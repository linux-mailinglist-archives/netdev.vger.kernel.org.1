Return-Path: <netdev+bounces-190538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF997AB76FC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1C31BA705F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4529670C;
	Wed, 14 May 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iTY5Pu7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D465213259
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254170; cv=none; b=a7KUPyZamN+kUqbViIdxqU0dg7ZVm1MVQuiqYEgM3QhQUku7s2io7msg+QXRyOSenwHwEDu6Fc+yJes5zF1UFeYu1yf1O60FhaMjAGuW+Q9LCw6YROWlTXPbKuc54dvHTbRpzhwbeOZhEGF50lC+bfPp8C+xEgJ4W7zaxFIepQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254170; c=relaxed/simple;
	bh=sssKmI+GJUxNQmv0gU3xPKWrLzWVaGEg60EXUJOJN6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3w+xmWQw4TG2Ep904Ilhk5sGwRao8em47Ms07+d7m+qDss/8Hoh6bsCv1sM+AAtfTZQ+gdr+SwTzX+E5mNXKfSuApfaJv55l7K4ygXPzAyCY0P35xQGMAA3pYFlT+WV6G7J4SJTnXN2UJ59HPsndV5954S5XQfam/phloEu+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iTY5Pu7Y; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254169; x=1778790169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Q16WL/geTaFZ8k/AfXMX2XKXz7t/OsAIpeTHrghgYA=;
  b=iTY5Pu7Y0HlH2/eZrdf1Lf5oI3d78rdOMzG5ktLJf1XLyyy/VXcWr9r2
   61XZ5sCM4j1MhQKq7tBLOyJEFLzuyDjYg9j1QPwiVRyI2/3GS5Oof7nB8
   g0HG92578fqwELAiB8HLJNwadHj6Q0n9DjLr1gDnh5fcXPyDrI1AUHYJl
   ElNVnDCiA3GYwMx1Fr8OgA+jMXAtWAakbSJ2TYsHdt5pkAV2XanL1SYpu
   p0xTk7WFW5I6EX3pXTjdRTxZ9A7X7RXXOOcFdRcGPZC0Y2IVV1qUU9iac
   3DIg1Bpde0/9VZspY1ForNRjs6g9Z4DG6fTAfO6Exu6V2yG76PS88Srgc
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="93283539"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:22:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:58300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.33:2525] with esmtp (Farcaster)
 id 6cf5dcb3-2215-44d4-894f-71a9f3d6efe7; Wed, 14 May 2025 20:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: 6cf5dcb3-2215-44d4-894f-71a9f3d6efe7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:22:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:22:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/7] ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
Date: Wed, 14 May 2025 13:19:00 -0700
Message-ID: <20250514201943.74456-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

These two commits preallocated two per-cpu variables in
ip6_route_info_create() as fib_nh_common_init() and fib6_nh_init()
were expected to be called under RCU.

  * commit d27b9c40dbd6 ("ipv6: Preallocate nhc_pcpu_rth_output in
    ip6_route_info_create().")
  * commit 5720a328c3e9 ("ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in
    ip6_route_info_create().")

Now these functions can be called without RCU and can use GFP_KERNEL.

Let's revert the commits.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_semantics.c | 10 ++++------
 net/ipv6/route.c         | 34 +++-------------------------------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index dabe2b7044ab..d643bd1a0d9d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -617,12 +617,10 @@ int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 {
 	int err;
 
-	if (!nhc->nhc_pcpu_rth_output) {
-		nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
-							    gfp_flags);
-		if (!nhc->nhc_pcpu_rth_output)
-			return -ENOMEM;
-	}
+	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
+						    gfp_flags);
+	if (!nhc->nhc_pcpu_rth_output)
+		return -ENOMEM;
 
 	if (encap) {
 		struct lwtunnel_state *lwtstate;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index dda913ebd2d3..0143262094b0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3674,12 +3674,10 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		goto out;
 
 pcpu_alloc:
+	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
 	if (!fib6_nh->rt6i_pcpu) {
-		fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
-		if (!fib6_nh->rt6i_pcpu) {
-			err = -ENOMEM;
-			goto out;
-		}
+		err = -ENOMEM;
+		goto out;
 	}
 
 	fib6_nh->fib_nh_dev = dev;
@@ -3739,24 +3737,6 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 	}
 }
 
-static int fib6_nh_prealloc_percpu(struct fib6_nh *fib6_nh, gfp_t gfp_flags)
-{
-	struct fib_nh_common *nhc = &fib6_nh->nh_common;
-
-	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
-	if (!fib6_nh->rt6i_pcpu)
-		return -ENOMEM;
-
-	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
-						    gfp_flags);
-	if (!nhc->nhc_pcpu_rth_output) {
-		free_percpu(fib6_nh->rt6i_pcpu);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 					       gfp_t gfp_flags,
 					       struct netlink_ext_ack *extack)
@@ -3794,12 +3774,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		goto free;
 	}
 
-	if (!cfg->fc_nh_id) {
-		err = fib6_nh_prealloc_percpu(&rt->fib6_nh[0], gfp_flags);
-		if (err)
-			goto free_metrics;
-	}
-
 	if (cfg->fc_flags & RTF_ADDRCONF)
 		rt->dst_nocount = true;
 
@@ -3824,8 +3798,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
 	return rt;
-free_metrics:
-	ip_fib_metrics_put(rt->fib6_metrics);
 free:
 	kfree(rt);
 err:
-- 
2.49.0


