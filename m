Return-Path: <netdev+bounces-161725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07835A2397D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 07:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA497A0768
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6F7B3E1;
	Fri, 31 Jan 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjzaAp7R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0CC8EB;
	Fri, 31 Jan 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304490; cv=none; b=FCsfaSvcAwdTYFKo5Hg1EqbuJUHdNmz6mrkg90Y8CPcoJ5px4aU9tPSy0fQdMI2ayJgmdI61GMEi/4KRS48WMHqMp5bBF8kQ3cnlTIeldsHnSYiFdewQJftrfNjxhpLOPD2KrLRdPrk50DnMJHWZKrD7sy8Gsxz5LDErq3RDTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304490; c=relaxed/simple;
	bh=4457f3QO7jxAij1w8K8qI9z2zpN0Sb/yTbSaXGKXzAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br9unCWde18V07l7eyuzwUWBQ81PhLZh9vIY3+9Q+u5BI4iHTjp4wjHX60lqw3yldmF96yKZs7WX/GaSf0dOQtyhVNfnSwksOCZqUaKNEumt9fFn2lYUrHTLGp5JH6WRJ987hk41Zrq0itDruR0Gevg92v6BgCW8u98c7OCGFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjzaAp7R; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738304488; x=1769840488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4457f3QO7jxAij1w8K8qI9z2zpN0Sb/yTbSaXGKXzAQ=;
  b=BjzaAp7RuWCGEq2EGRmZmq376vgWvNLwp72iFMljd4h2P0qxod4EtIL+
   rXRVzYR20/VZtOchotBT3inaLXy2nfDDA0pSRegvwQORcQkyTeDTKvw1n
   s58tu5q3eOSh7y3Iec2DTZz701tYk/rnbeq+uidubgsN6vobtXivWZd/I
   0DAHYxR8P1Lk04TdKNvO3gO7zhTjOvGy1ivdsrrJuzu/tK/8TzbWetPfj
   gP8x10G4OLfOxhyHuq93ss+SdWBThWEa4UHPtiAHi+kTXRm9kEqQTHXzH
   GH2QhRgUxysQjX3cJ7czeXIuP+UDQCet2lem/SWoXryGXXz4zQAt4P6+0
   A==;
X-CSE-ConnectionGUID: EZiD/ztZROeXaQyGj+m6lQ==
X-CSE-MsgGUID: aDeXSpepS1acpB0xgdmJnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38898451"
X-IronPort-AV: E=Sophos;i="6.13,247,1732608000"; 
   d="scan'208";a="38898451"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 22:21:28 -0800
X-CSE-ConnectionGUID: 8/BkORJtSKaC4/WFwBOUug==
X-CSE-MsgGUID: 4dYWIjDlRoyHMpYHStLWJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,247,1732608000"; 
   d="scan'208";a="110122754"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 22:21:24 -0800
Date: Fri, 31 Jan 2025 07:17:54 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	wojciech.drewek@intel.com, piotr.raczynski@intel.com,
	mateusz.polchlopek@intel.com, pawel.kaminski@intel.com,
	michal.wilczynski@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ice: Add check for devm_kzalloc()
Message-ID: <Z5xrEtiFC4PtSFp6@mev-dev.igk.intel.com>
References: <20250131013832.24805-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131013832.24805-1-jiashengjiangcool@gmail.com>

On Fri, Jan 31, 2025 at 01:38:32AM +0000, Jiasheng Jiang wrote:
> Add check for the return value of devm_kzalloc() to guarantee the success
> of allocation.
> 
> Fixes: 42c2eb6b1f43 ("ice: Implement devlink-rate API")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index d116e2b10bce..dbdb83567364 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -981,6 +981,9 @@ static int ice_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv
>  
>  	/* preallocate memory for ice_sched_node */
>  	node = devm_kzalloc(ice_hw_to_dev(pi->hw), sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +

Thanks for fixing:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  	*priv = node;
>  
>  	return 0;
> -- 
> 2.25.1

