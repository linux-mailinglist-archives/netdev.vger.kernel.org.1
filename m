Return-Path: <netdev+bounces-65763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD583B98A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CD71F23958
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ACE10A12;
	Thu, 25 Jan 2024 06:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D21118E
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163858; cv=none; b=NFhKCBHUkQRDZ0I6v1UNSQgAWgqD90DW3x9kjeJ0FxYLPXzerZ9kXUbB3jSEAh+ijXgGWOKV9noZeA237KlGuH0SxqmVVOwMkeL8zJdXwLuP1DqXEWpnJOw/KT0FU5JLwcxlTiHr4wS7bDJznW0KMg0ZQyu6wbEz2HrelaWpexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163858; c=relaxed/simple;
	bh=dcJb5cwJ25x7oKX1vxurkgg2NrzhhV02OPGc+afU+Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnjfSKUrJKoCdn/GoDfy2Ji40Mc2PGHkMU/sfmW8s0sFd3GI6TFT7OSt1ZoddpMZZ1hZiJXO5j0Z7y/Aaj/UfTOft7kRzHOjNAix/dqvRUmuPYK0qrXh1/uZNEvC94vsVKRASPXK9jAeBU9bBMEeMgE0ClLoW0P9mIDqOMEnlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp66t1706163762til48w7f
X-QQ-Originating-IP: /hw59KBUlo6taHiGnylkpJNoB42afaJzTCh99NQ3ohM=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.185.81])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jan 2024 14:22:41 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKbSj3MHqbGMpoIfWzkWhxhyGDv5InsiMRReGsShbyv74TI0uqzO9
	ydhSYE9k0ibVAIzecP9wl/HUUtJWggtgOylxvMYROrMnwdaPbC+qPhNwVEGsL7iakaeFhjI
	59WZ2S5A0kpT5Uv1SwLoThNrCYJJzziLd3m0XhOmTLZP/U+OaowFqNUD7Ti9ypAo8oXD5UU
	EecmhygGRIMqDL+ToIm9nqC6woxjHxVYOXkW+10Tsl6in68MQG8NXeeHD4CcDYSoUljVSj0
	CB8XggKicInB1JloCPb1zCTnPU7WRHlVApIUZSzxtn7nrNZr6y5c6qRRMgCrsaluzG/ynvf
	amntZubZrxIp3WBSyN9c9khbhMvdR9N6BfpBYxQKXaLvK2cDMuvJ9QfEBEzUa52SIHxUDZS
	oM9z8ftpvOQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4210680236499607668
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 1/2] net: txgbe: move interrupt codes to a separate file
Date: Thu, 25 Jan 2024 14:22:12 +0800
Message-Id: <20240125062213.28248-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240125062213.28248-1-jiawenwu@trustnetic.com>
References: <20240125062213.28248-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

In order to change the interrupt response structure, there will be a
lot of code added next. Move these interrupt codes to a new file, to
make the codes cleaner.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 137 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   5 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 128 +---------------
 4 files changed, 144 insertions(+), 127 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h

diff --git a/drivers/net/ethernet/wangxun/txgbe/Makefile b/drivers/net/ethernet/wangxun/txgbe/Makefile
index 7507f762edfe..42718875277c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/Makefile
+++ b/drivers/net/ethernet/wangxun/txgbe/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_TXGBE) += txgbe.o
 txgbe-objs := txgbe_main.o \
               txgbe_hw.o \
               txgbe_phy.o \
+              txgbe_irq.o \
               txgbe_ethtool.o
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
new file mode 100644
index 000000000000..d26ee4cb1767
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/pci.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
+#include "txgbe_type.h"
+#include "txgbe_irq.h"
+
+/**
+ * txgbe_irq_enable - Enable default interrupt generation settings
+ * @wx: pointer to private structure
+ * @queues: enable irqs for queues
+ **/
+void txgbe_irq_enable(struct wx *wx, bool queues)
+{
+	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
+
+	/* unmask interrupt */
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	if (queues)
+		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
+}
+
+/**
+ * txgbe_intr - msi/legacy mode Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ **/
+static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct wx *wx  = data;
+	struct pci_dev *pdev;
+	u32 eicr;
+
+	q_vector = wx->q_vector[0];
+	pdev = wx->pdev;
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
+	if (!(pdev->msi_enabled))
+		wr32(wx, WX_PX_INTA, 1);
+
+	wx->isb_mem[WX_ISB_MISC] = 0;
+	/* would disable interrupts here but it is auto disabled */
+	napi_schedule_irqoff(&q_vector->napi);
+
+	/* re-enable link(maybe) and non-queue interrupts, no flush.
+	 * txgbe_poll will re-enable the queue interrupts
+	 */
+	if (netif_running(wx->netdev))
+		txgbe_irq_enable(wx, false);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * txgbe_request_msix_irqs - Initialize MSI-X interrupts
+ * @wx: board private structure
+ *
+ * Allocate MSI-X vectors and request interrupts from the kernel.
+ **/
+static int txgbe_request_msix_irqs(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int vector, err;
+
+	for (vector = 0; vector < wx->num_q_vectors; vector++) {
+		struct wx_q_vector *q_vector = wx->q_vector[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
+
+		if (q_vector->tx.ring && q_vector->rx.ring)
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-TxRx-%d", netdev->name, entry->entry);
+		else
+			/* skip this unused q_vector */
+			continue;
+
+		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err) {
+			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
+			       q_vector->name, err);
+			goto free_queue_irqs;
+		}
+	}
+
+	return 0;
+
+free_queue_irqs:
+	while (vector) {
+		vector--;
+		free_irq(wx->msix_q_entries[vector].vector,
+			 wx->q_vector[vector]);
+	}
+	wx_reset_interrupt_capability(wx);
+	return err;
+}
+
+/**
+ * txgbe_request_irq - initialize interrupts
+ * @wx: board private structure
+ *
+ * Attempt to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ **/
+int txgbe_request_irq(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	struct pci_dev *pdev = wx->pdev;
+	int err;
+
+	if (pdev->msix_enabled)
+		err = txgbe_request_msix_irqs(wx);
+	else if (pdev->msi_enabled)
+		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
+				  netdev->name, wx);
+	else
+		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
+				  netdev->name, wx);
+
+	if (err)
+		wx_err(wx, "request_irq failed, Error %d\n", err);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
new file mode 100644
index 000000000000..02c536421f7d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+void txgbe_irq_enable(struct wx *wx, bool queues);
+int txgbe_request_irq(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 3b151c410a5c..8cf8c0d016df 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -17,6 +17,7 @@
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
+#include "txgbe_irq.h"
 #include "txgbe_ethtool.h"
 
 char txgbe_driver_name[] = "txgbe";
@@ -76,133 +77,6 @@ static int txgbe_enumerate_functions(struct wx *wx)
 	return physfns;
 }
 
-/**
- * txgbe_irq_enable - Enable default interrupt generation settings
- * @wx: pointer to private structure
- * @queues: enable irqs for queues
- **/
-static void txgbe_irq_enable(struct wx *wx, bool queues)
-{
-	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
-
-	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
-	if (queues)
-		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
-}
-
-/**
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
- * @wx: board private structure
- *
- * Allocate MSI-X vectors and request interrupts from the kernel.
- **/
-static int txgbe_request_msix_irqs(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	int vector, err;
-
-	for (vector = 0; vector < wx->num_q_vectors; vector++) {
-		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_q_entries[vector];
-
-		if (q_vector->tx.ring && q_vector->rx.ring)
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-TxRx-%d", netdev->name, entry->entry);
-		else
-			/* skip this unused q_vector */
-			continue;
-
-		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
-				  q_vector->name, q_vector);
-		if (err) {
-			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
-			       q_vector->name, err);
-			goto free_queue_irqs;
-		}
-	}
-
-	return 0;
-
-free_queue_irqs:
-	while (vector) {
-		vector--;
-		free_irq(wx->msix_q_entries[vector].vector,
-			 wx->q_vector[vector]);
-	}
-	wx_reset_interrupt_capability(wx);
-	return err;
-}
-
-/**
- * txgbe_request_irq - initialize interrupts
- * @wx: board private structure
- *
- * Attempt to configure interrupts using the best available
- * capabilities of the hardware and kernel.
- **/
-static int txgbe_request_irq(struct wx *wx)
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
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-- 
2.27.0


