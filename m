Return-Path: <netdev+bounces-190537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73138AB76FB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4004E0928
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B61FECD4;
	Wed, 14 May 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lvPRJyq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DC1DFF7
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254144; cv=none; b=bWX1CzRbLj2vVUKT0icJ/UHD2u4ztTEz5zHqvK9Nip3U2/4/5HdfMkaG5L3g3Umt4n0GLD4/vP65XoBpAfE5jXfWDG5qnSG6JTG+DmaA43ze5hUtQfqEgtBYebs810axRwFqeRmdt+CEorkpB5tcjysvUQrFcWxX3ecHsZaS3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254144; c=relaxed/simple;
	bh=XJS3YIgLBNkZVtk7N4kHLzzSZ66Xa885M3x9Vrwr+Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb/K+n6cYhART5PD1V/7e0l69VzSPMEEC35sS1a+0YSbyVnnxIQtaqMxCRXf/kumQPN3qrS/h1zzM5sR5aAGyHSXApdoRep6NOkYeAymarkqeqPffAkAXHFC703fFkZY6B7fSd9YQNs28JhpxUFbVgrnrpmMbwfxUgp/VqsltaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lvPRJyq8; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254142; x=1778790142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYJJiHc77mIzIMfKHcT1qCNRRfXg/UDIRM6es0PSOyM=;
  b=lvPRJyq8PLiHOi0OoENd4pyv82/xwZ0i0LuyeZc/PTiiZ7J7i5f8vRvQ
   RApj/pdIN9zImiA6nVPo5e/yjr5jyoayFNQdLMVSVos8lZXDLAO/CrLBI
   29pWMA/cAQK2f3AfUSY8fZfAPTmXlLQTUrV0u0u4s8kqRla43axUgpYz0
   srrBb+dkWaZWzCqJ8cc4ahgSXnHINxkc1jzsE4/R+KHJh31uju6v+k9w5
   EOJxgK5yvM3sIJyupHx0k68nM0gSJvARm5vTrk8JmDY4/bOWo6sviGcZ6
   08UPhh86SuML5b47RM7pMEA/WgeZCYmF64Q+xclZ4i4fWFF02/5Uzxct0
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="196931002"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:22:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:8158]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id e995dde0-d36e-4f69-94e3-4f7f9c83a1d1; Wed, 14 May 2025 20:22:20 +0000 (UTC)
X-Farcaster-Flow-ID: e995dde0-d36e-4f69-94e3-4f7f9c83a1d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:22:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:22:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/7] ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
Date: Wed, 14 May 2025 13:18:59 -0700
Message-ID: <20250514201943.74456-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
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


