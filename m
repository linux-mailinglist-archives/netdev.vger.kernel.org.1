Return-Path: <netdev+bounces-265048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KvODF2dq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070A229F4F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8CA3051467
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF630C368;
	Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqJI2dEL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB962DD5F6
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854603; cv=none; b=qPgh8tGWfNV20G1Lp2jd1oI4QFZwcLKE+yPYsVk45qO4+A4HDQlnJCDezR4n39iGxsPSFXf/paVlOY2gYr53LYCDQYF5QJbOLDDkYbofxJaLSFIP5ZELb7zru53RnrcKpQGRdu5FllgnoCdSFQF2ZfMalFXkbVHOXZZvrtAPPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854603; c=relaxed/simple;
	bh=m/jWFiHcuyQD6TJx7+himMX/TO9v15HZ5CzwyeJF+pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS5bxV7+FXJ6fYtdQO6Hbg5etTRtlLzjC8STKlZUjhb3g3fwgsS+UkS9kiXIVnNZQ93GVNwjaFuA/ciFhrjN37plfihhkVjIsnvRAfyvmbQiG+eaIwbpnpkXol09H8BQ2ttruUYn3xz6zrmnpS10Dhj9uhVetAj0pa1E9T0bIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqJI2dEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2317DC2BCB0;
	Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854603;
	bh=m/jWFiHcuyQD6TJx7+himMX/TO9v15HZ5CzwyeJF+pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqJI2dELCKWVsMzspsgy/biBqnoQDsvbO4odoyMkzpJERGLbwdTaIVLUzUNO/TdZ/
	 EPdcC7y7AQLQic7GHN4X6qNBxTYvdiIbO6eU9hVnM/GnWnIBYaDGpjjbufz+i7OC3I
	 FkCysrtX4qMzRKaXRWCJZUAB4mISfHu+0gm6eWQcQLvIPl8V91+H5PoqzEfnlh3AVg
	 mf7BM6mhpSF7TjALoQCJp3YvvPFdWv2ytcS9GCkqLkZbo/NgfLUGiHjPxyEbzKLaxK
	 jLYJfD6H/S61NLJzrqHtNDV9UmLfoGFISwgM6eGUNkb7kn1g+zwOcBHKXD4hIGKqM1
	 d9PoL+jhFLm9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/10] tools: ynl: move samples to tests
Date: Fri,  6 Mar 2026 19:36:21 -0800
Message-ID: <20260307033630.1396085-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307033630.1396085-1-kuba@kernel.org>
References: <20260307033630.1396085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8070A229F4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265048-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The "samples" were always poor man's tests (used to manually
confirm that C YNL works).

Move all C sample programs from tools/net/ynl/samples/ to
tools/net/ynl/tests/, "merge" the Makefiles. The subsequent
changes will convert each sample into a proper KTAP selftests.

Since these are now tests rather than samples - default to
enabling asan. After all we're testing user space code here.

Sort the gitignore while at it, the page-pool entry was a leftover
so delete it.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile                        |  4 +-
 tools/net/ynl/samples/Makefile                | 36 --------------
 tools/net/ynl/tests/Makefile                  | 47 +++++++++++++++++--
 tools/net/ynl/{samples => tests}/devlink.c    |  0
 tools/net/ynl/{samples => tests}/ethtool.c    |  0
 tools/net/ynl/{samples => tests}/netdev.c     |  0
 tools/net/ynl/{samples => tests}/ovs.c        |  0
 tools/net/ynl/{samples => tests}/rt-addr.c    |  0
 tools/net/ynl/{samples => tests}/rt-link.c    |  0
 tools/net/ynl/{samples => tests}/rt-route.c   |  0
 .../ynl/{samples => tests}/tc-filter-add.c    |  0
 tools/net/ynl/{samples => tests}/tc.c         |  0
 tools/net/ynl/{samples => tests}/.gitignore   |  3 +-
 13 files changed, 45 insertions(+), 45 deletions(-)
 delete mode 100644 tools/net/ynl/samples/Makefile
 rename tools/net/ynl/{samples => tests}/devlink.c (100%)
 rename tools/net/ynl/{samples => tests}/ethtool.c (100%)
 rename tools/net/ynl/{samples => tests}/netdev.c (100%)
 rename tools/net/ynl/{samples => tests}/ovs.c (100%)
 rename tools/net/ynl/{samples => tests}/rt-addr.c (100%)
 rename tools/net/ynl/{samples => tests}/rt-link.c (100%)
 rename tools/net/ynl/{samples => tests}/rt-route.c (100%)
 rename tools/net/ynl/{samples => tests}/tc-filter-add.c (100%)
 rename tools/net/ynl/{samples => tests}/tc.c (100%)
 rename tools/net/ynl/{samples => tests}/.gitignore (87%)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 9b692f368be7..d514a48dae27 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -14,12 +14,12 @@ includedir ?= $(prefix)/include
 
 SPECDIR=../../../Documentation/netlink/specs
 
-SUBDIRS = lib generated samples ynltool tests
+SUBDIRS = lib generated ynltool tests
 
 all: $(SUBDIRS) libynl.a
 
+tests: | lib generated libynl.a
 ynltool: | lib generated libynl.a
-samples: | lib generated
 libynl.a: | lib generated
 	@echo -e "\tAR $@"
 	@ar rcs $@ lib/ynl.o generated/*-user.o
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
deleted file mode 100644
index d76cbd41cbb1..000000000000
--- a/tools/net/ynl/samples/Makefile
+++ /dev/null
@@ -1,36 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-include ../Makefile.deps
-
-CC=gcc
-CFLAGS += -std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
-	-I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
-ifeq ("$(DEBUG)","1")
-  CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
-endif
-
-LDLIBS=../lib/ynl.a ../generated/protos.a
-
-SRCS=$(wildcard *.c)
-BINS=$(patsubst %.c,%,${SRCS})
-
-include $(wildcard *.d)
-
-all: $(BINS)
-
-CFLAGS_page-pool=$(CFLAGS_netdev)
-CFLAGS_tc-filter-add:=$(CFLAGS_tc)
-
-$(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
-	@echo -e '\tCC sample $@'
-	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
-	@$(LINK.c) $@.o -o $@  $(LDLIBS)
-
-clean:
-	rm -f *.o *.d *~
-
-distclean: clean
-	rm -f $(BINS)
-
-.PHONY: all clean distclean
-.DEFAULT_GOAL=all
diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index eb166c9550db..5fa36c877235 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -1,21 +1,51 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for YNL tests
 
+include ../Makefile.deps
+
+CC=gcc
+CFLAGS += -std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
+	-I../lib/ -I../generated/ -I../../../testing/selftests/ \
+	-idirafter $(UAPI_PATH)
+ifneq ("$(NDEBUG)","1")
+  CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
+endif
+
+LDLIBS=../lib/ynl.a ../generated/protos.a
+
 TEST_PROGS := \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
 
+SRCS=$(wildcard *.c)
+BINS=$(patsubst %.c,%,${SRCS})
+
+CFLAGS_tc-filter-add:=$(CFLAGS_tc)
+
+include $(wildcard *.d)
+
 INSTALL_PATH ?= $(DESTDIR)/usr/share/kselftest
 
-all: $(TEST_PROGS)
+all: $(BINS) $(TEST_PROGS)
+
+../lib/ynl.a:
+	@$(MAKE) -C ../lib
+
+ ../generated/protos.a:
+	@$(MAKE) -C ../generated
+
+$(BINS): ../lib/ynl.a ../generated/protos.a
+	@echo -e '\tCC test $@'
+	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
+	@$(LINK.c) $@.o -o $@  $(LDLIBS)
 
 run_tests:
 	@for test in $(TEST_PROGS); do \
 		./$$test; \
 	done
 
-install: $(TEST_PROGS)
+install: $(TEST_PROGS) $(BINS)
 	@mkdir -p $(INSTALL_PATH)/ynl
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(INSTALL_PATH)/
 	@for test in $(TEST_PROGS); do \
@@ -26,11 +56,18 @@ install: $(TEST_PROGS)
 		    $$test > $(INSTALL_PATH)/ynl/$$name; \
 		chmod +x $(INSTALL_PATH)/ynl/$$name; \
 	done
+	@for bin in $(BINS); do \
+		cp $$bin $(INSTALL_PATH)/ynl/$$bin; \
+	done
 	@for test in $(TEST_PROGS); do \
 		echo "ynl:$$test"; \
 	done > $(INSTALL_PATH)/kselftest-list.txt
 
-clean distclean:
-	@# Nothing to clean
+clean:
+	rm -f *.o *.d *~
 
-.PHONY: all install clean run_tests
+distclean: clean
+	rm -f $(BINS)
+
+.PHONY: all install clean distclean run_tests
+.DEFAULT_GOAL=all
diff --git a/tools/net/ynl/samples/devlink.c b/tools/net/ynl/tests/devlink.c
similarity index 100%
rename from tools/net/ynl/samples/devlink.c
rename to tools/net/ynl/tests/devlink.c
diff --git a/tools/net/ynl/samples/ethtool.c b/tools/net/ynl/tests/ethtool.c
similarity index 100%
rename from tools/net/ynl/samples/ethtool.c
rename to tools/net/ynl/tests/ethtool.c
diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/tests/netdev.c
similarity index 100%
rename from tools/net/ynl/samples/netdev.c
rename to tools/net/ynl/tests/netdev.c
diff --git a/tools/net/ynl/samples/ovs.c b/tools/net/ynl/tests/ovs.c
similarity index 100%
rename from tools/net/ynl/samples/ovs.c
rename to tools/net/ynl/tests/ovs.c
diff --git a/tools/net/ynl/samples/rt-addr.c b/tools/net/ynl/tests/rt-addr.c
similarity index 100%
rename from tools/net/ynl/samples/rt-addr.c
rename to tools/net/ynl/tests/rt-addr.c
diff --git a/tools/net/ynl/samples/rt-link.c b/tools/net/ynl/tests/rt-link.c
similarity index 100%
rename from tools/net/ynl/samples/rt-link.c
rename to tools/net/ynl/tests/rt-link.c
diff --git a/tools/net/ynl/samples/rt-route.c b/tools/net/ynl/tests/rt-route.c
similarity index 100%
rename from tools/net/ynl/samples/rt-route.c
rename to tools/net/ynl/tests/rt-route.c
diff --git a/tools/net/ynl/samples/tc-filter-add.c b/tools/net/ynl/tests/tc-filter-add.c
similarity index 100%
rename from tools/net/ynl/samples/tc-filter-add.c
rename to tools/net/ynl/tests/tc-filter-add.c
diff --git a/tools/net/ynl/samples/tc.c b/tools/net/ynl/tests/tc.c
similarity index 100%
rename from tools/net/ynl/samples/tc.c
rename to tools/net/ynl/tests/tc.c
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/tests/.gitignore
similarity index 87%
rename from tools/net/ynl/samples/.gitignore
rename to tools/net/ynl/tests/.gitignore
index 05087ee323ba..045385df42a4 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/tests/.gitignore
@@ -1,8 +1,7 @@
-ethtool
 devlink
+ethtool
 netdev
 ovs
-page-pool
 rt-addr
 rt-link
 rt-route
-- 
2.53.0


