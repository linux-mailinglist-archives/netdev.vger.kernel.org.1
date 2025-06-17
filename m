Return-Path: <netdev+bounces-198489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655DCADC5F4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096D01897402
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB6292B40;
	Tue, 17 Jun 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTwpTzbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E620F088;
	Tue, 17 Jun 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151847; cv=none; b=TTtJ6ZwJ6kJ8gpNMYXbaUti/fnQXPxQZ33jF+yXCCBMctC5B3d/SrTnP3eM8fS/TJZs5Uogt3ywoNzTj57+HtlG44aGG9h+acUeAJAKVhPJsGYXwlf233j2xDhg6eRNZTeNw7C9h/Kjrkup/sniQ0wASFk2F0gov2xuBDuGEXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151847; c=relaxed/simple;
	bh=X2j90yRqeE3aKuyhk6ghNoBy9i0JVR8FllCgEfK/qt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMikQk3oep3Tq5L8Y7451033RrAILLVv/KX0vWpvbnBx1zo+JGb6/mLYnol6BjMCdJV0u7WrGjraS4eA8IX16mPb08Ulq7jL8NILKeqS3sAvkca6RfuwaudWBago+ADU33iXSpB5426BD2bhLxiIBEUw3Pb/PXM6JjrAeJEmja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTwpTzbj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so31890305e9.1;
        Tue, 17 Jun 2025 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750151843; x=1750756643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K+kVcoRIs8kNOYhjCZmLkdJECfCjOLZSTRWokWxaTY=;
        b=WTwpTzbjuWnlZR27JHvVHyJkzgIAWdIPRF0+NYpQhi6A2uoB/JcUGFef2Gnuz/elgY
         OtcsWSYtJvTA1WK+BWf3bp/04wDh+iKDUzMy46iupMgLFgVWKFeT6aSUfmpjRb7WMq8W
         V/1AFLVMPtv2q8dkjUPZirh35YU72W4tjWKxvbf1BmVkASSYJbJ2bkbgaBnQuBfxO2Oh
         G/oPQ8VuEWqSUFt88xuhp+J64MtYvBFJLTjc8khNqoZxeENrN6p814nVJ6WW6uaIj9TD
         FBoDJDUE0hm0YWTEEThd+CdCEATfVAhUO9tb7UJBpXOikvPbW52I+XkjLEm4HOUP6Nr+
         0nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151843; x=1750756643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K+kVcoRIs8kNOYhjCZmLkdJECfCjOLZSTRWokWxaTY=;
        b=dx8mnUIBQi5yyDsEB05j1khX0lgs7nvq6nthEJGvk5nwhF+4wIu7OwJD8zJ0uMIVws
         UvGmlXIe4gi51U4E7Q/fE19NiaQS+8/HGYB8t8E92ehqcCYOjEePsN+D2hXLKFP/PFaN
         vDW8MjIMzYAMOQlTVElCTgAZR123QiY3YizDrTWVhLopO1VWA7WmZt+wmxrKSeFOHy8d
         UfnQyrZHUF5oPcNXPejCtKooKbbBqb94beHGj70VBPxacejmrvowbw++6HDNRF49uFag
         TeRSh4kSAq2fUKOugOW/aAd3m36u/5x5kwS8OU00yWIiwCx04DWVSfRFOzVpQGiY6CUy
         UJkg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJWR0pco8EYqG37dA2DLK07zhj37UzKo97SdMAbn2Efjfh7mR+McA0M6RZhZoekD3lL7Z/L9i+1rf@vger.kernel.org, AJvYcCVGpBnc4flWXP77zdUZAMzNsc+wUCNfQ+vsJHstw3T2H8n83RmZ0Y8yGY18rYZjK6OAP9qrmQuK@vger.kernel.org, AJvYcCWJm0NlSeemelf+KrLS/A+wIKHIqa+iNHfPU+ZyM1EWl/d6/vAS3NeSn2uygBu9JX+DZ/RrC5KkzKaxRsPW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey/APOhtQKFf/r2RaVU63dxg9wqKFNP5+rLUHhmYdzW8dIf5+
	UizmrjPPGbdDFga2MHVY1rzofPoLCxdBdo/6WM0hqJ8OxEMnr6WBECjc
X-Gm-Gg: ASbGncsqty/JOK9/waliPC78rN3kWhpsD05NV5RnjXzZT8KHgB0s1Fnq+6ke7kBPJJY
	RW2rFAHlvls94oBQXop+3qQvpdpMDOvRB/p5xh+NxxEwjfilGpEOTbUfXf4NTsyH/sxyxWRKxj9
	GgODntiiT9lq8pFeh9TET0p7TwM5rvNEfG7L4UGeS+GjCZJQAR1/MeuLqOzoGNnzXscXIA7V/x9
	8I32fhdPgT8jsrq8MhID6j/rTGm77KwdADm1xtm4ThJvfVJ2UbOI8a3wcORVSQ7Rcfl4fmTtow1
	JE7VSoODhEquN7LryzClLItqrRuTXGj0n03wlYJhtzyvqb1yeGw3NY1GlRGd+1HCobhfJ7xfWnV
	Z/ZGha6UAwM4SmTINgZFSyLRZyDiY9HZIBsbae7Kriw==
X-Google-Smtp-Source: AGHT+IGhbIQRrw0vw5w664/4M83Ka3fyz5eJ/ovKqOtOsSM3NJFValxiLUg5kPvxg2cwgvzip62Chg==
X-Received: by 2002:a05:6000:2f84:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a57237c5bamr10308058f8f.25.1750151843144;
        Tue, 17 Jun 2025 02:17:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b74313sm13500439f8f.96.2025.06.17.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:17:22 -0700 (PDT)
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
Subject: [net-next PATCH v2 2/2] net: mdio: Add MDIO bus controller for Airoha AN7583
Date: Tue, 17 Jun 2025 11:16:53 +0200
Message-ID: <20250617091655.10832-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617091655.10832-1-ansuelsmth@gmail.com>
References: <20250617091655.10832-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7583 SoC have 2 dedicated MDIO bus controller in the SCU
register map. To driver register an MDIO controller based on the DT
reg property and access the register by accessing the parent syscon.

The MDIO bus logic is similar to the MT7530 internal MDIO bus but
deviates of some setting and some HW bug.

On Airoha AN7583 the MDIO clock is set to 25MHz by default and needs to
be correctly setup to 2.5MHz to correctly work (by setting the divisor
to 10x).

There seems to be Hardware bug where AN7583_MII_RWDATA
is not wiped in the context of unconnected PHY and the
previous read value is returned.

Example: (only one PHY on the BUS at 0x1f)
 - read at 0x1f report at 0x2 0x7500
 - read at 0x0 report 0x7500 on every address

To workaround this, we reset the Mdio BUS at every read
to have consistent values on read operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Out of RFC
- Drop fast mode register (it was reported that they are
  used for debug purpose)
- Connect actual clock to support clock-frequency tuning
- Adapt to DT schema changes
- Add and document found HW bug with spurious read on
  unconnected PHY

 drivers/net/mdio/Kconfig       |   7 +
 drivers/net/mdio/Makefile      |   1 +
 drivers/net/mdio/mdio-airoha.c | 276 +++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
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
index 000000000000..1dc9939c8d7d
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Airoha AN7583 MDIO interface driver
+ *
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/clk.h>
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
+/* MII address register definitions */
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
+
+#define AN7583_MII_MDIO_DELAY_USEC		100
+#define AN7583_MII_MDIO_RETRY_MSEC		100
+
+struct airoha_mdio_data {
+	u32 base_addr;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct reset_control *reset;
+};
+
+static int airoha_mdio_wait_busy(struct airoha_mdio_data *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->regmap, priv->base_addr, busy,
+					!(busy & AN7583_MII_BUSY),
+					AN7583_MII_MDIO_DELAY_USEC,
+					AN7583_MII_MDIO_RETRY_MSEC * USEC_PER_MSEC);
+}
+
+static void airoha_mdio_reset(struct airoha_mdio_data *priv)
+{
+	/* There seems to be Hardware bug where AN7583_MII_RWDATA
+	 * is not wiped in the context of unconnected PHY and the
+	 * previous read value is returned.
+	 *
+	 * Example: (only one PHY on the BUS at 0x1f)
+	 *  - read at 0x1f report at 0x2 0x7500
+	 *  - read at 0x0 report 0x7500 on every address
+	 *
+	 * To workaround this, we reset the Mdio BUS at every read
+	 * to have consistent values on read operation.
+	 */
+	reset_control_assert(priv->reset);
+	reset_control_deassert(priv->reset);
+}
+
+static int airoha_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct airoha_mdio_data *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	airoha_mdio_reset(priv);
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
+	airoha_mdio_reset(priv);
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
+	u32 addr, freq;
+	int ret;
+
+	ret = of_property_read_u32(dev->of_node, "reg", &addr);
+	if (ret)
+		return ret;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+	priv->base_addr = addr;
+	priv->regmap = device_node_to_regmap(dev->parent->of_node);
+
+	priv->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	reset_control_deassert(priv->reset);
+
+	bus->name = "airoha_mdio_bus";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
+	bus->parent = dev;
+	bus->read = airoha_mdio_read;
+	bus->write = airoha_mdio_write;
+	bus->read_c45 = airoha_mdio_cl45_read;
+	bus->write_c45 = airoha_mdio_cl45_write;
+
+	/* Check if a custom frequency is defined in DT or default to 2.5 MHz */
+	if (of_property_read_u32(dev->of_node, "clock-frequency", &freq))
+		freq = 2500000;
+
+	ret = clk_set_rate(priv->clk, freq);
+	if (ret)
+		return ret;
+
+	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
+	if (ret) {
+		reset_control_assert(priv->reset);
+		return ret;
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


