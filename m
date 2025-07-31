Return-Path: <netdev+bounces-211141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227DB16E04
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0963AC0C7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A287290DAC;
	Thu, 31 Jul 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2pLdObo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395228FAAB
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952334; cv=none; b=FDIwgGQBAxfw0+2GNLuE8GVYrO16kwgtRx8o92EAwjNr/jB31aQFQJK99ipYt1fAxKvUYqlbtmN31IzTLwK1insPuf1bbgdWQ315CULRoZRHndPpOrBKnhF1ost7wvoCpHdZ7vJSZ1SdDZCtpAhUbdzTLkJiXwRIQBqK6EpVzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952334; c=relaxed/simple;
	bh=F8AYxq0vS/2LL0CoNCaqeI41ObQNBGIFIOdzELs5dVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6iObnWYN9t00IXQ5ETaaXyMynrJ6D55vqs1FMDLcXjuSAtPRr15U0sWDKf76AGIV5FS+2ctDY6UcEAk72UvygJPNE7ru7CbxxQwepPXFH7Em0u2K8WXyot6FkmFL+KkCHNW2G3P0a/5buZUWnEn4Fm0E6awvGl0H6v8y2w3ZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2pLdObo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753952333; x=1785488333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F8AYxq0vS/2LL0CoNCaqeI41ObQNBGIFIOdzELs5dVw=;
  b=Q2pLdObon6DUdzQjiezewJRwr0kWc87QiYWzrO0S/me4Yb8TFvC0MIJ+
   +EUKQMDUQ3Ld7KyBwEhlXXTnEBiihzSo21TeSFrmdU/r85QSLzEuBQF4T
   yvBoLxmp8ZzrB190bid7FlellletWhv+yKJwm/jrL/58ptpp1N9jEYvgx
   nA9134oxHsM5VMGtXB2+tpVG1sDuwf0Or+lfWv/ErWegXd88WhqY0EdV/
   5viJnbkRIfepozMlpHJz/Td8pUkGLQnRFHHWh+U0YYQBh5M0GTM94C0pF
   dkq2rXB8F1dd3D5bxrAKb3dYGCqi/aK0RrZldIQRsEeNX10gkL6eSD8nH
   Q==;
X-CSE-ConnectionGUID: dkHM/zc0RxmDc3vsjzD3TA==
X-CSE-MsgGUID: Fsz4xRluTeqX5ykveiR7Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60090155"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="60090155"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:58:53 -0700
X-CSE-ConnectionGUID: u/y9wipnSeuQWFAa4MsoXQ==
X-CSE-MsgGUID: 6Iv/F7f5SXGPVbvR37c00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163235216"
Received: from jkuryjak-mobl1.ger.corp.intel.com (HELO [10.245.115.185]) ([10.245.115.185])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:58:50 -0700
Message-ID: <ddbfdf8c-53ab-4993-a53a-60c45d36cae9@linux.intel.com>
Date: Thu, 31 Jul 2025 10:58:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ftgmac100: fix potential NULL pointer access in
 ftgmac100_phy_disconnect
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-30 10:23 PM, Heiner Kallweit wrote:
> After the call to phy_disconnect() netdev->phydev is reset to NULL.

phy_disconnect() in its flow does not set phydev to NULL, if anywhere it 
happens in of_phy_deregister_fixed_link(), which already calls 
fixed_phy_unregister() before setting phydev to NULL

 From my understanding (which very much could be wrong) of 
ftgmac100_probe(), these two cases are mutually exclusive. The device 
either uses NCSI or will use a phy based on the DT "fixed-link" property
> So fixed_phy_unregister() would be called with a NULL pointer as argument.

Given my analysis above, I don't think this case is possible.

Best regards,
Dawid
> Therefore cache the phy_device before this call.
> 
> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 5d0c09068..a863f7841 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1750,16 +1750,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
>   static void ftgmac100_phy_disconnect(struct net_device *netdev)
>   {
>   	struct ftgmac100 *priv = netdev_priv(netdev);
> +	struct phy_device *phydev = netdev->phydev;
>   
> -	if (!netdev->phydev)
> +	if (!phydev)
>   		return;
>   
> -	phy_disconnect(netdev->phydev);
> +	phy_disconnect(phydev);
>   	if (of_phy_is_fixed_link(priv->dev->of_node))
>   		of_phy_deregister_fixed_link(priv->dev->of_node);
>   
>   	if (priv->use_ncsi)
> -		fixed_phy_unregister(netdev->phydev);
> +		fixed_phy_unregister(phydev);
>   }
>   
>   static void ftgmac100_destroy_mdio(struct net_device *netdev)


