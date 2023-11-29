Return-Path: <netdev+bounces-52130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C072A7FD6E7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C296283555
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0F14265;
	Wed, 29 Nov 2023 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab1Sqfj2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1C1B297
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 12:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD5C433C8;
	Wed, 29 Nov 2023 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701261535;
	bh=YRPmgyXmnqLz1Gklpj9zRIaCJd4+aKMKj1bXHQYDK2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ab1Sqfj2yUckgCwxxT6h6QHlIZHnJcU3RukIWFlzdGyNJkIPO5tFBKi+g/cyBBHuv
	 pHEN1otKZ20rY21owZpLSo1Chjo75m0OhzJffIIAPo57PjF6EZULlgnyoZ8jwgowKA
	 kt/WZ0o/cDDPO8+sydvhB+ZbVY0iHeNcFK0JmMVif6tK96HvYvBz+8EZxL1ZjRDP3F
	 kefgUk3n+g5Yz1bOOV5/23dEGFBxQMfeYM0dKEvPpOgd9dzrN5W6IeR1RrXy1t9aFe
	 KdCuI1+4ICPvYC6a2ssJaXtInmFOFC4gD6pRdZW2P3VtZI9oBqj+qNM85/dLhqwKPi
	 xYn+j9F1aL5dw==
Message-ID: <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
Date: Wed, 29 Nov 2023 14:38:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: improve suspend/resume
 support for J7200
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
 grygorii.strashko@ti.com, dan.carpenter@linaro.org,
 thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com, u-kumar1@ti.com
References: <20231128131936.600233-1-thomas.richard@bootlin.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231128131936.600233-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28/11/2023 15:19, Thomas Richard wrote:
> From: Gregory CLEMENT <gregory.clement@bootlin.com>

Subject is vague. Please be explicit about you are trying to do.

> 
> On J7200 the SoC is off during suspend, so the clocks have to be

What do you mean by SoC is off? I suppose you are referring to a certain
low power state of the SoC?

By "clocks have to be completely powered down" you mean they have to
be gated in addition to be disabled? What happens if they are left ungated?
Does it prevent SoC form entering the target low power state?

> completely power down, and phy_set_mode_ext must be called again.

Why must phy_set_mode_ext() be called again?

> 

Not all SoCs behave like J7200 so can we please restrict this change to J7200? Thanks.

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 25 ++++++++++++++++++++++++
>  drivers/net/ethernet/ti/am65-cpts.c      | 11 +++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index ece9f8df98ae..e95ef30bd67f 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2115,6 +2115,27 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  	return ret;
>  }
>  
> +static int am65_cpsw_nuss_resume_slave_ports(struct am65_cpsw_common *common)
> +{
> +	struct device *dev = common->dev;
> +	int i;
> +
> +	for (i = 1; i <= common->port_num; i++) {
> +		struct am65_cpsw_port *port;
> +		int ret;
> +
> +		port = am65_common_get_port(common, i);
> +
> +		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
> +		if (ret) {
> +			dev_err(dev, "port %d error setting phy mode %d\n", i, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void am65_cpsw_pcpu_stats_free(void *data)
>  {
>  	struct am65_cpsw_ndev_stats __percpu *stats = data;
> @@ -3087,6 +3108,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
>  	if (common->rx_irq_disabled)
>  		disable_irq(common->rx_chns.irq);
>  
> +	ret = am65_cpsw_nuss_resume_slave_ports(common);
> +	if (ret)
> +		dev_err(dev, "failed to resume slave ports: %d", ret);
> +
>  	am65_cpts_resume(common->cpts);
>  
>  	for (i = 0; i < common->port_num; i++) {
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index c66618d91c28..e6db5b61409a 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -1189,7 +1189,11 @@ void am65_cpts_suspend(struct am65_cpts *cpts)
>  	cpts->sr_cpts_ns = am65_cpts_gettime(cpts, NULL);
>  	cpts->sr_ktime_ns = ktime_to_ns(ktime_get_real());
>  	am65_cpts_disable(cpts);
> -	clk_disable(cpts->refclk);
> +
> +	/* During suspend the SoC can be power off, so let's not only
> +	 * disable but also unprepare the clock
> +	 */
> +	clk_disable_unprepare(cpts->refclk);
>  
>  	/* Save GENF state */
>  	memcpy_fromio(&cpts->sr_genf, &cpts->reg->genf, sizeof(cpts->sr_genf));
> @@ -1204,8 +1208,11 @@ void am65_cpts_resume(struct am65_cpts *cpts)
>  	int i;
>  	s64 ktime_ns;
>  
> +	/* During suspend the SoC can be power off, so let's not only
> +	 * enable but also prepare the clock
> +	 */
> +	clk_prepare_enable(cpts->refclk);
>  	/* restore state and enable CPTS */
> -	clk_enable(cpts->refclk);
>  	am65_cpts_write32(cpts, cpts->sr_rftclk_sel, rftclk_sel);
>  	am65_cpts_set_add_val(cpts);
>  	am65_cpts_write32(cpts, cpts->sr_control, control);

-- 
cheers,
-roger

