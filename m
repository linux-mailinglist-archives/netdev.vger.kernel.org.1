Return-Path: <netdev+bounces-176981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C30A6D24F
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C80188E16F
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C371B4231;
	Sun, 23 Mar 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq5qkKcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE35291E;
	Sun, 23 Mar 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770512; cv=none; b=kOyPLAp6p1mndReMbzKShml3AvCNgNhx/y4l1a8FYV8/nXc+aR7ijJ9e8dz158KrE3A9J8ne5IKNQvjVscAPRVe8Btc7CA255XGYUK40S8PrFS9SgzGqKB5KHfl1eYXpdc1rn44NwRRXqwXkx3cNNPEtJzcnsj/fb40/z3O6tG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770512; c=relaxed/simple;
	bh=Ads3rkVvEtA5gnRu3T023v9CP2UWuPnRpfuXZHDxtDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TMaj97OpwDzmimFhq+e6wqeN84cKlnyXTzki0prjM3IFRpMfIYGAZeaQoPQ8UGkR9DTpw2UnbdTXlmayYsVFPUc8B4HCdlVIKOIQD9egX6jfxrgG8F1iCP4GSeWFDhZPxfiv8JIFPoClHU+tumx6DxORDpo7FdHMIvSEm9eGiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq5qkKcP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2401617f8f.1;
        Sun, 23 Mar 2025 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742770508; x=1743375308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjSjWHZ6GaiKJ5erpSnC5BH+Omomyx0D+ocbSoLEIYo=;
        b=dq5qkKcP5t8RZFfDCbbW1aeyMkeCCN9QKHNJRykhZ7tcOgcc83wcEex6Z6OqjSMeQ9
         7eJ6htJRgGmUS6d/CDcy4r/AJvZPxX/M/Dil+cs89QjPrx+nHkD85Dh+/fesfDFm4Kiq
         WXqu9v1sg/5rJUAfLXpKafn94356P0wV+Q744YwH7FCclTZZ0FJxT278QNdblccA1AvC
         lZphULu/8kxEayHDQZVnV9g12uOCCHFt1FD7aECPSV7he5vq3mh+DuJQnVZBMQZXBOFg
         sKczEQXRZonFZpyGQoAC1nxjVzBpO1caeaIVM+YkJXgrHF5ttlQYrYR15fSTQiKH8EDR
         N3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742770508; x=1743375308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjSjWHZ6GaiKJ5erpSnC5BH+Omomyx0D+ocbSoLEIYo=;
        b=csNEWtU0vtfgDzw2x3AXJb6WsRCGwzWsuIDqDOXij+QACWr/mGqK88JeK0cFEgT0dq
         JR0VL30oOz95K+crDAp7yc4dycHCNehWlEXkMemk/kollpr7ExnuGjquGP67VweFyd0Q
         zDu3bQ50huQKN3lPHmOPolB7Hj2HO2i8LHQT6mte+g6OgwSHslTetMZ23INSe2lZHvPI
         UhiuYrxQGYTBZ1FSCzKdQQCbtxyFkyJW3X+7/cYYFyelOp5wLRt5ayZ0x4D6de5/iSEl
         YQYWMYnZTYmjVLJnCI9rs0Q9BB8C1a1bZ4wxVhXNii8zzj0zpHoXRdMxyl3Rv+TR/HfN
         9S7w==
X-Forwarded-Encrypted: i=1; AJvYcCUMUlQ4vjSPbDM+AG14piqF1KpH7Ncxy5HfHCwd71xTdf0rmzbOSOin1yG6Wj1W/XiHSspyobZR@vger.kernel.org, AJvYcCUMryeKGV2aVmPISPE3yG844+PBFYG5gDTYdD288gjFfJcdENpuDiscTvXImxWbLAkd70gEIy5KCYvV5jr6@vger.kernel.org, AJvYcCURNYMfbdFSKY6D5VztEgu+HzgWTqF25X6XYe2j0bQsfuUnPPF0dXyHbzQrE8ixMqFGJp4Flz8btXp8@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhHBrrS4r8fWEIA+xJIFw6RI674S/p2NO7cR3W/L6mPK9JjFZ
	7x0nnx5upIJT1zA89uJHbYzm14Py8Mdmi29VWrwt6fughxUxfAIQ
X-Gm-Gg: ASbGncv2fHUv4pcHmmrLXG1O/csEZuFtNjTht6kWVJrlDEOcd9wweBEVTY7Ah/yYSEI
	Wu7IrN4boQzo8+hKC/y7BnXgsj9wF4nRNSWC8A4VOsLov49Ksmpx9IwbEOon2X9BNjj9ZhjG0rb
	ypF0lvlIqyUsj4EyFwkusop3dOEUci0zMjFJe2P+L2qLheqswZNIlfWigfSEAwRYgJ0dUsD5Yvh
	eHbQZ7QHgFUBc8Yjda1c8LWblU5BKiIee2Sj8czJV+1iopPbZ8eI7fNPgZPbthPaS6/xzMWqV4h
	cNNOOUO+FGvae63wzo0k6oUUo3nY1MH+308Ocv9x5N+Xr4AMobJoPfOCS+JOAEnEBxEVDq1lqdn
	QDdN98Wqi8YMyiQ==
X-Google-Smtp-Source: AGHT+IEex4VdBh+woNYEnyNkS9HTKRV3QW3S/InAM14m/ulWcEsZhy3lQ3lFLbXTdyJtwZ+gg+5/Hw==
X-Received: by 2002:a5d:64cb:0:b0:391:42f2:5c7b with SMTP id ffacd0b85a97d-3997f8fea8bmr10800160f8f.16.1742770507600;
        Sun, 23 Mar 2025 15:55:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f36sm9171129f8f.32.2025.03.23.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:55:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Date: Sun, 23 Mar 2025 23:54:26 +0100
Message-ID: <20250323225439.32400-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
to setup some configuration and require special handling to sync with
the parity bit. The parity bit is a way the IPC use to follow correct
order of command sent.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x7500
before the firmware is loaded.

They all support up to 5 LEDs with various HW mode supported.

While implementing it was found some strange coincidence with using the
same logic for implementing C22 in MMD regs in Broadcom PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS               |   6 +
 drivers/net/phy/Kconfig   |  12 +
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/as21xxx.c | 834 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 853 insertions(+)
 create mode 100644 drivers/net/phy/as21xxx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 873aa2cce4d7..9a2df6d221bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -645,6 +645,12 @@ F:	drivers/iio/accel/adxl380.h
 F:	drivers/iio/accel/adxl380_i2c.c
 F:	drivers/iio/accel/adxl380_spi.c
 
+AEONSEMI PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/as21xxx.c
+
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
 M:	Ondřej Jirman <megi@xff.cz>
 S:	Maintained
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..454715c651d6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -121,6 +121,18 @@ config AMCC_QT2025_PHY
 
 source "drivers/net/phy/aquantia/Kconfig"
 
+config AS21XXX_PHY
+	tristate "Aeonsemi AS21xxx PHYs"
+	help
+	  Currently supports the Aeonsemi AS21xxx PHY.
+
+	  These are C45 PHYs 10G that require all a generic firmware.
+
+	  Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
+	  AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
+	  AS21210PB1 that all register with the PHY ID 0x7500 0x7500
+	  before the firmware is loaded.
+
 config AX88796B_PHY
 	tristate "Asix PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c8dac6e92278..14156bf11267 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
+obj-$(CONFIG_AS21XXX_PHY)	+= as21xxx.o
 ifdef CONFIG_AX88796B_RUST_PHY
   obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
 else
diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
new file mode 100644
index 000000000000..7aefe2fcf24f
--- /dev/null
+++ b/drivers/net/phy/as21xxx.c
@@ -0,0 +1,834 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Aeonsemi AS21XXxX PHY Driver
+ *
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define VEND1_GLB_REG_CPU_RESET_ADDR_LO_BASEADDR 0x3
+#define VEND1_GLB_REG_CPU_RESET_ADDR_HI_BASEADDR 0x4
+
+#define VEND1_GLB_REG_CPU_CTRL		0xe
+#define   VEND1_GLB_CPU_CTRL_MASK	GENMASK(4, 0)
+#define   VEND1_GLB_CPU_CTRL_LED_POLARITY_MASK GENMASK(12, 8)
+#define   VEND1_GLB_CPU_CTRL_LED_POLARITY(_n) FIELD_PREP(VEND1_GLB_CPU_CTRL_LED_POLARITY_MASK, \
+							 BIT(_n))
+
+#define VEND1_FW_START_ADDR		0x100
+
+#define VEND1_GLB_REG_MDIO_INDIRECT_ADDRCMD 0x101
+#define VEND1_GLB_REG_MDIO_INDIRECT_LOAD 0x102
+
+#define VEND1_GLB_REG_MDIO_INDIRECT_STATUS 0x103
+
+#define VEND1_PTP_CLK			0x142
+#define   VEND1_PTP_CLK_EN		BIT(6)
+
+/* 5 LED at step of 0x20
+ * FE: Fast-Ethernet (100)
+ * GE: Gigabit-Ethernet (1000)
+ * NG: New-Generation (2500/5000/10000)
+ * (Lovely ChatGPT managed to translate meaning of NG)
+ */
+#define VEND1_LED_REG(_n)		(0x1800 + ((_n) * 0x10))
+#define   VEND1_LED_REG_A_EVENT		GENMASK(15, 11)
+#define     VEND1_LED_REG_A_EVENT_ON_10 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x0)
+#define     VEND1_LED_REG_A_EVENT_ON_100 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x1)
+#define     VEND1_LED_REG_A_EVENT_ON_1000 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x2)
+#define     VEND1_LED_REG_A_EVENT_ON_2500 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x3)
+#define     VEND1_LED_REG_A_EVENT_ON_5000 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x4)
+#define     VEND1_LED_REG_A_EVENT_ON_10000 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x5)
+#define     VEND1_LED_REG_A_EVENT_ON_FE_GE FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x6)
+#define     VEND1_LED_REG_A_EVENT_ON_NG FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x7)
+#define     VEND1_LED_REG_A_EVENT_ON_FULL_DUPLEX FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x8)
+#define     VEND1_LED_REG_A_EVENT_ON_COLLISION FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x9)
+#define     VEND1_LED_REG_A_EVENT_BLINK_TX FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xa)
+#define     VEND1_LED_REG_A_EVENT_BLINK_RX FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xb)
+#define     VEND1_LED_REG_A_EVENT_BLINK_ACT FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xc)
+#define     VEND1_LED_REG_A_EVENT_ON_LINK FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xd)
+#define     VEND1_LED_REG_A_EVENT_ON_LINK_BLINK_ACT FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xe)
+#define     VEND1_LED_REG_A_EVENT_ON_LINK_BLINK_RX FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0xf)
+#define     VEND1_LED_REG_A_EVENT_ON_FE_GE_BLINK_ACT FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x10)
+#define     VEND1_LED_REG_A_EVENT_ON_NG_BLINK_ACT FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x11)
+#define     VEND1_LED_REG_A_EVENT_ON_NG_BLINK_FE_GE FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x12)
+#define     VEND1_LED_REG_A_EVENT_ON_FD_BLINK_COLLISION FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x13)
+#define     VEND1_LED_REG_A_EVENT_ON	FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x14)
+#define     VEND1_LED_REG_A_EVENT_OFF	FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x15)
+#define VEND1_LED_CONF			0x1881
+#define   VEND1_LED_CONFG_BLINK		GENMASK(7, 0)
+
+#define VEND1_SPEED_STATUS		0x4002
+#define   VEND1_SPEED_MASK		GENMASK(7, 0)
+#define   VEND1_SPEED_10000		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x3)
+#define   VEND1_SPEED_5000		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x5)
+#define   VEND1_SPEED_2500		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x9)
+#define   VEND1_SPEED_1000		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x10)
+#define   VEND1_SPEED_100		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x20)
+#define   VEND1_SPEED_10		FIELD_PREP_CONST(VEND1_SPEED_MASK, 0x0)
+
+#define VEND1_IPC_CMD			0x5801
+#define   AEON_IPC_CMD_PARITY		BIT(15)
+#define   AEON_IPC_CMD_SIZE		GENMASK(10, 6)
+#define   AEON_IPC_CMD_OPCODE		GENMASK(5, 0)
+
+#define IPC_CMD_NOOP			0x0  /* Do nothing */
+#define IPC_CMD_INFO			0x1  /* Get Firmware Version */
+#define IPC_CMD_SYS_CPU			0x2  /* SYS_CPU */
+#define IPC_CMD_BULK_DATA		0xa  /* Pass bulk data in ipc registers. */
+#define IPC_CMD_BULK_WRITE		0xc  /* Write bulk data to memory */
+#define IPC_CMD_CFG_PARAM		0x1a /* Write config parameters to memory */
+#define IPC_CMD_NG_TESTMODE		0x1b /* Set NG test mode and tone */
+#define IPC_CMD_TEMP_MON		0x15 /* Temperature monitoring function */
+#define IPC_CMD_SET_LED			0x23 /* Set led */
+
+#define VEND1_IPC_STS			0x5802
+#define   AEON_IPC_STS_PARITY		BIT(15)
+#define   AEON_IPC_STS_SIZE		GENMASK(14, 10)
+#define   AEON_IPC_STS_OPCODE		GENMASK(9, 4)
+#define   AEON_IPC_STS_STATUS		GENMASK(3, 0)
+#define   AEON_IPC_STS_STATUS_RCVD	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0x1)
+#define   AEON_IPC_STS_STATUS_PROCESS	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0x2)
+#define   AEON_IPC_STS_STATUS_SUCCESS	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0x4)
+#define   AEON_IPC_STS_STATUS_ERROR	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0x8)
+#define   AEON_IPC_STS_STATUS_BUSY	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0xe)
+#define   AEON_IPC_STS_STATUS_READY	FIELD_PREP_CONST(AEON_IPC_STS_STATUS, 0xf)
+
+#define VEND1_IPC_DATA0			0x5808
+#define VEND1_IPC_DATA1			0x5809
+#define VEND1_IPC_DATA2			0x580a
+#define VEND1_IPC_DATA3			0x580b
+#define VEND1_IPC_DATA4			0x580c
+#define VEND1_IPC_DATA5			0x580d
+#define VEND1_IPC_DATA6			0x580e
+#define VEND1_IPC_DATA7			0x580f
+#define VEND1_IPC_DATA(_n)		(VEND1_IPC_DATA0 + (_n))
+
+/* Sub command of CMD_INFO */
+#define IPC_INFO_VERSION		0x1
+
+/* Sub command of CMD_SYS_CPU */
+#define IPC_SYS_CPU_REBOOT		0x3
+#define IPC_SYS_CPU_IMAGE_OFST		0x4
+#define IPC_SYS_CPU_IMAGE_CHECK		0x5
+#define IPC_SYS_CPU_PHY_ENABLE		0x6
+
+/* Sub command of CMD_CFG_PARAM */
+#define IPC_CFG_PARAM_DIRECT		0x4
+
+/* CFG DIRECT sub command */
+#define IPC_CFG_PARAM_DIRECT_NG_PHYCTRL	0x1
+#define IPC_CFG_PARAM_DIRECT_CU_AN	0x2
+#define IPC_CFG_PARAM_DIRECT_SDS_PCS	0x3
+#define IPC_CFG_PARAM_DIRECT_AUTO_EEE	0x4
+#define IPC_CFG_PARAM_DIRECT_SDS_PMA	0x5
+#define IPC_CFG_PARAM_DIRECT_DPC_RA	0x6
+#define IPC_CFG_PARAM_DIRECT_DPC_PKT_CHK 0x7
+#define IPC_CFG_PARAM_DIRECT_DPC_SDS_WAIT_ETH 0x8
+#define IPC_CFG_PARAM_DIRECT_WDT	0x9
+#define IPC_CFG_PARAM_DIRECT_SDS_RESTART_AN 0x10
+#define IPC_CFG_PARAM_DIRECT_TEMP_MON	0x11
+#define IPC_CFG_PARAM_DIRECT_WOL	0x12
+
+/* Sub command of CMD_TEMP_MON */
+#define IPC_CMD_TEMP_MON_GET		0x4
+
+#define PHY_ID_AS21010JB1		0x75009422
+#define PHY_ID_AS21XXX			0x75007500
+#define PHY_VENDOR_AEONSEMI		0x75009400
+
+#define AEON_MAX_LDES			5
+#define AEON_IPC_DATA_MAX		(8 * sizeof(u16))
+
+#define AEON_BOOT_ADDR			0x1000
+#define AEON_CPU_BOOT_ADDR		0x2000
+#define AEON_CPU_CTRL_FW_LOAD		(BIT(4) | BIT(2) | BIT(1) | BIT(0))
+#define AEON_CPU_CTRL_FW_START		BIT(0)
+
+enum {
+	MDIO_AN_C22 = 0xffe0,
+};
+
+struct as21xxx_led_pattern_info {
+	unsigned int pattern;
+	u16 val;
+};
+
+struct as21xxx_priv {
+	bool parity_status;
+};
+
+static struct as21xxx_led_pattern_info as21xxx_led_supported_pattern[] = {
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_10),
+		.val = VEND1_LED_REG_A_EVENT_ON_10
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_100),
+		.val = VEND1_LED_REG_A_EVENT_ON_100
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_1000),
+		.val = VEND1_LED_REG_A_EVENT_ON_1000
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_2500),
+		.val = VEND1_LED_REG_A_EVENT_ON_2500
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_5000),
+		.val = VEND1_LED_REG_A_EVENT_ON_5000
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_10000),
+		.val = VEND1_LED_REG_A_EVENT_ON_10000
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK),
+		.val = VEND1_LED_REG_A_EVENT_ON_LINK
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_100) |
+			   BIT(TRIGGER_NETDEV_LINK_1000),
+		.val = VEND1_LED_REG_A_EVENT_ON_FE_GE
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_2500) |
+			   BIT(TRIGGER_NETDEV_LINK_5000) |
+			   BIT(TRIGGER_NETDEV_LINK_10000),
+		.val = VEND1_LED_REG_A_EVENT_ON_NG
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.val = VEND1_LED_REG_A_EVENT_ON_FULL_DUPLEX
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_TX),
+		.val = VEND1_LED_REG_A_EVENT_BLINK_TX
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_BLINK_RX
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_TX) |
+			   BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_BLINK_ACT
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_10) |
+			   BIT(TRIGGER_NETDEV_LINK_100) |
+			   BIT(TRIGGER_NETDEV_LINK_1000) |
+			   BIT(TRIGGER_NETDEV_LINK_2500) |
+			   BIT(TRIGGER_NETDEV_LINK_5000) |
+			   BIT(TRIGGER_NETDEV_LINK_10000),
+		.val = VEND1_LED_REG_A_EVENT_ON_LINK
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_10) |
+			   BIT(TRIGGER_NETDEV_LINK_100) |
+			   BIT(TRIGGER_NETDEV_LINK_1000) |
+			   BIT(TRIGGER_NETDEV_LINK_2500) |
+			   BIT(TRIGGER_NETDEV_LINK_5000) |
+			   BIT(TRIGGER_NETDEV_LINK_10000) |
+			   BIT(TRIGGER_NETDEV_TX) |
+			   BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_ON_LINK_BLINK_ACT
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_10) |
+			   BIT(TRIGGER_NETDEV_LINK_100) |
+			   BIT(TRIGGER_NETDEV_LINK_1000) |
+			   BIT(TRIGGER_NETDEV_LINK_2500) |
+			   BIT(TRIGGER_NETDEV_LINK_5000) |
+			   BIT(TRIGGER_NETDEV_LINK_10000) |
+			   BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_ON_LINK_BLINK_RX
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_100) |
+			   BIT(TRIGGER_NETDEV_LINK_1000) |
+			   BIT(TRIGGER_NETDEV_TX) |
+			   BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_ON_FE_GE_BLINK_ACT
+	},
+	{
+		.pattern = BIT(TRIGGER_NETDEV_LINK_2500) |
+			   BIT(TRIGGER_NETDEV_LINK_5000) |
+			   BIT(TRIGGER_NETDEV_LINK_10000) |
+			   BIT(TRIGGER_NETDEV_TX) |
+			   BIT(TRIGGER_NETDEV_RX),
+		.val = VEND1_LED_REG_A_EVENT_ON_NG_BLINK_ACT
+	}
+};
+
+static int aeon_firmware_boot(struct phy_device *phydev, const u8 *data, size_t size)
+{
+	int i, ret;
+	u16 val;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_CPU_CTRL,
+			     VEND1_GLB_CPU_CTRL_MASK, AEON_CPU_CTRL_FW_LOAD);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_FW_START_ADDR,
+			    AEON_BOOT_ADDR);
+	if (ret)
+		return ret;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_MDIO_INDIRECT_ADDRCMD,
+			     0x3ffc, 0xc000);
+	if (ret)
+		return ret;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_MDIO_INDIRECT_STATUS);
+	if (val > 1) {
+		phydev_err(phydev, "wrong origin mdio_indirect_status: %x\n", val);
+		return -EINVAL;
+	}
+
+	/* Firmware is always aligned to u16 */
+	for (i = 0; i < size; i += 2) {
+		val = data[i + 1] << 8 | data[i];
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_MDIO_INDIRECT_LOAD, val);
+		if (ret)
+			return ret;
+	}
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_CPU_RESET_ADDR_LO_BASEADDR,
+			    lower_16_bits(AEON_CPU_BOOT_ADDR));
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_CPU_RESET_ADDR_HI_BASEADDR,
+			    upper_16_bits(AEON_CPU_BOOT_ADDR));
+	if (ret)
+		return ret;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLB_REG_CPU_CTRL,
+			      VEND1_GLB_CPU_CTRL_MASK, AEON_CPU_CTRL_FW_START);
+}
+
+static int aeon_firmware_load(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw;
+	const char *fw_name;
+	int ret;
+
+	ret = of_property_read_string(dev->of_node, "firmware-name",
+				      &fw_name);
+	if (ret)
+		return ret;
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret) {
+		phydev_err(phydev, "failed to find FW file %s (%d)\n",
+			   fw_name, ret);
+		return ret;
+	}
+
+	ret = aeon_firmware_boot(phydev, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int aeon_ipc_send_cmd(struct phy_device *phydev, u32 cmd,
+			     u16 *ret_sts)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+	bool curr_parity;
+	u32 val;
+	int ret;
+
+	/* The IPC sync by using a single parity bit.
+	 * Each CMD have alternately this bit set or clear
+	 * to understand correct flow and packet order.
+	 */
+	curr_parity = priv->parity_status;
+	if (priv->parity_status)
+		cmd |= AEON_IPC_CMD_PARITY;
+
+	/* Always update parity for next packet */
+	priv->parity_status = !priv->parity_status;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_CMD, cmd);
+	if (ret)
+		return ret;
+
+	/* Wait for packet to be processed */
+	usleep_range(10000, 15000);
+
+	/* With no ret_sts, ignore waiting for packet completion
+	 * (ipc parity bit sync)
+	 */
+	if (!ret_sts)
+		return 0;
+
+	/* Exit condition logic:
+	 * - Wait for parity bit equal
+	 * - Wait for status success, error OR ready
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
+					FIELD_GET(AEON_IPC_STS_PARITY, val) ==
+						curr_parity &&
+					(val & AEON_IPC_STS_STATUS) !=
+						AEON_IPC_STS_STATUS_RCVD &&
+					(val & AEON_IPC_STS_STATUS) !=
+						AEON_IPC_STS_STATUS_PROCESS &&
+					(val & AEON_IPC_STS_STATUS) !=
+						AEON_IPC_STS_STATUS_BUSY,
+					10000, 2000000, false);
+	if (ret)
+		return ret;
+
+	*ret_sts = val;
+	if ((val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int aeon_ipc_send_msg(struct phy_device *phydev, u16 opcode,
+			     u16 *data, unsigned int data_len, u16 *ret_sts)
+{
+	u32 cmd;
+	int ret;
+	int i;
+
+	if (data_len > AEON_IPC_DATA_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < data_len / sizeof(u16); i++)
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
+			      data[i]);
+
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
+	ret = aeon_ipc_send_cmd(phydev, cmd, ret_sts);
+	if (ret)
+		phydev_err(phydev, "failed to send ipc msg for %x: %d\n", opcode, ret);
+
+	return ret;
+}
+
+static int aeon_ipc_rcv_msg(struct phy_device *phydev, u16 ret_sts,
+			    u16 *data)
+{
+	unsigned int size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
+	int ret;
+	int i;
+
+	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
+		return -EINVAL;
+
+	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
+		if (ret < 0)
+			return ret;
+
+		data[i] = ret;
+	}
+
+	return size;
+}
+
+/* Logic to sync parity bit with IPC.
+ * We send 2 NOP cmd with same partity and we wait for IPC
+ * to handle the packet only for the second one. This way
+ * we make sure we are sync for every next cmd.
+ */
+static int aeon_ipc_sync_parity(struct phy_device *phydev)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+	u16 ret_sts;
+	u32 cmd;
+	int ret;
+
+	/* Send NOP with no parity */
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_NOOP);
+	aeon_ipc_send_cmd(phydev, cmd, NULL);
+
+	/* Reset packet parity */
+	priv->parity_status = false;
+
+	/* Send second NOP with no parity */
+	ret = aeon_ipc_send_cmd(phydev, cmd, &ret_sts);
+	/* We expect to return -EFAULT */
+	if (ret != -EFAULT)
+		return ret;
+
+	if ((ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_READY)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int aeon_ipc_get_fw_version(struct phy_device *phydev)
+{
+	u16 ret_data[8], data[1];
+	u16 ret_sts;
+	int ret;
+
+	data[0] = IPC_INFO_VERSION;
+	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data, sizeof(data),
+				&ret_sts);
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
+	if (ret < 0)
+		return ret;
+
+	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);
+
+	return 0;
+}
+
+static int aeon_dpc_ra_enable(struct phy_device *phydev)
+{
+	u16 data[2];
+	u16 ret_sts;
+
+	data[0] = IPC_CFG_PARAM_DIRECT;
+	data[1] = IPC_CFG_PARAM_DIRECT_DPC_RA;
+
+	return aeon_ipc_send_msg(phydev, IPC_CMD_CFG_PARAM, data,
+				 sizeof(data), &ret_sts);
+}
+
+static int as21xxx_probe(struct phy_device *phydev)
+{
+	struct as21xxx_priv *priv;
+	int ret;
+
+	phydev->priv = devm_kzalloc(&phydev->mdio.dev,
+				    sizeof(*priv), GFP_KERNEL);
+	if (!phydev->priv)
+		return -ENOMEM;
+
+	ret = aeon_firmware_load(phydev);
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_sync_parity(phydev);
+	if (ret)
+		return ret;
+
+	/* Enable PTP clk if not already Enabled */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
+			       VEND1_PTP_CLK_EN);
+	if (ret)
+		return ret;
+
+	ret = aeon_dpc_ra_enable(phydev);
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_get_fw_version(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int as21xxx_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+			   phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
+static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
+{
+	int status;
+
+	*bmcr = phy_read_mmd(phydev, MDIO_MMD_AN,
+			     MDIO_AN_C22 + MII_BMCR);
+	if (*bmcr < 0)
+		return *bmcr;
+
+	/* Autoneg is being started, therefore disregard current
+	 * link status and report link as down.
+	 */
+	if (*bmcr & BMCR_ANRESTART) {
+		phydev->link = 0;
+		return 0;
+	}
+
+	status = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
+	if (status < 0)
+		return status;
+
+	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
+
+	return 0;
+}
+
+static int as21xxx_read_c22_lpa(struct phy_device *phydev)
+{
+	int lpagb;
+
+	lpagb = phy_read_mmd(phydev, MDIO_MMD_AN,
+			     MDIO_AN_C22 + MII_STAT1000);
+	if (lpagb < 0)
+		return lpagb;
+
+	if (lpagb & LPA_1000MSFAIL) {
+		int adv = phy_read_mmd(phydev, MDIO_MMD_AN,
+				       MDIO_AN_C22 + MII_CTRL1000);
+
+		if (adv < 0)
+			return adv;
+
+		if (adv & CTL1000_ENABLE_MASTER)
+			phydev_err(phydev, "Master/Slave resolution failed, maybe conflicting manual settings?\n");
+		else
+			phydev_err(phydev, "Master/Slave resolution failed\n");
+		return -ENOLINK;
+	}
+
+	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
+					lpagb);
+
+	return 0;
+}
+
+static int as21xxx_read_status(struct phy_device *phydev)
+{
+	int bmcr, old_link = phydev->link;
+	int ret;
+
+	ret = as21xxx_read_link(phydev, &bmcr);
+	if (ret)
+		return ret;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret)
+			return ret;
+
+		ret = as21xxx_read_c22_lpa(phydev);
+		if (ret)
+			return ret;
+
+		phy_resolve_aneg_linkmode(phydev);
+	} else {
+		int speed;
+
+		linkmode_zero(phydev->lp_advertising);
+
+		speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_SPEED_STATUS);
+		if (speed < 0)
+			return speed;
+
+		switch (speed & VEND1_SPEED_STATUS) {
+		case VEND1_SPEED_10000:
+			phydev->speed = SPEED_10000;
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		case VEND1_SPEED_5000:
+			phydev->speed = SPEED_5000;
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		case VEND1_SPEED_2500:
+			phydev->speed = SPEED_2500;
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		case VEND1_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			if (bmcr & BMCR_FULLDPLX)
+				phydev->duplex = DUPLEX_FULL;
+			else
+				phydev->duplex = DUPLEX_HALF;
+			break;
+		case VEND1_SPEED_100:
+			phydev->speed = SPEED_100;
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		case VEND1_SPEED_10:
+			phydev->speed = SPEED_10;
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int as21xxx_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	u16 val = VEND1_LED_REG_A_EVENT_OFF;
+
+	if (index > AEON_MAX_LDES)
+		return -EINVAL;
+
+	if (value)
+		val = VEND1_LED_REG_A_EVENT_ON;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_LED_REG(index),
+			      VEND1_LED_REG_A_EVENT, val);
+}
+
+static int as21xxx_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	int i;
+
+	if (index > AEON_MAX_LDES)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
+		if (rules == as21xxx_led_supported_pattern[i].pattern)
+			return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int as21xxx_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	u16 val;
+	int i;
+
+	if (index > AEON_MAX_LDES)
+		return -EINVAL;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_LED_REG(index));
+	if (val < 0)
+		return val;
+
+	val &= VEND1_LED_REG_A_EVENT;
+	for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
+		if (val == as21xxx_led_supported_pattern[i].val) {
+			*rules = as21xxx_led_supported_pattern[i].pattern;
+			return 0;
+		}
+
+	/* Should be impossible */
+	return -EINVAL;
+}
+
+static int as21xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	u16 val;
+	int i;
+
+	if (index > AEON_MAX_LDES)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
+		if (rules == as21xxx_led_supported_pattern[i].pattern) {
+			val = as21xxx_led_supported_pattern[i].val;
+			break;
+		}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_LED_REG(index),
+			      VEND1_LED_REG_A_EVENT, val);
+}
+
+static int as21xxx_led_polarity_set(struct phy_device *phydev, int index,
+				    unsigned long modes)
+{
+	bool led_active_low;
+	u16 mask, val = 0;
+	u32 mode;
+
+	if (index > AEON_MAX_LDES)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			led_active_low = true;
+			break;
+		case PHY_LED_ACTIVE_HIGH: /* default mode */
+			led_active_low = false;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	mask = VEND1_GLB_CPU_CTRL_LED_POLARITY(index);
+	if (led_active_low)
+		val = VEND1_GLB_CPU_CTRL_LED_POLARITY(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_GLB_REG_CPU_CTRL,
+			      mask, val);
+}
+
+static struct phy_driver as21xxx_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
+		.name		= "Aeonsemi AS21xxx",
+		.probe		= as21xxx_probe,
+		.get_features	= as21xxx_get_features,
+		.read_status	= as21xxx_read_status,
+		.led_brightness_set = as21xxx_led_brightness_set,
+		.led_hw_is_supported = as21xxx_led_hw_is_supported,
+		.led_hw_control_set = as21xxx_led_hw_control_set,
+		.led_hw_control_get = as21xxx_led_hw_control_get,
+		.led_polarity_set = as21xxx_led_polarity_set,
+	},
+};
+module_phy_driver(as21xxx_drivers);
+
+static struct mdio_device_id __maybe_unused as21xxx_tbl[] = {
+	{ PHY_ID_MATCH_VENDOR(PHY_VENDOR_AEONSEMI) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, as21xxx_tbl);
+
+MODULE_DESCRIPTION("Aeonsemi AS21xxx PHY driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.48.1


