Return-Path: <netdev+bounces-92031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B88B504A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 06:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B314AB22562
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 04:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC9F4EE;
	Mon, 29 Apr 2024 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdZFdNqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1256EC2
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365588; cv=none; b=NfH3xran588KYI/f7eXO+/eyvH/ML3JZcLVNyF4t4m/Ih3CjRvxshK2x1Ff5QlUTpSoMPV4Ba7heNXllsUst9yUc3Z9I5cXZVr8k8FTmD07SrbJmn8cSWrlFcsRuKAtfHZnTRo2V8im/9YxjUNuJF1Ljyjrae5P7+SFEI9TAB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365588; c=relaxed/simple;
	bh=lIwfkCagAY0VddciEks0L9XG2231HuL5Tw3qGOFDzBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4+X9eB2Ar57oYfNMv1ZDD60zk2DaJDB43LRHcA3cDB90h2ooUKP7RhENAp4eh/jnR5X3hG3Jlc2IOlnZxFPEN+RUI70XqtAemqYxf39s0RJczyBVcIEXsp3eJC2PAn979EgqcbKYU4p180YmNahNAEzLapKvp+uRXe+ZvPClO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdZFdNqs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e832475ed1so968995ad.1
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 21:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365586; x=1714970386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MvsesFOQgpGQeA+0VeBg46Kb6308G0jC9V72Z16PD8=;
        b=YdZFdNqsebrEHvDNB/BIQvIDhdpY35q+tcLB0YDFTxPZWIrbHz4L9mlxxE2qU09qs9
         zUOdUgDbrufGyjhGAxyJDQd7FTfyEDqcTo2UPnzXw517Omg1osB+f63/RwMPKHD5d68h
         fbgpPwfKkiaHxXT/dDbySksYtBGoILmu+OjYJjhkDMTB3fk/XoHBvhKTrwYlduuv2suP
         7c6YFBnSEu5TX4VHef+eLR0L0mvueEuFg6SdutVuLbjy0Bi9nXrP6wSrFPDEYP0ZGVox
         4upsLT9Bx0SJzNCMIbHn51aiehVhOOHDTo6XyPoSHXSqcCJNYyxnmCHfNAi3gPMMg4r3
         vPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365586; x=1714970386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MvsesFOQgpGQeA+0VeBg46Kb6308G0jC9V72Z16PD8=;
        b=kjuQVS6CNXUTVeWZ7i49yhs2VDuee9yx1LNiTXFeabTnNAUrNa9jriwYjV4I1g6QCz
         XqN6Egna6+R0sxZTYoMI94IVFeGuyDQFpz2/LD0Z7Z7Xkdv+rRqXju1xRV939WR+yQuo
         ZGkSC9F4wpjprqySDHIHlLYG39hwCQWeAA5544BOQrvNKkctGiM6WLyAoT/qPeonEi9+
         CW/pDlT9jxsImVD3+volRPThg+gwR657k+XmkbV+vUvS8m1pMBnd3ENbrk35uttRwmXc
         b03kTTIXZTpsDXEPqXKwIIo+8pGQt4iB7cAnyCtgucjv1lZzvPa1CG/aWieC96nOP8BO
         FTcQ==
X-Gm-Message-State: AOJu0YwYPBTylckN2hAuB5as0u6ab+6P3bYxxwLzpgDqynQgNg+UmpUW
	BA/dNh8Ez01bGLAgjlM+fSudv1qQvI7ZpDr9KH5tFcHu1CTdna5W0p7eYA==
X-Google-Smtp-Source: AGHT+IFyXFuWkHgcVxXqodfs8Kpn9xWUXneLaLPLDGEKguVwo83D1sbcIKnU54nV6sQI4eoeBgwA6w==
X-Received: by 2002:a17:902:da83:b0:1dd:b54c:df51 with SMTP id j3-20020a170902da8300b001ddb54cdf51mr11679470plx.4.1714365585688;
        Sun, 28 Apr 2024 21:39:45 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm796129pls.13.2024.04.28.21.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:39:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v3 5/6] net: tn40xx: add mdio bus support
Date: Mon, 29 Apr 2024 13:38:26 +0900
Message-Id: <20240429043827.44407-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429043827.44407-1-fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.h      |   4 +
 drivers/net/ethernet/tehuti/tn40_mdio.c | 132 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 1 deletion(-)
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
index 791e07f6d718..c87ca150b583 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1771,6 +1771,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index a93b83e343d3..2719a31fe86c 100644
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
@@ -175,6 +176,7 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct tn40_rx_page_table rx_page_table;
+	struct mii_bus *mdio;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -261,4 +263,6 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_mdiobus_init(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
new file mode 100644
index 000000000000..df9258338572
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
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
+	int ret;
+
+	ret = readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
+					TN40_GET_MDIO_BUSY(stat) == 0, 10,
+					10000);
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


