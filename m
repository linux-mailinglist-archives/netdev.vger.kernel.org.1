Return-Path: <netdev+bounces-116865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56C94BE39
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932F11F23069
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CC18CC1E;
	Thu,  8 Aug 2024 13:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160A18E740
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122537; cv=none; b=oUwq95bLMjJfPGQ91fSFrQ3ugAyJZJbS44VE2JXNqPYoT/1G8tPvdD32bPOphXFHTALPBYqHMVTQYf6wwmms/Mby5LLuZySggROHWNPUn6AzTh9hzghQaqh/8dhn4w36Kl4NKtCcjCeqKAYq7trg+j5wiFw1YpyCsRTt1Rc7nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122537; c=relaxed/simple;
	bh=4cuPfHmkBT4djvVCSyY2N1DhBrbDX6ir3eBO+8mPiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gehzP/wi7wF//V4U+/hy4/hIjbTJ4hw86fXif2xL8vx0d/OAHUdHcmS1RZfZxyO/E82yNblyRxOQW/Hy1DKk9EQ4EWXQSfrYo80IqlZovKVimxPwapZXV7SLm56d7fgB8Hp6cacQK3duXe6gmGnl2ALWb464b/PE5aFnbmEUthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sc2se-0000gE-4O; Thu, 08 Aug 2024 15:08:36 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sc2sc-005R24-P8; Thu, 08 Aug 2024 15:08:34 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sc2sc-008k7Q-2G;
	Thu, 08 Aug 2024 15:08:34 +0200
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
Subject: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the PHY framework
Date: Thu,  8 Aug 2024 15:08:32 +0200
Message-Id: <20240808130833.2083875-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808130833.2083875-1-o.rempel@pengutronix.de>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
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
 drivers/net/phy/Makefile                |  2 +-
 drivers/net/phy/open_alliance_helpers.c | 70 +++++++++++++++++++++++++
 include/linux/open_alliance_helpers.h   | 47 +++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/open_alliance_helpers.c
 create mode 100644 include/linux/open_alliance_helpers.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 202ed7f450da6..8a46a04af01a5 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o
+				   linkmode.o open_alliance_helpers.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/open_alliance_helpers.c b/drivers/net/phy/open_alliance_helpers.c
new file mode 100644
index 0000000000000..eac1004c065ae
--- /dev/null
+++ b/drivers/net/phy/open_alliance_helpers.c
@@ -0,0 +1,70 @@
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
+ */
+
+#include <linux/ethtool_netlink.h>
+#include <linux/open_alliance_helpers.h>
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
+	u8 tdr_status = (reg_value & OA_1000BT1_HDD_TDR_STATUS_MASK) >> 4;
+	u8 dist_val = (reg_value & OA_1000BT1_HDD_TDR_DISTANCE_MASK) >> 8;
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
+	u8 dist_val = (reg_value & OA_1000BT1_HDD_TDR_DISTANCE_MASK) >> 8;
+
+	if (dist_val == OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE)
+		return -ERANGE;
+
+	return dist_val * 100;
+}
+
diff --git a/include/linux/open_alliance_helpers.h b/include/linux/open_alliance_helpers.h
new file mode 100644
index 0000000000000..8b7d97bc6f186
--- /dev/null
+++ b/include/linux/open_alliance_helpers.h
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


