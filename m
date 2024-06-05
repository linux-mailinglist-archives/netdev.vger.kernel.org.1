Return-Path: <netdev+bounces-101183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F7E8FDA78
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B007A285F10
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998D167D8E;
	Wed,  5 Jun 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ/hEhTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AC167D88
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630060; cv=none; b=GimQbGBj1rRQbjeBUDWkLocDJMdLscmYIo/lTmvjwcZdGaQPgEocxBcZL2FeCV/jubj+jmjKaKSOjJ1bvY4aZsTBQL4Qw1ENkZircaunsJ17GniulX+EYKdCmURctxzLRJAXD+/MTTcS2LZTl3KQe4XL7VzJeeXNLBjPpV7zzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630060; c=relaxed/simple;
	bh=9oT2+UqOuunVSDLyIpV0rUFhrVMy3DjAtUbXATY/Mus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeRwyQJQ4oqdUnrBtCcp5q60W8si4wr438gfbOKlgL0TItexxeb4OCZ8nBzCrEhRgEiIrGfZvRZdNgc9HO8pxgohb6SilrSKsZNAfIrYPe9BMpkxqKkXFrACwPJfas3xagTbO7Kmlf1GLAv85to5fkEgGIWx5zDI8PL31PlcTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ/hEhTP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so164065ab.3
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717630057; x=1718234857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QshOR171TKumizHD0H4FWgFPBvbiOfTCjxmswigCJc4=;
        b=kZ/hEhTPyG0tHfkNrm70QAvCssU3vGafzSCik1RzKsQp5X47YDTxUfZc5jlmyff0uK
         HMlzSelNUIWoiH9+PthQzuWm5ggLBEE27Bi+pSmTVO3ylW0kesbClhLiVpJa5cZaUjL6
         /wbsdypaVobiGifPPDFhmXAEEFhx58el/hM1ybWyAQmjcxQ1Fjk99dio2eHHK7wGl3L+
         Rao9joP5Mlj5J+k0dZtoBzd7O8YSmO0uhiRh2AlByLeCLTb7uu/aButpV1csrezZJXRn
         +93c03NN9CV6b3c9lnhx5OxwhfiUwgrbozRmN2O311Ce3pl0Yb42g4aPUyv6LKBz2ADZ
         Q+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630057; x=1718234857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QshOR171TKumizHD0H4FWgFPBvbiOfTCjxmswigCJc4=;
        b=Ane2cncVe+euRONLxz1CzmZ1JW//sDbHakxlmYmULaLJbDMNhUus7nmrKFJQa82nGr
         gP6jZIlhZeTurfCG5YT0iNhpqBTFhmVajStCibMzuSJKU6DBrQiKLFRNutFZtAIOJsUm
         1HiEIIMFtDMCpSZltyH3en7MaTxbNUKkq/FxAS6539xRJbad2FLA7xnmdg2kY5vLP24w
         L60qltO2Z0GUjeFisFdes+R2K9UCdOQdyrOkwWo/5X83ggF8XQ24Jjz5yaQUmER3V4o0
         VkPw4qMWcR9hZmMa+5b31LIutJ4Oy5R4oVsqWUK7MuKlz56LjKPliAoQVkPH4iZy4fiY
         C9aQ==
X-Gm-Message-State: AOJu0YyfmtV312L/4SjUJGaEwzu1N4fpPCBygV8WNVW9Jezw3jk0Db8s
	oExPG3qA+/7rep4lGBUiVwfKoAH/534zUWCh6lJAE2apQvwjVv57GwzAJvhX
X-Google-Smtp-Source: AGHT+IGFQ1eE0e8qIT7I6Mwihso4miYQ8iBZMmJx0ngvhx3TlkZvHeygMHojWw0zFoqF5WBMBFsUBw==
X-Received: by 2002:a05:6e02:178f:b0:374:60da:64dd with SMTP id e9e14a558f8ab-374b1ee27b1mr42746545ab.1.1717630057459;
        Wed, 05 Jun 2024 16:27:37 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm67725a12.94.2024.06.05.16.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:27:37 -0700 (PDT)
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
Subject: [PATCH net-next v9 5/6] net: tn40xx: add mdio bus support
Date: Thu,  6 Jun 2024 08:26:07 +0900
Message-Id: <20240605232608.65471-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605232608.65471-1-fujita.tomonori@gmail.com>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
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


