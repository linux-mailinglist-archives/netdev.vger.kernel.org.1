Return-Path: <netdev+bounces-190917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4567AB9407
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA74C9E6165
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE8227E84;
	Fri, 16 May 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YldsuS34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9F34CF9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362521; cv=none; b=L2N38wowKOqibqzOVodYe13DAbzuwFvlcn5IvlqVoqfas63n7uVhyu5FEToJAkrXFEqkgAEPxavItvhUcsCrZTOxe83qirpQM9OVi9hbEXQI8hxhKGq/1HlVjI8/u91tgR6SaH5il0A9WUux1QFFnctGNaD846w4+hrzzjdx3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362521; c=relaxed/simple;
	bh=av006DZeEI1Tgi4m56tegR+XkDYrUrTokf0njjxK8Jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO+aVa/teRXOdYK6WNyzW1ivGgq1dH2f7h0FFX0nas8wpaSU0V0tAtaTFLfY/44yeR7hctvgCG5Ly5atsTwHVjJGESfXPeaX1lKCbsjsFIeUef8m1z5yDv3+S0G0KMiRmTalGD+j2sXkR00UKxJbcf/famgF1iBNFeeqRNVJXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YldsuS34; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362520; x=1778898520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3Bkb1uDXTzJxRKH54/m4ladxZTSz3CHA5xNpoMYNN8=;
  b=YldsuS34Emp5/vywjMLB6x+HfwpCKvUOwNFZ8+N99hT0D99+yLqZyd8W
   ecZSzKoOo7BYh+cWljxDKWy39QzxC3SKy9fb5f/lc+3kisiB1Wo2GzsFz
   yP0BTMS8w1Mp8nwgjBagXzL6RH6euiLwT5Ym97kw+W+p7aN8fylvR39Gj
   X7OVMqSoh6zB4yp6fJM5oOGW4fMW21ryFCkM6Xd0pz0MIbXYq7NqUFads
   bTzptrGpO722F7jEN005twKyoTtwagh77L2mgEjalbCIWgPDoHZXIZ/VR
   8qlCnN8RqDlSdA5wuXsHEtl6eBuEBqZ+qD7+d65JzhcyKFRfyeV9IR5O8
   g==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="723279198"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:28:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:4831]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id 96b21ff1-7495-4c20-b4f0-26e7d2c9ac4d; Fri, 16 May 2025 02:28:35 +0000 (UTC)
X-Farcaster-Flow-ID: 96b21ff1-7495-4c20-b4f0-26e7d2c9ac4d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/7] ipv6: Remove rcu_read_lock() in fib6_get_table().
Date: Thu, 15 May 2025 19:27:17 -0700
Message-ID: <20250516022759.44392-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once allocated, the IPv6 routing table is not freed until
netns is dismantled.

fib6_get_table() uses rcu_read_lock() while iterating
net->ipv6.fib_table_hash[], but it's not needed and
rather confusing.

Because some callers have this pattern,

  table = fib6_get_table();

  rcu_read_lock();
  /* ... use table here ... */
  rcu_read_unlock();

  [ See: addrconf_get_prefix_route(), ip6_route_del(),
         rt6_get_route_info(), rt6_get_dflt_router() ]

and this looks illegal but is actually safe.

Let's remove rcu_read_lock() in fib6_get_table() and pass true
to the last argument of hlist_for_each_entry_rcu() to bypass
the RCU check.

Note that protection is not needed but RCU helper is used to
avoid data-race.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_fib.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 1f860340690c..88770ecd2da1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -281,22 +281,20 @@ EXPORT_SYMBOL_GPL(fib6_new_table);
 
 struct fib6_table *fib6_get_table(struct net *net, u32 id)
 {
-	struct fib6_table *tb;
 	struct hlist_head *head;
-	unsigned int h;
+	struct fib6_table *tb;
 
-	if (id == 0)
+	if (!id)
 		id = RT6_TABLE_MAIN;
-	h = id & (FIB6_TABLE_HASHSZ - 1);
-	rcu_read_lock();
-	head = &net->ipv6.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-		if (tb->tb6_id == id) {
-			rcu_read_unlock();
+
+	head = &net->ipv6.fib_table_hash[id & (FIB6_TABLE_HASHSZ - 1)];
+
+	/* See comment in fib6_link_table().  RCU is not required,
+	 * but rcu_dereference_raw() is used to avoid data-race.
+	 */
+	hlist_for_each_entry_rcu(tb, head, tb6_hlist, true)
+		if (tb->tb6_id == id)
 			return tb;
-		}
-	}
-	rcu_read_unlock();
 
 	return NULL;
 }
-- 
2.49.0


