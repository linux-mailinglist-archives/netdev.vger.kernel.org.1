Return-Path: <netdev+bounces-193759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1675CAC5C40
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62854A19DA
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FA214A91;
	Tue, 27 May 2025 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqmSh5cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1C20E00C;
	Tue, 27 May 2025 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381735; cv=none; b=Nix6OJ3epT5vC79AHRtKIUYgjLU6M905ZSpaqLxRYcl/yOJhxM7upM0PoCY/pNDCKqn3TVXq54hqEURy1flxNfmpDjKLnIFHT9bH9ABJumDvxIJkwWfi0WkT6sLQcJd4e5/CgvKitdHoD338Fra4CXiEtCsZtPqzuvTjiJGZRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381735; c=relaxed/simple;
	bh=azdU8zFbYTPN14qTCD6L46rGqWVBJH66BpgjaOuYkOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkLnKNzHmQjT7HkNwDXtGnNJnKObwpqg4Gn6bEWIJ+ZgjOIVPD5kEYAN27oFY8bmL3lVlkk2KJy+0tUPXZgSfw5E/STsWt9iIp2tuHeSicni5LjjXPXp1a2Ve4fvSM4LAlDMAReWoeYe0HUoH+WOfW/kNz2ZPU5CVPm1lMVIyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqmSh5cz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so49566725e9.3;
        Tue, 27 May 2025 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381732; x=1748986532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtWDaPY7KILMZDdEKWMsuXfHsya3TaBkd0+i/kLxSMM=;
        b=eqmSh5cz3FSA7zwSawFqI5hKOUCP1u42QEU527QGh/hTBYAwDOS1Okyk5+Tsyw5lWe
         6wyHTSp7runybb34TQK++wbyEbGChgFg3uFBp6DKnK+pE287SPXzoejuU2YveCEVWblA
         UzZIStQDn/nYvrCimQzY4I5QY4HbpfKzFVutoY9oEbTYsbj3PTUKDS2tj1aOXfkdHxX4
         GLyGbgcEksxEcfN8mVWaTTP+POXwn7SL29VHW4KLHrB/gp2rldyKARGhtVTstyQK6eyz
         vhXh8B3iBoe2iNjnlqfgEMvWr2DTK9xcKl1570XuQJZ23xwfCGLpivguH0nx31uRdxdf
         0eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381732; x=1748986532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtWDaPY7KILMZDdEKWMsuXfHsya3TaBkd0+i/kLxSMM=;
        b=J2E/jc37U38R2/XkpNcoLVng7ov6/ps7/FCAyXwkB2OmqLn+C6OBEK8ICV6tGYpdyQ
         Dyisq3C35lnB8iIRt62S3T22QXaBjQ4wznhNQGRX+JhVs/1/XZrB1/M1MKq1WtKSJd0x
         2CUQP0djDMv/FKBq8RhLVlnNIXL17KJc2+EUMPu9TchGznWIgUMR5uCaDB/XCcc/0/Oz
         bDQST5m+eYVvOcCnwM0Lg5DFfzgm6SE9RvM5F4HernNSc9W4THC+MlpBgS0EB0ffhkz2
         Y7YnnNzqrIPNgcOoKEYW/m9b7cSqre0dsJ/rArbbvnJzw0la4nxMMDpbWj157RivILqe
         CdRw==
X-Forwarded-Encrypted: i=1; AJvYcCUHHEG+OtikKdAoSFQPE0mjpra2dXOCCjVhQZqDPMVGLfU+zXuZlDIK4oV7clHsTdoNZMlOIER2N+tnoVwE@vger.kernel.org, AJvYcCVAYOLQwXsV0t7ukbqO+GPKvVvQhQ5XQBuEKPxvdowEE2RGXYkeSbi9Jc4W5IregQGoFdZR3p/4@vger.kernel.org, AJvYcCXCD8Iz13YJyt7LFJGWHpVH/9QzovypJAl3zlM/t2oS1Jgd55EmekI0Y8jnW2enfmrAU/2hUSAkkk+H@vger.kernel.org
X-Gm-Message-State: AOJu0YymaPGFsEfIuWPq0MCP77a1NHy66nnz0FBxLyaEpoHr4clOEKtM
	U3zlgD5/uHP0l1klf1YlA+CtbuQ9bH/cbQDC6Qt+Fa1+Lp7chN6Hvbta
X-Gm-Gg: ASbGncsRcFzw4MCFP8L8vjQJdps0GNB6iUp5Hd1bJvx5bedFQcmnrRiWP0GPhAlE/2X
	BKsMoDsbxVpTvTxfQ3xmt9PbbzvnuVx1nZjyPJi8uUfswKyxcd+eJoMut5aGV+Aw1pYTTPgx+FT
	iAsOShtCnx+Vyj3ECGjdD/9um1jiBkltkpaK1+EaFYmoTld6xw3QL9Ax6dzGRz6G/t3xCxb97Ag
	ZU9LRRVrtvFiPWaFifZKblFvyowPGqJE3AlGa2Pmdan5DNvVKu+DTkG+YksrMMeyn0c8p9PK6Zh
	MQlUxp2U3NarnbOvHd8HFkcT9bWwasI59HgF1JJTgd1L+PgIv6EL+Vsd3+m3kaClITuUDeasdmu
	vsw5+iS4+995Z5Sbi/Cgx/mFAN441xc8=
X-Google-Smtp-Source: AGHT+IF1nLnZmIQtlHnHGtvHpHsT5EiPGa70EufdAJk+qgT6jSbYqPQjyN/+Uxe8efN0c1mfDqKUWg==
X-Received: by 2002:a05:600c:3490:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-44c9484582amr140450305e9.18.1748381731782;
        Tue, 27 May 2025 14:35:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b9a7adsm165671f8f.57.2025.05.27.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:35:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 2/2] net: mdio: Add MDIO bus controller for Airoha AN7583
Date: Tue, 27 May 2025 23:34:43 +0200
Message-ID: <20250527213503.12010-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527213503.12010-1-ansuelsmth@gmail.com>
References: <20250527213503.12010-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7583 SoC have 2 dedicated MDIO bus controller in the SCU
register map. To driver expose the 2 MDIO controller based on the DT
node and access the register by accessing the parent syscon.

The MDIO bus logic is similar to the MT7530 internal MDIO bus but
deviates of some setting to enable MDIO fast mode and some difference
for CL45 handling.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/Kconfig       |   7 +
 drivers/net/mdio/Makefile      |   1 +
 drivers/net/mdio/mdio-airoha.c | 275 +++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-airoha.c

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 7db40aaa079d..e1e32b687068 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -27,6 +27,13 @@ config ACPI_MDIO
 	help
 	  ACPI MDIO bus (Ethernet PHY) accessors
 
+config MDIO_AIROHA
+	tristate "Airoha AN7583 MDIO bus controller"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	help
+	  This module provides a driver for the MDIO busses found in the
+	  Airoha AN7583 SoC's.
+
 config MDIO_SUN4I
 	tristate "Allwinner sun4i MDIO interface support"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index c23778e73890..fbec636700e7 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ACPI_MDIO)		+= acpi_mdio.o
 obj-$(CONFIG_FWNODE_MDIO)	+= fwnode_mdio.o
 obj-$(CONFIG_OF_MDIO)		+= of_mdio.o
 
+obj-$(CONFIG_MDIO_AIROHA)		+= mdio-airoha.o
 obj-$(CONFIG_MDIO_ASPEED)		+= mdio-aspeed.o
 obj-$(CONFIG_MDIO_BCM_IPROC)		+= mdio-bcm-iproc.o
 obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
new file mode 100644
index 000000000000..a30081f6141a
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Airoha AN7583 MDIO interface driver
+ *
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define AN7583_MAX_MDIO_BUS			2
+
+/* MII address register definitions */
+#define AN7583_MDIO0_ADDR			0xc8
+#define AN7583_MDIO1_ADDR			0xcc
+#define   AN7583_MII_BUSY			BIT(31)
+#define   AN7583_MII_RDY			BIT(30) /* RO signal BUS is ready */
+#define   AN7583_MII_CL22_REG_ADDR		GENMASK(29, 25)
+#define   AN7583_MII_CL45_DEV_ADDR		AN7583_MII_CL22_REG_ADDR
+#define   AN7583_MII_PHY_ADDR			GENMASK(24, 20)
+#define   AN7583_MII_CMD			GENMASK(19, 18)
+#define   AN7583_MII_CMD_CL22_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL22_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_ADDR		FIELD_PREP_CONST(AN7583_MII_CMD, 0x0)
+#define   AN7583_MII_CMD_CL45_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL45_POSTREAD_INCADDR	FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x3)
+#define   AN7583_MII_ST				GENMASK(17, 16)
+#define   AN7583_MII_ST_CL45			FIELD_PREP_CONST(AN7583_MII_ST, 0x0)
+#define   AN7583_MII_ST_CL22			FIELD_PREP_CONST(AN7583_MII_ST, 0x1)
+#define   AN7583_MII_RWDATA			GENMASK(15, 0)
+#define   AN7583_MII_CL45_REG_ADDR		AN7583_MII_RWDATA
+#define AN7583_MDIO_PHY				0xd4
+#define   AN7583_MDIO1_SPEED_MODE		BIT(11)
+#define   AN7583_MDIO0_SPEED_MODE		BIT(10)
+
+#define AN7583_MII_MDIO_DELAY_USEC		100
+#define AN7583_MII_MDIO_RETRY_MSEC		100
+
+static const u32 airoha_mdio_bus_base_addrs[] = {
+	AN7583_MDIO0_ADDR,
+	AN7583_MDIO1_ADDR,
+};
+
+static const u32 airoha_mdio_bus_speed_mode[] = {
+	AN7583_MDIO0_SPEED_MODE,
+	AN7583_MDIO1_SPEED_MODE,
+};
+
+struct airoha_mdio_data {
+	u32 base_addr;
+	struct regmap *regmap;
+	struct reset_control *reset;
+};
+
+static int
+airoha_mdio_wait_busy(struct airoha_mdio_data *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->regmap, priv->base_addr, busy,
+					!(busy & AN7583_MII_BUSY),
+					AN7583_MII_MDIO_DELAY_USEC,
+					AN7583_MII_MDIO_RETRY_MSEC * USEC_PER_MSEC);
+}
+
+static int airoha_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct airoha_mdio_data *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL22 |
+	      AN7583_MII_CMD_CL22_READ;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, priv->base_addr, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AN7583_MII_RWDATA, val);
+}
+
+static int airoha_mdio_write(struct mii_bus *bus, int addr, int regnum,
+			     u16 value)
+{
+	struct airoha_mdio_data *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL22 |
+	      AN7583_MII_CMD_CL22_WRITE;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	val |= FIELD_PREP(AN7583_MII_RWDATA, value);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+
+	return ret;
+}
+
+static int airoha_mdio_cl45_read(struct mii_bus *bus, int addr, int devnum,
+				 int regnum)
+{
+	struct airoha_mdio_data *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+	      AN7583_MII_CMD_CL45_ADDR;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+	      AN7583_MII_CMD_CL45_READ;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, priv->base_addr, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AN7583_MII_RWDATA, val);
+}
+
+static int airoha_mdio_cl45_write(struct mii_bus *bus, int addr, int devnum,
+				  int regnum, u16 value)
+{
+	struct airoha_mdio_data *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+	      AN7583_MII_CMD_CL45_ADDR;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+	      AN7583_MII_CMD_CL45_WRITE;
+	val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	val |= FIELD_PREP(AN7583_MII_RWDATA, value);
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+
+	return ret;
+}
+
+static int airoha_mdio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_mdio_data *priv;
+	struct mii_bus *bus;
+	int ret;
+
+	if (of_get_child_count(dev->of_node) > AN7583_MAX_MDIO_BUS)
+		return -EINVAL;
+
+	for_each_child_of_node_scoped(dev->of_node, child) {
+		u32 id;
+
+		ret = of_property_read_u32(child, "reg", &id);
+		if (ret)
+			return ret;
+
+		if (id > AN7583_MAX_MDIO_BUS)
+			return -EINVAL;
+
+		bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+		if (!bus)
+			return -ENOMEM;
+
+		priv = bus->priv;
+		priv->base_addr = airoha_mdio_bus_base_addrs[id];
+		priv->regmap = device_node_to_regmap(dev->parent->of_node);
+		priv->reset = devm_reset_control_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(priv->reset))
+			return PTR_ERR(priv->reset);
+
+		reset_control_deassert(priv->reset);
+
+		bus->name = "airoha_mdio_bus";
+		snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d-mii",
+			 dev_name(dev), id);
+		bus->parent = dev;
+		bus->read = airoha_mdio_read;
+		bus->write = airoha_mdio_write;
+		bus->read_c45 = airoha_mdio_cl45_read;
+		bus->write_c45 = airoha_mdio_cl45_write;
+
+		ret = devm_of_mdiobus_register(dev, bus, child);
+		if (ret) {
+			reset_control_assert(priv->reset);
+			return ret;
+		}
+
+		ret = regmap_set_bits(priv->regmap, AN7583_MDIO_PHY,
+				      airoha_mdio_bus_speed_mode[id]);
+		if (ret) {
+			reset_control_assert(priv->reset);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id airoha_mdio_dt_ids[] = {
+	{ .compatible = "airoha,an7583-mdio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, airoha_mdio_dt_ids);
+
+static struct platform_driver airoha_mdio_driver = {
+	.probe = airoha_mdio_probe,
+	.driver = {
+		.name = "airoha-mdio",
+		.of_match_table = airoha_mdio_dt_ids,
+	},
+};
+
+module_platform_driver(airoha_mdio_driver);
+
+MODULE_DESCRIPTION("Airoha AN7583 MDIO interface driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.48.1


