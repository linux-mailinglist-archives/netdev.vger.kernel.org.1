Return-Path: <netdev+bounces-182417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B1A88AEA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37623B0BD0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66FB28A1F8;
	Mon, 14 Apr 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HRbugtUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299127FD79
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654801; cv=none; b=Oq6FJZT7byFlqby2qcsFIimad+SWJOCGoHjho+IRdWJFDIzlMH/U/ri6ZncKdd13jlBbExHQmgRHVwz984tg4shl29pXIRiQu2xrH1OdL45QPe8Ia0mZDAZkOVkC67SmQlkzQJmfMTjgiLV752ScQQKmUiD/qbfI2+0I+jHXQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654801; c=relaxed/simple;
	bh=8Um8Y5ofOW+j6mM564a4kUX1OkpLCR+k4mUSaII+w4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8sZebfCN5+KWcPqq7xgFbNbaQcP3HBojntnMyURjFELP7mGa0Gm2aabBBzZgh1hAsQeArh8dWVnfxHEZN2JRgl0MxA+kpVzjezEBnQ6XvZuZ3ISRI65oMWUCYvt21b53Jj5RMximq+Adtwmg7p8c+2S9aVZbG1w9wTAyECsKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HRbugtUP; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654800; x=1776190800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+bzTaYLkHwO3qYEXHz/jTd3YjeoDA/kP+cqQ7LA1tM=;
  b=HRbugtUPCIS/CUUxqXbzq7pdMv0sAYdEIbZZ7QK0U6Sq2EeKzO3Lye3w
   9mFj1sm0fUqKOJYnkAyCfxPIg9rEq1wMBlMJ+nIkRxMy143LG5rlat/hO
   DUnZoKtIscIsxfwLC78m3lhK1U/KziGpG6BNKiQyEd10AhGBFd/PuN7Lv
   A=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="713728135"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:19:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:48633]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 49908037-8c2f-4db9-ad4e-5f140333d17f; Mon, 14 Apr 2025 18:19:56 +0000 (UTC)
X-Farcaster-Flow-ID: 49908037-8c2f-4db9-ad4e-5f140333d17f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 11/14] ipv6: Protect fib6_link_table() with spinlock.
Date: Mon, 14 Apr 2025 11:14:59 -0700
Message-ID: <20250414181516.28391-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

If the request specifies a new table ID, fib6_new_table() is
called to create a new routing table.

Two concurrent requests could specify the same table ID, so we
need a lock to protect net->ipv6.fib_table_hash[h].

Let's add a spinlock to protect the hash bucket linkage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_fib.c       | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 5f2cfd84570a..47dc70d8100a 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -72,6 +72,7 @@ struct netns_ipv6 {
 	struct rt6_statistics   *rt6_stats;
 	struct timer_list       ip6_fib_timer;
 	struct hlist_head       *fib_table_hash;
+	spinlock_t		fib_table_hash_lock;
 	struct fib6_table       *fib6_main_tbl;
 	struct list_head	fib6_walkers;
 	rwlock_t		fib6_walker_lock;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bf727149fdec..79b672f3fc53 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -249,19 +249,33 @@ static struct fib6_table *fib6_alloc_table(struct net *net, u32 id)
 
 struct fib6_table *fib6_new_table(struct net *net, u32 id)
 {
-	struct fib6_table *tb;
+	struct fib6_table *tb, *new_tb;
 
 	if (id == 0)
 		id = RT6_TABLE_MAIN;
+
 	tb = fib6_get_table(net, id);
 	if (tb)
 		return tb;
 
-	tb = fib6_alloc_table(net, id);
-	if (tb)
-		fib6_link_table(net, tb);
+	new_tb = fib6_alloc_table(net, id);
+	if (!new_tb)
+		return NULL;
+
+	spin_lock_bh(&net->ipv6.fib_table_hash_lock);
+
+	tb = fib6_get_table(net, id);
+	if (unlikely(tb)) {
+		spin_unlock_bh(&net->ipv6.fib_table_hash_lock);
+		kfree(new_tb);
+		return tb;
+	}
 
-	return tb;
+	fib6_link_table(net, new_tb);
+
+	spin_unlock_bh(&net->ipv6.fib_table_hash_lock);
+
+	return new_tb;
 }
 EXPORT_SYMBOL_GPL(fib6_new_table);
 
@@ -2423,6 +2437,8 @@ static int __net_init fib6_net_init(struct net *net)
 	if (!net->ipv6.fib_table_hash)
 		goto out_rt6_stats;
 
+	spin_lock_init(&net->ipv6.fib_table_hash_lock);
+
 	net->ipv6.fib6_main_tbl = kzalloc(sizeof(*net->ipv6.fib6_main_tbl),
 					  GFP_KERNEL);
 	if (!net->ipv6.fib6_main_tbl)
-- 
2.49.0


