Return-Path: <netdev+bounces-182428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0AFA88B1C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4413C1899AA0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5C28DEEC;
	Mon, 14 Apr 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F0+Mk7aB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624A28466C;
	Mon, 14 Apr 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655424; cv=none; b=BVb6DmIXTtIUyPz6m+okUVKw2Sc0dbppscyEUT3lfU53Xovoxtb5cuNJZ6jpL1rDm/nyKA9dM5I2mWOj0nKVriIZy/QQE7XL3SbNqOSbTfA2Wxjws2CRxCMe4exD+87TOka3ru6uOqx9ILybL53X2WCrh4//+yAsuFJuaHdhMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655424; c=relaxed/simple;
	bh=6HmJKQO2X4WyvpQqfOeCUt/KLjexAoDH+2V1AxIXnok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwMrDM+J3F184UlbPx82vf7DgSap74II99OuAaC0gz6TihgCk1EACydvo2JNauBQDaMrOxy0Fl/dbhAnUqcWW7K+VbWm0M5Zj4GuCUD82O12JXskkV95wjJqKt8yN/jMdga86TJi3sZ6TSQhlgANwFEP0m3bt5upJojyjs+ha38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F0+Mk7aB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KvrP4YX9S88PE5IGWj9XQEJrki5oMuCrrMt/Wwr1Hxw=; b=F0+Mk7aBUK+0Qn8yr3+0zXWTV4
	Y6tEaB+VVFzxQ5xMlEqWLRg99PhfBRfcefiA++Hi/koQtHGy5Xe2qzxrpHUFoy/+55OKQufU3Yin5
	XPnHk7xWytSkie8IVd5hishRde0WcEpsneqeOJ/tD8dy/tTdSo9EGks8j9H4F/YkGs6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4OZI-009FcJ-GO; Mon, 14 Apr 2025 20:30:04 +0200
Date: Mon, 14 Apr 2025 20:30:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bo-Cun Chen <bc-bocun.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/5] net: ethernet: mtk_eth_soc: revise mdc divider
 configuration
Message-ID: <6c36505c-7af3-49f5-9141-8a655f90a2f9@lunn.ch>
References: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>

On Mon, Apr 14, 2025 at 07:11:20PM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> In the current method, the MDC divider was reset to the default setting
> of 2.5MHz after the NETSYS SER. Therefore, we need to move the MDC
> divider configuration function to mtk_hw_init().
> 
> Fixes: c0a440031d431 ("net: ethernet: mtk_eth_soc: set MDIO bus clock frequency")
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 60 ++++++++++++++-------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 43197b28b3e74..fd643cc1b7dd2 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -871,11 +871,11 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
>  	.mac_enable_tx_lpi = mtk_mac_enable_tx_lpi,
>  };
>  
> -static int mtk_mdio_init(struct mtk_eth *eth)
> +static int mtk_mdio_config(struct mtk_eth *eth)
>  {
>  	unsigned int max_clk = 2500000, divider;
>  	struct device_node *mii_np;
> -	int ret;
> +	int ret = 0;
>  	u32 val;
>  
>  	mii_np = of_get_available_child_by_name(eth->dev->of_node, "mdio-bus");
> @@ -884,22 +884,6 @@ static int mtk_mdio_init(struct mtk_eth *eth)
>  		return -ENODEV;
>  	}
>  
> -	eth->mii_bus = devm_mdiobus_alloc(eth->dev);
> -	if (!eth->mii_bus) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> -
> -	eth->mii_bus->name = "mdio";
> -	eth->mii_bus->read = mtk_mdio_read_c22;
> -	eth->mii_bus->write = mtk_mdio_write_c22;
> -	eth->mii_bus->read_c45 = mtk_mdio_read_c45;
> -	eth->mii_bus->write_c45 = mtk_mdio_write_c45;
> -	eth->mii_bus->priv = eth;
> -	eth->mii_bus->parent = eth->dev;
> -
> -	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
> -
>  	if (!of_property_read_u32(mii_np, "clock-frequency", &val)) {
>  		if (val > MDC_MAX_FREQ || val < MDC_MAX_FREQ / MDC_MAX_DIVIDER) {
>  			dev_err(eth->dev, "MDIO clock frequency out of range");
> @@ -922,6 +906,42 @@ static int mtk_mdio_init(struct mtk_eth *eth)
>  
>  	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / divider);
>  
> +err_put_node:
> +	of_node_put(mii_np);
> +	return ret;
> +}
> +
> +static int mtk_mdio_init(struct mtk_eth *eth)
> +{
> +	struct device_node *mii_np;
> +	int ret;
> +
> +	mii_np = of_get_child_by_name(eth->dev->of_node, "mdio-bus");
> +	if (!mii_np) {
> +		dev_err(eth->dev, "no %s child node found", "mdio-bus");
> +		return -ENODEV;
> +	}
> +
> +	if (!of_device_is_available(mii_np)) {
> +		ret = -ENODEV;
> +		goto err_put_node;
> +	}

It seems like you end up doing these checks twice. In theory it might
change between the calls, but it is very unlikely? Maybe just keep
node reference returned by of_get_child_by_name() and release it in
mtk_mdio_cleanup()?

Or calculate the divider in mtk_mdio_init() as is, but store it away
in struct mtk_eth, so you don't need to redo all the DT parsing?

	Andrew

