Return-Path: <netdev+bounces-176663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FE9A6B39E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D761E481723
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D821E5B7A;
	Fri, 21 Mar 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V0dUzeXb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE52A1CF
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742530030; cv=none; b=dE8bUjvNcgQ4DxIJNJF+HU1P3d0coxdds1vJnBaWjikW6YXzngtk79WCNit1XKCxSCTUxxaW27ecvBwd84JkzZn34603WOfMjE/UWQFyhmFM2P9Ojim4/4jfuB2MDl2hRkVUoe5Hs0Z25Tq36Olu2udtAomGOGcfQxfgZxs69nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742530030; c=relaxed/simple;
	bh=c80Lncl+hLIhw8DiMAi9dMXHy73A8PY7QkGhPulvxxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS+PZC31fzHg0QJSjNU0GA1/THnD07AA6/+O6rCi1srGTDm7WW4Y5D6xqY8Sp6JOlLGX3mziNphKpeavXQp+iZZh7ihynibeDBjTTSg3mF6J8Y9s1jE1miWtLpHhU8qCB6Fk2tTJzVrgQfNU3yFYesnu9tEosGZ3tMKg+BnMyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V0dUzeXb; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742530028; x=1774066028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUrbQ6SxnLKnz1wFAPr1Cl25aZGvfLvmgaMyDgl1ZNY=;
  b=V0dUzeXb5Rjj/urttQJfN4GcxicSLRoYuuXM6MNSwD0uJXLeswu2dZg3
   d1T6ehEjuMwgzrVuiUwdVrU4AbwnmVg/nguSSzsHIVO8SnfAg+NgODaBb
   0uu60O2nDBGfuuEJ1HVoPlG7y8xRCyrDaL3ZOUdDnjb1zVQwoYUw8WO0k
   M=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="473021916"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:07:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:6088]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.105:2525] with esmtp (Farcaster)
 id c4918cb9-630b-4c41-a144-b6da99908f0e; Fri, 21 Mar 2025 04:07:05 +0000 (UTC)
X-Farcaster-Flow-ID: c4918cb9-630b-4c41-a144-b6da99908f0e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 13/13] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Thu, 20 Mar 2025 21:00:50 -0700
Message-ID: <20250321040131.21057-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.

The remaining things to do are

  1. pass false to lwtunnel_valid_encap_type_attr()
  2. use rcu_dereference_rtnl() in fib6_check_nexthop()
  3. place rcu_read_lock() before ip6_route_info_create_nh().

Let's complete RTNL-free conversion.

When each CPU-X adds 100000 routes on table-X in a batch on
c7a.metal-48xl EC2 instance with 192 CPUs,

without this series:

  $ sudo ./route_test.sh
  ...
  added 19200000 routes (100000 routes * 192 tables).
  Time elapsed: 189154 milliseconds.

with this series:

  $ sudo ./route_test.sh
  ...
  added 19200000 routes (100000 routes * 192 tables).
  Time elapsed: 62531 milliseconds.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c |  4 ++--
 net/ipv6/route.c   | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 94eab81bfe54..dec1a107aa0b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1543,12 +1543,12 @@ int fib6_check_nexthop(struct nexthop *nh, struct fib6_config *cfg,
 	if (nh->is_group) {
 		struct nh_group *nhg;
 
-		nhg = rtnl_dereference(nh->nh_grp);
+		nhg = rcu_dereference_rtnl(nh->nh_grp);
 		if (nhg->has_v4)
 			goto no_v4_nh;
 		is_fdb_nh = nhg->fdb_nh;
 	} else {
-		nhi = rtnl_dereference(nh->nh_info);
+		nhi = rcu_dereference_rtnl(nh->nh_info);
 		if (nhi->family == AF_INET)
 			goto no_v4_nh;
 		is_fdb_nh = nhi->fdb_nh;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a209d8c8ff75..d1d60415d1aa 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3868,12 +3868,16 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
+	rcu_read_lock();
+
 	err = ip6_route_info_create_nh(rt, cfg, extack);
 	if (err)
-		return err;
+		goto unlock;
 
 	err = __ip6_ins_rt(rt, &cfg->fc_nlinfo, extack);
 	fib6_info_release(rt);
+unlock:
+	rcu_read_unlock();
 
 	return err;
 }
@@ -4494,12 +4498,10 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	switch (cmd) {
 	case SIOCADDRT:
-		rtnl_lock();
 		/* Only do the default setting of fc_metric in route adding */
 		if (cfg.fc_metric == 0)
 			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
-		rtnl_unlock();
 		break;
 	case SIOCDELRT:
 		err = ip6_route_del(&cfg, NULL);
@@ -5078,7 +5080,7 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 	} while (rtnh_ok(rtnh, remaining));
 
 	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len,
-					      extack, newroute);
+					      extack, false);
 }
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -5216,7 +5218,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
 		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-						extack, newroute);
+						extack, false);
 		if (err < 0)
 			goto errout;
 	}
@@ -5483,6 +5485,8 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	if (err)
 		return err;
 
+	rcu_read_lock();
+
 	err = ip6_route_mpath_info_create_nh(&rt6_nh_list, extack);
 	if (err)
 		goto cleanup;
@@ -5574,6 +5578,8 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	}
 
 cleanup:
+	rcu_read_unlock();
+
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
 		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
@@ -6856,7 +6862,7 @@ static void bpf_iter_unregister(void)
 
 static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
-	 .doit = inet6_rtm_newroute},
+	 .doit = inet6_rtm_newroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELROUTE,
 	 .doit = inet6_rtm_delroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
-- 
2.48.1


