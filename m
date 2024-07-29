Return-Path: <netdev+bounces-113541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9793EF7D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ABC282CE7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF4137776;
	Mon, 29 Jul 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w7/Ma9e2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E2328B6;
	Mon, 29 Jul 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240656; cv=none; b=qRgcwX9Dpf2XJF5P2oxFY0mt1MROJEMQa5lX+t2EHwx2Wq3gckbimElo+cwjxcJQoTnjPlK/3+Rk6fZ7RM1489s7qeH8bVaF8hg0hYkN84fndqiIRTHLr6AnH8E75FjITnV0kDzXHcp5C1iUTa5ocP77vuit0HgPsapnzsOq91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240656; c=relaxed/simple;
	bh=R63FGz1kBtLadER7X9II9B6WGjgDISpSFFA71Gvujao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsKSe1xXcIRicimDShKJSyuf39rbE4TIhZvlGOCMUjFyvAl9D5etbDivWdO7v8kXbOMhAouKiPLQWzv9vRtik0jxZ/kdbg4uYlzcSa8z6zW5gjGSNPAxdXMcTC9V0u8v5YCozET4ihTXA521IhYFqDa+8raJtkj688nM9xbWwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w7/Ma9e2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gCxzdAMkj/8OkdO71mENFkZ1HghwlMtrsU5cRTlyXeY=; b=w7/Ma9e2mk8elAHKm9HZzrgVwj
	QyZh7GBLYgZbPrkgCz8n6m4zW4ZGrE2b49n6GlkZ/W3EE+mAhU252WQ+EbsdeqY9IRizI1Tp/DAv6
	uvWo+lgDSTQUSqcTSvqG3RaIBpHLG0l5rmSuaNTVTM2olOQi1fd7Kfa8196/KlRqgTitKY12pMPDy
	uQspEGu4TDqlfqURhPHbwioucuWGOiXQSS+PtEVOMcoXlODdzxl0XK417YE2ZcNCZ/d8ChsyQ9gB5
	d8awxUyADD+9bonDTOLhohZ3Z/WgcFhBkEWODR9n8700gyfBSY6xFanCT9d8gtZzcsxdHfwPJXCJH
	I+ww4JGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51930)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYLLx-0003MA-1C;
	Mon, 29 Jul 2024 09:03:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYLLy-00049D-Fy; Mon, 29 Jul 2024 09:03:34 +0100
Date: Mon, 29 Jul 2024 09:03:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Youwan Wang <youwan@nfschina.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [net-next,v2] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
Message-ID: <ZqdM1rwbmIED/0WC@shell.armlinux.org.uk>
References: <b61cae2b-6b94-465e-b4e4-6c220c6c66d9@lunn.ch>
 <20240709113735.630583-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709113735.630583-1-youwan@nfschina.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 09, 2024 at 07:37:35PM +0800, Youwan Wang wrote:
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2ce74593d6e4..0564decf701f 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -270,6 +270,7 @@ static DEFINE_MUTEX(phy_fixup_lock);
>  
>  static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  {
> +	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
>  	struct device_driver *drv = phydev->mdio.dev.driver;
>  	struct phy_driver *phydrv = to_phy_driver(drv);
>  	struct net_device *netdev = phydev->attached_dev;
> @@ -277,6 +278,15 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	if (!drv || !phydrv->suspend)
>  		return false;
>  
> +	/* If the PHY on the mido bus is not attached but has WOL enabled
> +	 * we cannot suspend the PHY.
> +	 */
> +	phy_ethtool_get_wol(phydev, &wol);
> +	phydev->wol_enabled = !!(wol.wolopts);
> +	if (!netdev && phydev->wol_enabled &&
> +	    !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> +		return false;
> +

We now end up with two places that do this phy_ethtool_get_wol()
dance. Rather than duplicating code, we should use a function to
avoid the duplication:

8<===

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: phy: add phy_drv_wol_enabled()

Add a function that phylib can inquire of the driver whether WoL has
been enabled at the PHY.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 19f8ae113dd3..09f57181b8a6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1433,6 +1433,15 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+static bool phy_drv_wol_enabled(struct phy_device *phydev)
+{
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+	phy_ethtool_get_wol(phydev, &wol);
+
+	return wol.wolopts != 0;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1975,7 +1984,6 @@ EXPORT_SYMBOL(phy_detach);
 
 int phy_suspend(struct phy_device *phydev)
 {
-	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *netdev = phydev->attached_dev;
 	const struct phy_driver *phydrv = phydev->drv;
 	int ret;
@@ -1983,8 +1991,9 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended || !phydrv)
 		return 0;
 
-	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
+			      (netdev && netdev->wol_enabled);
+
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
-- 
2.30.2


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

