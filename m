Return-Path: <netdev+bounces-157626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E444A0B0AB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA143A0357
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9566231A50;
	Mon, 13 Jan 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq5XMahF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB663C1F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755784; cv=none; b=TE0RNlh8HukB59tSzaP2aU9UCt0mtxeHEmphgmB5qLh6wTPfAS1L+zRfWswFzRz3Fx60knThtd5YLoqXclJ3TNE/i9Ez3k8U4aNysVQXd1KZdm3hPsydNj0JovosKCQrd3I1URqMlB7BIBx1TtjqjpT67Jt8QVjnP+KFmlJpp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755784; c=relaxed/simple;
	bh=feiiVMD0NY3ia9GjmU318WGLIvVwUwSw2bxmJQ52C9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqHaTZTtGkGVj3uPrhShvQz8UUr/wtnd2sa4z2x3GIzGLxtI3BJv3YJx75Ij40CoIUY6KOCbGGM/gS8PlBk0BKWDkcD4DaEPaRiPMdGmBsi0lvmENOq/mrf8zkrTM06lZXrhe08MRZC9DncAu2BfDGjQySkhgiOJZQgurxLt0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq5XMahF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755783; x=1768291783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feiiVMD0NY3ia9GjmU318WGLIvVwUwSw2bxmJQ52C9Y=;
  b=Nq5XMahFfZ24kC/YbZyll+hhFqEIysF+Mb0ji6xiI4YoUfSB8g6E8nw6
   Ne0ECSBUAwbPiglrk/+Arx+lJwwIKgXNw8ReHQa3ialSjI7gAP1425TAM
   V5lay3G2CUg+8klTIL+UTUrzxF9JKr3OnK7ji6rkUeIt0HvyNE3XiOB0H
   qqE3Z79VjOm/TkC1cfZtBasi7PoNAMDv4EEYUA5Xiz60SJlQf38Q4zSy6
   QiC3w332dCEqejwTrpl1kos6lX9GDiZanjrkjheDdt8g98eMNvyD485OF
   4wmxI1OyHO2aUhD/TIM4lwVGmP4MDxW7gmf1cepD8q7YTr2VRyEEerAkH
   A==;
X-CSE-ConnectionGUID: ap7fup04QH6UjYP5fIQGPw==
X-CSE-MsgGUID: GgDwIIECScOBKk2EZmdQXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="47494342"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47494342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:09:43 -0800
X-CSE-ConnectionGUID: XDL/N15pSaOIpDalmv0N7w==
X-CSE-MsgGUID: TGJxXP4zQsWbKG5PDAP+8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104556001"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:09:37 -0800
Date: Mon, 13 Jan 2025 09:06:19 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 04/10] bnxt_en: Refactor completion ring free
 routine
Message-ID: <Z4TJe66l3H8DkizD@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-5-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:21PM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> Add a wrapper routine to free L2 completion rings.  This will be
> useful later in the series.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e9a2e30c1537..4c5cb4dd7420 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7378,6 +7378,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
>  	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
>  }
>  
> +static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
> +				   struct bnxt_cp_ring_info *cpr)
> +{
> +	struct bnxt_ring_struct *ring;
> +
> +	ring = &cpr->cp_ring_struct;
> +	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> +		return;
> +
> +	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
> +				INVALID_HW_RING_ID);
> +	ring->fw_ring_id = INVALID_HW_RING_ID;
> +}
> +
>  static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
>  {
>  	u32 type;
> @@ -7423,17 +7437,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
>  		struct bnxt_ring_struct *ring;
>  		int j;
>  
> -		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
> -			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
> +		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++)
> +			bnxt_hwrm_cp_ring_free(bp, &cpr->cp_ring_arr[j]);
>  
> -			ring = &cpr2->cp_ring_struct;
> -			if (ring->fw_ring_id == INVALID_HW_RING_ID)
> -				continue;
> -			hwrm_ring_free_send_msg(bp, ring,
> -						RING_FREE_REQ_RING_TYPE_L2_CMPL,
> -						INVALID_HW_RING_ID);
> -			ring->fw_ring_id = INVALID_HW_RING_ID;
> -		}
>  		ring = &cpr->cp_ring_struct;
>  		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
>  			hwrm_ring_free_send_msg(bp, ring, type,
> -- 
> 2.30.1

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

