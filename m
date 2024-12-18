Return-Path: <netdev+bounces-152869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C29F6146
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C6188E2C7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CE1922F9;
	Wed, 18 Dec 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNI8O2Hz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080F158D6A;
	Wed, 18 Dec 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513563; cv=none; b=b6KTeHE7jp49sW0sbl1w+u55zVeAflt6Z48/IdaLnmzl0Co/h4NT4rZdk8jtuUITmbJAXx0oKAUHveq9o1FSSYLvdoOzH7dsOC+z2DAvgz3gNMxcdL9X41Pyp6gVHkbchO8cY0N+L8iGwTgf1ym2GmpJEvYB9vOz26+dSOMp4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513563; c=relaxed/simple;
	bh=BvpxTN4Kw3DFQ8gOQbXiKSOFa7A1kdcG5WkmrmGVTvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKXDHM6btBiPJTUNi2RGs3l456moqtXU11f/WOF/PjSjse0yUB6o+PIQzIPicA3EKKStFaBIorVRi2+fWs/SECRcAchdcezwRgvEdcXR1nMJazGB4Scwk51G5hb9D6jvYKoUXLAIZoM7wWYP8PkbwvTqu1WS7j1dzjcoGRw3suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNI8O2Hz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734513563; x=1766049563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvpxTN4Kw3DFQ8gOQbXiKSOFa7A1kdcG5WkmrmGVTvM=;
  b=QNI8O2HzOaiQaMos9jU8tDHmX30z0EOvhHUnXlGEAKLDFo8Tpnv9f57v
   Wl0nevwWoCraTrFj8f8XWdzusu8h7z7xHm1fKu4Z4A4yZRgt9F9++Tg0m
   XPltPC+fONthk1mEizIiZDEDg5A3DiKpDjqYErAxs3ys5DEvMG3hDp/cx
   C96ZE42/aGUY0JzslLAPTQzbLrPF0WYQ0YOhtbBt5tnCw5Ub4iNL9c4ET
   U9h5Rc9uQTjFg6yTRCyzFxBjuzGYWSj3LxPo11oCUZWwLoVwx695qYjKq
   gh9vfVxEL/OdNFiMa2aCW1L+arZcfKWV4XD1txU8wp5IC+6sQHMQh7CRi
   g==;
X-CSE-ConnectionGUID: 68ZijsZTTMSNm9hBzGJ3DQ==
X-CSE-MsgGUID: YKG0gRbMS4OTLKow3mxPYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="52388617"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="52388617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:19:22 -0800
X-CSE-ConnectionGUID: YSVYg34oQCiz/ZjXWrnELg==
X-CSE-MsgGUID: v3Yk+36hSR2Cd/YGePg4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128782156"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:19:18 -0800
Date: Wed, 18 Dec 2024 10:16:12 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 2/7] net: hns3: fix missing features due to
 dev->features configuration too early
Message-ID: <Z2KS3IClps8eV3c/@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217010839.1742227-3-shaojijie@huawei.com>

On Tue, Dec 17, 2024 at 09:08:34AM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> Currently, the netdev->features is configured in hns3_nic_set_features.
> As a result, __netdev_update_features considers that there is no feature
> difference, and the procedures of the real features are missing.
> 
> Fixes: 2a7556bb2b73 ("net: hns3: implement ndo_features_check ops for hns3 driver")
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 43377a7b2426..a7e3b22f641c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2452,7 +2452,6 @@ static int hns3_nic_set_features(struct net_device *netdev,
>  			return ret;
>  	}
>  
> -	netdev->features = features;
>  	return 0;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

>  }
>  
> -- 
> 2.33.0

