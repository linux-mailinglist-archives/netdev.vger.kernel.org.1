Return-Path: <netdev+bounces-249307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9CD168C3
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1D043013BD8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF834BA46;
	Tue, 13 Jan 2026 03:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF43090D2;
	Tue, 13 Jan 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275884; cv=none; b=Hf5YQSAMmS63hdLrifiUJILnO0Yb0pYBxVUOD52Hr2RLXw7iIBYxF37jKFg90eD3aeplprKeqKpH8BgTfMwVwGwxR/C17sHxnJ9EnOkXVLxPjDr3rNKJPND7lJyv4zy2fxiCb5ID0u7meZXcp8QvUouzpwwntJHOWbD9KlrfXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275884; c=relaxed/simple;
	bh=9lYvE1lWK65fQNDb1ov3iurb3fOw/SUHyMdoLQ73OKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTauYkujVK88TQSNnTFNGmYZJuzv/ArsT+mWkUrjz4gonAZGzQyvzL9gaNgjpdNrS//lJvbq541J/3HBxuHTrNM7gzJtuoJKCyAGSy1YYTXA1gs5hIWjNYql565KxhaYwTM/D0VM11AtldIUSaMf1wzRuZTI3+QfWkvqpdfMnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVKe-000000001Vl-0ug9;
	Tue, 13 Jan 2026 03:44:36 +0000
Date: Tue, 13 Jan 2026 03:44:33 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Michael Klein <michael@fossekall.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] net: phy: realtek: demystify PHYSR register location
Message-ID: <6ed246e0aa3ca8038d2fa432d51518959fb89b6b.1768275364.git.daniel@makrotopia.org>
References: <cover.1768275364.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768275364.git.daniel@makrotopia.org>

Turns out that register address RTL_VND2_PHYSR (0xa434) maps to
Clause-22 register MII_RESV2. Use that to get rid of yet another magic
number, and rename access macros accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: rebase on top of recent commit
    "net: phy: realtek: add dummy PHY driver for RTL8127ATF"
    replacing newly added reference to RTL_VND2_PHYSR

 drivers/net/phy/realtek/realtek_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 4512fad3f64b8..8f1c8424e7f94 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -179,12 +179,12 @@
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
@@ -1103,12 +1103,12 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
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
@@ -1136,7 +1136,7 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
 	 * 1: Master Mode
 	 */
 	if (phydev->speed >= 1000) {
-		if (val & RTL_VND2_PHYSR_MASTER)
+		if (val & RTL_PHYSR_MASTER)
 			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
 		else
 			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
@@ -1156,8 +1156,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
-			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
+	val = phy_read(phydev, RTL_PHYSR);
 	if (val < 0)
 		return val;
 
@@ -1623,7 +1622,8 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 	}
 
 	/* Read actual speed from vendor register. */
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			   RTL822X_VND2_C22_REG(RTL_PHYSR));
 	if (val < 0)
 		return val;
 
@@ -2127,7 +2127,7 @@ static int rtlgen_sfp_read_status(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
+	val = phy_read(phydev, RTL_PHYSR);
 	if (val < 0)
 		return val;
 
-- 
2.52.0

