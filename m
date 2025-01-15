Return-Path: <netdev+bounces-158407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1533A11B8F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0134C165939
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EAC22F83F;
	Wed, 15 Jan 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L6cd2QeP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E01DB12B
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928578; cv=none; b=WfVT/X0pZro1yajc618P4dp0YPZ7JdyQdSmoM+KZ8FMxisJ9fGgZQWWXMAMnZm1+uoqZZdz5mTLOjyC356BDT2PjD+FBNCgMi/ogEI8If7tYkIfPh7VMlR7t3M2kt118jsHyTt96YaDjzuo+CTUBHWCUOrKb152PZo00ysS96m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928578; c=relaxed/simple;
	bh=3IAo4OUhSMferWkQTo36JDp2A+F7kOeBlvmaGpVy37s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6+f3TPyonCr0NZ1IqCwaFPDAo7NlXMlRhLqSUjRXADzx1JxDkFAZ1s5T+9vTSXDBWOBoP2JPIsPptgZMu+2oA2APU3MAo1OItO9dt43Q7xanEtGBKpMhF0GPjkZXQ/82/pKeUncJ/+JP6VKUVPpgYtN+aTQSYgJL+nocp9Eqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L6cd2QeP; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928576; x=1768464576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJtiydFTVgb2mEKNXKKfFH3t6I+paBtEk25tQqpSj9k=;
  b=L6cd2QePnA0xRMqjl0itmKClUL+AZaM9xa11wmYoqfaLva7JqD3++Dex
   bqMG1w2uvz3W9fxYR7+tw2bXVSx72aJHgvL8ob3g+s92aiSghDZwipTcp
   J6UpnokKz2wP7uElvBQY4EZfKdcjR2JyNgeNfXY+yxxPimP2tyU/BKLO0
   s=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="161543862"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:09:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:65294]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 0edbee03-1a09-486b-b81c-5c2f5a459d46; Wed, 15 Jan 2025 08:09:34 +0000 (UTC)
X-Farcaster-Flow-ID: 0edbee03-1a09-486b-b81c-5c2f5a459d46
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:09:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:09:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/11] ipv6: Pass dev to inet6_addr_add().
Date: Wed, 15 Jan 2025 17:06:04 +0900
Message-ID: <20250115080608.28127-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
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
index 9c7257b28a84..0e7ca74012aa 100644
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


