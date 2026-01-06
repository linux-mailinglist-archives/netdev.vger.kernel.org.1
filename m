Return-Path: <netdev+bounces-247446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50433CFAA85
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268013013D4D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF824679C;
	Tue,  6 Jan 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fj1Xaccs"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FC20DD51
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727598; cv=none; b=rjctug6DNUgLfI7LRWlRJjk/KtrL3Jwl9tOyBlQ7ya1u1Bhqe7Lo5kjCE9548oJonJPmv7EOfhY86Bd2YJJ/CIdOrKZzFPG86VhWM31SiyEq4gdRdzPpMjJTk5IJps+Hhc+yj29JzDlRBY2w58qa/fA1edEihOVCU4NJt3Mjwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727598; c=relaxed/simple;
	bh=rEXURhxxqLJlNxkqpMsZ06/rDEKN8IdxY7vYnW1GsR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onm8Y2rBIN4YYkEwQLFwxDgUIXghCe+a8+V6oz/bOl7zjpVbzwSjb3GhWqYQXxA4fMqvlBa2OxoV0L65nPEbrOFYljQIw/Wk6M01EyeBfrDOFIhouJwvLq/ihALdvLIiO9A2e2oeneviN9BULx0vF/SXhRvcPPdFQX6jfLojg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fj1Xaccs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97983e82-698a-4042-9417-f9d9c1247e77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767727584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8Uv8ViAxWsHdMXcBt3qZfhJJPVyoN2bV3IhBd0MKqI=;
	b=Fj1XaccsM8tAaJ6yXQgYuvaedm/5E8T3WwjZ5YHl5OcO+68ianotJqnNyrWaqLLtvFkFET
	r53GUxCF5eZ5muXC6P8OHoUe4qQZmjwMi77Vqy5u3ZAtx5C4s9jp+2reo5ZXw/GxG1vRC5
	q5M1rHfdrurF1GM/WDhuzbca4MhqB9I=
Date: Tue, 6 Jan 2026 14:26:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/2] net: axienet: Fix resource release ordering
To: Suraj Gupta <suraj.gupta2@amd.com>, mturquette@baylibre.com,
 sboyd@kernel.org, radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com
Cc: linux@armlinux.org.uk, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260102085454.3439195-1-suraj.gupta2@amd.com>
 <20260102085454.3439195-3-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260102085454.3439195-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/2/26 03:54, Suraj Gupta wrote:
> From: Sean Anderson <sean.anderson@linux.dev>
> 
> Device-managed resources are released after manually-managed resources.
> Therefore, once any manually-managed resource is acquired, all further
> resources must be manually-managed too.
> 
> Convert all resources before the MDIO bus is created into device-managed
> resources. In all cases but one there are already devm variants available.
> 
> Fixes: 46aa27df8853 ("net: axienet: Use devm_* calls")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Co-developed-by: Suraj Gupta <suraj.gupta2@amd.com>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 83 ++++++-------------
>  1 file changed, 27 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 284031fb2e2c..998bacd508b8 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2787,7 +2787,7 @@ static int axienet_probe(struct platform_device *pdev)
>  	int addr_width = 32;
>  	u32 value;
>  
> -	ndev = alloc_etherdev(sizeof(*lp));
> +	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(*lp));
>  	if (!ndev)
>  		return -ENOMEM;
>  
> @@ -2815,41 +2815,32 @@ static int axienet_probe(struct platform_device *pdev)
>  	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
>  	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
>  
> -	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
> +	lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
> +						    "s_axi_lite_clk");
>  	if (!lp->axi_clk) {
>  		/* For backward compatibility, if named AXI clock is not present,
>  		 * treat the first clock specified as the AXI clock.
>  		 */
> -		lp->axi_clk = devm_clk_get_optional(&pdev->dev, NULL);
> -	}
> -	if (IS_ERR(lp->axi_clk)) {
> -		ret = PTR_ERR(lp->axi_clk);
> -		goto free_netdev;
> -	}
> -	ret = clk_prepare_enable(lp->axi_clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n", ret);
> -		goto free_netdev;
> +		lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
>  	}
> +	if (IS_ERR(lp->axi_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(lp->axi_clk),
> +				     "could not get AXI clock\n");
>  
>  	lp->misc_clks[0].id = "axis_clk";
>  	lp->misc_clks[1].id = "ref_clk";
>  	lp->misc_clks[2].id = "mgt_clk";
>  
> -	ret = devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> -	if (ret)
> -		goto cleanup_clk;
> -
> -	ret = clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> +	ret = devm_clk_bulk_get_optional_enable(&pdev->dev, XAE_NUM_MISC_CLOCKS,
> +						lp->misc_clks);
>  	if (ret)
> -		goto cleanup_clk;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not get/enable misc. clocks\n");
>  
>  	/* Map device registers */
>  	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
> -	if (IS_ERR(lp->regs)) {
> -		ret = PTR_ERR(lp->regs);
> -		goto cleanup_clk;
> -	}
> +	if (IS_ERR(lp->regs))
> +		return PTR_ERR(lp->regs);
>  	lp->regs_start = ethres->start;
>  
>  	/* Setup checksum offload, but default to off if not specified */
> @@ -2918,19 +2909,17 @@ static int axienet_probe(struct platform_device *pdev)
>  			lp->phy_mode = PHY_INTERFACE_MODE_1000BASEX;
>  			break;
>  		default:
> -			ret = -EINVAL;
> -			goto cleanup_clk;
> +			return -EINVAL;
>  		}
>  	} else {
>  		ret = of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode);
>  		if (ret)
> -			goto cleanup_clk;
> +			return ret;
>  	}
>  	if (lp->switch_x_sgmii && lp->phy_mode != PHY_INTERFACE_MODE_SGMII &&
>  	    lp->phy_mode != PHY_INTERFACE_MODE_1000BASEX) {
>  		dev_err(&pdev->dev, "xlnx,switch-x-sgmii only supported with SGMII or 1000BaseX\n");
> -		ret = -EINVAL;
> -		goto cleanup_clk;
> +		return -EINVAL;
>  	}
>  
>  	if (!of_property_present(pdev->dev.of_node, "dmas")) {
> @@ -2945,7 +2934,7 @@ static int axienet_probe(struct platform_device *pdev)
>  				dev_err(&pdev->dev,
>  					"unable to get DMA resource\n");
>  				of_node_put(np);
> -				goto cleanup_clk;
> +				return ret;
>  			}
>  			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
>  							     &dmares);
> @@ -2962,19 +2951,17 @@ static int axienet_probe(struct platform_device *pdev)
>  		}
>  		if (IS_ERR(lp->dma_regs)) {
>  			dev_err(&pdev->dev, "could not map DMA regs\n");
> -			ret = PTR_ERR(lp->dma_regs);
> -			goto cleanup_clk;
> +			return PTR_ERR(lp->dma_regs);
>  		}
>  		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
>  			dev_err(&pdev->dev, "could not determine irqs\n");
> -			ret = -ENOMEM;
> -			goto cleanup_clk;
> +			return -ENOMEM;
>  		}
>  
>  		/* Reset core now that clocks are enabled, prior to accessing MDIO */
>  		ret = __axienet_device_reset(lp);
>  		if (ret)
> -			goto cleanup_clk;
> +			return ret;
>  
>  		/* Autodetect the need for 64-bit DMA pointers.
>  		 * When the IP is configured for a bus width bigger than 32 bits,
> @@ -3001,14 +2988,13 @@ static int axienet_probe(struct platform_device *pdev)
>  		}
>  		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
>  			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit architecture\n");
> -			ret = -EINVAL;
> -			goto cleanup_clk;
> +			return -EINVAL;
>  		}
>  
>  		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
>  		if (ret) {
>  			dev_err(&pdev->dev, "No suitable DMA available\n");
> -			goto cleanup_clk;
> +			return ret;
>  		}
>  		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
>  		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
> @@ -3018,15 +3004,12 @@ static int axienet_probe(struct platform_device *pdev)
>  
>  		lp->eth_irq = platform_get_irq_optional(pdev, 0);
>  		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
> -			ret = lp->eth_irq;
> -			goto cleanup_clk;
> +			return lp->eth_irq;
>  		}
>  		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> -		if (IS_ERR(tx_chan)) {
> -			ret = PTR_ERR(tx_chan);
> -			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
> -			goto cleanup_clk;
> -		}
> +		if (IS_ERR(tx_chan))
> +			return dev_err_probe(lp->dev, PTR_ERR(tx_chan),
> +					     "No Ethernet DMA (TX) channel found\n");
>  
>  		cfg.reset = 1;
>  		/* As name says VDMA but it has support for DMA channel reset */
> @@ -3034,7 +3017,7 @@ static int axienet_probe(struct platform_device *pdev)
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Reset channel failed\n");
>  			dma_release_channel(tx_chan);
> -			goto cleanup_clk;
> +			return ret;
>  		}
>  
>  		dma_release_channel(tx_chan);
> @@ -3139,13 +3122,6 @@ static int axienet_probe(struct platform_device *pdev)
>  		put_device(&lp->pcs_phy->dev);
>  	if (lp->mii_bus)
>  		axienet_mdio_teardown(lp);
> -cleanup_clk:
> -	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> -	clk_disable_unprepare(lp->axi_clk);
> -
> -free_netdev:
> -	free_netdev(ndev);
> -
>  	return ret;
>  }
>  
> @@ -3163,11 +3139,6 @@ static void axienet_remove(struct platform_device *pdev)
>  		put_device(&lp->pcs_phy->dev);
>  
>  	axienet_mdio_teardown(lp);
> -
> -	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> -	clk_disable_unprepare(lp->axi_clk);
> -
> -	free_netdev(ndev);
>  }
>  
>  static void axienet_shutdown(struct platform_device *pdev)

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

I think you should resend this without RFC now that the merge window is open.

