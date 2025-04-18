Return-Path: <netdev+bounces-183999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BBEA92EAC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F428A3357
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A9B67E;
	Fri, 18 Apr 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lrcS/1nz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63494A2D
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935015; cv=none; b=lIYxkMpcKrdsyY+f4Op482VR/wasRCntPQ76544sGHaXUSY5fvmDJZM8mjUouMPyhv8miczPdzOewmJE9Hue4NWc0U0Kl/4cWLSyAjO7JBOXJZ+vx1iLL2eF4iW7DYrXhEX55S+RXgIH9i8iX7+rRUn5OzLcF4dysghxuJTxvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935015; c=relaxed/simple;
	bh=ocxHcpFd/aXAiqEguL79Hk8g2DvC9kRI4VaXt7Pc0/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8DfQJ9GNF62mLSg6WuSRptWOvqfAc8khfXRtjSvtYgEoB6RBo5UoSRV6AWAxBqgMNoDrShX6EHnwqlR8ME9xFgUZ24VlGCk+PHov74KIG9jeTc0tn0jnEEPa3BUpEw8heRuNcPvyvXpigRiQNjJvGRuZTkyTowrQotmKCfQm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lrcS/1nz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935010; x=1776471010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8blhG/i8aGYh/3YoAtrjYC/S1xXErFQ4LA8ZKcBdbc=;
  b=lrcS/1nzBDsZUa1MQHBayee4xfy7O1GKP3WEAnqGeZ14Rzd541ku88vN
   Z8bgytqk7Ki6a28b/yKBApft5kx2nNdFqPse8wZDi+P1SmXM28fZSz07E
   V/d/wFTdmwF9jH9dZxUxvMvrl9MSlt9jZM6Frh4zrUMIsj0hhGgn60Hrk
   0=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="289448017"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:08:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:7157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id 689019fb-99e4-4766-b6b9-8fce679beab4; Fri, 18 Apr 2025 00:08:58 +0000 (UTC)
X-Farcaster-Flow-ID: 689019fb-99e4-4766-b6b9-8fce679beab4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 10/15] ipv6: Rename rt6_nh.next to rt6_nh.list.
Date: Thu, 17 Apr 2025 17:03:51 -0700
Message-ID: <20250418000443.43734-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_multipath_add() allocates struct rt6_nh for each config
of multipath routes to link them to a local list rt6_nh_list.

struct rt6_nh.next is the list node of each config, so the name
is quite misleading.

Let's rename it to list.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/c9bee472-c94e-4878-8cc2-1512b2c54db5@redhat.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index af11fcaa5cf3..05e33d319488 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5314,7 +5314,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 struct rt6_nh {
 	struct fib6_info *fib6_info;
 	struct fib6_config r_cfg;
-	struct list_head next;
+	struct list_head list;
 };
 
 static int ip6_route_info_append(struct list_head *rt6_nh_list,
@@ -5324,7 +5324,7 @@ static int ip6_route_info_append(struct list_head *rt6_nh_list,
 	struct rt6_nh *nh;
 	int err = -EEXIST;
 
-	list_for_each_entry(nh, rt6_nh_list, next) {
+	list_for_each_entry(nh, rt6_nh_list, list) {
 		/* check if fib6_info already exists */
 		if (rt6_duplicate_nexthop(nh->fib6_info, rt))
 			return err;
@@ -5335,7 +5335,7 @@ static int ip6_route_info_append(struct list_head *rt6_nh_list,
 		return -ENOMEM;
 	nh->fib6_info = rt;
 	memcpy(&nh->r_cfg, r_cfg, sizeof(*r_cfg));
-	list_add_tail(&nh->next, rt6_nh_list);
+	list_add_tail(&nh->list, rt6_nh_list);
 
 	return 0;
 }
@@ -5478,7 +5478,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	info->skip_notify_kernel = 1;
 
 	err_nh = NULL;
-	list_for_each_entry(nh, &rt6_nh_list, next) {
+	list_for_each_entry(nh, &rt6_nh_list, list) {
 		err = __ip6_ins_rt(nh->fib6_info, info, extack);
 
 		if (err) {
@@ -5546,16 +5546,16 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 		ip6_route_mpath_notify(rt_notif, rt_last, info, nlflags);
 
 	/* Delete routes that were already added */
-	list_for_each_entry(nh, &rt6_nh_list, next) {
+	list_for_each_entry(nh, &rt6_nh_list, list) {
 		if (err_nh == nh)
 			break;
 		ip6_route_del(&nh->r_cfg, extack);
 	}
 
 cleanup:
-	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
+	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, list) {
 		fib6_info_release(nh->fib6_info);
-		list_del(&nh->next);
+		list_del(&nh->list);
 		kfree(nh);
 	}
 
-- 
2.49.0


