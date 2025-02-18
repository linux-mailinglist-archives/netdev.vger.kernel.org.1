Return-Path: <netdev+bounces-167317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DFA39BF9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415293B3FC6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0B243368;
	Tue, 18 Feb 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw7VhTE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23822E3E6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880762; cv=none; b=tynfTfa6QuOUzuXFjAqOtUUtcTa8gUU5FOhMga6/2v65N7f+B4KTv2ovV0JsBjkOUyYdTqFomyA8uNybjOUtfZC8cJsfe5SiM1OXdF5GqJiu7gb7a2AJ1IuYe/arUwRXZu9IZliDul8kQZ8hRHUW/azy7S48J7TijliMFa6nflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880762; c=relaxed/simple;
	bh=RMlE+aBFnfHwcj/rhzN4XnO9LInYDLRzW3I1FhuywP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzPfm0PL/sGrn5iWk+DT3jqUHiubeYvEtj6dmowzgTamajIP2kyvN3dbFmkjJ1a4bUwiz7jyURDPQ8cyQ5SoN0yDURm6xpiuzOgC0s4Si4jJVuOwN5pGkAfvdXoyMLaumG/AshAx+nVTZA4gISmTFVrFR7w6UK1kmbCznmN0W/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw7VhTE7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2751121f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739880759; x=1740485559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X47cQH6FR6C7j/Up4LLz6aoSjJ7SgUOnLSAusotpZnU=;
        b=Iw7VhTE7yu9XbOBFjGsXxyH/rLUcw4VKP8zcgGVOpevigm3uCAaq9b7yYOuoMrQu9u
         R9h0jLBKIb5Qx+Yww1qH4m20VDV7RDZ8I4+beqQ9Qu5Y4W+DHwZLowWI03vr1znl2JFK
         7NFF1FSdfYBy8UhdRbsfbS1lJyTzpwTsvgKFSbbQCnyYRUJQl4UvepENOvtMgaRR+ueB
         XGthdF8+1CK8zowWrVPCNnjEOwgUUYfTggGbVllW45oG3nd9VWlqtzcEC5CC2aua7Jx3
         JERk2FOCY/Rj7iqbNnyAAFFlFamViIcVTFYKi6Ah0bF55nsW+ETYf3FS8r10SUi3hEkg
         EbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880759; x=1740485559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X47cQH6FR6C7j/Up4LLz6aoSjJ7SgUOnLSAusotpZnU=;
        b=nwVdjpNDmbcqPPvwspLuJ0srxmYWze1qxd+cGRGsypUfXJ0joPXIQmEJXuH0g0CQxV
         dlTUyqewDuiaPHOwb8zKWhMjBWbYNizxstwGRhzFgX00P3/mZ2cmoeOvs1bTgS6D3zXL
         vWlWX38RFPz0kg30yYfGA2zj0vDERfqnmPkze123qzzW759m1GC8bbVwVNh6eWYnKDqa
         gKDfqLvtK6uvA1L0wkOYqhS/aT7Rfl+y2uRYv3Dh6nbDgrY+pBOSk1b6ec762oE9qNSl
         feWDxv4bYFJGaiTOG+H5JazBusShEFiES0Bnw7fIvE5CkFht0BbuAFkIXoH5lXN9dQzk
         QwUA==
X-Forwarded-Encrypted: i=1; AJvYcCV0L7rR+L60BjjOpbhhfNsEIQqj6HoxCnqM48cM7JKS7IB/h1D/mlRPip2mnB98zr6ImPU5L8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrbl89vxheN6RV/JNTzV+/ksxzexmpZ7oLE8aUorlOuDSUzZEu
	Kn7uwlc5qkHA2CSmoNP1q9Eu+HxN3Bb4MVD/4GZWoCi+dYVJW+ub
X-Gm-Gg: ASbGncsTolAl5eFRVrJJHe+zQjp6CcQE6YN9HbuT309QwHnExd2sG6qy0/039sciSKR
	Zn41FqbNqix98/ISpSMDHSkc5l1/MIOgeyl05M4nT3yuH/BVRONVupkUHBGIdKeBqQzI//2M477
	7kD6DIDONRJiG7qDCEIkIIhUrH8eIAX2AM3aVLNFBl1WZdRgNFOVdCslg3H7zQlJBiTIT3oddIl
	SSbZZzS9IfJwHnED5qW+QgByF6QAOMTzXCYDuQnhSQ2pYP0u6wvMiTib+aj48lf64B/V1KWNp/z
	FGb+wWCgVdMyLz9cE6Dyz+2YOQp1afGUJmkc
X-Google-Smtp-Source: AGHT+IGfl26QBRcs7azxFZkwq029uy2eHK8IvR/k3nk3ZYaPlK2rx8OjgmvLLP8g8FdagMI+2HLiig==
X-Received: by 2002:a05:6000:1541:b0:38f:3a89:fdb1 with SMTP id ffacd0b85a97d-38f3a8a0139mr9293747f8f.30.1739880758309;
        Tue, 18 Feb 2025 04:12:38 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8730sm15201161f8f.93.2025.02.18.04.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:12:38 -0800 (PST)
Message-ID: <a52f405f-1be6-4fe6-a8d2-a8be63158662@gmail.com>
Date: Tue, 18 Feb 2025 14:12:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] eth: mlx4: remove the local XDP
 fast-recycling ring
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: tariqt@nvidia.com, idosch@idosch.org, hawk@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250213010635.1354034-1-kuba@kernel.org>
 <20250213010635.1354034-4-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250213010635.1354034-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 3:06, Jakub Kicinski wrote:
> It will be replaced with page pool's built-in recycling.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: no change
> ---
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 11 ------
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 40 --------------------
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c   | 11 +-----
>   3 files changed, 2 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index 29f48e63081b..97311c98569f 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> @@ -253,14 +253,6 @@ struct mlx4_en_rx_alloc {
>   
>   #define MLX4_EN_CACHE_SIZE (2 * NAPI_POLL_WEIGHT)
>   
> -struct mlx4_en_page_cache {
> -	u32 index;
> -	struct {
> -		struct page	*page;
> -		dma_addr_t	dma;
> -	} buf[MLX4_EN_CACHE_SIZE];
> -};
> -
>   enum {
>   	MLX4_EN_TX_RING_STATE_RECOVERING,
>   };
> @@ -343,7 +335,6 @@ struct mlx4_en_rx_ring {
>   	void *buf;
>   	void *rx_info;
>   	struct bpf_prog __rcu *xdp_prog;
> -	struct mlx4_en_page_cache page_cache;
>   	unsigned long bytes;
>   	unsigned long packets;
>   	unsigned long csum_ok;
> @@ -708,8 +699,6 @@ netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
>   			       struct mlx4_en_priv *priv, unsigned int length,
>   			       int tx_ind, bool *doorbell_pending);
>   void mlx4_en_xmit_doorbell(struct mlx4_en_tx_ring *ring);
> -bool mlx4_en_rx_recycle(struct mlx4_en_rx_ring *ring,
> -			struct mlx4_en_rx_alloc *frame);
>   
>   int mlx4_en_create_tx_ring(struct mlx4_en_priv *priv,
>   			   struct mlx4_en_tx_ring **pring,
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index a8c0cf5d0d08..d2cfbf2e38d9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -142,18 +142,6 @@ static int mlx4_en_prepare_rx_desc(struct mlx4_en_priv *priv,
>   		(index << ring->log_stride);
>   	struct mlx4_en_rx_alloc *frags = ring->rx_info +
>   					(index << priv->log_rx_info);
> -	if (likely(ring->page_cache.index > 0)) {
> -		/* XDP uses a single page per frame */
> -		if (!frags->page) {
> -			ring->page_cache.index--;
> -			frags->page = ring->page_cache.buf[ring->page_cache.index].page;
> -			frags->dma  = ring->page_cache.buf[ring->page_cache.index].dma;
> -		}
> -		frags->page_offset = XDP_PACKET_HEADROOM;
> -		rx_desc->data[0].addr = cpu_to_be64(frags->dma +
> -						    XDP_PACKET_HEADROOM);
> -		return 0;
> -	}
>   
>   	return mlx4_en_alloc_frags(priv, ring, rx_desc, frags, gfp);
>   }
> @@ -430,26 +418,6 @@ void mlx4_en_recover_from_oom(struct mlx4_en_priv *priv)
>   	}
>   }
>   
> -/* When the rx ring is running in page-per-packet mode, a released frame can go
> - * directly into a small cache, to avoid unmapping or touching the page
> - * allocator. In bpf prog performance scenarios, buffers are either forwarded
> - * or dropped, never converted to skbs, so every page can come directly from
> - * this cache when it is sized to be a multiple of the napi budget.
> - */
> -bool mlx4_en_rx_recycle(struct mlx4_en_rx_ring *ring,
> -			struct mlx4_en_rx_alloc *frame)
> -{
> -	struct mlx4_en_page_cache *cache = &ring->page_cache;
> -
> -	if (cache->index >= MLX4_EN_CACHE_SIZE)
> -		return false;
> -
> -	cache->buf[cache->index].page = frame->page;
> -	cache->buf[cache->index].dma = frame->dma;
> -	cache->index++;
> -	return true;
> -}
> -
>   void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
>   			     struct mlx4_en_rx_ring **pring,
>   			     u32 size, u16 stride)
> @@ -475,14 +443,6 @@ void mlx4_en_destroy_rx_ring(struct mlx4_en_priv *priv,
>   void mlx4_en_deactivate_rx_ring(struct mlx4_en_priv *priv,
>   				struct mlx4_en_rx_ring *ring)
>   {
> -	int i;
> -
> -	for (i = 0; i < ring->page_cache.index; i++) {
> -		dma_unmap_page(priv->ddev, ring->page_cache.buf[i].dma,
> -			       PAGE_SIZE, priv->dma_dir);
> -		put_page(ring->page_cache.buf[i].page);
> -	}
> -	ring->page_cache.index = 0;
>   	mlx4_en_free_rx_buf(priv, ring);
>   	if (ring->stride <= TXBB_SIZE)
>   		ring->buf -= TXBB_SIZE;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> index 6e077d202827..fe1378a689a1 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> @@ -350,16 +350,9 @@ u32 mlx4_en_recycle_tx_desc(struct mlx4_en_priv *priv,
>   			    int napi_mode)
>   {
>   	struct mlx4_en_tx_info *tx_info = &ring->tx_info[index];
> -	struct mlx4_en_rx_alloc frame = {
> -		.page = tx_info->page,
> -		.dma = tx_info->map0_dma,
> -	};
>   
> -	if (!napi_mode || !mlx4_en_rx_recycle(ring->recycle_ring, &frame)) {
> -		dma_unmap_page(priv->ddev, tx_info->map0_dma,
> -			       PAGE_SIZE, priv->dma_dir);
> -		put_page(tx_info->page);
> -	}
> +	dma_unmap_page(priv->ddev, tx_info->map0_dma, PAGE_SIZE, priv->dma_dir);
> +	put_page(tx_info->page);
>   
>   	return tx_info->nr_txbb;
>   }

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


