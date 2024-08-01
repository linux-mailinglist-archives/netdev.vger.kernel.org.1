Return-Path: <netdev+bounces-115009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DC944E26
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01960284A26
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACA1A4F39;
	Thu,  1 Aug 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncIbq8LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693351A4885
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522940; cv=none; b=kPxk+lf+794LrFL2KqAKyWWAA3YcbZqcNyaMfRIYbGQLU2yUlWaeYCmlk2gOPsvBpFfKLbLcXUjJgl8j5bfPr+Zfafv4hWDX9Z0EZI7T3vMqN4+hKsEh+VG/VgvH7sJqeYSdh1gQpcDxoQpCdVagfgE8vA9yOlyFDnrtLnOl1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522940; c=relaxed/simple;
	bh=GZyIPN1G+25wGME29PtVRV32mdWiEPrTkVniXVVudEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifTqtnELiDReCV2tT+fiByy5fwZ34ycDvpHzPc1clLBgSsYH0HgM1Wv3HRDXJlF8b1+1eSzMR2K2/i83b6rA0o6q/DruTlrzVhoT0up8hwyCfV6jvOBY63nfXjJK/gjvMkvmBYTkWbpWP9VZsm6VpF3xuK1pA6piuVnPUU5Wp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncIbq8LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9755C32786;
	Thu,  1 Aug 2024 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522940;
	bh=GZyIPN1G+25wGME29PtVRV32mdWiEPrTkVniXVVudEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncIbq8LMQwgIVZ0GmyORKdsTx6RYJRvq5csUxjffsneF5R7EsmrYKUEc2eLzr8xhn
	 PNIJBDmSgk38pv4o6KAaVgBsDPQpCPubJdwHF31Kffxw3fjoRpmw/yNSYu+apcsWPz
	 JjCULs+bYGvwbHjIMlR67EXIYksBnLNZny3UKQi5ijVrOXYpLW64q1etNbhmH3akys
	 W6cXn8yN7jopc5Cze09WLQG7k3aQHnWW4bP0YGF1vDjRr4HGGsjOysv1xcv9uAD+gm
	 CqnycXcZ8EV85OCSYmI3r67jHLc+2/1nqoX5o2jYYt/hv+0MqZtQ4o9eTWw8j29zXV
	 evSuicvqDAjaQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH v2 net-next 2/8] net: airoha: Move airoha_queues in airoha_qdma
Date: Thu,  1 Aug 2024 16:35:04 +0200
Message-ID: <795fc4797bffbf7f0a1351308aa9bf0e65b5126e.1722522582.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722522582.git.lorenzo@kernel.org>
References: <cover.1722522582.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QDMA controllers available in EN7581 SoC have independent tx/rx hw queues
so move them in airoha_queues structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 126 +++++++++++----------
 1 file changed, 65 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 7add08bac8cf..fc6712216c47 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -785,6 +785,17 @@ struct airoha_hw_stats {
 
 struct airoha_qdma {
 	void __iomem *regs;
+
+	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
+
+	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
+	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	/* descriptor and packet buffers for qdma hw forward */
+	struct {
+		void *desc;
+		void *q;
+	} hfwd;
 };
 
 struct airoha_gdm_port {
@@ -809,20 +820,10 @@ struct airoha_eth {
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
 
-	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
-
 	struct net_device *napi_dev;
-	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
-	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
-
-	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
 
-	/* descriptor and packet buffers for qdma hw forward */
-	struct {
-		void *desc;
-		void *q;
-	} hfwd;
+	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
+	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
 };
 
 static u32 airoha_rr(void __iomem *base, u32 offset)
@@ -1390,7 +1391,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
 	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	struct airoha_eth *eth = q->eth;
-	int qid = q - &eth->q_rx[0];
+	int qid = q - &qdma->q_rx[0];
 	int nframes = 0;
 
 	while (q->queued < q->ndesc - 1) {
@@ -1457,8 +1458,9 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	struct airoha_eth *eth = q->eth;
-	int qid = q - &eth->q_rx[0];
+	int qid = q - &qdma->q_rx[0];
 	int done = 0;
 
 	while (done < budget) {
@@ -1549,7 +1551,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 		.dev = eth->dev,
 		.napi = &q->napi,
 	};
-	int qid = q - &eth->q_rx[0], thr;
+	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
@@ -1613,7 +1615,7 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth,
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		int err;
 
 		if (!(RX_DONE_INT_MASK & BIT(i))) {
@@ -1621,7 +1623,7 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth,
 			continue;
 		}
 
-		err = airoha_qdma_init_rx_queue(eth, &eth->q_rx[i],
+		err = airoha_qdma_init_rx_queue(eth, &qdma->q_rx[i],
 						qdma, RX_DSCP_NUM(i));
 		if (err)
 			return err;
@@ -1640,7 +1642,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
 	eth = irq_q->eth;
 	qdma = &eth->qdma[0];
-	id = irq_q - &eth->q_tx_irq[0];
+	id = irq_q - &qdma->q_tx_irq[0];
 
 	while (irq_q->queued > 0 && done < budget) {
 		u32 qid, last, val = irq_q->q[irq_q->head];
@@ -1657,10 +1659,10 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		last = FIELD_GET(IRQ_DESC_IDX_MASK, val);
 		qid = FIELD_GET(IRQ_RING_IDX_MASK, val);
 
-		if (qid >= ARRAY_SIZE(eth->q_tx))
+		if (qid >= ARRAY_SIZE(qdma->q_tx))
 			continue;
 
-		q = &eth->q_tx[qid];
+		q = &qdma->q_tx[qid];
 		if (!q->ndesc)
 			continue;
 
@@ -1726,7 +1728,7 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 				     struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int size)
 {
-	int i, qid = q - &eth->q_tx[0];
+	int i, qid = q - &qdma->q_tx[0];
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
@@ -1764,7 +1766,7 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 				   struct airoha_tx_irq_queue *irq_q,
 				   struct airoha_qdma *qdma, int size)
 {
-	int id = irq_q - &eth->q_tx_irq[0];
+	int id = irq_q - &qdma->q_tx_irq[0];
 	dma_addr_t dma_addr;
 
 	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
@@ -1792,15 +1794,15 @@ static int airoha_qdma_init_tx(struct airoha_eth *eth,
 {
 	int i, err;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-		err = airoha_qdma_tx_irq_init(eth, &eth->q_tx_irq[i],
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		err = airoha_qdma_tx_irq_init(eth, &qdma->q_tx_irq[i],
 					      qdma, IRQ_QUEUE_LEN(i));
 		if (err)
 			return err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		err = airoha_qdma_init_tx_queue(eth, &eth->q_tx[i],
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		err = airoha_qdma_init_tx_queue(eth, &qdma->q_tx[i],
 						qdma, TX_DSCP_NUM);
 		if (err)
 			return err;
@@ -1836,17 +1838,17 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth,
 	int size;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
-	eth->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					     GFP_KERNEL);
-	if (!eth->hfwd.desc)
+	qdma->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
+					      GFP_KERNEL);
+	if (!qdma->hfwd.desc)
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	eth->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					  GFP_KERNEL);
-	if (!eth->hfwd.q)
+	qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
+					   GFP_KERNEL);
+	if (!qdma->hfwd.q)
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
@@ -1934,8 +1936,8 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
 	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX4, INT_IDX4_MASK);
 
 	/* setup irq binding */
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		if (!eth->q_tx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
 			continue;
 
 		if (TX_RING_IRQ_BLOCKING_MAP_MASK & BIT(i))
@@ -1960,8 +1962,8 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
 	airoha_qdma_init_qos(eth, qdma);
 
 	/* disable qdma rx delay interrupt */
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
 		airoha_qdma_clear(qdma, REG_RX_DELAY_INT_IDX(i),
@@ -1995,18 +1997,18 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
 					RX_DONE_INT_MASK);
 
-		for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-			if (!eth->q_rx[i].ndesc)
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			if (!qdma->q_rx[i].ndesc)
 				continue;
 
 			if (intr[1] & BIT(i))
-				napi_schedule(&eth->q_rx[i].napi);
+				napi_schedule(&qdma->q_rx[i].napi);
 		}
 	}
 
 	if (intr[0] & INT_TX_MASK) {
-		for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-			struct airoha_tx_irq_queue *irq_q = &eth->q_tx_irq[i];
+		for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+			struct airoha_tx_irq_queue *irq_q = &qdma->q_tx_irq[i];
 			u32 status, head;
 
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
@@ -2020,7 +2022,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			irq_q->head = head % irq_q->size;
 			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
 
-			napi_schedule(&eth->q_tx_irq[i].napi);
+			napi_schedule(&qdma->q_tx_irq[i].napi);
 		}
 	}
 
@@ -2079,44 +2081,46 @@ static int airoha_hw_init(struct airoha_eth *eth)
 
 static void airoha_hw_cleanup(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_disable(&eth->q_rx[i].napi);
-		netif_napi_del(&eth->q_rx[i].napi);
-		airoha_qdma_cleanup_rx_queue(&eth->q_rx[i]);
-		if (eth->q_rx[i].page_pool)
-			page_pool_destroy(eth->q_rx[i].page_pool);
+		napi_disable(&qdma->q_rx[i].napi);
+		netif_napi_del(&qdma->q_rx[i].napi);
+		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
+		if (qdma->q_rx[i].page_pool)
+			page_pool_destroy(qdma->q_rx[i].page_pool);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-		napi_disable(&eth->q_tx_irq[i].napi);
-		netif_napi_del(&eth->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		napi_disable(&qdma->q_tx_irq[i].napi);
+		netif_napi_del(&qdma->q_tx_irq[i].napi);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		if (!eth->q_tx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
 			continue;
 
-		airoha_qdma_cleanup_tx_queue(&eth->q_tx[i]);
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
 	}
 }
 
 static void airoha_qdma_start_napi(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
-		napi_enable(&eth->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		napi_enable(&qdma->q_tx_irq[i].napi);
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_enable(&eth->q_rx[i].napi);
+		napi_enable(&qdma->q_rx[i].napi);
 	}
 }
 
@@ -2391,7 +2395,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
 	qdma = &eth->qdma[0];
-	q = &eth->q_tx[qid];
+	q = &qdma->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
 
-- 
2.45.2


