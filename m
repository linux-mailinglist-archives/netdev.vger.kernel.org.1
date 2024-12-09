Return-Path: <netdev+bounces-150213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09419E97AC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53081887D6B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8A1E9B0F;
	Mon,  9 Dec 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTFlsMl4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1811C5CCF;
	Mon,  9 Dec 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751957; cv=none; b=jcA7QLeiLTeJN1MXT3X1iz3Kk0o2fxbkcKaW7qoiRp2PAVXztBLwDiQzoTzrvMR59aekZoggaJ5/EMrVHpb1HZrqxe8tZd9adtkkxMO9/NKb9lEs2Z5igNR0SPaXr4T9FoRFbGCG+g5AbFHw6giepsXkWavIO/6nF1GBsPmEL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751957; c=relaxed/simple;
	bh=Pd4XAEGzTQkRmvbk8DoDSXh43lRX+8hCZiigf0RgIKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBZ+qKhXENprjY80tE8HOvphHeksFPaSVDRIIqvW0jTEeQHMsfcbPbmW6nz9EuX0NL5Zl0/1t8D65I2eVpV6pkXBXQ8BU5182POXImuvVPRSPwEZIdrPtW4JSU92X07Hb6lhJ/D0UY6o1ykYl03939B/bmF8vTit+QodUaEJmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTFlsMl4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1715086f8f.0;
        Mon, 09 Dec 2024 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751953; x=1734356753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RQwZ2Rx5T9jyCOWKfOL3l539Mk8OkDnC/4KFbJ9300=;
        b=MTFlsMl4datmGDL+2sWgXmvyGzhTooT3fUAAsM6JeVCUtwjNVdrOxf0tu068gedsGr
         hJcYnRser0G++CZMsEVEaZK0n7T2FIAUYBZCdIqM3g0Fl4ePZd3skP/E3gh1QVM8lZ6x
         R7WTR+t2lyUDTHxmCW9nbLuRmpKeR1jlTF5OZwtql510i7rQMKBO8HT7ggbmQv7ek6Ex
         SM0+uskoq3DpoDaFOFHpb5UQ8PZq6YHXeybw/rmc/DhnDJ0EO8mQFUJVvLt+lQ1QN5qq
         qIBEbWU8H+F6J+RsAUyMiV1rljoihQZdnUODRQCF8EVdeN2CDuDRf8dQL55MkMYRHnBG
         +JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751953; x=1734356753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RQwZ2Rx5T9jyCOWKfOL3l539Mk8OkDnC/4KFbJ9300=;
        b=EGdvcrLCcev2iSj9V0y37xiyKkqcktPKd5PtSm8wsA+oOY+uH4WOBjQOe16lGaKShf
         vohIZwGtDpHPzO1ZUi/1bYcF1JIGPZw+UEXTZsERD4sfFM+pBu5lhi+IXj3Mu6dgqTa0
         yOmbZ0xVwKOlxnqHElrxN+XHmsWQdla8Z8vgWua8KEzdfBJzBA/TzdEg1mv47XnoSUGs
         5CMAzr4gEdupQRtq2z5MotSO5gyAlshVzQquRiesplM1VWPnRyCstVFf1ZSenI5UGmaT
         PQOXcz0kTZvMfw1L0bZOBmjguZD/oq40T19NrmM8BsVqa4wePbCSNXZWzc61nCgxP3d3
         19ng==
X-Forwarded-Encrypted: i=1; AJvYcCUU7tjvtUK8HQ7W4wOOTAIV7QY9eER24d0kDvKrqtqXw0UFLd/u0OJys2KdIY76SboSNa5+Iobt@vger.kernel.org, AJvYcCVZbY7Cr6xOL1QZBobCkmTL0Z+YYQ7sMjuLS9vzdKVHQ4v2inxVgeOH+xjTMwZ8ZQJhZ9fpofpq4BLNlRMb@vger.kernel.org, AJvYcCVpkhHmerbWh4T3tXzU52qHarEK10cldP6CLC0h+N/Ik8ZcVtJJ37KnF18dIF5V1qV/xGErfZTXqu7G@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGviniqmLA5TYyb6sBnGrVZj8ROJpO4ieWR8denMntfg8oDN0
	0ySvPQ3l2S05s9Iy0RlYgMpLBHLcSRQUo/w5X1bgQJTldJzuNrz4
X-Gm-Gg: ASbGnctB5oNbVHDLdCPZXzmJWz1Cbi5jAPcGvxUjvdH66krXglnrufXD3FYQiqhHOCU
	3Clv6cgYQp/9E2+F49SsG7txyl2NdzEJZGuYTckeE0Ol58NtiL3zopVUz6M1p68r5vxV/k1hsJU
	905FPYwL2MJuC9On33gA8yGJJfma9r2N8NgkrdSRDgs9hgsSOVNx3CRyls3zHzsBL8M/9Tw6m/y
	dvh2n2SyV5IaxQfWM3gNg41Mas17rSsWBS9yM3GQXsD6hF0qeC2158nbDEtJP6bVK5K6HZVpAKv
	NCjiBIsrmUk4P8XdWa8=
X-Google-Smtp-Source: AGHT+IG+GiAtBGPpTQE85f77tOXGENuVzYIt60U4IGJKHUrD+jI9FtGvemriH/ywSCgC33RA64WzQQ==
X-Received: by 2002:a5d:584b:0:b0:382:4b52:ffcc with SMTP id ffacd0b85a97d-38645370be9mr432402f8f.0.1733751953093;
        Mon, 09 Dec 2024 05:45:53 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:52 -0800 (PST)
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
Subject: [net-next PATCH v11 9/9] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Mon,  9 Dec 2024 14:44:26 +0100
Message-ID: <20241209134459.27110-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
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
 MAINTAINERS                  |   1 +
 drivers/net/phy/Kconfig      |   5 +
 drivers/net/phy/Makefile     |   1 +
 drivers/net/phy/air_an8855.c | 267 +++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+)
 create mode 100644 drivers/net/phy/air_an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c42431a09b84..25490fcab5a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -725,6 +725,7 @@ F:	drivers/mfd/airoha-an8855.c
 F:	drivers/net/dsa/an8855.c
 F:	drivers/net/dsa/an8855.h
 F:	drivers/net/mdio/mdio-an8855.c
+F:	drivers/net/phy/air_an8855.c
 F:	drivers/nvmem/an8855-efuse.c
 
 AIROHA ETHERNET DRIVER
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 15828f4710a9..9b4a7c12b138 100644
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
index e6145153e837..38ca7432780e 100644
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
index 000000000000..7fab0854ef78
--- /dev/null
+++ b/drivers/net/phy/air_an8855.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
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
+#define AN8855_PHY_FLAGS_EN_CALIBRATION		BIT(0)
+
+struct air_an8855_priv {
+	u8 calibration_data[4];
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
+	struct device_node *node = dev->of_node;
+	struct air_an8855_priv *priv;
+
+	/* If we don't have a node, skip calib */
+	if (!node)
+		return 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
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
+	/* Apply calibration values, if needed.
+	 * AN8855_PHY_FLAGS_EN_CALIBRATION signal this.
+	 */
+	if (priv && phydev->dev_flags & AN8855_PHY_FLAGS_EN_CALIBRATION) {
+		u8 *calibration_data = priv->calibration_data;
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
2.45.2


