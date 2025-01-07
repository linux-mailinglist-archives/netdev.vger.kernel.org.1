Return-Path: <netdev+bounces-155878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE09BA042A2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3941881921
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201F78F4B;
	Tue,  7 Jan 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+MljCBW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61D4C85;
	Tue,  7 Jan 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260455; cv=none; b=k4Ep51KZoOSccOm6NuE/J9cHVgYimRHMApDRdYXs4yrkFoCDV/oneZv1YoylgWZw2k/9Nf/jzqozD89EpjLMxQ1e5nJf9LSnnLo7OMSHfUoMZEKEWSuzIRg34Nm8FuyKJ/Cp9bGidY+xjFFv7LthGt161TCcpH0ztw6amDPdz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260455; c=relaxed/simple;
	bh=cu3rdNRnTqYe3r19qfPQdpRJWXYnw99zrMefEAGKXmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBE0jtA4Yo0XytDftKd6izPZK/KvwxdIODcvKqDzVXelsla0R+lXewGVSSGKT2rm5JgVyG9FurpY15NT5+xPT59Ee68c/kvbjKBhXZGTbElwxIvVVd3EFLhdmGb1Sc/GvqDTkRqFGH6qFNPG+bamsvbO4ir/GBqktTJNr4Kw+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+MljCBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AF6C4CED6;
	Tue,  7 Jan 2025 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736260454;
	bh=cu3rdNRnTqYe3r19qfPQdpRJWXYnw99zrMefEAGKXmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+MljCBWfYm6hOecL2F0DCbKZzfuHgmevO0ky/XNGFRfxuEbC2uQk9D0/G0LbqBGz
	 l1FNXWECQcXh29eC4mr3pcFrmnmx+Q1MeZTRkMMvsnssNFyF3JEligSTr7odlnEkVX
	 rLLAgEgj2tO1/re2teSUmQ330qebj4bQul1KnN2x3t7XPRY/Y3wibA1Qv1fm6HUbsT
	 zaY51mG+iei0Q6+CMH3o60obtIKCpDkZTizxlmKTJuCR9irPNw4BesX8kgFrS8Tfqz
	 RH60Yhulke6nMEtIo1XDA1zvd89uDiUpqNNsxrjV9vsdr1iglFydAts8FP7sZZDv35
	 bi/BF/eZhRUlg==
Date: Tue, 7 Jan 2025 14:34:10 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com
Subject: Re: [net-next PATCH 2/6] octeontx2-pf: AF_XDP zero copy receive
 support
Message-ID: <20250107143410.GA5872@kernel.org>
References: <20250107104628.2035267-1-sumang@marvell.com>
 <20250107104628.2035267-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107104628.2035267-3-sumang@marvell.com>

On Tue, Jan 07, 2025 at 04:16:24PM +0530, Suman Ghosh wrote:
> This patch adds support to AF_XDP zero copy support for CN10K.
> This patch specifically adds receive side support. In this approach once
> a xdp program with zero copy support on a specific rx queue is enabled,
> then that receive queue is disabled/detached from the existing kernel
> queue and re-assigned to the umem memory.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

I'd like to bring to your attention a number of minor issues
flagged by Smatch.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

...

> @@ -1298,6 +1311,7 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  	int pool_id, pool_start = 0, pool_end = 0, size = 0;
>  	struct otx2_pool *pool;
>  	u64 iova;
> +	int idx;
>  
>  	if (type == AURA_NIX_SQ) {
>  		pool_start = otx2_get_pool_idx(pfvf, type, 0);
> @@ -1312,8 +1326,8 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  
>  	/* Free SQB and RQB pointers from the aura pool */
>  	for (pool_id = pool_start; pool_id < pool_end; pool_id++) {
> -		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		pool = &pfvf->qset.pool[pool_id];
> +		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		while (iova) {
>  			if (type == AURA_NIX_RQ)
>  				iova -= OTX2_HEAD_ROOM;
> @@ -1323,6 +1337,13 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  			iova = otx2_aura_allocptr(pfvf, pool_id);
>  		}
>  	}
> +
> +	for (idx = 0 ; idx < pool->xdp_cnt; idx++) {
> +		if (!pool->xdp[idx])
> +			continue;
> +
> +		xsk_buff_free(pool->xdp[idx]);
> +	}

Looking over otx2_pool_init(), I am wondering if the loop above run should
over all (non AURA_NIX_RQ) pools, rather than the last pool covered by the
preceding loop.

This was flagged by Smatch, because it is concerned that pool may be used
unset above, presumably if the preceding loop iterates zero times (I'm
unsure if that can happen in practice).

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

...

> @@ -3204,6 +3199,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/* Enable link notifications */
>  	otx2_cgx_config_linkevents(pf, true);
>  
> +	pf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
> +	if (!pf->af_xdp_zc_qidx)
> +		goto err_pf_sriov_init;
> +

This goto will result in the function returning err.
However, here err is 0. Should it be set to a negative error value instead?

>  #ifdef CONFIG_DCB
>  	err = otx2_dcbnl_set_ops(netdev);
>  	if (err)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

...

> @@ -571,6 +574,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
>  		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
>  			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
>  
> +		pool = &pfvf->qset.pool[cq->cq_idx];

I am also unsure if this can happen in practice, but Smatch is concerned
that cq may be used uninitialised here. It does seem that could
theoretically be the case if, in the for loop towards the top of this
function, cq_poll->cq_ids[i] is always CINT_INVALID_CQ.

>  		if (unlikely(!filled_cnt)) {
>  			struct refill_work *work;
>  			struct delayed_work *dwork;

...

> @@ -1426,13 +1440,24 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  	unsigned char *hard_start;
>  	struct otx2_pool *pool;
>  	int qidx = cq->cq_idx;
> -	struct xdp_buff xdp;
> +	struct xdp_buff xdp, *xsk_buff = NULL;
>  	struct page *page;
>  	u64 iova, pa;
>  	u32 act;
>  	int err;
>  
>  	pool = &pfvf->qset.pool[qidx];
> +
> +	if (pool->xsk_pool) {
> +		xsk_buff = pool->xdp[--cq->rbpool->xdp_top];
> +		if (!xsk_buff)
> +			return false;
> +
> +		xsk_buff->data_end = xsk_buff->data + cqe->sg.seg_size;
> +		act = bpf_prog_run_xdp(prog, xsk_buff);
> +		goto handle_xdp_verdict;

iova is not initialised until a few lines further down,
which does not occur in the case of this condition.

> +	}
> +
>  	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
>  	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
>  	page = virt_to_page(phys_to_virt(pa));
> @@ -1445,6 +1470,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  
>  	act = bpf_prog_run_xdp(prog, &xdp);
>  
> +handle_xdp_verdict:
>  	switch (act) {
>  	case XDP_PASS:
>  		break;

The lines lines of this function, between the hunk above and the one below
looks like this:

	case XDP_TX:
		qidx += pfvf->hw.tx_queues;
		cq->pool_ptrs++;
		return otx2_xdp_sq_append_pkt(pfvf, iova,

The above uses iova, but in the case that we got here
via goto handle_xdp_verdict it is uninitialised.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index e926c6ce96cf..9bb7e5c3e227 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -722,6 +722,10 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_shutdown_tc;
>  
> +	vf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
> +	if (!vf->af_xdp_zc_qidx)
> +		goto err_shutdown_tc;

Along the same lines of my comment on otx2_probe():
should err be set to a negative error value here?

...

-- 
pw-bot: changes-requested

