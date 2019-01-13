require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

# Put your record definitions here
class Track
	attr_accessor :tname, :location

	def initialize (tname, location)
		@tname = tname
		@location = location
	end
end

class Album
	attr_accessor :id, :title, :artist, :img, :tcount, :tracks

	def initialize (id, title, artist, img, tcount, tracks)
    @id = id
		@title = title
		@artist = artist
		@img = img
    @tcount = tcount
		@tracks = tracks
	end
end

WIN_WIDTH = 1000
WIN_HEIGHT = 600

class MusicPlayerMain < Gosu::Window

	def initialize
	    super WIN_WIDTH, WIN_HEIGHT
	    self.caption = "Music Player"

		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
		@albums = load_albums()
    @background = Gosu::Color::BLUE
		@album_img1 = Gosu::Image.new("A.png", :tileable => true)
		@album_img2 = Gosu::Image.new("B.png", :tileable => true)
		@album_img3 = Gosu::Image.new("C.png", :tileable => true)
		@album_img4 = Gosu::Image.new("D.png", :tileable => true)
    @info_font = Gosu::Font.new(30)
    @choice = -1
    @track_font = Gosu::Font.new(30)
    @playingsong = -1
	end

   def read_track music_file
	  track_name = music_file.gets().strip
    track_location = music_file.gets().strip
	  track = Track.new(track_name, track_location)
    track.tname = track_name
    track.location = track_location
    track
  end

  def read_tracks music_file,track_count
	  tracks = Array.new()
	  i = 0
    while (i < track_count.to_i)
    track = read_track(music_file)
    tracks << track
    i += 1
    end
    tracks
  end
  def read_album (i,music_file)
    primarykey = i + 1
    album_title = music_file.gets().strip
    album_artist = music_file.gets().strip
    album_img = music_file.gets().strip
    track_count = music_file.gets().strip
    tracks = read_tracks(music_file,track_count)
    album = Album.new(primarykey, album_title, album_artist, album_img, track_count, tracks)
    album
  end
  #read the data from file and insert to array
  def read_albums music_file
    albums = Array.new()
    count = music_file.gets()
	  i = 0
    while (i < count.to_i)
    album = read_album(i,music_file)
    albums << album
    i += 1
    end
    albums
  end
  #load the albums data from textfile
  def load_albums
  	music_file = File.new("album.txt","r")
    albums = read_albums(music_file)
    albums
  end



  def draw_albums

    @album_img1.draw(10,10,ZOrder::UI)
    @album_img2.draw(310,10,ZOrder::UI)
    @album_img3.draw(10,310,ZOrder::UI)
    @album_img4.draw(310,310,ZOrder::UI)

    if @choice > -1
      i = 0
      pY = 50
      while i < 15
      display_track(@albums[@choice].tracks[i].tname,pY)
      i += 1
      pY += 30
      end
    end
  end

  def area_clicked(leftX, topY, rightX, bottomY)
     # complete this code
    x1 = mouse_x
    y1 = mouse_y
    tx = leftX + rightX
    ty = topY + bottomY

    if (x1 >= leftX) and (x1 <= rightX) and (y1 >= topY) and (y1 <= ty)
       true
    else
      false
    end

  end

  def display_track(title, ypos)
  	@track_font.draw(title, 630, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def playTrack(track)

  			@song = Gosu::Song.new(@albums[@choice].tracks[track].location)
  			@song.play(false)

  end

# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
     Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, @background, ZOrder::BACKGROUND, mode=:default)
	end


	def update


	end

 # Draws the album images and the track list for the selected album

	def draw
		# Complete the missing code
		draw_background
		draw_albums
    if @playingsong > -1
    @info_font.draw("Now playing...#{@albums[@choice].tracks[@playingsong].tname}", 630, 550, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    end
    
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
	    when Gosu::MsLeft
	    	# What should happen here?
        #area of album 1
        if area_clicked(10,10,298,289)
           @choice = 0
           @background = Gosu::Color::YELLOW
        end
        #area of album 2
        if area_clicked(310,13,597,290)
           @choice = 1
           @background = Gosu::Color::RED
        end
        #area of album 3
        if area_clicked(10,310,300,589)
           @choice = 2
           @background = Gosu::Color::WHITE
        end
        #area of album 4
        if area_clicked(313,314,600,590)
           @choice = 3
           @background = Gosu::Color::GREEN
        end

        #track clicked area
      #track1
      if area_clicked(630,50,980,80)
          playTrack(0)
          @playingsong = 0
      end
      #track2
      if area_clicked(630,81,980,110)
          playTrack(1)
          @playingsong = 1
      end
      #track3
      if area_clicked(630,111,980,140)
          playTrack(2)
          @playingsong = 2
      end
      #track4
      if area_clicked(630,141,980,170)
          playTrack(3)
          @playingsong = 3
      end
      #track5
      if area_clicked(630,171,980,200)
          playTrack(4)
          @playingsong = 4
      end
      #track6
      if area_clicked(630,201,980,230)
          playTrack(5)
          @playingsong = 5
      end
      #track6
      if area_clicked(630,231,980,260)
          playTrack(6)
          @playingsong = 6
      end
      #track7
      if area_clicked(630,261,980,290)
          playTrack(7)
          @playingsong = 7
      end
      #track8
      if area_clicked(630,291,980,320)
          playTrack(8)
          @playingsong = 8
      end
      #track9
      if area_clicked(630,321,980,350)
          playTrack(9)
          @playingsong = 9
      end
      #track10
      if area_clicked(630,351,980,380)
          playTrack(10)
          @playingsong = 10
      end
      #track11
      if area_clicked(630,381,980,410)
          playTrack(11)
          @playingsong = 11
      end
      #track12
      if area_clicked(630,411,980,440)
          playTrack(12)
          @playingsong = 12
      end
      #track13
      if area_clicked(630,441,980,470)
          playTrack(13)
          @playingsong = 13
      end
      #track14
      if area_clicked(630,471,980,500)
          playTrack(14)
          @playingsong = 14
      end
      #track15
      if area_clicked(630,501,980,530)
          playTrack(15)
          @playingsong = 15
      end


      end
	  end
end
# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
