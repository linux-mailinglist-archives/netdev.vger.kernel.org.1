Return-Path: <netdev+bounces-189566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DCAB2A5B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C53D3B957C
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ABF25FA1D;
	Sun, 11 May 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6xk8te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DD25F79E;
	Sun, 11 May 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988824; cv=none; b=K6FWWfIxFxFjtl9+osw2dIDBQXRRKYTih7KwQYHXludqPIey+TiQBlwRP33stCuByMnf0LdmFNEY07TEZjEhcU3SDSdaL0IL2CsF7EvDUvr0xEt2zByiIUtu+8YS9v0kBbXMKY9Wqp5vtpbfKCrk1oHBvrj/VHz+SylbFj299k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988824; c=relaxed/simple;
	bh=+QNLiQDdt++4dsv9NbQAscz2i7SK4e8p+AbJ07dfeS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyGUhTGC2xN3yrp3BpGnp+qtbl6fTRqry+uNNC3BjwXdWO7NTpluVy0hw7WwCPGLP+dUkVbFYHN1tIZSpL0ovNXShaT2/JYbKNIaLmSXhk6W6jLr+Z5gJaPRhYuQunolJRdFjtRntUjTB+49KvSQkv3N7d+gABUvJjB4JpfVOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6xk8te; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso37728495e9.2;
        Sun, 11 May 2025 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988820; x=1747593620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CNFUjPq4HoPTCeEuaRY4Eb3Tx96n4QPBWivdYASBbo=;
        b=d+6xk8tegEZ5d7noa7PooehCkL/kwS8vAqLtdOvT1DUvaZ819W65JJRGeV5J6vPjDE
         POW7QLbE5V0vtyQ2l3+uqKA9HtKL4fATl823H6pwmXkRqfLgI/t2fz3I1KAyitPWjy3g
         6xzvWWkgQQi6FfpFRYhqMy52MqIXXWTJkad2IIN4bmP475wRVSIyJDHGXIqQ/aQSZ/yQ
         3QJ3UBnGYMr5X1/p7ikLLo6Q7PGepRzywjtD7n4N9PIlGT1RBIeSCmrFHT9hjL+Jwrdi
         GtOST3GdQUKyD2IvRGKrcIcJ0t+HUm1ZP5Yq8X6SqDZqzH8my9oiagJLDEWsmVetZVqY
         U7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988820; x=1747593620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CNFUjPq4HoPTCeEuaRY4Eb3Tx96n4QPBWivdYASBbo=;
        b=QHJX/U08kvJgoeuKjBqMmhinf+txdfuq5N061IuXovJ/doMOW44EAAGnfjG7+sFjZk
         XCWEA8LhDybn8TK+gRxCIao6s8biOZCWDEjDmKt6cmFAiz38/Uvl55la9IiNN5cRhZ6B
         2kcCVHTEZvLC9vZBlo05/ynS2wCjNwqnySzJLyDEX0IReHySYbFI3mxX1i8JDS1lokR4
         0OyxSMpV/fLJG57ZC/4E/8/d3J7BszHqmTRbwVSN+MArAfpYZrIOSH9Ynap9DRMMV+Ij
         ai7AFbDPLWd7EfLWkboNI6ekxzUZE2uNB8bqQiXJE/oJY8wGNM/Ban3eEGwqcl/+CGdG
         AC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVe1dfgXjkPf8o6/dnsfd14j5jGyjlu4HDW0RF35bf4/wAk52Huut8alIGR41Tt4TCZi6RB6Z6q@vger.kernel.org, AJvYcCVp5sl4b3+HwTRLDFYpsvwWcNDSNKPFuMrvTz/sfAUNz2AkpoERtdknHgu7T4z65dIt6CE3PgjMEkIh@vger.kernel.org, AJvYcCWXx7So4axti6EPSPaCsbA5Oa5BQpctLc262oAFovvPE1FYvXUKXmrrcRfwofkOsDT07OWDXEodlyWOX4X9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/FPw0cZlV73JJdEz3w23LELgLhRHzZAfjwgAs2U6idQGqgAM
	QC/QL2B0clzEAoFe3EqCQOnVqAUZxhaHA+fmRqJvrm766sN7Lpe2
X-Gm-Gg: ASbGncsmlYkDE5VNEz4htTPH9qFC6sOPdhE/Iz/55PJEgLSyaq2fA3a/l3y6yn7Hs5D
	BDyTm+B1Mb0sw4D/iRKPrYKjg5Wq3ppV8YXqpkbQ62KctWyqMPow8142yZftiNm/bZMxi8AQIGG
	Ln+D8RBVg01b8P0p8/jiWAxHqk7fkalFXVqNSiEeyIHgWQbp0/NVpKCM1tK5GP8R6yyyCnJXHNb
	ewL/J+Aut/RweqPxj7iXq4W/CQAzxaskZ5G4T5SX65ftnu9iPbIi7r1RPYfWO+JsZLYhlblxwsf
	5SgkD52Mf/cFFkdDiPcAk+ALWkJlNnW/nyfs4p/QuHEgNIvulAdo8KKClCXbZqJPs3StIYS46py
	nXIAspubK3iRi+XnOpxhk
X-Google-Smtp-Source: AGHT+IEGUVlx3y/GnPHKFvnmEjhMY0WWd/Rv2Js237lQUtWoIWrWiBMNALBReJdK24iAbBKIW+238A==
X-Received: by 2002:a05:600c:8284:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442d6dd2478mr74252465e9.20.1746988819607;
        Sun, 11 May 2025 11:40:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:19 -0700 (PDT)
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
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v9 1/6] net: phy: pass PHY driver to .match_phy_device OP
Date: Sun, 11 May 2025 20:39:25 +0200
Message-ID: <20250511183933.3749017-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511183933.3749017-1-ansuelsmth@gmail.com>
References: <20250511183933.3749017-1-ansuelsmth@gmail.com>
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
index 71fb4410c31b..4d8460c93078 100644
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
index f11dd32494c3..22921b192a8b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1966,25 +1966,29 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
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
index 2eb735e68dd8..96a96c0334a7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -554,7 +554,7 @@ static int phy_bus_match(struct device *dev, const struct device_driver *drv)
 		return 0;
 
 	if (phydrv->match_phy_device)
-		return phydrv->match_phy_device(phydev);
+		return phydrv->match_phy_device(phydev, phydrv);
 
 	if (phydev->is_c45) {
 		for (i = 1; i < num_ids; i++) {
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 301fbe141b9b..6b655d3c7e1c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1314,13 +1314,15 @@ static bool rtlgen_supports_mmd(struct phy_device *phydev)
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
@@ -1336,32 +1338,38 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
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
@@ -1379,7 +1387,8 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
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
index d62d292024bc..cafac4f205d8 100644
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


