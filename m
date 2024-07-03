Return-Path: <netdev+bounces-108869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70DE926199
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656A71F2143A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30817A596;
	Wed,  3 Jul 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIhFmnz+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11617838B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012580; cv=none; b=HYZg4cHws7VMQqEr7lcOQ6cwM7WAVq8NLyMPaxJ9BWJSiHUykEGbDpCsCx737IW1lAdjPrMX/9SVlfAeLC31br4cclm3Q+oi8XbDH2n9/GoCOP3fV66lcjucVt1aaeyzOrPLP9KO8c8fSCjUky1j1D3Tijg3rBcsVjbuZpx01jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012580; c=relaxed/simple;
	bh=gVSHs/txastxc+p5HWuJAzqBslA+1scIlNsHFQvuKiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7PzlK7vqymIua4DnLAzWZV9GghtHAGTFG6KxMfOdGBa+o1ffEeAGda/kyp0W/OmjxXKhCXybXFnJEN4/HV5FUy3yyTo7xcxnaCDDUHkGzO+8f8QD+8OJqfCGbfEtl9HA/TZ/EL+kO/h39+YM3b/gEH/gsOI5/0ZJx5fonmmAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIhFmnz+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012580; x=1751548580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVSHs/txastxc+p5HWuJAzqBslA+1scIlNsHFQvuKiE=;
  b=nIhFmnz+pjGsb1/XNAl2h6vTBVI5wVe7Y73RX9ZRAXEVUvxm69MfilE8
   mOvHSholgDXG08Z8PiHSjLiFzSoCviOUyXFYgSMPQGbtkcOLGjYb2VUim
   6e1inBcbSNU4k5mSqYlh+Bi43fd2O/G66vcO90kxHIHHEpOn4Zpsu/Xty
   tHzMjpOWu4HomMSyQ2hyeiXkHeItvp00i8z+ojazBFKBzW3BQW2gTDmhA
   FSA/fBNHAH1qvYnpeoksJo5450h6tt0YP0DzdfQbCPsVKp7sqBDOZWQuN
   9KQoC5t8pigwXKWd00XmIFslFG2lEbjp61xW/usWN2xNLTiKi0LlANial
   w==;
X-CSE-ConnectionGUID: LkQZ6kYEQwmNn1Nb/6T/GA==
X-CSE-MsgGUID: m/sWPxmFThulTnRw9QMgpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17195094"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17195094"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:16:16 -0700
X-CSE-ConnectionGUID: dX6Oh2bYQSu98xO7BTM+Sg==
X-CSE-MsgGUID: fsCBoCPZSjWD+BQoDhiZAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="83805888"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2024 06:16:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E39E32877D;
	Wed,  3 Jul 2024 14:16:11 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iproute2-next 3/3] Makefile: support building from subdirectories
Date: Wed,  3 Jul 2024 15:15:21 +0200
Message-Id: <20240703131521.60284-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support building also from subdirectories, like: `make -C devlink` or
`cd devlink; make`.

Extract common defines and include flags to a new file (common.mk) which
will be included from subdir makefiles via the generated config.mk file.

Note that the current, toplevel-issued, `make` still works as before.
Note that `./configure && make` is still required once after the fresh
checkout.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 Makefile  | 45 ---------------------------------------------
 common.mk | 43 +++++++++++++++++++++++++++++++++++++++++++
 configure |  3 +++
 3 files changed, 46 insertions(+), 45 deletions(-)
 create mode 100644 common.mk

diff --git a/Makefile b/Makefile
index 2b2c3dec927e..1915b8191d3e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Top level Makefile for iproute2
 
--include config.mk
-
 ifeq ("$(origin V)", "command line")
 VERBOSE = $(V)
 endif
@@ -14,37 +12,6 @@ ifeq ($(VERBOSE),0)
 MAKEFLAGS += --no-print-directory
 endif
 
-PREFIX?=/usr
-SBINDIR?=/sbin
-NETNS_RUN_DIR?=/var/run/netns
-NETNS_ETC_DIR?=/etc/netns
-DATADIR?=$(PREFIX)/share
-HDRDIR?=$(PREFIX)/include/iproute2
-CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(DATADIR)/iproute2
-DOCDIR?=$(DATADIR)/doc/iproute2
-MANDIR?=$(DATADIR)/man
-ARPDDIR?=/var/lib/arpd
-KERNEL_INCLUDE?=/usr/include
-BASH_COMPDIR?=$(DATADIR)/bash-completion/completions
-
-# Path to db_185.h include
-DBM_INCLUDE:=$(DESTDIR)/usr/include
-
-SHARED_LIBS = y
-
-DEFINES= -DRESOLVE_HOSTNAMES -DLIBDIR=\"$(LIBDIR)\"
-ifneq ($(SHARED_LIBS),y)
-DEFINES+= -DNO_SHARED_LIBS
-endif
-
-DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
-         -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
-         -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
-         -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
-         -DARPDDIR=\"$(ARPDDIR)\" \
-         -DCONF_COLOR=$(CONF_COLOR)
-
 #options for AX.25
 ADDLIB+=ax25_ntop.o
 
@@ -59,24 +26,12 @@ ADDLIB+=netrom_ntop.o
 
 CC := gcc
 HOSTCC ?= $(CC)
-DEFINES += -D_GNU_SOURCE
-# Turn on transparent support for LFS
-DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-CCOPTS = -O2 -pipe
-WFLAGS := -Wall -Wstrict-prototypes  -Wmissing-prototypes
-WFLAGS += -Wmissing-declarations -Wold-style-definition -Wformat=2
-
-CFLAGS := $(WFLAGS) $(CCOPTS) -I../include -I../include/uapi $(DEFINES) $(CFLAGS)
-YACCFLAGS = -d -t -v
 
 SUBDIRS=lib ip tc bridge misc netem genl man
 ifeq ($(HAVE_MNL),y)
 SUBDIRS += tipc devlink rdma dcb vdpa
 endif
 
-LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
-LDLIBS += $(LIBNETLINK)
-
 all: config.mk
 	@set -e; \
 	for i in $(SUBDIRS); \
diff --git a/common.mk b/common.mk
new file mode 100644
index 000000000000..de26322322d6
--- /dev/null
+++ b/common.mk
@@ -0,0 +1,43 @@
+PREFIX?=/usr
+SBINDIR?=/sbin
+NETNS_RUN_DIR?=/var/run/netns
+NETNS_ETC_DIR?=/etc/netns
+DATADIR?=$(PREFIX)/share
+HDRDIR?=$(PREFIX)/include/iproute2
+CONF_ETC_DIR?=/etc/iproute2
+CONF_USR_DIR?=$(DATADIR)/iproute2
+DOCDIR?=$(DATADIR)/doc/iproute2
+MANDIR?=$(DATADIR)/man
+ARPDDIR?=/var/lib/arpd
+KERNEL_INCLUDE?=/usr/include
+BASH_COMPDIR?=$(DATADIR)/bash-completion/completions
+
+# Path to db_185.h include
+DBM_INCLUDE:=$(DESTDIR)/usr/include
+
+SHARED_LIBS = y
+
+DEFINES= -DRESOLVE_HOSTNAMES -DLIBDIR=\"$(LIBDIR)\"
+ifneq ($(SHARED_LIBS),y)
+DEFINES+= -DNO_SHARED_LIBS
+endif
+
+DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
+         -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
+         -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
+         -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
+         -DARPDDIR=\"$(ARPDDIR)\" \
+         -DCONF_COLOR=$(CONF_COLOR)
+
+DEFINES += -D_GNU_SOURCE
+# Turn on transparent support for LFS
+DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
+CCOPTS = -O2 -pipe
+WFLAGS := -Wall -Wstrict-prototypes  -Wmissing-prototypes
+WFLAGS += -Wmissing-declarations -Wold-style-definition -Wformat=2
+
+CFLAGS := $(WFLAGS) $(CCOPTS) -I../include -I../include/uapi $(DEFINES) $(CFLAGS)
+YACCFLAGS = -d -t -v
+
+LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
+LDLIBS += $(LIBNETLINK)
diff --git a/configure b/configure
index 928048b3d8c0..978f787ce4d3 100755
--- a/configure
+++ b/configure
@@ -615,6 +615,9 @@ check_cap
 echo -n "color output: "
 check_color
 
+# must be after check_color
+echo "include ../common.mk" >> $CONFIG
+
 echo >> $CONFIG
 echo "%.o: %.c" >> $CONFIG
 echo '	$(QUIET_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<' >> $CONFIG
-- 
2.39.3


