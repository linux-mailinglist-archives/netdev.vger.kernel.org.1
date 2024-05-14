Return-Path: <netdev+bounces-96353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0018C5624
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77454B2153A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD74C6E619;
	Tue, 14 May 2024 12:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [194.37.255.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D46430;
	Tue, 14 May 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690751; cv=none; b=YNylX59ksyOi2C+GeKopg8DOc/iT6t2Jb7ea2UGzyh2IluyqG0UuThWhd9VohMisWByILapI2SrjIJe24486NTOWjqTou5UabiEkz7vZjmaal4h2Lj+eCjEmaXfhnsaRNW76/Yc4644KXoJUWwhzt80ygKVfPkU7fNFVHH7yhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690751; c=relaxed/simple;
	bh=NLL4HBEiAyQkrN0runhZY+Wcah1jVOEAdXj+xW2bWBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2G2thJK82Mfc0XUrYN+Fzuu5Z5DmX/c3YrHglb1pedUrioIg26fe3gWqsmBhYm09/xcmDfU0tUESlXKyzt7/V7f4HCAl4fZhXCFtHwEpJmO9rSMjvfOsb6Ylvw8vGh45pHXpyqTSWP0ssXIpzYM+z03HpWjcZ+8uuzVRenCOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=194.37.255.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1s6rH4-001y82-GG; Tue, 14 May 2024 14:28:54 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1s6rH3-00H5xj-7Z; Tue, 14 May 2024 14:28:53 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 8A044CA5AA8;
	Tue, 14 May 2024 14:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 7B112CA5AF6;
	Tue, 14 May 2024 14:28:52 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id we7DMOYIUk4Z; Tue, 14 May 2024 14:28:52 +0200 (CEST)
Received: from ew-linux.ew (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id 62877CA5AA8;
	Tue, 14 May 2024 14:28:52 +0200 (CEST)
From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
Date: Tue, 14 May 2024 14:27:28 +0200
Message-Id: <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1715689734-04F54B7C-E8CD99F5/0/0

The PHY supports multiple modes of which not all are properly
implemented by the driver. In the case of the RGMII-to-SGMII and
1000BASE-X modes, this was primarily due to the use of non-standard
registers for auto-negotiation settings and link status. This patch adds
device-specific get_features(), config_aneg(), aneg_done(), and
read_status() functions for these modes. They are based on the genphy_*
versions with the correct registers and fall back to the genphy_*
versions for other modes.

The RGMII-to-SGMII mode is special, because the chip does not really act
as a PHY in this mode but rather as a bridge. It requires a connected
SGMII PHY and gets the negotiated speed and duplex from it through SGMII
auto-negotiation. To use the DP83869 as a virtual PHY, we assume that
the connected SGMII PHY supports 10/100/1000M half/full duplex and
therefore support and always advertise those settings.

Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
---
 drivers/net/phy/dp83869.c | 391 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 387 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index d248a13c1749..cc7a9889829e 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -42,6 +42,9 @@
 #define DP83869_IO_MUX_CFG	0x0170
 #define DP83869_OP_MODE		0x01df
 #define DP83869_FX_CTRL		0x0c00
+#define DP83869_FX_STS		0x0c01
+#define DP83869_FX_ANADV	0x0c04
+#define DP83869_FX_LPABL	0x0c05
=20
 #define DP83869_SW_RESET	BIT(15)
 #define DP83869_SW_RESTART	BIT(14)
@@ -116,6 +119,39 @@
 #define DP83869_OP_MODE_MII			BIT(5)
 #define DP83869_SGMII_RGMII_BRIDGE		BIT(6)
=20
+/* FX_CTRL bits */
+#define DP83869_CTRL0_SPEED_SEL_MSB		BIT(6)
+#define DP83869_CTRL0_DUPLEX_MODE		BIT(8)
+#define DP83869_CTRL0_RESTART_AN		BIT(9)
+#define DP83869_CTRL0_ISOLATE			BIT(10)
+#define DP83869_CTRL0_PWRDN			BIT(11)
+#define DP83869_CTRL0_ANEG_EN			BIT(12)
+#define DP83869_CTRL0_SPEED_SEL_LSB		BIT(13)
+#define DP83869_CTRL0_LOOPBACK			BIT(14)
+
+/* FX_STS bits */
+#define DP83869_STTS_LINK_STATUS		BIT(2)
+#define DP83869_STTS_ANEG_COMPLETE		BIT(5)
+
+/* FX_ANADV bits */
+#define DP83869_BP_FULL_DUPLEX			BIT(5)
+#define DP83869_BP_HALF_DUPLEX			BIT(6)
+#define DP83869_BP_PAUSE			BIT(7)
+#define DP83869_BP_ASYMMETRIC_PAUSE		BIT(8)
+
+/* FX_LPABL bits
+ * Bits 12:10 for RGMII-to-SGMII mode are undocumented and were determin=
ed
+ * through tests. It appears that, in this mode, the tx_config_Reg defin=
ed in
+ * the SGMII spec is copied to FX_LPABL after SGMII auto-negotiation.
+ */
+#define DP83869_LP_ABILITY_FULL_DUPLEX		BIT(5)
+#define DP83869_LP_ABILITY_PAUSE		BIT(7)
+#define DP83869_LP_ABILITY_ASYMMETRIC_PAUSE	BIT(8)
+#define DP83869_LP_ABILITY_SGMII_100		BIT(10)
+#define DP83869_LP_ABILITY_SGMII_1000		BIT(11)
+#define DP83869_LP_ABILITY_SGMII_DUPLEX		BIT(12)
+#define DP83869_LP_ABILITY_ACK			BIT(14)
+
 /* RXFCFG bits*/
 #define DP83869_WOL_MAGIC_EN		BIT(0)
 #define DP83869_WOL_PATTERN_EN		BIT(1)
@@ -154,19 +190,319 @@ struct dp83869_private {
 	int mode;
 };
=20
+static int dp83869_fx_setup_forced(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+	u16 ctl =3D 0;
+
+	phydev->pause =3D 0;
+	phydev->asym_pause =3D 0;
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE)
+		ctl |=3D DP83869_CTRL0_SPEED_SEL_MSB;
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE) {
+		if (phydev->speed =3D=3D SPEED_1000)
+			ctl |=3D DP83869_CTRL0_SPEED_SEL_MSB;
+		else if (phydev->speed =3D=3D SPEED_100)
+			ctl |=3D DP83869_CTRL0_SPEED_SEL_LSB;
+
+		/* Contrary to the data sheet, there is NO need to clear
+		 * 10M_SGMII_RATE_ADAPT_DISABLE in 10M_SGMII_CFG for 10M SGMII.
+		 */
+	}
+
+	if (phydev->duplex =3D=3D DUPLEX_FULL)
+		ctl |=3D DP83869_CTRL0_DUPLEX_MODE;
+
+	return phy_modify_mmd(phydev, DP83869_DEVADDR, DP83869_FX_CTRL,
+			      ~(u16)(DP83869_CTRL0_LOOPBACK |
+				      DP83869_CTRL0_ISOLATE |
+				      DP83869_CTRL0_PWRDN), ctl);
+}
+
+static int dp83869_fx_config_advert(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+	int err, changed =3D 0;
+	u32 adv =3D 0;
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE) {
+		linkmode_and(phydev->advertising, phydev->advertising,
+			     phydev->supported);
+
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				      phydev->advertising))
+			adv |=3D DP83869_BP_FULL_DUPLEX;
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				      phydev->advertising))
+			adv |=3D DP83869_BP_PAUSE;
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				      phydev->advertising))
+			adv |=3D DP83869_BP_ASYMMETRIC_PAUSE;
+	}
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE) {
+		/* As we cannot control the connected SGMII PHY, we force
+		 * advertising all speeds.
+		 */
+		linkmode_copy(phydev->advertising, phydev->supported);
+		adv |=3D DP83869_BP_HALF_DUPLEX;
+		adv |=3D DP83869_BP_FULL_DUPLEX;
+	}
+
+	err =3D phy_modify_mmd_changed(phydev, DP83869_DEVADDR, DP83869_FX_ANAD=
V,
+				     DP83869_BP_HALF_DUPLEX |
+				     DP83869_BP_FULL_DUPLEX | DP83869_BP_PAUSE |
+				     DP83869_BP_ASYMMETRIC_PAUSE, adv);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		changed =3D 1;
+
+	return changed;
+}
+
+static int dp83869_fx_restart_aneg(struct phy_device *phydev)
+{
+	return phy_modify_mmd(phydev, DP83869_DEVADDR, DP83869_FX_CTRL,
+			      DP83869_CTRL0_ISOLATE, DP83869_CTRL0_ANEG_EN |
+			      DP83869_CTRL0_RESTART_AN);
+}
+
+static int dp83869_fx_check_and_restart_aneg(struct phy_device *phydev,
+					     bool restart)
+{
+	int ret;
+
+	if (!restart) {
+		ret =3D phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_CTRL);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & DP83869_CTRL0_ANEG_EN) ||
+		    (ret & DP83869_CTRL0_ISOLATE))
+			restart =3D true;
+	}
+
+	if (restart)
+		return dp83869_fx_restart_aneg(phydev);
+
+	return 0;
+}
+
+static int dp83869_config_aneg(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+	bool changed =3D false;
+	int err;
+
+	if (dp83869->mode !=3D DP83869_RGMII_1000_BASE &&
+	    dp83869->mode !=3D DP83869_RGMII_SGMII_BRIDGE)
+		return genphy_config_aneg(phydev);
+
+	if (phydev->autoneg !=3D AUTONEG_ENABLE)
+		return dp83869_fx_setup_forced(phydev);
+
+	err =3D dp83869_fx_config_advert(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed =3D true;
+
+	return dp83869_fx_check_and_restart_aneg(phydev, changed);
+}
+
+static int dp83869_aneg_done(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE ||
+	    dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE) {
+		int retval =3D phy_read_mmd(phydev, DP83869_DEVADDR,
+					  DP83869_FX_STS);
+
+		return (retval < 0) ? retval :
+				      (retval & DP83869_STTS_ANEG_COMPLETE);
+	} else {
+		return genphy_aneg_done(phydev);
+	}
+}
+
+static int dp83869_fx_update_link(struct phy_device *phydev)
+{
+	int status =3D 0, fx_ctrl;
+
+	fx_ctrl =3D phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_CTRL);
+	if (fx_ctrl < 0)
+		return fx_ctrl;
+
+	if (fx_ctrl & DP83869_CTRL0_RESTART_AN)
+		goto done;
+
+	if (!phy_polling_mode(phydev) || !phydev->link) {
+		status =3D phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_STS);
+		if (status < 0)
+			return status;
+		else if (status & DP83869_STTS_LINK_STATUS)
+			goto done;
+	}
+
+	status =3D phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_STS);
+	if (status < 0)
+		return status;
+ done:
+	phydev->link =3D status & DP83869_STTS_LINK_STATUS ? 1 : 0;
+	phydev->autoneg_complete =3D status & DP83869_STTS_ANEG_COMPLETE ? 1 : =
0;
+
+	if (phydev->autoneg =3D=3D AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link =3D 0;
+
+	return 0;
+}
+
+static int dp83869_1000basex_read_lpa(struct phy_device *phydev)
+{
+	int fx_lpabl;
+
+	if (phydev->autoneg =3D=3D AUTONEG_ENABLE) {
+		if (!phydev->autoneg_complete) {
+			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
+							0);
+			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+					 phydev->lp_advertising, 0);
+			return 0;
+		}
+
+		fx_lpabl =3D phy_read_mmd(phydev, DP83869_DEVADDR,
+					DP83869_FX_LPABL);
+		if (fx_lpabl < 0)
+			return fx_lpabl;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				 phydev->lp_advertising,
+				 fx_lpabl & DP83869_LP_ABILITY_FULL_DUPLEX);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising,
+				 fx_lpabl & DP83869_LP_ABILITY_PAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->lp_advertising,
+				 fx_lpabl &
+				 DP83869_LP_ABILITY_ASYMMETRIC_PAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->lp_advertising,
+				 fx_lpabl & DP83869_LP_ABILITY_ACK);
+
+	} else {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	return 0;
+}
+
+static int dp83869_fx_read_status_fixed(struct phy_device *phydev)
+{
+	int fx_ctrl =3D phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_CTRL);
+
+	if (fx_ctrl < 0)
+		return fx_ctrl;
+
+	if (fx_ctrl & DP83869_CTRL0_DUPLEX_MODE)
+		phydev->duplex =3D DUPLEX_FULL;
+	else
+		phydev->duplex =3D DUPLEX_HALF;
+
+	if (fx_ctrl & DP83869_CTRL0_SPEED_SEL_MSB)
+		phydev->speed =3D SPEED_1000;
+	else if (fx_ctrl & DP83869_CTRL0_SPEED_SEL_LSB)
+		phydev->speed =3D SPEED_100;
+	else
+		phydev->speed =3D SPEED_10;
+
+	return 0;
+}
+
+static int dp83869_fx_read_status(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+	int err, old_link =3D phydev->link;
+
+	err =3D dp83869_fx_update_link(phydev);
+	if (err)
+		return err;
+
+	if (phydev->autoneg =3D=3D AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->master_slave_get =3D MASTER_SLAVE_CFG_UNSUPPORTED;
+	phydev->master_slave_state =3D MASTER_SLAVE_STATE_UNSUPPORTED;
+	phydev->speed =3D SPEED_UNKNOWN;
+	phydev->duplex =3D DUPLEX_UNKNOWN;
+	phydev->pause =3D 0;
+	phydev->asym_pause =3D 0;
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE) {
+		err =3D dp83869_1000basex_read_lpa(phydev);
+		if (err < 0)
+			return err;
+
+		if (phydev->autoneg =3D=3D AUTONEG_ENABLE &&
+		    phydev->autoneg_complete) {
+			phy_resolve_aneg_linkmode(phydev);
+		} else if (phydev->autoneg =3D=3D AUTONEG_DISABLE) {
+			err =3D dp83869_fx_read_status_fixed(phydev);
+			if (err < 0)
+				return err;
+		}
+	} else if (dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE) {
+		if (phydev->autoneg =3D=3D AUTONEG_ENABLE &&
+		    phydev->autoneg_complete) {
+			int fx_lpabl;
+
+			fx_lpabl =3D phy_read_mmd(phydev, DP83869_DEVADDR,
+						DP83869_FX_LPABL);
+			if (fx_lpabl < 0)
+				return fx_lpabl;
+
+			if (fx_lpabl & DP83869_LP_ABILITY_SGMII_1000)
+				phydev->speed =3D SPEED_1000;
+			else if (fx_lpabl & DP83869_LP_ABILITY_SGMII_100)
+				phydev->speed =3D SPEED_100;
+			else
+				phydev->speed =3D SPEED_10;
+
+			if (fx_lpabl & DP83869_LP_ABILITY_SGMII_DUPLEX)
+				phydev->duplex =3D DUPLEX_FULL;
+			else
+				phydev->duplex =3D DUPLEX_HALF;
+		} else if (phydev->autoneg =3D=3D AUTONEG_DISABLE) {
+			err =3D dp83869_fx_read_status_fixed(phydev);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int dp83869_read_status(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869 =3D phydev->priv;
 	int ret;
=20
-	ret =3D genphy_read_status(phydev);
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE ||
+	    dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE)
+		ret =3D dp83869_fx_read_status(phydev);
+	else
+		ret =3D genphy_read_status(phydev);
+
 	if (ret)
 		return ret;
=20
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) =
{
+	if (dp83869->mode =3D=3D DP83869_RGMII_100_BASE) {
 		if (phydev->link) {
-			if (dp83869->mode =3D=3D DP83869_RGMII_100_BASE)
-				phydev->speed =3D SPEED_100;
+			phydev->speed =3D SPEED_100;
 		} else {
 			phydev->speed =3D SPEED_UNKNOWN;
 			phydev->duplex =3D DUPLEX_UNKNOWN;
@@ -780,6 +1116,7 @@ static int dp83869_configure_mode(struct phy_device =
*phydev,
=20
 		break;
 	case DP83869_RGMII_1000_BASE:
+		break;
 	case DP83869_RGMII_100_BASE:
 		ret =3D dp83869_configure_fiber(phydev, dp83869);
 		break;
@@ -874,6 +1211,49 @@ static int dp83869_probe(struct phy_device *phydev)
 	return dp83869_config_init(phydev);
 }
=20
+static int dp83869_get_features(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 =3D phydev->priv;
+	int err;
+
+	err =3D genphy_read_abilities(phydev);
+	if (err)
+		return err;
+
+	/* The PHY reports all speeds (10/100/1000BASE-T full/half-duplex and
+	 * 1000BASE-X) as supported independent of the selected mode. We clear
+	 * the settings that are nonsensical for each mode.
+	 */
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_SGMII_BRIDGE) {
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	}
+
+	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_MII_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				   phydev->supported);
+	}
+
+	return 0;
+}
+
 static int dp83869_phy_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -896,10 +1276,13 @@ static int dp83869_phy_reset(struct phy_device *ph=
ydev)
 	PHY_ID_MATCH_MODEL(_id),				\
 	.name		=3D (_name),				\
 	.probe          =3D dp83869_probe,			\
+	.get_features	=3D dp83869_get_features,			\
 	.config_init	=3D dp83869_config_init,			\
 	.soft_reset	=3D dp83869_phy_reset,			\
 	.config_intr	=3D dp83869_config_intr,			\
 	.handle_interrupt =3D dp83869_handle_interrupt,		\
+	.config_aneg	=3D dp83869_config_aneg,			\
+	.aneg_done	=3D dp83869_aneg_done,			\
 	.read_status	=3D dp83869_read_status,			\
 	.get_tunable	=3D dp83869_get_tunable,			\
 	.set_tunable	=3D dp83869_set_tunable,			\
--=20
2.34.1


