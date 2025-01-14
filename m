Return-Path: <netdev+bounces-158020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B5A101C4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142257A109D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41C2500AC;
	Tue, 14 Jan 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jQ3KPjdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D22500A8
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842237; cv=none; b=gh0ocKtli/YPG1OFrehdPsKToXk4P2YMPsmQSCpU/1HGF3T4pg7Bb9Ij28LPgeWDp4L8lsBh/38Ey84FRZhrCZRyOCQRZZhbq49f6/38arLj+/191S/JGwVC/Y4PdHW3n71huMeC55nPHEau80CuAFRm+XPX3yFMPDp9L2Od9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842237; c=relaxed/simple;
	bh=lFBn7N0pbcbX8UwCMsC9mig23ssrwm50K8N4P1H/Fj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2HpccPY2QfCFr4IUsHWD0t5nNiyoYDh+ZstNZOU6KlRrEhXDCSVnpPmS6N8/mVREOmqmKKsU5DrwsWVPXEdHTp1OVJwNu0Mj09OGV3WJ/6MPkEX3u6HHV4xcimylJno1oj1Yo4gTXIURaDF6OJ1gcDgdaQWf1cDl/okLstpg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jQ3KPjdk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842236; x=1768378236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vzMKQLBkB4wa/RZWqUrJFK4TAWinF82DOVssU1vPRW0=;
  b=jQ3KPjdkwrbpXMbWye7N5oFB9N0JYFaGLUJ3OxietPk1QV1NnbzV6bfx
   OuGKPhCk7eP6imsydAI+4CVb91NazwWCj4pVS2N6ii6vFrW9gDBCwQr8G
   srDNJjNVPSk1oGl5C4vDQ4LFvB4CLmq8vFsne72hRfbkBC0A/xFsVJ+NM
   E=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="161243175"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:10:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:12148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.27:2525] with esmtp (Farcaster)
 id 983efabc-4c69-4a70-bcd9-897beb8d8799; Tue, 14 Jan 2025 08:10:35 +0000 (UTC)
X-Farcaster-Flow-ID: 983efabc-4c69-4a70-bcd9-897beb8d8799
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:10:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:10:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/11] ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.
Date: Tue, 14 Jan 2025 17:05:16 +0900
Message-ID: <20250114080516.46155-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's register inet6_rtm_deladdr() with RTNL_FLAG_DOIT_PERNET and
hold rtnl_net_lock() before inet6_addr_del().

Now that inet6_addr_del() is always called under per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3a75e014cdce..1a1a6b114798 100644
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


