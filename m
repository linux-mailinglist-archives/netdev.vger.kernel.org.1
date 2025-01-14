Return-Path: <netdev+bounces-158018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF8A101C2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2009B3A212D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D523278D;
	Tue, 14 Jan 2025 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EIjNYprX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736D246327
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842188; cv=none; b=VBH6LT0EusPO0yCqhfnjeDqtFiZuDUw8VDxf5/3cufIRWeptY/7fElr44kjC8NikkbzN90QdLwa2L46RgHGh9IUDkFVLOPvf6lSun8N7ARzhoRjRW02fMzQoMtTe8jOyWUGIrZx4d6HIOauInW9eXAO+AyaWuXL8egWMGCflS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842188; c=relaxed/simple;
	bh=6KfdX5F5cHNxhcUqyOChbFJx6O/t9umpF0bw2HZR4lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTbDuyTJepJ3Q0cYCqkOBsW8PGsCkqo86UTh1wyc+VIZoFdUVJvUTXvS0nRsRkhtzNRweXO+9hKi9aiMSXgR62b1jlYo8bikfPDmgatQDwFVyLi6zbpQKe/+HuvqXB+Sjr/Abe2AUCnrP5OmmzfNdoupvuCR3N2QhQnPuaqxMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EIjNYprX; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842186; x=1768378186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYJ07qGioqfCCfebv8MZ1ELCx2+a9ep6x8vxIr660Gc=;
  b=EIjNYprXcUS/1dNkrwTulrs1XbxqTFCaIv0yqRA04Q36l2K5DuP9qYsC
   eT5aVm4R5B7tXyjHL4ch0VmJUWNO4K9hiaCEEIrKTzBzu4ZfP+zXMZPPC
   QT1endjyePFeF2rXJ/I7FsP6SKROf8EyQoi1pwKsN2kbyPO7tIjzhgXw2
   s=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="454037337"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:09:42 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:36492]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.5:2525] with esmtp (Farcaster)
 id e2a14caa-9329-4148-95e0-708c3c461f87; Tue, 14 Jan 2025 08:09:41 +0000 (UTC)
X-Farcaster-Flow-ID: e2a14caa-9329-4148-95e0-708c3c461f87
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:09:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:09:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/11] ipv6: Move lifetime validation to inet6_rtm_newaddr().
Date: Tue, 14 Jan 2025 17:05:14 +0900
Message-ID: <20250114080516.46155-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
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
index 3a2f4501b302..721a4bceb107 100644
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
@@ -5023,6 +4976,9 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	cfg.valid_lft = INFINITY_LIFE_TIME;
 	cfg.preferred_lft = INFINITY_LIFE_TIME;
+	cfg.ifa_flags |= IFA_F_PERMANENT;
+	expires = 0;
+	flags = 0;
 
 	if (tb[IFA_CACHEINFO]) {
 		struct ifa_cacheinfo *ci;
@@ -5030,6 +4986,27 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
 	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
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


