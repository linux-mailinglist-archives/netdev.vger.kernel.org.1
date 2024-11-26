Return-Path: <netdev+bounces-147473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596819D9BEB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C06282CA6
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F831D9341;
	Tue, 26 Nov 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lqj0VSmL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAB1D90AD
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640165; cv=none; b=b7K6QJ/xfrYPppNUxcpZyub5MWWvbWtz4ld7DaBJLSt/NkbGweBJOec8TlAhC4Q6NJHFqyMkTqWojZ9QcfQq0hwrqEfMFtGwKtA9MAjsHM0ksqTYT8wajquBURGyhVJcXt6x637bnhLnFHKp8qdW2ySHw9Sts4G6oHlPA+Q4cMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640165; c=relaxed/simple;
	bh=YElFGImjztUQCSse6gpgzwlx7S2FNgeCoA8J+GLC8BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0eZckjUVtKOzYeQZMgyvjacZGrNcgXzrmLEvAOLlre687KFnFIdS6O8dhpXiLVfY2WYbOzcK1WM1M+IjfUjJ8aVKZ8yCdPdebH05SQ/4mpWLZWVt77K5EVA1OWQkmqMXESDCZEx54YTmeHI3xF3RZCqvfFgR64vVuyC4BT7egU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lqj0VSmL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vi83y/8B3Gubm1QfFkkHpp9kuAcCX8lWoAL/8HKghRw=; b=lqj0VSmLHjU0d/oG8cpuR8TM88
	9JLF2np7GplvnvAjtFYNVFnPif6QNYPrimeY3ZhlZeNM4HPwDeOpNTZoaYVLrboAkOItRuTJg9RbV
	clGXZOP6hygYwfJf9N7detcqyasKYrUSVkgOr1IxYMgJ6av4A8jBKYI5VRmYwdX4rIBsuhWwlDONH
	p42ZQE3N+0SM/sUbq9FidT4vbG6yxWfVqtWxgSLwkqzaOHEJXCeAlmWajjHouVrcdxo2Gbto76miW
	I98PF9G+jRUgpKiPX8Y0N+NQg1MVAnOmn36Y84IOYVDKiY7wb5KhhlSctIBefUh4GzWJrteJKrAcw
	2INfuvng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36036)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tFyqm-0007NI-2j;
	Tue, 26 Nov 2024 16:55:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tFyqk-0004hL-06;
	Tue, 26 Nov 2024 16:55:42 +0000
Date: Tue, 26 Nov 2024 16:55:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 00/23] net: phylink managed EEE support
Message-ID: <Z0X9jVhpLvBGkRXD@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> In doing this, I came across the fact that the addition of phylib
> managed EEE support has actually broken a huge number of drivers -
> phylib will now overwrite all members of struct ethtool_keee whether
> the netdev driver wants it or not. This leads to weird scenarios where
> doing a get_eee() op followed by a set_eee() op results in e.g.
> tx_lpi_timer being zeroed, because the MAC driver doesn't know it needs
> to initialise phylib's phydev->eee_cfg.tx_lpi_timer member. This mess
> really needs urgently addressing, and I believe it came about because
> Andrew's patches were only partly merged via another party - I guess
> highlighting the inherent danger of "thou shalt limit your patch series
> to no more than 15 patches" when one has a subsystem who's in-kernel
> API is changing.

Note that, I think, fec_main.c isn't broken, although a quick review
only looking at fec_enet_get_eee() may suggest otherwise:

static int
fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
{
        struct fec_enet_private *fep = netdev_priv(ndev);
        struct ethtool_keee *p = &fep->eee;

        if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
                return -EOPNOTSUPP;

        if (!netif_running(ndev))
                return -ENETDOWN;

        edata->tx_lpi_timer = p->tx_lpi_timer; // <===========================

        return phy_ethtool_get_eee(ndev->phydev, edata);
}

static int
fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
{
...
        p->tx_lpi_timer = edata->tx_lpi_timer;

Since the driver does not touch phydev->eee_cfg.tx_lpi_timer,
phy_ethtool_get_eee() above will overwrite edata->tx_lpi_timer with
zero. If ethtool does a read-modify-write on the EEE settings, then
fec_enet_set_eee() will be passed a value of zero for
edata->tx_lpi_timer.

This will result in FEC_LPI_SLEEP and FEC_LPI_WAKE being written with
zero, and from what I can see in fec_enet_eee_mode_set(), that disables
EEE.

The saving grace for this driver is that p->tx_lpi_timer also starts
off as zero.

A better implementation would be to get rid of p->tx_lpi_timer
entirely, and instead rely on phydev->eee_cfg.tx_lpi_timer to be
managed by phylib, obtaining its value from there in
fec_enet_eee_mode_set(). At least the driver doesn't attempt to
maintain any other EEE state!

So something like this:


diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1cca0425d493..c81f2ea588f2 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -671,8 +671,6 @@ struct fec_enet_private {
 	unsigned int tx_time_itr;
 	unsigned int itr_clk_rate;
 
-	/* tx lpi eee mode */
-	struct ethtool_keee eee;
 	unsigned int clk_ref_rate;
 
 	/* ptp clock period in ns*/
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237..25c842835d52 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2045,14 +2045,14 @@ static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
 	return us * (fep->clk_ref_rate / 1000) / 1000;
 }
 
-static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
+static int fec_enet_eee_mode_set(struct net_device *ndev, u32 lpi_timer,
+				 bool enable)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 	unsigned int sleep_cycle, wake_cycle;
 
 	if (enable) {
-		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
+		sleep_cycle = fec_enet_us_to_tx_cycle(lpi_timer);
 		wake_cycle = sleep_cycle;
 	} else {
 		sleep_cycle = 0;
@@ -2105,7 +2105,9 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			napi_enable(&fep->napi);
 		}
 		if (fep->quirks & FEC_QUIRK_HAS_EEE)
-			fec_enet_eee_mode_set(ndev, phy_dev->enable_tx_lpi);
+			fec_enet_eee_mode_set(ndev,
+					      phy_dev->eee_cfg.tx_lpi_timer,
+					      phy_dev->enable_tx_lpi);
 	} else {
 		if (fep->link) {
 			netif_stop_queue(ndev);
@@ -3181,7 +3183,6 @@ static int
 fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3189,8 +3190,6 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 	if (!netif_running(ndev))
 		return -ENETDOWN;
 
-	edata->tx_lpi_timer = p->tx_lpi_timer;
-
 	return phy_ethtool_get_eee(ndev->phydev, edata);
 }
 
@@ -3198,7 +3197,6 @@ static int
 fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3206,8 +3204,6 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 	if (!netif_running(ndev))
 		return -ENETDOWN;
 
-	p->tx_lpi_timer = edata->tx_lpi_timer;
-
 	return phy_ethtool_set_eee(ndev->phydev, edata);
 }
 
Another patch to be added to my stack...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

