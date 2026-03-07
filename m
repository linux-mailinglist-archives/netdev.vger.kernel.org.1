Return-Path: <netdev+bounces-265051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCPaM5adq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE0229F6C
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4B8309AA65
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B33128B6;
	Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWLZ2WE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401131282C
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854605; cv=none; b=ut5GaHzZHI0mW1tzjO1g8niOA37dcxCEFW9YAZHi3/fFFS8BcquzropfXb0svNx1I3o0A/XGTM60ILmcbfsF315bJ9ySXNFzXU+WNDGlzqWzNC7mvDOdE+H2QdJ3CYk9IiSFeKeMAFE0hr0Wzm5+X0V2xVQjxZqQG3aWRdKBBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854605; c=relaxed/simple;
	bh=5sR6tDQdYFMgjKLPm0iP15hvGCnc3k6Ne2ET96hdeA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7/E4TuQ1jwaY1Xz6ZDtHGATg+jobYaW6o6vNq5dzEvSk8Zr29IJ73R3YqaS6/ejoCuw1gH0Jb7JGfnQwo2jLw5ilMXH0wqHr6kSCxn+K4pvXOZDIOmDw5MeouQL06jrwkRlYpmOxldhmaT5B3RoojhXyPy8H1sk8z7so7iCePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWLZ2WE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2322EC2BC9E;
	Sat,  7 Mar 2026 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854605;
	bh=5sR6tDQdYFMgjKLPm0iP15hvGCnc3k6Ne2ET96hdeA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWLZ2WE7u0uVUzhB4xLMY3znfdHyzfTDtocTxIHCM9kcxnEkc1mThknYM3jpnvoet
	 OBrwq3zJtYCqveLsRWFNBk9O8WG02e1s+WE+isnXefVL1SXitpv2HPnjvNh6Nq1B+e
	 XUJg3WqHqFQkxBkB7g0zIw4HsV7MtebdiavUqtzcoXgTkk3pY5fCivuamDk/Y9fndX
	 0Jj4xjPWOHVRYW5W0adi+PQrKvL6mqo9Bo+kzpTq0ETuvN9KzjQjiBAjbMdv8nOiDI
	 L6WJxaU9K7Oc/g9U0yPPkSPGLa4UG5ISkZcZ7fjXmZg0GFCx8TDVaVLIYVpKyuKTcq
	 ag22AZoo5++hA==
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
Subject: [PATCH net-next v2 04/10] tools: ynl: convert rt-link sample to selftest
Date: Fri,  6 Mar 2026 19:36:24 -0800
Message-ID: <20260307033630.1396085-5-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 32EE0229F6C
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
	TAGGED_FROM(0.00)[bounces-265051-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert rt-link.c to use kselftest_harness.h with FIXTURE/TEST_F.
Move rt-link from BINS to TEST_GEN_PROGS.

Output:

  TAP version 13
  1..3
  # Starting 3 tests from 1 test cases.
  #  RUN           rt_link.dump ...
  #   1:          lo: mtu 65536
  #   2:          sit0: mtu  1480  kind sit
  #            OK  rt_link.dump
  ok 1 rt_link.dump
  #  RUN           rt_link.netkit ...
  #   4:          nk1: mtu  1500  kind netkit    primary 1  policy blackhole
  #            OK  rt_link.netkit
  ok 2 rt_link.netkit
  #  RUN           rt_link.netkit_err_msg ...
  #            OK  rt_link.netkit_err_msg
  ok 3 rt_link.netkit_err_msg
  # PASSED: 3 / 3 tests passed.
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile  |   2 +-
 tools/net/ynl/tests/rt-link.c | 196 +++++++++++++++++++---------------
 tools/net/ynl/tests/config    |   1 +
 3 files changed, 111 insertions(+), 88 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index df9d37c8b2a4..08d1146d91ce 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -21,13 +21,13 @@ TEST_PROGS := \
 TEST_GEN_PROGS := \
 	netdev \
 	ovs \
+	rt-link \
 # end of TEST_GEN_PROGS
 
 BINS := \
 	devlink \
 	ethtool \
 	rt-addr \
-	rt-link \
 	rt-route \
 	tc \
 	tc-filter-add \
diff --git a/tools/net/ynl/tests/rt-link.c b/tools/net/ynl/tests/rt-link.c
index acdd4b4a0f74..ef619ce6143f 100644
--- a/tools/net/ynl/tests/rt-link.c
+++ b/tools/net/ynl/tests/rt-link.c
@@ -7,16 +7,21 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 
+#include <kselftest_harness.h>
+
 #include "rt-link-user.h"
 
-static void rt_link_print(struct rt_link_getlink_rsp *r)
+static void rt_link_print(struct __test_metadata *_metadata,
+			  struct rt_link_getlink_rsp *r)
 {
 	unsigned int i;
 
-	printf("%3d: ", r->_hdr.ifi_index);
+	EXPECT_TRUE((bool)r->_hdr.ifi_index);
+	ksft_print_msg("%3d: ", r->_hdr.ifi_index);
 
+	EXPECT_TRUE((bool)r->_len.ifname);
 	if (r->_len.ifname)
-		printf("%16s: ", r->ifname);
+		printf("%6s: ", r->ifname);
 
 	if (r->_present.mtu)
 		printf("mtu %5d  ", r->mtu);
@@ -50,7 +55,7 @@ static void rt_link_print(struct rt_link_getlink_rsp *r)
 	printf("\n");
 }
 
-static int rt_link_create_netkit(struct ynl_sock *ys)
+static int netkit_create(struct ynl_sock *ys)
 {
 	struct rt_link_getlink_ntf *ntf_gl;
 	struct rt_link_newlink_req *req;
@@ -58,49 +63,24 @@ static int rt_link_create_netkit(struct ynl_sock *ys)
 	int ret;
 
 	req = rt_link_newlink_req_alloc();
-	if (!req) {
-		fprintf(stderr, "Can't alloc req\n");
+	if (!req)
 		return -1;
-	}
 
-	/* rtnetlink doesn't provide info about the created object.
-	 * It expects us to set the ECHO flag and the dig the info out
-	 * of the notifications...
-	 */
 	rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);
-
 	rt_link_newlink_req_set_linkinfo_kind(req, "netkit");
-
-	/* Test error messages */
-	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, 10);
-	ret = rt_link_newlink(ys, req);
-	if (ret) {
-		printf("Testing error message for policy being bad:\n\t%s\n", ys->err.msg);
-	} else {
-		fprintf(stderr,	"Warning: unexpected success creating netkit with bad attrs\n");
-		goto created;
-	}
-
 	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, NETKIT_DROP);
 
 	ret = rt_link_newlink(ys, req);
-created:
 	rt_link_newlink_req_free(req);
-	if (ret) {
-		fprintf(stderr, "YNL: %s\n", ys->err.msg);
+	if (ret)
 		return -1;
-	}
 
-	if (!ynl_has_ntf(ys)) {
-		fprintf(stderr,
-			"Warning: interface created but received no notification, won't delete the interface\n");
+	if (!ynl_has_ntf(ys))
 		return 0;
-	}
 
 	ntf = ynl_ntf_dequeue(ys);
-	if (ntf->cmd !=	RTM_NEWLINK) {
-		fprintf(stderr,
-			"Warning: unexpected notification type, won't delete the interface\n");
+	if (!ntf || ntf->cmd != RTM_NEWLINK) {
+		ynl_ntf_free(ntf);
 		return 0;
 	}
 	ntf_gl = (void *)ntf;
@@ -110,75 +90,117 @@ static int rt_link_create_netkit(struct ynl_sock *ys)
 	return ret;
 }
 
-static void rt_link_del(struct ynl_sock *ys, int ifindex)
+static void netkit_delete(struct __test_metadata *_metadata,
+			  struct ynl_sock *ys, int ifindex)
 {
 	struct rt_link_dellink_req *req;
 
 	req = rt_link_dellink_req_alloc();
-	if (!req) {
-		fprintf(stderr, "Can't alloc req\n");
-		return;
-	}
+	ASSERT_NE(NULL, req);
 
 	req->_hdr.ifi_index = ifindex;
-	if (rt_link_dellink(ys, req))
-		fprintf(stderr, "YNL: %s\n", ys->err.msg);
-	else
-		fprintf(stderr,
-			"Trying to delete a Netkit interface (ifindex %d)\n",
-			ifindex);
-
+	EXPECT_EQ(0, rt_link_dellink(ys, req));
 	rt_link_dellink_req_free(req);
 }
 
-int main(int argc, char **argv)
+FIXTURE(rt_link)
+{
+	struct ynl_sock *ys;
+};
+
+FIXTURE_SETUP(rt_link)
+{
+	struct ynl_error yerr;
+
+	self->ys = ynl_sock_create(&ynl_rt_link_family, &yerr);
+	ASSERT_NE(NULL, self->ys) {
+		TH_LOG("failed to create rt-link socket: %s", yerr.msg);
+	}
+}
+
+FIXTURE_TEARDOWN(rt_link)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(rt_link, dump)
 {
 	struct rt_link_getlink_req_dump *req;
 	struct rt_link_getlink_list *rsp;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
-	int created = 0;
-
-	ys = ynl_sock_create(&ynl_rt_link_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
-	}
-
-	if (argc > 1) {
-		fprintf(stderr, "Trying to create a Netkit interface\n");
-		created = rt_link_create_netkit(ys);
-		if (created < 0)
-			goto err_destroy;
-	}
 
 	req = rt_link_getlink_req_dump_alloc();
-	if (!req)
-		goto err_del_ifc;
-
-	rsp = rt_link_getlink_dump(ys, req);
+	ASSERT_NE(NULL, req);
+	rsp = rt_link_getlink_dump(self->ys, req);
 	rt_link_getlink_req_dump_free(req);
-	if (!rsp)
-		goto err_close;
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+	ASSERT_FALSE(ynl_dump_empty(rsp));
 
-	if (ynl_dump_empty(rsp))
-		fprintf(stderr, "Error: no links reported\n");
 	ynl_dump_foreach(rsp, link)
-		rt_link_print(link);
+		rt_link_print(_metadata, link);
+
 	rt_link_getlink_list_free(rsp);
-
-	if (created)
-		rt_link_del(ys, created);
-
-	ynl_sock_destroy(ys);
-	return 0;
-
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-err_del_ifc:
-	if (created)
-		rt_link_del(ys, created);
-err_destroy:
-	ynl_sock_destroy(ys);
-	return 2;
 }
+
+TEST_F(rt_link, netkit)
+{
+	struct rt_link_getlink_req_dump *dreq;
+	struct rt_link_getlink_list *rsp;
+	bool found = false;
+	int netkit_ifindex;
+
+	/* Create netkit with valid policy */
+	netkit_ifindex = netkit_create(self->ys);
+	ASSERT_GT(netkit_ifindex, 0)
+		TH_LOG("failed to create netkit: %s", self->ys->err.msg);
+
+	/* Verify it appears in a dump */
+	dreq = rt_link_getlink_req_dump_alloc();
+	ASSERT_NE(NULL, dreq);
+	rsp = rt_link_getlink_dump(self->ys, dreq);
+	rt_link_getlink_req_dump_free(dreq);
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+
+	ynl_dump_foreach(rsp, link) {
+		if (link->_hdr.ifi_index == netkit_ifindex) {
+			rt_link_print(_metadata, link);
+			found = true;
+		}
+	}
+	rt_link_getlink_list_free(rsp);
+	EXPECT_TRUE(found);
+
+	netkit_delete(_metadata, self->ys, netkit_ifindex);
+}
+
+TEST_F(rt_link, netkit_err_msg)
+{
+	struct rt_link_newlink_req *req;
+	int ret;
+
+	/* Test creating netkit with bad policy - should fail */
+	req = rt_link_newlink_req_alloc();
+	ASSERT_NE(NULL, req);
+	rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE);
+	rt_link_newlink_req_set_linkinfo_kind(req, "netkit");
+	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, 10);
+
+	ret = rt_link_newlink(self->ys, req);
+	rt_link_newlink_req_free(req);
+	EXPECT_NE(0, ret) {
+		TH_LOG("creating netkit with bad policy should fail");
+	}
+
+	/* Expect:
+	 * Kernel error: 'Provided default xmit policy not supported' (bad attribute: .linkinfo.data(netkit).policy)
+	 */
+	EXPECT_NE(NULL, strstr(self->ys->err.msg, "bad attribute: .linkinfo.data(netkit).policy")) {
+		TH_LOG("expected extack msg not found: %s",
+		       self->ys->err.msg);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
index 357b34611da4..b4c58d86a6c2 100644
--- a/tools/net/ynl/tests/config
+++ b/tools/net/ynl/tests/config
@@ -3,5 +3,6 @@ CONFIG_INET_DIAG=y
 CONFIG_IPV6=y
 CONFIG_NET_NS=y
 CONFIG_NETDEVSIM=m
+CONFIG_NETKIT=y
 CONFIG_OPENVSWITCH=m
 CONFIG_VETH=m
-- 
2.53.0


