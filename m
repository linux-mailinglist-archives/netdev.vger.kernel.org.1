Return-Path: <netdev+bounces-114222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689394189C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BBD1C23175
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF901A619B;
	Tue, 30 Jul 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUW9NxWS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1F1078F
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356602; cv=none; b=T0hvYrOGXI+fGa+ofLeBtPNmb5L5I2IhoHUO1jNp0KRwdBN6eYMxpz9rRFQbeG31yLIyJwOWXnNJtpnqj7XfW2UZlJjmue/tUzVSGXAlcRlbqVvChHGu2ThDxwBJjJUc0OpWwTlE6yUxRY0OS5FO5t5mdKYmXK7D4HSTfwUdaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356602; c=relaxed/simple;
	bh=sfqBQSsAIVul+cWchZDkh1XCF3d97ktq4ROwF8F/vCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyxQcU/nlz3JaJYtiiwI0mjvXwNgLOl/kjP2uH2kjhwdYHTz3YLE3fGiOi0HZj5bUKGumcfGtY1hSpzg+JQ1jU9QbXJq89a1C04Hri0nF4d8KT9t6K67xd9K0O1A9WV+juK//EiOcHkvb6seiLNTmO4xhZt8sQ9FQ40EGa/FdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUW9NxWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56214C4AF0C;
	Tue, 30 Jul 2024 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356602;
	bh=sfqBQSsAIVul+cWchZDkh1XCF3d97ktq4ROwF8F/vCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUW9NxWSK2Y4K/c4WwKyS0w8iw5CveH1l/m6QqpjSheG5jVOasiuL7sqZHyGr8jwJ
	 ByppZ9AhCI9AYB5IMmgNEIXisd01LWqerevFGH86hrDPQEx4BHsqimfGAC/nWK+u2K
	 Hi2Fwl9U1M+3x9XGFTVubrbsgIYwqSNykGgVr3yW38J6aI1d1Ua43zsYdn47NE39K6
	 +r9O2DklT4Q3xgduHDY9+t2qWzQyvHYgeaT8cDB6pihckQSu1z1sMWvyumak48ld2q
	 H8aCNyDB7yolJTBdI5QdQ2+OGfMH/7rHJAIHPyfbwrSpY4q4UwkWQqlYXwVutnBs2p
	 BQarGASffTcDg==
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
Subject: [PATCH net-next 4/9] net: airoha: Add airoha_qdma pointer in airoha_tx_irq_queue/airoha_queue structures
Date: Tue, 30 Jul 2024 18:22:43 +0200
Message-ID: <b7e0112ae9717193c6eb5e5e3af8e790ad1ef91b.1722356015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move airoha_eth pointer in airoha_qdma structure from
airoha_tx_irq_queue/airoha_queue ones. This is a preliminary patch to
introduce support for multi-QDMA controllers available on EN7581.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 84 +++++++++++-----------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6e46558f4277..763b8df73552 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -728,7 +728,7 @@ struct airoha_queue_entry {
 };
 
 struct airoha_queue {
-	struct airoha_eth *eth;
+	struct airoha_qdma *qdma;
 
 	/* protect concurrent queue accesses */
 	spinlock_t lock;
@@ -747,7 +747,7 @@ struct airoha_queue {
 };
 
 struct airoha_tx_irq_queue {
-	struct airoha_eth *eth;
+	struct airoha_qdma *qdma;
 
 	struct napi_struct napi;
 	u32 *q;
@@ -784,6 +784,7 @@ struct airoha_hw_stats {
 };
 
 struct airoha_qdma {
+	struct airoha_eth *eth;
 	void __iomem *regs;
 
 	/* protect concurrent irqmask accesses */
@@ -1388,8 +1389,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
 static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
-	struct airoha_qdma *qdma = &q->eth->qdma[0];
-	struct airoha_eth *eth = q->eth;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
 	int nframes = 0;
 
@@ -1457,8 +1458,8 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
-	struct airoha_qdma *qdma = &q->eth->qdma[0];
-	struct airoha_eth *eth = q->eth;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
 	int done = 0;
 
@@ -1521,7 +1522,6 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_queue *q = container_of(napi, struct airoha_queue, napi);
-	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	int cur, done = 0;
 
 	do {
@@ -1530,14 +1530,13 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 	} while (cur && done < budget);
 
 	if (done < budget && napi_complete(napi))
-		airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_enable(q->qdma, QDMA_INT_REG_IDX1,
 				       RX_DONE_INT_MASK);
 
 	return done;
 }
 
-static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q,
+static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
 	const struct page_pool_params pp_params = {
@@ -1547,15 +1546,16 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 		.dma_dir = DMA_FROM_DEVICE,
 		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
-		.dev = eth->dev,
+		.dev = qdma->eth->dev,
 		.napi = &q->napi,
 	};
+	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
 	q->ndesc = ndesc;
-	q->eth = eth;
+	q->qdma = qdma;
 
 	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -1595,7 +1595,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 
 static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->eth;
+	struct airoha_eth *eth = q->qdma->eth;
 
 	while (q->queued) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
@@ -1609,8 +1609,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	}
 }
 
-static int airoha_qdma_init_rx(struct airoha_eth *eth,
-			       struct airoha_qdma *qdma)
+static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 {
 	int i;
 
@@ -1622,8 +1621,8 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth,
 			continue;
 		}
 
-		err = airoha_qdma_init_rx_queue(eth, &qdma->q_rx[i],
-						qdma, RX_DSCP_NUM(i));
+		err = airoha_qdma_init_rx_queue(&qdma->q_rx[i], qdma,
+						RX_DSCP_NUM(i));
 		if (err)
 			return err;
 	}
@@ -1639,9 +1638,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	int id, done = 0;
 
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
-	eth = irq_q->eth;
-	qdma = &eth->qdma[0];
+	qdma = irq_q->qdma;
 	id = irq_q - &qdma->q_tx_irq[0];
+	eth = qdma->eth;
 
 	while (irq_q->queued > 0 && done < budget) {
 		u32 qid, last, val = irq_q->q[irq_q->head];
@@ -1723,16 +1722,16 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
-static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q,
+static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int size)
 {
+	struct airoha_eth *eth = qdma->eth;
 	int i, qid = q - &qdma->q_tx[0];
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
 	q->ndesc = size;
-	q->eth = eth;
+	q->qdma = qdma;
 	q->free_thr = 1 + MAX_SKB_FRAGS;
 
 	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
@@ -1761,11 +1760,11 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 	return 0;
 }
 
-static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
-				   struct airoha_tx_irq_queue *irq_q,
+static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 				   struct airoha_qdma *qdma, int size)
 {
 	int id = irq_q - &qdma->q_tx_irq[0];
+	struct airoha_eth *eth = qdma->eth;
 	dma_addr_t dma_addr;
 
 	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
@@ -1777,7 +1776,7 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 
 	memset(irq_q->q, 0xff, size * sizeof(u32));
 	irq_q->size = size;
-	irq_q->eth = eth;
+	irq_q->qdma = qdma;
 
 	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
 	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
@@ -1788,21 +1787,20 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 	return 0;
 }
 
-static int airoha_qdma_init_tx(struct airoha_eth *eth,
-			       struct airoha_qdma *qdma)
+static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 {
 	int i, err;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-		err = airoha_qdma_tx_irq_init(eth, &qdma->q_tx_irq[i],
-					      qdma, IRQ_QUEUE_LEN(i));
+		err = airoha_qdma_tx_irq_init(&qdma->q_tx_irq[i], qdma,
+					      IRQ_QUEUE_LEN(i));
 		if (err)
 			return err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-		err = airoha_qdma_init_tx_queue(eth, &qdma->q_tx[i],
-						qdma, TX_DSCP_NUM);
+		err = airoha_qdma_init_tx_queue(&qdma->q_tx[i], qdma,
+						TX_DSCP_NUM);
 		if (err)
 			return err;
 	}
@@ -1812,7 +1810,7 @@ static int airoha_qdma_init_tx(struct airoha_eth *eth,
 
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->eth;
+	struct airoha_eth *eth = q->qdma->eth;
 
 	spin_lock_bh(&q->lock);
 	while (q->queued) {
@@ -1829,9 +1827,9 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 	spin_unlock_bh(&q->lock);
 }
 
-static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth,
-					struct airoha_qdma *qdma)
+static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 {
+	struct airoha_eth *eth = qdma->eth;
 	dma_addr_t dma_addr;
 	u32 status;
 	int size;
@@ -1870,8 +1868,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth,
 				 REG_LMGR_INIT_CFG);
 }
 
-static void airoha_qdma_init_qos(struct airoha_eth *eth,
-				 struct airoha_qdma *qdma)
+static void airoha_qdma_init_qos(struct airoha_qdma *qdma)
 {
 	airoha_qdma_clear(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_SCALE_MASK);
 	airoha_qdma_set(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_BASE_MASK);
@@ -1921,8 +1918,7 @@ static void airoha_qdma_init_qos(struct airoha_eth *eth,
 			FIELD_PREP(SLA_SLOW_TICK_RATIO_MASK, 40));
 }
 
-static int airoha_qdma_hw_init(struct airoha_eth *eth,
-			       struct airoha_qdma *qdma)
+static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 {
 	int i;
 
@@ -1960,7 +1956,7 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
 		       GLOBAL_CFG_TX_WB_DONE_MASK |
 		       FIELD_PREP(GLOBAL_CFG_MAX_ISSUE_NUM_MASK, 2));
 
-	airoha_qdma_init_qos(eth, qdma);
+	airoha_qdma_init_qos(qdma);
 
 	/* disable qdma rx delay interrupt */
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2036,6 +2032,8 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	int err;
 
 	spin_lock_init(&qdma->irq_lock);
+	qdma->eth = eth;
+
 	qdma->irq = platform_get_irq(pdev, 0);
 	if (qdma->irq < 0)
 		return qdma->irq;
@@ -2045,19 +2043,19 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_rx(eth, qdma);
+	err = airoha_qdma_init_rx(qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_tx(eth, qdma);
+	err = airoha_qdma_init_tx(qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_hfwd_queues(eth, qdma);
+	err = airoha_qdma_init_hfwd_queues(qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_hw_init(eth, qdma);
+	err = airoha_qdma_hw_init(qdma);
 	if (err)
 		return err;
 
-- 
2.45.2


