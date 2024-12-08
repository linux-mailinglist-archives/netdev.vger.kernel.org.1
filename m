Return-Path: <netdev+bounces-149935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A910E9E82DF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F0D166238
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000613A25B;
	Sun,  8 Dec 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPwZVmdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF98F77;
	Sun,  8 Dec 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617316; cv=none; b=NedgMsjy6Ou9pHganBY5JMcOZunoM6Ra/VM62CnCoqfZocqa1Q/p4jyfCZGJGT/eEpOAmKXz5fOYzPCpIHfsMGo/FGPuyXCpzjaTiudRA1GipbDBlUw0z2H8uoxyyX0FGXeWO7vqHSsuxodlDbx8fGLbqPZGO8S9eBjmum2leEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617316; c=relaxed/simple;
	bh=u21sf4Pf8DVF3B8tTyBu6dcP+znXT5z4lry9t3oeAuw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ+1gkUTbD8N/7D0C0YYT3DDNCCAJ8wxKDYcQJeF0YlB8G9f2Wczz/yW8I4sXSXBPoLMshhvRq8J2l1b8P3GUwbRBwuEh6OjdSJPGTsw7Y9ijN5q1zu+MvkjaoqeLbWOBCz0EAJNcqgN2XhJlT273kP6Yf6nM/2GpoKVkVVd80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPwZVmdF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d86a3085so21265465e9.2;
        Sat, 07 Dec 2024 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617313; x=1734222113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWK5L5fiEh9x1Fnec1ztFmshwvmpoPPX1jR0wmHavBU=;
        b=nPwZVmdFEx8fxzGtTaM/Jj3c8M2F6aFsNGLGk37ZiiI/ZiNmjd/sZNVxfCcrcnTeuB
         /+q4mscMZxETA8w/CEbeXwo3Tkj+uo3oncOFWI/qcDS9RUMfOyW7zw6/WwZgZyd8UQ7s
         L4XFRs0ExsFS741FNUAhoDeSXhDhUzr8r2cy5IRbHqW5qmeExgpBkDqrR29SjqD4hKdA
         2PrOGDpRdiBob0Uwu927C4tp2svCWoB++zuWfVa54GgEhG2u0rNcCL3pF/4SnyU00hrw
         1uqdE3cy6PDFqooasudgcSQWqq3IK7/XBBT9YqPoSEI6NnYcIj//xh2xxyJpbNZakMwG
         mhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617313; x=1734222113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWK5L5fiEh9x1Fnec1ztFmshwvmpoPPX1jR0wmHavBU=;
        b=IkexAY/3cmMvhvDp1QwC50ZYb/L/u9RhIKn09vG4B1XV5N2n5Wf0ZO4RmNcBjJ62TH
         CIoOmXu7LzGZyhAdBfWT2DSa6frbLr9/r926waCgXdSqit65b4q+ZbvbMgIBvBz8CcYw
         mQIvqdd5iid8n2Y/lBJe14ZBL76uLjUEGNwX9giblU0yP/hw6CMhDkQ9gyhTqY6Ru26P
         /7Lx98IDeMMzzXBdeb020gDiS7v/MqRShvYHP2lhC1y5tvLKN74LN5kwWS52vbXsCC0R
         786A16uQsnENyjFiimxKIp6e185xpFz2dMWbQs22cOTbiYxHEK4LPrbaqt35P2NaLuGV
         +iDA==
X-Forwarded-Encrypted: i=1; AJvYcCUsDznkebazlYJ1F4mkRAkUBXbSmiTBrvNcz5ActneuZsAD+jW2HdCSETuLYs4obfav3IDgocI6@vger.kernel.org, AJvYcCV213kqcGxTQk7EJBHQcB/NkB5QC2vQpdmnrDkfhaAfT8lGLM0Y+ChwLIKgdp2ZYb4rYwiJLTq90306@vger.kernel.org, AJvYcCVcnQ30H1OJ8Uc2tSSqQf6K8pcALhxxXq+a2+h2GlUXue9RxquMU4c7dhX1Wcgn6qMn9jAEG9uZKvRveBY5@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIEuMg0CWcT97nZQfqiyT2VkUDJ3QPobecUPcUN+wGRzccJVE
	kxLFr4AFphGwGE8qqM+5J0SLhQguSxQSdfv93bcRg8k7cW49hIJu
X-Gm-Gg: ASbGncsdn1y/orTIO7fnajWcabGXcvY54FbyPm0gfetE5oZS2XhFxqJPGBvoSJAT70+
	C6Up217s8YBHEdEzAGcMcMwnMfoFmPhbnlEhelJlhtU3fgYYp4R7lOhTEHaBh3P9o1RnEh329gb
	Mb6PZGnbiUiVOq4H64yahKvxU7mwaIaA0hvjZdXSkWhL9Nsu5K47VkPr86eA59Ke5LliMJOXdaO
	BcOcZ2ZltZKa/FnCowejF70+PXGXMBefROdd04GN8RO7OXCbYJsfjIdOzWzdj54DS/MurnXeqez
	BY+gHtd4nKCL5pyhobA=
X-Google-Smtp-Source: AGHT+IFErou0z5usYeTe01YrkBJhcuomp9lkMIUC049he4nWnk0WtxadZczy3cqAantHH0mxzDERSg==
X-Received: by 2002:a05:600c:1388:b0:434:a239:d2fe with SMTP id 5b1f17b1804b1-434dded5da5mr49749885e9.28.1733617312882;
        Sat, 07 Dec 2024 16:21:52 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:51 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v10 5/9] mfd: an8855: Add support for Airoha AN8855 Switch MFD
Date: Sun,  8 Dec 2024 01:20:40 +0100
Message-ID: <20241208002105.18074-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
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
address

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                           |   1 +
 drivers/mfd/Kconfig                   |   9 +
 drivers/mfd/Makefile                  |   1 +
 drivers/mfd/airoha-an8855.c           | 279 ++++++++++++++++++++++++++
 include/linux/mfd/airoha-an8855-mfd.h |  41 ++++
 5 files changed, 331 insertions(+)
 create mode 100644 drivers/mfd/airoha-an8855.c
 create mode 100644 include/linux/mfd/airoha-an8855-mfd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f3e3f6938824..7f4d7c48b6e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -721,6 +721,7 @@ F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..a83db24336d9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -53,6 +53,15 @@ config MFD_ALTERA_SYSMGR
 	  using regmap_mmio accesses for ARM32 parts and SMC calls to
 	  EL3 for ARM64 parts.
 
+config MFD_AIROHA_AN8855
+	bool "Airoha AN8855 Switch MFD"
+	depends on MDIO && OF
+	select MFD_CORE
+	help
+	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
+	  that provide various peripherals. Currently it provides a
+	  DSA switch and a NVMEM provider.
+
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e057d6d6faef..bcbeb36ab19d 100644
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
index 000000000000..b6cecfc325f6
--- /dev/null
+++ b/drivers/mfd/airoha-an8855.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD driver for Airoha AN8855 Switch
+ */
+
+#include <linux/mfd/airoha-an8855-mfd.h>
+#include <linux/mfd/core.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
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
+int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
+			u8 page) __must_hold(&priv->bus->mdio_lock)
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
+EXPORT_SYMBOL_GPL(an8855_mii_set_page);
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
+static int
+an8855_regmap_write(void *ctx, uint32_t reg, uint32_t val)
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
+static int an8855_mfd_probe(struct mdio_device *mdiodev)
+{
+	struct an8855_mfd_priv *priv;
+	struct regmap *regmap;
+
+	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->bus = mdiodev->bus;
+	priv->dev = &mdiodev->dev;
+	priv->switch_addr = mdiodev->addr;
+	/* no DMA for mdiobus, mute warning for DMA mask not set */
+	priv->dev->dma_mask = &priv->dev->coherent_dma_mask;
+
+	regmap = devm_regmap_init(priv->dev, NULL, priv,
+				  &an8855_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(priv->dev, "regmap initialization failed");
+		return PTR_ERR(priv->dev);
+	}
+
+	dev_set_drvdata(&mdiodev->dev, priv);
+
+	return devm_mfd_add_devices(priv->dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
+				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
+				    NULL);
+}
+
+static const struct of_device_id an8855_mfd_of_match[] = {
+	{ .compatible = "airoha,an8855-mfd" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_mfd_of_match);
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
diff --git a/include/linux/mfd/airoha-an8855-mfd.h b/include/linux/mfd/airoha-an8855-mfd.h
new file mode 100644
index 000000000000..56061566a079
--- /dev/null
+++ b/include/linux/mfd/airoha-an8855-mfd.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MFD driver for Airoha AN8855 Switch
+ */
+#ifndef _LINUX_INCLUDE_MFD_AIROHA_AN8855_MFD_H
+#define _LINUX_INCLUDE_MFD_AIROHA_AN8855_MFD_H
+
+#include <linux/bitfield.h>
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
+	struct device *dev;
+	struct mii_bus *bus;
+
+	unsigned int switch_addr;
+	u16 current_page;
+};
+
+int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
+			u8 page);
+
+#endif
-- 
2.45.2


