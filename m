Return-Path: <netdev+bounces-60101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235481D568
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446C1C20CD1
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29111C8A;
	Sat, 23 Dec 2023 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAeXLlZE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6E11718
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 17:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA04C433C8;
	Sat, 23 Dec 2023 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703353731;
	bh=03Mw3pTrVcalUFwXHgizomiqyu9j2TDfmFEEnJjsgSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAeXLlZEsG7ROdqI2PXNz8MBASajy2ZNVJ88sgC51YVXI0A1RuK4prwwUGUBCcKNA
	 ZWvhbhh2RtVAO/X3fa7jKu197+ZctY+cgk0J5Y0Jxg5dFLQLGie1/NZOAq5Of0FwOY
	 yUNUC0g0xz5Q3vO2cnMtKqXuhakspKlilGAFsPJa/RrpPkTCFZ9inDvUn1rsRNpgVB
	 Dn9AC8x0JNbd7us27h5eIwDxpkXWX/+oSjqEOe2sWkxtwJfmOZJldEiqw9kbFwWXDB
	 0CQQavMbPWhcvnsbnq8AecfdCU9kQfpzD5CF/kHglUhUPQdgFSKP5iqzjbHTVSwboB
	 /1P4KefGIGucg==
Date: Sat, 23 Dec 2023 17:48:45 +0000
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 16/20] net/mlx5e: NVMEoTCP, queue init/teardown
Message-ID: <20231223174845.GJ201037@kernel.org>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-17-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221213358.105704-17-aaptel@nvidia.com>
mlx5e_open_cqFrom: Simon Horman <horms@kernel.org>

On Thu, Dec 21, 2023 at 09:33:54PM +0000, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> Adds the ddp ops of sk_add, sk_del and offload limits.
> 
> When nvme-tcp establishes new queue/connection, the sk_add op is called.
> We allocate a hardware context to offload operations for this queue:
> - use a steering rule based on the connection 5-tuple to mark packets
>   of this queue/connection with a flow-tag in their completion (cqe)
> - use a dedicated TIR to identify the queue and maintain the HW context
> - use a dedicated ICOSQ to maintain the HW context by UMR postings
> - use a dedicated tag buffer for buffer registration
> - maintain static and progress HW contexts by posting the proper WQEs.
> 
> When nvme-tcp teardowns a queue/connection, the sk_del op is called.
> We teardown the queue and free the corresponding contexts.
> 
> The offload limits we advertise deal with the max SG supported.
> 
> [Re-enabled calling open/close icosq out of en_main.c]
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

...

> +static int
> +mlx5e_nvmeotcp_build_icosq(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_priv *priv, int io_cpu)
> +{
> +	u16 max_sgl, max_klm_per_wqe, max_umr_per_ccid, sgl_rest, wqebbs_rest;
> +	struct mlx5e_channel *c = priv->channels.c[queue->channel_ix];
> +	struct mlx5e_sq_param icosq_param = {};
> +	struct mlx5e_create_cq_param ccp = {};
> +	struct dim_cq_moder icocq_moder = {};
> +	struct mlx5e_icosq *icosq;
> +	int err = -ENOMEM;
> +	u16 log_icosq_sz;
> +	u32 max_wqebbs;
> +
> +	icosq = &queue->sq;
> +	max_sgl = mlx5e_get_max_sgl(priv->mdev);
> +	max_klm_per_wqe = queue->max_klms_per_wqe;
> +	max_umr_per_ccid = max_sgl / max_klm_per_wqe;
> +	sgl_rest = max_sgl % max_klm_per_wqe;
> +	wqebbs_rest = sgl_rest ? MLX5E_KLM_UMR_WQEBBS(sgl_rest) : 0;
> +	max_wqebbs = (MLX5E_KLM_UMR_WQEBBS(max_klm_per_wqe) *
> +		     max_umr_per_ccid + wqebbs_rest) * queue->size;
> +	log_icosq_sz = order_base_2(max_wqebbs);
> +
> +	mlx5e_build_icosq_param(priv->mdev, log_icosq_sz, &icosq_param);
> +	ccp.napi = &queue->qh.napi;
> +	ccp.ch_stats = &priv->channel_stats[queue->channel_ix]->ch;
> +	ccp.node = cpu_to_node(io_cpu);
> +	ccp.ix = queue->channel_ix;
> +
> +	err = mlx5e_open_cq(priv, icocq_moder, &icosq_param.cqp, &ccp, &icosq->cq);

Hi Aurelien and Ben,

This doesn't seem to compile with gcc-13 with allmodconfig on x86_64:

 .../nvmeotcp.c: In function 'mlx5e_nvmeotcp_build_icosq':
 .../nvmeotcp.c:472:29: error: passing argument 1 of 'mlx5e_open_cq' from incompatible pointer type [-Werror=incompatible-pointer-types]
   472 |         err = mlx5e_open_cq(priv, icocq_moder, &icosq_param.cqp, &ccp, &icosq->cq);
       |                             ^~~~
       |                             |
       |                             struct mlx5e_priv *
 In file included from .../nvmeotcp.h:9,
                  from .../nvmeotcp.c:7:
 ....h:1065:41: note: expected 'struct mlx5_core_dev *' but argument is of type 'struct mlx5e_priv *'
  1065 | int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
       |                   ~~~~~~~~~~~~~~~~~~~~~~^~~~
 cc1: all warnings being treated as errors

> +	if (err)
> +		goto err_nvmeotcp_sq;
> +	err = mlx5e_open_icosq(c, &priv->channels.params, &icosq_param, icosq,
> +			       mlx5e_nvmeotcp_icosq_err_cqe_work);
> +	if (err)
> +		goto close_cq;
> +
> +	spin_lock_init(&queue->sq_lock);
> +	return 0;
> +
> +close_cq:
> +	mlx5e_close_cq(&icosq->cq);
> +err_nvmeotcp_sq:
> +	return err;
> +}

...

