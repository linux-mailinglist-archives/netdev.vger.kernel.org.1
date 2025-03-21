Return-Path: <netdev+bounces-176658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD5A6B396
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15391889BB2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BF1EB1A9;
	Fri, 21 Mar 2025 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qXT3MWDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5231E9B3D
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529904; cv=none; b=urB/I+F6AogVMd5BFvK3VmE9JeSY98BhhP4paZwZMYZAehRyaR4avnMHWnviUlQRFddHGecOG+TGSIEGKZQ9pqIbXlWKLJrxfvDrRvP8Mt79/Ym93Syn6pSCTs19rcGmfRGhrHtx20ilFQQI2IcRuVrv00HhvbbKw8B48Zgi/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529904; c=relaxed/simple;
	bh=UhzxaBOiYHDOkINpRy36jejUgyjbSgvr0f7OLP5wuaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0xiyi2f0Fo+ZYhJq0CWHZLaVXBcwBvnfNP+R4gzpXZyvohyju42LG3TRe6rVvyixqpPijyr6bib5sYgyCzd5lHIrusocUQxi5TFzTe6qucCGIHiBFG2F96381XXXWpgHjssl+PVvwiICc2qyvIjYqg7g7Wz7Bfiv7wFZDyZ0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qXT3MWDW; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529903; x=1774065903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5dpJ78s4RWlmPiW3uAXfitaErnG4uvCAZ/+qdEl6pA=;
  b=qXT3MWDWHYjnjfCLhfE1/fnDIz+PyEdxuoRewasidHd0Z805UsMGlpqi
   SscB7EHN8T+XwbZ5iiYhnbZDuS/I2exnVCPaLkiA1Tl7kjWaEeZGMsl6E
   gEPjOshaDlftLiBO61m+odd0flLEN8jMcUT8JJ915Ho79VnC1HrA6fLjB
   g=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="473021422"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:04:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:23244]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.119:2525] with esmtp (Farcaster)
 id 2c495aa3-2281-4dc8-ac27-07d172ee5487; Fri, 21 Mar 2025 04:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: 2c495aa3-2281-4dc8-ac27-07d172ee5487
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/13] ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
Date: Thu, 20 Mar 2025 21:00:45 -0700
Message-ID: <20250321040131.21057-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>
References: <20250321040131.21057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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
index d50377131506..e65e2c8b7125 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3697,10 +3697,19 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 
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
2.48.1


