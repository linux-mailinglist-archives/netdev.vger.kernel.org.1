Return-Path: <netdev+bounces-122864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FD962DB8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292181F24CC7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042791A3BDB;
	Wed, 28 Aug 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR5/59CT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B61A7042;
	Wed, 28 Aug 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862749; cv=none; b=F/MY3G90y7sUC18UHCWGbG48ya25CTmpNNtkyumm49suU5Xx/aIh4ElJGzlO1XhjlVtmU8a8jWKMnsV7a58f5aDBTGb78Q8/3gTpfpyfoaiRxaMtuun8QqvvwPu0p5Rav0cNJ1F7BmVAeLUHudweWi5e3758kM8RQnOs2ZtVe5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862749; c=relaxed/simple;
	bh=IcOpHz8GgohndUTMyAYMIG+hCu7kJbe6e1APBKfYgPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZwSUolYhqLa9JXrskZUauBHbhJmvmXX4tGTQ/snc2LneLeobpI89DFTc3Hicj8qJg40DLiTMq1PGAreEeAWb4B2Wjc6hXS/Iy8SD9KPhlw322l//yKFCs5VWgU7IPSM3F+v9y0BGsembgqnvnUF31lxTNRgtIfKpJQyAqBy/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR5/59CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433E5C515B4;
	Wed, 28 Aug 2024 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862749;
	bh=IcOpHz8GgohndUTMyAYMIG+hCu7kJbe6e1APBKfYgPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR5/59CTcmE9y0TjuQtpRRU3O8DmJUlgFo4Y3OfmCeqIgIPRE4+iuwlxl+bC5IsIE
	 gOXLu02v+azXCkwZ0eRQPL5UavCwaAq5b9aMsznsCN1YvMX9YFvIiX07ApHGdRN9Er
	 pCEJo7LHnlfTP/Jf5UKH3EukXS7kRH1Igoi71h4PRA+PLaLfuyggj6/FYeNUS5RfzR
	 48neoiCmzP/+8UggeZ5ic1cAanCrHwwYo5exk6A++87m0f1fb/qG2b6cX4YBKKlUuj
	 60Z25CRgS416qfMPZlbg2HmXe1Y0MshwxeUoMlSIL9uTD1rMqLZE05g4LvQoDqujex
	 f4aeE+c9aSomQ==
Date: Wed, 28 Aug 2024 17:32:24 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 6/6] net: ethernet: fs_enet: phylink conversion
Message-ID: <20240828163224.GT1368797@kernel.org>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
 <20240828095103.132625-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828095103.132625-7-maxime.chevallier@bootlin.com>

On Wed, Aug 28, 2024 at 11:51:02AM +0200, Maxime Chevallier wrote:
> fs_enet is a quite old but still used Ethernet driver found on some NXP
> devices. It has support for 10/100 Mbps ethernet, with half and full
> duplex. Some variants of it can use RMII, while other integrations are
> MII-only.
> 
> Add phylink support, thus removing custom fixed-link hanldling.
> 
> This also allows removing some internal flags such as the use_rmii flag.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi Maxime,

Some minor issues from my side: not a full review by any stretch of
the imagination.

...

> @@ -911,7 +894,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
>  	if (!IS_ERR(clk)) {
>  		ret = clk_prepare_enable(clk);
>  		if (ret)
> -			goto out_deregister_fixed_link;
> +			goto out_phylink;
>  
>  		fpi->clk_per = clk;
>  	}

This goto will result in a dereference of fep.
But fep is not initialised until the following line,
which appears a little below this hunk.

	fep = netdev_priv(ndev);

This goto will also result in the function returning without
releasing clk.

Both flagged by Smatch.

> @@ -936,6 +919,26 @@ static int fs_enet_probe(struct platform_device *ofdev)
>  	fep->fpi = fpi;
>  	fep->ops = ops;
>  
> +	fep->phylink_config.dev = &ndev->dev;
> +	fep->phylink_config.type = PHYLINK_NETDEV;
> +	fep->phylink_config.mac_capabilities = MAC_10 | MAC_100;
> +
> +	__set_bit(PHY_INTERFACE_MODE_MII,
> +		  fep->phylink_config.supported_interfaces);
> +
> +	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec"))
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  fep->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&fep->phylink_config, dev_fwnode(fep->dev),
> +				 phy_mode, &fs_enet_phylink_mac_ops);
> +	if (IS_ERR(phylink)) {
> +		ret = PTR_ERR(phylink);
> +		goto out_free_fpi;

This also appears to leak clk, as well as ndev.

I didn't look for other cases.

> +	}
> +
> +	fep->phylink = phylink;
> +
>  	ret = fep->ops->setup_data(ndev);
>  	if (ret)
>  		goto out_free_dev;
> @@ -968,8 +971,6 @@ static int fs_enet_probe(struct platform_device *ofdev)
>  
>  	ndev->ethtool_ops = &fs_ethtool_ops;
>  
> -	netif_carrier_off(ndev);
> -
>  	ndev->features |= NETIF_F_SG;
>  
>  	ret = register_netdev(ndev);
> @@ -988,10 +989,8 @@ static int fs_enet_probe(struct platform_device *ofdev)
>  	free_netdev(ndev);
>  out_put:
>  	clk_disable_unprepare(fpi->clk_per);
> -out_deregister_fixed_link:
> -	of_node_put(fpi->phy_node);
> -	if (of_phy_is_fixed_link(ofdev->dev.of_node))
> -		of_phy_deregister_fixed_link(ofdev->dev.of_node);
> +out_phylink:
> +	phylink_destroy(fep->phylink);
>  out_free_fpi:
>  	kfree(fpi);
>  	return ret;

...

