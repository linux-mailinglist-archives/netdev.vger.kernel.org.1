Return-Path: <netdev+bounces-183995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C00A92EA3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BC84A1D14
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E821442C;
	Fri, 18 Apr 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f037affS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8879EA
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934896; cv=none; b=C5TPfYDoGKTfzQ/EgrhufaUY3Aiu/4geic4XGD4M1KjWjY8EOLq6lR9NVJRpqujJqjKTCWQ11E7rSntebCZHjL0YNFDGVV/NVYDJEDHjvttv29qyVmZrXSjgzEMYH6F5MzGBQSsm0SE3ll+Nc8ciQGfABwv6m7JTiUS4Wy2Ntg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934896; c=relaxed/simple;
	bh=k/8qX0BNwgh176hMRAi+XVQ3knseryLGwqugBHGY5Lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b15L/haTR+aFAL1ktmmZJqDN4SruKy+T8ax6QLdITAq1YCsx9EzTfiwfcYi3lhdnXqruxjOkBjk6ePm9yJAqXENtSWsK3Sty5ALuZhpixae3a/jXw3sCcstmE/9I5dm2J58kLUR+0OHYoIaOQM644ixRo+fE9rb5Z7csoWNTgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f037affS; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934894; x=1776470894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/vIwFPrQWzVaKDGSkoh0hV7FgliOgaH5bk4sHYD+Sc=;
  b=f037affSWL2Jn/Sl9ltYIkf7+XDilNfnOu+CT55YygCEi7ukGUUDJe7/
   IHEFEZ6Fw94euAEc+qkTw/zTxOOQhJ0ftY/UcMrOd3+MxpvBdVN94vRtP
   ktm7FewU+MjeSXhKMo5Fl6x1kHhAraYp2C1yQmkWDcPQGIQhK4uyMUhcs
   k=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="736588014"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:08:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:56926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id 4df646f8-28ca-497a-8aa6-08d3e18d79ef; Fri, 18 Apr 2025 00:08:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4df646f8-28ca-497a-8aa6-08d3e18d79ef
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 08/15] ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
Date: Thu, 17 Apr 2025 17:03:49 -0700
Message-ID: <20250418000443.43734-9-kuniyu@amazon.com>
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
index b0ddb73c732e..ea755027cf61 100644
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


