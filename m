Return-Path: <netdev+bounces-71803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F48551B7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364631F225D5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F701292C2;
	Wed, 14 Feb 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alzPC9Wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E419128836
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934128; cv=none; b=aZ0tuOEDy1DCxWqwYczEqiwHapGGkh1uEFwzgQKsr0fDLoU1JExv/sXmVYzC5TQOM7/lTFd+8lyET71BgxRnmfY42HDSNzCDxTCCuhNOL9fCQHi/vhu0GycQYzNgHVJGcfD4tM9YatBMAn1qF6Y73//LDNm0C4kGFHvSmYqgYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934128; c=relaxed/simple;
	bh=jGOaR9YzbYSApWmKBAUmeMYCI/NFoJh2wnbvudW6gts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cibQeJqZqnK7Z5lFQkUggVMETeFTxVufF/kp1S1ikg7IikW1EnjRScHCcjjKJenox3yXwAB0B2QmW7UsRiBBB+HT+/c4RmeCa2JzFvsraNLD3VlZtNchWVUxRXu0+YGtLSZLLQIRK4gOUwzRJM6zeIlMxb83Ihh/xVC+TrDxZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alzPC9Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E16BC433C7;
	Wed, 14 Feb 2024 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934127;
	bh=jGOaR9YzbYSApWmKBAUmeMYCI/NFoJh2wnbvudW6gts=;
	h=From:To:Cc:Subject:Date:From;
	b=alzPC9WoRcovjGWSQTKym5lX6GIHY8TavF2zPFHEM76UBHgd/maz4uhO2Shg286hg
	 WI1+MdVqIjmqWUhAM6PkeT+VgBuTI52LbiQ5HTUYCvecF51eiLEuoEarO1FQXT5s+o
	 cgjePRL+2gUdtrWxd8hfI/j6bhZ2f9YvZstn9sQLk1ryKw7r3PnckgOhifwWWdfABD
	 3XI0hbZwUDYa/G1m0eQpCwigqZCNIYx0/5Y8ufiO0DDqipabavMHLtCCdZtoBXQf4+
	 QI56HNsQrTMX3dwTKo1LgwsbcKVOwrHoGB5WHNlhhH6Z4yb0IeHtY8U+4EtOknUvY+
	 9gzljYF70voCg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com,
	toke@redhat.com
Subject: [RFC net-next] net: page_pool: fix recycle stats for percpu page_pool allocator
Date: Wed, 14 Feb 2024 19:08:40 +0100
Message-ID: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use global page_pool_recycle_stats percpu counter for percpu page_pool
allocator.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/page_pool.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6e0753e6a95b..1bb83b6e7a61 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -31,6 +31,8 @@
 #define BIAS_MAX	(LONG_MAX >> 1)
 
 #ifdef CONFIG_PAGE_POOL_STATS
+static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_recycle_stats);
+
 /* alloc_stat_inc is intended to be used in softirq context */
 #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
 /* recycle_stat_inc is safe to use when preemption is possible. */
@@ -220,14 +222,19 @@ static int page_pool_init(struct page_pool *pool,
 	pool->has_init_callback = !!pool->slow.init_callback;
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
-	if (!pool->recycle_stats)
-		return -ENOMEM;
+	if (cpuid < 0) {
+		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
+		if (!pool->recycle_stats)
+			return -ENOMEM;
+	} else {
+		pool->recycle_stats = &pp_recycle_stats;
+	}
 #endif
 
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
 #ifdef CONFIG_PAGE_POOL_STATS
-		free_percpu(pool->recycle_stats);
+		if (cpuid < 0)
+			free_percpu(pool->recycle_stats);
 #endif
 		return -ENOMEM;
 	}
@@ -251,7 +258,8 @@ static void page_pool_uninit(struct page_pool *pool)
 		put_device(pool->p.dev);
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	free_percpu(pool->recycle_stats);
+	if (pool->cpuid < 0)
+		free_percpu(pool->recycle_stats);
 #endif
 }
 
-- 
2.43.0


