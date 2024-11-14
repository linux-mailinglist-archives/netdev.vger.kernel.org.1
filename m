Return-Path: <netdev+bounces-144936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9469C8CB4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29451F22507
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2583BBEB;
	Thu, 14 Nov 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O3ta6huY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57D3987D;
	Thu, 14 Nov 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593982; cv=none; b=mmxIFKDWjuQYH5dY+9n8ZnSrN/M2IeFkshYYbASZyTThsougaveKjKgpFVxD5yvG1NqN8T/VopWfaOvuCAN51bcNKuUKD9etXJwAx2+g2wp98GpkfMeM3ifbPcheH0h6dFMCZkn+f7FlM8LA5qZmNYAvpSKu/Bc1yVFfZxZe34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593982; c=relaxed/simple;
	bh=aUGDcjVPNu0PoDxYd0OUr5SXSZIVMo9B38h213Ax6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzjLvYCBiQ/5SOMyW54xxLbAToc1/EyoewjoNY6hap/DirC2NCGKtcS8ucD5NT3VjJ6EXf9XDE9jrdi3TeccxeqEa2KViwX5YmUrHMYO0rzUMHg1zWjMRbH48XjU8JrSY92WMmuVFqURS1VcjsTFemhnFGdSTcfRkwRItpjc36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O3ta6huY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0DyiD3ejpKkSu4mppJ+GQZe5KVQL/VUrRw8jSsk28p4=; b=O3ta6huYE8104TF8jA5dPpYfrC
	XGQ+YiXAo+PzqMREZZzEfi/V9yb4N/GZXXIZ+yMv6AjEifbrygBdtC7Hf7c9/fEWnF6FPsiuiMXY7
	i5PqfQpZvKYO3+J0+FR5agPTqRkuAaSclbPC5lHnqvENomg+BS/mdONRl6bj85zJ0tkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBags-00DIzU-Ir; Thu, 14 Nov 2024 15:19:22 +0100
Date: Thu, 14 Nov 2024 15:19:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 2/2] net: stmmac: set initial EEE policy
 configuration
Message-ID: <a6cbf428-4672-4beb-8c55-e4d3ae684458@lunn.ch>
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
 <20241114081653.3939346-3-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114081653.3939346-3-yong.liang.choong@linux.intel.com>

On Thu, Nov 14, 2024 at 04:16:53PM +0800, Choong Yong Liang wrote:
> Set the initial eee_cfg values to have 'ethtool --show-eee ' display
> the initial EEE configuration.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7bf275f127c9..5fce52a9412e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1204,7 +1204,7 @@ static int stmmac_init_phy(struct net_device *dev)
>  			netdev_err(priv->dev, "no phy at addr %d\n", addr);
>  			return -ENODEV;
>  		}
> -
> +		phy_support_eee(phydev);
>  		ret = phylink_connect_phy(priv->phylink, phydev);

Is supporting EEE a synthesis option, or is it always available?

Some EEE code is guarded by:

        if (!priv->dma_cap.eee)
                return -EOPNOTSUPP;

	Andrew

