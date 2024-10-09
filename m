Return-Path: <netdev+bounces-133958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD834997905
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F93FB20ED0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77121E2857;
	Wed,  9 Oct 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t+DSCFqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0261E2853
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515988; cv=none; b=Ub1zZJvjFOaeIJkYEvuPHQclOYlJ/vJ3jP9PK0GcTcjzoWC2bhhHmSrPFBQCRUeLmSyGQoo0hG8RjMJXASRwy7VDzfWY/324UIUtCRatzKjTH2wPdpPRkrT3PaUoKJxrPC7b7Qcusch28eASZBgFlizj9F+MH6fdj2Lu0kiIZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515988; c=relaxed/simple;
	bh=nV+Xkgg6artkjNCQ13SRbGImEs0VRqUrceINgcUQHC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX9pM1O9QO/tCPMdK0vov/m+0PTeLQil8iqV2c9MSnu1zkKi3PjPr3Gh98yisggkM/6smIT+anTd/rXajcKO4CzDG3+CVMlRtUyAy9tHy0tWBmsYCHeu3njh4crsP9zsT1RtN+u4+glaLJaI6neSvULpO9QKRNTgxv3qsNNde0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t+DSCFqz; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515987; x=1760051987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJPzdtTUB+Ln87ewo/1mUJnkijm+rCd1qJWl40dIFhs=;
  b=t+DSCFqzFg+YGorIU+vxn0QEZ0s7+BE16RNwVvVo0ke50iq67iytj3s9
   fiZCgFWmkFNqrc5CoysfYPatKG80TI07Vcg/9cFt0pIszsTI6nogG5kaZ
   KrH1RsZyjXFZF9cJVNoUJ6zQkJpiXvbgnEyowYreMQdVAxtOHjdbRv890
   w=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="765254195"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:19:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:38539]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 3bbf642e-27a1-44fb-993c-2ce3fdc62908; Wed, 9 Oct 2024 23:19:46 +0000 (UTC)
X-Farcaster-Flow-ID: 3bbf642e-27a1-44fb-993c-2ce3fdc62908
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:19:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:19:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/13] rtnetlink: Call rtnl_link_get_net_capable() in rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:51 -0700
Message-ID: <20241009231656.57830-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
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
---
 net/core/rtnetlink.c | 51 ++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7f464554d881..fc62f23d2647 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3543,7 +3543,7 @@ struct rtnl_newlink_tbs {
 
 static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
 			   const struct rtnl_link_ops *ops,
-			   struct net_device *dev,
+			   struct net_device *dev, struct net *tgt_net,
 			   struct rtnl_newlink_tbs *tbs,
 			   struct nlattr **data,
 			   struct netlink_ext_ack *extack)
@@ -3607,10 +3607,10 @@ static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3628,6 +3628,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
+			       struct net *tgt_net,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
 			       struct netlink_ext_ack *extack)
@@ -3635,9 +3636,9 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	unsigned char name_assign_type = NET_NAME_USER;
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
-	struct net *dest_net, *link_net;
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
+	struct net *link_net;
 	int err;
 
 	if (!ops->alloc && !ops->setup)
@@ -3650,14 +3651,10 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
@@ -3670,7 +3667,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		link_net = NULL;
 	}
 
-	dev = rtnl_create_link(link_net ? : dest_net, ifname,
+	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
 			       name_assign_type, ops, tb, extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
@@ -3692,7 +3689,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	if (err < 0)
 		goto out_unregister;
 	if (link_net) {
-		err = dev_change_net_namespace(dev, dest_net, ifname);
+		err = dev_change_net_namespace(dev, tgt_net, ifname);
 		if (err < 0)
 			goto out_unregister;
 	}
@@ -3704,7 +3701,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 out:
 	if (link_net)
 		put_net(link_net);
-	put_net(dest_net);
+
 	return err;
 out_unregister:
 	if (ops->newlink) {
@@ -3720,6 +3717,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
+			  struct net *tgt_net,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
@@ -3746,19 +3744,18 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3769,7 +3766,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, tgt_net, nlh, tb, data, extack);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -3778,6 +3775,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr **tb, **linkinfo, **data = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	struct net *tgt_net;
 	int ops_srcu_index;
 	int ret;
 
@@ -3842,8 +3840,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


