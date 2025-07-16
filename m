Return-Path: <netdev+bounces-207421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB2B07193
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073E850085F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA228B401;
	Wed, 16 Jul 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge71JVxy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126B157493
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657919; cv=none; b=mm0sQES2ReHlkc/mTMkZjV6mt6oYu7K0Rt8EXjT7Uu2By2Rm6EtQp9kAaHYgR1OcJ3ABW+9ebOPXlrktZahBN9jFoJSFB5d1DuwmBTe9wJGU4wCaHOn265S2sMkhFbRfH6e94XjzcawyYmER8vBEw9shZg3vhzKGx3JDwqFRdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657919; c=relaxed/simple;
	bh=dkpNnjpYsRhJQBoL5SohE6eDXE1Dfz7eQHIaMTW4SHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8y83sG7lAMg6k1Uh2Ig7FIc9N5o9qWOO+jXuoHe0Cw0+XwLQqikch8KdJbT/mr2fIWwPQbkWvncppkjwSDiNWCNsdZ4yzhz2aXZANeHji2g1c0cfIBXFvIbhDOLS0ntrKhRHNvGfYQG0GrDKq+bwX/uDmbbB4PmCgkYLowVQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge71JVxy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752657918; x=1784193918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkpNnjpYsRhJQBoL5SohE6eDXE1Dfz7eQHIaMTW4SHs=;
  b=Ge71JVxyQ31EcBJn2noyDZ/ngHp0Qz93h4M/d+qIudCY7pt0zgJs5rcx
   nxdUPQvNSr3N27Yx1qt8+6sfmB6o8MJZrVBXU5t6ln7ZZ87S9IXwD4N0e
   tg6J1RRBZr2wVj1K7n5DdB4YkHJxqxpTmm/6XuaLAWHIroeSozzXQaed5
   Hy39iOC/mxVbzg/KzJ7onaQ/AiWMfqat/Gby7d86D8CATHQyiWrXxQohS
   asf+OS1E2uk0hW3yMlkBv4ZJavtUWkMdSc30dasicpK7MIKu/rNlcletu
   OasI+KXKIjOPMAbQQGZYNUtL/mbkJSXe8+f/gmnxda6FD19Ey9btNya5i
   Q==;
X-CSE-ConnectionGUID: 9PaYg9bJTEe8s8ZpLun1EQ==
X-CSE-MsgGUID: cacKaEc1QZWCreLkcoT92w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54990013"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54990013"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:25:17 -0700
X-CSE-ConnectionGUID: khmRv9vYRvSjNH+DH50fJg==
X-CSE-MsgGUID: eFyp1+WeR6SXM5VzHx5kNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="188455816"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:25:14 -0700
Date: Wed, 16 Jul 2025 11:24:07 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni4redhat.com@mx0a-0016f401.pphosted.com,
	horms@kernel.org, gakula@marvell.com, hkelam@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
	sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <aHdvt63yoJLt/1g9@mev-dev.igk.intel.com>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
 <1752598924-32705-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752598924-32705-2-git-send-email-sbhatta@marvell.com>

On Tue, Jul 15, 2025 at 10:31:54PM +0530, Subbaraya Sundeep wrote:
> Simplify NIX context reading and writing by using hardware
> maximum context size instead of using individual sizes of
> each context type.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
>  .../marvell/octeontx2/af/rvu_struct.h         |  7 ++-
>  2 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index bdf4d852c15d..48d44911b663 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -17,6 +17,8 @@
>  #include "lmac_common.h"
>  #include "rvu_npc_hash.h"
>  
> +#define NIX_MAX_CTX_SIZE	128
> +

[...]

>  
>  	return 0;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> index 0596a3ac4c12..8a66f53a7658 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> @@ -370,6 +370,8 @@ struct nix_cq_ctx_s {
>  	u64 qsize		: 4;
>  	u64 cq_err_int		: 8;
>  	u64 cq_err_int_ena	: 8;
> +	/* Ensure all context sizes are minimum 128 bytes */
> +	u64 padding[12];
>  };
>  
>  /* CN10K NIX Receive queue context structure */
> @@ -672,7 +674,8 @@ struct nix_sq_ctx_s {
>  struct nix_rsse_s {
>  	uint32_t rq			: 20;
>  	uint32_t reserved_20_31		: 12;
> -
> +	/* Ensure all context sizes are minimum 128 bytes */
> +	u64 padding[15];
>  };
>  
>  /* NIX receive multicast/mirror entry structure */
> @@ -684,6 +687,8 @@ struct nix_rx_mce_s {
>  	uint64_t rsvd_31_24 : 8;
>  	uint64_t pf_func    : 16;
>  	uint64_t next       : 16;
> +	/* Ensure all context sizes are minimum 128 bytes */
> +	u64 padding[15];
>  };

To be sure that each used structures are correct size you can
use static assertion, sth like:
static_assert((NIC_MAX_CTX_SIZE) == sizeof(struct X))

Thanks

>  
>  enum nix_band_prof_layers {
> -- 
> 2.34.1
> 

