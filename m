Return-Path: <netdev+bounces-169983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67164A46B16
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC8B3B1AE1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B722505B7;
	Wed, 26 Feb 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I4HZbpbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF524394B
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598246; cv=none; b=haYJElpAPtO6sUXl7b7TkM0kYVe3aTDE2i++NarimaGeE8Nwc2IXYWCGnrLYVsUjY75joLP5SKO5aQW60ROHuHOyaLrwYozUuqY+YD4ljO+iWiX5YyMdZdfILWNm0Wvu4zbEh39z8hQFYDs6L/PZC5p2suqkBmNn0JWqjyeiQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598246; c=relaxed/simple;
	bh=X7HgU2SooqwsdZJaiSDCFA8LRp4qnUVmYOCsQPycZx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSzuGw1r/U04kihZNziQ57YJ7WJKC9EcyvBTE5ZjH37DO+/mTL4JcSbZIo9WIDGApxUiUtmALl1Mn/Sm/zX9LfrRaUnCHcYw6aKCwf9GUO91A+S7HufUwNXFMRZZCEOFWNKuaupVaZIIcS2OfrvDBtfRUQ6ywbThA/Qkt9Fwoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I4HZbpbx; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598244; x=1772134244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10vq9HcFvL/h4/5UOZz3xjreJ3PbRno1kcDII/cclaU=;
  b=I4HZbpbxGG/L2xk6yyXrnAJ0VrxJDSfTayIYld8e2U04m2xvnOKXjH7z
   SPCNdThotQmlysdb8TJtl69Gw4Jbo//N22wdpCfQ1KiJaAklgL+hA4lE9
   t6GRBJVVKZYCWMV90w4guqrQ9e/MqHlApknJacLu/mJaquEtOLuATXZOU
   o=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="381129376"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:29:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:53171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id ed6e0e2c-73c4-437e-8849-113864842a5c; Wed, 26 Feb 2025 19:29:10 +0000 (UTC)
X-Farcaster-Flow-ID: ed6e0e2c-73c4-437e-8849-113864842a5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:27:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:27:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/12] ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
Date: Wed, 26 Feb 2025 11:25:47 -0800
Message-ID: <20250226192556.21633-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will allocate fib_info_hash[] and fib_info_laddrhash[] for each netns.

Currently, fib_info_hash[] is allocated when the first route is added.

Let's move the first allocation to a new __net_init function.

Note that we must call fib4_semantics_exit() in fib_net_exit_batch()
because ->exit() is called earlier than ->exit_batch().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index a68a4eb5e0d1..f00ac983861a 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1421,28 +1421,21 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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
@@ -1863,7 +1856,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 	struct fib_info *fi;
 	int ret = 0;
 
-	if (!fib_info_laddrhash || local == 0)
+	if (!local)
 		return 0;
 
 	head = fib_info_laddrhash_bucket(net, local);
@@ -2265,3 +2258,29 @@ void fib_select_path(struct net *net, struct fib_result *res,
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


