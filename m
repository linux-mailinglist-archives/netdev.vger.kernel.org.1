Return-Path: <netdev+bounces-143116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E89C134C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B30284707
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C249EBE;
	Fri,  8 Nov 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VeC+k7Uq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15E46B5
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027021; cv=none; b=IIfdY8TGpjRjIlyx3JGKlpazio12lMxvIb/xw1vjNl8yCotfUKjn45vP574MnP4sHASh/d4vGzFOnlBK1KME5yPIbDby+Qnt7XcOwJHiBUvOvm9sMd3egioXkow/7nYj11h6AgayQB8wruwVt3zD4+RGBAHwnvUqdKmG8o/gLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027021; c=relaxed/simple;
	bh=b9Ss0amDD5dbu+G9Ta3eQsJ6ZdK55BZEmmCg16lppuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d14ZW4BvxW/0cRQW+tl198LwCwOaPra4OnlXMqRSqKhetDji8L1G07TF4YrldH0plQEKLV2erkBO4sDrQVuvpYJg0RHooJ6d/ZX+vPYX1JYLFTAVkmXdzji2Rbvc1pZ5SXbzoWfLs/R+KTaAgU3TYpYhF86SgwAMyKjrH26xCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VeC+k7Uq; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027020; x=1762563020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBM/WicWZIV4hc78DSuZmiP7ITOQkkcXD1F3saaowk0=;
  b=VeC+k7UqALQzN3vJcqgqVN6XHuJBUAzfR+tOUV9Jw5/hn5M2y9XCOqU+
   LVtupMiIxcMjCUCVtdhUNADR1tvicaSFG2UrOyxvPAHt7PhadRvn8de4h
   A+j4XHgjPMQjfnrgUgaQXLLjY40UwkZ9BwPO7xgmWObubbR9yFYPerjry
   I=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="773777590"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:50:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:6764]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.42:2525] with esmtp (Farcaster)
 id ffe7cfe1-e981-4c85-b11d-b59b5b8030b9; Fri, 8 Nov 2024 00:50:11 +0000 (UTC)
X-Farcaster-Flow-ID: ffe7cfe1-e981-4c85-b11d-b59b5b8030b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:50:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:50:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 05/10] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Thu, 7 Nov 2024 16:48:18 -0800
Message-ID: <20241108004823.29419-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108004823.29419-1-kuniyu@amazon.com>
References: <20241108004823.29419-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
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
  3. Call rtnl_link_get_net_tb()

Let's add a new field peer_type to struct rtnl_link_ops and prefetch
netns in the peer ifla to add it to rtnl_nets in rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2:
  * Unexport rtnl_link_get_net_tb() and made it static
  * Change peer_type to u16
  * squash patch 2 & 3 (due to static requires a user)
---
 include/net/rtnetlink.h |  2 ++
 net/core/rtnetlink.c    | 55 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index ef7c11f0d74c..bef76abcff8d 100644
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
index 1879a46a9d7e..fe65dd6cde8d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2492,9 +2492,10 @@ int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
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
@@ -2502,8 +2503,17 @@ struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
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
@@ -3768,6 +3778,37 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
@@ -3896,12 +3937,18 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


