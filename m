Return-Path: <netdev+bounces-183986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B5A92E97
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0202C1B62C6C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0B372;
	Fri, 18 Apr 2025 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iAsOziWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CC173
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934750; cv=none; b=RlQXvhxoUoQJwT6GRgGgZDm97PUlsqNos3InUWFxpo3I3MYeibh6XELXZrQoiEmDxwhO8FYwoKfjVWliDtbl6I7REvoVfUX1S4J2AOjua2Be9GgKSWnoj2WGHwsNE1K8quRINXKKe4FLmBXUvR/xlY8uUHCbpNqCZEXCjYWfqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934750; c=relaxed/simple;
	bh=I/QqMJxyxxM0q5+4qJ9cFi0SsQBPz/qcjS8OZwfP1T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwW53dR0drujg/DRpAtceu3/SmsUgJdU0PzchpmarNAvTxPCBQctCSvAY/iqYu5BmEXSfA5kYtm8xgQ1YSdHq46MtXMbKDdcONJAv/qkImxj+P/cTX1tpq1PHGmWLrBy8djauAinh6hWq92r28/nUbnV8wI6PCPyW1C39hXaquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iAsOziWP; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934749; x=1776470749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9LPb3OYIRQ36IQYyd/1zAtQz/QlRdUHsy9gFQabZkw=;
  b=iAsOziWPPgqvQ91lcA58NT9iarFwcp9+JXKblZ16v4WgLfS50NuNiEBH
   NN0IWpHUTGHy4br+DCGImRJ5vIjmpxiIFYG9pWEA4JHzuzpa4lkh8UCRW
   c4e/J7bNa3tPj+geqPM0b5zGRjjkM2pdpu7V255dTD3PmnnYe5i9PLx8Q
   A=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="490407402"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:05:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28306]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.220:2525] with esmtp (Farcaster)
 id 02f02bbd-f3e1-475c-97b6-27deef9c8bca; Fri, 18 Apr 2025 00:05:44 +0000 (UTC)
X-Farcaster-Flow-ID: 02f02bbd-f3e1-475c-97b6-27deef9c8bca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:05:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:05:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/15] ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
Date: Thu, 17 Apr 2025 17:03:43 -0700
Message-ID: <20250418000443.43734-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Basically, removing an IPv6 route does not require RTNL because
the IPv6 routing tables are protected by per table lock.

inet6_rtm_delroute() calls nexthop_find_by_id() to check if the
nexthop specified by RTA_NH_ID exists.  nexthop uses rbtree and
the top-down walk can be safely performed under RCU.

ip6_route_del() already relies on RCU and the table lock, but we
need to extend the RCU critical section a bit more to cover
__ip6_del_rt().  For example, nexthop_for_each_fib6_nh() and
inet6_rt_notify() needs RCU.

Let's call nexthop_find_by_id() and __ip6_del_rt() under RCU and
get rid of RTNL from inet6_rtm_delroute() and SIOCDELRT.

Even if the nexthop is removed after rcu_read_unlock() in
inet6_rtm_delroute(), __remove_nexthop_fib() cleans up the routes
tied to the nexthop, and ip6_route_del() returns -ESRCH.  So the
request was at least valid as of nexthop_find_by_id(), and it's just
a matter of timing.

Note that we need to pass false to lwtunnel_valid_encap_type_attr().
The following patches also use the newroute bool.

Note also that fib6_get_table() does not require RCU because once
allocated fib6_table is not freed until netns dismantle.  I will
post a follow-up series to convert such callers to RCU-lockless
version.  [0]

Link: https://lore.kernel.org/netdev/20250417174557.65721-1-kuniyu@amazon.com/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3: Add a note that fib6_get_table() does not require RCU
v2: Call __ip6_del_rt() under RCU
---
 net/ipv6/route.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 51f693581b7c..4de7abe5ee02 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4124,9 +4124,9 @@ static int ip6_route_del(struct fib6_config *cfg,
 			if (rt->nh) {
 				if (!fib6_info_hold_safe(rt))
 					continue;
-				rcu_read_unlock();
 
-				return __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				err =  __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				break;
 			}
 			if (cfg->fc_nh_id)
 				continue;
@@ -4141,13 +4141,13 @@ static int ip6_route_del(struct fib6_config *cfg,
 				continue;
 			if (!fib6_info_hold_safe(rt))
 				continue;
-			rcu_read_unlock();
 
 			/* if gateway was specified only delete the one hop */
 			if (cfg->fc_flags & RTF_GATEWAY)
-				return __ip6_del_rt(rt, &cfg->fc_nlinfo);
-
-			return __ip6_del_rt_siblings(rt, cfg);
+				err = __ip6_del_rt(rt, &cfg->fc_nlinfo);
+			else
+				err = __ip6_del_rt_siblings(rt, cfg);
+			break;
 		}
 	}
 	rcu_read_unlock();
@@ -4516,19 +4516,20 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
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
 
@@ -5051,7 +5052,8 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 };
 
 static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
-					struct netlink_ext_ack *extack)
+					struct netlink_ext_ack *extack,
+					bool newroute)
 {
 	struct rtnexthop *rtnh;
 	int remaining;
@@ -5085,15 +5087,16 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
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
 
@@ -5202,7 +5205,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_mp = nla_data(tb[RTA_MULTIPATH]);
 		cfg->fc_mp_len = nla_len(tb[RTA_MULTIPATH]);
 
-		err = rtm_to_fib6_multipath_config(cfg, extack);
+		err = rtm_to_fib6_multipath_config(cfg, extack, newroute);
 		if (err < 0)
 			goto errout;
 	}
@@ -5222,7 +5225,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
 		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-						extack, true);
+						extack, newroute);
 		if (err < 0)
 			goto errout;
 	}
@@ -5545,15 +5548,20 @@ static int inet6_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -6765,7 +6773,7 @@ static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_o
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
 	 .doit = inet6_rtm_newroute},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELROUTE,
-	 .doit = inet6_rtm_delroute},
+	 .doit = inet6_rtm_delroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
 	 .doit = inet6_rtm_getroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
-- 
2.49.0


