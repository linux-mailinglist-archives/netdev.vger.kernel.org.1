Return-Path: <netdev+bounces-192200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268FABEE0C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF2F3A919F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8412367D5;
	Wed, 21 May 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Be/9/vAC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8321ABB9;
	Wed, 21 May 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816607; cv=none; b=R72ZFnXbtjYKYQBQ2IyNgfoNHbOmSOpdcGo2MGunLAlzgB7/XmiYR5rrt+/rfbwd7Li1E4XKZBrM1nCpuBJP2TgKjgz2g/+DD9pG3rACe92hm564oA3f/ccOWGFJ+mrc3a1uycefaZgfc9xru2oKd8nYrfvh4VdykLkqr4eNWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816607; c=relaxed/simple;
	bh=nnZ32l/wC8IB5jxsCJX2rZsRy0WE1KOizSvfjplrc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNYBLf92+yEc17lVg8voiaiiTNKPKeoPf7dpjOns8IT/BNzydZ2aRzbBjx2dHEcigr58SOlXEHLcRyVoeC/B/HU3A1d8u/ZKPqjOKt/ytROHMww+DMJjMSnl/tT55Ma/ajhJmn3TiosppnvNj09pmCQJ3Heejjqc87NyaoBFf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Be/9/vAC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747816606; x=1779352606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnZ32l/wC8IB5jxsCJX2rZsRy0WE1KOizSvfjplrc7A=;
  b=Be/9/vACYnXUAVkakioZa7pJP2dg1RrzNYdiTpZkeELaaKULf5IBiYWP
   roR1O7ZK0eDHqSftg8JRjAZaIWS5kV/cW+xpVg4BRMGWK9CpKflnkUOoe
   zWXzG6cPz183OCbdMuhJBolOTid8E0QOeueNsNOj/eUjS6U8mytQfux04
   OzBDg6+jE9yym9i85g/2LPWZWqok7S6+zeNpQOLeLqs5d3FMqV1aenMyV
   DS7nmRyEeu6HLp+0ihn8Y5+lP0KAndESccIKvKcKHF5DGiFI82Z37Hp0r
   oO1mXcSxAXDKwyPqTUwF+S/YS5np2QBNFPiXS4+A4ExtUjIqV1dRp0ydn
   w==;
X-CSE-ConnectionGUID: yOl7dAnPTiKX/hF9L9Ah0w==
X-CSE-MsgGUID: 8YqJT6IeSpiHIhkzAmR2fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49043864"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49043864"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:36:45 -0700
X-CSE-ConnectionGUID: 4K+HPBIqRFC6s6qIRvQhWw==
X-CSE-MsgGUID: 8In+ItoKREOWT2IKIdO+lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144701684"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:36:43 -0700
Date: Wed, 21 May 2025 10:36:06 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net PATCH 2/2] octeontx2-af: Fix APR entry mapping based on
 APR_LMT_CFG
Message-ID: <aC2QdjlVJTNhfvV9@mev-dev.igk.intel.com>
References: <20250521060834.19780-1-gakula@marvell.com>
 <20250521060834.19780-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521060834.19780-3-gakula@marvell.com>

On Wed, May 21, 2025 at 11:38:34AM +0530, Geetha sowjanya wrote:
> The current implementation maps the APR table using a fixed size,
> which can lead to incorrect mapping when the number of PFs and VFs
> varies.
> This patch corrects the mapping by calculating the APR table
> size dynamically based on the values configured in the
> APR_LMT_CFG register, ensuring accurate representation
> of APR entries in debugfs.
> 
> Fixes: 0daa55d033b0 ("octeontx2-af: cn10k: debugfs for dumping LMTST map table").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c |  9 ++++++---
>  .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 ++++++++---
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> index 3838c04b78c2..4a3370a40dd8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> @@ -13,7 +13,6 @@
>  /* RVU LMTST */
>  #define LMT_TBL_OP_READ		0
>  #define LMT_TBL_OP_WRITE	1
> -#define LMT_MAP_TABLE_SIZE	(128 * 1024)
>  #define LMT_MAPTBL_ENTRY_SIZE	16
>  #define LMT_MAX_VFS		256
>  
> @@ -26,10 +25,14 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
>  {
>  	void __iomem *lmt_map_base;
>  	u64 tbl_base, cfg;
> +	int pfs, vfs;
>  
>  	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
> +	cfg  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
> +	vfs = 1 << (cfg & 0xF);
> +	pfs = 1 << ((cfg >> 4) & 0x7);
>  
> -	lmt_map_base = ioremap_wc(tbl_base, LMT_MAP_TABLE_SIZE);
> +	lmt_map_base = ioremap_wc(tbl_base, pfs * vfs * LMT_MAPTBL_ENTRY_SIZE);
>  	if (!lmt_map_base) {
>  		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
>  		return -ENOMEM;
> @@ -80,7 +83,7 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
>  
>  	mutex_lock(&rvu->rsrc_lock);
>  	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
> -	pf = rvu_get_pf(pcifunc) & 0x1F;
> +	pf = rvu_get_pf(pcifunc) & RVU_PFVF_PF_MASK;
>  	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
>  	      ((pcifunc & RVU_PFVF_FUNC_MASK) & 0xFF);
>  	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TXN_REQ, val);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index a1f9ec03c2ce..c827da626471 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -553,6 +553,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
>  	u64 lmt_addr, val, tbl_base;
>  	int pf, vf, num_vfs, hw_vfs;
>  	void __iomem *lmt_map_base;
> +	int apr_pfs, apr_vfs;
>  	int buf_size = 10240;
>  	size_t off = 0;
>  	int index = 0;
> @@ -568,8 +569,12 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
>  		return -ENOMEM;
>  
>  	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
> +	val  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
> +	apr_vfs = 1 << (val & 0xF);
> +	apr_pfs = 1 << ((val >> 4) & 0x7);
>  
> -	lmt_map_base = ioremap_wc(tbl_base, 128 * 1024);
> +	lmt_map_base = ioremap_wc(tbl_base, apr_pfs * apr_vfs *
> +				  LMT_MAPTBL_ENTRY_SIZE);

As it is the same as in lmtst_map_table_ops() I think you can move whole
to a new function.

rvu_ioremap_wc(rvu, base, size);

or sth like that. It isn't strong opinion. Rest looks fine, thanks.

>  	if (!lmt_map_base) {
>  		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
>  		kfree(buf);
> @@ -591,7 +596,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
>  		off += scnprintf(&buf[off], buf_size - 1 - off, "PF%d  \t\t\t",
>  				    pf);
>  
> -		index = pf * rvu->hw->total_vfs * LMT_MAPTBL_ENTRY_SIZE;
> +		index = pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE;
>  		off += scnprintf(&buf[off], buf_size - 1 - off, " 0x%llx\t\t",
>  				 (tbl_base + index));
>  		lmt_addr = readq(lmt_map_base + index);
> @@ -604,7 +609,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
>  		/* Reading num of VFs per PF */
>  		rvu_get_pf_numvfs(rvu, pf, &num_vfs, &hw_vfs);
>  		for (vf = 0; vf < num_vfs; vf++) {
> -			index = (pf * rvu->hw->total_vfs * 16) +
> +			index = (pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE) +
>  				((vf + 1)  * LMT_MAPTBL_ENTRY_SIZE);
>  			off += scnprintf(&buf[off], buf_size - 1 - off,
>  					    "PF%d:VF%d  \t\t", pf, vf);
> -- 
> 2.25.1

