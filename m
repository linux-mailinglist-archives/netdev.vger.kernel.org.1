Return-Path: <netdev+bounces-221012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC76B49E3C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292E84424D6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A7233134;
	Tue,  9 Sep 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeMY1QjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E4244687;
	Tue,  9 Sep 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378651; cv=none; b=Lpan2monNQA4+pteaKBtrxEolLHLFw3lDeqpsC4jBKpQWLYG06+xQkwKVLJBsTsk1+Ihm1WQbkNCMB5idnYuJe/iQMuiY9KB+UzU/FBKCOlCDeP2wplTNEUAoXdnEHDvExfBUsuQuW9LfcZpc3SsmwXzXGkKMNA7PN/kEc/ydfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378651; c=relaxed/simple;
	bh=5j19lG/Bzlkit+YPd7dhu1fJDUz79MVlBlmpwp6VMMU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGVuySKPVkCI3x98G8ggrsMkuuw4a7j5IrCtgXlE1NdvnESt1djc2YK/U7I3so7mSz0vM6z2U1LMgdYSmhakfzRabGY0K3cF29BOXRNLfjc+qDamuX/+STv+rsytUArpRy7wEKrn64ykpdmkjlI+4UqkaWproNXmUlJ8dSPf9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeMY1QjJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso32277515e9.2;
        Mon, 08 Sep 2025 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378648; x=1757983448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+LqAwl1edUEs6Wqc0lhS2WeD/IveCthRFm9TM/GDVg=;
        b=jeMY1QjJop9UOJ9XmKmhj8jnlAAKb9BnEDoNwa/F5a+PKkChmRres9TrZUnYKMmFOw
         y0NA7Cf66lvWzA4xpRlsuFci3nD0bRIQEl+hJ83egOdwf4rtg1piFQwpSLGELPQtTAW/
         Zlxe1cxg31577p6TVb99+6fuq+kku7hxI+KFKDqjFUp+6dPyMAbRhDa9rsJ0ueubLI6g
         YYLbT0nr19SC5PrP9arT+XYr7LdRqHnWg95LkK/pSFZE6NuDP2WgYUTx1pc1Mk9rbP6O
         4shtSXYutxbHKsAa+LCF3WSoUUABJh40VolZWWGnsxdwJf3/27lkZJ6qHZWqzy1Ak50E
         NOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378648; x=1757983448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+LqAwl1edUEs6Wqc0lhS2WeD/IveCthRFm9TM/GDVg=;
        b=gQ1lCJybskFmEeb8hDpMyrx53192vkmgsG7eAG1Pq7taXXwgsmx5efwdylVG1UPv1x
         osil6DKHIE+CjOKhcEmEe1mupael1aFnwnQjKx9vqm1Oue+5Nnwlr6aqsH3tPm8H1CB1
         zu3HKT8JbzODa1/GU/Hm4OFvPAe7/UNTbR1VMp7SSeAs4/YFQeTgUHi9vpNoWMjZiypZ
         taPz2xjmflkXST9juaFCZ8vCX4YwjKaUenZaHtIekGLLN4t0kb2e1Lh3078Q3VS0l0cT
         Dbm60U+CBNATvCit81Cm8OahgTtXOwHIicBAJoGlgi1icK3mEJ8F4BJt8qCdh6l0ZUrd
         Thfw==
X-Forwarded-Encrypted: i=1; AJvYcCUw17FF76+Q/Am1GWWtaDoUDAAX/qhbH6k1tbyK662fVpyNw/uMSZgj3nz8bK2jX9XiC8PbFJcK@vger.kernel.org, AJvYcCXAGttxcWTa+mzIMtfUOMSCD4V4H6v7apni/cZ/Esw9ovCNkmRTNxdJvWFx5GTikGzWXkmKvfzV0+0H@vger.kernel.org, AJvYcCXLIJOYmyMLPKcJ0qj5yirhRbDOIJC/9QYFyjPOTak/gCgTOSnXq5ToQMAwXGeuo/NUQUPfiSDnkPLMnbVT@vger.kernel.org
X-Gm-Message-State: AOJu0YxKE4f/RefJ4PKNv4cZaTZv5AruNXdsCFVDHezoB3VEYrgO31UY
	Woeiu0r+uQ+K7pKxAuGRm0f/ZW5omF1+qnnwSSm8/iunIzAt1FYvWiTn
X-Gm-Gg: ASbGncsSskIuzbSXGtRroeQAqshBWz3ChUgoTlg3CwRPlHTUgVZ12edi+EQwCOWO+l/
	d//WAFLO87BWh1mf92rl3vYEmMNyaGG6zIe/bMTT0Aa6v8UHXgUJ7Cf62/Dz6SWZcUYu5ZAyOtK
	kM8nWc9VPboXcLKacsyXCyUuxR1q1dBoxUTEcoP2/vPPJsCCynLGvuxQzujZBcaWPjVoVXbalaE
	upBSfjNoILcm9IsPIWHpTqZNEDkbDS1vLlfINZwHAGuW+0qF46gU9V8rTZS9naNyzgwwy/B1TZc
	knQHuJXAdWI5faN91KDn2mOko7MyUmFE/e+EFLh+bgy0UFNa3MpxYQ1CxNeD4JVoiEFyhBQ+8nQ
	+LDB45l7Dqml2zd1zEeL3zS0HIfGvh80647kLmCDjnI0Sw97DUf+2YPsMVk4NIYdpC6uem7o=
X-Google-Smtp-Source: AGHT+IG8wKCiMHuzR5sstMeBRbIqHHlCdAEhDqolLs/suUEez8P/CpliYXrFOhbZu23rK8jxecA8eg==
X-Received: by 2002:a05:600c:1c82:b0:45b:9a46:2655 with SMTP id 5b1f17b1804b1-45dec4e0723mr15402955e9.13.1757378647565;
        Mon, 08 Sep 2025 17:44:07 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:44:07 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v16 07/10] mfd: an8855: Add support for Airoha AN8855 Switch MFD
Date: Tue,  9 Sep 2025 02:43:38 +0200
Message-ID: <20250909004343.18790-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN8855 Switch MFD that provide support for a DSA
switch and a NVMEM provider.

Also make use of the mdio-regmap driver and register a regmap for each
internal PHY of the switch.
This is needed to handle the double usage of the PHYs as both PHY and
Switch accessor.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mfd/Kconfig         |  13 +
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/airoha-an8855.c | 513 ++++++++++++++++++++++++++++++++++++
 3 files changed, 527 insertions(+)
 create mode 100644 drivers/mfd/airoha-an8855.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1..f93450444887 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -53,6 +53,19 @@ config MFD_ALTERA_SYSMGR
 	  using regmap_mmio accesses for ARM32 parts and SMC calls to
 	  EL3 for ARM64 parts.
 
+config MFD_AIROHA_AN8855
+	tristate "Airoha AN8855 Switch Core"
+	select MFD_CORE
+	select MDIO_DEVICE
+	select MDIO_REGMAP
+	depends on NETDEVICES && OF
+	help
+	  Support for the Airoha AN8855 Switch Core. This is an SoC
+	  that provides various peripherals, to count, i2c, an Ethrnet
+	  Switch, a CPU timer, GPIO, eFUSE.
+
+	  Currently it provides a DSA switch and a NVMEM provider.
+
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f7bdedd5a66d..30f46c53d6df 100644
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
index 000000000000..5dc27aaff4b1
--- /dev/null
+++ b/drivers/mfd/airoha-an8855.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Core driver for Airoha AN8855 Switch
+ */
+
+#include <linux/bitfield.h>
+#include <linux/fwnode_mdio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/core.h>
+#include <linux/mdio.h>
+#include <linux/mdio/mdio-regmap.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+
+/* Register for HW trap status */
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
+#define   AN8855_PBUS_MODE_ADDR_INCR	BIT(15)
+#define AN8855_PBUS_WR_ADDR_HIGH	0x11
+#define AN8855_PBUS_WR_ADDR_LOW		0x12
+#define AN8855_PBUS_WR_DATA_HIGH	0x13
+#define AN8855_PBUS_WR_DATA_LOW		0x14
+#define AN8855_PBUS_RD_ADDR_HIGH	0x15
+#define AN8855_PBUS_RD_ADDR_LOW		0x16
+#define AN8855_PBUS_RD_DATA_HIGH	0x17
+#define AN8855_PBUS_RD_DATA_LOW		0x18
+
+#define AN8855_MAX_PHY_PORT		5
+
+struct an8855_core_priv {
+	struct mii_bus *bus;
+
+	unsigned int switch_addr;
+	u16 current_page;
+};
+
+struct an8855_phy_priv {
+	u8 addr;
+
+	struct an8855_core_priv *core;
+};
+
+static const struct mfd_cell an8855_core_childs[] = {
+	{
+		.name = "an8855-efuse",
+		.of_compatible = "airoha,an8855-efuse",
+	}, {
+		.name = "an8855-switch",
+		.of_compatible = "airoha,an8855-switch",
+	},
+};
+
+static int an8855_mii_set_page(struct an8855_core_priv *priv, u8 addr,
+			       u8 page) __must_hold(&priv->bus->mdio_lock)
+{
+	struct mii_bus *bus = priv->bus;
+	int ret;
+
+	ret = __mdiobus_write(bus, addr, AN8855_PHY_SELECT_PAGE, page);
+	if (ret) {
+		dev_err_ratelimited(&bus->dev, "failed to set mii page\n");
+		return ret;
+	}
+
+	/* Cache current page if next MII read/write is for Switch page */
+	priv->current_page = page;
+	return 0;
+}
+
+static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
+			     u32 *val) __must_hold(&bus->mdio_lock)
+{
+	int lo, hi, ret;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
+			      AN8855_PBUS_MODE_ADDR_FIXED);
+	if (ret)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_HIGH,
+			      upper_16_bits(reg));
+	if (ret)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_LOW,
+			      lower_16_bits(reg));
+	if (ret)
+		goto err;
+
+	hi = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_HIGH);
+	if (hi < 0) {
+		ret = hi;
+		goto err;
+	}
+
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
+	dev_err_ratelimited(&bus->dev, "failed to read register\n");
+	return ret;
+}
+
+static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
+{
+	struct an8855_core_priv *priv = ctx;
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
+	if (ret)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_HIGH,
+			      upper_16_bits(reg));
+	if (ret)
+		goto err;
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_LOW,
+			      lower_16_bits(reg));
+	if (ret)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_HIGH,
+			      upper_16_bits(val));
+	if (ret)
+		goto err;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_LOW,
+			      lower_16_bits(val));
+	if (ret)
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
+	struct an8855_core_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 addr = priv->switch_addr;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret)
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
+	struct an8855_core_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u16 addr = priv->switch_addr;
+	u32 val;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret)
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
+static int an855_regmap_phy_reset_page(struct an8855_core_priv *priv,
+				       int phy) __must_hold(&priv->bus->mdio_lock)
+{
+	/* Check PHY page only for addr shared with switch */
+	if (phy != priv->switch_addr)
+		return 0;
+
+	/* Don't restore page if it's not set to Switch page */
+	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
+					    AN8855_PHY_PAGE_EXTENDED_4))
+		return 0;
+
+	/*
+	 * Restore page to 0, PHY might change page right after but that
+	 * will be ignored as it won't be a switch page.
+	 */
+	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
+}
+
+static int an8855_regmap_phy_read(void *ctx, uint32_t reg, uint32_t *val)
+{
+	struct an8855_phy_priv *priv = ctx;
+	struct an8855_core_priv *core_priv;
+	u32 addr = priv->addr;
+	struct mii_bus *bus;
+	int ret;
+
+	core_priv = priv->core;
+	bus = core_priv->bus;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an855_regmap_phy_reset_page(core_priv, addr);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_read(bus, addr, reg);
+	if (ret >= 0)
+		*val = ret;
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int an8855_regmap_phy_write(void *ctx, uint32_t reg, uint32_t val)
+{
+	struct an8855_phy_priv *priv = ctx;
+	struct an8855_core_priv *core_priv;
+	u32 addr = priv->addr;
+	struct mii_bus *bus;
+	int ret;
+
+	core_priv = priv->core;
+	bus = core_priv->bus;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an855_regmap_phy_reset_page(core_priv, addr);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_write(bus, addr, reg, val);
+
+exit:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret;
+}
+
+static const struct regmap_config an8855_phy_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_read = an8855_regmap_phy_read,
+	.reg_write = an8855_regmap_phy_write,
+	.disable_locking = true,
+	.max_register = 0x1f,
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
+		dev_err(dev, "Detected Switch ID %x but %x was expected\n",
+			id, AN8855_ID);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int an8855_phy_register(struct device *dev, struct an8855_core_priv *priv,
+			       struct device_node *phy_np)
+{
+	struct mdio_regmap_config mrc = { };
+	struct an8855_phy_priv *phy_priv;
+	struct regmap *regmap;
+	struct mii_bus *bus;
+	u8 phy_offset;
+	u32 addr;
+	int ret;
+
+	ret = of_property_read_u32(phy_np, "reg", &addr);
+	if (ret)
+		return ret;
+
+	phy_offset = addr - priv->switch_addr;
+	if (phy_offset >= AN8855_MAX_PHY_PORT)
+		return -EINVAL;
+
+	phy_priv = devm_kzalloc(dev, sizeof(*phy_priv), GFP_KERNEL);
+	if (!phy_priv)
+		return -ENOMEM;
+
+	phy_priv->addr = addr;
+	phy_priv->core = priv;
+
+	regmap = devm_regmap_init(dev, NULL, phy_priv, &an8855_phy_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "phy%d regmap initialization failed\n",
+				      addr);
+
+	mrc.regmap = regmap;
+	mrc.parent = dev;
+	mrc.valid_addr = addr;
+	snprintf(mrc.name, MII_BUS_ID_SIZE, "an8855-phy%d-mii", addr);
+
+	bus = devm_mdio_regmap_register(dev, &mrc);
+	if (IS_ERR(bus))
+		return PTR_ERR(bus);
+
+	return fwnode_mdiobus_register_phy(bus, of_fwnode_handle(phy_np), addr);
+}
+
+static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
+{
+	struct device_node *mdio_np;
+	int ret;
+
+	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!mdio_np)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
+		ret = an8855_phy_register(dev, priv, phy_np);
+		if (ret)
+			break;
+	}
+
+	of_node_put(mdio_np);
+	return ret;
+}
+
+static int an8855_core_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct an8855_core_priv *priv;
+	struct gpio_desc *reset_gpio;
+	struct regmap *regmap;
+	u32 val;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->bus = mdiodev->bus;
+	priv->switch_addr = mdiodev->addr;
+	/* No DMA for mdiobus, mute warning for DMA mask not set */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
+	ret = an855_mdio_register(dev, priv);
+	if (ret)
+		return ret;
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
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_core_childs,
+				    ARRAY_SIZE(an8855_core_childs), NULL, 0,
+				    NULL);
+}
+
+static const struct of_device_id an8855_core_of_match[] = {
+	{ .compatible = "airoha,an8855" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_core_of_match);
+
+static struct mdio_driver an8855_core_driver = {
+	.probe = an8855_core_probe,
+	.mdiodrv.driver = {
+		.name = "an8855",
+		.of_match_table = an8855_core_of_match,
+	},
+};
+mdio_module_driver(an8855_core_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha AN8855 MFD");
+MODULE_LICENSE("GPL");
-- 
2.51.0


