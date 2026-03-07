Return-Path: <netdev+bounces-265055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOp9M+edq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343CA229F89
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3289F30D7ECA
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FC3101CD;
	Sat,  7 Mar 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeFrxOmu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FE3101B6
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854608; cv=none; b=f0IxYQASHYFmgzqsbQKRWEXbPS+qHBqZiKCHMwRyWwNMcVjk+RGqOgXulUbBhx4pJJGa2itHMeasfEHvDWMAR9T9lEBFQU/ceM/pk1l6KUqPCyuLK66bTSIvAQZC5YfNqFG5w6rrfInPg+W0588nbHnh2/k8j8aFExNWBDRdNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854608; c=relaxed/simple;
	bh=8X8qYyPlONLCSDncxZGq/exN2rFPQ1YjLFrZ94E0Zt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb0glqAYC5QYcaYRfZ2UI2M704uGp2+7a8XstLZ0XSmzGF4Wq692cggTfv/ffYrPvWSEpTQl7vSdLiIrQaSHPTneAHIlJ73HoobjdpEUP11vmL/KjkerxLFAQ6t5LuTUJmE+nFIXDfGwrPvmrFHyvi+JfdlGKlQYVvL/HcUzeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeFrxOmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42CBC2BCAF;
	Sat,  7 Mar 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854608;
	bh=8X8qYyPlONLCSDncxZGq/exN2rFPQ1YjLFrZ94E0Zt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeFrxOmukkpNHdww3+Jiwe2bBC00IskJmiTKqOmEUYsjkxpyKaOk+d7tCAj7LnWb6
	 RFncpDWIl99VrzZ0FpLiwACs7fcvXasbYYeoaGfSvWSRyIR8b4rTxX8vHZpWZnGZO7
	 lLY1j8cmQosvEnGcWIvAN89yXRG7ye9hDA+8LN9noYtEikgtyYArq/iyPIENZUMIzJ
	 OGlKk5rA5GCLpLMMYVjOUwSEQPHnAYckax/u4OjTRn57JF7pn5e31QWslJa3TBqE4l
	 X3OTmKvxs03AB4kOfkLMs5MZ320XuLEC+GZSKezpVCuE1csH50C0RGIHv2qIVqq6u6
	 oN9dzTVO5FJ0Q==
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
Subject: [PATCH net-next v2 08/10] tools: ynl: convert ethtool sample to selftest
Date: Fri,  6 Mar 2026 19:36:28 -0800
Message-ID: <20260307033630.1396085-9-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 343CA229F89
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
	TAGGED_FROM(0.00)[bounces-265055-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ethtool.sh:url]
X-Rspamd-Action: no action

Convert ethtool.c to use kselftest_harness.h with FIXTURE/TEST_F.
Move ethtool from BINS to TEST_GEN_FILES and add ethtool.sh wrapper
which sets up a netdevsim device before running the test binary.

Output:

  TAP version 13
  1..2
  # Starting 2 tests from 1 test cases.
  #  RUN           ethtool.channels ...
  #    nsim0: combined 1
  #            OK  ethtool.channels
  ok 1 ethtool.channels
  #  RUN           ethtool.rings ...
  #    nsim0: rx 512 tx 512
  #            OK  ethtool.rings
  ok 2 ethtool.rings
  # PASSED: 2 / 2 tests passed.
  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile   |  3 +-
 tools/net/ynl/tests/ethtool.c  | 83 ++++++++++++++++++++++------------
 tools/net/ynl/tests/ethtool.sh |  5 ++
 3 files changed, 62 insertions(+), 29 deletions(-)
 create mode 100755 tools/net/ynl/tests/ethtool.sh

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 14d399a70f10..c380e9f331a3 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -15,6 +15,7 @@ LDLIBS=../lib/ynl.a ../generated/protos.a
 
 TEST_PROGS := \
 	devlink.sh \
+	ethtool.sh \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
@@ -28,10 +29,10 @@ TEST_GEN_PROGS := \
 
 TEST_GEN_FILES := \
 	devlink \
+	ethtool \
 # end of TEST_GEN_FILES
 
 BINS := \
-	ethtool \
 	rt-addr \
 	rt-route \
 # end of BINS
diff --git a/tools/net/ynl/tests/ethtool.c b/tools/net/ynl/tests/ethtool.c
index a7ebbd1b98db..926a75d23c9b 100644
--- a/tools/net/ynl/tests/ethtool.c
+++ b/tools/net/ynl/tests/ethtool.c
@@ -6,28 +6,49 @@
 
 #include <net/if.h>
 
+#include <kselftest_harness.h>
+
 #include "ethtool-user.h"
 
-int main(int argc, char **argv)
+FIXTURE(ethtool)
+{
+	struct ynl_sock *ys;
+};
+
+FIXTURE_SETUP(ethtool)
+{
+	self->ys = ynl_sock_create(&ynl_ethtool_family, NULL);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create ethtool socket");
+}
+
+FIXTURE_TEARDOWN(ethtool)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(ethtool, channels)
 {
 	struct ethtool_channels_get_req_dump creq = {};
-	struct ethtool_rings_get_req_dump rreq = {};
 	struct ethtool_channels_get_list *channels;
-	struct ethtool_rings_get_list *rings;
-	struct ynl_sock *ys;
 
-	ys = ynl_sock_create(&ynl_ethtool_family, NULL);
-	if (!ys)
-		return 1;
+	creq._present.header = 1; /* ethtool needs an empty nest */
+	channels = ethtool_channels_get_dump(self->ys, &creq);
+	ASSERT_NE(NULL, channels) {
+		TH_LOG("channels dump failed: %s", self->ys->err.msg);
+	}
 
-	creq._present.header = 1; /* ethtool needs an empty nest, sigh */
-	channels = ethtool_channels_get_dump(ys, &creq);
-	if (!channels)
-		goto err_close;
+	if (ynl_dump_empty(channels)) {
+		ethtool_channels_get_list_free(channels);
+		SKIP(return, "no entries in channels dump");
+	}
 
-	printf("Channels:\n");
 	ynl_dump_foreach(channels, dev) {
-		printf("  %8s: ", dev->header.dev_name);
+		EXPECT_TRUE((bool)dev->header._len.dev_name);
+		ksft_print_msg("%8s: ", dev->header.dev_name);
+		EXPECT_TRUE(dev->_present.rx_count ||
+			    dev->_present.tx_count ||
+			    dev->_present.combined_count);
 		if (dev->_present.rx_count)
 			printf("rx %d ", dev->rx_count);
 		if (dev->_present.tx_count)
@@ -37,15 +58,28 @@ int main(int argc, char **argv)
 		printf("\n");
 	}
 	ethtool_channels_get_list_free(channels);
+}
 
-	rreq._present.header = 1; /* ethtool needs an empty nest.. */
-	rings = ethtool_rings_get_dump(ys, &rreq);
-	if (!rings)
-		goto err_close;
+TEST_F(ethtool, rings)
+{
+	struct ethtool_rings_get_req_dump rreq = {};
+	struct ethtool_rings_get_list *rings;
+
+	rreq._present.header = 1; /* ethtool needs an empty nest */
+	rings = ethtool_rings_get_dump(self->ys, &rreq);
+	ASSERT_NE(NULL, rings) {
+		TH_LOG("rings dump failed: %s", self->ys->err.msg);
+	}
+
+	if (ynl_dump_empty(rings)) {
+		ethtool_rings_get_list_free(rings);
+		SKIP(return, "no entries in rings dump");
+	}
 
-	printf("Rings:\n");
 	ynl_dump_foreach(rings, dev) {
-		printf("  %8s: ", dev->header.dev_name);
+		EXPECT_TRUE((bool)dev->header._len.dev_name);
+		ksft_print_msg("%8s: ", dev->header.dev_name);
+		EXPECT_TRUE(dev->_present.rx || dev->_present.tx);
 		if (dev->_present.rx)
 			printf("rx %d ", dev->rx);
 		if (dev->_present.tx)
@@ -53,13 +87,6 @@ int main(int argc, char **argv)
 		printf("\n");
 	}
 	ethtool_rings_get_list_free(rings);
-
-	ynl_sock_destroy(ys);
-
-	return 0;
-
-err_close:
-	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
-	ynl_sock_destroy(ys);
-	return 2;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/ethtool.sh b/tools/net/ynl/tests/ethtool.sh
new file mode 100755
index 000000000000..0859ddd697e8
--- /dev/null
+++ b/tools/net/ynl/tests/ethtool.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
+nsim_setup
+"$(dirname "$(realpath "$0")")/ethtool"
-- 
2.53.0


