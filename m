Return-Path: <netdev+bounces-190923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7449AB9416
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142DF501C4E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0037282EE;
	Fri, 16 May 2025 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hENRkhZt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7D132122
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362663; cv=none; b=YOtG0PUVlONZBHR5wYUlfwDsbBO4nyQUkBytCkjek1Lj3B+OUFBIURsX48stAYdbeE38PBmtC03uwj+Zo7sYNTNvkGaBQMXzgUsgDuNZ7fyPrTgD9JwKyXjK061nkjUnImap9mn780FwucG6AtoA01SCrq7Wom6pEeFbk56gico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362663; c=relaxed/simple;
	bh=sssKmI+GJUxNQmv0gU3xPKWrLzWVaGEg60EXUJOJN6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSrXzRnO5/91WpkVriHOUxWkwAnKRozvOi6czEH+heW9WparIbKwjKsmeJMAOIsSHfLaxCbuM4yXTzLS39L7TBfL4NM6F+TB6AtVaZbfhvjNxkO4zphS0EAee0uPHZG4L0K6syusvbHW3oQXhzrRsOLiyrwCO5EBoG+F5/ytrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hENRkhZt; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362662; x=1778898662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Q16WL/geTaFZ8k/AfXMX2XKXz7t/OsAIpeTHrghgYA=;
  b=hENRkhZt+shQ9uAYu3CIwJHmnunrLM/qDCNfFfpq5iGRXAJH65VU5r63
   1G43Yr4e+dy42kDsDZVaauTmN7xznyHKa6A0lN6M+09aUYol74GtMA0rP
   RnEkdVdC07dmnfeLcOh6KmTRB8JCSDnhAxBJsisOkXUsACNZvLHWksvqt
   jUL4bpivRlal8Fm4UmM1LyPqPf3KabP4d46o+GYKQajWwz+kufcjy6MO5
   PhVo66+r4GXvH8kgfjQ8COg8wmhfU4CqV4aUmnXdzK9qWXlU0/nH8xoOe
   B5y+KY9KoOUI80wIZjtV1CEgExo/FbsF7suxiz96nisLypttwRHtPcCsO
   A==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="825244699"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:31:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16045]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.122:2525] with esmtp (Farcaster)
 id 231d874f-5588-416c-b4a0-5f827b3eaf2d; Fri, 16 May 2025 02:31:01 +0000 (UTC)
X-Farcaster-Flow-ID: 231d874f-5588-416c-b4a0-5f827b3eaf2d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:31:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:30:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/7] ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
Date: Thu, 15 May 2025 19:27:23 -0700
Message-ID: <20250516022759.44392-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516022759.44392-1-kuniyu@amazon.com>
References: <20250516022759.44392-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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


