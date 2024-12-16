Return-Path: <netdev+bounces-152399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CAB9F3C74
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F26164D56
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29011D4607;
	Mon, 16 Dec 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a7IixwUm"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AE4437
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383513; cv=none; b=nc276vE9Wz6vJcxmxfy5wvaEhFQu6SBgpjxzQjR9dMOsOWHc6ocgeUjy8WAHnOXz4yOFEsCqW1nqf4nxYGQoLEa92CMia6GE1SjUgVif98lkwCDO7EvcpeqCacoKc+XOVbXQPNyPNgwNeCYJ7txquoNGYm602GkSWijPQzdo0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383513; c=relaxed/simple;
	bh=gveE3AFjnCRtkhZcpghv4Hm1eHhppOYpKxuHyUTNbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sORmlUy0KMGSy0qgmayq2Qo3tZHy2IeE9EHEX7V68EdlgkrMilZ1AqzltIiI8zYMW+N1Oa2BRkOVFLDiSj8WIzTfd4gFkHJjQQSZvLr6N3GxDvl7TJC+IvBeEc06XqrDVFMUJMHeRLtlPN2I8PFVx3CD55eUxajsa7HGvprBJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a7IixwUm; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca8b58c7-d60f-4e55-9fb5-73d9a1359758@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734383508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6YHqabL8H88pX7l5vwe9u2k0OYy6u/HFwM211vfByc=;
	b=a7IixwUmczfjsifpOkrxk0MF+EAZZmzZvzslId8Kb0aufCi6QvTQOe9LtjxwLobxMzn9hg
	ETbz9t8PHTjJLTXczmFc3j7u3eihpV2CsIohIlwaad/Oj4QhBfS1snsnVTq5vIPYIolZJj
	TWw86Hb6blmISYcYph3Rd5/qrsSpFYI=
Date: Mon, 16 Dec 2024 21:11:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][net-next] net/mlx5e: avoid to call net_dim and
 dim_update_sample
To: Li RongQing <lirongqing@baidu.com>, saeedm@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: Shuo Li <lishuo02@baidu.com>
References: <20241212114723.38844-1-lirongqing@baidu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241212114723.38844-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/12/2024 11:47, Li RongQing wrote:
> High cpu usage for net_dim is seen still after commit 61bf0009a765
> ("dim: pass dim_sample to net_dim() by reference"), the calling
> net_dim can be avoid under network low throughput or pingpong mode by
> checking the event counter, even under high throughput, it maybe only
> rx or tx direction
> 
> And don't initialize dim_sample variable, since it will gets
> overwritten by dim_update_sample

dim_update_sample doesn't init dim_sample::comp_ctr, which is later used 
in net_dim()->dim_calc_stats(). This change can bring uninitialized
memory to the whole calculation. Keep it initialized.

> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: Shuo Li <lishuo02@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> index 7610829..7c525e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> @@ -49,11 +49,19 @@ static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
>   static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
>   {
>   	struct mlx5e_sq_stats *stats = sq->stats;
> -	struct dim_sample dim_sample = {};
> +	struct dim_sample dim_sample;
> +	u16 nevents;
>   
>   	if (unlikely(!test_bit(MLX5E_SQ_STATE_DIM, &sq->state)))
>   		return;
>   
> +	if (sq->dim->state == DIM_MEASURE_IN_PROGRESS) {
> +		nevents = BIT_GAP(BITS_PER_TYPE(u16), sq->cq.event_ctr,
> +						  sq->dim->start_sample.event_ctr);
> +		if (nevents < DIM_NEVENTS)
> +			return;
> +	}
> +
>   	dim_update_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
>   	net_dim(sq->dim, &dim_sample);
>   }
> @@ -61,11 +69,19 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
>   static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
>   {
>   	struct mlx5e_rq_stats *stats = rq->stats;
> -	struct dim_sample dim_sample = {};
> +	struct dim_sample dim_sample;
> +	u16 nevents;
>   
>   	if (unlikely(!test_bit(MLX5E_RQ_STATE_DIM, &rq->state)))
>   		return;
>   
> +	if (rq->dim->state == DIM_MEASURE_IN_PROGRESS) {
> +		nevents = BIT_GAP(BITS_PER_TYPE(u16), rq->cq.event_ctr,
> +						  rq->dim->start_sample.event_ctr);
> +		if (nevents < DIM_NEVENTS)
> +			return;
> +	}
> +
>   	dim_update_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
>   	net_dim(rq->dim, &dim_sample);
>   }


