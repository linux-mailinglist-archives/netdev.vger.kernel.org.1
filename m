Return-Path: <netdev+bounces-157623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0FA0B08C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AA71887356
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B3C233127;
	Mon, 13 Jan 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvG+eOg0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811072327A8
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755553; cv=none; b=agCcg2UMMP4CDbS2OoBRlUoSNpGnR5EIcLhY9Kx6eN9wuzeddhZm8qjBXARVSuWFdIJji77W76hBG0S0nX4uIhtNTMD6xO/Z4GFrl7Y5xUMX8LquCti2CW+zxF2BMTxmpi+mLb96B/4MPQzpoiDG7Z8lU17S/auvEuFNLHa68qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755553; c=relaxed/simple;
	bh=aqg36jRtK67Lr2t9WAJ7JSCc+dBPvqV+4LJ9BWPAL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knfvSWfSPtYS55SYXWRAquNJX98pdAiMXvMURTS6o3mI7GxELMqqv38+qjaRWNjRjgERRD6sV2/xydPlmGYQ6XNuVifqt1XPMXKquP62Xo/9by5optvqT0yANe0CbqIu1W7vZqi2cUuBcqqEPQPEpzMkqQdicaekLTU0r55FoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvG+eOg0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755551; x=1768291551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqg36jRtK67Lr2t9WAJ7JSCc+dBPvqV+4LJ9BWPAL/I=;
  b=dvG+eOg0cAKV9/NX1i1KF4y7vx+CgOuzZgkG5Vl6usNC6fAtxHcj+guj
   DnAhN17wbIrLXeozD69Eyv6deMXamuVYB225lfyYmYJs0ALmqMM9RBQNj
   1wtXhS7i39GV+thKdvWs7HH1TwPa6AUWA7e1dSMuSnJBb0OMf7zO+zrnj
   +u6ZgON5MS5Wu0caN6K5iHp1R0UjxiBj/rO1BEHSCNtVj1iORJx81ikd9
   ds/h3+P9hM5kJLhyS90a0ML2MKy0Bw1EQXV29SQvkUrvPZf+yh0uxlDbz
   nSjoZ83RN5pk35vd1MzbyB9Ga3e4BD+gDKnCiAHOVj97LYmBY0rAb49Bl
   A==;
X-CSE-ConnectionGUID: Wy8dYYabSNOGjiwH+0z2UQ==
X-CSE-MsgGUID: Rij8tp3BScKU8P3q9aFHBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="48000894"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48000894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:05:51 -0800
X-CSE-ConnectionGUID: 04bbFbo3SPmtq8wwU2MISQ==
X-CSE-MsgGUID: W3gQ/7JdRyGRoSTVq4i4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109430846"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:05:48 -0800
Date: Mon, 13 Jan 2025 09:02:29 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 03/10] bnxt_en: Refactor TX ring allocation logic
Message-ID: <Z4TIcj8ICN5WkNXf@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-4-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:20PM -0800, Michael Chan wrote:
> Add a new bnxt_hwrm_tx_ring_alloc() function to handle allocating
> a transmit ring.  This will be useful later in the series.
> 
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d364a707664b..e9a2e30c1537 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7191,6 +7191,20 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
>  	return 0;
>  }
>  
> +static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
> +				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
> +{
> +	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
> +	u32 type = HWRM_RING_ALLOC_TX;
Nit as previous, can be const

> +	int rc;
> +
> +	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
> +	if (rc)
> +		return rc;
> +	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
> +	return 0;
> +}
> +
>  static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
>  {
>  	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
> @@ -7227,23 +7241,17 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
>  		}
>  	}
>  
> -	type = HWRM_RING_ALLOC_TX;
>  	for (i = 0; i < bp->tx_nr_rings; i++) {
>  		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
> -		struct bnxt_ring_struct *ring;
> -		u32 map_idx;
>  
>  		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
>  			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
>  			if (rc)
>  				goto err_out;
>  		}
> -		ring = &txr->tx_ring_struct;
> -		map_idx = i;
> -		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
> +		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, i);
>  		if (rc)
>  			goto err_out;
> -		bnxt_set_db(bp, &txr->tx_db, type, map_idx, ring->fw_ring_id);
>  	}
>  
>  	for (i = 0; i < bp->rx_nr_rings; i++) {
> -- 
> 2.30.1

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


