Return-Path: <netdev+bounces-159344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB8A152E0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ABF1884A65
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41C1802DD;
	Fri, 17 Jan 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEmz9aY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5714884C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127770; cv=none; b=rf0SB0q1VsUG1RIFFodOmLXKMz1GPOuV0axYedd0iiqEEsjCXRgfuCbqECQQ50zbr/FAGbVM+kGAONuT830yxsoXrZ84SFgN9taWiLRKHfcxFmc/Z6hfB+FfmChMHvrfoRNTN5UixEwhNHhtkdvTaZEqgbNnaBoY0wOvP5cGP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127770; c=relaxed/simple;
	bh=70ErwYI2oWoAkX+2AzJkkPjgr9K8gu7leSSw5rUhFEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqYmZDdBqKx4o1n2zq1zg59NyCaoEepW0ahMZDTK+DSxumMcEDoBdXsNepxktwExGFLWqZ777SGRvWT0X2gDtOOj+j8WPYokt+QlUbTt/9l1Eoe+ByC+OmnRob0C+FWbmSMyE1NPqYq8Sx92kaS3yd6IbytTpeepws90UhUl+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEmz9aY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD7EC4CEDD;
	Fri, 17 Jan 2025 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737127770;
	bh=70ErwYI2oWoAkX+2AzJkkPjgr9K8gu7leSSw5rUhFEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEmz9aY1+4XNr5hWInO5JvWrzwaZ4eRs/ofkCIpGT8RJgEEW8ie0YuZdzo3zihRws
	 EkpD3sX9b6zgRtLwnkDJvL14dxAT2U8G1+CJ7SZ3cKnaKCICdUANZufhNYmCcxGAKC
	 ARE71rSq7mBM2hzFzSW52RI4+CEGwLleKx4mh2t7jBexbbk/bgsHF1RdbNd1Cmn+me
	 On6z+bYzwyxTof3fj5R/lSLr0EOidfdBU2UbaQkfOkr48ZGXFWfB/3Yxm+rUQsfuh4
	 J3tk09rVX6Flmvy3IkHYTbESkeTeo/GO8wnZLwI3mytI8fUGp+snjvsXILWtI8SVaW
	 GNfS4xwXekiHA==
Date: Fri, 17 Jan 2025 15:29:25 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com, helgaas@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <20250117152925.GP6206@kernel.org>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
 <20250116192343.34535-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116192343.34535-10-michael.chan@broadcom.com>

On Thu, Jan 16, 2025 at 11:23:42AM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> In order to use queue_stop/queue_start to support the new Steering
> Tags, we need to free the TX ring and TX completion ring if it is a
> combined channel with TX/RX sharing the same NAPI.  Otherwise
> TX completions will not have the updated Steering Tag.  With that
> we can now add napi_disable() and napi_enable() during queue_stop()/
> queue_start().  This will guarantee that NAPI will stop processing
> the completion entries in case there are additional pending entries
> in the completion rings after queue_stop().
> 
> There could be some NQEs sitting unprocessed while NAPI is disabled
> thereby leaving the NQ unarmed.  Explicitly re-arm the NQ after
> napi_enable() in queue start so that NAPI will resume properly.
> 
> Error handling in bnxt_queue_start() requires a reset.  If a TX
> ring cannot be allocated or initialized properly, it will cause
> TX timeout.  The reset will also free any partially allocated
> rings.
> 
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: David Wei <dw@davidwei.uk>
> 
> v2:
> Add reset for error handling in queue_start().
> Fix compile error.
> 
> Discussion about adding napi_disable()/napi_enable():
> 
> https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 124 ++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> @@ -15616,6 +15694,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt_rx_ring_info *rxr, *clone;
>  	struct bnxt_cp_ring_info *cpr;
>  	struct bnxt_vnic_info *vnic;
> +	struct bnxt_napi *bnapi;
>  	int i, rc;
>  
>  	rxr = &bp->rx_ring[idx];
> @@ -15633,25 +15712,40 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  
>  	bnxt_copy_rx_ring(bp, rxr, clone);
>  
> +	bnapi = rxr->bnapi;
>  	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
>  	if (rc)
> -		return rc;
> +		goto err_reset_rx;
>  
>  	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
>  	if (rc)
> -		goto err_free_hwrm_rx_ring;
> +		goto err_reset_rx;
>  
>  	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
>  	if (rc)
> -		goto err_free_hwrm_cp_ring;
> +		goto err_reset_rx;
>  
>  	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
>  
> -	cpr = &rxr->bnapi->cp_ring;
> +	cpr = &bnapi->cp_ring;
>  	cpr->sw_stats->rx.rx_resets++;

Hi Somnath and Michael,

cpr is initialised here. However, it appears that the above
"goto err_reset_rx" directives will result in cpr being dereferenced.

Flagged by W=1 builds with clang-19, and Smatch.

>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> +		cpr->sw_stats->tx.tx_resets++;
> +		rc = bnxt_tx_queue_start(bp, idx);
> +		if (rc) {
> +			netdev_warn(bp->dev,
> +				    "tx queue restart failed: rc=%d\n", rc);
> +			bnapi->tx_fault = 1;
> +			goto err_reset;
> +		}
> +	}
> +
> +	napi_enable(&bnapi->napi);
> +	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +
>  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
>  		vnic = &bp->vnic_info[i];
>  
> @@ -15668,10 +15762,12 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  
>  	return 0;
>  
> -err_free_hwrm_cp_ring:
> -	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
> -err_free_hwrm_rx_ring:
> -	bnxt_hwrm_rx_ring_free(bp, rxr, false);
> +err_reset_rx:
> +	rxr->bnapi->in_reset = true;
> +err_reset:
> +	napi_enable(&bnapi->napi);
> +	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +	bnxt_reset_task(bp, true);
>  	return rc;
>  }

...

