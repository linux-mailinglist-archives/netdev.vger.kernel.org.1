Return-Path: <netdev+bounces-94532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89448BFC82
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDE2813D0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C9824AC;
	Wed,  8 May 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUyvwbqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05862839FF
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168619; cv=none; b=GfvO1gkvhdC7i1yvLZPQBipVpMdX3uaLEXeShkTkJuM2tVS4sQU9LppU+NfcXvYjFrTUQL5m4im+YLDxytklO5K5Fjyo4OQ8zwRI8rHZej84CPicxFLLdf/0Cj85F6VkmUDBZk5CBIaqJBuksyCQ3HFFyZEtg84+djuHX8sZp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168619; c=relaxed/simple;
	bh=nmLdgGJZNrPNL6tCu33F5D6oIIERliRSlSq4r50/Ik4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EECRDMD2x/L4ORF1BAyM0CagZu37FWTuI7Dlwu+roY9/S27KUQgLhQnwiS8sXBB7rA6OhtULpTAJmNPGd7sah1OYk8htl/Vfg4wr1ExSe58cXt4hgg6Znet9K8rNLWnT2cKEtJBgsXaCMAs6j9T4sFAAXxXF6qy4qKvoXmIBaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUyvwbqR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b620b0662dso184994a91.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168617; x=1715773417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/dnvqI7+luja3NjtVyoBp6tDm8lCGJw8vL4e+YwZgU=;
        b=kUyvwbqR10k9dffrgV7v+sZwI0IFE/OTN520A8ksrxopo/Cx/Sp8p7Yl1uoTyeZxk4
         XhbPqtnerpz4+hpthJWnu86kYlRCahi/8R2WEWQZAjYCIPD1QjSCadCBRzL8XSfVOckd
         n6I99qcCZE16UQSKFa68v3X9Jlk/mo4Ckn/N3iBhE2R86hf1jq0V8z5kQGzG1CndKm44
         nqDP3OgWYuGk6IP0hSbTljg4YNPo+lywAZ9aflSGCX1FzmiqUV8CQ2S19eauvRDBBm3h
         dOR5MaxNWb4FZrvkn82a1Vp9jcowxf8oEivCIOLH6tx7ADbZWmX8DqvNylAKo5nwF0dU
         1Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168617; x=1715773417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/dnvqI7+luja3NjtVyoBp6tDm8lCGJw8vL4e+YwZgU=;
        b=dyUMlmx9J2ERVAe+562eW8Pn1vJKZiUnAhSzv7396CzXX24xkuz3UlttQimALlzWsI
         EAPwYuSsPh32BAyUZdynvJd/n3ubjhDKHGL/mS7EV4YpJkf58zr7lvjK8SoS1LMHTAwZ
         I6HHBGAa3+QuA5OgCR93Gjit5Kf/4BWHI4yM9Agll8Zc3uBzFGAPfTBqg744pN6mmX9J
         r9PXiFHTQ3VdSt2kGtt9p51vj1jI64rikXH23qmbn/erjg9YarjlT0rmh7guDGiAL5uu
         vi/VMv9ykxIOGQtFCxDXxE8Yv3BpmGkcJfjL9Ln1154L7S0OpmSwI1PQSBuvLtGasKuC
         TemQ==
X-Gm-Message-State: AOJu0YzbxbeJzeoS+h3eBE7f6lZoCshxmSqDWZ1mLi0zxgy4cbXnheMH
	nu2iUtBhiOK1C5moUqRA5uwLvwNAioyl5GPDmK5g5IXOdBlYP+FYRTgFnEb2
X-Google-Smtp-Source: AGHT+IGj+tt+I2W/SBaWv1F44JDWiKKdwEiCRpBNfLUs/tPgqzqICWnWyMaUKfW9c5KkZ62e2+mIfA==
X-Received: by 2002:a17:902:ea01:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1eeb089c302mr25172585ad.4.1715168617107;
        Wed, 08 May 2024 04:43:37 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e83a70d774sm11620938plg.187.2024.05.08.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:36 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com
Subject: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
Date: Wed,  8 May 2024 20:39:46 +0900
Message-Id: <20240508113947.68530-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508113947.68530-1-fujita.tomonori@gmail.com>
References: <20240508113947.68530-1-fujita.tomonori@gmail.com>
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
index b923ea58f2d4..07690c1d3f32 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1780,6 +1780,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 19bf1652b579..c9af2fa8faa1 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -160,6 +160,7 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct tn40_rx_page_table rx_page_table;
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -239,4 +240,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
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


