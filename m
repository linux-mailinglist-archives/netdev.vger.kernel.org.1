Return-Path: <netdev+bounces-202014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C027AEBF13
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8674B3B8521
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15E2EBDE4;
	Fri, 27 Jun 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecZFF1+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF92EBBA2
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049115; cv=none; b=Qb71+CqtKvF+ssLqQT8xY1f4IuuGvam4mMZ+LidT1/3vD7HCYCOYd2fGk7BUEVkVcEkaMfm4kKEkVPk/nTw5427fmwNG+cIaoe/MSaVK7LuxPWBxVAayxnyQNQDpxvB3rolmxJPpixjh4bkW7PlWsMjfV9R5zAVSdePFSyTGmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049115; c=relaxed/simple;
	bh=HkWCVwJQbfpx8FmLn65kmBBlTCs+zaW3lqttbUJLeJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ch3G3QsQ/NcSN+NsBOOSanv9kAo/aBC0ahIIRnAldTKXoaSetYdHPxfbflTSVZGYOm+Au5Qi8bZRmUK+7cUiv2oo8vOKfkmxAbYKQcGfDG8fJLO82DKHjeQQummdL1kaqR0u7WEVIaZRTsxcFMYtzFSI1IuB6jN/jT6/mpdHsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecZFF1+F; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747ddba7c90so151536b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751049113; x=1751653913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJo9CtXFcRWuDjas8h65+O0iUteSLSP5tA8EVWt81GY=;
        b=ecZFF1+FqLRNr1tvL8o19zSIXC4wEb0RuQsSjJF4+fcfwywTQ8gSKXs/AoG0qv18bl
         FYWtyaR2oHCBhZgTFIGdCuGOm2w3ObOXW7PjLtzITeL49wNrxVfArVX2nzp8CHi2hkIU
         9GyxU9/36O67V0a5wPKwbH1vM9Da/+Q3MxOkwdD0Eu+HDNfLEMSenrzwVw8q9hwX/axS
         G5Tes5jlPS+++S/khA2gi1kXmHTB/qYbAeY9QYo/gy8tFNuqgv5m+sC7kwqaYurYeqFR
         U0sCkhdpfEkdF9ZNDmQB9HKH6ujZ6lsokJBsfSJXOv2V2N2EPzd1EZx0oazlfJ9+h052
         R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049113; x=1751653913;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJo9CtXFcRWuDjas8h65+O0iUteSLSP5tA8EVWt81GY=;
        b=iPFqMIKIR0bfWRlfR1gcZC3uyJreY9ssMfRZjYFg05hh8+W8itk7gGxfyk9vlbSRna
         cBNmGrLT8mFxoDPIAOynoqyN/19EfvxIoIn94goQ40ZBUrd2fq8wjuhw2jDtNRVLxdgM
         087/AODtOZEvzNVt8dQigAmpV5YiJr3yULwi3rJRg5bxer60Ae0iuQ2APbhgld6CSyYu
         /76eMezBZHsEAPV8KWIgoozOu2ZAxVl9WatD4t84AMQivbO8eDaIrymvGAs4pFtvSVav
         LwPg5dffqBZHqQPqAHGPp6eagkWCLoEjZ+/WIuoIRIux4YDApOwK7BPGYgXSo9iAxjiX
         rzZA==
X-Gm-Message-State: AOJu0YymGnw0vcWHBDFohgG7dzhGA7DEi9tMEhxKP82eazai+JmEXdc/
	ftUbqKoYC5NcEsC76mucTzV9uO6KYAB9A8XGJL31tcn4PFey2q3iF04PxClW5txA0YlddMe4Q+k
	BFf7NtrmjH+DbJ3G9Dg4WpwNy2vWr1/6CqnfioBUaXx4KIizIbelS/10K5oe0kNRv2p9YvII0TF
	wVeXts5IeINBO/v2B3rQGZoBXX49Yrgf3hKh9ypLeEP1df5x+MVWBEbN9UFXmSVfs=
X-Google-Smtp-Source: AGHT+IGj48GQh4XwsgU2Xo4f83vJ4SZi9wNSVpTXqFST1M+jCyUOENFkEoJDQmfjon74Fce5t0qqkKhLlxuqiBe3Pw==
X-Received: from pfiu9.prod.google.com ([2002:a05:6a00:1249:b0:748:f627:51c4])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:889:b0:748:6a1f:6d3b with SMTP id d2e1a72fcca58-74af6f43cb7mr6230462b3a.19.1751049112565;
 Fri, 27 Jun 2025 11:31:52 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:31:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627183141.3781516-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: make IRQ handlers and page allocation NUMA aware
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, bcf@google.com, pkaligineedi@google.com, 
	joshwash@google.com, linux-kernel@vger.kernel.org
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
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  1 +
 drivers/net/ethernet/google/gve/gve_main.c    | 30 +++++++++++++++----
 drivers/net/ethernet/google/gve/gve_rx.c      | 15 ++++++----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  9 +++---
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4469442d4940..d99654771487 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -790,6 +790,7 @@ struct gve_priv {
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
index 28e4795f5f40..0de348605872 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -457,10 +457,19 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
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
@@ -499,8 +508,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		if (priv->rx_cfg.num_queues > priv->rx_cfg.max_queues)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
-	/* Half the notification blocks go to TX and half to RX */
-	active_cpus = min_t(int, priv->num_ntfy_blks / 2, num_online_cpus());
 
 	/* Setup Management Vector  - the last vector */
 	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve-mgmnt@pci:%s",
@@ -529,6 +536,8 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 	}
 
 	/* Setup the other blocks - the first n-1 vectors */
+	node_mask = gve_get_node_mask(priv);
+	cur_cpu = cpumask_first(node_mask);
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
 		int msix_idx = i;
@@ -545,9 +554,17 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -1036,7 +1053,7 @@ int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   struct page **page, dma_addr_t *dma,
 		   enum dma_data_direction dir, gfp_t gfp_flags)
 {
-	*page = alloc_page(gfp_flags);
+	*page = alloc_pages_node(priv->numa_node, gfp_flags, 0);
 	if (!*page) {
 		priv->page_alloc_fail++;
 		return -ENOMEM;
@@ -2294,6 +2311,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	 */
 	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
 	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
 
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 90e875c1832f..367f1157fa73 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -192,8 +192,9 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 	 */
 	slots = rx->mask + 1;
 
-	rx->data.page_info = kvzalloc(slots *
-				      sizeof(*rx->data.page_info), GFP_KERNEL);
+	rx->data.page_info =
+		kvzalloc_node(array_size(slots, sizeof(*rx->data.page_info)),
+			      GFP_KERNEL, priv->numa_node);
 	if (!rx->data.page_info)
 		return -ENOMEM;
 
@@ -216,7 +217,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 
 	if (!rx->data.raw_addressing) {
 		for (j = 0; j < rx->qpl_copy_pool_mask + 1; j++) {
-			struct page *page = alloc_page(GFP_KERNEL);
+			struct page *page = alloc_pages_node(priv->numa_node,
+							     GFP_KERNEL, 0);
 
 			if (!page) {
 				err = -ENOMEM;
@@ -303,9 +305,10 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 
 	rx->qpl_copy_pool_mask = min_t(u32, U32_MAX, slots * 2) - 1;
 	rx->qpl_copy_pool_head = 0;
-	rx->qpl_copy_pool = kvcalloc(rx->qpl_copy_pool_mask + 1,
-				     sizeof(rx->qpl_copy_pool[0]),
-				     GFP_KERNEL);
+	rx->qpl_copy_pool =
+		kvzalloc_node(array_size(rx->qpl_copy_pool_mask + 1,
+					 sizeof(rx->qpl_copy_pool[0])),
+			      GFP_KERNEL, priv->numa_node);
 
 	if (!rx->qpl_copy_pool) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 0be41a0cdd15..ecaf1a56e4fb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -236,9 +236,10 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
-	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
-				      sizeof(rx->dqo.buf_states[0]),
-				      GFP_KERNEL);
+	rx->dqo.buf_states =
+		kvzalloc_node(array_size(rx->dqo.num_buf_states,
+					 sizeof(rx->dqo.buf_states[0])),
+			      GFP_KERNEL, priv->numa_node);
 	if (!rx->dqo.buf_states)
 		return -ENOMEM;
 
@@ -487,7 +488,7 @@ static int gve_rx_copy_ondemand(struct gve_rx_ring *rx,
 				struct gve_rx_buf_state_dqo *buf_state,
 				u16 buf_len)
 {
-	struct page *page = alloc_page(GFP_ATOMIC);
+	struct page *page = alloc_pages_node(rx->gve->numa_node, GFP_ATOMIC, 0);
 	int num_frags;
 
 	if (!page)
-- 
2.50.0.727.gbf7dc18ff4-goog


