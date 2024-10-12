Return-Path: <netdev+bounces-134846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27199B506
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4641F21FC4
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83560153BE4;
	Sat, 12 Oct 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNam9Yvd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7971E495;
	Sat, 12 Oct 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739016; cv=none; b=ALjQEIHto6MskygcNseqDKPiCprxTIZBo43/pFbgLucbpCvcEATXPY0/pulJvd73mdWjV34tLjBsXNlG8gwr5EPF0VAv9LeLSUifVYq3c9vpWpJ/vBPQFiPL0dsG/bPfI6lCIRgYU8hTMqqmZ7DKpzKej3xpJNxjm9t7PSdjxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739016; c=relaxed/simple;
	bh=vQYV4mQ3jh3/qlh27NffOGGKqKitgAbdpNmmqkj2fBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9kSspX9CRbC+zjusei2zi3BzvQmAZjdDwssfOA3j30SUO2xU7M96YluOdNlbE/TpouP0WEL09KFS46rJXKKuCTzM3o0Sn99ewOTeK5iniXsArd+8McOdfCEUI2dcfE8GK64j9X7vWlGL9uVJTD7u1iZEKYJRDE8zTjp5W4M7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNam9Yvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B8C4CEC6;
	Sat, 12 Oct 2024 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728739015;
	bh=vQYV4mQ3jh3/qlh27NffOGGKqKitgAbdpNmmqkj2fBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNam9YvddedmJaXeR2LVkfk/2aN0tBfsRmpRtZrzm+QVwYPC4l0THYaKvAlmiEy1a
	 J4ctvQem4X0Hq8ShslwvmEiGdhn0KN6FOltV/eWsPydnRmw/KlSaGoCSdW0fruv6gD
	 hu2+B5MoXXgn94YHAdl9/ymxiv/OgJlBCQZzWlrsVgoBzAaLRgG5Cwsh9JRNx/ZPOz
	 qBX8EX3bYWrRLQCcG0Du+2rPHY5NP86MCPlBu3n9UFzClZ2zslGUv/j/97hqLgTx5K
	 EHE1KbRkPxodRYLZeq9Oy1dwCW55bVK+g5SexOYmtaRCQv2SI8CJjlDuIwKp9gX6yE
	 wvD7uqUaKKuEw==
Date: Sat, 12 Oct 2024 14:16:51 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 6/7] net: ibm: emac: generate random MAC if
 not found
Message-ID: <20241012131651.GE77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-7-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-7-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:21PM -0700, Rosen Penev wrote:
> On this Cisco MX60W, u-boot sets the local-mac-address property.
> Unfortunately by default, the MAC is wrong and is actually located on a
> UBI partition. Which means nvmem needs to be used to grab it.
> 
> In the case where that fails, EMAC fails to initialize instead of
> generating a random MAC as many other drivers do.
> 
> Match behavior with other drivers to have a working ethernet interface.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index b9ccaae61c48..faa483790b29 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2937,9 +2937,12 @@ static int emac_init_config(struct emac_instance *dev)
>  
>  	/* Read MAC-address */
>  	err = of_get_ethdev_address(np, dev->ndev);
> -	if (err)
> -		return dev_err_probe(&dev->ofdev->dev, err,
> -				     "Can't get valid [local-]mac-address from OF !\n");
> +	if (err == -EPROBE_DEFER)
> +		return err;
> +	if (err) {
> +		dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
> +		eth_hw_addr_random(dev->ndev);
> +	}

The above seems to take the random path for all errors other than
-EPROBE_DEFER. That seems too broad to me, and perhaps it would
be better to be more specific. Assuming the case that needs
to be covered is -EINVAL (a guess on my part), perhaps something like this
would work? (Completely untested!)

	err = of_get_ethdev_address(np, dev->ndev);
	if (err == -EINVAL) {
		/* An explanation should go here, mentioning Cisco MX60W
		 * Maybe the logic should even be specific to that hw?
		 */
		dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
		eth_hw_addr_random(dev->ndev);
	} else if (err) {
		return dev_err_probe(&dev->ofdev->dev, err,
				     "Can't get valid [local-]mac-address from OF !\n");
	}

Also, should this be a bug fix with a Fixes tag for net?

>  
>  	/* IAHT and GAHT filter parameterization */
>  	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
> -- 
> 2.47.0
> 

