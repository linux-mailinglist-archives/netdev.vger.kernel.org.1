Return-Path: <netdev+bounces-38967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A57BD4C4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9615428147C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0A1173D;
	Mon,  9 Oct 2023 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="i1eGObU/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEA8C1A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:57:02 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B89AC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 00:56:57 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CBA4320231; Mon,  9 Oct 2023 15:56:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1696838213;
	bh=/bMSFW5Qvxm6IvOr+HZKkpM7MjiGUSUZqJlWc54qgAg=;
	h=From:To:Cc:Subject:Date;
	b=i1eGObU/b6HjJZVp9Hkpxi3UjNqLwsNFvOd/tzxQDqv0jIOW+/K+rmnd1AHDYIXLH
	 VoHOnNG+GHwGlGZu5O78hehsdzTyR3ImRN8F+n3Yw+z4ufSZtTQ7TgthIDczsjwK0R
	 ZyNh/QP8GDoi35udYsQOZqDBHoBk44ZRuQ6Catb3mX8mI0tAKNhoyZme0Rx4UgXVw0
	 Wgs7L0Ehz7sW32EJq1PEu7a33UTvfIANzaLZww8lc9Qctl1bJrVQytMr0MzMLC5v7h
	 FW9smWZHytPTNvMWV6l2p4bAzTZzwFa/dWrylVsON54aLqW3lM/T4MAlH63x6Tvffi
	 6ujobCRsa1tWg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] mctp: perform route lookups under a RCU read-side lock
Date: Mon,  9 Oct 2023 15:56:45 +0800
Message-Id: <29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Our current route lookups (mctp_route_lookup and mctp_route_lookup_null)
traverse the net's route list without the RCU read lock held. This means
the route lookup is subject to preemption, resulting in an potential
grace period expiry, and so an eventual kfree() while we still have the
route pointer.

Add the proper read-side critical section locks around the route
lookups, preventing premption and a possible parallel kfree.

The remaining net->mctp.routes accesses are already under a
rcu_read_lock, or protected by the RTNL for updates.

Based on an analysis from Sili Luo <rootlab@huawei.com>, where
introducing a delay in the route lookup could cause a UAF on
simultaneous sendmsg() and route deletion.

Reported-by: Sili Luo <rootlab@huawei.com>
Fixes: 889b7da23abf ("mctp: Add initial routing framework")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index f51a05ec7162..68be8f2b622d 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -737,6 +737,8 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	struct mctp_route *tmp, *rt = NULL;
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
 		/* TODO: add metrics */
 		if (mctp_rt_match_eid(tmp, dnet, daddr)) {
@@ -747,21 +749,29 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 		}
 	}
 
+	rcu_read_unlock();
+
 	return rt;
 }
 
 static struct mctp_route *mctp_route_lookup_null(struct net *net,
 						 struct net_device *dev)
 {
-	struct mctp_route *rt;
+	struct mctp_route *tmp, *rt = NULL;
 
-	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		if (rt->dev->dev == dev && rt->type == RTN_LOCAL &&
-		    refcount_inc_not_zero(&rt->refs))
-			return rt;
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
+		if (tmp->dev->dev == dev && tmp->type == RTN_LOCAL &&
+		    refcount_inc_not_zero(&tmp->refs)) {
+			rt = tmp;
+			break;
+		}
 	}
 
-	return NULL;
+	rcu_read_unlock();
+
+	return rt;
 }
 
 static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
-- 
2.39.2


