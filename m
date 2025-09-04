Return-Path: <netdev+bounces-219890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0BB439AC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F024D587ED1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F612FC01F;
	Thu,  4 Sep 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iFIfUCLu"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FD2FC00C;
	Thu,  4 Sep 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984454; cv=none; b=QtzwvxXRxZ2ee9imjXcZsOMWBqimUNJ0LKQS1Mdxe+I5kMOF5qMF1Ov/jdWAOIrHxmhmI/qVpwyTIlwIiz6wc3LECtEJKwGbjAq80n/VEfxjLCqKfuXBCubWk4ry17KB9bbqwQQBZ9ko7qFIjW9jvq8RVA4HWmFNTeiprx3XDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984454; c=relaxed/simple;
	bh=a9TgE+M7267BdTJIuw3gh/B6w3LpVMeRFli2D8fltPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJc3SYi96lwPIpfLaWbCKhh4EWNFIQTEpyb7+CT+IgLFx6tGSaf/yFYN1Vmn0P513Z1pW4mTNH/1JUE9xSJJ1+NdCSRU/xeE88g9FkGRcR5YlKxcHGK/J3jS+E1cclJA/AMB8v6knwDA+od6CCINQKeE3PhwGmnU/hvgQOmbEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iFIfUCLu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 480E922FC2;
	Thu,  4 Sep 2025 13:14:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH20WvHbfP0i; Thu,  4 Sep 2025 13:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756984448; bh=a9TgE+M7267BdTJIuw3gh/B6w3LpVMeRFli2D8fltPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFIfUCLuO/STk0WVtv2IgHQalzKuAMQ5N5EkPwTtlvH7OsMa5p0ToDE8BszzyEA1b
	 aLAu2FiJOxp7zHXhrQZDsHLZ/tE8yAm9G3Jh+7+bNh07rr4Q/4lQvgCpPdyx7ekqQf
	 6ry2lOjoW7Gdahi9UxNA4vaEOaXz0iaZMgyN+pJowizj8bDKgNX+2xaUj3uAqbYrYf
	 X2U+Dsm4NyNxWumzOaPSsV6E86eVL9YsZ/97k9zusBhy/DRNHpPEPxZlpIU7+r0+zY
	 8RuD8D+oP7WDF/C73vUnRPZvaa2cYeEVTctnLJi/pahfn7rLLq4EDqRS3dz31HRW0Y
	 SDFRMIyUbxiLA==
Date: Thu, 4 Sep 2025 11:13:53 +0000
From: Yao Zi <ziyao@disroot.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLl0cbYv-fY-tPpI@pie>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904103443.GH372207@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904103443.GH372207@horms.kernel.org>

On Thu, Sep 04, 2025 at 11:34:43AM +0100, Simon Horman wrote:
> On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > We must set the clk_phy pointer to NULL to indicating it isn't available
> > if the optional phy clock couldn't be obtained. Otherwise the error code
> > returned by of_clk_get() could be wrongly taken as an address, causing
> > invalid pointer dereference when later clk_phy is passed to
> > clk_prepare_enable().
> > 
> > Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > On next-20250903, the fixed commit causes NULL pointer dereference on
> > Radxa E20C during probe of dwmac-rk, a typical dmesg looks like
> > 
> > [    0.273324] rk_gmac-dwmac ffbe0000.ethernet: IRQ eth_lpi not found
> > [    0.273888] rk_gmac-dwmac ffbe0000.ethernet: IRQ sfty not found
> > [    0.274520] rk_gmac-dwmac ffbe0000.ethernet: PTP uses main clock
> > [    0.275226] rk_gmac-dwmac ffbe0000.ethernet: clock input or output? (output).
> > [    0.275867] rk_gmac-dwmac ffbe0000.ethernet: Can not read property: tx_delay.
> > [    0.276491] rk_gmac-dwmac ffbe0000.ethernet: set tx_delay to 0x30
> > [    0.277026] rk_gmac-dwmac ffbe0000.ethernet: Can not read property: rx_delay.
> > [    0.278086] rk_gmac-dwmac ffbe0000.ethernet: set rx_delay to 0x10
> > [    0.278658] rk_gmac-dwmac ffbe0000.ethernet: integrated PHY? (no).
> > [    0.279249] Unable to handle kernel paging request at virtual address fffffffffffffffe
> > [    0.279948] Mem abort info:
> > [    0.280195]   ESR = 0x000000096000006
> > [    0.280523]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    0.280989]   SET = 0, FnV = 0
> > [    0.281287]   EA = 0, S1PTW = 0
> > [    0.281574]   FSC = 0x06: level 2 translation fault
> > 
> > where the invalid address is just -ENOENT (-2).
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index cf619a428664..26ec8ae662a6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -1414,11 +1414,17 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
> >  	if (plat->phy_node) {
> >  		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> >  		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > -		/* If it is not integrated_phy, clk_phy is optional */
> > +		/*
> > +		 * If it is not integrated_phy, clk_phy is optional. But we must
> > +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
> > +		 * the error code could be wrongly taken as an invalid pointer.
> > +		 */
> >  		if (bsp_priv->integrated_phy) {
> >  			if (ret)
> >  				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> >  			clk_set_rate(bsp_priv->clk_phy, 50000000);
> > +		} else if (ret) {
> > +			bsp_priv->clk_phy = NULL;
> >  		}
> >  	}
> 
> Thanks, and sorry for my early confusion about applying this patch.
> 
> I agree that the bug you point out is addressed by this patch.
> Although I wonder if it is cleaner not to set bsp_priv->clk_phy
> unless there is no error, rather than setting it then resetting
> it if there is an error.

Yes, it sounds more natural to have a temporary variable storing result
of of_clk_get() and only assign it to clk_phy when the result is valid.

> More importantly, I wonder if there is another bug: does clk_set_rate need
> to be called in the case where there is no error and bsp_priv->integrated_phy
> is false?

In my understanding this may be intended, bsp_priv->integrated_phy is
only false when an external phy is used, and an external phy might
require arbitrary clock rates, thus it doesn't seem a good idea to me to
hardcode the clock rate in the driver.

I guess rate of clk_phy could also be set up with assigned-clock-rates
in devicetree. If so it may be reasonable to enable the clock only.

> So I am wondering if it makes sense to go with something like this.
> (Compile tested only!)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 266c53379236..a25816af2c37 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1411,12 +1411,16 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>  	}
>  
>  	if (plat->phy_node) {
> -		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> -		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> -		/* If it is not integrated_phy, clk_phy is optional */
> -		if (bsp_priv->integrated_phy) {
> -			if (ret)
> +		struct clk *clk_phy;
> +
> +		clk_phy = of_clk_get(plat->phy_node, 0);
> +		ret = PTR_ERR_OR_ZERO(clk_phy);
> +		if (ret) {
> +			/* If it is not integrated_phy, clk_phy is optional */
> +			if (bsp_priv->integrated_phy)
>  				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> +		} else {
> +			bsp_priv->clk_phy = clk_phy;
>  			clk_set_rate(bsp_priv->clk_phy, 50000000);
>  		}
>  	}
> 
> Please note: if you send an updated patch (against net) please
> make sure you wait 24h before the original post.
> 
> See: https://docs.kernel.org/process/maintainer-netdev.html

Thanks for the tip. While digging through the problematic commit for the
clk_phy's rate problem, I found others have discovered the problem[1]
and proposed some fixes (though there hasn't been a formal patch).

I should have read the original thread before sending this patch! Will
wait for some time and see whether the netdev maintainer prefers waiting
for original author's fix or taking mine.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/netdev/a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com/

