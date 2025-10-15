Return-Path: <netdev+bounces-229468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A544BDCAC6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A234A3C7F99
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF228FA91;
	Wed, 15 Oct 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="X+6mwWPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575F23236D;
	Wed, 15 Oct 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509074; cv=none; b=lHsvth66JkIXcRkmyPDOQ2SdLHmhMKRdbLMEn8W9m2l+yx6cpDbmV0izKCLtZbFeK6ZxANmgQ2ZJlIEAEfGkJyFpzb9RWMvuQw6VtungX5xYNfo987RzkcIU9SuacywrB55kDPkMOF6ZhvMra0GhNSNP3j1/5qJBZwHdRxy7b8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509074; c=relaxed/simple;
	bh=3DUiQzMFuD1q7gKq6cx3qFgLAsWUcWiBw2JF2wM1HGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBtOQbvb2IY6qji/Q956saFeju+taIRiwoyO8SBqyS88P847WDX0OuuOMnNGiEd0A4x54jb/5kYIF/HI5m8qge1X39+Z+93cDgCbfxaTCOJU0Hjy5kpuHjHtW67aU34s5aqQcYdbrdGRU55atvH3f6p/WPNE3kc+sv2rCEduhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=X+6mwWPD; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25f6e32a2;
	Wed, 15 Oct 2025 14:17:39 +0800 (GMT+08:00)
Message-ID: <4c9ec1ab-8833-4e07-a39c-ba502117866f@rock-chips.com>
Date: Wed, 15 Oct 2025 14:17:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dwmac-rk: No need to check the return value
 of the phy_power_on()
To: Lizhe <sensor1010@163.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, jonas@kwiboo.se, david.wu@rock-chips.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015040847.6421-1-sensor1010@163.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20251015040847.6421-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a99e684616903abkunm8d7d969e2bd29d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkaQlYdGk1LHkkaQ0IZQx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X+6mwWPDH1PC0JAJsCEXtIDwEPnM6bx7ESrZL/FdgaTzkrXtRUD2nl2I9dKoOxJwyNrorco6P6jLawdEl7PWM7IgvOxAJ6SOVRfxslkY9V3GXAquDUmE5j76Qe1utfOMfRd5ku8G7P6h7+B0MRHl3lqjPuOb0KhZvyVlCVUJlFs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=q8XaJ9YCp4W+b7drspa/wsyUFTPtmL0PalpV0e9ymoU=;
	h=date:mime-version:subject:message-id:from;

On 10/15/2025 12:08 PM, Lizhe wrote:

> 'phy_power_on' is a local scope one within the driver, since the return
> value of the phy_power_on() function is always 0, checking its return
> value is redundant.
>
> the function name 'phy_power_on()' conflicts with the existing
> phy_power_on() function in the PHY subsystem. a suitable alternative
> name would be rk_phy_power_set(), particularly since when the second
> argument is false, this function actually powers off the PHY
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 51ea0caf16c1..9d296bfab013 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1461,23 +1461,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
>   	return 0;
>   }
>   
> -static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
> +static void rk_phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
>   {
>   	struct regulator *ldo = bsp_priv->regulator;
>   	struct device *dev = bsp_priv->dev;
> -	int ret;
>   
>   	if (enable) {
> -		ret = regulator_enable(ldo);
> -		if (ret)
> +		if (regulator_enable(ldo))
>   			dev_err(dev, "fail to enable phy-supply\n");
>   	} else {
> -		ret = regulator_disable(ldo);
> -		if (ret)
> +		if (regulator_disable(ldo))
>   			dev_err(dev, "fail to disable phy-supply\n");
>   	}
> -
> -	return 0;
>   }
>   
>   static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
> @@ -1655,11 +1650,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>   		dev_err(dev, "NO interface defined!\n");
>   	}
>   
> -	ret = phy_power_on(bsp_priv, true);
> -	if (ret) {
> -		gmac_clk_enable(bsp_priv, false);

Is gmac_clk_enable() also redundant?


> -		return ret;
> -	}
> +	rk_phy_power_on(bsp_priv, true);
>   
>   	pm_runtime_get_sync(dev);
>   

-- 
Best,
Chaoyi


