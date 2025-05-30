Return-Path: <netdev+bounces-194318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FBAC8807
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12091BA542A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2FE1DE2A7;
	Fri, 30 May 2025 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM0nNKZU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6510F1
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748583685; cv=none; b=Q2Igry/RzxLEqvY8ikgvuQYWwEC7OWjLmdRTTAFjBL79JmMzhqS6ae48Be/wbLvHV/60e7DSosFM8uQkPJLLrelYnP6rPhHAVNmyn5uAtYDTi1SU73nFiO/OMGhmW1Jf9LRCeNX6qo5+tZa1KgrcyPl6SnklOrmuxmfzltJ1kI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748583685; c=relaxed/simple;
	bh=LbSYNgmhR0c/Zp67rRAJs6mS5y+ZbbE3ZwWrA0QWZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxug8p9WhNuXNm3los3cYzA/JtVAVBVNR8jAmfqqfR+1tSs13Kl/AYyun4IlkPZ9BeofUnXEnXAf0PStZXc6BDJVkcP1kjxIiqr4g9uOys4ovRE70Ch0I5kzwjjDNKteO4G9iFZ2+tNO0fPjD6272yXp/ez6dKxvE8BP0qSz2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM0nNKZU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748583684; x=1780119684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbSYNgmhR0c/Zp67rRAJs6mS5y+ZbbE3ZwWrA0QWZ0E=;
  b=hM0nNKZUw9MBigXHUvSvJeSrb9QV8UrgDUI7pLN8xdXlEPjyvUTL4fIU
   Ktlmc4vKXzOvoDgy5I3Zf9Lc9TF+SxrUD7LT85V4GQ7H0S8zMhyfnFez6
   yz7VY2XeZ5uQgk7bGyxAR9p6CGD3BwThhnljnHn9TOnXQKeIgJJXwx5Qg
   IutdVZ2ePxvzxH4cMLb0TB/IDGPkIoFv9mq2B2bJyLrmAxFMHQKQlCPAL
   tY4oguAkazRtlqPhmhQ192itZdgZSAcXaznaDxDyLePYDRv/RVGOPIRd8
   hDKB3sq7C9D6jNMYDBCW45X1NZDfRTOTFVcx7fw0vX5ug6XHWPGQA+lWF
   g==;
X-CSE-ConnectionGUID: E+50hbm6QleRK4CyePuzew==
X-CSE-MsgGUID: K6+xVi/eT/WOqsZFFOceEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50720240"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="50720240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 22:41:23 -0700
X-CSE-ConnectionGUID: 3Cu1/i0USI614N8NVlXHqg==
X-CSE-MsgGUID: bJ0Jb4wiSpCO6oPqfB+TVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143691662"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 22:41:22 -0700
Date: Fri, 30 May 2025 07:40:42 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Li Jun <lijun01@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ppp: remove error variable
Message-ID: <aDk8uHRRlf7tO6F5@mev-dev.igk.intel.com>
References: <20250530024850.378749-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530024850.378749-1-lijun01@kylinos.cn>

On Fri, May 30, 2025 at 10:48:50AM +0800, Li Jun wrote:
> the error variable did not function as a variable.
> so remove it.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Hi,

net-next is closed till the 9 June. Plese resend when open.
I assuming you don't want to target it to net, as you don't have fixes
tag and this is cosmetic refactor, not a real issue.

Thanks

> ---
>  drivers/net/ppp/pptp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 5feaa70b5f47..67239476781e 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -501,7 +501,6 @@ static int pptp_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  	struct pppox_sock *po;
> -	int error = 0;
>  
>  	if (!sk)
>  		return 0;
> @@ -526,7 +525,7 @@ static int pptp_release(struct socket *sock)
>  	release_sock(sk);
>  	sock_put(sk);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static void pptp_sock_destruct(struct sock *sk)
> -- 
> 2.25.1

