Return-Path: <netdev+bounces-223657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A15B59D22
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80F07AAC4C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFE283124;
	Tue, 16 Sep 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAjVPrSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26520261B6E;
	Tue, 16 Sep 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039141; cv=none; b=dSNWdOzxO4mfNZvkYS25qX8cbYg1/kU7ZwbNYRSWDKBoVpDgC6AyxaQX7vq+iZwGr5Y/GxrMsCtqRh/kqIW6S0qogFSi3FdFkXM81gxqrR952n8UEgHVGwoiMLWaji21JZZRJu6iKq9W9iybkcsrLfYEnabxBD4AWLc9Yo0B5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039141; c=relaxed/simple;
	bh=gk7CesNbqEE41H793e/4urJ3uAUrh7Stsl5ltgqtYXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUjRTNpW30rcyOI7LV15EUhkq6a8BzohXwK7hVIsFJ68FXV4vNFjndnt0DPoDEvvQtO3qXw6xkLiP0JrUp3Gw635MQP2pZTX4UM8DKWVnxh4F22JMdrIVYbPq4ZN8PxsCbkBL/4LRr7K/8kzm+wql0AOC2IG/k3HNcrqiYNPrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAjVPrSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCD9C4CEEB;
	Tue, 16 Sep 2025 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039139;
	bh=gk7CesNbqEE41H793e/4urJ3uAUrh7Stsl5ltgqtYXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kAjVPrSWmPpNcZhZxgRo4lbYUA5EfnpaozdTREstbp6iKceefku3TNYVS6u3lLNc2
	 qFKwotl/btNYv36PQbGqiVm5g2kIxe2+ajSGjkt54Ga8b+Sq8lQbqrQ3o1JJnRkzHW
	 Vx5JNtnQfFX/3wG+Mrgh2t/HxffVY2qAIsAbsBPR9hvOEBobVCMdrzUNKn6TQXfNjJ
	 ZpykYuHQoO7aEf8tJXYsuF7UzMM2W7wX8x7o4zA4o10BhqM06TWoHPYkyPMMGz50XX
	 G07dd1AbAH26SawoUHSBk3AtUBf/exHrdQmGxpjoX9zF+y1dh1sbV+Y3MLfafPuaWF
	 l31lgzVz1uHWg==
Date: Tue, 16 Sep 2025 09:12:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, Lei Yang
 <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <20250916091217.17df915c@kernel.org>
In-Reply-To: <20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
	<20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 03:47:29 -0700 Breno Leitao wrote:
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1208,6 +1208,26 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  	return 0;
>  }
>  
> +int ethtool_get_rx_ring_count(struct net_device *dev)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_rxnfc rx_rings = {};
> +	int ret;
> +
> +	if (ops->get_rx_ring_count)
> +		return ops->get_rx_ring_count(dev);
> +
> +	if (!ops->get_rxnfc)
> +		return -EOPNOTSUPP;
> +
> +	rx_rings.cmd = ETHTOOL_GRXRINGS;
> +	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return rx_rings.data;
> +}

This gets called from netlink, so I think it needs to be in common.c

