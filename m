Return-Path: <netdev+bounces-183998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6AA92EAB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C814A0BAF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6904A35;
	Fri, 18 Apr 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tXkNngH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF31C32
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935013; cv=none; b=b5q+JDVSkpDR2rxp3JV7gLbUS2cySi7rcGDZX0G4IDTCkVXGtSMslVBLcsBU2Hr5Trf0MIBbm5EYqIeDx7VNJikvNy6bbbBaR4l/30TxIDtR5Wba+obAxsd/z1koj65+alHJ3Xmj3o7jVpzH4Bk878W5eyg50JDZuViBtkXfaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935013; c=relaxed/simple;
	bh=YGkNDMqdZqchvESjOX5O3TZvDoIrMwsn3Bp1pWvp5rY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow48Ogi4c/pyhraycwvySewW76sKyNQzzyGBM359oBYgEudDie3RMkIuThtrYng6KcyjP9MRXIcbzO3BfcJECvkCPh4WK0wUG+A6FP7LDi0A0PpB8R2f8540Jh/k1AiOorztcxaG95wHbbJ/IhC6Y3jzbHgiIeAroVcSKoyrdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tXkNngH5; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935013; x=1776471013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWXCbuUzffdftajprNuLLbXgxV3sgU+WkNBT2DK66P8=;
  b=tXkNngH5SCGFZWBEfN8nJ97BRnkzIEl18kQ/M+w1zoBSU/UlNnYlijEH
   apc54Gpr8CYoEzENOBORiw1aBK5mfxtgx0T9HUd9H8dIyJNl2YOjMHvSz
   5r3O1OEMQsF/Ie/wOn3D6wUdVi3N3gDfBmiJ4kqNqpzBYIKM1m0jj7g+S
   8=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="289448190"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:10:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:28021]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id b9bffe3d-43a4-42ff-8548-54006c614cbd; Fri, 18 Apr 2025 00:10:09 +0000 (UTC)
X-Farcaster-Flow-ID: b9bffe3d-43a4-42ff-8548-54006c614cbd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:10:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 13/15] ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
Date: Thu, 17 Apr 2025 17:03:54 -0700
Message-ID: <20250418000443.43734-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The next patch adds per-nexthop spinlock which protects nh->f6i_list.

When rt->nh is not NULL, fib6_add_rt2node() will be called under the lock.
fib6_add_rt2node() could call fib6_purge_rt() for another route, which
could holds another nexthop lock.

Then, deadlock could happen between two nexthops.

Let's defer fib6_purge_rt() after fib6_add_rt2node().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


