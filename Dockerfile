FROM fermipy/fermipy:latest
MAINTAINER stephan.zimmer <zimmer@slac.stanford.edu>

ARG PYTHON_VERSION=2.7
ARG CONDA_DEPS="numpy scipy matplotlib astropy healpy pyyaml emcee corner nose cython astropy fitsio"

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y python=$PYTHON_VERSION pip pytest && \
    conda install -y $CONDA_DEPS && \
    pip install vegas && \
    pip install ugali --no-deps --install-option="--isochrones"

## add dpshsim

RUN git clone https://github.com/kadrlica/dsphsim.git && \
    cd dsphsim && python setup.py install

CMD ["usleep 10 && /opt/conda/bin/jupyter notebook --notebook-dir=/workdir --ip='*' --port=8888 --no-browser --allow-root"]
ENTRYPOINT ["/bin/bash","--login","-c"]
