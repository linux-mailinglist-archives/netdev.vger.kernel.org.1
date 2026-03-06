Return-Path: <netdev+bounces-264614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEPXApo3qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:10:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FA21A7DC
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656803071A69
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7073D33A9E9;
	Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEsNWToB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD3330B2E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762964; cv=none; b=mC+80C8QIBbbDqZhoOUcxX8aDmInvFm67pPQVXI/SIKsskaHdsGp4V+S2RnvY2hS5NFUmWRVvctloxf5f9qi5XH0LJMt5FeE5XrHgvexYGdyt+SiLA627IdHG4cVNCw15FiMkVk4oHGEsDX2cUBrtZUD/jHWI6cJ/jSFP5MztNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762964; c=relaxed/simple;
	bh=dHUL8jV1X0NbkR6yVyFZXDxoi3ggn4hJMvXizQzlXbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiQsDZibioeSMc9YUsBxxu1+nT8b4SuvlQw2lhNaCwE7stZng6NLYVLhVFdlBjWc+S1L3OCTN5n0ZHVmIH3VIBeLte5+cbhoAjXXwB1bb7Dt7H7sGVdnd5W89cBaW2SaNQfPpYWfkiMBuEhl5k/dbVCcizuLqEV8L3S7S0C8YCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEsNWToB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972ABC19423;
	Fri,  6 Mar 2026 02:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762964;
	bh=dHUL8jV1X0NbkR6yVyFZXDxoi3ggn4hJMvXizQzlXbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEsNWToBkuAm05bAsIme3v31hDghrGMipGLyLCjixGukoFNFoTqfQ/M9xTQ9ZWKbU
	 931i86XfjBwujkcx2OFrK7stM+REJu0UVPSRk5GlzHfvotTVBtl5fousb6620DZbKK
	 UTT7DjVV04OzW1O8AOhqNgolMZqau3x5yBiXYByJsn8DTq0dmeQzTxRWsS5l6vfHDa
	 eL/RXrjWRpxlBJMJ8N23zAF/lbcheKF8zwX3cE7ian+Ri3/6mlDIyVpFXh2yQYDO63
	 A5H589pitPfBkmh0qRJT13rR/y3Q7pkWWBMgcuVJntqNvOjPQldwwzTNpclO/wKwRU
	 dMfKXbbjoFhwA==
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
Subject: [PATCH net-next 05/10] tools: ynl: convert tc and tc-filter-add samples to selftest
Date: Thu,  5 Mar 2026 18:08:56 -0800
Message-ID: <20260306020901.524105-6-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 5F9FA21A7DC
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
	TAGGED_FROM(0.00)[bounces-264614-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert tc.c and tc-filter-add.c to produce KTAP output with
kselftest_harness. Merge the two tests together. They both
test TC one is testing qdisc and the other classifiers but
they can easily live in a single selftest.

Make the test spawn a new netns, and run the operations on
lo to avoid onerous setup and cleanup.

  TAP version 13
  1..2
  # Starting 2 tests from 1 test cases.
  #  RUN           tc.qdisc ...
  #               lo: fq_codel  limit: 10240p target: 5ms new_flow_cnt: 0
  #            OK  tc.qdisc
  ok 1 tc.qdisc
  #  RUN           tc.flower ...
  # flower pref 1 proto: 0x8100
  # flower:
  #   vlan_id: 100
  #   vlan_prio: 5
  #   num_of_vlans: 3
  # action order: 1 vlan push id 200 protocol 0x8100 priority 0
  # action order: 2 vlan push id 300 protocol 0x8100 priority 0
  #            OK  tc.flower
  ok 2 tc.flower
  # PASSED: 2 / 2 tests passed.
  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile        |   4 +-
 tools/net/ynl/tests/tc-filter-add.c | 335 -----------------------
 tools/net/ynl/tests/tc.c            | 403 +++++++++++++++++++++++++---
 tools/net/ynl/tests/config          |   6 +
 4 files changed, 372 insertions(+), 376 deletions(-)
 delete mode 100644 tools/net/ynl/tests/tc-filter-add.c

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 08d1146d91ce..524092a8de7e 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -22,6 +22,7 @@ TEST_GEN_PROGS := \
 	netdev \
 	ovs \
 	rt-link \
+	tc \
 # end of TEST_GEN_PROGS
 
 BINS := \
@@ -29,13 +30,10 @@ BINS := \
 	ethtool \
 	rt-addr \
 	rt-route \
-	tc \
-	tc-filter-add \
 # end of BINS
 
 CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
 CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
-CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 
 include $(wildcard *.d)
 
diff --git a/tools/net/ynl/tests/tc-filter-add.c b/tools/net/ynl/tests/tc-filter-add.c
deleted file mode 100644
index 97871e9e9edc..000000000000
--- a/tools/net/ynl/tests/tc-filter-add.c
+++ /dev/null
@@ -1,335 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <arpa/inet.h>
-#include <linux/pkt_sched.h>
-#include <linux/tc_act/tc_vlan.h>
-#include <linux/tc_act/tc_gact.h>
-#include <linux/if_ether.h>
-#include <net/if.h>
-
-#include <ynl.h>
-
-#include "tc-user.h"
-
-#define TC_HANDLE (0xFFFF << 16)
-
-const char *vlan_act_name(struct tc_vlan *p)
-{
-	switch (p->v_action) {
-	case TCA_VLAN_ACT_POP:
-		return "pop";
-	case TCA_VLAN_ACT_PUSH:
-		return "push";
-	case TCA_VLAN_ACT_MODIFY:
-		return "modify";
-	default:
-		break;
-	}
-
-	return "not supported";
-}
-
-const char *gact_act_name(struct tc_gact *p)
-{
-	switch (p->action) {
-	case TC_ACT_SHOT:
-		return "drop";
-	case TC_ACT_OK:
-		return "ok";
-	case TC_ACT_PIPE:
-		return "pipe";
-	default:
-		break;
-	}
-
-	return "not supported";
-}
-
-static void print_vlan(struct tc_act_vlan_attrs *vlan)
-{
-	printf("%s ", vlan_act_name(vlan->parms));
-	if (vlan->_present.push_vlan_id)
-		printf("id %u ", vlan->push_vlan_id);
-	if (vlan->_present.push_vlan_protocol)
-		printf("protocol %#x ", ntohs(vlan->push_vlan_protocol));
-	if (vlan->_present.push_vlan_priority)
-		printf("priority %u ", vlan->push_vlan_priority);
-}
-
-static void print_gact(struct tc_act_gact_attrs *gact)
-{
-	struct tc_gact *p = gact->parms;
-
-	printf("%s ", gact_act_name(p));
-}
-
-static void flower_print(struct tc_flower_attrs *flower, const char *kind)
-{
-	struct tc_act_attrs *a;
-	unsigned int i;
-
-	printf("%s:\n", kind);
-
-	if (flower->_present.key_vlan_id)
-		printf("  vlan_id: %u\n", flower->key_vlan_id);
-	if (flower->_present.key_vlan_prio)
-		printf("  vlan_prio: %u\n", flower->key_vlan_prio);
-	if (flower->_present.key_num_of_vlans)
-		printf("  num_of_vlans: %u\n", flower->key_num_of_vlans);
-
-	for (i = 0; i < flower->_count.act; i++) {
-		a = &flower->act[i];
-		printf("action order: %i %s ", i + 1, a->kind);
-		if (a->options._present.vlan)
-			print_vlan(&a->options.vlan);
-		else if (a->options._present.gact)
-			print_gact(&a->options.gact);
-		printf("\n");
-	}
-	printf("\n");
-}
-
-static void tc_filter_print(struct tc_gettfilter_rsp *f)
-{
-	struct tc_options_msg *opt = &f->options;
-
-	if (opt->_present.flower)
-		flower_print(&opt->flower, f->kind);
-	else if (f->_len.kind)
-		printf("%s pref %u proto: %#x\n", f->kind,
-		       (f->_hdr.tcm_info >> 16),
-			ntohs(TC_H_MIN(f->_hdr.tcm_info)));
-}
-
-static int tc_filter_add(struct ynl_sock *ys, int ifi)
-{
-	struct tc_newtfilter_req *req;
-	struct tc_act_attrs *acts;
-	struct tc_vlan p = {
-		.action = TC_ACT_PIPE,
-		.v_action = TCA_VLAN_ACT_PUSH
-	};
-	__u16 flags = NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE;
-	int ret;
-
-	req = tc_newtfilter_req_alloc();
-	if (!req) {
-		fprintf(stderr, "tc_newtfilter_req_alloc failed\n");
-		return -1;
-	}
-	memset(req, 0, sizeof(*req));
-
-	acts = tc_act_attrs_alloc(3);
-	if (!acts) {
-		fprintf(stderr, "tc_act_attrs_alloc\n");
-		tc_newtfilter_req_free(req);
-		return -1;
-	}
-	memset(acts, 0, sizeof(*acts) * 3);
-
-	req->_hdr.tcm_ifindex = ifi;
-	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
-	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
-	req->chain = 0;
-
-	tc_newtfilter_req_set_nlflags(req, flags);
-	tc_newtfilter_req_set_kind(req, "flower");
-	tc_newtfilter_req_set_options_flower_key_vlan_id(req, 100);
-	tc_newtfilter_req_set_options_flower_key_vlan_prio(req, 5);
-	tc_newtfilter_req_set_options_flower_key_num_of_vlans(req, 3);
-
-	__tc_newtfilter_req_set_options_flower_act(req, acts, 3);
-
-	/* Skip action at index 0 because in TC, the action array
-	 * index starts at 1, with each index defining the action's
-	 * order. In contrast, in YNL indexed arrays start at index 0.
-	 */
-	tc_act_attrs_set_kind(&acts[1], "vlan");
-	tc_act_attrs_set_options_vlan_parms(&acts[1], &p, sizeof(p));
-	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[1], 200);
-	tc_act_attrs_set_kind(&acts[2], "vlan");
-	tc_act_attrs_set_options_vlan_parms(&acts[2], &p, sizeof(p));
-	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[2], 300);
-
-	tc_newtfilter_req_set_options_flower_flags(req, 0);
-	tc_newtfilter_req_set_options_flower_key_eth_type(req, htons(0x8100));
-
-	ret = tc_newtfilter(ys, req);
-	if (ret)
-		fprintf(stderr, "tc_newtfilter: %s\n", ys->err.msg);
-
-	tc_newtfilter_req_free(req);
-
-	return ret;
-}
-
-static int tc_filter_show(struct ynl_sock *ys, int ifi)
-{
-	struct tc_gettfilter_req_dump *req;
-	struct tc_gettfilter_list *rsp;
-
-	req = tc_gettfilter_req_dump_alloc();
-	if (!req) {
-		fprintf(stderr, "tc_gettfilter_req_dump_alloc failed\n");
-		return -1;
-	}
-	memset(req, 0, sizeof(*req));
-
-	req->_hdr.tcm_ifindex = ifi;
-	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
-	req->_present.chain = 1;
-	req->chain = 0;
-
-	rsp = tc_gettfilter_dump(ys, req);
-	tc_gettfilter_req_dump_free(req);
-	if (!rsp) {
-		fprintf(stderr, "YNL: %s\n", ys->err.msg);
-		return -1;
-	}
-
-	if (ynl_dump_empty(rsp))
-		fprintf(stderr, "Error: no filters reported\n");
-	else
-		ynl_dump_foreach(rsp, flt) tc_filter_print(flt);
-
-	tc_gettfilter_list_free(rsp);
-
-	return 0;
-}
-
-static int tc_filter_del(struct ynl_sock *ys, int ifi)
-{
-	struct tc_deltfilter_req *req;
-	__u16 flags = NLM_F_REQUEST;
-	int ret;
-
-	req = tc_deltfilter_req_alloc();
-	if (!req) {
-		fprintf(stderr, "tc_deltfilter_req_alloc failed\n");
-		return -1;
-	}
-	memset(req, 0, sizeof(*req));
-
-	req->_hdr.tcm_ifindex = ifi;
-	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
-	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
-	tc_deltfilter_req_set_nlflags(req, flags);
-
-	ret = tc_deltfilter(ys, req);
-	if (ret)
-		fprintf(stderr, "tc_deltfilter failed: %s\n", ys->err.msg);
-
-	tc_deltfilter_req_free(req);
-
-	return ret;
-}
-
-static int tc_clsact_add(struct ynl_sock *ys, int ifi)
-{
-	struct tc_newqdisc_req *req;
-	__u16 flags = NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE;
-	int ret;
-
-	req = tc_newqdisc_req_alloc();
-	if (!req) {
-		fprintf(stderr, "tc_newqdisc_req_alloc failed\n");
-		return -1;
-	}
-	memset(req, 0, sizeof(*req));
-
-	req->_hdr.tcm_ifindex = ifi;
-	req->_hdr.tcm_parent = TC_H_CLSACT;
-	req->_hdr.tcm_handle = TC_HANDLE;
-	tc_newqdisc_req_set_nlflags(req, flags);
-	tc_newqdisc_req_set_kind(req, "clsact");
-
-	ret = tc_newqdisc(ys, req);
-	if (ret)
-		fprintf(stderr, "tc_newqdisc failed: %s\n", ys->err.msg);
-
-	tc_newqdisc_req_free(req);
-
-	return ret;
-}
-
-static int tc_clsact_del(struct ynl_sock *ys, int ifi)
-{
-	struct tc_delqdisc_req *req;
-	__u16 flags = NLM_F_REQUEST;
-	int ret;
-
-	req = tc_delqdisc_req_alloc();
-	if (!req) {
-		fprintf(stderr, "tc_delqdisc_req_alloc failed\n");
-		return -1;
-	}
-	memset(req, 0, sizeof(*req));
-
-	req->_hdr.tcm_ifindex = ifi;
-	req->_hdr.tcm_parent = TC_H_CLSACT;
-	req->_hdr.tcm_handle = TC_HANDLE;
-	tc_delqdisc_req_set_nlflags(req, flags);
-
-	ret = tc_delqdisc(ys, req);
-	if (ret)
-		fprintf(stderr, "tc_delqdisc failed: %s\n", ys->err.msg);
-
-	tc_delqdisc_req_free(req);
-
-	return ret;
-}
-
-static int tc_filter_config(struct ynl_sock *ys, int ifi)
-{
-	int ret = 0;
-
-	if (tc_filter_add(ys, ifi))
-		return -1;
-
-	ret = tc_filter_show(ys, ifi);
-
-	if (tc_filter_del(ys, ifi))
-		return -1;
-
-	return ret;
-}
-
-int main(int argc, char **argv)
-{
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
-	int ifi, ret = 0;
-
-	if (argc < 2) {
-		fprintf(stderr, "Usage: %s <interface_name>\n", argv[0]);
-		return 1;
-	}
-	ifi = if_nametoindex(argv[1]);
-	if (!ifi) {
-		perror("if_nametoindex");
-		return 1;
-	}
-
-	ys = ynl_sock_create(&ynl_tc_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
-	}
-
-	if (tc_clsact_add(ys, ifi)) {
-		ret = 2;
-		goto err_destroy;
-	}
-
-	if (tc_filter_config(ys, ifi))
-		ret = 3;
-
-	if (tc_clsact_del(ys, ifi))
-		ret = 4;
-
-err_destroy:
-	ynl_sock_destroy(ys);
-	return ret;
-}
diff --git a/tools/net/ynl/tests/tc.c b/tools/net/ynl/tests/tc.c
index 0bfff0fdd792..77e6fb69c61e 100644
--- a/tools/net/ynl/tests/tc.c
+++ b/tools/net/ynl/tests/tc.c
@@ -1,21 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
+#include <arpa/inet.h>
+#include <linux/pkt_sched.h>
+#include <linux/tc_act/tc_vlan.h>
+#include <linux/tc_act/tc_gact.h>
+#include <linux/if_ether.h>
+#include <net/if.h>
 
 #include <ynl.h>
 
-#include <net/if.h>
+#include <kselftest_harness.h>
 
 #include "tc-user.h"
 
-static void tc_qdisc_print(struct tc_getqdisc_rsp *q)
+#define TC_HANDLE (0xFFFF << 16)
+
+static bool tc_qdisc_print(struct __test_metadata *_metadata,
+			   struct tc_getqdisc_rsp *q)
 {
+	bool was_fq_codel = false;
 	char ifname[IF_NAMESIZE];
 	const char *name;
 
 	name = if_indextoname(q->_hdr.tcm_ifindex, ifname);
-	if (name)
-		printf("%16s: ", name);
+	EXPECT_TRUE((bool)name);
+	ksft_print_msg("%16s: ", name ?: "no-name");
 
 	if (q->_len.kind) {
 		printf("%s  ", q->kind);
@@ -27,6 +40,11 @@ static void tc_qdisc_print(struct tc_getqdisc_rsp *q)
 			fq_codel = &q->options.fq_codel;
 			stats = q->stats2.app.fq_codel;
 
+			EXPECT_EQ(true,
+				  fq_codel->_present.limit &&
+				  fq_codel->_present.target &&
+				  q->stats2.app._len.fq_codel);
+
 			if (fq_codel->_present.limit)
 				printf("limit: %dp ", fq_codel->limit);
 			if (fq_codel->_present.target)
@@ -35,46 +53,355 @@ static void tc_qdisc_print(struct tc_getqdisc_rsp *q)
 			if (q->stats2.app._len.fq_codel)
 				printf("new_flow_cnt: %d ",
 				       stats->qdisc_stats.new_flow_count);
+			was_fq_codel = true;
 		}
 	}
-
 	printf("\n");
+
+	return was_fq_codel;
 }
 
-int main(int argc, char **argv)
+static const char *vlan_act_name(struct tc_vlan *p)
 {
-	struct tc_getqdisc_req_dump *req;
-	struct tc_getqdisc_list *rsp;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
-
-	ys = ynl_sock_create(&ynl_tc_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
+	switch (p->v_action) {
+	case TCA_VLAN_ACT_POP:
+		return "pop";
+	case TCA_VLAN_ACT_PUSH:
+		return "push";
+	case TCA_VLAN_ACT_MODIFY:
+		return "modify";
+	default:
+		break;
 	}
 
-	req = tc_getqdisc_req_dump_alloc();
-	if (!req)
-		goto err_destroy;
-
-	rsp = tc_getqdisc_dump(ys, req);
-	tc_getqdisc_req_dump_free(req);
-	if (!rsp)
-		goto err_close;
-
-	if (ynl_dump_empty(rsp))
-		fprintf(stderr, "Error: no addresses reported\n");
-	ynl_dump_foreach(rsp, qdisc)
-		tc_qdisc_print(qdisc);
-	tc_getqdisc_list_free(rsp);
-
-	ynl_sock_destroy(ys);
-	return 0;
-
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-err_destroy:
-	ynl_sock_destroy(ys);
-	return 2;
+	return "not supported";
 }
+
+static const char *gact_act_name(struct tc_gact *p)
+{
+	switch (p->action) {
+	case TC_ACT_SHOT:
+		return "drop";
+	case TC_ACT_OK:
+		return "ok";
+	case TC_ACT_PIPE:
+		return "pipe";
+	default:
+		break;
+	}
+
+	return "not supported";
+}
+
+static void print_vlan(struct tc_act_vlan_attrs *vlan)
+{
+	printf("%s ", vlan_act_name(vlan->parms));
+	if (vlan->_present.push_vlan_id)
+		printf("id %u ", vlan->push_vlan_id);
+	if (vlan->_present.push_vlan_protocol)
+		printf("protocol %#x ", ntohs(vlan->push_vlan_protocol));
+	if (vlan->_present.push_vlan_priority)
+		printf("priority %u ", vlan->push_vlan_priority);
+}
+
+static void print_gact(struct tc_act_gact_attrs *gact)
+{
+	struct tc_gact *p = gact->parms;
+
+	printf("%s ", gact_act_name(p));
+}
+
+static void flower_print(struct tc_flower_attrs *flower, const char *kind)
+{
+	struct tc_act_attrs *a;
+	unsigned int i;
+
+	ksft_print_msg("%s:\n", kind);
+
+	if (flower->_present.key_vlan_id)
+		ksft_print_msg("  vlan_id: %u\n", flower->key_vlan_id);
+	if (flower->_present.key_vlan_prio)
+		ksft_print_msg("  vlan_prio: %u\n", flower->key_vlan_prio);
+	if (flower->_present.key_num_of_vlans)
+		ksft_print_msg("  num_of_vlans: %u\n",
+			       flower->key_num_of_vlans);
+
+	for (i = 0; i < flower->_count.act; i++) {
+		a = &flower->act[i];
+		ksft_print_msg("action order: %i %s ", i + 1, a->kind);
+		if (a->options._present.vlan)
+			print_vlan(&a->options.vlan);
+		else if (a->options._present.gact)
+			print_gact(&a->options.gact);
+		printf("\n");
+	}
+}
+
+static void tc_filter_print(struct __test_metadata *_metadata,
+			     struct tc_gettfilter_rsp *f)
+{
+	struct tc_options_msg *opt = &f->options;
+
+	if (opt->_present.flower) {
+		EXPECT_TRUE((bool)f->_len.kind);
+		flower_print(&opt->flower, f->kind);
+	} else if (f->_len.kind) {
+		ksft_print_msg("%s pref %u proto: %#x\n", f->kind,
+			       (f->_hdr.tcm_info >> 16),
+			       ntohs(TC_H_MIN(f->_hdr.tcm_info)));
+	}
+}
+
+static int tc_clsact_add(struct ynl_sock *ys, int ifi)
+{
+	struct tc_newqdisc_req *req;
+	int ret;
+
+	req = tc_newqdisc_req_alloc();
+	if (!req)
+		return -1;
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_CLSACT;
+	req->_hdr.tcm_handle = TC_HANDLE;
+	tc_newqdisc_req_set_nlflags(req,
+				    NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE);
+	tc_newqdisc_req_set_kind(req, "clsact");
+
+	ret = tc_newqdisc(ys, req);
+	tc_newqdisc_req_free(req);
+
+	return ret;
+}
+
+static int tc_clsact_del(struct ynl_sock *ys, int ifi)
+{
+	struct tc_delqdisc_req *req;
+	int ret;
+
+	req = tc_delqdisc_req_alloc();
+	if (!req)
+		return -1;
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_CLSACT;
+	req->_hdr.tcm_handle = TC_HANDLE;
+	tc_delqdisc_req_set_nlflags(req, NLM_F_REQUEST);
+
+	ret = tc_delqdisc(ys, req);
+	tc_delqdisc_req_free(req);
+
+	return ret;
+}
+
+static int tc_filter_add(struct ynl_sock *ys, int ifi)
+{
+	struct tc_newtfilter_req *req;
+	struct tc_act_attrs *acts;
+	struct tc_vlan p = {
+		.action = TC_ACT_PIPE,
+		.v_action = TCA_VLAN_ACT_PUSH
+	};
+	int ret;
+
+	req = tc_newtfilter_req_alloc();
+	if (!req)
+		return -1;
+	memset(req, 0, sizeof(*req));
+
+	acts = tc_act_attrs_alloc(3);
+	if (!acts) {
+		tc_newtfilter_req_free(req);
+		return -1;
+	}
+	memset(acts, 0, sizeof(*acts) * 3);
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
+	req->chain = 0;
+
+	tc_newtfilter_req_set_nlflags(req, NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE);
+	tc_newtfilter_req_set_kind(req, "flower");
+	tc_newtfilter_req_set_options_flower_key_vlan_id(req, 100);
+	tc_newtfilter_req_set_options_flower_key_vlan_prio(req, 5);
+	tc_newtfilter_req_set_options_flower_key_num_of_vlans(req, 3);
+
+	__tc_newtfilter_req_set_options_flower_act(req, acts, 3);
+
+	/* Skip action at index 0 because in TC, the action array
+	 * index starts at 1, with each index defining the action's
+	 * order. In contrast, in YNL indexed arrays start at index 0.
+	 */
+	tc_act_attrs_set_kind(&acts[1], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[1], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[1], 200);
+	tc_act_attrs_set_kind(&acts[2], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[2], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[2], 300);
+
+	tc_newtfilter_req_set_options_flower_flags(req, 0);
+	tc_newtfilter_req_set_options_flower_key_eth_type(req, htons(0x8100));
+
+	ret = tc_newtfilter(ys, req);
+	tc_newtfilter_req_free(req);
+
+	return ret;
+}
+
+static int tc_filter_del(struct ynl_sock *ys, int ifi)
+{
+	struct tc_deltfilter_req *req;
+	int ret;
+
+	req = tc_deltfilter_req_alloc();
+	if (!req)
+		return -1;
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
+	tc_deltfilter_req_set_nlflags(req, NLM_F_REQUEST);
+
+	ret = tc_deltfilter(ys, req);
+	tc_deltfilter_req_free(req);
+
+	return ret;
+}
+
+FIXTURE(tc)
+{
+	struct ynl_sock *ys;
+	int ifindex;
+};
+
+FIXTURE_SETUP(tc)
+{
+	struct ynl_error yerr;
+	int ret;
+
+	ret = unshare(CLONE_NEWNET);
+	ASSERT_EQ(0, ret);
+
+	self->ifindex = 1; /* loopback */
+
+	self->ys = ynl_sock_create(&ynl_tc_family, &yerr);
+	ASSERT_NE(NULL, self->ys) {
+		TH_LOG("failed to create tc socket: %s", yerr.msg);
+	}
+}
+
+FIXTURE_TEARDOWN(tc)
+{
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(tc, qdisc)
+{
+	struct tc_getqdisc_req_dump *dreq;
+	struct tc_newqdisc_req *add_req;
+	struct tc_delqdisc_req *del_req;
+	struct tc_getqdisc_list *rsp;
+	bool found = false;
+	int ret;
+
+	add_req = tc_newqdisc_req_alloc();
+	ASSERT_NE(NULL, add_req);
+	memset(add_req, 0, sizeof(*add_req));
+
+	add_req->_hdr.tcm_ifindex = self->ifindex;
+	add_req->_hdr.tcm_parent = TC_H_ROOT;
+	tc_newqdisc_req_set_nlflags(add_req,
+				    NLM_F_REQUEST | NLM_F_CREATE);
+	tc_newqdisc_req_set_kind(add_req, "fq_codel");
+
+	ret = tc_newqdisc(self->ys, add_req);
+	tc_newqdisc_req_free(add_req);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("qdisc add failed: %s", self->ys->err.msg);
+	}
+
+	dreq = tc_getqdisc_req_dump_alloc();
+	rsp = tc_getqdisc_dump(self->ys, dreq);
+	tc_getqdisc_req_dump_free(dreq);
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+	ASSERT_FALSE(ynl_dump_empty(rsp));
+
+	ynl_dump_foreach(rsp, qdisc) {
+		found |= tc_qdisc_print(_metadata, qdisc);
+	}
+	tc_getqdisc_list_free(rsp);
+	EXPECT_TRUE(found);
+
+	del_req = tc_delqdisc_req_alloc();
+	ASSERT_NE(NULL, del_req);
+	memset(del_req, 0, sizeof(*del_req));
+
+	del_req->_hdr.tcm_ifindex = self->ifindex;
+	del_req->_hdr.tcm_parent = TC_H_ROOT;
+	tc_delqdisc_req_set_nlflags(del_req, NLM_F_REQUEST);
+
+	ret = tc_delqdisc(self->ys, del_req);
+	tc_delqdisc_req_free(del_req);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("qdisc del failed: %s", self->ys->err.msg);
+	}
+}
+
+TEST_F(tc, flower)
+{
+	struct tc_gettfilter_req_dump *dreq;
+	struct tc_gettfilter_list *rsp;
+	bool found = false;
+	int ret;
+
+	ret = tc_clsact_add(self->ys, self->ifindex);
+	if (ret)
+		SKIP(return, "clsact not supported: %s", self->ys->err.msg);
+
+	ret = tc_filter_add(self->ys, self->ifindex);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("filter add failed: %s", self->ys->err.msg);
+	}
+
+	dreq = tc_gettfilter_req_dump_alloc();
+	memset(dreq, 0, sizeof(*dreq));
+	dreq->_hdr.tcm_ifindex = self->ifindex;
+	dreq->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	dreq->_present.chain = 1;
+	dreq->chain = 0;
+
+	rsp = tc_gettfilter_dump(self->ys, dreq);
+	tc_gettfilter_req_dump_free(dreq);
+	ASSERT_NE(NULL, rsp) {
+		TH_LOG("filter dump failed: %s", self->ys->err.msg);
+	}
+
+	ynl_dump_foreach(rsp, flt) {
+		tc_filter_print(_metadata, flt);
+		if (flt->options._present.flower) {
+			EXPECT_EQ(100, flt->options.flower.key_vlan_id);
+			EXPECT_EQ(5, flt->options.flower.key_vlan_prio);
+			found = true;
+		}
+	}
+	tc_gettfilter_list_free(rsp);
+	EXPECT_TRUE(found);
+
+	ret = tc_filter_del(self->ys, self->ifindex);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("filter del failed: %s", self->ys->err.msg);
+	}
+
+	ret = tc_clsact_del(self->ys, self->ifindex);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("clsact del failed: %s", self->ys->err.msg);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
index b4c58d86a6c2..75c0fe72391f 100644
--- a/tools/net/ynl/tests/config
+++ b/tools/net/ynl/tests/config
@@ -1,7 +1,13 @@
 CONFIG_DUMMY=m
 CONFIG_INET_DIAG=y
 CONFIG_IPV6=y
+CONFIG_NET_ACT_VLAN=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_SCH_FQ_CODEL=m
+CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_NS=y
+CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=m
 CONFIG_NETKIT=y
 CONFIG_OPENVSWITCH=m
-- 
2.53.0


