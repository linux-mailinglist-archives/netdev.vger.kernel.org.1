Return-Path: <netdev+bounces-133962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3B99790A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307AD1C220D9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F0A1E2853;
	Wed,  9 Oct 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XmM9Dm6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9601E2857
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516066; cv=none; b=SXK0/gz6mFvz5nEtED1kwBqir4OeFiNYhLSTJeJR+8JpRnvKWZI7Wh8/58YoqxtsEm0ZAQtPr9TJJrrAv6Pvs4pmPwryKcfU1ZgeZcHoq/LO2SEoROF1qW1QAlQwDHaAS1g6/M/1GPwXu3H2P1i0TKVcaMcnTZAyOTsepLvUirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516066; c=relaxed/simple;
	bh=tBKPhC+/n0AEdyYxsaGTm6nCTmzi9Or1yo+lgRxzfas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq9a46gMM0FyFtvEnLmN3ph9rkLh0y1PK/0qDpfpWyGjSnXgmTo9++hocEsOh7NeKtlw2gBPksbgOMPZHAUH+MOI3rNKLS4Ey6jfuJEfIML4sQcbEzpSPyICW/+g0uF99iyRB45IOgnDBq5BhB9nvyT/Sy2BtC+BlXmQF0bAJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XmM9Dm6O; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728516064; x=1760052064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeczMu7mulCwhIzokfDy7FpoBGX7c3NXbTacTSpkN3E=;
  b=XmM9Dm6O5+8pKonS1E09mx9S65WZK058PK6tcMfRJTyrdUvfu+RiKDYb
   SmKlk1sBX2grQ+AxHAPVH3foUOV7kb3BdOdQfPyStKNJP09pOobBaAuLZ
   iUgvx/iLHD3UFifB/2oZILCoYtmtcxrghq2wh37EELk+XhmWXVzYcD+at
   A=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="686429629"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:21:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:1553]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 3956824e-d670-41f8-b23c-cb7d427e341a; Wed, 9 Oct 2024 23:21:01 +0000 (UTC)
X-Farcaster-Flow-ID: 3956824e-d670-41f8-b23c-cb7d427e341a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:21:00 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:20:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/13] rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
Date: Wed, 9 Oct 2024 16:16:55 -0700
Message-ID: <20241009231656.57830-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_setlink().

RTM_SETLINK could call rtnl_link_get_net_capable() in do_setlink()
to move a dev to a new netns, but the netns needs to be fetched before
holding rtnl_net_lock().

Let's move it to rtnl_setlink() and pass the netns to do_setlink().

Now, RTM_NEWLINK paths (rtnl_changelink() and rtnl_group_changelink())
can pass the prefetched netns to do_setlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index de693a88986e..a0702e531331 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2875,8 +2875,8 @@ static int do_set_proto_down(struct net_device *dev,
 #define DO_SETLINK_MODIFIED	0x01
 /* notify flag means notify + modified. */
 #define DO_SETLINK_NOTIFY	0x03
-static int do_setlink(const struct sk_buff *skb,
-		      struct net_device *dev, struct ifinfomsg *ifm,
+static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
+		      struct net *tgt_net, struct ifinfomsg *ifm,
 		      struct netlink_ext_ack *extack,
 		      struct nlattr **tb, int status)
 {
@@ -2893,27 +2893,19 @@ static int do_setlink(const struct sk_buff *skb,
 	else
 		ifname[0] = '\0';
 
-	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_TARGET_NETNSID]) {
+	if (!net_eq(tgt_net, dev_net(dev))) {
 		const char *pat = ifname[0] ? ifname : NULL;
-		struct net *net;
 		int new_ifindex;
 
-		net = rtnl_link_get_net_capable(skb, dev_net(dev),
-						tb, CAP_NET_ADMIN);
-		if (IS_ERR(net)) {
-			err = PTR_ERR(net);
-			goto errout;
-		}
-
 		if (tb[IFLA_NEW_IFINDEX])
 			new_ifindex = nla_get_s32(tb[IFLA_NEW_IFINDEX]);
 		else
 			new_ifindex = 0;
 
-		err = __dev_change_net_namespace(dev, net, pat, new_ifindex);
-		put_net(net);
+		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
 		if (err)
 			goto errout;
+
 		status |= DO_SETLINK_MODIFIED;
 	}
 
@@ -3277,6 +3269,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFLA_MAX+1];
 	struct net_device *dev = NULL;
+	struct net *tgt_net;
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
@@ -3288,6 +3281,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	tgt_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	if (IS_ERR(tgt_net))
+		return PTR_ERR(tgt_net);
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3296,11 +3293,13 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -EINVAL;
 
 	if (dev)
-		err = do_setlink(skb, dev, ifm, extack, tb, 0);
+		err = do_setlink(skb, dev, tgt_net, ifm, extack, tb, 0);
 	else if (!err)
 		err = -ENODEV;
 
 errout:
+	put_net(tgt_net);
+
 	return err;
 }
 
@@ -3593,7 +3592,7 @@ static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
 		status |= DO_SETLINK_NOTIFY;
 	}
 
-	return do_setlink(skb, dev, nlmsg_data(nlh), extack, tb, status);
+	return do_setlink(skb, dev, tgt_net, nlmsg_data(nlh), extack, tb, status);
 }
 
 static int rtnl_group_changelink(const struct sk_buff *skb,
@@ -3607,7 +3606,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = do_setlink(skb, dev, ifm, extack, tb, 0);
+			err = do_setlink(skb, dev, tgt_net, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
 		}
-- 
2.39.5 (Apple Git-154)


