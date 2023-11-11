Return-Path: <netdev+bounces-47205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F417E8C8C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD9A2812A6
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE31D55A;
	Sat, 11 Nov 2023 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dCH3rscT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4381D552
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 20:19:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B843A82
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wL2afnAABF+Db7RS2p7nT0FMmnt7WpY28TOFnNTBOG4=; b=dCH3rscT5Whhf4tO9eoCnFRvv2
	fn4t1bMl7W3px+4/BHxP/0eWj5KBbwBr7arkfxY9gOBPviEXSmkgYTeK11f69+qy86Pvf1K5XYt5S
	qMay9n0Qw8yOUbN8Lj9XYctb74/LM/Kp5SSoPNCHyyyAbMqDS2odg2DUbhOq7493FOFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1uRu-001N9j-08; Sat, 11 Nov 2023 21:19:22 +0100
Date: Sat, 11 Nov 2023 21:19:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 4/9] net: stmmac: dwmac-loongson: Refactor code for
 loongson_dwmac_probe()
Message-ID: <3c59e90d-7e13-43de-a213-b08bc5696ee0@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <5f659ea8ab3a90ab27b99dfa24b05c20f3698545.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f659ea8ab3a90ab27b99dfa24b05c20f3698545.1699533745.git.siyanteng@loongson.cn>

On Fri, Nov 10, 2023 at 05:25:43PM +0800, Yanteng Si wrote:
> Add a setup() function to initialize data, and simplify code for
> loongson_dwmac_probe().

This does not look like a refactoring patch. Such patches just move
code around, but otherwise leave the code alone. There are real
changes in here.

> -	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
> -		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
> -		return -ENODEV;
> -	}
> -

This just disappears. Why is it no longer needed?


>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
>  		return -ENOMEM;
>  
> +	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> +					   sizeof(*plat->mdio_bus_data),
> +					   GFP_KERNEL);
> +	if (!plat->mdio_bus_data)
> +		return -ENOMEM;
> +
> +	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
> +				     GFP_KERNEL);
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
> +
>  	plat->mdio_node = of_get_child_by_name(np, "mdio");
>  	if (plat->mdio_node) {
>  		dev_info(&pdev->dev, "Found MDIO subnode\n");
> -
> -		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> -						   sizeof(*plat->mdio_bus_data),
> -						   GFP_KERNEL);
> -		if (!plat->mdio_bus_data) {
> -			ret = -ENOMEM;
> -			goto err_put_node;
> -		}

MDIO was conditional, but now is mandatory. Why? 

>  	if (ret) {
> -		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
> +		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
> +			__func__);

Changes like this are a distraction. The reviewer is trying to
understand what has changed and why. If you want to make white space
changes, please do it in a patch of its own.

Please break this patch up into lots of smaller parts, each with a
good commit messaged explaining what is going on, and importantly,
why.

	Andrew

