Return-Path: <netdev+bounces-134221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230A998720
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D032819A4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B91C7B8F;
	Thu, 10 Oct 2024 13:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E41C7B86;
	Thu, 10 Oct 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565644; cv=none; b=pQa88Eb3k/0A1vLJKMEWnOndZGds2jEqSELipjTgbnaXql8QGQnIGfK7oU81SsMWvmROLEvalfS/aihFSAzjfBeboeh97IchCagogwjYSNx0Zm/+T9Kgyt3XuM9S3dmxqWjFLzpP4LLuY1F3lkgmQHNkn13GLRscn5fH6c+wyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565644; c=relaxed/simple;
	bh=TGS0ZK1e1WP/QJYP4eNJCEg/YWBBdI8ud91rOySDWCs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O21AHSJKqRaQ7voxB+W+F4j5Jhy2RZRdp9N3UR+FXrd3HWbkbj5FHRm1r7UVtbp3Prf26BZe78a3ZwQ1zz4smcbSDpIZOfqqIiMS1F6K2JaP6AItXQIhS4l+4n3XxEc8dFurfLA4QD6njtEEtPpwiX8S5c2oiBva81biGSN2VCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syssx-000000003FQ-0T8K;
	Thu, 10 Oct 2024 13:07:19 +0000
Date: Thu, 10 Oct 2024 14:07:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: phy: realtek: read duplex and gbit
 master from PHYSR register
Message-ID: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PHYSR MMD register is present and defined equally for all RTL82xx
Ethernet PHYs.
Read duplex and Gbit master bits from rtlgen_decode_speed() and rename
it to rtlgen_decode_physr().

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: don't override link up/down status from PHYSR

 drivers/net/phy/realtek.c | 41 +++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index c15d2f66ef0d..9bbbbad1ca5a 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -80,15 +80,18 @@
 
 #define RTL822X_VND2_GANLPAR				0xa414
 
-#define RTL822X_VND2_PHYSR				0xa434
-
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
 #define RTL9000A_GINMR				0x14
 #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
 
-#define RTLGEN_SPEED_MASK			0x0630
+#define RTL_VND2_PHYSR				0xa434
+#define RTL_VND2_PHYSR_DUPLEX			BIT(3)
+#define RTL_VND2_PHYSR_SPEEDL			GENMASK(5, 4)
+#define RTL_VND2_PHYSR_SPEEDH			GENMASK(10, 9)
+#define RTL_VND2_PHYSR_MASTER			BIT(11)
+#define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
@@ -660,9 +663,18 @@ static int rtl8366rb_config_init(struct phy_device *phydev)
 }
 
 /* get actual speed to cover the downshift case */
-static void rtlgen_decode_speed(struct phy_device *phydev, int val)
+static void rtlgen_decode_physr(struct phy_device *phydev, int val)
 {
-	switch (val & RTLGEN_SPEED_MASK) {
+	/* bit 3
+	 * 0: Half Duplex
+	 * 1: Full Duplex
+	 */
+	if (val & RTL_VND2_PHYSR_DUPLEX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	switch (val & RTL_VND2_PHYSR_SPEED_MASK) {
 	case 0x0000:
 		phydev->speed = SPEED_10;
 		break;
@@ -684,6 +696,19 @@ static void rtlgen_decode_speed(struct phy_device *phydev, int val)
 	default:
 		break;
 	}
+
+	/* bit 11
+	 * 0: Slave Mode
+	 * 1: Master Mode
+	 */
+	if (phydev->speed >= 1000) {
+		if (val & RTL_VND2_PHYSR_MASTER)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+		else
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	} else {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
+	}
 }
 
 static int rtlgen_read_status(struct phy_device *phydev)
@@ -701,7 +726,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
-	rtlgen_decode_speed(phydev, val);
+	rtlgen_decode_physr(phydev, val);
 
 	return 0;
 }
@@ -1007,11 +1032,11 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 		return 0;
 
 	/* Read actual speed from vendor register. */
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_PHYSR);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
 	if (val < 0)
 		return val;
 
-	rtlgen_decode_speed(phydev, val);
+	rtlgen_decode_physr(phydev, val);
 
 	return 0;
 }
-- 
2.47.0

