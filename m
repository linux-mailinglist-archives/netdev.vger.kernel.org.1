Return-Path: <netdev+bounces-47206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EC7E8C92
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620EA1F20F51
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E31D6A4;
	Sat, 11 Nov 2023 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bJrYI3i0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665E1CF9C
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 20:24:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D544D72
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PFfPrO+9zhsMY6RMZEKoGHdyJC9jK44NAuRN+rek0aM=; b=bJrYI3i04XFAcm6KBFnNvQIrfH
	5D/wMWFkeKIc1kCO5+DCSf1+z5KezBgby0orCCaBZOaQFT2leon9TfTX8c9tDMb/IPZw5rGWE3t9N
	NjjFpgGpAGjp5U/l8rph/VO4Thu/9qdk22UF+vtrfE7BCz0ZiA/LbcJ6CiezQtGEr0LM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1uX2-001NBK-28; Sat, 11 Nov 2023 21:24:40 +0100
Date: Sat, 11 Nov 2023 21:24:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 5/9] net: stmmac: dwmac-loongson: Add full PCI support
Message-ID: <52a727bb-29d0-4d5c-9043-95903f7b9892@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <0e9dd61f05571b01de369e449106db3ac2dd56da.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9dd61f05571b01de369e449106db3ac2dd56da.1699533745.git.siyanteng@loongson.cn>

> -	res.irq = of_irq_get_byname(np, "macirq");
> -	if (res.irq < 0) {
> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> -	}
> -
> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -	if (res.wol_irq < 0) {
> -		dev_info(&pdev->dev,
> -			 "IRQ eth_wake_irq not found, using macirq\n");
> -		res.wol_irq = res.irq;
> -	}
> -
> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -	if (res.lpi_irq < 0) {
> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> +	if (np) {
> +		res.irq = of_irq_get_byname(np, "macirq");
> +		if (res.irq < 0) {
> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +
> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +		if (res.wol_irq < 0) {
> +			dev_info(&pdev->dev,
> +				 "IRQ eth_wake_irq not found, using macirq\n");
> +			res.wol_irq = res.irq;
> +		}
> +
> +		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +		if (res.lpi_irq < 0) {
> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}

This is where a refactoring patch is useful. Have one patch which
moves this code into a helper function. The commit message can say it
just moves code around, but there is no functional change. The second
patch then moves the call to the helper inside the if (np).

      Andrew


