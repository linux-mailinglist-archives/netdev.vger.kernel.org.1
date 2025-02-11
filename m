Return-Path: <netdev+bounces-165259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E7A314DB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4791160876
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8F1E4929;
	Tue, 11 Feb 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6IGPRTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748A1DDC14
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301533; cv=none; b=FI+2fKo7eFvHl5/wVLdnN1WVYVthsFYlxrU6SXLujyYLCX0taR1GDioZOBcLcQROxxW8CGY+IjJ0uh3R0aXffsH+e97LmSX6X0gCfNA7296H0/1Iyg+8sc+8zL3ZbJVTVWoG1v01epkOH4yqkmpCWUAGfBAlIpJXlivK5K1F3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301533; c=relaxed/simple;
	bh=CGi9ZOITBdFZluNfiLT7NCh1Tn/TBDC0RufTwMxoFgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsg8aOSTM5m3kzRj47ocC+gL4bKG3oloP33gPHZmyNKkcpMkehxh61Qu+4469NwnEPF3zH4s45eTrNODB3wzu0uoLuYjBJDpylQDhx6W3gF6uvA/o/dvRkdtjMzWBODyf3kKM40ZO/HecGN4EdsVtgRFKeyOiFIqPlXCh0aXQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6IGPRTV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43944181e68so28639925e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301530; x=1739906330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTfZOHANu/YGppikkXhX4HscJiCNWNI6kh9fsouaqCw=;
        b=j6IGPRTV4+waazYO0Av/cAVu3MvnGiLAA7DTVfWueglQGyKRwGcvEm9y8ayORYH1VM
         JzWJcJbq9ASigFzKFPCALnC+zr9bTnnPiiKL4f+tpUmorGLWgObgM0Wmg0z5iPPXKfln
         75ehW4yZJ5LsXlQXt3oMPkWydanMBwQsfUOiLH6Ru7OdhVoe6csKIa73AE9wGdmlzHQn
         SsqHkFZPH9YXlTm4OfKYQyZvtXAvQRXqNL3W+FwdZV4DjuCHVlDrxQSDtDhGkgUYFiSc
         kerNom0E1tOGJHZBys0/UbCfx2PfTMyG0LqDRTkqeag2iHb42nLq6IkIdbaEGb0A+GKm
         CPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301530; x=1739906330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTfZOHANu/YGppikkXhX4HscJiCNWNI6kh9fsouaqCw=;
        b=Omq72DAxXxoSLHJ4iv1W3QwtB0xf5PrpA8TDXLEOBnY5S3p77ELz60udChL5JzOkbq
         LvDTuJL83BQxfjJU4E3RTkePfzxGQGMXV697MnAWKXjfytKBelQj+G/TvkJxqupsAmYi
         KwmSjc2l1tNnVD2GQP1H50H2OhSjjrW9OWdF67Q1Nin5hAyhdVQOMUjOcc08JlYS+fuy
         ErmZou1xKrllfbY23aycilNzbdbqGSmZxZkBIX//gknjbgYer56STAXSzSV2dO9vJjqh
         sAvrbEYaxItUMzG4KoYNzw9Lj0p8ZqfwZ56pfrRhYcuYnAqQQDXjUm6N8MzAR6PHeY0Y
         Ip4Q==
X-Gm-Message-State: AOJu0Yw8smlZ/diStIOBBLiclWl7sCoUddAgsh0mLmW53zkD0eimHYWm
	4ms6eV9UcdzS4veC1IfdbPRNSIswKXGE0Hnfh1n0J/nDrHEEGnnTT7TEqA==
X-Gm-Gg: ASbGncsVLraw6uJo+9oxrojIPADHNexf7wixmkv6c0XfGaeG1sokl+kmxgtnQheFtvK
	mYS1mBIWAfnLrymLh4PZFoHJ+dAzBV3OKz5eLbJXFBXqVJkvSw/uCew3SE5AzRig8wcUsF+E7aH
	u5jl5T7dlLmufDZoSyOgR6VMPXz3IedbyHxrJUmF3vYUjMrb598RtRUPERW1WHgl1qLcctEKEc0
	2LHai5WjlQoU5jb7Okrk0K5L9Sz938P38/A9kszSrOEaiBeOGp7c/9XrRxYH/kR3p6JRW8Hdjk5
	1S3Bvlqs1SWqbTfP38G5SIdXBBtlP7tdLWFQ
X-Google-Smtp-Source: AGHT+IGc8avIHv+5NLQZSMYVUgvzPDowNPWx7B2vuf4fHaXkRtljAGjn/ODCxOOJO3mi3Yj+DKV7Iw==
X-Received: by 2002:a5d:6d0b:0:b0:38d:cab2:91db with SMTP id ffacd0b85a97d-38dea251ff6mr187214f8f.6.1739301529299;
        Tue, 11 Feb 2025 11:18:49 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da9648dsm190527785e9.7.2025.02.11.11.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:18:49 -0800 (PST)
Message-ID: <8eab9a5a-ce82-4291-8952-5e5c4610e0b0@gmail.com>
Date: Tue, 11 Feb 2025 21:18:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-2-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250205031213.358973-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/2025 5:12, Jakub Kicinski wrote:
> Create a pool per rx queue. Subsequent patches will make use of it.
> 
> Move fcs_del to a hole to make space for the pointer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  3 ++-
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 24 +++++++++++++++++++-
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index 28b70dcc652e..29f48e63081b 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h

..


> @@ -286,9 +288,26 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   	ring->log_stride = ffs(ring->stride) - 1;
>   	ring->buf_size = ring->size * ring->stride + TXBB_SIZE;
>   
> -	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
> +	pp.flags = PP_FLAG_DMA_MAP;
> +	pp.pool_size = MLX4_EN_MAX_RX_SIZE;
> +	pp.nid = node;
> +	pp.napi = &priv->rx_cq[queue_index]->napi;
> +	pp.netdev = priv->dev;
> +	pp.dev = &mdev->dev->persist->pdev->dev;
> +	pp.dma_dir = DMA_BIDIRECTIONAL;

I just noticed one more thing, here we better take the value from 
priv->dma_dir, as it could be DMA_FROM_DEVICE or DMA_BIDIRECTIONAL 
depending on XDP program presence.

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


