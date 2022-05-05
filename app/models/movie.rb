# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  description :text
#  duration    :integer
#  image       :string
#  title       :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :integer
#
class Movie < ApplicationRecord
  def title_with_year
    result = self.title +"(" + self.year.to_s + ")"
  end 

  def director
    my_director_id = self.director_id
    matching_directors = Director.where({ :id => my_director_id})
    the_director = matching_directors.at(0)
    return the_director
  end  

  def cast
    # Stretch goal: return all the actors that played a role in a particular movie
    m_id = self.id
    all_actors_id = Character.where({:movie_id => m_id}).map_relation_to_array(:actor_id)
    actors = Array.new
    all_actors_id.each do |an_actor_id|
      an_actor = Actor.where({:id=>an_actor_id}).at(0)
      an_actor_name = an_actor.name
      actors.push(an_actor_name)
    end
    return actors
  end

end
