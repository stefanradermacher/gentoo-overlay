# Copyright 2026 Stefan Radermacher
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Plugin lives in <libdir>/qt6/plugins/okular_generators and links against
# okularcore, so it must be rebuilt after every Okular update (Okular has no
# subslot, hence no := dependency is possible).
KFMIN=6.27.0
QTMIN=6.11.2
inherit ecm

DESCRIPTION="MuPDF based PDF backend (generator plugin) for Okular"
HOMEPAGE="https://github.com/stefanradermacher/okular-mupdf"
SRC_URI="https://github.com/stefanradermacher/okular-mupdf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets,xml]
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-apps/okular-26.08.0:6
	app-text/mupdf:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_postinst() {
	elog "The MuPDF backend has priority 3 and is therefore preferred over"
	elog "Poppler (priority 1) for PDF files. Restart Okular to use it."
	elog "To pick the backend per file enable \"Ask for the backend when opening"
	elog "files\" in the Okular general settings."
}
