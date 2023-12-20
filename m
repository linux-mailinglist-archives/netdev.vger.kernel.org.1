Return-Path: <netdev+bounces-59276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C581A341
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398A0B25B12
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4A46431;
	Wed, 20 Dec 2023 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMvWrzSi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC34642E
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447BC433CB;
	Wed, 20 Dec 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087732;
	bh=q48rfmgbzT811gDqkKiHhQXF9wQraPE6WLfoJlZuu/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMvWrzSi8nL04Emh4bVOdrl8LEjnOB3KZxp79jWTKYrh/h1x4Ndjsf+aOFwqLpZZN
	 R86AEVxcZPGXX/i08/JBuFd/HknTdSrtq8pHnsGN/j8w/cY4GS7L7qSR/mpeIOYJmh
	 nwWblPK0Kmt8aVIDi+Odb3RG5j4WNcUvikIF7NPKun57Qc0i1fwdW5qAtpUR+wpvkv
	 yE2C7NrvggzUJJWFx1ys3N8AXIQTP6D8cKL0AiZ7p4snFdew7eYy5Rr7jI15klMbJm
	 8HkkaLDlotmGDlo8QCTlYDuvm8s/OfMkdDY5alWJ3QLPaHc6/MoY8FmghCM0mQyF/V
	 zVPUUK9j2yFaw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 03/15] net: phy: realtek: rework MMD register access methods
Date: Wed, 20 Dec 2023 16:55:06 +0100
Message-ID: <20231220155518.15692-4-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
currently allow access to only 6 MMD registers, via a vendor specific
mechanism (a paged read / write).

The PHY specification explains that MMD registers for MMDs 1 to 30 can
be accessed via the clause 22 indirect mechanism through registers 13
and 14, but this is not possible for MMD 31.

A Realtek contact explained that MMD 31 registers can be accessed by
setting clause 22 page register (register 31):
  page = mmd_reg >> 4
  reg = 0x10 | ((mmd_reg & 0xf) >> 1)

This mechanism is currently used in the driver. For example the
.read_mmd() method accesses the PCS.EEE_ABLE register by setting page
to 0xa5c and accessing register 0x12. By the formulas above, this
corresponds to MMD register 31.a5c4. The Realtek contact confirmed that
the PCS.EEE_ABLE register (3.0014) is also available via MMD alias
31.a5c4, and this is also true for the other registers:

  register name   address   page.reg  alias
  PCS.EEE_ABLE    3.0x0014  0xa5c.12  31.0xa5c4
  PCS.EEE_ABLE2   3.0x0015  0xa6e.16  31.0xa6ec
  AN.EEE_ADV      7.0x003c  0xa5d.10  31.0xa5d0
  AN.EEE_LPABLE   7.0x003d  0xa5d.11  31.0xa5d2
  AN.EEE_ADV2     7.0x003e  0xa6d.12  31.0xa6d4
  AN.EEE_LPABLE2  7.0x003f  0xa6d.10  31.0xa6d0

Since the registers are also available at the true MMD addresses where
they can be accessed via the indirect mechanism (via registers 13 and
14) we can rework the code to be more generic and allow access to all
MMD registers.

Rework the .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
PHYs:
- use direct clause 45 access if the MDIO bus supports it
- use the indirect access via clause 22 registers 13 and 14 for MMDs
  1 to 30
- use the vendor specific method to access MMD 31 registers

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 111 ++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 894172a3e15f..6e84f460a888 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -585,84 +585,63 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	return rtlgen_get_speed(phydev);
 }
 
-static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+static int rtlgen_read_mmd(struct phy_device *phydev, int dev, u16 reg)
 {
-	int ret;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+	int page, ret;
 
-	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
-		rtl821x_write_page(phydev, 0xa5c);
-		ret = __phy_read(phydev, 0x12);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_read(phydev, 0x10);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_read(phydev, 0x11);
-		rtl821x_write_page(phydev, 0);
-	} else {
-		ret = -EOPNOTSUPP;
-	}
+	/* use c45 access if MDIO bus supports them */
+	if (bus->read_c45)
+		return __mdiobus_c45_read(bus, addr, dev, reg);
 
-	return ret;
-}
+	/* use c22 indirect access for MMD != 31 */
+	if (dev != MDIO_MMD_VEND2)
+		return __mmd_phy_read_indirect(bus, addr, dev, reg);
 
-static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
-			    u16 val)
-{
-	int ret;
+	/* MDIO_MMD_VEND2 registers need to be accessed in a different way */
+	page = reg >> 4;
+	reg = 0x10 | ((reg & 0xf) >> 1);
 
-	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_write(phydev, 0x10, val);
-		rtl821x_write_page(phydev, 0);
-	} else {
-		ret = -EOPNOTSUPP;
-	}
+	ret = rtl821x_write_page(phydev, page);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	ret = __phy_read(phydev, reg);
+	if (ret < 0)
+		return ret;
+
+	return rtl821x_write_page(phydev, 0) ?: ret;
 }
 
-static int rtl822x_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+static int rtlgen_write_mmd(struct phy_device *phydev, int dev, u16 reg,
+			    u16 val)
 {
-	int ret = rtlgen_read_mmd(phydev, devnum, regnum);
-
-	if (ret != -EOPNOTSUPP)
-		return ret;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+	int page, ret;
 
-	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE2) {
-		rtl821x_write_page(phydev, 0xa6e);
-		ret = __phy_read(phydev, 0x16);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_read(phydev, 0x12);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_read(phydev, 0x10);
-		rtl821x_write_page(phydev, 0);
-	}
+	/* use c45 access if MDIO bus supports them */
+	if (bus->write_c45)
+		return __mdiobus_c45_write(bus, addr, dev, reg, val);
 
-	return ret;
-}
+	/* use c22 indirect access for MMD != 31 */
+	if (dev != MDIO_MMD_VEND2)
+		return __mmd_phy_write_indirect(bus, addr, dev, reg, val);
 
-static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
-			     u16 val)
-{
-	int ret = rtlgen_write_mmd(phydev, devnum, regnum, val);
+	/* MDIO_MMD_VEND2 registers need to be accessed in a different way */
+	page = reg >> 4;
+	reg = 0x10 | ((reg & 0xf) >> 1);
 
-	if (ret != -EOPNOTSUPP)
+	ret = rtl821x_write_page(phydev, page);
+	if (ret < 0)
 		return ret;
 
-	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_write(phydev, 0x12, val);
-		rtl821x_write_page(phydev, 0);
-	}
+	ret = __phy_write(phydev, reg, val);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return rtl821x_write_page(phydev, 0) ?: ret;
 }
 
 static int rtl822x_get_features(struct phy_device *phydev)
@@ -993,8 +972,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc840),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
@@ -1005,8 +984,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
-- 
2.41.0


