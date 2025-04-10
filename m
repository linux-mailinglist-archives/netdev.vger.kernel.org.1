Return-Path: <netdev+bounces-181024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657AA83677
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40AC4A2049
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507F1C863A;
	Thu, 10 Apr 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tcZ5lNAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CB1C878E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251792; cv=none; b=FAzE3QCcoo58gPIX+GEt6QfmSsgNnUv3z4NaqqjvsqUWCJptFfQolycJzRhEK9HdVF7CfZNQhBEXnl6mSugG9e+z4Xrq98eRrTS2vAkdtNFSWss3p1iJZMRFvHOSC1jbg1vkXHZwp/YHmDzdQRqjZILAJGFOkEv7mGZKt7mMezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251792; c=relaxed/simple;
	bh=T7iI1odWfchGdSKzszJV3RrSxmvGhEKWjLn/ReBxKMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWMQ1YysoiIB/wGWBswxqx+ZTWHIrhnNvcu1pcKjBqC/ePr2Yok2iPlQmoDJ1yFBOwyzuN5VzLvkpyd6O8NkCFtSO2RGlbRUr1fO3BfxSJSoofBNhJyiXsg7hqhKV4rVtxbUkiYHA6rWU/8VcvkZ1ukIKq5ftvI3LI3sY0gdtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tcZ5lNAh; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251790; x=1775787790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qFeBmVUG+XBjbIBPdKnaiWGHh/r2itfNreZTs2W20Dc=;
  b=tcZ5lNAhI4b+Z9H4dSW4qcUJyFT0Q9hH0ryOKb0TPnEJDeE0Z3miFD2R
   epH9Xvqkk0rqCi1PTjjnXjH+kPNDzeiaLpuosK5QKWsxovyquQR1xdMLB
   1DIX0uIdJfCgOtk0UJEH7t5DMOnReoIsDP7FqqNyGAMD6WU1G/M+Ob31m
   k=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="189833980"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:23:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:59417]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 17cd7802-403d-4655-9268-66cf25296eb5; Thu, 10 Apr 2025 02:23:10 +0000 (UTC)
X-Farcaster-Flow-ID: 17cd7802-403d-4655-9268-66cf25296eb5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v1 net-next 07/14] ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:28 -0700
Message-ID: <20250410022004.8668-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410022004.8668-1-kuniyu@amazon.com>
References: <20250410022004.8668-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following functions iterates the dying netns list and performs
the same operations for each netns.

  * ip6gre_exit_batch_rtnl()
  * ip6_tnl_exit_batch_rtnl()
  * vti6_exit_batch_rtnl()
  * sit_exit_batch_rtnl()

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: David Ahern <dsahern@kernel.org>
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


