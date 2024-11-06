Return-Path: <netdev+bounces-142207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EE89BDD02
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9284D1F24598
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B71190696;
	Wed,  6 Nov 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YlETjuzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB85190674
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859922; cv=none; b=MzR3zOfJFbhC60gMW/MIUPW+ydZYuf21q5OqRfiT5YFP52jFtrMhfn1Dhe590FXVrUfPUQs+hvvhfHlIPUQHHanyCd793bZmC2AihNX8f91/Vg2YHCwIe0LXfn2S2whXIbqjbsW0ORZKasEQfB+98arhD8AFOZOgkMXMzIPly9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859922; c=relaxed/simple;
	bh=ksoxMNVDflTxlKumsW2IkSw97AGjjwBCJ7fBEwgx65k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4TUG6Myo+rCEvlXS1hXI3EMq8BDWgEp1/gJ5vye4nxrPuYvcnKQvPP+Cm2Wq53yBbk0iIGyTOtukVlX0chfkx5ku6X28vP5C8L4AL5ifVw1nle8mywSdIL5jXZ1aWDOG85Jktq7+hQOlNv8TbGdynQImO6Ay0Ld5rsXojZmQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YlETjuzl; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859921; x=1762395921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkqMv0qPtPKxgNm0B1nTnyyVBOUwTDqCLur7PMRDGgk=;
  b=YlETjuzlnYKrRHuwx0BYX6DnHmzRzaSo4lc6krREUTugBNE9E5uuldTU
   SxDfp6c1duyTYlrHwTx4Wa7AiTSkkXFNQUMEgSMA3CtliBBIgD4IxRo9M
   w/6dpy6bDwEXb8G6oPKnwQ+QTyStaTOthPUI24NCIyOpo2qhJyAnn+te6
   U=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="349723784"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:25:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:32263]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id f910f9fb-91e7-4bf4-9867-29356e236919; Wed, 6 Nov 2024 02:25:19 +0000 (UTC)
X-Farcaster-Flow-ID: f910f9fb-91e7-4bf4-9867-29356e236919
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:25:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:25:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/7] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Tue, 5 Nov 2024 18:24:27 -0800
Message-ID: <20241106022432.13065-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106022432.13065-1-kuniyu@amazon.com>
References: <20241106022432.13065-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In ops->newlink(), veth, vxcan, and netkit call rtnl_link_get_net() with
a net pointer, which is the first argument of ->newlink().

rtnl_link_get_net() could return another netns based on IFLA_NET_NS_PID
and IFLA_NET_NS_FD in the peer device's attributes.

We want to get it and fill rtnl_nets->nets[] in advance in rtnl_newlink()
for per-netns RTNL.

All of the three get the peer netns in the same way:

  1. Call rtnl_nla_parse_ifinfomsg()
  2. Call ops->validate() (vxcan doesn't have)
  3. Call rtnl_link_get_net()

Let's add a new field peer_type to struct rtnl_link_ops and prefetch
netns in the peer ifla to add it to rtnl_nets in rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v2:
  * Rename the helper to rtnl_link_get_net_ifla()
  * Unexport rtnl_link_get_net_ifla() and made it static
  * Change peer_type to u16
  * squash patch 2 & 3 (due to static requires a user)
---
 include/net/rtnetlink.h |  2 ++
 net/core/rtnetlink.c    | 55 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b260c0cc9671..f17208323c08 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -75,6 +75,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
+ *	@peer_type: Peer device specific netlink attribute number (e.g. VETH_INFO_PEER)
  *	@maxtype: Highest device specific netlink attribute number
  *	@policy: Netlink policy for device specific attribute validation
  *	@validate: Optional validation function for netlink/changelink parameters
@@ -116,6 +117,7 @@ struct rtnl_link_ops {
 	void			(*setup)(struct net_device *dev);
 
 	bool			netns_refund;
+	const u16		peer_type;
 	unsigned int		maxtype;
 	const struct nla_policy	*policy;
 	int			(*validate)(struct nlattr *tb[],
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 81f4722c1353..d5557a621099 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2518,9 +2518,10 @@ int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 }
 EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
-struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
+static struct net *rtnl_link_get_net_ifla(struct nlattr *tb[])
 {
-	struct net *net;
+	struct net *net = NULL;
+
 	/* Examine the link attributes and figure out which
 	 * network namespace we are talking about.
 	 */
@@ -2528,8 +2529,17 @@ struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
 	else if (tb[IFLA_NET_NS_FD])
 		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
-	else
+
+	return net;
+}
+
+struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
+{
+	struct net *net = rtnl_link_get_net_ifla(tb);
+
+	if (!net)
 		net = get_net(src_net);
+
 	return net;
 }
 EXPORT_SYMBOL(rtnl_link_get_net);
@@ -3794,6 +3804,37 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
+static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
+			     const struct rtnl_link_ops *ops,
+			     struct nlattr *data[],
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[IFLA_MAX + 1];
+	struct net *net;
+	int err;
+
+	if (!data || !data[ops->peer_type])
+		return 0;
+
+	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
+	if (err < 0)
+		return err;
+
+	if (ops->validate) {
+		err = ops->validate(tb, NULL, extack);
+		if (err < 0)
+			return err;
+	}
+
+	net = rtnl_link_get_net_ifla(tb);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+	if (net)
+		rtnl_nets_add(rtnl_nets, net);
+
+	return 0;
+}
+
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
 			  struct net *tgt_net, struct net *link_net,
@@ -3922,12 +3963,18 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			if (ret < 0)
 				goto put_ops;
 		}
+
+		if (ops->peer_type) {
+			ret = rtnl_add_peer_net(&rtnl_nets, ops, data, extack);
+			if (ret < 0)
+				goto put_ops;
+		}
 	}
 
 	tgt_net = rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb, CAP_NET_ADMIN);
 	if (IS_ERR(tgt_net)) {
 		ret = PTR_ERR(tgt_net);
-		goto put_ops;
+		goto put_net;
 	}
 
 	rtnl_nets_add(&rtnl_nets, tgt_net);
-- 
2.39.5 (Apple Git-154)


