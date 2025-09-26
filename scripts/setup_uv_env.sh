#!/usr/bin/env bash
set -euo pipefail

# Create and populate a uv-managed virtual environment for LIMAP.
# This script mirrors the steps in the README installation section using uv.

if ! command -v uv >/dev/null 2>&1; then
  echo "Error: uv is not installed. Please install uv first: https://docs.astral.sh/uv/" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="${UV_VENV_PATH:-${ROOT_DIR}/.venv}"

# Instruct uv to provision and populate the chosen environment path.
export UV_PROJECT_ENVIRONMENT="${VENV_DIR}"

pushd "${ROOT_DIR}" >/dev/null
uv sync
popd >/dev/null

PYTHON_BIN="${VENV_DIR}/bin/python"

cat <<MSG
uv environment created at: ${VENV_DIR}
To activate it, run:
  source "${VENV_DIR}/bin/activate"

You can then verify the installation with:
  "${PYTHON_BIN}" -c "import limap; print(limap.__version__)"
MSG
