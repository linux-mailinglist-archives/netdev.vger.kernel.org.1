Return-Path: <netdev+bounces-122764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA19627A8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954971F27F26
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568217837D;
	Wed, 28 Aug 2024 12:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBD176259;
	Wed, 28 Aug 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849300; cv=none; b=VTm8SQ6X5Y0b0wk+5Wrhf5HvyuIZKQJM/VZsVcwCbQB/U61//YTbcEjbB8dKIyLzqcFg1mq2y/yUK0HEWt56nbejceEQcDCRCBvML0qbh74iEPQKNiRO5bUPSt0DPDPM8sSgufGJIrEMp81/uw2MPgt28/LbssHzy0DaiL5hlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849300; c=relaxed/simple;
	bh=pSIT8jogu9fH+HAd7BSCp8MKhnBphymb1oTOJhpLaJk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3lLFv4aS4wfi59DZootwAdcx9waB2Y4J5yz/Dqe8asCORpjHa3WlxSVnv36BIbrhl9ZEEWMGspCUHtOD74Q/zvfMzqL9FCbo6oi0ebDKn3YZ/w3EQB2J/VGC8Txeg0x8chko3P0gCb2E4dOvMn5eACqdOOYmwdXX323QeWd+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3z01DSdz6H7Wv;
	Wed, 28 Aug 2024 20:45:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 665B814038F;
	Wed, 28 Aug 2024 20:48:16 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:48:15 +0100
Date: Wed, 28 Aug 2024 13:48:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
Subject: Re: [PATCH net-next v2 08/13] net: mdio: mux-mmioreg: Simplified
 with dev_err_probe()
Message-ID: <20240828134814.0000569d@Huawei.com>
In-Reply-To: <20240828032343.1218749-9-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
	<20240828032343.1218749-9-ruanjinjie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 11:23:38 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use the dev_err_probe() helper to simplify code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Ah. I should have read next patch. Sorry!

Might be worth breaking from rule of aligning parameters
after brackets to keep the longest line lengths down.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Split into 2 patches.
> ---
>  drivers/net/mdio/mdio-mux-mmioreg.c | 45 ++++++++++++-----------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
> index 4d87e61fec7b..08c484ccdcbe 100644
> --- a/drivers/net/mdio/mdio-mux-mmioreg.c
> +++ b/drivers/net/mdio/mdio-mux-mmioreg.c
> @@ -109,30 +109,26 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ret = of_address_to_resource(np, 0, &res);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not obtain memory map for node %pOF\n",
> -			np);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not obtain memory map for node %pOF\n", np);
>  	s->phys = res.start;
>  
>  	s->iosize = resource_size(&res);
>  	if (s->iosize != sizeof(uint8_t) &&
>  	    s->iosize != sizeof(uint16_t) &&
>  	    s->iosize != sizeof(uint32_t)) {
> -		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "only 8/16/32-bit registers are supported\n");
>  	}
>  
>  	iprop = of_get_property(np, "mux-mask", &len);
> -	if (!iprop || len != sizeof(uint32_t)) {
> -		dev_err(&pdev->dev, "missing or invalid mux-mask property\n");
> -		return -ENODEV;
> -	}
> -	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8)) {
> -		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
> -		return -EINVAL;
> -	}
> +	if (!iprop || len != sizeof(uint32_t))
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "missing or invalid mux-mask property\n");
> +	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8))
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "only 8/16/32-bit registers are supported\n");
>  	s->mask = be32_to_cpup(iprop);
>  
>  	/*
> @@ -142,17 +138,14 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
>  	for_each_available_child_of_node_scoped(np, np2) {
>  		u64 reg;
>  
> -		if (of_property_read_reg(np2, 0, &reg, NULL)) {
> -			dev_err(&pdev->dev, "mdio-mux child node %pOF is "
> -				"missing a 'reg' property\n", np2);
> -			return -ENODEV;
> -		}
> -		if ((u32)reg & ~s->mask) {
> -			dev_err(&pdev->dev, "mdio-mux child node %pOF has "
> -				"a 'reg' value with unmasked bits\n",
> -				np2);
> -			return -ENODEV;
> -		}
> +		if (of_property_read_reg(np2, 0, &reg, NULL))
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "mdio-mux child node %pOF is missing a 'reg' property\n",
> +					     np2);
> +		if ((u32)reg & ~s->mask)
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
I'd align these super long ones as. 
			     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
It is ugly but then so are > 100 char lines.
> +					     np2);
>  	}
>  
>  	ret = mdio_mux_init(&pdev->dev, pdev->dev.of_node,


