Return-Path: <netdev+bounces-59275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6481A340
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FF82848D0
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AE45C09;
	Wed, 20 Dec 2023 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFWsTBNe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B241874
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C00C433C7;
	Wed, 20 Dec 2023 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087729;
	bh=dhIVe/qoWjws/D9aB1vERhcD2b2+SCRz3fSeSGdruyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFWsTBNeX3rn6REq/xl6XVzGfQNzlnyFUrVzyqkfiJeT8YKUcJzPRA3UbKyTZQScC
	 fCOHpVvuiljuAL4jQXpPZMoxVnyoDfuMQcoJAY5hdCGu8w1w2iyhVku1uj7jojcu5X
	 wABlpjiFXDkJpErulWvv1v4tKio7Q1/jDjANfCXrY9BusQY+GgYMiJahUBCQMgZZfO
	 0Z/qqWnLtT2uq9yu9TuN6zh4+sfYhmKnhvDlm8xx4+JERcMc+O4i416HN8p2sRKCzY
	 V2wOlqq2I9wWf51h1Ewu2EvDu0GmBTpSkmbD4jvoIRlZr0N6PwZoF67TtMeI08ILHy
	 VF+2SLQ4OVOyg==
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
Subject: [PATCH net-next 02/15] net: phy: export indirect MMD register accessors
Date: Wed, 20 Dec 2023 16:55:05 +0100
Message-ID: <20231220155518.15692-3-kabel@kernel.org>
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

Export mmd_phy_read_indirect() and mmd_phy_write_indirect(), the
indirect MMD accessors, so that the functions can be used from the
.read_mmd / .write_mmd phy_driver methods.

Add a __ prefix to these functions.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/phy-core.c | 14 ++++++++------
 include/linux/phy.h        | 10 ++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 9318b65cca95..150020cfa593 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -546,8 +546,8 @@ static int mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
 			       devad | MII_MMD_CTRL_NOINCR);
 }
 
-static int mmd_phy_read_indirect(struct mii_bus *bus, int phy_addr, int devad,
-				 u32 regnum)
+int __mmd_phy_read_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			    u32 regnum)
 {
 	int ret;
 
@@ -558,9 +558,10 @@ static int mmd_phy_read_indirect(struct mii_bus *bus, int phy_addr, int devad,
 	/* Read the content of the MMD's selected register */
 	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
 }
+EXPORT_SYMBOL(__mmd_phy_read_indirect);
 
-static int mmd_phy_write_indirect(struct mii_bus *bus, int phy_addr, int devad,
-				  u32 regnum, u16 val)
+int __mmd_phy_write_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			     u32 regnum, u16 val)
 {
 	int ret;
 
@@ -571,6 +572,7 @@ static int mmd_phy_write_indirect(struct mii_bus *bus, int phy_addr, int devad,
 	/* Write the data into MMD's selected register */
 	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
 }
+EXPORT_SYMBOL(__mmd_phy_write_indirect);
 
 static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
 			int devad, u32 regnum)
@@ -578,7 +580,7 @@ static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
 	if (is_c45)
 		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
 
-	return mmd_phy_read_indirect(bus, phy_addr, devad, regnum);
+	return __mmd_phy_read_indirect(bus, phy_addr, devad, regnum);
 }
 
 static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
@@ -587,7 +589,7 @@ static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
 	if (is_c45)
 		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
 
-	return mmd_phy_write_indirect(bus, phy_addr, devad, regnum, val);
+	return __mmd_phy_write_indirect(bus, phy_addr, devad, regnum, val);
 }
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e9e85d347587..65b79b155f3a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1358,6 +1358,16 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
 	__ret; \
 })
 
+/*
+ * __mmd_phy_read_indirect, __mmd_phy_write_indirect - Convenience functions for
+ * indirectly accessing MMD registers via clause 22 registers 13 and 14. Can be
+ * used in phy_driver's .read_mmd and .write_mmd methods.
+ */
+int __mmd_phy_read_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			    u32 regnum);
+int __mmd_phy_write_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			     u32 regnum, u16 val);
+
 /*
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
-- 
2.41.0


