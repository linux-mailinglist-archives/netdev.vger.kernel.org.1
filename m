Return-Path: <netdev+bounces-117104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410D94CB42
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64421F21C2E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF178CE7;
	Fri,  9 Aug 2024 07:24:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03131779A4
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188296; cv=none; b=uEbcRf9vCC0iSder8loonKQsknaCJbJYbdOdVCosXj1xvWgoq5lTMZo3+wK+P4S8/2Yxu1HxjRLYrwqXcjFPZED5PfisOvaHuarBejEnzspOQSZbEzMf0CRbyr1K/fmv9x+Vg4RLzbhlifD/nJ3Ksp0eXqPbOtWiEtaSnjQGr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188296; c=relaxed/simple;
	bh=rUVtqtZyjzIYQ6czWaEkDNTDbjZzYZw5zGQvwjXTuSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxZo4fw1dUcbkWkMbLgOlZb9Qm8xqjESvZSnzPyo8c3RJ9mGgb2SZz41uVG4Pf/Sqm9se/aK+P32ONhaC5/t5+bQJJES3NJH1X4itR6oyF0eotFX/wQYI0xjo89k4vFxbQf5Dk70EJDMlIuAqwcvMb/IbBB3P18LrrJ9TEiYJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzO-0001f7-Tu; Fri, 09 Aug 2024 09:24:42 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzN-005buw-4J; Fri, 09 Aug 2024 09:24:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1scJzN-00EaZC-0B;
	Fri, 09 Aug 2024 09:24:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/3] phy: Add Open Alliance helpers for the PHY framework
Date: Fri,  9 Aug 2024 09:24:38 +0200
Message-Id: <20240809072440.3477125-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809072440.3477125-1-o.rempel@pengutronix.de>
References: <20240809072440.3477125-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce helper functions specific to Open Alliance diagnostics,
integrating them into the PHY framework. Currently, these helpers
are limited to 1000BaseT1 specific TDR functionality.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- make it optional
- move headers to the drivers/net/phy folder
---
 drivers/net/phy/Kconfig                 |  3 +
 drivers/net/phy/Makefile                |  1 +
 drivers/net/phy/open_alliance_helpers.c | 76 +++++++++++++++++++++++++
 drivers/net/phy/open_alliance_helpers.h | 47 +++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/net/phy/open_alliance_helpers.c
 create mode 100644 drivers/net/phy/open_alliance_helpers.h

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7fddc8306d822..874422e530ff0 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -44,6 +44,9 @@ config LED_TRIGGER_PHY
 		<Speed in megabits>Mbps OR <Speed in gigabits>Gbps OR link
 		for any speed known to the PHY.
 
+config OPEN_ALLIANCE_HELPERS
+	bool
+
 config PHYLIB_LEDS
 	def_bool OF
 	depends on LEDS_CLASS=y || LEDS_CLASS=PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 202ed7f450da6..e93dfec881c5d 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_DEVRES)	+= mdio_devres.o
 libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
 
+obj-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
 obj-$(CONFIG_PHYLINK)		+= phylink.o
 obj-$(CONFIG_PHYLIB)		+= libphy.o
 
diff --git a/drivers/net/phy/open_alliance_helpers.c b/drivers/net/phy/open_alliance_helpers.c
new file mode 100644
index 0000000000000..b7e67bdb01e33
--- /dev/null
+++ b/drivers/net/phy/open_alliance_helpers.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * open_alliance_helpers.c - OPEN Alliance specific PHY diagnostic helpers
+ *
+ * This file contains helper functions for implementing advanced diagnostic
+ * features as specified by the OPEN Alliance for automotive Ethernet PHYs.
+ * These helpers include functionality for Time Delay Reflection (TDR), dynamic
+ * channel quality assessment, and other PHY diagnostics.
+ *
+ * For more information on the specifications, refer to the OPEN Alliance
+ * documentation: https://opensig.org/automotive-ethernet-specifications/
+ * Currently following specifications are partially or fully implemented:
+ * - Advanced diagnostic features for 1000BASE-T1 automotive Ethernet PHYs.
+ *   TC12 - advanced PHY features.
+ *   https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf
+ */
+
+#include <linux/ethtool_netlink.h>
+
+#include "open_alliance_helpers.h"
+
+/**
+ * oa_1000bt1_get_ethtool_cable_result_code - Convert TDR status to ethtool
+ *					      result code
+ * @reg_value: Value read from the TDR register
+ *
+ * This function takes a register value from the HDD.TDR register and converts
+ * the TDR status to the corresponding ethtool cable test result code.
+ *
+ * Return: The appropriate ethtool result code based on the TDR status
+ */
+int oa_1000bt1_get_ethtool_cable_result_code(u16 reg_value)
+{
+	u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
+	u8 dist_val = FIELD_GET(OA_1000BT1_HDD_TDR_DISTANCE_MASK, reg_value);
+
+	switch (tdr_status) {
+	case OA_1000BT1_HDD_TDR_STATUS_CABLE_OK:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	case OA_1000BT1_HDD_TDR_STATUS_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case OA_1000BT1_HDD_TDR_STATUS_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case OA_1000BT1_HDD_TDR_STATUS_NOISE:
+		return ETHTOOL_A_CABLE_RESULT_CODE_NOISE;
+	default:
+		if (dist_val == OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE)
+			return ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE;
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+EXPORT_SYMBOL_GPL(oa_1000bt1_get_ethtool_cable_result_code);
+
+/**
+ * oa_1000bt1_get_tdr_distance - Get distance to the main fault from TDR
+ *				 register value
+ * @reg_value: Value read from the TDR register
+ *
+ * This function takes a register value from the HDD.TDR register and extracts
+ * the distance to the main fault detected by the TDR feature. The distance is
+ * measured in centimeters and ranges from 0 to 3100 centimeters. If the
+ * distance is not available (0x3f), the function returns -ERANGE.
+ *
+ * Return: The distance to the main fault in centimeters, or -ERANGE if the
+ * resolution is not possible.
+ */
+int oa_1000bt1_get_tdr_distance(u16 reg_value)
+{
+	u8 dist_val = FIELD_GET(OA_1000BT1_HDD_TDR_DISTANCE_MASK, reg_value);
+
+	if (dist_val == OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE)
+		return -ERANGE;
+
+	return dist_val * 100;
+}
+EXPORT_SYMBOL_GPL(oa_1000bt1_get_tdr_distance);
diff --git a/drivers/net/phy/open_alliance_helpers.h b/drivers/net/phy/open_alliance_helpers.h
new file mode 100644
index 0000000000000..8b7d97bc6f186
--- /dev/null
+++ b/drivers/net/phy/open_alliance_helpers.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef OPEN_ALLIANCE_HELPERS_H
+#define OPEN_ALLIANCE_HELPERS_H
+
+/*
+ * These defines reflect the TDR (Time Delay Reflection) diagnostic feature
+ * for 1000BASE-T1 automotive Ethernet PHYs as specified by the OPEN Alliance.
+ *
+ * The register values are part of the HDD.TDR register, which provides
+ * information about the cable status and faults. The exact register offset
+ * is device-specific and should be provided by the driver.
+ */
+#define OA_1000BT1_HDD_TDR_ACTIVATION_MASK		GENMASK(1, 0)
+#define OA_1000BT1_HDD_TDR_ACTIVATION_OFF		1
+#define OA_1000BT1_HDD_TDR_ACTIVATION_ON		2
+
+#define OA_1000BT1_HDD_TDR_STATUS_MASK			GENMASK(7, 4)
+#define OA_1000BT1_HDD_TDR_STATUS_SHORT			3
+#define OA_1000BT1_HDD_TDR_STATUS_OPEN			6
+#define OA_1000BT1_HDD_TDR_STATUS_NOISE			5
+#define OA_1000BT1_HDD_TDR_STATUS_CABLE_OK		7
+#define OA_1000BT1_HDD_TDR_STATUS_TEST_IN_PROGRESS	8
+#define OA_1000BT1_HDD_TDR_STATUS_TEST_NOT_POSSIBLE	13
+
+/*
+ * OA_1000BT1_HDD_TDR_DISTANCE_MASK:
+ * This mask is used to extract the distance to the first/main fault
+ * detected by the TDR feature. Each bit represents an approximate distance
+ * of 1 meter, ranging from 0 to 31 meters. The exact interpretation of the
+ * bits may vary, but generally:
+ * 000000 = no error
+ * 000001 = error about 0-1m away
+ * 000010 = error between 1-2m away
+ * ...
+ * 011111 = error about 30-31m away
+ * 111111 = resolution not possible / out of distance
+ */
+#define OA_1000BT1_HDD_TDR_DISTANCE_MASK			GENMASK(13, 8)
+#define OA_1000BT1_HDD_TDR_DISTANCE_NO_ERROR			0
+#define OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE	0x3f
+
+int oa_1000bt1_get_ethtool_cable_result_code(u16 reg_value);
+int oa_1000bt1_get_tdr_distance(u16 reg_value);
+
+#endif /* OPEN_ALLIANCE_HELPERS_H */
+
-- 
2.39.2


