Return-Path: <netdev+bounces-222988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F53B576FA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26D04E1B56
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613BA3009FF;
	Mon, 15 Sep 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwx65Zdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851423002CD
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933177; cv=none; b=oKSLZFjwc37TYMkFRhS0VWgWIBQ64SxJb9eQR9LlLsL2x5oNwawsJF9ILfbWcWBo6jiLqN1M8HXlLPYid/GMQYTg9wdywoVR5B0DFbxEuF+eTDNBlTUcoQDK828UYNWk687VEktVY3gQy5MR5IQkfPAIQe/hQru70lR7sip9OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933177; c=relaxed/simple;
	bh=3lfI0hbFDSkZIP0Esz755jFFmPu71x98M5c2Vb0pd28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzFb2ARK78bUFFOdXXalt7MQKNgpPqmfysUwLgbjyRoFUpeL3SlvK9t7exMfMBHB49bh1byXJpyHj5G+p69Ut1aUt3wLtxb1L0CQAhfexahp0dHxgl5UIdZ4yyX/q0UdUzGeYoiwruY7Sr6Uxby4ukSSJ0EM3SfONhmuZwTvoLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwx65Zdl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so1026537f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933172; x=1758537972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw7eFxxOPSgW1pgIIDJZROGLxVLojEl3KzXjHT73qQ8=;
        b=kwx65ZdlAsOnNHedJrP1s58cuTtEMIKTCpgArA2GwQ/4AImsPLc7b7tAJd3wILL+Un
         0V9UlSOc4Vn7oMYnSka2dFgCbWSJHX/tXkxtZ5Sq2XsBUZGSsbI4eNogArPzd6VuxzYh
         Cjp9cZdHGwmaJQ6RVaYn4xBaEcNrPhhR4Je7/hBMpTfN7TaxNnIXs0i5STxWwrYStur3
         VojZSb/RajTF1o0tL9MvuxKpinOokcRIP1WAuHS6PaOK0hQvYsbhrCtM61fff62o/sMy
         UKeU2dAeZAEzxfCEwqGREvZ/oj8bASvK4AjkjPhBs9IDiQNQhctKcGLlI/UTAYuJ9lKo
         GekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933172; x=1758537972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw7eFxxOPSgW1pgIIDJZROGLxVLojEl3KzXjHT73qQ8=;
        b=bhiE7mPW0eN9RwcIBWFNBZbAzr3hrqcIbTMdhXrCqWsPUct0DVyMWLzI826m2L3nwX
         1y7mps8euVady1Qx+/Zccwv56F0SLRo0m0tfQfw61eh7osxXbvamu3mp5XsBkTh9IQuM
         cnu+PGM/SAt50tf/PsVknLS7C8SdVvqR+QdZpvxCwQQIaj7dwbmAeT4iirn+iI2pIe3H
         CsJ27N6qyzfdpDx0FhetR4GlcE59cl0InxRbVbAR53qjgwTwwZDii3QMZX2YZQ0N6Uc2
         VpSRilpY9+kB5Clof8EkFRBbonBPNmXY05mFFbtTefAFvFSI5zzkRXSknXJ4uXG+Wtzk
         kveg==
X-Forwarded-Encrypted: i=1; AJvYcCWnMpzv7SG2ek9r52PMQ8+1ItLtkp9S8QYQA2nFSNilKGapfnTeYMbpynt6TrIA1BBmw/zsBZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHFSh9TFiW5oj11Dwt+1F3EJQrYFb5mrVSBqbraKbJilOieUp
	iOwnZ80eK+0iXWhFbZxPybG69GcvKFDi3hrMid67TEqQow9wSHz7CJE5
X-Gm-Gg: ASbGncuM/AGFSE9LXtNxl0cXdrGisi2x+A0w0m12H759Jq0Hsbo4edNxcTUXVP2F7p3
	WX9CTxYDb9f3CRvpIyvIdqOV5hucTyLlvuzZ5tljAczMwfEf6scgi+j05FnO27Na539AX7KJnII
	PIL1qnLEMg0ugNCtHNWvXP/eMKwbDcqGFsNTEeC+XhiU6dpsw7ZHFfrB0YsTz9T79WJxgJjyRi0
	dOVe7Gvx/08kEvUoraJmAnD2AuOMrk2kEULZc5hRgseQOzpjRNZQUSmvmGDQ5xpkpz/mb7Dypnv
	zVXJQbLwyArbnQK56UXyRBEMXjZY/Kv4jG7svGb/HDdH5wIUb4xeqXPbj96gvYJiJ8M93+r6XuS
	t2eywcBzwQaXQsTD0pOUHcY30YjIn8U59sl4S5I1epAkvQZyuREvbaonulOCbkpkNQT/TAEY0Su
	o/cjQSPA==
X-Google-Smtp-Source: AGHT+IEiiDOUoi66pynaa+zm6F+L1Rj0Swl0+IVh52DDn5iNqoSQEU682ht5TrxXJ5SZPzKA/Dplhw==
X-Received: by 2002:a05:6000:240a:b0:3e3:f332:73f7 with SMTP id ffacd0b85a97d-3e7657adee4mr10492892f8f.28.1757933171669;
        Mon, 15 Sep 2025 03:46:11 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:46:11 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 7/8] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Mon, 15 Sep 2025 12:45:43 +0200
Message-ID: <20250915104545.1742-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
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
index a7fb1d7cae94..c01ca9117fbb 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -91,6 +91,11 @@ config AS21XXX_PHY
 	  AS21210PB1 that all register with the PHY ID 0x7500 0x7500
 	  before the firmware is loaded.
 
+config AIR_AN8855_PHY
+	tristate "Airoha AN8855 Internal Gigabit PHY"
+	help
+	  Currently supports the internal Airoha AN8855 Switch PHY.
+
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 402a33d559de..be18963f93dc 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -29,6 +29,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
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
2.51.0


