Return-Path: <netdev+bounces-104967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864690F4F8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C607B22A50
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7E156C69;
	Wed, 19 Jun 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilDmOOnx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3815689B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817877; cv=none; b=C2ta394xwH5jzoQTXXI3QPshyUMPZOsXbc/U+wpW3AvrKf9/OdCt5jAfrP0NML21XYwdyptP3SunVBhs+u+2G/WZp+4UAKN2OS5+oMkEC0yqHQ6srSrtNoDgESCxXbr103WHaXRaeridrKKWh86gSu89J3eL0JeQ81FzTx0hWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817877; c=relaxed/simple;
	bh=9bRaxG3cUyTtN2Gu7YcIu/MXwHYbf7eBUez/R2ahNDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3IPcwlZHczpqulwskMef22qf7fgDpLv82Iqg6dnPMaZQ4sKQYC1lhbAwim/KSx5P0SqfNYxjB/3fxy0skDrMj+8ywo+KlepVuEm8+o+ivAEeLZ4qlq6RZzlV1Gi1acR5WEorZl1/vB+BtXqbafQjJAZBeMgUCPXcOlGLLCwrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilDmOOnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADF5C2BBFC;
	Wed, 19 Jun 2024 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718817877;
	bh=9bRaxG3cUyTtN2Gu7YcIu/MXwHYbf7eBUez/R2ahNDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilDmOOnxhV6S3zgqtUbEvxgNNTOFMpy7GWWRicWc7xx1jTOzBRT6PSOz9vowtE1Yi
	 lgQZI7jfJBOiFTKckHr41GH5pR7wejMtFsuN2UaUiBB5YI4P0IjMbWzRtByrk1TqyO
	 Ep7/JVAjrB8CdZq4kiBkxl7btkmOjXpQKEacqXZZ/x0+6LdclyRcX93c/O/0CgmVh8
	 Ld44Ei60fdi9Ksbzp6zG40NlJtOMDLKUGTnZdj92usgNnH1rlVOx+cNcBU67piDCbu
	 XqqzQ/gFTg8/o3oGV1TD+IgAVPItdNtNIiUkfmrTG2rRjbpkTtW4Xqh1lGZ8DPu1FD
	 ay0OizJc07bkQ==
Date: Wed, 19 Jun 2024 10:24:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
 <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: Re: [PATCH v5 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
Message-ID: <20240619102435.52b7be88@kernel.org>
In-Reply-To: <7552f2ab4cf66232baf03d3bc3a47fc1341761f9.1718750587.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
	<7552f2ab4cf66232baf03d3bc3a47fc1341761f9.1718750587.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 23:44:24 +0100 edward.cree@amd.com wrote:
> + * @create_rxfh_context: Create a new RSS context with the specified RX flow
> + *	hash indirection table, hash key, and hash function.
> + *	Parameters which are set to %NULL or zero will be populated to
> + *	appropriate defaults by the driver.

The defaults will most likely "inherit" whatever is set in context 0.
So the driver _may_ init the values according to its preferences
but they will not be used by the core (specifically not reported to
user space via ethtool netlink)

Does that match your thinking?

> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that the indir table, hkey and hfunc are not yet populated as
> + *	of this call.  The driver does not need to update these; the core
> + *	will do so if this op succeeds.
> + *	If the driver provides this method, it must also provide
> + *	@modify_rxfh_context and @remove_rxfh_context.
> + *	Returns a negative error code or zero.
> + * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
> + *	the contents of the RX flow hash indirection table, hash key, and/or
> + *	hash function associated with the given context.
> + *	Parameters which are set to %NULL or zero will remain unchanged.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that it will still contain the *old* settings.  The driver does
> + *	not need to update these; the core will do so if this op succeeds.
> + *	Returns a negative error code or zero. An error code must be returned
> + *	if at least one unsupported change was requested.
> + * @remove_rxfh_context: Remove the specified RSS context.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
> + *	Returns a negative error code or zero.
>   * @get_channels: Get number of channels.
>   * @set_channels: Set number of channels.  Returns a negative error code or
>   *	zero.
> @@ -906,6 +933,7 @@ struct ethtool_ops {
>  	u32     cap_rss_ctx_supported:1;
>  	u32	cap_rss_sym_xor_supported:1;
>  	u16	rxfh_priv_size;
> +	u32	rxfh_max_context_id;
>  	u32	supported_coalesce_params;
>  	u32	supported_ring_params;
>  	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
> @@ -968,6 +996,15 @@ struct ethtool_ops {
>  	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
>  	int	(*set_rxfh)(struct net_device *, struct ethtool_rxfh_param *,
>  			    struct netlink_ext_ack *extack);
> +	int	(*create_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const struct ethtool_rxfh_param *rxfh);
> +	int	(*modify_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const struct ethtool_rxfh_param *rxfh);
> +	int	(*remove_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       u32 rss_context);

Can we make remove void? It's sort of a cleanup, cleanups which can
fail make life hard.

