Return-Path: <netdev+bounces-167315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABDCA39BC5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74656171758
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A142417C0;
	Tue, 18 Feb 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTLn4Rdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F423ED70
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880636; cv=none; b=hzOtpn1aHQbJsQ+ndoKIBxUDkRxklbfAKLVmOwV9gfUrghqo07vvzfMAOZrvvHI3l6I9wvsKWY4A2YqWbZZI1aVYhzkIxRgWT2NeMnM4bxkkSUB5zWA55RvrYbXcep7x7jywjW+nam0pH91OkR8BWuZPawLJdFSnSwSqTfjJ+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880636; c=relaxed/simple;
	bh=Mk62jvhw6ko49dfwLhJwGxQPKlQidZgIasxbma8ffMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCXkV3xiGW1sQVVj1Oh4E/vm/8xvJUtK+SomwPa1wMhFrdgNqUAH7QcPFRaVKZxMZMVowhwOsXlQSFMchQFlpM2nkaAyOXSO8AgwNR4RFg02CDCligk7JY0ZNg8mlhMwVVqJ6WA7wWpplghgBCaIDt6SSAxNZ6gloxBoZWlnQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTLn4Rdl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43971025798so17159845e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739880632; x=1740485432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKVQ+Leobbwxn2c+p/dbggVPUfw2EMZvd1JGMa7PQPw=;
        b=fTLn4RdlIBQzoWcc6DgniMdOL2ylPBXrV7jqNnQV/HrZbIYiPEOUe1+uHHDXyceQay
         g5uk0Ojgi3qplcFaFdjAQCBYm8lZAqOAo6uSR8L0NHg/2D1BexJ4JP+3vC7o5C8oQWJt
         WSqRlO/eiiWhG93A/8oPfELDHAYDbVmPVUSVEwgjLzKzhN1L8nLL+TBgLyv4UJY47Yh5
         8dOeZSUTEHQPtpVJNi6dKvMS61y6Z2aPHM6JbzhmwAsdGGe6mxjY+T/gAkU41ZgKlKpw
         Mo8SWmqRR5eZewLdr70Ir8ikj02Xkt6tuI1Pjhjidkpncf7f3oRLceec4dyY3uoYKU0j
         W3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880632; x=1740485432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKVQ+Leobbwxn2c+p/dbggVPUfw2EMZvd1JGMa7PQPw=;
        b=jxEchUvNzROq7XBFHNOYbyi56Bd78NmI8yh7WKEzk4wJcLFKr9EJhRp9zno/CqJsqX
         o4ovOnWIOLS1cJnAEShcso/nx2vHjwIC5fxILmGcc9hpm5pAFigSmZaW/MfO4jmUn69c
         0/lZRRenZNwQXkKu4MqX01WjI3BJu3ixzWgsmmIcIxozZPDuedocz6/L0oZYRvCgO49O
         JVAMSiZQPJ0ZtLsT4r6OTD36ze/xat/+9K4K5L7pVv34YdP0wAlzxHEA+mmcaTvjF9wA
         neLJp3y7qOYy0IhRuI5qnblGEGkAZ6ShLTmyOjKKMsJsmoFzPQWcSY/vqdEqa3JHYCod
         mKEw==
X-Forwarded-Encrypted: i=1; AJvYcCUbTUZAKkp+QJZhJx4KoiHfAZ0uhjMhC4ZR4rGMmzF8ce3jGIG5dKl7YowZtHxWHG9Fw6iT0SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqDIFQuwyE3SpyTGTmGuZGdv+ZKs5jrjrXYOEtBF6zBmNchFD
	GkYWiLc2OIWoq3gl0NBRgiH+PdJFOmzXIeQwBLw0DTsCwFXNmfog
X-Gm-Gg: ASbGnctLSxiWC4+a+V9z0UHlYECKamYKff+aAdMgc4CI/qLjErSrU5k4SSSziJcZ8ZM
	evA2wSxpI/s74o8fZUBAdVY9Lyi9YUKj+cmdAGFCMB9UmIz27COMPDrNLjPU2p7FElUTu5b+Zri
	Djtj0pLTML/vgcz80kReuh8Q2UvrtuC8jZoC1eNSPBA1dNfE6J8aMAqKc6SOhZLD1BRk89cFIop
	eWVIxrB9KLDdkdDsdEo34a5blYVfsmrwVs/0T8Rngo9Cw04IkIBAwFg9ncYuvRB6cqhuwiIJ9i7
	dRstLhyOPxsUYcZFUjRY40Fsf7mwAky1M51C
X-Google-Smtp-Source: AGHT+IGVUk72bsqjmRWqmvyLQrSV8MP+cxYDiFnWkoJ4UtZWVo1TrnDSBcChkN4akrI94dCNjVLnfw==
X-Received: by 2002:a05:600c:19d0:b0:439:4355:2f7e with SMTP id 5b1f17b1804b1-4396e6e1a32mr118198405e9.13.1739880631733;
        Tue, 18 Feb 2025 04:10:31 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm60964445e9.16.2025.02.18.04.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:10:30 -0800 (PST)
Message-ID: <38898d98-80c9-4bc9-8603-e968a7c495d0@gmail.com>
Date: Tue, 18 Feb 2025 14:10:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: tariqt@nvidia.com, idosch@idosch.org, hawk@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250213010635.1354034-1-kuba@kernel.org>
 <20250213010635.1354034-2-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250213010635.1354034-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 3:06, Jakub Kicinski wrote:
> Create a pool per rx queue. Subsequent patches will make use of it.
> 
> Move fcs_del to a hole to make space for the pointer.
> 
> Per common "wisdom" base the page pool size on the ring size.
> Note that the page pool cache size is in full pages, so just
> round up the effective buffer size to pages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>   - use priv->rx_skb_size for effective buffer size
>   - use priv->dma_dir for DMA mapping direction, instead of always BIDIR
> v2: https://lore.kernel.org/20250211192141.619024-2-kuba@kernel.org
>   - update pp.pool_size
> v1: https://lore.kernel.org/20250205031213.358973-2-kuba@kernel.org
> ---
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  3 ++-
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 24 +++++++++++++++++++-
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index 28b70dcc652e..29f48e63081b 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> @@ -335,10 +335,11 @@ struct mlx4_en_rx_ring {
>   	u16 stride;
>   	u16 log_stride;
>   	u16 cqn;	/* index of port CQ associated with this ring */
> +	u8  fcs_del;
>   	u32 prod;
>   	u32 cons;
>   	u32 buf_size;
> -	u8  fcs_del;
> +	struct page_pool *pp;
>   	void *buf;
>   	void *rx_info;
>   	struct bpf_prog __rcu *xdp_prog;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 15c57e9517e9..a8c0cf5d0d08 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -48,6 +48,7 @@
>   #if IS_ENABLED(CONFIG_IPV6)
>   #include <net/ip6_checksum.h>
>   #endif
> +#include <net/page_pool/helpers.h>
>   
>   #include "mlx4_en.h"
>   
> @@ -268,6 +269,7 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   			   u32 size, u16 stride, int node, int queue_index)
>   {
>   	struct mlx4_en_dev *mdev = priv->mdev;
> +	struct page_pool_params pp = {};
>   	struct mlx4_en_rx_ring *ring;
>   	int err = -ENOMEM;
>   	int tmp;
> @@ -286,9 +288,26 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   	ring->log_stride = ffs(ring->stride) - 1;
>   	ring->buf_size = ring->size * ring->stride + TXBB_SIZE;
>   
> -	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
> +	pp.flags = PP_FLAG_DMA_MAP;
> +	pp.pool_size = size * DIV_ROUND_UP(priv->rx_skb_size, PAGE_SIZE);
> +	pp.nid = node;
> +	pp.napi = &priv->rx_cq[queue_index]->napi;
> +	pp.netdev = priv->dev;
> +	pp.dev = &mdev->dev->persist->pdev->dev;
> +	pp.dma_dir = priv->dma_dir;
> +
> +	ring->pp = page_pool_create(&pp);
> +	if (!ring->pp)
>   		goto err_ring;
>   
> +	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
> +		goto err_pp;
> +
> +	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 ring->pp);
> +	if (err)
> +		goto err_xdp_info;
> +
>   	tmp = size * roundup_pow_of_two(MLX4_EN_MAX_RX_FRAGS *
>   					sizeof(struct mlx4_en_rx_alloc));
>   	ring->rx_info = kvzalloc_node(tmp, GFP_KERNEL, node);
> @@ -319,6 +338,8 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   	ring->rx_info = NULL;
>   err_xdp_info:
>   	xdp_rxq_info_unreg(&ring->xdp_rxq);
> +err_pp:
> +	page_pool_destroy(ring->pp);
>   err_ring:
>   	kfree(ring);
>   	*pring = NULL;
> @@ -445,6 +466,7 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
>   	xdp_rxq_info_unreg(&ring->xdp_rxq);
>   	mlx4_free_hwq_res(mdev->dev, &ring->wqres, size * stride + TXBB_SIZE);
>   	kvfree(ring->rx_info);
> +	page_pool_destroy(ring->pp);
>   	ring->rx_info = NULL;
>   	kfree(ring);
>   	*pring = NULL;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patches,
Tariq

