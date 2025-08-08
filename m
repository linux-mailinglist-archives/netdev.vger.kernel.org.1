Return-Path: <netdev+bounces-212172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA9B1E8F0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D70BA009A8
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B161627A925;
	Fri,  8 Aug 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFOwBdRs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BA27A451
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658603; cv=none; b=oUrxnU+6f0SGfUU6CbA0RG7DVkjTAMbPyLWCfzZ4+ZJuI5E7werrSeEWKKguYd1KO/9MVVn6SXlsEiTlbqEkGW30RYl6mW0yaDQgImbhCwBo8op9a6iOO7b34LodX6tvj2k1znioa8j7roHuCEKQOCGO5pd+RMw0F0Zv1I5IER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658603; c=relaxed/simple;
	bh=Ry/5UI73pZtdPKEskqZzyPIwhQo+s64pnx0FlVxe0dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLBy278Ztq32odHVFMVWBNMDHOCMIiUI+49URr6R4ObKqiheaS8UDYEyVBVndn39oX1+E8cTKZLOI2WrMWx08ygSZSnjzplmBGgv8q4yw9OrZxwgEqF9Qcd07CteBrdpAcE/4cvLYosavhHEPPs6gToUQ7Dd/JIrjx94d6QoTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFOwBdRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BAAC4CEED;
	Fri,  8 Aug 2025 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754658602;
	bh=Ry/5UI73pZtdPKEskqZzyPIwhQo+s64pnx0FlVxe0dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFOwBdRshhFKDGtm6ZJNi50fc33bSOPHC1hQMCtSk20p3W1WQd2f4JcdQCjINzeXX
	 Dh3LLcw/aZAB8B849z6ypCLJC4025T1Ko/yKIXpt7bXG6W2MJOaHAaCF+qy7X3Gcua
	 2YoqTry90teKprfUWIlirzavBwIxyfTD2LIU5sE6UP+lTuOciJzRkcrg4OKNV+YqFu
	 2uMdlNe3iQ0VjaZJcTxh+vIyCFc9FtIQoJQeIPYsQ1oUpSHav9HCfMMMQBLI76a+M7
	 sut8kVIa4+QLyekrP1S06cNVMJKu58YlBl8ZNSRi5s30vx9DMof01qfsaJFJPniV+U
	 MFGC2fdQ/1xmw==
Date: Fri, 8 Aug 2025 14:09:57 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <20250808130957.GB1705@horms.kernel.org>
References: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>
 <20250807183359.GO61519@horms.kernel.org>
 <aJT7QTzT_AHmkS6H@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJT7QTzT_AHmkS6H@shell.armlinux.org.uk>

On Thu, Aug 07, 2025 at 08:15:13PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 07, 2025 at 07:33:59PM +0100, Simon Horman wrote:
> > On Thu, Aug 07, 2025 at 09:48:30AM +0100, Russell King (Oracle) wrote:
> > > The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
> > > doesn't take part in the devm release. Therefore, when a device is
> > > unbound, this clock needs to be explicitly put. Fix this.
> > > 
> > > Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > > Spotted this resource leak while making other changes to dwmac-rk.
> > > Would be great if the dwmac-rk maintainers can test it.
> > > 
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > index 79b92130a03f..4a315c87c4d0 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > @@ -1770,6 +1770,9 @@ static void rk_gmac_remove(struct platform_device *pdev)
> > >  	stmmac_dvr_remove(&pdev->dev);
> > >  
> > >  	rk_gmac_powerdown(bsp_priv);
> > > +
> > > +	if (plat->phy_node && bsp_priv->integrated_phy)
> > > +		clk_put(bsp_priv->clk_phy);
> > 
> > Hi Russell,
> > 
> > Something seems a little off here.
> > I don't see plat in this context in net.
> 
> Already have a fix for it, thanks anyway. Today ended up going awol
> due to dentistry stuff. :(

Thanks, I see the fix now.
Hope your AFK mission went well.

