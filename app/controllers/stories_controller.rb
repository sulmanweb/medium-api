class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_story, only: [:show, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all

    render json: @stories
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    render json: @story
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id

    if @story.save
      render json: @story, status: :created, location: @story
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    authorize @story

    if @story.update(story_params)
      head :no_content
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    authorize @story
    @story.destroy

    head :no_content
  end

  private

    def set_story
      @story = Story.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:title, :content)
    end
end
