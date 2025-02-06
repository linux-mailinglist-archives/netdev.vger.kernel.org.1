Return-Path: <netdev+bounces-163655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E33A2B27C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CA33A829B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BEB1A9B3D;
	Thu,  6 Feb 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJipl0VN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB11A9B29
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871097; cv=none; b=NiNkVKTvvKQ2qkqjbaQGBlbje8uGseG5WvhHhhyVFNozisDhbHv3AnMprOLKXMRclSCbQAHtr1ZZ73eRf+yuX2zFT1e2Ss/cblqywWubsTqKHK7vfRjhPzNV81PkXR7/fhKgq9MGWF8VTxjz+N7YQPSFhaxqleRqp35BBTAFBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871097; c=relaxed/simple;
	bh=6ohrSW/5JVp4bsD8wvjFoYa4vTCbTF5snPh52l0C3kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2bW3Tc83Q2jHfbGnsceAY+PmJsN0NTpgOJ3jn7lEKROo4y2E7dBpYAd2L+vnM5WFYSzLnbN/t3xHJv9iHOcao3R29pSkG/FkcKK/BrQDpua8Mxj4H3xyzfSPIHiY8BoZYffPw2kbLbmLwrUAQK9ZY/p/Widx2xQZ8VDnF5z030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJipl0VN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43622267b2eso13242885e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738871092; x=1739475892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RE8cvCV/HERexI8ceA4ibWbrii9tUDlciBRLc5KXRE=;
        b=UJipl0VNVJ/+i/do4OKcbEYmCFDaNPxgi0Hfk1OMdSCcppCpd2ttoPihuEnU29hvz2
         ViAW+ng50iImM0aavZAfzqYUbcv8BQmtnvVyb/IpQu9w6ft0A0G4Kv7joj4V17mzFh/k
         TCMRwPRaKyiLpDm6L1uWcf9zPGKbaSkl6XQ+79UHvBk1scdurj3xsmsiApg2+VjDxLja
         0z6zDjy6pPuTUNb/dYUuvgx0+xX4l6RzRrCbCrJEj41RPN27soJxstd+lyZlwW85zjzz
         Ps9XjpnAjslD92thTUv8unZ+milWLtg/3LK2VMAEv+i4RJ0Q0yJLihbDTAbQEOoIeh09
         bWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738871092; x=1739475892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RE8cvCV/HERexI8ceA4ibWbrii9tUDlciBRLc5KXRE=;
        b=KTqETyED4jQJDxF0UrRMdr5Ds/1XAtFK+DpmolvaVNj95zanlafbXhGdDOC1s66PXb
         Q+J91+CR+WQLdyKFvLcwKDjgR/ZeF6By1WUYw3o34eZ582nycJs+bFzpHrnBJwwQtqQV
         43TuQ5vskvvs6x5oNFopum9YGuimy5ygx0H4cK2SEW7E4PY5aaAA/XplLDGIxS3faVn2
         KccBwk6ny5vh6VUV3sDEPeS2laiW3cm+p/MuZD2AwrbYef8TJoDImZsQiOotDAHvqBaL
         yRJKJD2kNsxYbF0RnMwMqPv6UzqczPDgMzmi1llxn/rkfzoA6RICazQdv10VoU1YcDD2
         /lEw==
X-Gm-Message-State: AOJu0Yz4ZL+dxZBw5ST18NGUKA6stn62QY3emgVKkOXynWMEYG7zsHR+
	XbMR/nUHXH22tuQelUhIF63WBPDsgYNneeEA4p54f2+cf51T8yFN
X-Gm-Gg: ASbGnctZ2PVJWsrdbLaqwURfwpL2rC1h2krbt6iUZ3Lk7UgbZ/VKQiZXsTOf8zLmM5+
	mWQogewzz7beOqlu3zmo/iSCovhxlIPOOa/AliHfhtsg2VDjIcGXord2A8lDakaUulqyWa4PVUp
	FFTS1Qh5dj85RVzF9i1W6Xif8oq/V5zJ/udt+1A/QglJ4WSNj+CoiXinOxrTM/eDdizWBh2YGV5
	sHUI84PS2MTb3BZtp9v7ZR6/VS7vilmAVBTgND6OKBtAnbXe5ezIAtgJzAlsmi90G9WwXB9v3iJ
	j5j1MQjj7VSrBQd47x6mNBmThNNTxQW/T+V1
X-Google-Smtp-Source: AGHT+IFuEtpQ3votOXo6im2Pijns/AJ2mR5XC/LP5EEhrHybLAI/hQvVIYUdqn68m51O1F/tYYW00A==
X-Received: by 2002:a05:600c:3552:b0:438:a1f5:3e38 with SMTP id 5b1f17b1804b1-439249c75c3mr6659715e9.30.1738871092078;
        Thu, 06 Feb 2025 11:44:52 -0800 (PST)
Received: from [172.27.51.105] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d933794sm66737905e9.7.2025.02.06.11.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 11:44:51 -0800 (PST)
Message-ID: <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
Date: Thu, 6 Feb 2025 21:44:38 +0200
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
> index 15c57e9517e9..2c23d75baf14 100644
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
> +	pp.pool_size = MLX4_EN_MAX_RX_SIZE;

Pool size is not accurate.
 From one side, MLX4_EN_MAX_RX_SIZE might be too big compared to the 
actual size.

However, more importantly, it can be too small when working with large 
MTU. This is mutually exclusive with XDP in mlx4.

Rx ring entries consist of 'frags', each entry needs between 1 to 4 
(MLX4_EN_MAX_RX_FRAGS) frags. In default MTU, each page shared between 
two entries.

> +	pp.nid = node;
> +	pp.napi = &priv->rx_cq[queue_index]->napi;
> +	pp.netdev = priv->dev;
> +	pp.dev = &mdev->dev->persist->pdev->dev;
> +	pp.dma_dir = DMA_BIDIRECTIONAL;
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


