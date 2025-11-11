Return-Path: <netdev+bounces-237500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E8C4C95E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DD4F841C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FE262FC7;
	Tue, 11 Nov 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOdWjj/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DD2BF00A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852280; cv=none; b=NaCigCgyWMuTBQ0C8mINTKq258mNaICTPZsc4eOHh2Fk3bN0fvl9CsjGGhEV7EoyLpiYvZCztW5K+51w910Wv5/rmAFeT5dJLh1WOq9VxGKQClnlAOO3+dnwV0oZE1w8PCgjS6MRzNArsLQr+nuCqHKF7tcJQWa/EsCh9Ox3tWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852280; c=relaxed/simple;
	bh=jcWGjzMSe/bUvpkL2HB/YbFJrUOryEcY53ec7kWHavI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvyAQpLK4u40FjVbpvTZssR6RRNa4HQiRGouxCgr/VdhVsBJlZK6sBY8LQRnXCuksMAHQ0KQzNzeeNPFOALsS0Lts84gqLBcA5Y3GIgeyMgGy2lxTXo4nOrex9Ig52qs0jG6qO0W0XPk4Ab2gM2WBhSnCRXgSdeO15tsZmMY09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOdWjj/W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ef378069so26220405ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852277; x=1763457077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnuSLNJpozflXXStfLE1DxUP0tpYGi8nHHaLe8eo2uk=;
        b=bOdWjj/Was9MwOLB9+FF83rtQ2KyP45MRkPYmGxagCsm0GJGrfvYM2YfKTn/e5za2/
         RxWllbU6FufGEKz3RTc/L4q4TBmJCke66NuUydXgOeCwE8W2r0epZuPUd4WssRA6uvGG
         TdMRfCAlDE2QJgF85qZJbPFRVL/0sy2vFuaM332YMgsjW3M/Z4NiWfmU5ESASOTwiYeT
         AfcpFBDNdCUDUNVA7R+SREMkeCafRWmoDpukGz7s+KgDoOTGbZQ/GRNB7aCsXjn0TPX4
         uYvhdx2UiOwy1JkeLYJ5Y9uREgNCIkJeUP95g4o+JHJ7PNrdgj1pooSapB4OXxmcQUJq
         g5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852277; x=1763457077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnuSLNJpozflXXStfLE1DxUP0tpYGi8nHHaLe8eo2uk=;
        b=G8DrcuT3c0jw1iGyWaa+j+YWEQwRKX1fbyleyT1c4BhhPDZZTxVFBVGPmk1ePCiRZa
         3j9Xn0LFsazrak6bUB3eDJYdrpklABRApShOpAl7D16SUPtmP5B4huWZ1gUFTsRKGGOq
         x8dt45nIrTl6ZTIdoH2rukIhN5POtaWIi2+PPfsArgyrLvwcU82GMgK9+MWblj2FKN0o
         Aqsgrmnw1SIHDIfMPJnaJd9nZHswlWqgsvGQcd9jbXGMc90ROBjJQltSOy9QB9F5zcWU
         XKBqavDVaDuxaHRFbJSbWgqk5KBEb4LM5quHG/05TGxvrcG3oi1CNwv7lSC3NJ/LSzoN
         3mEw==
X-Gm-Message-State: AOJu0Yy01IomZNnbUbrw/X4Rfj524KTA368K83ENmiX8RDzGioeDyV5q
	/prngCDMFU8xpDVdxLmPfREOVIN2xdmsLpoYFUghcoemKIigwEF8vsjP
X-Gm-Gg: ASbGncvyzim9PBEkqT2i8gxEnjK2aod9UQlgWHx/7RW+CBIsie2WUmCkHfEcc2Us1w6
	BnYOgCWUmGfKYIXzYHsn4i86jBnzmTMrWqB6A397SmXLgvdHpShzzXE7pRIrfLhUZhLcptdKtaW
	j534T6t+C6yun44dU60p2cOE4n+tz77I7f7Y9951xAgS9ZA1yrbJ480KOwR36F79hccjLlbI/S6
	VVluBFX2C8Ts9FvWCYKW0Oga20DVoZwrNP4WWKltre9FKBQCnUAelfXVv2ADrXif3lqkySnY8ka
	Strzc2t1a3Pt4NJwvhdb/wFVSS4Jo7h/azc8MRc+EFq0Qfw5SUJUkajtjaeDW/Pv/wH6IarhTme
	zYApCFGKYOB/KGMLgIsFEKlstW6ocdeAEpqMKbswOqhvC4gipTDOdAvWOG78nGzXltKO/i0DxwK
	eLE0PYnhNuGQpX8mTaejvubVhvknHzkSWf
X-Google-Smtp-Source: AGHT+IH5smDV0RfqJdcQPYkVf2qwjppINZBZuD7Pb0expMILc0K/ZLMG1v5REakorx9qj+6vc75s5w==
X-Received: by 2002:a17:902:f68a:b0:298:33c9:ed9e with SMTP id d9443c01a7336-29833c9ef5dmr62150035ad.28.1762852277321;
        Tue, 11 Nov 2025 01:11:17 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:79c0:4ab7:69ea:ca5e:a64f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5cf37sm172715415ad.35.2025.11.11.01.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:11:16 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe functions into a common helper
Date: Tue, 11 Nov 2025 09:10:46 +0000
Message-ID: <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Unify the probe implementations of the VSC85xx PHY family into a single
vsc85xx_probe_common() helper. The existing probe functions for the
vsc85xx, vsc8514, vsc8574, and vsc8584 variants contained almost
identical initialization logic, differing only in configuration
parameters such as the number of LEDs, supported LED modes, hardware
statistics, and PTP support.

Introduce a vsc85xx_probe_config structure to describe the per-variant
parameters, and move all common setup code into the shared helper. Each
variant's probe function now defines a constant configuration instance
and calls vsc85xx_probe_common().

Also mark the default LED mode array parameter as const to match its
usage.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Grouped check_rate_magic check

v1->v2:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 237 ++++++++++++++++---------------
 1 file changed, 124 insertions(+), 113 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 032050ec0bc9..0ae0199d28bb 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -22,6 +22,24 @@
 #include "mscc_serdes.h"
 #include "mscc.h"
 
+struct vsc85xx_probe_config {
+	const struct vsc85xx_hw_stat *hw_stats;
+	u8 nleds;
+	u16 supp_led_modes;
+	size_t nstats;
+	bool use_package;
+	size_t shared_size;
+	bool has_ptp;
+	bool check_rate_magic;
+};
+
+static const u32 vsc85xx_default_led_modes_4[] = {
+	VSC8531_LINK_1000_ACTIVITY,
+	VSC8531_LINK_100_ACTIVITY,
+	VSC8531_LINK_ACTIVITY,
+	VSC8531_DUPLEX_COLLISION
+};
+
 static const struct vsc85xx_hw_stat vsc85xx_hw_stats[] = {
 	{
 		.string	= "phy_receive_errors",
@@ -436,7 +454,7 @@ static int vsc85xx_dt_led_mode_get(struct phy_device *phydev,
 #endif /* CONFIG_OF_MDIO */
 
 static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
-				    u32 *default_mode)
+				    const u32 *default_mode)
 {
 	struct vsc8531_private *priv = phydev->priv;
 	char led_dt_prop[28];
@@ -2211,132 +2229,125 @@ static int vsc85xx_config_inband(struct phy_device *phydev, unsigned int modes)
 				reg_val);
 }
 
+static int vsc85xx_probe_common(struct phy_device *phydev,
+				const struct vsc85xx_probe_config *cfg,
+				const u32 *default_led_mode)
+{
+	struct vsc8531_private *vsc8531;
+	int ret;
+
+	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
+	if (!vsc8531)
+		return -ENOMEM;
+
+	phydev->priv = vsc8531;
+
+	/* Check rate magic if needed (only for non-package PHYs) */
+	if (cfg->check_rate_magic) {
+		ret = vsc85xx_edge_rate_magic_get(phydev);
+		if (ret < 0)
+			return ret;
+
+		vsc8531->rate_magic = ret;
+	}
+
+	/* Set up package if needed */
+	if (cfg->use_package) {
+		vsc8584_get_base_addr(phydev);
+		devm_phy_package_join(&phydev->mdio.dev, phydev,
+				      vsc8531->base_addr, cfg->shared_size);
+	}
+
+	/* Configure LED settings */
+	vsc8531->nleds = cfg->nleds;
+	vsc8531->supp_led_modes = cfg->supp_led_modes;
+
+	/* Configure hardware stats */
+	vsc8531->hw_stats = cfg->hw_stats;
+	vsc8531->nstats = cfg->nstats;
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
+
+	/* PTP setup for VSC8584 */
+	if (cfg->has_ptp) {
+		if (phy_package_probe_once(phydev)) {
+			ret = vsc8584_ptp_probe_once(phydev);
+			if (ret)
+				return ret;
+		}
+
+		ret = vsc8584_ptp_probe(phydev);
+		if (ret)
+			return ret;
+	}
+
+	/* Parse LED modes from device tree */
+	return vsc85xx_dt_led_modes_get(phydev, default_led_mode);
+}
+
 static int vsc8514_probe(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531;
-	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
-	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
-	   VSC8531_DUPLEX_COLLISION};
-
-	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
-	if (!vsc8531)
-		return -ENOMEM;
-
-	phydev->priv = vsc8531;
-
-	vsc8584_get_base_addr(phydev);
-	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      vsc8531->base_addr, 0);
-
-	vsc8531->nleds = 4;
-	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
-	vsc8531->hw_stats = vsc85xx_hw_stats;
-	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
-	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
-				      sizeof(u64), GFP_KERNEL);
-	if (!vsc8531->stats)
-		return -ENOMEM;
-
-	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+	static const struct vsc85xx_probe_config vsc8514_cfg = {
+		.nleds = 4,
+		.supp_led_modes = VSC85XX_SUPP_LED_MODES,
+		.hw_stats = vsc85xx_hw_stats,
+		.nstats = ARRAY_SIZE(vsc85xx_hw_stats),
+		.use_package = true,
+		.shared_size = 0,
+		.has_ptp = false,
+		.check_rate_magic = false,
+	};
+
+	return vsc85xx_probe_common(phydev, &vsc8514_cfg, vsc85xx_default_led_modes_4);
 }
 
 static int vsc8574_probe(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531;
-	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
-	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
-	   VSC8531_DUPLEX_COLLISION};
-
-	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
-	if (!vsc8531)
-		return -ENOMEM;
-
-	phydev->priv = vsc8531;
-
-	vsc8584_get_base_addr(phydev);
-	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      vsc8531->base_addr, 0);
-
-	vsc8531->nleds = 4;
-	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
-	vsc8531->hw_stats = vsc8584_hw_stats;
-	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
-	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
-				      sizeof(u64), GFP_KERNEL);
-	if (!vsc8531->stats)
-		return -ENOMEM;
-
-	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+	static const struct vsc85xx_probe_config vsc8574_cfg = {
+		.nleds = 4,
+		.supp_led_modes = VSC8584_SUPP_LED_MODES,
+		.hw_stats = vsc8584_hw_stats,
+		.nstats = ARRAY_SIZE(vsc8584_hw_stats),
+		.use_package = true,
+		.shared_size = 0,
+		.has_ptp = false,
+		.check_rate_magic = false,
+	};
+
+	return vsc85xx_probe_common(phydev, &vsc8574_cfg, vsc85xx_default_led_modes_4);
 }
 
 static int vsc8584_probe(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531;
-	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
-	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
-	   VSC8531_DUPLEX_COLLISION};
-	int ret;
-
-	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
-	if (!vsc8531)
-		return -ENOMEM;
-
-	phydev->priv = vsc8531;
-
-	vsc8584_get_base_addr(phydev);
-	devm_phy_package_join(&phydev->mdio.dev, phydev, vsc8531->base_addr,
-			      sizeof(struct vsc85xx_shared_private));
-
-	vsc8531->nleds = 4;
-	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
-	vsc8531->hw_stats = vsc8584_hw_stats;
-	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
-	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
-				      sizeof(u64), GFP_KERNEL);
-	if (!vsc8531->stats)
-		return -ENOMEM;
-
-	if (phy_package_probe_once(phydev)) {
-		ret = vsc8584_ptp_probe_once(phydev);
-		if (ret)
-			return ret;
-	}
-
-	ret = vsc8584_ptp_probe(phydev);
-	if (ret)
-		return ret;
-
-	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+	static const struct vsc85xx_probe_config vsc8584_cfg = {
+		.nleds = 4,
+		.supp_led_modes = VSC8584_SUPP_LED_MODES,
+		.hw_stats = vsc8584_hw_stats,
+		.nstats = ARRAY_SIZE(vsc8584_hw_stats),
+		.use_package = true,
+		.shared_size = sizeof(struct vsc85xx_shared_private),
+		.has_ptp = true,
+		.check_rate_magic = false,
+	};
+
+	return vsc85xx_probe_common(phydev, &vsc8584_cfg, vsc85xx_default_led_modes_4);
 }
 
 static int vsc85xx_probe(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531;
-	int rate_magic;
-	u32 default_mode[2] = {VSC8531_LINK_1000_ACTIVITY,
-	   VSC8531_LINK_100_ACTIVITY};
-
-	rate_magic = vsc85xx_edge_rate_magic_get(phydev);
-	if (rate_magic < 0)
-		return rate_magic;
-
-	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
-	if (!vsc8531)
-		return -ENOMEM;
-
-	phydev->priv = vsc8531;
-
-	vsc8531->rate_magic = rate_magic;
-	vsc8531->nleds = 2;
-	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
-	vsc8531->hw_stats = vsc85xx_hw_stats;
-	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
-	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
-				      sizeof(u64), GFP_KERNEL);
-	if (!vsc8531->stats)
-		return -ENOMEM;
-
-	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+	static const struct vsc85xx_probe_config vsc85xx_cfg = {
+		.nleds = 2,
+		.supp_led_modes = VSC85XX_SUPP_LED_MODES,
+		.hw_stats = vsc85xx_hw_stats,
+		.nstats = ARRAY_SIZE(vsc85xx_hw_stats),
+		.use_package = false,
+		.has_ptp = false,
+		.check_rate_magic = true,
+	};
+
+	return vsc85xx_probe_common(phydev, &vsc85xx_cfg, vsc85xx_default_led_modes_4);
 }
 
 static void vsc85xx_remove(struct phy_device *phydev)
-- 
2.43.0


