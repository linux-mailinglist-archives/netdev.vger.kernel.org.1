Return-Path: <netdev+bounces-115441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B694661C
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2D22832C9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1AA6F068;
	Fri,  2 Aug 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwgKG0v+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742947A64
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640893; cv=none; b=PSLoPdd1J2QY+Jz7i9r2+qEAS+Ys4FG27d/0L+9uQObzV7ukCFEGiSkV6gDqNIX7eHc/59PWjUqwIxqVJahhv7xERI/PW3dX6zIA9tu8N6B08OC06g3Oy5N4K7uSzPaHLvCIuc/ViwwFez0aNonA3lBc1pVlJ64Qdpld8bFnDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640893; c=relaxed/simple;
	bh=+0kjrXxCDa0FtE4zg7wDZfBWHPVJfjHqH9un0RqUMbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBR76FC1/+im/bd4fN08hAfrz3Mp5JdUEOJxU+hMUcsI1b6tlo7dX01P8hs58mcusgPOLhpbZqpSdOic6eTTtupjJotLxPNgbErIGGUsuAvW1b3ZXa5UywXDYiRoWC2uWaPc7WSODk4DYuU5RI5gKPMHYFmLd7VWbqdDPAwzFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwgKG0v+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C8C32782;
	Fri,  2 Aug 2024 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722640893;
	bh=+0kjrXxCDa0FtE4zg7wDZfBWHPVJfjHqH9un0RqUMbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwgKG0v+h1VB/hx1ES0HQh3bDf8zKwSqeTiQ1woOsxu32RXucpMCTpGsASqnYylDe
	 5nrsPmaauasqxtcm+q/Z8D/bvWoi0C75IaogNQpL03J5kMbp9dH8Czr6FjRSMzo/TB
	 PYyCK3QkD0p+pVZ7sVn2UMyKrRJcqGqPXjhE73UugmNbTMImmaAPtorCo/g26ZyIwH
	 +93inde2kOGyEVsjnmejBBm8fpsqnn9H9nYCLhoFlsYZgssZ2+ISDYWpbz+P6PjGE6
	 5jhuselpvTdfctk/TUdOMescZJrakuXbI+8n1f3FNjKA4tA+Cuo/1LGiIwGmmEVy3o
	 Z34lRZNenWjlg==
Date: Fri, 2 Aug 2024 16:21:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, jfraker@google.com, Ziwei Xiao
 <ziweixiao@google.com>
Subject: Re: [PATCH net-next 2/2] gve: Add RSS adminq commands and ethtool
 support
Message-ID: <20240802162131.0eb94666@kernel.org>
In-Reply-To: <20240802012834.1051452-3-pkaligineedi@google.com>
References: <20240802012834.1051452-1-pkaligineedi@google.com>
	<20240802012834.1051452-3-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 18:28:34 -0700 Praveen Kaligineedi wrote:
> +static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct gve_priv *priv = netdev_priv(netdev);
> +	struct gve_rss_config rss_config = {0};

I never remember the exact rules, are you sure this is the one that 
is guaranteed per standard to zero all the fields?

> +	u32 *indir = rxfh->indir;
> +	u8 hfunc = rxfh->hfunc;
> +	u8 *key = rxfh->key;
> +	int err = 0;
> +
> +	if (!priv->rss_key_size || !priv->rss_lut_size)
> +		return -EOPNOTSUPP;
> +
> +	switch (hfunc) {
> +	case ETH_RSS_HASH_NO_CHANGE:
> +		break;
> +	case ETH_RSS_HASH_TOP:
> +		rss_config.hash_alg = ETH_RSS_HASH_TOP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (key) {
> +		rss_config.hash_key = kvcalloc(priv->rss_key_size,
> +					       sizeof(*rss_config.hash_key), GFP_KERNEL);

key is a bitstream...
IOW this code is like allocating a string with 
	calloc(length, sizeof(char)) 
:S

But what is the point of the allocations in this function in the first
place? You kvcalloc here, copy, call gve_adminq_configure_rss()
which dma_alloc_coherent() and copies into that, again.

> +		if (!rss_config.hash_key)
> +			return -ENOMEM;
> +
> +		memcpy(rss_config.hash_key, key, priv->rss_key_size * sizeof(*key));
> +	}
> +
> +	if (indir) {
> +		rss_config.hash_lut = kvcalloc(priv->rss_lut_size,
> +					       sizeof(*rss_config.hash_lut), GFP_KERNEL);
> +		if (!rss_config.hash_lut) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		memcpy(rss_config.hash_lut, indir, priv->rss_lut_size * sizeof(*indir));
> +	}
> +
> +	err = gve_adminq_configure_rss(priv, &rss_config);
> +
> +out:
> +	kvfree(rss_config.hash_lut);
> +	kvfree(rss_config.hash_key);
> +	return err;
> +}

