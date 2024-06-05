Return-Path: <netdev+bounces-101035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5008FD01C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F056B1C25651
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487317C8D;
	Wed,  5 Jun 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRo7pCZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59D17BBF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595308; cv=none; b=WJqL8jDx7OAd1Gv7q7zjCnk9XgNtHtqlVhfegcdjhJmFGJWQNMQvbeOg5VgWUvCAYWy6KgMpbrlfUHhfV8cXQO0i/5067Na7nES4i25eg3jCAz7kpJBr4/hoxg94GIrpJU+MyDuLOjjzXgXg9xXt2ejpWmeIxWaPn8NRH379LIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595308; c=relaxed/simple;
	bh=6GONRzVRWfH0YvEROkm1QZg1CpQtS5NTN8e88etON3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll+cZY0iuBorK1Ahc9mA2lQNCM9mIk7rJ7Ju2XKqTmarbNaCY7pCvnJzOr7wJARWhN/LJfv+SHMVKILqWqDprnkhMhkC7FrIKl1Xmp8PkNdmGrwkw3emPo4IzuyHLVIUmkyBCW2iLB+/FC3Jg7QbWQpoF0D3tIsQaa7jESOtKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRo7pCZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0849DC32781;
	Wed,  5 Jun 2024 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595308;
	bh=6GONRzVRWfH0YvEROkm1QZg1CpQtS5NTN8e88etON3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRo7pCZPn//+e3QxjGQdJAhwwgxSLYBI+XrrHjS8QA+evvCmN+SR9UW5RVqjKiuee
	 sCdtQbJI3lUnBUbk8WFC1riIcsBDvQDqN2HzlzaV4Lxj1pHNTSS1JvafHSuI+A6qev
	 5H0qH8rCIGrULL9op0iewoaDJSq7Av31ueTeT7ZlcYEHmEMMjYEBWLlL2Wl9qkw3AJ
	 Gkx7Nvibn6PXv5Cta6Z1DCpQewRxlxlpj03/BNwoeC9kSDkDw55AmmoafvZgjEdsSQ
	 nCNRLwkl1fFg1ROxZNd6ZcJxYPjzAYOy5kvokDv80nJy1MlupyaM8OXw5EuQhspn35
	 HeyHClPMmp7PA==
Date: Wed, 5 Jun 2024 14:48:23 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Yoray Zack <yorayz@nvidia.com>
Subject: Re: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Skipping on duplicate
 flush of the same SHAMPO SKB
Message-ID: <20240605134823.GK791188@kernel.org>
References: <20240528142807.903965-1-tariqt@nvidia.com>
 <20240528142807.903965-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528142807.903965-9-tariqt@nvidia.com>

On Tue, May 28, 2024 at 05:28:00PM +0300, Tariq Toukan wrote:
> From: Yoray Zack <yorayz@nvidia.com>
> 
> SHAMPO SKB can be flushed in mlx5e_shampo_complete_rx_cqe().
> If the SKB was flushed, rq->hw_gro_data->skb was also set to NULL.
> 
> We can skip on flushing the SKB in mlx5e_shampo_flush_skb
> if rq->hw_gro_data->skb == NULL.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1e3a5b2afeae..3f76c33aada0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2334,7 +2334,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
>  	}
>  
>  	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
> -	if (flush)
> +	if (flush && rq->hw_gro_data->skb)
>  		mlx5e_shampo_flush_skb(rq, cqe, match);

nit: It seems awkward to reach inside rq like this
     when mlx5e_shampo_flush_skb already deals with the skb in question.

     Would it make esnse for the NULL skb check to
     be moved inside mlx5e_shampo_flush_skb() ?

>  free_hd_entry:
>  	if (likely(head_size))
> -- 
> 2.31.1
> 
> 

