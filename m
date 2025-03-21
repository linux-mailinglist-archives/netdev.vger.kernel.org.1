Return-Path: <netdev+bounces-176661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52193A6B39C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E1D3BB782
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA651E5B76;
	Fri, 21 Mar 2025 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ChVKP0qv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC1E5B66
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529981; cv=none; b=eJLK+J/hYDYLs6AhkIg9amt5K1QailBeCQa0vcH2rOGoNqaeU9hDDDy9hHUDoXnpv0Z4j1WXghC8jOridDf58w2yv4qb1H0JNu2eoh5F0nRKRx7Di65Z59FjSCdxkOVtq9Uq6nbOfiQwaEl2SP3B6dR6fAJkTqrwR4jbIe+P87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529981; c=relaxed/simple;
	bh=fgwx+7iMklHrWb3dDB4HvyWrLV8bhcQrbo12LRwC9pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqcVKPVzY59FAsmP5PzuKKSwEZLhEK0FIATFUl01jCmG4CeFQVzPA5H6YrzhqW6g5a6C51kbFaeV0shSMDgFZ9tKGxlmiSHixILg0pStPUsT7sHKdnJlybwqPAYWMDJi1gpCzG8FEt3S8IAWnE4ZHM1Ha1f2aw/s/geJvzcgcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ChVKP0qv; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529980; x=1774065980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1iaZXUu9i6eVKCq4SxYBsjMkrOGQqppMpVTGSVt7XIo=;
  b=ChVKP0qvJR20309qvwdfKbRL6+TvNzObufe1DZ4PLr3DxxNYuuyAWvs1
   qkKbJdehVtGv4XHAK2FR+F1lKtAD88wQKZuUXluBLjnkaBxqtSh169afO
   h/56L/pdziVf6A/GdW9ZrHMFpmaGxdEZYncTr4EcCN8xumWmkOlO+Hbap
   0=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="504642786"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:06:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:13029]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.45:2525] with esmtp (Farcaster)
 id 88e29678-cdef-4f8d-9401-0aa676ac2cda; Fri, 21 Mar 2025 04:06:12 +0000 (UTC)
X-Farcaster-Flow-ID: 88e29678-cdef-4f8d-9401-0aa676ac2cda
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:06:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/13] ipv6: Protect fib6_link_table() with spinlock.
Date: Thu, 20 Mar 2025 21:00:48 -0700
Message-ID: <20250321040131.21057-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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
index c134ba202c4c..dab091f70f2b 100644
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
2.48.1


