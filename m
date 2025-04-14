Return-Path: <netdev+bounces-182414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19054A88AE7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723361898F22
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196B288C89;
	Mon, 14 Apr 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HDRjF5Fm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492027FD79
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654733; cv=none; b=oqr9e3Yr9K8um2ikLCZa1BTtv5syvnTzds6oUv1NbeyFzEk5xk1zVJ30Sn17/LYUi/j+byq1+duXVAftM1ajOhE2vIAlNSpZm/rDfmgY9he8WMC9Ci+bfGeEXyHproUxYhu6vwBwzQQlQgAe51cWd+bFX9BtenKwMaMFxWTSZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654733; c=relaxed/simple;
	bh=L0iegh6XMKcn8EQsMHOx4IB4H+fxSzAIA9MRLEV5QnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrW9AhqgR8i/EDrNeLBLqOMLov+aooCW8rPLLHQ40K2rddh5WYD3HLcgVeuxsCGmQpTLB9RHNchSi5lQG1nDyuA+Xsyq2v9gHv9OL10ApoIcHkO/wJXcvrz+gxoyD2e6s8Xp/0caHgB4jvDA0AoGarZ9pBPYEGuVaixRMiRkxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HDRjF5Fm; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654732; x=1776190732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMgboYsi/JoD0ajLMpMv4Tt7dZ89gFX0bb0FLe152fs=;
  b=HDRjF5FmaiI0HwsByo3JUoP/jurLIrgZy76mN3/QTdFTJrSeKEhzjvSH
   e53Wd0OyW907phz3yAfWqUTm00ewGdEaM8pbhdsnafuhUOnyOS+Q8l9dF
   qANJUDRDPsTqy5RBbaMAY1RWcvBhFOxzGRy5yE4UBEmC5JD06KTnC0oz4
   I=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="191017992"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:18:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39764]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id db12a566-8aeb-489f-bf62-8cf3638b6810; Mon, 14 Apr 2025 18:18:42 +0000 (UTC)
X-Farcaster-Flow-ID: db12a566-8aeb-489f-bf62-8cf3638b6810
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:18:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:18:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 08/14] ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
Date: Mon, 14 Apr 2025 11:14:56 -0700
Message-ID: <20250414181516.28391-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
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
index 404da01a7502..7b33f46fdae4 100644
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


