Return-Path: <netdev+bounces-122160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506F96032E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D491C21FC3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E41448E0;
	Tue, 27 Aug 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4uvbeq/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29D747F
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744045; cv=none; b=hnv7rpqJ5ynYuxBj5JCPBdtnR0Fcvo6ph2AT8LMmeKtuT77gCFhivKkCWxhNPqdU/9jw9aAjzTJ4hIKuWamlMdNYzjJanbhAH8t7B56Yzx+JZd5M/PQY0oEH2XYlwqKMLM+URw2h/2XXX+kGMV3zLcyEhSKpfZLp2Xp4UNQwX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744045; c=relaxed/simple;
	bh=hICCdJDJAcH4HSbFU25gziG7zVIdO93tC/zvJvkHOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXSB1Ole6mx9eHlJWDymdHvbX+qUmQ74YR6xgyecC/lpOCW+IXGWfKIP/Wyu3aqceVeVW2OlFo0UcVuum4DGqNiOb5IZfN6JFImtVsapW1kvX3kFSrMTBXZR+vgLhIV/8JOfy6DngVPxNAewzoSpcEmELNOQBlZ2kgkgjLwi5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4uvbeq/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724744044; x=1756280044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hICCdJDJAcH4HSbFU25gziG7zVIdO93tC/zvJvkHOr8=;
  b=U4uvbeq/PevgY2LUjBzPyh6DRK0ZGdn6Ly9JmeIH4KTkm/3FjgsMWDEx
   Kcjvy2IOzvNEfj1gG/mwamnD+OnRE4fFofVpZZIqjMR2eCogBHCnlhQTM
   gDyrQe5pKXOkV57Hee9eNojXv2mHIlqj5I5jAuvi8qqY1FvHOY44dl+Sh
   N+LSdeKotR+PT1+EjhhaWqlQZ3ZSQ+cTtCNwU0wosAHa32DGvzceeZ8Ff
   /V/6qszlIm5WxiSRnQ52yi7V8lIfpA1PI1IOLyis1S4MZZG0DgiRQFMaN
   XPIaVezqfZFBONCwaAHsYwPH4LhrPtIQoT5fXUSEuwdAwWAwkIiAN3M6J
   Q==;
X-CSE-ConnectionGUID: j6jKeLPSSByYu07veLdT8w==
X-CSE-MsgGUID: iqxtRvrBSOuTp5y0oVWnJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34356177"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="34356177"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:34:04 -0700
X-CSE-ConnectionGUID: LmgdmFQ5Sfq2F4vbJ8q6Xw==
X-CSE-MsgGUID: V1y+eRyJQSeNkDefPp3tRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67468450"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:34:01 -0700
Date: Tue, 27 Aug 2024 09:32:03 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, horms@kernel.org,
	helgaas@kernel.org, przemyslaw.kitszel@intel.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v3 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <Zs2A8wvFUoZfjPzQ@mev-dev.igk.intel.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
 <20240823195657.31588-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823195657.31588-10-michael.chan@broadcom.com>

On Fri, Aug 23, 2024 at 12:56:57PM -0700, Michael Chan wrote:
> A range of MSIX vectors are allocated at initialization for the number
> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Fix typo in changelog
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 +++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index fa4115f6dafe..39dc67dbe9b2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10622,6 +10622,43 @@ static void bnxt_setup_msix(struct bnxt *bp)
>  
>  static int bnxt_init_int_mode(struct bnxt *bp);
>  
> +static int bnxt_add_msix(struct bnxt *bp, int total)
> +{
> +	int i;
> +
> +	if (bp->total_irqs >= total)
> +		return total;
> +
> +	for (i = bp->total_irqs; i < total; i++) {
> +		struct msi_map map;
> +
> +		map = pci_msix_alloc_irq_at(bp->pdev, i, NULL);
> +		if (map.index < 0)
> +			break;
> +		bp->irq_tbl[i].vector = map.virq;
> +		bp->total_irqs++;
> +	}
> +	return bp->total_irqs;
> +}
> +
> +static int bnxt_trim_msix(struct bnxt *bp, int total)
> +{
> +	int i;
> +
> +	if (bp->total_irqs <= total)
> +		return total;
> +
> +	for (i = bp->total_irqs; i > total; i--) {
> +		struct msi_map map;
> +
> +		map.index = i - 1;
> +		map.virq = bp->irq_tbl[i - 1].vector;
> +		pci_msix_free_irq(bp->pdev, map);
> +		bp->total_irqs--;
> +	}
> +	return bp->total_irqs;
> +}

Patch looks fine, treat it only as suggestion:

You can save some lines of code by merging this two function.

static int bnxt_change_msix(struct bnxt *bp, int total)
{
	int i;

	/* add MSI-Xs if needed */
	for (i = bp->total_irqs; i < total; i++) {
		...
	}

	/* remove MSI-Xs if needed */
	for (i = bp->total_irqs; i > total; i--) {
		...
	}

	return bp->total_irqs;
}
> +
>  static int bnxt_setup_int_mode(struct bnxt *bp)
>  {
>  	int rc;
> @@ -10788,6 +10825,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
>  int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  {
>  	bool irq_cleared = false;
> +	bool irq_change = false;
>  	int tcs = bp->num_tc;
>  	int irqs_required;
>  	int rc;
> @@ -10806,15 +10844,28 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	}
>  
>  	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
> -		bnxt_ulp_irq_stop(bp);
> -		bnxt_clear_int_mode(bp);
> -		irq_cleared = true;
> +		irq_change = true;
> +		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
> +			bnxt_ulp_irq_stop(bp);
> +			bnxt_clear_int_mode(bp);
> +			irq_cleared = true;
> +		}
>  	}
>  	rc = __bnxt_reserve_rings(bp);
>  	if (irq_cleared) {
>  		if (!rc)
>  			rc = bnxt_init_int_mode(bp);
>  		bnxt_ulp_irq_restart(bp, rc);
> +	} else if (irq_change && !rc) {
> +		int total;
> +
> +		if (irqs_required > bp->total_irqs)
> +			total = bnxt_add_msix(bp, irqs_required);
> +		else
> +			total = bnxt_trim_msix(bp, irqs_required);
> +
> +		if (total != irqs_required)
> +			rc = -ENOSPC;

and here

if (bnxt_change_msix(bp, irqs_required) != irqs_required)
	rc = -ENOSPC;

Thanks,
Michal
>  	}
>  	if (rc) {
>  		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
> -- 
> 2.30.1
> 

