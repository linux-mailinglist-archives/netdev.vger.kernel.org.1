Return-Path: <netdev+bounces-167318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03EA39BEE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC927A516C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739D243394;
	Tue, 18 Feb 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8MEONzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2A24338D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880801; cv=none; b=FcFjTbGHjKPKDV/Q2NpDQ59cxMIwsph9lBWFzTDA1y0cmkImg8jHF94yBDDu5P4k1u1p3Pi9joBDMEvlJl0Rk1RCcFpHHFUDMGCogM82s2GV1WkofXU1WiblR1yJ0KwE/IM/892KMOCuqNt+2zbipkkPZriABq+6KqW8q1n4+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880801; c=relaxed/simple;
	bh=Ketz9vdr2AGn1KPCYEVONEtPDtN654dH+Z0vQyn1y0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcfvzZuo8sRezwWi2Y6RTzag5g8COXbzRTspSCeby7L73pP8ExN0e7zTefHK1hW6jkH9h4JeUqTOw+LeEykE2cBpFa6MzTzbavTHSWT2qDFuKcb99zcMkzMXcwFhW0iqOoEYgy8E5xH29WjXJoHLf2oOa9iv+Tez1eZT+YErZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8MEONzy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso16766865e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739880798; x=1740485598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SW22Yu0nffl+ohbcLBDtP83UD79o0fM5BUreV7SrudE=;
        b=m8MEONzyaeOVHss3wNE/JH2jjYMuQhksMKXJy2s3taWlxTVWD9RQXClb4ll+GxwnZZ
         cQ+y7g5UdRi74BZ3Ju/lyAjjCrhSKRS4cSjL8AvxeRH8ZXeEWNDFKY9fUfrAphU8gl0I
         LWX30RdE5VuOv4G+jtF6uAIPa9uJDLHHQuVtDumlrX8r/vRjPC0KoHZc42eZQO7Qu0yN
         Q3Y5fo4P4HyKyhiQIbFTl6/OMFaV8cyjVIxTdtt0MGKWCmfFikBdq4QJtwHeWU9BgDIL
         TBXFIqxrYNWimcaZLFXWzopQSfGjhPv0QZyYWHtI2BNs7VAXi55NabMMbz1nc41KU8Jq
         plqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880798; x=1740485598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SW22Yu0nffl+ohbcLBDtP83UD79o0fM5BUreV7SrudE=;
        b=g12ak1AXpOVLAkGXERR5vAib8PV1xoyZhmjEws3Uh35tRHKunJi2UJTGxiBu3OujA5
         MiCB+LetCnF7ATYbVvyU045aCxnAGUhi9xj2gDbl3x8OFx4SVRbjz1mcUVZCGUbppJG9
         y9W/1QbEi6SU1Z3aM2l6v54JWPvPnqbeAJWwnvZJa1+3XX24VTQXr0Y3IjS+Zh3Atsiz
         yefmC/4Ebf6gb3DmvBRU6vBO4VMF6kglWddPK/cScnUHM8oFNClddeLMZMMY6ArmyyQT
         sWU1wGPcn7Xivnt+C6o14EupsiIrHo1GReLV/g1r/a+IhYttx4qOEkho4Honq4DCNEdL
         lW2g==
X-Forwarded-Encrypted: i=1; AJvYcCX9Wc16CiVCKFqQHps+S1fNr4HfLobFicFHVU+WLDDwlfrZYt7ruSlwlNq4+OP++maormDXAzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPzlN2CkhxW2IT2uVj1gdgCyTciMAMM035xYhhPpZop3rkWfD
	k61Wv4qlaIUQCFBHzyUJXA3KmsjK8WP3zSwykZtBDmKk1XuQXwLj
X-Gm-Gg: ASbGncui8aVI5T2RLVITrHWtTnNYYIEu3af70ev6M+Pqdbtqzn6+wsrVTVmBoaHb6FI
	DKc6fXod164ZddJE0utmsXpvxU7OWilut3Qm1umHCRTUhpLyKK338RKXSGDqZk92lltFpjzkYiB
	oXSdx28UEgxviJL5DXkjwwUmlZ/qjFj0kKykZqtoElgY0cOvjpRLUEUltE/IZgKCUvp41sHuaci
	ygLcbKsP03rMz92VTs6q2dUqyGRMJKsqdHMHeyMadDQgvrRBQZIz+iXbBiepSwekF1RvL+H8pq5
	SHrbwBWAYTrrPfYNDwUmi97eZfISYXjOE74C
X-Google-Smtp-Source: AGHT+IFbn4seXQVE2ZsDuvHhU3Lez0LgriF3RYxeETmtUe/JEds+OCgRdMIRcxtCZd4+oep+VfiXaQ==
X-Received: by 2002:a05:600c:4588:b0:439:48f6:dd6e with SMTP id 5b1f17b1804b1-4396e717cbdmr117392745e9.19.1739880797358;
        Tue, 18 Feb 2025 04:13:17 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439831f209bsm60111905e9.13.2025.02.18.04.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:13:16 -0800 (PST)
Message-ID: <3d27913a-f500-4d23-b459-ccd1bfed8e4c@gmail.com>
Date: Tue, 18 Feb 2025 14:13:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] eth: mlx4: use the page pool for Rx
 buffers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: tariqt@nvidia.com, idosch@idosch.org, hawk@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250213010635.1354034-1-kuba@kernel.org>
 <20250213010635.1354034-5-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250213010635.1354034-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 3:06, Jakub Kicinski wrote:
> Simple conversion to page pool. Preserve the current fragmentation
> logic / page splitting. Each page starts with a single frag reference,
> and then we bump that when attaching to skbs. This can likely be
> optimized further.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - remove unnecessary .max_len setting
> v1: https://lore.kernel.org/20250205031213.358973-5-kuba@kernel.org
> ---
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 -
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 55 +++++++-------------
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 +--
>   3 files changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index 97311c98569f..ad0d91a75184 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> @@ -247,7 +247,6 @@ struct mlx4_en_tx_desc {
>   
>   struct mlx4_en_rx_alloc {
>   	struct page	*page;
> -	dma_addr_t	dma;
>   	u32		page_offset;
>   };
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index d2cfbf2e38d9..b33285d755b9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -52,57 +52,39 @@
>   
>   #include "mlx4_en.h"
>   
> -static int mlx4_alloc_page(struct mlx4_en_priv *priv,
> -			   struct mlx4_en_rx_alloc *frag,
> -			   gfp_t gfp)
> -{
> -	struct page *page;
> -	dma_addr_t dma;
> -
> -	page = alloc_page(gfp);
> -	if (unlikely(!page))
> -		return -ENOMEM;
> -	dma = dma_map_page(priv->ddev, page, 0, PAGE_SIZE, priv->dma_dir);
> -	if (unlikely(dma_mapping_error(priv->ddev, dma))) {
> -		__free_page(page);
> -		return -ENOMEM;
> -	}
> -	frag->page = page;
> -	frag->dma = dma;
> -	frag->page_offset = priv->rx_headroom;
> -	return 0;
> -}
> -
>   static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>   			       struct mlx4_en_rx_ring *ring,
>   			       struct mlx4_en_rx_desc *rx_desc,
>   			       struct mlx4_en_rx_alloc *frags,
>   			       gfp_t gfp)
>   {
> +	dma_addr_t dma;
>   	int i;
>   
>   	for (i = 0; i < priv->num_frags; i++, frags++) {
>   		if (!frags->page) {
> -			if (mlx4_alloc_page(priv, frags, gfp)) {
> +			frags->page = page_pool_alloc_pages(ring->pp, gfp);
> +			if (!frags->page) {
>   				ring->alloc_fail++;
>   				return -ENOMEM;
>   			}
> +			page_pool_fragment_page(frags->page, 1);
> +			frags->page_offset = priv->rx_headroom;
> +
>   			ring->rx_alloc_pages++;
>   		}
> -		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> -						    frags->page_offset);
> +		dma = page_pool_get_dma_addr(frags->page);
> +		rx_desc->data[i].addr = cpu_to_be64(dma + frags->page_offset);
>   	}
>   	return 0;
>   }
>   
>   static void mlx4_en_free_frag(const struct mlx4_en_priv *priv,
> +			      struct mlx4_en_rx_ring *ring,
>   			      struct mlx4_en_rx_alloc *frag)
>   {
> -	if (frag->page) {
> -		dma_unmap_page(priv->ddev, frag->dma,
> -			       PAGE_SIZE, priv->dma_dir);
> -		__free_page(frag->page);
> -	}
> +	if (frag->page)
> +		page_pool_put_full_page(ring->pp, frag->page, false);
>   	/* We need to clear all fields, otherwise a change of priv->log_rx_info
>   	 * could lead to see garbage later in frag->page.
>   	 */
> @@ -167,7 +149,7 @@ static void mlx4_en_free_rx_desc(const struct mlx4_en_priv *priv,
>   	frags = ring->rx_info + (index << priv->log_rx_info);
>   	for (nr = 0; nr < priv->num_frags; nr++) {
>   		en_dbg(DRV, priv, "Freeing fragment:%d\n", nr);
> -		mlx4_en_free_frag(priv, frags + nr);
> +		mlx4_en_free_frag(priv, ring, frags + nr);
>   	}
>   }
>   
> @@ -469,7 +451,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
>   		if (unlikely(!page))
>   			goto fail;
>   
> -		dma = frags->dma;
> +		dma = page_pool_get_dma_addr(page);
>   		dma_sync_single_range_for_cpu(priv->ddev, dma, frags->page_offset,
>   					      frag_size, priv->dma_dir);
>   
> @@ -480,6 +462,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
>   		if (frag_info->frag_stride == PAGE_SIZE / 2) {
>   			frags->page_offset ^= PAGE_SIZE / 2;
>   			release = page_count(page) != 1 ||
> +				  atomic_long_read(&page->pp_ref_count) != 1 ||
>   				  page_is_pfmemalloc(page) ||
>   				  page_to_nid(page) != numa_mem_id();
>   		} else if (!priv->rx_headroom) {
> @@ -493,10 +476,9 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
>   			release = frags->page_offset + frag_info->frag_size > PAGE_SIZE;
>   		}
>   		if (release) {
> -			dma_unmap_page(priv->ddev, dma, PAGE_SIZE, priv->dma_dir);
>   			frags->page = NULL;
>   		} else {
> -			page_ref_inc(page);
> +			page_pool_ref_page(page);
>   		}
>   
>   		nr++;
> @@ -766,7 +748,8 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
>   			/* Get pointer to first fragment since we haven't
>   			 * skb yet and cast it to ethhdr struct
>   			 */
> -			dma = frags[0].dma + frags[0].page_offset;
> +			dma = page_pool_get_dma_addr(frags[0].page);
> +			dma += frags[0].page_offset;
>   			dma_sync_single_for_cpu(priv->ddev, dma, sizeof(*ethh),
>   						DMA_FROM_DEVICE);
>   
> @@ -805,7 +788,8 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
>   			void *orig_data;
>   			u32 act;
>   
> -			dma = frags[0].dma + frags[0].page_offset;
> +			dma = page_pool_get_dma_addr(frags[0].page);
> +			dma += frags[0].page_offset;
>   			dma_sync_single_for_cpu(priv->ddev, dma,
>   						priv->frag_info[0].frag_size,
>   						DMA_FROM_DEVICE);
> @@ -868,6 +852,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
>   		skb = napi_get_frags(&cq->napi);
>   		if (unlikely(!skb))
>   			goto next;
> +		skb_mark_for_recycle(skb);
>   
>   		if (unlikely(ring->hwtstamp_rx_filter == HWTSTAMP_FILTER_ALL)) {
>   			u64 timestamp = mlx4_en_get_cqe_ts(cqe);
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> index fe1378a689a1..87f35bcbeff8 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> @@ -44,6 +44,7 @@
>   #include <linux/ipv6.h>
>   #include <linux/indirect_call_wrapper.h>
>   #include <net/ipv6.h>
> +#include <net/page_pool/helpers.h>
>   
>   #include "mlx4_en.h"
>   
> @@ -350,9 +351,10 @@ u32 mlx4_en_recycle_tx_desc(struct mlx4_en_priv *priv,
>   			    int napi_mode)
>   {
>   	struct mlx4_en_tx_info *tx_info = &ring->tx_info[index];
> +	struct page_pool *pool = ring->recycle_ring->pp;
>   
> -	dma_unmap_page(priv->ddev, tx_info->map0_dma, PAGE_SIZE, priv->dma_dir);
> -	put_page(tx_info->page);
> +	/* Note that napi_mode = 0 means ndo_close() path, not budget = 0 */
> +	page_pool_put_full_page(pool, tx_info->page, !!napi_mode);
>   
>   	return tx_info->nr_txbb;
>   }
> @@ -1189,7 +1191,7 @@ netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
>   	tx_desc = ring->buf + (index << LOG_TXBB_SIZE);
>   	data = &tx_desc->data;
>   
> -	dma = frame->dma;
> +	dma = page_pool_get_dma_addr(frame->page);
>   
>   	tx_info->page = frame->page;
>   	frame->page = NULL;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


