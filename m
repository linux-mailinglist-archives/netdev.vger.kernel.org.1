Return-Path: <netdev+bounces-173340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E63A5862D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1D37A2AF1
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE82135AA;
	Sun,  9 Mar 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNXBvwSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAA213223;
	Sun,  9 Mar 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541289; cv=none; b=dJrwqT9P5blRHYZJ6AnRe38hIL9IVIqC6vE1d+Q4Um7Mcmb21uw6Y9207ohkouKfBYj/+mDB9tPmJwBfW3UO0uwo9B0835gpkcLtkbm5aI8FhZFGVe0PE8BhQQLPqZp6qqEJ0ynftCaQ9iXPW/ymKsOzFWNi5feiEk7G6IKiRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541289; c=relaxed/simple;
	bh=74vEbxd0nUPZRIkwuO0siZ5uCQU+hbTpBRWHKcYWuDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIB3zhC/iHKCKqwUqGOuu0ahblq1zvUOlN5++j0CqWsqvbLZcTqHqibIxONs4k/P99KNtYwntC7zwqXadGlvzxX6c/de+p4ZOfmqBbzyqHi4dj7LB2k2KKW3t/3wfEaDgBShu0LBG5frbUd9vDnVHooKVTIR9hqa5RUnsWdfXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNXBvwSh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so19926095e9.3;
        Sun, 09 Mar 2025 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541285; x=1742146085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbbhunkaODe4Ier9KtS4Ta62R51zKBU888CwhnoW5OY=;
        b=NNXBvwShPqWHVovMEbIyh/kP/ADHTgozA4N7fuVcwvBmFVqKrJ0B3YdTP5FishIykC
         wK3OZxEUJvmg8nGgsvOtsNfp5677yFHyvTfOw0kMsdULoSiwB/sRRO7F2hYvmfPveei2
         DTbG5MKUC3W4DEzO11qUSvD3H04LKWt7KVXBu4OfVUfrAUTH208YmraSw4AkxIAeoSDn
         7vjByXT4wB9Pxz1i5y/Fbq4lHn+ZjCBXEGrP05nRzVrhJRhe+FwPLbLFIrCm6QDXtx23
         10NepAIoQXquXc8gH7S/gieiotMDa4ByjkvPFmsSVA1B+8+QCW8EJXpKyVg1cZwEB6pO
         Rg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541285; x=1742146085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbbhunkaODe4Ier9KtS4Ta62R51zKBU888CwhnoW5OY=;
        b=wD7FLLJL1/bfww56ZuJnqW+2CDXKXlMszU6SxJ42n2nG75CKGCUtIV/HzzKkDpID/L
         815rBiDhTp9RLGbpAFNE6281myqn17xiUe/sXlAhbkzq6+HP0v52xNBn/AlJ3kRq8W+3
         lvIfnfcrJROX50NeY0ycWujf+wHjDygwkywVqoWyf27z1B2bd+ovA67ULHxmYH20YrEr
         pDVKcACFCMeWpwAPDIjLqSi1drBxvxdXxZVWlkWIKazsTzfYrgrPyCpY4baOyGD2EaaW
         skKUZtq9Ds+LyF3UuRIgCHGyzzyQMRQgfkD2c9ojjznhGil1wleZV36KQ/9NXVZ52l28
         oZgg==
X-Forwarded-Encrypted: i=1; AJvYcCUFOklVaYQVtSoxSsbbyspXuTuLENT6qC8Dj/Fx6W44hb7X/mdSjk+2GhtDPaU4pdNY0wAQjkwW3RbW9cg0@vger.kernel.org, AJvYcCVEejUAfLgbxRC4l5wwh55vrChCyIKvDwNIIcmJ63cir+mbqGcpc5p+dJBInHQaVoeqCC3Vy1XQ@vger.kernel.org, AJvYcCXwNIJ1wS07H/0siQkDc/HWRzlZJVbCBb4cTag+gkGOzKcz+Fkl2MJ38Tw7zdbcXX5R4E9tcqNul4OY@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAomBenoKrirpXWKh5b6+j8MnCbvkuHKpjBoP0pVntU4jAVaf
	H6De6eXonw77fNr3Y/+k3vBl9jkO/JzKmI24ChKXo5IDDNOQmMhW
X-Gm-Gg: ASbGncszXJ0G0dbNo86bJ4bGKa0a0v5awDXS5ccwPUeLkJdpSWHFZhTuE4QbEBv0Lei
	aOsXF0rzHWwBt+Kd+0go2VIUwn6sSIpV1B3gDIGQub+tZjq0MdxYhS6OLfGxMEg1DpZP7a7t8bI
	U1VQAjZ4oQRm3Ar5UM4WesiaDajeu9osd43PbZ7t30UQHD8i0XvnjEsDVVS5onE4Kowoguv0sA8
	x3khU9+7j/did5BldsG0GJGp5Mn0rIc6BJJMvKvicVtfd2jleRcYBuYZDy4OxW/eUVIv4Fkqh4m
	rEX20jwqKzY6fs8sMSI4FfcN8XvZjNBvOja0LqHILKgev0PaxY90BKL4+g81fwsBKVdchRukjKO
	oNPNJzUosbq9iFyLo6Ho/wV9m
X-Google-Smtp-Source: AGHT+IEupyYZFvDu9b6/KIPRa/IaVO/xgw3UOpaIoSf0EiRjRtw0X7JJVIV9cZsDcER4eQhQi08Chg==
X-Received: by 2002:a05:600c:a3a1:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43ce47808eamr45424795e9.0.1741541284373;
        Sun, 09 Mar 2025 10:28:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:28:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 09/13] mfd: an8855: Add support for Airoha AN8855 Switch MFD
Date: Sun,  9 Mar 2025 18:26:54 +0100
Message-ID: <20250309172717.9067-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN8855 Switch MFD that provide support for a DSA
switch and a NVMEM provider. Also provide support for a virtual MDIO
passthrough as the PHYs address for the switch are shared with the switch
address.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                 |   1 +
 drivers/mfd/Kconfig         |  10 +
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/airoha-an8855.c | 445 ++++++++++++++++++++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 drivers/mfd/airoha-an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b7075425c94e..5844addbda2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -730,6 +730,7 @@ F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32..1b5abe5e2694 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -53,6 +53,16 @@ config MFD_ALTERA_SYSMGR
 	  using regmap_mmio accesses for ARM32 parts and SMC calls to
 	  EL3 for ARM64 parts.
 
+config MFD_AIROHA_AN8855
+	tristate "Airoha AN8855 Switch MFD"
+	select MFD_CORE
+	select MDIO_DEVICE
+	depends on NETDEVICES && OF
+	help
+	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
+	  that provides various peripherals. Currently it provides a
+	  DSA switch and a NVMEM provider.
+
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf12..37677f65a981 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
+obj-$(CONFIG_MFD_AIROHA_AN8855)	+= airoha-an8855.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
new file mode 100644
index 000000000000..0a6440bd4118
--- /dev/null
+++ b/drivers/mfd/airoha-an8855.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD driver for Airoha AN8855 Switch
+ */
+
+#include <linux/bitfield.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/core.h>
+#include <linux/mdio.h>
+#include <linux/mdio/mdio-regmap.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+
+/* Register for hw trap status */
+#define AN8855_HWTRAP			0x1000009c
+
+#define AN8855_CREV			0x10005000
+#define   AN8855_ID			0x8855
+
+#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
+
+/* MII Registers */
+#define AN8855_PHY_SELECT_PAGE		0x1f
+#define   AN8855_PHY_PAGE		GENMASK(2, 0)
+#define   AN8855_PHY_PAGE_STANDARD	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
+#define   AN8855_PHY_PAGE_EXTENDED_1	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
+#define   AN8855_PHY_PAGE_EXTENDED_4	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x4)
+
+/* MII Registers Page 4 */
+#define AN8855_PBUS_MODE		0x10
+#define   AN8855_PBUS_MODE_ADDR_FIXED	0x0
+#define AN8855_PBUS_MODE_ADDR_INCR	BIT(15)
+#define AN8855_PBUS_WR_ADDR_HIGH	0x11
+#define AN8855_PBUS_WR_ADDR_LOW		0x12
+#define AN8855_PBUS_WR_DATA_HIGH	0x13
+#define AN8855_PBUS_WR_DATA_LOW		0x14
+#define AN8855_PBUS_RD_ADDR_HIGH	0x15
+#define AN8855_PBUS_RD_ADDR_LOW		0x16
+#define AN8855_PBUS_RD_DATA_HIGH	0x17
+#define AN8855_PBUS_RD_DATA_LOW		0x18
+
+struct an8855_mfd_priv {
+	struct mii_bus *bus;
+
+	unsigned int switch_addr;
+	u16 current_page;
+};
+
+static const struct mfd_cell an8855_mfd_devs[] = {
+	{
+		.name = "an8855-efuse",
+		.of_compatible = "airoha,an8855-efuse",
+	}, {
+		.name = "an8855-switch",
+		.of_compatible = "airoha,an8855-switch",
+	}, {
+		.name = "an8855-mdio",
+		.of_compatible = "airoha,an8855-mdio",
+	}
+};
+
+static int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
+			       u8 page) __must_hold(&priv->bus->mdio_lock)
+{
+	struct mii_bus *bus = priv->bus;
+	int ret;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
+	if (ret < 0)
+		dev_err_ratelimited(&bus->dev,
+				    "failed to set an8855 mii page\n");
+
+	/* Cache current page if next mii read/write is for switch */
+	priv->current_page = page;
+	return ret < 0 ? ret : 0;
+}
+
+static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
+			     u32 *val) __must_hold(&bus->mdio_lock)
+{
+	int lo, hi, ret;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
+			      AN8855_PBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_HIGH,
+			      upper_16_bits(reg));
+	if (ret < 0)
+		goto err;
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_LOW,
+			      lower_16_bits(reg));
+	if (ret < 0)
+		goto err;
+
+	hi = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_HIGH);
+	if (hi < 0) {
+		ret = hi;
+		goto err;
+	}
+	lo = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_LOW);
+	if (lo < 0) {
+		ret = lo;
+		goto err;
+	}
+
+	*val = ((u16)hi << 16) | ((u16)lo & 0xffff);
+
+	return 0;
+err:
+	dev_err_ratelimited(&bus->dev,
+			    "failed to read an8855 register\n");
+	return ret;
+}
+
+static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
+{
+	struct an8855_mfd_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 addr = priv->switch_addr;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_read32(bus, addr, reg, val);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg,
+			      u32 val) __must_hold(&bus->mdio_lock)
+{
+	int ret;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
+			      AN8855_PBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_HIGH,
+			      upper_16_bits(reg));
+	if (ret < 0)
+		goto err;
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_LOW,
+			      lower_16_bits(reg));
+	if (ret < 0)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_HIGH,
+			      upper_16_bits(val));
+	if (ret < 0)
+		goto err;
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_LOW,
+			      lower_16_bits(val));
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	dev_err_ratelimited(&bus->dev,
+			    "failed to write an8855 register\n");
+	return ret;
+}
+
+static int an8855_regmap_write(void *ctx, uint32_t reg, uint32_t val)
+{
+	struct an8855_mfd_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 addr = priv->switch_addr;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_write32(bus, addr, reg, val);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int an8855_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask,
+				     uint32_t write_val)
+{
+	struct an8855_mfd_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 addr = priv->switch_addr;
+	u32 val;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_read32(bus, addr, reg, &val);
+	if (ret < 0)
+		goto exit;
+
+	val &= ~mask;
+	val |= write_val;
+	ret = an8855_mii_write32(bus, addr, reg, val);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static const struct regmap_range an8855_readable_ranges[] = {
+	regmap_reg_range(0x10000000, 0x10000fff), /* SCU */
+	regmap_reg_range(0x10001000, 0x10001fff), /* RBUS */
+	regmap_reg_range(0x10002000, 0x10002fff), /* MCU */
+	regmap_reg_range(0x10005000, 0x10005fff), /* SYS SCU */
+	regmap_reg_range(0x10007000, 0x10007fff), /* I2C Slave */
+	regmap_reg_range(0x10008000, 0x10008fff), /* I2C Master */
+	regmap_reg_range(0x10009000, 0x10009fff), /* PDMA */
+	regmap_reg_range(0x1000a100, 0x1000a2ff), /* General Purpose Timer */
+	regmap_reg_range(0x1000a200, 0x1000a2ff), /* GPU timer */
+	regmap_reg_range(0x1000a300, 0x1000a3ff), /* GPIO */
+	regmap_reg_range(0x1000a400, 0x1000a5ff), /* EFUSE */
+	regmap_reg_range(0x1000c000, 0x1000cfff), /* GDMP CSR */
+	regmap_reg_range(0x10010000, 0x1001ffff), /* GDMP SRAM */
+	regmap_reg_range(0x10200000, 0x10203fff), /* Switch - ARL Global */
+	regmap_reg_range(0x10204000, 0x10207fff), /* Switch - BMU */
+	regmap_reg_range(0x10208000, 0x1020bfff), /* Switch - ARL Port */
+	regmap_reg_range(0x1020c000, 0x1020cfff), /* Switch - SCH */
+	regmap_reg_range(0x10210000, 0x10213fff), /* Switch - MAC */
+	regmap_reg_range(0x10214000, 0x10217fff), /* Switch - MIB */
+	regmap_reg_range(0x10218000, 0x1021bfff), /* Switch - Port Control */
+	regmap_reg_range(0x1021c000, 0x1021ffff), /* Switch - TOP */
+	regmap_reg_range(0x10220000, 0x1022ffff), /* SerDes */
+	regmap_reg_range(0x10286000, 0x10286fff), /* RG Batcher */
+	regmap_reg_range(0x1028c000, 0x1028ffff), /* ETHER_SYS */
+	regmap_reg_range(0x30000000, 0x37ffffff), /* I2C EEPROM */
+	regmap_reg_range(0x38000000, 0x3fffffff), /* BOOT_ROM */
+	regmap_reg_range(0xa0000000, 0xbfffffff), /* GPHY */
+};
+
+static const struct regmap_access_table an8855_readable_table = {
+	.yes_ranges = an8855_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(an8855_readable_ranges),
+};
+
+static const struct regmap_config an8855_regmap_config = {
+	.name = "switch",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0xbfffffff,
+	.reg_read = an8855_regmap_read,
+	.reg_write = an8855_regmap_write,
+	.reg_update_bits = an8855_regmap_update_bits,
+	.disable_locking = true,
+	.rd_table = &an8855_readable_table,
+};
+
+static int an855_regmap_phy_reset_page(struct an8855_mfd_priv *priv,
+				       int phy) __must_hold(&priv->bus->mdio_lock)
+{
+	/* Check PHY page only for addr shared with switch */
+	if (phy != priv->switch_addr)
+		return 0;
+
+	/* Don't restore page if it's not set to switch page */
+	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
+					    AN8855_PHY_PAGE_EXTENDED_4))
+		return 0;
+
+	/* Restore page to 0, PHY might change page right after but that
+	 * will be ignored as it won't be a switch page.
+	 */
+	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
+}
+
+static int an8855_regmap_phy_read(void *ctx, uint32_t reg, uint32_t *val)
+{
+	struct an8855_mfd_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 phy_id, addr;
+	int ret;
+
+	phy_id = FIELD_GET(MDIO_REGMAP_PHY_ADDR, reg);
+	addr = FIELD_GET(MDIO_REGMAP_PHY_REG, reg);
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an855_regmap_phy_reset_page(priv, phy_id);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_read(priv->bus, phy_id, addr);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return 0;
+}
+
+static int an8855_regmap_phy_write(void *ctx, uint32_t reg, uint32_t val)
+{
+	struct an8855_mfd_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 phy_id, addr;
+	int ret;
+
+	phy_id = FIELD_GET(MDIO_REGMAP_PHY_ADDR, reg);
+	addr = FIELD_GET(MDIO_REGMAP_PHY_REG, reg);
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an855_regmap_phy_reset_page(priv, phy_id);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_write(priv->bus, phy_id, addr, val);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret;
+}
+
+/* Regmap for MDIO Passtrough
+ * PHY Addr and PHY Reg are encoded in the regmap register.
+ */
+static const struct regmap_config an8855_regmap_phy_config = {
+	.name = "phy",
+	.reg_bits = 20,
+	.val_bits = 16,
+	.reg_stride = 1,
+	.max_register = MDIO_REGMAP_PHY_ADDR | MDIO_REGMAP_PHY_REG,
+	.reg_read = an8855_regmap_phy_read,
+	.reg_write = an8855_regmap_phy_write,
+	.disable_locking = true,
+};
+
+static int an8855_read_switch_id(struct device *dev, struct regmap *regmap)
+{
+	u32 id;
+	int ret;
+
+	ret = regmap_read(regmap, AN8855_CREV, &id);
+	if (ret)
+		return ret;
+
+	if (id != AN8855_ID) {
+		dev_err(dev, "Switch ID detected %x but expected %x\n",
+			id, AN8855_ID);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int an8855_mfd_probe(struct mdio_device *mdiodev)
+{
+	struct regmap *regmap, *regmap_phy;
+	struct device *dev = &mdiodev->dev;
+	struct an8855_mfd_priv *priv;
+	struct gpio_desc *reset_gpio;
+	u32 val;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->bus = mdiodev->bus;
+	priv->switch_addr = mdiodev->addr;
+	/* no DMA for mdiobus, mute warning for DMA mask not set */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
+	regmap_phy = devm_regmap_init(dev, NULL, priv, &an8855_regmap_phy_config);
+	if (IS_ERR(regmap_phy))
+		return dev_err_probe(dev, PTR_ERR(regmap_phy),
+				     "regmap phy initialization failed\n");
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	if (reset_gpio) {
+		usleep_range(100000, 150000);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		usleep_range(100000, 150000);
+		gpiod_set_value_cansleep(reset_gpio, 1);
+
+		/* Poll HWTRAP reg to wait for Switch to fully Init */
+		ret = regmap_read_poll_timeout(regmap, AN8855_HWTRAP, val,
+					       val, 20, 200000);
+		if (ret)
+			return ret;
+	}
+
+	ret = an8855_read_switch_id(dev, regmap);
+	if (ret)
+		return ret;
+
+	/* Release global PHY power down */
+	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
+	if (ret)
+		return ret;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
+				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
+				    NULL);
+}
+
+static const struct of_device_id an8855_mfd_of_match[] = {
+	{ .compatible = "airoha,an8855" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_mfd_of_match);
+
+static struct mdio_driver an8855_mfd_driver = {
+	.probe = an8855_mfd_probe,
+	.mdiodrv.driver = {
+		.name = "an8855",
+		.of_match_table = an8855_mfd_of_match,
+	},
+};
+mdio_module_driver(an8855_mfd_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha AN8855 MFD");
+MODULE_LICENSE("GPL");
-- 
2.48.1


