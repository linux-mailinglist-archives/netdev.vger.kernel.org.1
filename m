Return-Path: <netdev+bounces-68630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CD84766E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC191F27D22
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798A14AD2F;
	Fri,  2 Feb 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wCMAc8a1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050414AD2D
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895716; cv=none; b=IIrwygXegwZzAFlFIUISO4dCW2LP4F+9XhPZeU8Lg6jHlAH3pL77IuU3F0y52Lbs7KfaDc3CmFms1eezm/dFKb+u/Ibv2tycpNEJ5fyfnsVLk0gEoge11kR0oC+7kCiF2aw/GwJjENU4NrzXdc5hFhLxzbrtKoIeKLsQhQBwKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895716; c=relaxed/simple;
	bh=oQHlFrgOM34DYaHVUSIoA2n+x/M77d1BbhsYCnAkQPg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=NsUVvN/JrekWcavehe+tQGO2yY45o/kysHpyODXZjnNfJTlMoUwazzXrCsTDN9lbBrFF6vNvAtDGWWsR1NwkmW1jFDyku0IlVqCOF8h5hPCbFoELRKqX6xsv8US36OvxooHA0LiK65+o9VQTDRWrFznbLhPsLKs2Yp8Jg/ffP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wCMAc8a1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9qR1zIZh07zNkVqp/d7/uODkvoKa5K4GkkM8O77GA6I=; b=wCMAc8a1bizfawvI7ySmVbmL6f
	tUP9l7N/KOa/mQFaabzUR8xrKhpdyapvgIXaYTMzNvcoaWFdYk5bX1hduxiA7BVVFQNOC0Pm2WIsk
	QOsXthzsT8OpL6tjOMaPIuaQXmTWeSlbBGbEirwFQgK6w9L8frFr2HFZu2f87CvAXhA+TU1hT2cbR
	O2n2u9xAvfNoMacBtFVmmuXm9qfrMB2O9l8mRQyZwvxxtagm59aJiBMyotBYo6O9JIvjUl1HeW47h
	3UIo6+G19MwnHfNDk+dWsvGm2YcARFHSsluUz5zvGkRec6Znl1RJ9vzA23e4FATXoLWVfaPyyLUVE
	L13ltR7g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38922 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVxXu-0006I0-0h;
	Fri, 02 Feb 2024 17:41:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVxXt-002YqY-9G; Fri, 02 Feb 2024 17:41:45 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: phy: constify phydev->drv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Feb 2024 17:41:45 +0000

Device driver structures are shared between all devices that they
match, and thus nothing should never write to the device driver
structure through the phydev->drv pointer. Let's make this pointer
const to catch code that attempts to do so.

Suggested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c               | 3 +--
 drivers/net/phy/phy_device.c        | 6 +++---
 drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
 include/linux/phy.h                 | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3b9531143be1..14224e06d69f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1290,7 +1290,6 @@ int phy_disable_interrupts(struct phy_device *phydev)
 static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 {
 	struct phy_device *phydev = phy_dat;
-	struct phy_driver *drv = phydev->drv;
 	irqreturn_t ret;
 
 	/* Wakeup interrupts may occur during a system sleep transition.
@@ -1316,7 +1315,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	}
 
 	mutex_lock(&phydev->lock);
-	ret = drv->handle_interrupt(phydev);
+	ret = phydev->drv->handle_interrupt(phydev);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 52828d1c64f7..2eed8f03621d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1413,7 +1413,7 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
 
-static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
@@ -1867,7 +1867,7 @@ int phy_suspend(struct phy_device *phydev)
 {
 	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *netdev = phydev->attached_dev;
-	struct phy_driver *phydrv = phydev->drv;
+	const struct phy_driver *phydrv = phydev->drv;
 	int ret;
 
 	if (phydev->suspended)
@@ -1892,7 +1892,7 @@ EXPORT_SYMBOL(phy_suspend);
 
 int __phy_resume(struct phy_device *phydev)
 {
-	struct phy_driver *phydrv = phydev->drv;
+	const struct phy_driver *phydrv = phydev->drv;
 	int ret;
 
 	lockdep_assert_held(&phydev->lock);
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7fd9fe6a602b..7b1bc5fcef9b 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -22,7 +22,7 @@
 
 struct gmii2rgmii {
 	struct phy_device *phy_dev;
-	struct phy_driver *phy_drv;
+	const struct phy_driver *phy_drv;
 	struct phy_driver conv_phy_drv;
 	struct mdio_device *mdio;
 };
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a66f07d3f5f4..ad93f8b1b128 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -638,7 +638,7 @@ struct phy_device {
 
 	/* Information about the PHY type */
 	/* And management functions */
-	struct phy_driver *drv;
+	const struct phy_driver *drv;
 
 	struct device_link *devlink;
 
-- 
2.30.2


