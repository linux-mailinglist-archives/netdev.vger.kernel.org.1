Return-Path: <netdev+bounces-158019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C8A101C3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4E3163CC6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF52500A8;
	Tue, 14 Jan 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ig/w9ZVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD252309BD
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842217; cv=none; b=dLcaHn/snaIx2onKuTFzlTTC/fvhQ4FNvJh0IDZzrVCZwGqqdpwh6YdczJJzSElgUI1Ns85qFQf2SL9B+ZbOP0m/1UHZz+mBHYHitkVZ1kIFczSs5IjX8n7pSzkq8De8ogYtTStmpH0f67LZE652i9QNEZEIWLwcEL+zxDz7KO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842217; c=relaxed/simple;
	bh=SrgGiWwljyNaZJqN5WCc5fRyNR/ITaP9Qlj/L8YmUTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPu8SV9nIJJMzzgep6fRu9y5GT4PxF8qafs+Lnrn1N38QLSencCgycyBjwJCy2hcRuNmJ3gal969BVmaQzHoi/k82ZNXBii6sESHh8jQPgOrSdiZ7l0BAvxVtqleBd50B1fdJYclEPFiFCiBLX6GApYUCMbaqB7IoUwh7HaFnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ig/w9ZVf; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842216; x=1768378216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGN6yWP56Vnj3iXYAKTINviBpXZiWw98UuMNnTD8lXo=;
  b=Ig/w9ZVfTl+oqYDHWKSFuBLt4s9STq5ag+34O/xl2iVQZCuRzNHJg69l
   qreRSeCy8H0nrSbfa5Ro4JRTQX86UN35I47daTM7XEd6aMsMvFIz3yUWV
   DRmleKu6FXFcDOta6KkljHNCWvbfTELp6iGEZkY4kiSJ+i/1p8lPFgn3D
   U=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="458645108"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:10:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33834]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.180:2525] with esmtp (Farcaster)
 id 4f820973-75ff-47d8-b6aa-8f24806a03aa; Tue, 14 Jan 2025 08:10:10 +0000 (UTC)
X-Farcaster-Flow-ID: 4f820973-75ff-47d8-b6aa-8f24806a03aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:10:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:10:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/11] ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
Date: Tue, 14 Jan 2025 17:05:15 +0900
Message-ID: <20250114080516.46155-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's register inet6_rtm_newaddr() with RTNL_FLAG_DOIT_PERNET
and hold rtnl_net_lock() before __dev_get_by_index().

Now that inet6_addr_add() and inet6_addr_modify() are always
called under per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 721a4bceb107..3a75e014cdce 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3014,7 +3014,7 @@ static int inet6_addr_add(struct net *net, struct net_device *dev,
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	if (cfg->plen > 128) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
@@ -4849,7 +4849,7 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 	bool new_peer = false;
 	bool had_prefixroute;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR &&
 	    (ifp->flags & IFA_F_TEMPORARY || ifp->prefix_len != 64))
@@ -5016,15 +5016,20 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
 			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
 
+	rtnl_net_lock(net);
+
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
-		return -ENODEV;
+		err = -ENODEV;
+		goto unlock;
 	}
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
-		return PTR_ERR(idev);
+	if (IS_ERR(idev)) {
+		err = PTR_ERR(idev);
+		goto unlock;
+	}
 
 	if (!ipv6_allow_optimistic_dad(net, idev))
 		cfg.ifa_flags &= ~IFA_F_OPTIMISTIC;
@@ -5032,7 +5037,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (cfg.ifa_flags & IFA_F_NODAD &&
 	    cfg.ifa_flags & IFA_F_OPTIMISTIC) {
 		NL_SET_ERR_MSG(extack, "IFA_F_NODAD and IFA_F_OPTIMISTIC are mutually exclusive");
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	ifa = ipv6_get_ifaddr(net, cfg.pfx, dev, 1);
@@ -5041,7 +5047,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 * It would be best to check for !NLM_F_CREATE here but
 		 * userspace already relies on not having to provide this.
 		 */
-		return inet6_addr_add(net, dev, &cfg, expires, flags, extack);
+		err = inet6_addr_add(net, dev, &cfg, expires, flags, extack);
+		goto unlock;
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
@@ -5053,6 +5060,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	in6_ifa_put(ifa);
+unlock:
+	rtnl_net_unlock(net);
 
 	return err;
 }
@@ -7393,7 +7402,7 @@ static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] __initconst_or
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETLINK,
 	 .dumpit = inet6_dump_ifinfo, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDR,
-	 .doit = inet6_rtm_newaddr},
+	 .doit = inet6_rtm_newaddr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDR,
 	 .doit = inet6_rtm_deladdr},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDR,
-- 
2.39.5 (Apple Git-154)


