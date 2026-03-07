Return-Path: <netdev+bounces-265057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEP5NGqdq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6A229F56
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43AAE301C686
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AD314A95;
	Sat,  7 Mar 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POmeueR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D2311C2A
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854609; cv=none; b=V8ABNRAS1IyWgTmPVwiQGx8zEN2/WQ8Ijgzg8E2tz0nZClyQU8kqBsGwQ09xXEioMgexFPxaeEpciI9GMx+cOnxr1BY9IT/LZiRH1C7syAOsqwD8VUoZv2zQiETQPBhxZFuk1vufJh499VZ3A9H9XCFBV42QfnvXPnQjhfukMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854609; c=relaxed/simple;
	bh=qushIPcyHX0LtUDQIyn8N92S+zuR2K58L25cXcul5Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsdWnWjU+vFFY//EZU1jUGAUH3sHdTvLTRhGw0IRA3oX2tYIIWlyE/6zqNMCHNJn4WYZtr9AwPKDr8cLAApF4FUBVGTNeSTuC2HkGX8NWl69azbUS7KO2qa5LzvaC8CxpWIL1mu4SI1IMOQTT1DMVY4x3gAthie0JH2BuPytqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POmeueR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F08C2BC9E;
	Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854609;
	bh=qushIPcyHX0LtUDQIyn8N92S+zuR2K58L25cXcul5Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POmeueR4DQCK1xtiAb/pj0lUQxVvsq7rG9Llvnc3a9xtSRXDJ6W5WmS7yJZ88lE1k
	 /0CYwNzn/lRo/G+PvJBpBZCiiJFQWXC7vdvP/Nakl5STbDpTNsXpn17GQEcd0w363b
	 mctlSXwJ5BSAu8At18ZoLoa/SnAFCgDApsam2UZUG+7kUiUAmfEXqiL53iakzSv21R
	 HHv6o6mx/WUhqqlyTuUKQa6MTEEH+K4NqSkPdy6AfIkQpTKqmU9Pr2XrqcKAHyS2qA
	 yOuaVIcCel+4f4n13OoD3s4GLiFv1B4ASWjsHOH6otPd41Ge97l30hZKREwfIExb2h
	 ngyAgst8UlA5A==
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
Subject: [PATCH net-next v2 10/10] tools: ynl: convert rt-route sample to selftest
Date: Fri,  6 Mar 2026 19:36:30 -0800
Message-ID: <20260307033630.1396085-11-kuba@kernel.org>
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
X-Rspamd-Queue-Id: DDF6A229F56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265057-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ynl_nsim_lib.sh:url,rt-route.sh:url]
X-Rspamd-Action: no action

Convert rt-route.c to use kselftest_harness.h with FIXTURE/TEST_F.
This is the last test to convert so clean up the Makefile.

Validate that the connected routes for 192.168.1.0/24 and
2001:db8::/64 appear in the dump.

Output:

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           rt_route.dump ...
  # oif: nsim0            dst: 192.168.1.0/24
  # oif: lo               dst: ::1/128
  # oif: nsim0            dst: 2001:db8::1/128
  # oif: nsim0            dst: 2001:db8::/64
  # oif: nsim0            dst: fe80::/64
  # oif: nsim0            dst: ff00::/8
  #            OK  rt_route.dump
  ok 1 rt_route.dump
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile    | 16 +++---
 tools/net/ynl/tests/rt-route.c  | 87 +++++++++++++++++++++++----------
 tools/net/ynl/tests/rt-route.sh |  5 ++
 3 files changed, 72 insertions(+), 36 deletions(-)
 create mode 100755 tools/net/ynl/tests/rt-route.sh

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 52b54ea6c90f..2a02958c7039 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	devlink.sh \
 	ethtool.sh \
 	rt-addr.sh \
+	rt-route.sh \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
@@ -32,11 +33,8 @@ TEST_GEN_FILES := \
 	devlink \
 	ethtool \
 	rt-addr \
-# end of TEST_GEN_FILES
-
-BINS := \
 	rt-route \
-# end of BINS
+# end of TEST_GEN_FILES
 
 TEST_FILES := ynl_nsim_lib.sh
 
@@ -47,7 +45,7 @@ include $(wildcard *.d)
 
 INSTALL_PATH ?= $(DESTDIR)/usr/share/kselftest
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
+all: $(TEST_GEN_PROGS) $(TEST_GEN_FILES)
 
 ../lib/ynl.a:
 	@$(MAKE) -C ../lib
@@ -55,7 +53,7 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
  ../generated/protos.a:
 	@$(MAKE) -C ../generated
 
-$(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS): %: %.c ../lib/ynl.a ../generated/protos.a
+$(TEST_GEN_PROGS) $(TEST_GEN_FILES): %: %.c ../lib/ynl.a ../generated/protos.a
 	@echo -e '\tCC test $@'
 	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
 	@$(LINK.c) $@.o -o $@  $(LDLIBS)
@@ -65,7 +63,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS): %: %.c ../lib/ynl.a ../generated/pr
 		./$$test; \
 	done
 
-install: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
+install: $(TEST_GEN_PROGS) $(TEST_GEN_FILES)
 	@mkdir -p $(INSTALL_PATH)/ynl
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(INSTALL_PATH)/
 	@for test in $(TEST_PROGS); do \
@@ -79,7 +77,7 @@ install: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
 	@for file in $(TEST_FILES); do \
 		cp $$file $(INSTALL_PATH)/ynl/$$file; \
 	done
-	@for bin in $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS); do \
+	@for bin in $(TEST_GEN_PROGS) $(TEST_GEN_FILES); do \
 		cp $$bin $(INSTALL_PATH)/ynl/$$bin; \
 	done
 	@for test in $(TEST_PROGS) $(TEST_GEN_PROGS); do \
@@ -90,7 +88,7 @@ install: $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
 	rm -f *.o *.d *~
 
 distclean: clean
-	rm -f $(TEST_GEN_PROGS) $(TEST_GEN_FILES) $(BINS)
+	rm -f $(TEST_GEN_PROGS) $(TEST_GEN_FILES)
 
 .PHONY: all install clean distclean run_tests
 .DEFAULT_GOAL=all
diff --git a/tools/net/ynl/tests/rt-route.c b/tools/net/ynl/tests/rt-route.c
index 7427104a96df..c9fd2bc48144 100644
--- a/tools/net/ynl/tests/rt-route.c
+++ b/tools/net/ynl/tests/rt-route.c
@@ -7,9 +7,12 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 
+#include <kselftest_harness.h>
+
 #include "rt-route-user.h"
 
-static void rt_route_print(struct rt_route_getroute_rsp *r)
+static void rt_route_print(struct __test_metadata *_metadata,
+			   struct rt_route_getroute_rsp *r)
 {
 	char ifname[IF_NAMESIZE];
 	char route_str[64];
@@ -22,8 +25,9 @@ static void rt_route_print(struct rt_route_getroute_rsp *r)
 
 	if (r->_present.oif) {
 		name = if_indextoname(r->oif, ifname);
+		EXPECT_NE(NULL, name);
 		if (name)
-			printf("oif: %-16s ", name);
+			ksft_print_msg("oif: %-16s ", name);
 	}
 
 	if (r->_len.dst) {
@@ -41,40 +45,69 @@ static void rt_route_print(struct rt_route_getroute_rsp *r)
 	printf("\n");
 }
 
-int main(int argc, char **argv)
+FIXTURE(rt_route)
+{
+	struct ynl_sock *ys;
+};
+
+FIXTURE_SETUP(rt_route)
+{
+	struct ynl_error yerr;
+
+	self->ys = ynl_sock_create(&ynl_rt_route_family, &yerr);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create rt-route socket: %s", yerr.msg);
+}
+
+FIXTURE_TEARDOWN(rt_route)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(rt_route, dump)
 {
 	struct rt_route_getroute_req_dump *req;
 	struct rt_route_getroute_list *rsp;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
+	struct in6_addr v6_expected;
+	struct in_addr v4_expected;
+	bool found_v4 = false;
+	bool found_v6 = false;
 
-	ys = ynl_sock_create(&ynl_rt_route_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
-	}
+	/* The bash wrapper configures 192.168.1.1/24 and 2001:db8::1/64,
+	 * make sure we can find the connected routes in the dump.
+	 */
+	inet_pton(AF_INET, "192.168.1.0", &v4_expected);
+	inet_pton(AF_INET6, "2001:db8::", &v6_expected);
 
 	req = rt_route_getroute_req_dump_alloc();
-	if (!req)
-		goto err_destroy;
+	ASSERT_NE(NULL, req);
 
-	rsp = rt_route_getroute_dump(ys, req);
+	rsp = rt_route_getroute_dump(self->ys, req);
 	rt_route_getroute_req_dump_free(req);
-	if (!rsp)
-		goto err_close;
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
 
-	if (ynl_dump_empty(rsp))
-		fprintf(stderr, "Error: no routeesses reported\n");
-	ynl_dump_foreach(rsp, route)
-		rt_route_print(route);
+	ASSERT_FALSE(ynl_dump_empty(rsp)) {
+		rt_route_getroute_list_free(rsp);
+		TH_LOG("no routes reported");
+	}
+
+	ynl_dump_foreach(rsp, route) {
+		rt_route_print(_metadata, route);
+
+		if (route->_hdr.rtm_table == RT_TABLE_LOCAL)
+			continue;
+
+		if (route->_len.dst == 4 && route->_hdr.rtm_dst_len == 24)
+			found_v4 |= !memcmp(route->dst, &v4_expected, 4);
+		if (route->_len.dst == 16 && route->_hdr.rtm_dst_len == 64)
+			found_v6 |= !memcmp(route->dst, &v6_expected, 16);
+	}
 	rt_route_getroute_list_free(rsp);
 
-	ynl_sock_destroy(ys);
-	return 0;
-
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-err_destroy:
-	ynl_sock_destroy(ys);
-	return 2;
+	EXPECT_TRUE(found_v4);
+	EXPECT_TRUE(found_v6);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/rt-route.sh b/tools/net/ynl/tests/rt-route.sh
new file mode 100755
index 000000000000..020338f0a238
--- /dev/null
+++ b/tools/net/ynl/tests/rt-route.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
+nsim_setup
+"$(dirname "$(realpath "$0")")/rt-route"
-- 
2.53.0


