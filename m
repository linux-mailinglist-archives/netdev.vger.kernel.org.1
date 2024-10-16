Return-Path: <netdev+bounces-136269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3265E9A1225
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5838282EB3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EE212627;
	Wed, 16 Oct 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gWQgqX5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F52212EFF
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105083; cv=none; b=RMjqNSh4zW775z89eN45tro87nzgW2mW9xYFtQElBxNgDGTttIKOC8fBuW2JKimsExKlzZkK5DKjhGe02+sp6umuzL1lLt4IKtsnHT7gfqvHo9m0DeD5DhtCUU+rtv2iKL6O6Lfg2XxLLCFILQ9XP+CsdeFLDiX2vt4xgoM3zPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105083; c=relaxed/simple;
	bh=boXZTWRj8q5Y8LXGLAmMQddgqXwwkAW5zmUm6VBpe/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeYFyH8VRZSr/KKUTmtJoX0mBORagpBM/KwC5DXL4QqFoqFmp8y2rB4L9TSI50cKGqvBuGBwWyYIsy8S0OGayRzyPi744ExIYjLRLig5SRtQL/c1FRVbp/66mhb5xfFSTjCsD0HPX0wuUj6p+N2Lokcz6tD1AF+kTBMFrNKhDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gWQgqX5W; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105082; x=1760641082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=or+thUWvJ9EAOvHxUlb17GypJeU1g5rwYCisFE9/Drw=;
  b=gWQgqX5WGHsUCGEEVro57bL552VwmIKOA7xh6N256bduRgsTtFP4P/vG
   h/9xLyTPQRt6pxGi3zIxjKRZN2iKOT4bKCV1Z2bf+l0ULpac3yH25kN+W
   fIDSeCqhixtkQkQCg2HQh1gADIBtEmGG57iKZrSWgOr3SBp1DvGiHMdy4
   8=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="138740301"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:58:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:44944]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 3f30c8f2-15de-4432-b54a-d6f7b21256ab; Wed, 16 Oct 2024 18:58:01 +0000 (UTC)
X-Farcaster-Flow-ID: 3f30c8f2-15de-4432-b54a-d6f7b21256ab
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:58:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:57:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/14] rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
Date: Wed, 16 Oct 2024 11:53:55 -0700
Message-ID: <20241016185357.83849-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
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
v2:
  * Move put_net() above the errorout label in rtnl_setlink()
---
 net/core/rtnetlink.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f89a902458d6..445e6ffed75e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2881,8 +2881,8 @@ static int do_set_proto_down(struct net_device *dev,
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
@@ -2899,27 +2899,19 @@ static int do_setlink(const struct sk_buff *skb,
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
 
@@ -3283,6 +3275,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFLA_MAX+1];
 	struct net_device *dev = NULL;
+	struct net *tgt_net;
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
@@ -3294,6 +3287,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	tgt_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	if (IS_ERR(tgt_net)) {
+		err = PTR_ERR(tgt_net);
+		goto errout;
+	}
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3302,10 +3301,11 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -EINVAL;
 
 	if (dev)
-		err = do_setlink(skb, dev, ifm, extack, tb, 0);
+		err = do_setlink(skb, dev, tgt_net, ifm, extack, tb, 0);
 	else if (!err)
 		err = -ENODEV;
 
+	put_net(tgt_net);
 errout:
 	return err;
 }
@@ -3599,7 +3599,7 @@ static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
 		status |= DO_SETLINK_NOTIFY;
 	}
 
-	return do_setlink(skb, dev, nlmsg_data(nlh), extack, tb, status);
+	return do_setlink(skb, dev, tgt_net, nlmsg_data(nlh), extack, tb, status);
 }
 
 static int rtnl_group_changelink(const struct sk_buff *skb,
@@ -3613,7 +3613,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = do_setlink(skb, dev, ifm, extack, tb, 0);
+			err = do_setlink(skb, dev, tgt_net, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
 		}
-- 
2.39.5 (Apple Git-154)


