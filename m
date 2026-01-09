Return-Path: <netdev+bounces-248324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04711D06E9D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E363012DD2
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDB318149;
	Fri,  9 Jan 2026 03:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A11E8329;
	Fri,  9 Jan 2026 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927833; cv=none; b=aSiqvi13h8ZHDcL+p0PqgNEdVFVNuNtnbCxhRZbZcUkhDkpPX3fz5uuP/SKudZ9WHZX1DxSYO7R4vOvl0tiV5xnRvCHjv8cuhwOFfWwckxEg6RxHUluTTp3SNwy1LKWOgcmKzQTMJ5ulfkPC63T6dj3TlUp3Y3tQECOQyUNsi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927833; c=relaxed/simple;
	bh=fFQh76+m+BUPRidLALObSIy1ryFNPjOKKoEZgbiNkTg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN8h8Ac/0hqGnJ0Z0nEf217b7ujh6uBvS7h8doESo5exnyB2RLdLNmwgKg3prjHTPU4YL3frgKH7ShMTsIIPGuvll4WUWaJC52ZycGbpiwab5G6WCu9d1T7hkKNUKGdseSBwRqDX+5f0dliEnKy9dr9BGFyiKv2yKyizHpZC/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve2mw-000000005lV-3bcD;
	Fri, 09 Jan 2026 03:03:46 +0000
Date: Fri, 9 Jan 2026 03:03:44 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: phy: realtek: demystify PHYSR register
 location
Message-ID: <bad322c8d939b5ba564ba353af9fb5f07b821752.1767926665.git.daniel@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767926665.git.daniel@makrotopia.org>

Turns out that register address RTL_VND2_PHYSR (0xa434) maps to
Clause-22 register MII_RESV2. Use that to get rid of yet another magic
number, and rename access macros accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index d07d60bc1ce34..5712372c71f91 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -178,12 +178,12 @@
 #define RTL9000A_GINMR				0x14
 #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
 
-#define RTL_VND2_PHYSR				0xa434
-#define RTL_VND2_PHYSR_DUPLEX			BIT(3)
-#define RTL_VND2_PHYSR_SPEEDL			GENMASK(5, 4)
-#define RTL_VND2_PHYSR_SPEEDH			GENMASK(10, 9)
-#define RTL_VND2_PHYSR_MASTER			BIT(11)
-#define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
+#define RTL_PHYSR				MII_RESV2
+#define RTL_PHYSR_DUPLEX			BIT(3)
+#define RTL_PHYSR_SPEEDL			GENMASK(5, 4)
+#define RTL_PHYSR_SPEEDH			GENMASK(10, 9)
+#define RTL_PHYSR_MASTER			BIT(11)
+#define RTL_PHYSR_SPEED_MASK			(RTL_PHYSR_SPEEDL | RTL_PHYSR_SPEEDH)
 
 #define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
 #define	RTL_MDIO_AN_EEE_ADV			0xa5d0
@@ -1102,12 +1102,12 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
 	 * 0: Half Duplex
 	 * 1: Full Duplex
 	 */
-	if (val & RTL_VND2_PHYSR_DUPLEX)
+	if (val & RTL_PHYSR_DUPLEX)
 		phydev->duplex = DUPLEX_FULL;
 	else
 		phydev->duplex = DUPLEX_HALF;
 
-	switch (val & RTL_VND2_PHYSR_SPEED_MASK) {
+	switch (val & RTL_PHYSR_SPEED_MASK) {
 	case 0x0000:
 		phydev->speed = SPEED_10;
 		break;
@@ -1135,7 +1135,7 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
 	 * 1: Master Mode
 	 */
 	if (phydev->speed >= 1000) {
-		if (val & RTL_VND2_PHYSR_MASTER)
+		if (val & RTL_PHYSR_MASTER)
 			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
 		else
 			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
@@ -1155,8 +1155,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
-			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
+	val = phy_read(phydev, RTL_PHYSR);
 	if (val < 0)
 		return val;
 
@@ -1622,7 +1621,8 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 	}
 
 	/* Read actual speed from vendor register. */
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			   RTL822X_VND2_C22_REG(RTL_PHYSR));
 	if (val < 0)
 		return val;
 
-- 
2.52.0

