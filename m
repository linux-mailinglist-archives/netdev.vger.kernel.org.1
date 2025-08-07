Return-Path: <netdev+bounces-212094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8217B1DD6A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 21:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933B17216F0
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFE1A8F84;
	Thu,  7 Aug 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y7R35Ggh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE20143748
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594144; cv=none; b=J0qZbiZS0lLFgeekPRdSWnD8qSzQ7x0LI2RPyU+mhzh6prBSkaH18cCMZFq26Z7/0L1MpsiW9HGKvYicpXQCYzn6A5Kl3hkCwe3cIkLY1FeQLpuYkBLThyjk4btsJKx6YJNAzzB6BbJQ6KySeM5O/V4r6ay3YN1+FqPyVxqwb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594144; c=relaxed/simple;
	bh=kDFfxu37Oy0VOTzAqLpTHhH4gLQwPm1aW+ZU6CGO6gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl8vLedptEp+uYQ8LRL/4b92SX6Y6v020ULakc0bUHmIGbtXcpTWvu236V4D5Qvxf/1wKvnPiKJ7ndgOfhzsdys4QMfmZ0V5CVfrMBN/7TkFz0VQQW179BiOTrR8OXzpaoWXEQCpJztNAKXAB3u0HidNDsHjB1Rdsuh+Ep457EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y7R35Ggh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VTJAmK/RuqPGqNceQRqXn7WqL1onxDBkB7rg1B+KpRc=; b=y7R35GghiBYgAKpVICZVirOPT8
	5h7mM1XI90jlP/RPcoTWrygIdPQ5PPobGdFATPVC/YraPpasd6kXlCDSjNTBnIoiqUY8Cn4+tMuNL
	7ZIjqwrvBr9hqELYrBOGgZxqq5XmvoXEXPTA5clZE5gc4/zm4pBZXQKhckgw2gyJcFFyBhciRfv0U
	DuE/L63jFzmVKau62VmE6UIC0k2aOX/TUlgheRn9goZuadMp72U5CoYGE2bPIh/Rv5z4+j/6rmGki
	JBIwT1/sfM3o3toZHau7DVYhIPrhQhnnn3XzL2Z5U8Nr+vZ0uXd5ybIaM2OMr0J7/wgiJxhjRWvjO
	0f4MKsGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uk65A-0006V3-1m;
	Thu, 07 Aug 2025 20:15:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uk654-0008LM-0X;
	Thu, 07 Aug 2025 20:15:14 +0100
Date: Thu, 7 Aug 2025 20:15:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, David Wu <david.wu@rock-chips.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: stmmac: rk: put the PHY clock on remove
Message-ID: <aJT7QTzT_AHmkS6H@shell.armlinux.org.uk>
References: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>
 <20250807183359.GO61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807183359.GO61519@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 07, 2025 at 07:33:59PM +0100, Simon Horman wrote:
> On Thu, Aug 07, 2025 at 09:48:30AM +0100, Russell King (Oracle) wrote:
> > The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
> > doesn't take part in the devm release. Therefore, when a device is
> > unbound, this clock needs to be explicitly put. Fix this.
> > 
> > Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Spotted this resource leak while making other changes to dwmac-rk.
> > Would be great if the dwmac-rk maintainers can test it.
> > 
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 79b92130a03f..4a315c87c4d0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -1770,6 +1770,9 @@ static void rk_gmac_remove(struct platform_device *pdev)
> >  	stmmac_dvr_remove(&pdev->dev);
> >  
> >  	rk_gmac_powerdown(bsp_priv);
> > +
> > +	if (plat->phy_node && bsp_priv->integrated_phy)
> > +		clk_put(bsp_priv->clk_phy);
> 
> Hi Russell,
> 
> Something seems a little off here.
> I don't see plat in this context in net.

Already have a fix for it, thanks anyway. Today ended up going awol
due to dentistry stuff. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

