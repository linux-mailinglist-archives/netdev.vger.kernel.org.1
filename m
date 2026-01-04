Return-Path: <netdev+bounces-246755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F6CF0F81
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF48300987A
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E3283FDF;
	Sun,  4 Jan 2026 13:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA248176;
	Sun,  4 Jan 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532317; cv=none; b=eC2cHD4gIN005TS3ibOtL9NZJS3YFSk6jXo5FBvwG6hHvevLBRVyK0EHhawnXl22aUqP/BSEwlELohMvo/wfbLsmnL1OhreERuSxmNHt71K20hvIOC1l4ZLZvAAFXDYIaRy+PonHPJrVCBoMPnmJ7lQaen2C95tJqwkY+QhkmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532317; c=relaxed/simple;
	bh=6pZQm5pyKF5ZGDG3QVZWOEC77tTyW89PzViemk3NNno=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqX+96uSQy4P/0z46kWguVu9KP1hOvXB62rEk5sZBFNL56uWglhv7RC5oTrn5075+UUwDuyjtb3calk9B057KhEgzX73gIFd1VeaOCHbvVXV0oNIiDWBYnUOVb2LF+GneiXOjIe3NN5BDUQhGN8uZxUhYxmRBxvKaC6JuKEb7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcNtf-000000003PD-1CFL;
	Sun, 04 Jan 2026 13:11:51 +0000
Date: Sun, 4 Jan 2026 13:11:48 +0000
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
Subject: [PATCH net-next 2/4] net: phy: realtek: implement configuring
 in-band an
Message-ID: <cd482df6f147eab867a40af497a662f6201cf5dc.1767531485.git.daniel@makrotopia.org>
References: <cover.1767531485.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767531485.git.daniel@makrotopia.org>

Implement the inband_caps() and config_inband() PHY driver methods to
allow configuring the use of in-band-status with SGMII and 2500Base-X on
RTL8226 and RTL8221B 2.5GE PHYs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek/realtek_main.c | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e42c5efbfa5ef..0653a9d8fcb6f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -131,6 +131,15 @@
 #define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
 #define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
 
+#define RTL822X_VND1_SERDES_CMD			0x7587
+#define  RTL822X_VND1_SERDES_CMD_WRITE		BIT(1)
+#define  RTL822X_VND1_SERDES_CMD_BUSY		BIT(0)
+#define RTL822X_VND1_SERDES_ADDR		0x7588
+#define  RTL822X_VND1_SERDES_ADDR_AUTONEG	0x2
+#define   RTL822X_VND1_SERDES_INBAND_DISABLE	0x71d0
+#define   RTL822X_VND1_SERDES_INBAND_ENABLE	0x70d0
+#define RTL822X_VND1_SERDES_DATA		0x7589
+
 /* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
  * is set, they cannot be accessed by C45-over-C22.
  */
@@ -1308,6 +1317,50 @@ static int rtl822xb_config_init(struct phy_device *phydev)
 	return rtl822x_set_serdes_option_mode(phydev, false);
 }
 
+static int rtl822x_serdes_write(struct phy_device *phydev, u16 reg, u16 val)
+{
+	int ret, poll;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_DATA, val);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CMD,
+			    RTL822X_VND1_SERDES_CMD_WRITE |
+			    RTL822X_VND1_SERDES_CMD_BUSY);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					 RTL822X_VND1_SERDES_CMD, poll,
+					 !(poll & RTL822X_VND1_SERDES_CMD_BUSY),
+					 500, 100000, false);
+}
+
+static int rtl822x_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	return rtl822x_serdes_write(phydev, RTL822X_VND1_SERDES_ADDR_AUTONEG,
+				    (modes != LINK_INBAND_DISABLE) ?
+				    RTL822X_VND1_SERDES_INBAND_ENABLE :
+				    RTL822X_VND1_SERDES_INBAND_DISABLE);
+}
+
+static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+	default:
+		return 0;
+	}
+}
+
 static int rtl822xb_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
@@ -2103,6 +2156,8 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
@@ -2116,6 +2171,8 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
 		.config_init	= rtl822x_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.read_status	= rtl822xb_c45_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtlgen_c45_resume,
@@ -2125,6 +2182,8 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
@@ -2138,6 +2197,8 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
@@ -2151,6 +2212,8 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
@@ -2164,6 +2227,8 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
@@ -2177,6 +2242,8 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
 		.config_init	= rtl822xb_config_init,
+		.inband_caps	= rtl822x_inband_caps,
+		.config_inband	= rtl822x_config_inband,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
-- 
2.52.0

