Return-Path: <netdev+bounces-76886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF186F462
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68271C209A2
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296BBA39;
	Sun,  3 Mar 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dic6PhRr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1AB665
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461739; cv=none; b=VPFCbGA7RhwCiZhSCTmt7PDx/aGdLDGlrlImPaVLu7FAC6JjuocR9sQXM86/K8uZPBOsHkgoBzO3yCCMET+hsf+PHKhvN4YWYrt0Mc+k738ARPw7q8qv8cTIzmUkQOIq6r0MZGkyzN5AiT8YtqiksnjHQcEzOghkytKI1Yc2WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461739; c=relaxed/simple;
	bh=siq6HOhSzEeNzB/JB+C87MyjxsVd3QW2Jm2KK7FCco8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+/6MmXQXfLikXktO28NosjmcozXGAl8qvEfB5ZD7scKiMMmmC8zfwKaJ4U2lDD+vvyljW8oTVLZ+q+HDPlQk3TWA+Ge9n0uGrqwxMaS5L0DDnBTgJLic9tt7fhy0eRIFKicEe/dD/XK8sU2bo2VIdGe8Lu7g1jDCKhPbYeTQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dic6PhRr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so646307066b.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461736; x=1710066536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ9HJaWD1Pl24OreY0kE11jDzhnsbKVm9cmv5C826xA=;
        b=dic6PhRrGfux4jH4uvBal3bPm5e9/Jfm0KczNvMEBLt0/iQCSDnkb3UR/10dLp98us
         kCRYZurrP5eJ1fri1yGAcnxGrPg7QRovdGP3ErWU6XjI0WRzOCcMVEHK1ny7P7BQF8lF
         niUqKfjm+XgpykEIzcPf3XBNqHR4NmguApl2GwJ0uwA/GDmlVcY2qQASyzBkgyIBlO3D
         MzGEU0RvjqzcdKCNjn1JZa7PDofnvHNoVvyi7Iwsp20V70d4CV/Q6kr0A00K0XA7Aron
         h9+TwpE4Rh4PoYieb8y02ySIe7Y5xS+cM1RgRCCzp8Vz0uCEM7WGWyN4p3SUm3urlO+4
         VGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461736; x=1710066536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ9HJaWD1Pl24OreY0kE11jDzhnsbKVm9cmv5C826xA=;
        b=m5uaRTk4RhVhwwsUigc2QC4haTnPHI2V8wFeeNTooL+REG/r3gpHcH9ljDPx5hXsAn
         BH/OK+mvHJtWh/iypuJC0K/0pY2oHYmVj7nwYX9a5ZptCPOO2QOlONjHuPYLOJGIVCsE
         vizP4/mR0Y6AndkmM3+0+E4gn35prs+Y8E4uqZUD06rAp9LeOwvyuOmgBp38Q7TNHlYe
         oDVQfw1Ajl+7s6cP6V5U4mBO34S8gfi/ECgDZuQER86oxDzsn5K8TXEOYqt1iuNFPXpF
         +t9nU/Wc0dr4Obsobdw8nr61hjgH+UsGssgXb48iBDTg7h2Gf02xmuUuC/Z2lVUV4/z5
         9q1w==
X-Gm-Message-State: AOJu0YzgYDfyyqh4qBVI0H5M4DMTR1+8fkc7E/rlhrm8eVOgZD+ATrvc
	QSFNrOTCeFjMsW0Shf5BkDxr9UKxMbno4JGZ2U4zfU7smZGELzw4
X-Google-Smtp-Source: AGHT+IExfODGtuTuQHq4/nFEtKUTpnfuJa0WrwKrcM8t8eVDRZ7oU3UjDWH1e+gf27mo+OH7XJMVdQ==
X-Received: by 2002:a17:906:c411:b0:a44:7edf:e6bb with SMTP id u17-20020a170906c41100b00a447edfe6bbmr3969357ejz.37.1709461735454;
        Sun, 03 Mar 2024 02:28:55 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:54 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode for rtl822x/8251b PHYs
Date: Sun,  3 Mar 2024 11:28:42 +0100
Message-ID: <20240303102848.164108-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240303102848.164108-1-ericwouds@gmail.com>
References: <20240303102848.164108-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Couzens <lynxis@fe80.eu>

The rtl822x series and rtl8251b support switching SerDes mode between
2500base-x and sgmii based on the negotiated copper speed.

Configure this switching mode according to SerDes modes supported by
host.

There is an additional datasheet for RTL8226B/RTL8221B called
"SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
setup interface and rate adapter mode.

However, there is no documentation about the meaning of registers
and bits, it's literally just magic numbers and pseudo-code.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
[ refactored, dropped HiSGMII mode and changed commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
[ changed rtl822x_update_interface() to use vendor register ]
[ always fill in possible interfaces ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 99 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 1fa70427b2a2..8a876e003774 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -54,6 +54,16 @@
 						 RTL8201F_ISR_LINK)
 #define RTL8201F_IER				0x13
 
+#define RTL822X_VND1_SERDES_OPTION			0x697a
+#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX		2
+
+#define RTL822X_VND1_SERDES_CTRL3			0x7580
+#define RTL822X_VND1_SERDES_CTRL3_MODE_MASK		GENMASK(5, 0)
+#define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
+#define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -659,6 +669,60 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return ret;
 }
 
+static int rtl822x_config_init(struct phy_device *phydev)
+{
+	bool has_2500, has_sgmii;
+	u16 mode;
+	int ret;
+
+	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    phydev->host_interfaces) ||
+		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
+
+	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
+			     phydev->host_interfaces) ||
+		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
+
+	/* fill in possible interfaces */
+	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
+		     has_2500);
+	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
+		     has_sgmii);
+
+	if (!has_2500 && !has_sgmii)
+		return 0;
+
+	/* determine SerDes option mode */
+	if (has_2500 && !has_sgmii)
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
+	else
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
+
+	/* the following sequence with magic numbers sets up the SerDes
+	 * option mode
+	 */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
+				     RTL822X_VND1_SERDES_OPTION,
+				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
+				     mode);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
+}
+
 static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
@@ -695,6 +759,28 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, ret);
 }
 
+static void rtl822x_update_interface(struct phy_device *phydev)
+{
+	int val;
+
+	if (!phydev->link)
+		return;
+
+	/* Change interface according to serdes mode */
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CTRL3);
+	if (val < 0)
+		return;
+
+	switch (val & RTL822X_VND1_SERDES_CTRL3_MODE_MASK) {
+	case RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX:
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		break;
+	case RTL822X_VND1_SERDES_CTRL3_MODE_SGMII:
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		break;
+	}
+}
+
 static int rtl822x_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -709,11 +795,13 @@ static int rtl822x_read_status(struct phy_device *phydev)
 						  lpadv);
 	}
 
-	ret = genphy_read_status(phydev);
+	ret = rtlgen_read_status(phydev);
 	if (ret < 0)
 		return ret;
 
-	return rtlgen_get_speed(phydev);
+	rtl822x_update_interface(phydev);
+
+	return 0;
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
@@ -976,6 +1064,7 @@ static struct phy_driver realtek_drvs[] = {
 		.match_phy_device = rtl8226_match_phy_device,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -988,6 +1077,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1000,6 +1090,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1010,6 +1101,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1019,6 +1111,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
+		.config_init    = rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1030,6 +1123,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1040,6 +1134,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8251B 5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1


