Return-Path: <netdev+bounces-76888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BBD86F464
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4902C1C20AA8
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFEC13C;
	Sun,  3 Mar 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVzLWyOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87DBA30
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461741; cv=none; b=V7YsvR+a8ihwFdK+YcgCXDyxM0jrxKP7K7mGapOO21TUR7LNVb8A9HdUhTYqxKha1mT4z3DAQYXujfssIXEtXHoUfLO/OWey1BmT2+Rzj8axYst7kqGYDOg2//DTmHRixpS+B4heqJ44jwt1L9p61xPaOMRtC/1/czDeMMh5JzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461741; c=relaxed/simple;
	bh=HD2O05oz2qqFgSIPq9zduW+BZh1pUXN27sBxcbWI8Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvVdpFGTTAXbRaKIjLVhOCPqJObqpldmwWBTP7zWMzeQ0VL2R6dPW0jDtUWx3ctI8BiK9VxXdsIJUlUB2tTzpCn1CnLhdq+DqBQOwQvwVeEJYOhb+XnhoeWf4FxgQ9NkB4ecvfODEaX+s2aXZVvK3TGUt5y02gmRQi3GJ5M9wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVzLWyOH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso4551652a12.2
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461737; x=1710066537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrvd88NGpHW9F/V9li6Lki1iFZbuRCGFBdhBcqiBwBY=;
        b=jVzLWyOHiDUC/3V3fd69EUVley3Odr6y3qvXvY6NVNV+8TGmBsTh0DdbO4hhWcH9JE
         93rLW3uhFHSnA2UB8eZBABA2rBDrixHfaDc8KvKj4fgDl2+yzXdV5PCaB9lOHXGUV+ey
         S0je/Ps58PXqClUmbkiVAQAawOUreHtJaRIdvGaARjqmH5TXSMS7hsLKFftmZS9lW9RR
         bVIFmRMlPsuDtyQEuQNwrJJETRVUIYDkxbBIf8QpnBjJqbfejxJjiBXe6vrB0MaPHzgs
         f6vxsQSKTZUDiyDUpRQ2JL5pKgO+u1rI86Xd+RFWZ95C5eEsAaEQ30Ju4YzIFiUK3YbW
         e6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461737; x=1710066537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrvd88NGpHW9F/V9li6Lki1iFZbuRCGFBdhBcqiBwBY=;
        b=DArnwiaM+3/1/CseFwWBWV4M36TAvuq1axs3/5NtqLsm99RMRASPCFkg2F5bNJWIvL
         toWrhBwPkMOzEBzemXGF6rP9HNwf8moc8kaXyhR5rYloRLy+4F/Nu+EUZyyC3eDrK7Ik
         OMu77rVvMDybumDcnchAgmcTX6Ktv909AnAjVz9mUq7ldBM4qLT8g5OlxETAyz5hzAFm
         wYOavCXHKwZFYpoOWB2iwD/e/TxM0gMmSotQQcj5kYzckwGpKEF2zoh8/lEUjx/jqn+K
         tj1qRp3h5kA2BUBD02PhqNfRt0rknzIyzP0znaRzcWhSb1aLNJIHGFgPV54wDojFsPq+
         DzDQ==
X-Gm-Message-State: AOJu0Yw/iP9KqcB0TffaCwrjzQidXaTHeOy8VdhsTlaL5sMhvvXScWuv
	d1L7I1FIXzDBkis+oSEkwZtLuEthV06o1DUshftwgdpMqomXrLLv
X-Google-Smtp-Source: AGHT+IHbwhNZvCF4wReJl2rMlRJaWo2kcZnUEue2XHOnnZQaHj19rX/vNUQQxugfhoIBr/hS02BzIw==
X-Received: by 2002:a17:906:ca46:b0:a3f:2ef9:598a with SMTP id jx6-20020a170906ca4600b00a3f2ef9598amr4293349ejb.36.1709461737398;
        Sun, 03 Mar 2024 02:28:57 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:56 -0800 (PST)
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
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 3/7] net: phy: realtek: Add driver instances for rtl8221b/8251b via Clause 45
Date: Sun,  3 Mar 2024 11:28:44 +0100
Message-ID: <20240303102848.164108-4-ericwouds@gmail.com>
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

From: Marek Behún <kabel@kernel.org>

Collected from several commits in [PATCH net-next]
"Realtek RTL822x PHY rework to c45 and SerDes interface switching"

The instances are used by Clause 45 only accessible PHY's on several sfp
modules, which are using RollBall protocol.

Signed-off-by: Marek Behún <kabel@kernel.org>
[ Added matching functions to differentiate C45 instances ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 146 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index d7a47edd529e..f9a67761878e 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -64,6 +64,13 @@
 #define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
 #define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
 
+/* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
+ * is set, they cannot be accessed by C45-over-C22.
+ */
+#define RTL822X_VND2_GBCR				0xa412
+
+#define RTL822X_VND2_GANLPAR				0xa414
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -74,6 +81,9 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B_VB_CG				0x001cc849
+#define RTL_8221B_VN_CG				0x001cc84a
+#define RTL_8251B				0x001cc862
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -826,6 +836,56 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret, val;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	val = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+
+	/* Vendor register as C45 has no standardized support for 1000BaseT */
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, RTL822X_VND2_GBCR,
+				     ADVERTISE_1000FULL, val);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+static int rtl822x_c45_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Vendor register as C45 has no standardized support for 1000BaseT */
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   RTL822X_VND2_GANLPAR);
+		if (val < 0)
+			return val;
+
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	}
+
+	rtl822x_update_interface(phydev);
+
+	return 0;
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -849,6 +909,44 @@ static int rtl8226_match_phy_device(struct phy_device *phydev)
 	       rtlgen_supports_2_5gbps(phydev);
 }
 
+static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id, bool is_c45)
+{
+	if (phydev->is_c45)
+		return is_c45 && (id == phydev->c45_ids.device_ids[1]);
+	else
+		return !is_c45 && (id == phydev->phy_id);
+}
+
+static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
+}
+
+static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
+}
+
+static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
+}
+
+static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
+}
+
+static int rtl8251b_c22_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8251B, false);
+}
+
+static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8251B, true);
+}
+
 static int rtlgen_resume(struct phy_device *phydev)
 {
 	int ret = genphy_resume(phydev);
@@ -859,6 +957,15 @@ static int rtlgen_resume(struct phy_device *phydev)
 	return ret;
 }
 
+static int rtlgen_c45_resume(struct phy_device *phydev)
+{
+	int ret = genphy_c45_pma_resume(phydev);
+
+	msleep(20);
+
+	return ret;
+}
+
 static int rtl9000a_config_init(struct phy_device *phydev)
 {
 	phydev->autoneg = AUTONEG_DISABLE;
@@ -1134,8 +1241,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc849),
-		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_init    = rtl822x_config_init,
 		.get_rate_matching = rtl822x_get_rate_matching,
@@ -1146,8 +1253,17 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc84a),
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822x_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
+	}, {
+		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
@@ -1158,8 +1274,17 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc862),
-		.name           = "RTL8251B 5Gbps PHY",
+		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822x_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
+	}, {
+		.match_phy_device = rtl8251b_c22_match_phy_device,
+		.name           = "RTL8251B 5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
@@ -1169,6 +1294,15 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+	}, {
+		.match_phy_device = rtl8251b_c45_match_phy_device,
+		.name           = "RTL8251B 5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822x_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		= "RTL8366RB Gigabit Ethernet",
-- 
2.42.1


