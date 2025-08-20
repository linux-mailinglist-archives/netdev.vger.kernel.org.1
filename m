Return-Path: <netdev+bounces-215303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6DB2E005
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76883A5D6B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029B3203B5;
	Wed, 20 Aug 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgV2zYRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4631E119
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701569; cv=none; b=Z7a5h4rDumNJP/JkVSRJdTNAiUIUqk/ptsQ8izOEL48eeZfw1KpvMRz7n1ZxdWSgZ3mc4Z/BuXDVZE7O1BNTKP7WSw8ixingVDEqdmZeNYoFXC5CiFwtt0VcDxf4l8XihyAFKBMt018zk4CT8SoxX1D6MzjslQID8Iqfu5ICEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701569; c=relaxed/simple;
	bh=FxvqJnRcSmLIK9+yvuiS9vhKSZMVKxh5Vdh9yiyJHcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZrBDwzd5UluxAZJJPMwkC0/AiMsFyW6NaQb3JH4wPJMhwb7ywbSC1HCTFaDe4eTLe1YH0IHOrsOZ37enNsGyZ3vG8O11+4wLz8mNvGxW+AwgHy/C6lXSh/jvMqBTDxew58lGZS4TcxXy58jR2BcZCf1MVm1q6EzOOf/nQiGv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgV2zYRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E2C4CEE7;
	Wed, 20 Aug 2025 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755701569;
	bh=FxvqJnRcSmLIK9+yvuiS9vhKSZMVKxh5Vdh9yiyJHcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgV2zYRR0wDgFSeuatQ5eDscaGWsLwjXBqOsGYUfbaHAQyyb+7IBBVRHxIhjmcQfW
	 ZJnasqQEqqV5KJwrgUss1SWSd8jscxQIftAgj00lZRrki3KC7NJJdUMd2F/8x0HKr9
	 JpID0xru26jnPX9I4wtPIjPWiMF73++HjUVbYlvB5u8uVtXlfUFmV7QIQ3L03ndJ1j
	 BWd7h/xBrWHnkpFbw9NkDMw4SVbWK9rVHS576cCbMpxoEiJsw4efSYq1kP8/l8mO/N
	 YTyohr0YYFEFpYJWjMuEfJjek5lWtRwIhAc+dzrEh7ifYGK9+jRjOe4k5Ba8wswOhG
	 BeIufWE4KcTkQ==
Date: Wed, 20 Aug 2025 07:52:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Dragos Tatulea" <dtatulea@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <almasrymina@google.com>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <alexanderduyck@fb.com>,
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next 11/15] net: page_pool: add helper to pre-check
 if PP will be unreadable
Message-ID: <20250820075247.153b392b@kernel.org>
In-Reply-To: <DC77YRDDLDV2.2RNW77Q8HPLTH@nvidia.com>
References: <20250820025704.166248-1-kuba@kernel.org>
	<20250820025704.166248-12-kuba@kernel.org>
	<DC77YRDDLDV2.2RNW77Q8HPLTH@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 11:30:42 +0000 Dragos Tatulea wrote:
> > +bool __page_pool_rxq_wants_unreadable(struct net_device *dev, unsigned int qid);
> > +
> > +static inline bool
> > +page_pool_rxq_wants_unreadable(const struct page_pool_params *pp_params)
> > +{
> > +	return __page_pool_rxq_wants_unreadable(pp_params->netdev,
> > +						pp_params->queue_idx);
> > +}
> > +  
> Why not do this in the caller and have just a
> page_pool_rxq_wants_unreadable() instead? It does make the code more
> succint in the next patch but it looks weird as a generic function.
> Subjective opinion though.

Do you mean remove the version of the helper which takes pp_params?
Yeah, dunno. I wrote the version that takes pp_params first.
I wanted the helper to live next to page_pool_is_unreadable().

If we remove the version that takes the pp_params, this helper makes
more sense as an rxq helper, in netdev_queues.h / netdev_rx_queue.c :

bool netif_rxq_has_unreadable_mp(dev, rxq_idx)

right?

