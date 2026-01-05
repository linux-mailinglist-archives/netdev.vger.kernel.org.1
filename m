Return-Path: <netdev+bounces-247130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A86CF4D06
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB38D309D9DF
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20031B800;
	Mon,  5 Jan 2026 16:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4062FCBE3;
	Mon,  5 Jan 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631118; cv=none; b=dd1lQeScow7ozdsbqK6OrQBrO3tKhe4u2XFj5QuklXQYA1thAF8wGge4aLrkYny6VccfogpziofQdocZOViemNchZtrfe/XyfHGLytAyU3ZCTLbtvBNZUNMG4kj0BQR4flithXrLElKB3cNa38Z95p0D2E6pUSCLsRliskbccpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631118; c=relaxed/simple;
	bh=Hctdg8nxGr8eXtF6WOd4UjLIYimfCBA1oeiF24yby2U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdNwm9wW9dPGS2ob/QWPzlTGNh8Qoo9tWtyal966FFDHE5+/XV0mZC9kigptr1KaVQ/an+TiD4mlkRlUL4chmzF63jAz+BPTC67690jlJ+ysgxRxRxnSmrs6i+kTL2uvOuDJsTxXPIYQxMNUSSLY/NHD8Ryn+hNh1R681XocAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcnbE-000000000ya-1uv4;
	Mon, 05 Jan 2026 16:38:32 +0000
Date: Mon, 5 Jan 2026 16:38:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] net: phy: move mmd_phy_read and
 mmd_phy_write to phylib.h
Message-ID: <79169cd624a3572d426e42c7b13cd2654a35d0cb.1767630451.git.daniel@makrotopia.org>
References: <cover.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767630451.git.daniel@makrotopia.org>

Helper functions mmd_phy_read and mmd_phy_write are useful for PHYs
which require custom MMD access functions for some but not all MMDs.
Move mmd_phy_read and mmd_phy_write function prototypes from
phylib-internal.h to phylib.h to make them available for PHY drivers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/phy/phylib-internal.h | 6 ------
 drivers/net/phy/phylib.h          | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index ebda74eb60a54..dc9592c6bb8e7 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -7,7 +7,6 @@
 #define __PHYLIB_INTERNAL_H
 
 struct phy_device;
-struct mii_bus;
 
 /*
  * phy_supported_speeds - return all speeds currently supported by a PHY device
@@ -21,11 +20,6 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
 
-int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
-		 int devad, u32 regnum);
-int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
-		  int devad, u32 regnum, u16 val);
-
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
 #endif /* __PHYLIB_INTERNAL_H */
diff --git a/drivers/net/phy/phylib.h b/drivers/net/phy/phylib.h
index c15484a805b39..0fba245f97458 100644
--- a/drivers/net/phy/phylib.h
+++ b/drivers/net/phy/phylib.h
@@ -8,6 +8,7 @@
 
 struct device_node;
 struct phy_device;
+struct mii_bus;
 
 struct device_node *phy_package_get_node(struct phy_device *phydev);
 void *phy_package_get_priv(struct phy_device *phydev);
@@ -30,5 +31,9 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 			  int base_addr, size_t priv_size);
 int devm_of_phy_package_join(struct device *dev, struct phy_device *phydev,
 			     size_t priv_size);
+int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
+		 int devad, u32 regnum);
+int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
+		  int devad, u32 regnum, u16 val);
 
 #endif /* __PHYLIB_H */
-- 
2.52.0

