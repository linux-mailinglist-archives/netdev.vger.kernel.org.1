Return-Path: <netdev+bounces-178032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94EA7410F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484F81895344
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD491E51E6;
	Thu, 27 Mar 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se5lXW5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86401D61B1;
	Thu, 27 Mar 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115565; cv=none; b=VKm1s20un3L+chFQ5lvxbwpjGxTiJtaAtwsx6kosorc8etXp09X/+o5+3P8uh+/56bVhRN6SiY5IMvivQ3KfoGZXdQiot/XoDdAFCQd6d+HvbRu7kdmdFUFTARXj+ZRVWKiPa+wRgJHRI8nP4orI4rih1rETPSbf4quND/uArRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115565; c=relaxed/simple;
	bh=+jG83L3T++gpg86vJ04dZe1D8mV6DZg7ZISWFqUGZVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1ocgEbB5gSozjmr6LKZuqOAeFN8in6ZqjwFYxhYxE9SUaCDwQoxey/R6ccRZ4CtjNPrt1rxYM63yMu1Zjc/YQMx36bv/3Xp+8kmRze9wSyZVkBv73l807GVcC3o9QUbkmFsjc41EMEqWcMFhwqyKhHJjejufJy925dd9/5FW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se5lXW5c; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso1219092f8f.2;
        Thu, 27 Mar 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115562; x=1743720362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjlTdSXj+pN+wb7r+Ip7QKXOaz/T3UtXfZ08FY6gt2w=;
        b=Se5lXW5cuQu0ArsIz88eHKOaZ8q2xiAr+M5eq7Z9JfnpcAuGi/z6D3HQXitNtThKYg
         +MFvXac6AZbBJyr2mPtbOJKuGLk8FZd3NXpjoSXNdpsP5Beoh5ULVyXw8N1j6b0daC5s
         JgtnFbn3W2L3uEYnP9XiEYvD5IvS2A+yF+Vwn/hFR1UOTaoBN7n4o+/5KW5H4ihfiw+t
         iMAuyboKBePLY/H/nOvSWHvX3CrBtGGlVeUA1AG3ntZEmlI6cZWAeru4UgYzVmVhAyVT
         Gy8Vswx+YPl2RZy1dPe+iJ4RcQtRNnwDka83Oy8IFv8LxpybpEVoptTbSeupxbcaE/7E
         wrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115562; x=1743720362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjlTdSXj+pN+wb7r+Ip7QKXOaz/T3UtXfZ08FY6gt2w=;
        b=kQ3Cvp6WLNOw/VaCvnsU0wuWDsdEjkTG8esTeoW053/oQXEsNtS6BbgzNvoacP0H1B
         ZDAxsSABfADCHXoXtUKEmXFGFwjXukHJsPJo8l04wpw6R3uqSM31c8AgliR5wLjOVi4P
         KOmY+oS5mApRHSBGNfY5/3PlHTFiBfaU30kgHDH6RoZnR3SgKj22tEQGHiuwSNTds7Eu
         Ne7vlZxkuUfYlD0WDkP/d/WhLQD3nqYPUZn/HtQkldooOhRtcVA8/c6C/7cCHSBEfvpB
         kCSsEKtX50SbnDRAnCZQ77SigaRB5tfHI7IrXxyd7ue/PA1kxMBmNMmeR5CAfQXyxaTb
         ZETw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pywz1ZrIoIoONgupVginsuiF84EYVlq1nX4AwY1dAO9SYTyiN9k60FWl79+VX3UJXE8SKV+7bzxW+Fmj@vger.kernel.org, AJvYcCWu6ANvK0SwZVNjpHLxMaFRUdo5/moHDwUINJ9nd02DlHMv83p6SKYpBY0PbH6MbTogqhwInbRC@vger.kernel.org, AJvYcCXzSEbQkHn0j+HVxX8SgMXYju+NoObU3LM3kUTO/5GneoInfMW9ENXJiNCXur+/68sgXb0F9hFpm64h@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKpq+I0ZyfsMwAjdoAYIri7sFjmXTvM+PTA+7LEdZ7jXPRHNe
	2pGQrL367qmpoPAWCGWUBwTOC2/dOmKba8bKHBre3T9OBwU7AKvi
X-Gm-Gg: ASbGncsR2EHdDx0LarQoW/caZ0QGc3tEurpkEOAhVNHZSXt3VsFNdWEMr/pi+/njkZC
	Es6SXW07ITsZJn7keaCS9tsHAIKOdQ/xFOPoP7S5mko39IvyYUqLgcTNasEyVLiJQRWTzYHKdBY
	fWnAKD4qmLzkyoCT1iYQ6KsBonENAn8p2Vztm++0eQRSm/cfjjtbaotv3ZAYDMFmI9doIJmGP3n
	AYFr0JTqmUcWaOp5Pos9nZO1ba+gt9suEWC6kvBfBEA6YEin4VQaRFzWAndNGhKOeC488o2p0GW
	bPQQIDPAqg0sYvmUC6/gsF1QXu415fRN6+ADX9NtigLI0PpSMBItoppnitTbjpxLsPSuSX6m6GY
	9S5YzFfOWKOMq5A==
X-Google-Smtp-Source: AGHT+IGb0dSpeP8CowKqOf64jwD5jjo1alpQLoTQuLsch7hDO/0TDUqSQ6b4OpJrAq532VLUhNqtHQ==
X-Received: by 2002:a05:6000:1f8f:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39ad1788652mr4487959f8f.52.1743115561669;
        Thu, 27 Mar 2025 15:46:01 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:46:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Reviewed-by: Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next RFC PATCH v4 1/6] net: phy: pass PHY driver to .match_phy_device OP
Date: Thu, 27 Mar 2025 23:45:12 +0100
Message-ID: <20250327224529.814-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327224529.814-1-ansuelsmth@gmail.com>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
Having access to the PHY driver struct might be useful to check the
PHY ID of the driver is being matched for in case the PHY ID scanned in
the phydev is not consistent.

A scenario for this is a PHY that change PHY ID after a firmware is
loaded, in such case, the PHY ID stored in PHY device struct is not
valid anymore and PHY will manually scan the ID in the match_phy_device
function.

Having the PHY driver info is also useful for those PHY driver that
implement multiple simple .match_phy_device OP to match specific MMD PHY
ID. With this extra info if the parsing logic is the same, the matching
function can be generalized by using the phy_id in the PHY driver
instead of hardcoding.

Suggested-by: Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm87xx.c              |  6 ++++--
 drivers/net/phy/icplus.c               |  6 ++++--
 drivers/net/phy/marvell10g.c           | 12 ++++++++----
 drivers/net/phy/micrel.c               |  6 ++++--
 drivers/net/phy/nxp-c45-tja11xx.c      | 12 ++++++++----
 drivers/net/phy/nxp-tja11xx.c          |  6 ++++--
 drivers/net/phy/phy_device.c           |  2 +-
 drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++---------
 drivers/net/phy/teranetics.c           |  3 ++-
 include/linux/phy.h                    |  3 ++-
 10 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index e81404bf8994..1e1e2259fc2b 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -185,12 +185,14 @@ static irqreturn_t bcm87xx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int bcm8706_match_phy_device(struct phy_device *phydev)
+static int bcm8706_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
 }
 
-static int bcm8727_match_phy_device(struct phy_device *phydev)
+static int bcm8727_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
 }
diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index bbcc7d2b54cd..c0c4f19cfb6a 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -520,12 +520,14 @@ static int ip101a_g_match_phy_device(struct phy_device *phydev, bool ip101a)
 	return ip101a == !ret;
 }
 
-static int ip101a_match_phy_device(struct phy_device *phydev)
+static int ip101a_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return ip101a_g_match_phy_device(phydev, true);
 }
 
-static int ip101g_match_phy_device(struct phy_device *phydev)
+static int ip101g_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return ip101a_g_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 5354c8895163..13e81dff42c1 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -1264,7 +1264,8 @@ static int mv3310_get_number_of_ports(struct phy_device *phydev)
 	return ret + 1;
 }
 
-static int mv3310_match_phy_device(struct phy_device *phydev)
+static int mv3310_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	if ((phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
 	     MARVELL_PHY_ID_MASK) != MARVELL_PHY_ID_88X3310)
@@ -1273,7 +1274,8 @@ static int mv3310_match_phy_device(struct phy_device *phydev)
 	return mv3310_get_number_of_ports(phydev) == 1;
 }
 
-static int mv3340_match_phy_device(struct phy_device *phydev)
+static int mv3340_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	if ((phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
 	     MARVELL_PHY_ID_MASK) != MARVELL_PHY_ID_88X3310)
@@ -1297,12 +1299,14 @@ static int mv211x_match_phy_device(struct phy_device *phydev, bool has_5g)
 	return !!(val & MDIO_PCS_SPEED_5G) == has_5g;
 }
 
-static int mv2110_match_phy_device(struct phy_device *phydev)
+static int mv2110_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return mv211x_match_phy_device(phydev, true);
 }
 
-static int mv2111_match_phy_device(struct phy_device *phydev)
+static int mv2111_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return mv211x_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 24882d30f685..d7f11f16fbd1 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -768,7 +768,8 @@ static int ksz8051_ksz8795_match_phy_device(struct phy_device *phydev,
 		return !ret;
 }
 
-static int ksz8051_match_phy_device(struct phy_device *phydev)
+static int ksz8051_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return ksz8051_ksz8795_match_phy_device(phydev, true);
 }
@@ -888,7 +889,8 @@ static int ksz8061_config_init(struct phy_device *phydev)
 	return kszphy_config_init(phydev);
 }
 
-static int ksz8795_match_phy_device(struct phy_device *phydev)
+static int ksz8795_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 250a018d5546..bc2b7cc0cebe 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1971,25 +1971,29 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
 	return macsec_ability;
 }
 
-static int tja1103_match_phy_device(struct phy_device *phydev)
+static int tja1103_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
 	       !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1104_match_phy_device(struct phy_device *phydev)
+static int tja1104_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
 	       nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1120_match_phy_device(struct phy_device *phydev)
+static int tja1120_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
 	       !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1121_match_phy_device(struct phy_device *phydev)
+static int tja1121_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
 	       nxp_c45_macsec_ability(phydev);
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 07e94a2478ac..3c38a8ddae2f 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -651,12 +651,14 @@ static int tja1102_match_phy_device(struct phy_device *phydev, bool port0)
 	return !ret;
 }
 
-static int tja1102_p0_match_phy_device(struct phy_device *phydev)
+static int tja1102_p0_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return tja1102_match_phy_device(phydev, true);
 }
 
-static int tja1102_p1_match_phy_device(struct phy_device *phydev)
+static int tja1102_p1_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return tja1102_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225378..2d6ceacb2986 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -514,7 +514,7 @@ static int phy_bus_match(struct device *dev, const struct device_driver *drv)
 		return 0;
 
 	if (phydrv->match_phy_device)
-		return phydrv->match_phy_device(phydev);
+		return phydrv->match_phy_device(phydev, phydrv);
 
 	if (phydev->is_c45) {
 		for (i = 1; i < num_ids; i++) {
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 893c82479671..b4dc0d6fe4ca 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1117,13 +1117,15 @@ static bool rtlgen_supports_mmd(struct phy_device *phydev)
 	return val > 0;
 }
 
-static int rtlgen_match_phy_device(struct phy_device *phydev)
+static int rtlgen_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
 	       !rtlgen_supports_2_5gbps(phydev);
 }
 
-static int rtl8226_match_phy_device(struct phy_device *phydev)
+static int rtl8226_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
 	       rtlgen_supports_2_5gbps(phydev) &&
@@ -1139,32 +1141,38 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
 		return !is_c45 && (id == phydev->phy_id);
 }
 
-static int rtl8221b_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_match_phy_device(struct phy_device *phydev,
+				     const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
 }
 
-static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
 }
 
-static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
 }
 
-static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
 }
 
-static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
 }
 
-static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
+static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev,
+						const struct phy_driver *phydrv)
 {
 	if (phydev->is_c45)
 		return false;
@@ -1182,7 +1190,8 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
 }
 
-static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8251b_c45_match_phy_device(struct phy_device *phydev,
+					 const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8251B, true);
 }
diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index 752d4bf7bb99..46c5ff7d7b56 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -67,7 +67,8 @@ static int teranetics_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static int teranetics_match_phy_device(struct phy_device *phydev)
+static int teranetics_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[3] == PHY_ID_TN2020;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..7042ceaadcc6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -990,7 +990,8 @@ struct phy_driver {
 	 * driver for the given phydev.	 If NULL, matching is based on
 	 * phy_id and phy_id_mask.
 	 */
-	int (*match_phy_device)(struct phy_device *phydev);
+	int (*match_phy_device)(struct phy_device *phydev,
+				const struct phy_driver *phydrv);
 
 	/**
 	 * @set_wol: Some devices (e.g. qnap TS-119P II) require PHY
-- 
2.48.1


