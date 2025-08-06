Return-Path: <netdev+bounces-211857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B3B1BF18
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6708A1892DCD
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E658199FB0;
	Wed,  6 Aug 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ygHclmUz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812B1DEFF5;
	Wed,  6 Aug 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450119; cv=none; b=PRlkZY/KYUTBf5J8ZfnUW+bfpek9fl30HskZVsXuyVVlLQHm1cQDx1w6vkA2Jv+q74c18N6VZWaWbPwPQzaeRoQS2TSQIdHpysMcg82tWaDSWePC8kyenrqKiO9MDhydgBrIgra40vjnFQrUJCFvo9lskvjROPxhICKz/K9gE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450119; c=relaxed/simple;
	bh=sPrtmwwARRGLbmpSZeZG+QWuvEgNUV8jtG/H8k73wqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDFGHi+z1ISX02runRZc0ps5D4mDUhDTUNrl9+aFLtgRyI8EGS1rFrIlZGjpkTDy72Cshytx/tL2y6gQk6p52sK5nQab/DQBRuZvF7kKqUZDG5P7G2szWIZ26/84fnTqBjWiBAwwLSkOBc4a/+XixJ/7cgm3+3E0X6XzloCaGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ygHclmUz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oJH5KNGSYO4/UiYFErjzDJ3fGQHDSZzhyyZv4ILcihA=; b=ygHclmUzWU8YQkMYad2J6FVTlp
	rUSjmHiKNbUM3zFdh2+Cr9HummLeuNCQeaMp54HaQLsBKPxPNYl8OB31xcn4Rs8dfWGiQnmQWJyLW
	SDVh7XiHYTklCXvRZTXoEZM6QYcghtI1jXvF5e3dmNc79c3zpvvUGqGSTt9B8AJa2PnY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujUcD-003quH-UA; Wed, 06 Aug 2025 05:14:57 +0200
Date: Wed, 6 Aug 2025 05:14:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH] net: ethernet: stmmac: dwmac-rk: Make the clk_phy could
 be used for external phy
Message-ID: <3c401e82-169f-4540-9c12-175798ac72a6@lunn.ch>
References: <20250806011405.115-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806011405.115-1-kernel@airkyi.com>

On Wed, Aug 06, 2025 at 09:14:05AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> For external phy, clk_phy should be optional, and some external phy
> need the clock input from clk_phy. This patch adds support for setting
> clk_phy for external phy.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

net-next is closed at the moment for the merge window.

You also need the indicate the tree in the Subject: line.

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..703b4b24f3bc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1558,6 +1558,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>  	struct device *dev = &bsp_priv->pdev->dev;
>  	int phy_iface = bsp_priv->phy_iface;
>  	int i, j, ret;
> +	unsigned int rate;

Reverse Christmas tree. Longest to shortest.

>  
>  	bsp_priv->clk_enabled = false;
>  
> @@ -1595,12 +1596,19 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>  		clk_set_rate(bsp_priv->clk_mac, 50000000);
>  	}
>  
> -	if (plat->phy_node && bsp_priv->integrated_phy) {
> +	if (plat->phy_node) {
>  		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>  		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> -		if (ret)
> -			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> -		clk_set_rate(bsp_priv->clk_phy, 50000000);
> +		/* If it is not integrated_phy, clk_phy is optional */
> +		if (bsp_priv->integrated_phy) {
> +			if (ret)
> +				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> +
> +			ret = of_property_read_u32(plat->phy_node, "clock-frequency", &rate);

Is this property already in the DT binding?


    Andrew

---
pw-bot: cr

