Return-Path: <netdev+bounces-265056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDziFOmdq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B005229F90
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4708930D9104
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07634310636;
	Sat,  7 Mar 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl1+yO8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F3101A2
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854608; cv=none; b=r79qjk1dx5ys8M4QsT5ViUIyFzyfGahjAj0ul003SKYKqdMmAoZo3WSIG4LYCccUzyJWY6Js3XztU4qTB+n0T2t5bNiy8SoAgbngjWCxYPDWxL6+h72Vk6zOSHi6w6e+pYdZb68teU+JsOrTwVuIZJ5g2VAOSNhZbh04/MrnGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854608; c=relaxed/simple;
	bh=2fA8eLDEtwGisyMdlSXjQPp6RvVDgWD4RUmxJj2NBMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMrLDWq7+fTR7Np8OYGDR5YmOwsdlvIeTwqC9HOEnJW0aNXZ+iyp6NnAOrPPNJc1DBCC+BhT5hk7uIv4uOdidnC/bKDAhjA7RYOEjJAvPHDwnvmfFcupg6UdvKKiNc4kkuZEIZHvMFjSqzwch6qvVcfnG4uXrJ5XM1QuwqEDTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl1+yO8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43365C19422;
	Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854608;
	bh=2fA8eLDEtwGisyMdlSXjQPp6RvVDgWD4RUmxJj2NBMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sl1+yO8IVi7Yqz57ZWGBrPih4ESzlRb7A/WJpxfWN71PkRFdCKX7XlM9VMY4pYbTZ
	 873hCWnWDS/uCfY/sysVhJxvmGELUM5w0x64Liee5XotyRfH4OYA4UQjVMT/BQpQ+2
	 GzqeSEQ9AfKyv0C+K51ff9LEWRQemLKoDrX8BbXhQmm9ccwqW9CefwsQupLD7vAYG3
	 D/JwO/XW6y7LuD+xZlPqMZZB+jSJH3B4rwRl/CZAemZ1QiRtB0w3JHFqB31iPjGNFj
	 NLhq8ih12vQSLW9hOaIESKxjUpPSwQTOeORecmV4jIdrkBPTzC2oDCmmUCJBF5j+BF
	 Q/c3m2IsI004Q==
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
Subject: [PATCH net-next v2 09/10] tools: ynl: convert rt-addr sample to selftest
Date: Fri,  6 Mar 2026 19:36:29 -0800
Message-ID: <20260307033630.1396085-10-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 9B005229F90
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
	TAGGED_FROM(0.00)[bounces-265056-lists,netdev=lfdr.de];
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

Convert rt-addr.c to use kselftest_harness.h with FIXTURE/TEST_F.

Validate that the addresses configured by the wrapper (192.168.1.1
and 2001:db8::1) appear in the dump.

Output:

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           rt_addr.dump ...
  #               lo: 127.0.0.1
  #            nsim0: 192.168.1.1
  #               lo: ::1
  #            nsim0: 2001:db8::1
  #            nsim0: fe80::7c66:c9ff:fe5f:bf01
  #            OK  rt_addr.dump
  ok 1 rt_addr.dump
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile   |  3 +-
 tools/net/ynl/tests/rt-addr.c  | 85 +++++++++++++++++++++++-----------
 tools/net/ynl/tests/rt-addr.sh |  5 ++
 3 files changed, 65 insertions(+), 28 deletions(-)
 create mode 100755 tools/net/ynl/tests/rt-addr.sh

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index c380e9f331a3..52b54ea6c90f 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -16,6 +16,7 @@ LDLIBS=../lib/ynl.a ../generated/protos.a
 TEST_PROGS := \
 	devlink.sh \
 	ethtool.sh \
+	rt-addr.sh \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
@@ -30,10 +31,10 @@ TEST_GEN_PROGS := \
 TEST_GEN_FILES := \
 	devlink \
 	ethtool \
+	rt-addr \
 # end of TEST_GEN_FILES
 
 BINS := \
-	rt-addr \
 	rt-route \
 # end of BINS
 
diff --git a/tools/net/ynl/tests/rt-addr.c b/tools/net/ynl/tests/rt-addr.c
index 2edde5c36b18..f6c3715b2f20 100644
--- a/tools/net/ynl/tests/rt-addr.c
+++ b/tools/net/ynl/tests/rt-addr.c
@@ -7,9 +7,12 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 
+#include <kselftest_harness.h>
+
 #include "rt-addr-user.h"
 
-static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
+static void rt_addr_print(struct __test_metadata *_metadata,
+			  struct rt_addr_getaddr_rsp *a)
 {
 	char ifname[IF_NAMESIZE];
 	char addr_str[64];
@@ -17,9 +20,11 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
 	const char *name;
 
 	name = if_indextoname(a->_hdr.ifa_index, ifname);
+	EXPECT_NE(NULL, name);
 	if (name)
-		printf("%16s: ", name);
+		ksft_print_msg("%16s: ", name);
 
+	EXPECT_TRUE(a->_len.address == 4 || a->_len.address == 16);
 	switch (a->_len.address) {
 	case 4:
 		addr = inet_ntop(AF_INET, a->address,
@@ -41,40 +46,66 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
 	printf("\n");
 }
 
-int main(int argc, char **argv)
+FIXTURE(rt_addr)
+{
+	struct ynl_sock *ys;
+};
+
+FIXTURE_SETUP(rt_addr)
+{
+	struct ynl_error yerr;
+
+	self->ys = ynl_sock_create(&ynl_rt_addr_family, &yerr);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create rt-addr socket: %s", yerr.msg);
+}
+
+FIXTURE_TEARDOWN(rt_addr)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(rt_addr, dump)
 {
 	struct rt_addr_getaddr_list *rsp;
 	struct rt_addr_getaddr_req *req;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
+	struct in6_addr v6_expected;
+	struct in_addr v4_expected;
+	bool found_v4 = false;
+	bool found_v6 = false;
 
-	ys = ynl_sock_create(&ynl_rt_addr_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
-	}
+	/* The bash wrapper for this test adds these addresses on nsim0,
+	 * make sure we can find them in the dump.
+	 */
+	inet_pton(AF_INET, "192.168.1.1", &v4_expected);
+	inet_pton(AF_INET6, "2001:db8::1", &v6_expected);
 
 	req = rt_addr_getaddr_req_alloc();
-	if (!req)
-		goto err_destroy;
+	ASSERT_NE(NULL, req);
 
-	rsp = rt_addr_getaddr_dump(ys, req);
+	rsp = rt_addr_getaddr_dump(self->ys, req);
 	rt_addr_getaddr_req_free(req);
-	if (!rsp)
-		goto err_close;
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
 
-	if (ynl_dump_empty(rsp))
-		fprintf(stderr, "Error: no addresses reported\n");
-	ynl_dump_foreach(rsp, addr)
-		rt_addr_print(addr);
+	ASSERT_FALSE(ynl_dump_empty(rsp)) {
+		rt_addr_getaddr_list_free(rsp);
+		TH_LOG("no addresses reported");
+	}
+
+	ynl_dump_foreach(rsp, addr) {
+		rt_addr_print(_metadata, addr);
+
+		found_v4 |= addr->_len.address == 4 &&
+			    !memcmp(addr->address, &v4_expected, 4);
+		found_v6 |= addr->_len.address == 16 &&
+			    !memcmp(addr->address, &v6_expected, 16);
+	}
 	rt_addr_getaddr_list_free(rsp);
 
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
diff --git a/tools/net/ynl/tests/rt-addr.sh b/tools/net/ynl/tests/rt-addr.sh
new file mode 100755
index 000000000000..87661236d126
--- /dev/null
+++ b/tools/net/ynl/tests/rt-addr.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
+nsim_setup
+"$(dirname "$(realpath "$0")")/rt-addr"
-- 
2.53.0


