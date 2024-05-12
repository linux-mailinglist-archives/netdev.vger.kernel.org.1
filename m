Return-Path: <netdev+bounces-95767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F738C35CF
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D117C1F213D8
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E91C680;
	Sun, 12 May 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzYlXO8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A01CD1B
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715504567; cv=none; b=jUpxJCrrisli1emtRLk7s7RVC4yE1Zf2IXej7VrDSs9Td/Wfpaah3Wi7Bsv4aNVuCHotPECQW6oAnBpFhUAeOL9ofk2hFXmFi7DzpyR6Vkw+m0ZiQAXXQcCwbeF9MYMA5udeJsc4PjhbP8/gJf7seMYfS3L+/qispIbL9jyHK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715504567; c=relaxed/simple;
	bh=ixQJluCRettALjHzNuopyIooinsK1HBCcOBuDDW2kMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHfnXbqTy6+jlwAlIea0ePuMq2ZAcc/yHa1FDWzNFk/yBKIsd9N3oLSCabEMdGVfaS/ddRze3mIf87D01YHvWSfjTvg5Ia6Dczu6xnDLB1QrwGDLsw1TbhYWLnqAsEKOuQk3s997nZQ/ME66CufYTzAqjGZWuu5V5BbATGMFmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzYlXO8l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b516b36acfso894398a91.2
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715504564; x=1716109364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3N5g34YyfKOBoMkeEW+uts0Umg/wO7R1IPns3sL0z4=;
        b=kzYlXO8lItU3xiwaOEik4hR0wga8cm+NXU/tns5rIR14Gktps8tg3nt5iK2t5mNnGb
         h1wkAaGS8O5dIgnHXXvvt+P97RYoU83tiMAIP6wWca/zjN6K6aKDJhMksDmEstUeWh9I
         6VGNH0mi1PUktAVE3tp3JQNkIMhFakWTjy8mmShZIX59PqRKJ/klvd7ffK+llkmo/ij3
         SfoYIYpXegoMBFAcmD1shFEFa3ptU9Fm2WwyUcclw2487d/TJMRALg3/7G0FsuQBnOq0
         BnW03/X1rGthFyhw+4sedkfJAqEhws/FJGr9P/P7/HtPH/0DkueY8OzelnifqzFviCU5
         CyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715504564; x=1716109364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3N5g34YyfKOBoMkeEW+uts0Umg/wO7R1IPns3sL0z4=;
        b=I1/S0Y3GKYqjzjQZexxdx9+zkxfCW44Sz/cNp7LAPoQ+cFphKjuSkVDWdHojxrm4gh
         N1R1xcEpcClkLexIql5k3ieea3QuEE7xcVrd6eoNXqHZ6tjsae/l/KgstoXpl1+6E9gh
         Vz6DF6qVwfq3BaFiOmvPNNfMT4MvIDOcP/h5bd0at+2cgCy1pc9kfRhRAlESkHfN6PoB
         Ww0b/j5GGNPns6sr7mgnhdbfFJeb8ebVuly+TDb0Bup+ZSwNUtYDbvFO/gny/b56LO9p
         Ti/iqjs/2Ih0cCnPb/WkieaH474Kz6jqphvxo6pd5iDKlXwKUKOOGgJWcy5Qkh6aCLvc
         Ho5g==
X-Gm-Message-State: AOJu0YwklsOektPjqFmiLN9uKxgHB3aNBVOovBlXNDn5SN7RPJQ5sstJ
	hviROLAbcc7gtnaw23kV0q/cph/GPrAud/W5GjXpKSDfyV+vq00eFo4nHN/L
X-Google-Smtp-Source: AGHT+IGVM4C6NwVPTZjjCbvTG1BO9L80Ph9DAPrXi0E2CfL9zHn9fShhM36LD9lgzoim2sdodAxzjw==
X-Received: by 2002:a05:6a00:4a85:b0:6f4:bd8d:b48f with SMTP id d2e1a72fcca58-6f4e01b96a6mr7335870b3a.0.1715504564350;
        Sun, 12 May 2024 02:02:44 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fff45ce3sm219915b3a.197.2024.05.12.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 02:02:44 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net
Subject: [PATCH net-next v6 5/6] net: tn40xx: add mdio bus support
Date: Sun, 12 May 2024 17:56:10 +0900
Message-Id: <20240512085611.79747-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512085611.79747-1-fujita.tomonori@gmail.com>
References: <20240512085611.79747-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c      |   6 +
 drivers/net/ethernet/tehuti/tn40.h      |   3 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 140 ++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
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
index 4ddbdb21f1ed..38b2a1fe501a 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1764,6 +1764,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_unset_drvdata;
 	}
 
+	ret = tn40_mdiobus_init(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
+		goto err_free_irq;
+	}
+
 	priv->stats_flag =
 		((tn40_read_reg(priv, TN40_FPGA_VER) & 0xFFF) != 308);
 
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 6efa268ea0e2..e5e3610f9b8f 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -158,6 +158,7 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct tn40_rx_page_table rx_page_table;
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -237,4 +238,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..b0d559229ea3
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/phylink.h>
+
+#include "tn40.h"
+
+#define TN40_MDIO_DEVAD_MASK GENMASK(4, 0)
+#define TN40_MDIO_PRTAD_MASK GENMASK(9, 5)
+#define TN40_MDIO_CMD_VAL(device, port)			\
+	(FIELD_PREP(TN40_MDIO_DEVAD_MASK, (device)) |	\
+	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
+#define TN40_MDIO_CMD_READ BIT(15)
+
+static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
+{
+	void __iomem *regs = priv->regs;
+	int mdio_cfg;
+
+	mdio_cfg = readl(regs + TN40_REG_MDIO_CMD_STAT);
+	if (speed == 1)
+		mdio_cfg = (0x7d << 7) | 0x08;	/* 1MHz */
+	else
+		mdio_cfg = 0xA08;	/* 6MHz */
+	mdio_cfg |= (1 << 6);
+	writel(mdio_cfg, regs + TN40_REG_MDIO_CMD_STAT);
+	msleep(100);
+}
+
+static u32 tn40_mdio_stat(struct tn40_priv *priv)
+{
+	void __iomem *regs = priv->regs;
+
+	return readl(regs + TN40_REG_MDIO_CMD_STAT);
+}
+
+static int tn40_mdio_get(struct tn40_priv *priv, u32 *val)
+{
+	u32 stat;
+
+	return readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
+					 TN40_GET_MDIO_BUSY(stat) == 0, 10,
+					 10000);
+}
+
+static int tn40_mdio_read(struct tn40_priv *priv, int port, int device,
+			  u16 regnum)
+{
+	void __iomem *regs = priv->regs;
+	u32 tmp_reg, i;
+
+	/* wait until MDIO is not busy */
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+
+	i = TN40_MDIO_CMD_VAL(device, port);
+	writel(i, regs + TN40_REG_MDIO_CMD);
+	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+
+	writel(TN40_MDIO_CMD_READ | i, regs + TN40_REG_MDIO_CMD);
+	/* read CMD_STAT until not busy */
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+
+	tmp_reg = readl(regs + TN40_REG_MDIO_DATA);
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
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+	writel(TN40_MDIO_CMD_VAL(device, port), regs + TN40_REG_MDIO_CMD);
+	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+	writel((u32)data, regs + TN40_REG_MDIO_DATA);
+	/* read CMD_STAT until not busy */
+	ret = tn40_mdio_get(priv, &tmp_reg);
+	if (ret)
+		return -EIO;
+
+	if (TN40_GET_MDIO_RD_ERR(tmp_reg)) {
+		dev_err(&priv->pdev->dev, "MDIO error after write command\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int tn40_mdio_read_cb(struct mii_bus *mii_bus, int addr, int devnum,
+			     int regnum)
+{
+	return tn40_mdio_read(mii_bus->priv, addr, devnum, regnum);
+}
+
+static int tn40_mdio_write_cb(struct mii_bus *mii_bus, int addr, int devnum,
+			      int regnum, u16 val)
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
+	bus->read_c45 = tn40_mdio_read_cb;
+	bus->write_c45 = tn40_mdio_write_cb;
+
+	ret = devm_mdiobus_register(&pdev->dev, bus);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
+			ret, bus->state, MDIOBUS_UNREGISTERED);
+		return ret;
+	}
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
+	priv->mdio = bus;
+	return 0;
+}
-- 
2.34.1


