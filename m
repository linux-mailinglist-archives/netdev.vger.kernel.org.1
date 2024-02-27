Return-Path: <netdev+bounces-75210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E5868A39
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518871C21D10
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF65647B;
	Tue, 27 Feb 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWLrJQcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC556441
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020338; cv=none; b=RxmCXkVLfFPRgePvUCrkB/ejpAEPzXsrUndZMftf0kByBM09AcLGv83SUI9v63zxo/Z3GT51SOci09gUAW+KeNfASO8DKIE1k37g6tpAdYczQGYYOwQvsn7H01Kt2bPa+Thk1jKHXaWsAUvkJZYaUU9nqQ70uwVPzV0XBh0DgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020338; c=relaxed/simple;
	bh=VIGHiCdx7SNXX7Nu6+QrVq5iUlV4cziKIYKF/N3cJvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7mYJ0WAP1yChPHAP2AVqaJmuXZJKAMU5D3VLKUTpSeLXaPBYKpG+KrQuFu2bu2v9EtjIoSNx1o/IHsk1EIoKYCnL8sW4wlTKXuYy9TzwFfCj7hT+fLXjnIRGcW/LL4x1niL7U+EefkmsSag5YBxbBIRyllTRbFnQ3HRmAlvOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWLrJQcg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so152232a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020335; x=1709625135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIaNztM01O7/22vlhTB8ChN0VbTm6XWSFtGnNH9aomg=;
        b=DWLrJQcgFQTaf3+u8Cbp7UlMz/hjKadI6+gSGhIB1sCuJy/s+AQE4dsS6Ci/Sz74Il
         wj+wf28PoHatBKgKsHA12ZK1B/HjwPw5RT1vVc7Z2I4VXVpeiTcBl3H5MZYXGCnHCNDs
         qrGaJTl+y6bwkRolDzq2VQvuI/iqRVFNVXNtlBSSlU3cKCYSI4hO1RjvP7NdDSk1QS7p
         9kHutoDHb6uS0Ug1uVdl8vGp/jjnpfPI2ESIsRUI+E2ik3qfgE09mkf9JZBgEAvjo+ts
         6TWdnwxByltYeYjrvyJMN/Hq+Dais2JXCQ+mWry234GOHMnc05YeSNcvXzS8Z7GMFSwI
         B33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020335; x=1709625135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIaNztM01O7/22vlhTB8ChN0VbTm6XWSFtGnNH9aomg=;
        b=lMCz8gdkjsqQ437PS95p5dm9STJXREvv/zjrKlNzk+nn0gOqy3YDmXfx8aZzOReA8a
         1yFEP/0U0fviIAomgmyrXKnJEjzFQOdJCvkOJL4U9m3y/Ra8AzGIT8FGQ13arb1prAAu
         Wc28dvnYDuZkJyb9h+7n0aZNy9zlPSp39GOzEh3pvGXHaRPPvk+POSAIQPsI1FQ2so5d
         qcm3cYHvRLDcGEwUaZ/yurux36WmyOnxHsAN4cTveL5X4nZhRrR+T5jZ2qGTrr+vj13q
         A1gOHm9eUZwEilNjf7r0LcS6bE6EJ30DkMlxald8yajJxbC9Z96Wzx4G/kSRmtpic2zG
         srZw==
X-Gm-Message-State: AOJu0Yy2lTzF/t/ZMTIVXHSR/OXPhOYPM3Lnl26JY79SxuUkbtQyplgr
	mjF2NMvSmvclhXwsnUX8wCmew8PCHZNLSlZdiZ+l0ORwnsofxWnf
X-Google-Smtp-Source: AGHT+IGQZVUGLbZkpfHwRLGDAFErmAypIDa7ydK5bKtdUMU3jeyo0c0p6qrfj+3uiquexg+aPLEkbA==
X-Received: by 2002:a17:906:3685:b0:a3f:ac54:eb68 with SMTP id a5-20020a170906368500b00a3fac54eb68mr5946385ejc.69.1709020335285;
        Mon, 26 Feb 2024 23:52:15 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:14 -0800 (PST)
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
Subject: [PATCH RFC net-next 4/6] net: phy: realtek: Add driver instances for rtl8221b/8251b via Clause 45
Date: Tue, 27 Feb 2024 08:51:49 +0100
Message-ID: <20240227075151.793496-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227075151.793496-1-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver instances for Clause 45 communication with the RTL8221B/8251B.

This is used by Clause 45 only accessible PHY's on several sfp modules,
which are using RollBall protocol.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 171 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index e7c42ec18971..e7964ce158c3 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -64,6 +64,15 @@
 #define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
 #define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
 
+/* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
+ * is set, they cannot be accessed by C45-over-C22.
+ */
+#define RTL822X_VND2_GBCR				0xa412
+
+#define RTL822X_VND2_GANLPAR				0xa414
+
+#define RTL822X_VND2_PHYSR				0xa434
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -74,6 +83,9 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B_VB_CG				0x001cc849
+#define RTL_8221B_VN_CG				0x001cc84a
+#define RTL_8251B				0x001cc862
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -821,6 +833,76 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT,
+			 phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
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
+	if (!phydev->link)
+		return 0;
+
+	/* Read actual speed from vendor register. */
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_PHYSR);
+	if (val < 0)
+		return val;
+
+	rtlgen_get_speed(phydev, val);
+
+	rtl822x_update_interface(phydev);
+
+	return 0;
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -844,6 +926,44 @@ static int rtl8226_match_phy_device(struct phy_device *phydev)
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
@@ -854,6 +974,15 @@ static int rtlgen_resume(struct phy_device *phydev)
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
@@ -1129,8 +1258,8 @@ static struct phy_driver realtek_drvs[] = {
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
@@ -1141,8 +1270,18 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc84a),
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
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
@@ -1153,8 +1292,18 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc862),
-		.name           = "RTL8251B 5Gbps PHY",
+		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
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
@@ -1164,6 +1313,16 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+	}, {
+		.match_phy_device = rtl8251b_c45_match_phy_device,
+		.name           = "RTL8251B 5Gbps PHY (C45)",
+		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822x_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		= "RTL8366RB Gigabit Ethernet",
-- 
2.42.1


