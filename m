Return-Path: <netdev+bounces-192167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA59ABEBF7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DD7B465E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0322DFA3;
	Wed, 21 May 2025 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6+FYMQl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84621B1AB;
	Wed, 21 May 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808800; cv=none; b=nUn2Y2kCZmoo0wWZeytzcO+N/j72YbztFKLBwM6KOCu+Y94YEtHaAdmIoUuHwUt8rJ1gY0SuLJ1Wz3j37RT0gpwT/qFmrHXL7nZ1JRcw+qhJPMesZIehY+nGjFTbyWVhTjQvOB0h9j9LKNZA9rSMsHnFNNfoWQM4/5womRvmVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808800; c=relaxed/simple;
	bh=G7NyHqoxMUFHKaynfPZqxOQJz6ix7f6OCz2eY2/zINI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXGIYAbR2F8kFJ2BukiZOfrV5pZqd9my33r2GwbnmWhuZxOi0R694812z2AMyqk7A0euohUhWuHK6Mqv1aqEsLRZSVEVzTVktRhO0JS79g4e6pm+Zw+kFj0vtBAmU2cjS7o6mUdmXfD3YcyOdjdjhkQk/jChBu0KWo3TxBsxTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6+FYMQl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747808799; x=1779344799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7NyHqoxMUFHKaynfPZqxOQJz6ix7f6OCz2eY2/zINI=;
  b=T6+FYMQlyWI2QZuwXRIyS8xr/j09LYYcY6KwzIJz3Hb63w/h366INvci
   nM7wi5SNHl6w8yABVRSl9+WyRSQz341b7GWOe7r1SbYM6NWewabWTGh/g
   wD+EHmxGSNtIECwqwdXt1tSW1l9ZmW1kCNwqxADCpNPaSdSHMpTTzJ41V
   R94yrlT2VuWpwIpgkdK4BLvurCUoaRBM1fJQlCWRPie5O8fJLpaMqWv2A
   HUzm5BjqSdRvP5VWJigN2cnkyJhtVaBkGEELuLjhiwJDDo1Y4Be2w2tCf
   vi37398Gs8CK0GKr5fTeCHsWhRM66YBkm5R3xCMOfy3Apid0uITBjT9um
   w==;
X-CSE-ConnectionGUID: wnBdyg9TQB2BswMuzcSguw==
X-CSE-MsgGUID: kJjBFdH1QzK12GGoLn7pUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60425766"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60425766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:26:36 -0700
X-CSE-ConnectionGUID: A2Jt7UeGTe6Hc9xr9aD3Gg==
X-CSE-MsgGUID: WH1yTpN1QQmGyApzkmaNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="143919338"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:26:29 -0700
Date: Wed, 21 May 2025 08:25:51 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Nelson Escobar <neescoba@cisco.com>
Cc: Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Daley <johndale@cisco.com>
Subject: Re: [PATCH net-next] net/enic: Allow at least 8 RQs to always be used
Message-ID: <aC1x74D+eYJtvHQi@mev-dev.igk.intel.com>
References: <20250521-enic_min_8rq-v1-1-691bd2353273@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-enic_min_8rq-v1-1-691bd2353273@cisco.com>

On Wed, May 21, 2025 at 01:19:29AM +0000, Nelson Escobar wrote:
> Enic started using netif_get_num_default_rss_queues() to set the number
> of RQs used in commit cc94d6c4d40c ("enic: Adjust used MSI-X
> wq/rq/cq/interrupt resources in a more robust way")
> 
> This resulted in machines with less than 16 cpus using less than 8 RQs.
> Allow enic to use at least 8 RQs no matter how many cpus are in the
> machine to not impact existing enic workloads after a kernel upgrade.
> 
> Reviewed-by: John Daley <johndale@cisco.com>
> Reviewed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic.h      | 1 +
>  drivers/net/ethernet/cisco/enic/enic_main.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 9c12e967e9f1299e1cf3e280a16fb9bf93ac607b..301b3f3114afa8f60c34c05661ee3cf67d4d6808 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -26,6 +26,7 @@
>  
>  #define ENIC_WQ_MAX		256
>  #define ENIC_RQ_MAX		256
> +#define ENIC_RQ_MIN_DEFAULT	8
>  
>  #define ENIC_WQ_NAPI_BUDGET	256
>  
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index c753c35b26ebd12c500f2056b3eb583de8c6b076..6ef8a0d90bce38781d931f62518cf9bafb223288 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -2296,7 +2296,8 @@ static int enic_adjust_resources(struct enic *enic)
>  		 * used based on which resource is the most constrained
>  		 */
>  		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
> -		rq_default = netif_get_num_default_rss_queues();
> +		rq_default = max(netif_get_num_default_rss_queues(),
> +				 ENIC_RQ_MIN_DEFAULT);
>  		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
>  		max_queues = min(enic->cq_avail,
>  				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
> 
> ---
> base-commit: ae605349e1fa5a29cdeecf52f92aa76850900d90
> change-id: 20250513-enic_min_8rq-421f23897dc2
> 
> Best regards,

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> Nelson Escobar <neescoba@cisco.com>

