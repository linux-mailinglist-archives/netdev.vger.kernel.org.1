Return-Path: <netdev+bounces-92849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDD8B9204
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267CB1C209C2
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4216C43E;
	Wed,  1 May 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS8WJvqx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002116ABF7
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604872; cv=none; b=IyajffhKQzbr+nZLYhmCUUHoZ0em+myeZPaWAoPyK409WMkNYs3HcbQeHzxBslBJgFE2VLyCVPFi7YwNm4z6PA3x1urOTPiJJ/hUNhwraJrSVq0fR0SOMyZjUYIVPOQB5XCUimEBwtWqxgZuRmQDvrl5AJQGhKoyeTBnPtrDnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604872; c=relaxed/simple;
	bh=hh2xmj3yHb1+mAKxBclsCECp2efJ8yliMaEndxFrJPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=us8QHMuW9ir0mmoFz6HcBi5TAu6Pt9XCe3jGxMkrBQxMniigIJiXLkHvXvH4sMiKb81GJS/aPbjzljqwsEQsxOXV0eEjJlc4qHY1+8SugxhTLV1aPyPXQPMAzBv6Axl6Z2Xn9dX6yWJzCM5gMlir8cufHd+q90auPty7sW/S2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS8WJvqx; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5acf5723325so1847761eaf.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714604869; x=1715209669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMKIThqs8TY8bHnTqk+eYE5fB6Ktyld+avJqHXFBb4M=;
        b=GS8WJvqxSYeRxSd8tlU4TEYY8doYx/5Z7o5GOu6NH+YdIGNxBnd8Fa/xrTqqtzMes2
         X3gAazSNVQbnfY8Bs7FLpu9Tt606fXyfGLKaN/zhoIS5a0WNFUsILusUKowa1cMZINC0
         wRzXAjQXDmXHGXIdGyVvZWWDVpx+nVMdjsEiBeR73lZqJ0B5nOHcpPKPWWUqW3Fg2pzN
         7nC0yEGHP4hmx5I+LD3esTZltr+9DQV1GFObaTHSjNGTp/+R20K+Aqha+B9d6XRn5/C1
         PjrrGrcLrDm8Jwx52tgF+PMI1S+FM7sc1hnv6WDwuNpSzak3prM572ZyOARFxbmasKon
         pffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604869; x=1715209669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMKIThqs8TY8bHnTqk+eYE5fB6Ktyld+avJqHXFBb4M=;
        b=fHgdEIUpL5jq8Si0ITQQc4E26G4QL0nTlaE1P8MHQK9kOnJMlMdzeaEg3LQitalsma
         IhPvqKNEo+abWUoM6SBdeG2R2n5ulCDinQUUgft7B+XOu9ier2LL83eRrz08YbXVW+m7
         6+c10b6YN29bpYnYRqjD1GCm48aaiRKXzwW/b7MbWTUJvoaEWZmqDHNQnHmyz3XdwXo5
         LN40xB7z4uLYpdYQp3mJW4EaaQ6WZkfsZXfHOemrQktl7M0J0XLObFOb0cKxug/ajrR4
         UmpNOw2WMjsLep0XTKsD2wAwcXLxHieY2UM84lTaxVqDCh7rCNuRRJc+UYXtT6ZhnUNK
         QtqA==
X-Gm-Message-State: AOJu0YzJh7my9FLn1ry3PF4A/cf0IHkU+5ltVmhMXMfDD6h0bW08YDyM
	cvG1UioWSj8AyAbAKm2SiJ4+HYkP8Prf+6ro+bCjxEr8wDXbbgSWt0SC9DVJ
X-Google-Smtp-Source: AGHT+IG4ZLQvm2CgJSMG4vTJ4uHmkGzVOQUpOGVMkZwGrjk7xZanGW5ooLkBuM1yJVPSKGV8VJ00zg==
X-Received: by 2002:a05:6870:b14a:b0:22e:dfbc:4aae with SMTP id a10-20020a056870b14a00b0022edfbc4aaemr4494138oal.2.1714604869457;
        Wed, 01 May 2024 16:07:49 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm23819380pfb.170.2024.05.01.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:07:49 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v4 5/6] net: tn40xx: add mdio bus support
Date: Thu,  2 May 2024 08:05:51 +0900
Message-Id: <20240501230552.53185-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501230552.53185-1-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c      |   6 ++
 drivers/net/ethernet/tehuti/tn40.h      |   3 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 134 ++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 1 deletion(-)
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
index 6f9c5fc88d45..db1f781b8063 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1776,6 +1776,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index cbb7b80c66b1..ce991041caf9 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -160,6 +160,7 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct tn40_rx_page_table rx_page_table;
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -246,4 +247,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..64ef7f40f25d
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/phylink.h>
+
+#include "tn40.h"
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
+	i = ((device & 0x1F) | ((port & 0x1F) << 5));
+	writel(i, regs + TN40_REG_MDIO_CMD);
+	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
+	if (tn40_mdio_get(priv, NULL))
+		return -EIO;
+
+	writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);
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
+	writel(((device & 0x1F) | ((port & 0x1F) << 5)),
+	       regs + TN40_REG_MDIO_CMD);
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


