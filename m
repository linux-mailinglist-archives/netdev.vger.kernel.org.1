Return-Path: <netdev+bounces-158411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69188A11B9E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EB63A33B5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A42361C0;
	Wed, 15 Jan 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KwxezNgF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BDF1FECD7
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928689; cv=none; b=GjJHDEECv8yFrBn17CbJ2L+jmbQbzI9nQmAkuQBqKGoCbsNSrniEdnBnyzi3s8z++Aqqdorxga8yvsulFb4zwLnG4DRV6SOv8T71OblohFNH9IP40Cogk+LA5O2zxpUpRKChF3q+ph5jqT5eKGTgbqUvrHBkqto6CyAn9DAU6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928689; c=relaxed/simple;
	bh=WE0nkjsg35Fe6mpAqlav4aKHosViO7H2jTW8MHzV9w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaLDrxScVF4TD+Xp4UNN+cO3e3eVuDqteLvxIg0HZxF2ukTe9+7Y8Y8/7LKWqUeWo0NeOKYrhT+2gwvwqAUm2fXzS4ZD6PAWu+bGCi5NEus7X28PF3fV2wKcZFyE7xnC0WMqNZaqOIa04SmqsRwSe/9yR3Xecsdk+BkjpcfdhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KwxezNgF; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928688; x=1768464688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mF3Ey3PS3cYH2MQCjMNQSZ1kgeOZnVEoKM4t/Qtsie8=;
  b=KwxezNgFljeK/SXrMCSgs31qPHhu/rOgeKQnpcYsN1Wz9wUQdU9+jcKJ
   jW7/NtYNheaHrGWrcYiwMsZNEUcD89zpWfaN2cfLTK4ybXc0hHubHq3Gn
   8cQpLQZQhmUxiXz+bDxAlklV6RssedPyXWFyMrlpnqtpjzzOdvRv333st
   s=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="57830651"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:11:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:45791]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id 50efd308-b75b-49e2-a4f7-a1f092de8da5; Wed, 15 Jan 2025 08:11:24 +0000 (UTC)
X-Farcaster-Flow-ID: 50efd308-b75b-49e2-a4f7-a1f092de8da5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:11:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:11:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/11] ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.
Date: Wed, 15 Jan 2025 17:06:08 +0900
Message-ID: <20250115080608.28127-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's register inet6_rtm_deladdr() with RTNL_FLAG_DOIT_PERNET and
hold rtnl_net_lock() before inet6_addr_del().

Now that inet6_addr_del() is always called under per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b848e4038d2e..ac8cc1076536 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3096,7 +3096,7 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 		return -ENODEV;
 	}
 
-	idev = __in6_dev_get(dev);
+	idev = __in6_dev_get_rtnl_net(dev);
 	if (!idev) {
 		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
 		return -ENXIO;
@@ -4792,8 +4792,12 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	/* We ignore other flags so far. */
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
 
-	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
-			      ifm->ifa_prefixlen, extack);
+	rtnl_net_lock(net);
+	err = inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
+			     ifm->ifa_prefixlen, extack);
+	rtnl_net_unlock(net);
+
+	return err;
 }
 
 static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
@@ -7404,7 +7408,7 @@ static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] __initconst_or
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDR,
 	 .doit = inet6_rtm_newaddr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDR,
-	 .doit = inet6_rtm_deladdr},
+	 .doit = inet6_rtm_deladdr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDR,
 	 .doit = inet6_rtm_getaddr, .dumpit = inet6_dump_ifaddr,
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.39.5 (Apple Git-154)


