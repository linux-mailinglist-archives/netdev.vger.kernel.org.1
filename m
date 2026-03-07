Return-Path: <netdev+bounces-265050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJpuGoidq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E779C229F65
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54B83088305
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67363311C2A;
	Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCyKTVO1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FE311959
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854605; cv=none; b=XADBygZb2/uPdAmUeZi2CgPuFiQ46thUkDcd99kEa8KAXI2mnNckqC5Qw/WgHpqg2K+jzYQWWvOz25WOAAmhKyhaCE4+LAP89fEQD15WxQe2vFfNZQHREjDAp+t2At2k8RWC8vYdzv2166JTXKtNM1nUwZPhMc4j/QYh8LlfCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854605; c=relaxed/simple;
	bh=EXZ9iSzjDV+permXa1OiU2KmjA45N/wSvwtpF7ZIIwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy0H0AJxUKbAnAlaIaT5cc3bSOqwpHxJwfOtDEiF4Yu0DJYP1zBVh0JfGcTnnBuWBY14SSGrDo+fl2iisCItoneMezYXCzVMTUi1Kf7YDjYDlfLADkZvwXOVYW/Ha9IvecNx1irlnFs5R1KDZqHxlUUzeuPvatCe/LUgYyjsRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCyKTVO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FACC2BC86;
	Sat,  7 Mar 2026 03:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854605;
	bh=EXZ9iSzjDV+permXa1OiU2KmjA45N/wSvwtpF7ZIIwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCyKTVO1vF0dyflhL5nQ5LeEME6CBgLEXw1k8uXrHE64mBtAbG1Keb7i7bbALAD2H
	 s5adEM4m973uirJG1hqpDrFfuFn4AuRLw2/D3ivXCtnbQsZtKG+CZ/9mGuCQmlTWVY
	 YmLeLcIONidbSwgLAdOCFwqD/bK+p02p2pDubu2TeZ7bdhsiuN7Z3+B+KgI+nCiWD8
	 SXaoz6Wj3DjaWTTYsQP27i1NxoiuKtuVzW8HwDxRZEdW4RWWx0Ur6SsM4olUFHRfoh
	 HME8Iy0aBL3G6Drnnw93qB0Zng1HSnyWxD0f+VnUPJnVIDZ5FztPw0s+pLtyaej2sr
	 ai2NQfyZHQ5Pw==
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
Subject: [PATCH net-next v2 03/10] tools: ynl: convert ovs sample to selftest
Date: Fri,  6 Mar 2026 19:36:23 -0800
Message-ID: <20260307033630.1396085-4-kuba@kernel.org>
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
X-Rspamd-Queue-Id: E779C229F65
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
	TAGGED_FROM(0.00)[bounces-265050-lists,netdev=lfdr.de];
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

Convert ovs.c to produce KTAP output with kselftest_harness.
The single "crud" test creates a new OVS datapath, fetches it back
by name, then dumps all datapaths verifying the new one appears.

IIRC I added this test because ovs is a genetlink family but
has a family-specific fixed header.

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           ovs.crud ...
  # get:
  # ynl-test(3): pid:0 cache:256
  # dump:
  # ynl-test(3): pid:0 cache:256
  #            OK  ovs.crud
  ok 1 ovs.crud
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile |   3 +-
 tools/net/ynl/tests/ovs.c    | 128 ++++++++++++++++++++++++-----------
 tools/net/ynl/tests/config   |   1 +
 3 files changed, 91 insertions(+), 41 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 1d77d3662f46..df9d37c8b2a4 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -20,12 +20,12 @@ TEST_PROGS := \
 
 TEST_GEN_PROGS := \
 	netdev \
+	ovs \
 # end of TEST_GEN_PROGS
 
 BINS := \
 	devlink \
 	ethtool \
-	ovs \
 	rt-addr \
 	rt-link \
 	rt-route \
@@ -34,6 +34,7 @@ BINS := \
 # end of BINS
 
 CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
+CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
 CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 
 include $(wildcard *.d)
diff --git a/tools/net/ynl/tests/ovs.c b/tools/net/ynl/tests/ovs.c
index 3e975c003d77..d49f5a8e647e 100644
--- a/tools/net/ynl/tests/ovs.c
+++ b/tools/net/ynl/tests/ovs.c
@@ -4,57 +4,105 @@
 
 #include <ynl.h>
 
+#include <kselftest_harness.h>
+
 #include "ovs_datapath-user.h"
 
-int main(int argc, char **argv)
+static void ovs_print_datapath(struct __test_metadata *_metadata,
+			       struct ovs_datapath_get_rsp *dp)
+{
+	EXPECT_TRUE((bool)dp->_len.name);
+	if (!dp->_len.name)
+		return;
+
+	EXPECT_TRUE((bool)dp->_hdr.dp_ifindex);
+	ksft_print_msg("%s(%d): pid:%u cache:%u\n",
+		       dp->name, dp->_hdr.dp_ifindex,
+		       dp->upcall_pid, dp->masks_cache_size);
+}
+
+FIXTURE(ovs)
 {
 	struct ynl_sock *ys;
+	char *dp_name;
+};
+
+FIXTURE_SETUP(ovs)
+{
+	self->ys = ynl_sock_create(&ynl_ovs_datapath_family, NULL);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create OVS datapath socket");
+}
+
+FIXTURE_TEARDOWN(ovs)
+{
+	if (self->dp_name) {
+		struct ovs_datapath_del_req *req;
+
+		req = ovs_datapath_del_req_alloc();
+		if (req) {
+			ovs_datapath_del_req_set_name(req, self->dp_name);
+			ovs_datapath_del(self->ys, req);
+			ovs_datapath_del_req_free(req);
+		}
+	}
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(ovs, crud)
+{
+	struct ovs_datapath_get_req_dump *dreq;
+	struct ovs_datapath_new_req *new_req;
+	struct ovs_datapath_get_list *dps;
+	struct ovs_datapath_get_rsp *dp;
+	struct ovs_datapath_get_req *req;
+	bool found = false;
 	int err;
 
-	ys = ynl_sock_create(&ynl_ovs_datapath_family, NULL);
-	if (!ys)
-		return 1;
+	new_req = ovs_datapath_new_req_alloc();
+	ASSERT_NE(NULL, new_req);
+	ovs_datapath_new_req_set_upcall_pid(new_req, 1);
+	ovs_datapath_new_req_set_name(new_req, "ynl-test");
 
-	if (argc > 1) {
-		struct ovs_datapath_new_req *req;
+	err = ovs_datapath_new(self->ys, new_req);
+	ovs_datapath_new_req_free(new_req);
+	ASSERT_EQ(0, err) {
+		TH_LOG("new failed: %s", self->ys->err.msg);
+	}
+	self->dp_name = "ynl-test";
 
-		req = ovs_datapath_new_req_alloc();
-		if (!req)
-			goto err_close;
+	ksft_print_msg("get:\n");
+	req = ovs_datapath_get_req_alloc();
+	ASSERT_NE(NULL, req);
+	ovs_datapath_get_req_set_name(req, "ynl-test");
 
-		ovs_datapath_new_req_set_upcall_pid(req, 1);
-		ovs_datapath_new_req_set_name(req, argv[1]);
-
-		err = ovs_datapath_new(ys, req);
-		ovs_datapath_new_req_free(req);
-		if (err)
-			goto err_close;
-	} else {
-		struct ovs_datapath_get_req_dump *req;
-		struct ovs_datapath_get_list *dps;
-
-		printf("Dump:\n");
-		req = ovs_datapath_get_req_dump_alloc();
-
-		dps = ovs_datapath_get_dump(ys, req);
-		ovs_datapath_get_req_dump_free(req);
-		if (!dps)
-			goto err_close;
-
-		ynl_dump_foreach(dps, dp) {
-			printf("  %s(%d): pid:%u cache:%u\n",
-			       dp->name, dp->_hdr.dp_ifindex,
-			       dp->upcall_pid, dp->masks_cache_size);
-		}
-		ovs_datapath_get_list_free(dps);
+	dp = ovs_datapath_get(self->ys, req);
+	ovs_datapath_get_req_free(req);
+	ASSERT_NE(NULL, dp) {
+		TH_LOG("get failed: %s", self->ys->err.msg);
 	}
 
-	ynl_sock_destroy(ys);
+	ovs_print_datapath(_metadata, dp);
+	EXPECT_STREQ("ynl-test", dp->name);
+	ovs_datapath_get_rsp_free(dp);
 
-	return 0;
+	ksft_print_msg("dump:\n");
+	dreq = ovs_datapath_get_req_dump_alloc();
+	ASSERT_NE(NULL, dreq);
 
-err_close:
-	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
-	ynl_sock_destroy(ys);
-	return 2;
+	dps = ovs_datapath_get_dump(self->ys, dreq);
+	ovs_datapath_get_req_dump_free(dreq);
+	ASSERT_NE(NULL, dps) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+
+	ynl_dump_foreach(dps, d) {
+		ovs_print_datapath(_metadata, d);
+		if (d->name && !strcmp(d->name, "ynl-test"))
+			found = true;
+	}
+	ovs_datapath_get_list_free(dps);
+	EXPECT_TRUE(found);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
index 339f1309c03f..357b34611da4 100644
--- a/tools/net/ynl/tests/config
+++ b/tools/net/ynl/tests/config
@@ -3,4 +3,5 @@ CONFIG_INET_DIAG=y
 CONFIG_IPV6=y
 CONFIG_NET_NS=y
 CONFIG_NETDEVSIM=m
+CONFIG_OPENVSWITCH=m
 CONFIG_VETH=m
-- 
2.53.0


