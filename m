Return-Path: <netdev+bounces-65762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76983B989
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EB01F2374D
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BC10A34;
	Thu, 25 Jan 2024 06:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B110A10
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163854; cv=none; b=E7mC0WmRZ/yB/MUMquKv0KMkbnAe3R+APQI3OOaQlhiI9+Ek8Lbn62+dlwN8SEpE7IPdwlrraOvUvk0Iqm1x7MSv43Tk2s3YxdbBqf3TAVzzlOpDVYPlcToswSm2icVUBYojgGBH8WJ7hS4n9AaESDlx6Irts12rssgi4g2o9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163854; c=relaxed/simple;
	bh=7d5zGQd9/9pQo/Kri/ALx9s/mEjmKv2p639mADltLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WigScXxGJRDnC/eOpLAYPH02k2cIVjY4Xjd4wAn5ztgQ27fMPX+QK+1NwogQEwNtXHDB8riY0VZTFIEpFPnxUzgIIr55Hg1Aer2PFPVbp7LfD+zBJrPVjbYieAMkQXfFU42vlSsofvvJncB33o6EvyFo2hTQSB6PnAu6lPUvpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp66t1706163766t69869lj
X-QQ-Originating-IP: eBjTA9HZ/Ru73+cRSEXR6NvS+XanLJPxJDkKKu5aQYs=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.185.81])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jan 2024 14:22:45 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: I8hG9CuxGDJLc+3PLYZkBwiDhY+hUWuBXMR5rvL88qld/0USM+fMiZYXloBdD
	FB9rxL/N94aXqNoyyuyNc4RO2wPkiG9q1hhiPKG8AUhLDjdX2Nnud1HyZ2Stzn4Cl3AZ9QT
	6Sw/Hp8hNJ3cd3lvlBpF/smHAz3gGCoCzzGnIp0IrWkii2eq7PDuTA7FE7XZ4dWDPKK5+KR
	QUXKEgWLno6RBz6xYB3Md1H2n7nqYotr+Y6nGuyYUIQ1iAcdeMT9TJVjvbwR6mjDtIaaHjv
	qRyzzZnI70psA4emSCDMupbh/Hs5Pr8eygqefUsTaPlm1MwoiqktR62TVE28xDy3gr9cEoK
	qQ8iWyFq0BufiX/LBdV7GouvnfqCNvNuatyybjy2A2SabUZqwFenxm0xAeL4/t7xzvl6MCp
	RjH2HNqqfxCOO8TpF68TfA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16189963530550919410
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
Subject: [PATCH net-next v4 2/2] net: txgbe: use irq_domain for interrupt controller
Date: Thu, 25 Jan 2024 14:22:13 +0800
Message-Id: <20240125062213.28248-3-jiawenwu@trustnetic.com>
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

In the current interrupt controller, the MAC interrupt acts as the
parent interrupt in the GPIO IRQ chip. But when the number of Rx/Tx
ring changes, the PCI IRQ vector needs to be reallocated. Then this
interrupt controller would be corrupted. So use irq_domain structure
to avoid the above problem.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 -
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 132 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  12 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  59 +++-----
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  17 +++
 9 files changed, 193 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1db754615cca..945c13d1a982 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1958,8 +1958,6 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
-	wx->msix_in_use = false;
-
 	return 0;
 }
 EXPORT_SYMBOL(wx_sw_init);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 8706223a6e5a..7cf02ab6de68 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1614,14 +1614,12 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 	/* One for non-queue interrupts */
 	nvecs += 1;
 
-	if (!wx->msix_in_use) {
-		wx->msix_entry = kcalloc(1, sizeof(struct msix_entry),
-					 GFP_KERNEL);
-		if (!wx->msix_entry) {
-			kfree(wx->msix_q_entries);
-			wx->msix_q_entries = NULL;
-			return -ENOMEM;
-		}
+	wx->msix_entry = kcalloc(1, sizeof(struct msix_entry),
+				 GFP_KERNEL);
+	if (!wx->msix_entry) {
+		kfree(wx->msix_q_entries);
+		wx->msix_q_entries = NULL;
+		return -ENOMEM;
 	}
 
 	nvecs = pci_alloc_irq_vectors_affinity(wx->pdev, nvecs,
@@ -1931,10 +1929,8 @@ void wx_reset_interrupt_capability(struct wx *wx)
 	if (pdev->msix_enabled) {
 		kfree(wx->msix_q_entries);
 		wx->msix_q_entries = NULL;
-		if (!wx->msix_in_use) {
-			kfree(wx->msix_entry);
-			wx->msix_entry = NULL;
-		}
+		kfree(wx->msix_entry);
+		wx->msix_entry = NULL;
 	}
 	pci_free_irq_vectors(wx->pdev);
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b4dc4f341117..1fdeb464d5f4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1047,7 +1047,6 @@ struct wx {
 	unsigned int queues_per_pool;
 	struct msix_entry *msix_q_entries;
 	struct msix_entry *msix_entry;
-	bool msix_in_use;
 	struct wx_ring_feature ring_feature[RING_F_ARRAY_SIZE];
 
 	/* misc interrupt status block */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index d26ee4cb1767..b3e3605d1edb 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
 
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
+#include "txgbe_phy.h"
 #include "txgbe_irq.h"
 
 /**
@@ -135,3 +137,133 @@ int txgbe_request_irq(struct wx *wx)
 
 	return err;
 }
+
+static int txgbe_request_gpio_irq(struct txgbe *txgbe)
+{
+	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+	return request_threaded_irq(txgbe->gpio_irq, NULL,
+				    txgbe_gpio_irq_handler,
+				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
+}
+
+static int txgbe_request_link_irq(struct txgbe *txgbe)
+{
+	txgbe->link_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
+	return request_threaded_irq(txgbe->link_irq, NULL,
+				    txgbe_link_irq_handler,
+				    IRQF_ONESHOT, "txgbe-link-irq", txgbe);
+}
+
+static const struct irq_chip txgbe_irq_chip = {
+	.name = "txgbe-misc-irq",
+};
+
+static int txgbe_misc_irq_domain_map(struct irq_domain *d,
+				     unsigned int irq,
+				     irq_hw_number_t hwirq)
+{
+	struct txgbe *txgbe = d->host_data;
+
+	irq_set_chip_data(irq, txgbe);
+	irq_set_chip(irq, &txgbe->misc.chip);
+	irq_set_nested_thread(irq, true);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
+	.map = txgbe_misc_irq_domain_map,
+};
+
+static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	unsigned int nhandled = 0;
+	unsigned int sub_irq;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	if (eicr & TXGBE_PX_MISC_GPIO) {
+		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+		handle_nested_irq(sub_irq);
+		nhandled++;
+	}
+	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
+		    TXGBE_PX_MISC_ETH_AN)) {
+		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
+		handle_nested_irq(sub_irq);
+		nhandled++;
+	}
+
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
+}
+
+static void txgbe_del_irq_domain(struct txgbe *txgbe)
+{
+	int hwirq, virq;
+
+	for (hwirq = 0; hwirq < txgbe->misc.nirqs; hwirq++) {
+		virq = irq_find_mapping(txgbe->misc.domain, hwirq);
+		irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(txgbe->misc.domain);
+}
+
+void txgbe_free_misc_irq(struct txgbe *txgbe)
+{
+	free_irq(txgbe->gpio_irq, txgbe);
+	free_irq(txgbe->link_irq, txgbe);
+	free_irq(txgbe->misc.irq, txgbe);
+	txgbe_del_irq_domain(txgbe);
+}
+
+int txgbe_setup_misc_irq(struct txgbe *txgbe)
+{
+	struct wx *wx = txgbe->wx;
+	int hwirq, err;
+
+	txgbe->misc.nirqs = 2;
+	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
+						   &txgbe_misc_irq_domain_ops, txgbe);
+	if (!txgbe->misc.domain)
+		return -ENOMEM;
+
+	for (hwirq = 0; hwirq < txgbe->misc.nirqs; hwirq++)
+		irq_create_mapping(txgbe->misc.domain, hwirq);
+
+	txgbe->misc.chip = txgbe_irq_chip;
+	if (wx->pdev->msix_enabled)
+		txgbe->misc.irq = wx->msix_entry->vector;
+	else
+		txgbe->misc.irq = wx->pdev->irq;
+
+	err = request_threaded_irq(txgbe->misc.irq, NULL,
+				   txgbe_misc_irq_handle,
+				   IRQF_ONESHOT,
+				   wx->netdev->name, txgbe);
+	if (err)
+		goto del_misc_irq;
+
+	err = txgbe_request_gpio_irq(txgbe);
+	if (err)
+		goto free_msic_irq;
+
+	err = txgbe_request_link_irq(txgbe);
+	if (err)
+		goto free_gpio_irq;
+
+	return 0;
+
+free_gpio_irq:
+	free_irq(txgbe->gpio_irq, txgbe);
+free_msic_irq:
+	free_irq(txgbe->misc.irq, txgbe);
+del_misc_irq:
+	txgbe_del_irq_domain(txgbe);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
index 02c536421f7d..b77945e7a0f2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
@@ -3,3 +3,5 @@
 
 void txgbe_irq_enable(struct wx *wx, bool queues);
 int txgbe_request_irq(struct wx *wx);
+void txgbe_free_misc_irq(struct txgbe *txgbe);
+int txgbe_setup_misc_irq(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8cf8c0d016df..e67a21294158 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -392,6 +392,7 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -402,6 +403,7 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
+	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -410,6 +412,7 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
+	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -625,10 +628,14 @@ static int txgbe_probe(struct pci_dev *pdev,
 	txgbe->wx = wx;
 	wx->priv = txgbe;
 
-	err = txgbe_init_phy(txgbe);
+	err = txgbe_setup_misc_irq(txgbe);
 	if (err)
 		goto err_release_hw;
 
+	err = txgbe_init_phy(txgbe);
+	if (err)
+		goto err_free_misc_irq;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_phy;
@@ -655,6 +662,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
+err_free_misc_irq:
+	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -687,6 +696,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
+	txgbe_free_misc_irq(txgbe);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1b84d495d14e..bae0a8ee7014 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -292,6 +292,21 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	return 0;
 }
 
+irqreturn_t txgbe_link_irq_handler(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 status;
+	bool up;
+
+	status = rd32(wx, TXGBE_CFG_PORT_ST);
+	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
+
+	phylink_mac_change(wx->phylink, up);
+
+	return IRQ_HANDLED;
+}
+
 static int txgbe_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct wx *wx = gpiochip_get_data(chip);
@@ -437,7 +452,7 @@ static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
 }
 
 static const struct irq_chip txgbe_gpio_irq_chip = {
-	.name = "txgbe_gpio_irq",
+	.name = "txgbe-gpio-irq",
 	.irq_ack = txgbe_gpio_irq_ack,
 	.irq_mask = txgbe_gpio_irq_mask,
 	.irq_unmask = txgbe_gpio_irq_unmask,
@@ -446,20 +461,14 @@ static const struct irq_chip txgbe_gpio_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void txgbe_irq_handler(struct irq_desc *desc)
+irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct wx *wx = irq_desc_get_handler_data(desc);
-	struct txgbe *txgbe = wx->priv;
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
 	irq_hw_number_t hwirq;
 	unsigned long gpioirq;
 	struct gpio_chip *gc;
 	unsigned long flags;
-	u32 eicr;
-
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
-
-	chained_irq_enter(chip, desc);
 
 	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
 
@@ -468,7 +477,7 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
 		u32 irq_type = irq_get_trigger_type(gpio);
 
-		generic_handle_domain_irq(gc->irq.domain, hwirq);
+		handle_nested_irq(gpio);
 
 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
@@ -477,17 +486,7 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 		}
 	}
 
-	chained_irq_exit(chip, desc);
-
-	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
-		    TXGBE_PX_MISC_ETH_AN)) {
-		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
-
-		phylink_mac_change(wx->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
-	}
-
-	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	return IRQ_HANDLED;
 }
 
 static int txgbe_gpio_init(struct txgbe *txgbe)
@@ -524,19 +523,6 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 
 	girq = &gc->irq;
 	gpio_irq_chip_set_chip(girq, &txgbe_gpio_irq_chip);
-	girq->parent_handler = txgbe_irq_handler;
-	girq->parent_handler_data = wx;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(dev, girq->num_parents,
-				     sizeof(*girq->parents), GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-
-	/* now only suuported on MSI-X interrupt */
-	if (!wx->msix_entry)
-		return -EPERM;
-
-	girq->parents[0] = wx->msix_entry->vector;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 
@@ -754,8 +740,6 @@ int txgbe_init_phy(struct txgbe *txgbe)
 		goto err_unregister_i2c;
 	}
 
-	wx->msix_in_use = true;
-
 	return 0;
 
 err_unregister_i2c:
@@ -788,5 +772,4 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
-	txgbe->wx->msix_in_use = false;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 1ab592124986..9855d44076cb 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,6 +4,8 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
+irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
+irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 270a6fd9ad0b..1b4ff50d5857 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -5,6 +5,7 @@
 #define _TXGBE_TYPE_H_
 
 #include <linux/property.h>
+#include <linux/irq.h>
 
 /* Device IDs */
 #define TXGBE_DEV_ID_SP1000                     0x1001
@@ -169,15 +170,31 @@ struct txgbe_nodes {
 	const struct software_node *group[SWNODE_MAX + 1];
 };
 
+enum txgbe_misc_irqs {
+	TXGBE_IRQ_GPIO = 0,
+	TXGBE_IRQ_LINK,
+	TXGBE_IRQ_MAX
+};
+
+struct txgbe_irq {
+	struct irq_chip chip;
+	struct irq_domain *domain;
+	int nirqs;
+	int irq;
+};
+
 struct txgbe {
 	struct wx *wx;
 	struct txgbe_nodes nodes;
+	struct txgbe_irq misc;
 	struct dw_xpcs *xpcs;
 	struct platform_device *sfp_dev;
 	struct platform_device *i2c_dev;
 	struct clk_lookup *clock;
 	struct clk *clk;
 	struct gpio_chip *gpio;
+	unsigned int gpio_irq;
+	unsigned int link_irq;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


