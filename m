Return-Path: <netdev+bounces-176657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55251A6B38D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFA73B851B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4551E5B76;
	Fri, 21 Mar 2025 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IevE6Hi5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16112A1CF
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529877; cv=none; b=h8v3meDuJ6mCynFvwLQTqUT0uCW7INXEaPUGxJcbmN+tTiIo+f6SqkeAgydwkawIOTREz/sc6crTStLM4Ky0n47vthBjTb0N8vffZKWIBGJRvGwbLiamgjcl/SrzQol4OT5P0AOnMzbq4rJJoP9gpW98KDJs++mNMP3FS/E9clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529877; c=relaxed/simple;
	bh=xNU97WSD6rBM8gw4ESGlGIGTSxu7eB9eNjsE5CQFPAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6tDD1XZSRc6uGFWAwksYDC+XyRRIF0kFoLqj1Z15OUl9pC4N8GbimzRgud6DZXq+ktY90rRE0WPK/guB0Ag/5/p8ceUckaCq57gX4uxUWTLlnDvYL7O0KLQyiAr94Md7wAXymyHd0tNbVSNlk9Mz4Vrfrkk6THe9M8AMpsiQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IevE6Hi5; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529875; x=1774065875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76glfmGHtRz+XzKIeLvL8CRAcmfZ5nNKYDKN0AMav8M=;
  b=IevE6Hi5LvKsQoaL+YM2qaJLlcoMYfGFRNlku8lKrI1mIFK+JBzQazXQ
   uDDZXbP5poCBI0gIFsipjCMVfv4oiK0jNhreFRpEo0psVqi1lCkJQMSXB
   TgoyGfs5egeeyXxUttpuYTAGv+iLnHqbOuEmzl+i4jRFXLXl12CUNvomz
   s=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="180556804"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:04:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.176:2525] with esmtp (Farcaster)
 id 3bc04f57-206e-4ccf-81cb-8d0fcf8a55ed; Fri, 21 Mar 2025 04:04:33 +0000 (UTC)
X-Farcaster-Flow-ID: 3bc04f57-206e-4ccf-81cb-8d0fcf8a55ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/13] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
Date: Thu, 20 Mar 2025 21:00:44 -0700
Message-ID: <20250321040131.21057-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_info_create_nh() will be called under RCU.

Then, fib6_nh_init() is also under RCU, but per-cpu memory allocation
is very likely to fail with GFP_ATOMIC while bluk-adding IPv6 routes
and we will see a bunch of this message in dmesg.

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
index 6299cfd9f12a..d50377131506 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3630,10 +3630,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
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
@@ -3693,6 +3695,15 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
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
@@ -3730,6 +3741,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
 
@@ -3754,6 +3771,8 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
 	return rt;
+free_metrics:
+	ip_fib_metrics_put(rt->fib6_metrics);
 free:
 	kfree(rt);
 err:
-- 
2.48.1


