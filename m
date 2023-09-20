Return-Path: <netdev+bounces-35161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3A7A7633
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5B1C20AAF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428A1172C;
	Wed, 20 Sep 2023 08:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CA11708
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:42:18 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144B93;
	Wed, 20 Sep 2023 01:42:17 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qismj-0004xM-2C; Wed, 20 Sep 2023 10:42:13 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kyle Zeng <zengyhkyle@gmail.com>
Subject: [PATCH net 3/3] netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP
Date: Wed, 20 Sep 2023 10:41:51 +0200
Message-ID: <20230920084156.4192-4-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920084156.4192-1-fw@strlen.de>
References: <20230920084156.4192-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jozsef Kadlecsik <kadlec@netfilter.org>

Kyle Zeng reported that there is a race between IPSET_CMD_ADD and IPSET_CMD_SWAP
in netfilter/ip_set, which can lead to the invocation of `__ip_set_put` on a
wrong `set`, triggering the `BUG_ON(set->ref == 0);` check in it.

The race is caused by using the wrong reference counter, i.e. the ref counter instead
of ref_netlink.

Fixes: 24e227896bbf ("netfilter: ipset: Add schedule point in call_ad().")
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/ZPZqetxOmH+w%2Fmyc@westworld/#r
Tested-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipset/ip_set_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index e564b5174261..35d2f9c9ada0 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -682,6 +682,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1693,11 +1701,11 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
-- 
2.41.0


