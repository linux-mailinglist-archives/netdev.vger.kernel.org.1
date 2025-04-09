Return-Path: <netdev+bounces-180555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B858A81A6A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EBA4C1CB9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084BA158DD8;
	Wed,  9 Apr 2025 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RTxtccqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3B156C6A
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161479; cv=none; b=a59UbnGB4JIROhtTEInLXkbuZh4IFg8ovCs3Ckhf8DwppblpgtPUzDKMCdjwEtnrSubB8w1pzQif1+YCll7OsHDuEQ8uh2lrDn6F5GkHaYMjzGxFRUuEYBR4rdVlBVZUgnaI7XbdiNApPTEAGpreucpRJiE5UlgEqkCxAWnK0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161479; c=relaxed/simple;
	bh=xljfddazrrFm56vBQ/GFRQ501a+71eZ83skbnBLhaRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2zTkhlf12GkOf4lpnv9PpD3AvEG9V8ww3vq///TwJlAMNJ1pJrYJzyzPlKfRVKpYSvNxDQ0KDe90NP+4F2o417CpyUjfSyxP/O8Ow0CM60qq+zMp9lh+7ya1YuDaW1kxElxxqHOELBpcyYiSxKybhKcxIhF65Ir0r6FWGLWllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RTxtccqN; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161478; x=1775697478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyBWL3G95p5nuKio8G4DT0OejK1w9v3ZVGhW1nk4gzA=;
  b=RTxtccqN4LVsX5MPY5q+9/dq5rWxBJ+vod4pmoQprlTThAR6ifchQZAH
   9jcI9SgBkAe7yktFfvvi+dJ/exDdf27XeXDHpHCpIvZY3VYE92MBVDhnq
   GZoP9k0gcbCDxjaI/+cWN2DZGOTejPPyeLWgUoURgs3XIK9ichNi5gpsT
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="481484055"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:17:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:2051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 60ae09dd-57c4-4e9f-9d85-e69d88055adf; Wed, 9 Apr 2025 01:17:56 +0000 (UTC)
X-Farcaster-Flow-ID: 60ae09dd-57c4-4e9f-9d85-e69d88055adf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:17:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:17:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/14] ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
Date: Tue, 8 Apr 2025 18:12:20 -0700
Message-ID: <20250409011243.26195-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The next patch adds per-nexthop spinlock which protects nh->f6i_list.

When rt->nh is not NULL, fib6_add_rt2node() will be called under the lock.
fib6_add_rt2node() could call fib6_purge_rt() for another route, which
could holds another nexthop lock.

Then, deadlock could happen between two nexthops.

Let's defer fib6_purge_rt() after fib6_add_rt2node().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ip6_fib.h |  1 +
 net/ipv6/ip6_fib.c    | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 7c87873ae211..88b0dd4d8e09 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -198,6 +198,7 @@ struct fib6_info {
 					fib6_destroying:1,
 					unused:4;
 
+	struct list_head		purge_link;
 	struct rcu_head			rcu;
 	struct nexthop			*nh;
 	struct fib6_nh			fib6_nh[];
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dab091f70f2b..116bf9dee616 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1083,8 +1083,8 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
  */
 
 static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
-			    struct nl_info *info,
-			    struct netlink_ext_ack *extack)
+			    struct nl_info *info, struct netlink_ext_ack *extack,
+			    struct list_head *purge_list)
 {
 	struct fib6_info *leaf = rcu_dereference_protected(fn->leaf,
 				    lockdep_is_held(&rt->fib6_table->tb6_lock));
@@ -1308,10 +1308,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		}
 		nsiblings = iter->fib6_nsiblings;
 		iter->fib6_node = NULL;
-		fib6_purge_rt(iter, fn, info->nl_net);
+		list_add(&iter->purge_link, purge_list);
 		if (rcu_access_pointer(fn->rr_ptr) == iter)
 			fn->rr_ptr = NULL;
-		fib6_info_release(iter);
 
 		if (nsiblings) {
 			/* Replacing an ECMP route, remove all siblings */
@@ -1324,10 +1323,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (rt6_qualify_for_ecmp(iter)) {
 					*ins = iter->fib6_next;
 					iter->fib6_node = NULL;
-					fib6_purge_rt(iter, fn, info->nl_net);
+					list_add(&iter->purge_link, purge_list);
 					if (rcu_access_pointer(fn->rr_ptr) == iter)
 						fn->rr_ptr = NULL;
-					fib6_info_release(iter);
 					nsiblings--;
 					info->nl_net->ipv6.rt6_stats->fib_rt_entries--;
 				} else {
@@ -1397,6 +1395,7 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	     struct nl_info *info, struct netlink_ext_ack *extack)
 {
 	struct fib6_table *table = rt->fib6_table;
+	LIST_HEAD(purge_list);
 	struct fib6_node *fn;
 #ifdef CONFIG_IPV6_SUBTREES
 	struct fib6_node *pn = NULL;
@@ -1499,8 +1498,16 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	}
 #endif
 
-	err = fib6_add_rt2node(fn, rt, info, extack);
+	err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
 	if (!err) {
+		struct fib6_info *iter, *next;
+
+		list_for_each_entry_safe(iter, next, &purge_list, purge_link) {
+			list_del(&iter->purge_link);
+			fib6_purge_rt(iter, fn, info->nl_net);
+			fib6_info_release(iter);
+		}
+
 		if (rt->nh)
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
-- 
2.49.0


