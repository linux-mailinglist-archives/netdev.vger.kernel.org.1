Return-Path: <netdev+bounces-76002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393F86BF1A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CA11C21653
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396B286A7;
	Thu, 29 Feb 2024 02:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAA364C0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174667; cv=none; b=rAddBnc7H2DupnZl86jlMnQ3bVEwI8CgV6iXJasagxYCSCmQfsf7d/IldZcHPcNTsHelEmxC7taUkcSeq/SqsS1gW/5FtmIowXrUvocjfSvnlMWVxOFvsDtl8mO6q8DA3Fd7vu55ZZ0xUbLAxTqeqFephg1sOcWGzoEBzHku+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174667; c=relaxed/simple;
	bh=yi0kYK8Fm3sY5IO7qLLlx0iTzEujjf+30ngYKY5ely4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sGqYJmdEw5U1U7oH4J9a5Jhf2pGLuTo1jkAC0rd4zL7Hw758guypIJjIFq/lXn9Jx65ERRYS9MPrtR2ZgoS93s+4VPEkCen2vkx8BOGAiikhrNceOLS4O9FOvnSv9tzjdSZDQjrRsAsdDFwIV14wcUjuFcx5f8N5JIDmITkK0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp75t1709174562t4qj3ora
X-QQ-Originating-IP: 650xBhqzwoX7cCPGZtn69t6Am9NYAklg/IR0DWHoi+0=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Feb 2024 10:42:40 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: dKvkn8qoLrHMFTxmEHOqLxtNkwUIkSX7yJ8/ibNqj8DiSZSqh5/YlRxoXOoP9
	vkxqrL0lsAcNwkxvulksuVZQc0piz8kmvkxczpGBGNqjzfPaW4ehMePVPFDF7ZgKGcZ3AP3
	KgcCSb/fAL634ComX02BNsiPhjcxkjtWmh2OM7TFYlNJ/xown9dEE+XWXozrycPGd2ljamm
	JLHaCyQ97CVDKqSMF3Boy45cSm3env419M4EHZFBND0YtBNQjpDsfHPocMzaeY94Yw3muSx
	t07vDHow3cOFww65ptSN/C6CWwnCLbgGJaAaTfCDtPAs5ukp7Z7fbqaaKCk7GCzqtepC9FM
	Ix0MGSjff3ZHzbHuhVCctBA4FvWxwYbPUJNP/gAi1mC698Q2dnQrME75kzdrA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16484643689901370740
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
Subject: [PATCH v2] net: txgbe: fix GPIO interrupt blocking
Date: Thu, 29 Feb 2024 10:42:37 +0800
Message-Id: <20240229024237.22568-1-jiawenwu@trustnetic.com>
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

There were two problems to be solved in this patch:

1. The register of GPIO interrupt status is masked before MAC IRQ
is enabled. This is because of hardware deficiency. So manually
clear the interrupt status before using them. Otherwise, GPIO
interrupts will never be reported again. There is a workaround for
clearing interrupts to set GPIO EOI in txgbe_up_complete().

2. GPIO EOI is not set to clear interrupt status after handling
the interrupt. It should be done in irq_chip->irq_ack, but this
function is not called in handle_nested_irq(). So executing
function txgbe_gpio_irq_ack() manually in txgbe_gpio_irq_handler().

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 29 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index e67a21294158..bd4624d14ca0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -81,6 +81,7 @@ static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	txgbe_reinit_gpio_intr(wx);
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index bae0a8ee7014..93295916b1d2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -475,8 +475,10 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 	gc = txgbe->gpio;
 	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
+		struct irq_data *d = irq_get_irq_data(gpio);
 		u32 irq_type = irq_get_trigger_type(gpio);
 
+		txgbe_gpio_irq_ack(d);
 		handle_nested_irq(gpio);
 
 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
@@ -489,6 +491,33 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void txgbe_reinit_gpio_intr(struct wx *wx)
+{
+	struct txgbe *txgbe = wx->priv;
+	irq_hw_number_t hwirq;
+	unsigned long gpioirq;
+	struct gpio_chip *gc;
+	unsigned long flags;
+
+	/* for gpio interrupt pending before irq enable */
+	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
+
+	gc = txgbe->gpio;
+	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
+		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
+		struct irq_data *d = irq_get_irq_data(gpio);
+		u32 irq_type = irq_get_trigger_type(gpio);
+
+		txgbe_gpio_irq_ack(d);
+
+		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
+			txgbe_toggle_trigger(gc, hwirq);
+			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
+		}
+	}
+}
+
 static int txgbe_gpio_init(struct txgbe *txgbe)
 {
 	struct gpio_irq_chip *girq;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 9855d44076cb..8a026d804fe2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -5,6 +5,7 @@
 #define _TXGBE_PHY_H_
 
 irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
+void txgbe_reinit_gpio_intr(struct wx *wx);
 irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
-- 
2.27.0


