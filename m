Return-Path: <netdev+bounces-212091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BCB1DD29
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 20:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A085851E7
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA221FBE80;
	Thu,  7 Aug 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpmPWgtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAA18BBB9
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591645; cv=none; b=XigLyXt/MoXSmEKF5IUrO2zCvFEgBrrMesS7wAROGPbFyHqvMBARlKY3sh7evuxoLoguzxKeGXvHPOFsUNxl5WPxtzpz8MyDN+BcogNWwGJLpmZPIlQQv0x7POP54BeDVQKhTPxOt/1iaVxTAk5m+GQ4dbLpNckPFQoa+XQpt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591645; c=relaxed/simple;
	bh=loZ2Dv1nU1wHg8IXgsAmVe1JV3DP7oTgPbO/b4U/h1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwCo0zm7AcSYiVEPRCxtRoj0NxASpKW9iaexXyWVD+uTOMt5jQw7lrUf+8QeA1++rlPNSFJcsGs5b7LxSoqlj2D8wAWAc4xjO4HsCDtzr3ipFzWK4wzb7QFoIWrDzk8X/9+vcicCcCEin4XeWbpQxhB1jpQWPg1rQ7v+zCS4Rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpmPWgtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1F9C4CEF6;
	Thu,  7 Aug 2025 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591644;
	bh=loZ2Dv1nU1wHg8IXgsAmVe1JV3DP7oTgPbO/b4U/h1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpmPWgtNr6JME9JZZzgXleZTqAeizkiuPh+hBP0wMVFh6Kx1clun8/mB0+srli9cF
	 iVEjDKD3FUZFp6vN3dnM2+mddVmgrvuFAjDEmaUspyPnYhXh4rsCf3PC3wQCnaUzIT
	 bIp8aTpekWizMp5S7ubJshcrZRFcJeLo22Wy2LPSKHDmHW5F5egGSfpEPsiTMCxaE4
	 b9l2E9D30swgyyX0QYaqu7NV+yRUiVTRs872rZa134SbSDplPhbz8iy0sVy+ublcZP
	 qIYECWImVuKooyKXWddzPlJBIhKyH5ZD0JOc9VFME5xtGphWq++8c5tdmetEbwGHwj
	 VxJTRm4IumZxA==
Date: Thu, 7 Aug 2025 19:33:59 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Message-ID: <20250807183359.GO61519@horms.kernel.org>
References: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>

On Thu, Aug 07, 2025 at 09:48:30AM +0100, Russell King (Oracle) wrote:
> The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
> doesn't take part in the devm release. Therefore, when a device is
> unbound, this clock needs to be explicitly put. Fix this.
> 
> Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Spotted this resource leak while making other changes to dwmac-rk.
> Would be great if the dwmac-rk maintainers can test it.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 79b92130a03f..4a315c87c4d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1770,6 +1770,9 @@ static void rk_gmac_remove(struct platform_device *pdev)
>  	stmmac_dvr_remove(&pdev->dev);
>  
>  	rk_gmac_powerdown(bsp_priv);
> +
> +	if (plat->phy_node && bsp_priv->integrated_phy)
> +		clk_put(bsp_priv->clk_phy);

Hi Russell,

Something seems a little off here.
I don't see plat in this context in net.

>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.30.2
> 

