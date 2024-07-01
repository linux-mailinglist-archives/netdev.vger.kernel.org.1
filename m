Return-Path: <netdev+bounces-108006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73391D8B8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571212815C3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237E6EB4A;
	Mon,  1 Jul 2024 07:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C87406D
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818127; cv=none; b=YuzuJxuWYb0KybFv/IW4X3ysUbXwfFQftm5bndHvXNkD8SZ9d7tR+P4wg9nsYlC8hE14QAXrZNjK8QiN3bFp79OUA+C+GzuZnYuGeb4P6kms6ERYbCucpKBpu4cgJByao1kwTyzqT9AkxHggpiVZasjMW/+kNlUlb1u0ehKFTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818127; c=relaxed/simple;
	bh=gzQWSltr9sPaKg9CupcK7CXu2I8jESr4Ypv0NrPRb38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/X2DT/k8RGwJNOXKqRTD8YKii/ZxGjbkg1wYlxuATQLTq4RoH33YwQTAEGiIuh+4aU0RAARqS98ckY6W908n42gAPCGIQHMwz5juBO8ZZfNCFIrQ9Sr2UDCJX5/Bur3/jqEpTDcplvnRH7v7wyxeM4GT8y5sm9QfWmp4dv83Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1719818069tggkhis9
X-QQ-Originating-IP: mvwfBNP6JMj6JWUpggeqYQzlQwlC//mDZlfXGmk94Dg=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 15:14:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15239171740786974454
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
Subject: [PATCH net v3 2/4] net: txgbe: remove separate irq request for MSI and INTx
Date: Mon,  1 Jul 2024 15:14:14 +0800
Message-Id: <20240701071416.8468-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240701071416.8468-1-jiawenwu@trustnetic.com>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
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

Add wx->misc_irq_domain to determine whether the driver creates an IRQ
domain and threaded request the IRQs.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  5 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 80 ++-----------------
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
 6 files changed, 15 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 7c4b6881a93f..d1b682ce9c6d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1959,6 +1959,7 @@ int wx_sw_init(struct wx *wx)
 	}
 
 	bitmap_zero(wx->state, WX_STATE_NBITS);
+	wx->misc_irq_domain = false;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index f53776877f71..e1f514b21090 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1997,7 +1997,8 @@ void wx_free_irq(struct wx *wx)
 	int vector;
 
 	if (!(pdev->msix_enabled)) {
-		free_irq(pdev->irq, wx);
+		if (!wx->misc_irq_domain)
+			free_irq(pdev->irq, wx);
 		return;
 	}
 
@@ -2012,7 +2013,7 @@ void wx_free_irq(struct wx *wx)
 		free_irq(entry->vector, q_vector);
 	}
 
-	if (wx->mac.type == wx_mac_em)
+	if (!wx->misc_irq_domain)
 		free_irq(wx->msix_entry->vector, wx);
 }
 EXPORT_SYMBOL(wx_free_irq);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5aaf7b1fa2db..0df7f5712b6f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1058,6 +1058,7 @@ struct wx {
 	dma_addr_t isb_dma;
 	u32 *isb_mem;
 	u32 isb_tag[WX_ISB_MAX];
+	bool misc_irq_domain;
 
 #define WX_MAX_RETA_ENTRIES 128
 #define WX_RSS_INDIR_TBL_MAX 64
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index b3e3605d1edb..1490fd6ddbdf 100644
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
@@ -256,6 +190,8 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (err)
 		goto free_gpio_irq;
 
+	wx->misc_irq_domain = true;
+
 	return 0;
 
 free_gpio_irq:
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


