Return-Path: <netdev+bounces-177009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45CA6D3FB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C455116C1BD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6442AF19;
	Mon, 24 Mar 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSDZ14WZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BA23A9
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796329; cv=none; b=O/EdeyVb1UNGfuVcDGpvIo4e8gS/Q5vqaB+zH//fe03Ux9kl1XmYlp1dmmRdHwFSAFI5oUrQAV7tGmun2FR9XSxJydS0mI9Ygev+UPdAi7EvH9xSHzrQTZX6AgroJmdq9ssBab3LdxYXG5cnXT2OdrWvSJADVX3ThbsfYSnJ3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796329; c=relaxed/simple;
	bh=pf3MzY2hCYg7+b+FFlDJlEOmtWR0uWYxQ8eZMqOf4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivqEH3WJZCURqO/a3uDBPqTYQv8SnWYpkoonxs869aOpDg7aRd9gEsKYb1P9RyIMkhq3WTQHpp9mtQn9uptB08falrky23KrM721nFPTby2HKpdcm7VImIlSBsCGPnfbaAf2vAfEvMN4A4Kcp/9Rr+0L3zRThCCcA/CthB87QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSDZ14WZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742796327; x=1774332327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pf3MzY2hCYg7+b+FFlDJlEOmtWR0uWYxQ8eZMqOf4qk=;
  b=gSDZ14WZFLHPpKxKf2Ht3NEYsN0mjKtv57rROddzG+xKCkQNyJ11zNJg
   HOzSFG4Jw8R+TAKS0wwA7KRlKpdcBy1IAbg/AMJqedDLNFT4w8NfCR1RF
   F9hsxp22R8hi8ZjkRz9yqgPtEXOn5TBoD/HhCk2sTBqeFwtFiOGj+01S+
   AE332MUHseS7ZKh2OfiWdkh+YrPSMTNz+3W8PEnxeWwdTkmwzl6TPNbE7
   8VYlmCLZjWiFIywKFqSmGIr0hwl65T+bQMLYe1/GyiMyN4+TwOqVX8PNS
   r3j01/fc7EerPvCbPzxfFPJ0WFfPDbKcgQK9rTwBG20bDAVPwY8hRlz+r
   g==;
X-CSE-ConnectionGUID: 7G7E6OCoRmOThTtSzKnHLA==
X-CSE-MsgGUID: uCIeX4+cSN61xqKulgljVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="55360535"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="55360535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:05:26 -0700
X-CSE-ConnectionGUID: DRbMxMdqS26nLpM+8gBc6w==
X-CSE-MsgGUID: awd2nrSPT+CJL9LapuwiTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129145362"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:05:24 -0700
Date: Mon, 24 Mar 2025 07:01:26 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Johan Korsnes <johan.korsnes@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: au1000_eth: Mark au1000_ReleaseDB() static
Message-ID: <Z+D1NpUDCsIZLAEP@mev-dev.igk.intel.com>
References: <20250323190450.111241-1-johan.korsnes@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323190450.111241-1-johan.korsnes@gmail.com>

On Sun, Mar 23, 2025 at 08:04:50PM +0100, Johan Korsnes wrote:
> This fixes the following build warning:
> ```
> drivers/net/ethernet/amd/au1000_eth.c:574:6: warning: no previous prototype for 'au1000_ReleaseDB' [-Wmissing-prototypes]
>   574 | void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>       |      ^~~~~~~~~~~~~~~~
> ```
> 
> Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/amd/au1000_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index 0671a066913b..9d35ac348ebe 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> @@ -571,7 +571,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
>  	return pDB;
>  }
>  
> -void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
> +static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>  {
>  	struct db_dest *pDBfree = aup->pDBfree;
>  	if (pDBfree)

Thanks for fixing it
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

You didn't specify the tree (net vs net-next in [PATCH ...]). If you
want it to go to net you will need fixes tag, if to net-next it is fine.

> -- 
> 2.49.0

