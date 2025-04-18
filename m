Return-Path: <netdev+bounces-183993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451FA92E9F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71041B6467C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD791C32;
	Fri, 18 Apr 2025 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bfJ/h4UL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC924372
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934868; cv=none; b=k1953+H+IEEcGNQZvjR3ZB5mC+SZTHWIZYh1hHM8GTBpSwaiYRoiJI9zR6nd/Bymu1HprtrAdXXUu7GEaR6P7zxDTqKfIcep7W4LXefsnQ0stqpASvkSvrnlUFE6QqcrEhYZeSzDmfnKjzJBU55M5srIxhBMnrrTAt8OAiyegEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934868; c=relaxed/simple;
	bh=0VjY1ESLr76PmkuLVTZHldsHAtwKKI8bX3QbI6POrR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIcSOx5HZnBoNw4ozLRvmd7W/iIvV6mvPPz72hIa4ZJw3xCklPvR15pPN5JH0bw0blzllPy11l8eqNDmXZKEnocJInwZtXGynUzVDuMfGYNlOMr3U66Ttn1juDCa4tR2Sddl/jKUzkLw9AWNj7FZsNtY+gBQa9XmW8/Q6qvL1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bfJ/h4UL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934866; x=1776470866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/9Ib4uAPeswRKX89M/H+u2dIGhKz124xau90Arp5DY=;
  b=bfJ/h4ULLU2DKl5H8HAl2xJChgqeItIR57l4D/khMBsmxcIt+hgOBYcI
   f1TGtSSeI9cPkndtAfJfVAC+9Ve/257AWEeX8F6I5S6SLn+/9gKfI4S2s
   3tlfflUbLglaFx3zHWmXAdY9QB/iGdZgY00ZPJD93bvSPRsbBZ6F24Pba
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="192136091"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:07:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:40033]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id 38dd2e39-73db-440b-b4d6-6b67a6b66bf5; Fri, 18 Apr 2025 00:07:45 +0000 (UTC)
X-Farcaster-Flow-ID: 38dd2e39-73db-440b-b4d6-6b67a6b66bf5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:07:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:07:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 07/15] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
Date: Thu, 17 Apr 2025 17:03:48 -0700
Message-ID: <20250418000443.43734-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_info_create_nh() will be called under RCU.

Then, fib6_nh_init() is also under RCU, but per-cpu memory allocation
is very likely to fail with GFP_ATOMIC while bulk-adding IPv6 routes
and we would see a bunch of this message in dmesg.

  percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
  percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left

Let's preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().

If something fails before the original memory allocation in
fib6_nh_init(), ip6_route_info_create_nh() calls fib6_info_release(),
which releases the preallocated per-cpu memory.

Note that rt->fib6_nh->rt6i_pcpu is not preallocated when called via
ipv6_stub, so we still need alloc_percpu_gfp() in fib6_nh_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3: Explain alloc_percpu_gfp() is still needed when called via ipv6_stub.
---
 net/ipv6/route.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7328404c77c1..b0ddb73c732e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3664,10 +3664,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		goto out;
 
 pcpu_alloc:
-	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
 	if (!fib6_nh->rt6i_pcpu) {
-		err = -ENOMEM;
-		goto out;
+		fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
+		if (!fib6_nh->rt6i_pcpu) {
+			err = -ENOMEM;
+			goto out;
+		}
 	}
 
 	fib6_nh->fib_nh_dev = dev;
@@ -3727,6 +3729,15 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 	}
 }
 
+static int fib6_nh_prealloc_percpu(struct fib6_nh *fib6_nh, gfp_t gfp_flags)
+{
+	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
+	if (!fib6_nh->rt6i_pcpu)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 					       gfp_t gfp_flags,
 					       struct netlink_ext_ack *extack)
@@ -3764,6 +3775,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		goto free;
 	}
 
+	if (!cfg->fc_nh_id) {
+		err = fib6_nh_prealloc_percpu(&rt->fib6_nh[0], gfp_flags);
+		if (err)
+			goto free_metrics;
+	}
+
 	if (cfg->fc_flags & RTF_ADDRCONF)
 		rt->dst_nocount = true;
 
@@ -3788,6 +3805,8 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
 	return rt;
+free_metrics:
+	ip_fib_metrics_put(rt->fib6_metrics);
 free:
 	kfree(rt);
 err:
-- 
2.49.0


