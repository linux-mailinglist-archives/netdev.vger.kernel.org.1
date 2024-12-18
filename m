Return-Path: <netdev+bounces-152870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538969F6157
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397597A1669
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DD81925A2;
	Wed, 18 Dec 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3jzyBzw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A961791F4;
	Wed, 18 Dec 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513837; cv=none; b=cRI1skEpv+C2mwWr5KQzsOMAnXDWFELGjZtXyu2XVIV9NdAy0nfx5/0q45k2h9ofKl1QqmAdqBWB5K4ywddcUM6GpUgsn3XKZh90y2Ueg9qHuxFOUzHJK0Dd7csUJAr18X2ay6BkfHSXHBwFZC8aaxOLaTxHP6XhzmBdjNL8NeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513837; c=relaxed/simple;
	bh=SP3UykcEPzg/MSotJ0+0DR3WhJeZ0KS1gdLvsDmy4tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2e2iCxFHPeBjtIojM0dtowZjsktFBtxKoxqlgMQVkyX04ndSlQOvgfGqgPiILnoiYKpUED1H0rFiL3RG/TdQPtNk+gjy3+rrl3sUFwS/OoYCnGzGuG1uRoyQPP4KMi+6PKntocpPp6qH2xG+MKuqa+W4DjaprEQw96VZ7cpF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3jzyBzw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734513836; x=1766049836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SP3UykcEPzg/MSotJ0+0DR3WhJeZ0KS1gdLvsDmy4tw=;
  b=N3jzyBzwM/Uv+Dr+C43iml8+Dx+I8PqsivJsCse9w0gCrkE9NGqtSxKb
   /CZKgTdyLdkkI7bK+Tfmr8g8FbzbbHeFoL8hTRTXbHzuo++2/gvgfUe6f
   Wv9++fYk/0lkloJMsofKu6VtFEBN2Yg227cpG4uK5Wpy4WyliT/OL7sqo
   LbFZ35UwJxETkbbmW4+l/mJ8sRZWrNMMAYju97NDOAdvIzwxEAW1+80Qc
   X/7iMD9MyW5cHtCqijtAgncQR/5IeMWI/SPQ+wNvWaKQZwOc1oWUj9Zhb
   vpx5FT9L5/U9WfBlIDMk7adz0/pDTjJjBNHRz7o6vbl8P0t4CEyG5PBeU
   g==;
X-CSE-ConnectionGUID: di358Vk9TW6V2Bfm346h3Q==
X-CSE-MsgGUID: 8ID5HoD3SUWj1OolplIyQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="46373970"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="46373970"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:23:55 -0800
X-CSE-ConnectionGUID: 0kp/RRJPQpKhJTahM/Qzaw==
X-CSE-MsgGUID: 4KUUOf30TrqI3p6m+hQK4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="98035017"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:23:51 -0800
Date: Wed, 18 Dec 2024 10:20:45 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 5/7] net: hns3: initialize reset_timer
 before hclgevf_misc_irq_init()
Message-ID: <Z2KT7bLfHmx01wSU@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217010839.1742227-6-shaojijie@huawei.com>

On Tue, Dec 17, 2024 at 09:08:37AM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently the misc irq is initialized before reset_timer setup. But
> it will access the reset_timer in the irq handler. So initialize
> the reset_timer earlier.
> 
> Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index fd0abe37fdd7..8739da317897 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -2313,6 +2313,7 @@ static void hclgevf_state_init(struct hclgevf_dev *hdev)
>  	clear_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state);
>  
>  	INIT_DELAYED_WORK(&hdev->service_task, hclgevf_service_task);
Comment here that timer needs to be initialized before misc irq will be
nice, but that is onlu my impression.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks
> +	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
>  
>  	mutex_init(&hdev->mbx_resp.mbx_mutex);
>  	sema_init(&hdev->reset_sem, 1);
> @@ -3012,7 +3013,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
>  		 HCLGEVF_DRIVER_NAME);
>  
>  	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
> -	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
>  
>  	return 0;
>  
> -- 
> 2.33.0

