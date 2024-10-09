Return-Path: <netdev+bounces-133959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB16997907
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16267283DD5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCA1E2853;
	Wed,  9 Oct 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ibPSVAC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A9183CC1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516008; cv=none; b=SfhTo/Kp1QyUb3piKrQVmg7H1cxzwzaXHfgNJnfYJV63Q1R7OXimiQAP9BWgMQFToVkUmNvoiiRlQ2AWQBIQ7HD9n3CHVigSiTBkxvZf0FeGGcjvW8sogEJgsEvXKN42xjimfdPljAOymWW456vcHvZ8Ka05CaGx9IF7sh3Z3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516008; c=relaxed/simple;
	bh=CEEGE1UqidslQcLt0lf3HRoHF1o2f1LXA3ybDyPnW6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmUr0Wf0vjuaYJgmBQpVgxt6/0unsx0npUNe5AeVMDdyA+s3a3vAwXFwL6Mve2rdSTJd9L/icta38FkVod2d9Mzt0z8zPFeRlziu7nc2oIRYs13zcRbb1me+oxpemdstVr+65qQ9iHqTVcdNBkHJjHoUBe6sLsoZS+24z5EcXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ibPSVAC7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728516007; x=1760052007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7QaEEJr1XkLb3yuxSRZU13s3su4K2Jcvzr6v8bpWoGs=;
  b=ibPSVAC7/mnHOqc0oQ6dxHmID5aPNJzn9CMkKhDfOdyCzDQMz6s25rrD
   AdAGtwKbNe+XMgyGTj0EsMdnsXhXgD6R5sX+GQBkMyGUiekyVAJm3t6yU
   C5UcTxMwD8yTN/NlL+CKzNR7HczhJWT9xQR1vShBobTNi58R8Lxk+WzEx
   c=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="238125463"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:20:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:62964]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 9ee77a73-515a-44b1-bfcb-be4ee9c4a0b7; Wed, 9 Oct 2024 23:20:05 +0000 (UTC)
X-Farcaster-Flow-ID: 9ee77a73-515a-44b1-bfcb-be4ee9c4a0b7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:20:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:20:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/13] rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:52 -0700
Message-ID: <20241009231656.57830-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Another netns option for RTM_NEWLINK is IFLA_LINK_NETNSID and
is fetched in rtnl_newlink_create().

This must be done before holding rtnl_net_lock().

Let's move IFLA_LINK_NETNSID processing to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fc62f23d2647..70a3a9f411d8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3628,7 +3628,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
-			       struct net *tgt_net,
+			       struct net *tgt_net, struct net *link_net,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
 			       struct netlink_ext_ack *extack)
@@ -3638,7 +3638,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	u32 portid = NETLINK_CB(skb).portid;
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
-	struct net *link_net;
 	int err;
 
 	if (!ops->alloc && !ops->setup)
@@ -3651,22 +3650,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	if (tb[IFLA_LINK_NETNSID]) {
-		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
-
-		link_net = get_net_ns_by_id(tgt_net, id);
-		if (!link_net) {
-			NL_SET_ERR_MSG(extack, "Unknown network namespace id");
-			err =  -EINVAL;
-			goto out;
-		}
-		err = -EPERM;
-		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN))
-			goto out;
-	} else {
-		link_net = NULL;
-	}
-
 	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
 			       name_assign_type, ops, tb, extack);
 	if (IS_ERR(dev)) {
@@ -3699,9 +3682,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			goto out_unregister;
 	}
 out:
-	if (link_net)
-		put_net(link_net);
-
 	return err;
 out_unregister:
 	if (ops->newlink) {
@@ -3717,7 +3697,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
-			  struct net *tgt_net,
+			  struct net *tgt_net, struct net *link_net,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
@@ -3766,16 +3746,16 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, tgt_net, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, nlh, tb, data, extack);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **tb, **linkinfo, **data = NULL;
+	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
-	struct net *tgt_net;
 	int ops_srcu_index;
 	int ret;
 
@@ -3846,8 +3826,27 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_ops;
 	}
 
-	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, tbs, data, extack);
+	if (tb[IFLA_LINK_NETNSID]) {
+		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
+
+		link_net = get_net_ns_by_id(tgt_net, id);
+		if (!link_net) {
+			NL_SET_ERR_MSG(extack, "Unknown network namespace id");
+			ret =  -EINVAL;
+			goto put_net;
+		}
+
+		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto put_net;
+		}
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
 
+put_net:
+	if (link_net)
+		put_net(link_net);
 	put_net(tgt_net);
 put_ops:
 	if (ops)
-- 
2.39.5 (Apple Git-154)


