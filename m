Return-Path: <netdev+bounces-136263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C39A1218
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AA6B24C4A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F61B4F2F;
	Wed, 16 Oct 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bX81rl4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4818DF97
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105009; cv=none; b=U9GPjmkh8+OVUmcb39Hj/fcZiAG2aqYvnKifyKHGRdF0imsBDv4YjEM8y0rb9yPRRxwbid/erfqtYkM1C8MeDOizVaWMuOgzgZcIa+UZgWXA1Vg5ps6T45cM+xoiDo7fW/NBtNPfyPBcWqxS1+H7oTAelF1V80k5+p77ZE70bJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105009; c=relaxed/simple;
	bh=QT4oTnwgkdk1BHfuCrfHbOzN6wzJY60cmiBpFT/8fM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzHKJhHbC5ftWe7P95phQQr5xNJQQ+oI7v/5gp464nnJvWsSbuymBZPAMv+pACeGLTUJlk1g+UXIZqrWLrjsxuyjBpgKwwQ2VF9V1fw9zOIfra34FQUc7Nyd0qdonikLbMJEfjZJpxqagswphgd3uBRcRSvEHqQfAhua/bwIQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bX81rl4N; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105008; x=1760641008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HfzpoCHHyT43vZ5CRKWDrBQfafKRex/ccdbe3aRIK5Q=;
  b=bX81rl4Nd5c1trSJh7Rt2Z/i2vm703LXT39bLRwXaZzFM+JEx1SI27DM
   +VghlH9AqPbjc5NWadKIVwlYFSBA0nda/3/wpGj+zD3eBY5gqJdatWs8F
   VCmuxrvcsr7Ls94WRJ5jsUDmF+iIRv0TEnlno6r2ctmzTgTrM10Ot3q/f
   c=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="239853992"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:56:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:2343]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 42140e99-0f7a-42ed-9701-ba602d22a166; Wed, 16 Oct 2024 18:56:44 +0000 (UTC)
X-Farcaster-Flow-ID: 42140e99-0f7a-42ed-9701-ba602d22a166
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:56:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:56:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/14] rtnetlink: Call rtnl_link_get_net_capable() in rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:51 -0700
Message-ID: <20241016185357.83849-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As a prerequisite of per-netns RTNL, we must fetch netns before
looking up dev or moving it to another netns.

rtnl_link_get_net_capable() is called in rtnl_newlink_create() and
do_setlink(), but both of them need to be moved to the RTNL-independent
region, which will be rtnl_newlink().

Let's call rtnl_link_get_net_capable() in rtnl_newlink() and pass the
netns down to where needed.

Note that the latter two have not passed the nets to do_setlink() yet
but will do so after the remaining rtnl_link_get_net_capable() is moved
to rtnl_setlink() later.

While at it, dest_net is renamed to tgt_net in rtnl_newlink_create() to
align with rtnl_{del,set}link().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 51 ++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31b105b3a834..f6823c8d21ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3549,7 +3549,7 @@ struct rtnl_newlink_tbs {
 
 static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
 			   const struct rtnl_link_ops *ops,
-			   struct net_device *dev,
+			   struct net_device *dev, struct net *tgt_net,
 			   struct rtnl_newlink_tbs *tbs,
 			   struct nlattr **data,
 			   struct netlink_ext_ack *extack)
@@ -3613,10 +3613,10 @@ static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int rtnl_group_changelink(const struct sk_buff *skb,
-		struct net *net, int group,
-		struct ifinfomsg *ifm,
-		struct netlink_ext_ack *extack,
-		struct nlattr **tb)
+				 struct net *net, struct net *tgt_net,
+				 int group, struct ifinfomsg *ifm,
+				 struct netlink_ext_ack *extack,
+				 struct nlattr **tb)
 {
 	struct net_device *dev, *aux;
 	int err;
@@ -3634,6 +3634,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
+			       struct net *tgt_net,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
 			       struct netlink_ext_ack *extack)
@@ -3641,9 +3642,9 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	unsigned char name_assign_type = NET_NAME_USER;
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
-	struct net *dest_net, *link_net;
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
+	struct net *link_net;
 	int err;
 
 	if (!ops->alloc && !ops->setup)
@@ -3656,14 +3657,10 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
-	if (IS_ERR(dest_net))
-		return PTR_ERR(dest_net);
-
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
 
-		link_net = get_net_ns_by_id(dest_net, id);
+		link_net = get_net_ns_by_id(tgt_net, id);
 		if (!link_net) {
 			NL_SET_ERR_MSG(extack, "Unknown network namespace id");
 			err =  -EINVAL;
@@ -3676,7 +3673,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		link_net = NULL;
 	}
 
-	dev = rtnl_create_link(link_net ? : dest_net, ifname,
+	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
 			       name_assign_type, ops, tb, extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
@@ -3698,7 +3695,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	if (err < 0)
 		goto out_unregister;
 	if (link_net) {
-		err = dev_change_net_namespace(dev, dest_net, ifname);
+		err = dev_change_net_namespace(dev, tgt_net, ifname);
 		if (err < 0)
 			goto out_unregister;
 	}
@@ -3710,7 +3707,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 out:
 	if (link_net)
 		put_net(link_net);
-	put_net(dest_net);
+
 	return err;
 out_unregister:
 	if (ops->newlink) {
@@ -3726,6 +3723,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
+			  struct net *tgt_net,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
@@ -3752,19 +3750,18 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (dev)
-		return rtnl_changelink(skb, nlh, ops, dev, tbs, data, extack);
+		return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, data, extack);
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
 		 * or it's for a group
 		*/
-		if (link_specified)
+		if (link_specified || !tb[IFLA_GROUP])
 			return -ENODEV;
-		if (tb[IFLA_GROUP])
-			return rtnl_group_changelink(skb, net,
-						nla_get_u32(tb[IFLA_GROUP]),
-						ifm, extack, tb);
-		return -ENODEV;
+
+		return rtnl_group_changelink(skb, net, tgt_net,
+					     nla_get_u32(tb[IFLA_GROUP]),
+					     ifm, extack, tb);
 	}
 
 	if (tb[IFLA_MAP] || tb[IFLA_PROTINFO])
@@ -3775,7 +3772,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, tgt_net, nlh, tb, data, extack);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -3784,6 +3781,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr **tb, **linkinfo, **data = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	struct net *tgt_net;
 	int ops_srcu_index;
 	int ret;
 
@@ -3848,8 +3846,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	ret = __rtnl_newlink(skb, nlh, ops, tbs, data, extack);
+	tgt_net = rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb, CAP_NET_ADMIN);
+	if (IS_ERR(tgt_net)) {
+		ret = PTR_ERR(tgt_net);
+		goto put_ops;
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, tbs, data, extack);
 
+	put_net(tgt_net);
 put_ops:
 	if (ops)
 		rtnl_link_ops_put(ops, ops_srcu_index);
-- 
2.39.5 (Apple Git-154)


