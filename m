Return-Path: <netdev+bounces-250667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F2D389C5
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 00:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FE68302B8EB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F343128AC;
	Fri, 16 Jan 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uNmvPJQ+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C512E1758
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768605710; cv=none; b=Mp7btRMaVgrHMVfmO9w8qRRJkuxbsByxZEghK9/DWa7ItfJonwa46df2x4rJnVHvScEJwTC7ZSB2y5L+H09M+dvMN1MC9FlbEAI+ucOf6UjPrEiqqzf5aicnVKyExwVCJMhhtrk6/9wEkk9KwklxYgwW3TOvnOLE5wx6ZqjDxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768605710; c=relaxed/simple;
	bh=Q6JTuC4fGGJrvspNz6n1fVzcEpFz9H60CDvBISfQ4tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOCzIJZ1F2X1mAAsUmsCQI/IhFsCxM28iEFbs0nh+H2SEB2X9BLyb3OcBuq3fFM/A9ojCDcE+ubmboZ9pyEvvmQPfKndd6qwxszPenYe/04BVKQqNE2S90yDzBC+aWfVDfSmxh61Bqf0pV5ENKJzHrQcd5GVKiuxX5umLczh4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uNmvPJQ+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I0LjCIeuPAwdgtlev8KvuzPXD9fmIY3MFzxNjZLLxnw=; b=uNmvPJQ+P2k4OgB8mxWlVT3Mo7
	iJia5uWsqTxGGMH6sVLoXn6X6YdcXxaXOI/KNMgkKeYT3u/8Xp0gy6N8FyS3n+IJemRDWFKlJzLe/
	MJ6NQV1Gqo5TBeJj9PHn+CEEH/h+9QXcU45Bxtqa93FI7sxn7ciRcGkluzgCrKBHTEDSVpylVZuXZ
	on4ZjHQ6Hyd68MveQuYFl00FLZI5BNxw5EOZIs7v047O4ebunzW4pMaRXR7ZwwfD3hNVDrtiGbz8j
	UDNiOFpIv/d9wlfeKd7caSQDi9UWo4Ky26LnSmVe0w0BGp/PiXmRV5RD/Ni1HOMaY7kReIHEXYyKQ
	XdX7rRzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46954)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgt8F-000000002lN-3lSf;
	Fri, 16 Jan 2026 23:21:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgt8C-0000000040s-17Iu;
	Fri, 16 Jan 2026 23:21:28 +0000
Date: Fri, 16 Jan 2026 23:21:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix dwmac4 transmit performance
 regression
Message-ID: <aWrH-FAuWnqmbSaJ@shell.armlinux.org.uk>
References: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
 <ab2d7cc9-e7d9-47fb-95ad-90ae4f5f1f67@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2d7cc9-e7d9-47fb-95ad-90ae4f5f1f67@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 08:42:19AM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 16/01/2026 01:49, Russell King (Oracle) wrote:
> > dwmac4's transmit performance dropped by a factor of four due to an
> > incorrect assumption about which definitions are for what. This
> > highlights the need for sane register macros.
> > 
> > Commit 8409495bf6c9 ("net: stmmac: cores: remove many xxx_SHIFT
> > definitions") changed the way the txpbl value is merged into the
> > register:
> > 
> >         value = readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
> > -       value = value | (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> > +       value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);
> > 
> > With the following in the header file:
> > 
> >  #define DMA_BUS_MODE_PBL               BIT(16)
> > -#define DMA_BUS_MODE_PBL_SHIFT         16
> > 
> > The assumption here was that DMA_BUS_MODE_PBL was the mask for
> > DMA_BUS_MODE_PBL_SHIFT, but this turns out not to be the case.
> > 
> > The field is actually six bits wide, buts 21:16, and is called
> > TXPBL.
> > 
> > What's even more confusing is, there turns out to be a PBLX8
> > single bit in the DMA_CHAN_CONTROL register (0x1100 for channel 0),
> > and DMA_BUS_MODE_PBL seems to be used for that. However, this bit
> > et.al. was listed under a comment "/* DMA SYS Bus Mode bitmap */"
> > which is for register 0x1004.
> > 
> > Fix this up by adding an appropriately named field definition under
> > the DMA_CHAN_TX_CONTROL() register address definition.
> > 
> > Move the RPBL mask definition under DMA_CHAN_RX_CONTROL(), correctly
> > renaming it as well.
> > 
> > Also move the PBL bit definition under DMA_CHAN_CONTROL(), correctly
> > renaming it.
> > 
> > This removes confusion over the PBL fields.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Good job finding the problem ! However you need a Fixes tag, even though
> ths is is for net-next.

I really give up with when fixes should be added or not, because it
seems quite random when it's needed and when it isn't.

And no, don't quote the stable-kernel-rules nonsense that is
meaningless ot stable kernel people, when they use AI to analyse
commits and pick stuff completely randomly.

> It would also have been nice to be in CC, I spent some time on the bisect...

I thought you were, but I see now it was a different Maxime!

> Besides that, problem solved on an imx8mp setup :)
> 
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

