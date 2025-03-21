Return-Path: <netdev+bounces-176652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D2A6B386
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B62E7A35B7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0F4120B;
	Fri, 21 Mar 2025 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eiljMtWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF211ADC93
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529757; cv=none; b=BZKE0A9ewnBM5mgnBDKFwM2yFnER/VjRGQKzMbYky8IUHPCpeeqGQRrIiYSPhwtjyfC3uweEB/Rq9KmY69mJyEuqU3/tUwch9br+7grlh/LqK3x7CIXEKcSl0zADm8Q3ilbQxqjR4ICEYuSw5MEfOHbOYrSIt3DcabTDGetGPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529757; c=relaxed/simple;
	bh=cRTUSyZYAk+3+JIFs8OUszyPgUftTF6JYUwFks1+XFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHd165qRVXNapZZCfDBQlbnKUFwcF5dqXmazr9tKdNQ2n8luy+0J45i+lf2D+ewmsm7GKXcITXFkXaNhKwbaqitEtVLcBYReEiJjT8y7XeBqiZnRgyu7aeWVZFd0p6gNfEOJXNFYwl7ZcClwGC9Td8lyvWyF6L5p66yX3p2JTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eiljMtWI; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529755; x=1774065755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yVfca1C4xlVwk36jd4PEpNGlfkB96iV0sOBWQ/2wNQ=;
  b=eiljMtWI72hg7paYqW3/1wSdOqfEvJmfHiICDbc51In+aUzY+/lV3ZKQ
   JYXKaRiNuwAh75WHhwVdZXeyNlBnezZyHpmev1A2coXyEk20oWU1cZ97e
   pKaOzAJjJL8Znxe8bqdIZ1KPM1pJYju2/Sae9pHBKmikoTGD5V5PFtciX
   I=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="180556352"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:02:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:55471]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.118:2525] with esmtp (Farcaster)
 id f7affa5a-6777-40d6-b34e-30a438f97822; Fri, 21 Mar 2025 04:02:32 +0000 (UTC)
X-Farcaster-Flow-ID: f7affa5a-6777-40d6-b34e-30a438f97822
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/13] ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
Date: Thu, 20 Mar 2025 21:00:39 -0700
Message-ID: <20250321040131.21057-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>
References: <20250321040131.21057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Basically, removing an IPv6 route does not require RTNL because
the IPv6 routing tables are protected by per table lock.  Also,
ip6_route_del() already relies on RCU and the table lock.

inet6_rtm_delroute() calls nexthop_find_by_id() to check if the
nexthop specified by RTA_NH_ID exists.  nexthop uses rbtree and
the top-down walk can be safely performed under RCU.

Let's call nexthop_find_by_id() under RCU and get rid of RTNL
from inet6_rtm_delroute() and SIOCDELRT.

Even if the nexthop is removed after rcu_read_unlock() in
inet6_rtm_delroute(), __remove_nexthop_fib() cleans up the routes
tied to the nexthop, and ip6_route_del() returns -ESRCH.  So the
request was at least valid as of nexthop_find_by_id(), and it's just
a matter of timing.

Note that we need to pass false to lwtunnel_valid_encap_type_attr().
The following patches also use the newroute bool.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6c9c99fb02fe..b737b242079e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4482,19 +4482,20 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	rtmsg_to_fib6_config(net, rtmsg, &cfg);
 
-	rtnl_lock();
 	switch (cmd) {
 	case SIOCADDRT:
+		rtnl_lock();
 		/* Only do the default setting of fc_metric in route adding */
 		if (cfg.fc_metric == 0)
 			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
+		rtnl_unlock();
 		break;
 	case SIOCDELRT:
 		err = ip6_route_del(&cfg, NULL);
 		break;
 	}
-	rtnl_unlock();
+
 	return err;
 }
 
@@ -5017,7 +5018,8 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 };
 
 static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
-					struct netlink_ext_ack *extack)
+					struct netlink_ext_ack *extack,
+					bool newroute)
 {
 	struct rtnexthop *rtnh;
 	int remaining;
@@ -5051,15 +5053,16 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 	} while (rtnh_ok(rtnh, remaining));
 
 	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len,
-					      extack, true);
+					      extack, newroute);
 }
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 			      struct fib6_config *cfg,
 			      struct netlink_ext_ack *extack)
 {
-	struct rtmsg *rtm;
+	bool newroute = nlh->nlmsg_type == RTM_NEWROUTE;
 	struct nlattr *tb[RTA_MAX+1];
+	struct rtmsg *rtm;
 	unsigned int pref;
 	int err;
 
@@ -5168,7 +5171,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_mp = nla_data(tb[RTA_MULTIPATH]);
 		cfg->fc_mp_len = nla_len(tb[RTA_MULTIPATH]);
 
-		err = rtm_to_fib6_multipath_config(cfg, extack);
+		err = rtm_to_fib6_multipath_config(cfg, extack, newroute);
 		if (err < 0)
 			goto errout;
 	}
@@ -5188,7 +5191,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
 		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-						extack, true);
+						extack, newroute);
 		if (err < 0)
 			goto errout;
 	}
@@ -5511,15 +5514,20 @@ static int inet6_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (cfg.fc_nh_id &&
-	    !nexthop_find_by_id(sock_net(skb->sk), cfg.fc_nh_id)) {
-		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
-		return -EINVAL;
+	if (cfg.fc_nh_id) {
+		rcu_read_lock();
+		err = !nexthop_find_by_id(sock_net(skb->sk), cfg.fc_nh_id);
+		rcu_read_unlock();
+
+		if (err) {
+			NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
+			return -EINVAL;
+		}
 	}
 
-	if (cfg.fc_mp)
+	if (cfg.fc_mp) {
 		return ip6_route_multipath_del(&cfg, extack);
-	else {
+	} else {
 		cfg.fc_delete_all_nh = 1;
 		return ip6_route_del(&cfg, extack);
 	}
@@ -6731,7 +6739,7 @@ static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_o
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
 	 .doit = inet6_rtm_newroute},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELROUTE,
-	 .doit = inet6_rtm_delroute},
+	 .doit = inet6_rtm_delroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
 	 .doit = inet6_rtm_getroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
-- 
2.48.1


