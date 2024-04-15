Return-Path: <netdev+bounces-87860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16418A4CCF
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F01282FCD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA55FEE5;
	Mon, 15 Apr 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKl/h7e5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4F5C90A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177856; cv=none; b=XeU+GUdhmsW9x872hNOEPV5hTWVOTlpbJw2xKEWvvAWpPuLTO/DnUoFluhPRJMZ9fGFKGFsWazU9laaUI3pmRCjcIbJ4n2QplD3U3VszxcLxwoHtaB8cSjbHNIuqMCKx3MFpUTRt2tTAsg98mYznR6E8J36JeVFseVb5Qz++mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177856; c=relaxed/simple;
	bh=nteOD3r/H7S6WbzwrcMqwYFvaUNpiAzBInlrtbWX+OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdOrbu5UH6PZtFR9Qocy1qAcQP0NcKEddcZqwMm+jKmAPr1eUoP0X8WU1d6nYBm9E9HQNYqNNmKfc6qw5gJAUqsGqzug2mQCksAAtz9TAzPwLMddP+omZHgZrByc+p1Oqm2EhyUpNgKyOx/kbEqLBD/n2XfR5D6Rfj0S8eJC4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKl/h7e5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so498793a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177854; x=1713782654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyJcQiU9vUIpByp+hYM1xx7BP+EdsE8jigDUcYhYdsk=;
        b=KKl/h7e5WgilALVeBTeGesNX+JR6M2m/GQc009CUMc1awJSE8HjPxvUnWGmNQ0FIkr
         1JyEPdS4m8dBZa7O0i2y2D/vWT1tsBXTMefYMxJKz+DM36Fo70y/IDeEMLYQXigsUOPr
         3qwb7gvFb9DbOPOTfkTgPBmQ2lKjrMpWeZfT400TXRqadrPWxw9OXXaQGp0lSb+HPGL8
         4GMwHltOu/h9A4w29932CGsFZlT6shkHsFR2gwNaqRLtLujdlQhjiFDWOS0jGtTTKaTk
         SG0kBhnq1sF2rKvzryaj1l4kchOhVMS6jGQArV0G+hrfE0NlhRHPJwPmHwoKhQGDetLu
         3ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177854; x=1713782654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyJcQiU9vUIpByp+hYM1xx7BP+EdsE8jigDUcYhYdsk=;
        b=ANxm82BxqSTHYVGFbxAVBLiy6GTVZF9GsHe9wBDs6AIET6VFuV8FvnxWsIM4DraH90
         dQLnm1Q6hS6hBvsE6SS7eDdaSkuEmzK+BXHpqe+Y5XRuPgf5FQv8ZuiXmMLAzlcfCZWX
         ee4HZrPc96v/mZVk0L3A+VbRb+QPaWwAvvrVMxdq68z+H+pgJRKqCC1Hol7SqYJ3Wg11
         O7w8Ac7lv+0vAQ2yq17qBJbN5oQS5yx21Tq9RguRHUB3roPmWTUeQLsktYoMxkGb9K+v
         QUfFuxVWa/O/Hm+bTfuzZoJZmKNxcbQHFwDNgyryoU4C4snRXTiHvhJ7drThkrZaCIFf
         F8Sw==
X-Gm-Message-State: AOJu0Yyv3TYjw1xaWbSJF1WDi1WzT2zwEAUB/xi4KEzeVZLgHfGtWY+f
	2z95uGAkQZ0zFAvoHuXmEN4r6P4lXZf4QvczhHs5YX70YusqegB+fBsC4Q==
X-Google-Smtp-Source: AGHT+IEMPpfwRYfh11iUxX9U1BIwCFh7gwJtoEs4OEliHTdl1rV0qo2SF0F89h3rHJFKcvxf80dKOA==
X-Received: by 2002:a17:902:e84d:b0:1dd:da28:e5ca with SMTP id t13-20020a170902e84d00b001ddda28e5camr11408746plg.0.1713177853958;
        Mon, 15 Apr 2024 03:44:13 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001e256cb48f7sm7581991plt.197.2024.04.15.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:44:13 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch
Subject: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
Date: Mon, 15 Apr 2024 19:43:52 +0900
Message-Id: <20240415104352.4685-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104352.4685-1-fujita.tomonori@gmail.com>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds supports for multiple PHY hardware with PHYLIB. The
adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.

For now, the PCI ID table of this driver enables adapters using only
QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/Kconfig     |   1 +
 drivers/net/ethernet/tehuti/Makefile    |   2 +-
 drivers/net/ethernet/tehuti/tn40.c      |  32 ++++++
 drivers/net/ethernet/tehuti/tn40.h      |   5 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 141 ++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 4198fd59e42e..71f22471f9a0 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -27,6 +27,7 @@ config TEHUTI_TN40
 	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
 	depends on PCI
 	select FW_LOADER
+	select AMCC_QT2025_PHY
 	help
 	  This driver supports 10G Ethernet adapters using Tehuti Networks
 	  TN40xx chips. Currently, adapters with Applied Micro Circuits
diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/tehuti/Makefile
index 1c468d99e476..7a0fe586a243 100644
--- a/drivers/net/ethernet/tehuti/Makefile
+++ b/drivers/net/ethernet/tehuti/Makefile
@@ -5,5 +5,5 @@
 
 obj-$(CONFIG_TEHUTI) += tehuti.o
 
-tn40xx-y := tn40.o
+tn40xx-y := tn40.o tn40_mdio.o
 obj-$(CONFIG_TEHUTI_TN40) += tn40xx.o
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index c8ed9b743753..2c50295f4e68 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1285,18 +1285,26 @@ static void bdx_link_changed(struct bdx_priv *priv)
 		if (priv->link_loop_cnt++ > LINK_LOOP_MAX) {
 			/* MAC reset */
 			bdx_set_link_speed(priv, 0);
+			bdx_set_link_speed(priv, priv->phydev->speed);
 			priv->link_loop_cnt = 0;
 		}
 		write_reg(priv, 0x5150, 1000000);
 		return;
 	}
+
+	if (!netif_carrier_ok(priv->ndev)) {
+		netif_wake_queue(priv->ndev);
+		phy_print_status(priv->phydev);
+	}
 	priv->link = link;
+	netif_carrier_on(priv->ndev);
 }
 
 static inline void bdx_isr_extra(struct bdx_priv *priv, u32 isr)
 {
 	if (isr & (IR_LNKCHG0 | IR_LNKCHG1 | IR_TMR0)) {
 		netdev_dbg(priv->ndev, "isr = 0x%x\n", isr);
+		phy_mac_interrupt(priv->phydev);
 		bdx_link_changed(priv);
 	}
 }
@@ -1580,23 +1588,42 @@ static int bdx_close(struct net_device *ndev)
 
 	bdx_disable_interrupts(priv);
 	free_irq(priv->pdev->irq, priv->ndev);
+	phy_stop(priv->phydev);
+	phy_disconnect(priv->phydev);
 	bdx_sw_reset(priv);
 	destroy_rx_ring(priv);
 	destroy_tx_ring(priv);
 	return 0;
 }
 
+static void phy_handler(struct net_device *_dev)
+{
+}
+
 static int bdx_open(struct net_device *dev)
 {
 	struct bdx_priv *priv = netdev_priv(dev);
 	int ret;
 
 	bdx_sw_reset(priv);
+
+	ret = phy_connect_direct(priv->ndev, priv->phydev, phy_handler, PHY_INTERFACE_MODE_XAUI);
+	if (ret) {
+		netdev_err(dev, "failed to connect to phy %d\n", ret);
+		return ret;
+	}
+	phy_attached_info(priv->phydev);
+	phy_start(priv->phydev);
+
 	ret = bdx_start(priv);
 	if (ret) {
 		netdev_err(dev, "failed to start %d\n", ret);
+		phy_stop(priv->phydev);
+		phy_disconnect(priv->phydev);
 		return ret;
 	}
+	napi_enable(&priv->napi);
+	netif_start_queue(priv->ndev);
 	return 0;
 }
 
@@ -1872,6 +1899,11 @@ static int bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	priv->stats_flag = ((read_reg(priv, FPGA_VER) & 0xFFF) != 308);
 
+	ret = bdx_mdiobus_init(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to find PHY.\n");
+		goto err_free_irq;
+	}
 	priv->isr_mask =
 	    IR_RX_FREE_0 | IR_LNKCHG0 | IR_PSE | IR_TMR0 | IR_RX_DESC_0 |
 	    IR_TX_FREE_0 | IR_TMR1;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index fb43ebb5911f..06ab9a2cb42d 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -197,6 +197,9 @@ struct bdx_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct bdx_rx_page_table rx_page_table;
+
+	struct mii_bus *mdio;
+	struct phy_device *phydev;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -283,4 +286,6 @@ static inline void write_reg(struct bdx_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int bdx_mdiobus_init(struct bdx_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..f7f83c77e8b2
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static u32 bdx_mdio_get(struct bdx_priv *priv)
+{
+	void __iomem *regs = priv->regs;
+
+#define BDX_MAX_MDIO_BUSY_LOOPS 1024
+	int tries = 0;
+
+	while (++tries < BDX_MAX_MDIO_BUSY_LOOPS) {
+		u32 mdio_cmd_stat = readl(regs + REG_MDIO_CMD_STAT);
+
+		if (GET_MDIO_BUSY(mdio_cmd_stat) == 0)
+			return mdio_cmd_stat;
+	}
+	dev_err(&priv->pdev->dev, "MDIO busy!\n");
+	return 0xFFFFFFFF;
+}
+
+static u16 bdx_mdio_read(struct bdx_priv *priv, int device, int port, u16 addr)
+{
+	void __iomem *regs = priv->regs;
+	u32 tmp_reg, i;
+	/* wait until MDIO is not busy */
+	if (bdx_mdio_get(priv) == 0xFFFFFFFF)
+		return -1;
+
+	i = ((device & 0x1F) | ((port & 0x1F) << 5));
+	writel(i, regs + REG_MDIO_CMD);
+	writel((u32)addr, regs + REG_MDIO_ADDR);
+	tmp_reg = bdx_mdio_get(priv);
+	if (tmp_reg == 0xFFFFFFFF)
+		return -1;
+
+	writel(((1 << 15) | i), regs + REG_MDIO_CMD);
+	/* read CMD_STAT until not busy */
+	tmp_reg = bdx_mdio_get(priv);
+	if (tmp_reg == 0xFFFFFFFF)
+		return -1;
+
+	if (GET_MDIO_RD_ERR(tmp_reg)) {
+		dev_dbg(&priv->pdev->dev, "MDIO error after read command\n");
+		return -1;
+	}
+	tmp_reg = readl(regs + REG_MDIO_DATA);
+
+	return (tmp_reg & 0xFFFF);
+}
+
+static int bdx_mdio_write(struct bdx_priv *priv, int device, int port, u16 addr,
+			  u16 data)
+{
+	void __iomem *regs = priv->regs;
+	u32 tmp_reg;
+
+	/* wait until MDIO is not busy */
+	if (bdx_mdio_get(priv) == 0xFFFFFFFF)
+		return -1;
+	writel(((device & 0x1F) | ((port & 0x1F) << 5)), regs + REG_MDIO_CMD);
+	writel((u32)addr, regs + REG_MDIO_ADDR);
+	if (bdx_mdio_get(priv) == 0xFFFFFFFF)
+		return -1;
+	writel((u32)data, regs + REG_MDIO_DATA);
+	/* read CMD_STAT until not busy */
+	tmp_reg = bdx_mdio_get(priv);
+	if (tmp_reg == 0xFFFFFFFF)
+		return -1;
+
+	if (GET_MDIO_RD_ERR(tmp_reg)) {
+		dev_err(&priv->pdev->dev, "MDIO error after write command\n");
+		return -1;
+	}
+	return 0;
+}
+
+static void bdx_mdio_set_speed(struct bdx_priv *priv, u32 speed)
+{
+	void __iomem *regs = priv->regs;
+	int mdio_cfg;
+
+	mdio_cfg = readl(regs + REG_MDIO_CMD_STAT);
+	if (speed == 1)
+		mdio_cfg = (0x7d << 7) | 0x08;	/* 1MHz */
+	else
+		mdio_cfg = 0xA08;	/* 6MHz */
+	mdio_cfg |= (1 << 6);
+	writel(mdio_cfg, regs + REG_MDIO_CMD_STAT);
+	msleep(100);
+}
+
+static int mdio_read_reg(struct mii_bus *mii_bus, int addr, int devnum, int regnum)
+{
+	return bdx_mdio_read(mii_bus->priv, devnum, addr, regnum);
+}
+
+static int mdio_write_reg(struct mii_bus *mii_bus, int addr, int devnum, int regnum, u16 val)
+{
+	return bdx_mdio_write(mii_bus->priv, devnum, addr, regnum, val);
+}
+
+int bdx_mdiobus_init(struct bdx_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	struct mii_bus *bus;
+	struct phy_device *phydev;
+	int ret;
+
+	bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = BDX_DRV_NAME;
+	bus->parent = &pdev->dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "tn40xx-%x-%x",
+		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
+	bus->priv = priv;
+
+	bus->read_c45 = mdio_read_reg;
+	bus->write_c45 = mdio_write_reg;
+
+	ret = devm_mdiobus_register(&pdev->dev, bus);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
+			ret, bus->state, MDIOBUS_UNREGISTERED);
+		return ret;
+	}
+
+	phydev = phy_find_first(bus);
+	if (!phydev) {
+		dev_err(&pdev->dev, "failed to find phy\n");
+		return -1;
+	}
+	phydev->irq = PHY_MAC_INTERRUPT;
+	priv->mdio = bus;
+	priv->phydev = phydev;
+	bdx_mdio_set_speed(priv, MDIO_SPEED_6MHZ);
+	return 0;
+}
-- 
2.34.1


