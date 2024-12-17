Return-Path: <netdev+bounces-152598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E249F4C49
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A45174576
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B441F428D;
	Tue, 17 Dec 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DxdZ2zbb"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE731F03E8;
	Tue, 17 Dec 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441566; cv=none; b=HGy+1nmc11F7UojC8ikzkkjpkWHU8di3GoQ7Cns/gvJNmbpm9YfEJQSX+bfvhNiqrt4Tx0WOSablZMbQ1UaFn8Pe9TeJs/oEh2oFQTGyoPQZqxmtccUaGquFrFB1imcLd5jdmv18Doobjdbq/0nDnIsF2m8FpJ5X32w5APrZZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441566; c=relaxed/simple;
	bh=A8fII84AFmjcafFwK5VTw+0G0huOuWv2dJPM8L5Hf0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhawIyPgzJF09x5QKNYum8KCwqKKbyJJMZlZKBr2uZhCOLMg2AVF7vn0yttOozcB8pW8rj5WlXwZcIluW8+jLX9TuJSo8BEvfMifOETwhfUjXWnAVExw/Lw+SUfu9QH6N44TOco9KiutKWDyeYXfpzIafTxmuYLWZ1ikkF9eGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DxdZ2zbb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A297C000C;
	Tue, 17 Dec 2024 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734441556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUvAF8nNh95eCP+DJf/kow70CTWmtALCQZrGVyhyTco=;
	b=DxdZ2zbbF9lT2rC9CkWB74l9vT5Dd/ap3ZVFqQhl+iuUntR7iTeWMeBIM9cgAynMsFp1QU
	6jerE5mJBZ3SgAXJ4nh//VZbyCfDGhp5j0QBWFWWZThca7x9uOKfWL0sKzzUg/D4qEo+oo
	VHci9RDcY7P08cW97PcYF+zzjjJATwEFYpMFojaWxvKf/Y2pkLGX3w4YB6vVy6XCyCp4GY
	zcW6PTtzazInS0ktppzzY4Ui5RsjY8Un0rexPzG/pZ8PMBSiJCaI6xzVEOUj5SKz9vbTsE
	xOMfvE1igIujLiMl5NHBzAsQ5IgUIt5/xMVqkt7nITzwNsxSzPOhs/qIqrHrow==
Date: Tue, 17 Dec 2024 14:19:12 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: stmmac: use PCS supported_interfaces
Message-ID: <20241217141912.34cdd5ae@fedora.home>
In-Reply-To: <E1tMBRQ-006vat-7F@rmk-PC.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<E1tMBRQ-006vat-7F@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Fri, 13 Dec 2024 19:35:12 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Use the PCS' supported_interfaces member to build the MAC level
> supported_interfaces bitmap.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d45fd7a3acd5..0e45c4a48bb5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1206,6 +1206,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  	struct stmmac_mdio_bus_data *mdio_bus_data;
>  	int mode = priv->plat->phy_interface;
>  	struct fwnode_handle *fwnode;
> +	struct phylink_pcs *pcs;
>  	struct phylink *phylink;
>  
>  	priv->phylink_config.dev = &priv->dev->dev;
> @@ -1227,8 +1228,14 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  
>  	/* If we have an xpcs, it defines which PHY interfaces are supported. */
>  	if (priv->hw->xpcs)
> -		xpcs_get_interfaces(priv->hw->xpcs,
> -				    priv->phylink_config.supported_interfaces);
> +		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
> +	else
> +		pcs = priv->hw->phylink_pcs;
> +
> +	if (pcs)
> +		phy_interface_or(priv->phylink_config.supported_interfaces,
> +				 priv->phylink_config.supported_interfaces,
> +				 pcs->supported_interfaces);
>  
>  	fwnode = priv->plat->port_node;
>  	if (!fwnode)

I think that we could even make xpcs_get_interfaces a static
non-exported function now :) But this can be done in a subsequent patch.

Thanks for that work !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

