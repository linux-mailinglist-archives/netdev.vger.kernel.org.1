Return-Path: <netdev+bounces-176662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F152BA6B39D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742383BB77C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342F1E5B83;
	Fri, 21 Mar 2025 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="usgHEWfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52571E5B66
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529998; cv=none; b=BgGpv8nwCyPShyiVzCdEGkwz+IpFeRKhnXAGlZY67iYh5wAYnDyKKBTfx6z12F3SOf3cdp7nHx/3mkPNssQom26vCSPFnqIF3EclCpKDVpIrht7Ftc/J/VImeMEhF/SNKohqZQV7DpbCZ62pKhhKRHiDmaVVXLcBEmY67Z0uTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529998; c=relaxed/simple;
	bh=1AQHgqLA1N5HxMEMcP1cjxM8G4H9CKKQsWdiV6cYGik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am4ynXgHOWq7huHTUNHVrmLHkiZfpQE037Az0+rZlNj7lPvzWy81/7ZJIDY2+mI3PE1bLHv9LRWbuhPJET2b4DjF+G9x5jzjVuDAVLBG1MiKM2gP4bwBE3GVQ/aJ8GzI+gK1k/pOb0+2K7HpSaG58aVK+hGYHqU6prZhuh4VIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=usgHEWfK; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529997; x=1774065997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmOMvl/PQJMWaP2MLo4yUl8+RyhaQP0nveuQ10tUOxE=;
  b=usgHEWfK1Gv9cyT7RVgUmhPHkJ3q0mZZv3qNh6UMoE3eldbu1CFdTbYL
   lAoK9ZOUOv4iQbNTM/CVQ+90gw9VIIYuCNl8rlu0mJpXMBoqLDTJGcWsu
   QxPx/JH0DAFg7OQjSrxyYTZCuwYqK5fBWBNk/s4yCRjj5rsnk35imlXz8
   k=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="473021834"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:06:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:28202]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.231:2525] with esmtp (Farcaster)
 id 23b37812-20cc-47f3-89e5-37b6d01ba7bc; Fri, 21 Mar 2025 04:06:34 +0000 (UTC)
X-Farcaster-Flow-ID: 23b37812-20cc-47f3-89e5-37b6d01ba7bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/13] ipv6: Protect nh->f6i_list with spinlock and flag.
Date: Thu, 20 Mar 2025 21:00:49 -0700
Message-ID: <20250321040131.21057-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we may be going to add a route tied to a dying nexthop.

The nexthop itself is not freed during the RCU graceful period,
but if we link a route after __remove_nexthop_fib() is called for
the nexthop, the route will be leaked.

To avoid the race between IPv6 route addition under RCU vs nexthop
deletion under RTNL, let's add a dead flag and protect it and
nh->f6i_list with a spinlock.

__remove_nexthop_fib() acquires the nexthop's spinlock and sets false
to nh->dead, then calls ip6_del_rt() for the linked route one by one
without the spinlock because fib6_purge_rt() acquires it later.

While adding an IPv6 route, fib6_add() acquires the nexthop lock and
checks the dead flag just before inserting the route.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/nexthop.h |  2 ++
 net/ipv4/nexthop.c    | 20 +++++++++++++++++---
 net/ipv6/ip6_fib.c    | 25 ++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index d9fb44e8b321..572e69cda476 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -152,6 +152,8 @@ struct nexthop {
 	u8			protocol;   /* app managing this nh */
 	u8			nh_flags;
 	bool			is_group;
+	bool			dead;
+	spinlock_t		lock;       /* protect dead and f6i_list */
 
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 01df7dd795f0..94eab81bfe54 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -541,6 +541,7 @@ static struct nexthop *nexthop_alloc(void)
 		INIT_LIST_HEAD(&nh->f6i_list);
 		INIT_LIST_HEAD(&nh->grp_list);
 		INIT_LIST_HEAD(&nh->fdb_list);
+		spin_lock_init(&nh->lock);
 	}
 	return nh;
 }
@@ -2105,7 +2106,7 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
 /* not called for nexthop replace */
 static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 {
-	struct fib6_info *f6i, *tmp;
+	struct fib6_info *f6i;
 	bool do_flush = false;
 	struct fib_info *fi;
 
@@ -2116,13 +2117,26 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 	if (do_flush)
 		fib_flush(net);
 
-	/* ip6_del_rt removes the entry from this list hence the _safe */
-	list_for_each_entry_safe(f6i, tmp, &nh->f6i_list, nh_list) {
+	spin_lock_bh(&nh->lock);
+
+	nh->dead = true;
+
+	while (1) {
+		f6i = list_first_entry_or_null(&nh->f6i_list, typeof(*f6i), nh_list);
+		if (!f6i)
+			break;
+
+		spin_unlock_bh(&nh->lock);
+
 		/* __ip6_del_rt does a release, so do a hold here */
 		fib6_info_hold(f6i);
 		ipv6_stub->ip6_del_rt(net, f6i,
 				      !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
+
+		spin_lock_bh(&nh->lock);
 	}
+
+	spin_unlock_bh(&nh->lock);
 }
 
 static void __remove_nexthop(struct net *net, struct nexthop *nh,
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dab091f70f2b..a1aab33b2558 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1048,8 +1048,12 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 	rt6_flush_exceptions(rt);
 	fib6_drop_pcpu_from(rt, table);
 
-	if (rt->nh && !list_empty(&rt->nh_list))
-		list_del_init(&rt->nh_list);
+	if (rt->nh) {
+		spin_lock(&rt->nh->lock);
+		if (!list_empty(&rt->nh_list))
+			list_del_init(&rt->nh_list);
+		spin_unlock(&rt->nh->lock);
+	}
 
 	if (refcount_read(&rt->fib6_ref) != 1) {
 		/* This route is used as dummy address holder in some split
@@ -1499,10 +1503,21 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	}
 #endif
 
-	err = fib6_add_rt2node(fn, rt, info, extack);
+	if (rt->nh) {
+		spin_lock(&rt->nh->lock);
+		if (rt->nh->dead) {
+			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			err = -EINVAL;
+		} else {
+			err = fib6_add_rt2node(fn, rt, info, extack);
+			if (!err)
+				list_add(&rt->nh_list, &rt->nh->f6i_list);
+		}
+		spin_unlock(&rt->nh->lock);
+	} else {
+		err = fib6_add_rt2node(fn, rt, info, extack);
+	}
 	if (!err) {
-		if (rt->nh)
-			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
 
 		if (rt->fib6_flags & RTF_EXPIRES)
-- 
2.48.1


