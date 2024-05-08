Return-Path: <netdev+bounces-94337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AD8BF379
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290D41C2338A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0237384;
	Wed,  8 May 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSCv4nwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3B383
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127517; cv=none; b=rK95WfAvmZQ0Tyy0gI4M+fS8tyGhLCahohb9rjE6acfqabZEkFFNO8l5i9ymNgwKXa4ekwHbtDT0N2nOiCvGhyc9fxICNIqnJMjtUsDAQ/Y8FWlxUVX7o5Dw9BWrRsy7haRQ0OfdOPc11hqGEgMDD3QeKmQsnKyjw5aRpHybqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127517; c=relaxed/simple;
	bh=m+udy2PKJZjJOWOfxzCLZ9nieMF/yevJ0z+jKbqbHnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CStjRZyxj7wO6EgoFY1xuwA7GTC2aYsFBuibqPZjP+AVU/czJ/Ez3LeDRLIpQCyE54E6CJKAfuK3t8Vhr9f5H/Tl0VdGIIjxGzrMjUkarGMhLJXt9gLkFxpkBvHHsMvefPPu5bfyTa+L9P/7TFKtUG+NEPuIhiS1B5rJLUJoJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSCv4nwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB605C2BBFC;
	Wed,  8 May 2024 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715127517;
	bh=m+udy2PKJZjJOWOfxzCLZ9nieMF/yevJ0z+jKbqbHnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sSCv4nwTzQplo12PUa5xjS5eUAE6L7+RLMGdAUJS/yU9c1Dmt04Jijz86JPxWGFkQ
	 Y/kAEMYlqdYcavNOAMSEy9VU8VHTgFjtIMDIkrhlsWlOvF6eiA19QJSnYMsl19DyrI
	 wkXeCSs7YMGpSfYmRA41BczAkymnHkiXOr2aGk0ZRiHML6qsf/O7+OEwL+jXkOjdD7
	 LUTJgZilcHqogQEIIwazT0m58chjYBkqrjFxaHTguQsP1tmyYMxVm4kAcpgWKGViuL
	 pnn5dDUh3miT0za6lvJ5Tt4kemOeid9nVl9fzvPihYhR2wR5WEK7eLcQi5lFQVrnkF
	 XTsAKa6vinHzg==
Date: Tue, 7 May 2024 17:18:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <20240507171835.1e92cffa@kernel.org>
In-Reply-To: <20240506011637.27272-5-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 03:16:17 +0200 Antonio Quartulli wrote:

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index ad3813419c33..338e99dfe886 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -11,6 +11,26 @@
>  #include <linux/skbuff.h>
>  
>  #include "io.h"
> +#include "ovpnstruct.h"
> +#include "netlink.h"
> +
> +int ovpn_struct_init(struct net_device *dev)
> +{
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +	int err;
> +
> +	ovpn->dev = dev;
> +
> +	err = ovpn_nl_init(ovpn);
> +	if (err < 0)
> +		return err;
> +
> +	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);

Set pcpu_stat_type, core will allocate for you

> +	if (!dev->tstats)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

> +/**
> + * ovpn_struct_init - Initialize the netdevice private area
> + * @dev: the device to initialize
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +int ovpn_struct_init(struct net_device *dev);

Weak preference for kdoc to go with the implementation, not declaration.

> +static const struct net_device_ops ovpn_netdev_ops = {
> +	.ndo_open		= ovpn_net_open,
> +	.ndo_stop		= ovpn_net_stop,
> +	.ndo_start_xmit		= ovpn_net_xmit,
> +	.ndo_get_stats64        = dev_get_tstats64,

Core should count pcpu stats automatically

> +};
> +
>  bool ovpn_dev_is_valid(const struct net_device *dev)
>  {
>  	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>  }

> +	list_add(&ovpn->dev_list, &dev_list);
> +	rtnl_unlock();
> +
> +	/* turn carrier explicitly off after registration, this way state is
> +	 * clearly defined
> +	 */
> +	netif_carrier_off(dev);

carrier off inside the locked section, user can call open
immediately after unlock

