Return-Path: <netdev+bounces-184002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497DA92EAF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CE44A0CF0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5357462;
	Fri, 18 Apr 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RoQuTGcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234D442C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935068; cv=none; b=UuDfeYW08c1c8fpATn/nYtOcrpAE3sRiQaA8aPWGDfvmiXCI+MX17hcNFxi3POca5NSQoLjuYTUe1iExoIDH7AfjYhCNGAT5iTeIbm5wugLR3ePGk2V90qD8RODNnCIuIJWugXkOQrPc45tjhgye9Qdk5K4GB6EHfugOQGnN5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935068; c=relaxed/simple;
	bh=s7CHZqZcsXdyNoNhn9yRvT7Jur7Qmj60erO3CRxPwZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ivd69Eu3kbIt7roKBmYT+iFxARX6L0XTbEhYGZKSyy1ilewWNc+VeE60Mrxo929tMgSpxcgiT7GbKWMmSU3ZDuIKS/sjd5EO2TBTY0fwG33eWr85ImdoGgSXNlNjf9KkuXf7E+Z2D5TnVXiEXGbQtUKjn4b88nZZPxHSCLlUP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RoQuTGcB; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935057; x=1776471057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDBQgMa7jn0o+BB8P/Y+JwNfnTEUqRUfyQn4GsE6RkI=;
  b=RoQuTGcBWEwTJv15SFLct38IgyJLQBY64DhipRPC3EWoHJknDeUkFlmc
   SlWn+0EVxP3oIr5wZY7ofrgf5A5q0neWImJhKnDfbi+iwOTC+CzgdvL6j
   aDOQsGY3vrBjWl/bHEh+zLb4w+BSBZ3CrsIjsUIJmdLVkK8WCG2M6D4dF
   w=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="84707639"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:09:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9668]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id d79657d3-1bd1-46da-b7b6-d36d742e9b38; Fri, 18 Apr 2025 00:09:45 +0000 (UTC)
X-Farcaster-Flow-ID: d79657d3-1bd1-46da-b7b6-d36d742e9b38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:09:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:09:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 12/15] ipv6: Protect fib6_link_table() with spinlock.
Date: Thu, 17 Apr 2025 17:03:53 -0700
Message-ID: <20250418000443.43734-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

If the request specifies a new table ID, fib6_new_table() is
called to create a new routing table.

Two concurrent requests could specify the same table ID, so we
need a lock to protect net->ipv6.fib_table_hash[h].

Let's add a spinlock to protect the hash bucket linkage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


