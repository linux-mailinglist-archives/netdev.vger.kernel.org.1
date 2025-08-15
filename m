Return-Path: <netdev+bounces-214001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB6B27ACD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1CE1C8790B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4723FC66;
	Fri, 15 Aug 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="jvOZxmi7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957F1FC0F0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246047; cv=none; b=IyNsCZat2YLHnOrLpAJLnK9YOw/VbnU48PN7sPNZSUMRFI2NqWh1C0Rb4Vf8h/xNI0MMfpsS6BFDijVjnr65VzygDfVohdhS2KGyQBBwyUjeGcd4cU0iJRmjLL01RuV88GAK3oaVfdhzAIOSTo50YBAilone3pvsx0tkwTh/pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246047; c=relaxed/simple;
	bh=YsWETRXwLsrLOcXH3DupIuLZELW/r8FKv5zPHazyH8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW/VHVjLv0H0b1QsHvpwyDXA0HkaiMLaL/ss83Y4fvpVhqyJQwMZwQ1+R6bJcQYqrrjor0S1PnZ/XS6guDfB5RG7PaK98QsUx0VoPpKS1voIXWdIMiGKztRP69AicI7a+sE+CAdgpft5j0+lr/XLF0j7AbmdZrQAqJeCXyF2jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=jvOZxmi7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755246023; x=1755850823;
	i=markus.stockhausen@gmx.de;
	bh=X/jNrm/FtNa5FOo/g0ES5OBhaB+p+tOlDySfSRZVF3U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jvOZxmi7VlRYASq44oYmAwdAhlW3JTc/qtb1ciI7KViHoZ5CIpfSDtRwkAoPRExp
	 Uf2PkcCBggFVlOM/pf5TyzcEx9T/nColhKt9fhhL+koP84UjGwFejw7K9pwBmY4Te
	 ORxZjZLClK1KGACGloxePCHMKYYJ+O9MYmmH09SlFWgBQgUm/Hi7eMjr3cZ+68Yhy
	 +2gvR1pa32RXed5gwInLD9xMaMrsH/0u1a1/gm4GRD4TqytnGfGxL8pvypokz8hSG
	 NsDI2atdLY34bAfATAqtgIipkfvPSDhTHNUC8Xl04USEukk7P9P5tn3MpaPO1HkxE
	 SMOPMozjJklfgLduyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1uCfNC1NHJ-00bk90; Fri, 15
 Aug 2025 10:20:23 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	daniel@makrotopia.org,
	netdev@vger.kernel.org,
	jan@3e8.eu
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next] net: phy: realtek: enable serdes option mode for RTL8226-CG
Date: Fri, 15 Aug 2025 04:20:09 -0400
Message-ID: <20250815082009.3678865-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sgQUxqOINK0bCYit/fmEnVJmungM3cW4fupOLmMYXn0PSgulyAE
 vVzafkbY2coaX2BjnCdCWnHxWmftA/WtlX/G9fd6bnvmd/ZpC5Y1yFIPYBaND5LSGIKLIZL
 E3wTt5N5nLNxStz+fjSGdcSKkjZnA6FtDPs/kQrN+VjT1hEXQI8n2n4IikLMd3pJb3OGHT2
 V9ISh4h1qmfF6r+g0a3ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:smCO/PTn6ok=;NSTCYTCxAlMrVSLz5+OqucL69gf
 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
 1vyjUVlkowougjaqkL8ZiMsliSnP

The RTL8226-CG can make use of the serdes option mode feature to
dynamically switch between SGMII and 2500base-X. From what is
known the setup sequence is much simpler with no magic values.

Convert the exiting config_init() into a helper that configures
the PHY depending on generation 1 or 2. Call the helper from two
separated new config_init() functions.

Finally convert the phy_driver specs of the RTL8226-CG to make
use of the new configuration and switch over to the extended
read_status() function to dynamically change the interface
according to the serdes mode.

Remark! The logic could be simpler if the serdes mode could be
set before all other generation 2 magic values. Due to missing
RTL8221B test hardware the mmd command order was kept.

Tested on Zyxel XGS1210-12.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/realtek/realtek_main.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/real=
tek/realtek_main.c
index a7541899e327..acc44de54270 100644
=2D-- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1038,7 +1038,7 @@ static int rtl822x_probe(struct phy_device *phydev)
 	return 0;
 }
=20
-static int rtl822xb_config_init(struct phy_device *phydev)
+static int rtl822x_set_serdes_option_mode(struct phy_device *phydev, bool=
 gen1)
 {
 	bool has_2500, has_sgmii;
 	u16 mode;
@@ -1073,15 +1073,18 @@ static int rtl822xb_config_init(struct phy_device =
*phydev)
 	/* the following sequence with magic numbers sets up the SerDes
 	 * option mode
 	 */
-	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
-	if (ret < 0)
-		return ret;
+
+	if (!gen1) {
+		ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
+		if (ret < 0)
+			return ret;
+	}
=20
 	ret =3D phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
 				     RTL822X_VND1_SERDES_OPTION,
 				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
 				     mode);
-	if (ret < 0)
+	if (gen1 || ret < 0)
 		return ret;
=20
 	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
@@ -1095,6 +1098,16 @@ static int rtl822xb_config_init(struct phy_device *=
phydev)
 	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
 }
=20
+static int rtl822x_config_init(struct phy_device *phydev)
+{
+	return rtl822x_set_serdes_option_mode(phydev, true);
+}
+
+static int rtl822xb_config_init(struct phy_device *phydev)
+{
+	return rtl822x_set_serdes_option_mode(phydev, false);
+}
+
 static int rtl822xb_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
@@ -1693,7 +1706,8 @@ static struct phy_driver realtek_drvs[] =3D {
 		.soft_reset     =3D rtl822x_c45_soft_reset,
 		.get_features   =3D rtl822x_c45_get_features,
 		.config_aneg    =3D rtl822x_c45_config_aneg,
-		.read_status    =3D rtl822x_c45_read_status,
+		.config_init    =3D rtl822x_config_init,
+		.read_status    =3D rtl822xb_c45_read_status,
 		.suspend        =3D genphy_c45_pma_suspend,
 		.resume         =3D rtlgen_c45_resume,
 	}, {
=2D-=20
2.47.0


