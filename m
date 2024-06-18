Return-Path: <netdev+bounces-104335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EB90C30E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5263F1C22513
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09DF1CD1F;
	Tue, 18 Jun 2024 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WymQGzgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D03BB59
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687893; cv=none; b=ask8ArCYBAYkLOASoDKCLwzPPM6dH+Zlga2LzyiHZADCYQb3NCOUjYbxYT2Y77e9elEmN0LWD3n9VFm+ctEx76j1ILulzQa+14LQIxY0MVmnjH7RbnqyMdhiMnKVWMIT7u2nIzwA8ROC8cu652B5c20mCvKSr6agX8lrGeTqkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687893; c=relaxed/simple;
	bh=o6Rz07PBGenkAtAATpn/N0/JLT0K7ky0ZKjypW3tgDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBO6IAYwcK19qO4wweRCVPxjxlsBcjZjCJWXd5tf6hKXsOsw0OZ+OEZZqgTy5eVnXFFQ1zTWTbS9ONVpha2unADE5ZVlFbHsRY+09a1bNCXFlKWi4GlwDbgiUrfQc3kKV3Es5ujFPSwiRG9xLNxLuWP/2/sYNgBH6rpg3G049MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WymQGzgA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f99e2dc8cdso21615ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718687891; x=1719292691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGK7LofLPpbrPjOJdlzE5/ZbJveooJBnW+He9jnucMI=;
        b=WymQGzgAXIuD5VT3mootjGo8o6H3BGYaSXlWuWak6D8JYUVZfNXD/nVHh+A3BCn1n1
         OxhL4MEA9e8tmmXZyP2nknHZO3yRrFY911vhPt8VSh6SJ0OSXGxC171WOhMFhPoU+nlL
         uEXdz0XDVkDY5tQm77y2krZ4B6p2031ha+Wgy1AXfRI/w7C2TiyqKfz2PuaCmX3sKwBF
         9d9wiWyKEw0znQCto1jLHNXcaZ72JHTjae40ZrDxX3I3n4JrR3lU48Tqe+Je/XzUhpyZ
         bCrXqRgzls8WuJfHpcLllL3lvRBh5dcwQOWndePlOrWvZsVkjqawjQBWYVRFdTt6e7Po
         xCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718687891; x=1719292691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGK7LofLPpbrPjOJdlzE5/ZbJveooJBnW+He9jnucMI=;
        b=kzTVFNDwFCRInjYxGWmfIwNoDpoCYANZYofPpQ7Sxxm4eRT2iaYMt3+ERuXQq2n23W
         CaebnVFO1Nm0zAnuZ/aj4TyVXY3taOy4+5RCB455R4N7p/a1lQrO2EL3ysgK7JUrHB1t
         7MKWdRDYUaSbuxtcY+pg3k5hjLTrTeIyvDkzE+ieKDUXGoGoWZf5Y9waErtHaVxVNPt2
         xEVGGSuvsxDr9aOJEJ3ReaWRGI2wQqpEgRgHCAKX2BTJQcIG65UniTozaWv8JvTM6OKD
         T5GhxmoG+voDN9+3+mkGixtIc9MDkxzxfx/vyT1dBoE5xEBol2fcZwoiFlWtlOsxAZJC
         1niA==
X-Gm-Message-State: AOJu0Yyis9qKSt9IOK8miNohIcnCNHu0uAKvlv07aShS3ZacfvEHq/vB
	Icnf+OUXWUoCmYmAxPFQX5WKfZTvJrM8iaTm9HyRatH6i9Mv/NXUYQXYIEWs
X-Google-Smtp-Source: AGHT+IG31PNZhn9Sh9PkP54BfrYx6gNGyJAgjdCjpSYwLd9V2xVOYNbCTzLBEhlCOsxXXi+vWGFvUQ==
X-Received: by 2002:a17:902:ce8e:b0:1f5:e635:21eb with SMTP id d9443c01a7336-1f862544952mr133434475ad.0.1718687891275;
        Mon, 17 Jun 2024 22:18:11 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6debasm88165575ad.65.2024.06.17.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:18:11 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v11 6/7] net: tn40xx: add mdio bus support
Date: Tue, 18 Jun 2024 14:16:07 +0900
Message-Id: <20240618051608.95208-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618051608.95208-1-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.h      |   4 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 142 ++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)
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
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 20b400e58ef9..4cbe0c3883c7 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -140,6 +140,8 @@ struct tn40_priv {
 	u32 b0_len;
 	dma_addr_t b0_dma; /* Physical address of buffer */
 	char *b0_va; /* Virtual address of buffer */
+
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -217,4 +219,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..af18615d64a8
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,142 @@
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
+	if (speed == TN40_MDIO_SPEED_1MHZ)
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
+static int tn40_mdio_wait_nobusy(struct tn40_priv *priv, u32 *val)
+{
+	u32 stat;
+	int ret;
+
+	ret = readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
+					TN40_GET_MDIO_BUSY(stat) == 0, 10,
+					10000);
+	if (val)
+		*val = stat;
+	return ret;
+}
+
+static int tn40_mdio_read(struct tn40_priv *priv, int port, int device,
+			  u16 regnum)
+{
+	void __iomem *regs = priv->regs;
+	u32 i;
+
+	/* wait until MDIO is not busy */
+	if (tn40_mdio_wait_nobusy(priv, NULL))
+		return -EIO;
+
+	i = TN40_MDIO_CMD_VAL(device, port);
+	writel(i, regs + TN40_REG_MDIO_CMD);
+	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
+	if (tn40_mdio_wait_nobusy(priv, NULL))
+		return -EIO;
+
+	writel(TN40_MDIO_CMD_READ | i, regs + TN40_REG_MDIO_CMD);
+	/* read CMD_STAT until not busy */
+	if (tn40_mdio_wait_nobusy(priv, NULL))
+		return -EIO;
+
+	return lower_16_bits(readl(regs + TN40_REG_MDIO_DATA));
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
+	if (tn40_mdio_wait_nobusy(priv, NULL))
+		return -EIO;
+	writel(TN40_MDIO_CMD_VAL(device, port), regs + TN40_REG_MDIO_CMD);
+	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
+	if (tn40_mdio_wait_nobusy(priv, NULL))
+		return -EIO;
+	writel((u32)data, regs + TN40_REG_MDIO_DATA);
+	/* read CMD_STAT until not busy */
+	ret = tn40_mdio_wait_nobusy(priv, &tmp_reg);
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
+static int tn40_mdio_read_c45(struct mii_bus *mii_bus, int addr, int devnum,
+			      int regnum)
+{
+	return tn40_mdio_read(mii_bus->priv, addr, devnum, regnum);
+}
+
+static int tn40_mdio_write_c45(struct mii_bus *mii_bus, int addr, int devnum,
+			       int regnum, u16 val)
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
+	bus->read_c45 = tn40_mdio_read_c45;
+	bus->write_c45 = tn40_mdio_write_c45;
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


