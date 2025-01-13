Return-Path: <netdev+bounces-157620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E9A0B074
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D8A7A32CD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D4231A43;
	Mon, 13 Jan 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJbVN6yI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E15F41F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755351; cv=none; b=DtCbaNqp048j4SP7xP/wB9E8OWQgnW86UiVCvgtOsZ3/rF1y3Futv3oOIZx1RiJK8Vn4M6WH5iJ8rtipsmzN9iusDSpsE/nqm9kHV7MVfebU02ATqECGeL2eAlBCRAa5XT9PwacssoWyTvlBw9Nbp5ThuUwUIzvLFjOQQEUJTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755351; c=relaxed/simple;
	bh=YnQepySkEhSPTL3ab6PkdM7xkpBa3j6PwVW2DdcQYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckkvbrnX8S7Ba0EXouVT68D6itvNfkkGbME0xTo0QihxJEWodN1YeU+tK1ZBK8LL5cflwr0bqoQnuCUn+3R8I/FbjUH5s9IVWznbN5BGndhXTETncqrQOyPC2LrWuS1izFYzL1GgBvdpx6NgmRcwH6sEWC9YuwnTp5kAtpCTu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJbVN6yI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755350; x=1768291350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YnQepySkEhSPTL3ab6PkdM7xkpBa3j6PwVW2DdcQYtI=;
  b=OJbVN6yIntKSozpzUbyPVBAjf/pMaDW8rXSWtBZOYEcoTEmOJzI5iTFC
   +WWYtK11DyOSzg6sRxt9PsDHsqQVBofDjMr6VKhTqej3NjDS211x3lwXk
   jIz+I+XpLs9mSkaex67oDeFpY1ZvHDmagjnnvW2DEN5qRUpPTzzY28rZu
   faN6o8bj9ZRPGOVnJSSqPXdj7BRYf0+5seDBtaClWjxN4igOOvOxq5wQH
   4Da56EYRHdfO528QEwluA+0I+V1tE7RQL+cmgsXgqtW1GEGXU+O8I6dUG
   vk1pyd6ZqOrQfv2imsu1lvGjj1cR19PuRkvbGcQl/6E7PuDzrLs4g9ViY
   A==;
X-CSE-ConnectionGUID: eSxJpdGVRmOOatfIYGnQMg==
X-CSE-MsgGUID: QbUj4wiQTRa+uEX2p6Xl1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="48418297"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48418297"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:02:29 -0800
X-CSE-ConnectionGUID: BB7W8DURTOONcEnUbmeZ3g==
X-CSE-MsgGUID: J6fh3hlDRYyvJDqKCMNUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104208046"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:02:26 -0800
Date: Mon, 13 Jan 2025 08:59:08 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 02/10] bnxt_en Refactor completion ring
 allocation logic for P5_PLUS chips
Message-ID: <Z4THzLTGKCgp/SUQ@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-3-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:19PM -0800, Michael Chan wrote:
> Add a new bnxt_hwrm_cp_ring_alloc_p5() function to handle allocating
> one completion ring on P5_PLUS chips.  This simplifies the existing code
> and will be useful later in the series.
> 
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 +++++++++++------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8527788bed91..d364a707664b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7172,6 +7172,25 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
>  	return 0;
>  }
>  
> +static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
> +				      struct bnxt_cp_ring_info *cpr)
> +{
> +	struct bnxt_napi *bnapi = cpr->bnapi;
> +	u32 type = HWRM_RING_ALLOC_CMPL;
Nit, can be const

> +	struct bnxt_ring_struct *ring;
> +	u32 map_idx = bnapi->index;
> +	int rc;
> +
> +	ring = &cpr->cp_ring_struct;
> +	ring->handle = BNXT_SET_NQ_HDL(cpr);
> +	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
> +	if (rc)
> +		return rc;
> +	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
> +	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +	return 0;
> +}
> +
>  static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
>  {
>  	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
> @@ -7215,19 +7234,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
>  		u32 map_idx;
>  
>  		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> -			struct bnxt_cp_ring_info *cpr2 = txr->tx_cpr;
> -			struct bnxt_napi *bnapi = txr->bnapi;
> -			u32 type2 = HWRM_RING_ALLOC_CMPL;
> -
> -			ring = &cpr2->cp_ring_struct;
> -			ring->handle = BNXT_SET_NQ_HDL(cpr2);
> -			map_idx = bnapi->index;
> -			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
> +			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
>  			if (rc)
>  				goto err_out;
> -			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
> -				    ring->fw_ring_id);
> -			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
>  		}
>  		ring = &txr->tx_ring_struct;
>  		map_idx = i;
> @@ -7247,20 +7256,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
>  		if (!agg_rings)
>  			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
>  		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> -			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
> -			struct bnxt_napi *bnapi = rxr->bnapi;
> -			u32 type2 = HWRM_RING_ALLOC_CMPL;
> -			struct bnxt_ring_struct *ring;
> -			u32 map_idx = bnapi->index;
> -
> -			ring = &cpr2->cp_ring_struct;
> -			ring->handle = BNXT_SET_NQ_HDL(cpr2);
> -			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
> +			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
>  			if (rc)
>  				goto err_out;
> -			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
> -				    ring->fw_ring_id);
> -			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
>  		}
>  	}
>  
> -- 
> 2.30.1

Nice simplification
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


