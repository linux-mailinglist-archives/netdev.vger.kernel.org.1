Return-Path: <netdev+bounces-85981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE589D309
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB31C21090
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD27CF1A;
	Tue,  9 Apr 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9i5dCdR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DA7BB11
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647828; cv=none; b=cVNYw8Faz6b3Y9vQJhmW4/6tGz2+W7uYk9BeS81tz2TFLvxPaYgHmd9ZUYEMwGnTVpFI5F/gQPyGZvzWOnDbfrQCDmd40oUSuxYBkHhmkThwApLhyUrWYkFPjsm/LeigQHbP3EIa5SE7N9ZIR3XzoWgcWyzscUz3jbGMJmdwt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647828; c=relaxed/simple;
	bh=GFdJqQERxwf3ogjuKeJLFkZNfHbqAIUgRXfSk1CJh9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0cFB4aqpAR5mkrdDVaUGKSIHKxalN+L7E3EinhWK7y+2uYD4b4IbOe+y3P+YT/e7XMMJIGCgRVqIEAr75mqSB2Hpi5+LGNKdIQkRnqvcUjiO2iCzo6lBx3CwN7DiaLKbecT8nR+tQ4cIRuFjWZOcGYGs1Tsp09bf3tzpZrXruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9i5dCdR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51381021af1so8491972e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647825; x=1713252625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUGNrGMMaWToBXy+N/O6G9Hn7sqcj1wDeJzInv5qykk=;
        b=k9i5dCdRaCay/FnO8y5AGoTVJULFrA8W6Yedy/tUez+LSrTkv7MTpm2/DS1ShKFl6p
         waI4W5Z/pjhYyPq6oBlePeJBWxoMVJs9uOcEtB18Gt7MfYoP7t8XHR/LUbnfMiPD1Txz
         iagCKFzURSV3kI9XIZruKhsrUejR/2H1ES08v1epy0zzS1BQTedYZcE5wtPyQ1lyUk32
         hHamR+3SvAiA/etbhZyvtH9xRmw5YEW1gA1JvgwcDJRTX18P4ZWuqeH5kUKFqWNi26Bn
         JhOT1N4eUDLfAc518034Q6l7Yr+6T5JVW+geCMvxDcyor3uozqecbQ4v9ugC2mSb2Y9G
         +w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647825; x=1713252625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUGNrGMMaWToBXy+N/O6G9Hn7sqcj1wDeJzInv5qykk=;
        b=CMZd3Pis0J5zyELLaIK/bCmrPtDFKTYl4SXtyXPVN4jzMpirbOE1jnE5G3j8P2z8/I
         GkkWbLocq8mGMcOLFFnw/zqkmzjfiYqABGk+O2c6GDyo0uXgErpFMMiFoOUMiqcibFlv
         m6sxx+5S7Ud9wgPKEIf/KC4Z65Ipx3vreHBqXGAKGknnJhdS+wcUw6iOsNCwGqC7UoE2
         Q4rRQJQqLJpeGv5g3t/9j2x/QjNkEFdmIsSsAo06bRMy9t1vAhk0qnOhV1TsywQL6918
         3sZBEj4KcdZhwv4PB7iWtUqPagU4YzXIBdvvw3VANgt87OQfrTA7j9QppBdGFLzaKp2B
         r29A==
X-Gm-Message-State: AOJu0YwpZFeUusV4z/QoEdPqGlk0YoCtXMImMzmxh7Us2qUg7B8JHlWy
	lnk5o2QE7Tz48RuxEw82w6Ey4MLRAzdINEVaswHtexbsIfuZ6ONf
X-Google-Smtp-Source: AGHT+IEuFOR3lpSZczmbCpVbqVWTovkrx9ORnETTuGdyywgNKCju0Qzj+90IAONQ8DI+gseBvrYVog==
X-Received: by 2002:ac2:5636:0:b0:516:be9d:11ac with SMTP id b22-20020ac25636000000b00516be9d11acmr9873656lff.13.1712647824439;
        Tue, 09 Apr 2024 00:30:24 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:24 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 net-next 1/6] net: phy: realtek: configure SerDes mode for rtl822xb PHYs
Date: Tue,  9 Apr 2024 09:30:11 +0200
Message-ID: <20240409073016.367771-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
References: <20240409073016.367771-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Couzens <lynxis@fe80.eu>

The rtl8221b and rtl8226b series support switching SerDes mode between
2500base-x and sgmii based on the negotiated copper speed.

Configure this switching mode according to SerDes modes supported by
host.

There is an additional datasheet for RTL8226B/RTL8221B called
"SERDES MODE SETTING FLOW APPLICATION NOTE" where a sequence is
described to setup interface and rate adapter mode.

However, there is no documentation about the meaning of registers
and bits, it's literally just magic numbers and pseudo-code.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
[ refactored, dropped HiSGMII mode and changed commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
[ changed rtl822x_update_interface() to use vendor register ]
[ always fill in possible interfaces ]
[ only apply to rtl8221b and rtl8226b phy's ]
[ set phydev->rate_matching in .config_init() ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/realtek.c | 114 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 1fa70427b2a2..70cd1834a832 100644
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
 
@@ -659,6 +669,63 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return ret;
 }
 
+static int rtl822xb_config_init(struct phy_device *phydev)
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
+	if (has_2500 && !has_sgmii) {
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	} else {
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
+		phydev->rate_matching = RATE_MATCH_NONE;
+	}
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
@@ -695,6 +762,28 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, ret);
 }
 
+static void rtl822xb_update_interface(struct phy_device *phydev)
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
@@ -716,6 +805,19 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	return rtlgen_get_speed(phydev);
 }
 
+static int rtl822xb_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl822x_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	rtl822xb_update_interface(phydev);
+
+	return 0;
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -988,7 +1090,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
-		.read_status	= rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
@@ -1010,7 +1113,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
@@ -1020,7 +1124,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
@@ -1030,7 +1135,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
-- 
2.42.1


