Return-Path: <netdev+bounces-184114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5CA9361E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6262A463161
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C92741AD;
	Fri, 18 Apr 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efrsB+cl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C7EEB3
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972877; cv=none; b=qt5wiAhDTF83KVK8VT1LXjAt/MqXWI968Y3tWu3wiLusA9HgHlqIHzOdReQgw49clCISNkwVmJpdpRe3SWWSAVAw1gXpzJg9tg6+ci+O6UqLaLhqeHFCfm+KT3Oxk3uGNJQ6HeqrQB2znjJGKFFLZAJTgZTrsoci9mxt6Ie+J7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972877; c=relaxed/simple;
	bh=uBaJ+y7RySKtcwtyANcpaQx2ruucaM16ol7dsI1Zh40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p74iM+FN2SbQAaQ2Pw9Cm4oRFmoC+YPrhxHnZwec7WBdeb3+d9GtbusXnmLkCGSeqqNmFSQn8GstTlE72Yz7O6SUJAu8WCij746rQbi+KpLnsZedM3QnBVzNbLC+bzGDkDvyv+rTsGpRp6wtBLRc9A4HRItZ7YZFMx/12eZWT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efrsB+cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6822FC4CEE2;
	Fri, 18 Apr 2025 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744972876;
	bh=uBaJ+y7RySKtcwtyANcpaQx2ruucaM16ol7dsI1Zh40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=efrsB+clnDYvHKXNt9PoMX2LIczBGTKnnDTcvWncDqrHJWG5F9fsghpyRiAXO5tti
	 IothoC87KhwLy4oq38Mje+9n/W5DWupwZUjPo2GdANHbjNt+4Q46rcSoNSPlbg9s5a
	 GlaqdXn3bNTrFkBb1XPPbUozwbDnzP1bstKX9dFy61jEVfkdEhr3SIfx8w1xtmRfI0
	 5s2sob1NFv89JmTiBYkIGEou0HToBoeoFryJHQUmGXEuE8BelGQg2s4UY53wUAehDC
	 1cVIewtE6R3sk35V9sv2JEL10tGVbB5iOLmoKBZzYg1bVo29OkJclO+EjKaJJeDF17
	 uH5latrdcUA/w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 18 Apr 2025 12:40:49 +0200
Subject: [PATCH net-next 1/2] net: airoha: Introduce airoha_irq_bank struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-airoha-eth-multi-irq-v1-1-1ab0083ca3c1@kernel.org>
References: <20250418-airoha-eth-multi-irq-v1-0-1ab0083ca3c1@kernel.org>
In-Reply-To: <20250418-airoha-eth-multi-irq-v1-0-1ab0083ca3c1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 ethernet SoC supports 4 programmable IRQ lines each one composed
by 4 IRQ configuration registers. Add airoha_irq_bank struct as a
container for independent IRQ lines info (e.g. IRQ number, enabled source
interrupts, ecc). This is a preliminary patch to support multiple IRQ lines
in airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 106 ++++++++++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h  |  13 +++-
 drivers/net/ethernet/airoha/airoha_regs.h |  11 ++--
 3 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c773b5ea9c051ab40ddd5c9ba5a1795ed36e6820..e1c1cf965c2f16e3fb4ad17f5299b27d9615da3f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -34,37 +34,40 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 	return val;
 }
 
-static void airoha_qdma_set_irqmask(struct airoha_qdma *qdma, int index,
-				    u32 clear, u32 set)
+static void airoha_qdma_set_irqmask(struct airoha_irq_bank *irq_bank,
+				    int index, u32 clear, u32 set)
 {
+	struct airoha_qdma *qdma = irq_bank->qdma;
+	int bank = irq_bank - &qdma->irq_banks[0];
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(qdma->irqmask)))
+	if (WARN_ON_ONCE(index >= ARRAY_SIZE(irq_bank->irqmask)))
 		return;
 
-	spin_lock_irqsave(&qdma->irq_lock, flags);
+	spin_lock_irqsave(&irq_bank->irq_lock, flags);
 
-	qdma->irqmask[index] &= ~clear;
-	qdma->irqmask[index] |= set;
-	airoha_qdma_wr(qdma, REG_INT_ENABLE(index), qdma->irqmask[index]);
+	irq_bank->irqmask[index] &= ~clear;
+	irq_bank->irqmask[index] |= set;
+	airoha_qdma_wr(qdma, REG_INT_ENABLE(bank, index),
+		       irq_bank->irqmask[index]);
 	/* Read irq_enable register in order to guarantee the update above
 	 * completes in the spinlock critical section.
 	 */
-	airoha_qdma_rr(qdma, REG_INT_ENABLE(index));
+	airoha_qdma_rr(qdma, REG_INT_ENABLE(bank, index));
 
-	spin_unlock_irqrestore(&qdma->irq_lock, flags);
+	spin_unlock_irqrestore(&irq_bank->irq_lock, flags);
 }
 
-static void airoha_qdma_irq_enable(struct airoha_qdma *qdma, int index,
-				   u32 mask)
+static void airoha_qdma_irq_enable(struct airoha_irq_bank *irq_bank,
+				   int index, u32 mask)
 {
-	airoha_qdma_set_irqmask(qdma, index, 0, mask);
+	airoha_qdma_set_irqmask(irq_bank, index, 0, mask);
 }
 
-static void airoha_qdma_irq_disable(struct airoha_qdma *qdma, int index,
-				    u32 mask)
+static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
+				    int index, u32 mask)
 {
-	airoha_qdma_set_irqmask(qdma, index, mask, 0);
+	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
 static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
@@ -732,6 +735,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_queue *q = container_of(napi, struct airoha_queue, napi);
+	struct airoha_irq_bank *irq_bank = &q->qdma->irq_banks[0];
 	int cur, done = 0;
 
 	do {
@@ -740,7 +744,7 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 	} while (cur && done < budget);
 
 	if (done < budget && napi_complete(napi))
-		airoha_qdma_irq_enable(q->qdma, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_enable(irq_bank, QDMA_INT_REG_IDX1,
 				       RX_DONE_INT_MASK);
 
 	return done;
@@ -944,7 +948,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (done < budget && napi_complete(napi))
-		airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX0,
+		airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX0,
 				       TX_DONE_INT_MASK(id));
 
 	return done;
@@ -1175,13 +1179,16 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 	int i;
 
 	/* clear pending irqs */
-	for (i = 0; i < ARRAY_SIZE(qdma->irqmask); i++)
+	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks[0].irqmask); i++)
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), 0xffffffff);
 
 	/* setup irqs */
-	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
-	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX1, INT_IDX1_MASK);
-	airoha_qdma_irq_enable(qdma, QDMA_INT_REG_IDX4, INT_IDX4_MASK);
+	airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX0,
+			       INT_IDX0_MASK);
+	airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX1,
+			       INT_IDX1_MASK);
+	airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX4,
+			       INT_IDX4_MASK);
 
 	/* setup irq binding */
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
@@ -1226,13 +1233,14 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 
 static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
-	struct airoha_qdma *qdma = dev_instance;
-	u32 intr[ARRAY_SIZE(qdma->irqmask)];
+	struct airoha_irq_bank *irq_bank = dev_instance;
+	struct airoha_qdma *qdma = irq_bank->qdma;
+	u32 intr[ARRAY_SIZE(irq_bank->irqmask)];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(qdma->irqmask); i++) {
+	for (i = 0; i < ARRAY_SIZE(intr); i++) {
 		intr[i] = airoha_qdma_rr(qdma, REG_INT_STATUS(i));
-		intr[i] &= qdma->irqmask[i];
+		intr[i] &= irq_bank->irqmask[i];
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
@@ -1240,7 +1248,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		return IRQ_NONE;
 
 	if (intr[1] & RX_DONE_INT_MASK) {
-		airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX1,
+		airoha_qdma_irq_disable(irq_bank, QDMA_INT_REG_IDX1,
 					RX_DONE_INT_MASK);
 
 		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -1257,7 +1265,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
 				continue;
 
-			airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX0,
+			airoha_qdma_irq_disable(irq_bank, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 			napi_schedule(&qdma->q_tx_irq[i].napi);
 		}
@@ -1266,6 +1274,39 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static int airoha_qdma_init_irq_banks(struct platform_device *pdev,
+				      struct airoha_qdma *qdma)
+{
+	struct airoha_eth *eth = qdma->eth;
+	int i, id = qdma - &eth->qdma[0];
+
+	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
+		struct airoha_irq_bank *irq_bank = &qdma->irq_banks[i];
+		int err, irq_index = 4 * id + i;
+		const char *name;
+
+		spin_lock_init(&irq_bank->irq_lock);
+		irq_bank->qdma = qdma;
+
+		irq_bank->irq = platform_get_irq(pdev, irq_index);
+		if (irq_bank->irq < 0)
+			return irq_bank->irq;
+
+		name = devm_kasprintf(eth->dev, GFP_KERNEL,
+				      KBUILD_MODNAME ".%d", irq_index);
+		if (!name)
+			return -ENOMEM;
+
+		err = devm_request_irq(eth->dev, irq_bank->irq,
+				       airoha_irq_handler, IRQF_SHARED, name,
+				       irq_bank);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int airoha_qdma_init(struct platform_device *pdev,
 			    struct airoha_eth *eth,
 			    struct airoha_qdma *qdma)
@@ -1273,9 +1314,7 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	int err, id = qdma - &eth->qdma[0];
 	const char *res;
 
-	spin_lock_init(&qdma->irq_lock);
 	qdma->eth = eth;
-
 	res = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d", id);
 	if (!res)
 		return -ENOMEM;
@@ -1285,12 +1324,7 @@ static int airoha_qdma_init(struct platform_device *pdev,
 		return dev_err_probe(eth->dev, PTR_ERR(qdma->regs),
 				     "failed to iomap qdma%d regs\n", id);
 
-	qdma->irq = platform_get_irq(pdev, 4 * id);
-	if (qdma->irq < 0)
-		return qdma->irq;
-
-	err = devm_request_irq(eth->dev, qdma->irq, airoha_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, qdma);
+	err = airoha_qdma_init_irq_banks(pdev, qdma);
 	if (err)
 		return err;
 
@@ -2784,7 +2818,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	dev->features |= dev->hw_features;
 	dev->vlan_features = dev->hw_features;
 	dev->dev.of_node = np;
-	dev->irq = qdma->irq;
+	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index da5371bcd14732afdeb2430e24bcbddaf9c479f7..af263203d488e1246f4ff16921684a2532645fa4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -17,6 +17,7 @@
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		2
+#define AIROHA_MAX_NUM_IRQ_BANKS	1
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		5
@@ -452,17 +453,23 @@ struct airoha_flow_table_entry {
 	unsigned long cookie;
 };
 
-struct airoha_qdma {
-	struct airoha_eth *eth;
-	void __iomem *regs;
+struct airoha_irq_bank {
+	struct airoha_qdma *qdma;
 
 	/* protect concurrent irqmask accesses */
 	spinlock_t irq_lock;
 	u32 irqmask[QDMA_INT_REG_MAX];
 	int irq;
+};
+
+struct airoha_qdma {
+	struct airoha_eth *eth;
+	void __iomem *regs;
 
 	atomic_t users;
 
+	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
+
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 29c8f046b9910c371ab4edc34b01f58d7383ae8d..1d99fe9f81124441e3f8fda77df4e04eee0e131b 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -423,11 +423,12 @@
 	 ((_n) == 2) ? 0x0720 :		\
 	 ((_n) == 1) ? 0x0024 : 0x0020)
 
-#define REG_INT_ENABLE(_n)		\
-	(((_n) == 4) ? 0x0750 :		\
-	 ((_n) == 3) ? 0x0744 :		\
-	 ((_n) == 2) ? 0x0740 :		\
-	 ((_n) == 1) ? 0x002c : 0x0028)
+#define REG_INT_ENABLE(_b, _n)		\
+	(((_n) == 4) ? 0x0750 + ((_b) << 5) :	\
+	 ((_n) == 3) ? 0x0744 + ((_b) << 5) :	\
+	 ((_n) == 2) ? 0x0740 + ((_b) << 5) :	\
+	 ((_n) == 1) ? 0x002c + ((_b) << 3) :	\
+		       0x0028 + ((_b) << 3))
 
 /* QDMA_CSR_INT_ENABLE1 */
 #define RX15_COHERENT_INT_MASK		BIT(31)

-- 
2.49.0


