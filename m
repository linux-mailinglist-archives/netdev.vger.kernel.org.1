Return-Path: <netdev+bounces-236061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3DC38203
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6474E377A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992522E88B6;
	Wed,  5 Nov 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hviKIaze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176F2E7F17;
	Wed,  5 Nov 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379894; cv=none; b=nVZGBEszGElcgz5NqX+mA4jvVNLe6zZS2uWxXLeC4loR02AhYvejlhSUOfkTvV+PU9rQ3Mi+6u7qeK0qz9++gxQ3bX8KccKJr3+ra6UOFJrtmReOgUXfvFU3jTsP509y81/t67eazC4vAUNzvA5yC6o1RrEi3n6TmFs8cgTbb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379894; c=relaxed/simple;
	bh=B8yTV03Q9jwmaCwhHLe+lZXGvL0TrgUTDSNsu86Ozro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTLDCe7Wj3o9KG96AmzB+Gt33qgHPfkyp7XjYDjlP5c8LsrW0T5VlPBvQSX++hg17JoAHNWnERLGe1cJqw6Mfno6oldyTfarjVwfHenKJBRmcdvVx+aA6zCaSlbDwsG1u00qdDHhNFEAeQyCYeXmvqYRRgAQIRfQfUaLaw6g1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hviKIaze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDAEC4CEFB;
	Wed,  5 Nov 2025 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762379894;
	bh=B8yTV03Q9jwmaCwhHLe+lZXGvL0TrgUTDSNsu86Ozro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hviKIazeFK9mJwV73CTvhS5UYKTaVAmURy3ecRJLOsdqvcgAyfQ+QLtnPQ/I0roGz
	 uT9Ga391GEUphWBwRaebXmt0J2sJmRyFj4keCF7Z7JIixyFvMWwkKedRnctjt4gnNW
	 d462U3FOHY6XpaGAK8ndhzNV0vKlOns9ToVreMxhv4pkPhTtlq/NOx1jYSiSlopmD7
	 PyntxuVPVXHYy9+e4ZnIs5e7nrQDA102Je+dnWvMJtjxQt7r+iIC+DqxMnodQ8gAJ9
	 Z3Y9WBKUvic383636ApbmIOHWzQv5eoFG8gzYAdFIwPzjDJbsdiz7BDLhHL7YxbXgO
	 4KkccFEjTrDPA==
Message-ID: <fa6ace55-fb4a-4275-bcd0-c733a788d2b9@kernel.org>
Date: Wed, 5 Nov 2025 22:58:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 ziweixiao@google.com, Vedant Mathur <vedantmathur@google.com>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251105200801.178381-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2025 21.07, Mina Almasry wrote:
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 0e2b703c673a..f63ffdd3b3ba 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -8,6 +8,8 @@
>   #include "gve.h"
>   #include "gve_utils.h"
>   
> +#include "net/netdev_queues.h"
> +

Shouldn't this be with "<net/netdev_queues.h>" ?

And why include this and not net/page_pool/types.h that you just
modified in previous patch?

>   int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
>   {
>   	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
> @@ -263,6 +265,8 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
>   	if (priv->header_split_enabled) {
>   		pp.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>   		pp.queue_idx = rx->q_num;
> +		if  (netif_rxq_has_unreadable_mp(priv->dev, rx->q_num))
> +			pp.pool_size = PAGE_POOL_MAX_RING_SIZE;
>   	}
>   


