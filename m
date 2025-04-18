Return-Path: <netdev+bounces-183994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD24A92EA2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E062D3BDD44
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA84442C;
	Fri, 18 Apr 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EtpqqN6q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF723DE
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934888; cv=none; b=FPymTfloKHBFZackhb13/XBF6aNY9mu6twTzEbP6iieuRLbmLZFIB2pJvXjsDc2S2PA4F7NL8lNI9dRzO9Wq/uDRbglawBDQUzltNBccF1n2F5zbv1S8kBCc9JUZLx3IlmOoXPp/RcxIDOCe9rRTjo1zBS+8qwr8kt10mX+EttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934888; c=relaxed/simple;
	bh=LXCC3DiTO+MpUZtkieMVJbmIUAMoaxu15xl9NpIgdzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqXw2wNlLs8OmOaWYMsLg17DYKSjnyxARe8HB5Zt5z37UWaRodN5tRo/iOgPc01CTyRk0U8mLLbiA73Xm6budIqoloO2NpJ6gSVVp/RFas1zmVfO+fyCWYDI0dqkFBj6pd8z1qAen8Id7YIjpycCRnlghorDqLx/OxxmS3NyRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EtpqqN6q; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934887; x=1776470887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OsCX6bAx47k1BIW0b5BPQZME3GBSntyrmTDvcdAH6jQ=;
  b=EtpqqN6q5QB26USIR+C+SG6Hs+jyKpvKwGrM2UzeBxlQGslptRzVWHyz
   qwwZgLeWYmc1QcaYBGBl4h9yZGW7nHHO9PtD7/N68cYojNlOUVw2leWSr
   5X7ENVPoOjLxRM/mLh5X4kbEaZlGpLQuImheKm+KyIW0TIoXIcinil2+q
   o=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="192135979"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:06:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:5819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id 62a842f2-fadf-4c55-9f48-cccaabb2ef78; Fri, 18 Apr 2025 00:06:56 +0000 (UTC)
X-Farcaster-Flow-ID: 62a842f2-fadf-4c55-9f48-cccaabb2ef78
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 05/15] ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
Date: Thu, 17 Apr 2025 17:03:46 -0700
Message-ID: <20250418000443.43734-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
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
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/route.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5f370c269e64..06c5414fc14e 100644
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


