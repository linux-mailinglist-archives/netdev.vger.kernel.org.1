Return-Path: <netdev+bounces-249305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBED168BA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0F83028475
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DB34AB03;
	Tue, 13 Jan 2026 03:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C930E0E5;
	Tue, 13 Jan 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275866; cv=none; b=qlSz9T5q8fJlw+uArYtlp3GED44QJ069wGRq2kjuPVHgb+EscqEVJJUSuOSZuMcEx9AAfCgeJ181D5pzYKKhfwo6KWXRGArs1Q46uCd5wA9TcuCjVpY3mCsMG4z7SBDFn1AO1ubUkjGhs87UAiNLs0i2uPmioqyKUN4uTp5+N3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275866; c=relaxed/simple;
	bh=pjAJc7cFgj5ez0wfbN+bun+UNWhKuxS3Bqnjbf9ljJ8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA4hOnuSsRMCIEv9gdR2hqZ25weAkaeDFPkgu95B4EDpJhE+odfCYUw9qpnY1yp8dnkn0P1i7a68yiz6pzjwUuXHtC5jnGfKvenWx/8+5UuJ29qn0Q+lzaXJxCke0NsLkTNPTS1ITRRgs1/FeGfhxNhkbN4EV7T8DNCuX8qAszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVKO-000000001Us-1Oqu;
	Tue, 13 Jan 2026 03:44:20 +0000
Date: Tue, 13 Jan 2026 03:44:17 +0000
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
Subject: [PATCH v2 2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
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

RealTek 2.5GE PHYs have all standard Clause-22 registers mapped also
inside MDIO_MMD_VEND2 at offset 0xa400. This is used mainly in case the
PHY is connected to a Clause-45-only bus. The RTL8221B is frequently
used in copper SFP module which uses the RollBall MDIO-over-I2C
method which *only* supports Clause-45, for example.

In order to support using the PHY on Clause-45-only busses, the PHY
driver has previously been split into a C22-only and C45-only instances,
creating quite a bit of redundancy and confusion.

In preparation of reunifying the two driver instances, add support for
translating MDIO_MMD_VEND2 registers 0xa400 to 0xa43c back to Clause-22
registers 0 to 30 in case the PHY is accessed on a Clause-22 bus.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: improve commit message

 drivers/net/phy/realtek/realtek_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 18eea6b4b59a6..74980b2d66157 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -144,6 +144,7 @@
 
 #define RTL822X_VND2_TO_PAGE(reg)		((reg) >> 4)
 #define RTL822X_VND2_TO_PAGE_REG(reg)		(16 + (((reg) & GENMASK(3, 0)) >> 1))
+#define RTL822X_VND2_TO_C22_REG(reg)		(((reg) - 0xa400) / 2)
 #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
 #define RTL8221B_VND2_INER			0xa4d2
@@ -1265,6 +1266,11 @@ static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
 		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
 				    phydev->is_c45, devnum, reg);
 
+	/* Simplify access to C22-registers addressed inside MDIO_MMD_VEND2 */
+	if (reg >= RTL822X_VND2_C22_REG(0) &&
+	    reg <= RTL822X_VND2_C22_REG(30))
+		return __phy_read(phydev, RTL822X_VND2_TO_C22_REG(reg));
+
 	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
 	page = RTL822X_VND2_TO_PAGE(reg);
 	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -1300,6 +1306,11 @@ static int rtl822xb_write_mmd(struct phy_device *phydev, int devnum, u16 reg,
 		return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
 				     phydev->is_c45, devnum, reg, val);
 
+	/* Simplify access to C22-registers addressed inside MDIO_MMD_VEND2 */
+	if (reg >= RTL822X_VND2_C22_REG(0) &&
+	    reg <= RTL822X_VND2_C22_REG(30))
+		return __phy_write(phydev, RTL822X_VND2_TO_C22_REG(reg), val);
+
 	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
 	page = RTL822X_VND2_TO_PAGE(reg);
 	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
-- 
2.52.0

