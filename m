Return-Path: <netdev+bounces-141751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B79BC2E6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD046280DA6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B52943F;
	Tue,  5 Nov 2024 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LgfH2XfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006D22F1C
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772385; cv=none; b=R+i1Neey1qzjL9p4z1uiDm9lWiuH3kqurdlMlVBOuYmJiKL5AHevygN77AbjdKaW+eMUrG54DGpzU4VaxtzicBJiKKVrjYB/6xBw1jo+KmhQ+W3q3qjRgVnllu3hcWRX6OaB8VTVo1OmRh52BHkvdz3byfX4OjbESJocckQcEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772385; c=relaxed/simple;
	bh=O3H9MJ0j+aN4Y4VjzlmrZhkR7WpT+LsBwJEbafgpgJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGLjdQP6bvbZIvf1nNVxUgfYuIQuSjX+Be5fAXM2X39yWkhqRiB8t4Byy+2ggKJyv389jGMRJeXvRXPzlJfYHAKnl+Obf1M0kXJCtE/Nhu6X1rKQwlbLst6MD1HOe8u9TbIRr3afnY5Skxvt+J0v1fqV0ZJCLG+5HpCKnZN95xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LgfH2XfV; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772383; x=1762308383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDzh8KSy9wbffeB3Kl5kUfrodYVgFD0qOuGxG3LVYe4=;
  b=LgfH2XfVS58y49Jr1v7B7UrX5aFdH7N+WvpsKDbNVEVpUXB8yCfubqa5
   oTEyja9c5ERj0GcDekwFArJlc2HpWF4kuDw1SjJnG5Zur9RKG75h1/R+O
   GeHDEjuDLRhKg3eZQImBcOWmRSKdT8/AK9DUS5OtA9zpgTxLehokbyxny
   U=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="144416308"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:06:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:1660]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.170:2525] with esmtp (Farcaster)
 id e3d22a3b-1e40-4293-a400-41d672caab60; Tue, 5 Nov 2024 02:06:21 +0000 (UTC)
X-Farcaster-Flow-ID: e3d22a3b-1e40-4293-a400-41d672caab60
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:06:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:06:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Mon, 4 Nov 2024 18:05:09 -0800
Message-ID: <20241105020514.41963-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105020514.41963-1-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For veth, vxcan, and netkit, we need to prefetch the peer device's
netns in rtnl_newlink() for per-netns RTNL.

All of the three get the netns in the same way peer netlink attr tb:

  1. Call rtnl_nla_parse_ifinfomsg()
  2. Call ops->validate() (vxcan doesn't have)
  3. Call rtnl_link_get_net_tb()

Let's add a new field peer_type to struct rtnl_link_ops and fetch
netns in peer attrbutes to add it to rtnl_nets in rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h |  2 ++
 net/core/rtnetlink.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b9ed44b2d056..c3548da95ffa 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -85,6 +85,7 @@ void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net);
  *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
+ *	@peer_type: Peer device specific netlink attribute number (e.g. VETH_INFO_PEER)
  *	@maxtype: Highest device specific netlink attribute number
  *	@policy: Netlink policy for device specific attribute validation
  *	@validate: Optional validation function for netlink/changelink parameters
@@ -126,6 +127,7 @@ struct rtnl_link_ops {
 	void			(*setup)(struct net_device *dev);
 
 	bool			netns_refund;
+	const unsigned char	peer_type;
 	unsigned int		maxtype;
 	const struct nla_policy	*policy;
 	int			(*validate)(struct nlattr *tb[],
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1bc8afcefc1e..48bd9e062550 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3798,6 +3798,37 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
+	net = rtnl_link_get_net_tb(tb);
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
@@ -3926,12 +3957,18 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


