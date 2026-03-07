Return-Path: <netdev+bounces-265054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC5SBdGdq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F4229F82
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9E130C691E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E453148A8;
	Sat,  7 Mar 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA1wFPM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6231352B
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854607; cv=none; b=oSTFj5x2zdxLxT+3YqbWdiNGDmJawEaSr4K/0hMseFuURcearQH5Z57HEW1r4SQla+9wG6vXOy2GeJF7d9vmolKQhgKWEM1sej7OJKRMh9RcNoJMWOow8pefm3kGXnX8GVeepFYlkLOo0Rc4+VaHRDGA+DRIHSOEjekiwP1HB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854607; c=relaxed/simple;
	bh=nGi9C6cp878Z66+LkBvBTmVgEcrv9UtNuGowYxYWAn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyJRaoMJpXw8dp4CRQzRJy+Qgd7uClSAFRZwgXooIf5YZn43zevGmv36a+lhHnJ1Ov5MefhguuQeh5Q2d+OuUdcj17iqjI0yIC4dmm5SXf7ZraTd3kOCV9NI+a1CSbuGOK2IF+xB0x35fkXC7EuKFKylOy0dlutivrqfbNkVUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA1wFPM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DABFC2BC9E;
	Sat,  7 Mar 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854607;
	bh=nGi9C6cp878Z66+LkBvBTmVgEcrv9UtNuGowYxYWAn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA1wFPM4dRflNCEVGBO7idIpbNCczVCr0GsQjIl2hYyxOrr8wMaFVHDpUbV5I76+r
	 BIcDK4fsHR+KaCvTNXI40kHtVVf4PGlsKbMh8H4xKSHuEwKfaHaKL8qnKF/1H8knU/
	 tmxfCIDUNzg7LbOHt7ocM7TILepljKWpr31yiRXfXetZypNPQPXE56SHuq9kCAWmeO
	 2r9vW6S6yIdDlQaR5/8oWa6iNjfCMTrjugT1c+09Wpn6QlGmglAVOtzcEwzGPQmKZ8
	 dZOkkoCkNF2uUtvA1DyI+8t5Je+89MdT0HYW5F0FR3qa5a0HowLS0poAjAGr7qqb9Q
	 9uktY7BmhAzWw==
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
Subject: [PATCH net-next v2 07/10] tools: ynl: convert devlink sample to selftest
Date: Fri,  6 Mar 2026 19:36:27 -0800
Message-ID: <20260307033630.1396085-8-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 880F4229F82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265054-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devlink.info:url,devlink.sh:url]
X-Rspamd-Action: no action

Convert devlink.c to use kselftest_harness.h with FIXTURE/TEST_F.
Move devlink from BINS to TEST_GEN_FILES in the Makefile since
it's invoked via the devlink.sh wrapper which sets up netdevsim.

Output:

  TAP version 13
  1..2
  # Starting 2 tests from 1 test cases.
  #  RUN           devlink.dump ...
  # netdevsim/netdevsim1337
  #            OK  devlink.dump
  ok 1 devlink.dump
  #  RUN           devlink.info ...
  # netdevsim/netdevsim1337:
  #   driver: netdevsim
  #   running fw:
  #     fw.mgmt: 10.20.30
  #            OK  devlink.info
  ok 2 devlink.info
  # PASSED: 2 / 2 tests passed.
  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile   |  16 ++++--
 tools/net/ynl/tests/devlink.c  | 100 +++++++++++++++++++++++----------
 tools/net/ynl/tests/devlink.sh |   5 ++
 3 files changed, 85 insertions(+), 36 deletions(-)
 create mode 100755 tools/net/ynl/tests/devlink.sh

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index a329de031add..14d399a70f10 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -14,6 +14,7 @@ endif
 LDLIBS=../lib/ynl.a ../generated/protos.a
 
 TEST_PROGS := \
+	devlink.sh \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
@@ -25,8 +26,11 @@ TEST_GEN_PROGS := \
 	tc \
 # end of TEST_GEN_PROGS
 
-BINS := \
+TEST_GEN_FILES := \
 	devlink \
+# end of TEST_GEN_FILES
+
+BINS := \
 	ethtool \
 	rt-addr \
 	rt-route \
@@ -41,7 +45,7 @@ include $(wildcard *.d)
 
 INSTALL_PATH ?= $(DESTDIR)/usr/share/kselftest
 
-all: $(TEST_GEN_PROGS) $(BINS)
+all: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
 
 ../lib/ynl.a:
 	@$(MAKE) -C ../lib
@@ -49,7 +53,7 @@ all: $(TEST_GEN_PROGS) $(BINS)
  ../generated/protos.a:
 	@$(MAKE) -C ../generated
 
-$(TEST_GEN_PROGS) $(BINS): %: %.c ../lib/ynl.a ../generated/protos.a
+$(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS): %: %.c ../lib/ynl.a ../generated/protos.a
 	@echo -e '\tCC test $@'
 	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
 	@$(LINK.c) $@.o -o $@  $(LDLIBS)
@@ -59,7 +63,7 @@ $(TEST_GEN_PROGS) $(BINS): %: %.c ../lib/ynl.a ../generated/protos.a
 		./$$test; \
 	done
 
-install: $(TEST_GEN_PROGS) $(BINS)
+install: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
 	@mkdir -p $(INSTALL_PATH)/ynl
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(INSTALL_PATH)/
 	@for test in $(TEST_PROGS); do \
@@ -73,7 +77,7 @@ install: $(TEST_GEN_PROGS) $(BINS)
 	@for file in $(TEST_FILES); do \
 		cp $$file $(INSTALL_PATH)/ynl/$$file; \
 	done
-	@for bin in $(TEST_GEN_PROGS) $(BINS); do \
+	@for bin in $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS); do \
 		cp $$bin $(INSTALL_PATH)/ynl/$$bin; \
 	done
 	@for test in $(TEST_PROGS) $(TEST_GEN_PROGS); do \
@@ -84,7 +88,7 @@ install: $(TEST_GEN_PROGS) $(BINS)
 	rm -f *.o *.d *~
 
 distclean: clean
-	rm -f $(TEST_GEN_PROGS) $(BINS)
+	rm -f $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
 
 .PHONY: all install clean distclean run_tests
 .DEFAULT_GOAL=all
diff --git a/tools/net/ynl/tests/devlink.c b/tools/net/ynl/tests/devlink.c
index ac9dfb01f280..2e668bb15af1 100644
--- a/tools/net/ynl/tests/devlink.c
+++ b/tools/net/ynl/tests/devlink.c
@@ -4,58 +4,98 @@
 
 #include <ynl.h>
 
+#include <kselftest_harness.h>
+
 #include "devlink-user.h"
 
-int main(int argc, char **argv)
+FIXTURE(devlink)
+{
+	struct ynl_sock *ys;
+};
+
+FIXTURE_SETUP(devlink)
+{
+	self->ys = ynl_sock_create(&ynl_devlink_family, NULL);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create devlink socket");
+}
+
+FIXTURE_TEARDOWN(devlink)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(devlink, dump)
 {
 	struct devlink_get_list *devs;
-	struct ynl_sock *ys;
 
-	ys = ynl_sock_create(&ynl_devlink_family, NULL);
-	if (!ys)
-		return 1;
+	devs = devlink_get_dump(self->ys);
+	ASSERT_NE(NULL, devs) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
 
-	devs = devlink_get_dump(ys);
-	if (!devs)
-		goto err_close;
+	if (ynl_dump_empty(devs)) {
+		devlink_get_list_free(devs);
+		SKIP(return, "no entries in dump");
+	}
+
+	ynl_dump_foreach(devs, d) {
+		EXPECT_TRUE((bool)d->_len.bus_name);
+		EXPECT_TRUE((bool)d->_len.dev_name);
+		ksft_print_msg("%s/%s\n", d->bus_name, d->dev_name);
+	}
+
+	devlink_get_list_free(devs);
+}
+
+TEST_F(devlink, info)
+{
+	struct devlink_get_list *devs;
+
+	devs = devlink_get_dump(self->ys);
+	ASSERT_NE(NULL, devs) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+
+	if (ynl_dump_empty(devs)) {
+		devlink_get_list_free(devs);
+		SKIP(return, "no devices to query");
+	}
 
 	ynl_dump_foreach(devs, d) {
 		struct devlink_info_get_req *info_req;
 		struct devlink_info_get_rsp *info_rsp;
-		unsigned i;
+		unsigned int i;
 
-		printf("%s/%s:\n", d->bus_name, d->dev_name);
+		EXPECT_TRUE((bool)d->_len.bus_name);
+		EXPECT_TRUE((bool)d->_len.dev_name);
+		ksft_print_msg("%s/%s:\n", d->bus_name, d->dev_name);
 
 		info_req = devlink_info_get_req_alloc();
+		ASSERT_NE(NULL, info_req);
 		devlink_info_get_req_set_bus_name(info_req, d->bus_name);
 		devlink_info_get_req_set_dev_name(info_req, d->dev_name);
 
-		info_rsp = devlink_info_get(ys, info_req);
+		info_rsp = devlink_info_get(self->ys, info_req);
 		devlink_info_get_req_free(info_req);
-		if (!info_rsp)
-			goto err_free_devs;
+		ASSERT_NE(NULL, info_rsp) {
+			devlink_get_list_free(devs);
+			TH_LOG("info_get failed: %s", self->ys->err.msg);
+		}
 
+		EXPECT_TRUE((bool)info_rsp->_len.info_driver_name);
 		if (info_rsp->_len.info_driver_name)
-			printf("    driver: %s\n", info_rsp->info_driver_name);
+			ksft_print_msg("  driver: %s\n",
+				       info_rsp->info_driver_name);
 		if (info_rsp->_count.info_version_running)
-			printf("    running fw:\n");
+			ksft_print_msg("  running fw:\n");
 		for (i = 0; i < info_rsp->_count.info_version_running; i++)
-			printf("        %s: %s\n",
-			       info_rsp->info_version_running[i].info_version_name,
-			       info_rsp->info_version_running[i].info_version_value);
-		printf("    ...\n");
+			ksft_print_msg("    %s: %s\n",
+				       info_rsp->info_version_running[i].info_version_name,
+				       info_rsp->info_version_running[i].info_version_value);
 		devlink_info_get_rsp_free(info_rsp);
 	}
 	devlink_get_list_free(devs);
-
-	ynl_sock_destroy(ys);
-
-	return 0;
-
-err_free_devs:
-	devlink_get_list_free(devs);
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-	ynl_sock_destroy(ys);
-	return 2;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/devlink.sh b/tools/net/ynl/tests/devlink.sh
new file mode 100755
index 000000000000..a684c749aa5e
--- /dev/null
+++ b/tools/net/ynl/tests/devlink.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
+nsim_setup
+"$(dirname "$(realpath "$0")")/devlink"
-- 
2.53.0


