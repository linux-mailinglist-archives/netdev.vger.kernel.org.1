Return-Path: <netdev+bounces-179925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E7A7EEE3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD53017936B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95F2222B7;
	Mon,  7 Apr 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOwGB222"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76921C17D;
	Mon,  7 Apr 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056608; cv=none; b=qOON4yYBX9FjHaBIBT4mlsX2ofKl8PP9wZ1XZQvp6jFVKD3YzkeJxyIEkUalOmn/oNpvkbqwjA1Sf8P/igK1fIgbX4owgeu/uarC28nFftyPrKj+7ULeg8749fr4dupzeBAliXxyTjKwAGWNpD2S4lKrdg3N9WRUWm/q+YpWOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056608; c=relaxed/simple;
	bh=EZMVh2db0ZmarXKOQ7m4yP7KorQoZr0yhTBe80XRdC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJTs87YMhk99Z8CUeZkzVu4QgrKWURymdg3MtlVntqtJGAv/nkDQGM8kJ5ty3gjjqFMWmzpVgk9HRmDN7qFGHl+c9IJAYJ52I+WctmpRVbKr597eS5CUGwYVFMBCstrHD/ikVgTA/acGp3khls/Pg6/r+NhG5V+IVWNgqnO6ZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOwGB222; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so30677615e9.1;
        Mon, 07 Apr 2025 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056604; x=1744661404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+OVgZAbcP9S/JBP9Hsy4ANWhG6zZP/1wY/sh/4+PQM=;
        b=QOwGB222bOgyCoWWA9MyNuXt2THa/9m1B8HEtrpIQtg2jjjpgh5Mxn/9aD9rSPZXj4
         DGp+0Mm92ab1RkCrB8nk+hDLYWf7GOKA5+Hj5LFi18oSDYboj1OMn+AabfnuDWLvTx+F
         rnLzdoQXFTaIpqJnNGdRenSeAWlDh0xRz5GSsYQEiFtMVBwOn9zAYidWqXVFhhdTvO1O
         WVFj6oe1i0ZO9TCtRAHVRYt+Sf46ttIeiAev+sHBTwj0X6QlBfCjtTy9OhtvvgLys1kd
         XhfboM/+fgQ9o1n5ibl5Fh4uMD2gm0cgPtLTPyLeGAcuL0Rha58tNnye/XpchynlD8AV
         0kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056604; x=1744661404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+OVgZAbcP9S/JBP9Hsy4ANWhG6zZP/1wY/sh/4+PQM=;
        b=uA/YDkaAdWDQEQ7g9/GYGDy4kePKyXcYBJ47XfprxNPqIdZjVtfyrJutXWSyySfSFk
         8HUYxthfh0GTR2VqbfC+EOiXXsGoLyRv5JfEhzMVgs3B3LaKSsaTPg63U0W8ZCQzc/cr
         TK5Hqfp0W2DZ/c3dFgoYMCtXpEsJO0Kc6kSH5M8PGqZqlqnMXzDao3PnDwJjKGow1hc5
         1S4PPrgqPxVmuQq/6Yzbp75Kz41iinsMKcbhLzHpWvHlKuRPO8QveO1EQgwiDlbZns5S
         bubt+c1k12+bmGE0GBqQ1GD2yhI29O/miMBmEX+zUY55o5XT9xEuTDiS8K/VM007XdC6
         L2vw==
X-Forwarded-Encrypted: i=1; AJvYcCWD22WHdOE6NzL3VwbqRt31gEwCKfrFZ923HtcX42xh/3Z/ZRudxzKGiggB5gFBdKlJPapTqgu8JDjZNnZP@vger.kernel.org, AJvYcCWGsUr19/zD3/2yPMv3lD3kXBjeWoLuAF/k2oVi5RC5UXSDtB5h5RbZXcdQDtcN7GrvFpjpkh7OpTYy@vger.kernel.org, AJvYcCXrvT+r+WwnDrl+FskkPoyFVBR8RFlQEKG67gBgbAzla5pIOwp39cHGO9w/SybEgKm1nT/rkuhk@vger.kernel.org
X-Gm-Message-State: AOJu0YygStVF9ARHcQ3CneMcPTHse7UzvV3gLMw/hUGjrzzXL5G8vtnG
	iaZ0yS3vi22L8/SukZAibIIpev3U7h3PPjKonjGdMjSVwO4A9kM+
X-Gm-Gg: ASbGncvK5nC5UVeLjf9V9EClWxjewz+93Jw6on1Cb1fvjI1hZ+0/GIfzcpz8V2xAI2s
	GEXGd/6NISdvj8bwyG3Oq0sTWb2TK8nUAvNPOTAf3lj+vTX9BQ3E/t/+Uq23fWOBVPNxyIQAriE
	kjVWLROLhwYW//uio1t7TQSVi+u52+7LeK9m9Fzb7rgqdTDmo4U9AIkPXBudB7x6A1oKZhFVSX1
	Jc3ldtZg1WZarxc+C/WDX9hxhak6vbsJ3I1xwMIlc8saNAsc28hNL4jtfxwleQrYv1q+t9p43wx
	2X3oaywwjd9lNFb4pMdgNzjFCBJX60ubpoVySAfs1R+fkQpLMeo46EeXLkwzmqLhzXWXfqN87pt
	4fgVF5EEv30l2BA==
X-Google-Smtp-Source: AGHT+IFUSs/zjmprrQUH8g0sY9t2gfVUGsA0fDM7zDTnmQDR8GRVNZ3atxPUsZAJONnwmS2Or6neUw==
X-Received: by 2002:a05:600c:6a0b:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43f0e649702mr6629765e9.13.1744056604034;
        Mon, 07 Apr 2025 13:10:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:03 -0700 (PDT)
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
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v6 1/6] net: phy: pass PHY driver to .match_phy_device OP
Date: Mon,  7 Apr 2025 22:09:21 +0200
Message-ID: <20250407200933.27811-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200933.27811-1-ansuelsmth@gmail.com>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
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


