Return-Path: <netdev+bounces-220505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7BB46745
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9AE1C87753
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD5296BBF;
	Fri,  5 Sep 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPOS8IeI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A126B951;
	Fri,  5 Sep 2025 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115775; cv=none; b=CzIaWsng+fG8Zs6BtzfNSBolx3hHOzjUmolfecVkc6mYD3h5w8Qzwe7jQwXD6IUmGlhu6KJ1ezyeLkNo9I8VVkYe6ymjb6s9UkOwUkW0F1dYQ3XMC/i8/seGdSS6+MQ3Kd787OD6YD6xJ3jBkSd7Rf1hEYWNOFmsk7A7vGNEH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115775; c=relaxed/simple;
	bh=Z4AafRmSqirL4OdrjEWSxwft6czYJP8hw7N/bR6khaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5m5TOvOPuEXw9PEWyNAm3dFXz4it21vkkqLb7upfJ3Up7dDbvtjRVYqOC7y7rncPHI+gX1kZ4LwKsq+SREim+mcPCrFMnlsXmE4Wjj1saPsWy7SEX8JZCV4NNOTe9xq5bK9pbe1ArH3UUOYIok55uP7ZKFDBeiEZFHtsQY39Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPOS8IeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC753C4CEF1;
	Fri,  5 Sep 2025 23:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115774;
	bh=Z4AafRmSqirL4OdrjEWSxwft6czYJP8hw7N/bR6khaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SPOS8IeITLATnexg0CrOFsJngLGbZWPeLa81mWBhS2jVPMLSDYVXuHJvBImbGE6S4
	 K9apfFx8yriqCpeCkNs97UpZpNTh51pe6lvMkqFg5YykMrm7dmsvPFIWxoYhxIf6kX
	 EmhMe1fQ9wxyaAk6/yyxy6dNOS+4z0dze49CW3868a0ZWXaSqz0w2wlszbwNRiLQnI
	 lqH1Mda1bnui12BOeiURCM0lGidj5bz+7KckguicOb+kJmk2dbzCK7nhRaGWwPSEYY
	 fs0RqlGMuSzd6BiEcTjLCaeWCd81KEuMuBGG8TYfdzynUYT8N5iiQenI1XB8PJSOhd
	 gtuN/SviVpeXw==
Date: Fri, 5 Sep 2025 16:42:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 jdamato@fastly.com, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next 4/7] net: ethtool: add get_rxrings callback
 to optimize RX ring queries
Message-ID: <20250905164253.4e9902d2@kernel.org>
In-Reply-To: <20250905-gxrings-v1-4-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
	<20250905-gxrings-v1-4-984fc471f28f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 10:07:23 -0700 Breno Leitao wrote:
> +	int	(*get_rxrings)(struct net_device *dev);

I think this can return u32..
The drivers can't possibly fail to know how many queues they have.
We already do that for get_rxfh_*_size callbacks

>  	void	(*get_pause_stats)(struct net_device *dev,
>  				   struct ethtool_pause_stats *pause_stats);
>  	void	(*get_pauseparam)(struct net_device *,
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 1a9ad47f60313..2f3dbef9eb712 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1208,6 +1208,22 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  	return 0;
>  }
>  
> +static int get_num_rxrings(struct net_device *dev)

This one has to indeed keep returning int, until we get rid of
get_rxnfc fallback completely.

> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_rxnfc rx_rings;
> +	int ret;
> +
> +	if (ops->get_rxrings)
> +		return ops->get_rxrings(dev);
> +
> +	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return rx_rings.data;
> +}
> +
>  static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
>  						  u32 cmd,
>  						  void __user *useraddr)
> @@ -1217,16 +1233,17 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
>  	int ret;
>  
> -	if (!ops->get_rxnfc)
> +	if (!ops->get_rxnfc && !ops->get_rxrings)
>  		return -EOPNOTSUPP;
>  
>  	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
>  	if (ret)
>  		return ret;
>  
> -	ret = ops->get_rxnfc(dev, &info, NULL);
> -	if (ret < 0)
> -		return ret;
> +	if (WARN_ON_ONCE(info.cmd != ETHTOOL_GRXRINGS))
> +		return -EOPNOTSUPP;

I think malicious user space can trigger this warning with a TOCTOU
race. Let's skip the check, it's not really needed?

> +	info.data = get_num_rxrings(dev);

