Return-Path: <netdev+bounces-91141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77768B184F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05505B21E83
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE1D512;
	Thu, 25 Apr 2024 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXfnUwJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D16AC0
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007133; cv=none; b=Y2BvZvpP6VTPWBZzuuCVLaKhRwvjQSxI/OxmCyAsgmzNP5B4kt4kgzAf6dYG4vjysXfhHtlvWDrUPq/eY41LmWPmcUGTIC9/aioftQWdJ8HphMBkAENFPnSYczyKjTY5SunWTmxRePgqSucAtk/gvj+PvuuUJ0Q5r9boaKt9IA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007133; c=relaxed/simple;
	bh=K88s39uNZ4FRv021dChTTdZu5B5XLc4BZAXSflq0eDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA/WX7M+J2j5l83e8z//FNxfzYeLhu7OENl4rDgNqkJpPEY1wK7HEVjUUVhLzdHuJJt12cvk3NHk8ZlLfnUSDLW+jeuF9qx01Two9krGfssV6o/bGVHpPF2ayGIVMVatWOaWsiTzuKgpx/LHH/gqS1l9DbNGclywxjVRnUVKlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXfnUwJG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ab936993abso98146a91.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007131; x=1714611931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qj3QCDDjCWnkZXKDBMr2xGVUFiCgKqiwW62qe5EaPk=;
        b=jXfnUwJGC1meFOqdmkonIBGBidCTpPNfedQUxFKVh+9AqK/2lJdDmZ6q9HXyjYCwpS
         NEJAW3y2s0x/hA0Jz9syZchVZkE5MZ7EZlhRu+sa+RZ8vCQKFpoFcfHq7gvP7ppBNtzY
         iDhfmQYdpKao5ZhkIcIunE12hTFFBoyqS0YvEP+rtcbxmVWmU8jbWXpfXq4pEI2N62BQ
         heH8UpNDK/pRnyo/WfICr0pwQQ0H7Toqc1NQXpvvRX+Ot401o52SVm7Iozoa9F9oc2+K
         R0xd5kWxxOxND1ghJvYIQNfyfp+cEl2aI/rN6YgV6PPmteBfUi5CBIbe+aiKd1WDpAdf
         YoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007131; x=1714611931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qj3QCDDjCWnkZXKDBMr2xGVUFiCgKqiwW62qe5EaPk=;
        b=LADHfR/tK7z0RJnodp0Ve/w6e6lBSNXvPKSzwxSvyvaZutkhZA6ouysSqxvislrc0n
         wCPX/XUukpBwIQ3Ky+JWy4W4rM2JYGp8Vd+UkP4JvFdER5teIqBUuXEjOZbcrVxVsAX+
         saCGYW74d/m6tDv+1hMYHcFNFVKC3nRPToxAT13/vu+Y8SmtZtXp0StDO4Q1EEUAYIwO
         ye5LhHg5uaj3G/b3w1qMNAhVkqvlbCZ/hTWJn/KYNmB0oXprbQ094yo6R2D71/cVN+L8
         mKby254fFZF7qfWIR5GYqv7TForzy6LBsq2/QHq+/LNgRCttREm0w56Ag2otQcPO4F2L
         Waqg==
X-Gm-Message-State: AOJu0YzuIHMokKra+PD9xx07Wa/DNuYnD/gbfWI3iV02dgmH7dHXFgCc
	1Ifr1vGa/+QhWn1/s2YzmTzjQw7IXMTJMGwFjDVkpaqKhxiUYVEP0MEpOA==
X-Google-Smtp-Source: AGHT+IGNHgsWjrkj0Z5pmcE0Ccb1Z7kqCp3FB349sob3XXVb9h8McsEoAsvRlVFodmhRboAGsPE9uQ==
X-Received: by 2002:aa7:8d15:0:b0:6ec:f5d2:f641 with SMTP id j21-20020aa78d15000000b006ecf5d2f641mr4966961pfe.1.1714007131347;
        Wed, 24 Apr 2024 18:05:31 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:30 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 5/6] net: tn40xx: add mdio bus support
Date: Thu, 25 Apr 2024 10:03:53 +0900
Message-Id: <20240425010354.32605-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds supports for mdio bus. A later path adds PHYLIB
support on the top of this.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/Makefile    |   2 +-
 drivers/net/ethernet/tehuti/tn40.c      |   7 +-
 drivers/net/ethernet/tehuti/tn40.h      |   4 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 129 ++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c

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
index f676fc6e1d3a..0b8a063adb8c 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1760,8 +1760,13 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_unset_drvdata;
 	}
 
-	priv->stats_flag = ((read_reg(priv, FPGA_VER) & 0xFFF) != 308);
+	ret = tn40_mdiobus_init(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
+		goto err_free_irq;
+	}
 
+	priv->stats_flag = ((read_reg(priv, FPGA_VER) & 0xFFF) != 308);
 	priv->isr_mask =
 	    IR_RX_FREE_0 | IR_LNKCHG0 | IR_PSE | IR_TMR0 | IR_RX_DESC_0 |
 	    IR_TX_FREE_0 | IR_TMR1;
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 2c24f75cab03..0f39dc70f37c 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -11,6 +11,7 @@
 #include <linux/if_vlan.h>
 #include <linux/in.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -176,6 +177,7 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct rx_page_table rx_page_table;
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -262,4 +264,6 @@ static inline void write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..c00421427f20
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static void mdio_set_speed(struct tn40_priv *priv, u32 speed)
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
+static u32 mdio_stat(struct tn40_priv *priv)
+{
+	void __iomem *regs = priv->regs;
+
+	return readl(regs + REG_MDIO_CMD_STAT);
+}
+
+static int mdio_get(struct tn40_priv *priv, u32 *val)
+{
+	u32 stat;
+	int ret;
+
+	ret = readx_poll_timeout_atomic(mdio_stat, priv, stat,
+					GET_MDIO_BUSY(stat) == 0, 10, 10000);
+	return ret;
+}
+
+static int tn40_mdio_read(struct tn40_priv *priv, int port, int device,
+			  u16 regnum)
+{
+	void __iomem *regs = priv->regs;
+	u32 tmp_reg, i;
+
+	/* wait until MDIO is not busy */
+	if (mdio_get(priv, NULL))
+		return -EIO;
+
+	i = ((device & 0x1F) | ((port & 0x1F) << 5));
+	writel(i, regs + REG_MDIO_CMD);
+	writel((u32)regnum, regs + REG_MDIO_ADDR);
+	if (mdio_get(priv, NULL))
+		return -EIO;
+
+	writel(((1 << 15) | i), regs + REG_MDIO_CMD);
+	/* read CMD_STAT until not busy */
+	if (mdio_get(priv, NULL))
+		return -EIO;
+
+	tmp_reg = readl(regs + REG_MDIO_DATA);
+	return lower_16_bits(tmp_reg);
+}
+
+static int tn40_mdio_write(struct tn40_priv *priv, int port, int device,
+			   u16 regnum, u16 data)
+{
+	void __iomem *regs = priv->regs;
+	u32 tmp_reg = 0;
+	int ret;
+
+	/* wait until MDIO is not busy */
+	if (mdio_get(priv, NULL))
+		return -EIO;
+	writel(((device & 0x1F) | ((port & 0x1F) << 5)), regs + REG_MDIO_CMD);
+	writel((u32)regnum, regs + REG_MDIO_ADDR);
+	if (mdio_get(priv, NULL))
+		return -EIO;
+	writel((u32)data, regs + REG_MDIO_DATA);
+	/* read CMD_STAT until not busy */
+	ret = mdio_get(priv, &tmp_reg);
+	if (ret)
+		return -EIO;
+
+	if (GET_MDIO_RD_ERR(tmp_reg)) {
+		dev_err(&priv->pdev->dev, "MDIO error after write command\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int mdio_read(struct mii_bus *mii_bus, int addr, int devnum, int regnum)
+{
+	return tn40_mdio_read(mii_bus->priv, addr, devnum, regnum);
+}
+
+static int mdio_write(struct mii_bus *mii_bus, int addr, int devnum,
+		      int regnum, u16 val)
+{
+	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val);
+}
+
+int tn40_mdiobus_init(struct tn40_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = TN40_DRV_NAME;
+	bus->parent = &pdev->dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "tn40xx-%x-%x",
+		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
+	bus->priv = priv;
+
+	bus->read_c45 = mdio_read;
+	bus->write_c45 = mdio_write;
+
+	ret = devm_mdiobus_register(&pdev->dev, bus);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
+			ret, bus->state, MDIOBUS_UNREGISTERED);
+		return ret;
+	}
+	mdio_set_speed(priv, MDIO_SPEED_6MHZ);
+	priv->mdio = bus;
+	return 0;
+}
-- 
2.34.1


