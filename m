Return-Path: <netdev+bounces-182418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5375A88AEB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A86C189903F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AF288C94;
	Mon, 14 Apr 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RQ+4ku8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AD2DFA4D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654825; cv=none; b=JTmy6pvfx+soriZbOY7DK9EyVms8hRr54Ed5cpN6Fue6SNmm9udacEfO5Xaro7qqecd4p5ySH2cx3SGPaw0c18C9uP9stTD21qBN1dwjkmQseA00SWh0LC2LtydUvwpM4nq+cz7IQEE76cTUdPGz8ZDZdMPSFf8B9tq1IQXEBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654825; c=relaxed/simple;
	bh=MfkQCmfWSxCtpRRKBiC5j2r4L+93knS7/A9laJnNKjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0kk8eik/1XolU3+rkfkCWwRy03aRAf1AkM2wePGucOo28Oi4T6+L0aBelaLg69GqK/GCfJquZTxp84ghjA+dGNkZMiyLzqnfTbS+YtDAedY5X9iFPUTgryGqmgRx+7USzal9WbGqWD07Ax2XIm0mLvBOhXjXtVl+XZT/rseUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RQ+4ku8Y; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654824; x=1776190824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK+h3wQqyBSLs4zcjp/60mO3401fHh/haMP7OjQHHJs=;
  b=RQ+4ku8YUjOZFslrxRMCdnaWL1dLDxXTmu+lrRjWWN5wW40g5wJU5vVq
   RT8AHBswRpGi5y+F5epW6Z+e5LOJHqC58s7NxOmiHbF9UESaPdWfv+Sl8
   B4uPTt60XpU4pngg1luDBH01qMZv6eZNWjva9IkdoNWNQZ2n5kETbpmu8
   k=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="489315611"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:20:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:40038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 7d667632-186d-45f6-b7f2-65b0b6fb8623; Mon, 14 Apr 2025 18:20:19 +0000 (UTC)
X-Farcaster-Flow-ID: 7d667632-186d-45f6-b7f2-65b0b6fb8623
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:20:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:20:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 12/14] ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
Date: Mon, 14 Apr 2025 11:15:00 -0700
Message-ID: <20250414181516.28391-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
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
index 79b672f3fc53..9e9db5470bbf 100644
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


