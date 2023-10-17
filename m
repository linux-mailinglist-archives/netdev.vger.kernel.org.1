Return-Path: <netdev+bounces-41760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31E7CBDD9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FFB2121D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D93B29E;
	Tue, 17 Oct 2023 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435C3D392
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:37:33 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A9F2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:37:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 58B782084B;
	Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAyRnNgFs4Me; Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AE80B207B3;
	Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id AAB5380004A;
	Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:37:27 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 17 Oct
 2023 10:37:26 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 694F8318083D; Tue, 17 Oct 2023 10:37:26 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/7] net: xfrm: skip policies marked as dead while reinserting policies
Date: Tue, 17 Oct 2023 10:37:17 +0200
Message-ID: <20231017083723.1364940-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017083723.1364940-1-steffen.klassert@secunet.com>
References: <20231017083723.1364940-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dong Chenchen <dongchenchen2@huawei.com>

BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
Read of size 1 at addr ffff8881051f3bf8 by task ip/668

CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x72/0xa0
 print_report+0xd0/0x620
 kasan_report+0xb6/0xf0
 xfrm_policy_inexact_list_reinsert+0xb6/0x430
 xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
 xfrm_policy_inexact_alloc_chain+0x23f/0x320
 xfrm_policy_inexact_insert+0x6b/0x590
 xfrm_policy_insert+0x3b1/0x480
 xfrm_add_policy+0x23c/0x3c0
 xfrm_user_rcv_msg+0x2d0/0x510
 netlink_rcv_skb+0x10d/0x2d0
 xfrm_netlink_rcv+0x49/0x60
 netlink_unicast+0x3fe/0x540
 netlink_sendmsg+0x528/0x970
 sock_sendmsg+0x14a/0x160
 ____sys_sendmsg+0x4fc/0x580
 ___sys_sendmsg+0xef/0x160
 __sys_sendmsg+0xf7/0x1b0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x73/0xdd

The root cause is:

cpu 0			cpu1
xfrm_dump_policy
xfrm_policy_walk
list_move_tail
			xfrm_add_policy
			... ...
			xfrm_policy_inexact_list_reinsert
			list_for_each_entry_reverse
				if (!policy->bydst_reinsert)
				//read non-existent policy
xfrm_dump_policy_done
xfrm_policy_walk_done
list_del(&walk->walk.all);

If dump_one_policy() returns err (triggered by netlink socket),
xfrm_policy_walk() will move walk initialized by socket to list
net->xfrm.policy_all. so this socket becomes visible in the global
policy list. The head *walk can be traversed when users add policies
with different prefixlen and trigger xfrm_policy node merge.

The issue can also be triggered by policy list traversal while rehashing
and flushing policies.

It can be fixed by skip such "policies" with walk.dead set to 1.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d6b405782b63..113fb7e9cdaf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -851,7 +851,7 @@ static void xfrm_policy_inexact_list_reinsert(struct net *net,
 		struct hlist_node *newpos = NULL;
 		bool matches_s, matches_d;
 
-		if (!policy->bydst_reinsert)
+		if (policy->walk.dead || !policy->bydst_reinsert)
 			continue;
 
 		WARN_ON_ONCE(policy->family != family);
@@ -1256,8 +1256,11 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		struct xfrm_pol_inexact_bin *bin;
 		u8 dbits, sbits;
 
+		if (policy->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(policy->index);
-		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
+		if (dir >= XFRM_POLICY_MAX)
 			continue;
 
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
@@ -1823,9 +1826,11 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->type != type)
 			continue;
 
@@ -1862,9 +1867,11 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->xdo.dev != dev)
 			continue;
 
-- 
2.34.1


