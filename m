Return-Path: <netdev+bounces-176057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31EA6883C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D984A3B306A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8025A2C2;
	Wed, 19 Mar 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea6p1KBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF8254AFC;
	Wed, 19 Mar 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376733; cv=none; b=qYChm15u1r9VqRVJVz5Xy10Z9A6pd0S4l4na1x31IR0alCtx0cQ5UsAIyVspdA3oQMAA/wlGNtwcm8G0iYiTqC70uJqWThFTUyBx2YX8gcKFcJx45IjTlHuKWrjpqHwSUPuG2LOE76opQ8EtFnLIHp3Untj5I0djcyXkcWOLwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376733; c=relaxed/simple;
	bh=IsSr0wX0D/RHalSLc13nA67slNDqv2KI4EP4GC8jN1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wmg1wq/YNw1jrS5dQ7s0oEtRHv+cB+kcit9VD8JSKAA0EC63YwX5rPQX/yjwA0vPF3VbM2bIAzV1Pd6qbfh+iibhtqZKKwd94fGaPjbNQp1xoFCYCtljodZdh1T9hosVbmWPfLe1e3mCDqReLWDlPQbWYpoKeDza5YKFRSOwqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea6p1KBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F2C4CEF2;
	Wed, 19 Mar 2025 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376733;
	bh=IsSr0wX0D/RHalSLc13nA67slNDqv2KI4EP4GC8jN1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ea6p1KBNR8PESCP7Nup1708/++FB5ztSkIaPeEET1r7L7lIJvwXfbZkb7HwayAWyi
	 T0+13+UD/YxOW/XIUE5nbXN3sgN6J2XDo01InETzr6VUK1pF6ysJ2UDKYAYlEfXK44
	 uhAz82JsqfwuTW+p1WII3HEZFTimm+cHzgtqdwCzHYHTYgoqwsS+OdqGiCA6Fk6LIs
	 JzIUfmKPNGVCMXUPW8VM870svvKoKa0FB/3MItg5hzoXxXPVfyAugOjQDfKtb8marP
	 LJZTuOU0rMQ9Dfs7DNZiSaLAIfsXZNymajP/FNhjKXMwUTpr2IXuzK3Iwg3d8WWHGK
	 9ODvGwO9v9Rog==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 27/57] irqdomain: net: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:20 +0100
Message-ID: <20250319092951.37667-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Cc: Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/dsa/microchip/ksz_common.c         | 5 +++--
 drivers/net/dsa/microchip/ksz_ptp.c            | 4 ++--
 drivers/net/dsa/mv88e6xxx/chip.c               | 2 +-
 drivers/net/dsa/mv88e6xxx/global2.c            | 6 ++++--
 drivers/net/dsa/qca/ar9331.c                   | 4 ++--
 drivers/net/dsa/realtek/rtl8365mb.c            | 4 ++--
 drivers/net/dsa/realtek/rtl8366rb.c            | 6 ++----
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 6 ++++--
 drivers/net/usb/lan78xx.c                      | 9 ++++-----
 9 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..579ee504fed5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2697,8 +2697,9 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	kirq->dev = dev;
 	kirq->masked = ~0;
 
-	kirq->domain = irq_domain_add_simple(dev->dev->of_node, kirq->nirqs, 0,
-					     &ksz_irq_domain_ops, kirq);
+	kirq->domain = irq_domain_create_simple(of_fwnode_handle(dev->dev->of_node),
+						kirq->nirqs, 0,
+						&ksz_irq_domain_ops, kirq);
 	if (!kirq->domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 22fb9ef4645c..992101e4bdee 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1136,8 +1136,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 	init_completion(&port->tstamp_msg_comp);
 
-	ptpirq->domain = irq_domain_add_linear(dev->dev->of_node, ptpirq->nirqs,
-					       &ksz_ptp_irq_domain_ops, ptpirq);
+	ptpirq->domain = irq_domain_create_linear(of_fwnode_handle(dev->dev->of_node),
+						  ptpirq->nirqs, &ksz_ptp_irq_domain_ops, ptpirq);
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5db96ca52505..a39aab7cd606 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -297,7 +297,7 @@ static int mv88e6xxx_g1_irq_setup_common(struct mv88e6xxx_chip *chip)
 	u16 reg, mask;
 
 	chip->g1_irq.nirqs = chip->info->g1_irqs;
-	chip->g1_irq.domain = irq_domain_add_simple(
+	chip->g1_irq.domain = irq_domain_create_simple(
 		NULL, chip->g1_irq.nirqs, 0,
 		&mv88e6xxx_g1_irq_domain_ops, chip);
 	if (!chip->g1_irq.domain)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index b2b5f6ba438f..aaf97c1e3167 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1154,8 +1154,10 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	chip->g2_irq.domain = irq_domain_add_simple(
-		chip->dev->of_node, 16, 0, &mv88e6xxx_g2_irq_domain_ops, chip);
+	chip->g2_irq.domain = irq_domain_create_simple(of_fwnode_handle(chip->dev->of_node),
+						       16, 0,
+						       &mv88e6xxx_g2_irq_domain_ops,
+						       chip);
 	if (!chip->g2_irq.domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index e9f2c67bc15f..79a29676ca6f 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -821,8 +821,8 @@ static int ar9331_sw_irq_init(struct ar9331_sw_priv *priv)
 		return ret;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(np, 1, &ar9331_sw_irqdomain_ops,
-						priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(np), 1,
+						   &ar9331_sw_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -EINVAL;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 7e96355c28bd..964a56ee16cc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1719,8 +1719,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(intc, priv->num_ports,
-						&rtl8365mb_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), priv->num_ports,
+						   &rtl8365mb_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(priv->dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index f54771cab56d..8bdb52b5fdcb 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -550,10 +550,8 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_priv *priv)
 		dev_err(priv->dev, "unable to request irq: %d\n", ret);
 		goto out_put_node;
 	}
-	priv->irqdomain = irq_domain_add_linear(intc,
-						RTL8366RB_NUM_INTERRUPT,
-						&rtl8366rb_irqdomain_ops,
-						priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), RTL8366RB_NUM_INTERRUPT,
+						   &rtl8366rb_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(priv->dev, "failed to create IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8658a51ee810..f60c8a73ddce 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -184,8 +184,10 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 		goto skip_sp_irq;
 
 	txgbe->misc.nirqs = 1;
-	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
-						   &txgbe_misc_irq_domain_ops, txgbe);
+	txgbe->misc.domain = irq_domain_create_simple(NULL, txgbe->misc.nirqs,
+						      0,
+						      &txgbe_misc_irq_domain_ops,
+						      txgbe);
 	if (!txgbe->misc.domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 137adf6d5b08..9a5de0098ec0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2456,14 +2456,11 @@ static struct irq_chip lan78xx_irqchip = {
 
 static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 {
-	struct device_node *of_node;
 	struct irq_domain *irqdomain;
 	unsigned int irqmap = 0;
 	u32 buf;
 	int ret = 0;
 
-	of_node = dev->udev->dev.parent->of_node;
-
 	mutex_init(&dev->domain_data.irq_lock);
 
 	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
@@ -2475,8 +2472,10 @@ static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqchip = &lan78xx_irqchip;
 	dev->domain_data.irq_handler = handle_simple_irq;
 
-	irqdomain = irq_domain_add_simple(of_node, MAX_INT_EP, 0,
-					  &chip_domain_ops, &dev->domain_data);
+	irqdomain = irq_domain_create_simple(of_fwnode_handle(dev->udev->dev.parent->of_node),
+					     MAX_INT_EP, 0,
+					     &chip_domain_ops,
+					     &dev->domain_data);
 	if (irqdomain) {
 		/* create mapping for PHY interrupt */
 		irqmap = irq_create_mapping(irqdomain, INT_EP_PHY);
-- 
2.49.0


