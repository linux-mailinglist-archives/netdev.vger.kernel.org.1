Return-Path: <netdev+bounces-180550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E561A81A60
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027631B648A1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A90129D0B;
	Wed,  9 Apr 2025 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="boBzE8WB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70541C695
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161357; cv=none; b=P8PTkY83MFrDsL2VBAjZAZK1FuT8TU3jB5mh1YAkQQX9LimDJ+fbfbHZhBkjEUioixA9gypeVibfkZeL42zSy9dDYrZCooGkDBPgw1j/SYxUdm0ly2yx1QrEzNLfnyPhb2TCJxGHdgd2XvC2k9YcLgxw29NdqoMlc98MZ85uFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161357; c=relaxed/simple;
	bh=WNC7mQY9uLuSJnsl678eTLQKCxGVsRFgT/E/KVB39po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZIkHGSr+rx4Bdakm371P9IevgdV13W0sb2KqoaFHgwP3Ob40hZYJgcHDjddbaH2OkW1pnlK3DTv9sg5EHyy9Fi0yNfC0/40QJU7EAYPVUlIuEx6gxIVT/9ajNeS90m43oFs97xP1VPws3siwQ1wkBkFo7RjkZNhntEUFinD1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=boBzE8WB; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161356; x=1775697356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PkJnDZ5WtRDqoXVJlBGvjFKTOGQ2eWXt0pPAqEMXwMQ=;
  b=boBzE8WBFXl5a1ociWlLaYNgMKfIIfpagNM6hZ4kPW1fmYGu9kixUBT4
   wn8gqQHOA0dpBPp59Hgu5RQagUpw0/hTeuE4180XJPyD1fJtSFPcfi+9R
   Rswl+5GL9eGu2YxLV9m6eC/CsrWEtkdWoFDzNThKL+cUwf9s/AVmgbdLe
   0=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="478735760"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:15:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:8544]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id ca81c5ce-f840-491e-b303-99c612585217; Wed, 9 Apr 2025 01:15:51 +0000 (UTC)
X-Farcaster-Flow-ID: ca81c5ce-f840-491e-b303-99c612585217
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:15:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:15:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/14] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
Date: Tue, 8 Apr 2025 18:12:15 -0700
Message-ID: <20250409011243.26195-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
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
index c236443300b3..470530eee91b 100644
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


