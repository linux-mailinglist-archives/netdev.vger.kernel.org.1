Return-Path: <netdev+bounces-83892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A8894B00
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04461C21F2F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C261B809;
	Tue,  2 Apr 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNwsP06w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778B1862E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037542; cv=none; b=NFQ3f6DXjH8FAZe/TCPIQvcr7BkKxBJBmmFBrDnAXqP8wbRDz1gI5P1xHizGatw68Y1Vyzk2tSc5pgtknj8AAiyuMGqvPn3w6xGAjUrCp+yO5DiK/1Ogd5ibK6aNVVUukRq2cgvBjVW3uRxd7RPlx7hB0kcnsMcmYXCSnOAEW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037542; c=relaxed/simple;
	bh=A3MVv24g4QV8LN5gJsYKjdeaaxkNitOaJ8A8zhZZS8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsH///FnJ7V3avi8cTPn6m8nKQyieEApUc9sS5yR11I0N4UjB5RsRO8EftvRUr2d2bPDPb1J+ZTs9F2ULktCr8bzxRo5jgHazKXZvIaCB8vWBeIs+2RQv6e/dYtYQSM0aathcq/vkzXFVKZWahZjPXZ6AloXOWlTWQMv7dua5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNwsP06w; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e62f3e63dso210041466b.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037539; x=1712642339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRkNpAKRKsU36uMj/FI8dPhQFnxtSs2t1Hcr7YYNwBk=;
        b=NNwsP06wedvvqGoCd9/gj/z7WFa3AN9CX3AjNXqOx7ir5qcDOciJNb3Oqg+J279QZV
         kWVq5PnkCsKMHk85HgPcZQbnNMetl7rXR3nQYXPjEiWW3YAiuUAa3vq9WEi6XGHVeVl1
         1Zy+rt3l8ZKYPwSIZi1mgNjv0VJLIqFLWj1mXDkLBRJM+t2x440GExQMLzkd7qI/xDVM
         9V3u8Skwt1CZcTxyAns5mMulgNex4MNy8U3j4sn6u3/bcH7iJMoOU09Wrk1fAvv+7/cG
         7dXClkwgEKNJZlozmaWMnmJyAeMwYjEzVPUCAx3vijdHMT7tSMdrHHRdhpYzCHV5C/0D
         QtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037539; x=1712642339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRkNpAKRKsU36uMj/FI8dPhQFnxtSs2t1Hcr7YYNwBk=;
        b=P+KysBReeo7uBtfS6Dm0rGowhNu4m6EKi1dGHt+ZW8jt57fRVbhF7UMNfy0vKbr+OF
         RZGm4wqU/nudiqBtgwSELbvxiz5ExGGQXIS0wfp8c2/bm6mSTz0UM73Ym+7QAojd0j0w
         bFQ9hFcFdHR7ge+y/ug+0ResQLxc0LXkdfYb0Bs1i7qdtxV5Y3qgo2fJNzUw7rddRCVU
         bDh5wqjmamxzp8r/DakrRLIdQijrD1K2OcVbi56EusjSLPj/GXv5JyStAfqpQXWtRNvO
         K8GtuKaTuB9ytvXj1brfK46buDUnHzlSIKqJgeBfVhaTgJKNFFpaPUIktSQvilc7cq9/
         OceQ==
X-Gm-Message-State: AOJu0YxtcYo8nd+Ta+Z+phKxAsrEtvTzMCf+0FfstWts8CSGvSZR8xYK
	H64ABZD2j6AOKobHn1g9nwp2LlRKUceItb8rJ7X7buvONynJObCM
X-Google-Smtp-Source: AGHT+IFyGjBlnGuP8Md3eiF4ioBdvDiCnO/LkPva0dEC2gLEEqGHYkEEVrL7bfkFH1OOIaqHF5X0vg==
X-Received: by 2002:a17:906:30c4:b0:a4e:fe3:ceff with SMTP id b4-20020a17090630c400b00a4e0fe3ceffmr5394802ejb.57.1712037539398;
        Mon, 01 Apr 2024 22:58:59 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:58:59 -0700 (PDT)
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
Subject: [PATCH v3 net-next 3/6] net: phy: realtek: Add driver instances for rtl8221b via Clause 45
Date: Tue,  2 Apr 2024 07:58:45 +0200
Message-ID: <20240402055848.177580-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240402055848.177580-1-ericwouds@gmail.com>
References: <20240402055848.177580-1-ericwouds@gmail.com>
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
 drivers/net/phy/realtek.c | 135 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index ca1d61fa44f5..2215a31d5aab 100644
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
@@ -840,6 +850,67 @@ static int rtl822xb_read_status(struct phy_device *phydev)
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
+	return 0;
+}
+
+static int rtl822xb_c45_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl822x_c45_read_status(phydev);
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
@@ -863,6 +934,35 @@ static int rtl8226_match_phy_device(struct phy_device *phydev)
 	       rtlgen_supports_2_5gbps(phydev);
 }
 
+static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
+			       bool is_c45)
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
 static int rtlgen_resume(struct phy_device *phydev)
 {
 	int ret = genphy_resume(phydev);
@@ -873,6 +973,15 @@ static int rtlgen_resume(struct phy_device *phydev)
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
@@ -1144,8 +1253,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc849),
-		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1156,8 +1265,17 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc84a),
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822xb_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
+	}, {
+		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1167,6 +1285,15 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+	}, {
+		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822xb_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc862),
 		.name           = "RTL8251B 5Gbps PHY",
-- 
2.42.1


