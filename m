Return-Path: <netdev+bounces-300056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ftGAZ1LMmofyQUAu9opvQ
	(envelope-from <netdev+bounces-300056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D5269726A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="KDdN4/41";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300056-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46403300600F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662533BB661;
	Wed, 17 Jun 2026 07:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38573BB670
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:24:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681046; cv=none; b=FeaThSOE6d78WWQTzfKb3A7h9mbR0xhDzV+Ga00w3TR57yogMFT9GJO7qtk4sFwUW5UR1eMn6nx0Z3ll50a2tGv001f7Hs/NWvHpP8jldAWh1MbW8EN2Vtb0SD873Eu4cxEOL7XzwILsnS/7kEDCUh+ojO6nfL2V10Tc8CFdW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681046; c=relaxed/simple;
	bh=vN7HkFzdiO9VzqsNqKseh8p1JebrF1lzD3SPIiY/XGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZQtXueEGddPdREs3dxAcZIk/HxT+or09KVbziRe1/DToVPcv8Z+HvYEqFYv9hxPdJr4XP/rsjkRu+68EEB+Jo0W+Obwu6ko/lOgRTMc6QOpAE4wje18MNRBoziBW6xm1dHdYOdiVPqtQ+vfRer/md8e8EQvzjb6AghlNh/RgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDdN4/41; arc=none smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec49f7e35eso713882666b.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681043; x=1782285843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjmUPDClbDkPs/Q/gGvLbyNfztYl4Gq0Pvfi7sSSo90=;
        b=KDdN4/41BO1EbQHgVku89ugCrEqfFll/5D+APzdWLMnLiaMC+AeYwiS54JNuMeHYVb
         oLzgZ2xSqg2ox4EGiKiWk3RiV8hpqg9dQKU+3ss0ai9NHrKqF6dD8qLhmGSxkdKU2Li5
         ic7ZRgkVbnvnNEgXVSaiIiy8sb8stRmJdu+uOjpuGmAG/dNB2I8VmgpwZ/vSpybZpXmk
         t8zRdjf3B+hwMJdDg8iIV7HgzQeKtlE81WHr5JqdvhADCiuWRVuUQy9R1NawH4ajBhzD
         xEPmzhVhGqtWD0bO+mdEY+D+t1UjNO2OfRk4MAGJvNXr/MaHxu/nhSwAOeEk5dWQwkgK
         ObGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681043; x=1782285843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjmUPDClbDkPs/Q/gGvLbyNfztYl4Gq0Pvfi7sSSo90=;
        b=XKYuKsnOMAOvStw1vFtXddqSPflDcM8scFPNcqKq+l7UcqFsKkRHLZevjNRNHrqdIz
         G3AD87qexzl9GM4cwu2IS4RuJdkNghj2MFlxPQaMINHAmKuU95/dc531EBH7FRFtIKHT
         XiXRLezFoJMZ8RZiiujmnM06Vp19Fuk9bZA9fimbUAvgEHWYfdc0jnjWbiZGKX9qEkS2
         /BKrgetJ+6zXoBALz7niqzIIXaklV6Ak21vRrQ4l/tfq9Dph0z58j176kdgbdJNUKyAB
         RuilGWIodaaKP2qCZ7pbP1MfTJngIgB58KVI/l9Luy+hl3mCuCRvHwbtTxdbhwVwNf/t
         ZQPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qw0OZyAgsx+8PULwSAMiR/N8lqggKNWMUngeDwpYMF/bs3URH7e9q8Tw6CfVVwt+IYp3O+ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrRqy34eTH3tSFvHwJ+6Nkmucx5kejkvHnOervh98FGggO/0K
	mjCfe7jVgbdV5JGKyGe30ke8slALO5b+kayivBZPI/g4g5IAe7fLQ9s=
X-Gm-Gg: Acq92OHJSdswTZ3pZEsFmCmIS3t19RZmrDEc6NYGA3Fc11cW9rMrMroB1byFScVX9OE
	qJ+XFY3btNcTMKFwFpbsjgqyCFRDXeokAhGjLFv7eV8hzkz7Cx7AmFhnsQNlmTEWrafUYVm+SAp
	Acv0QhVla3yhagk+Z8mId9qtkXmQhE0JsjWs1lQlAn5IY820hgOQX1eGUFdWRp2v6huFccFnAGC
	RhJpYNMT8rkXjGfkHpQ6j2mxs+ov8ETxY0vJXyP2YPunWX3HH0MGc9U0KdEmZX5b/EWAP6mfALp
	IgMZF6217dquS0DyLNBjKUbji9JM8OGxOqDt9xo68GYYBBKfWGdacQhjaIT+Ti1rzSq3OBRm/It
	4OXHxMX+bnM8BgULdsewZWlt8DfJP8/2UhcpDEE2LkgTASZL0m3cuugYA6IxtHAFfQA15RN2k1B
	tfgGNDBzASNOalJqg73mybsinopFN40xrRbg==
X-Received: by 2002:a17:906:eec1:b0:bed:6e53:bb25 with SMTP id a640c23a62f3a-c05a73b168amr174284966b.40.1781681041227;
        Wed, 17 Jun 2026 00:24:01 -0700 (PDT)
Received: from archlinux ([2.26.254.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb51007a9sm733539066b.21.2026.06.17.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:24:00 -0700 (PDT)
From: NeKon69 <nobodqwe@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	piotr.kwapulinski@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeKon69 <nobodqwe@gmail.com>
Subject: [PATCH net v2] ice: Fix use-after-scope in ice_sched_add_nodes_to_layer()
Date: Wed, 17 Jun 2026 10:21:55 +0300
Message-ID: <20260617072155.1172432-1-nobodqwe@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300056-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[nobodqwe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:piotr.kwapulinski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nobodqwe@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nobodqwe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04D5269726A

Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
changed ice_sched_add_nodes_to_layer() from recursive control flow to an
iterative loop.

Inside the loop, first_teid_ptr may be set to the address of a
block-local variable:

    u32 temp;
    ...
    if (num_added)
        first_teid_ptr = &temp;

On the next loop iteration, first_teid_ptr may be passed to
ice_sched_add_nodes_to_hw_layer(), after temp from the previous
iteration has gone out of scope.

Instead of keeping temporary storage for later calls, allow
first_node_teid to be NULL when the caller does not need the TEID.

This was found by Clang with LifetimeSafety enabled while testing C
language support on a Linux allmodconfig build.

Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
Link: https://github.com/llvm/llvm-project/pull/203270
Signed-off-by: NeKon69 <nobodqwe@gmail.com>
---
v2:
- Allow first_node_teid to be NULL when callers do not need the TEID.
- Pass NULL after the first TEID has already been returned instead of using
  temporary stack storage.
- Update kernel-doc for helpers accepting NULL.
- Link to v1: https://lore.kernel.org/netdev/20260613101440.80190-1-nobodqwe@gmail.com/
- Compile-tested with:
  make drivers/net/ethernet/intel/ice/ice_sched.o

 drivers/net/ethernet/intel/ice/ice_sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..89e191c839b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -895,7 +895,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
  * @layer: layer number to add nodes
  * @num_nodes: number of nodes
  * @num_nodes_added: pointer to num nodes added
- * @first_node_teid: if new nodes are added then return the TEID of first node
+ * @first_node_teid: if new nodes are added then return the TEID of first node,
+ *                   may be NULL
  * @prealloc_nodes: preallocated nodes struct for software DB
  *
  * This function add nodes to HW as well as to SW DB for a given layer
@@ -1000,7 +1001,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		if (!pi->sib_head[tc_node->tc_num][layer])
 			pi->sib_head[tc_node->tc_num][layer] = new_node;
 
-		if (i == 0)
+		if (first_node_teid && i == 0)
 			*first_node_teid = teid;
 	}
 
@@ -1015,7 +1016,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
  * @parent: pointer to parent node
  * @layer: layer number to add nodes
  * @num_nodes: number of nodes to be added
- * @first_node_teid: pointer to the first node TEID
+ * @first_node_teid: pointer to the first node TEID, may be NULL
  * @num_nodes_added: pointer to number of nodes added
  *
  * Add nodes into specific HW layer.
@@ -1078,7 +1079,6 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	*num_nodes_added = 0;
 	while (*num_nodes_added < num_nodes) {
 		u16 max_child_nodes, num_added = 0;
-		u32 temp;
 
 		status = ice_sched_add_nodes_to_hw_layer(pi, tc_node, parent,
 							 layer,	new_num_nodes,
@@ -1109,13 +1109,11 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 			 * try the next available sibling.
 			 */
 			parent = ice_sched_find_next_vsi_node(parent);
-			/* Don't modify the first node TEID memory if the
-			 * first node was added already in the above call.
-			 * Instead send some temp memory for all other
-			 * recursive calls.
+			/* Don't modify the first node TEID memory if the first node
+			 * was added already in the above call.
 			 */
 			if (num_added)
-				first_teid_ptr = &temp;
+				first_teid_ptr = NULL;
 
 			new_num_nodes = num_nodes - *num_nodes_added;
 		}
-- 
2.54.0

