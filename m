Return-Path: <netdev+bounces-179510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA403A7D397
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D72188A1F1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57271C6B4;
	Mon,  7 Apr 2025 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN91DojN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A81917ED
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003954; cv=none; b=eZMENryj8YlCbF6hHSqDW/0sNd/TcfgKATq1FDdeEnt2rC4nFzp0gD7U+DBDAlqYldXaVF4t7BW9W1IjUWCOhRVn3mOyM7+/AstT/LBiRQgVTjPwxCbUt6JePArPLATaD579l7zXraS0wGEsXF2V/c23a/pfgYxkIue7H1FyoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003954; c=relaxed/simple;
	bh=SvWZSIdBh5TXMw/vt87mngeXTI1OswjOy822p3sHzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6spL2TGLBu+T59OiL1Ym8NGE0UUFsH2m6hax3dunxRyO8nyKV2T9dGhO1yFnj/quLYc/i30dipupGIvyZJeyj7dzAbuY9QjxJ3ufeMjtT4fVzpOebebz/IVcAKjXSpYab8tB8uVf2Q5QAvcuh9YKSwZ7oVNdocAVev1/8RRjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN91DojN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744003953; x=1775539953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvWZSIdBh5TXMw/vt87mngeXTI1OswjOy822p3sHzL8=;
  b=CN91DojN0SHWoqhggE1INqNjh+lDPpt2BFHcKFP92w2NBQWSNTxT4w9q
   upfOrULH5OKEIuTuJsdvZVcspOK3jJeg3+bNnJ6CDnJj2X7f8wnAYZGZu
   3LPx54N+dUDoD/3uaqaWcAA6N9GUupC2bDPSNtAVBpabM/TEMQnEMffhk
   2XHbpMHl84sM8gaubhVjeXnT/kPvx8pumWD+GDE9zYYJwHoxMiMnGvUjv
   6sldZjE0M6A+MZuZH9GM53iQA8AqyIz3WogFUlYF3BaNjTnz03wWNzPXo
   9UsvhKv7sgLnQi2oHQm5RyYUqfnRnkzbAWSP7en8/Y3pzdVPcwxbuBMwU
   g==;
X-CSE-ConnectionGUID: rbjcfjLvSxG8s+u4Owit2Q==
X-CSE-MsgGUID: 6MKoYFbkSDSSEhsy0NIL4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="62768714"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="62768714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:32:31 -0700
X-CSE-ConnectionGUID: 2pMjjKUeT5mlwqz5Bz69gA==
X-CSE-MsgGUID: S8sW/wFjTgK6PRYICEb7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="132993676"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:32:28 -0700
Date: Mon, 7 Apr 2025 07:32:13 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jdamato@fastly.com, duanqiangwen@net-swift.com, dlemoal@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: libwx: handle page_pool_dev_alloc_pages error
Message-ID: <Z/NjXSRVFp9c/XmQ@mev-dev.igk.intel.com>
References: <20250406192351.3850007-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406192351.3850007-1-chenyuan0y@gmail.com>

On Sun, Apr 06, 2025 at 02:23:51PM -0500, Chenyuan Yang wrote:
> page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
> but it would still proceed to use the NULL pointer and then crash.
> 
> This is similar to commit 001ba0902046
> ("net: fec: handle page_pool_dev_alloc_pages error").
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 00b0b318df27..d567443b1b20 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -310,7 +310,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
>  		return true;
>  
>  	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
> -	WARN_ON(!page);
> +	if (unlikely(!page))
> +		return false;
>  	dma = page_pool_get_dma_addr(page);
>  
>  	bi->page_dma = dma;

Thanks for fixing, it is fine, however you need to add fixes tag.
Probably:
Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")

> -- 
> 2.34.1

