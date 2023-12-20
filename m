Return-Path: <netdev+bounces-59274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1081A33F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6D1C24083
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675341875;
	Wed, 20 Dec 2023 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjkLIo8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DB41874
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440EEC433CC;
	Wed, 20 Dec 2023 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087726;
	bh=Wax2RwcsMcZOhlsSJS8rQWRkaHqiXQOrD81pQbxBYDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjkLIo8MK+mSaKnZ+TCp9jnT3Neu5hYuwH2l44AVuOO/AhyjOSSejaCaWDlY6voIV
	 sOLunPuxk214ZMiaSVoEAu7m3iosRstSqjB9GpguPCm2aqFbGYs7gGcCM373BXpXfD
	 xam82m8eIk0o1iHgsIy/zedW7V2gFHFmHQUeguMgx98BTcYa1h0WZnuKbGZM42DoaV
	 0DkoLszhQghocmINSyhDmLtdPsUYRu6Bu+YYdLwl7EzQiGLpFn6embKxLNRDP99vru
	 n9wKumzOMP3lSGg+M1ZqY68yRPVc988r7Swl+FYWVLiDhJRLhrBj9YZXmvEix9P6h/
	 OBZRek6wMl9Kg==
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
Subject: [PATCH net-next 01/15] net: phy: fail early with error code if indirect MMD access fails
Date: Wed, 20 Dec 2023 16:55:04 +0100
Message-ID: <20231220155518.15692-2-kabel@kernel.org>
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

Check return values of __mdiobus_write() in mmd_phy_indirect() and
return value of mmd_phy_indirect() itself.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/phy-core.c | 52 +++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..9318b65cca95 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -526,18 +526,50 @@ int phy_speed_down_core(struct phy_device *phydev)
 	return 0;
 }
 
-static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
-			     u16 regnum)
+static int mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			    u16 regnum)
 {
+	int ret;
+
 	/* Write the desired MMD Devad */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
+	ret = __mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
+	if (ret < 0)
+		return ret;
 
 	/* Write the desired MMD register address */
-	__mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
+	ret = __mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
+	if (ret < 0)
+		return ret;
 
 	/* Select the Function : DATA with no post increment */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
-			devad | MII_MMD_CTRL_NOINCR);
+	return __mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
+			       devad | MII_MMD_CTRL_NOINCR);
+}
+
+static int mmd_phy_read_indirect(struct mii_bus *bus, int phy_addr, int devad,
+				 u32 regnum)
+{
+	int ret;
+
+	ret = mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	if (ret < 0)
+		return ret;
+
+	/* Read the content of the MMD's selected register */
+	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+}
+
+static int mmd_phy_write_indirect(struct mii_bus *bus, int phy_addr, int devad,
+				  u32 regnum, u16 val)
+{
+	int ret;
+
+	ret = mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	if (ret < 0)
+		return ret;
+
+	/* Write the data into MMD's selected register */
+	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
 }
 
 static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
@@ -546,9 +578,7 @@ static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
 	if (is_c45)
 		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
 
-	mmd_phy_indirect(bus, phy_addr, devad, regnum);
-	/* Read the content of the MMD's selected register */
-	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+	return mmd_phy_read_indirect(bus, phy_addr, devad, regnum);
 }
 
 static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
@@ -557,9 +587,7 @@ static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
 	if (is_c45)
 		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
 
-	mmd_phy_indirect(bus, phy_addr, devad, regnum);
-	/* Write the data into MMD's selected register */
-	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+	return mmd_phy_write_indirect(bus, phy_addr, devad, regnum, val);
 }
 
 /**
-- 
2.41.0


