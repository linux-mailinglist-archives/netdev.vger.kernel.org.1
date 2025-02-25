Return-Path: <netdev+bounces-169575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9701A44A64
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C0F3ABE04
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C319EEC2;
	Tue, 25 Feb 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zdvf7OzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD01547F8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507868; cv=none; b=NrgNZXEYyk8ZFTm85cB5t4fN2MLbWXwh9GwzGiES0Z9UmzwT0BmvbCI++d1yaj/DcwND+vVn8wldN/UYhCpP+a47BOsuJ3PI0yjbouFN9eQ0/RMR723f4EwYR7JWcJFtHERUSVC7rqkKzOikwKMamVCCGe6DzNgVP1CoJfsDYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507868; c=relaxed/simple;
	bh=pTrS50UrAKy1J93trNooj9xNLJKGQrH88v3pxNpIlJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzLPFwdMo2QjoNVX03gVWWsvYcUhI8gKBfycUWhDzTNgCS1QbKXMqHqoxP614MQE8wdTcSECsfylZS1ot5oAFLdfQC/6/J9zp5q43t+BkMo4cCABdz5u+mi0/HXYJxXbbnaimJgNL9/nUPAi2HddQOCdevmKAmnElWBgM9hK6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zdvf7OzL; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507867; x=1772043867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+QarZnAxWbwS+OcBvn5AvEnnndu8SzFmsMMexD2NMY=;
  b=Zdvf7OzLH/aBPtFXf/49Ex7zy+kwToXD8PcGJV4qcwBarWsfknwncElj
   iGxyb/0Om/bMGrSEiVHA4plcCrdAgcvGrhu61+IyGQaPHOaOl5UeBgjHi
   YgYOmUFZLIfXMQVhgavoHMCpLlajhxas9ECfmvKS8fmscEPNtaTRvCdZw
   c=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="69147468"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:24:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:58041]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id 334b2faf-c54e-4ac5-9f40-efe0e2cad126; Tue, 25 Feb 2025 18:24:23 +0000 (UTC)
X-Farcaster-Flow-ID: 334b2faf-c54e-4ac5-9f40-efe0e2cad126
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:24:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:24:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
Date: Tue, 25 Feb 2025 10:22:41 -0800
Message-ID: <20250225182250.74650-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will allocate fib_info_hash[] and fib_info_laddrhash[] for each netns.

Currently, fib_info_hash[] is allocated when the first route is added.

Let's move the first allocation to a new __net_init function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ip_fib.h     |  2 ++
 net/ipv4/fib_frontend.c  |  9 ++++++++
 net/ipv4/fib_semantics.c | 45 ++++++++++++++++++++++++++++------------
 3 files changed, 43 insertions(+), 13 deletions(-)

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
index 6730e2034cf8..dbf84c23ca09 100644
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
+	fib4_semantics_init(net);
+out_semantics:
 	rtnl_lock();
 	ip_fib_net_exit(net);
 	rtnl_unlock();
@@ -1637,6 +1645,7 @@ static void __net_exit fib_net_exit(struct net *net)
 {
 	fib_proc_exit(net);
 	nl_fib_lookup_exit(net);
+	fib4_semantics_init(net);
 }
 
 static void __net_exit fib_net_exit_batch(struct list_head *net_list)
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


