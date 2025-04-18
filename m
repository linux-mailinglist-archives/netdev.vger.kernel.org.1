Return-Path: <netdev+bounces-184001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575BA92EAE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015EF1B6484F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A77462;
	Fri, 18 Apr 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FCYV1bC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41064A28
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935061; cv=none; b=XNZciwV+MOWnriCaiaxI0CMXYT9C058adsHVopzxJsT3VbY4QcKcHB/h+UyEGj0kh1I4GZuAGSkwqoKwTRAVJI6Mq4Rk9gBvhmWeCpN/IN1+P5QjgSK5h3vvUdWdjjjm9hLiXTuC+03xQ6POF6eLo/maVcsO2azvUOP4jwsn4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935061; c=relaxed/simple;
	bh=wCkyCKZDA2qFtOXwoxT0MpoO7W9rsomVx4NAYQYLLHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaPGHLPff3QcB9x959qQ5X8Y+v6K07SOo4uSfwpGOQqGVYX30VIb7HNasfh9NXHCHgijjqD3EINKt8v9A+x20T0i7nBNb/ewb4tNhyy36Jogg8qYkrNcbBZx52R4JAfKbw1zwkKMA8/32/RthJAmIWIIJCO2TjEFRXH6R+HTu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FCYV1bC5; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935060; x=1776471060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XgyMnDVwBP4DHemFo3dGiC1WYM3h6jTM1r5Bw8Tf9Dg=;
  b=FCYV1bC54C9S6MM7/M3MBxFs9bWxL6hoPXmivPO7iQHx2ZW5UeAGmZ9v
   xqjf+aSRX4Z46Nu7/0Xm+AHT8ISrgiqd2NjF5MTtu+fahw6uvz/oA6iJj
   Sv84iypZSbs7Sq+LxkwCZ92UapmxJyev5kWhOCBFo67l4JLAym3F/FBte
   4=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="490408267"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:10:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:5000]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.220:2525] with esmtp (Farcaster)
 id 2ad56887-35ac-4ec9-875c-beed4632b621; Fri, 18 Apr 2025 00:10:57 +0000 (UTC)
X-Farcaster-Flow-ID: 2ad56887-35ac-4ec9-875c-beed4632b621
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Thu, 17 Apr 2025 17:03:56 -0700
Message-ID: <20250418000443.43734-16-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.

The remaining things to do are

  1. pass false to lwtunnel_valid_encap_type_attr()
  2. use rcu_dereference_rtnl() in fib6_check_nexthop()
  3. place rcu_read_lock() before ip6_route_info_create_nh().

Let's complete the RTNL-free conversion.

When each CPU-X adds 100000 routes on table-X in a batch
concurrently on c7a.metal-48xl EC2 instance with 192 CPUs,

without this series:

  $ sudo ./route_test.sh
  ...
  added 19200000 routes (100000 routes * 192 tables).
  time elapsed: 191577 milliseconds.

with this series:

  $ sudo ./route_test.sh
  ...
  added 19200000 routes (100000 routes * 192 tables).
  time elapsed: 62854 milliseconds.

I changed the number of routes in each table (1000 ~ 100000)
and consistently saw it finish 3x faster with this series.

Note that now every caller of lwtunnel_valid_encap_type() passes
false as the last argument, and this can be removed later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c |  4 ++--
 net/ipv6/route.c   | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6ba6cb1340c1..823e4a783d2b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1556,12 +1556,12 @@ int fib6_check_nexthop(struct nexthop *nh, struct fib6_config *cfg,
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
index c8c1c75268e3..bb46e724db73 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3902,12 +3902,16 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
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
@@ -4528,12 +4532,10 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
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
@@ -5112,7 +5114,7 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 	} while (rtnh_ok(rtnh, remaining));
 
 	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len,
-					      extack, newroute);
+					      extack, false);
 }
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -5250,7 +5252,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
 		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-						extack, newroute);
+						extack, false);
 		if (err < 0)
 			goto errout;
 	}
@@ -5517,6 +5519,8 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	if (err)
 		return err;
 
+	rcu_read_lock();
+
 	err = ip6_route_mpath_info_create_nh(&rt6_nh_list, extack);
 	if (err)
 		goto cleanup;
@@ -5608,6 +5612,8 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	}
 
 cleanup:
+	rcu_read_unlock();
+
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, list) {
 		fib6_info_release(nh->fib6_info);
 		list_del(&nh->list);
@@ -6890,7 +6896,7 @@ static void bpf_iter_unregister(void)
 
 static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
-	 .doit = inet6_rtm_newroute},
+	 .doit = inet6_rtm_newroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELROUTE,
 	 .doit = inet6_rtm_delroute, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETROUTE,
-- 
2.49.0


