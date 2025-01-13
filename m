Return-Path: <netdev+bounces-157631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EACA0B125
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D3E165575
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927F187554;
	Mon, 13 Jan 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyZRxDP3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0D8F49
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757061; cv=none; b=VIKmaxQ5D0d4ORI9NPxPdvKeMm/wpyeDJSe5LB1jHbm6ojfyFJZUToCeRfuuVX7eE68FjhVu7Z4o1bT+c3AEDCjCwQsjzQNk7wQPhBta5UJCrNY2FPrs2Vrgf1yyeoKHZCj10k08MpW1PEKd5KErL/yZri1/+5LuPHn5kqhzfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757061; c=relaxed/simple;
	bh=qkT2/rZII9AL7SYupD7dH6ZuGO/zPcxwlTsKm6qHb3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjNd2lFqmKoeFuf/mOeRq7tGzieD5TeSHIIXeDw1mjKvLCFgLQRhx7bcwkKAvv1vTfCJghkXqNc/TnwFIzJFidMLPL4N7to8GQAvyBpes8VTIsdut/7vxaBWD7Ct6CPTHFfy/2yQ1Cx1IPBdXRAw2RH0YY4jVQItlOuewYqhjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyZRxDP3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736757061; x=1768293061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qkT2/rZII9AL7SYupD7dH6ZuGO/zPcxwlTsKm6qHb3w=;
  b=kyZRxDP3regfEaoYkpBlMpqdUPLozGsj1WBLTOciPTubMoFipW4/rxW4
   p/AlKqF4vFVf8NykM9Ko1uE7vcuHc3YG9/SoQl8/ZIWA+Y/GOQ5xZxzTC
   I+ZtFlmrRSXLkrW13JdcgJcp9o0X9XnSR5wdDuukwWfZJ2rcg6dINmCUf
   CJ4BBmKpOKeAp3GMVoIJpsb6rAPjDEgSfxnKfSa5tZL4G+Xx4iIwFtqQz
   R+HMURhFBDMiqR5XcoP6w0KEnnjA/rpP1ZoWlmdL83/LUtem2bLL/MZsG
   z6JVm6sYwTVRi+PKgcnmflC8JX3tN0TQ4Eg4yhYsrFO2UDHf5E6qfeLai
   w==;
X-CSE-ConnectionGUID: nqDvbJKkRne2P05wo6zV7g==
X-CSE-MsgGUID: kAWJbnXxR1+C5ycSTpLKFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40679836"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40679836"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:31:00 -0800
X-CSE-ConnectionGUID: Vl8PrIXLQoSPzAi3OYhvrA==
X-CSE-MsgGUID: InRebTJZSpOMt2ytOas8HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109525990"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:30:49 -0800
Date: Mon, 13 Jan 2025 09:27:31 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 06/10] bnxt_en: Refactor RX/RX AGG ring
 parameters setup for P5_PLUS
Message-ID: <Z4TOc/M4eUqQPLR2@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-7-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:23PM -0800, Michael Chan wrote:
> There is some common code for setting up RX and RX AGG ring allocation
> parameters for P5_PLUS chips.  Refactor the logic into a new function.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 58 +++++++++++------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 4336a5b54289..c862250d3b77 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -6917,6 +6917,28 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
>  	hwrm_req_drop(bp, req);
>  }
>  
> +static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
> +				       struct hwrm_ring_alloc_input *req,
> +				       struct bnxt_ring_struct *ring)
> +{
> +	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
> +	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
> +
> +	if (ring_type == HWRM_RING_ALLOC_AGG) {
> +		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
> +		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
> +		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
> +		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
> +	} else {
> +		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
> +		if (NET_IP_ALIGN == 2)
> +			req->flags =
> +				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
> +	}
> +	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
> +	req->enables |= cpu_to_le32(enables);
> +}
> +
>  static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
>  				    struct bnxt_ring_struct *ring,
>  				    u32 ring_type, u32 map_index)
> @@ -6968,37 +6990,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
>  		break;
>  	}
>  	case HWRM_RING_ALLOC_RX:
> -		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
> -		req->length = cpu_to_le32(bp->rx_ring_mask + 1);
> -		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> -			u16 flags = 0;
> -
> -			/* Association of rx ring with stats context */
> -			grp_info = &bp->grp_info[ring->grp_idx];
> -			req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
> -			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
> -			req->enables |= cpu_to_le32(
> -				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
> -			if (NET_IP_ALIGN == 2)
> -				flags = RING_ALLOC_REQ_FLAGS_RX_SOP_PAD;
> -			req->flags = cpu_to_le16(flags);
> -		}
> -		break;
>  	case HWRM_RING_ALLOC_AGG:
> -		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> -			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
> -			/* Association of agg ring with rx ring */
> -			grp_info = &bp->grp_info[ring->grp_idx];
> -			req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
> -			req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
> -			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
> -			req->enables |= cpu_to_le32(
> -				RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
> -				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
> -		} else {
> -			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
> -		}
> -		req->length = cpu_to_le32(bp->rx_agg_ring_mask + 1);
> +		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
> +		req->length = (ring_type == HWRM_RING_ALLOC_RX) ?
> +			      cpu_to_le32(bp->rx_ring_mask + 1) :
> +			      cpu_to_le32(bp->rx_agg_ring_mask + 1);
> +		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
> +			bnxt_set_rx_ring_params_p5(bp, ring_type, req, ring);
>  		break;
>  	case HWRM_RING_ALLOC_CMPL:
>  		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
> -- 
> 2.30.1

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


