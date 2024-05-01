Return-Path: <netdev+bounces-92860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7B8B925A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA783B20B29
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E016ABCE;
	Wed,  1 May 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PudHx9wY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C72168B1F
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605975; cv=none; b=MhHjK3NxDX1C297wonyBxqmK8KrBqayPbvNUNf2W8vA3pDx/+cZ6G5wZf8yO/AWSeyF11opvnE469b0F0VNDEm5CzFrhc42lpx+Z8ltHhxfMJsOjo2iA3waLleH8P8Lvay2J6DsIedsJfA1MA3JvdqmvaOWoJEfv4jMbFCw8E0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605975; c=relaxed/simple;
	bh=/joToHSomABW+06vWRtBrMH4B6SnFVzxzlzpu9HmI18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gd1p9BIIqlULGpUuFETNnGjzFLBmnv3t4gEXuBCpZuVEJ94ChsY0pCjNTWv64vm81DYjQtLRpaqI6O0OqGMeNcm3xFtWY/M5GcnGKCKa86X8cuE7UOO21scbb/EM/RUSpKRrW8e9GBWzvDgShcmpncD9gug7kR016cETSec1pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PudHx9wY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c1f7169so4316357b3.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605972; x=1715210772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzydajZgokrqXX9bEfu1ztrWITDHwOkwhwLeM0IM3fs=;
        b=PudHx9wYWuHEDAfcIrXND9NLUIPFdqU3bASBiLLJtx2+GF2oxh6C68GYQbcUMmPCCC
         7ksxfxL1VdZ1+u6SfxRscgnboJo6C1T1OplIdY3AeT8a2X+UtKsfXdBGGvEnTOabY5mq
         pl6lYDDIBE+s+h935vKYFdhTUURhhz0USRVRxI5o0FLPYElp+1YLukzJYuCTpMxFFq5b
         e4ywt4E1LWztZ5qRG/1uDXcYy3jUv0P897fjuSZBmmMcF+u4U7pXjNyb3IiPn5rvs9qM
         2Jkegh8HbdbP6333T0SRGkwoo5DLD9KqlxSN6waTvNIRRaIGnHMzsNroOmeNNIPWGOYb
         8p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605972; x=1715210772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzydajZgokrqXX9bEfu1ztrWITDHwOkwhwLeM0IM3fs=;
        b=jiexxq2iJzC9sIUC+Ei3NdwCwaG3JniqWLdSV4v7UNnzBEjvd6XstZlsOuMdVvJqvq
         fkByw6SKuYZYa2+kK9Lsykp05CpTXMfhaDN/JpLMOUQe16V13UypBjScV8+AWj36HbHF
         g+W9N+baeHtyGfG1DgqLBXoe2IGTyXvw6Kr3kjGBuy+yz07Dc+73ufJBr5FKqmr3Qp6v
         ixOmVm1bKmiGMVFEbz1o/8bp9LTbeJkZgDUlWJlER+NgBYDWDEnC94SOOYFHuEeetoJx
         4k3hJbFaT8YS+gfx+ZPJlLjQfqjorQvprCMdRT+7EMHQLWyKLXIVaL4Gb8D6BztiQInK
         mE/A==
X-Gm-Message-State: AOJu0YxgEv6eipltpT8WI5vqPsA8aytJPUMNT4MLa9+V+LiCJOrJZQBb
	25QeEThVuWbQo77QGrQz2Z0eGXQWt1BKF1uZxGyLlHTsgPZzulhhDmIXu8YfXanEA1L/68LELoc
	LJM7DlliXMjx11T6NYxOowocQNtLjx7ug+OOK9lFWI07akN+K4rP0HB7ooLHgu+XTYqm25Y6NfT
	uKVsqIIyyyUTrfx9ZLwHaoNBh8n/D9zGEw8myCIKb5/OM=
X-Google-Smtp-Source: AGHT+IG1WdQZ3ofC7EAFmMNGJlTEc5w0O8GXi6rwGEHHlEatLtO1xoRh7qsZ+6CV8+W36fSq0HdVxAbXFD0XsQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:2d07:b0:de5:9ecc:46b6 with SMTP
 id fo7-20020a0569022d0700b00de59ecc46b6mr268689ybb.6.1714605971925; Wed, 01
 May 2024 16:26:11 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:48 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-10-shailend@google.com>
Subject: [PATCH net-next v2 09/10] gve: Alloc and free QPLs with the rings
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Every tx and rx ring has its own queue-page-list (QPL) that serves as
the bounce buffer. Previously we were allocating QPLs for all queues
before the queues themselves were allocated and later associating a QPL
with a queue. This is avoidable complexity: it is much more natural for
each queue to allocate and free its own QPL.

Moreover, the advent of new queue-manipulating ndo hooks make it hard to
keep things as is: we would need to transfer a QPL from an old queue to
a new queue, and that is unpleasant.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  30 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   7 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 343 +++++-------------
 drivers/net/ethernet/google/gve/gve_rx.c      |  43 ++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  23 +-
 drivers/net/ethernet/google/gve/gve_tx.c      |  33 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  23 +-
 7 files changed, 171 insertions(+), 331 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f27a6d5fbecf..9e0a433c991c 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -638,26 +638,10 @@ struct gve_ptype_lut {
 	struct gve_ptype ptypes[GVE_NUM_PTYPES];
 };
 
-/* Parameters for allocating queue page lists */
-struct gve_qpls_alloc_cfg {
-	struct gve_queue_config *tx_cfg;
-	struct gve_queue_config *rx_cfg;
-
-	u16 num_xdp_queues;
-	bool raw_addressing;
-	bool is_gqi;
-
-	/* Allocated resources are returned here */
-	struct gve_queue_page_list *qpls;
-};
-
 /* Parameters for allocating resources for tx queues */
 struct gve_tx_alloc_rings_cfg {
 	struct gve_queue_config *qcfg;
 
-	/* qpls must already be allocated */
-	struct gve_queue_page_list *qpls;
-
 	u16 ring_size;
 	u16 start_idx;
 	u16 num_rings;
@@ -673,9 +657,6 @@ struct gve_rx_alloc_rings_cfg {
 	struct gve_queue_config *qcfg;
 	struct gve_queue_config *qcfg_tx;
 
-	/* qpls must already be allocated */
-	struct gve_queue_page_list *qpls;
-
 	u16 ring_size;
 	u16 packet_buffer_size;
 	bool raw_addressing;
@@ -701,7 +682,6 @@ struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
 	struct gve_rx_ring *rx; /* array of rx_cfg.num_queues */
-	struct gve_queue_page_list *qpls; /* array of num qpls */
 	struct gve_notify_block *ntfy_blocks; /* array of num_ntfy_blks */
 	struct gve_irq_db *irq_db_indices; /* array of num_ntfy_blks */
 	dma_addr_t irq_db_indices_bus;
@@ -1025,7 +1005,6 @@ static inline u32 gve_rx_qpl_id(struct gve_priv *priv, int rx_qid)
 	return priv->tx_cfg.max_queues + rx_qid;
 }
 
-/* Returns the index into priv->qpls where a certain rx queue's QPL resides */
 static inline u32 gve_get_rx_qpl_id(const struct gve_queue_config *tx_cfg, int rx_qid)
 {
 	return tx_cfg->max_queues + rx_qid;
@@ -1036,7 +1015,6 @@ static inline u32 gve_tx_start_qpl_id(struct gve_priv *priv)
 	return gve_tx_qpl_id(priv, 0);
 }
 
-/* Returns the index into priv->qpls where the first rx queue's QPL resides */
 static inline u32 gve_rx_start_qpl_id(const struct gve_queue_config *tx_cfg)
 {
 	return gve_get_rx_qpl_id(tx_cfg, 0);
@@ -1090,6 +1068,12 @@ int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   enum dma_data_direction, gfp_t gfp_flags);
 void gve_free_page(struct device *dev, struct page *page, dma_addr_t dma,
 		   enum dma_data_direction);
+/* qpls */
+struct gve_queue_page_list *gve_alloc_queue_page_list(struct gve_priv *priv,
+						      u32 id, int pages);
+void gve_free_queue_page_list(struct gve_priv *priv,
+			      struct gve_queue_page_list *qpl,
+			      u32 id);
 /* tx handling */
 netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev);
 int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
@@ -1126,11 +1110,9 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
-			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_adjust_config(struct gve_priv *priv,
-		      struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
 		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_adjust_queues(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a606670a9a39..156b7e128b53 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -538,20 +538,17 @@ static int gve_adjust_ring_sizes(struct gve_priv *priv,
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	int err;
 
 	/* get current queue configuration */
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	/* copy over the new ring_size from ethtool */
 	tx_alloc_cfg.ring_size = new_tx_desc_cnt;
 	rx_alloc_cfg.ring_size = new_rx_desc_cnt;
 
 	if (netif_running(priv->dev)) {
-		err = gve_adjust_config(priv, &qpls_alloc_cfg,
-					&tx_alloc_cfg, &rx_alloc_cfg);
+		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 79b7a677ec0b..e22ac764ec4f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -611,37 +611,36 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	gve_clear_device_resources_ok(priv);
 }
 
-static int gve_unregister_qpl(struct gve_priv *priv, u32 i)
+static int gve_unregister_qpl(struct gve_priv *priv,
+			      struct gve_queue_page_list *qpl)
 {
 	int err;
 
-	err = gve_adminq_unregister_page_list(priv, priv->qpls[i].id);
+	if (!qpl)
+		return 0;
+
+	err = gve_adminq_unregister_page_list(priv, qpl->id);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "Failed to unregister queue page list %d\n",
-			  priv->qpls[i].id);
+			  qpl->id);
 		return err;
 	}
 
-	priv->num_registered_pages -= priv->qpls[i].num_entries;
+	priv->num_registered_pages -= qpl->num_entries;
 	return 0;
 }
 
-static int gve_register_qpl(struct gve_priv *priv, u32 i)
+static int gve_register_qpl(struct gve_priv *priv,
+			    struct gve_queue_page_list *qpl)
 {
-	int num_rx_qpls;
 	int pages;
 	int err;
 
-	/* Rx QPLs succeed Tx QPLs in the priv->qpls array. */
-	num_rx_qpls = gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
-	if (i >= gve_rx_start_qpl_id(&priv->tx_cfg) + num_rx_qpls) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot register nonexisting QPL at index %d\n", i);
-		return -EINVAL;
-	}
+	if (!qpl)
+		return 0;
 
-	pages = priv->qpls[i].num_entries;
+	pages = qpl->num_entries;
 
 	if (pages + priv->num_registered_pages > priv->max_registered_pages) {
 		netif_err(priv, drv, priv->dev,
@@ -651,14 +650,11 @@ static int gve_register_qpl(struct gve_priv *priv, u32 i)
 		return -EINVAL;
 	}
 
-	err = gve_adminq_register_page_list(priv, &priv->qpls[i]);
+	err = gve_adminq_register_page_list(priv, qpl);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "failed to register queue page list %d\n",
-			  priv->qpls[i].id);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
+			  qpl->id);
 		return err;
 	}
 
@@ -666,6 +662,26 @@ static int gve_register_qpl(struct gve_priv *priv, u32 i)
 	return 0;
 }
 
+static struct gve_queue_page_list *gve_tx_get_qpl(struct gve_priv *priv, int idx)
+{
+	struct gve_tx_ring *tx = &priv->tx[idx];
+
+	if (gve_is_gqi(priv))
+		return tx->tx_fifo.qpl;
+	else
+		return tx->dqo.qpl;
+}
+
+static struct gve_queue_page_list *gve_rx_get_qpl(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+
+	if (gve_is_gqi(priv))
+		return rx->data.qpl;
+	else
+		return rx->dqo.qpl;
+}
+
 static int gve_register_xdp_qpls(struct gve_priv *priv)
 {
 	int start_id;
@@ -674,7 +690,7 @@ static int gve_register_xdp_qpls(struct gve_priv *priv)
 
 	start_id = gve_xdp_tx_start_queue_id(priv);
 	for (i = start_id; i < start_id + gve_num_xdp_qpls(priv); i++) {
-		err = gve_register_qpl(priv, i);
+		err = gve_register_qpl(priv, gve_tx_get_qpl(priv, i));
 		/* This failure will trigger a reset - no need to clean up */
 		if (err)
 			return err;
@@ -685,7 +701,6 @@ static int gve_register_xdp_qpls(struct gve_priv *priv)
 static int gve_register_qpls(struct gve_priv *priv)
 {
 	int num_tx_qpls, num_rx_qpls;
-	int start_id;
 	int err;
 	int i;
 
@@ -694,15 +709,13 @@ static int gve_register_qpls(struct gve_priv *priv)
 	num_rx_qpls = gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
 
 	for (i = 0; i < num_tx_qpls; i++) {
-		err = gve_register_qpl(priv, i);
+		err = gve_register_qpl(priv, gve_tx_get_qpl(priv, i));
 		if (err)
 			return err;
 	}
 
-	/* there might be a gap between the tx and rx qpl ids */
-	start_id = gve_rx_start_qpl_id(&priv->tx_cfg);
 	for (i = 0; i < num_rx_qpls; i++) {
-		err = gve_register_qpl(priv, start_id + i);
+		err = gve_register_qpl(priv, gve_rx_get_qpl(priv, i));
 		if (err)
 			return err;
 	}
@@ -718,7 +731,7 @@ static int gve_unregister_xdp_qpls(struct gve_priv *priv)
 
 	start_id = gve_xdp_tx_start_queue_id(priv);
 	for (i = start_id; i < start_id + gve_num_xdp_qpls(priv); i++) {
-		err = gve_unregister_qpl(priv, i);
+		err = gve_unregister_qpl(priv, gve_tx_get_qpl(priv, i));
 		/* This failure will trigger a reset - no need to clean */
 		if (err)
 			return err;
@@ -729,7 +742,6 @@ static int gve_unregister_xdp_qpls(struct gve_priv *priv)
 static int gve_unregister_qpls(struct gve_priv *priv)
 {
 	int num_tx_qpls, num_rx_qpls;
-	int start_id;
 	int err;
 	int i;
 
@@ -738,15 +750,14 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 	num_rx_qpls = gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
 
 	for (i = 0; i < num_tx_qpls; i++) {
-		err = gve_unregister_qpl(priv, i);
+		err = gve_unregister_qpl(priv, gve_tx_get_qpl(priv, i));
 		/* This failure will trigger a reset - no need to clean */
 		if (err)
 			return err;
 	}
 
-	start_id = gve_rx_start_qpl_id(&priv->tx_cfg);
 	for (i = 0; i < num_rx_qpls; i++) {
-		err = gve_unregister_qpl(priv, start_id + i);
+		err = gve_unregister_qpl(priv, gve_rx_get_qpl(priv, i));
 		/* This failure will trigger a reset - no need to clean */
 		if (err)
 			return err;
@@ -857,7 +868,6 @@ static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 {
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
-	cfg->qpls = priv->qpls;
 	cfg->ring_size = priv->tx_desc_cnt;
 	cfg->start_idx = 0;
 	cfg->num_rings = gve_num_tx_queues(priv);
@@ -914,9 +924,9 @@ static int gve_alloc_xdp_rings(struct gve_priv *priv)
 	return 0;
 }
 
-static int gve_alloc_rings(struct gve_priv *priv,
-			   struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-			   struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+static int gve_queues_mem_alloc(struct gve_priv *priv,
+				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int err;
 
@@ -1002,9 +1012,9 @@ static void gve_free_xdp_rings(struct gve_priv *priv)
 	}
 }
 
-static void gve_free_rings(struct gve_priv *priv,
-			   struct gve_tx_alloc_rings_cfg *tx_cfg,
-			   struct gve_rx_alloc_rings_cfg *rx_cfg)
+static void gve_queues_mem_free(struct gve_priv *priv,
+				struct gve_tx_alloc_rings_cfg *tx_cfg,
+				struct gve_rx_alloc_rings_cfg *rx_cfg)
 {
 	if (gve_is_gqi(priv)) {
 		gve_tx_free_rings_gqi(priv, tx_cfg);
@@ -1033,35 +1043,41 @@ int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 	return 0;
 }
 
-static int gve_alloc_queue_page_list(struct gve_priv *priv,
-				     struct gve_queue_page_list *qpl,
-				     u32 id, int pages)
+struct gve_queue_page_list *gve_alloc_queue_page_list(struct gve_priv *priv,
+						      u32 id, int pages)
 {
+	struct gve_queue_page_list *qpl;
 	int err;
 	int i;
 
+	qpl = kvzalloc(sizeof(*qpl), GFP_KERNEL);
+	if (!qpl)
+		return NULL;
+
 	qpl->id = id;
 	qpl->num_entries = 0;
 	qpl->pages = kvcalloc(pages, sizeof(*qpl->pages), GFP_KERNEL);
-	/* caller handles clean up */
 	if (!qpl->pages)
-		return -ENOMEM;
+		goto abort;
+
 	qpl->page_buses = kvcalloc(pages, sizeof(*qpl->page_buses), GFP_KERNEL);
-	/* caller handles clean up */
 	if (!qpl->page_buses)
-		return -ENOMEM;
+		goto abort;
 
 	for (i = 0; i < pages; i++) {
 		err = gve_alloc_page(priv, &priv->pdev->dev, &qpl->pages[i],
 				     &qpl->page_buses[i],
 				     gve_qpl_dma_dir(priv, id), GFP_KERNEL);
-		/* caller handles clean up */
 		if (err)
-			return -ENOMEM;
+			goto abort;
 		qpl->num_entries++;
 	}
 
-	return 0;
+	return qpl;
+
+abort:
+	gve_free_queue_page_list(priv, qpl, id);
+	return NULL;
 }
 
 void gve_free_page(struct device *dev, struct page *page, dma_addr_t dma,
@@ -1073,14 +1089,16 @@ void gve_free_page(struct device *dev, struct page *page, dma_addr_t dma,
 		put_page(page);
 }
 
-static void gve_free_queue_page_list(struct gve_priv *priv,
-				     struct gve_queue_page_list *qpl,
-				     int id)
+void gve_free_queue_page_list(struct gve_priv *priv,
+			      struct gve_queue_page_list *qpl,
+			      u32 id)
 {
 	int i;
 
-	if (!qpl->pages)
+	if (!qpl)
 		return;
+	if (!qpl->pages)
+		goto free_qpl;
 	if (!qpl->page_buses)
 		goto free_pages;
 
@@ -1093,109 +1111,8 @@ static void gve_free_queue_page_list(struct gve_priv *priv,
 free_pages:
 	kvfree(qpl->pages);
 	qpl->pages = NULL;
-}
-
-static void gve_free_n_qpls(struct gve_priv *priv,
-			    struct gve_queue_page_list *qpls,
-			    int start_id,
-			    int num_qpls)
-{
-	int i;
-
-	for (i = start_id; i < start_id + num_qpls; i++)
-		gve_free_queue_page_list(priv, &qpls[i], i);
-}
-
-static int gve_alloc_n_qpls(struct gve_priv *priv,
-			    struct gve_queue_page_list *qpls,
-			    int page_count,
-			    int start_id,
-			    int num_qpls)
-{
-	int err;
-	int i;
-
-	for (i = start_id; i < start_id + num_qpls; i++) {
-		err = gve_alloc_queue_page_list(priv, &qpls[i], i, page_count);
-		if (err)
-			goto free_qpls;
-	}
-
-	return 0;
-
-free_qpls:
-	/* Must include the failing QPL too for gve_alloc_queue_page_list fails
-	 * without cleaning up.
-	 */
-	gve_free_n_qpls(priv, qpls, start_id, i - start_id + 1);
-	return err;
-}
-
-static int gve_alloc_qpls(struct gve_priv *priv, struct gve_qpls_alloc_cfg *cfg,
-			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
-{
-	int max_queues = cfg->tx_cfg->max_queues + cfg->rx_cfg->max_queues;
-	int rx_start_id, tx_num_qpls, rx_num_qpls;
-	struct gve_queue_page_list *qpls;
-	u32 page_count;
-	int err;
-
-	if (cfg->raw_addressing)
-		return 0;
-
-	qpls = kvcalloc(max_queues, sizeof(*qpls), GFP_KERNEL);
-	if (!qpls)
-		return -ENOMEM;
-
-	/* Allocate TX QPLs */
-	page_count = priv->tx_pages_per_qpl;
-	tx_num_qpls = gve_num_tx_qpls(cfg->tx_cfg, cfg->num_xdp_queues,
-				      gve_is_qpl(priv));
-	err = gve_alloc_n_qpls(priv, qpls, page_count, 0, tx_num_qpls);
-	if (err)
-		goto free_qpl_array;
-
-	/* Allocate RX QPLs */
-	rx_start_id = gve_rx_start_qpl_id(cfg->tx_cfg);
-	/* For GQI_QPL number of pages allocated have 1:1 relationship with
-	 * number of descriptors. For DQO, number of pages required are
-	 * more than descriptors (because of out of order completions).
-	 * Set it to twice the number of descriptors.
-	 */
-	if (cfg->is_gqi)
-		page_count = rx_alloc_cfg->ring_size;
-	else
-		page_count = gve_get_rx_pages_per_qpl_dqo(rx_alloc_cfg->ring_size);
-	rx_num_qpls = gve_num_rx_qpls(cfg->rx_cfg, gve_is_qpl(priv));
-	err = gve_alloc_n_qpls(priv, qpls, page_count, rx_start_id, rx_num_qpls);
-	if (err)
-		goto free_tx_qpls;
-
-	cfg->qpls = qpls;
-	return 0;
-
-free_tx_qpls:
-	gve_free_n_qpls(priv, qpls, 0, tx_num_qpls);
-free_qpl_array:
-	kvfree(qpls);
-	return err;
-}
-
-static void gve_free_qpls(struct gve_priv *priv,
-			  struct gve_qpls_alloc_cfg *cfg)
-{
-	int max_queues = cfg->tx_cfg->max_queues + cfg->rx_cfg->max_queues;
-	struct gve_queue_page_list *qpls = cfg->qpls;
-	int i;
-
-	if (!qpls)
-		return;
-
-	for (i = 0; i < max_queues; i++)
-		gve_free_queue_page_list(priv, &qpls[i], i);
-
-	kvfree(qpls);
-	cfg->qpls = NULL;
+free_qpl:
+	kvfree(qpl);
 }
 
 /* Use this to schedule a reset when the device is capable of continuing
@@ -1299,17 +1216,6 @@ static void gve_drain_page_cache(struct gve_priv *priv)
 		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
 
-static void gve_qpls_get_curr_alloc_cfg(struct gve_priv *priv,
-					struct gve_qpls_alloc_cfg *cfg)
-{
-	  cfg->raw_addressing = !gve_is_qpl(priv);
-	  cfg->is_gqi = gve_is_gqi(priv);
-	  cfg->num_xdp_queues = priv->num_xdp_queues;
-	  cfg->tx_cfg = &priv->tx_cfg;
-	  cfg->rx_cfg = &priv->rx_cfg;
-	  cfg->qpls = priv->qpls;
-}
-
 static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_rx_alloc_rings_cfg *cfg)
 {
@@ -1317,7 +1223,6 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->qcfg_tx = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->enable_header_split = priv->header_split_enabled;
-	cfg->qpls = priv->qpls;
 	cfg->ring_size = priv->rx_desc_cnt;
 	cfg->packet_buffer_size = gve_is_gqi(priv) ?
 				  GVE_DEFAULT_RX_BUFFER_SIZE :
@@ -1326,11 +1231,9 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 }
 
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
-			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
-	gve_qpls_get_curr_alloc_cfg(priv, qpls_alloc_cfg);
 	gve_tx_get_curr_alloc_cfg(priv, tx_alloc_cfg);
 	gve_rx_get_curr_alloc_cfg(priv, rx_alloc_cfg);
 }
@@ -1362,53 +1265,13 @@ static void gve_rx_stop_rings(struct gve_priv *priv, int num_rings)
 	}
 }
 
-static void gve_queues_mem_free(struct gve_priv *priv,
-				struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
-				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
-{
-	gve_free_rings(priv, tx_alloc_cfg, rx_alloc_cfg);
-	gve_free_qpls(priv, qpls_alloc_cfg);
-}
-
-static int gve_queues_mem_alloc(struct gve_priv *priv,
-				struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
-				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
-{
-	int err;
-
-	err = gve_alloc_qpls(priv, qpls_alloc_cfg, rx_alloc_cfg);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "Failed to alloc QPLs\n");
-		return err;
-	}
-	tx_alloc_cfg->qpls = qpls_alloc_cfg->qpls;
-	rx_alloc_cfg->qpls = qpls_alloc_cfg->qpls;
-	err = gve_alloc_rings(priv, tx_alloc_cfg, rx_alloc_cfg);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "Failed to alloc rings\n");
-		goto free_qpls;
-	}
-
-	return 0;
-
-free_qpls:
-	gve_free_qpls(priv, qpls_alloc_cfg);
-	return err;
-}
-
 static void gve_queues_mem_remove(struct gve_priv *priv)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
-	gve_queues_mem_free(priv, &qpls_alloc_cfg,
-			    &tx_alloc_cfg, &rx_alloc_cfg);
-	priv->qpls = NULL;
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	priv->tx = NULL;
 	priv->rx = NULL;
 }
@@ -1417,7 +1280,6 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
  * No memory is allocated. Passed-in memory is freed on errors.
  */
 static int gve_queues_start(struct gve_priv *priv,
-			    struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
 			    struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			    struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
@@ -1425,7 +1287,6 @@ static int gve_queues_start(struct gve_priv *priv,
 	int err;
 
 	/* Record new resources into priv */
-	priv->qpls = qpls_alloc_cfg->qpls;
 	priv->tx = tx_alloc_cfg->tx;
 	priv->rx = rx_alloc_cfg->rx;
 
@@ -1497,23 +1358,19 @@ static int gve_open(struct net_device *dev)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
-	err = gve_queues_mem_alloc(priv, &qpls_alloc_cfg,
-				   &tx_alloc_cfg, &rx_alloc_cfg);
+	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	if (err)
 		return err;
 
 	/* No need to free on error: ownership of resources is lost after
 	 * calling gve_queues_start.
 	 */
-	err = gve_queues_start(priv, &qpls_alloc_cfg,
-			       &tx_alloc_cfg, &rx_alloc_cfg);
+	err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	if (err)
 		return err;
 
@@ -1572,11 +1429,8 @@ static int gve_close(struct net_device *dev)
 
 static int gve_remove_xdp_queues(struct gve_priv *priv)
 {
-	int qpl_start_id;
 	int err;
 
-	qpl_start_id = gve_xdp_tx_start_queue_id(priv);
-
 	err = gve_destroy_xdp_rings(priv);
 	if (err)
 		return err;
@@ -1588,27 +1442,19 @@ static int gve_remove_xdp_queues(struct gve_priv *priv)
 	gve_unreg_xdp_info(priv);
 	gve_free_xdp_rings(priv);
 
-	gve_free_n_qpls(priv, priv->qpls, qpl_start_id, gve_num_xdp_qpls(priv));
 	priv->num_xdp_queues = 0;
 	return 0;
 }
 
 static int gve_add_xdp_queues(struct gve_priv *priv)
 {
-	int start_id;
 	int err;
 
 	priv->num_xdp_queues = priv->rx_cfg.num_queues;
 
-	start_id = gve_xdp_tx_start_queue_id(priv);
-	err = gve_alloc_n_qpls(priv, priv->qpls, priv->tx_pages_per_qpl,
-			       start_id, gve_num_xdp_qpls(priv));
-	if (err)
-		goto err;
-
 	err = gve_alloc_xdp_rings(priv);
 	if (err)
-		goto free_xdp_qpls;
+		goto err;
 
 	err = gve_reg_xdp_info(priv, priv->dev);
 	if (err)
@@ -1626,8 +1472,6 @@ static int gve_add_xdp_queues(struct gve_priv *priv)
 
 free_xdp_rings:
 	gve_free_xdp_rings(priv);
-free_xdp_qpls:
-	gve_free_n_qpls(priv, priv->qpls, start_id, gve_num_xdp_qpls(priv));
 err:
 	priv->num_xdp_queues = 0;
 	return err;
@@ -1878,15 +1722,13 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 }
 
 int gve_adjust_config(struct gve_priv *priv,
-		      struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
 		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int err;
 
 	/* Allocate resources for the new confiugration */
-	err = gve_queues_mem_alloc(priv, qpls_alloc_cfg,
-				   tx_alloc_cfg, rx_alloc_cfg);
+	err = gve_queues_mem_alloc(priv, tx_alloc_cfg, rx_alloc_cfg);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "Adjust config failed to alloc new queues");
@@ -1898,14 +1740,12 @@ int gve_adjust_config(struct gve_priv *priv,
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "Adjust config failed to close old queues");
-		gve_queues_mem_free(priv, qpls_alloc_cfg,
-				    tx_alloc_cfg, rx_alloc_cfg);
+		gve_queues_mem_free(priv, tx_alloc_cfg, rx_alloc_cfg);
 		return err;
 	}
 
 	/* Bring the device back up again with the new resources. */
-	err = gve_queues_start(priv, qpls_alloc_cfg,
-			       tx_alloc_cfg, rx_alloc_cfg);
+	err = gve_queues_start(priv, tx_alloc_cfg, rx_alloc_cfg);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "Adjust config failed to start new queues, !!! DISABLING ALL QUEUES !!!\n");
@@ -1925,23 +1765,18 @@ int gve_adjust_queues(struct gve_priv *priv,
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	int err;
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	/* Relay the new config from ethtool */
-	qpls_alloc_cfg.tx_cfg = &new_tx_config;
 	tx_alloc_cfg.qcfg = &new_tx_config;
 	rx_alloc_cfg.qcfg_tx = &new_tx_config;
-	qpls_alloc_cfg.rx_cfg = &new_rx_config;
 	rx_alloc_cfg.qcfg = &new_rx_config;
 	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
 	if (netif_carrier_ok(priv->dev)) {
-		err = gve_adjust_config(priv, &qpls_alloc_cfg,
-					&tx_alloc_cfg, &rx_alloc_cfg);
+		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 		return err;
 	}
 	/* Set the config for the next up. */
@@ -2106,7 +1941,6 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	bool enable_hdr_split;
 	int err = 0;
 
@@ -2126,15 +1960,13 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
 	if (enable_hdr_split == priv->header_split_enabled)
 		return 0;
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	rx_alloc_cfg.enable_header_split = enable_hdr_split;
 	rx_alloc_cfg.packet_buffer_size = gve_get_pkt_buf_size(priv, enable_hdr_split);
 
 	if (netif_running(priv->dev))
-		err = gve_adjust_config(priv, &qpls_alloc_cfg,
-					&tx_alloc_cfg, &rx_alloc_cfg);
+		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	return err;
 }
 
@@ -2144,18 +1976,15 @@ static int gve_set_features(struct net_device *netdev,
 	const netdev_features_t orig_features = netdev->features;
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
-	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	struct gve_priv *priv = netdev_priv(netdev);
 	int err;
 
-	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
-				&tx_alloc_cfg, &rx_alloc_cfg);
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
 		netdev->features ^= NETIF_F_LRO;
 		if (netif_carrier_ok(netdev)) {
-			err = gve_adjust_config(priv, &qpls_alloc_cfg,
-						&tx_alloc_cfg, &rx_alloc_cfg);
+			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 			if (err) {
 				/* Revert the change on error. */
 				netdev->features = orig_features;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 79c1d8f63621..70aca2f2c8c3 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -41,7 +41,6 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 		for (i = 0; i < slots; i++)
 			page_ref_sub(rx->data.page_info[i].page,
 				     rx->data.page_info[i].pagecnt_bias - 1);
-		rx->data.qpl = NULL;
 
 		for (i = 0; i < rx->qpl_copy_pool_mask + 1; i++) {
 			page_ref_sub(rx->qpl_copy_pool[i].page,
@@ -107,6 +106,7 @@ static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	u32 slots = rx->mask + 1;
 	int idx = rx->q_num;
 	size_t bytes;
+	u32 qpl_id;
 
 	if (rx->desc.desc_ring) {
 		bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
@@ -132,6 +132,12 @@ static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	kvfree(rx->qpl_copy_pool);
 	rx->qpl_copy_pool = NULL;
 
+	if (rx->data.qpl) {
+		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, idx);
+		gve_free_queue_page_list(priv, rx->data.qpl, qpl_id);
+		rx->data.qpl = NULL;
+	}
+
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
 }
 
@@ -188,12 +194,6 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 	if (!rx->data.page_info)
 		return -ENOMEM;
 
-	if (!rx->data.raw_addressing) {
-		u32 qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
-
-		rx->data.qpl = &cfg->qpls[qpl_id];
-	}
-
 	for (i = 0; i < slots; i++) {
 		if (!rx->data.raw_addressing) {
 			struct page *page = rx->data.qpl->pages[i];
@@ -246,8 +246,6 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 		page_ref_sub(rx->data.page_info[i].page,
 			     rx->data.page_info[i].pagecnt_bias - 1);
 
-	rx->data.qpl = NULL;
-
 	return err;
 
 alloc_err_rda:
@@ -274,6 +272,8 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 	struct device *hdev = &priv->pdev->dev;
 	u32 slots = cfg->ring_size;
 	int filled_pages;
+	int qpl_page_cnt;
+	u32 qpl_id = 0;
 	size_t bytes;
 	int err;
 
@@ -306,10 +306,22 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 		goto abort_with_slots;
 	}
 
+	if (!rx->data.raw_addressing) {
+		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+		qpl_page_cnt = cfg->ring_size;
+
+		rx->data.qpl = gve_alloc_queue_page_list(priv, qpl_id,
+							 qpl_page_cnt);
+		if (!rx->data.qpl) {
+			err = -ENOMEM;
+			goto abort_with_copy_pool;
+		}
+	}
+
 	filled_pages = gve_rx_prefill_pages(rx, cfg);
 	if (filled_pages < 0) {
 		err = -ENOMEM;
-		goto abort_with_copy_pool;
+		goto abort_with_qpl;
 	}
 	rx->fill_cnt = filled_pages;
 	/* Ensure data ring slots (packet buffers) are visible. */
@@ -350,6 +362,11 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 	rx->q_resources = NULL;
 abort_filled:
 	gve_rx_unfill_pages(priv, rx, cfg);
+abort_with_qpl:
+	if (!rx->data.raw_addressing) {
+		gve_free_queue_page_list(priv, rx->data.qpl, qpl_id);
+		rx->data.qpl = NULL;
+	}
 abort_with_copy_pool:
 	kvfree(rx->qpl_copy_pool);
 	rx->qpl_copy_pool = NULL;
@@ -368,12 +385,6 @@ int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
 	int err = 0;
 	int i, j;
 
-	if (!cfg->raw_addressing && !cfg->qpls) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc QPL ring before allocing QPLs\n");
-		return -EINVAL;
-	}
-
 	rx = kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_rx_ring),
 		      GFP_KERNEL);
 	if (!rx)
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7c2980c212f4..4ea8ecc3b2d5 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -307,6 +307,7 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	size_t buffer_queue_slots;
 	int idx = rx->q_num;
 	size_t size;
+	u32 qpl_id;
 	int i;
 
 	completion_queue_slots = rx->dqo.complq.mask + 1;
@@ -325,7 +326,11 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
 	}
 
-	rx->dqo.qpl = NULL;
+	if (rx->dqo.qpl) {
+		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+		gve_free_queue_page_list(priv, rx->dqo.qpl, qpl_id);
+		rx->dqo.qpl = NULL;
+	}
 
 	if (rx->dqo.bufq.desc_ring) {
 		size = sizeof(rx->dqo.bufq.desc_ring[0]) * buffer_queue_slots;
@@ -377,7 +382,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 				 int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
+	int qpl_page_cnt;
 	size_t size;
+	u32 qpl_id;
 
 	const u32 buffer_queue_slots = cfg->ring_size;
 	const u32 completion_queue_slots = cfg->ring_size;
@@ -418,9 +425,13 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		goto err;
 
 	if (!cfg->raw_addressing) {
-		u32 qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+		qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+		qpl_page_cnt = gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 
-		rx->dqo.qpl = &cfg->qpls[qpl_id];
+		rx->dqo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
+							qpl_page_cnt);
+		if (!rx->dqo.qpl)
+			goto err;
 		rx->dqo.next_qpl_page_idx = 0;
 	}
 
@@ -454,12 +465,6 @@ int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
 	int err;
 	int i;
 
-	if (!cfg->raw_addressing && !cfg->qpls) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc QPL ring before allocing QPLs\n");
-		return -EINVAL;
-	}
-
 	rx = kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_rx_ring),
 		      GFP_KERNEL);
 	if (!rx)
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index f805700d67e7..24a64ec1073e 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -216,6 +216,7 @@ static void gve_tx_free_ring_gqi(struct gve_priv *priv, struct gve_tx_ring *tx,
 	struct device *hdev = &priv->pdev->dev;
 	int idx = tx->q_num;
 	size_t bytes;
+	u32 qpl_id;
 	u32 slots;
 
 	slots = tx->mask + 1;
@@ -223,8 +224,12 @@ static void gve_tx_free_ring_gqi(struct gve_priv *priv, struct gve_tx_ring *tx,
 			  tx->q_resources, tx->q_resources_bus);
 	tx->q_resources = NULL;
 
-	if (!tx->raw_addressing) {
-		gve_tx_fifo_release(priv, &tx->tx_fifo);
+	if (tx->tx_fifo.qpl) {
+		if (tx->tx_fifo.base)
+			gve_tx_fifo_release(priv, &tx->tx_fifo);
+
+		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		gve_free_queue_page_list(priv, tx->tx_fifo.qpl, qpl_id);
 		tx->tx_fifo.qpl = NULL;
 	}
 
@@ -255,6 +260,8 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 				 int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
+	int qpl_page_cnt;
+	u32 qpl_id = 0;
 	size_t bytes;
 
 	/* Make sure everything is zeroed to start */
@@ -279,12 +286,17 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 	tx->raw_addressing = cfg->raw_addressing;
 	tx->dev = hdev;
 	if (!tx->raw_addressing) {
-		u32 qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		qpl_page_cnt = priv->tx_pages_per_qpl;
+
+		tx->tx_fifo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
+							    qpl_page_cnt);
+		if (!tx->tx_fifo.qpl)
+			goto abort_with_desc;
 
-		tx->tx_fifo.qpl = &cfg->qpls[qpl_id];
 		/* map Tx FIFO */
 		if (gve_tx_fifo_init(priv, &tx->tx_fifo))
-			goto abort_with_desc;
+			goto abort_with_qpl;
 	}
 
 	tx->q_resources =
@@ -300,6 +312,11 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 abort_with_fifo:
 	if (!tx->raw_addressing)
 		gve_tx_fifo_release(priv, &tx->tx_fifo);
+abort_with_qpl:
+	if (!tx->raw_addressing) {
+		gve_free_queue_page_list(priv, tx->tx_fifo.qpl, qpl_id);
+		tx->tx_fifo.qpl = NULL;
+	}
 abort_with_desc:
 	dma_free_coherent(hdev, bytes, tx->desc, tx->bus);
 	tx->desc = NULL;
@@ -316,12 +333,6 @@ int gve_tx_alloc_rings_gqi(struct gve_priv *priv,
 	int err = 0;
 	int i, j;
 
-	if (!cfg->raw_addressing && !cfg->qpls) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc QPL ring before allocing QPLs\n");
-		return -EINVAL;
-	}
-
 	if (cfg->start_idx + cfg->num_rings > cfg->qcfg->max_queues) {
 		netif_err(priv, drv, priv->dev,
 			  "Cannot alloc more than the max num of Tx rings\n");
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 3d825e406c4b..fe1b26a4d736 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -209,6 +209,7 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	struct device *hdev = &priv->pdev->dev;
 	int idx = tx->q_num;
 	size_t bytes;
+	u32 qpl_id;
 
 	if (tx->q_resources) {
 		dma_free_coherent(hdev, sizeof(*tx->q_resources),
@@ -236,7 +237,11 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	kvfree(tx->dqo.tx_qpl_buf_next);
 	tx->dqo.tx_qpl_buf_next = NULL;
 
-	tx->dqo.qpl = NULL;
+	if (tx->dqo.qpl) {
+		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		gve_free_queue_page_list(priv, tx->dqo.qpl, qpl_id);
+		tx->dqo.qpl = NULL;
+	}
 
 	netif_dbg(priv, drv, priv->dev, "freed tx queue %d\n", idx);
 }
@@ -282,7 +287,9 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 {
 	struct device *hdev = &priv->pdev->dev;
 	int num_pending_packets;
+	int qpl_page_cnt;
 	size_t bytes;
+	u32 qpl_id;
 	int i;
 
 	memset(tx, 0, sizeof(*tx));
@@ -349,9 +356,13 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 		goto err;
 
 	if (!cfg->raw_addressing) {
-		u32 qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+		qpl_page_cnt = priv->tx_pages_per_qpl;
 
-		tx->dqo.qpl = &cfg->qpls[qpl_id];
+		tx->dqo.qpl = gve_alloc_queue_page_list(priv, qpl_id,
+							qpl_page_cnt);
+		if (!tx->dqo.qpl)
+			goto err;
 
 		if (gve_tx_qpl_buf_init(tx))
 			goto err;
@@ -371,12 +382,6 @@ int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
 	int err = 0;
 	int i, j;
 
-	if (!cfg->raw_addressing && !cfg->qpls) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc QPL ring before allocing QPLs\n");
-		return -EINVAL;
-	}
-
 	if (cfg->start_idx + cfg->num_rings > cfg->qcfg->max_queues) {
 		netif_err(priv, drv, priv->dev,
 			  "Cannot alloc more than the max num of Tx rings\n");
-- 
2.45.0.rc0.197.gbae5840b3b-goog


