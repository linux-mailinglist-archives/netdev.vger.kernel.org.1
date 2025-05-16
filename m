Return-Path: <netdev+bounces-191099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71823ABA0E4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE333B9E6B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F51D5CED;
	Fri, 16 May 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjq8cPcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4E224F6;
	Fri, 16 May 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413727; cv=none; b=LGM3PGFinGeEQM7KgwgvxvzNQnA9MwPBeLrJUvOJMTm82HnhrkzUbYnQWMRXLTGjdmWsMk1h97AzYGkHFNpbu8afsXDYW/Zf85DfIkLFB1MboQCTjteRhQ2c7hHjuELnUc01OPuQUMdf50walIglvCyWJTz1k8sVUCEBL4++hyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413727; c=relaxed/simple;
	bh=oqSCffZ2pSKs1cQhhnUX+LS+VjwStB+2iEVkCsD71c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UI4OmopGfTlkJ9HnjhFe3ZT0QG+JDy8+g/JyIwM75zX0HweUYep/eu06hM1bZy/BthAJMNA4udqVCvVVoh5bYx9rT6pY6kKE+6FHThhvACxoZ82dAbXwVU8+1NbeapUQmlyEWKpIZa93g3wOoh2xNRIdjeKuK61LSYtL3NGLSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjq8cPcq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so4304899a12.0;
        Fri, 16 May 2025 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747413723; x=1748018523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=by2cvq0MhcmA2l2Vo2mRxRGxW56s+5XR6roaek/LVE4=;
        b=Pjq8cPcqVjEdIHxQIabmUv2/A7xSzitqkzHa3mGMxQzD4OgtFmGYmxlfV/Su1X6iEK
         20hEzoYZYtnW4HrZsog5mPTmCSiI2nsKC6ipuNzymYOoTUgAr4xgPU8StqjF1Vi517Ht
         GuYx3S+Kp29IxG1VphT7gkH7XHR0eVsW7Lw86XPkI4dp/389otiJHC9sAISVmoY9nvK+
         PaU7denRWP9dwJqpU7SvZPb7DEPhczA36PeNtdaLRL0laPeAn6kGLtKT5wt+gS3tQ5kv
         ljecIs6YQieHfiV+CWjpEM9qLADgoZlHKN84+79c0unDte5W6nxXISm+AJ73X6eGwrZK
         ytKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413723; x=1748018523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=by2cvq0MhcmA2l2Vo2mRxRGxW56s+5XR6roaek/LVE4=;
        b=ZDTSPDNmGWNAxwECJpYhIIo1eRSwqzDicbw4Iu1x2AK+CBiWVh7LQdVBoB96HbJGmB
         9KoqnobIeiY8hqR778lCgyoEEdEBPK6dxA2961KQbToGP/fLLjjQaOofr2H7Y7AsVQEX
         96iwRoDuuvNc6ewLGkFnRQQVbbvmnOGu2mLBbuHqOrjlRe1hzm2P92+jllqPvYOJRN2G
         qJH7ssUDPTHMNvRiUYNpsz7PUNNjJTDXXKQWZ4zwFTu/UoRZ1VNOm+JKzHmZ5a3Q5FZP
         0UyYicBezD9KdatZd2Hkpt22zg6F68bfP9hwg8w2OuFxbTKJ6gDOgcJHkobKT73grit3
         u2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqAlj7FSRfVOFgrZldEBCfijFoEEGjtCBgs0BYqUgwpvUhFyrC+/AGgiJ3b2dgAvaXdXjClu/a7Vagzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWibRr3Wgzqwu+r6yfZQYDVzOZIr7MiLXmyjoJP7TbbFK+JTIY
	xyeO+IKc2GOkMIHYTTejcLAUxWUcv6wlicqOFF/v1m6C8v5jyEDWw406/qfY6wuH
X-Gm-Gg: ASbGncvJ4WbAF89WaKpimtraLyuvtbTwMe8sgkx61XNPavm11Dwdy7Pceb0ICQ1xmMW
	OcANxJIRCMMW/wDVUxK62DR0iOdPHSt4whzj+igD6169gsrszKjzSReS8RlLlP6/SNlD8PBzHwt
	2t76aObo6y9uQvfSV1Rf7PgnXJzz+DS2quMyXjNzFs8ogKKLMweInb5MUeOPnaSf9iAljfvGUpz
	sGrOdzOzL6BIBT+KvrK8Swreezw5qZQfUrDr0CCMx6RZzqBMHY8HsRvEz27BZsJmJx+OSi7dZuX
	7j54l7UHpX908EVC2pu6O4WRMvCQS3k9vpF/oEu34d6okOJyEqXFuOvtX18XOxtZ8S34fWPYH+G
	DxRChL0oSNeDdy4n0GfkEjAhkNGxg07Tu4XAWt8ylpICoy3R+nw==
X-Google-Smtp-Source: AGHT+IGGN9nYDmWb8SDEDz+73P2HhWCaMve4GMSvU4KLN8yDzGbxN0+jaSIUI5Q8IowcMs/AzdslOA==
X-Received: by 2002:a50:d74b:0:b0:600:2813:b237 with SMTP id 4fb4d7f45d1cf-60119cd0cb8mr2303441a12.31.1747413722226;
        Fri, 16 May 2025 09:42:02 -0700 (PDT)
Received: from Lord-Beerus.tastitalia.local (net-130-25-109-68.cust.vodafonedsl.it. [130.25.109.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d502736sm1669415a12.25.2025.05.16.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:42:01 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stefano.radaelli21@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: [PATCH net-next v2] net: phy: add driver for MaxLinear MxL86110 PHY
Date: Fri, 16 May 2025 18:41:23 +0200
Message-ID: <20250516164126.234883-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
copper, compliant with IEEE 802.3.

The driver implements basic features such as:
- Device initialization
- RGMII interface timing configuration
- Wake-on-LAN support
- LED initialization and control via /sys/class/leds

This driver has been tested on multiple Variscite boards, including:
- VAR-SOM-MX93 (i.MX93)
- VAR-SOM-MX8M-PLUS (i.MX8MP)

Example boot log showing driver probe:
[    7.692101] imx-dwmac 428a0000.ethernet eth0:
        PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=POLL)

Changes from v1:
- Add net-next support
- Improved locking management and tests using CONFIG_PROVE_LOCKING
- General cleanup

Started a new thread

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 MAINTAINERS                 |   1 +
 drivers/net/phy/Kconfig     |  12 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/mxl-86110.c | 570 ++++++++++++++++++++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 drivers/net/phy/mxl-86110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84e99e991f53..cca046bbe00b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14653,6 +14653,7 @@ MAXLINEAR ETHERNET PHY DRIVER
 M:	Xu Liang <lxu@maxlinear.com>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
 MCAN MMIO DEVICE DRIVER
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 677d56e06539..fbaa009c146d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -263,6 +263,18 @@ config MAXLINEAR_GPHY
 	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
 	  GPY241, GPY245 PHYs.
 
+config MAXLINEAR_86110_PHY
+	tristate "MaxLinear MXL86110 PHY support"
+	help
+	 Support for the MaxLinear MXL86110 Gigabit Ethernet
+	 Physical Layer transceiver.
+	 The MXL86110 is commonly used in networking equipment such as
+	 routers, switches, and embedded systems, providing the
+	 physical interface for 10/100/1000 Mbps Ethernet connections
+	 over copper media.
+	 If you are using a board with the MXL86110 PHY connected to your
+	 Ethernet MAC, you should enable this option.
+
 source "drivers/net/phy/mediatek/Kconfig"
 
 config MICREL_PHY
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 59ac3a9a3177..171a80228c12 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
+obj-$(CONFIG_MAXLINEAR_86110_PHY)       += mxl-86110.o
 obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
new file mode 100644
index 000000000000..63f32c49fcc1
--- /dev/null
+++ b/drivers/net/phy/mxl-86110.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PHY driver for Maxlinear MXL86110
+ *
+ * Copyright 2023 MaxLinear Inc.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+/* PHY ID */
+#define PHY_ID_MXL86110		0xc1335580
+
+/* required to access extended registers */
+#define MXL86110_EXTD_REG_ADDR_OFFSET	0x1E
+#define MXL86110_EXTD_REG_ADDR_DATA		0x1F
+#define PHY_IRQ_ENABLE_REG				0x12
+#define PHY_IRQ_ENABLE_REG_WOL			BIT(6)
+
+/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
+#define MXL86110_EXT_SYNCE_CFG_REG						0xA012
+#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL				BIT(4)
+#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN	BIT(5)
+#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E				BIT(6)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK			GENMASK(3, 1)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL		0
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M			4
+
+/* WOL registers */
+#define MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG		0xA007 /* high-> FF:FF                   */
+#define MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG	0xA008 /*    middle-> :FF:FF <-middle    */
+#define MXL86110_WOL_MAC_ADDR_LOW_EXTD_REG		0xA009 /*                   :FF:FF <-low */
+
+#define MXL86110_EXT_WOL_CFG_REG				0xA00A
+#define MXL86110_EXT_WOL_CFG_WOLE_MASK			BIT(3)
+#define MXL86110_EXT_WOL_CFG_WOLE_DISABLE		0
+#define MXL86110_EXT_WOL_CFG_WOLE_ENABLE		BIT(3)
+
+/* RGMII register */
+#define MXL86110_EXT_RGMII_CFG1_REG							0xA003
+/* delay can be adjusted in steps of about 150ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY				(0x0 << 10)
+/* Closest value to 2000 ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS				(0xD << 10)
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK				GENMASK(13, 10)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS			(0xD << 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK			GENMASK(3, 0)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS		(0xD << 4)
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK	GENMASK(7, 4)
+
+#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
+			((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
+			(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
+			(MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK))
+
+/* EXT Sleep Control register */
+#define MXL86110_UTP_EXT_SLEEP_CTRL_REG					0x27
+#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF		0
+#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK	BIT(15)
+
+/* RGMII In-Band Status and MDIO Configuration Register */
+#define MXL86110_EXT_RGMII_MDIO_CFG				0xA005
+#define MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK			GENMASK(6, 6)
+#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK			GENMASK(5, 5)
+#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK			GENMASK(4, 0)
+
+#define MXL86110_MAX_LEDS            3
+/* LED registers and defines */
+#define MXL86110_LED0_CFG_REG 0xA00C
+#define MXL86110_LED1_CFG_REG 0xA00D
+#define MXL86110_LED2_CFG_REG 0xA00E
+
+#define MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND		BIT(13)
+#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON	BIT(12)
+#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON	BIT(11)
+#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON			BIT(10)	/* LED 0,1,2 default */
+#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON			BIT(9)	/* LED 0,1,2 default */
+#define MXL86110_LEDX_CFG_LINK_UP_TX_ON				BIT(8)
+#define MXL86110_LEDX_CFG_LINK_UP_RX_ON				BIT(7)
+#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON			BIT(6) /* LED 2 default */
+#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON			BIT(5) /* LED 1 default */
+#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON			BIT(4) /* LED 0 default */
+#define MXL86110_LEDX_CFG_LINK_UP_COLLISION			BIT(3)
+#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK			BIT(2)
+#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK		BIT(1)
+#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK		BIT(0)
+
+#define MXL86110_LED_BLINK_CFG_REG						0xA00F
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ			0
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ			BIT(0)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ			BIT(1)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ			(BIT(1) | BIT(0))
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ			0
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ			BIT(2)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ			BIT(3)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ			(BIT(3) | BIT(2))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_ON	0
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_PERC_ON	(BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_PERC_ON	(BIT(5))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_PERC_ON	(BIT(5) | BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_OFF	(BIT(6))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_PERC_ON	(BIT(6) | BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_PERC_ON	(BIT(6) | BIT(5))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_PERC_ON	(BIT(6) | BIT(5) | BIT(4))
+
+/* Chip Configuration Register - COM_EXT_CHIP_CFG */
+#define MXL86110_EXT_CHIP_CFG_REG			0xA001
+#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE	BIT(8)
+#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE	BIT(15)
+
+/**
+ * mxl86110_write_extended_reg() - write to a PHY's extended register
+ * @phydev: pointer to a &struct phy_device
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ *
+ * NOTE: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * returns 0 or negative error code
+ */
+static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 regnum, u16 val)
+{
+	int ret;
+
+	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
+}
+
+/**
+ * mxl86110_read_extended_reg - Read a PHY's extended register
+ * @phydev: Pointer to the PHY device structure
+ * @regnum: Extended register number to read (address written to reg 30)
+ *
+ * Reads the content of a PHY extended register using the MaxLinear
+ * 2-step access mechanism: write the register address to reg 30 (0x1E),
+ * then read the value from reg 31 (0x1F).
+ *
+ * NOTE: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 16-bit register value on success, or negative errno code on failure.
+ */
+static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
+	if (ret < 0)
+		return ret;
+	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
+}
+
+/**
+ * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
+ * @phydev: pointer to the phy_device
+ * @regnum: register number to write
+ * @mask: bit mask of bits to clear
+ * @set: bit mask of bits to set
+ *
+ * NOTE: register value = (old register value & ~mask) | set.
+ * This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * returns 0 or negative error code
+ */
+static int mxl86110_modify_extended_reg(struct phy_device *phydev, u16 regnum, u16 mask,
+					u16 set)
+{
+	int ret;
+
+	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, set);
+}
+
+/**
+ * mxl86110_get_wol() - report if wake-on-lan is enabled
+ * @phydev: pointer to the phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ */
+static void mxl86110_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	int value;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+	phy_lock_mdio_bus(phydev);
+	value = mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
+	phy_unlock_mdio_bus(phydev);
+	if (value >= 0 && (value & MXL86110_EXT_WOL_CFG_WOLE_MASK))
+		wol->wolopts |= WAKE_MAGIC;
+}
+
+/**
+ * mxl86110_set_wol() - enable/disable wake-on-lan
+ * @phydev: pointer to the phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ *
+ * Configures the WOL Magic Packet MAC
+ * returns 0 or negative errno code
+ */
+static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	struct net_device *netdev;
+	const u8 *mac;
+	int ret = 0;
+
+	phy_lock_mdio_bus(phydev);
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		netdev = phydev->attached_dev;
+		if (!netdev) {
+			ret = -ENODEV;
+			goto error;
+		}
+
+		/* Configure the MAC address of the WOL magic packet */
+		mac = (const u8 *)netdev->dev_addr;
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG,
+						  ((mac[0] << 8) | mac[1]));
+		if (ret < 0)
+			goto error;
+
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG,
+						  ((mac[2] << 8) | mac[3]));
+		if (ret < 0)
+			goto error;
+
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_LOW_EXTD_REG,
+						  ((mac[4] << 8) | mac[5]));
+		if (ret < 0)
+			goto error;
+
+		ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG,
+						   MXL86110_EXT_WOL_CFG_WOLE_MASK,
+						   MXL86110_EXT_WOL_CFG_WOLE_ENABLE);
+		if (ret < 0)
+			goto error;
+
+		/* Enables Wake-on-LAN interrupt in the PHY. */
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
+				   PHY_IRQ_ENABLE_REG_WOL);
+		if (ret < 0)
+			goto error;
+
+		phydev_dbg(phydev, "%s, WOL Magic packet MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
+			   __func__, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+
+	} else {
+		ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG,
+						   MXL86110_EXT_WOL_CFG_WOLE_MASK,
+						   MXL86110_EXT_WOL_CFG_WOLE_DISABLE);
+		if (ret < 0)
+			goto error;
+
+		/* Disables Wake-on-LAN interrupt in the PHY. */
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
+				   PHY_IRQ_ENABLE_REG_WOL, 0);
+		if (ret < 0)
+			goto error;
+	}
+
+	phy_unlock_mdio_bus(phydev);
+	return 0;
+error:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK_10) |
+						 BIT(TRIGGER_NETDEV_LINK_100) |
+						 BIT(TRIGGER_NETDEV_LINK_1000) |
+						 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_TX) |
+						 BIT(TRIGGER_NETDEV_RX));
+
+static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	u16 val;
+
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
+	phy_unlock_mdio_bus(phydev);
+	if (val < 0)
+		return val;
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
+		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
+		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	return 0;
+};
+
+static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 val = 0;
+	int ret;
+
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_10))
+		val |= MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_100))
+		val |= MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		val |= MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_TX))
+		val |= MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX))
+		val |= MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
+		val |= MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		val |= MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
+
+	if (rules & BIT(TRIGGER_NETDEV_TX) ||
+	    rules & BIT(TRIGGER_NETDEV_RX))
+		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
+
+	phy_lock_mdio_bus(phydev);
+	ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
+	phy_unlock_mdio_bus(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+/**
+ * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
+ * @phydev: pointer to the phy_device
+ *
+ * Custom settings can be defined in custom config section of the driver
+ * returns 0 or negative errno code
+ */
+static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
+{
+	u16 mask = 0, value = 0;
+	int ret = 0;
+
+	/*
+	 * Configures the clock output to its default setting as per the datasheet.
+	 * This results in a 25MHz clock output being selected in the
+	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
+	 */
+	value = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
+				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
+	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
+	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
+
+	/* Write clock output configuration */
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
+					   mask, value);
+
+	return ret;
+}
+
+/**
+ * mxl86110_broadcast_cfg - Configure MDIO broadcast setting for PHY
+ * @phydev: Pointer to the PHY device structure
+ *
+ * This function configures the MDIO broadcast behavior of the MxL86110 PHY.
+ * Currently, broadcast mode is explicitly disabled by clearing the EPA0 bit
+ * in the RGMII_MDIO_CFG extended register.
+ *
+ * Return: 0 on success or a negative errno code on failure.
+ */
+static int mxl86110_broadcast_cfg(struct phy_device *phydev)
+{
+	int ret = 0;
+	u16 val;
+
+	val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG);
+	if (val < 0)
+		return val;
+
+	val &= ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
+	ret = mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG, val);
+
+	return ret;
+}
+
+/**
+ * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
+ * @phydev: Pointer to the PHY device structure
+ *
+ * Configure all PHY LEDs to blink on traffic activity regardless of their
+ * ON or OFF state. This behavior allows each LED to serve as a pure activity
+ * indicator, independently of its use as a link status indicator.
+ *
+ * By default, each LED blinks only when it is also in the ON state. This function
+ * modifies the appropriate registers (LABx fields) to enable blinking even
+ * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
+ * without requiring it to also serve as a link status LED.
+ *
+ * NOTE: Any further LED customization can be performed via the
+ * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
+ * led_hw_control_set are used to support this mechanism.
+ *
+ * Return: 0 on success or a negative errno code on failure.
+ */
+static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
+{
+	int ret, index;
+	u16 val = 0;
+
+	for (index = 0; index < MXL86110_MAX_LEDS; index++) {
+		val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
+		if (val < 0)
+			return val;
+
+		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+};
+
+/**
+ * mxl86110_config_init() - initialize the PHY
+ * @phydev: pointer to the phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86110_config_init(struct phy_device *phydev)
+{
+	unsigned int val = 0;
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* configure syncE / clk output */
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		goto error;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
+			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
+			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS;
+		val |= MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error;
+	}
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
+					   MXL86110_EXT_RGMII_CFG1_FULL_MASK, val);
+	if (ret < 0)
+		goto error;
+
+	/* Configure RXDLY (RGMII Rx Clock Delay) to disable the default additional
+	 * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
+	 * and use just the digital one selected before
+	 */
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
+					   MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE, 0);
+	if (ret < 0)
+		goto error;
+
+	ret = mxl86110_enable_led_activity_blink(phydev);
+	if (ret < 0)
+		goto error;
+
+	ret = mxl86110_broadcast_cfg(phydev);
+	if (ret < 0)
+		goto error;
+
+	phy_unlock_mdio_bus(phydev);
+	return 0;
+error:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static struct phy_driver mxl_phy_drvs[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
+		.name			= "MXL86110 Gigabit Ethernet",
+		.config_init		= mxl86110_config_init,
+		.get_wol		= mxl86110_get_wol,
+		.set_wol		= mxl86110_set_wol,
+		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
+		.led_hw_control_get     = mxl86110_led_hw_control_get,
+		.led_hw_control_set     = mxl86110_led_hw_control_set,
+	},
+};
+
+module_phy_driver(mxl_phy_drvs);
+
+static const struct mdio_device_id __maybe_unused mxl_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(PHY_ID_MXL86110) },
+	{  }
+};
+
+MODULE_DEVICE_TABLE(mdio, mxl_tbl);
+
+MODULE_DESCRIPTION("MaxLinear MXL86110 PHY driver");
+MODULE_AUTHOR("Stefano Radaelli");
+MODULE_LICENSE("GPL");

base-commit: 894fbb55e60cab4ea740f6c65a08b5f8155221f4
-- 
2.43.0


