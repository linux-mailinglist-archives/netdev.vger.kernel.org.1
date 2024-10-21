Return-Path: <netdev+bounces-137474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E79A698D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED07A1F22B1B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A71F9EB3;
	Mon, 21 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaKuzF+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A21F9A80;
	Mon, 21 Oct 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515769; cv=none; b=bXx4s4e0tO5qMKkX3ZHQVZ6Xr69RK7Bx8IBcMXnSuEP4IU5zeFiT8erTo3yHtz/RIYttI/jOdwE8kYXYYjPtOlpliNRvPsoOFq37DUdZ6NLyF6vO8U5BNsf66Z3P2zbdrUuHukCKfjP/uPNXSxgp75uycYv8RuaEx1p3nH9wiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515769; c=relaxed/simple;
	bh=6gxKEuarQ+vDh+L/bcbaCZ1nuZ4Bx5b43d+dMGtM32c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mASvROiwxQSKOJTFbQ51CIrlXG/r5A2Fv2O1JSRA4O0QUGVDLknuUwT2OC+9RBJ/pa73z0XahOXkE2he8AKE7OcjtsjIFqc+Jp4c9vfU/bPLNY5P5zfbWjWLAyyd/BD57vfE/gmlk5nCevwOspa6FpSSgoXaJSwg61kma1d8MA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaKuzF+K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so31106915e9.2;
        Mon, 21 Oct 2024 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515765; x=1730120565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdr3q6nNRjuIKptOGau1hasFAcJEBLZMYAAhIph/2y0=;
        b=QaKuzF+KeXinL3BZlozoJSmSxUQIAP45bBuD9+3w21ce/Mt7tgHRtVcqIGBKz4CfRE
         JkOPKiJaRPmaFTFkgtZflB/5mPg3sXyYzWOyVBxxlbi3DdW3f6Pu2GyaxUav7ACFgwI/
         sD8HtKUUPc/3uYNep+A+yYAKLSYeTawMG28HHJiIhJmmNpqJcf5jLG3mOg+TcGLsgkFm
         K7XcF8+whEK2DxjtmH66sIcp4XJ5bEOIUgX8LK2NOjAgpiBVe8Ag7vIURk6VKCHl8LnE
         LgGfX4woMvE+N5EipsSV31/2hGo21Zf75ajO3YapH0OzAM2p7aHDaDG08daA9NVA8WLW
         nLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515765; x=1730120565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdr3q6nNRjuIKptOGau1hasFAcJEBLZMYAAhIph/2y0=;
        b=P3xSAZ+koOxyzAKiozDC7k1y5PCiBTBni1TB9MXMjgFzk8CecpePMmrAuaeQ7W8qlN
         X+bsK3xBKF/2K49CTfwGO3YKaNrgNjcFuwzH+9yXlTb4QlVgPsjw7ftiW8FeUnx8slPc
         nKJBHAItzIwfya7jxFlOn/CQfRsYFiXjSEiiz9V6PftXtotk5W77FguIykPo/tLJXsyJ
         xyIwtiznvrpldykFQi9YFiKubhzJCHT0jwOULi1CZxo6WOrJfN/w9VNqxX32Yb4oPd0s
         Jn5jN7CukxdEObtITN5HAFmVjUReSHwjm339abzy9u2R39c/OO4T8tFLHJf4RJPZ9AuV
         IMwA==
X-Forwarded-Encrypted: i=1; AJvYcCV4MRelFQ2JaKeCbFROU//WVZYtBMNBVljjUFHcgNUTAKWs4cmbCVDNKrUDwPRZrn/ZSDApwwgZ2Wi4wc+1@vger.kernel.org, AJvYcCVoa+BpTbLxC6m0uDIt37bc9rgtetEVsEfidN8r+iZvqu0dx9p43udMP9StfJ1U1vCTCIhvhiL2yTMO@vger.kernel.org, AJvYcCWMMVuNB2Wau6oEDc+6tUpsED3mNLh2awhz3GZ4K2IB7BlIh5Zk9qP3m1zl8d8vE7+WegCLbgbY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5/sRYb5rYmLfzGoz31goGAS1rYyZ7rt4Mvq5d6Pxog4N0XSv
	7bs5ZUV+OoACh6nGDa/zfr62f2W/gTvtrtnmnpcpHj6d98dEJBmq
X-Google-Smtp-Source: AGHT+IEsg6uJIcXF28DD/Av+navB79ctZNPCtCYigrWk6w4cagxFR80UEX0wWiSuxMyNYrzKmytHlQ==
X-Received: by 2002:a5d:5e11:0:b0:37c:d512:d427 with SMTP id ffacd0b85a97d-37edc481847mr4040861f8f.35.1729515764285;
        Mon, 21 Oct 2024 06:02:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcfdsm4295329f8f.103.2024.10.21.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 4/4] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Mon, 21 Oct 2024 15:01:59 +0200
Message-ID: <20241021130209.15660-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021130209.15660-1-ansuelsmth@gmail.com>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN8855 Internal Switch Gigabit PHY.

This is a simple PHY driver to configure and calibrate the PHY for the
AN8855 Switch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/net/phy/Kconfig      |   5 +
 drivers/net/phy/Makefile     |   1 +
 drivers/net/phy/air_an8855.c | 187 +++++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 drivers/net/phy/air_an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e3077d9feee2..cf34add2a0bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,6 +726,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 F:	drivers/net/dsa/an8855.c
 F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ee3ea0b56d48..1d474038ea7f 100644
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
index 90f886844381..baba7894785b 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -35,6 +35,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
+obj-$(CONFIG_AIR_AN8855_PHY)   += air_an8855.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
new file mode 100644
index 000000000000..d40b0b17a2e4
--- /dev/null
+++ b/drivers/net/phy/air_an8855.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/phy.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+
+#define AN8855_PHY_PAGE_CTRL			0x1f
+#define   AN8855_PHY_NORMAL_PAGE		0x0
+#define   AN8855_PHY_EXT_PAGE			0x1
+
+#define AN8855_PHY_EXT_REG_14			0x14
+#define   AN8855_PHY_EN_DOWN_SHFIT		BIT(4)
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
+/* PHY TX PAIR DELAY SELECT Register */
+#define PHY_TX_PAIR_DLY_SEL_GBE			0x013
+/* PHY ADC Register */
+#define PHY_RXADC_CTRL				0x0d8
+#define PHY_RXADC_REV_0				0x0d9
+#define PHY_RXADC_REV_1				0x0da
+
+#define AN8855_PHY_ID			0xc0ff0410
+
+static int an8855_config_init(struct phy_device *phydev)
+{
+	u8 calibration_data[4];
+	int ret;
+
+	memcpy(calibration_data, &phydev->dev_flags, sizeof(u32));
+
+	/* Enable HW auto downshift */
+	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
+	if (ret)
+		return ret;
+	ret = phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
+			   AN8855_PHY_EN_DOWN_SHFIT);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
+	if (ret)
+		return ret;
+
+	/* Enable Asymmetric Pause Capability */
+	ret = phy_set_bits(phydev, MII_ADVERTISE, ADVERTISE_PAUSE_ASYM);
+	if (ret)
+		return ret;
+
+	/* Disable EEE */
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+	if (ret)
+		return ret;
+
+	/* Apply calibration values, if needed. */
+	if (phydev->dev_flags) {
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
+	/* Apply values to decude signal noise */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, PHY_TX_PAIR_DLY_SEL_GBE, 0x4040);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, PHY_RXADC_CTRL, 0x1010);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, PHY_RXADC_REV_0, 0x100);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, PHY_RXADC_REV_1, 0x100);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val;
+	int ret;
+
+	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
+	if (ret)
+		return ret;
+
+	val = phy_read(phydev, AN8855_PHY_EXT_REG_14);
+	*data = val & AN8855_PHY_EXT_REG_14 ? DOWNSHIFT_DEV_DEFAULT_COUNT :
+					      DOWNSHIFT_DEV_DISABLE;
+
+	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	int ret;
+
+	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
+	if (ret)
+		return ret;
+
+	if (cnt != DOWNSHIFT_DEV_DISABLE) {
+		ret = phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
+				   AN8855_PHY_EN_DOWN_SHFIT);
+		if (ret)
+			return ret;
+	} else {
+		ret = phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
+				     AN8855_PHY_EN_DOWN_SHFIT);
+		if (ret)
+			return ret;
+	}
+
+	return phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
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
+static struct phy_driver An8855_driver[] = {
+{
+	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
+	.name			= "Airoha AN8855 internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.flags			= PHY_IS_INTERNAL,
+	.config_init		= an8855_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_tunable		= an8855_get_tunable,
+	.set_tunable		= an8855_set_tunable,
+	.suspend		= genphy_suspend,
+	.resume			= genphy_resume,
+}, };
+
+module_phy_driver(An8855_driver);
+
+static struct mdio_device_id __maybe_unused An8855_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(AN8855_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, An8855_tbl);
+
+MODULE_DESCRIPTION("Airoha AN8855 PHY driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.2


