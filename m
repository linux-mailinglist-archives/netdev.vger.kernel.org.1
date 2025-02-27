Return-Path: <netdev+bounces-170224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A16A47DD6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C282116923B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5184B5AE;
	Thu, 27 Feb 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yOwIp/wL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7C27003F
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659653; cv=none; b=mZvsqnUKgjU745dF0pTBiYpHiY5hPmI/kXHakevRXvD2YOcdHVqkPzHj2/4MvBT/6pyLhqRNuP2oB7fkevRaXzlsWShewFh8EdEO4QwYazyxxE05QJ/8QjO7cxD+E1oM1e3OWDygRCDUyVB6C4WsOLjEETN6gAwU6UJAC0lba1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659653; c=relaxed/simple;
	bh=9idlHId5N61HZnym4E8QQnoZ8XcrBAk6EC1QRm06OnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZtmH1tVvWP/9gfKbVrYmy7vDAMJvhDXwtA37EGFi7Eotwpp0D8fXgBf62YG3dOonmXXBnIZ3L+Tga1jowsfIS1iEJEJjGIW7ZOko7yniRnjpjuOpXh4NMdCScH4quPCMgV2WDWHlDnyWXJFQOqEpvaw0Cqc36S8gLzURLFvgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yOwIp/wL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gLtar/wHfeVCmLMg/jaoFP7v7u+SOrYejD4+SDmmhUE=; b=yOwIp/wLpIAD63YfkPXz6hmvgx
	8wybSmMu5NeH5TJurRum8vIiTyAWntTUZPBagHrPzZ/Kz1uBarRkJc9JORZSScrrfQRqYkTYk7C0B
	Wezx7q6s4uoDZI3vh3q9rORa7zpsdCDYMhAwnba7CyitYDmQCk8mWgNc2+1c642iTsgDY5TUlGhwc
	dZi61rVK/bKoj4wIr8m9YgHFwiewA3GDuGsvZ/cxcF3D+l/VPuNFSWyMBRIr/kKtMOpWZ1SdP7+Py
	+fUxpjcNsKPlB8hhmLR6zncZdIxOzvZhf0C38kNgCg+bfmcgKpA79Du8ivR4nAZIt45hWu2+n9Rt1
	lQ7yRHwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43564)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnd5J-00074f-0H;
	Thu, 27 Feb 2025 12:33:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnd57-00087j-2f;
	Thu, 27 Feb 2025 12:33:37 +0000
Date: Thu, 27 Feb 2025 12:33:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>, hailong.fan@siengine.com,
	2694439648@qq.com
Subject: Re: net: stmmac: weirdness in stmmac_hw_setup()
Message-ID: <Z8BboX9RxZBSXRr1@shell.armlinux.org.uk>
References: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
 <20250226104326.0000766e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226104326.0000766e@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 10:43:26AM +0800, Furong Xu wrote:
> On Thu, 20 Feb 2025 16:17:43 +0000, "Russell King (Oracle)" wrote:
> 
> > While looking through the stmmac driver, I've come across some
> > weirdness in stmmac_hw_setup() which looks completely barmy to me.
> > 
> > It seems that it follows the initialisation suggested by Synopsys
> > (as best I can determine from the iMX8MP documentation), even going
> > as far as to *enable* transmit and receive *before* the network
> > device has been administratively brought up. stmmac_hw_setup() does
> > this:
> > 
> >         /* Enable the MAC Rx/Tx */
> >         stmmac_mac_set(priv, priv->ioaddr, true);
> > 
> > which sets the TE and RE bits in the MAC configuration register.
> > 
> > This means that if the network link is active, packets will start
> > to be received and will be placed into the receive descriptors.
> > 
> > We won't transmit anything because we won't be placing packets in
> > the transmit descriptors to be transmitted.
> > 
> > However, this in stmmac_hw_setup() is just wrong. Can it be deleted
> > as per the below?
> > Tested-by: Thierry Reding <treding@nvidia.com>
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index c2913f003fe6..d6e492f523f5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3493,9 +3493,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
> >  		priv->hw->rx_csum = 0;
> >  	}
> >  
> > -	/* Enable the MAC Rx/Tx */
> > -	stmmac_mac_set(priv, priv->ioaddr, true);
> > -
> >  	/* Set the HW DMA mode and the COE */
> >  	stmmac_dma_operation_mode(priv);
> >  
> 
> A better fix here:
> https://lore.kernel.org/all/tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com/
> 
> I can reproduce and confirm that patch works well.
> I was going to leave a Tested-by: tag on that patch if everything looks good enough,
> but the author (now copied) never come back.

As I now have access to the databook, the initialisation guidance given
in appendix E is very clear that at least the RE bit should not be set
until initialisation of both DMA and MAC have been completed.

RE allows the MAC to start receiving packets and placing them in the
FIFO for the DMA block to then transfer them to memory.

If the link is down, then there should be no activity on the receive
interface, so not setting RE until the link is up should have no
effect. Therefore, start_rx methods that set this bit should not be
doing so, and we should not set this bit until mac_link_up() has
been called.

Analysing the code for the RE bit, we have:

1. xxx_set_mac() (called via stmmac_mac_set()) which sets/clears both
   the RE and TE bits together. This is called with a "true" argument
   from:

1.1. stmmac_mac_link_up() - correct, the link has come up.

1.2. stmmac_hw_setup() - incorrect, we don't know whether the link
     is up or down. I think simply removing this would be correct,
     provided the patches that move phylink_resume() later in
     stmmac_resume() are merged (will be posted non-RFC only once my
     current set of stmmac clock changes have been merged.)

1.3. stmmac_xdp_open() - probably incorrect, we don't know whether
     the link is up or down. stmmac_xdp_open() is only called from
     stmmac_xdp_set_prog(), and the network interface must be
     running. This implies that everything has already been
     initialised, and phylink has been started. stmmac_xdp_open()
     also messes with the carrier, which will upset phylink.
     I think the right solution here is to call phylink_stop() in
     stmmac_xdp_release() and phylink_start() in stmmac_xdp_open(),
     removing the stmmac_mac_set() and netif_carrier*() calls in
     both these functions.

2. xxx_pmt() (called via stmmac_pmt()) sets RE if (e.g. dwxgmac2)
   WAKE_MAGIC or WAKE_UCAST is set.

   This brings up questions. The only place it's called with a
   potentially non-zero argument is in stmmac_suspend(). A few lines
   above is:

        /* Stop TX/RX DMA */
        stmmac_stop_all_dma(priv);

   which is a reasonable thing to do when suspending. However, the
   DW databook states clearly that RE should not be set if DMA is
   not able to empty the FIFO between the MAC and DMA otherwise it
   will overflow. So... I think this causes overflow there. I'm not
   sure what effect that has. Has wake-on-lan been tested?

3. xxx_start_rx() (called via stmmac_start_rx()) sets RE along with
   starting the requested queue.

   This is called in two places:

3.1. stmmac_test_flowctrl(). It looks to me like this needs the link
     to already be up, which means that RE must already be set. Note
     that the call to stmmac_stop_rx() does not clear RE.

3.2. stmmac_start_rx_dma() which has two callers.

3.2.1. stmmac_start_all_dma(). This is called from:

3.2.1.1. the end of stmmac_hw_setup(), which has already called
         stmmac_mac_set() which would've set the RE bit. Same
         arguments as for 1.2 for why this is wrong.

3.2.2. the end of stmmac_enable_rx_queue(), which is called from
       stmmac_xdp_enable_pool(). Very similar to 3.1 above.

TE seems to be a very similar story with the exception of xxx_pmt(),
except the functions are "tx" rather than "rx".

So, my plan with regard to RE is:

1. Add phylink_start() and phylink_stop() into stmmac_xdp_open()
   and stmmac_xdp_release() to the link is properly managed.

2. Remove setting RE from xxx_start_rx().

3. Remove stmmac_mac_set(, true) from everywhere except
   stmmac_mac_link_up().

4. Remove stmmac_mac_set(, false) from stmmac_release(). This has
   already called phylink_stop(), which will have synchronously called
   stmmac_mac_link_down().

5. With (1) addressed stmmac_mac_set(, false) and netif_carrier_off()
   both become redundant in stmmac_xdp_release().

6. Remove stmmac_stop_all_dma() and stmmac_mac_set(, false) in
   stmmac_dvr_remove(). Not only is this inherently racy (the network
   device is *still* *published* *to* *userspace* here, but one of
   the jobs unregister_netdev() does is to take the network device
   down before unregistering - in other words, .ndo_stop() will
   have been called and completed before this returns, which will have
   the effect of calling stmmac_mac_link_down() (which will call
   stmmac_mac_set(, false), and stmmac_release() will have already
   called stmmac_stop_all_dma().

(6) is a frequent programming mistake that I see in lots of network
drivers. It seems most people assume that unregister_netdev() does
nothing, and they need to manually take stop the MAC and take down the
link. :(

I'm going to leave xxx_pmt() alone for the moment as although that's
questionable, I think feedback from people using WoL is necessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

