Return-Path: <netdev+bounces-116287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE20949D4F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96561F22494
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 01:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECB1E520;
	Wed,  7 Aug 2024 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASTo3l38"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD292C1BA
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993418; cv=none; b=sOwJXv8UXMa1lqLoPGhos8ogmFHQ+xUCRm5mdRxCs8dmBf91jiHbf3VaDsCwRZKEHAj6l60xZxBN52zzK/bPHbk4XzLXfPT4pcc7uEWIklcoSc5brzPfzAon0lP9ZiZsatnqg/G5OCxDkr8cSF94wlb4NnHCjBqFPkdvPbC6tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993418; c=relaxed/simple;
	bh=HQ4lNOfZ4aYOA2R0EvfkgxjJzs4j5xM6+QlVmxOkYT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNifee+GI67D38n3VQ33qVsij8hcr6PYBogGRC1v4OMN3SPc78UaQMeE8GTVTo2S8H01VC0RtJ8irXKhWDjWkw3o3Uxdhgsuef2R0YXWOWXCGV8wQTQhIi9Yy9acqPvuIPX6ngW6S6hYTX5NVxThugmn8Wyyi3k9f01ELw5ru9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASTo3l38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2CC32786;
	Wed,  7 Aug 2024 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722993418;
	bh=HQ4lNOfZ4aYOA2R0EvfkgxjJzs4j5xM6+QlVmxOkYT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ASTo3l38I3x+NwxOGQ85K0pGyxgPWqchIsCosjDAiatow1v3cJJrzj0oNNsomXksb
	 z+JJLvHaz59+97uAj0FFjcY8UKaHVpbgFfF2oZtI9h/YP29CQ3CTlYW8hKA3qXluW6
	 ZLQ+6298nAWx56BgPYICua4FhX4kGRoY3bkbK+RdpTRZ9Zs+5G3lqVxsEITSOzxow0
	 lEa0zNS+numUsN/vdRKPnb5USN5CB8RCh0Sg7s3l3qi2kgjgzuS2qyFSZvcXaciu6l
	 BKY69U5I7ZerOguzdCa42pqG1+ci8ceA1IfPT5zVyoXpxzohfBBwAIBHTLqboif99i
	 eJGCjrxKGPItw==
Date: Tue, 6 Aug 2024 18:16:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 06/11] net/mlx5e: Use extack in set ringparams
 callback
Message-ID: <20240806181656.2c908cfd@kernel.org>
In-Reply-To: <20240806125804.2048753-7-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
	<20240806125804.2048753-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 15:57:59 +0300 Tariq Toukan wrote:
>  	if (param->rx_jumbo_pending) {
> -		netdev_info(priv->netdev, "%s: rx_jumbo_pending not supported\n",
> -			    __func__);
> +		NL_SET_ERR_MSG_MOD(extack, "rx-jumbo not supported");
>  		return -EINVAL;
>  	}
>  	if (param->rx_mini_pending) {
> -		netdev_info(priv->netdev, "%s: rx_mini_pending not supported\n",
> -			    __func__);
> +		NL_SET_ERR_MSG_MOD(extack, "rx-mini not supported");
>  		return -EINVAL;
>  	}

This is dead code in the first place, mlx5 doesn't set associated max
values so:

	if (ringparam.rx_pending > max.rx_max_pending ||
	    ringparam.rx_mini_pending > max.rx_mini_max_pending ||
	    ringparam.rx_jumbo_pending > max.rx_jumbo_max_pending ||
	    ringparam.tx_pending > max.tx_max_pending)
		return -EINVAL;

in the core will reject any attempts at using these.

