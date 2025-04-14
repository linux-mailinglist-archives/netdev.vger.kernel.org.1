Return-Path: <netdev+bounces-182419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB86A88AEC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AD178B04
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521728A1F8;
	Mon, 14 Apr 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AU5k80ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C27288C94
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654852; cv=none; b=YZjlfMhawJy+AypiBxGqDS5CzwrOQ1WMnJBpLDIaQ8CYFSCJFafLrymA0d4neh29NtbzoP+NJ86SNKb4Mq31atE9SXU40pS4PGgoQDZ1B/gOpJgUEjPZCfvVCY4HC64EgIeouJ4AVvgB3v5mMdA4a3KiuwYFizsOLTwhOk/r3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654852; c=relaxed/simple;
	bh=yqwHSC+ZrOU/b77QfqFX3WmOoNK8Ae1Fu9lk0uQ9+Rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhKk5nujnhEtK6KYxbnhgdX6rBjH0mvdG0bX039vJYRnvKsw1hblROtPsiz211WFwpnliPmf2jGnc2CT74HvvMyzh7EdeE54SG7W5BiWebRObTIzoqPcyP09n++HJvKnnnB0vOMS5p8EVe5TwPBUDfEOuAlg11O54uLthLPwcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AU5k80ao; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654851; x=1776190851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZdh8rMF+q/XqULGU6qPfPEhaQ/b/Ju4EI9IQkvXYVM=;
  b=AU5k80ao9/xbKgw/sfKHzMO98CzgXOY0zPgP4bujI4CQ9WrWWjsfS5+c
   AokkBZlVUILHOEYTO5aCa+0WfVgGiDFaYSuUaQvi24K9S7GFefyQZvBWg
   aVugOUsZ/8c1fOsx+gpGbEqRtla2/60iPNnrQ/zXd2lskBfyn2OtYG88n
   g=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="815946686"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:20:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8409]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 2a91ca03-1dd8-4060-b2a7-948afe2da5ed; Mon, 14 Apr 2025 18:20:44 +0000 (UTC)
X-Farcaster-Flow-ID: 2a91ca03-1dd8-4060-b2a7-948afe2da5ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:20:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:20:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 13/14] ipv6: Protect nh->f6i_list with spinlock and flag.
Date: Mon, 14 Apr 2025 11:15:01 -0700
Message-ID: <20250414181516.28391-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414181516.28391-1-kuniyu@amazon.com>
References: <20250414181516.28391-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
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
 include/net/nexthop.h |  2 ++
 net/ipv4/nexthop.c    | 18 +++++++++++++++---
 net/ipv6/ip6_fib.c    | 30 +++++++++++++++++++++++++-----
 3 files changed, 42 insertions(+), 8 deletions(-)

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
index 467151517023..5e47166512e2 100644
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
index 9e9db5470bbf..dac9596cf532 100644
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
@@ -1498,7 +1504,23 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	}
 #endif
 
-	err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
+	if (rt->nh) {
+		spin_lock(&rt->nh->lock);
+
+		if (rt->nh->dead) {
+			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			err = -EINVAL;
+		} else {
+			err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
+			if (!err)
+				list_add(&rt->nh_list, &rt->nh->f6i_list);
+		}
+
+		spin_unlock(&rt->nh->lock);
+	} else {
+		err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
+	}
+
 	if (!err) {
 		struct fib6_info *iter, *next;
 
@@ -1508,8 +1530,6 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			fib6_info_release(iter);
 		}
 
-		if (rt->nh)
-			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
 
 		if (rt->fib6_flags & RTF_EXPIRES)
-- 
2.49.0


