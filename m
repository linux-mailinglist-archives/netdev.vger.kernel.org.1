Return-Path: <netdev+bounces-106752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83687917887
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53561C21FFF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2C014A61A;
	Wed, 26 Jun 2024 06:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DC14B954
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382111; cv=none; b=nMaOKsoTmxnVVIaBsNGBDFBnbMqV8cKps8OT13kI5mstpm+oJkoy6IOb4YBxYuenjkOceqC18Uh6gDGaGNTYMiLx7R8IYaZHDpo9tLwvMN48yKZMFOvuu561X3QNCudGIMLxv9ceiBlYXfUW6Z/e1wVU09tDbGsGOL2NHJ25394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382111; c=relaxed/simple;
	bh=7TfyMqi448tKTHC90VCtVI1fR+Txam7a4A3EvruSXt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9nPONGoBAJ5+R2nCJEAXnqnButlfGQZTb8R28i7+bzMGRow35HHfxPh/l66A8olquPmY1N3nokc6BYNjbVtHYdyGrgun2KFiUmOrS8IQEO6MOMc39oPLlQH6sI3ou21wV1mcyQDF7odaikipHlGmKOWVAmDxfTXGtFQXvI30sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1719382033tpfdfe7o
X-QQ-Originating-IP: pVFWMs24sZBz6yJyZnobQHpxZO52G9gzEtUiA9bxeeE=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 14:07:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12094565687085345338
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 1/2] net: txgbe: remove separate irq request for MSI and INTx
Date: Wed, 26 Jun 2024 14:07:02 +0800
Message-Id: <20240626060703.31652-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240626060703.31652-1-jiawenwu@trustnetic.com>
References: <20240626060703.31652-1-jiawenwu@trustnetic.com>
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
system crash. So remove txgbe_request_irq() for MSI/INTx case, and
rename txgbe_request_msix_irqs() since it only request for queue irqs.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 78 ++-----------------
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
 4 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 68bde91b67a0..99f55a3573c8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1996,7 +1996,8 @@ void wx_free_irq(struct wx *wx)
 	int vector;
 
 	if (!(pdev->msix_enabled)) {
-		free_irq(pdev->irq, wx);
+		if (wx->mac.type == wx_mac_em)
+			free_irq(pdev->irq, wx);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index b3e3605d1edb..ac789ec0091a 100644
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
index 8c7a74981b90..76b5672c0a17 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -294,7 +294,7 @@ static int txgbe_open(struct net_device *netdev)
 
 	wx_configure(wx);
 
-	err = txgbe_request_irq(wx);
+	err = txgbe_request_queue_irqs(wx);
 	if (err)
 		goto err_free_isb;
 
-- 
2.27.0


