Return-Path: <netdev+bounces-133409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C08995D71
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC69A1F2442D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C639FD9;
	Wed,  9 Oct 2024 01:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF8383;
	Wed,  9 Oct 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438791; cv=none; b=TI3aHNYspTPmeVUYq3djoDzLd3w89YgIZ7YU+jB0tKjSXgfHOlb/QhBZbMJ5OBJ6qf+7PAxIFKtjDOqf6tQwWZpA9YV282mSZSe+Pd6H/Oaar7G/TBQ8Hj8ycbPsPfmsvPKSUzVVxHfMjKVGOJtRPdaMRu4nHg6YbprAEbsQyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438791; c=relaxed/simple;
	bh=rzONIBT2xHW7ECDdWtokFD/Xfd59nQLmQrZC7TpWLAc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qeML9XmWzXYgZ2W/WO0OsJdMhuNaClMbGZiL9nXDbpzBGWMxhSM2t4OQN/QmMfI0FAY6SXAO/MJ4X8FAcAXwd8VCP7dEa3VljEyeRKDkceQapE10oyc84I9pg9idukDU9xLVJ/cxswjZjR/S1OtgeZh5kBt3C9ef1bi6ivsgTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syLsw-000000003El-1eZh;
	Wed, 09 Oct 2024 01:53:06 +0000
Date: Wed, 9 Oct 2024 02:53:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: phy: realtek: read duplex and gbit master
 from PHYSR register
Message-ID: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
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
 drivers/net/phy/realtek.c | 48 ++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index c15d2f66ef0d..717284a71667 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -80,15 +80,19 @@
 
 #define RTL822X_VND2_GANLPAR				0xa414
 
-#define RTL822X_VND2_PHYSR				0xa434
-
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
 #define RTL9000A_GINMR				0x14
 #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
 
-#define RTLGEN_SPEED_MASK			0x0630
+#define RTL_VND2_PHYSR				0xa434
+#define RTL_VND2_PHYSR_LINK			BIT(2)
+#define RTL_VND2_PHYSR_DUPLEX			BIT(3)
+#define RTL_VND2_PHYSR_SPEEDL			GENMASK(5, 4)
+#define RTL_VND2_PHYSR_SPEEDH			GENMASK(10, 9)
+#define RTL_VND2_PHYSR_MASTER			BIT(11)
+#define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
@@ -660,9 +664,24 @@ static int rtl8366rb_config_init(struct phy_device *phydev)
 }
 
 /* get actual speed to cover the downshift case */
-static void rtlgen_decode_speed(struct phy_device *phydev, int val)
+static void rtlgen_decode_physr(struct phy_device *phydev, int val)
 {
-	switch (val & RTLGEN_SPEED_MASK) {
+	/* bit 2
+	 * 0: Link not OK
+	 * 1: Link OK
+	 */
+	phydev->link = !!(val & RTL_VND2_PHYSR_LINK);
+
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
@@ -684,6 +703,19 @@ static void rtlgen_decode_speed(struct phy_device *phydev, int val)
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
@@ -701,7 +733,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (val < 0)
 		return val;
 
-	rtlgen_decode_speed(phydev, val);
+	rtlgen_decode_physr(phydev, val);
 
 	return 0;
 }
@@ -1007,11 +1039,11 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
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

