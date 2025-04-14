Return-Path: <netdev+bounces-182411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD6A88AE4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79141898EB5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91CC1A5B85;
	Mon, 14 Apr 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KnFnOVmw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CC17C21C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654654; cv=none; b=Y3g7x3fMM/Z9qUP00NYnDXf4xaJZDqxTFBSOaf5GpQ97Ee6frnTTrwfL2lvsXnTx/5gjMxSHBLkx80l+1sxIfBxVYXhipa1B1LWvKdEUK8m2zZsKQtdsSYBG4afhAlZw7/90+eebrC+EtTT47zuKCeveUteCsG+guqiU1oeptgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654654; c=relaxed/simple;
	bh=0zTeX2jIkFGlcf1btxsRpyOt7z/ixfNm7beQA9cc7OE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUNh5yJI0amhrlLKWwR8a0sSpNdS5blYYTYznQm3Jqx2hZ83vvjwclLnPuHRxsQX0ErKp0hWYuJG8OUjozzO61IPGWaFQ+O4BoyPkoI5qyTYdrff75EYBdLnGvNfFyOtVjXvo3yYzOIINU1mTkUMwXwnbjZg9vqZHd6Ap0xv36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KnFnOVmw; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654653; x=1776190653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u2iO8V+QvIEFUVRule+xLtjCMj7TYRLTIivE6f0Hd4A=;
  b=KnFnOVmwJiU3niYGgrM8Xo6Nd4DgL6fiu9JsP9G2ixsmlrB2wkKqln+J
   LNWgL537ruvqgror0uF+BXKThupI3fs4PrS7WZvceMO+ljCrBihCyDsrH
   GqkbRoOsilJdSg5Cd3xAdh+GmT9RkB1ir3N/Sc9Uh4AX8q/XAStNFQmuQ
   w=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="480298808"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:17:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:35705]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 376fa57a-bd4e-44f0-b2c7-494cfcf58f63; Mon, 14 Apr 2025 18:17:30 +0000 (UTC)
X-Farcaster-Flow-ID: 376fa57a-bd4e-44f0-b2c7-494cfcf58f63
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:17:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:17:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 05/14] ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
Date: Mon, 14 Apr 2025 11:14:53 -0700
Message-ID: <20250414181516.28391-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we must perform two lookups for nexthop and dev under RCU
to guarantee their lifetime.

ip6_route_info_create() calls nexthop_find_by_id() first if
RTA_NH_ID is specified, and then allocates struct fib6_info.

nexthop_find_by_id() must be called under RCU, but we do not want
to use GFP_ATOMIC for memory allocation here, which will be likely
to fail in ip6_route_multipath_add().

Let's move nexthop_find_by_id() after the memory allocation so
that we can later split ip6_route_info_create() into two parts:
the sleepable part and the RCU part.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7e35187594e6..808b126de5b3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3733,24 +3733,11 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 {
 	struct net *net = cfg->fc_nlinfo.nl_net;
 	struct fib6_info *rt = NULL;
-	struct nexthop *nh = NULL;
 	struct fib6_table *table;
 	struct fib6_nh *fib6_nh;
-	int err = -EINVAL;
+	int err = -ENOBUFS;
 	int addr_type;
 
-	if (cfg->fc_nh_id) {
-		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
-		if (!nh) {
-			NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
-			goto out;
-		}
-		err = fib6_check_nexthop(nh, cfg, extack);
-		if (err)
-			goto out;
-	}
-
-	err = -ENOBUFS;
 	if (cfg->fc_nlinfo.nlh &&
 	    !(cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_CREATE)) {
 		table = fib6_get_table(net, cfg->fc_table);
@@ -3766,7 +3753,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		goto out;
 
 	err = -ENOMEM;
-	rt = fib6_info_alloc(gfp_flags, !nh);
+	rt = fib6_info_alloc(gfp_flags, !cfg->fc_nh_id);
 	if (!rt)
 		goto out;
 
@@ -3802,12 +3789,27 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	ipv6_addr_prefix(&rt->fib6_src.addr, &cfg->fc_src, cfg->fc_src_len);
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
-	if (nh) {
+
+	if (cfg->fc_nh_id) {
+		struct nexthop *nh;
+
+		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
+		if (!nh) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
+			goto out_free;
+		}
+
+		err = fib6_check_nexthop(nh, cfg, extack);
+		if (err)
+			goto out_free;
+
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
 			err = -ENOENT;
 			goto out_free;
 		}
+
 		rt->nh = nh;
 		fib6_nh = nexthop_fib6_nh(rt->nh);
 	} else {
-- 
2.49.0


