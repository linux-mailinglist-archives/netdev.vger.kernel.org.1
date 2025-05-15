Return-Path: <netdev+bounces-190774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856CEAB8A8E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0417D188830E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1C2135A0;
	Thu, 15 May 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0X7/oO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C75157A6B;
	Thu, 15 May 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322719; cv=none; b=tmBfU91ZQhF523fjCqC9kbh6kto0L9gisPDJ6Hqrk/mFlDhYvh5hNMULRK9jInME3Pghg7z4B/pGCO4RjwDeH6yw6XCMNEA3fBoJasq+46+i3xduCvz7GrK4gY0I26mEe1x8yENAf42BaZc0Qx2/Y9p5D2OQFZzdayBsHhQ94tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322719; c=relaxed/simple;
	bh=ykZ7ibb+6YwxCo3xf8ERP5uOvmZVmyTupgeK8Z3nXyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeSabDOnKzuJzjFP0FLIbEGs5gaR2OrDihwXnTdRq13X5Eqvw6ZXOruEFBAOw9VLB69EEHstcluT+LE582WBS7rNIKo8XDRs50403kU456L1n8pFARURlWH6Bvgb2LGPopKAxY17FcNfPodFLO1r8dIpLR/2mHdzGC80U4ZC68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0X7/oO1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad4d5bb4d0eso200065166b.1;
        Thu, 15 May 2025 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747322713; x=1747927513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdYAZRjxx8IwmeMj+EcaS8v2k0Tp5dUA8c1/eGT3MQs=;
        b=N0X7/oO1fqRKOCJ52xbEOkcFSdiCBbBd9T+iw2M9MmPcg+GY5Qq1nFrHiQ1YauOdVr
         pAaBUTWIu3LQnaoQXi0LlnNmE60+r+7UicKIaUofH5iFJeHQz+oquJjZnAGMW66ZFpNz
         OYeU279sjqy0C9lCKPSBEkijmiQ3dM7PlNlDlNRQI2UioJ7cALiO49lw6HZekzQfLoO5
         zr+L06adt2hmHaEZimkJ4K8SBzFZBmRBaVnMdbyrhK4XVj9HGkOWgorvBYgpsznYshOx
         KoJvQj+mTUe6GXBFxTbtQLIFVge8VkAXR0hbxSt/5GR1PtO6cJkAzjjgZR5uGEBtB5vc
         tphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747322713; x=1747927513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdYAZRjxx8IwmeMj+EcaS8v2k0Tp5dUA8c1/eGT3MQs=;
        b=vlTAXJfpOBGrM14/hJ79XrettGerd3tqRJRuUcEsq7uyxxHz3aoI+yCir3ldqTGqyx
         xp9mwofdrdRWPRqx1gpr7Z5P3+3b5Kw6IkYAXUV1nunYq4nTezST55s9V5Rw/ftm/kIK
         PJ2GCdkOt51ES4Q20Bu8KRdGK2fHsxPFNRPTfrL4d92YVdMxrvy3LduZossC/CnYNsHK
         VkmPmqsvQYZowTpmYGEj3bUCpaP2MrD/olSD1SSPhgf9DePSdKgjAB9wQu7zztAbB6Eh
         O2rgDiHSrSwe49R08R2luCN1azl5J53LDAZyLctYfUGEnsW+H3YBEMxnvt1MBG0BH+fb
         QCFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJv4B8BFEPHe5n/CLHHEsrfl90Sx6WxQzRFWAEiod+05oRyZinLOFIQAZ3VRAmbztv8u+qPrBQGdDc2kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd5ZNh0RippeH1bGP0xhRNmG5Zuu6tDJEdd2L2wMJuSew3qdD
	kXw3wNnG7Eb5it8neL7Hx78lnO7C9Ebzh1ePUZKgRdhW3QHZPhbaWKO6cvyWFnKh
X-Gm-Gg: ASbGncvPR9l7mIYYiMKqHz3DElIYntwBp219UYYeVWfqB6BRCNOhjZHgJAT8XqBcw5o
	dwrVOsPmrUSAO6l7UPJYyKvR7oZlAmVPG2yfairNMJ1jrZsxnZD4eJh8RmdkqadvWJckRASP1mu
	uad3J8MN2rneAB/uKgI57BexQR/JKfj9R82SKUYH8ULofi4alC8DMtVDS8xvLhHZE7vGBxtyeCs
	UaqOQz/oEpk6t2+uMiG9oIvFDb98kAXQ0oDHAJclxMdxmocQuYFRQ+DnrDcmwyt2Gx2YBHriYnJ
	1KHj48IeqSNzg8U7/JDgXCxV+i9BzldJeIIzDJHpTTcDzkWEUQzMe38XqfYYRAqhGopOj7YVdSi
	76MwiQ7gtqrLfXSRpafu629rZA1FXzrMLmaMG0g==
X-Google-Smtp-Source: AGHT+IEtm8ul4JeE7NzWCg6z09SgULdicGVlKf9a6R8OcsHq1vtUyxVgfUDEzhxf/wAoDwNEhhlTVA==
X-Received: by 2002:a17:907:86a0:b0:ad4:f81b:9001 with SMTP id a640c23a62f3a-ad52d5d62abmr10626566b.61.1747322712944;
        Thu, 15 May 2025 08:25:12 -0700 (PDT)
Received: from Lord-Beerus.station (net-130-25-109-68.cust.vodafonedsl.it. [130.25.109.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4395d0sm3414466b.114.2025.05.15.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 08:25:12 -0700 (PDT)
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
Subject: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
Date: Thu, 15 May 2025 17:24:28 +0200
Message-ID: <20250515152432.77835-1-stefano.radaelli21@gmail.com>
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

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 MAINTAINERS                 |   1 +
 drivers/net/phy/Kconfig     |  12 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/mxl-86110.c | 670 ++++++++++++++++++++++++++++++++++++
 4 files changed, 684 insertions(+)
 create mode 100644 drivers/net/phy/mxl-86110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3563492e4eba..183077e079a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14661,6 +14661,7 @@ MAXLINEAR ETHERNET PHY DRIVER
 M:	Xu Liang <lxu@maxlinear.com>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
 MCAN MMIO DEVICE DRIVER
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d29f9f7fd2e1..885ddddf03bd 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -266,6 +266,18 @@ config MAXLINEAR_GPHY
 	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
 	  GPY241, GPY245 PHYs.
 
+config MAXLINEAR_86110_PHY
+	tristate "MaxLinear MXL86110 PHY support"
+	help
+	  Support for the MaxLinear MXL86110 Gigabit Ethernet
+	  Physical Layer transceiver.
+	  The MXL86110 is commonly used in networking equipment such as
+	  routers, switches, and embedded systems, providing the
+	  physical interface for 10/100/1000 Mbps Ethernet connections
+	  over copper media.
+	  If you are using a board with the MXL86110 PHY connected to your
+	  Ethernet MAC, you should enable this option.
+
 source "drivers/net/phy/mediatek/Kconfig"
 
 config MICREL_PHY
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 23ce205ae91d..eb0231882834 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
new file mode 100644
index 000000000000..034ca701e660
--- /dev/null
+++ b/drivers/net/phy/mxl-86110.c
@@ -0,0 +1,670 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PHY driver for Maxlinear MXL86110
+ *
+ * Copyright 2023 MaxLinear Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+
+#define MXL86110_DRIVER_DESC	"MaxLinear MXL86110 PHY driver"
+
+/* PHY ID */
+#define PHY_ID_MXL86110		0xC1335580
+
+/* required to access extended registers */
+#define MXL86110_EXTD_REG_ADDR_OFFSET	0x1E
+#define MXL86110_EXTD_REG_ADDR_DATA		0x1F
+#define PHY_IRQ_ENABLE_REG				0x12
+#define PHY_IRQ_ENABLE_REG_WOL			BIT(6)
+
+/* only 1 page for MXL86110 */
+#define MXL86110_DEFAULT_PAGE	0
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
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_2250PS				(0xF << 10)
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS				(0x1 << 10)
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK				GENMASK(13, 10)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS			(0xF << 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_150PS			(0x1 << 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK			GENMASK(3, 0)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS		(0xF << 4)
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_150PS		(0x1 << 4)
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
+ * mxl86110_read_page - Read current page number
+ * @phydev: Pointer to the PHY device
+ *
+ * Return: The currently selected page number, or negative errno on failure.
+ */
+static int mxl86110_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_OFFSET);
+};
+
+/**
+ * mxl86110_write_page - Select PHY register page
+ * @phydev: Pointer to the PHY device
+ * @page: Page number to select
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+static int mxl86110_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, page);
+};
+
+/**
+ * mxl86110_write_extended_reg() - write to a PHY's extended register
+ * @phydev: pointer to a &struct phy_device
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ *
+ * NOTE: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY. If exclusive access
+ * cannot be guaranteed, please use mxl86110_locked_write_extended_reg()
+ * which handles locking internally.
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
+ * mxl86110_locked_write_extended_reg - Safely write to an extended register
+ * @phydev: Pointer to the PHY device structure
+ * @regnum: Extended register number to write
+ * @val: Value to write
+ *
+ * This function safely writes to an extended register in the MxL86110 PHY.
+ * It locks the MDIO bus, selects the default page, writes the register number
+ * and value using reg 30 and reg 31, restores the previous page, and unlocks the bus.
+ *
+ * Use this locked variant when accessing extended registers in contexts
+ * where concurrent access to the MDIO bus may occur (e.g., from userspace
+ * calls, interrupt context, or asynchronous callbacks like LED triggers).
+ * If you are in a context where the MDIO bus is already locked or
+ * guaranteed exclusive, the non-locked variant can be used for efficiency.
+ *
+ * Return: 0 on success or a negative errno code on failure.
+ */
+static int mxl86110_locked_write_extended_reg(struct phy_device *phydev, u16 regnum,
+					      u16 val)
+{
+	int ret, page;
+
+	/* phy_select_page() locks MDIO bus */
+	ret = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+	page = ret;
+	if (ret >= 0)
+		ret = mxl86110_write_extended_reg(phydev, regnum, val);
+	/*
+	 * 'ret' holds the previous return code.
+	 * phy_restore_page() uses it to propagate errors,
+	 * and may overwrite it with page restore errors.
+	 */
+	ret = phy_restore_page(phydev, page, ret);
+	return ret;
+}
+
+/**
+ * mxl86110_read_extended_reg() - write to a PHY's extended register
+ * @phydev: pointer to a &struct phy_device
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ *
+ * NOTE: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY. If exclusive access
+ * cannot be guaranteed, please use mxl86110_locked_read_extended_reg()
+ * which handles locking internally.
+ *
+ * returns the value of regnum reg or negative error code
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
+ * mxl86110_read_extended_reg - Safely read an extended register
+ * @phydev: Pointer to the PHY device structure
+ * @regnum: Extended register number to read
+ *
+ * This function safely reads an extended register from the MxL86110 PHY.
+ * It locks the MDIO bus to prevent concurrent access, ensures that the
+ * default page is selected (as required for accessing reg 30/31), performs
+ * the read sequence, restores the previous page, and finally unlocks the bus.
+ *
+ * Use this locked variant when accessing extended registers in contexts
+ * where concurrent access to the MDIO bus may occur (e.g., from userspace
+ * calls, interrupt context, or asynchronous callbacks like LED triggers).
+ * If you are in a context where the MDIO bus is already locked or
+ * guaranteed exclusive, the non-locked variant can be used for efficiency.
+ *
+ * Return: The 16-bit value read from the extended register, or a negative errno code.
+ */
+static int mxl86110_locked_read_extended_reg(struct phy_device *phydev, u16 regnum)
+{
+	int ret, page;
+
+	/* phy_select_page() locks MDIO bus */
+	ret = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+	page = ret;
+	if (ret >= 0)
+		ret = mxl86110_read_extended_reg(phydev, regnum);
+	/*
+	 * 'ret' holds the previous return code.
+	 * phy_restore_page() uses it to propagate errors,
+	 * and may overwrite it with page restore errors.
+	 */
+	ret = phy_restore_page(phydev, page, ret);
+	return ret;
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
+	value = mxl86110_locked_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
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
+	int page_to_restore;
+	const u8 *mac;
+	int ret = 0;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		netdev = phydev->attached_dev;
+		if (!netdev)
+			return -ENODEV;
+
+		page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+		if (page_to_restore < 0)
+			goto error;
+
+		/* Configure the MAC address of the WOL magic packet */
+		mac = (const u8 *)netdev->dev_addr;
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG,
+						  ((mac[0] << 8) | mac[1]));
+		if (ret < 0)
+			goto error;
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG,
+						  ((mac[2] << 8) | mac[3]));
+		if (ret < 0)
+			goto error;
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
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
+				   PHY_IRQ_ENABLE_REG_WOL);
+		if (ret < 0)
+			goto error;
+
+		phydev_dbg(phydev, "%s, WOL Magic packet MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
+			   __func__, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+
+	} else {
+		page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+		if (page_to_restore < 0)
+			goto error;
+
+		ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG,
+						   MXL86110_EXT_WOL_CFG_WOLE_MASK,
+						   MXL86110_EXT_WOL_CFG_WOLE_DISABLE);
+
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
+				   PHY_IRQ_ENABLE_REG_WOL, 0);
+		if (ret < 0)
+			goto error;
+	}
+
+	return phy_restore_page(phydev, page_to_restore, 0);
+
+error:
+	return phy_restore_page(phydev, page_to_restore, ret);
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
+	val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
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
+	ret = mxl86110_locked_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
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
+	int ret, page;
+
+	/* Ensure we're on the default page before accessing extended registers.
+	 * This function may be called in contexts where a different page is active.
+	 * No need to reselect the page between consecutive extended accesses,
+	 * as the PHY auto-resets to default after each one.
+	 */
+	ret = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+	page = ret;
+	if (ret < 0)
+		return phy_restore_page(phydev, page, ret);
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
+	return phy_restore_page(phydev, page, ret);
+}
+
+/**
+ * mxl86110_config_init() - initialize the PHY
+ * @phydev: pointer to the phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86110_config_init(struct phy_device *phydev)
+{
+	int page_to_restore, ret = 0;
+	unsigned int val = 0;
+	int index;
+
+	/* Ensure we're on the default page before accessing extended registers.
+	 * This function may be called in contexts where a different page is active.
+	 * No need to reselect the page between consecutive extended accesses,
+	 * as the PHY auto-resets to default after each one.
+	 */
+	page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
+	if (page_to_restore < 0)
+		goto err_restore_page;
+
+	/*
+	 * RX_CLK delay (RXDLY) enabled via CHIP_CFG register causes a fixed
+	 * delay of approximately 2 ns at 125 MHz or 8 ns at 25/2.5 MHz.
+	 * Digital delays in RGMII_CFG1 register are additive
+	 */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
+			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
+			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
+		val |= MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_restore_page;
+	}
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
+					   MXL86110_EXT_RGMII_CFG1_FULL_MASK, val);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Configure RXDLY (RGMII Rx Clock Delay) to keep the default
+	 * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
+	 */
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
+					   MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE, 1);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/*
+	 * Configure all PHY LEDs to blink on traffic activity regardless of their
+	 * ON or OFF state. This behavior allows each LED to serve as a pure activity
+	 * indicator, independently of its use as a link status indicator.
+	 *
+	 * By default, each LED blinks only when it is also in the ON state. This function
+	 * modifies the appropriate registers (LABx fields) to enable blinking even
+	 * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
+	 * without requiring it to also serve as a link status LED.
+	 *
+	 * NOTE: Any further LED customization can be performed via the
+	 * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
+	 * led_hw_control_set are used to support this mechanism.
+	 */
+	for (index = 0; index < MXL86110_MAX_LEDS; index++) {
+		val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
+		if (val < 0)
+			goto err_restore_page;
+
+		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
+		ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+
+	val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG);
+	if (val < 0)
+		goto err_restore_page;
+
+	val &= ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
+	ret = mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG, val);
+	if (ret < 0)
+		goto err_restore_page;
+
+	return phy_restore_page(phydev, page_to_restore, 0);
+
+err_restore_page:
+	return phy_restore_page(phydev, page_to_restore, ret);
+}
+
+/**
+ * mxl86110_probe() - read chip config then set suitable reg_page_mode
+ * @phydev: pointer to the phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int mxl86110_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	/* configure syncE / clk output */
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct phy_driver mxl_phy_drvs[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
+		.name			= "MXL86110 Gigabit Ethernet",
+		.probe			= mxl86110_probe,
+		.config_init		= mxl86110_config_init,
+		.config_aneg		= genphy_config_aneg,
+		.read_page              = mxl86110_read_page,
+		.write_page             = mxl86110_write_page,
+		.read_status		= genphy_read_status,
+		.get_wol		= mxl86110_get_wol,
+		.set_wol		= mxl86110_set_wol,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
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
+MODULE_DESCRIPTION(MXL86110_DRIVER_DESC);
+MODULE_AUTHOR("Stefano Radaelli");
+MODULE_LICENSE("GPL");
-- 
2.43.0


