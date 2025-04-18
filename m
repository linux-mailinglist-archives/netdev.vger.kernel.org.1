Return-Path: <netdev+bounces-184000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B40A92EAD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D961B647D5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367307462;
	Fri, 18 Apr 2025 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FpSaRj0r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79691442C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935036; cv=none; b=qngAWtqQPtFKAXSZSHNXSZbV0rU0TzUWjEmQAbVbZPFeGzGiDlfikvgJ5KxW1nchR0/E31PTjRV7zjEqwKUzPMbXTJ6o7dvDKOth28KbFW6LHdgDVog+UH5fnvC1OsqfxuziIq4XDolNoeS2vW+N+HZAjmGoNX4R2/tqHpOhAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935036; c=relaxed/simple;
	bh=xX7FySFNBQ9DLZl87r733wZCDP2+PjZdxfaUFhHnlJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOTtyBAUxyLTRGVfFp8jZcXWRVo2d+UqJy42KNfUzUjyyqFiyhyeqYnxO1wZj84lSzHPwy4+Ej8EYHQULEEs+uiJRbswRM7ShII75QjDO3l74gkUUb56sj2FY8bCPLKdV3lRS9bsYYikueHQ1AqKe0yRGP7xToMrxy2LBBikCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FpSaRj0r; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935035; x=1776471035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/YU7ev4mGLwhdCB8vprRxybPY4K79+jho6X9E3w1Uk=;
  b=FpSaRj0rGisbcMall5WHAlqZfyzj/x2+wkRV26JEjjx/NKpkkvhYW+LT
   cwynyNIsL1NbaCLFeucZWE+MuoaesKOH3Gd/s4XUSmGSj9cWEQpzxHrTs
   wkSmWKf6G9yZeVcTpj/hCiApQGA47ipTY5ct2yqvUrYwnP6hmEhp/OCSs
   g=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512501547"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:10:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:35666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id 645f41fe-a1bb-4402-812b-4fa159bac305; Fri, 18 Apr 2025 00:10:33 +0000 (UTC)
X-Farcaster-Flow-ID: 645f41fe-a1bb-4402-812b-4fa159bac305
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 14/15] ipv6: Protect nh->f6i_list with spinlock and flag.
Date: Thu, 17 Apr 2025 17:03:55 -0700
Message-ID: <20250418000443.43734-15-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we may be going to add a route tied to a dying nexthop.

The nexthop itself is not freed during the RCU grace period, but
if we link a route after __remove_nexthop_fib() is called for the
nexthop, the route will be leaked.

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
v3: Bundle critical section for rt->nh as fib6_add_rt2node_nh()
---
 include/net/nexthop.h |  2 ++
 net/ipv4/nexthop.c    | 18 +++++++++++++++---
 net/ipv6/ip6_fib.c    | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 8 deletions(-)

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
index d9cf06b297d1..6ba6cb1340c1 100644
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
@@ -2118,7 +2119,7 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
 /* not called for nexthop replace */
 static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 {
-	struct fib6_info *f6i, *tmp;
+	struct fib6_info *f6i;
 	bool do_flush = false;
 	struct fib_info *fi;
 
@@ -2129,13 +2130,24 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 	if (do_flush)
 		fib_flush(net);
 
-	/* ip6_del_rt removes the entry from this list hence the _safe */
-	list_for_each_entry_safe(f6i, tmp, &nh->f6i_list, nh_list) {
+	spin_lock_bh(&nh->lock);
+
+	nh->dead = true;
+
+	while (!list_empty(&nh->f6i_list)) {
+		f6i = list_first_entry(&nh->f6i_list, typeof(*f6i), nh_list);
+
 		/* __ip6_del_rt does a release, so do a hold here */
 		fib6_info_hold(f6i);
+
+		spin_unlock_bh(&nh->lock);
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
index 9e9db5470bbf..1f860340690c 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1048,8 +1048,14 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 	rt6_flush_exceptions(rt);
 	fib6_drop_pcpu_from(rt, table);
 
-	if (rt->nh && !list_empty(&rt->nh_list))
-		list_del_init(&rt->nh_list);
+	if (rt->nh) {
+		spin_lock(&rt->nh->lock);
+
+		if (!list_empty(&rt->nh_list))
+			list_del_init(&rt->nh_list);
+
+		spin_unlock(&rt->nh->lock);
+	}
 
 	if (refcount_read(&rt->fib6_ref) != 1) {
 		/* This route is used as dummy address holder in some split
@@ -1341,6 +1347,28 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 	return 0;
 }
 
+static int fib6_add_rt2node_nh(struct fib6_node *fn, struct fib6_info *rt,
+			       struct nl_info *info, struct netlink_ext_ack *extack,
+			       struct list_head *purge_list)
+{
+	int err;
+
+	spin_lock(&rt->nh->lock);
+
+	if (rt->nh->dead) {
+		NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+		err = -EINVAL;
+	} else {
+		err = fib6_add_rt2node(fn, rt, info, extack, purge_list);
+		if (!err)
+			list_add(&rt->nh_list, &rt->nh->f6i_list);
+	}
+
+	spin_unlock(&rt->nh->lock);
+
+	return err;
+}
+
 static void fib6_start_gc(struct net *net, struct fib6_info *rt)
 {
 	if (!timer_pending(&net->ipv6.ip6_fib_timer) &&
@@ -1498,7 +1526,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	}
 #endif
 
-	err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
+	if (rt->nh)
+		err = fib6_add_rt2node_nh(fn, rt, info, extack, &purge_list);
+	else
+		err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
 	if (!err) {
 		struct fib6_info *iter, *next;
 
@@ -1508,8 +1539,6 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			fib6_info_release(iter);
 		}
 
-		if (rt->nh)
-			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
 
 		if (rt->fib6_flags & RTF_EXPIRES)
-- 
2.49.0


