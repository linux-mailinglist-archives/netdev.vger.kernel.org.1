Return-Path: <netdev+bounces-158409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885DA11B9A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1403B3A83B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BE284A6F;
	Wed, 15 Jan 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GoDpvArG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084A23236B
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928637; cv=none; b=gvXYNkVmbCaZCwTf6aucuFOfMAY8GnbXQ4wWaQicUZh3nhecLvImLqc4CMfKb/zxfXDLXEVoJnQgfSRSgEOEPrbSsRKDqv3Ea+EjGurlY3eRBXmoYRsM/eA2L7WgeCd/pa+7XuJ4vxExHuD9HwjcAZ6ia+FiX2nPRf270GQ3k5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928637; c=relaxed/simple;
	bh=6TNMgtB4wlodMKlsMZv6+rIbmLSz4vQye5O0xmiUa4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AncEE0agYSwWz77O4+OMsputYXQ0QW94MzKjSzEz9phj9IcLpwt7C1sohF3hYMgcz6xTpX5bIFGGX4T8zIvjcl4qFOB7Jm2hgHkgrVSZPPU+QjVLgD0SSlRQVLiiTP1U7dBG+wW/5gdn75qwkx1AOsY3uT552vt5BiWwIy41mTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GoDpvArG; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928637; x=1768464637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFhK2oU2VmORMJs2+UWzRNESkr3bMaymWDlZyMWBG8c=;
  b=GoDpvArGvuNF2Xr+pCm0Ke432TsbilE2yEHHuD/VmV+3ZWKqXUbW3Gia
   IMpJdHim7HduncadKd2d0ZNH5p+EHv4g++bfuieRMzE+ILhu4g+kRGRJb
   5FvZVPr2KuYobtZau0Xt+kwQsmDWZNXKCOxyU6t0UP09cWTi+IebDvCgz
   w=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="486095235"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:10:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:6513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 0e980968-7af3-44fc-847a-0423f05a3602; Wed, 15 Jan 2025 08:10:30 +0000 (UTC)
X-Farcaster-Flow-ID: 0e980968-7af3-44fc-847a-0423f05a3602
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:10:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:10:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/11] ipv6: Move lifetime validation to inet6_rtm_newaddr().
Date: Wed, 15 Jan 2025 17:06:06 +0900
Message-ID: <20250115080608.28127-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

inet6_addr_add() and inet6_addr_modify() have the same code to validate
IPv6 lifetime that is done under RTNL.

Let's factorise it out to inet6_rtm_newaddr() so that we can validate
the lifetime without RTNL later.

Note that inet6_addr_add() is called from addrconf_add_ifaddr(), but the
lifetime is INFINITY_LIFE_TIME in the path, so expires and flags are 0.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 93 +++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 58 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9720ff17f0a1..9ae25a8d1632 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3008,14 +3008,11 @@ static int ipv6_mc_config(struct sock *sk, bool join,
  *	Manual configuration of address on an interface
  */
 static int inet6_addr_add(struct net *net, struct net_device *dev,
-			  struct ifa6_config *cfg,
+			  struct ifa6_config *cfg, clock_t expires, u32 flags,
 			  struct netlink_ext_ack *extack)
 {
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
-	unsigned long timeout;
-	clock_t expires;
-	u32 flags;
 
 	ASSERT_RTNL();
 
@@ -3024,12 +3021,6 @@ static int inet6_addr_add(struct net *net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	/* check the lifetime */
-	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft) {
-		NL_SET_ERR_MSG_MOD(extack, "address lifetime invalid");
-		return -EINVAL;
-	}
-
 	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64) {
 		NL_SET_ERR_MSG_MOD(extack, "address with \"mngtmpaddr\" flag must have a prefix length of 64");
 		return -EINVAL;
@@ -3053,24 +3044,6 @@ static int inet6_addr_add(struct net *net, struct net_device *dev,
 
 	cfg->scope = ipv6_addr_scope(cfg->pfx);
 
-	timeout = addrconf_timeout_fixup(cfg->valid_lft, HZ);
-	if (addrconf_finite_timeout(timeout)) {
-		expires = jiffies_to_clock_t(timeout * HZ);
-		cfg->valid_lft = timeout;
-		flags = RTF_EXPIRES;
-	} else {
-		expires = 0;
-		flags = 0;
-		cfg->ifa_flags |= IFA_F_PERMANENT;
-	}
-
-	timeout = addrconf_timeout_fixup(cfg->preferred_lft, HZ);
-	if (addrconf_finite_timeout(timeout)) {
-		if (timeout == 0)
-			cfg->ifa_flags |= IFA_F_DEPRECATED;
-		cfg->preferred_lft = timeout;
-	}
-
 	ifp = ipv6_add_addr(idev, cfg, true, extack);
 	if (!IS_ERR(ifp)) {
 		if (!(cfg->ifa_flags & IFA_F_NOPREFIXROUTE)) {
@@ -3180,7 +3153,7 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
 	if (dev)
-		err = inet6_addr_add(net, dev, &cfg, NULL);
+		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
 	else
 		err = -ENODEV;
 	rtnl_net_unlock(net);
@@ -4869,20 +4842,15 @@ static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
 }
 
 static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
-			     struct ifa6_config *cfg)
+			     struct ifa6_config *cfg, clock_t expires,
+			     u32 flags)
 {
-	u32 flags;
-	clock_t expires;
-	unsigned long timeout;
 	bool was_managetempaddr;
-	bool had_prefixroute;
 	bool new_peer = false;
+	bool had_prefixroute;
 
 	ASSERT_RTNL();
 
-	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft)
-		return -EINVAL;
-
 	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR &&
 	    (ifp->flags & IFA_F_TEMPORARY || ifp->prefix_len != 64))
 		return -EINVAL;
@@ -4890,24 +4858,6 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 	if (!(ifp->flags & IFA_F_TENTATIVE) || ifp->flags & IFA_F_DADFAILED)
 		cfg->ifa_flags &= ~IFA_F_OPTIMISTIC;
 
-	timeout = addrconf_timeout_fixup(cfg->valid_lft, HZ);
-	if (addrconf_finite_timeout(timeout)) {
-		expires = jiffies_to_clock_t(timeout * HZ);
-		cfg->valid_lft = timeout;
-		flags = RTF_EXPIRES;
-	} else {
-		expires = 0;
-		flags = 0;
-		cfg->ifa_flags |= IFA_F_PERMANENT;
-	}
-
-	timeout = addrconf_timeout_fixup(cfg->preferred_lft, HZ);
-	if (addrconf_finite_timeout(timeout)) {
-		if (timeout == 0)
-			cfg->ifa_flags |= IFA_F_DEPRECATED;
-		cfg->preferred_lft = timeout;
-	}
-
 	if (cfg->peer_pfx &&
 	    memcmp(&ifp->peer_addr, cfg->peer_pfx, sizeof(struct in6_addr))) {
 		if (!ipv6_addr_any(&ifp->peer_addr))
@@ -4992,13 +4942,16 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		  struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
-	struct ifaddrmsg *ifm;
 	struct nlattr *tb[IFA_MAX+1];
 	struct in6_addr *peer_pfx;
 	struct inet6_ifaddr *ifa;
 	struct net_device *dev;
 	struct inet6_dev *idev;
 	struct ifa6_config cfg;
+	struct ifaddrmsg *ifm;
+	unsigned long timeout;
+	clock_t expires;
+	u32 flags;
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
@@ -5028,8 +4981,11 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
 			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
 
+	cfg.ifa_flags |= IFA_F_PERMANENT;
 	cfg.valid_lft = INFINITY_LIFE_TIME;
 	cfg.preferred_lft = INFINITY_LIFE_TIME;
+	expires = 0;
+	flags = 0;
 
 	if (tb[IFA_CACHEINFO]) {
 		struct ifa_cacheinfo *ci;
@@ -5037,6 +4993,27 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ci = nla_data(tb[IFA_CACHEINFO]);
 		cfg.valid_lft = ci->ifa_valid;
 		cfg.preferred_lft = ci->ifa_prefered;
+
+		if (!cfg.valid_lft || cfg.preferred_lft > cfg.valid_lft) {
+			NL_SET_ERR_MSG_MOD(extack, "address lifetime invalid");
+			return -EINVAL;
+		}
+
+		timeout = addrconf_timeout_fixup(cfg.valid_lft, HZ);
+		if (addrconf_finite_timeout(timeout)) {
+			cfg.ifa_flags &= ~IFA_F_PERMANENT;
+			cfg.valid_lft = timeout;
+			expires = jiffies_to_clock_t(timeout * HZ);
+			flags = RTF_EXPIRES;
+		}
+
+		timeout = addrconf_timeout_fixup(cfg.preferred_lft, HZ);
+		if (addrconf_finite_timeout(timeout)) {
+			if (timeout == 0)
+				cfg.ifa_flags |= IFA_F_DEPRECATED;
+
+			cfg.preferred_lft = timeout;
+		}
 	}
 
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
@@ -5064,7 +5041,7 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 * It would be best to check for !NLM_F_CREATE here but
 		 * userspace already relies on not having to provide this.
 		 */
-		return inet6_addr_add(net, dev, &cfg, extack);
+		return inet6_addr_add(net, dev, &cfg, expires, flags, extack);
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
@@ -5072,7 +5049,7 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		NL_SET_ERR_MSG_MOD(extack, "address already assigned");
 		err = -EEXIST;
 	} else {
-		err = inet6_addr_modify(net, ifa, &cfg);
+		err = inet6_addr_modify(net, ifa, &cfg, expires, flags);
 	}
 
 	in6_ifa_put(ifa);
-- 
2.39.5 (Apple Git-154)


