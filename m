Return-Path: <netdev+bounces-181797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E3A867B9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605628C6631
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943EB28F941;
	Fri, 11 Apr 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HRerO6/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8392347C7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404947; cv=none; b=GV7+w3rnK9ur/h3Aua7B6H5WTPUpJDtTL9++oChu8m/7oluwG8u8vyMdOEmihuFvFvnYXQGisvM0rr51jNHym0Vxex8HXyYgp8MKvkskZ8aEQXNeWB9pwx+McyC6jP2TdUxRtK8PSO5eBldZ4wHE4VL7F0Nac1l+/l01cgOSmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404947; c=relaxed/simple;
	bh=KLN3wjtwPe3Wkq4Q6i3AdU/Av1RJFgnjXMGMO5Y5O80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2F214xSvo8s4OjEzUqTvvQZsom1qyatzRK0eysiOpzNlO6y43O5NomUgmSxSf+dhwLEr9cyEIiHTn6wYE3NNcNY5RUKf56MU6gLWyXcMxvtTyZFT8XktCv6AmJ1oKPJCmWVcIlJ1NkQ6im9snRW0ih+F9wzvFOy1QhnppPPnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HRerO6/S; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404945; x=1775940945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p14F1jkEh3NeWfmiRfM+ooIUYN2BcLksJPUtGszQ/0U=;
  b=HRerO6/S/3z0/k415DN/PtKP0Y8l08VD/NZMPBMax4RFI/tmsEPotc9P
   N4aiRSYKn2HyYcFVeiB4S6QwhfqjRz7Mr8VuwHPK2NNni3iTkw60KaxV2
   Qv02TbFdJfuPX1MhdHYYQ2x2JJCWEVVPbVQgIspMQCRvytIZRIN9ZXcZQ
   g=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="9723362"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:55:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:36180]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 730c2e1b-7f1f-4f20-8c5a-aab17bdd5eb6; Fri, 11 Apr 2025 20:55:38 +0000 (UTC)
X-Farcaster-Flow-ID: 730c2e1b-7f1f-4f20-8c5a-aab17bdd5eb6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:55:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:55:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 net-next 06/14] ipv4: ip_tunnel: Convert ip_tunnel_delete_nets() callers to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:35 -0700
Message-ID: <20250411205258.63164-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip_tunnel_delete_nets() iterates the dying netns list and performs the
same operations for each.

Let's export ip_tunnel_destroy() as ip_tunnel_delete_net() and call it
from ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/net/ip_tunnels.h |  7 +++----
 net/ipv4/ip_gre.c        | 27 ++++++++++++---------------
 net/ipv4/ip_tunnel.c     | 25 +++++++------------------
 net/ipv4/ip_vti.c        |  9 ++++-----
 net/ipv4/ipip.c          |  9 ++++-----
 5 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index a36a335cef9f..0c3d571a04a1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -377,10 +377,9 @@ struct net *ip_tunnel_get_link_net(const struct net_device *dev);
 int ip_tunnel_get_iflink(const struct net_device *dev);
 int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 		       struct rtnl_link_ops *ops, char *devname);
-
-void ip_tunnel_delete_nets(struct list_head *list_net, unsigned int id,
-			   struct rtnl_link_ops *ops,
-			   struct list_head *dev_to_kill);
+void ip_tunnel_delete_net(struct net *net, unsigned int id,
+			  struct rtnl_link_ops *ops,
+			  struct list_head *dev_to_kill);
 
 void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		    const struct iphdr *tnl_params, const u8 protocol);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 26d15f907551..f5b9004d6938 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1066,16 +1066,15 @@ static int __net_init ipgre_init_net(struct net *net)
 	return ip_tunnel_init_net(net, ipgre_net_id, &ipgre_link_ops, NULL);
 }
 
-static void __net_exit ipgre_exit_batch_rtnl(struct list_head *list_net,
-					     struct list_head *dev_to_kill)
+static void __net_exit ipgre_exit_rtnl(struct net *net,
+				       struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, ipgre_net_id, &ipgre_link_ops,
-			      dev_to_kill);
+	ip_tunnel_delete_net(net, ipgre_net_id, &ipgre_link_ops, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_net_ops = {
 	.init = ipgre_init_net,
-	.exit_batch_rtnl = ipgre_exit_batch_rtnl,
+	.exit_rtnl = ipgre_exit_rtnl,
 	.id   = &ipgre_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
@@ -1752,16 +1751,15 @@ static int __net_init ipgre_tap_init_net(struct net *net)
 	return ip_tunnel_init_net(net, gre_tap_net_id, &ipgre_tap_ops, "gretap0");
 }
 
-static void __net_exit ipgre_tap_exit_batch_rtnl(struct list_head *list_net,
-						 struct list_head *dev_to_kill)
+static void __net_exit ipgre_tap_exit_rtnl(struct net *net,
+					   struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, gre_tap_net_id, &ipgre_tap_ops,
-			      dev_to_kill);
+	ip_tunnel_delete_net(net, gre_tap_net_id, &ipgre_tap_ops, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_tap_net_ops = {
 	.init = ipgre_tap_init_net,
-	.exit_batch_rtnl = ipgre_tap_exit_batch_rtnl,
+	.exit_rtnl = ipgre_tap_exit_rtnl,
 	.id   = &gre_tap_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
@@ -1772,16 +1770,15 @@ static int __net_init erspan_init_net(struct net *net)
 				  &erspan_link_ops, "erspan0");
 }
 
-static void __net_exit erspan_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
+static void __net_exit erspan_exit_rtnl(struct net *net,
+					struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(net_list, erspan_net_id, &erspan_link_ops,
-			      dev_to_kill);
+	ip_tunnel_delete_net(net, erspan_net_id, &erspan_link_ops, dev_to_kill);
 }
 
 static struct pernet_operations erspan_net_ops = {
 	.init = erspan_init_net,
-	.exit_batch_rtnl = erspan_exit_batch_rtnl,
+	.exit_rtnl = erspan_exit_rtnl,
 	.id   = &erspan_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 1024f961ec9a..3913ec89ad20 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1174,13 +1174,16 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init_net);
 
-static void ip_tunnel_destroy(struct net *net, struct ip_tunnel_net *itn,
-			      struct list_head *head,
-			      struct rtnl_link_ops *ops)
+void ip_tunnel_delete_net(struct net *net, unsigned int id,
+			  struct rtnl_link_ops *ops,
+			  struct list_head *head)
 {
+	struct ip_tunnel_net *itn = net_generic(net, id);
 	struct net_device *dev, *aux;
 	int h;
 
+	ASSERT_RTNL_NET(net);
+
 	for_each_netdev_safe(net, dev, aux)
 		if (dev->rtnl_link_ops == ops)
 			unregister_netdevice_queue(dev, head);
@@ -1198,21 +1201,7 @@ static void ip_tunnel_destroy(struct net *net, struct ip_tunnel_net *itn,
 				unregister_netdevice_queue(t->dev, head);
 	}
 }
-
-void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
-			   struct rtnl_link_ops *ops,
-			   struct list_head *dev_to_kill)
-{
-	struct ip_tunnel_net *itn;
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list) {
-		itn = net_generic(net, id);
-		ip_tunnel_destroy(net, itn, dev_to_kill, ops);
-	}
-}
-EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
+EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
 
 int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 159b4473290e..686e4f3d83aa 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -523,16 +523,15 @@ static int __net_init vti_init_net(struct net *net)
 	return 0;
 }
 
-static void __net_exit vti_exit_batch_rtnl(struct list_head *list_net,
-					   struct list_head *dev_to_kill)
+static void __net_exit vti_exit_rtnl(struct net *net,
+				     struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, vti_net_id, &vti_link_ops,
-			      dev_to_kill);
+	ip_tunnel_delete_net(net, vti_net_id, &vti_link_ops, dev_to_kill);
 }
 
 static struct pernet_operations vti_net_ops = {
 	.init = vti_init_net,
-	.exit_batch_rtnl = vti_exit_batch_rtnl,
+	.exit_rtnl = vti_exit_rtnl,
 	.id   = &vti_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index bab0bf90c908..3e03af073a1c 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -604,16 +604,15 @@ static int __net_init ipip_init_net(struct net *net)
 	return ip_tunnel_init_net(net, ipip_net_id, &ipip_link_ops, "tunl0");
 }
 
-static void __net_exit ipip_exit_batch_rtnl(struct list_head *list_net,
-					    struct list_head *dev_to_kill)
+static void __net_exit ipip_exit_rtnl(struct net *net,
+				      struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, ipip_net_id, &ipip_link_ops,
-			      dev_to_kill);
+	ip_tunnel_delete_net(net, ipip_net_id, &ipip_link_ops, dev_to_kill);
 }
 
 static struct pernet_operations ipip_net_ops = {
 	.init = ipip_init_net,
-	.exit_batch_rtnl = ipip_exit_batch_rtnl,
+	.exit_rtnl = ipip_exit_rtnl,
 	.id   = &ipip_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
-- 
2.49.0


