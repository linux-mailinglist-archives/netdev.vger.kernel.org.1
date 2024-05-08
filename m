Return-Path: <netdev+bounces-94382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5458BF4C4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61381B21B36
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932111713;
	Wed,  8 May 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWpkP9fj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846C8F4E;
	Wed,  8 May 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137074; cv=none; b=G8JWQublQWDRg8mliiBGfvxTBMRl9U8Yv1zRI5CxqAu2JuudRn4dYEFTPh1ueyRtyEjXJWEQsBH7LQ0P2fFYMiTcpFxbpqlGsOJybJKFVSjdnaMFqPotRGd3FwZWbFjz9M0CIhV+XOljn1kXsUcjuXDtwNIU9dBhY0RjZhaiiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137074; c=relaxed/simple;
	bh=E6rT37IX6XLu1lS4UQnWxLhnJrW3UDpWQ9J7ERcu5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+Oqsdc6oDljCpZ32jFdEr19FedUm6AE4TNTmUPVv3XAby5oPtFyMdpYpdxoRWZo87doMrfyyiztW3q9Tr8uWRtSKyh4/XpvjFGjExEv6grJQsWRf5pE9FgofktsuXUNB/Yvyhs1ZKyluu/kQc+3irqzwY3Poe4RZBVY/ErER0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWpkP9fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19190C2BBFC;
	Wed,  8 May 2024 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715137074;
	bh=E6rT37IX6XLu1lS4UQnWxLhnJrW3UDpWQ9J7ERcu5BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kWpkP9fjCmsAL6uK8UlEqiRME5JVf3aVEgj+DQLpcWXWB63gPyBxXpUrzM4xLcyuu
	 5zmffks6WKIf7Jz1AXFLp/0MnwACMHP/XPhVmC0o5LFkI9E6Nnv1G+xvwcUUFLhZuy
	 7m+fm8129FpxeET3zIyZxS6c9n1GHYacuiEm5RcKxuwM3YXggwP28YG435ctIlNqau
	 pQWm0y6aGYx1MlSF9UDqmLP7tw5PEjzPbLcW7T1Q7eBlgd+QaAuKzUiqqC5UIyAnj1
	 H2bbnnd2cyBO/5wiKWA6Wjz3hX8ha37ng6HGRtG/gcQNS/jgpr8wUMeMOPM8hO+LPG
	 kQ5ULw9fStl2g==
Date: Tue, 7 May 2024 19:57:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v12 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240507195752.7275cb63@kernel.org>
In-Reply-To: <20240504064447.129622-3-hengqi@linux.alibaba.com>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
	<20240504064447.129622-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 May 2024 14:44:45 +0800 Heng Qi wrote:
> @@ -1325,6 +1354,8 @@ operations:
>              - tx-aggr-max-bytes
>              - tx-aggr-max-frames
>              - tx-aggr-time-usecs
> +            - rx-profile
> +            - tx-profile
>        dump: *coalesce-get-op
>      -
>        name: coalesce-set

set probably needs to get the new attributes, too?

>  Request is rejected if it attributes declared as unsupported by driver (i.e.
> diff --git a/include/linux/dim.h b/include/linux/dim.h
> index 43398f5eade2..d848b790ca50 100644
> --- a/include/linux/dim.h
> +++ b/include/linux/dim.h
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <linux/netdevice.h>

looks unnecessary, you just need a forward declaration of 
struct net_device, no?

> diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
> index 67d5beb34dc3..b3e01619f929 100644
> --- a/lib/dim/net_dim.c
> +++ b/lib/dim/net_dim.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/dim.h>
> +#include <linux/rtnetlink.h>
>  
>  /*
>   * Net DIM profiles:
> @@ -95,6 +96,76 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
>  }
>  EXPORT_SYMBOL(net_dim_get_def_tx_moderation);
>  
> +int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
> +			   u8 coal_flags, u8 rx_mode, u8 tx_mode,
> +			   void (*rx_dim_work)(struct work_struct *work),
> +			   void (*tx_dim_work)(struct work_struct *work))
> +{
> +	struct dim_cq_moder *rxp = NULL, *txp;
> +	struct dim_irq_moder *moder;
> +	int len;
> +
> +	dev->irq_moder = kzalloc(sizeof(*dev->irq_moder), GFP_KERNEL);
> +	if (!dev->irq_moder)
> +		goto err_moder;

return the error directly here, no need to goto

> +	moder = dev->irq_moder;
> +	len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_profile);
> +
> +	moder->coal_flags = coal_flags;
> +	moder->profile_flags = profile_flags;
> +
> +	if (profile_flags & DIM_PROFILE_RX) {
> +		moder->rx_dim_work = rx_dim_work;
> +		WRITE_ONCE(moder->dim_rx_mode, rx_mode);

why WRITE_ONCE()? The structure can't be used, yet

> +		rxp = kmemdup(rx_profile[rx_mode], len, GFP_KERNEL);
> +		if (!rxp)
> +			goto err_rx_profile;

name the labels after the target, please, not the source

> +		rcu_assign_pointer(moder->rx_profile, rxp);
> +	}

> +static int ethnl_update_profile(struct net_device *dev,
> +				struct dim_cq_moder __rcu **dst,
> +				const struct nlattr *nests,
> +				struct netlink_ext_ack *extack)

> +	rcu_assign_pointer(*dst, new_profile);
> +	kfree_rcu(old_profile, rcu);
> +
> +	return 0;

Don't we need to inform DIM somehow that profile has switched
and it should restart itself?

