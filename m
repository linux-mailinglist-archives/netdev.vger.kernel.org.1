Return-Path: <netdev+bounces-158017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49CA101C1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185E47A1024
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E32500A8;
	Tue, 14 Jan 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CFxPJXbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA22309BD
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842158; cv=none; b=g2IZE1Oh4XLb5L61l5ZHkszkM6zGG8AnyAlYSJJvDokFiROIN+JzmIErOQ6y184IOiL2r9rtJfTHBeF3w2ETJD5CoM7+XeQBge8pbpcq0daN/jiDnEyD4/Ge6ce90dEKVAQcjU7V7D2RhMb9hOeSO0nRNEBHe/ssT3c8sQAy+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842158; c=relaxed/simple;
	bh=IUPx/iOlGPY8zdkOotnjyvph0D5YrhEbnSNrqCqJOA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7EqRcKxpuJPENpiDklhOVDF1rfrycKMpKZ4jgaoKenMPgBH80AjAYuNoPtztOgoCtpAYXh29WaRw0+Aju7y9luQNMrjIq9GKjTDKmbQA4OJtn7RcGpsjiUEtYgqutDS5npBcKlEGZtSKR8hFWiRTXYoReEjOKkeAnOMJgcHUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CFxPJXbm; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842158; x=1768378158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nAUiPmmwVYhYv/4YvrgqIHgkr2rKGI9Squ8jrHh3dwI=;
  b=CFxPJXbmM0HVpszl6EGV8v90j32Gjx5RM8+XVK8PV2fav7xyjqktbu/g
   agqbHCSHl/Bey0rCInfOvIQaH19EGGUToKq4K+ok7lup5+YOFiN6TlWij
   6Q8rgGlupYD7HQNJmPM2Xe4gSQKB7xXKaRdZG7v+NvhvaYFtNOtd6Uvx5
   U=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="262895249"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:09:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:15383]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.219:2525] with esmtp (Farcaster)
 id d1dbb130-f294-4cf2-a5ff-c1a1ae87304d; Tue, 14 Jan 2025 08:09:14 +0000 (UTC)
X-Farcaster-Flow-ID: d1dbb130-f294-4cf2-a5ff-c1a1ae87304d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:09:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:09:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/11] ipv6: Pass dev to inet6_addr_add().
Date: Tue, 14 Jan 2025 17:05:13 +0900
Message-ID: <20250114080516.46155-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

inet6_addr_add() is called from inet6_rtm_newaddr() and
addrconf_add_ifaddr().

inet6_addr_add() looks up dev by __dev_get_by_index(), but
it's already done in inet6_rtm_newaddr().

Let's move the 2nd lookup to addrconf_add_ifaddr() and pass
dev to inet6_addr_add().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0daea381d541..3a2f4501b302 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3007,13 +3007,12 @@ static int ipv6_mc_config(struct sock *sk, bool join,
 /*
  *	Manual configuration of address on an interface
  */
-static int inet6_addr_add(struct net *net, int ifindex,
+static int inet6_addr_add(struct net *net, struct net_device *dev,
 			  struct ifa6_config *cfg,
 			  struct netlink_ext_ack *extack)
 {
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
-	struct net_device *dev;
 	unsigned long timeout;
 	clock_t expires;
 	u32 flags;
@@ -3036,10 +3035,6 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		return -EINVAL;
 	}
 
-	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
-		return -ENODEV;
-
 	idev = addrconf_add_dev(dev);
 	if (IS_ERR(idev)) {
 		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
@@ -3048,7 +3043,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
 
 	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
-					 true, cfg->pfx, ifindex);
+					 true, cfg->pfx, dev->ifindex);
 
 		if (ret < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "Multicast auto join failed");
@@ -3103,7 +3098,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		return 0;
 	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
-			       cfg->pfx, ifindex);
+			       cfg->pfx, dev->ifindex);
 	}
 
 	return PTR_ERR(ifp);
@@ -3169,6 +3164,7 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 		.preferred_lft = INFINITY_LIFE_TIME,
 		.valid_lft = INFINITY_LIFE_TIME,
 	};
+	struct net_device *dev;
 	struct in6_ifreq ireq;
 	int err;
 
@@ -3182,7 +3178,11 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 	cfg.plen = ireq.ifr6_prefixlen;
 
 	rtnl_net_lock(net);
-	err = inet6_addr_add(net, ireq.ifr6_ifindex, &cfg, NULL);
+	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
+	if (dev)
+		err = inet6_addr_add(net, dev, &cfg, NULL);
+	else
+		err = -ENODEV;
 	rtnl_net_unlock(net);
 	return err;
 }
@@ -5064,7 +5064,7 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 * It would be best to check for !NLM_F_CREATE here but
 		 * userspace already relies on not having to provide this.
 		 */
-		return inet6_addr_add(net, ifm->ifa_index, &cfg, extack);
+		return inet6_addr_add(net, dev, &cfg, extack);
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
-- 
2.39.5 (Apple Git-154)


