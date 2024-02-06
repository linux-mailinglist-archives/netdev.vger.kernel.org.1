Return-Path: <netdev+bounces-69377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC784AEA4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8701F24BBB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35242128803;
	Tue,  6 Feb 2024 07:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085E128807
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203423; cv=none; b=Km9HyVJbj1NAEC2QKLnd/LdMCzEuLSdGN2XKToBeYgZ4dA0PbCPUKI8OIll/PaIkMwM2wstr7jX1fbTaubDW7n/msQAJHHcghC39RWye5qc4iiKizwFiqquGVjLADAQ3iQuTqbw68LPsnONgmBmRqrj6ZmsPWBQWulUlsmnlHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203423; c=relaxed/simple;
	bh=C5jFswG8b+UaOfeVTV0E+tt5g4B7a0VklDTKRlszfUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJCn9BpWVlXJrj4w+v4EllZ/iHHpRMYKg4lzOBNQSIg9+KB5VyLa4eGGk6eAA4wOj1TUNUzydkw1Rn8861GW9pCScfaybiCOsDrqidcupoC3LK2QfTg2YccRualvYkQ3MZ/KthEHH7yY7BplNvxgCiso4BMRZDJnfQMok+j/oxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp89t1707203310t9i3y7dd
X-QQ-Originating-IP: 6vtsevcW0pvtAfV8b6EI0HrqD4fqb/ytB8EW27VqNe0=
Received: from lap-jiawenwu.trustnetic.com ( [115.192.112.184])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Feb 2024 15:08:27 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: qOAV9bwDT/kuu38F2q/Tg5bW+GeZGkbpnr+OG234UYH4pxW8zH+nBuiBW8vr+
	evYIkCvWi88GzmuoBq4cjjFr30AgB3LmU1EFqMiyroL4ko6R19kRHqvJDD4Jm0Oz5EK0cVN
	HxZrwqTmfOk3jkvyvodqkeSj3LcjstUGAh1R4tardC2ahbm+B06eCvzvGC0dac66i0X7Lol
	cu0dMounxzewhAsj/e7fZVahWC/N3tv3jyW6EszpymYtOZUQSyKrbFt4jWrEbrzvMiA1tgl
	syoSqH6NkTUxs7DDdEVthgbRJLVWHta/oQkc9MNedTKVaIr70m8GtLMWuBsm4IoTplpyPi3
	ngqnZSuRUP7+BrmeiEDI3oM5BKTJHfn4nRhm6Z6t3wfU94QZffk+uNTSdKY/Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4159978867216461553
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net: txgbe: fix GPIO interrupt blocking
Date: Tue,  6 Feb 2024 15:08:24 +0800
Message-Id: <20240206070824.17460-1-jiawenwu@trustnetic.com>
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

GPIO interrupt is generated before MAC IRQ is enabled, it causes
subsequent GPIO interrupts that can no longer be reported if it is
not cleared in time. So clear GPIO interrupt status at the right
time. And executing function txgbe_gpio_irq_ack() manually since
handle_nested_irq() does not call .irq_ack for irq_chip.

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


