Return-Path: <netdev+bounces-131565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD198EDFC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452781C21A68
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694916C453;
	Thu,  3 Oct 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDMpTqJP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC2161310;
	Thu,  3 Oct 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954297; cv=none; b=fDg1nEVcAUOPWv+yY8b8bkR3QssdH+DQcEoWYuHgrTaAdBJ+BZ73Z27XnpQEJIz6DZhoGjsXRKlPb1K8O4SFpim19+Yxai1dV9w1kPmh43IuXJjEs9LyCSFZYdlM/h4T/WMvqON/IPoFsES1ky6XRc4bCxQAnP2MWJI97hnm054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954297; c=relaxed/simple;
	bh=AtYWg0i+YgGT7RsQ96Mj+yOKNWur0aXD7xdQt3uW+a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzNmmSPSjkVQ5vIyWNTlPkmRZs94HvuL1Au+Vlah7cWmesgpoxmuEAdrWq6MkCUKyhMTcmfyl1goBlScj/X1/0arNgnkS1xDyrVFqTWCs5YdhYGQJShimu1yg6QNml/4xlVAVwO8qXJXrGWj4nUtqUx2tJIoIVxQgmWWS5a43Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDMpTqJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE624C4CEC5;
	Thu,  3 Oct 2024 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727954296;
	bh=AtYWg0i+YgGT7RsQ96Mj+yOKNWur0aXD7xdQt3uW+a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDMpTqJPT5y+13vnCs3T53BfGSzwmvg+daUGX7k2VcNREQDIiH8jz+HBSVKyJ83Bn
	 LB/uF0AOZ17LW6PcBPRykWRiCo5IaGT7byz8dWHYTyD9ocg1+yoap7ZQAp3A6duoyH
	 BgHgA4tTgHA6jpeD+eHOnHygM6TEuSD88Neg1aeLsmmlr/6rigwhx2lM4Ql8hLnt3v
	 JS6VpG/rWfx8o+k1TrZ7T1IKK2wdtIEdpcQCMuBRJ+J7GRijD/gY6cKviCMLjYNJ9M
	 +DPvzb6/P9olrhoSWbpcj6REwyS8iJVB0E3Orh9tKERa1lARJFzJ5zMxu+r9h92Guv
	 e/MbrDUWofJfQ==
Date: Thu, 3 Oct 2024 12:18:11 +0100
From: Simon Horman <horms@kernel.org>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net] stmmac: dwmac-intel-plat: fix call balance of tx_clk
 handling routines
Message-ID: <20241003111811.GJ1310185@kernel.org>
References: <20240930183715.2112075-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930183715.2112075-1-mordan@ispras.ru>

On Mon, Sep 30, 2024 at 09:37:15PM +0300, Vitalii Mordan wrote:
> If the clock dwmac->tx_clk was not enabled in intel_eth_plat_probe,
> it should not be disabled in any path.
> 
> Conversely, if it was enabled in intel_eth_plat_probe, it must be disabled
> in all error paths to ensure proper cleanup.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: 9efc9b2b04c7 ("net: stmmac: Add dwmac-intel-plat for GBE driver")
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-intel-plat.c   | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> index d68f0c4e7835..2a2893f2f2a8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> @@ -108,7 +108,12 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
>  			if (IS_ERR(dwmac->tx_clk))
>  				return PTR_ERR(dwmac->tx_clk);
>  
> -			clk_prepare_enable(dwmac->tx_clk);
> +			ret = clk_prepare_enable(dwmac->tx_clk);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"Failed to enable tx_clk\n");
> +				return ret;
> +			}
>  
>  			/* Check and configure TX clock rate */
>  			rate = clk_get_rate(dwmac->tx_clk);
> @@ -117,6 +122,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
>  				rate = dwmac->data->tx_clk_rate;
>  				ret = clk_set_rate(dwmac->tx_clk, rate);
>  				if (ret) {
> +					clk_disable_unprepare(dwmac->tx_clk);
>  					dev_err(&pdev->dev,
>  						"Failed to set tx_clk\n");
>  					return ret;

Hi Vitalii,

I think that unwinding using a goto label would be more idiomatic here
and in the following changes to intel_eth_plat_probe().

> @@ -131,6 +137,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
>  			rate = dwmac->data->ptp_ref_clk_rate;
>  			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
>  			if (ret) {
> +				if (dwmac->data->tx_clk_en)
> +					clk_disable_unprepare(dwmac->tx_clk);
>  				dev_err(&pdev->dev,
>  					"Failed to set clk_ptp_ref\n");
>  				return ret;
> @@ -150,7 +158,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>  	if (ret) {
> -		clk_disable_unprepare(dwmac->tx_clk);
> +		if (dwmac->data->tx_clk_en)
> +			clk_disable_unprepare(dwmac->tx_clk);

Smatch warns that dwmac->data may be NULL here.

>  		return ret;
>  	}
>  
> @@ -162,7 +171,8 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
>  	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
>  
>  	stmmac_pltfr_remove(pdev);
> -	clk_disable_unprepare(dwmac->tx_clk);
> +	if (dwmac->data->tx_clk_en)

And I wonder if it can be NULL here too.

> +		clk_disable_unprepare(dwmac->tx_clk);
>  }
>  
>  static struct platform_driver intel_eth_plat_driver = {
> -- 
> 2.25.1
> 
> 

