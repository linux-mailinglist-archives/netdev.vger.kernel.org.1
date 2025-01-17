Return-Path: <netdev+bounces-159174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55AA149EA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF2E1882C0E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453391F78E1;
	Fri, 17 Jan 2025 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7CjI/wC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671A1F76D5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097176; cv=none; b=vFmEN4VnnG3AyrFbitlryhk/vQrcpQ1EBcJLIhbqIY0Hm7UICcvSG0OvB7enfWGYwWxMK5cE0DMrhwAwjWf2qpqDCo6Jt38HAHHmDJhSsqZr3FtKl0nkPWC/4LgjjhiDYcfQOHvvk7QFg6SJpVeJ1WCH+R96qimFXAWTDSanUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097176; c=relaxed/simple;
	bh=Kh99yRrt1KfTzAQKc+MnZyA5aF3QuHL2w0fcK3MSk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1ZGiSO1q4La9orJh8CrlqKeEhCpUv1Yi/J88NkMWJkwbmV97yrfsL36q3SrEhDmiZ0U3HlnYB2cdtfZhCZJyD1jit7GYUO+RFIbHVaQfYxUidd0MfMnXgPajHFpNnQWcLLKR9R1VyBtKQ3H7OYZtRdpTp+NnyrcpZRBI3+ivVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7CjI/wC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737097175; x=1768633175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kh99yRrt1KfTzAQKc+MnZyA5aF3QuHL2w0fcK3MSk4Y=;
  b=N7CjI/wC4KLbfSu4oRYd9ZRch7PoOBHYa5zu1GC+AdJ9gxUVh0pb+6Do
   XVdwH58ZIyvcMOW/jq7WskpYI381ds/nHsgq/ulQan0VzqJBTVQ0xkqKY
   1Zrz1K1wyJl7+Zgj/X/Hu1LiKZ02KS/Bnv3sNb6Acx5HpDpwUHbT3RP9M
   +mOL5LWSpMFk/TNC8WM0SmcHSHJxDy9OPfTz40K1XIw/CRL6z1NuGUEp1
   L/EQzrTnb0NpxD2FWvFjzDDjzSyM0M5AbbeEnBToYivfpFd7UPMz+qFPW
   HohpkB+08Yp+NcUmS0HpgRVnlb1Fb5Tcc8DiU2FWmt9z2KUaNIHcgjCem
   Q==;
X-CSE-ConnectionGUID: 1LbgCj5ES+yui4hESYu2+w==
X-CSE-MsgGUID: jUb5mh/tT7aEerS/oYjIig==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37636225"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37636225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:59:34 -0800
X-CSE-ConnectionGUID: g9DfxZMFQS2sk/93mHwnrQ==
X-CSE-MsgGUID: g9rKf+WwT0y72UVx6asUQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="110720814"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:59:31 -0800
Date: Fri, 17 Jan 2025 07:56:10 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	helgaas@kernel.org, Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <Z4n/CkPn1v+eydD2@mev-dev.igk.intel.com>
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
> index 53279904cdb5..0a10a4cffcc8 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7346,6 +7346,22 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
>  	return 0;
>  }
>

[...]

>  static void bnxt_free_irq(struct bnxt *bp)
>  {
>  	struct bnxt_irq *irq;
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
It looked good to have partial freeing here, but as reset can do the
same it is fine to drop it.

Thanks for fixing the error path.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> +err_reset_rx:
> +	rxr->bnapi->in_reset = true;
> +err_reset:
> +	napi_enable(&bnapi->napi);
> +	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +	bnxt_reset_task(bp, true);
>  	return rc;
>  }
>  
> @@ -15679,7 +15775,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  {
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_rx_ring_info *rxr;
> +	struct bnxt_cp_ring_info *cpr;
>  	struct bnxt_vnic_info *vnic;
> +	struct bnxt_napi *bnapi;
>  	int i;
>  
>  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> @@ -15691,15 +15789,23 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	/* Make sure NAPI sees that the VNIC is disabled */
>  	synchronize_net();
>  	rxr = &bp->rx_ring[idx];
> -	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> +	bnapi = rxr->bnapi;
> +	cpr = &bnapi->cp_ring;
> +	cancel_work_sync(&cpr->dim.work);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	page_pool_disable_direct_recycling(rxr->page_pool);
>  	if (bnxt_separate_head_pool())
>  		page_pool_disable_direct_recycling(rxr->head_pool);
>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> +		bnxt_tx_queue_stop(bp, idx);
> +
> +	napi_disable(&bnapi->napi);
> +
>  	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
>  	bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> +	bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
>  
>  	memcpy(qmem, rxr, sizeof(*rxr));
>  	bnxt_init_rx_ring_struct(bp, qmem);
> -- 
> 2.30.1
> 

