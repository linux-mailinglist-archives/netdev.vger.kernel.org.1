Return-Path: <netdev+bounces-115010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F10944E27
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9655CB21293
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04121A4F36;
	Thu,  1 Aug 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks0oF3uh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8F1A4885
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522944; cv=none; b=IWA6ahl01QGZFGi5kQSKf7L2BPwkd2ZKTShGgKkMvr/hTkRpML1z0Lcrk6vXTRhBHBMdvr6RlP2I3P4uNX30+aEFrbGIKPwGg5S8Exx9JlLmsnTxlsjoHAEq46ROIQZludW6vlY19DDhEzWaKMwnkMnBhfZiOgJNpj5kYey8ADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522944; c=relaxed/simple;
	bh=MdCYfXhI+5ylGk5FIhPJCeHlshTnPBveEQYvMXylFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXqwXSIEY9bqsnTwoolB0ODowdG9eH40X0tAzIpggCu9fTXKtyAhWYjJ3dNFuZSedsLkbNf0wUAQJtUN5TLKmPb//vOR7oSdd8+2OMvFNEOt8U4v4+YqFqEPoonJQIeBV86g36r7LJcMKLept6S6l/iwCM/J566N4quJtfe95H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks0oF3uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B666BC32786;
	Thu,  1 Aug 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522944;
	bh=MdCYfXhI+5ylGk5FIhPJCeHlshTnPBveEQYvMXylFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ks0oF3uhxGivw2b2OmB/yoapT1nLsPyHc1rGX/MtAW3KDJpLU+yI2DE6jHKYflBDm
	 kTIEU43c3xrIoN50AmSKQEG5y8fDpIXEo5+kar9wmfbtxEgc6hN4B4SNsA1wimwbT+
	 22gKcyAUCtcaPiw8cFzFZlkw+cHKyoqJJruAsV08l/XKTaMf1HYFlTj5dIAeDw3Fjl
	 O7ACaB89QB4fIaGi312Ugr9c1Fm2146SolpBppk00KCfDgsqPbUnrM7U49EPOPXy4M
	 VAr8HOSLWyiz5/KlqvYF905Jvkq0bow1jefc0dEQAQHavWhj6HMrhKX8FZLLvp8C1k
	 Q4JhgNm/7L0Og==
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
Subject: [PATCH v2 net-next 3/8] net: airoha: Move irq_mask in airoha_qdma structure
Date: Thu,  1 Aug 2024 16:35:05 +0200
Message-ID: <1c8a06e8be605278a7b2f3cd8ac06e74bf5ebf2b.1722522582.git.lorenzo@kernel.org>
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

QDMA controllers have independent irq lines, so move irqmask in
airoha_qdma structure. This is a preliminary patch to support multiple
QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 84 +++++++++++-----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index fc6712216c47..48d0b44e6d92 100644
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
@@ -1927,13 +1926,13 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
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
@@ -1979,14 +1978,13 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth,
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
 
@@ -1994,7 +1992,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		return IRQ_NONE;
 
 	if (intr[1] & RX_DONE_INT_MASK) {
-		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX1,
 					RX_DONE_INT_MASK);
 
 		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2014,7 +2012,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
 				continue;
 
-			airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX0,
+			airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 
 			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
@@ -2029,12 +2027,18 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
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
@@ -2060,7 +2064,8 @@ static int airoha_qdma_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static int airoha_hw_init(struct airoha_eth *eth)
+static int airoha_hw_init(struct platform_device *pdev,
+			  struct airoha_eth *eth)
 {
 	int err;
 
@@ -2076,7 +2081,7 @@ static int airoha_hw_init(struct airoha_eth *eth)
 	if (err)
 		return err;
 
-	return airoha_qdma_init(eth);
+	return airoha_qdma_init(pdev, eth);
 }
 
 static void airoha_hw_cleanup(struct airoha_eth *eth)
@@ -2673,11 +2678,6 @@ static int airoha_probe(struct platform_device *pdev)
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
@@ -2687,7 +2687,7 @@ static int airoha_probe(struct platform_device *pdev)
 	strscpy(eth->napi_dev->name, "qdma_eth", sizeof(eth->napi_dev->name));
 	platform_set_drvdata(pdev, eth);
 
-	err = airoha_hw_init(eth);
+	err = airoha_hw_init(pdev, eth);
 	if (err)
 		goto error;
 
-- 
2.45.2


