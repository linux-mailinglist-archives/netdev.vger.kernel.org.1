Return-Path: <netdev+bounces-93281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C55D8BAE16
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA828218B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3A15444B;
	Fri,  3 May 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i58uEv04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C63154446;
	Fri,  3 May 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744372; cv=none; b=pGLDdeUwBCQfkwzb3oqLanTEg+y2p0hw6eCj9NOnQmMkfJWyfAktRIT6ueyrLhCTjjIoMNslcFXvX00L1Q0Di/J8MAZcoadsUHJbs+7adVVoEX8cdNGoCDDaXjtx7tyjoujasppAC8AhM/79fIWOdgmdmYNX2lkTLVFmcq/WlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744372; c=relaxed/simple;
	bh=1/sEbkKVzr1sl9rpqMBPxOBN56nWkciK2TSQEX52IVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL/7H2TgkCf3xN7YS0cRORWqTaCkClJMBlYZJS0K5xrsW7+nYmlo54RDY4HtD4+VSSNIfqPIpKLijuzqCXKb/5Imzu+6wBQygjvgZZ2RIWd3oZMY4FS+Gi/8NkwGN3pzSKHFCMYClGTNh/ft/CuV9aq5uORhJWTbJe8V5hTaPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i58uEv04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3464C2BBFC;
	Fri,  3 May 2024 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714744371;
	bh=1/sEbkKVzr1sl9rpqMBPxOBN56nWkciK2TSQEX52IVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i58uEv04qUG5DAgLpocPjF3sinBvQely/LrKAIf5mxbVLYZ5uFWE+Jn+8LPmmVMkp
	 dEHNPmB09phulo90CmfqeS0ZobiViN470dScFLCDlQnroBGKxWb1TyQc18vhWblSwJ
	 0nQglDytYII8DIjGdgOw6bPtFRwmxbjDM43ws7e+L+f7iWdmXC3ZexyCoq7LYY1Obr
	 ooocTlSSLUr3zJcsg4WdBC3JOOdIfvP8oOu6Yb1S5XF+a/hTyW+Ck9vRVTg6PWqPXc
	 +Lu1YBcg8a22e9f/fU9sRTU/bzy+63yhGB/7uvJjAYUqnoFF7PlZ4mZrfEh26LCXYx
	 pdyeERfnr3nMQ==
Date: Fri, 3 May 2024 14:52:44 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240503135244.GV2821784@kernel.org>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430173136.15807-3-hengqi@linux.alibaba.com>

On Wed, May 01, 2024 at 01:31:34AM +0800, Heng Qi wrote:

...

> diff --git a/include/linux/dim.h b/include/linux/dim.h

...

> @@ -198,6 +234,32 @@ enum dim_step_result {
>  	DIM_ON_EDGE,
>  };
>  
> +/**
> + * net_dim_init_irq_moder - collect information to initialize irq moderation
> + * @dev: target network device
> + * @profile_flags: Rx or Tx profile modification capability
> + * @coal_flags: irq moderation params flags
> + * @rx_mode: CQ period mode for Rx
> + * @tx_mode: CQ period mode for Tx
> + * @rx_dim_work: Rx worker called after dim decision
> + *    void (*rx_dim_work)(struct work_struct *work);
> + *
> + * @tx_dim_work: Tx worker called after dim decision
> + *    void (*tx_dim_work)(struct work_struct *work);
> + *

Hi Heng Qi,

The above seems to result in make htmldocs issuing the following warnings:

 .../net_dim:175: ./include/linux/dim.h:244: WARNING: Inline emphasis start-string without end-string.
 .../net_dim:175: ./include/linux/dim.h:244: WARNING: Inline emphasis start-string without end-string.
 .../net_dim:175: ./include/linux/dim.h:247: WARNING: Inline emphasis start-string without end-string.
 .../net_dim:175: ./include/linux/dim.h:247: WARNING: Inline emphasis start-string without end-string.

I suggest the following alternative:

 * @rx_dim_work: Rx worker called after dim decision
 * @tx_dim_work: Tx worker called after dim decision

Exercised using Sphinx 7.2.6

...

> diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c

...

> @@ -134,6 +212,12 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>  	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
>  	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
>  	const struct ethtool_coalesce *coal = &data->coalesce;
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	struct net_device *dev = req_base->dev;
> +	struct dim_irq_moder *moder = dev->irq_moder;
> +	u8 coal_flags;
> +	int ret;
> +#endif
>  	u32 supported = data->supported_params;

It's a minor nit, but here goes: please consider using reverse xmas tree
order - longest line to shortest - for local variable declarations in
Networking code.

In this case, I appreciate that it's not strictly possible without
introducing more than one IS_ENABLED condition, which seems worse.
So, as that condition breaks the visual flow, what I suggest in this
case is having a second block of local variable declarations, like this:

	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
	const struct ethtool_coalesce *coal = &data->coalesce;
	u32 supported = data->supported_params;                  

#if IS_ENABLED(CONFIG_DIMLIB)
	struct dim_irq_moder *moder = dev->irq_moder;
	struct net_device *dev = req_base->dev;
	u8 coal_flags;
	int ret;
#endif 

Or better still, if it can be done cleanly, moving all the IS_ENABLED()
code in this function into a separate function, with an no-op
implementation in the case that CONFIG_DIMLIB is not enabled. In general
I'd recommend that approach over sprinkling IS_ENABLED or #ifdef inside
functions. Because in my experience it tends to lead to more readable code.

In any case, the following tool is helpful for isolating
reverse xmas tree issues.

https://github.com/ecree-solarflare/xmastree


>  	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
> @@ -192,11 +276,49 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>  			     kcoal->tx_aggr_time_usecs, supported))
>  		return -EMSGSIZE;
>  
> +#if IS_ENABLED(CONFIG_DIMLIB)
> +	if (!moder)
> +		return 0;
> +
> +	coal_flags = moder->coal_flags;
> +	rcu_read_lock();
> +	if (moder->profile_flags & DIM_PROFILE_RX) {
> +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_PROFILE,
> +					   rcu_dereference(moder->rx_profile),
> +					   coal_flags);
> +		if (ret) {
> +			rcu_read_unlock();
> +			return ret;
> +		}
> +	}
> +
> +	if (moder->profile_flags & DIM_PROFILE_TX) {
> +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_PROFILE,
> +					   rcu_dereference(moder->tx_profile),
> +					   coal_flags);
> +		if (ret) {
> +			rcu_read_unlock();
> +			return ret;
> +		}
> +	}
> +	rcu_read_unlock();
> +#endif
>  	return 0;
>  }

...

