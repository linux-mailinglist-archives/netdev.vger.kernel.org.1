Return-Path: <netdev+bounces-171787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AABA4EABA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D392170104
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DD292F9B;
	Tue,  4 Mar 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGsrPmrU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6C280A39
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110316; cv=none; b=DRZc/WLmT70qUAi9UBcn+wO2HutvbRpikC+/fI5zK8ThLSEeF3sRVIlj/pspT2i10+c+je9RX/ccgKUUUXbdK0PdWrL2lbG4rVXRBZo09ACD3f8sdr2+WwtyajtgVP0p/B5szaH3k80cPx2AQPECN8ILJLYcmXaw9AMnaTBfeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110316; c=relaxed/simple;
	bh=/XYaCM7ffLPvBmOKEewqpIBZvsk+7sQeQ/ouoLNmb3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp6qrSwvHbhm7CWJDQlggUeQNw+bvMWQwUfHEE5AN2msdn8HgGXPbyE8cdG9ts3Ri0Kli8+QSyzvIJ/fw4qnkxKn9FvHNeEzZpRoRgggZ+qJ6cbobLkCRuzXKzoHyMoj08xQnzuGUIDpr/kBUW2ajRGXhB/Gdi3QnjJSeThu9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGsrPmrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697E0C4CEE5;
	Tue,  4 Mar 2025 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110315;
	bh=/XYaCM7ffLPvBmOKEewqpIBZvsk+7sQeQ/ouoLNmb3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGsrPmrUNKRPdh6/tPUlX0DZdO3u6G1v8Z7IsvxUh0PTFWtmzC1luyNhUg54gtQsz
	 hLBHBzARalamTAD5aPs4A0PHkO4gqajIhWvYUj4l+gRx0LG4mrT5S6rasBKofCfv20
	 uobPfLhnY0b1eoLdz1/CkS62UAKNVzGsLyyJg89Cshk/aiw3YiYO4RdDCAVBu6ofUI
	 YCUrz+qKrzzMkJtTwHG9EUWsd6S+6vqfSPeVPuZ2Y/CEoEwUyQIAip//uRrEFeV6fI
	 Ly70iWwN1Bzdk7YWcT9NzZOC/jJOf8+cbIK5Way9ARjAsmre6xLdELbapWyJC1H/Ch
	 PbxEKKV3bEQ4Q==
Date: Tue, 4 Mar 2025 17:45:10 +0000
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
Message-ID: <20250304174510.GI3666230@kernel.org>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303095304.1534-16-aaptel@nvidia.com>

On Mon, Mar 03, 2025 at 09:52:59AM +0000, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> NVMEoTCP offload uses buffer registration for ddp operation.
> Every request comprises from SG list that might consist from elements
> with multiple combination sizes, thus the appropriate way to perform
> buffer registration is with KLM UMRs.
> 
> UMR stands for user-mode memory registration, it is a mechanism to alter
> address translation properties of MKEY by posting WorkQueueElement
> aka WQE on send queue.
> 
> MKEY stands for memory key, MKEY are used to describe a region in memory
> that can be later used by HW.
> 
> KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
> enables to map multiple memory spaces with different sizes in unified MKEY.
> KLM UMR is a UMR that use to update a KLM_MKEY.
> 
> Nothing needs to be done on memory registration completion and this
> notification is expensive so we add a wrapper to be able to ring the
> doorbell without generating any.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c

...

> @@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
>  	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
>  };
>  
> +static void
> +fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
> +		      u32 klm_entries, u16 klm_offset)
> +{
> +	struct scatterlist *sgl_mkey;
> +	u32 lkey, i;
> +
> +	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
> +	for (i = 0; i < klm_entries; i++) {
> +		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
> +		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
> +		wqe->inline_klms[i].key = cpu_to_be32(lkey);
> +		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
> +	}
> +
> +	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
> +		wqe->inline_klms[i].bcount = 0;
> +		wqe->inline_klms[i].key = 0;
> +		wqe->inline_klms[i].va = 0;
> +	}
> +}
> +
> +static void
> +build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
> +		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
> +		       enum wqe_type klm_type)
> +{
> +	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
> +		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
> +	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
> +		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
> +	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
> +	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
> +	struct mlx5_mkey_seg *mkc = &wqe->mkc;

Hi Aurelien, all,

I think that the lines above...

> +	u32 sqn = queue->sq.sqn;
> +	u16 pc = queue->sq.pc;
> +
> +	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
> +					     MLX5_OPCODE_UMR | (opc_mod) << 24);
> +	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
> +	cseg->general_id = cpu_to_be32(id);
> +
> +	if (klm_type == KLM_UMR && !klm_offset) {
> +		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
> +					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
> +		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
> +	}
> +
> +	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
> +	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	ucseg->xlt_offset = cpu_to_be16(klm_offset);
> +	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
> +}
> +
> +static void
> +mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
> +{
> +	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
> +
> +	memset(wi, 0, sizeof(*wi));
> +
> +	wi->num_wqebbs = wqebbs;
> +	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
> +}
> +
> +static u32
> +post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
> +	     enum wqe_type wqe_type,
> +	     u16 ccid,
> +	     u32 klm_length,
> +	     u32 klm_offset)
> +{
> +	struct mlx5e_icosq *sq = &queue->sq;
> +	u32 wqebbs, cur_klm_entries;
> +	struct mlx5e_umr_wqe *wqe;
> +	u16 pi, wqe_sz;
> +
> +	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
> +	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
> +	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
> +	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
> +	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
> +	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
> +			       klm_length, wqe_type);
> +	sq->pc += wqebbs;
> +	sq->doorbell_cseg = &wqe->ctrl;

... and this one need (at least) to be updated for the following commit
which is now present in net-next:

bf08fd32cc55 ("net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings")

> +	return cur_klm_entries;
> +}
> +

...

