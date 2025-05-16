Return-Path: <netdev+bounces-190922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1FAB9411
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC516A14F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850BD3211;
	Fri, 16 May 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RjBOpnSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8C10E5
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362644; cv=none; b=GO7INtb49ZvzNbepVHY+wFBebJYauVKw+jD1/DQuBIuR2OPHVVMDidPcxqBEAsvXO/c1hb8klI5CUFwqiv4Vh6FfaB90p/DraJwxBWTIm31S/YV0coNlN+t+gcy4RyQK/RLQ999ihpIq88OPqCO8tipfFCiwm2tOficaaO0XFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362644; c=relaxed/simple;
	bh=XJS3YIgLBNkZVtk7N4kHLzzSZ66Xa885M3x9Vrwr+Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bjza+1GtIDslGvS7qGmRcL/MdPS3ORY7bYjyqf9KdFprXoNiPoUtroPcXv2IH6q9YySAEw09hSmEHK430yTsW9Ghy8rNiVKZCR/NCb2evXyMH0fZL/9gGTxI/Ss0XyojID7d3hxtuMOPSePDC5coWdoyRORD5kWsoU2cvvLf/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RjBOpnSC; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362643; x=1778898643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYJJiHc77mIzIMfKHcT1qCNRRfXg/UDIRM6es0PSOyM=;
  b=RjBOpnSCB1jVfXCq90kg2Vj/npREjugyhxrELPFx88UCk7aNFTRUSpq/
   dLryyg51v6NR7hdHQgAM86vfj6VnwQUezYJ5emj7aeg2oHj28z9QEprcL
   aGTPH1ZmVx94y35W7g+YsqsU8VeJ+I4+lSYrW95fUz9oDT5Bi17KvHbbM
   TNQt6XOBwQ/Bv+UMJ84QX+20lNIyc8qzsYKp067x8kRA0IbTsiBbsliaX
   oipkqgDumZGXRHInLfFPgZChzmu9vFnkm9qRPKHSihTjsmekhQpl/Spmb
   PYNDSEAcozsv1INC7Mf0F4nkL7zZB86n3G3LwxXkUUDHloB77GM6IYAli
   A==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="825244652"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:30:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:32246]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id 7b79994c-dd6d-4250-a24e-58f4b5938e05; Fri, 16 May 2025 02:30:37 +0000 (UTC)
X-Farcaster-Flow-ID: 7b79994c-dd6d-4250-a24e-58f4b5938e05
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:30:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:30:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/7] ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
Date: Thu, 15 May 2025 19:27:22 -0700
Message-ID: <20250516022759.44392-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit c4837b9853e5 ("ipv6: Split ip6_route_info_create()."),
ip6_route_info_create_nh() uses GFP_ATOMIC as it was expected to be
called under RCU.

Now, we can call it without RCU and use GFP_KERNEL.

Let's pass gfp_flags to ip6_route_info_create_nh().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 96ae21da9961..dda913ebd2d3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3834,6 +3834,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 
 static int ip6_route_info_create_nh(struct fib6_info *rt,
 				    struct fib6_config *cfg,
+				    gfp_t gfp_flags,
 				    struct netlink_ext_ack *extack)
 {
 	struct net *net = cfg->fc_nlinfo.nl_net;
@@ -3869,7 +3870,7 @@ static int ip6_route_info_create_nh(struct fib6_info *rt,
 	} else {
 		int addr_type;
 
-		err = fib6_nh_init(net, rt->fib6_nh, cfg, GFP_ATOMIC, extack);
+		err = fib6_nh_init(net, rt->fib6_nh, cfg, gfp_flags, extack);
 		if (err)
 			goto out_release;
 
@@ -3917,7 +3918,7 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
-	err = ip6_route_info_create_nh(rt, cfg, extack);
+	err = ip6_route_info_create_nh(rt, cfg, gfp_flags, extack);
 	if (err)
 		return err;
 
@@ -4707,7 +4708,7 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 	if (IS_ERR(f6i))
 		return f6i;
 
-	err = ip6_route_info_create_nh(f6i, &cfg, extack);
+	err = ip6_route_info_create_nh(f6i, &cfg, gfp_flags, extack);
 	if (err)
 		return ERR_PTR(err);
 
@@ -5471,7 +5472,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 			goto cleanup;
 		}
 
-		err = ip6_route_info_create_nh(rt, &r_cfg, extack);
+		err = ip6_route_info_create_nh(rt, &r_cfg, GFP_KERNEL, extack);
 		if (err) {
 			rt = NULL;
 			goto cleanup;
-- 
2.49.0


