Return-Path: <netdev+bounces-59284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3A81A34B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670AD1F22084
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0424184B;
	Wed, 20 Dec 2023 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E55suoDV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0747A50
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FECFC433C7;
	Wed, 20 Dec 2023 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087757;
	bh=gTgkGMnEnms6TAHoMp/Q4RgVgXjpL1xtuZpFMscE8SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E55suoDVp3qUeQ8H2/EsiA62GEfo/q4UANCFBnA/Xh5+5twr6TKpYjSM0NbJY+aKZ
	 3dO9d3Q976ZWJA9Eqb0vvjVYJeYNvvodWcj9KE2FhXvP2UOPUDKcb4SitB/ULDlZc8
	 c9diGfg7/oW58MEY/mSEobg9PrlB7mzAeQCJnnpMs3hwvT5B3cvqSNJP3b1F6RQ+FG
	 ymEcjvV6gAkpjVA7bnsZAmTwNYV3J/4eY3mRPbngvligF+BOUiQCM/hZarHz8HvoJo
	 59qRDo09qyTEHpsU+3/fXh2whE589S1UIAU+CB4ZHcnoFfHMqv2DEB1HBSY485Pkpr
	 AXelwFB5Ianvw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 11/15] net: phy: realtek: use generic c45 status reading with 1000baseT vendor extension for rtl822x
Date: Wed, 20 Dec 2023 16:55:14 +0100
Message-ID: <20231220155518.15692-12-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that rtl822x PHYs .read_mmd() and .write_mmd() methods support
accessing all MMD registers, use the generic clause 45 function
genphy_c45_read_status() instead of the current clause 22 version for
reading status for the rtl822x series of Realtek transceivers.

Because 802.3-2018 does not define MMD registers for reading 1000baseT
autonegotiation status, use vendor specific MMD register for this.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 592de975248f..f36b2bfabe57 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -55,6 +55,7 @@
 #define RTL8201F_IER				0x13
 
 #define RTL8221_GBCR				0xa412
+#define RTL8221_GANLPAR				0xa414
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -678,30 +679,17 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 
 static int rtl822x_read_status(struct phy_device *phydev)
 {
-	int ret;
+	int val;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		int lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
-
-		if (lpadv < 0)
-			return lpadv;
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
-	}
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221_GANLPAR);
+		if (val < 0)
+			return val;
 
-	ret = genphy_read_status(phydev);
-	if (ret < 0)
-		return ret;
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	}
 
-	return rtlgen_get_speed(phydev);
+	return genphy_c45_read_status(phydev);
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
-- 
2.41.0


