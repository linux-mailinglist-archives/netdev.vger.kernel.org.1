Return-Path: <netdev+bounces-180554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E05DA81A67
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37C83BF7BB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A6823DE;
	Wed,  9 Apr 2025 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nB8cA03d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968647D07D
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161454; cv=none; b=iOvW8hFwkrFNvdlOoMraRs6LEwEFR3ZQAhYwkWFBBdZhJN+W8twWA59JB4lVSE1pBFfQCJp1Pjfd6OIOoLFQ9fdwRxFuvJExxy/fA5AX532LyWFtuQ0Cajgbq329jD3k0fcZi6L6Zn9eTnc72mpy3TYBrIPEXZV9PqCQUiaqmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161454; c=relaxed/simple;
	bh=dbj49XgZmz0wC6ctWZ8PGws2IiJpCvQytiLXFqIO5vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtGMmAxbjm2xJ3tznrvSrHDgpB4ba3xfKPWOVqKw2/TFoJLXeoIwJhoA0GEIV08xNs/cVlgre8MSiSmrYU4LTFAvtBnGDAJJYltrjtDh4JDa1NYNf7piMJnh8XZUVc1tgOl2NKP4eWHk8rM8pENApLT42HDmxbh8FUvsbbD94Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nB8cA03d; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161453; x=1775697453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+LcftNrfgZBStuLXUDTwTXWBV86Bz2k2ywoX8EI24k=;
  b=nB8cA03d27llR4boopCbKP0QXGwqno8nTe3kbgv5uvv6SBG9yKdmCW7T
   h89C87yhA2qXvRM/6NsqbrA/hiq3PVph26HQAK42EWqBNEUTHj+f5CiGn
   KDVNXyM9801hDfdAiqbqy384FxJ/x3iGvhPAsA/V7AszNLJNLscHW3K0b
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="8764936"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:17:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 697c97e1-e1b2-4107-ab32-28e147975cd8; Wed, 9 Apr 2025 01:17:31 +0000 (UTC)
X-Farcaster-Flow-ID: 697c97e1-e1b2-4107-ab32-28e147975cd8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:17:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:17:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/14] ipv6: Protect fib6_link_table() with spinlock.
Date: Tue, 8 Apr 2025 18:12:19 -0700
Message-ID: <20250409011243.26195-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
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
2.49.0


