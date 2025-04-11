Return-Path: <netdev+bounces-181798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DDA867BC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA27AC44D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE428FFE7;
	Fri, 11 Apr 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ENmvLBjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD156280A32
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404969; cv=none; b=GDqCtGRtIJcREF67FOLt9vxAhhjldqG/wnzc6S1Ae8nivyPwSUeioXnP/BSlm3PjhfIHrVoNNsgVux42RXnDyMWWIKUnuTAG1XKgKrAbMVULFDyZgHlk2/cWCVyCFKjKR4+zwcu7noeduHFkRkxtACochvvpg05eglFf1zJfvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404969; c=relaxed/simple;
	bh=pwTrdHT14YVdoFAAfxHOk8ITqJo6oKXFqdjvVyWVklM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8RvCulxQI7F7hjUTgviw/j0lHOhMcNVKhugP0EBBTza7Wgy9kkU/hZB2T2ltQ4omnJcm1HpgNh2w+z+NWvVksscA5oSAT6y8UkNunUlIPfy1Omn02NUSIQYTNEZh+K8r0ODePzeJrPveWMGLrw9G6qroYA72HcpL97Mw7Nkk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ENmvLBjC; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404966; x=1775940966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o2FuUJvOyZMNIqV7L2oAy+Opyv/YH1KHE7r3MiKm42w=;
  b=ENmvLBjCYUW/BnnKX/2BApEz4xC/hZlBq/AZWosUmNA+11YZ1RCJvDw2
   +qmqQgmApOdTNoFWAoSxkpD7jXRW+n2ms2Hre6lDwBabvhNu01+FO8uA5
   xYGk54tQWpUlIvd6grJfEa+0+Ho8dNRJDPzFxZ8Dkfiw0xllNsSt3qQa/
   M=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="9723499"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:56:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:37002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 400039b6-97cd-4ec6-a2fc-f4ba74869dcf; Fri, 11 Apr 2025 20:56:05 +0000 (UTC)
X-Farcaster-Flow-ID: 400039b6-97cd-4ec6-a2fc-f4ba74869dcf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:56:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:55:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 net-next 07/14] ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:36 -0700
Message-ID: <20250411205258.63164-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following functions iterates the dying netns list and performs
the same operations for each netns.

  * ip6gre_exit_batch_rtnl()
  * ip6_tnl_exit_batch_rtnl()
  * vti6_exit_batch_rtnl()
  * sit_exit_batch_rtnl()

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/ipv6/ip6_gre.c    | 22 ++++++----------------
 net/ipv6/ip6_tunnel.c | 24 ++++++++----------------
 net/ipv6/ip6_vti.c    | 27 +++++++--------------------
 net/ipv6/sit.c        | 23 ++++++-----------------
 4 files changed, 27 insertions(+), 69 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 957ca98fa70f..2dc9dcffe2ca 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1570,7 +1570,7 @@ static struct inet6_protocol ip6gre_protocol __read_mostly = {
 	.flags       = INET6_PROTO_FINAL,
 };
 
-static void ip6gre_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit ip6gre_exit_rtnl_net(struct net *net, struct list_head *head)
 {
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	struct net_device *dev, *aux;
@@ -1587,16 +1587,16 @@ static void ip6gre_destroy_tunnels(struct net *net, struct list_head *head)
 		for (h = 0; h < IP6_GRE_HASH_SIZE; h++) {
 			struct ip6_tnl *t;
 
-			t = rtnl_dereference(ign->tunnels[prio][h]);
+			t = rtnl_net_dereference(net, ign->tunnels[prio][h]);
 
 			while (t) {
 				/* If dev is in the same netns, it has already
 				 * been added to the list by the previous loop.
 				 */
 				if (!net_eq(dev_net(t->dev), net))
-					unregister_netdevice_queue(t->dev,
-								   head);
-				t = rtnl_dereference(t->next);
+					unregister_netdevice_queue(t->dev, head);
+
+				t = rtnl_net_dereference(net, t->next);
 			}
 		}
 	}
@@ -1640,19 +1640,9 @@ static int __net_init ip6gre_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6gre_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
-{
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		ip6gre_destroy_tunnels(net, dev_to_kill);
-}
-
 static struct pernet_operations ip6gre_net_ops = {
 	.init = ip6gre_init_net,
-	.exit_batch_rtnl = ip6gre_exit_batch_rtnl,
+	.exit_rtnl = ip6gre_exit_rtnl_net,
 	.id   = &ip6gre_net_id,
 	.size = sizeof(struct ip6gre_net),
 };
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a04dd1bb4b19..894d3158a6f0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2210,7 +2210,7 @@ static struct xfrm6_tunnel mplsip6_handler __read_mostly = {
 	.priority	=	1,
 };
 
-static void __net_exit ip6_tnl_destroy_tunnels(struct net *net, struct list_head *list)
+static void __net_exit ip6_tnl_exit_rtnl_net(struct net *net, struct list_head *list)
 {
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct net_device *dev, *aux;
@@ -2222,25 +2222,27 @@ static void __net_exit ip6_tnl_destroy_tunnels(struct net *net, struct list_head
 			unregister_netdevice_queue(dev, list);
 
 	for (h = 0; h < IP6_TUNNEL_HASH_SIZE; h++) {
-		t = rtnl_dereference(ip6n->tnls_r_l[h]);
+		t = rtnl_net_dereference(net, ip6n->tnls_r_l[h]);
 		while (t) {
 			/* If dev is in the same netns, it has already
 			 * been added to the list by the previous loop.
 			 */
 			if (!net_eq(dev_net(t->dev), net))
 				unregister_netdevice_queue(t->dev, list);
-			t = rtnl_dereference(t->next);
+
+			t = rtnl_net_dereference(net, t->next);
 		}
 	}
 
-	t = rtnl_dereference(ip6n->tnls_wc[0]);
+	t = rtnl_net_dereference(net, ip6n->tnls_wc[0]);
 	while (t) {
 		/* If dev is in the same netns, it has already
 		 * been added to the list by the previous loop.
 		 */
 		if (!net_eq(dev_net(t->dev), net))
 			unregister_netdevice_queue(t->dev, list);
-		t = rtnl_dereference(t->next);
+
+		t = rtnl_net_dereference(net, t->next);
 	}
 }
 
@@ -2287,19 +2289,9 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6_tnl_exit_batch_rtnl(struct list_head *net_list,
-					       struct list_head *dev_to_kill)
-{
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		ip6_tnl_destroy_tunnels(net, dev_to_kill);
-}
-
 static struct pernet_operations ip6_tnl_net_ops = {
 	.init = ip6_tnl_init_net,
-	.exit_batch_rtnl = ip6_tnl_exit_batch_rtnl,
+	.exit_rtnl = ip6_tnl_exit_rtnl_net,
 	.id   = &ip6_tnl_net_id,
 	.size = sizeof(struct ip6_tnl_net),
 };
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 09ec4b0ad7dc..40464a88bca6 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1112,21 +1112,21 @@ static struct rtnl_link_ops vti6_link_ops __read_mostly = {
 	.get_link_net	= ip6_tnl_get_link_net,
 };
 
-static void __net_exit vti6_destroy_tunnels(struct vti6_net *ip6n,
-					    struct list_head *list)
+static void __net_exit vti6_exit_rtnl_net(struct net *net, struct list_head *list)
 {
-	int h;
+	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 	struct ip6_tnl *t;
+	int h;
 
 	for (h = 0; h < IP6_VTI_HASH_SIZE; h++) {
-		t = rtnl_dereference(ip6n->tnls_r_l[h]);
+		t = rtnl_net_dereference(net, ip6n->tnls_r_l[h]);
 		while (t) {
 			unregister_netdevice_queue(t->dev, list);
-			t = rtnl_dereference(t->next);
+			t = rtnl_net_dereference(net, t->next);
 		}
 	}
 
-	t = rtnl_dereference(ip6n->tnls_wc[0]);
+	t = rtnl_net_dereference(net, ip6n->tnls_wc[0]);
 	if (t)
 		unregister_netdevice_queue(t->dev, list);
 }
@@ -1170,22 +1170,9 @@ static int __net_init vti6_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit vti6_exit_batch_rtnl(struct list_head *net_list,
-					    struct list_head *dev_to_kill)
-{
-	struct vti6_net *ip6n;
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list) {
-		ip6n = net_generic(net, vti6_net_id);
-		vti6_destroy_tunnels(ip6n, dev_to_kill);
-	}
-}
-
 static struct pernet_operations vti6_net_ops = {
 	.init = vti6_init_net,
-	.exit_batch_rtnl = vti6_exit_batch_rtnl,
+	.exit_rtnl = vti6_exit_rtnl_net,
 	.id   = &vti6_net_id,
 	.size = sizeof(struct vti6_net),
 };
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 9a0f32acb750..a72dbca9e8fc 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1804,8 +1804,7 @@ static struct xfrm_tunnel mplsip_handler __read_mostly = {
 };
 #endif
 
-static void __net_exit sit_destroy_tunnels(struct net *net,
-					   struct list_head *head)
+static void __net_exit sit_exit_rtnl_net(struct net *net, struct list_head *head)
 {
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 	struct net_device *dev, *aux;
@@ -1820,15 +1819,15 @@ static void __net_exit sit_destroy_tunnels(struct net *net,
 		for (h = 0; h < (prio ? IP6_SIT_HASH_SIZE : 1); h++) {
 			struct ip_tunnel *t;
 
-			t = rtnl_dereference(sitn->tunnels[prio][h]);
+			t = rtnl_net_dereference(net, sitn->tunnels[prio][h]);
 			while (t) {
 				/* If dev is in the same netns, it has already
 				 * been added to the list by the previous loop.
 				 */
 				if (!net_eq(dev_net(t->dev), net))
-					unregister_netdevice_queue(t->dev,
-								   head);
-				t = rtnl_dereference(t->next);
+					unregister_netdevice_queue(t->dev, head);
+
+				t = rtnl_net_dereference(net, t->next);
 			}
 		}
 	}
@@ -1881,19 +1880,9 @@ static int __net_init sit_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit sit_exit_batch_rtnl(struct list_head *net_list,
-					   struct list_head *dev_to_kill)
-{
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		sit_destroy_tunnels(net, dev_to_kill);
-}
-
 static struct pernet_operations sit_net_ops = {
 	.init = sit_init_net,
-	.exit_batch_rtnl = sit_exit_batch_rtnl,
+	.exit_rtnl = sit_exit_rtnl_net,
 	.id   = &sit_net_id,
 	.size = sizeof(struct sit_net),
 };
-- 
2.49.0


