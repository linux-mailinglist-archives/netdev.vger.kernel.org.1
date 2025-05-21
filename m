Return-Path: <netdev+bounces-192202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B65ABEE24
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD93B8B2A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507512367D3;
	Wed, 21 May 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQM5CfEC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65C237A3B;
	Wed, 21 May 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816833; cv=none; b=OX3DPx0lT+O1tgBI00zkyd3dbUuSAlkMOnjB1f9eOgwD+WvsiZ2yJRjIzdtpvr4zy/Nf9bFT6Rx7ZU0O8kGM5835/QzQPjh7Y99+zwrUpcLHcZpqLNDKZu/fW7EEZcvgHVDHsaYokdFxNuQkUpvrWElXG0gNBnsOnZ3JHxeFzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816833; c=relaxed/simple;
	bh=ZfjrbPi/++vFluGCkn52FEE/Q7CTtIEHaujenXpydjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUomjKbGwBrN8QJ64NhOprmTZwAYh3nmoIOU7+rhWezTFVyLxsbpaFHFyn9xAzUybjHH/QYHue2Nu5Na2Rehkm8UHM+fux61TChI7WghznmcMREGaSIIyRFze6SQg8h0z2cj2lAgxKz7KqKAkNHDNMvgsVd3TXoO5Y0ujEE3qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQM5CfEC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747816832; x=1779352832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfjrbPi/++vFluGCkn52FEE/Q7CTtIEHaujenXpydjI=;
  b=lQM5CfECUM9E+2DNek8WFoVk9ptRYhCTlGGWi+QYibpJemfK+rWrIM0E
   FSH0MaOHSHFzy3Qs5O/1qqEglMmZMro7WERL3OxRwoMsV4xKbUNpdGmVe
   WyEBiFilrdA8SF8ilKOl4YiAJi8HZ4OEBCstZS2bofPHsIYZZjZSbXHGI
   VruqyOlYK1bPS5RDRb3FLlV+6gEtZbIDfESSkqdtkgWYPDmMlIe8Id+8t
   NPcJJLn/R+ad3nfxvslSNsACJEu/mib2BPmK6lvJk1HDo8eB1YTYee+XZ
   65VtY3DL3Jv8GhGLuOqJNkmBh+S44rGmCmd7YrsSS+TJrnjS3qG5hkKY5
   g==;
X-CSE-ConnectionGUID: 9aAG0KpsShaBnvgq2AFXyQ==
X-CSE-MsgGUID: QYMUcuSNSsCjNJtyKMnCeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49688179"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49688179"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:40:31 -0700
X-CSE-ConnectionGUID: qdgOXjpcSU2ovHmlLDfuMg==
X-CSE-MsgGUID: mlrJ3UG2SmuMpq6UTF+5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140897815"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:40:28 -0700
Date: Wed, 21 May 2025 10:39:52 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net PATCH 1/2] octeontx2-af: Set LMT_ENA bit for APR table
 entries
Message-ID: <aC2RWIQgAxG03pSC@mev-dev.igk.intel.com>
References: <20250521060834.19780-1-gakula@marvell.com>
 <20250521060834.19780-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521060834.19780-2-gakula@marvell.com>

On Wed, May 21, 2025 at 11:38:33AM +0530, Geetha sowjanya wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> This patch enables the LMT line for a PF/VF by setting the
> LMT_ENA bit in the APR_LMT_MAP_ENTRY_S structure.
> 
> Additionally, it simplifies the logic for calculating the
> LMTST table index by consistently using the maximum
> number of hw supported VFs (i.e., 256).
> 
> Fixes: 873a1e3d207a ("octeontx2-af: cn10k: Setting up lmtst map table").
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> index 7fa98aeb3663..3838c04b78c2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> @@ -15,13 +15,17 @@
>  #define LMT_TBL_OP_WRITE	1
>  #define LMT_MAP_TABLE_SIZE	(128 * 1024)
>  #define LMT_MAPTBL_ENTRY_SIZE	16
> +#define LMT_MAX_VFS		256
> +
> +#define LMT_MAP_ENTRY_ENA      BIT_ULL(20)
> +#define LMT_MAP_ENTRY_LINES    GENMASK_ULL(18, 16)
>  
>  /* Function to perform operations (read/write) on lmtst map table */
>  static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
>  			       int lmt_tbl_op)
>  {
>  	void __iomem *lmt_map_base;
> -	u64 tbl_base;
> +	u64 tbl_base, cfg;
>  
>  	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
>  
> @@ -35,6 +39,13 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
>  		*val = readq(lmt_map_base + index);
>  	} else {
>  		writeq((*val), (lmt_map_base + index));
> +
> +		cfg = FIELD_PREP(LMT_MAP_ENTRY_ENA, 0x1);
> +		/* 2048 LMTLINES */
> +		cfg |= FIELD_PREP(LMT_MAP_ENTRY_LINES, 0x6);
> +
> +		writeq(cfg, (lmt_map_base + (index + 8)));
Is this 8 LMT_MAP_TBL_W1_OFF? It isn't obvious for me why +8, but I
don't know the driver, so maybe it should.

> +
>  		/* Flushing the AP interceptor cache to make APR_LMT_MAP_ENTRY_S
>  		 * changes effective. Write 1 for flush and read is being used as a
>  		 * barrier and sets up a data dependency. Write to 0 after a write
> @@ -52,7 +63,7 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
>  #define LMT_MAP_TBL_W1_OFF  8
>  static u32 rvu_get_lmtst_tbl_index(struct rvu *rvu, u16 pcifunc)
>  {
> -	return ((rvu_get_pf(pcifunc) * rvu->hw->total_vfs) +
> +	return ((rvu_get_pf(pcifunc) * LMT_MAX_VFS) +
>  		(pcifunc & RVU_PFVF_FUNC_MASK)) * LMT_MAPTBL_ENTRY_SIZE;

Just nit/question, patch looks fine
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
>  
> -- 
> 2.25.1

