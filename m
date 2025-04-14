Return-Path: <netdev+bounces-182413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802CA88AE6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6EC1898E80
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261327FD79;
	Mon, 14 Apr 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k6Kr5MmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A75539A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654704; cv=none; b=V5ocWf3ah/gZl/N1wDMdSzKt56rSpU+mN/dP/xcTTm4xShC9xJzuIZgEI5Xtxwk34Cv01bPwVvO7tD8MAATVZgZcGV9Vw6MqE55C06doqRbEV52+7vSEFuescuVCwqGPPVgLZ38WiNO3tSiGTxnYg5/EdER6Pb4+WPtwNCdNst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654704; c=relaxed/simple;
	bh=XsthCKan0dvlKIieVKG19uVuhLX5/zIS+UaEIr70Z5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+AH1jD6IfrnCE5pDPBu6ncHa7zP/GFRi9JU8BKlBIQuZ4LYIdgKs5I2lQ0ZXB9qP+8xkHgezkXG3IUX0zFB+CQzIf//mmpmuvi6UsjEsEr+9Q+I57yQr6L0D2D4b2zgehlFb7LKL1I6/OTcxU/RMqFVxXa60GNHjgD1mWQCT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k6Kr5MmJ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654703; x=1776190703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eqkPM586f+WbYywMNy395jjoPm+aMhZ/N/8La+b9bzY=;
  b=k6Kr5MmJBFvy5uczjHfv9STtAb2JnK8vrxScnDmif44ePPX6llV4SXLu
   LhznC08ljeB6c9TINDUTVD++D3CsPIvL1MD9sG+sPyEFnJzUTdCpz1Q/J
   jWa38A1WULR88garHvKVdA/TjLmWE9fuOHEipokLYT00N7bTH7BDfV3qR
   c=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="288349074"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:18:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:13316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id 6248327c-88c4-4b18-a86b-39f163dff254; Mon, 14 Apr 2025 18:18:18 +0000 (UTC)
X-Farcaster-Flow-ID: 6248327c-88c4-4b18-a86b-39f163dff254
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:18:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:18:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 07/14] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
Date: Mon, 14 Apr 2025 11:14:55 -0700
Message-ID: <20250414181516.28391-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_info_create_nh() will be called under RCU.

Then, fib6_nh_init() is also under RCU, but per-cpu memory allocation
is very likely to fail with GFP_ATOMIC while bluk-adding IPv6 routes
and we would see a bunch of this message in dmesg.

  percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
  percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left

Let's preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().

If something fails before the original memory allocation in
fib6_nh_init(), ip6_route_info_create_nh() calls fib6_info_release(),
which releases the preallocated per-cpu memory.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ce060b59d41a..404da01a7502 100644
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


