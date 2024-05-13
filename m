Return-Path: <netdev+bounces-96094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F68C44E5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B203C1C22F2B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D3157486;
	Mon, 13 May 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcTJcET+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC07155355;
	Mon, 13 May 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616892; cv=none; b=hoMapr6gIfdyoMd7ZgSlfD1AUMsw/UTtuDQ4ZcyyQLCvPaRRqkcdht1OjOIGSwbs1KjDuGoQOzNcDwEWeI2ddLx8uZCWDQZh3unKj/M8pUW09rr1kZJO1Hh5oPgfRtfGkfpBSYW7U9EF/cV5b0ivmoRgKsGv651m+DsNsIMYF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616892; c=relaxed/simple;
	bh=oN5lGCQ1uIgrJDquhY3G+4SzD4WEuKha/hOkt+PGxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfQvuA5kaCBTuXNLV2r43lFvkMfOQ4FnnrpAEdJXNpgv8Tv6LMOx7CypN04dORJZsY7KtXE6i492OyxGwRzrbxSLFNhDr/s40vzQwjRh9KuLqu9bRKcYfYelgTSpY3Dkrl15/dptMY/HjnmeyKnWfh3DDYAohyNSbuW69Jms9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcTJcET+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7BDC2BD11;
	Mon, 13 May 2024 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616892;
	bh=oN5lGCQ1uIgrJDquhY3G+4SzD4WEuKha/hOkt+PGxrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcTJcET+RTVv2T+3hTtLAmzquL7SgYHKI34xA7qZKHBAtyizcbqv1OWGM4QOvURfm
	 th0ADvJlsvjp4xd25Wx49s7ItWf+7zjULXFn6IWPJpt6R6vVOsutjlSZT6Vcziv0vl
	 XIS7RsomFWWsk/2PSrY839HQ/gFi5zBmk/2BfSGyAS7qNQn/xMRFYGagXmhMZWbTh2
	 8PX6F+Ejz65LUSmvNGMcnG6qaPh4SQ4ons6HxYUXxDaqbuCb2b1WU9hH1QgHSmCCLo
	 ch1XKgdGoMZXW/pi3tqpOZXvbg+OkrQcGd8EvnFwUDABZLVBEGRtUqFbqLHczYqsPl
	 NqEfc96nBylQA==
Date: Mon, 13 May 2024 17:14:47 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v2 3/8] octeontx2-af: Disable backpressure between CPT
 and NIX
Message-ID: <20240513161447.GR2787@kernel.org>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-4-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513105446.297451-4-bbhushan2@marvell.com>

On Mon, May 13, 2024 at 04:24:41PM +0530, Bharat Bhushan wrote:
> NIX can assert backpressure to CPT on the NIX<=>CPT link.
> Keep the backpressure disabled for now. NIX block anyways
> handles backpressure asserted by MAC due to PFC or flow
> control pkts.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

...

> @@ -592,8 +596,16 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
>  	bp = &nix_hw->bp;
>  	chan_base = pfvf->rx_chan_base + req->chan_base;
>  	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
> -		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
> -		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
> +		/* CPT channel for a given link channel is always
> +		 * assumed to be BIT(11) set in link channel.
> +		 */
> +		if (cpt_link)
> +			chan_v = chan | BIT(11);
> +		else
> +			chan_v = chan;

Hi Bharat,

The chan_v logic above seems to appear twice in this patch.
I'd suggest adding a helper.

> +
> +		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
> +		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
>  			    cfg & ~BIT_ULL(16));
>  
>  		if (type == NIX_INTF_TYPE_LBK) {

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 7ec99c8d610c..e9d2e039a322 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1705,6 +1705,31 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
>  }
>  EXPORT_SYMBOL(otx2_nix_config_bp);
>  
> +int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
> +{
> +	struct nix_bp_cfg_req *req;
> +
> +	if (enable)
> +		req = otx2_mbox_alloc_msg_nix_cpt_bp_enable(&pfvf->mbox);
> +	else
> +		req = otx2_mbox_alloc_msg_nix_cpt_bp_disable(&pfvf->mbox);
> +
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->chan_base = 0;
> +#ifdef CONFIG_DCB
> +	req->chan_cnt = pfvf->pfc_en ? IEEE_8021QAZ_MAX_TCS : 1;
> +	req->bpid_per_chan = pfvf->pfc_en ? 1 : 0;
> +#else
> +	req->chan_cnt =  1;
> +	req->bpid_per_chan = 0;
> +#endif

IMHO, inline #ifdefs reduce readability and reduce maintainability.

Would it be possible to either:

1. Include the pfc_en field in struct otx2_nic and make
   sure it is set to 0 if CONFIG_DCB is unset; or
2. Provide a wrapper that returns 0 if CONFIG_DCB is unset,
   otherwise pfvf->pfc_en.

I suspect 1 will have little downside and be easiest to implement.

> +
> +	return otx2_sync_mbox_msg(&pfvf->mbox);
> +}
> +EXPORT_SYMBOL(otx2_nix_cpt_config_bp);
> +
>  /* Mbox message handlers */
>  void mbox_handler_cgx_stats(struct otx2_nic *pfvf,
>  			    struct cgx_stats_rsp *rsp)

...

