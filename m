Return-Path: <netdev+bounces-63488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A1E82D5B8
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DC3281DEC
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A21C13E;
	Mon, 15 Jan 2024 09:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4DE54E
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp75t1705310184t7xppw1j
X-QQ-Originating-IP: Bbeu+Op7oOzUniSqnIPRMJMH0FTrs4sc2EHMaGX3ue8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jan 2024 17:16:22 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: p8PN4UZ3LytY/5e1jJLE8Ne9LyvvxUwBaa9OnFWSn1+mq95Bj0Xb3Q0D6o16q
	A8HFacbHjRdAI1M+u/U4ItJH9/p+lMvjigIb9QjAJnFxD4LihaaRaKBHMTk7Qb8DhCd2ft1
	LeIa4njZzyVyxJFZ0VuDdGB55B+TxuN8s6Zz3f7wv+kps2YjR9jvkj9VDoBoh6B/aZWToGO
	YZMROVq35ffzudyoYFy8wnxc1yxWAs9Iw6cNbNR+cUpKl9Mea6jnyo52rLDzL+r4n2IKHob
	SQmAyUbO4U2Yo+ngjhrSA3BX30joZgJ3xbbjY0nKOXAGp6xgfYhsmRPWywcRMylbsaCJe1/
	RAbVqKPkpte0CpM0XVyMARvkfudnaLhrTFGBA+dVauveniQwS03gU0pIzIBKUjIUBk+WgOg
	/WyHdJfNYXn/kT/KhDuX2g9rEHOs93/S
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8001289998976161782
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
Subject: [RFC PATCH net-next] net: txgbe: use irq_domain for interrupt controller
Date: Mon, 15 Jan 2024 17:16:21 +0800
Message-Id: <20240115091621.23312-1-jiawenwu@trustnetic.com>
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

Use irq_domain infrastructure for MAC interrupt controller, which above
the GPIO interrupt controller.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 -
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 119 +++++++++++++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  68 +++++-----
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  10 ++
 7 files changed, 165 insertions(+), 56 deletions(-)

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
index 23355cc408fd..e681244c6684 100644
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
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 3b151c410a5c..017f0e43bf34 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/string.h>
 #include <linux/etherdevice.h>
+#include <linux/irqdomain.h>
 #include <linux/phylink.h>
 #include <net/ip.h>
 #include <linux/if_vlan.h>
@@ -203,6 +204,110 @@ static int txgbe_request_irq(struct wx *wx)
 	return err;
 }
 
+static void txgbe_misc_irq_mask(struct irq_data *d)
+{
+}
+
+static void txgbe_misc_irq_unmask(struct irq_data *d)
+{
+	struct txgbe *txgbe = irq_data_get_irq_chip_data(d);
+	struct wx *wx = txgbe->wx;
+
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+}
+
+static const struct irq_chip txgbe_irq_chip = {
+	.name = "txgbe-misc-irq",
+	.irq_mask = txgbe_misc_irq_mask,
+	.irq_unmask = txgbe_misc_irq_unmask,
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
+	irq_set_nested_thread(irq, 1);
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
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+
+	handle_nested_irq(txgbe->gpio_irq);
+
+	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
+		    TXGBE_PX_MISC_ETH_AN)) {
+		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
+
+		phylink_mac_change(wx->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void txgbe_del_misc_irq(struct txgbe *txgbe)
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
+static void txgbe_free_misc_irq(struct txgbe *txgbe)
+{
+	free_irq(txgbe->misc.irq, txgbe);
+	txgbe_del_misc_irq(txgbe);
+}
+
+static int txgbe_setup_misc_irq(struct txgbe *txgbe)
+{
+	struct wx *wx = txgbe->wx;
+	int hwirq, err;
+
+	txgbe->misc.nirqs = 1;
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
+		txgbe_del_misc_irq(txgbe);
+
+	return err;
+}
+
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
@@ -518,6 +623,7 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -528,6 +634,8 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
+	free_irq(txgbe->gpio_irq, txgbe);
+	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -536,6 +644,8 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
+	txgbe_setup_misc_irq(txgbe);
+	txgbe_request_gpio_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -751,10 +861,14 @@ static int txgbe_probe(struct pci_dev *pdev,
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
@@ -781,6 +895,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
+err_free_misc_irq:
+	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -813,6 +929,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
+	txgbe_free_misc_irq(txgbe);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1b84d495d14e..253d5a2c9063 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -437,7 +437,7 @@ static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
 }
 
 static const struct irq_chip txgbe_gpio_irq_chip = {
-	.name = "txgbe_gpio_irq",
+	.name = "txgbe-gpio-irq",
 	.irq_ack = txgbe_gpio_irq_ack,
 	.irq_mask = txgbe_gpio_irq_mask,
 	.irq_unmask = txgbe_gpio_irq_unmask,
@@ -446,29 +446,23 @@ static const struct irq_chip txgbe_gpio_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void txgbe_irq_handler(struct irq_desc *desc)
+static irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct wx *wx = irq_desc_get_handler_data(desc);
-	struct txgbe *txgbe = wx->priv;
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	unsigned long irq_status;
 	irq_hw_number_t hwirq;
-	unsigned long gpioirq;
 	struct gpio_chip *gc;
 	unsigned long flags;
-	u32 eicr;
-
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
 
-	chained_irq_enter(chip, desc);
-
-	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
+	irq_status = rd32(wx, WX_GPIO_INTSTATUS);
 
 	gc = txgbe->gpio;
-	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
+	for_each_set_bit(hwirq, &irq_status, gc->ngpio) {
 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
 		u32 irq_type = irq_get_trigger_type(gpio);
 
-		generic_handle_domain_irq(gc->irq.domain, hwirq);
+		handle_nested_irq(gpio);
 
 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
@@ -477,17 +471,10 @@ static void txgbe_irq_handler(struct irq_desc *desc)
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
 	/* unmask interrupt */
 	wx_intr_enable(wx, TXGBE_INTR_MISC);
+
+	return IRQ_HANDLED;
 }
 
 static int txgbe_gpio_init(struct txgbe *txgbe)
@@ -524,19 +511,6 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 
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
 
@@ -549,6 +523,14 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 	return 0;
 }
 
+int txgbe_request_gpio_irq(struct txgbe *txgbe)
+{
+	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, 0);
+	return request_threaded_irq(txgbe->gpio_irq, NULL,
+				    txgbe_gpio_irq_handler,
+				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
+}
+
 static int txgbe_clock_register(struct txgbe *txgbe)
 {
 	struct pci_dev *pdev = txgbe->wx->pdev;
@@ -736,10 +718,16 @@ int txgbe_init_phy(struct txgbe *txgbe)
 		goto err_destroy_phylink;
 	}
 
+	ret = txgbe_request_gpio_irq(txgbe);
+	if (ret) {
+		wx_err(wx, "failed to request gpio irq\n");
+		goto err_destroy_phylink;
+	}
+
 	ret = txgbe_clock_register(txgbe);
 	if (ret) {
 		wx_err(wx, "failed to register clock: %d\n", ret);
-		goto err_destroy_phylink;
+		goto err_free_gpio_irq;
 	}
 
 	ret = txgbe_i2c_register(txgbe);
@@ -754,8 +742,6 @@ int txgbe_init_phy(struct txgbe *txgbe)
 		goto err_unregister_i2c;
 	}
 
-	wx->msix_in_use = true;
-
 	return 0;
 
 err_unregister_i2c:
@@ -763,6 +749,8 @@ int txgbe_init_phy(struct txgbe *txgbe)
 err_unregister_clk:
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
+err_free_gpio_irq:
+	free_irq(txgbe->gpio_irq, txgbe);
 err_destroy_phylink:
 	phylink_destroy(wx->phylink);
 err_destroy_xpcs:
@@ -785,8 +773,8 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
+	free_irq(txgbe->gpio_irq, txgbe);
 	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
-	txgbe->wx->msix_in_use = false;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 1ab592124986..9fac5c911e37 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,6 +4,7 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
+int txgbe_request_gpio_irq(struct txgbe *txgbe);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 270a6fd9ad0b..45d84d20372a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -5,6 +5,7 @@
 #define _TXGBE_TYPE_H_
 
 #include <linux/property.h>
+#include <linux/irq.h>
 
 /* Device IDs */
 #define TXGBE_DEV_ID_SP1000                     0x1001
@@ -169,15 +170,24 @@ struct txgbe_nodes {
 	const struct software_node *group[SWNODE_MAX + 1];
 };
 
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
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


