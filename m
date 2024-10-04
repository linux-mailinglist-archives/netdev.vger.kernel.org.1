Return-Path: <netdev+bounces-131928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343CF98FF59
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD2CB22777
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACF145B1B;
	Fri,  4 Oct 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVMiKN54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E013B7B3;
	Fri,  4 Oct 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032960; cv=none; b=FA4lDMcMkVpN26nOLO+g4Pf1GD2rb1U9fVxbWOc3x0yIUpjYxLlcq5RzoTVJs3K+gKQ0jdtrODQ0azJiS5zpJSAf5LvQ5d5nNr1QfVc/+RSRk7ICLiDJ5GMYrKOs3e3YD4T6uordwuJZgMa1UksytzJGcsgFMA9d1rZ1D2Y8fic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032960; c=relaxed/simple;
	bh=ze72X9iDMSh9Xa/a4oUmP4Bw8H/h4imJJYOCTs7Fvd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppKrRVLdcQQV/+t6xxjXQKTb7tVUq722L7xPb4J/UcyO++gE0ZFs1cTQgoewh3S69hZ1TYrg/9BoAdMovbvzzi3l9t2zAvxVz9HPeKTOnhnS63LJQaYPQvkzOzUQI1t4lEBXpiZe0cxhHZm/CoRl8m65TY0s2ZtMikrbAdmRJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVMiKN54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C0FC4CEC6;
	Fri,  4 Oct 2024 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728032960;
	bh=ze72X9iDMSh9Xa/a4oUmP4Bw8H/h4imJJYOCTs7Fvd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oVMiKN54/zTNlfO14ojniITmcFnNmgozEUHxYSHEbZd5MCkCxMsDO/Fu8eciqYUIs
	 v+GyDv1jNvtyO984+wD5gbFYGxVYTPmuX8mo32HEEx0XPLBak1tX//nQMXvO7BZG6H
	 oSClryFiAEOWQqmEupBxsHxG6yLWTrWy8Kg81U4+tSX1+gOcbzRUT1kZ2lPcVddjVX
	 5E/dS65Pevl+MtGE2SgiqRgjKY4BtnJRF6qzLvOPq878o5fPnbSJyaa6+MQ7DLIZnS
	 0PiiZ10xN1rxrdQjDCx5ArTJqpfyZSD8ndLAMiLrMMqYIWzTgGBrGpgMlnYbV6wo28
	 bj40/l0+HuOng==
Message-ID: <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
Date: Fri, 4 Oct 2024 12:09:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
To: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <npitre@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-3-nico@fluxnic.net>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241004041218.2809774-3-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 04/10/2024 07:10, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Usage of devm_alloc_etherdev_mqs() conflicts with
> am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
> get unregistered twice. Switch to alloc_etherdev_mqs() and make sure

Do we know why the same net device gets unregistered twice?

> am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
> instances properly.
> 
> With this, it is finally possible to rmmod the driver without oopsing
> the kernel.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index f6bc8a4dc6..e95457c988 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>  		return 0;
>  
>  	/* alloc netdev */
> -	port->ndev = devm_alloc_etherdev_mqs(common->dev,
> -					     sizeof(struct am65_cpsw_ndev_priv),
> -					     AM65_CPSW_MAX_QUEUES,
> -					     AM65_CPSW_MAX_QUEUES);
> +	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
> +					AM65_CPSW_MAX_QUEUES,
> +					AM65_CPSW_MAX_QUEUES);

Can we solve this issue without doing this change as
there are many error cases relying on devm managed freeing of netdev.


>  	if (!port->ndev) {
>  		dev_err(dev, "error allocating slave net_device %u\n",
>  			port->port_id);
> @@ -2868,8 +2867,12 @@ static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
>  
>  	for (i = 0; i < common->port_num; i++) {
>  		port = &common->ports[i];
> -		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
> +		if (!port->ndev)
> +			continue;
> +		if (port->ndev->reg_state == NETREG_REGISTERED)
>  			unregister_netdev(port->ndev);
> +		free_netdev(port->ndev);
> +		port->ndev = NULL;

I still can't see what we are doing wrong in existing code.

>  	}
>  }
>  
> @@ -3613,16 +3616,17 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>  
>  	ret = am65_cpsw_nuss_init_ndevs(common);
>  	if (ret)
> -		goto err_free_phylink;
> +		goto err_ndevs_clear;
>  
>  	ret = am65_cpsw_nuss_register_ndevs(common);
>  	if (ret)
> -		goto err_free_phylink;
> +		goto err_ndevs_clear;
>  
>  	pm_runtime_put(dev);
>  	return 0;
>  
> -err_free_phylink:
> +err_ndevs_clear:
> +	am65_cpsw_nuss_cleanup_ndev(common);
>  	am65_cpsw_nuss_phylink_cleanup(common);
>  	am65_cpts_release(common->cpts);
>  err_of_clear:

-- 
cheers,
-roger

