Return-Path: <netdev+bounces-122151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0119602AE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295DD283340
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22361428F3;
	Tue, 27 Aug 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujf8cfa0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1938F58
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742389; cv=none; b=NbzMF9XiijbdQ1wppDmgf1wcYzMHOcQDHADklh5abqe658TXFeLm9YEI1WRbdwTg4z75a4ROmuTKWCJCeKWt5GUATD4DkQfBN8HSoKPwTAjLP6e7pE2co/tLJnktSLzQmRATtWWH2Fj9R6mRcUck05VeWK6TD5mdjv0362MmTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742389; c=relaxed/simple;
	bh=6DARzlLnItDQA1aIu/eOJeqqSj9QL6fvcxQPlHpRH6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk0ZeKIpAh+vypdhLZrVDGeHmCzbPFgl0q5a8Gp8MjL4RIYCGDFuhvdTZW1ckN3h+oEhFsZ+E0Cu/UT9TEnMPjJPpiEasMUjDCVFa8e81iBMnocXxZbmd8djVxoqsdTZjvuZEwslQCp4D0IHUhOHOdCJJxFi++mhHa7A6HYxUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujf8cfa0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724742387; x=1756278387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6DARzlLnItDQA1aIu/eOJeqqSj9QL6fvcxQPlHpRH6k=;
  b=Ujf8cfa0X8CEP+kEbrahF+WX6DLne/kZ2FqOUAMen4x76I1dbGKGcRa+
   3OdszYEfxMA6t5mfCky0vyJWTq1LMrSqd9Q/COJRJMPzoc9No+8W7jxUn
   A43qKB96/JhKLVNk5iobwhdcHcNC4r0ATQ3/4Lh1TyU3KTRsIpboA5/Kc
   U7NVRJwE0J3r7jsTSvQak67W18/T7X5bw8zKrEenk30c4fLewTU34KQGj
   TN3HUcaM4vDUEQGojSipwoaBLrCNOh3G85qWi9PdJIw1GCGn0KPZSwCMk
   hQaNiAqSO7TSLgnnlAx9q8uUpRhHCVWiMvdXi9mVRC09z4vVcs7caU59j
   A==;
X-CSE-ConnectionGUID: HKR8diXHQ2ypZNVx+It4ow==
X-CSE-MsgGUID: dGkI2B3yQoa6O6Pw9cPrsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33766779"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33766779"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:06:27 -0700
X-CSE-ConnectionGUID: Csajvh8NSwW5IGUWv+mKvw==
X-CSE-MsgGUID: Ak/3Sv4jRNG7m1QvjWA3+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="93509561"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:06:25 -0700
Date: Tue, 27 Aug 2024 09:04:28 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify
 the code
Message-ID: <Zs16fFk7sDIhcMP8@mev-dev.igk.intel.com>
References: <20240827025246.963115-1-lihongbo22@huawei.com>
 <20240827025246.963115-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025246.963115-2-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 10:52:45AM +0800, Hongbo Li wrote:
> As str_up_down is the common helper to reback "up/down"
> string, we can replace the target with it to simplify
> the code and fix the coccinelle warning.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/ncsi/ncsi-manage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 5ecf611c8820..13b4d393fb2d 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1281,7 +1281,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  				netdev_dbg(ndp->ndev.dev,
>  					   "NCSI: Channel %u added to queue (link %s)\n",
>  					   nc->id,
> -					   ncm->data[2] & 0x1 ? "up" : "down");
> +					   str_up_down(ncm->data[2] & 0x1));
Are you basing the commit on sth else than net-next? I can't see such
helper in the repo.

>  			}
>  
>  			spin_unlock_irqrestore(&nc->lock, cflags);
> -- 
> 2.34.1
> 

You have the same commit message in both patches, they can be merged
into one I think.

Thanks,
Michal

