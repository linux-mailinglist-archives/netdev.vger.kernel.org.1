Return-Path: <netdev+bounces-180551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1FBA81A62
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54599887429
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687727D07D;
	Wed,  9 Apr 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SRVq6K4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B16258A
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161380; cv=none; b=Oo4eLfG+evaLkwSL+/IQPP05zDpw28qMcKL2iqh/6azJrtGVXYeMZuGOC5oR50jNpJ6vriExumsY6ox5BPpZb69+uIw+X+MR7JRM5UXZIJwjxN4vVPy+zZubzUULirftdn2b4F8LJKACKS1ZjOQSBqSuGWEfteR/YvI/iE9Tri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161380; c=relaxed/simple;
	bh=GGjRInyyLUKojSv0+MvGYLHtlojrO0b1sZ0L/WDWcTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqUIlsCf6oV4JpIi6YUyn29+/q+wnbUArBvWHVbkxRIN0IzWjqk8Af2oZclFUcg0yI+D/HYYTS9+N6THO5A7YTiZcRTF15DgcE5ofiQ3vXppHQeyuJzv6Otwcwchcvb49O/QVS+T8L7mam6P8U9OsByBpcsKLdQKX9AynHwMiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SRVq6K4i; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161379; x=1775697379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFyv8kcaRvB7m4OpsMVjjZ2umJs9tQGmbYaySUBd0V8=;
  b=SRVq6K4i+VdP0aaIBTh1BrNpu+tV+/6A5Q4hLNBCQB/lDwSk56VyBmFl
   Vx02avb3m6v1JiIgKb3uhujUColzf46hfxifAviyVZiv1gMFS7stO4pys
   vh9b4kEP9dBnR8+6KTiZgpLn/zFdJO881T7mkMmVPPivkPcNLmLeSb+Oe
   4=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="286831427"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:16:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:59762]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 6d0ec5ba-f5b9-415f-aa2e-660c255d3ffa; Wed, 9 Apr 2025 01:16:16 +0000 (UTC)
X-Farcaster-Flow-ID: 6d0ec5ba-f5b9-415f-aa2e-660c255d3ffa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:16:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:16:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/14] ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
Date: Tue, 8 Apr 2025 18:12:16 -0700
Message-ID: <20250409011243.26195-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_info_create_nh() will be called under RCU.

It calls fib_nh_common_init() and allocates nhc->nhc_pcpu_rth_output.

As with the reason for rt->fib6_nh->rt6i_pcpu, we want to avoid
GFP_ATOMIC allocation for nhc->nhc_pcpu_rth_output under RCU.

Let's preallocate it in ip6_route_info_create().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_semantics.c | 10 ++++++----
 net/ipv6/route.c         |  9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f68bb9e34c34..5326f1501af0 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -617,10 +617,12 @@ int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 {
 	int err;
 
-	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
-						    gfp_flags);
-	if (!nhc->nhc_pcpu_rth_output)
-		return -ENOMEM;
+	if (!nhc->nhc_pcpu_rth_output) {
+		nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
+							    gfp_flags);
+		if (!nhc->nhc_pcpu_rth_output)
+			return -ENOMEM;
+	}
 
 	if (encap) {
 		struct lwtunnel_state *lwtstate;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 470530eee91b..f5a405c09268 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3731,10 +3731,19 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 
 static int fib6_nh_prealloc_percpu(struct fib6_nh *fib6_nh, gfp_t gfp_flags)
 {
+	struct fib_nh_common *nhc = &fib6_nh->nh_common;
+
 	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
 	if (!fib6_nh->rt6i_pcpu)
 		return -ENOMEM;
 
+	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
+						    gfp_flags);
+	if (!nhc->nhc_pcpu_rth_output) {
+		free_percpu(fib6_nh->rt6i_pcpu);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-- 
2.49.0


