Return-Path: <netdev+bounces-192458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D6ABFEF0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE2161904
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CE28936E;
	Wed, 21 May 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MseyJ40X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A1134AC;
	Wed, 21 May 2025 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862960; cv=none; b=tnlXge2KgwyxomEryzeS94Doi4j7nDXwgx+iT9GxY9PHQ7Ohj3tAuzGNH3NWwrzW9NGT9DCaW3YxlRZzq3y0DyDlSS5dDoxImgOgwEM8IAQ9pjW1qpNnzKy0tecq748S43aDkSAtezb5tsVUWTcqrlIPrkDua99Kf5tu+3H9Q3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862960; c=relaxed/simple;
	bh=lEz88SqeRUz3GmuJtMB/U/FrIeshy+iXsJ2mbBD77+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bo/7uSsxEnqUJt/qot9wPhqOcjQm5CtcqahnEx4LVBwDjFXsy/0qD9ZzyZOk3yIAfmnjvD0Xm/ByboRRrRBT1lrJvdFWMJqso2Rfp8quDfl0dYf3d+b9TBLD9XvURsTBO7oQLK0HHDXBF3blqOrdvINPMlTjkSgACQninAloecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MseyJ40X; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso4172223a12.2;
        Wed, 21 May 2025 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747862956; x=1748467756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvA7IZApxPJDL4CH2nPv83+pW9MjGhdAK6LPKlQ94Sk=;
        b=MseyJ40XJRvuePhxv7HvIyYlMc71TdNh6rkWoMe4XBpvVgIudIPt+PPjQu/l2k2PwQ
         M9gaDpDW9Uw8vyjOAA2zEfZ6tvClxpytfkuuaftDRaPA8Bs/KrSj3VDyyfgp74AS6kr2
         cdlX43V6fQoM1Wv8FkBBxBmBBQeBsEQj+h73Hqe5NeP2cxApPdi/xXlI+GT0o/sXoNjX
         M75b7Ymr8GGGcph2bsXjr6s5DtGqwVU1573GcrxJ8F0oBbpHEmv7Q5VEH4WqsYPBB4cr
         UdLZml8MYJcAQlCjpreGCVpZHKgDIQxEAxMPpJa5XFomSWzv3aZcA4ZzMzw5+NljtsNo
         Y7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747862956; x=1748467756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvA7IZApxPJDL4CH2nPv83+pW9MjGhdAK6LPKlQ94Sk=;
        b=czgK7/CUaabf65ufhvQbZynlF5phV7CPLNvYiVMvYN9No/b4Uz0bZ3rPPlqNJARDuw
         WQCZ7u6IyP5YDq+r2DrJTx2RxvFZXIA1T9c7EujxtwI+NiXt4i3zUF5ZKUWylyoPFu5l
         J5KwaULwLsnkk5Wp1oggnQ6BV1kmJvoSlMkSdwAT+PFeTE498PROAnPWSK5eWaovYNkQ
         fTLn1g9XTDBTcC32JYvUBwp3kHu1a+ZsTrax5jqZkOK5+AbW85P5TYdszxK13RWqrS1F
         sVVYppwFuI+vA2NbmC2hoCL1FCgcROOIeBZ4oCc21FIE/ZM9+D1ZU8jjmwuZzTO26f95
         nWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXkg097H3kH13H3+hopxJ9wUjSxp59OKOlQQpdzhG5L5UKh6fUNRfYLYe+J5CQOwcrPS1svegmTv30K5VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzooOcWfTFmMsxtn7/XxC90h0Cpqj8O4o5PLZx/gkc8C+6iNMh0
	MPWFQ7tUOlrmjKOuY0PbwsmwUKeto1HOOGNilAsbb1pn1TOCAx/dwSvVbdBA/kFf
X-Gm-Gg: ASbGncslW/VqSsm19YIb8ACSve+E0f5i+tMSK2ix+PDbJNBR/cbaCcsafLnD3i5pH1O
	npuAsKlcg7oSaNDJRUv6VTX0zy3jVWQz913kRmRLpxKHptf8dVL+RXgVz9j0fjW7bSwQU21Kuv3
	O/2fLOYmEZ3k2cxXNw6q0VOn7v/IHVG2uY3OzuoQb0TipFCTylSPGKms7blMuwJYQH/VRO0c0ZE
	2YWwLVw4pQHg65j17xCqKwqp3zS6gZ2gX0WYRkVwSrNOnGGSCkA3NUDv5jwT+LXfZXRizc7L61o
	/Ln/hd7sVLLRdQihUzZIBIkPTSrrVEXeQI4KLi1A4Ay9pwplVUFYlozEBV4=
X-Google-Smtp-Source: AGHT+IEwrg8MTD9MTtzjT7BElz9ZWFoOMAt9jYwEnwk+6y2hQdUoq4y5trbGpBXNwh1AZj78NgUfpw==
X-Received: by 2002:a50:a413:0:b0:601:68ee:9641 with SMTP id 4fb4d7f45d1cf-60168ef1155mr14533330a12.10.1747862955942;
        Wed, 21 May 2025 14:29:15 -0700 (PDT)
Received: from GLaDOS.. ([151.84.244.111])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d502736sm9521374a12.25.2025.05.21.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:29:15 -0700 (PDT)
From: stefano.radaelli21@gmail.com
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
Subject: [PATCH net-next v6] net: phy: add driver for MaxLinear MxL86110 PHY
Date: Wed, 21 May 2025 23:28:15 +0200
Message-ID: <20250521212821.593057-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Stefano Radaelli <stefano.radaelli21@gmail.com>

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v6:
  - Fix comments
  - Remove superfluous semicolon

v5: https://lore.kernel.org/netdev/20250521113414.567414-1-stefano.radaelli21@gmail.com/
  - Remove redundant macro
  - Remove unnecessary cast
  - Remove superfluous semicolons
  - Rename unlocked accessors with '__' prefix to match kernel naming conventions
  - Add locked variants of extended register accessors

v4: https://lore.kernel.org/netdev/20250520124521.440639-1-stefano.radaelli21@gmail.com/
  - Limited lines to 80 columns where possible.
  - kernel-doc: fixed 'Returns:' format in function comments.
  - Fixed invalid '< 0' checks on unsigned variables by using signed int.

v3: https://lore.kernel.org/netdev/20250519163032.96467-1-stefano.radaelli21@gmail.com/
  - Simplified return handling, removed unnecessary goto/ret=0 patterns
  - Added comments where MDIO lock is assumed
  - Replaced read-modify-write sequences with _modify_
    in broadcast and LED blink configuration

v2: https://lore.kernel.org/netdev/20250516164126.234883-1-stefano.radaelli21@gmail.com/
  - Add net-next support
  - Improved locking management and validation with CONFIG_PROVE_LOCKING
  - General cleanup and simplification

v1: https://lore.kernel.org/netdev/20250515184836.97605-1-stefano.radaelli21@gmail.com/

 MAINTAINERS                 |   1 +
 drivers/net/phy/Kconfig     |  12 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/mxl-86110.c | 616 ++++++++++++++++++++++++++++++++++++
 4 files changed, 630 insertions(+)
 create mode 100644 drivers/net/phy/mxl-86110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 536a81712c71..f6768a12b2f1 100644
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
index 127a9fd0feb9..7b9b0baa311a 100644
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
index 7de69320a3a7..416128553a2a 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
+obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
new file mode 100644
index 000000000000..ff2a3a22bd5b
--- /dev/null
+++ b/drivers/net/phy/mxl-86110.c
@@ -0,0 +1,616 @@
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
+#define MXL86110_EXTD_REG_ADDR_OFFSET			0x1E
+#define MXL86110_EXTD_REG_ADDR_DATA			0x1F
+#define PHY_IRQ_ENABLE_REG				0x12
+#define PHY_IRQ_ENABLE_REG_WOL				BIT(6)
+
+/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
+#define MXL86110_EXT_SYNCE_CFG_REG			0xA012
+#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL		BIT(4)
+#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN	BIT(5)
+#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E		BIT(6)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK		GENMASK(3, 1)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL	0
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M		4
+
+/* MAC Address registers */
+#define MXL86110_EXT_MAC_ADDR_CFG1			0xA007
+#define MXL86110_EXT_MAC_ADDR_CFG2			0xA008
+#define MXL86110_EXT_MAC_ADDR_CFG3			0xA009
+
+#define MXL86110_EXT_WOL_CFG_REG			0xA00A
+#define MXL86110_WOL_CFG_WOL_MASK			BIT(3)
+
+/* RGMII register */
+#define MXL86110_EXT_RGMII_CFG1_REG			0xA003
+/* delay can be adjusted in steps of about 150ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY		(0x0 << 10)
+/* Closest value to 2000 ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS		(0xD << 10)
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK		GENMASK(13, 10)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS	(0xD << 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK	GENMASK(3, 0)
+
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS	(0xD << 4)
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK	GENMASK(7, 4)
+
+#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
+			((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
+			(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
+			(MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK))
+
+/* EXT Sleep Control register */
+#define MXL86110_UTP_EXT_SLEEP_CTRL_REG			0x27
+#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF	0
+#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK	BIT(15)
+
+/* RGMII In-Band Status and MDIO Configuration Register */
+#define MXL86110_EXT_RGMII_MDIO_CFG			0xA005
+#define MXL86110_RGMII_MDIO_CFG_EPA0_MASK		GENMASK(6, 6)
+#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK		GENMASK(5, 5)
+#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK		GENMASK(4, 0)
+
+#define MXL86110_MAX_LEDS	3
+/* LED registers and defines */
+#define MXL86110_LED0_CFG_REG 0xA00C
+#define MXL86110_LED1_CFG_REG 0xA00D
+#define MXL86110_LED2_CFG_REG 0xA00E
+
+#define MXL86110_LEDX_CFG_BLINK				BIT(13)
+#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON	BIT(12)
+#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON	BIT(11)
+#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON		BIT(10)
+#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON		BIT(9)
+#define MXL86110_LEDX_CFG_LINK_UP_TX_ON			BIT(8)
+#define MXL86110_LEDX_CFG_LINK_UP_RX_ON			BIT(7)
+#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON		BIT(6)
+#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON		BIT(5)
+#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON		BIT(4)
+#define MXL86110_LEDX_CFG_LINK_UP_COLLISION		BIT(3)
+#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK		BIT(2)
+#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK		BIT(1)
+#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK		BIT(0)
+
+#define MXL86110_LED_BLINK_CFG_REG			0xA00F
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ		0
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ		BIT(0)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ		BIT(1)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ		(BIT(1) | BIT(0))
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ		0
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ		BIT(2)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ		BIT(3)
+#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ		(BIT(3) | BIT(2))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_ON		0
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_ON		(BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_ON		(BIT(5))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_ON		(BIT(5) | BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_OFF	(BIT(6))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_ON		(BIT(6) | BIT(4))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_ON		(BIT(6) | BIT(5))
+#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_ON	(BIT(6) | BIT(5) | BIT(4))
+
+/* Chip Configuration Register - COM_EXT_CHIP_CFG */
+#define MXL86110_EXT_CHIP_CFG_REG			0xA001
+#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE		BIT(8)
+#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE		BIT(15)
+
+/**
+ * __mxl86110_write_extended_reg() - write to a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ *
+ * Unlocked version of mxl86110_write_extended_reg
+ *
+ * Note: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 0 or negative error code
+ */
+static int __mxl86110_write_extended_reg(struct phy_device *phydev,
+					 u16 regnum, u16 val)
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
+ * __mxl86110_read_extended_reg - Read a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: extended register number to read (address written to reg 30)
+ *
+ * Unlocked version of mxl86110_read_extended_reg
+ *
+ * Reads the content of a PHY extended register using the MaxLinear
+ * 2-step access mechanism: write the register address to reg 30 (0x1E),
+ * then read the value from reg 31 (0x1F).
+ *
+ * Note: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 16-bit register value on success, or negative errno code on failure.
+ */
+static int __mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
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
+ * __mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: register number to write
+ * @mask: bit mask of bits to clear
+ * @set: bit mask of bits to set
+ *
+ * Note: register value = (old register value & ~mask) | set.
+ * This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 0 or negative error code
+ */
+static int __mxl86110_modify_extended_reg(struct phy_device *phydev,
+					  u16 regnum, u16 mask, u16 set)
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
+ * mxl86110_write_extended_reg() - Write to a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ *
+ * This function writes to an extended register of the PHY using the
+ * MaxLinear two-step access method (reg 0x1E/0x1F). It handles acquiring
+ * and releasing the MDIO bus lock internally.
+ *
+ * Return: 0 or negative error code
+ */
+static int mxl86110_write_extended_reg(struct phy_device *phydev,
+				       u16 regnum, u16 val)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __mxl86110_write_extended_reg(phydev, regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+/**
+ * mxl86110_read_extended_reg() - Read a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: extended register number to read
+ *
+ * This function reads from an extended register of the PHY using the
+ * MaxLinear two-step access method (reg 0x1E/0x1F). It handles acquiring
+ * and releasing the MDIO bus lock internally.
+ *
+ * Return: 16-bit register value on success, or negative errno code on failure
+ */
+static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __mxl86110_read_extended_reg(phydev, regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+/**
+ * mxl86110_get_wol() - report if wake-on-lan is enabled
+ * @phydev: pointer to the phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ */
+static void mxl86110_get_wol(struct phy_device *phydev,
+			     struct ethtool_wolinfo *wol)
+{
+	int val;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+	val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
+	if (val >= 0 && (val & MXL86110_WOL_CFG_WOL_MASK))
+		wol->wolopts |= WAKE_MAGIC;
+}
+
+/**
+ * mxl86110_set_wol() - enable/disable wake-on-lan
+ * @phydev: pointer to the phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ *
+ * Configures the WOL Magic Packet MAC
+ *
+ * Return: 0 or negative errno code
+ */
+static int mxl86110_set_wol(struct phy_device *phydev,
+			    struct ethtool_wolinfo *wol)
+{
+	struct net_device *netdev;
+	const unsigned char *mac;
+	int ret = 0;
+
+	phy_lock_mdio_bus(phydev);
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		netdev = phydev->attached_dev;
+		if (!netdev) {
+			ret = -ENODEV;
+			goto out;
+		}
+
+		/* Configure the MAC address of the WOL magic packet */
+		mac = netdev->dev_addr;
+		ret = __mxl86110_write_extended_reg(phydev,
+						    MXL86110_EXT_MAC_ADDR_CFG1,
+						    ((mac[0] << 8) | mac[1]));
+		if (ret < 0)
+			goto out;
+
+		ret = __mxl86110_write_extended_reg(phydev,
+						    MXL86110_EXT_MAC_ADDR_CFG2,
+						    ((mac[2] << 8) | mac[3]));
+		if (ret < 0)
+			goto out;
+
+		ret = __mxl86110_write_extended_reg(phydev,
+						    MXL86110_EXT_MAC_ADDR_CFG3,
+						    ((mac[4] << 8) | mac[5]));
+		if (ret < 0)
+			goto out;
+
+		ret = __mxl86110_modify_extended_reg(phydev,
+						     MXL86110_EXT_WOL_CFG_REG,
+						     MXL86110_WOL_CFG_WOL_MASK,
+						     MXL86110_WOL_CFG_WOL_MASK);
+		if (ret < 0)
+			goto out;
+
+		/* Enables Wake-on-LAN interrupt in the PHY. */
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
+				   PHY_IRQ_ENABLE_REG_WOL);
+		if (ret < 0)
+			goto out;
+
+		phydev_dbg(phydev,
+			   "%s, MAC Addr: %02X:%02X:%02X:%02X:%02X:%02X\n",
+			   __func__,
+			   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	} else {
+		ret = __mxl86110_modify_extended_reg(phydev,
+						     MXL86110_EXT_WOL_CFG_REG,
+						     MXL86110_WOL_CFG_WOL_MASK,
+						     0);
+		if (ret < 0)
+			goto out;
+
+		/* Disables Wake-on-LAN interrupt in the PHY. */
+		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
+				   PHY_IRQ_ENABLE_REG_WOL, 0);
+	}
+
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_LINK_10) |
+					     BIT(TRIGGER_NETDEV_LINK_100) |
+					     BIT(TRIGGER_NETDEV_LINK_1000) |
+					     BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+					     BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+					     BIT(TRIGGER_NETDEV_TX) |
+					     BIT(TRIGGER_NETDEV_RX));
+
+static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_trgs)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int val;
+
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	val = mxl86110_read_extended_reg(phydev,
+					 MXL86110_LED0_CFG_REG + index);
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
+}
+
+static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 val = 0;
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
+		val |= MXL86110_LEDX_CFG_BLINK;
+
+	return mxl86110_write_extended_reg(phydev,
+					  MXL86110_LED0_CFG_REG + index, val);
+}
+
+/**
+ * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
+ * @phydev: pointer to the phy_device
+ *
+ * Note: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 0 or negative errno code
+ */
+static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
+{
+	u16 mask = 0, val = 0;
+
+	/*
+	 * Configures the clock output to its default
+	 * setting as per the datasheet.
+	 * This results in a 25MHz clock output being selected in the
+	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
+	 */
+	val = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
+				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
+	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
+	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
+
+	/* Write clock output configuration */
+	return __mxl86110_modify_extended_reg(phydev,
+					      MXL86110_EXT_SYNCE_CFG_REG,
+					      mask, val);
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
+ * Note: This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 0 on success or a negative errno code on failure.
+ */
+static int mxl86110_broadcast_cfg(struct phy_device *phydev)
+{
+	return __mxl86110_modify_extended_reg(phydev,
+					      MXL86110_EXT_RGMII_MDIO_CFG,
+					      MXL86110_RGMII_MDIO_CFG_EPA0_MASK,
+					      0);
+}
+
+/**
+ * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
+ * @phydev: Pointer to the PHY device structure
+ *
+ * Configure all PHY LEDs to blink on traffic activity regardless of whether
+ * they are ON or OFF. This behavior allows each LED to serve as a pure activity
+ * indicator, independently of its use as a link status indicator.
+ *
+ * By default, each LED blinks only when it is also in the ON state.
+ * This function modifies the appropriate registers (LABx fields)
+ * to enable blinking even when the LEDs are OFF, to allow the LED to be used
+ * as a traffic indicator without requiring it to also serve
+ * as a link status LED.
+ *
+ * Note: Any further LED customization can be performed via the
+ * /sys/class/leds interface; the functions led_hw_is_supported,
+ * led_hw_control_get, and led_hw_control_set are used
+ * to support this mechanism.
+ *
+ * This function assumes the caller already holds the MDIO bus lock
+ * or otherwise has exclusive access to the PHY.
+ *
+ * Return: 0 on success or a negative errno code on failure.
+ */
+static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < MXL86110_MAX_LEDS; i++) {
+		ret = __mxl86110_modify_extended_reg(phydev,
+						     MXL86110_LED0_CFG_REG + i,
+						     0,
+						     MXL86110_LEDX_CFG_BLINK);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * mxl86110_config_init() - initialize the PHY
+ * @phydev: pointer to the phy_device
+ *
+ * Return: 0 or negative errno code
+ */
+static int mxl86110_config_init(struct phy_device *phydev)
+{
+	u16 val = 0;
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* configure syncE / clk output */
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		goto out;
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
+			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS |
+			MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = __mxl86110_modify_extended_reg(phydev,
+					     MXL86110_EXT_RGMII_CFG1_REG,
+					     MXL86110_EXT_RGMII_CFG1_FULL_MASK,
+					     val);
+	if (ret < 0)
+		goto out;
+
+	/* Configure RXDLY (RGMII Rx Clock Delay) to disable
+	 * the default additional delay value on RX_CLK
+	 * (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
+	 * and use just the digital one selected before
+	 */
+	ret = __mxl86110_modify_extended_reg(phydev,
+					     MXL86110_EXT_CHIP_CFG_REG,
+					     MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE,
+					     0);
+	if (ret < 0)
+		goto out;
+
+	ret = mxl86110_enable_led_activity_blink(phydev);
+	if (ret < 0)
+		goto out;
+
+	ret = mxl86110_broadcast_cfg(phydev);
+
+out:
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

base-commit: e6b3527c3b0a676c710e91798c2709cc0538d312
prerequisite-patch-id: 2335ebcc90360b008c840e7edf7e34a595880edf
-- 
2.43.0


