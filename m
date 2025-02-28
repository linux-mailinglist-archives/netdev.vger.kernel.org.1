Return-Path: <netdev+bounces-170733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC1A49C2B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7341706ED
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1226FD84;
	Fri, 28 Feb 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iFtcGjYq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5426BD95
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753509; cv=none; b=nLbyOWkPyJZ4YkXoKDAs+zgTLFvROkQWdK0la5IGlRSTnU9z07x37p9vh/JN+0O3dmp4RnVBdhjLnmRHiKxPkX/OTIEEqY750oCV87KcBh17M0/G6XFiYg5rVOC4F9UjhGNHTE6Cyqy7MBjusWKcO484PmO3ZKr7R8LGghsKR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753509; c=relaxed/simple;
	bh=VFV4V+KaAVrirb4p3PgEObarCo2A/dHguaMyEXLgNKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciQQknwbI8DP9Caw4YJx6k/HeiK3JsEvvgK+k8b7P5OQgnROHi7ctaDYyJCzFXRLBeBhXMg6/C5c0AawJX5DK6byiT2xgA6r97qucv0mjCOdVrnVE88Uy5GWv1PyP8idfjIBBbGOhRGgljZGAjaYG5KFlnLPG/1W0XiKeQZxu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iFtcGjYq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3tXnve9p7OqPOELNgMc2EsgP+Zfm3xXu92ERqG5r7f4=; b=iFtcGjYqiy3IOCZDaithdJHkh4
	CU+JJwQVo5k7U4sa3fUv8ige18h8zr+4GdMraoHFGWeOf4zC+u0c/rC+w6HK0gP49RT7j0ZhNXdYg
	Xo0KXs9QxxcaNvZTTX9c09YPKLWKeegsJ7GPzyGiAHfN+evABjifq7qMKSvG4BvNKB80RdVvgcklS
	XvpK8Y3ZuS4oSi0ailoVgdn2R2bUyWK3YCkr4INHGO+1wYFhQHxMt/f694g/CGw/Et7wAHt15uHPz
	K+TSiPZlvmG36cQbvbMTkzQXYQkABeFoOITqOMqdJnWJP9MQeYJ9o/vzo79Fuz01tErck8kn4uUTE
	ZDLZ2BvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40904)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1to1VK-00027b-2s;
	Fri, 28 Feb 2025 14:38:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1to1VH-0000oR-2d;
	Fri, 28 Feb 2025 14:38:15 +0000
Date: Fri, 28 Feb 2025 14:38:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Furong Xu <0x1207@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <Z8HKV4ytpJJ9NJw8@shell.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
 <20250228153122.00007c75@gmail.com>
 <7706823a-a787-4c7e-a6ac-9a4feaf76dee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7706823a-a787-4c7e-a6ac-9a4feaf76dee@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 02:14:29PM +0100, Andrew Lunn wrote:
> On Fri, Feb 28, 2025 at 03:31:22PM +0800, Furong Xu wrote:
> > On Thu, 27 Feb 2025 15:05:02 +0000
> > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > 
> > > Phylink does not permit drivers to mess with the netif carrier, as
> > > this will de-synchronise phylink with the MAC driver. Moreover,
> > > setting and clearing the TE and RE bits via stmmac_mac_set() in this
> > > path is also wrong as the link may not be up.
> > > 
> > > Replace the netif_carrier_on(), netif_carrier_off() and
> > > stmmac_mac_set() calls with the appropriate phylink_start() and
> > > phylink_stop() calls, thereby allowing phylink to manage the netif
> > > carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> > > methods.
> > > 
> > > Note that RE should only be set after the DMA is ready to avoid the
> > > receive FIFO between the MAC and DMA blocks overflowing, so
> > > phylink_start() needs to be placed after DMA has been started.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>  
> > XDP programs work like a charm both before and after this patch.
> > 
> > Tested-by: Furong Xu <0x1207@gmail.com>
> 
> Thanks for testing this.
> 
> Could you give a little details of how you actually tested it?
> 
> The issues here is, when is the link set admin up, requiring that
> phylink triggers an autoneg etc.
> 
> For plain old TCP/IP, you at some point use:
> 
> ip link set eth42 up
> 
> which will cause the core to call the drivers open() method, which
> then triggers phylnk.
> 
> The carrier manipulation which this code replaces seems to suggest you
> can load an XDP program while the interface is admin down, and that
> action of loading the program will implicitly set the carrier up.

It won't. See
drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c::stmmac_xdp_set_prog():

        if_running = netif_running(dev);

        need_update = !!priv->xdp_prog != !!prog;

        if (if_running && need_update)
                stmmac_xdp_release(dev);

	...

        if (if_running && need_update)
                stmmac_xdp_open(dev);

stmmac_xdp_open() and stmmac_xdp_release() will only be called if
netif_running() returns true as explained yesterday (but maybe
without enough detail). This tests __LINK_STATE_START in dev->state,
which is set just before calling .ndo_open(), and cleared if it fails
or before calling .ndo_stop().

Thus, netif_running() indicates whether the net core thinks the
device is adminsitratively "up".

Therefore, in the old code, if the programme is changed while the
device is administratively down, netif_running() will return false,
if_running will be false, and neither stmmac_xdp_release() nor
stmmac_xdp_open() will be called.

Hope that addresses your concern.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

