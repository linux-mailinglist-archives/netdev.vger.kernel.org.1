Return-Path: <netdev+bounces-98333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778128D0EB4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AE31F21898
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F07161306;
	Mon, 27 May 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd9FdNa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD5161B58
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842407; cv=none; b=grFxt8yEtrAJa1rmpnLulHVfJGTUa2gAoB1VWWV1aOsYGQ8s1gSWPrtoxWUaGb48eUZ5Wylq7vFLNOGGkem6VWg4dvjPj0iNYLXgH2lIj+6kBdgdzonyPpYdbhS25OTt6cbV9hu6qgsyOBduYQYhp5+iUfSg9lQHXYQfqzzyHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842407; c=relaxed/simple;
	bh=9oT2+UqOuunVSDLyIpV0rUFhrVMy3DjAtUbXATY/Mus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a42ih+/Gxxu/DJU0jx03pHL7EnLSkIzr8CuqQG8PTXvUCiwcAia3nJXB825pOBSk6fLki3aI6QbH39qug/dz2KKhHa/QKW0Sm5XvfV87GdpFUPOgQv9+aEdbAi2COKP+oDMLFc4Zt4Q/T20/vzdZ81QmEYct98wvJ8oynNeYlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd9FdNa1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bdd6b73a3aso17308a91.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842405; x=1717447205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QshOR171TKumizHD0H4FWgFPBvbiOfTCjxmswigCJc4=;
        b=Wd9FdNa12NDe/hBkK2pf4vX9U5kOlXuCKvMZTNKYq3LkT9IYHPmcZPkb1DDV3zqf1j
         G/LuKJw3GZKZzHDWK74ZygmQeUX8McOKe5xEI4vABQ4HiEuY7rJX/AcDmSbD81fogZMa
         Am/K8979zFRJ6M557B/7z09rIWqdp76O+2XnwtiuJ/qaV09BXuoWYd26qARuE/Ga1aBu
         W+ejGmteS3MKJ67fy28sQhcbozBCxntgFbpYPFOZ+ivetlz5v/pjv9lQd5a3DC0I0gQP
         kEMUmzj63gpvg0EvmXIxdNGR/WByeCu+iUeZ2mFS9IM8k2XiuR/YeOaESZVbwVMxOcGe
         yCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842405; x=1717447205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QshOR171TKumizHD0H4FWgFPBvbiOfTCjxmswigCJc4=;
        b=FTwYn4JWphCcvPyP8uVYYYACJiLwlK2TRz9hOzOKwAmRyQUuVnSaqMsQF/fU0PDXSd
         5OTPDvjhqyNds5kgZ4bdEoO+fAZNrmmOBPyhY6Ur87BXtkczPB9QnbS09LTzchAw9H8u
         oAecVMsgkXEHq184pxw92iKCxnlhmdRHmKiERBeY5FB6ibCwCtrkMDBeKQY6myWHRrlw
         B+ZsZeI6baJip676q6ZptkPQcUrXzuHkl5VyRz8wT5++UHQo30o5ixzERJ7wCGHSNxNl
         +hjLk4XsiW/Dm/6Plr+HehKT1g1pNOosc+M45l59aRp+jTXVv7K1dVouFFFD4cxs+z6P
         mdkA==
X-Gm-Message-State: AOJu0YwSSTqIPb6zJSjpzoIAnwACaSgQvvsVCtUGOx73A1p4dZjLCjTt
	BeLFTIj1k9tIvohTBTDwZ4WRPwmizr8fVXQ0gQmRHyIYnsGAOeOZKJ4bF15z
X-Google-Smtp-Source: AGHT+IEu0aaS+yHdnFEopMRzZ4eqwqlYwd6wDXY2ibZjb6KCIdkXe0v5lKYafFvsBaNMKb+oOEJ0Og==
X-Received: by 2002:a17:903:2347:b0:1f4:4618:8948 with SMTP id d9443c01a7336-1f4486eacc4mr123289135ad.2.1716842404911;
        Mon, 27 May 2024 13:40:04 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm26502925ad.164.2024.05.27.13.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:40:04 -0700 (PDT)
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
Subject: [PATCH net-next v7 5/6] net: tn40xx: add mdio bus support
Date: Tue, 28 May 2024 05:39:27 +0900
Message-Id: <20240527203928.38206-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203928.38206-1-fujita.tomonori@gmail.com>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40_mdio.c | 143 ++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
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
index afe85ce44d41..05a9adf9fe5a 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -141,6 +141,8 @@ struct tn40_priv {
 	u32 b0_len;
 	dma_addr_t b0_dma; /* Physical address of buffer */
 	char *b0_va; /* Virtual address of buffer */
+
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -218,4 +220,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..8a1f0c9f51b2
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,143 @@
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


