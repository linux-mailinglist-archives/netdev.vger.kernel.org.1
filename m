Return-Path: <netdev+bounces-248322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E345D06E94
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1816301D0CF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C823EAB7;
	Fri,  9 Jan 2026 03:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFD1E8329;
	Fri,  9 Jan 2026 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927811; cv=none; b=ixSP+vwq2qcNJ9fQnRq1cgAK4MxsRhAONSjiKRB1lNSrbwCY+asg2lShIf8kCDlkV/f4CEQfZdiO71gQxiNxiKYYH1TmUuTIsUZF66awbxM/7PdaynTSMqBd1Ra9vE/2i/s/V6/md7CtfeAukUKxk+pVAV3vLJasg1o1/CZ2gQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927811; c=relaxed/simple;
	bh=BFTSDRGmQm6Sxux2IEKd6bs1hUut7PYVzFZXa4mECW4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOqj/4UnV7p9s2mi26DQvr3VKAWkutpbw9WwJYreGGOMqRsFTG1E7zxrXdNJGz9s7ff/10s50s80JTFH8RA3VOYlLXmC29JlFh7Y5gX6Lsy5lBIRIYs+P5IRB3S5dSL5uNqrSniiKMZlMX8KeaTr44Np+e5awoDgFIobM7JvZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1ve2mb-000000005kQ-1vBF;
	Fri, 09 Jan 2026 03:03:25 +0000
Date: Fri, 9 Jan 2026 03:03:22 +0000
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
Subject: [PATCH net-next 2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
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

RealTek 2.5GE PHYs have all standard Clause-22 registers mapped also
inside MDIO_MMD_VEND2 at offset 0xa400. This is used mainly in case the
PHY is inside a copper SFP module which uses the RollBall MDIO-over-I2C
method which *only* supports Clause-45. In order to support such
modules, the PHY driver has previously been split into a C22-only and
C45-only instances, creating quite a bit of redundancy and confusion.

In preparation of reunifying the two driver instances, add support for
translating MDIO_MMD_VEND2 registers 0xa400 to 0xa438 back to standard
Clause-22 access in case the PHY is accessed on a Clause-22 bus.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 7302b25b8908b..886694ff995f6 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -143,6 +143,7 @@
 
 #define RTL822X_VND2_TO_PAGE(reg)		((reg) >> 4)
 #define RTL822X_VND2_TO_PAGE_REG(reg)		(16 + (((reg) & GENMASK(3, 0)) >> 1))
+#define RTL822X_VND2_TO_C22_REG(reg)		(((reg) - 0xa400) / 2)
 #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
 #define RTL8221B_VND2_INER			0xa4d2
@@ -1264,6 +1265,11 @@ static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
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
@@ -1299,6 +1305,11 @@ static int rtl822xb_write_mmd(struct phy_device *phydev, int devnum, u16 reg,
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

