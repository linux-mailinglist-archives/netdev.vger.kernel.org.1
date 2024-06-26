Return-Path: <netdev+bounces-106754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61348917889
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2943B218B5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495114A4C1;
	Wed, 26 Jun 2024 06:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E943148FF7
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382138; cv=none; b=Fme7c90dzfFbCy890v36Dde5FVMFTLApApKDrowIrKMtMEbUbtSEiVkEdnNDFURgOGJT/8fcGoK0tEdruc3tgoRjX5Ssx2SphJpVpSC0f/Ke6IvwLOd97PugFg4SLAYjEeqfRDXLYzwgrpYO3DOLfYi/BC6U0WWkqodOFGFeig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382138; c=relaxed/simple;
	bh=4d6/r+GnbfFq56RvyjPbH4Cwp1bN7kLIbh4/+UbqCCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaIO0pCB8Mf1HrO0OI+cGMk8Ipx8He8Fxd3LUCJ/CKqS1ORs03zI0QCgwqLw4kCd0T3hpacXjMmWbQEs8pWQiY0l9k9XTiWHHpkjF/MhdcryyLNn1OqYgThouugVt0/bC6c5slFvnJLpevbWy8hQq2FagDsoyCmDQ7cj/ShHQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1719382035tp6rhwsd
X-QQ-Originating-IP: lZDTu9e+3t4D3O9AEmwBS1rCvk8ejZ6gjSMZJ1p4rvM=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 14:07:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10226602197394032753
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
Subject: [PATCH net v2 2/2] net/txgbe: add extra handle for MSI/INTx into thread irq handle
Date: Wed, 26 Jun 2024 14:07:03 +0800
Message-Id: <20240626060703.31652-3-jiawenwu@trustnetic.com>
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

Rename original txgbe_misc_irq_handle() to txgbe_misc_irq_thread_fn()
since it is the handle thread to wake up. And add the primary handler
to deal the case of MSI/INTx, because there is a schedule NAPI poll.

Moreover, do not free isb resources in .ndo_stop, to avoid reading
memory by a null pointer.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 10 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 44 ++++++++++++++++---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 99f55a3573c8..f098758893b3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1686,6 +1686,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	}
 
 	pdev->irq = pci_irq_vector(pdev, 0);
+	wx->num_q_vectors = 1;
 
 	return 0;
 }
@@ -2027,6 +2028,9 @@ int wx_setup_isb_resources(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 
+	if (wx->isb_mem)
+		return 0;
+
 	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
 					 sizeof(u32) * 4,
 					 &wx->isb_dma,
@@ -2050,6 +2054,9 @@ void wx_free_isb_resources(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 
+	if (!wx->isb_mem)
+		return;
+
 	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
 			  wx->isb_mem, wx->isb_dma);
 	wx->isb_mem = NULL;
@@ -2386,7 +2393,8 @@ static void wx_free_all_tx_resources(struct wx *wx)
 
 void wx_free_resources(struct wx *wx)
 {
-	wx_free_isb_resources(wx);
+	if (wx->mac.type == wx_mac_em)
+		wx_free_isb_resources(wx);
 	wx_free_all_rx_resources(wx);
 	wx_free_all_tx_resources(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index ac789ec0091a..15e0fef02aac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -111,6 +111,36 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
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
@@ -157,6 +187,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
 {
+	unsigned long flags = IRQF_ONESHOT;
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
@@ -170,14 +201,17 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
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
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 76b5672c0a17..92c1fae826d0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -729,6 +729,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 
 	txgbe_remove_phy(txgbe);
 	txgbe_free_misc_irq(txgbe);
+	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-- 
2.27.0



