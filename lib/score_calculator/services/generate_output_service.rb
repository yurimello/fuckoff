# This service class recieves a calculated game
# generates outpu
# responds with output stream
class GenerateOutputService < BaseService
  def call(game)
    @response = "#{header}\n"
    game.children.each do |player|
      @response << "#{player.name}\n"
      output_frames(player.children)
    end
    self
  end

  private

  def header
    ['Frame'].concat((1..MAX_FRAMES).to_a).join("\t\t")
  end

  def output_frames(frames)
    output_rolls = ''
    output_frames = ''
    frames.each do |frame|
      frame.children.each do |roll|
        output_rolls << output_roll(roll, frame)
      end
      output_frames << "#{frame.score}\t\t"
    end

    @response << "Pinfalls\t#{output_rolls}\n"
    @response << "Score\t\t#{output_frames}\n"
  end

  def output_roll(roll, frame)
    output = "#{roll.name}\t"
    return output if frame.id == MAX_FRAMES

    output.gsub(/^x/i, "\tX")
  end
end
