Return-Path: <netdev+bounces-105594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E390911E4F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1387B23C84
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77716C869;
	Fri, 21 Jun 2024 08:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C884A3B
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957474; cv=none; b=IYIyAXZXAUZHvE+dpbLiBK9z9Qk2ogWY7AXm1tPM+jnvUVglU19aDFMcumrcgW4SIga/86Xryc3fJ3LeZsiv23vINvYlIQCVnYkgJV0PUqwO/QKEzVLO9D5mjV86CEdqRqgZzXv3YDiUJRtUZ38TIyyMY8dnh7Ez53FsS+W/wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957474; c=relaxed/simple;
	bh=UVRUugxCi2rz0GMCUXW8NRovMUywxDQcmrx7X8f2WtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LRpmQkWqd0V0/2o3szQ7CB+XVhr2vDiHrVin1iiy6VQjw2fa7unOaEb8PCi3MHUaJvO3pagvsmBZwGhU/eAQy4MqfrHt7I2Nh4ZD2PElPMkstRW8MaXKG3Gm9iuCbHrQqB8kLReojO38cH260JJmXrQJ5WHEJUn8THqho4gFrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp80t1718957402tsmp13zy
X-QQ-Originating-IP: YA9FwO2Eic/F18HK6FyR5uVczgyyuiWUMULn3TWr8EY=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.224.151])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Jun 2024 16:09:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13975059555697223853
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix MSI and INTx interrupts
Date: Fri, 21 Jun 2024 16:09:51 +0800
Message-Id: <20240621080951.14368-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When using MSI or INTx interrupts, request_irq() for pdev->irq will
conflict with request_threaded_irq() for txgbe->misc.irq, to cause
system crash.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  13 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 122 +++++++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   3 +-
 4 files changed, 59 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 68bde91b67a0..f098758893b3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1686,6 +1686,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	}
 
 	pdev->irq = pci_irq_vector(pdev, 0);
+	wx->num_q_vectors = 1;
 
 	return 0;
 }
@@ -1996,7 +1997,8 @@ void wx_free_irq(struct wx *wx)
 	int vector;
 
 	if (!(pdev->msix_enabled)) {
-		free_irq(pdev->irq, wx);
+		if (wx->mac.type == wx_mac_em)
+			free_irq(pdev->irq, wx);
 		return;
 	}
 
@@ -2026,6 +2028,9 @@ int wx_setup_isb_resources(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 
+	if (wx->isb_mem)
+		return 0;
+
 	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
 					 sizeof(u32) * 4,
 					 &wx->isb_dma,
@@ -2049,6 +2054,9 @@ void wx_free_isb_resources(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 
+	if (!wx->isb_mem)
+		return;
+
 	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
 			  wx->isb_mem, wx->isb_dma);
 	wx->isb_mem = NULL;
@@ -2385,7 +2393,8 @@ static void wx_free_all_tx_resources(struct wx *wx)
 
 void wx_free_resources(struct wx *wx)
 {
-	wx_free_isb_resources(wx);
+	if (wx->mac.type == wx_mac_em)
+		wx_free_isb_resources(wx);
 	wx_free_all_rx_resources(wx);
 	wx_free_all_tx_resources(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index b3e3605d1edb..15e0fef02aac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -27,57 +27,19 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 }
 
 /**
- * txgbe_intr - msi/legacy mode Interrupt Handler
- * @irq: interrupt number
- * @data: pointer to a network interface device structure
- **/
-static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
-{
-	struct wx_q_vector *q_vector;
-	struct wx *wx  = data;
-	struct pci_dev *pdev;
-	u32 eicr;
-
-	q_vector = wx->q_vector[0];
-	pdev = wx->pdev;
-
-	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
-	if (!eicr) {
-		/* shared interrupt alert!
-		 * the interrupt that we masked before the ICR read.
-		 */
-		if (netif_running(wx->netdev))
-			txgbe_irq_enable(wx, true);
-		return IRQ_NONE;        /* Not our interrupt */
-	}
-	wx->isb_mem[WX_ISB_VEC0] = 0;
-	if (!(pdev->msi_enabled))
-		wr32(wx, WX_PX_INTA, 1);
-
-	wx->isb_mem[WX_ISB_MISC] = 0;
-	/* would disable interrupts here but it is auto disabled */
-	napi_schedule_irqoff(&q_vector->napi);
-
-	/* re-enable link(maybe) and non-queue interrupts, no flush.
-	 * txgbe_poll will re-enable the queue interrupts
-	 */
-	if (netif_running(wx->netdev))
-		txgbe_irq_enable(wx, false);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * txgbe_request_msix_irqs - Initialize MSI-X interrupts
+ * txgbe_request_queue_irqs - Initialize MSI-X queue interrupts
  * @wx: board private structure
  *
- * Allocate MSI-X vectors and request interrupts from the kernel.
+ * Allocate MSI-X queue vectors and request interrupts from the kernel.
  **/
-static int txgbe_request_msix_irqs(struct wx *wx)
+int txgbe_request_queue_irqs(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 	int vector, err;
 
+	if (!wx->pdev->msix_enabled)
+		return 0;
+
 	for (vector = 0; vector < wx->num_q_vectors; vector++) {
 		struct wx_q_vector *q_vector = wx->q_vector[vector];
 		struct msix_entry *entry = &wx->msix_q_entries[vector];
@@ -110,34 +72,6 @@ static int txgbe_request_msix_irqs(struct wx *wx)
 	return err;
 }
 
-/**
- * txgbe_request_irq - initialize interrupts
- * @wx: board private structure
- *
- * Attempt to configure interrupts using the best available
- * capabilities of the hardware and kernel.
- **/
-int txgbe_request_irq(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	struct pci_dev *pdev = wx->pdev;
-	int err;
-
-	if (pdev->msix_enabled)
-		err = txgbe_request_msix_irqs(wx);
-	else if (pdev->msi_enabled)
-		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
-				  netdev->name, wx);
-	else
-		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
-				  netdev->name, wx);
-
-	if (err)
-		wx_err(wx, "request_irq failed, Error %d\n", err);
-
-	return err;
-}
-
 static int txgbe_request_gpio_irq(struct txgbe *txgbe)
 {
 	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
@@ -177,6 +111,36 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
 };
 
 static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 eicr;
+
+	if (wx->pdev->msix_enabled)
+		return IRQ_WAKE_THREAD;
+
+	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
+	if (!eicr) {
+		/* shared interrupt alert!
+		 * the interrupt that we masked before the ICR read.
+		 */
+		if (netif_running(wx->netdev))
+			txgbe_irq_enable(wx, true);
+		return IRQ_NONE;        /* Not our interrupt */
+	}
+	wx->isb_mem[WX_ISB_VEC0] = 0;
+	if (!(wx->pdev->msi_enabled))
+		wr32(wx, WX_PX_INTA, 1);
+
+	/* would disable interrupts here but it is auto disabled */
+	q_vector = wx->q_vector[0];
+	napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 {
 	struct txgbe *txgbe = data;
 	struct wx *wx = txgbe->wx;
@@ -223,6 +187,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
 {
+	unsigned long flags = IRQF_ONESHOT;
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
@@ -236,14 +201,17 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 		irq_create_mapping(txgbe->misc.domain, hwirq);
 
 	txgbe->misc.chip = txgbe_irq_chip;
-	if (wx->pdev->msix_enabled)
+	if (wx->pdev->msix_enabled) {
 		txgbe->misc.irq = wx->msix_entry->vector;
-	else
+	} else {
 		txgbe->misc.irq = wx->pdev->irq;
+		if (!wx->pdev->msi_enabled)
+			flags |= IRQF_SHARED;
+	}
 
-	err = request_threaded_irq(txgbe->misc.irq, NULL,
-				   txgbe_misc_irq_handle,
-				   IRQF_ONESHOT,
+	err = request_threaded_irq(txgbe->misc.irq, txgbe_misc_irq_handle,
+				   txgbe_misc_irq_thread_fn,
+				   flags,
 				   wx->netdev->name, txgbe);
 	if (err)
 		goto del_misc_irq;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
index b77945e7a0f2..e6285b94625e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
@@ -2,6 +2,6 @@
 /* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
 
 void txgbe_irq_enable(struct wx *wx, bool queues);
-int txgbe_request_irq(struct wx *wx);
+int txgbe_request_queue_irqs(struct wx *wx);
 void txgbe_free_misc_irq(struct txgbe *txgbe);
 int txgbe_setup_misc_irq(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8c7a74981b90..92c1fae826d0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -294,7 +294,7 @@ static int txgbe_open(struct net_device *netdev)
 
 	wx_configure(wx);
 
-	err = txgbe_request_irq(wx);
+	err = txgbe_request_queue_irqs(wx);
 	if (err)
 		goto err_free_isb;
 
@@ -729,6 +729,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 
 	txgbe_remove_phy(txgbe);
 	txgbe_free_misc_irq(txgbe);
+	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-- 
2.27.0


