Return-Path: <netdev+bounces-180557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91681A81A6C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCEE3B1AD5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33D6F305;
	Wed,  9 Apr 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vsryyHzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E94156C40
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161530; cv=none; b=gZ6+q/dji7jQjgMZlUMmzZ53y91EZDyqNIlms7ZUvSGtrW8GW9e01xhF2prfLz3KWJgQIsh9qHo9CRUzp+y52gpF3uDdjjtl4QRJnd5btB8Hx1u7gVTOlaGRUFYEySihtUwdjvF9NIAuhjiL7GlUskJVDGWKhwlkUUetYRGKxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161530; c=relaxed/simple;
	bh=SjhUyTjXhLuXYJZLoYPAjFBU1Ap6OV9cO+SwLitfMzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHBtW7U/n0otW07LJSyOh4ozbnOMRBRLr4hkYP5jEHMyCWL61JT/6ct07PV8GalxIHuhSx94o5F3Tgitep86PmcHuwBIHlin3NfUWweJ+q+xK+2wjulDNKDKQXzRArQBA+7gXef/Gcex2LneZTjkQnlXmiz/9VUMk7PYfY9XFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vsryyHzF; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161529; x=1775697529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhjV/t7xR+oerotYzSPe3v61NmjNSwe7LcK59StRv8Q=;
  b=vsryyHzFLCuD7KGTnRAG0TZzTlnmjz7BEvMOyzNM8UfPeAiHzw25CFD5
   4JZh/C729ZO3rCaUwfs6gJobFH9hlO2/KFV9bnxV096fG1BWeUbHLAvBd
   JIjOR3VC+/Y4pYdueIE1rDjRVA+hQucDSqAO32UDYiynYdpY7SKKllkJF
   w=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="481484170"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:18:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:26689]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id ce5db1d6-e525-4fef-9d97-c1da25fce83e; Wed, 9 Apr 2025 01:18:46 +0000 (UTC)
X-Farcaster-Flow-ID: ce5db1d6-e525-4fef-9d97-c1da25fce83e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:18:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:18:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 14/14] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Tue, 8 Apr 2025 18:12:22 -0700
Message-ID: <20250409011243.26195-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409011243.26195-1-kuniyu@amazon.com>
References: <20250409011243.26195-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
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
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  total routes: 19200006
  Time elapsed: 191577 milliseconds.

with series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  total routes: 19200006
  Time elapsed: 62854 milliseconds.

I changed the number of routes in each table (1000 ~ 100000)
and consistently saw it finish 3x faster with this series.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c |  4 ++--
 net/ipv6/route.c   | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 5e47166512e2..329f33a2be51 100644
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
index 26a0be592632..d6052a7ae12b 100644
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
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
 		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
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


