Return-Path: <netdev+bounces-114221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AF941898
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC36A1F210CA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679891898F2;
	Tue, 30 Jul 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjCLh4fH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED291A6192
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356599; cv=none; b=S3g4wvYmqLq9xNYND6xeD0qK+rnla0V3Iw7fZezMkkeeMewg0/vETL2ZHUBgqlZ6Ljj2465X+G+LTQc/jprg0mQf6VQRV91ukLADG0Go8HdG6TL+N2ZVSZCWo07pKXmI9bO2JOxj1EuEpsICuKpaHUZ6oa/fFhjbydsbQCkr9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356599; c=relaxed/simple;
	bh=Yj6/bpSP+ubZSRsNhUCvoRN1dMcjeDDLJZ1jzddx8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD9MulBCPr9clVrZoww2MDwl8EgeJJuK0TRTBDAbJfIO7Aj4Qy6Jr60Mj1mnEkB9TYk4jMd0q+YYkSay/qOoJozxPCQm6i5UO+toro6Mvu7bP69DoXqXrAXUa+s1vbrAcelj23/KXNj/tZa/F4DQTOCPrULVNRbuX4xxovToq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjCLh4fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1362C4AF0E;
	Tue, 30 Jul 2024 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356599;
	bh=Yj6/bpSP+ubZSRsNhUCvoRN1dMcjeDDLJZ1jzddx8OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjCLh4fHByBlfSYqJMXdd6Yju/BJTyMM9VC2WS0nIueOp9dQuXeZ/O+FncQmPt6bY
	 CGMMkA+dHh6Xfl6kC2/G4f8W5g0WAdHSb8MdPaVRPWhCxsDIus5wIoIMGv20O6BFpg
	 2xVfMZnQk17WxwxeIvA7BwuPnrmKuMYh2fFfMr4mesumb26AEArdG4oT4KMKh2dBKg
	 SwkpJf49GzSrhNLCYq42wR4EiJaKOHctpcHeBoOoK6xMxmqNXVjiLYdyt0qhCOcFmz
	 z3Kq0v84On8M1fp0XyS0ByWYUffg+PJWUP8APsKJw9Rr9tJdW1MQ8Oa4Bti9afIXGP
	 aoUC34/lMM5eQ==
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
Subject: [PATCH net-next 3/9] net: airoha: Move irq_mask in airoha_qdma structure
Date: Tue, 30 Jul 2024 18:22:42 +0200
Message-ID: <84a1ff3cd7c930c7928ad42b5d9df9bc7849ba9a.1722356015.git.lorenzo@kernel.org>
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

QDMA controllers have independent irq lines, so move irqmask in
airoha_qdma structure. This is a preliminary patch to support multiple
QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 84 +++++++++++-----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 10bb30732c32..6e46558f4277 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -786,6 +786,11 @@ struct airoha_hw_stats {
 struct airoha_qdma {
 	void __iomem *regs;
 
+	/* protect concurrent irqmask accesses */
+	spinlock_t irq_lock;
+	u32 irqmask[QDMA_INT_REG_MAX];
+	int irq;
+
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
@@ -812,11 +817,6 @@ struct airoha_eth {
 	unsigned long state;
 	void __iomem *fe_regs;
 
-	/* protect concurrent irqmask accesses */
-	spinlock_t irq_lock;
-	u32 irqmask[QDMA_INT_REG_MAX];
-	int irq;
-
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
 
@@ -866,38 +866,37 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
-static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
+static void airoha_qdma_set_irqmask(struct airoha_qdma *qdma, int index,
 				    u32 clear, u32 set)
 {
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(eth->irqmask)))
+	if (WARN_ON_ONCE(index >= ARRAY_SIZE(qdma->irqmask)))
 		return;
 
-	spin_lock_irqsave(&eth->irq_lock, flags);
+	spin_lock_irqsave(&qdma->irq_lock, flags);
 
-	eth->irqmask[index] &= ~clear;
-	eth->irqmask[index] |= set;
-	airoha_qdma_wr(&eth->qdma[0], REG_INT_ENABLE(index),
-		       eth->irqmask[index]);
+	qdma->irqmask[index] &= ~clear;
+	qdma->irqmask[index] |= set;
+	airoha_qdma_wr(qdma, REG_INT_ENABLE(index), qdma->irqmask[index]);
 	/* Read irq_enable register in order to guarantee the update above
 	 * completes in the spinlock critical section.
 	 */
-	airoha_qdma_rr(&eth->qdma[0], REG_INT_ENABLE(index));
+	airoha_qdma_rr(qdma, REG_INT_ENABLE(index));
 
-	spin_unlock_irqrestore(&eth->irq_lock, flags);
+	spin_unlock_irqrestore(&qdma->irq_lock, flags);
 }
 
-static void airoha_qdma_irq_enable(struct airoha_eth *eth, int index,
+static void airoha_qdma_irq_enable(struct airoha_qdma *qdma, int index,
 				   u32 mask)
 {
-	airoha_qdma_set_irqmask(eth, index, 0, mask);
+	airoha_qdma_set_irqmask(qdma, index, 0, mask);
 }
 
-static void airoha_qdma_irq_disable(struct airoha_eth *eth, int index,
+static void airoha_qdma_irq_disable(struct airoha_qdma *qdma, int index,
 				    u32 mask)
 {
-	airoha_qdma_set_irqmask(eth, index, mask, 0);
+	airoha_qdma_set_irqmask(qdma, index, mask, 0);
 }
 
 static void airoha_set_macaddr(struct airoha_eth *eth, const u8 *addr)
@@ -1522,7 +1521,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_queue *q = container_of(napi, struct airoha_queue, napi);
-	struct airoha_eth *eth = q->eth;
+	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	int cur, done = 0;
 
 	do {
@@ -1531,7 +1530,7 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 	} while (cur && done < budget);
 
 	if (done < budget && napi_complete(napi))
-		airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX1,
 				       RX_DONE_INT_MASK);
 
 	return done;
@@ -1718,7 +1717,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (done < budget && napi_complete(napi))
-		airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX0,
+		airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX0,
 				       TX_DONE_INT_MASK(id));
 
 	return done;
@@ -1928,13 +1927,13 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
 	int i;
 
 	/* clear pending irqs */
-	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++)
+	for (i = 0; i < ARRAY_SIZE(qdma->irqmask); i++)
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), 0xffffffff);
 
 	/* setup irqs */
-	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
-	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX1, INT_IDX1_MASK);
-	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX4, INT_IDX4_MASK);
+	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
+	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX1, INT_IDX1_MASK);
+	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX4, INT_IDX4_MASK);
 
 	/* setup irq binding */
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
@@ -1981,14 +1980,13 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
 static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
 	struct airoha_eth *eth = dev_instance;
-	u32 intr[ARRAY_SIZE(eth->irqmask)];
-	struct airoha_qdma *qdma;
+	struct airoha_qdma *qdma = &eth->qdma[0];
+	u32 intr[ARRAY_SIZE(qdma->irqmask)];
 	int i;
 
-	qdma = &eth->qdma[0];
-	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
+	for (i = 0; i < ARRAY_SIZE(qdma->irqmask); i++) {
 		intr[i] = airoha_qdma_rr(qdma, REG_INT_STATUS(i));
-		intr[i] &= eth->irqmask[i];
+		intr[i] &= qdma->irqmask[i];
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
@@ -1996,7 +1994,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		return IRQ_NONE;
 
 	if (intr[1] & RX_DONE_INT_MASK) {
-		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX1,
 					RX_DONE_INT_MASK);
 
 		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2016,7 +2014,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
 				continue;
 
-			airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX0,
+			airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 
 			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
@@ -2031,12 +2029,18 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-static int airoha_qdma_init(struct airoha_eth *eth)
+static int airoha_qdma_init(struct platform_device *pdev,
+			    struct airoha_eth *eth)
 {
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	int err;
 
-	err = devm_request_irq(eth->dev, eth->irq, airoha_irq_handler,
+	spin_lock_init(&qdma->irq_lock);
+	qdma->irq = platform_get_irq(pdev, 0);
+	if (qdma->irq < 0)
+		return qdma->irq;
+
+	err = devm_request_irq(eth->dev, qdma->irq, airoha_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, eth);
 	if (err)
 		return err;
@@ -2062,7 +2066,8 @@ static int airoha_qdma_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static int airoha_hw_init(struct airoha_eth *eth)
+static int airoha_hw_init(struct platform_device *pdev,
+			  struct airoha_eth *eth)
 {
 	int err;
 
@@ -2078,7 +2083,7 @@ static int airoha_hw_init(struct airoha_eth *eth)
 	if (err)
 		return err;
 
-	return airoha_qdma_init(eth);
+	return airoha_qdma_init(pdev, eth);
 }
 
 static void airoha_hw_cleanup(struct airoha_eth *eth)
@@ -2675,11 +2680,6 @@ static int airoha_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	spin_lock_init(&eth->irq_lock);
-	eth->irq = platform_get_irq(pdev, 0);
-	if (eth->irq < 0)
-		return eth->irq;
-
 	eth->napi_dev = alloc_netdev_dummy(0);
 	if (!eth->napi_dev)
 		return -ENOMEM;
@@ -2689,7 +2689,7 @@ static int airoha_probe(struct platform_device *pdev)
 	strscpy(eth->napi_dev->name, "qdma_eth", sizeof(eth->napi_dev->name));
 	platform_set_drvdata(pdev, eth);
 
-	err = airoha_hw_init(eth);
+	err = airoha_hw_init(pdev, eth);
 	if (err)
 		goto error;
 
-- 
2.45.2


