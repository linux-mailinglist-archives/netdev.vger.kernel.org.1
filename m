Return-Path: <netdev+bounces-150277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E659E9C1A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D0F16755C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0A153824;
	Mon,  9 Dec 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlM0LuNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE314F9FB;
	Mon,  9 Dec 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762992; cv=none; b=XQMsrM0kKZR9uVQUD7eoGHRp/nnYRi5A38iiK4AyIhyPmSY9psa7sm97ETJiLYNU1R1yF2WlgxCU+3Wixa9pkA5vgiovBUQ9Jm6cY9oyMPtLlR4zGjq0XbZwCHv+qzfCRKwez/KO9NZ/fUceugaZ8yOAhwvog/uIsPQXJ577XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762992; c=relaxed/simple;
	bh=qDOIcIRamvaYbznkBIfCb96yBhJPKCgcT8jFIZBkfHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBgtKjEkvCmC6iTvzaCZ9CAMyITeNhabI9ZjnEXEj/jQE4BqdJMAAEa+llKvDA+W63MRmmipaP75chNR/dNxa62k7x4ZVOsgOu32egszPCNIm+NH3N6CmLHU9V3ZMkE15mYB+FOSGSYulubpk2QA7ANYStX7glvIngdptGGjWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlM0LuNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7DDC4CED1;
	Mon,  9 Dec 2024 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733762991;
	bh=qDOIcIRamvaYbznkBIfCb96yBhJPKCgcT8jFIZBkfHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlM0LuNbsoL2znvYf3Gc0UUL41BG38Em8xK8cePbVnc+u7XhLKxlAFMAFmDvEpUL8
	 QN9hYXxmSZjZuuGQGGUMhaaRaRf9kokykbw9WSsaCNA4cBVQBwqCPAG/aTcGwHoqlq
	 8tiFQxAY0/i2M8lU0LiuS0w58nbQ0CoWl2RcXYLDS8XNvcamPn5ZCBN9XrHvDCu/sj
	 G5xDYZwdjo4cGWN2VNUM6Npp5r9w7W4UjV4Sp7prTEY+c7ADPwUPyxzTGKWYT2i6D/
	 ZZeYFLfFEPM60Y0fwZE9XZG+Jq5LlQmwbOKEH+LNN1VQ8j1miu1lZiKS5IOsMM1rbf
	 JtwoJ3cjsyFFw==
Date: Mon, 9 Dec 2024 16:49:46 +0000
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/7] net: ftgmac100: Add reset toggling for
 Aspeed SOCs
Message-ID: <20241209164946.GA2455@kernel.org>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205072048.1397570-4-jacky_chou@aspeedtech.com>

On Thu, Dec 05, 2024 at 03:20:44PM +0800, Jacky Chou wrote:
> Toggle the SCU reset before hardware initialization.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 17ec35e75a65..96c1eee547c4 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> @@ -98,6 +99,7 @@ struct ftgmac100 {
>  	struct work_struct reset_task;
>  	struct mii_bus *mii_bus;
>  	struct clk *clk;
> +	struct reset_control *rst;
>  
>  	/* AST2500/AST2600 RMII ref clock gate */
>  	struct clk *rclk;
> @@ -1979,6 +1981,22 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  				  priv->base + FTGMAC100_OFFSET_TM);
>  	}
>  
> +	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
> +	if (IS_ERR(priv->rst))
> +		goto err_register_netdev;

Hi Jacky,

The goto on the line above will result in this function returning err.
However, it seems that err is set to 0 here.
And perhaps it should be set to PTR_ERR(priv->rst).

Flagged by Smatch.

> +
> +	err = reset_control_assert(priv->rst);
> +	if (err) {
> +		dev_err(priv->dev, "Failed to reset mac (%d)\n", err);
> +		goto err_register_netdev;
> +	}
> +	usleep_range(10000, 20000);
> +	err = reset_control_deassert(priv->rst);
> +	if (err) {
> +		dev_err(priv->dev, "Failed to deassert mac reset (%d)\n", err);
> +		goto err_register_netdev;
> +	}
> +
>  	/* Default ring sizes */
>  	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
>  	priv->tx_q_entries = priv->new_tx_q_entries = DEF_TX_QUEUE_ENTRIES;
> -- 
> 2.25.1
> 
> 

