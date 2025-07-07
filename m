Return-Path: <netdev+bounces-204698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E7AFBD06
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A54A6DBA
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FB27FB22;
	Mon,  7 Jul 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5ULFmaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36442219300
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922099; cv=none; b=caNPmmSZK2x4xCn6ll51LcFzabbln7n/R4qlGImIwCEnLBGtK5Xpooh7NvaCu8TqV6K5mRp50jQYiNHkQzkuudtug8Z9IsXBIPUkLYRbTMNz8xDY4NjUFOSTRgMYYIdqeO0DH6N8rqsSl6SdA3DlBhgHwH6TMtDI7hoSRsPyfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922099; c=relaxed/simple;
	bh=+7FCA81KFT9+JhyVGmxctvYU7zQvcHJSacDM3W993bA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i1kwdaF2befPZyW92CTjfpcGxit6pguE01kfme0WAuPOmN3Y/v0hmpq48yeu1MfwHbGyj6csEG3J+hG6MUlo/wD61cmyjgHwd/ovPj3RoadtM+dTogqbQA3J1U108zdaUIYfBVmd6Z2iwIZjYq1ARTLtmm8Z4c8txignXZ2hwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5ULFmaC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7494999de28so4814202b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751922097; x=1752526897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXhyGtO+Q+sborGxjJWjNGQUHw01qSoxvb+5oMk73g4=;
        b=Q5ULFmaCX6EkxtUqEjcmYkfP60YsbG1ADQysijl3RQbQ0jHGYOycz9qS673cWg6RML
         eTijcRjIqZZW7G3T6fkY3NLiN1tOlwDKJ+805ev2TuT8xG69Ny6QOxYRqkJ7wxOHxJAP
         bFeqjuB/E2ZP/uceR5w8QlEooLWH/HY64kgFZys97OuO5Q6a1qACbNEY3EL2jMNtnIdh
         ls2BlpsuFFuH1js4iSCg8mgL7dozuw0UoacwQ/yQzXvzsq28IdybxCVEa4IQgCqFKFpd
         lDdzYo0lmSrYaa0eweeft/Mq6fYC40V70ktjQtgh6IKvReU+KRnNrOPEIZKMrcbkTis/
         ixFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922097; x=1752526897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXhyGtO+Q+sborGxjJWjNGQUHw01qSoxvb+5oMk73g4=;
        b=W3bJ13I4atxnefethjLVsHnWbxOa3OdcAWGg5IwqzyYVuRHpyJi7ALvAubBtSsEwCt
         RBkN6q5LFBWjpH7hxLHLRtZkbemI9TQrDzLdZBkoaf5tOfZmpM3HP7gRnJY5JzBFAIvW
         Azjt+GAfwjk2Fx3/SK4Jttq3RUEvWThRkSZ/t8opSRgk37b+z/6nOhXsv8q2MqMJHYWO
         22Cpf1KKHLoxERyb/sYfqSDtAPVOr57kONLdU2EzCjMmZYtGpvHDOZ6pxhvwxESXvRIX
         a33sDcaIIchX2GUHjIqtkBcLk5ZcKoNtOAssb2VrGRUVG+RQRaSw3ViI0TdVYjhIfdLa
         3tVQ==
X-Gm-Message-State: AOJu0YybxbsNMmfDJyl6jjuRB1iRl5FnbqAORhJCGnVxp+PHe8X4kUox
	L3XyTYglkb8fZAe1xYVXXZ+q09RuOS6ej2P4rIX7eeWA0hrOnCn9WpwrawpVTH3AAlPNxQuUBU2
	cDLB94m9JGMEqqQjCZHhobPMTnwHHSSR/t+nZjb7TIE/nCvMbcX8KzwZWsr9Ll2Kaqn7sF3Q7lE
	CuFXrfLrhuBelGEEvGex4kg9mQeWyexitd5qxyUiJtwTgdDWc=
X-Google-Smtp-Source: AGHT+IFnWJuIlkcfVHgTQWv/wyeAjNzQ0vnn6AUIfcjYabWkKBXJLk+2xeV4OpyHvFu+CbxgmHlQ8Nohq18qGg==
X-Received: from pfbfb4.prod.google.com ([2002:a05:6a00:2d84:b0:746:1fcb:a9cc])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd93:b0:748:e772:f952 with SMTP id d2e1a72fcca58-74d249a681fmr767557b3a.17.1751922097300;
 Mon, 07 Jul 2025 14:01:37 -0700 (PDT)
Date: Mon,  7 Jul 2025 14:01:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707210107.2742029-1-jeroendb@google.com>
Subject: [PATCH net-next v2] gve: make IRQ handlers and page allocation NUMA aware
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Bailey Forrest <bcf@google.com>, Joshua Washington <joshwash@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Bailey Forrest <bcf@google.com>

All memory in GVE is currently allocated without regard for the NUMA
node of the device. Because access to NUMA-local memory access is
significantly cheaper than access to a remote node, this change attempts
to ensure that page frags used in the RX path, including page pool
frags, are allocated on the NUMA node local to the gVNIC device. Note
that this attempt is best-effort. If necessary, the driver will still
allocate non-local memory, as __GFP_THISNODE is not passed. Descriptor
ring allocations are not updated, as dma_alloc_coherent handles that.

This change also modifies the IRQ affinity setting to only select CPUs
from the node local to the device, preserving the behavior that TX and
RX queues of the same index share CPU affinity.

Signed-off-by: Bailey Forrest <bcf@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
v1: https://lore.kernel.org/netdev/20250627183141.3781516-1-hramamurthy@google.com/
v2:
- Utilize kvcalloc_node instead of kvzalloc_node for array-type
  allocations.
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  1 +
 drivers/net/ethernet/google/gve/gve_main.c    | 30 +++++++++++++++----
 drivers/net/ethernet/google/gve/gve_rx.c      | 14 ++++-----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  8 ++---
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index cf91195d5f39..53899096e89e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -804,6 +804,7 @@ struct gve_priv {
 	struct gve_tx_queue_config tx_cfg;
 	struct gve_rx_queue_config rx_cfg;
 	u32 num_ntfy_blks; /* split between TX and RX so must be even */
+	int numa_node;
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	__be32 __iomem *db_bar2; /* "array" of doorbells */
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index a71883e1d920..6c3c459a1b5e 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -246,6 +246,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = 0,
 		.pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
+		.nid = priv->numa_node,
 		.dev = &priv->pdev->dev,
 		.netdev = priv->dev,
 		.napi = &priv->ntfy_blocks[ntfy_id].napi,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 27f97a1d2957..be461751ff31 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -461,10 +461,19 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
+{
+	if (priv->numa_node == NUMA_NO_NODE)
+		return cpu_all_mask;
+	else
+		return cpumask_of_node(priv->numa_node);
+}
+
 static int gve_alloc_notify_blocks(struct gve_priv *priv)
 {
 	int num_vecs_requested = priv->num_ntfy_blks + 1;
-	unsigned int active_cpus;
+	const struct cpumask *node_mask;
+	unsigned int cur_cpu;
 	int vecs_enabled;
 	int i, j;
 	int err;
@@ -503,8 +512,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		if (priv->rx_cfg.num_queues > priv->rx_cfg.max_queues)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
-	/* Half the notification blocks go to TX and half to RX */
-	active_cpus = min_t(int, priv->num_ntfy_blks / 2, num_online_cpus());
 
 	/* Setup Management Vector  - the last vector */
 	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve-mgmnt@pci:%s",
@@ -533,6 +540,8 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 	}
 
 	/* Setup the other blocks - the first n-1 vectors */
+	node_mask = gve_get_node_mask(priv);
+	cur_cpu = cpumask_first(node_mask);
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
 		int msix_idx = i;
@@ -549,9 +558,17 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			goto abort_with_some_ntfy_blocks;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
-		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
-				      get_cpu_mask(i % active_cpus));
+		irq_set_affinity_and_hint(block->irq,
+					  cpumask_of(cur_cpu));
 		block->irq_db_index = &priv->irq_db_indices[i].index;
+
+		cur_cpu = cpumask_next(cur_cpu, node_mask);
+		/* Wrap once CPUs in the node have been exhausted, or when
+		 * starting RX queue affinities. TX and RX queues of the same
+		 * index share affinity.
+		 */
+		if (cur_cpu >= nr_cpu_ids || (i + 1) == priv->tx_cfg.max_queues)
+			cur_cpu = cpumask_first(node_mask);
 	}
 	return 0;
 abort_with_some_ntfy_blocks:
@@ -1040,7 +1057,7 @@ int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   struct page **page, dma_addr_t *dma,
 		   enum dma_data_direction dir, gfp_t gfp_flags)
 {
-	*page = alloc_page(gfp_flags);
+	*page = alloc_pages_node(priv->numa_node, gfp_flags, 0);
 	if (!*page) {
 		priv->page_alloc_fail++;
 		return -ENOMEM;
@@ -2322,6 +2339,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	 */
 	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
 	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
 
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 90e875c1832f..ec424d2f4f57 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -192,8 +192,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 	 */
 	slots = rx->mask + 1;
 
-	rx->data.page_info = kvzalloc(slots *
-				      sizeof(*rx->data.page_info), GFP_KERNEL);
+	rx->data.page_info = kvcalloc_node(slots, sizeof(*rx->data.page_info),
+					   GFP_KERNEL, priv->numa_node);
 	if (!rx->data.page_info)
 		return -ENOMEM;
 
@@ -216,7 +216,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 
 	if (!rx->data.raw_addressing) {
 		for (j = 0; j < rx->qpl_copy_pool_mask + 1; j++) {
-			struct page *page = alloc_page(GFP_KERNEL);
+			struct page *page = alloc_pages_node(priv->numa_node,
+							     GFP_KERNEL, 0);
 
 			if (!page) {
 				err = -ENOMEM;
@@ -303,10 +304,9 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 
 	rx->qpl_copy_pool_mask = min_t(u32, U32_MAX, slots * 2) - 1;
 	rx->qpl_copy_pool_head = 0;
-	rx->qpl_copy_pool = kvcalloc(rx->qpl_copy_pool_mask + 1,
-				     sizeof(rx->qpl_copy_pool[0]),
-				     GFP_KERNEL);
-
+	rx->qpl_copy_pool = kvcalloc_node(rx->qpl_copy_pool_mask + 1,
+					  sizeof(rx->qpl_copy_pool[0]),
+					  GFP_KERNEL, priv->numa_node);
 	if (!rx->qpl_copy_pool) {
 		err = -ENOMEM;
 		goto abort_with_slots;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 96743e1d80f3..2bc4ff9da981 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -237,9 +237,9 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
-	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
-				      sizeof(rx->dqo.buf_states[0]),
-				      GFP_KERNEL);
+	rx->dqo.buf_states = kvcalloc_node(rx->dqo.num_buf_states,
+					   sizeof(rx->dqo.buf_states[0]),
+					   GFP_KERNEL, priv->numa_node);
 	if (!rx->dqo.buf_states)
 		return -ENOMEM;
 
@@ -488,7 +488,7 @@ static int gve_rx_copy_ondemand(struct gve_rx_ring *rx,
 				struct gve_rx_buf_state_dqo *buf_state,
 				u16 buf_len)
 {
-	struct page *page = alloc_page(GFP_ATOMIC);
+	struct page *page = alloc_pages_node(rx->gve->numa_node, GFP_ATOMIC, 0);
 	int num_frags;
 
 	if (!page)
-- 
2.50.0.727.gbf7dc18ff4-goog


