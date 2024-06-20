Return-Path: <netdev+bounces-105436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45245911257
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07321F239A5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E11B581D;
	Thu, 20 Jun 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFNhrMkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3593A1CD
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912541; cv=none; b=e6CUMveM7Fcjp1N7VG7oB3PImVLjW5RL4MQhJzqV3exRlEz/UZlpxaxe2zyXza+U14D2PmoOUtX+nvnlJRhx3Ksg4qiXLVZsVOSdOkb7CmtZo6dcohg4oDp/vE6hYeP6o9oDGHLXrZnDddGobh46nT6Ivvpar4N85ZTMOREvPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912541; c=relaxed/simple;
	bh=uRMCof5+/btxIHSRuDin7/wnCWST6KSaPEe8I1gdo3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7e2pdZ9JpZ1o1VUbuafb36PiY0oyny+3OwI+SysXX27p9CF5cawDQt4fA3eekh8Wro0QXwah44OeHJ+mNQnOVa404IP+fJX3ASDl5Np6fM2xEzlRnYXXxWflqtL40DUea/oAwmqRQ2i4qw6H6BFq/xrYObPtcyjEcoIfo1JY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFNhrMkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C7C2BD10;
	Thu, 20 Jun 2024 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912540;
	bh=uRMCof5+/btxIHSRuDin7/wnCWST6KSaPEe8I1gdo3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFNhrMkv4F0f2KbWTGDenNXlrO54JyWx+5o81vw0L9ZOhAgq4BcMXjCIQ2IVu84F3
	 q+86BhBAEV0PnTNW4A6zt+GY+koTmvcxx4LPfm20bkky2YZ7fqCNLXL4FNlNzyNJRe
	 dMx4B9d7smICmXfR2nAHYCmF1sR4WGBYoXk8rGXe3/s/IbLWhTYALAtWKO6fDlumss
	 LKC9cPnnrGmq7NNyC/vnHfKodQ3qXx7kRywWk9U84NZYiy7Rk+Z9slEy/9aDvIScT0
	 8BGd+x2NdVzplvPNxKWLk+grt5QqlovRuKteP2/qWb2a+sn67bQbT/Vp/EQfWXsR4n
	 84a5tlbKABlLw==
Date: Thu, 20 Jun 2024 20:42:14 +0100
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
	jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
Subject: Re: [PATCH v6 net-next 8/9] net: ethtool: use the tracking array for
 get_rxfh on custom RSS contexts
Message-ID: <20240620194214.GT959333@kernel.org>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <2f024e0b6d32880ff443c4e880af16ec2b5e456a.1718862050.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f024e0b6d32880ff443c4e880af16ec2b5e456a.1718862050.git.ecree.xilinx@gmail.com>

On Thu, Jun 20, 2024 at 06:47:11AM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> On 'ethtool -x' with rss_context != 0, instead of calling the driver to
>  read the RSS settings for the context, just get the settings from the
>  rss_ctx xarray, and return them to the user with no driver involvement.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  net/ethtool/ioctl.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 9d2d677770db..ac562ee3662e 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1199,6 +1199,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
>  	struct ethtool_rxfh_param rxfh_dev = {};
>  	u32 user_indir_size, user_key_size;
> +	struct ethtool_rxfh_context *ctx;
>  	struct ethtool_rxfh rxfh;
>  	u32 indir_bytes;
>  	u8 *rss_config;
> @@ -1246,11 +1247,25 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
>  	if (user_key_size)
>  		rxfh_dev.key = rss_config + indir_bytes;
>  
> -	rxfh_dev.rss_context = rxfh.rss_context;
> -
> -	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
> -	if (ret)
> -		goto out;
> +	if (rxfh.rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +		if (rxfh_dev.indir)
> +			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
> +			       indir_bytes);
> +		if (rxfh_dev.key)
> +			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
> +			       user_key_size);
> +		rxfh_dev.hfunc = ctx->hfunc;
> +		rxfh_dev.input_xfrm = ctx->input_xfrm;

Hi Edward,

The last line of this function is:

	return ret;

With this patch applied, Smatch complains that ret may be used there
when unintialised.

I think that occurs when the code reaches the line where this
commentary has been placed in this email.

> +	} else {
> +		ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
>  			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {
> 

