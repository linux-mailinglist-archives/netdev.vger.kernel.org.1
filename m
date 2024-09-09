Return-Path: <netdev+bounces-126738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006D9725C8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014E31F246F8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855218E340;
	Mon,  9 Sep 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1wAyl1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2318E04D;
	Mon,  9 Sep 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925241; cv=none; b=ahpCfajN23IiQOtXZpNaoGHxDqoJ0WWTBPSajDH0qDC4MWlmn0p5hzdvh/e94zJyTRnKtRPG7KEmKJ/pou3fsSj5oZsKZ9/5OzANVw4YznbR78QeYXJMEYx8gNdEvsOUx8blcOfB4m6kpyjxbYn8cE0pyZHibhLN/I6K4ytihaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925241; c=relaxed/simple;
	bh=2sTjUnFofjfZlvBUULpDgFPX9npiogf+j1pF5+840/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLXpMYKL6OOU6BvRtx51eKvYnCND9QnpwCFdF5qU2MriRmhMcs5kYDnHs7/l8Ev0ifA6p67dX9PRYoZqYkQvzaiWRWYmLy2wuAfLoO1PWVZKZekP2JJ3Uvm7vyM1NQB7yPaqTt9k1iIEQIBXRk3MKCnufnm01362+ayfV0Z5wWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1wAyl1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6D5C4CEC6;
	Mon,  9 Sep 2024 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725925241;
	bh=2sTjUnFofjfZlvBUULpDgFPX9npiogf+j1pF5+840/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1wAyl1nGTQKf7ly0O4kiJmi20BO05XSRaSRlgITTzYiM0B8VOrSe4VbewqI9hghE
	 nQD3fnpSK5twb0FlUlkNrD2jolC8WdEshelU8Wdmb+qPyvY5c5PP1hgVRLYJzPJIWL
	 14UULXan6dLZnZqzCkYpNgVcf+uBj+UbhCWZ0bhYMqVUDu97CtOG0ry5ORmyORwQGT
	 T0lf5B+OXOTba67BKXZS+L0w+dg+YFNLIlzveKIvMQfUWGy8jt/PB1WB5pzNm91O2u
	 rd3xNXxxTfLbkhWEw1jy9BcBIWrQQru6g1SgMpYdrPoGLehkRQWhQTMmRGbOyo4ceL
	 /wObdUydWU4uA==
Date: Mon, 9 Sep 2024 16:40:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <20240909164039.501dd626@kernel.org>
In-Reply-To: <20240908160702.56618-2-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
	<20240908160702.56618-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Sep 2024 16:06:35 +0000 Joe Damato wrote:
> Add a persistent NAPI storage area for NAPI configuration to the core.
> Drivers opt-in to setting the storage for a NAPI by passing an index
> when calling netif_napi_add_storage.
> 
> napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted), and set to 0 when napi_enable is called.

>  enum {
> @@ -2009,6 +2019,9 @@ enum netdev_reg_state {
>   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
>   *		   where the clock is recovered.
>   *
> + *	@napi_storage: An array of napi_storage structures containing per-NAPI
> + *		       settings.

FWIW you can use inline kdoc, with the size of the struct it's easier
to find it. Also this doesn't need to be accessed from fastpath so you
can move it down.

> +/**
> + * netif_napi_add_storage - initialize a NAPI context and set storage area
> + * @dev: network device
> + * @napi: NAPI context
> + * @poll: polling function
> + * @weight: the poll weight of this NAPI
> + * @index: the NAPI index
> + */
> +static inline void
> +netif_napi_add_storage(struct net_device *dev, struct napi_struct *napi,
> +		       int (*poll)(struct napi_struct *, int), int weight,
> +		       int index)
> +{
> +	napi->index = index;
> +	napi->napi_storage = &dev->napi_storage[index];
> +	netif_napi_add_weight(dev, napi, poll, weight);

You can drop the weight param, just pass NAPI_POLL_WEIGHT.

Then -- change netif_napi_add_weight() to prevent if from
calling napi_hash_add() if it has index >= 0

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 22c3f14d9287..ca90e8cab121 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
>  		if (n->dev->threaded && n->thread)
>  			new |= NAPIF_STATE_THREADED;
>  	} while (!try_cmpxchg(&n->state, &val, new));
> +
> +	if (n->napi_storage)
> +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));

And here inherit the settings and the NAPI ID from storage, then call
napi_hash_add(). napi_hash_add() will need a minor diff to use the
existing ID if already assigned.

And the inverse of that has to happen in napi_disable() (unhash, save
settings to storage), and __netif_napi_del() (don't unhash if it has
index).

I think that should work?

