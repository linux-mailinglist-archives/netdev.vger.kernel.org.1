Return-Path: <netdev+bounces-76478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66F86DE4D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05C7B2179E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB16A33C;
	Fri,  1 Mar 2024 09:31:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67A6996B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285509; cv=none; b=W+OFSb8s3EDQpVM9hRaB4oxEDTU0OQYGfwN6nk6YNvlvqru3R3ZWIyHgj84VkawHRxhZAPwJnxSbEYvNUkJjrHAqKZ207uCScJJWintbSC5j1vblOwF8KHzkDA28Tyc84d9xpEVmIO19OF1ew0qAPnfiGg4oG/BrMArHmuTKcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285509; c=relaxed/simple;
	bh=QF8BC//m0JPPdZOWBD+ELJhntt9MeckD2KqnVY+G5Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cOwk8g7mvf4VP0cPZxvGPRlHcUV/3SArikyzftMkOwnyHJIqcJLgTiePSbieDbjps2iYxs1rPXt0yfkimV8aDJYASPjjC0EF8hTZKPMWx3A6A8BoZb+N+fWjwwcWTWWGCTbT/VGtK5ukmlnYKdaankLBjbwTrHmORvSMLe90XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp80t1709285405twfipafa
X-QQ-Originating-IP: 7cSCx81IapJHudnZUCnEfAnsDohMPBPF8X+L/+wjWnM=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 01 Mar 2024 17:30:02 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: OtIeQkg1QQGMsrzuVnI4DJcPQJ2uc/dpZLJCD6TyYCMioxTcOZ4BJqsv7fx1B
	nOwHstfuMgkAMQx7d3almuBz+kvQEMU0cJp+gw/hmtS3VOE33ilu0xJCQ5SJM0et0jGlZIQ
	Pw6g9o+NeiLnfmQ5RsSaddYG032WGBwiDXyPzcWGikq0cR+T4354g0/5fILnb+PR/nOkzRJ
	rGXOFI/fMpt5Z8CCa9uIdJCyqChV0xZ0zjV3csrLszaFfwnZlD2lj7s6AXecBIq//7/0WZQ
	OoSMyMC7h6EizQchFpbqE5VnZNZyE2z/AWCy9An6rZ+W+X8HjLiKIY/kyc0v+s+Bh3JgoKc
	7P51XJRksfH8lB1ygBDYlU80GNIl/ve4IcSkC5xLCTtVoO/C1s6XUD9+Xmzr8F9NJwbtKpq
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3818342503685067253
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
Subject: [PATCH v3 1/2] net: txgbe: fix GPIO interrupt blocking
Date: Fri,  1 Mar 2024 17:29:55 +0800
Message-Id: <20240301092956.18544-1-jiawenwu@trustnetic.com>
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

The register of GPIO interrupt status is masked before MAC IRQ
is enabled. This is because of hardware deficiency. So manually
clear the interrupt status before using them. Otherwise, GPIO
interrupts will never be reported again. There is a workaround for
clearing interrupts to set GPIO EOI in txgbe_up_complete().

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 27 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |  1 +
 3 files changed, 29 insertions(+)

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
index bae0a8ee7014..c112f79b026e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -489,6 +489,33 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
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


