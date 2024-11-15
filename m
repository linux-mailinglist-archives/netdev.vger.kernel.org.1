Return-Path: <netdev+bounces-145185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0F9CD8DD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 07:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE02B22DD6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5431885BF;
	Fri, 15 Nov 2024 06:54:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78414EC77
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653689; cv=none; b=tAkAnu23D+YDdpABcct936t/Ks1GpQyU5KTjzjjwceVO7B4kzZ69NaorjHnbZyd+smjjPCKXNsbWJRjBxNtvZk++0vYjGk2g5kUE4CFHyIPKWF6FxeRhSWst/XLJ7PBmgUexlGU2nZq3Y6uy2ySSHHzTcq57GpElMJcEqACqKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653689; c=relaxed/simple;
	bh=TuNNIYt6IYlTNgMJNdrT36JIxJ4HsUPvT3BiqojK8uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StMYt4uJlItfXm/MS7TeoT2jc8N2xDgtrxwSF94fiNS5n44RAxLD9SP5bIwHiVxK6gwU/u6NolSQv8oeaWjcybr247xLqCA/jVxgkQVL30bHGTnBsHr+RRsUwt6JVehou7KenpuRor6HzL9dOSVdlAWnrZ6pfdiK1m/V9CC7NkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp82t1731653562tq53j0dw
X-QQ-Originating-IP: +X+72kly31mX0ybw22mjx8K+Q9gPQTGzqN6rlyntlsE=
Received: from wxdbg.localdomain.com ( [115.206.160.29])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Nov 2024 14:52:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15018095483652981737
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	horms@kernel.org,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2] net: txgbe: remove GPIO interrupt controller
Date: Fri, 15 Nov 2024 15:15:27 +0800
Message-Id: <20241115071527.1129458-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzSDQCFWCzVTRja39ZME0o3ZqJvGvf8sqv68B+u305xSjh/QQo4zNzns
	QPhQ82zS1XbPP2LhBwtwAl2wxkcqqkzH4lrYdzgEwnmV3/tIIaQUy8ArtanBnkOUClPKvIt
	pCCUBlKtufmeWm9zxYne/Dth5JoQdV+0Yy6qziieAcN7VROBGVw1oaVQxlAlNADsa5SL7gX
	CtAvN8u28yQlBHT8mwplGj6oqDTlTCGYx140z46GHRBw1XMMT9Rd8oWIvXl/WypgVkb0F3a
	CzTmFQlWbDmvcYDvvkUD0Pdy7qOHCI5Be7VxqsSEvUREj0902BVdu0//5eIYMUNxXU7jLWh
	fusvLlHoeg6DBMrKK7Y08HRkPxjV2t9xvc7RmQGP56EZHloKkYwNDEKHnLtimdSWr75yL86
	FQ/pwVeiCDspdtzWN2W7UPz3H5WTYN/QNSldSo1DRfZAkEt4wpC8dfJRaziZ70pSmIY7mzm
	UJSoCNAttK9/JMaZ9nDW++j+8/i2R8FI1Qo8qq3YtTPx/SEKY3e+dOano2mEkTalYhmph3a
	EM3rjCPXJhfHUMR47szuov0MtDhb8IX1mUUTZl4UpNx5Vb3dlXX5FEp7gTzDKUTDg67RSvW
	SHEEqh3DhVZ6UbLwFAstY+8GXHg/ehyHkVcQxN0LG0DfS2hTrh2BSJPT9blkzkD6aizq84I
	OigRQYydPuVVleKRTSV8DyorFGbXiBjTT4Yyy4T1fM2V/l+T2Qg372ExYEpe/B2I5JSf0+k
	KN0LQpi4pd/Po74uB03453pLuaGUE4z1dU/Qr/VxdeKklzjn5T692fhfuGiOIKNlZQbWKRz
	sB3OmhmWr6YSw5iSnVKv+6tKU2EikLhPLIAOtl9qqF/OfQs/kNFS/u0MphQlrDCaTS1/eT9
	j7ieGVLJkYkmXL6pIiLJPxZY7Vu+6ytzyqHX39nW0FseXldIvZolitPBoft2qu+sYm4LvXX
	nmtwL2qzN+VfpP/44ckBjUjq4KNcrwY3TsDfi1beBvsGWI8YHkUEcAa5F
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Since the GPIO interrupt controller is always not working properly, we need
to constantly add workaround to cope with hardware deficiencies. So just
remove GPIO interrupt controller, and let the SFP driver poll the GPIO
status.

Fixes: b4a2496c17ed ("net: txgbe: fix GPIO interrupt blocking")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
Changes in v2:
- Remove GPIO interrupt controller
- Link to v1: https://lore.kernel.org/all/20241106101717.981850-1-jiawenwu@trustnetic.com
---
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  24 +--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   1 -
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 166 ------------------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 -
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
 5 files changed, 4 insertions(+), 196 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index a4cf682dca65..0ee73a265545 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -72,14 +72,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
 	return err;
 }
 
-static int txgbe_request_gpio_irq(struct txgbe *txgbe)
-{
-	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
-	return request_threaded_irq(txgbe->gpio_irq, NULL,
-				    txgbe_gpio_irq_handler,
-				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
-}
-
 static int txgbe_request_link_irq(struct txgbe *txgbe)
 {
 	txgbe->link_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
@@ -149,11 +141,6 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	u32 eicr;
 
 	eicr = wx_misc_isb(wx, WX_ISB_MISC);
-	if (eicr & TXGBE_PX_MISC_GPIO) {
-		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
-		handle_nested_irq(sub_irq);
-		nhandled++;
-	}
 	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
 		    TXGBE_PX_MISC_ETH_AN)) {
 		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
@@ -179,7 +166,6 @@ static void txgbe_del_irq_domain(struct txgbe *txgbe)
 
 void txgbe_free_misc_irq(struct txgbe *txgbe)
 {
-	free_irq(txgbe->gpio_irq, txgbe);
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
@@ -191,7 +177,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	txgbe->misc.nirqs = 2;
+	txgbe->misc.nirqs = 1;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
@@ -216,20 +202,14 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (err)
 		goto del_misc_irq;
 
-	err = txgbe_request_gpio_irq(txgbe);
-	if (err)
-		goto free_msic_irq;
-
 	err = txgbe_request_link_irq(txgbe);
 	if (err)
-		goto free_gpio_irq;
+		goto free_msic_irq;
 
 	wx->misc_irq_domain = true;
 
 	return 0;
 
-free_gpio_irq:
-	free_irq(txgbe->gpio_irq, txgbe);
 free_msic_irq:
 	free_irq(txgbe->misc.irq, txgbe);
 del_misc_irq:
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 93180225a6f1..f77450268036 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -82,7 +82,6 @@ static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
-	txgbe_reinit_gpio_intr(wx);
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 67b61afdde96..2bfe41339c1c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -358,169 +358,8 @@ static int txgbe_gpio_direction_out(struct gpio_chip *chip, unsigned int offset,
 	return 0;
 }
 
-static void txgbe_gpio_irq_ack(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32(wx, WX_GPIO_EOI, BIT(hwirq));
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_gpio_irq_mask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	gpiochip_disable_irq(gc, hwirq);
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32m(wx, WX_GPIO_INTMASK, BIT(hwirq), BIT(hwirq));
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_gpio_irq_unmask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	gpiochip_enable_irq(gc, hwirq);
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32m(wx, WX_GPIO_INTMASK, BIT(hwirq), 0);
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_toggle_trigger(struct gpio_chip *gc, unsigned int offset)
-{
-	struct wx *wx = gpiochip_get_data(gc);
-	u32 pol, val;
-
-	pol = rd32(wx, WX_GPIO_POLARITY);
-	val = rd32(wx, WX_GPIO_EXT);
-
-	if (val & BIT(offset))
-		pol &= ~BIT(offset);
-	else
-		pol |= BIT(offset);
-
-	wr32(wx, WX_GPIO_POLARITY, pol);
-}
-
-static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	u32 level, polarity, mask;
-	unsigned long flags;
-
-	mask = BIT(hwirq);
-
-	if (type & IRQ_TYPE_LEVEL_MASK) {
-		level = 0;
-		irq_set_handler_locked(d, handle_level_irq);
-	} else {
-		level = mask;
-		irq_set_handler_locked(d, handle_edge_irq);
-	}
-
-	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH)
-		polarity = mask;
-	else
-		polarity = 0;
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-
-	wr32m(wx, WX_GPIO_INTEN, mask, mask);
-	wr32m(wx, WX_GPIO_INTTYPE_LEVEL, mask, level);
-	if (type == IRQ_TYPE_EDGE_BOTH)
-		txgbe_toggle_trigger(gc, hwirq);
-	else
-		wr32m(wx, WX_GPIO_POLARITY, mask, polarity);
-
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-
-	return 0;
-}
-
-static const struct irq_chip txgbe_gpio_irq_chip = {
-	.name = "txgbe-gpio-irq",
-	.irq_ack = txgbe_gpio_irq_ack,
-	.irq_mask = txgbe_gpio_irq_mask,
-	.irq_unmask = txgbe_gpio_irq_unmask,
-	.irq_set_type = txgbe_gpio_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
-};
-
-irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
-{
-	struct txgbe *txgbe = data;
-	struct wx *wx = txgbe->wx;
-	irq_hw_number_t hwirq;
-	unsigned long gpioirq;
-	struct gpio_chip *gc;
-	unsigned long flags;
-
-	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
-
-	gc = txgbe->gpio;
-	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
-		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
-		struct irq_data *d = irq_get_irq_data(gpio);
-		u32 irq_type = irq_get_trigger_type(gpio);
-
-		txgbe_gpio_irq_ack(d);
-		handle_nested_irq(gpio);
-
-		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-			txgbe_toggle_trigger(gc, hwirq);
-			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-void txgbe_reinit_gpio_intr(struct wx *wx)
-{
-	struct txgbe *txgbe = wx->priv;
-	irq_hw_number_t hwirq;
-	unsigned long gpioirq;
-	struct gpio_chip *gc;
-	unsigned long flags;
-
-	/* for gpio interrupt pending before irq enable */
-	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
-
-	gc = txgbe->gpio;
-	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
-		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
-		struct irq_data *d = irq_get_irq_data(gpio);
-		u32 irq_type = irq_get_trigger_type(gpio);
-
-		txgbe_gpio_irq_ack(d);
-
-		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-			txgbe_toggle_trigger(gc, hwirq);
-			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-		}
-	}
-}
-
 static int txgbe_gpio_init(struct txgbe *txgbe)
 {
-	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
 	struct device *dev;
 	struct wx *wx;
@@ -550,11 +389,6 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 	gc->direction_input = txgbe_gpio_direction_in;
 	gc->direction_output = txgbe_gpio_direction_out;
 
-	girq = &gc->irq;
-	gpio_irq_chip_set_chip(girq, &txgbe_gpio_irq_chip);
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_bad_irq;
-
 	ret = devm_gpiochip_add_data(dev, gc, wx);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 8a026d804fe2..3938985355ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,8 +4,6 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
-irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
-void txgbe_reinit_gpio_intr(struct wx *wx);
 irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 959102c4c379..8ea413a7abe9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -75,8 +75,7 @@
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
-	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR |   \
-	 TXGBE_PX_MISC_GPIO)
+	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
@@ -313,8 +312,7 @@ struct txgbe_nodes {
 };
 
 enum txgbe_misc_irqs {
-	TXGBE_IRQ_GPIO = 0,
-	TXGBE_IRQ_LINK,
+	TXGBE_IRQ_LINK = 0,
 	TXGBE_IRQ_MAX
 };
 
@@ -335,7 +333,6 @@ struct txgbe {
 	struct clk_lookup *clock;
 	struct clk *clk;
 	struct gpio_chip *gpio;
-	unsigned int gpio_irq;
 	unsigned int link_irq;
 
 	/* flow director */
-- 
2.27.0


