Return-Path: <netdev+bounces-170551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98521A49043
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9675816E8FC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8F195FE8;
	Fri, 28 Feb 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JS8DsG7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EB819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716701; cv=none; b=Et3TIJwTAEYSeSSaPx2QnO6cNWDguFddq+UBb4gA4cf8Qy7La0lvtmYLSpNT4MEJQNGY/vcEDAHpkj0owLxJt3zvg/icmOR3cIbsXEyRVRnmzsG1PrpmiXPjKvqY8WGjea4/2G/58I/ZAdH+xRaz7ULTz2mRB4O365qihMcQ59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716701; c=relaxed/simple;
	bh=pBdyIgIy2/u6mV5UPaJoZK/A9AbbsMWdKQK4h4zjnXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAH7XaeLJluTFeBzYvhsYHSKGvBrffBP42bbNLWlkhrfKr2qgOTbuGbheuZod/N1EUyzFcxlLiHkNkXdqhqcl5Id2ZV0CcDdQpr9gTUQnJuoD+NBZ/bMJ/QTKz9dePZJN1ZgXctuOjINs2n/Fw7NHQlQoFyIDVpBpR94zNwWM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JS8DsG7r; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716700; x=1772252700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RYp7sjW+bl1GcIlVzF9DwdITd34Ep5bNEEpvALG6gE=;
  b=JS8DsG7rjSW+rnTchx5CdXNsN+fgT6iukAhOfp3QRnWpEZ8L5WJx2jta
   3cYjiNaDe79UfS5DlnPNqvBE/uUo/1J4gNVBpx9L1sZm5qTGqZlojfHGG
   zd1FJNB2ZvPu6vZyxVSQ5zAzvoww4gNZdTcMUAKZUVgEYk/kRaP95lz6O
   U=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="381638537"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:24:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:41638]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.176:2525] with esmtp (Farcaster)
 id 16e2ec4e-9029-4b2d-95d5-cc29c0abd2de; Fri, 28 Feb 2025 04:24:57 +0000 (UTC)
X-Farcaster-Flow-ID: 16e2ec4e-9029-4b2d-95d5-cc29c0abd2de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 03/12] ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
Date: Thu, 27 Feb 2025 20:23:19 -0800
Message-ID: <20250228042328.96624-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will allocate fib_info_hash[] and fib_info_laddrhash[] for each netns.

Currently, fib_info_hash[] is allocated when the first route is added.

Let's move the first allocation to a new __net_init function.

Note that we must call fib4_semantics_exit() in fib_net_exit_batch()
because ->exit() is called earlier than ->exit_batch().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v2:
  * Fix memleak by calling fib4_semantics_exit() properly
  * Move fib4_semantics_exit() to fib_net_exit_batch()
---
 include/net/ip_fib.h     |  2 ++
 net/ipv4/fib_frontend.c  | 11 ++++++++++
 net/ipv4/fib_semantics.c | 45 ++++++++++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a113c11ab56b..e3864b74e92a 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -162,6 +162,8 @@ struct fib_info {
 	struct fib_nh		fib_nh[] __counted_by(fib_nhs);
 };
 
+int __net_init fib4_semantics_init(struct net *net);
+void __net_exit fib4_semantics_exit(struct net *net);
 
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 struct fib_rule;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 6730e2034cf8..40c062f820f2 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1615,9 +1615,15 @@ static int __net_init fib_net_init(struct net *net)
 	error = ip_fib_net_init(net);
 	if (error < 0)
 		goto out;
+
+	error = fib4_semantics_init(net);
+	if (error)
+		goto out_semantics;
+
 	error = nl_fib_lookup_init(net);
 	if (error < 0)
 		goto out_nlfl;
+
 	error = fib_proc_init(net);
 	if (error < 0)
 		goto out_proc;
@@ -1627,6 +1633,8 @@ static int __net_init fib_net_init(struct net *net)
 out_proc:
 	nl_fib_lookup_exit(net);
 out_nlfl:
+	fib4_semantics_exit(net);
+out_semantics:
 	rtnl_lock();
 	ip_fib_net_exit(net);
 	rtnl_unlock();
@@ -1648,6 +1656,9 @@ static void __net_exit fib_net_exit_batch(struct list_head *net_list)
 		ip_fib_net_exit(net);
 
 	rtnl_unlock();
+
+	list_for_each_entry(net, net_list, exit_list)
+		fib4_semantics_exit(net);
 }
 
 static struct pernet_operations fib_net_ops = {
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 23aae379ba42..b7e2023bf742 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1420,28 +1420,21 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	}
 #endif
 
-	err = -ENOBUFS;
-
 	if (fib_info_cnt >= fib_info_hash_size) {
+		unsigned int new_hash_bits = fib_info_hash_bits + 1;
 		struct hlist_head *new_info_hash;
-		unsigned int new_hash_bits;
-
-		if (!fib_info_hash_bits)
-			new_hash_bits = 4;
-		else
-			new_hash_bits = fib_info_hash_bits + 1;
 
 		new_info_hash = fib_info_hash_alloc(new_hash_bits);
 		if (new_info_hash)
 			fib_info_hash_move(new_info_hash, 1 << new_hash_bits);
-
-		if (!fib_info_hash_size)
-			goto failure;
 	}
 
 	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
-	if (!fi)
+	if (!fi) {
+		err = -ENOBUFS;
 		goto failure;
+	}
+
 	fi->fib_metrics = ip_fib_metrics_init(cfg->fc_mx, cfg->fc_mx_len, extack);
 	if (IS_ERR(fi->fib_metrics)) {
 		err = PTR_ERR(fi->fib_metrics);
@@ -1862,7 +1855,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 	struct fib_info *fi;
 	int ret = 0;
 
-	if (!fib_info_laddrhash || local == 0)
+	if (!local)
 		return 0;
 
 	head = fib_info_laddrhash_bucket(net, local);
@@ -2264,3 +2257,29 @@ void fib_select_path(struct net *net, struct fib_result *res,
 			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
 	}
 }
+
+int __net_init fib4_semantics_init(struct net *net)
+{
+	unsigned int hash_bits = 4;
+
+	if (!net_eq(net, &init_net))
+		return 0;
+
+	fib_info_hash = fib_info_hash_alloc(hash_bits);
+	if (!fib_info_hash)
+		return -ENOMEM;
+
+	fib_info_hash_bits = hash_bits;
+	fib_info_hash_size = 1 << hash_bits;
+	fib_info_laddrhash = fib_info_hash + fib_info_hash_size;
+
+	return 0;
+}
+
+void __net_exit fib4_semantics_exit(struct net *net)
+{
+	if (!net_eq(net, &init_net))
+		return;
+
+	fib_info_hash_free(fib_info_hash);
+}
-- 
2.39.5 (Apple Git-154)


