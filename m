Return-Path: <netdev+bounces-180556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F4A81A6B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204F8887403
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819F155333;
	Wed,  9 Apr 2025 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cOH1Tt6U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82607D07D
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161504; cv=none; b=SuC2fHhWMKLjwB8fKx9Hp/pWqh8roq2eOwFONlt+H+4QvwK73niGnOE0V3mfm7lcCaTxW1gXrjb50xIdDXiHxcPOvdA8TpHCsPbK/txz4Sat86Yv7ndZKoyAAwV5ThrkLg5Z8IhJWoL3skOr/8qfL5jUlv22OBvV36LHPuYU1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161504; c=relaxed/simple;
	bh=rCyXlK0EcemX1miOC+2PyL3cbgaKLVirCooMVTWTPgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpgPdjM3WVcS+uHxcH2AqqeTQmjUpCAq5v3UV7Jp/qQbM72Mj1K+5GbR664fcPw7SmGfq3axTOOvTzHnHj1OMJP7ZjNvWuBUleDeiG/SMx1E6Gs0qGjmg4t4BnIfSFnuVNv7qlarkGgJNwSwyinYZEcwt6XOSzRsUI2zyoe03sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cOH1Tt6U; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161503; x=1775697503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guY0/A6XyEzAwSv3WfaGRnGtgdU9QfRex+QnkNhs5qo=;
  b=cOH1Tt6U7MLwQLRAEaPi3PaFU/N3nuKn16uvrnbbIyCXkT03DtfR3t2Q
   H59/113+tU5HT86/fqYMN6CPb5AuEV61BncQvjJu0JdivpEXY86Z/GxTN
   YtxMZSSjCtqRgM/f893c1qkHl4nyK1nozN+F7dDS2SVBAZSBDY9gCaGF0
   E=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="734037078"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:18:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:32843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id 127cbc29-0b63-4b80-8e3f-ab835d7a6f8d; Wed, 9 Apr 2025 01:18:20 +0000 (UTC)
X-Farcaster-Flow-ID: 127cbc29-0b63-4b80-8e3f-ab835d7a6f8d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:18:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:18:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 13/14] ipv6: Protect nh->f6i_list with spinlock and flag.
Date: Tue, 8 Apr 2025 18:12:21 -0700
Message-ID: <20250409011243.26195-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
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
index 116bf9dee616..c5155de2ab53 100644
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


