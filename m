Return-Path: <netdev+bounces-72324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B48578D3
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1C2285214
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418A1B962;
	Fri, 16 Feb 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXYcxR1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FC1BF20
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075584; cv=none; b=Td7ejfQ8zHQLNj2tIK2ODnj/6lhfG2L1F68Xw8sHFvk0fiJmbyUS8BCyJhBHN28Jgn1hK6UOSUgErmfjF8WiQfp6Zji0UW6NXOjUbDezxgZejTkVujEPxa32Buc0Ua3ZvylBUsTs5Sg8n/Lo4b77HqmwYYfSR4sBZjAn5lhrlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075584; c=relaxed/simple;
	bh=A3PkjLDTCisRWnvOD7hYm8eZXWA++pOvoAeHn7RxY94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRGqSJVFKHgACbxvQrcUsaag8iwEMGNxNm2KgugdN+kVPwVLWKQtqbOSzYvSFdNgl4s0W38BYoZwaO4ByaAj8TgQS/MeXqT3dLJpeCuABnMPCOwVrKH0iZIDtsg6bEZxytV41KlPo/t9O59nUbx8Vbzm6x5CMc8eIS+w2a1TYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXYcxR1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE133C433C7;
	Fri, 16 Feb 2024 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708075583;
	bh=A3PkjLDTCisRWnvOD7hYm8eZXWA++pOvoAeHn7RxY94=;
	h=From:To:Cc:Subject:Date:From;
	b=GXYcxR1U6XCSUXbx4txwirbpE/itxEASPGi49r2JWPxpfzYsHq4IV+223g0/IHt4f
	 8X+wDMq77ECu4Eua1PqNCstbRWwcGfuWoP2ZK93xxa8Xk27ZfQU2pbaFjHCY2CfLqp
	 xqt7Vrj1SZ68MP7sjzzwXINODqM/M8woXVJeC7ztu4vMQWuTWpdmhqblUFJ3p5d1dI
	 6xb8MFbTVKC0F7G3IrNwIRU4h5F3oSuFcUhSQpIhXUFHyWsoB+wCWh66RlYN6MDMAf
	 QOpRpewQZ5TbmnIPAa+cFVNBepSIrdA+K6wOcG1w+s7Qb5OFDT8PFBOXjMTz8oew+A
	 l+fAgOVmdnMVw==
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
	toke@redhat.com,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next] net: page_pool: fix recycle stats for system page_pool allocator
Date: Fri, 16 Feb 2024 10:25:43 +0100
Message-ID: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use global percpu page_pool_recycle_stats counter for system page_pool
allocator instead of allocating a separate percpu variable for each
(also percpu) page pool instance.

Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/page_pool/types.h |  5 +++--
 net/core/dev.c                |  1 +
 net/core/page_pool.c          | 22 +++++++++++++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 3828396ae60c..2515cca6518b 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -18,8 +18,9 @@
 					* Please note DMA-sync-for-CPU is still
 					* device driver responsibility
 					*/
-#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
-				 PP_FLAG_DMA_SYNC_DEV)
+#define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
+#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
+				 PP_FLAG_SYSTEM_POOL)
 
 /*
  * Fast allocation side cache array/stack
diff --git a/net/core/dev.c b/net/core/dev.c
index cc9c2eda65ac..c588808be77f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11738,6 +11738,7 @@ static int net_page_pool_create(int cpuid)
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 	struct page_pool_params page_pool_params = {
 		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
+		.flags = PP_FLAG_SYSTEM_POOL,
 		.nid = NUMA_NO_NODE,
 	};
 	struct page_pool *pp_ptr;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 89c835fcf094..8f0c4e76181b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -31,6 +31,8 @@
 #define BIAS_MAX	(LONG_MAX >> 1)
 
 #ifdef CONFIG_PAGE_POOL_STATS
+static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_stats);
+
 /* alloc_stat_inc is intended to be used in softirq context */
 #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
 /* recycle_stat_inc is safe to use when preemption is possible. */
@@ -220,14 +222,23 @@ static int page_pool_init(struct page_pool *pool,
 	pool->has_init_callback = !!pool->slow.init_callback;
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
-	if (!pool->recycle_stats)
-		return -ENOMEM;
+	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL)) {
+		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
+		if (!pool->recycle_stats)
+			return -ENOMEM;
+	} else {
+		/* For system page pool instance we use a singular stats object
+		 * instead of allocating a separate percpu variable for each
+		 * (also percpu) page pool instance.
+		 */
+		pool->recycle_stats = &pp_system_recycle_stats;
+	}
 #endif
 
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
 #ifdef CONFIG_PAGE_POOL_STATS
-		free_percpu(pool->recycle_stats);
+		if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
+			free_percpu(pool->recycle_stats);
 #endif
 		return -ENOMEM;
 	}
@@ -251,7 +262,8 @@ static void page_pool_uninit(struct page_pool *pool)
 		put_device(pool->p.dev);
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	free_percpu(pool->recycle_stats);
+	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
+		free_percpu(pool->recycle_stats);
 #endif
 }
 
-- 
2.43.2


