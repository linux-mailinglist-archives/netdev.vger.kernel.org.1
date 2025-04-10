Return-Path: <netdev+bounces-181167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE7A83F80
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3E716BEE8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628726A1B4;
	Thu, 10 Apr 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQjpA+sI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DA1EB5F7;
	Thu, 10 Apr 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278922; cv=none; b=R+rkDoTckrgoTJV6dhkhU+1O/CJ+OzbbUGZ4H/gwQ9gzc1nLC/EXAcUGocdaRbNQfRtWTPalgt1jtKCQg2j+lAObpD7N7VdvUZdCFgT9/B+UIVQSWE6k29U99cQNqJR4LIJMKAAuW/T1T9t5ShZeLu8xp2xU+fx84IrRt7hjUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278922; c=relaxed/simple;
	bh=EZMVh2db0ZmarXKOQ7m4yP7KorQoZr0yhTBe80XRdC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNcP0t1KWdFzSDyCmE5EzlwggipMxAxkfIrty+B2dOLDGHuEBnK1Jxudisx6nF30kpFp3FiWXha3r5c+qofTDHZnHGJAijfQ6IvF1yp2yne76I9VRt2ILkVy4FaI8TKPhsRSX7fh39C70pbavRRJEwc9l9OBZ8BmpC/TiEp2nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQjpA+sI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso638562f8f.0;
        Thu, 10 Apr 2025 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278919; x=1744883719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+OVgZAbcP9S/JBP9Hsy4ANWhG6zZP/1wY/sh/4+PQM=;
        b=AQjpA+sITGHBEIJoMbwb8lmoMkOM66BC3X+uYgtT5iUIvUdGZCo2CeUpmNS77paw32
         d3dNkhnvxL0kPnTAKJm7mv0d3nAhq4LG7jkSqZDu++XkiGs1b1XGDXhGzcVymHtbjWoI
         CLj+U7LNDn3M1X5SPEsPDg8waiH9kY4+dfiG+ixMc/7zc9KfnxncHGcbNwCPwD8aUp5Q
         sFkKJc6CcTthUTCp55C1VVxH3fN/i4hKEIdtDdiLLDRP+MSQKc5GMyEU9/sHsXel3VdM
         H4NZ8OpqnOHHA/aIK2QCNj1rR2WELWl8Uqpf14A5l3fxOKbC+T5U9rLITCfDk29Bwqvp
         z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278919; x=1744883719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+OVgZAbcP9S/JBP9Hsy4ANWhG6zZP/1wY/sh/4+PQM=;
        b=G4oaypHoXI/bgMTCFiHAwBG1aC9mX5sIZA0sO6J7VFaxQ32IPNJ6WFMQ7yCtgRqRj2
         oJTaB3MbrLX6ar/W+KdEEVcNndXfF2WoQUrNQqsaQxAU6d0GRVSMkwZaaEJBjBbszdZj
         qVa2yps3+zUVBIJlR7EQzME8HaIEfArKOtq2/UQIVe/c/MC0m1bN/yxapSQ/qPMU0Pbg
         yvcan9ELyG6kdjqMn/hXE4vOq7He+bpnvlszA8WNRLgrufZXz3QY3zOmyurfQacwrWGn
         QSOFtoyNSDDeel9gbY0sOvwyWPp/xWMm2gwHaFSYGGUhFCLXTQiayfVE/PTSwc+Ov12m
         LXxg==
X-Forwarded-Encrypted: i=1; AJvYcCVyiyUAeSRKPoW8SbqBusVVCeb5uHVloMI3JIAtBkLsXAplEZETD62HrY9cZFGTQ0F/JnVymil08b1d@vger.kernel.org, AJvYcCXjGI+K8kKiWjreIx2xR1b6uYammOT02hjegfG9HbrXplpl8nxEarEKnl8Q9BZ+PVW8cRLZkHNS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/xEl/JATFcJunETcIqRw2bp7Fm0+FwCO1GDOD0XbhbM/fzgQ
	YaeW73aEM+L50r5iS/mRO7CzxPsf/+0pmsnim96qULmm8Oypjyaf
X-Gm-Gg: ASbGncvlcYIB0w42BQ6y8e//u/7qA5dwi7fbRnsbiHfIIrVazCIS32gL8tIRAjVc0xT
	A7R1ewivhX7U/3IIlr9bS/e+r+j7YHCAnj+Kc7cjxLWzRkjRHdPq9pIxs+hX97EhBLd46v2plWY
	WY64yYfQNkglqjbrF3T1i/Di8PKWvxwUpThmD3z01s3or10bMEMB8/zqZ27Z0mTJ9AWRRbFrQ7v
	ENOr+aeT3G5VGHmIAUxo1w75brg0nzzgRxfD3616dXr350OKePq1LHUUMDXUh/iX4sUnA0V98ss
	uDfPy67l9mrfE6fWLzt4GnvaAQj5romaKlg11YACgKPabV04EgA5sX2bK3uG5kVYZb6/DsstCpy
	jimaG6Ho5Mg==
X-Google-Smtp-Source: AGHT+IF2x4zo60JqH+t9vWJOpOJzBMAbWqxlx/lwUN4UZeXyCircWTU2ngvUbZ+T8aUY/ZuizDnRlw==
X-Received: by 2002:a05:6000:188c:b0:391:4c0c:c807 with SMTP id ffacd0b85a97d-39d8f4f1406mr1893188f8f.53.1744278918652;
        Thu, 10 Apr 2025 02:55:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:18 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v7 1/6] net: phy: pass PHY driver to .match_phy_device OP
Date: Thu, 10 Apr 2025 11:53:31 +0200
Message-ID: <20250410095443.30848-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
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

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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


