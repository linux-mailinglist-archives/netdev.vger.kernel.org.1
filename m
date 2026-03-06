Return-Path: <netdev+bounces-264616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBLsLbY3qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:11:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F621A7E3
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED4630810AD
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58233B95E;
	Fri,  6 Mar 2026 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9hLWxi+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50833B6ED
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762965; cv=none; b=R1nn8W6jHf5sKZICnQu6N5gNlGgmv2ouS7aPYs1HEHLfLzbjjh9mFNq7wBATYzqLiJOtQ2ZgJ8Fk+Ww4tedFvUUAmHG3bLiI3zT3/hCRgiCQyyH+O43oaA6u6cs3fVnvU5Kymj8HdJTh51OumfRVaRCV5R2TGOVvp6SCKQO4w04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762965; c=relaxed/simple;
	bh=jmC8qctquCHnImAh3J58Q3UjDHo3838l5ROMGNHHlaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgArrApl+txdCTBpV+spc+6E9ZFRzKeDRv4ChWAqWX26ak9bZMcmFMwJUkFBdYKgyHNcx46R//OURYevmcFQ499q12MupzInqNnP0Y2/5YCi4xWLVHRkMRud86jl3QsRx3S8QZDCWcJcyh4XKnJx+86YAXHO2GaG0GKlx4GCR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9hLWxi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF9FC116C6;
	Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762965;
	bh=jmC8qctquCHnImAh3J58Q3UjDHo3838l5ROMGNHHlaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9hLWxi+c07AFsGo32oZy3qPGQ+FablgRpnrQFf1RTRwlgV52l2sbh0MxEE2zQghL
	 2KAPLygS9YxN36enKa97e5o9XsOkcNQo+3EXPxj7J+qDxwEZMKW4VgBCGWfbujWIxG
	 oTlmf05WztV416iC4J98rbiHsIWRJELeDfsgBpUiiJYTqpfXlONlP7thAg74tNA7mJ
	 5NlIx9jh4RY7HSDeY84ZbX7oOUe8ZMMELSGkKV3PMrdNtlia2D/R+E4F8OIKJP5D7H
	 rvPaixHi+IUOO5bcWJkCAUsf7cVttxSjd97T0fAN73CL+SdDS6mKDfVWkcbOeHGWg1
	 26F+RuMXf47dA==
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
Subject: [PATCH net-next 07/10] tools: ynl: convert devlink sample to selftest
Date: Thu,  5 Mar 2026 18:08:58 -0800
Message-ID: <20260306020901.524105-8-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306020901.524105-1-kuba@kernel.org>
References: <20260306020901.524105-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 189F621A7E3
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
	TAGGED_FROM(0.00)[bounces-264616-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devlink.sh:url]
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
 tools/net/ynl/tests/Makefile   | 16 +++---
 tools/net/ynl/tests/devlink.c  | 99 +++++++++++++++++++++++-----------
 tools/net/ynl/tests/devlink.sh |  5 ++
 3 files changed, 84 insertions(+), 36 deletions(-)
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
index ac9dfb01f280..c666261f0f24 100644
--- a/tools/net/ynl/tests/devlink.c
+++ b/tools/net/ynl/tests/devlink.c
@@ -4,58 +4,97 @@
 
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
index 000000000000..55da00c985f4
--- /dev/null
+++ b/tools/net/ynl/tests/devlink.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
+nsim_setup
+exec "$(dirname "$(realpath "$0")")/devlink"
-- 
2.53.0


