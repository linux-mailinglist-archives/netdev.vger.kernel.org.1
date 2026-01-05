Return-Path: <netdev+bounces-247131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96465CF4C88
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2DD9302D3BF
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F422DF13F;
	Mon,  5 Jan 2026 16:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8333EB19;
	Mon,  5 Jan 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631150; cv=none; b=msPfTYOb5FX1ijkczqIVBKbyvjei62ezjd60eRReGrlLq8KQwjb2QSRKhrsCuO3ncapB/vq3VHW7mGcPO1XNHy00cAsiiR6s146LH8TwRbFPuRbC9iLxUAPDg0zyPhpylp/HlDUHbensMIjMZy1K92HiA4HZ+iB+CJ5YmJBMr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631150; c=relaxed/simple;
	bh=mH9EM+nJrI6TA5xmiiSyn7RwEUhqFst3KZoCwEpI2PE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXpRI5I0oY8IDwh9YsfEexDpOehl0mJ5pxzAAhzyN/uaUDepgsX17Qq5PNs5k/I6GQzE3AaVHNvgKOiyytWltP+L5AqBYnssW7T4+vvBxu1WK5+/gdMzcofDU8fnysCAs+ZcAYT0e2CMKyI7d3eLxyah58MfGHw/cJyM7gapm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcnbh-000000000zV-3GgE;
	Mon, 05 Jan 2026 16:39:01 +0000
Date: Mon, 5 Jan 2026 16:38:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
Message-ID: <25aab7f02dac7c6022171455523e3db1435b0881.1767630451.git.daniel@makrotopia.org>
References: <cover.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767630451.git.daniel@makrotopia.org>

RTL822x cannot access MDIO_MMD_VEND2 via MII_MMD_CTRL/MII_MMD_DATA. A
mapping to use paged access needs to be used instead. All other MMD
devices can be accessed as usual.

Implement phy_read_mmd and phy_write_mmd using paged access for
MDIO_MMD_VEND2 in Clause-22 mode instead of relying on
MII_MMD_CTRL/MII_MMD_DATA. This allows eg. rtl822x_config_aneg to work
as expected in case the MDIO bus doesn't support Clause-45 access.

Suggested-by: Bevan Weiss <bevan.weiss@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - use mmd_phy_read and mmd_phy_write
 - fix return value in on error (oldpage vs. ret)
 - fix wrong parameter name (reg vs. mmdreg)

 drivers/net/phy/realtek/realtek_main.c | 91 +++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 0653a9d8fcb6f..d1c7935a13acc 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/string_choices.h>
 
+#include "../phylib.h"
 #include "realtek.h"
 
 #define RTL8201F_IER				0x13
@@ -140,9 +141,8 @@
 #define   RTL822X_VND1_SERDES_INBAND_ENABLE	0x70d0
 #define RTL822X_VND1_SERDES_DATA		0x7589
 
-/* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
- * is set, they cannot be accessed by C45-over-C22.
- */
+#define RTL822X_VND2_TO_PAGE(reg)		((reg) >> 4)
+#define RTL822X_VND2_TO_PAGE_REG(reg)		(16 + (((reg) & GENMASK(3, 0)) >> 1))
 #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
 #define RTL8221B_VND2_INER			0xa4d2
@@ -1247,6 +1247,79 @@ static int rtl822x_probe(struct phy_device *phydev)
 	return 0;
 }
 
+/* RTL822x cannot access MDIO_MMD_VEND2 via MII_MMD_CTRL/MII_MMD_DATA.
+ * A mapping to use paged access needs to be used instead.
+ * All other MMD devices can be accessed as usual.
+ */
+static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
+{
+	int oldpage, ret, read_ret;
+	u16 page;
+
+	/* Use default method for all MMDs except MDIO_MMD_VEND2 or in case
+	 * Clause-45 access is available
+	 */
+	if (devnum != MDIO_MMD_VEND2 || phydev->is_c45)
+		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
+				    phydev->is_c45, devnum, reg);
+
+	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
+	page = RTL822X_VND2_TO_PAGE(reg);
+	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
+	if (oldpage < 0)
+		return oldpage;
+
+	if (oldpage != page) {
+		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	read_ret = __phy_read(phydev, RTL822X_VND2_TO_PAGE_REG(reg));
+	if (oldpage != page) {
+		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, oldpage);
+		if (ret < 0)
+			return ret;
+	}
+
+	return read_ret;
+}
+
+static int rtl822xb_write_mmd(struct phy_device *phydev, int devnum, u16 reg,
+			      u16 val)
+{
+	int oldpage, ret, write_ret;
+	u16 page;
+
+	/* Use default method for all MMDs except MDIO_MMD_VEND2 or in case
+	 * Clause-45 access is available
+	 */
+	if (devnum != MDIO_MMD_VEND2 || phydev->is_c45)
+		return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
+				     phydev->is_c45, devnum, reg, val);
+
+	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
+	page = RTL822X_VND2_TO_PAGE(reg);
+	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
+	if (oldpage < 0)
+		return oldpage;
+
+	if (oldpage != page) {
+		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	write_ret = __phy_write(phydev,  RTL822X_VND2_TO_PAGE_REG(reg), val);
+	if (oldpage != page) {
+		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, oldpage);
+		if (ret < 0)
+			return ret;
+	}
+
+	return write_ret;
+}
+
 static int rtl822x_set_serdes_option_mode(struct phy_device *phydev, bool gen1)
 {
 	bool has_2500, has_sgmii;
@@ -2150,6 +2223,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		.match_phy_device = rtl8221b_match_phy_device,
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
@@ -2164,6 +2239,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name		= "RTL8226-CG 2.5Gbps PHY",
@@ -2176,6 +2253,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtl822xb_c45_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtlgen_c45_resume,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name		= "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
@@ -2190,6 +2269,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
 		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
@@ -2205,6 +2286,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
 		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
@@ -2235,6 +2318,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822xb_read_mmd,
+		.write_mmd	= rtl822xb_write_mmd,
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
 		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
-- 
2.52.0

