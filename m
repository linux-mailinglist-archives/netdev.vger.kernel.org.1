Return-Path: <netdev+bounces-148840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8F9E3421
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A46FB28BAD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC52191484;
	Wed,  4 Dec 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpysddYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249218F2DD;
	Wed,  4 Dec 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297130; cv=none; b=ROARj2orAADpEoKbgM/PB5tc2C5ECJratdWWwOpghC5SsQIKpE3BDrRExftd3F2t5qtZ5TERi1WKJwtHE1iWLXgDGyBCcjlIViR9B+mIziKR3x9ohFrtDEYIRgwbWFyEtY/YZdoYyfUO2Pzc5hbNDdwnIN1l03NCJvML3+yusto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297130; c=relaxed/simple;
	bh=M3jlA7yrm7rG830xMKi1WEU+ABtakU6tva/b+46ljDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1gvUaTbD9JhhBdYpbcXW1lBRC9T/hkaXgphv3NoNbDS27Xy+uf5FKmJpOwnglsA0o+NGieSSMyIh4D1iHxirtp8pV/AgRUkiaBkeFxqvm/S58kaM/a08+XXh5Juy6sHqvwjNIKKFaBRgEnXKLp7iDTjjk8Ke42/QWQcUW/qbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpysddYC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e35912f1so3148846f8f.3;
        Tue, 03 Dec 2024 23:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733297122; x=1733901922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8CtCaU0yM9tUyjV48yOo43YGnfMX+XDLG/mbHhARUM=;
        b=NpysddYCBhAVqveQhdKfjV0Pxw86rBQDXpIqtQIHDn4oAx3M+ZU19Zfdb8CzaM5Mb5
         9OQrjSCML3kemm7ZSSU+8Xgblh22md7K9MNa06rhut1t4GN6ZavlEFl4zUqvl4JPpTUq
         c7ikbciw/4ZqManxP/h03jrPW+MS7b1jUXW18YCSCZfCLFOU4Ec3oByYT7rnTalffp6L
         Z9JizzM1w/Vr1UqT0ReLj90xt5bwcdZIv6bnGvhw9qRyIKEubzyXXyPOQt8SJKA8hTmb
         hOc9OGMhxlSYdJjcm/sgmtuTfwsP+FVhLewScKbuk+UxZfkoJ/RFTMsJhJ5ZdV1ys1lI
         FJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297122; x=1733901922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8CtCaU0yM9tUyjV48yOo43YGnfMX+XDLG/mbHhARUM=;
        b=m9XhONWb2vYmHahfnuJSFumO/EhYPoUDp2toJ9GEFcCfNrkAYeMkuVGqk8CKdrvWCW
         tGddvpEyN8shGAWb+RXLZ1LcqtegD7H+JFHyUAwI1wG6Ik2JE36pimYTPUQ1xZN6ne1R
         98DUmMJiP+bz1VzQkjXQZ3aY/1HUPjdwZemMP+3j770Ij+Vbs5zYpdON1lrx4QIuF/J6
         varia8bvwXWisvcGYrZayc6kIJnFk7CyYoyJO3PXfE6BHgeHalsArw+nKoH0xF0XXgaM
         rr9rj1jEcVTBuW5c72nU8YL5eAMt0cIkFMqcRVImeTX6xNTz8rw9V9cJi2kUtfs7llIR
         KWgA==
X-Forwarded-Encrypted: i=1; AJvYcCWCfGkGOQNwOcW0Mica3oAIf6CKkmn68z8Hy6ZTDPGq38CBOUsI1gw5XybOriar2xGlHKZByU4jwMjh1Cn3@vger.kernel.org, AJvYcCWIbACTeCmzTqHXriu+D7h4QyUGIDhWSoLm0vGTDBABKD0qiXB/ecpVwIihyjKgyFCxrVoUaKmZoihd@vger.kernel.org, AJvYcCXYccBZWxqjO+hUVqeeWoIfwG7Ew9I25Ph0XmsqxRTWFASM1/iFwBQ/uCxAXuko02nhJTikuS2U@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRvP7EKxXyibVfAppri4Ta7Lza/kjQZytujCR0QckkTLxJ22t
	ASlFGSEXx0pPQSRk3Gk1FiUqWZ/3s+8QgikRepLGxWRv2mb2olJR
X-Gm-Gg: ASbGncsRhVEjv2HuxFPCruyUyseNQfD+hCMKaze5uPqgVym8VHUD6AVsaLRrTwvbqic
	RPYYzzSm7ZUYKyZmCdn2iPf70DxykCSxwwnDddPrYox7Kp9/KVdmm9ohd4YKmrbgjMb0Z+Ewj8t
	zJ/U/HXZkOCPYQ18+j95fmKd1WvbXpdO/6R67oFcqfG270v17H0jy9bGzAz80LLnD24ougjCOim
	ZfnfEEQOcx2gfMpeKTz3Z3S+dElKjtbnG4+mjU1fLiJ1o68VGOBEoNvxt6O5/qupdX3sPKcbEAx
	dYbPo7lOXiQ4xPW38jk=
X-Google-Smtp-Source: AGHT+IEKMx6Rh51w0bnI5DXiG29cYgXM6tRa2+hvjHxg3Y7VIi+Atny6ifueAs4HJWL3GMuxeRyTgA==
X-Received: by 2002:a05:6000:1787:b0:385:f9ed:1632 with SMTP id ffacd0b85a97d-385fd3ebd6cmr4692350f8f.28.1733297121896;
        Tue, 03 Dec 2024 23:25:21 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d527257dsm14396655e9.1.2024.12.03.23.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:25:20 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
Date: Wed,  4 Dec 2024 08:24:10 +0100
Message-ID: <20241204072427.17778-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204072427.17778-1-ansuelsmth@gmail.com>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 5-Port Gigabit DSA switch.

The switch is also a nvmem-provider as it does have EFUSE to calibrate
the internal PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS              |   10 +
 drivers/net/dsa/Kconfig  |    9 +
 drivers/net/dsa/Makefile |    1 +
 drivers/net/dsa/an8855.c | 2673 ++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/an8855.h |  810 ++++++++++++
 5 files changed, 3503 insertions(+)
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16933f9faa0f..e3077d9feee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -717,6 +717,16 @@ S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
 
+AIROHA DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 2d10b4d6cfbb..6b6d0b7bae72 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -24,6 +24,15 @@ config NET_DSA_LOOP
 	  This enables support for a fake mock-up switch chip which
 	  exercises the DSA APIs.
 
+
+config NET_DSA_AN8855
+	tristate "Airoha AN8855 Ethernet switch support"
+	depends on NET_DSA
+	select NET_DSA_TAG_MTK
+	help
+	  This enables support for the Airoha AN8855 Ethernet switch
+	  chip.
+
 source "drivers/net/dsa/hirschmann/Kconfig"
 
 config NET_DSA_LANTIQ_GSWIP
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index cb9a97340e58..a74afb41a491 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
 ifdef CONFIG_NET_DSA_LOOP
 obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
 endif
+obj-$(CONFIG_NET_DSA_AN8855)	+= an8855.o
 obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
diff --git a/drivers/net/dsa/an8855.c b/drivers/net/dsa/an8855.c
new file mode 100644
index 000000000000..fbbfd4445f75
--- /dev/null
+++ b/drivers/net/dsa/an8855.c
@@ -0,0 +1,2673 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Airoha AN8855 DSA Switch driver
+ * Copyright (C) 2023 Min Yao <min.yao@airoha.com>
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/ethtool.h>
+#include <linux/etherdevice.h>
+#include <linux/gpio/consumer.h>
+#include <linux/if_bridge.h>
+#include <linux/iopoll.h>
+#include <linux/mdio.h>
+#include <linux/netdevice.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phylink.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "an8855.h"
+
+static const struct an8855_mib_desc an8855_mib[] = {
+	MIB_DESC(1, AN8855_PORT_MIB_TX_DROP, "TxDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_TX_CRC_ERR, "TxCrcErr"),
+	MIB_DESC(1, AN8855_PORT_MIB_TX_COLLISION, "TxCollision"),
+	MIB_DESC(1, AN8855_PORT_MIB_TX_OVERSIZE_DROP, "TxOversizeDrop"),
+	MIB_DESC(2, AN8855_PORT_MIB_TX_BAD_PKT_BYTES, "TxBadPktBytes"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_DROP, "RxDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_FILTERING, "RxFiltering"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_CRC_ERR, "RxCrcErr"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_CTRL_DROP, "RxCtrlDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_INGRESS_DROP, "RxIngressDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_FLOW_CONTROL_DROP, "FlowControlDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_WRED_DROP, "WredDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_MIRROR_DROP, "MirrorDrop"),
+	MIB_DESC(2, AN8855_PORT_MIB_RX_BAD_PKT_BYTES, "RxBadPktBytes"),
+	MIB_DESC(1, AN8855_PORT_MIB_RXS_FLOW_SAMPLING_PKT_DROP, "RxsFlowSamplingPktDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_RXS_FLOW_TOTAL_PKT_DROP, "RxsFlowTotalPktDrop"),
+	MIB_DESC(1, AN8855_PORT_MIB_PORT_CONTROL_DROP, "PortControlDrop"),
+};
+
+static int an8855_mii_set_page(struct mii_bus *bus, u8 phy_id, u8 page)
+{
+	int ret;
+
+	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
+	if (ret < 0)
+		dev_err_ratelimited(&bus->dev,
+				    "failed to set an8855 mii page\n");
+
+	return ret;
+}
+
+static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg, u32 *val)
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
+	struct an8855_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_read32(bus, priv->phy_base,
+				reg, val);
+
+exit:
+	an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_STANDARD);
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg, u32 val)
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
+	struct an8855_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_write32(priv->bus, priv->phy_base,
+				 reg, val);
+
+exit:
+	an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_STANDARD);
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int
+an8855_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask, uint32_t write_val)
+{
+	struct an8855_priv *priv = ctx;
+	struct mii_bus *bus = priv->bus;
+	u32 val;
+	int ret;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		goto exit;
+
+	ret = an8855_mii_read32(bus, priv->phy_base, reg, &val);
+	if (ret < 0)
+		goto exit;
+
+	val &= ~mask;
+	val |= write_val;
+	ret = an8855_mii_write32(bus, priv->phy_base, reg, val);
+
+exit:
+	an8855_mii_set_page(bus, priv->phy_base, AN8855_PHY_PAGE_STANDARD);
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
+static int
+an8855_mib_init(struct an8855_priv *priv)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, AN8855_MIB_CCR,
+			   AN8855_CCR_MIB_ENABLE);
+	if (ret)
+		return ret;
+
+	return regmap_write(priv->regmap, AN8855_MIB_CCR,
+			    AN8855_CCR_MIB_ACTIVATE);
+}
+
+static void an8855_fdb_write(struct an8855_priv *priv, u16 vid,
+			     u8 port_mask, const u8 *mac,
+			     bool add) __must_hold(&priv->reg_mutex)
+{
+	u32 mac_reg[2] = { };
+	u32 reg;
+
+	mac_reg[0] |= FIELD_PREP(AN8855_ATA1_MAC0, mac[0]);
+	mac_reg[0] |= FIELD_PREP(AN8855_ATA1_MAC1, mac[1]);
+	mac_reg[0] |= FIELD_PREP(AN8855_ATA1_MAC2, mac[2]);
+	mac_reg[0] |= FIELD_PREP(AN8855_ATA1_MAC3, mac[3]);
+	mac_reg[1] |= FIELD_PREP(AN8855_ATA2_MAC4, mac[4]);
+	mac_reg[1] |= FIELD_PREP(AN8855_ATA2_MAC5, mac[5]);
+
+	regmap_bulk_write(priv->regmap, AN8855_ATA1, mac_reg,
+			  ARRAY_SIZE(mac_reg));
+
+	reg = AN8855_ATWD_IVL;
+	if (add)
+		reg |= AN8855_ATWD_VLD;
+	reg |= FIELD_PREP(AN8855_ATWD_VID, vid);
+	reg |= FIELD_PREP(AN8855_ATWD_FID, AN8855_FID_BRIDGED);
+	regmap_write(priv->regmap, AN8855_ATWD, reg);
+	regmap_write(priv->regmap, AN8855_ATWD2,
+		     FIELD_PREP(AN8855_ATWD2_PORT, port_mask));
+}
+
+static void an8855_fdb_read(struct an8855_priv *priv, struct an8855_fdb *fdb)
+{
+	u32 reg[4];
+
+	regmap_bulk_read(priv->regmap, AN8855_ATRD0, reg,
+			 ARRAY_SIZE(reg));
+
+	fdb->live = FIELD_GET(AN8855_ATRD0_LIVE, reg[0]);
+	fdb->type = FIELD_GET(AN8855_ATRD0_TYPE, reg[0]);
+	fdb->ivl = FIELD_GET(AN8855_ATRD0_IVL, reg[0]);
+	fdb->vid = FIELD_GET(AN8855_ATRD0_VID, reg[0]);
+	fdb->fid = FIELD_GET(AN8855_ATRD0_FID, reg[0]);
+	fdb->aging = FIELD_GET(AN8855_ATRD1_AGING, reg[1]);
+	fdb->port_mask = FIELD_GET(AN8855_ATRD3_PORTMASK, reg[3]);
+	fdb->mac[0] = FIELD_GET(AN8855_ATRD2_MAC0, reg[2]);
+	fdb->mac[1] = FIELD_GET(AN8855_ATRD2_MAC1, reg[2]);
+	fdb->mac[2] = FIELD_GET(AN8855_ATRD2_MAC2, reg[2]);
+	fdb->mac[3] = FIELD_GET(AN8855_ATRD2_MAC3, reg[2]);
+	fdb->mac[4] = FIELD_GET(AN8855_ATRD1_MAC4, reg[1]);
+	fdb->mac[5] = FIELD_GET(AN8855_ATRD1_MAC5, reg[1]);
+	fdb->noarp = !!FIELD_GET(AN8855_ATRD0_ARP, reg[0]);
+}
+
+static int an8855_fdb_cmd(struct an8855_priv *priv, u32 cmd,
+			  u32 *rsp) __must_hold(&priv->reg_mutex)
+{
+	u32 val;
+	int ret;
+
+	/* Set the command operating upon the MAC address entries */
+	val = AN8855_ATC_BUSY | cmd;
+	ret = regmap_write(priv->regmap, AN8855_ATC, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(priv->regmap, AN8855_ATC, val,
+				       !(val & AN8855_ATC_BUSY), 20, 200000);
+	if (ret)
+		return ret;
+
+	if (rsp)
+		*rsp = val;
+
+	return 0;
+}
+
+static void
+an8855_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct an8855_priv *priv = ds->priv;
+	bool learning = false;
+	u32 stp_state;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		stp_state = AN8855_STP_DISABLED;
+		break;
+	case BR_STATE_BLOCKING:
+		stp_state = AN8855_STP_BLOCKING;
+		break;
+	case BR_STATE_LISTENING:
+		stp_state = AN8855_STP_LISTENING;
+		break;
+	case BR_STATE_LEARNING:
+		stp_state = AN8855_STP_LEARNING;
+		learning = dp->learning;
+		break;
+	case BR_STATE_FORWARDING:
+		learning = dp->learning;
+		fallthrough;
+	default:
+		stp_state = AN8855_STP_FORWARDING;
+		break;
+	}
+
+	regmap_update_bits(priv->regmap, AN8855_SSP_P(port),
+			   AN8855_FID_PST_MASK(AN8855_FID_BRIDGED),
+			   AN8855_FID_PST_VAL(AN8855_FID_BRIDGED, stp_state));
+
+	regmap_update_bits(priv->regmap, AN8855_PSC_P(port), AN8855_SA_DIS,
+			   learning ? 0 : AN8855_SA_DIS);
+}
+
+static void an8855_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	/* Set to clean Dynamic entry */
+	ret = regmap_write(priv->regmap, AN8855_ATA2, AN8855_ATA2_TYPE);
+	if (ret)
+		return;
+
+	/* Set Port */
+	ret = regmap_write(priv->regmap, AN8855_ATWD2,
+			   FIELD_PREP(AN8855_ATWD2_PORT, BIT(port)));
+	if (ret)
+		return;
+
+	/* Flush Dynamic entry at port */
+	an8855_fdb_cmd(priv, AN8855_ATC_MAT(AND8855_FDB_MAT_MAC_TYPE_PORT) |
+		       AN8855_FDB_FLUSH, NULL);
+}
+
+static int an8855_update_port_member(struct dsa_switch *ds, int port,
+				     const struct net_device *bridge_dev,
+				     bool join)
+{
+	struct an8855_priv *priv = ds->priv;
+	bool isolated, other_isolated;
+	struct dsa_port *dp;
+	u32 port_mask = 0;
+	int ret;
+
+	isolated = !!(priv->port_isolated_map & BIT(port));
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->index == port)
+			continue;
+
+		if (!dsa_port_offloads_bridge_dev(dp, bridge_dev))
+			continue;
+
+		other_isolated = !!(priv->port_isolated_map & BIT(dp->index));
+		port_mask |= BIT(dp->index);
+		/* Add/remove this port to the portvlan mask of the other
+		 * ports in the bridge
+		 */
+		if (join && !(isolated && other_isolated))
+			ret = regmap_set_bits(priv->regmap,
+					      AN8855_PORTMATRIX_P(dp->index),
+					      FIELD_PREP(AN8855_USER_PORTMATRIX,
+							 BIT(port)));
+		else
+			ret = regmap_clear_bits(priv->regmap,
+						AN8855_PORTMATRIX_P(dp->index),
+						FIELD_PREP(AN8855_USER_PORTMATRIX,
+							   BIT(port)));
+		if (ret)
+			return ret;
+	}
+
+	/* Add/remove all other ports to this port's portvlan mask */
+	return regmap_update_bits(priv->regmap, AN8855_PORTMATRIX_P(port),
+				  AN8855_USER_PORTMATRIX,
+				  join ? port_mask : ~port_mask);
+}
+
+static int an8855_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					struct switchdev_brport_flags flags,
+					struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
+			   BR_BCAST_FLOOD | BR_ISOLATED))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int an8855_port_bridge_flags(struct dsa_switch *ds, int port,
+				    struct switchdev_brport_flags flags,
+				    struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	if (flags.mask & BR_LEARNING) {
+		ret = regmap_update_bits(priv->regmap, AN8855_PSC_P(port), AN8855_SA_DIS,
+					 flags.val & BR_LEARNING ? 0 : AN8855_SA_DIS);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_FLOOD) {
+		ret = regmap_update_bits(priv->regmap, AN8855_UNUF, BIT(port),
+					 flags.val & BR_FLOOD ? BIT(port) : 0);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_MCAST_FLOOD) {
+		ret = regmap_update_bits(priv->regmap, AN8855_UNMF, BIT(port),
+					 flags.val & BR_MCAST_FLOOD ? BIT(port) : 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(priv->regmap, AN8855_UNIPMF, BIT(port),
+					 flags.val & BR_MCAST_FLOOD ? BIT(port) : 0);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_BCAST_FLOOD) {
+		ret = regmap_update_bits(priv->regmap, AN8855_BCF, BIT(port),
+					 flags.val & BR_BCAST_FLOOD ? BIT(port) : 0);
+		if (ret)
+			return ret;
+	}
+
+	if (flags.mask & BR_ISOLATED) {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
+
+		if (flags.val & BR_ISOLATED)
+			priv->port_isolated_map |= BIT(port);
+		else
+			priv->port_isolated_map &= ~BIT(port);
+
+		ret = an8855_update_port_member(ds, port, bridge_dev, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int an8855_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 age_count, age_unit, val;
+
+	/* Convert msec in AN8855_L2_AGING_MS_CONSTANT counter */
+	val = msecs / AN8855_L2_AGING_MS_CONSTANT;
+	/* Derive the count unit */
+	age_unit = val / FIELD_MAX(AN8855_AGE_UNIT);
+	/* Get the count in unit, age_unit is always incremented by 1 internally */
+	age_count = val / (age_unit + 1);
+
+	return regmap_update_bits(priv->regmap, AN8855_AAC,
+				  AN8855_AGE_CNT | AN8855_AGE_UNIT,
+				  FIELD_PREP(AN8855_AGE_CNT, age_count) |
+				  FIELD_PREP(AN8855_AGE_UNIT, age_unit));
+}
+
+static int an8855_port_bridge_join(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge,
+				   bool *tx_fwd_offload,
+				   struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+	int ret;
+
+	ret = an8855_update_port_member(ds, port, bridge.dev, true);
+	if (ret)
+		return ret;
+
+	/* Set to fallback mode for independent VLAN learning if in a bridge */
+	return regmap_update_bits(priv->regmap, AN8855_PCR_P(port),
+				  AN8855_PORT_VLAN,
+				  FIELD_PREP(AN8855_PORT_VLAN,
+					     AN8855_PORT_FALLBACK_MODE));
+}
+
+static void an8855_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	an8855_update_port_member(ds, port, bridge.dev, false);
+
+	/* When a port is removed from the bridge, the port would be set up
+	 * back to the default as is at initial boot which is a VLAN-unaware
+	 * port.
+	 */
+	regmap_update_bits(priv->regmap, AN8855_PCR_P(port),
+			   AN8855_PORT_VLAN,
+			   FIELD_PREP(AN8855_PORT_VLAN,
+				      AN8855_PORT_MATRIX_MODE));
+}
+
+static int an8855_port_fdb_add(struct dsa_switch *ds, int port,
+			       const unsigned char *addr, u16 vid,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+	u8 port_mask = BIT(port);
+	int ret;
+
+	/* Set the vid to the port vlan id if no vid is set */
+	if (!vid)
+		vid = AN8855_PORT_VID_DEFAULT;
+
+	mutex_lock(&priv->reg_mutex);
+	an8855_fdb_write(priv, vid, port_mask, addr, true);
+	ret = an8855_fdb_cmd(priv, AN8855_FDB_WRITE, NULL);
+	mutex_unlock(&priv->reg_mutex);
+
+	return ret;
+}
+
+static int an8855_port_fdb_del(struct dsa_switch *ds, int port,
+			       const unsigned char *addr, u16 vid,
+			       struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+	u8 port_mask = BIT(port);
+	int ret;
+
+	/* Set the vid to the port vlan id if no vid is set */
+	if (!vid)
+		vid = AN8855_PORT_VID_DEFAULT;
+
+	mutex_lock(&priv->reg_mutex);
+	an8855_fdb_write(priv, vid, port_mask, addr, false);
+	ret = an8855_fdb_cmd(priv, AN8855_FDB_WRITE, NULL);
+	mutex_unlock(&priv->reg_mutex);
+
+	return ret;
+}
+
+static int an8855_port_fdb_dump(struct dsa_switch *ds, int port,
+				dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct an8855_priv *priv = ds->priv;
+	int banks, count = 0;
+	u32 rsp;
+	int ret;
+	int i;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Load search port */
+	ret = regmap_write(priv->regmap, AN8855_ATWD2,
+			   FIELD_PREP(AN8855_ATWD2_PORT, BIT(port)));
+	if (ret)
+		goto exit;
+	ret = an8855_fdb_cmd(priv, AN8855_ATC_MAT(AND8855_FDB_MAT_MAC_PORT) |
+			     AN8855_FDB_START, &rsp);
+	if (ret < 0)
+		goto exit;
+
+	do {
+		/* From response get the number of banks to read, exit if 0 */
+		banks = FIELD_GET(AN8855_ATC_HIT, rsp);
+		if (!banks)
+			break;
+
+		/* Each banks have 4 entry */
+		for (i = 0; i < 4; i++) {
+			struct an8855_fdb _fdb = {  };
+
+			count++;
+
+			/* Check if bank is present */
+			if (!(banks & BIT(i)))
+				continue;
+
+			/* Select bank entry index */
+			ret = regmap_write(priv->regmap, AN8855_ATRDS,
+					   FIELD_PREP(AN8855_ATRD_SEL, i));
+			if (ret)
+				break;
+			/* wait 1ms for the bank entry to be filled */
+			usleep_range(1000, 1500);
+			an8855_fdb_read(priv, &_fdb);
+
+			if (!_fdb.live)
+				continue;
+			ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp, data);
+			if (ret < 0)
+				break;
+		}
+
+		/* Stop if reached max FDB number */
+		if (count >= AN8855_NUM_FDB_RECORDS)
+			break;
+
+		/* Read next bank */
+		ret = an8855_fdb_cmd(priv, AN8855_ATC_MAT(AND8855_FDB_MAT_MAC_PORT) |
+				     AN8855_FDB_NEXT, &rsp);
+		if (ret < 0)
+			break;
+	} while (true);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+	return ret;
+}
+
+static int an8855_vlan_cmd(struct an8855_priv *priv, enum an8855_vlan_cmd cmd,
+			   u16 vid) __must_hold(&priv->reg_mutex)
+{
+	u32 val;
+	int ret;
+
+	val = AN8855_VTCR_BUSY | FIELD_PREP(AN8855_VTCR_FUNC, cmd) |
+	      FIELD_PREP(AN8855_VTCR_VID, vid);
+	ret = regmap_write(priv->regmap, AN8855_VTCR, val);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(priv->regmap, AN8855_VTCR, val,
+					!(val & AN8855_VTCR_BUSY), 20, 200000);
+}
+
+static int an8855_vlan_add(struct an8855_priv *priv, u8 port, u16 vid,
+			   bool untagged) __must_hold(&priv->reg_mutex)
+{
+	u32 port_mask;
+	u32 val;
+	int ret;
+
+	/* Fetch entry */
+	ret = an8855_vlan_cmd(priv, AN8855_VTCR_RD_VID, vid);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, AN8855_VARD0, &val);
+	if (ret)
+		return ret;
+	port_mask = FIELD_GET(AN8855_VA0_PORT, val) | BIT(port);
+
+	/* Validate the entry with independent learning, create egress tag per
+	 * VLAN and joining the port as one of the port members.
+	 */
+	val = (val & AN8855_VA0_ETAG) | AN8855_VA0_IVL_MAC |
+	      AN8855_VA0_VTAG_EN | AN8855_VA0_VLAN_VALID |
+	      FIELD_PREP(AN8855_VA0_PORT, port_mask) |
+	      FIELD_PREP(AN8855_VA0_FID, AN8855_FID_BRIDGED);
+	ret = regmap_write(priv->regmap, AN8855_VAWD0, val);
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->regmap, AN8855_VAWD1, 0);
+	if (ret)
+		return ret;
+
+	/* CPU port is always taken as a tagged port for serving more than one
+	 * VLANs across and also being applied with egress type stack mode for
+	 * that VLAN tags would be appended after hardware special tag used as
+	 * DSA tag.
+	 */
+	if (port == AN8855_CPU_PORT)
+		val = AN8855_VLAN_EGRESS_STACK;
+	/* Decide whether adding tag or not for those outgoing packets from the
+	 * port inside the VLAN.
+	 */
+	else
+		val = untagged ? AN8855_VLAN_EGRESS_UNTAG : AN8855_VLAN_EGRESS_TAG;
+	ret = regmap_update_bits(priv->regmap, AN8855_VAWD0,
+				 AN8855_VA0_ETAG_PORT_MASK(port),
+				 AN8855_VA0_ETAG_PORT_VAL(port, val));
+	if (ret)
+		return ret;
+
+	/* Flush result to hardware */
+	return an8855_vlan_cmd(priv, AN8855_VTCR_WR_VID, vid);
+}
+
+static int an8855_vlan_del(struct an8855_priv *priv, u8 port,
+			   u16 vid) __must_hold(&priv->reg_mutex)
+{
+	u32 port_mask;
+	u32 val;
+	int ret;
+
+	/* Fetch entry */
+	ret = an8855_vlan_cmd(priv, AN8855_VTCR_RD_VID, vid);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, AN8855_VARD0, &val);
+	if (ret)
+		return ret;
+	port_mask = FIELD_GET(AN8855_VA0_PORT, val) & ~BIT(port);
+
+	if (!(val & AN8855_VA0_VLAN_VALID)) {
+		dev_err(priv->dev, "Cannot be deleted due to invalid entry\n");
+		return -EINVAL;
+	}
+
+	if (port_mask) {
+		val = (val & AN8855_VA0_ETAG) | AN8855_VA0_IVL_MAC |
+		       AN8855_VA0_VTAG_EN | AN8855_VA0_VLAN_VALID |
+		       FIELD_PREP(AN8855_VA0_PORT, port_mask);
+		ret = regmap_write(priv->regmap, AN8855_VAWD0, val);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(priv->regmap, AN8855_VAWD0, 0);
+		if (ret)
+			return ret;
+	}
+	ret = regmap_write(priv->regmap, AN8855_VAWD1, 0);
+	if (ret)
+		return ret;
+
+	/* Flush result to hardware */
+	return an8855_vlan_cmd(priv, AN8855_VTCR_WR_VID, vid);
+}
+
+static int an8855_port_set_vlan_mode(struct an8855_priv *priv, int port,
+				     enum an8855_port_mode port_mode,
+				     enum an8855_vlan_port_eg_tag eg_tag,
+				     enum an8855_vlan_port_attr vlan_attr,
+				     enum an8855_vlan_port_acc_frm acc_frm)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_PCR_P(port),
+				 AN8855_PORT_VLAN,
+				 FIELD_PREP(AN8855_PORT_VLAN, port_mode));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, AN8855_PVC_P(port),
+				  AN8855_PVC_EG_TAG | AN8855_VLAN_ATTR | AN8855_ACC_FRM,
+				  FIELD_PREP(AN8855_PVC_EG_TAG, eg_tag) |
+				  FIELD_PREP(AN8855_VLAN_ATTR, vlan_attr) |
+				  FIELD_PREP(AN8855_ACC_FRM, acc_frm));
+}
+
+static int an8855_port_set_pid(struct an8855_priv *priv, int port,
+			       u16 pid)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_PPBV1_P(port),
+				 AN8855_PPBV_G0_PORT_VID,
+				 FIELD_PREP(AN8855_PPBV_G0_PORT_VID, pid));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, AN8855_PVID_P(port),
+				  AN8855_G0_PORT_VID,
+				  FIELD_PREP(AN8855_G0_PORT_VID, pid));
+}
+
+static int an8855_port_vlan_filtering(struct dsa_switch *ds, int port,
+				      bool vlan_filtering,
+				      struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	/* The port is being kept as VLAN-unaware port when bridge is
+	 * set up with vlan_filtering not being set, Otherwise, the
+	 * port and the corresponding CPU port is required the setup
+	 * for becoming a VLAN-aware port.
+	 */
+	if (vlan_filtering) {
+		u32 acc_frm;
+		/* CPU port is set to fallback mode to let untagged
+		 * frames pass through.
+		 */
+		ret = an8855_port_set_vlan_mode(priv, AN8855_CPU_PORT,
+						AN8855_PORT_FALLBACK_MODE,
+						AN8855_VLAN_EG_CONSISTENT,
+						AN8855_VLAN_USER,
+						AN8855_VLAN_ACC_ALL);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(priv->regmap, AN8855_PVID_P(port), &val);
+		if (ret)
+			return ret;
+
+		/* Only accept tagged frames if PVID is not set */
+		if (FIELD_GET(AN8855_G0_PORT_VID, val) != AN8855_PORT_VID_DEFAULT)
+			acc_frm = AN8855_VLAN_ACC_TAGGED;
+		else
+			acc_frm = AN8855_VLAN_ACC_ALL;
+
+		/* Trapped into security mode allows packet forwarding through VLAN
+		 * table lookup.
+		 * Set the port as a user port which is to be able to recognize VID
+		 * from incoming packets before fetching entry within the VLAN table.
+		 */
+		ret = an8855_port_set_vlan_mode(priv, port,
+						AN8855_PORT_SECURITY_MODE,
+						AN8855_VLAN_EG_DISABLED,
+						AN8855_VLAN_USER,
+						acc_frm);
+		if (ret)
+			return ret;
+	} else {
+		bool disable_cpu_vlan = true;
+		struct dsa_port *dp;
+		u32 port_mode;
+
+		/* This is called after .port_bridge_leave when leaving a VLAN-aware
+		 * bridge. Don't set standalone ports to fallback mode.
+		 */
+		if (dsa_port_bridge_dev_get(dsa_to_port(ds, port)))
+			port_mode = AN8855_PORT_FALLBACK_MODE;
+		else
+			port_mode = AN8855_PORT_MATRIX_MODE;
+
+		/* When a port is removed from the bridge, the port would be set up
+		 * back to the default as is at initial boot which is a VLAN-unaware
+		 * port.
+		 */
+		ret = an8855_port_set_vlan_mode(priv, port, port_mode,
+						AN8855_VLAN_EG_CONSISTENT,
+						AN8855_VLAN_TRANSPARENT,
+						AN8855_VLAN_ACC_ALL);
+		if (ret)
+			return ret;
+
+		/* Restore default PVID */
+		ret = an8855_port_set_pid(priv, port, AN8855_PORT_VID_DEFAULT);
+		if (ret)
+			return ret;
+
+		dsa_switch_for_each_user_port(dp, ds) {
+			if (dsa_port_is_vlan_filtering(dp)) {
+				disable_cpu_vlan = false;
+				break;
+			}
+		}
+
+		if (disable_cpu_vlan) {
+			ret = an8855_port_set_vlan_mode(priv, AN8855_CPU_PORT,
+							AN8855_PORT_MATRIX_MODE,
+							AN8855_VLAN_EG_CONSISTENT,
+							AN8855_VLAN_USER,
+							AN8855_VLAN_ACC_ALL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int an8855_port_vlan_add(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_vlan *vlan,
+				struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct an8855_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+	ret = an8855_vlan_add(priv, port, vlan->vid, untagged);
+	mutex_unlock(&priv->reg_mutex);
+	if (ret)
+		return ret;
+
+	if (pvid) {
+		/* Accept all frames if PVID is set */
+		regmap_update_bits(priv->regmap, AN8855_PVC_P(port), AN8855_ACC_FRM,
+				   FIELD_PREP(AN8855_ACC_FRM, AN8855_VLAN_ACC_ALL));
+
+		/* Only configure PVID if VLAN filtering is enabled */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+			ret = an8855_port_set_pid(priv, port, vlan->vid);
+			if (ret)
+				return ret;
+		}
+	} else if (vlan->vid) {
+		ret = regmap_read(priv->regmap, AN8855_PVID_P(port), &val);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(AN8855_G0_PORT_VID, val) != vlan->vid)
+			return 0;
+
+		/* This VLAN is overwritten without PVID, so unset it */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+			ret = regmap_update_bits(priv->regmap, AN8855_PVC_P(port),
+						 AN8855_ACC_FRM,
+						 FIELD_PREP(AN8855_ACC_FRM,
+							    AN8855_VLAN_ACC_TAGGED));
+			if (ret)
+				return ret;
+		}
+
+		ret = an8855_port_set_pid(priv, port, AN8855_PORT_VID_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int an8855_port_vlan_del(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_vlan *vlan)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+	ret = an8855_vlan_del(priv, port, vlan->vid);
+	mutex_unlock(&priv->reg_mutex);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, AN8855_PVID_P(port), &val);
+	if (ret)
+		return ret;
+
+	/* PVID is being restored to the default whenever the PVID port
+	 * is being removed from the VLAN.
+	 */
+	if (FIELD_GET(AN8855_G0_PORT_VID, val) == vlan->vid) {
+		/* Only accept tagged frames if the port is VLAN-aware */
+		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+			ret = regmap_update_bits(priv->regmap, AN8855_PVC_P(port),
+						 AN8855_ACC_FRM,
+						 FIELD_PREP(AN8855_ACC_FRM,
+							    AN8855_VLAN_ACC_TAGGED));
+			if (ret)
+				return ret;
+		}
+
+		ret = an8855_port_set_pid(priv, port, AN8855_PORT_VID_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+an8855_port_mdb_add(struct dsa_switch *ds, int port,
+		    const struct switchdev_obj_port_mdb *mdb,
+		    struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	u8 port_mask = 0;
+	u32 val;
+	int ret;
+
+	/* Set the vid to the port vlan id if no vid is set */
+	if (!vid)
+		vid = AN8855_PORT_VID_DEFAULT;
+
+	mutex_lock(&priv->reg_mutex);
+
+	an8855_fdb_write(priv, vid, 0, addr, false);
+	if (!an8855_fdb_cmd(priv, AN8855_FDB_READ, NULL)) {
+		ret = regmap_read(priv->regmap, AN8855_ATRD3, &val);
+		if (ret)
+			goto exit;
+
+		port_mask = FIELD_GET(AN8855_ATRD3_PORTMASK, val);
+	}
+
+	port_mask |= BIT(port);
+	an8855_fdb_write(priv, vid, port_mask, addr, true);
+	ret = an8855_fdb_cmd(priv, AN8855_FDB_WRITE, NULL);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+
+	return ret;
+}
+
+static int
+an8855_port_mdb_del(struct dsa_switch *ds, int port,
+		    const struct switchdev_obj_port_mdb *mdb,
+		    struct dsa_db db)
+{
+	struct an8855_priv *priv = ds->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	u8 port_mask = 0;
+	u32 val;
+	int ret;
+
+	/* Set the vid to the port vlan id if no vid is set */
+	if (!vid)
+		vid = AN8855_PORT_VID_DEFAULT;
+
+	mutex_lock(&priv->reg_mutex);
+
+	an8855_fdb_write(priv, vid, 0, addr, 0);
+	if (!an8855_fdb_cmd(priv, AN8855_FDB_READ, NULL)) {
+		ret = regmap_read(priv->regmap, AN8855_ATRD3, &val);
+		if (ret)
+			goto exit;
+
+		port_mask = FIELD_GET(AN8855_ATRD3_PORTMASK, val);
+	}
+
+	port_mask &= ~BIT(port);
+	an8855_fdb_write(priv, vid, port_mask, addr, port_mask ? true : false);
+	ret = an8855_fdb_cmd(priv, AN8855_FDB_WRITE, NULL);
+
+exit:
+	mutex_unlock(&priv->reg_mutex);
+
+	return ret;
+}
+
+static int
+an8855_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	struct an8855_priv *priv = ds->priv;
+	int length;
+	u32 val;
+
+	/* When a new MTU is set, DSA always set the CPU port's MTU to the
+	 * largest MTU of the slave ports. Because the switch only has a global
+	 * RX length register, only allowing CPU port here is enough.
+	 */
+	if (!dsa_is_cpu_port(ds, port))
+		return 0;
+
+	/* RX length also includes Ethernet header, MTK tag, and FCS length */
+	length = new_mtu + ETH_HLEN + MTK_TAG_LEN + ETH_FCS_LEN;
+	if (length <= 1522)
+		val = AN8855_MAX_RX_PKT_1518_1522;
+	else if (length <= 1536)
+		val = AN8855_MAX_RX_PKT_1536;
+	else if (length <= 1552)
+		val = AN8855_MAX_RX_PKT_1552;
+	else if (length <= 3072)
+		val = AN8855_MAX_RX_JUMBO_3K;
+	else if (length <= 4096)
+		val = AN8855_MAX_RX_JUMBO_4K;
+	else if (length <= 5120)
+		val = AN8855_MAX_RX_JUMBO_5K;
+	else if (length <= 6144)
+		val = AN8855_MAX_RX_JUMBO_6K;
+	else if (length <= 7168)
+		val = AN8855_MAX_RX_JUMBO_7K;
+	else if (length <= 8192)
+		val = AN8855_MAX_RX_JUMBO_8K;
+	else if (length <= 9216)
+		val = AN8855_MAX_RX_JUMBO_9K;
+	else if (length <= 12288)
+		val = AN8855_MAX_RX_JUMBO_12K;
+	else if (length <= 15360)
+		val = AN8855_MAX_RX_JUMBO_15K;
+	else
+		val = AN8855_MAX_RX_JUMBO_16K;
+
+	/* Enable JUMBO packet */
+	if (length > 1552)
+		val |= AN8855_MAX_RX_PKT_JUMBO;
+
+	return regmap_update_bits(priv->regmap, AN8855_GMACCR,
+				  AN8855_MAX_RX_JUMBO | AN8855_MAX_RX_PKT_LEN,
+				  val);
+}
+
+static int
+an8855_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	return AN8855_MAX_MTU;
+}
+
+static void
+an8855_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+		   uint8_t *data)
+{
+	int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++)
+		ethtool_puts(&data, an8855_mib[i].name);
+}
+
+static void
+an8855_read_port_stats(struct an8855_priv *priv, int port, u32 offset, u8 size,
+		       uint64_t *data)
+{
+	u32 val, reg = AN8855_PORT_MIB_COUNTER(port) + offset;
+
+	regmap_read(priv->regmap, reg, &val);
+	*data = val;
+
+	if (size == 2) {
+		regmap_read(priv->regmap, reg + 4, &val);
+		*data |= (u64)val << 32;
+	}
+}
+
+static void
+an8855_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
+{
+	struct an8855_priv *priv = ds->priv;
+	const struct an8855_mib_desc *mib;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(an8855_mib); i++) {
+		mib = &an8855_mib[i];
+
+		an8855_read_port_stats(priv, port, mib->offset, mib->size,
+				       data + i);
+	}
+}
+
+static int
+an8855_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	return ARRAY_SIZE(an8855_mib);
+}
+
+static void
+an8855_get_eth_mac_stats(struct dsa_switch *ds, int port,
+			 struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	/* MIB counter doesn't provide a FramesTransmittedOK but instead
+	 * provide stats for Unicast, Broadcast and Multicast frames separately.
+	 * To simulate a global frame counter, read Unicast and addition Multicast
+	 * and Broadcast later
+	 */
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_UNICAST, 1,
+			       &mac_stats->FramesTransmittedOK);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_SINGLE_COLLISION, 1,
+			       &mac_stats->SingleCollisionFrames);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_MULTIPLE_COLLISION, 1,
+			       &mac_stats->MultipleCollisionFrames);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_UNICAST, 1,
+			       &mac_stats->FramesReceivedOK);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_BYTES, 2,
+			       &mac_stats->OctetsTransmittedOK);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_ALIGN_ERR, 1,
+			       &mac_stats->AlignmentErrors);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_DEFERRED, 1,
+			       &mac_stats->FramesWithDeferredXmissions);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_LATE_COLLISION, 1,
+			       &mac_stats->LateCollisions);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_EXCESSIVE_COLLISION, 1,
+			       &mac_stats->FramesAbortedDueToXSColls);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_BYTES, 2,
+			       &mac_stats->OctetsReceivedOK);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_MULTICAST, 1,
+			       &mac_stats->MulticastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->MulticastFramesXmittedOK;
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_BROADCAST, 1,
+			       &mac_stats->BroadcastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->BroadcastFramesXmittedOK;
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_MULTICAST, 1,
+			       &mac_stats->MulticastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->MulticastFramesReceivedOK;
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_BROADCAST, 1,
+			       &mac_stats->BroadcastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->BroadcastFramesReceivedOK;
+}
+
+static const struct ethtool_rmon_hist_range an8855_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, AN8855_MAX_MTU },
+	{}
+};
+
+static void an8855_get_rmon_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_rmon_stats *rmon_stats,
+				  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_UNDER_SIZE_ERR, 1,
+			       &rmon_stats->undersize_pkts);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_OVER_SZ_ERR, 1,
+			       &rmon_stats->oversize_pkts);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_FRAG_ERR, 1,
+			       &rmon_stats->fragments);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_JABBER_ERR, 1,
+			       &rmon_stats->jabbers);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_64, 1,
+			       &rmon_stats->hist[0]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_65_TO_127, 1,
+			       &rmon_stats->hist[1]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_128_TO_255, 1,
+			       &rmon_stats->hist[2]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_256_TO_511, 1,
+			       &rmon_stats->hist[3]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_512_TO_1023, 1,
+			       &rmon_stats->hist[4]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_1024_TO_1518, 1,
+			       &rmon_stats->hist[5]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PKT_SZ_1519_TO_MAX, 1,
+			       &rmon_stats->hist[6]);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_64, 1,
+			       &rmon_stats->hist_tx[0]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_65_TO_127, 1,
+			       &rmon_stats->hist_tx[1]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_128_TO_255, 1,
+			       &rmon_stats->hist_tx[2]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_256_TO_511, 1,
+			       &rmon_stats->hist_tx[3]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_512_TO_1023, 1,
+			       &rmon_stats->hist_tx[4]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_1024_TO_1518, 1,
+			       &rmon_stats->hist_tx[5]);
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PKT_SZ_1519_TO_MAX, 1,
+			       &rmon_stats->hist_tx[6]);
+
+	*ranges = an8855_rmon_ranges;
+}
+
+static void an8855_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_TX_PAUSE, 1,
+			       &ctrl_stats->MACControlFramesTransmitted);
+
+	an8855_read_port_stats(priv, port, AN8855_PORT_MIB_RX_PAUSE, 1,
+			       &ctrl_stats->MACControlFramesReceived);
+}
+
+static int an8855_port_mirror_add(struct dsa_switch *ds, int port,
+				  struct dsa_mall_mirror_tc_entry *mirror,
+				  bool ingress,
+				  struct netlink_ext_ack *extack)
+{
+	struct an8855_priv *priv = ds->priv;
+	int monitor_port;
+	u32 val;
+	int ret;
+
+	/* Check for existent entry */
+	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
+		return -EEXIST;
+
+	ret = regmap_read(priv->regmap, AN8855_MIR, &val);
+	if (ret)
+		return ret;
+
+	/* AN8855 supports 4 monitor port, but only use first group */
+	monitor_port = FIELD_GET(AN8855_MIRROR_PORT, val);
+	if (val & AN8855_MIRROR_EN && monitor_port != mirror->to_local_port)
+		return -EEXIST;
+
+	val = AN8855_MIRROR_EN;
+	val |= FIELD_PREP(AN8855_MIRROR_PORT, mirror->to_local_port);
+	ret = regmap_update_bits(priv->regmap, AN8855_MIR,
+				 AN8855_MIRROR_EN | AN8855_MIRROR_PORT,
+				 val);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_PCR_P(port),
+			      ingress ? AN8855_PORT_RX_MIR : AN8855_PORT_TX_MIR);
+	if (ret)
+		return ret;
+
+	if (ingress)
+		priv->mirror_rx |= BIT(port);
+	else
+		priv->mirror_tx |= BIT(port);
+
+	return 0;
+}
+
+static void an8855_port_mirror_del(struct dsa_switch *ds, int port,
+				   struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	if (mirror->ingress)
+		priv->mirror_rx &= ~BIT(port);
+	else
+		priv->mirror_tx &= ~BIT(port);
+
+	regmap_clear_bits(priv->regmap, AN8855_PCR_P(port),
+			  mirror->ingress ? AN8855_PORT_RX_MIR :
+					    AN8855_PORT_TX_MIR);
+
+	if (!priv->mirror_rx && !priv->mirror_tx)
+		regmap_clear_bits(priv->regmap, AN8855_MIR, AN8855_MIRROR_EN);
+}
+
+static int an8855_port_set_status(struct an8855_priv *priv, int port,
+				  bool enable)
+{
+	if (enable)
+		return regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
+				       AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+	else
+		return regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
+					 AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+}
+
+static int an8855_port_enable(struct dsa_switch *ds, int port,
+			      struct phy_device *phy)
+{
+	return an8855_port_set_status(ds->priv, port, true);
+}
+
+static void an8855_port_disable(struct dsa_switch *ds, int port)
+{
+	an8855_port_set_status(ds->priv, port, false);
+}
+
+static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
+			      struct ethtool_keee *eee)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 reg;
+	int ret;
+
+	if (eee->eee_enabled) {
+		ret = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
+		if (ret)
+			return ret;
+		/* Force enable EEE if force mode and LINK */
+		if (reg & AN8855_PMCR_FORCE_MODE &&
+		    reg & AN8855_PMCR_FORCE_LNK) {
+			switch (reg & AN8855_PMCR_FORCE_SPEED) {
+			case AN8855_PMCR_FORCE_SPEED_1000:
+				reg |= AN8855_PMCR_FORCE_EEE1G;
+				break;
+			case AN8855_PMCR_FORCE_SPEED_100:
+				reg |= AN8855_PMCR_FORCE_EEE100;
+				break;
+			default:
+				break;
+			}
+			ret = regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
+			if (ret)
+				return ret;
+		}
+		ret = regmap_update_bits(priv->regmap, AN8855_PMEEECR_P(port),
+					 AN8855_LPI_MODE_EN,
+					 eee->tx_lpi_enabled ? AN8855_LPI_MODE_EN : 0);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
+					AN8855_PMCR_FORCE_EEE1G |
+					AN8855_PMCR_FORCE_EEE100);
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(priv->regmap, AN8855_PMEEECR_P(port),
+					AN8855_LPI_MODE_EN);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int an8855_get_mac_eee(struct dsa_switch *ds, int port,
+			      struct ethtool_keee *eee)
+{
+	struct an8855_priv *priv = ds->priv;
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(priv->regmap, AN8855_PMEEECR_P(port), &reg);
+	if (ret)
+		return ret;
+	eee->tx_lpi_enabled = reg & AN8855_LPI_MODE_EN;
+
+	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
+	if (ret)
+		return ret;
+	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
+	eee->tx_lpi_timer = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) / 500;
+
+	ret = regmap_read(priv->regmap, AN8855_PMSR_P(port), &reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static u32 en8855_get_phy_flags(struct dsa_switch *ds, int port)
+{
+	struct an8855_priv *priv = ds->priv;
+
+	/* PHY doesn't need calibration */
+	if (!priv->phy_require_calib)
+		return 0;
+
+	/* Use AN8855_PHY_FLAGS_EN_CALIBRATION to signal
+	 * calibration needed.
+	 */
+	return AN8855_PHY_FLAGS_EN_CALIBRATION;
+}
+
+static enum dsa_tag_protocol
+an8855_get_tag_protocol(struct dsa_switch *ds, int port,
+			enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_MTK;
+}
+
+static int an8855_phy_read(struct mii_bus *bus, int phy, int regnum)
+{
+	struct an8855_priv *priv = bus->priv;
+
+	return mdiobus_read_nested(priv->bus, phy, regnum);
+}
+
+static int an8855_phy_write(struct mii_bus *bus, int phy, int regnum, u16 val)
+{
+	struct an8855_priv *priv = bus->priv;
+
+	return mdiobus_write_nested(priv->bus, phy, regnum, val);
+}
+
+/* Similar to MT7530 also trap link local frame and special frame to CPU */
+static int an8855_trap_special_frames(struct an8855_priv *priv)
+{
+	int ret;
+
+	/* Trap BPDUs to the CPU port(s) and egress them
+	 * VLAN-untagged.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_BPC,
+				 AN8855_BPDU_BPDU_FR | AN8855_BPDU_EG_TAG |
+				 AN8855_BPDU_PORT_FW,
+				 AN8855_BPDU_BPDU_FR |
+				 FIELD_PREP(AN8855_BPDU_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				 FIELD_PREP(AN8855_BPDU_PORT_FW, AN8855_BPDU_CPU_ONLY));
+	if (ret)
+		return ret;
+
+	/* Trap 802.1X PAE frames to the CPU port(s) and egress them
+	 * VLAN-untagged.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_PAC,
+				 AN8855_PAE_BPDU_FR | AN8855_PAE_EG_TAG |
+				 AN8855_PAE_PORT_FW,
+				 AN8855_PAE_BPDU_FR |
+				 FIELD_PREP(AN8855_PAE_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				 FIELD_PREP(AN8855_PAE_PORT_FW, AN8855_BPDU_CPU_ONLY));
+	if (ret)
+		return ret;
+
+	/* Trap frames with :01 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
+				 AN8855_R01_BPDU_FR | AN8855_R01_EG_TAG |
+				 AN8855_R01_PORT_FW,
+				 AN8855_R01_BPDU_FR |
+				 FIELD_PREP(AN8855_R01_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				 FIELD_PREP(AN8855_R01_PORT_FW, AN8855_BPDU_CPU_ONLY));
+	if (ret)
+		return ret;
+
+	/* Trap frames with :02 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
+				 AN8855_R02_BPDU_FR | AN8855_R02_EG_TAG |
+				 AN8855_R02_PORT_FW,
+				 AN8855_R02_BPDU_FR |
+				 FIELD_PREP(AN8855_R02_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				 FIELD_PREP(AN8855_R02_PORT_FW, AN8855_BPDU_CPU_ONLY));
+	if (ret)
+		return ret;
+
+	/* Trap frames with :03 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_RGAC1,
+				 AN8855_R03_BPDU_FR | AN8855_R03_EG_TAG |
+				 AN8855_R03_PORT_FW,
+				 AN8855_R03_BPDU_FR |
+				 FIELD_PREP(AN8855_R03_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				 FIELD_PREP(AN8855_R03_PORT_FW, AN8855_BPDU_CPU_ONLY));
+	if (ret)
+		return ret;
+
+	/* Trap frames with :0E MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	return regmap_update_bits(priv->regmap, AN8855_RGAC1,
+				  AN8855_R0E_BPDU_FR | AN8855_R0E_EG_TAG |
+				  AN8855_R0E_PORT_FW,
+				  AN8855_R0E_BPDU_FR |
+				  FIELD_PREP(AN8855_R0E_EG_TAG, AN8855_VLAN_EG_UNTAGGED) |
+				  FIELD_PREP(AN8855_R0E_PORT_FW, AN8855_BPDU_CPU_ONLY));
+}
+
+static int an8855_mdio_setup(struct an8855_priv *priv)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct device *dev = priv->dev;
+	struct device_node *np;
+	struct mii_bus *bus;
+	int ret = 0;
+
+	np = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (!np || !of_device_is_available(np))
+		goto exit;
+
+	bus = devm_mdiobus_alloc(priv->dev);
+	if (!bus) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	bus->priv = priv;
+	bus->name = KBUILD_MODNAME "-mii";
+	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d.%d",
+		 ds->dst->index, ds->index);
+	bus->parent = dev;
+	bus->read = an8855_phy_read;
+	bus->write = an8855_phy_write;
+
+	ret = devm_of_mdiobus_register(dev, bus, np);
+	if (ret)
+		dev_err(dev, "failed to register MDIO bus: %d", ret);
+
+exit:
+	of_node_put(np);
+	return ret;
+}
+
+static int
+an8855_setup_pvid_vlan(struct an8855_priv *priv)
+{
+	u32 val;
+	int ret;
+
+	/* Validate the entry with independent learning, keep the original
+	 * ingress tag attribute.
+	 */
+	val = AN8855_VA0_IVL_MAC | AN8855_VA0_EG_CON |
+	      FIELD_PREP(AN8855_VA0_FID, AN8855_FID_BRIDGED) |
+	      AN8855_VA0_PORT | AN8855_VA0_VLAN_VALID;
+	ret = regmap_write(priv->regmap, AN8855_VAWD0, val);
+	if (ret)
+		return ret;
+
+	return an8855_vlan_cmd(priv, AN8855_VTCR_WR_VID,
+			       AN8855_PORT_VID_DEFAULT);
+}
+
+static int an8855_setup(struct dsa_switch *ds)
+{
+	struct an8855_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int ret;
+
+	/* Setup mdio BUS for internal PHY */
+	ret = an8855_mdio_setup(priv);
+	if (ret)
+		return ret;
+
+	/* Enable and reset MIB counters */
+	ret = an8855_mib_init(priv);
+	if (ret)
+		return ret;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Disable MAC by default on all user ports */
+		ret = an8855_port_set_status(priv, dp->index, false);
+		if (ret)
+			return ret;
+
+		/* Individual user ports get connected to CPU port only */
+		ret = regmap_write(priv->regmap, AN8855_PORTMATRIX_P(dp->index),
+				   FIELD_PREP(AN8855_PORTMATRIX, BIT(AN8855_CPU_PORT)));
+		if (ret)
+			return ret;
+
+		/* Disable Learning on user ports */
+		ret = regmap_set_bits(priv->regmap, AN8855_PSC_P(dp->index),
+				      AN8855_SA_DIS);
+		if (ret)
+			return ret;
+
+		/* Disable Broadcast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_BCF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Disable Unknown Unicast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNUF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Disable Unknown Multicast Forward on user ports */
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNMF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(priv->regmap, AN8855_UNIPMF, BIT(dp->index));
+		if (ret)
+			return ret;
+
+		/* Set default PVID to on all user ports */
+		ret = an8855_port_set_pid(priv, dp->index, AN8855_PORT_VID_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable Airoha header mode on the cpu port */
+	ret = regmap_write(priv->regmap, AN8855_PVC_P(AN8855_CPU_PORT),
+			   AN8855_PORT_SPEC_REPLACE_MODE | AN8855_PORT_SPEC_TAG);
+	if (ret)
+		return ret;
+
+	/* Unknown multicast frame forwarding to the cpu port */
+	ret = regmap_write(priv->regmap, AN8855_UNMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Set CPU port number */
+	ret = regmap_update_bits(priv->regmap, AN8855_MFC,
+				 AN8855_CPU_EN | AN8855_CPU_PORT_IDX,
+				 AN8855_CPU_EN |
+				 FIELD_PREP(AN8855_CPU_PORT_IDX, AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* CPU port gets connected to all user ports of
+	 * the switch.
+	 */
+	ret = regmap_write(priv->regmap, AN8855_PORTMATRIX_P(AN8855_CPU_PORT),
+			   FIELD_PREP(AN8855_PORTMATRIX, dsa_user_ports(ds)));
+	if (ret)
+		return ret;
+
+	/* CPU port is set to fallback mode to let untagged
+	 * frames pass through.
+	 */
+	ret = regmap_update_bits(priv->regmap, AN8855_PCR_P(AN8855_CPU_PORT),
+				 AN8855_PORT_VLAN,
+				 FIELD_PREP(AN8855_PORT_VLAN, AN8855_PORT_FALLBACK_MODE));
+	if (ret)
+		return ret;
+
+	/* Enable Learning on CPU port */
+	ret = regmap_clear_bits(priv->regmap, AN8855_PSC_P(AN8855_CPU_PORT), AN8855_SA_DIS);
+	if (ret)
+		return ret;
+
+	/* Enable Broadcast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_BCF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Enable Unknown Unicast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_UNUF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Enable Unknown Multicast Forward on CPU port */
+	ret = regmap_set_bits(priv->regmap, AN8855_UNMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_UNIPMF, BIT(AN8855_CPU_PORT));
+	if (ret)
+		return ret;
+
+	/* Setup Trap special frame to CPU rules */
+	ret = an8855_trap_special_frames(priv);
+	if (ret)
+		return ret;
+
+	dsa_switch_for_each_port(dp, ds) {
+		/* Enable consistent egress tag (for VLAN unware VLAN-passtrough) */
+		ret = regmap_update_bits(priv->regmap, AN8855_PVC_P(dp->index),
+					 AN8855_PVC_EG_TAG,
+					 FIELD_PREP(AN8855_PVC_EG_TAG, AN8855_VLAN_EG_CONSISTENT));
+		if (ret)
+			return ret;
+	}
+
+	/* Setup VLAN for Default PVID */
+	ret = an8855_setup_pvid_vlan(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_CKGCR,
+				AN8855_CKG_LNKDN_GLB_STOP | AN8855_CKG_LNKDN_PORT_STOP);
+	if (ret)
+		return ret;
+
+	/* Release global PHY power down */
+	ret = regmap_write(priv->regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
+	if (ret)
+		return ret;
+
+	ds->configure_vlan_while_not_filtering = true;
+
+	/* Flush the FDB table */
+	ret = an8855_fdb_cmd(priv, AN8855_FDB_FLUSH, NULL);
+	if (ret < 0)
+		return ret;
+
+	/* Set min a max ageing value supported */
+	ds->ageing_time_min = AN8855_L2_AGING_MS_CONSTANT;
+	ds->ageing_time_max = FIELD_MAX(AN8855_AGE_CNT) *
+			      FIELD_MAX(AN8855_AGE_UNIT) *
+			      AN8855_L2_AGING_MS_CONSTANT;
+
+	return 0;
+}
+
+static struct phylink_pcs *
+an8855_phylink_mac_select_pcs(struct phylink_config *config,
+			      phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return &priv->pcs;
+	default:
+		return NULL;
+	}
+}
+
+static void
+an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct an8855_priv *priv;
+	int port = dp->index;
+
+	priv = ds->priv;
+
+	if (port != 5) {
+		if (port > 5)
+			dev_err(ds->dev, "unsupported port: %d", port);
+		return;
+	}
+
+	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
+			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
+			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
+			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
+			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
+			   AN8855_PMCR_BACKPR_EN);
+}
+
+static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
+				    struct phylink_config *config)
+{
+	switch (port) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+	case 5:
+		phy_interface_set_rgmii(config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		break;
+	}
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000FD;
+}
+
+static void
+an8855_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+
+	/* With autoneg just disable TX/RX else also force link down */
+	if (phylink_autoneg_inband(mode)) {
+		regmap_clear_bits(priv->regmap, AN8855_PMCR_P(dp->index),
+				  AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
+	} else {
+		regmap_update_bits(priv->regmap, AN8855_PMCR_P(dp->index),
+				   AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN |
+				   AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK,
+				   AN8855_PMCR_FORCE_MODE);
+	}
+}
+
+static void
+an8855_phylink_mac_link_up(struct phylink_config *config,
+			   struct phy_device *phydev, unsigned int mode,
+			   phy_interface_t interface, int speed, int duplex,
+			   bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct an8855_priv *priv = dp->ds->priv;
+	int port = dp->index;
+	u32 reg;
+
+	reg = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
+	if (phylink_autoneg_inband(mode)) {
+		reg &= ~AN8855_PMCR_FORCE_MODE;
+	} else {
+		reg |= AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK;
+
+		reg &= ~AN8855_PMCR_FORCE_SPEED;
+		switch (speed) {
+		case SPEED_10:
+			reg |= AN8855_PMCR_FORCE_SPEED_10;
+			break;
+		case SPEED_100:
+			reg |= AN8855_PMCR_FORCE_SPEED_100;
+			break;
+		case SPEED_1000:
+			reg |= AN8855_PMCR_FORCE_SPEED_1000;
+			break;
+		case SPEED_2500:
+			reg |= AN8855_PMCR_FORCE_SPEED_2500;
+			break;
+		case SPEED_5000:
+			reg |= AN8855_PMCR_FORCE_SPEED_5000;
+			break;
+		}
+
+		reg &= ~AN8855_PMCR_FORCE_FDX;
+		if (duplex == DUPLEX_FULL)
+			reg |= AN8855_PMCR_FORCE_FDX;
+
+		reg &= ~AN8855_PMCR_RX_FC_EN;
+		if (rx_pause || dsa_port_is_cpu(dp))
+			reg |= AN8855_PMCR_RX_FC_EN;
+
+		reg &= ~AN8855_PMCR_TX_FC_EN;
+		if (rx_pause || dsa_port_is_cpu(dp))
+			reg |= AN8855_PMCR_TX_FC_EN;
+
+		/* Disable any EEE options */
+		reg &= ~(AN8855_PMCR_FORCE_EEE5G | AN8855_PMCR_FORCE_EEE2P5G |
+			 AN8855_PMCR_FORCE_EEE1G | AN8855_PMCR_FORCE_EEE100);
+	}
+
+	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
+
+	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
+}
+
+static void an8855_pcs_get_state(struct phylink_pcs *pcs,
+				 struct phylink_link_state *state)
+{
+	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, AN8855_PMSR_P(AN8855_CPU_PORT), &val);
+	if (ret < 0) {
+		state->link = false;
+		return;
+	}
+
+	state->link = !!(val & AN8855_PMSR_LNK);
+	state->an_complete = state->link;
+	state->duplex = (val & AN8855_PMSR_DPX) ? DUPLEX_FULL :
+						  DUPLEX_HALF;
+
+	switch (val & AN8855_PMSR_SPEED) {
+	case AN8855_PMSR_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case AN8855_PMSR_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case AN8855_PMSR_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case AN8855_PMSR_SPEED_2500:
+		state->speed = SPEED_2500;
+		break;
+	case AN8855_PMSR_SPEED_5000:
+		state->speed = SPEED_5000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (val & AN8855_PMSR_RX_FC)
+		state->pause |= MLO_PAUSE_RX;
+	if (val & AN8855_PMSR_TX_FC)
+		state->pause |= MLO_PAUSE_TX;
+}
+
+static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
+	u32 val;
+	int ret;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			dev_err(priv->dev, "in-band negotiation unsupported");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*                   !!! WELCOME TO HELL !!!                   */
+
+	/* TX FIR - improve TX EYE */
+	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_10,
+				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C2_FORCE |
+				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C1_FORCE,
+				 AN8855_RG_DA_QP_TX_FIR_C2_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C2_FORCE, 0x4) |
+				 AN8855_RG_DA_QP_TX_FIR_C1_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C1_FORCE, 0x0));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x0;
+	else
+		val = 0xd;
+	ret = regmap_update_bits(priv->regmap, AN8855_INTF_CTRL_11,
+				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
+				 AN8855_RG_DA_QP_TX_FIR_C0B_FORCE,
+				 AN8855_RG_DA_QP_TX_FIR_C0B_SEL |
+				 FIELD_PREP(AN8855_RG_DA_QP_TX_FIR_C0B_FORCE, val));
+	if (ret)
+		return ret;
+
+	/* RX CDR - improve RX Jitter Tolerance */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x5;
+	else
+		val = 0x6;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_BOT_LIM,
+				 AN8855_RG_QP_CDR_LPF_KP_GAIN |
+				 AN8855_RG_QP_CDR_LPF_KI_GAIN,
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KP_GAIN, val) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_KI_GAIN, val));
+	if (ret)
+		return ret;
+
+	/* PLL */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x1;
+	else
+		val = 0x0;
+	ret = regmap_update_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_1,
+				 AN8855_RG_TPHY_SPEED,
+				 FIELD_PREP(AN8855_RG_TPHY_SPEED, val));
+	if (ret)
+		return ret;
+
+	/* PLL - LPF */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
+				 AN8855_RG_DA_QP_PLL_FBKSEL_INTF |
+				 AN8855_RG_DA_QP_PLL_BR_INTF |
+				 AN8855_RG_DA_QP_PLL_BPD_INTF |
+				 AN8855_RG_DA_QP_PLL_BPA_INTF |
+				 AN8855_RG_DA_QP_PLL_BC_INTF,
+				 AN8855_RG_DA_QP_PLL_RICO_SEL_INTF |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_FBKSEL_INTF, 0x0) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BR_INTF, 0x3) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPD_INTF, 0x0) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BPA_INTF, 0x5) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_BC_INTF, 0x1));
+	if (ret)
+		return ret;
+
+	/* PLL - ICO */
+	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_4,
+			      AN8855_RG_DA_QP_PLL_ICOLP_EN_INTF);
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				AN8855_RG_DA_QP_PLL_ICOIQ_EN_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - CHP */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x6;
+	else
+		val = 0x4;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_IR_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_IR_INTF, val));
+	if (ret)
+		return ret;
+
+	/* PLL - PFD */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_EN_INTRF |
+				 AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF |
+				 AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF, 0x1) |
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF, 0x1));
+	if (ret)
+		return ret;
+
+	/* PLL - POSTDIV */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_POSTDIV_EN_INTF |
+				 AN8855_RG_DA_QP_PLL_PHY_CK_EN_INTF |
+				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF,
+				 AN8855_RG_DA_QP_PLL_PCK_SEL_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - SDM */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CTRL_2,
+				AN8855_RG_DA_QP_PLL_SDM_IFM_INTF);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_SS_LCPLL_PWCTL_SETTING_2,
+				 AN8855_RG_NCPO_ANA_MSB,
+				 FIELD_PREP(AN8855_RG_NCPO_ANA_MSB, 0x1));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x7a000000;
+	else
+		val = 0x48000000;
+	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_2,
+			   FIELD_PREP(AN8855_RG_LCPLL_NCPO_VALUE, val));
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->regmap, AN8855_SS_LCPLL_TDC_PCW_1,
+			   FIELD_PREP(AN8855_RG_LCPLL_PON_HRDDS_PCW_NCPO_GPON, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_SS_LCPLL_TDC_FLT_5,
+				AN8855_RG_LCPLL_NCPO_CHG);
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
+				AN8855_RG_DA_QP_PLL_SDM_DI_EN_INTF);
+	if (ret)
+		return ret;
+
+	/* PLL - SS */
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
+				 AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_4,
+				 AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF, 0x0));
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_3,
+				 AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF,
+				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF, 0x0));
+	if (ret)
+		return ret;
+
+	/* PLL - TDC */
+	ret = regmap_clear_bits(priv->regmap, AN8855_PLL_CK_CTRL_0,
+				AN8855_RG_DA_QP_PLL_TDC_TXCK_SEL_INTF);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
+			      AN8855_RG_QP_PLL_SSC_TRI_EN);
+	if (ret)
+		return ret;
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_PLL_SDM_ORD,
+			      AN8855_RG_QP_PLL_SSC_PHASE_INI);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_RX_DAC_EN,
+				 AN8855_RG_QP_SIGDET_HF,
+				 FIELD_PREP(AN8855_RG_QP_SIGDET_HF, 0x2));
+	if (ret)
+		return ret;
+
+	/* TCL Disable (only for Co-SIM) */
+	ret = regmap_clear_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_0,
+				AN8855_RG_QP_EQ_RX500M_CK_SEL);
+	if (ret)
+		return ret;
+
+	/* TX Init */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x4;
+	else
+		val = 0x0;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_TX_MODE,
+				 AN8855_RG_QP_TX_RESERVE |
+				 AN8855_RG_QP_TX_MODE_16B_EN,
+				 FIELD_PREP(AN8855_RG_QP_TX_RESERVE, val));
+	if (ret)
+		return ret;
+
+	/* RX Control/Init */
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_QP_RXAFE_RESERVE,
+			      AN8855_RG_QP_CDR_PD_10B_EN);
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x1;
+	else
+		val = 0x2;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_MJV_LIM,
+				 AN8855_RG_QP_CDR_LPF_RATIO,
+				 FIELD_PREP(AN8855_RG_QP_CDR_LPF_RATIO, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_LPF_SETVALUE,
+				 AN8855_RG_QP_CDR_PR_BUF_IN_SR |
+				 AN8855_RG_QP_CDR_PR_BETA_SEL,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BUF_IN_SR, 0x6) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_BETA_SEL, 0x1));
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0xf;
+	else
+		val = 0xc;
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
+				 AN8855_RG_QP_CDR_PR_DAC_BAND,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_DAC_BAND, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
+				 AN8855_RG_QP_CDR_PR_KBAND_PCIE_MODE |
+				 AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK, 0x19));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF,
+				 AN8855_RG_QP_CDR_PHYCK_SEL |
+				 AN8855_RG_QP_CDR_PHYCK_RSTB |
+				 AN8855_RG_QP_CDR_PHYCK_DIV,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_SEL, 0x2) |
+				 FIELD_PREP(AN8855_RG_QP_CDR_PHYCK_DIV, 0x21));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE,
+				AN8855_RG_QP_CDR_PR_XFICK_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RG_QP_CDR_PR_CKREF_DIV1,
+				 AN8855_RG_QP_CDR_PR_KBAND_DIV,
+				 FIELD_PREP(AN8855_RG_QP_CDR_PR_KBAND_DIV, 0x4));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_26,
+				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
+				 AN8855_RG_LINK_NE_EN |
+				 AN8855_RG_LINK_ERRO_EN,
+				 AN8855_RG_QP_EQ_RETRAIN_ONLY_EN |
+				 AN8855_RG_LINK_ERRO_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_DLY_0,
+				 AN8855_RG_QP_RX_SAOSC_EN_H_DLY |
+				 AN8855_RG_QP_RX_PI_CAL_EN_H_DLY,
+				 FIELD_PREP(AN8855_RG_QP_RX_SAOSC_EN_H_DLY, 0x3f) |
+				 FIELD_PREP(AN8855_RG_QP_RX_PI_CAL_EN_H_DLY, 0x6f));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_42,
+				 AN8855_RG_QP_EQ_EN_DLY,
+				 FIELD_PREP(AN8855_RG_QP_EQ_EN_DLY, 0x150));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_2,
+				 AN8855_RG_QP_RX_EQ_EN_H_DLY,
+				 FIELD_PREP(AN8855_RG_QP_RX_EQ_EN_H_DLY, 0x150));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_PON_RXFEDIG_CTRL_9,
+				 AN8855_RG_QP_EQ_LEQOSC_DLYCNT,
+				 FIELD_PREP(AN8855_RG_QP_EQ_LEQOSC_DLYCNT, 0x1));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_8,
+				 AN8855_RG_DA_QP_SAOSC_DONE_TIME |
+				 AN8855_RG_DA_QP_LEQOS_EN_TIME,
+				 FIELD_PREP(AN8855_RG_DA_QP_SAOSC_DONE_TIME, 0x200) |
+				 FIELD_PREP(AN8855_RG_DA_QP_LEQOS_EN_TIME, 0xfff));
+	if (ret)
+		return ret;
+
+	/* Frequency meter */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		val = 0x10;
+	else
+		val = 0x28;
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_5,
+				 AN8855_RG_FREDET_CHK_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_CHK_CYCLE, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_6,
+				 AN8855_RG_FREDET_GOLDEN_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_GOLDEN_CYCLE, 0x64));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, AN8855_RX_CTRL_7,
+				 AN8855_RG_FREDET_TOLERATE_CYCLE,
+				 FIELD_PREP(AN8855_RG_FREDET_TOLERATE_CYCLE, 0x2710));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, AN8855_PLL_CTRL_0,
+			      AN8855_RG_PHYA_AUTO_INIT);
+	if (ret)
+		return ret;
+
+	/* PCS Init */
+	if (interface == PHY_INTERFACE_MODE_SGMII &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
+		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
+					AN8855_RG_SGMII_MODE | AN8855_RG_SGMII_AN_EN);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_clear_bits(priv->regmap, AN8855_RG_HSGMII_PCS_CTROL_1,
+				AN8855_RG_TBI_10B_MODE);
+	if (ret)
+		return ret;
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		/* Set AN Ability - Interrupt */
+		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_FORCE_CL37,
+				      AN8855_RG_FORCE_AN_DONE);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN_13,
+					 AN8855_SGMII_REMOTE_FAULT_DIS |
+					 AN8855_SGMII_IF_MODE,
+					 AN8855_SGMII_REMOTE_FAULT_DIS |
+					 FIELD_PREP(AN8855_SGMII_IF_MODE, 0xb));
+		if (ret)
+			return ret;
+	}
+
+	/* Rate Adaption - GMII path config. */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+		ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+					AN8855_RG_P0_DIS_MII_MODE);
+		if (ret)
+			return ret;
+	} else {
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+			ret = regmap_set_bits(priv->regmap, AN8855_MII_RA_AN_ENABLE,
+					      AN8855_RG_P0_RA_AN_EN);
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_update_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
+						 AN8855_RG_FORCE_CUR_SGMII_MODE |
+						 AN8855_RG_FORCE_CUR_SGMII_SEL,
+						 AN8855_RG_FORCE_CUR_SGMII_SEL);
+			if (ret)
+				return ret;
+
+			ret = regmap_clear_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+						AN8855_RG_P0_MII_RA_RX_EN |
+						AN8855_RG_P0_MII_RA_TX_EN |
+						AN8855_RG_P0_MII_RA_RX_MODE |
+						AN8855_RG_P0_MII_RA_TX_MODE);
+			if (ret)
+				return ret;
+		}
+
+		ret = regmap_set_bits(priv->regmap, AN8855_RATE_ADP_P0_CTRL_0,
+				      AN8855_RG_P0_MII_MODE);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0,
+			      AN8855_RG_RATE_ADAPT_RX_BYPASS |
+			      AN8855_RG_RATE_ADAPT_TX_BYPASS |
+			      AN8855_RG_RATE_ADAPT_RX_EN |
+			      AN8855_RG_RATE_ADAPT_TX_EN);
+	if (ret)
+		return ret;
+
+	/* Disable AN if not in autoneg */
+	ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANENABLE,
+				 neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE :
+									      0);
+	if (ret)
+		return ret;
+
+	if (interface == PHY_INTERFACE_MODE_SGMII &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
+		ret = regmap_set_bits(priv->regmap, AN8855_PHY_RX_FORCE_CTRL_0,
+				      AN8855_RG_FORCE_TXC_SEL);
+		if (ret)
+			return ret;
+	}
+
+	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
+	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
+	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		if (interface == PHY_INTERFACE_MODE_2500BASEX)
+			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
+		else
+			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;
+		ret = regmap_update_bits(priv->regmap, AN8855_SGMII_STS_CTRL_0,
+					 AN8855_RG_LINK_MODE_P0 |
+					 AN8855_RG_FORCE_SPD_MODE_P0,
+					 val | AN8855_RG_FORCE_SPD_MODE_P0);
+		if (ret)
+			return ret;
+	}
+
+	/* bypass flow control to MAC */
+	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_0,
+			   AN8855_RG_DPX_STS_P3 | AN8855_RG_DPX_STS_P2 |
+			   AN8855_RG_DPX_STS_P1 | AN8855_RG_TXFC_STS_P0 |
+			   AN8855_RG_RXFC_STS_P0 | AN8855_RG_DPX_STS_P0);
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2,
+			   AN8855_RG_RXFC_AN_BYPASS_P3 |
+			   AN8855_RG_RXFC_AN_BYPASS_P2 |
+			   AN8855_RG_RXFC_AN_BYPASS_P1 |
+			   AN8855_RG_TXFC_AN_BYPASS_P3 |
+			   AN8855_RG_TXFC_AN_BYPASS_P2 |
+			   AN8855_RG_TXFC_AN_BYPASS_P1 |
+			   AN8855_RG_DPX_AN_BYPASS_P3 |
+			   AN8855_RG_DPX_AN_BYPASS_P2 |
+			   AN8855_RG_DPX_AN_BYPASS_P1 |
+			   AN8855_RG_DPX_AN_BYPASS_P0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void an8855_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
+
+	regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANRESTART);
+}
+
+static const struct phylink_pcs_ops an8855_pcs_ops = {
+	.pcs_get_state = an8855_pcs_get_state,
+	.pcs_config = an8855_pcs_config,
+	.pcs_an_restart = an8855_pcs_an_restart,
+};
+
+static const struct phylink_mac_ops an8855_phylink_mac_ops = {
+	.mac_select_pcs	= an8855_phylink_mac_select_pcs,
+	.mac_config	= an8855_phylink_mac_config,
+	.mac_link_down	= an8855_phylink_mac_link_down,
+	.mac_link_up	= an8855_phylink_mac_link_up,
+};
+
+static const struct dsa_switch_ops an8855_switch_ops = {
+	.get_tag_protocol = an8855_get_tag_protocol,
+	.setup = an8855_setup,
+	.get_phy_flags = en8855_get_phy_flags,
+	.phylink_get_caps = an8855_phylink_get_caps,
+	.get_strings = an8855_get_strings,
+	.get_ethtool_stats = an8855_get_ethtool_stats,
+	.get_sset_count = an8855_get_sset_count,
+	.get_eth_mac_stats = an8855_get_eth_mac_stats,
+	.get_eth_ctrl_stats = an8855_get_eth_ctrl_stats,
+	.get_rmon_stats = an8855_get_rmon_stats,
+	.port_enable = an8855_port_enable,
+	.port_disable = an8855_port_disable,
+	.get_mac_eee = an8855_get_mac_eee,
+	.set_mac_eee = an8855_set_mac_eee,
+	.set_ageing_time = an8855_set_ageing_time,
+	.port_bridge_join = an8855_port_bridge_join,
+	.port_bridge_leave = an8855_port_bridge_leave,
+	.port_fast_age = an8855_port_fast_age,
+	.port_stp_state_set = an8855_port_stp_state_set,
+	.port_pre_bridge_flags = an8855_port_pre_bridge_flags,
+	.port_bridge_flags = an8855_port_bridge_flags,
+	.port_vlan_filtering = an8855_port_vlan_filtering,
+	.port_vlan_add = an8855_port_vlan_add,
+	.port_vlan_del = an8855_port_vlan_del,
+	.port_fdb_add = an8855_port_fdb_add,
+	.port_fdb_del = an8855_port_fdb_del,
+	.port_fdb_dump = an8855_port_fdb_dump,
+	.port_mdb_add = an8855_port_mdb_add,
+	.port_mdb_del = an8855_port_mdb_del,
+	.port_change_mtu = an8855_port_change_mtu,
+	.port_max_mtu = an8855_port_max_mtu,
+	.port_mirror_add = an8855_port_mirror_add,
+	.port_mirror_del = an8855_port_mirror_del,
+};
+
+static int an8855_read_switch_id(struct an8855_priv *priv)
+{
+	u32 id;
+	int ret;
+
+	ret = regmap_read(priv->regmap, AN8855_CREV, &id);
+	if (ret)
+		return ret;
+
+	if (id != AN8855_ID) {
+		dev_err(priv->dev,
+			"Switch id detected %x but expected %x",
+			id, AN8855_ID);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int an8855_efuse_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct an8855_priv *priv = context;
+
+	return regmap_bulk_read(priv->regmap, AN8855_EFUSE_DATA0 + offset,
+				val, bytes / sizeof(u32));
+}
+
+static struct nvmem_config an8855_nvmem_config = {
+	.name = "an8855-efuse",
+	.size = AN8855_EFUSE_CELL * sizeof(u32),
+	.stride = sizeof(u32),
+	.word_size = sizeof(u32),
+	.reg_read = an8855_efuse_read,
+};
+
+static int an8855_sw_register_nvmem(struct an8855_priv *priv)
+{
+	struct nvmem_device *nvmem;
+
+	an8855_nvmem_config.priv = priv;
+	an8855_nvmem_config.dev = priv->dev;
+	nvmem = devm_nvmem_register(priv->dev, &an8855_nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	return 0;
+}
+
+static int
+an8855_sw_probe(struct mdio_device *mdiodev)
+{
+	struct an8855_priv *priv;
+	u32 val;
+	int ret;
+
+	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->bus = mdiodev->bus;
+	priv->dev = &mdiodev->dev;
+	priv->phy_base = mdiodev->addr;
+	priv->phy_require_calib = of_property_read_bool(priv->dev->of_node,
+							"airoha,ext-surge");
+
+	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio))
+		return PTR_ERR(priv->reset_gpio);
+
+	priv->regmap = devm_regmap_init(priv->dev, NULL, priv,
+					&an8855_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(priv->dev, "regmap initialization failed");
+		return PTR_ERR(priv->regmap);
+	}
+
+	if (priv->reset_gpio) {
+		usleep_range(100000, 150000);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
+		usleep_range(100000, 150000);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+
+		/* Poll HWTRAP reg to wait for Switch to fully Init */
+		ret = regmap_read_poll_timeout(priv->regmap, AN8855_HWTRAP, val,
+					       val, 20, 200000);
+		if (ret)
+			return ret;
+	}
+
+	ret = an8855_read_switch_id(priv);
+	if (ret)
+		return ret;
+
+	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->dev = priv->dev;
+	priv->ds->num_ports = AN8855_NUM_PORTS;
+	priv->ds->priv = priv;
+	priv->ds->ops = &an8855_switch_ops;
+	devm_mutex_init(priv->dev, &priv->reg_mutex);
+	priv->ds->phylink_mac_ops = &an8855_phylink_mac_ops;
+
+	priv->pcs.ops = &an8855_pcs_ops;
+	priv->pcs.neg_mode = true;
+	priv->pcs.poll = true;
+
+	ret = an8855_sw_register_nvmem(priv);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(priv->dev, priv);
+
+	return devm_dsa_register_switch(priv->dev, priv->ds);
+}
+
+static const struct of_device_id an8855_of_match[] = {
+	{ .compatible = "airoha,an8855" },
+	{ /* sentinel */ }
+};
+
+static struct mdio_driver an8855_mdio_driver = {
+	.probe = an8855_sw_probe,
+	.mdiodrv.driver = {
+		.name = "an8855",
+		.of_match_table = an8855_of_match,
+	},
+};
+
+mdio_module_driver(an8855_mdio_driver);
+
+MODULE_AUTHOR("Min Yao <min.yao@airoha.com>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha AN8855 Switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/an8855.h b/drivers/net/dsa/an8855.h
new file mode 100644
index 000000000000..f916892a4e7b
--- /dev/null
+++ b/drivers/net/dsa/an8855.h
@@ -0,0 +1,810 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Min Yao <min.yao@airoha.com>
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __AN8855_H
+#define __AN8855_H
+
+#include <linux/bitfield.h>
+
+#define AN8855_NUM_PORTS		6
+#define AN8855_CPU_PORT			5
+#define AN8855_NUM_FDB_RECORDS		2048
+#define AN8855_GPHY_SMI_ADDR_DEFAULT	1
+#define AN8855_PORT_VID_DEFAULT		0
+#define AN8855_EFUSE_CELL		50
+
+#define MTK_TAG_LEN			4
+#define AN8855_MAX_MTU			(15360 - ETH_HLEN - ETH_FCS_LEN - MTK_TAG_LEN)
+
+#define AN8855_L2_AGING_MS_CONSTANT	1024
+
+#define AN8855_PHY_FLAGS_EN_CALIBRATION	BIT(0)
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
+/*	AN8855_SCU			0x10000000 */
+#define AN8855_RG_GPIO_LED_MODE		0x10000054
+#define AN8855_RG_GPIO_LED_SEL(i)	(0x10000000 + (0x0058 + ((i) * 4)))
+#define AN8855_RG_INTB_MODE		0x10000080
+#define AN8855_RG_RGMII_TXCK_C		0x100001d0
+
+#define AN8855_PKG_SEL			0x10000094
+#define   AN8855_PAG_SEL_AN8855H	0x2
+
+/* Register for hw trap status */
+#define AN8855_HWTRAP			0x1000009c
+
+#define AN8855_RG_GPIO_L_INV		0x10000010
+#define AN8855_RG_GPIO_CTRL		0x1000a300
+#define AN8855_RG_GPIO_DATA		0x1000a304
+#define AN8855_RG_GPIO_OE		0x1000a314
+
+#define AN8855_EFUSE_DATA0		0x1000a500
+#define   AN8855_EFUSE_R50O		GENMASK(30, 24)
+
+#define AN8855_CREV			0x10005000
+#define   AN8855_ID			0x8855
+
+/* Register for system reset */
+#define AN8855_RST_CTRL			0x100050c0
+#define   AN8855_SYS_CTRL_SYS_RST	BIT(31)
+
+#define AN8855_INT_MASK			0x100050f0
+#define   AN8855_INT_SYS		BIT(15)
+
+#define AN8855_RG_CLK_CPU_ICG		0x10005034
+#define   AN8855_MCU_ENABLE		BIT(3)
+
+#define AN8855_RG_TIMER_CTL		0x1000a100
+#define   AN8855_WDOG_ENABLE		BIT(25)
+
+#define AN8855_RG_GDMP_RAM		0x10010000
+
+/* Registers to mac forward control for unknown frames */
+#define AN8855_MFC			0x10200010
+#define   AN8855_CPU_EN			BIT(15)
+#define   AN8855_CPU_PORT_IDX		GENMASK(12, 8)
+
+#define AN8855_PAC			0x10200024
+#define   AN8855_TAG_PAE_MANG_FR	BIT(30)
+#define   AN8855_TAG_PAE_BPDU_FR	BIT(28)
+#define   AN8855_TAG_PAE_EG_TAG		GENMASK(27, 25)
+#define   AN8855_TAG_PAE_LKY_VLAN	BIT(24)
+#define   AN8855_TAG_PAE_PRI_HIGH	BIT(23)
+#define   AN8855_TAG_PAE_MIR		GENMASK(20, 19)
+#define   AN8855_TAG_PAE_PORT_FW	GENMASK(18, 16)
+#define   AN8855_PAE_MANG_FR		BIT(14)
+#define   AN8855_PAE_BPDU_FR		BIT(12)
+#define   AN8855_PAE_EG_TAG		GENMASK(11, 9)
+#define   AN8855_PAE_LKY_VLAN		BIT(8)
+#define   AN8855_PAE_PRI_HIGH		BIT(7)
+#define   AN8855_PAE_MIR		GENMASK(4, 3)
+#define   AN8855_PAE_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_RGAC1			0x10200028
+#define   AN8855_R02_MANG_FR		BIT(30)
+#define   AN8855_R02_BPDU_FR		BIT(28)
+#define   AN8855_R02_EG_TAG		GENMASK(27, 25)
+#define   AN8855_R02_LKY_VLAN		BIT(24)
+#define   AN8855_R02_PRI_HIGH		BIT(23)
+#define   AN8855_R02_MIR		GENMASK(20, 19)
+#define   AN8855_R02_PORT_FW		GENMASK(18, 16)
+#define   AN8855_R01_MANG_FR		BIT(14)
+#define   AN8855_R01_BPDU_FR		BIT(12)
+#define   AN8855_R01_EG_TAG		GENMASK(11, 9)
+#define   AN8855_R01_LKY_VLAN		BIT(8)
+#define   AN8855_R01_PRI_HIGH		BIT(7)
+#define   AN8855_R01_MIR		GENMASK(4, 3)
+#define   AN8855_R01_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_RGAC2			0x1020002c
+#define   AN8855_R0E_MANG_FR		BIT(30)
+#define   AN8855_R0E_BPDU_FR		BIT(28)
+#define   AN8855_R0E_EG_TAG		GENMASK(27, 25)
+#define   AN8855_R0E_LKY_VLAN		BIT(24)
+#define   AN8855_R0E_PRI_HIGH		BIT(23)
+#define   AN8855_R0E_MIR		GENMASK(20, 19)
+#define   AN8855_R0E_PORT_FW		GENMASK(18, 16)
+#define   AN8855_R03_MANG_FR		BIT(14)
+#define   AN8855_R03_BPDU_FR		BIT(12)
+#define   AN8855_R03_EG_TAG		GENMASK(11, 9)
+#define   AN8855_R03_LKY_VLAN		BIT(8)
+#define   AN8855_R03_PRI_HIGH		BIT(7)
+#define   AN8855_R03_MIR		GENMASK(4, 3)
+#define   AN8855_R03_PORT_FW		GENMASK(2, 0)
+
+#define AN8855_AAC			0x102000a0
+#define   AN8855_MAC_AUTO_FLUSH		BIT(28)
+/* Control Address Table Age time.
+ * (AN8855_AGE_CNT + 1) * ( AN8855_AGE_UNIT + 1 ) * AN8855_L2_AGING_MS_CONSTANT
+ */
+#define   AN8855_AGE_CNT		GENMASK(20, 12)
+/* Value in seconds. Value is always incremented of 1 */
+#define   AN8855_AGE_UNIT		GENMASK(10, 0)
+
+/* Registers for ARL Unknown Unicast Forward control */
+#define AN8855_UNUF			0x102000b4
+
+/* Registers for ARL Unknown Multicast Forward control */
+#define AN8855_UNMF			0x102000b8
+
+/* Registers for ARL Broadcast forward control */
+#define AN8855_BCF			0x102000bc
+
+/* Registers for port address age disable */
+#define AN8855_AGDIS			0x102000c0
+
+/* Registers for mirror port control */
+#define AN8855_MIR			0x102000cc
+#define   AN8855_MIRROR_EN		BIT(7)
+#define   AN8855_MIRROR_PORT		GENMASK(4, 0)
+
+/* Registers for BPDU and PAE frame control*/
+#define AN8855_BPC			0x102000d0
+#define   AN8855_BPDU_MANG_FR		BIT(14)
+#define   AN8855_BPDU_BPDU_FR		BIT(12)
+#define   AN8855_BPDU_EG_TAG		GENMASK(11, 9)
+#define   AN8855_BPDU_LKY_VLAN		BIT(8)
+#define   AN8855_BPDU_PRI_HIGH		BIT(7)
+#define   AN8855_BPDU_MIR		GENMASK(4, 3)
+#define   AN8855_BPDU_PORT_FW		GENMASK(2, 0)
+
+/* Registers for IP Unknown Multicast Forward control */
+#define AN8855_UNIPMF			0x102000dc
+
+enum an8855_bpdu_port_fw {
+	AN8855_BPDU_FOLLOW_MFC = 0,
+	AN8855_BPDU_CPU_EXCLUDE = 4,
+	AN8855_BPDU_CPU_INCLUDE = 5,
+	AN8855_BPDU_CPU_ONLY = 6,
+	AN8855_BPDU_DROP = 7,
+};
+
+/* Register for address table control */
+#define AN8855_ATC			0x10200300
+#define   AN8855_ATC_BUSY		BIT(31)
+#define   AN8855_ATC_HASH		GENMASK(24, 16)
+#define   AN8855_ATC_HIT		GENMASK(15, 12)
+#define   AN8855_ATC_MAT_MASK		GENMASK(11, 7)
+#define   AN8855_ATC_MAT(x)		FIELD_PREP(AN8855_ATC_MAT_MASK, x)
+#define   AN8855_ATC_SAT		GENMASK(5, 4)
+#define   AN8855_ATC_CMD		GENMASK(2, 0)
+
+enum an8855_fdb_mat_cmds {
+	AND8855_FDB_MAT_ALL = 0,
+	AND8855_FDB_MAT_MAC, /* All MAC address */
+	AND8855_FDB_MAT_DYNAMIC_MAC, /* All Dynamic MAC address */
+	AND8855_FDB_MAT_STATIC_MAC, /* All Static Mac Address */
+	AND8855_FDB_MAT_DIP, /* All DIP/GA address */
+	AND8855_FDB_MAT_DIP_IPV4, /* All DIP/GA IPv4 address */
+	AND8855_FDB_MAT_DIP_IPV6, /* All DIP/GA IPv6 address */
+	AND8855_FDB_MAT_DIP_SIP, /* All DIP_SIP address */
+	AND8855_FDB_MAT_DIP_SIP_IPV4, /* All DIP_SIP IPv4 address */
+	AND8855_FDB_MAT_DIP_SIP_IPV6, /* All DIP_SIP IPv6 address */
+	AND8855_FDB_MAT_MAC_CVID, /* All MAC address with CVID */
+	AND8855_FDB_MAT_MAC_FID, /* All MAC address with Filter ID */
+	AND8855_FDB_MAT_MAC_PORT, /* All MAC address with port */
+	AND8855_FDB_MAT_DIP_SIP_DIP_IPV4, /* All DIP_SIP address with DIP_IPV4 */
+	AND8855_FDB_MAT_DIP_SIP_SIP_IPV4, /* All DIP_SIP address with SIP_IPV4 */
+	AND8855_FDB_MAT_DIP_SIP_DIP_IPV6, /* All DIP_SIP address with DIP_IPV6 */
+	AND8855_FDB_MAT_DIP_SIP_SIP_IPV6, /* All DIP_SIP address with SIP_IPV6 */
+	/* All MAC address with MAC type (dynamic or static) with CVID */
+	AND8855_FDB_MAT_MAC_TYPE_CVID,
+	/* All MAC address with MAC type (dynamic or static) with Filter ID */
+	AND8855_FDB_MAT_MAC_TYPE_FID,
+	/* All MAC address with MAC type (dynamic or static) with port */
+	AND8855_FDB_MAT_MAC_TYPE_PORT,
+};
+
+enum an8855_fdb_cmds {
+	AN8855_FDB_READ = 0,
+	AN8855_FDB_WRITE = 1,
+	AN8855_FDB_FLUSH = 2,
+	AN8855_FDB_START = 4,
+	AN8855_FDB_NEXT = 5,
+};
+
+/* Registers for address table access */
+#define AN8855_ATA1			0x10200304
+#define   AN8855_ATA1_MAC0		GENMASK(31, 24)
+#define   AN8855_ATA1_MAC1		GENMASK(23, 16)
+#define   AN8855_ATA1_MAC2		GENMASK(15, 8)
+#define   AN8855_ATA1_MAC3		GENMASK(7, 0)
+#define AN8855_ATA2			0x10200308
+#define   AN8855_ATA2_MAC4		GENMASK(31, 24)
+#define   AN8855_ATA2_MAC5		GENMASK(23, 16)
+#define   AN8855_ATA2_UNAUTH		BIT(10)
+#define   AN8855_ATA2_TYPE		BIT(9) /* 1: dynamic, 0: static */
+#define   AN8855_ATA2_AGE		GENMASK(8, 0)
+
+/* Register for address table write data */
+#define AN8855_ATWD			0x10200324
+#define   AN8855_ATWD_FID		GENMASK(31, 28)
+#define   AN8855_ATWD_VID		GENMASK(27, 16)
+#define   AN8855_ATWD_IVL		BIT(15)
+#define   AN8855_ATWD_EG_TAG		GENMASK(14, 12)
+#define   AN8855_ATWD_SA_MIR		GENMASK(9, 8)
+#define   AN8855_ATWD_SA_FWD		GENMASK(7, 5)
+#define   AN8855_ATWD_UPRI		GENMASK(4, 2)
+#define   AN8855_ATWD_LEAKY		BIT(1)
+#define   AN8855_ATWD_VLD		BIT(0) /* vid LOAD */
+#define AN8855_ATWD2			0x10200328
+#define   AN8855_ATWD2_PORT		GENMASK(7, 0)
+
+/* Registers for table search read address */
+#define AN8855_ATRDS			0x10200330
+#define   AN8855_ATRD_SEL		GENMASK(1, 0)
+#define AN8855_ATRD0			0x10200334
+#define   AN8855_ATRD0_FID		GENMASK(28, 25)
+#define   AN8855_ATRD0_VID		GENMASK(21, 10)
+#define   AN8855_ATRD0_IVL		BIT(9)
+#define   AN8855_ATRD0_TYPE		GENMASK(4, 3)
+#define   AN8855_ATRD0_ARP		GENMASK(2, 1)
+#define   AN8855_ATRD0_LIVE		BIT(0)
+#define AN8855_ATRD1			0x10200338
+#define   AN8855_ATRD1_MAC4		GENMASK(31, 24)
+#define   AN8855_ATRD1_MAC5		GENMASK(23, 16)
+#define   AN8855_ATRD1_AGING		GENMASK(10, 3)
+#define AN8855_ATRD2			0x1020033c
+#define   AN8855_ATRD2_MAC0		GENMASK(31, 24)
+#define   AN8855_ATRD2_MAC1		GENMASK(23, 16)
+#define   AN8855_ATRD2_MAC2		GENMASK(15, 8)
+#define   AN8855_ATRD2_MAC3		GENMASK(7, 0)
+#define AN8855_ATRD3			0x10200340
+#define   AN8855_ATRD3_PORTMASK		GENMASK(7, 0)
+
+enum an8855_fdb_type {
+	AN8855_MAC_TB_TY_MAC = 0,
+	AN8855_MAC_TB_TY_DIP = 1,
+	AN8855_MAC_TB_TY_DIP_SIP = 2,
+};
+
+/* Register for vlan table control */
+#define AN8855_VTCR			0x10200600
+#define   AN8855_VTCR_BUSY		BIT(31)
+#define   AN8855_VTCR_FUNC		GENMASK(15, 12)
+#define   AN8855_VTCR_VID		GENMASK(11, 0)
+
+enum an8855_vlan_cmd {
+	/* Read/Write the specified VID entry from VAWD register based
+	 * on VID.
+	 */
+	AN8855_VTCR_RD_VID = 0,
+	AN8855_VTCR_WR_VID = 1,
+};
+
+/* Register for setup vlan write data */
+#define AN8855_VAWD0			0x10200604
+/* VLAN Member Control */
+#define   AN8855_VA0_PORT		GENMASK(31, 26)
+/* Egress Tag Control */
+#define   AN8855_VA0_ETAG		GENMASK(23, 12)
+#define   AN8855_VA0_ETAG_PORT		GENMASK(13, 12)
+#define   AN8855_VA0_ETAG_PORT_SHIFT(port) ((port) * 2)
+#define   AN8855_VA0_ETAG_PORT_MASK(port) (AN8855_VA0_ETAG_PORT << \
+						AN8855_VA0_ETAG_PORT_SHIFT(port))
+#define   AN8855_VA0_ETAG_PORT_VAL(port, val) (FIELD_PREP(AN8855_VA0_ETAG_PORT, (val)) << \
+						AN8855_VA0_ETAG_PORT_SHIFT(port))
+#define   AN8855_VA0_EG_CON		BIT(11)
+#define   AN8855_VA0_VTAG_EN		BIT(10) /* Per VLAN Egress Tag Control */
+#define   AN8855_VA0_IVL_MAC		BIT(5) /* Independent VLAN Learning */
+#define	  AN8855_VA0_FID		GENMASK(4, 1)
+#define   AN8855_VA0_VLAN_VALID		BIT(0) /* VLAN Entry Valid */
+#define AN8855_VAWD1			0x10200608
+#define   AN8855_VA1_PORT_STAG		BIT(1)
+
+enum an8855_fid {
+	AN8855_FID_STANDALONE = 0,
+	AN8855_FID_BRIDGED = 1,
+};
+
+/* Same register field of VAWD0 */
+#define AN8855_VARD0			0x10200618
+
+enum an8855_vlan_egress_attr {
+	AN8855_VLAN_EGRESS_UNTAG = 0,
+	AN8855_VLAN_EGRESS_TAG = 2,
+	AN8855_VLAN_EGRESS_STACK = 3,
+};
+
+/* Register for port STP state control */
+#define AN8855_SSP_P(x)			(0x10208000 + ((x) * 0x200))
+/* Up to 16 FID supported, each with the same mask */
+#define	  AN8855_FID_PST		GENMASK(1, 0)
+#define   AN8855_FID_PST_SHIFT(fid)	(2 * (fid))
+#define   AN8855_FID_PST_MASK(fid)	(AN8855_FID_PST << \
+						AN8855_FID_PST_SHIFT(fid))
+#define   AN8855_FID_PST_VAL(fid, val)	(FIELD_PREP(AN8855_FID_PST, (val)) << \
+						AN8855_FID_PST_SHIFT(fid))
+
+enum an8855_stp_state {
+	AN8855_STP_DISABLED = 0,
+	AN8855_STP_BLOCKING = 1,
+	AN8855_STP_LISTENING = AN8855_STP_BLOCKING,
+	AN8855_STP_LEARNING = 2,
+	AN8855_STP_FORWARDING = 3
+};
+
+/* Register for port control */
+#define AN8855_PCR_P(x)			(0x10208004 + ((x) * 0x200))
+#define   AN8855_EG_TAG			GENMASK(29, 28)
+#define   AN8855_PORT_PRI		GENMASK(26, 24)
+#define   AN8855_PORT_TX_MIR		BIT(20)
+#define   AN8855_PORT_RX_MIR		BIT(16)
+#define   AN8855_PORT_VLAN		GENMASK(1, 0)
+
+enum an8855_port_mode {
+	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
+	AN8855_PORT_MATRIX_MODE = 0,
+
+	/* Fallback Mode: Forward received frames with ingress ports that do
+	 * not belong to the VLAN member. Frames whose VID is not listed on
+	 * the VLAN table are forwarded by the PCR_MATRIX members.
+	 */
+	AN8855_PORT_FALLBACK_MODE = 1,
+
+	/* Check Mode: Forward received frames whose ingress do not
+	 * belong to the VLAN member. Discard frames if VID ismiddes on the
+	 * VLAN table.
+	 */
+	AN8855_PORT_CHECK_MODE = 2,
+
+	/* Security Mode: Discard any frame due to ingress membership
+	 * violation or VID missed on the VLAN table.
+	 */
+	AN8855_PORT_SECURITY_MODE = 3,
+};
+
+/* Register for port security control */
+#define AN8855_PSC_P(x)			(0x1020800c + ((x) * 0x200))
+#define   AN8855_SA_DIS			BIT(4)
+
+/* Register for port vlan control */
+#define AN8855_PVC_P(x)			(0x10208010 + ((x) * 0x200))
+#define   AN8855_PORT_SPEC_REPLACE_MODE	BIT(11)
+#define   AN8855_PVC_EG_TAG		GENMASK(10, 8)
+#define   AN8855_VLAN_ATTR		GENMASK(7, 6)
+#define   AN8855_PORT_SPEC_TAG		BIT(5)
+#define   AN8855_ACC_FRM		GENMASK(1, 0)
+
+enum an8855_vlan_port_eg_tag {
+	AN8855_VLAN_EG_DISABLED = 0,
+	AN8855_VLAN_EG_CONSISTENT = 1,
+	AN8855_VLAN_EG_UNTAGGED = 4,
+	AN8855_VLAN_EG_SWAP = 5,
+	AN8855_VLAN_EG_TAGGED = 6,
+	AN8855_VLAN_EG_STACK = 7,
+};
+
+enum an8855_vlan_port_attr {
+	AN8855_VLAN_USER = 0,
+	AN8855_VLAN_STACK = 1,
+	AN8855_VLAN_TRANSPARENT = 3,
+};
+
+enum an8855_vlan_port_acc_frm {
+	AN8855_VLAN_ACC_ALL = 0,
+	AN8855_VLAN_ACC_TAGGED = 1,
+	AN8855_VLAN_ACC_UNTAGGED = 2,
+};
+
+#define AN8855_PPBV1_P(x)		(0x10208014 + ((x) * 0x200))
+#define   AN8855_PPBV_G0_PORT_VID	GENMASK(11, 0)
+
+#define AN8855_PORTMATRIX_P(x)		(0x10208044 + ((x) * 0x200))
+#define   AN8855_PORTMATRIX		GENMASK(5, 0)
+/* Port matrix without the CPU port that should never be removed */
+#define   AN8855_USER_PORTMATRIX	GENMASK(4, 0)
+
+/* Register for port PVID */
+#define AN8855_PVID_P(x)		(0x10208048 + ((x) * 0x200))
+#define   AN8855_G0_PORT_VID		GENMASK(11, 0)
+
+/* Register for port MAC control register */
+#define AN8855_PMCR_P(x)		(0x10210000 + ((x) * 0x200))
+#define   AN8855_PMCR_FORCE_MODE	BIT(31)
+#define   AN8855_PMCR_FORCE_SPEED	GENMASK(30, 28)
+#define   AN8855_PMCR_FORCE_SPEED_5000	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x4)
+#define   AN8855_PMCR_FORCE_SPEED_2500	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x3)
+#define   AN8855_PMCR_FORCE_SPEED_1000	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x2)
+#define   AN8855_PMCR_FORCE_SPEED_100	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x1)
+#define   AN8855_PMCR_FORCE_SPEED_10	FIELD_PREP_CONST(AN8855_PMCR_FORCE_SPEED, 0x1)
+#define   AN8855_PMCR_FORCE_FDX		BIT(25)
+#define   AN8855_PMCR_FORCE_LNK		BIT(24)
+#define   AN8855_PMCR_IFG_XMIT		GENMASK(21, 20)
+#define   AN8855_PMCR_EXT_PHY		BIT(19)
+#define   AN8855_PMCR_MAC_MODE		BIT(18)
+#define   AN8855_PMCR_TX_EN		BIT(16)
+#define   AN8855_PMCR_RX_EN		BIT(15)
+#define   AN8855_PMCR_BACKOFF_EN	BIT(12)
+#define   AN8855_PMCR_BACKPR_EN		BIT(11)
+#define   AN8855_PMCR_FORCE_EEE5G	BIT(9)
+#define   AN8855_PMCR_FORCE_EEE2P5G	BIT(8)
+#define   AN8855_PMCR_FORCE_EEE1G	BIT(7)
+#define   AN8855_PMCR_FORCE_EEE100	BIT(6)
+#define   AN8855_PMCR_TX_FC_EN		BIT(5)
+#define   AN8855_PMCR_RX_FC_EN		BIT(4)
+
+#define AN8855_PMSR_P(x)		(0x10210010 + (x) * 0x200)
+#define   AN8855_PMSR_SPEED		GENMASK(30, 28)
+#define   AN8855_PMSR_SPEED_5000	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x4)
+#define   AN8855_PMSR_SPEED_2500	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x3)
+#define   AN8855_PMSR_SPEED_1000	FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x2)
+#define   AN8855_PMSR_SPEED_100		FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x1)
+#define   AN8855_PMSR_SPEED_10		FIELD_PREP_CONST(AN8855_PMSR_SPEED, 0x0)
+#define   AN8855_PMSR_DPX		BIT(25)
+#define   AN8855_PMSR_LNK		BIT(24)
+#define   AN8855_PMSR_EEE1G		BIT(7)
+#define   AN8855_PMSR_EEE100M		BIT(6)
+#define   AN8855_PMSR_RX_FC		BIT(5)
+#define   AN8855_PMSR_TX_FC		BIT(4)
+
+#define AN8855_PMEEECR_P(x)		(0x10210004 + (x) * 0x200)
+#define   AN8855_LPI_MODE_EN		BIT(31)
+#define   AN8855_WAKEUP_TIME_2500	GENMASK(23, 16)
+#define   AN8855_WAKEUP_TIME_1000	GENMASK(15, 8)
+#define   AN8855_WAKEUP_TIME_100	GENMASK(7, 0)
+#define AN8855_PMEEECR2_P(x)		(0x10210008 + (x) * 0x200)
+#define   AN8855_WAKEUP_TIME_5000	GENMASK(7, 0)
+
+#define AN8855_GMACCR			0x10213e00
+#define   AN8855_MAX_RX_JUMBO		GENMASK(7, 4)
+/* 2K for 0x0, 0x1, 0x2 */
+#define   AN8855_MAX_RX_JUMBO_2K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x0)
+#define   AN8855_MAX_RX_JUMBO_3K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x3)
+#define   AN8855_MAX_RX_JUMBO_4K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x4)
+#define   AN8855_MAX_RX_JUMBO_5K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x5)
+#define   AN8855_MAX_RX_JUMBO_6K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x6)
+#define   AN8855_MAX_RX_JUMBO_7K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x7)
+#define   AN8855_MAX_RX_JUMBO_8K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x8)
+#define   AN8855_MAX_RX_JUMBO_9K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x9)
+#define   AN8855_MAX_RX_JUMBO_12K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xa)
+#define   AN8855_MAX_RX_JUMBO_15K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xb)
+#define   AN8855_MAX_RX_JUMBO_16K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xc)
+#define   AN8855_MAX_RX_PKT_LEN		GENMASK(1, 0)
+#define   AN8855_MAX_RX_PKT_1518_1522	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x0)
+#define   AN8855_MAX_RX_PKT_1536	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x1)
+#define   AN8855_MAX_RX_PKT_1552	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x2)
+#define   AN8855_MAX_RX_PKT_JUMBO	FIELD_PREP_CONST(AN8855_MAX_RX_PKT_LEN, 0x3)
+
+#define AN8855_CKGCR			0x10213e1c
+#define   AN8855_LPI_TXIDLE_THD_MASK	GENMASK(31, 14)
+#define   AN8855_CKG_LNKDN_PORT_STOP	BIT(1)
+#define   AN8855_CKG_LNKDN_GLB_STOP	BIT(0)
+
+/* Register for MIB */
+#define AN8855_PORT_MIB_COUNTER(x)	(0x10214000 + (x) * 0x200)
+/* Each define is an offset of AN8855_PORT_MIB_COUNTER */
+#define   AN8855_PORT_MIB_TX_DROP	0x00
+#define   AN8855_PORT_MIB_TX_CRC_ERR	0x04
+#define   AN8855_PORT_MIB_TX_UNICAST	0x08
+#define   AN8855_PORT_MIB_TX_MULTICAST	0x0c
+#define   AN8855_PORT_MIB_TX_BROADCAST	0x10
+#define   AN8855_PORT_MIB_TX_COLLISION	0x14
+#define   AN8855_PORT_MIB_TX_SINGLE_COLLISION 0x18
+#define   AN8855_PORT_MIB_TX_MULTIPLE_COLLISION 0x1c
+#define   AN8855_PORT_MIB_TX_DEFERRED	0x20
+#define   AN8855_PORT_MIB_TX_LATE_COLLISION 0x24
+#define   AN8855_PORT_MIB_TX_EXCESSIVE_COLLISION 0x28
+#define   AN8855_PORT_MIB_TX_PAUSE	0x2c
+#define   AN8855_PORT_MIB_TX_PKT_SZ_64	0x30
+#define   AN8855_PORT_MIB_TX_PKT_SZ_65_TO_127 0x34
+#define   AN8855_PORT_MIB_TX_PKT_SZ_128_TO_255 0x38
+#define   AN8855_PORT_MIB_TX_PKT_SZ_256_TO_511 0x3
+#define   AN8855_PORT_MIB_TX_PKT_SZ_512_TO_1023 0x40
+#define   AN8855_PORT_MIB_TX_PKT_SZ_1024_TO_1518 0x44
+#define   AN8855_PORT_MIB_TX_PKT_SZ_1519_TO_MAX 0x48
+#define   AN8855_PORT_MIB_TX_BYTES	0x4c /* 64 bytes */
+#define   AN8855_PORT_MIB_TX_OVERSIZE_DROP 0x54
+#define   AN8855_PORT_MIB_TX_BAD_PKT_BYTES 0x58 /* 64 bytes */
+#define   AN8855_PORT_MIB_RX_DROP	0x80
+#define   AN8855_PORT_MIB_RX_FILTERING	0x84
+#define   AN8855_PORT_MIB_RX_UNICAST	0x88
+#define   AN8855_PORT_MIB_RX_MULTICAST	0x8c
+#define   AN8855_PORT_MIB_RX_BROADCAST	0x90
+#define   AN8855_PORT_MIB_RX_ALIGN_ERR	0x94
+#define   AN8855_PORT_MIB_RX_CRC_ERR	0x98
+#define   AN8855_PORT_MIB_RX_UNDER_SIZE_ERR 0x9c
+#define   AN8855_PORT_MIB_RX_FRAG_ERR	0xa0
+#define   AN8855_PORT_MIB_RX_OVER_SZ_ERR 0xa4
+#define   AN8855_PORT_MIB_RX_JABBER_ERR	0xa8
+#define   AN8855_PORT_MIB_RX_PAUSE	0xac
+#define   AN8855_PORT_MIB_RX_PKT_SZ_64	0xb0
+#define   AN8855_PORT_MIB_RX_PKT_SZ_65_TO_127 0xb4
+#define   AN8855_PORT_MIB_RX_PKT_SZ_128_TO_255 0xb8
+#define   AN8855_PORT_MIB_RX_PKT_SZ_256_TO_511 0xbc
+#define   AN8855_PORT_MIB_RX_PKT_SZ_512_TO_1023 0xc0
+#define   AN8855_PORT_MIB_RX_PKT_SZ_1024_TO_1518 0xc4
+#define   AN8855_PORT_MIB_RX_PKT_SZ_1519_TO_MAX 0xc8
+#define   AN8855_PORT_MIB_RX_BYTES	0xcc /* 64 bytes */
+#define   AN8855_PORT_MIB_RX_CTRL_DROP	0xd4
+#define   AN8855_PORT_MIB_RX_INGRESS_DROP 0xd8
+#define   AN8855_PORT_MIB_RX_ARL_DROP	0xdc
+#define   AN8855_PORT_MIB_FLOW_CONTROL_DROP 0xe0
+#define   AN8855_PORT_MIB_WRED_DROP	0xe4
+#define   AN8855_PORT_MIB_MIRROR_DROP	0xe8
+#define   AN8855_PORT_MIB_RX_BAD_PKT_BYTES 0xec /* 64 bytes */
+#define   AN8855_PORT_MIB_RXS_FLOW_SAMPLING_PKT_DROP 0xf4
+#define   AN8855_PORT_MIB_RXS_FLOW_TOTAL_PKT_DROP 0xf8
+#define   AN8855_PORT_MIB_PORT_CONTROL_DROP 0xfc
+#define AN8855_MIB_CCR			0x10213e30
+#define   AN8855_CCR_MIB_ENABLE		BIT(31)
+#define   AN8855_CCR_RX_OCT_CNT_GOOD	BIT(7)
+#define   AN8855_CCR_RX_OCT_CNT_BAD	BIT(6)
+#define   AN8855_CCR_TX_OCT_CNT_GOOD	BIT(5)
+#define   AN8855_CCR_TX_OCT_CNT_BAD	BIT(4)
+#define   AN8855_CCR_RX_OCT_CNT_GOOD_2	BIT(3)
+#define   AN8855_CCR_RX_OCT_CNT_BAD_2	BIT(2)
+#define   AN8855_CCR_TX_OCT_CNT_GOOD_2	BIT(1)
+#define   AN8855_CCR_TX_OCT_CNT_BAD_2	BIT(0)
+#define   AN8855_CCR_MIB_ACTIVATE	(AN8855_CCR_MIB_ENABLE | \
+					 AN8855_CCR_RX_OCT_CNT_GOOD | \
+					 AN8855_CCR_RX_OCT_CNT_BAD | \
+					 AN8855_CCR_TX_OCT_CNT_GOOD | \
+					 AN8855_CCR_TX_OCT_CNT_BAD | \
+					 AN8855_CCR_RX_OCT_CNT_BAD_2 | \
+					 AN8855_CCR_TX_OCT_CNT_BAD_2)
+#define AN8855_MIB_CLR			0x10213e34
+#define   AN8855_MIB_PORT6_CLR		BIT(6)
+#define   AN8855_MIB_PORT5_CLR		BIT(5)
+#define   AN8855_MIB_PORT4_CLR		BIT(4)
+#define   AN8855_MIB_PORT3_CLR		BIT(3)
+#define   AN8855_MIB_PORT2_CLR		BIT(2)
+#define   AN8855_MIB_PORT1_CLR		BIT(1)
+#define   AN8855_MIB_PORT0_CLR		BIT(0)
+
+/* HSGMII/SGMII Configuration register */
+/*	AN8855_HSGMII_AN_CSR_BASE	0x10220000 */
+#define AN8855_SGMII_REG_AN0		0x10220000
+/*        AN8855_SGMII_AN_ENABLE	BMCR_ANENABLE */
+/*        AN8855_SGMII_AN_RESTART	BMCR_ANRESTART */
+#define AN8855_SGMII_REG_AN_13		0x10220034
+#define   AN8855_SGMII_REMOTE_FAULT_DIS	BIT(8)
+#define   AN8855_SGMII_IF_MODE		GENMASK(5, 0)
+#define AN8855_SGMII_REG_AN_FORCE_CL37	0x10220060
+#define   AN8855_RG_FORCE_AN_DONE	BIT(0)
+
+/*	AN8855_HSGMII_CSR_PCS_BASE	0x10220000 */
+#define AN8855_RG_HSGMII_PCS_CTROL_1	0x10220a00
+#define   AN8855_RG_TBI_10B_MODE	BIT(30)
+#define AN8855_RG_AN_SGMII_MODE_FORCE	0x10220a24
+#define   AN8855_RG_FORCE_CUR_SGMII_MODE GENMASK(5, 4)
+#define   AN8855_RG_FORCE_CUR_SGMII_SEL	BIT(0)
+
+/*	AN8855_MULTI_SGMII_CSR_BASE	0x10224000 */
+#define AN8855_SGMII_STS_CTRL_0		0x10224018
+#define   AN8855_RG_LINK_MODE_P0	GENMASK(5, 4)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_2500 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x3)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_1000 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x2)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_100 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x1)
+#define   AN8855_RG_LINK_MODE_P0_SPEED_10 FIELD_PREP_CONST(AN8855_RG_LINK_MODE_P0, 0x0)
+#define   AN8855_RG_FORCE_SPD_MODE_P0	BIT(2)
+#define AN8855_MSG_RX_CTRL_0		0x10224100
+#define AN8855_MSG_RX_LIK_STS_0		0x10224514
+#define   AN8855_RG_DPX_STS_P3		BIT(24)
+#define   AN8855_RG_DPX_STS_P2		BIT(16)
+#define   AN8855_RG_EEE1G_STS_P1	BIT(12)
+#define   AN8855_RG_DPX_STS_P1		BIT(8)
+#define   AN8855_RG_TXFC_STS_P0		BIT(2)
+#define   AN8855_RG_RXFC_STS_P0		BIT(1)
+#define   AN8855_RG_DPX_STS_P0		BIT(0)
+#define AN8855_MSG_RX_LIK_STS_2		0x1022451c
+#define   AN8855_RG_RXFC_AN_BYPASS_P3	BIT(11)
+#define   AN8855_RG_RXFC_AN_BYPASS_P2	BIT(10)
+#define   AN8855_RG_RXFC_AN_BYPASS_P1	BIT(9)
+#define   AN8855_RG_TXFC_AN_BYPASS_P3	BIT(7)
+#define   AN8855_RG_TXFC_AN_BYPASS_P2	BIT(6)
+#define   AN8855_RG_TXFC_AN_BYPASS_P1	BIT(5)
+#define   AN8855_RG_DPX_AN_BYPASS_P3	BIT(3)
+#define   AN8855_RG_DPX_AN_BYPASS_P2	BIT(2)
+#define   AN8855_RG_DPX_AN_BYPASS_P1	BIT(1)
+#define   AN8855_RG_DPX_AN_BYPASS_P0	BIT(0)
+#define AN8855_PHY_RX_FORCE_CTRL_0	0x10224520
+#define   AN8855_RG_FORCE_TXC_SEL	BIT(4)
+
+/*	AN8855_XFI_CSR_PCS_BASE		0x10225000 */
+#define AN8855_RG_USXGMII_AN_CONTROL_0	0x10225bf8
+
+/*	AN8855_MULTI_PHY_RA_CSR_BASE	0x10226000 */
+#define AN8855_RG_RATE_ADAPT_CTRL_0	0x10226000
+#define   AN8855_RG_RATE_ADAPT_RX_BYPASS BIT(27)
+#define   AN8855_RG_RATE_ADAPT_TX_BYPASS BIT(26)
+#define   AN8855_RG_RATE_ADAPT_RX_EN	BIT(4)
+#define   AN8855_RG_RATE_ADAPT_TX_EN	BIT(0)
+#define AN8855_RATE_ADP_P0_CTRL_0	0x10226100
+#define   AN8855_RG_P0_DIS_MII_MODE	BIT(31)
+#define   AN8855_RG_P0_MII_MODE		BIT(28)
+#define   AN8855_RG_P0_MII_RA_RX_EN	BIT(3)
+#define   AN8855_RG_P0_MII_RA_TX_EN	BIT(2)
+#define   AN8855_RG_P0_MII_RA_RX_MODE	BIT(1)
+#define   AN8855_RG_P0_MII_RA_TX_MODE	BIT(0)
+#define AN8855_MII_RA_AN_ENABLE		0x10226300
+#define   AN8855_RG_P0_RA_AN_EN		BIT(0)
+
+/*	AN8855_QP_DIG_CSR_BASE		0x1022a000 */
+#define AN8855_QP_CK_RST_CTRL_4		0x1022a310
+#define AN8855_QP_DIG_MODE_CTRL_0	0x1022a324
+#define   AN8855_RG_SGMII_MODE		GENMASK(5, 4)
+#define   AN8855_RG_SGMII_AN_EN		BIT(0)
+#define AN8855_QP_DIG_MODE_CTRL_1	0x1022a330
+#define   AN8855_RG_TPHY_SPEED		GENMASK(3, 2)
+
+/*	AN8855_SERDES_WRAPPER_BASE	0x1022c000 */
+#define AN8855_USGMII_CTRL_0		0x1022c000
+
+/*	AN8855_QP_PMA_TOP_BASE		0x1022e000 */
+#define AN8855_PON_RXFEDIG_CTRL_0	0x1022e100
+#define   AN8855_RG_QP_EQ_RX500M_CK_SEL	BIT(12)
+#define AN8855_PON_RXFEDIG_CTRL_9	0x1022e124
+#define   AN8855_RG_QP_EQ_LEQOSC_DLYCNT	GENMASK(2, 0)
+
+#define AN8855_SS_LCPLL_PWCTL_SETTING_2	0x1022e208
+#define   AN8855_RG_NCPO_ANA_MSB	GENMASK(17, 16)
+#define AN8855_SS_LCPLL_TDC_FLT_2	0x1022e230
+#define   AN8855_RG_LCPLL_NCPO_VALUE	GENMASK(30, 0)
+#define AN8855_SS_LCPLL_TDC_FLT_5	0x1022e23c
+#define   AN8855_RG_LCPLL_NCPO_CHG	BIT(24)
+#define AN8855_SS_LCPLL_TDC_PCW_1	0x1022e248
+#define  AN8855_RG_LCPLL_PON_HRDDS_PCW_NCPO_GPON GENMASK(30, 0)
+#define AN8855_INTF_CTRL_8		0x1022e320
+#define AN8855_INTF_CTRL_9		0x1022e324
+#define AN8855_INTF_CTRL_10		0x1022e328
+#define   AN8855_RG_DA_QP_TX_FIR_C2_SEL	BIT(29)
+#define   AN8855_RG_DA_QP_TX_FIR_C2_FORCE GENMASK(28, 24)
+#define   AN8855_RG_DA_QP_TX_FIR_C1_SEL	BIT(21)
+#define   AN8855_RG_DA_QP_TX_FIR_C1_FORCE GENMASK(20, 16)
+#define AN8855_INTF_CTRL_11		0x1022e32c
+#define   AN8855_RG_DA_QP_TX_FIR_C0B_SEL BIT(6)
+#define   AN8855_RG_DA_QP_TX_FIR_C0B_FORCE GENMASK(5, 0)
+#define AN8855_PLL_CTRL_0		0x1022e400
+#define   AN8855_RG_PHYA_AUTO_INIT	BIT(0)
+#define AN8855_PLL_CTRL_2		0x1022e408
+#define   AN8855_RG_DA_QP_PLL_SDM_IFM_INTF BIT(30)
+#define   AN8855_RG_DA_QP_PLL_RICO_SEL_INTF BIT(29)
+#define   AN8855_RG_DA_QP_PLL_POSTDIV_EN_INTF BIT(28)
+#define   AN8855_RG_DA_QP_PLL_PHY_CK_EN_INTF BIT(27)
+#define   AN8855_RG_DA_QP_PLL_PFD_OFFSET_EN_INTRF BIT(26)
+#define   AN8855_RG_DA_QP_PLL_PFD_OFFSET_INTF GENMASK(25, 24)
+#define   AN8855_RG_DA_QP_PLL_PCK_SEL_INTF BIT(22)
+#define   AN8855_RG_DA_QP_PLL_KBAND_PREDIV_INTF GENMASK(21, 20)
+#define   AN8855_RG_DA_QP_PLL_IR_INTF	GENMASK(19, 16)
+#define   AN8855_RG_DA_QP_PLL_ICOIQ_EN_INTF BIT(14)
+#define   AN8855_RG_DA_QP_PLL_FBKSEL_INTF GENMASK(13, 12)
+#define   AN8855_RG_DA_QP_PLL_BR_INTF	GENMASK(10, 8)
+#define   AN8855_RG_DA_QP_PLL_BPD_INTF	GENMASK(7, 6)
+#define   AN8855_RG_DA_QP_PLL_BPA_INTF	GENMASK(4, 2)
+#define   AN8855_RG_DA_QP_PLL_BC_INTF	GENMASK(1, 0)
+#define AN8855_PLL_CTRL_3		0x1022e40c
+#define   AN8855_RG_DA_QP_PLL_SSC_PERIOD_INTF GENMASK(31, 16)
+#define   AN8855_RG_DA_QP_PLL_SSC_DELTA_INTF GENMASK(15, 0)
+#define AN8855_PLL_CTRL_4		0x1022e410
+#define   AN8855_RG_DA_QP_PLL_SDM_HREN_INTF GENMASK(4, 3)
+#define   AN8855_RG_DA_QP_PLL_ICOLP_EN_INTF BIT(2)
+#define   AN8855_RG_DA_QP_PLL_SSC_DIR_DLY_INTF GENMASK(1, 0)
+#define AN8855_PLL_CK_CTRL_0		0x1022e414
+#define   AN8855_RG_DA_QP_PLL_TDC_TXCK_SEL_INTF BIT(9)
+#define   AN8855_RG_DA_QP_PLL_SDM_DI_EN_INTF BIT(8)
+#define AN8855_RX_DLY_0			0x1022e614
+#define   AN8855_RG_QP_RX_SAOSC_EN_H_DLY GENMASK(13, 8)
+#define   AN8855_RG_QP_RX_PI_CAL_EN_H_DLY GENMASK(7, 0)
+#define AN8855_RX_CTRL_2		0x1022e630
+#define   AN8855_RG_QP_RX_EQ_EN_H_DLY	GENMASK(28, 16)
+#define AN8855_RX_CTRL_5		0x1022e63c
+#define   AN8855_RG_FREDET_CHK_CYCLE	GENMASK(29, 10)
+#define AN8855_RX_CTRL_6		0x1022e640
+#define   AN8855_RG_FREDET_GOLDEN_CYCLE	GENMASK(19, 0)
+#define AN8855_RX_CTRL_7		0x1022e644
+#define   AN8855_RG_FREDET_TOLERATE_CYCLE GENMASK(19, 0)
+#define AN8855_RX_CTRL_8		0x1022e648
+#define   AN8855_RG_DA_QP_SAOSC_DONE_TIME GENMASK(27, 16)
+#define   AN8855_RG_DA_QP_LEQOS_EN_TIME	GENMASK(14, 0)
+#define AN8855_RX_CTRL_26		0x1022e690
+#define   AN8855_RG_QP_EQ_RETRAIN_ONLY_EN BIT(26)
+#define   AN8855_RG_LINK_NE_EN		BIT(24)
+#define   AN8855_RG_LINK_ERRO_EN	BIT(23)
+#define AN8855_RX_CTRL_42		0x1022e6d0
+#define   AN8855_RG_QP_EQ_EN_DLY	GENMASK(12, 0)
+
+/*	AN8855_QP_ANA_CSR_BASE		0x1022f000 */
+#define AN8855_RG_QP_RX_DAC_EN		0x1022f000
+#define   AN8855_RG_QP_SIGDET_HF	GENMASK(17, 16)
+#define AN8855_RG_QP_RXAFE_RESERVE	0x1022f004
+#define   AN8855_RG_QP_CDR_PD_10B_EN	BIT(11)
+#define AN8855_RG_QP_CDR_LPF_BOT_LIM	0x1022f008
+#define   AN8855_RG_QP_CDR_LPF_KP_GAIN	GENMASK(26, 24)
+#define   AN8855_RG_QP_CDR_LPF_KI_GAIN	GENMASK(22, 20)
+#define AN8855_RG_QP_CDR_LPF_MJV_LIM	0x1022f00c
+#define   AN8855_RG_QP_CDR_LPF_RATIO	GENMASK(5, 4)
+#define AN8855_RG_QP_CDR_LPF_SETVALUE	0x1022f014
+#define   AN8855_RG_QP_CDR_PR_BUF_IN_SR	GENMASK(31, 29)
+#define   AN8855_RG_QP_CDR_PR_BETA_SEL	GENMASK(28, 25)
+#define AN8855_RG_QP_CDR_PR_CKREF_DIV1	0x1022f018
+#define   AN8855_RG_QP_CDR_PR_KBAND_DIV	GENMASK(26, 24)
+#define   AN8855_RG_QP_CDR_PR_DAC_BAND	GENMASK(12, 8)
+#define AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE 0x1022f01c
+#define   AN8855_RG_QP_CDR_PR_XFICK_EN	BIT(30)
+#define   AN8855_RG_QP_CDR_PR_KBAND_PCIE_MODE BIT(6)
+#define   AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE_MASK GENMASK(5, 0)
+#define AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF 0x1022f020
+#define   AN8855_RG_QP_CDR_PHYCK_SEL	GENMASK(17, 16)
+#define   AN8855_RG_QP_CDR_PHYCK_RSTB	BIT(13)
+#define   AN8855_RG_QP_CDR_PHYCK_DIV	GENMASK(12, 6)
+#define AN8855_RG_QP_TX_MODE		0x1022f028
+#define   AN8855_RG_QP_TX_RESERVE	GENMASK(31, 16)
+#define   AN8855_RG_QP_TX_MODE_16B_EN	BIT(0)
+#define AN8855_RG_QP_PLL_IPLL_DIG_PWR_SEL 0x1022f03c
+#define AN8855_RG_QP_PLL_SDM_ORD	0x1022f040
+#define   AN8855_RG_QP_PLL_SSC_PHASE_INI BIT(4)
+#define   AN8855_RG_QP_PLL_SSC_TRI_EN	BIT(3)
+
+/*	AN8855_ETHER_SYS_BASE		0x1028c800 */
+#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
+#define AN8855_RG_GPHY_SMI_ADDR		0x1028c848
+
+#define MIB_DESC(_s, _o, _n)	\
+	{			\
+		.size = (_s),	\
+		.offset = (_o),	\
+		.name = (_n),	\
+	}
+
+struct an8855_mib_desc {
+	unsigned int size;
+	unsigned int offset;
+	const char *name;
+};
+
+struct an8855_fdb {
+	u16 vid;
+	u8 port_mask;
+	u8 aging;
+	u8 mac[6];
+	bool noarp;
+	u8 live;
+	u8 type;
+	u8 fid;
+	u8 ivl;
+};
+
+struct an8855_priv {
+	struct device *dev;
+	struct dsa_switch *ds;
+	struct mii_bus *bus;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	/* Protect ATU or VLAN table access */
+	struct mutex reg_mutex;
+
+	struct phylink_pcs pcs;
+
+	unsigned int phy_base;
+
+	u8 mirror_rx;
+	u8 mirror_tx;
+	u8 port_isolated_map;
+
+	bool phy_require_calib;
+};
+
+#endif /* __AN8855_H */
-- 
2.45.2


