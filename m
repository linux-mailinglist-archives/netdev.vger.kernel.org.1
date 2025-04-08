Return-Path: <netdev+bounces-180133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE16A7FA7E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35C53A5BEF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E774269831;
	Tue,  8 Apr 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9psfOIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168A2690EB;
	Tue,  8 Apr 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105957; cv=none; b=Y2nCa9QVtoVhzcN9cjoaKJfxQQdaTUbnP29lVPMbnBfHt7b24IuI3s5I6e8DuwVuUyKgK5dHXYwtpFpO1lNY9as29nKnd5zs0aMaRxVFdHEiXtwdfuwedPxv5Gl+RC2xsg4l0vj4kGUoB0tq3vBHhoO+diYINcbXh/8bwotDLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105957; c=relaxed/simple;
	bh=CXapqmxUEmpk+SmZufRK+SDQBZ3NmoWpDA7DujfcS7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXD3NacxBwE38i/0Y2LwZFiFYN9RrH4UCn/oqLdlZa07DdZwBIqrEJjn6tc3EurWbeYE2NOhAVI6jUTXmnKPqf/O8c0wZYbTKwNoMH5iGe6K5PLUDTf057Aa4MiUk4WGFlmN0f+zrKABZ27aNI4hT8Nb/74YH1hiL6DsdsfPe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9psfOIk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso3242464f8f.2;
        Tue, 08 Apr 2025 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105953; x=1744710753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwltRZenz8I2v+f0rMVjtnSU0zbCoj6BsujDAg9wnzQ=;
        b=M9psfOIkR0mQZqqJRzB6M9Df6EaCTMwu4qVUhP8A69ekUHDiC4f0zyDBtdd2+ryq7p
         GuAaIbLdICIwl32qNmP2wzyj3WcnIanrCWurqWVyqZEwL7rrhF1U3na7+k5g9zdhXiUO
         O5fymLF1JFVjfflzl4M1zBnln/kjBPUPh++bQp2ls1aUgZ6te/W1Tav2Cqp+d3Y8gI3s
         E/KMLHpYD0g18PewVZqoyNxyiImb3haJ22VA54relkuS8srSnyBevLSs9Rbg0jrvmxGx
         WISI3Mns+jkcnuSKWxrBoQdaGzCaPxMyegbdSAPjxLAHPklzT0LO3OrrHr6mGr0U22Wx
         ZZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105953; x=1744710753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwltRZenz8I2v+f0rMVjtnSU0zbCoj6BsujDAg9wnzQ=;
        b=jRe6CWVXxkFSlR2b+iMcVi7/ZeoP0E74hul7hc/4KsWvqeLVv9lCXbs/fcvWdMO1IN
         Jm+tXRkCes1T8HFF93tSDboTKFSXEcl8CYksfyyb1V+OkfZAKH6lLNcQJE6qf74x8ne4
         OTmDgqWXC/pEjPjH8Par6e+WV9TFI9ShJQ5nVTrj6Bk7EbSW1w+ZZEZX83wPYiEXlmeE
         zyjnDIYr4RbhOrYUbzmOiH2RPyclhOYQnBgg5LzjmqCyH4XH1JRA6zNVvJ7S9Ad1oZa9
         1WSC9+8A1vgb8l7SM7n1ucGSLZOyrlLSKy9IoHnMOkiduNMC2YjHol5SYQhbK87usET+
         hfOA==
X-Forwarded-Encrypted: i=1; AJvYcCWXJSL4Vkv6ffpnuYfIVNXDKV/WFj3xeVTQc9I2E2+Dxkdl9zdf3Q0tpxg+UkG3qAhT/6QvHVQE@vger.kernel.org, AJvYcCWehLqs3yyY5VPBKzPoZ8KynhlQtWdS+7N1Ku+PXpSUj+gB+w1gIvg3YVJ9coG3LX+UStV4E4ipWStx@vger.kernel.org, AJvYcCXKZMNH3Ji6dJL8YXwuvV6ByCGAjGNllIxCnu1T6imoQTvSs5dWQIi9nYKaybad0t8ne/ffaxoTed8jPi+2@vger.kernel.org
X-Gm-Message-State: AOJu0YwlyFU4vBHwKHvIAzRWWzT4l86tIRnGX9Mv8BwYBy0MOUpXJ+us
	o7iFM+RgNP9PipxhYIVxfTRUbsErDx/bxKojpSzxgRMQkUYfIM/M
X-Gm-Gg: ASbGncu6zwA9PK6oXkPVT+ucAKJL9VT8DPB3lO367rMyYPkmlGkescyKfZRZzHvt3GD
	nVc9yLQ5locOWO2T+GglT6AlQCZoxYj6a5aIC6GWWZkY3RsYlglyE2qb1yul15EExIEXS/W11GE
	zYkrrjONkyVV90GhvgX5QhtGDyY7MrO5H49DOxO30fn7xKqB1Sxq7vbmCJbxdS/qQqUe6MdEmSm
	h5BhpUgFgkH2JQP09ALtCbFcG8QKNFbW2KSObt3N3O/+p2JrcU2+Ws95H9fspvn3GUpTxhea32r
	h+co9TZuqlGy9zRi6mrdZzv/TFb6uF2iAQ+oDwTZ0l0Zmd8BHYKS/0/F2YUcY9vKPuq+4mB+j2H
	NJNdTIGY+O9eChQ==
X-Google-Smtp-Source: AGHT+IEiXMMaMpseNfIuzetRmfm0JW+UlWCUJtLCq4xShjI6Yzjro3br4yUVxfp2s/la4C1lG68H/g==
X-Received: by 2002:a05:6000:4312:b0:390:ed04:a676 with SMTP id ffacd0b85a97d-39cb35be2edmr11974559f8f.22.1744105953116;
        Tue, 08 Apr 2025 02:52:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:32 -0700 (PDT)
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 14/16] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Tue,  8 Apr 2025 11:51:21 +0200
Message-ID: <20250408095139.51659-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN8855 Internal Switch Gigabit PHY.

This is a simple PHY driver to configure and calibrate the PHY for the
AN8855 Switch with the use of NVMEM cells.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/Kconfig      |   5 +
 drivers/net/phy/Makefile     |   1 +
 drivers/net/phy/air_an8855.c | 261 +++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/net/phy/air_an8855.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d29f9f7fd2e1..e96f61b8eaba 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -79,6 +79,11 @@ config SFP
 
 comment "MII PHY device drivers"
 
+config AIR_AN8855_PHY
+	tristate "Airoha AN8855 Internal Gigabit PHY"
+	help
+	  Currently supports the internal Airoha AN8855 Switch PHY.
+
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 23ce205ae91d..9425ad9dbc00 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -36,6 +36,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
+obj-$(CONFIG_AIR_AN8855_PHY)   += air_an8855.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
new file mode 100644
index 000000000000..a740dbaacf9a
--- /dev/null
+++ b/drivers/net/phy/air_an8855.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define AN8855_PHY_SELECT_PAGE			0x1f
+#define   AN8855_PHY_PAGE			GENMASK(2, 0)
+#define   AN8855_PHY_PAGE_STANDARD		FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
+#define   AN8855_PHY_PAGE_EXTENDED_1		FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
+
+/* MII Registers Page 1 */
+#define AN8855_PHY_EXT_REG_14			0x14
+#define   AN8855_PHY_EN_DOWN_SHIFT		BIT(4)
+
+/* R50 Calibration regs in MDIO_MMD_VEND1 */
+#define AN8855_PHY_R500HM_RSEL_TX_AB		0x174
+#define AN8855_PHY_R50OHM_RSEL_TX_A_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_A		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_B_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_B		GENMASK(6, 0)
+#define AN8855_PHY_R500HM_RSEL_TX_CD		0x175
+#define AN8855_PHY_R50OHM_RSEL_TX_C_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_C		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_D_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_D		GENMASK(6, 0)
+
+#define AN8855_SWITCH_EFUSE_R50O		GENMASK(30, 24)
+
+/* PHY TX PAIR DELAY SELECT Register */
+#define AN8855_PHY_TX_PAIR_DLY_SEL_GBE		0x013
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_A_GBE GENMASK(14, 12)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_B_GBE GENMASK(10, 8)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_C_GBE GENMASK(6, 4)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_D_GBE GENMASK(2, 0)
+/* PHY ADC Register */
+#define AN8855_PHY_RXADC_CTRL			0x0d8
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_A	BIT(12)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_B	BIT(8)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_C	BIT(4)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_D	BIT(0)
+#define AN8855_PHY_RXADC_REV_0			0x0d9
+#define   AN8855_PHY_RG_AD_RESERVE0_A		GENMASK(15, 8)
+#define   AN8855_PHY_RG_AD_RESERVE0_B		GENMASK(7, 0)
+#define AN8855_PHY_RXADC_REV_1			0x0da
+#define   AN8855_PHY_RG_AD_RESERVE0_C		GENMASK(15, 8)
+#define   AN8855_PHY_RG_AD_RESERVE0_D		GENMASK(7, 0)
+
+#define AN8855_PHY_ID				0xc0ff0410
+
+struct air_an8855_priv {
+	bool needs_calibration;
+};
+
+static const u8 dsa_r50ohm_table[] = {
+	127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
+	127, 127, 127, 127, 127, 127, 127, 126, 122, 117,
+	112, 109, 104, 101,  97,  94,  90,  88,  84,  80,
+	78,  74,  72,  68,  66,  64,  61,  58,  56,  53,
+	51,  48,  47,  44,  42,  40,  38,  36,  34,  32,
+	31,  28,  27,  24,  24,  22,  20,  18,  16,  16,
+	14,  12,  11,   9
+};
+
+static int en8855_get_r50ohm_val(struct device *dev, const char *calib_name,
+				 u8 *dest)
+{
+	u32 shift_sel, val;
+	int ret;
+	int i;
+
+	ret = nvmem_cell_read_u32(dev, calib_name, &val);
+	if (ret)
+		return ret;
+
+	shift_sel = FIELD_GET(AN8855_SWITCH_EFUSE_R50O, val);
+	for (i = 0; i < ARRAY_SIZE(dsa_r50ohm_table); i++)
+		if (dsa_r50ohm_table[i] == shift_sel)
+			break;
+
+	if (i < 8 || i >= ARRAY_SIZE(dsa_r50ohm_table))
+		*dest = dsa_r50ohm_table[25];
+	else
+		*dest = dsa_r50ohm_table[i - 8];
+
+	return 0;
+}
+
+static int an8855_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct air_an8855_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->needs_calibration = of_property_present(dev->of_node,
+						      "nvmem-cells");
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val;
+
+	val = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1, AN8855_PHY_EXT_REG_14);
+	if (val < 0)
+		return val;
+
+	*data = val & AN8855_PHY_EN_DOWN_SHIFT ? DOWNSHIFT_DEV_DEFAULT_COUNT :
+						 DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHIFT : 0;
+
+	return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
+				AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHIFT,
+				ds);
+}
+
+static int an8855_config_init(struct phy_device *phydev)
+{
+	struct air_an8855_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* Enable HW auto downshift */
+	ret = an8855_set_downshift(phydev, DOWNSHIFT_DEV_DEFAULT_COUNT);
+	if (ret)
+		return ret;
+
+	if (priv->needs_calibration) {
+		u8 calibration_data[4];
+
+		ret = en8855_get_r50ohm_val(dev, "tx_a", &calibration_data[0]);
+		if (ret)
+			return ret;
+
+		ret = en8855_get_r50ohm_val(dev, "tx_b", &calibration_data[1]);
+		if (ret)
+			return ret;
+
+		ret = en8855_get_r50ohm_val(dev, "tx_c", &calibration_data[2]);
+		if (ret)
+			return ret;
+
+		ret = en8855_get_r50ohm_val(dev, "tx_d", &calibration_data[3]);
+		if (ret)
+			return ret;
+
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_AB,
+				     AN8855_PHY_R50OHM_RSEL_TX_A | AN8855_PHY_R50OHM_RSEL_TX_B,
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_A, calibration_data[0]) |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_B, calibration_data[1]));
+		if (ret)
+			return ret;
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_CD,
+				     AN8855_PHY_R50OHM_RSEL_TX_C | AN8855_PHY_R50OHM_RSEL_TX_D,
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_C, calibration_data[2]) |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_D, calibration_data[3]));
+		if (ret)
+			return ret;
+	}
+
+	/* Apply values to reduce signal noise */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_TX_PAIR_DLY_SEL_GBE,
+			    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_A_GBE, 0x4) |
+			    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_C_GBE, 0x4));
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_CTRL,
+			    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_A |
+			    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_C);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_0,
+			    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_A, 0x1));
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_1,
+			    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_C, 0x1));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int an8855_get_tunable(struct phy_device *phydev,
+			      struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return an8855_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int an8855_set_tunable(struct phy_device *phydev,
+			      struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return an8855_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int an8855_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, AN8855_PHY_SELECT_PAGE);
+}
+
+static int an8855_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, AN8855_PHY_SELECT_PAGE, page);
+}
+
+static struct phy_driver an8855_driver[] = {
+{
+	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
+	.name			= "Airoha AN8855 internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.flags			= PHY_IS_INTERNAL,
+	.probe			= an8855_probe,
+	.config_init		= an8855_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_tunable		= an8855_get_tunable,
+	.set_tunable		= an8855_set_tunable,
+	.suspend		= genphy_suspend,
+	.resume			= genphy_resume,
+	.read_page		= an8855_read_page,
+	.write_page		= an8855_write_page,
+}, };
+
+module_phy_driver(an8855_driver);
+
+static struct mdio_device_id __maybe_unused an8855_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(AN8855_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, an8855_tbl);
+
+MODULE_DESCRIPTION("Airoha AN8855 PHY driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.48.1


