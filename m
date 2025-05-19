Return-Path: <netdev+bounces-191384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827CABB56D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D8418920DA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596902580D2;
	Mon, 19 May 2025 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3yGlqSG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577931E9B04
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637850; cv=none; b=eGMKpKtolvPF8oHuBPqdlqbBhf/XncDbp5FD0J4mzAc4a4KwaALcBjGj/pQIUoG6DZeZWMz/fTblYwZmz626bdUdcFOeotYG+Ij5ULlU2glbmEqAA7GFdC4Qxf210vJ5qXE5t/3cmII9SzU8FgcX87l+VxZD550qZD1oY+RtgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637850; c=relaxed/simple;
	bh=Di0hLMru24RKRY3YzZc6Y9MvEdO3nbHR5M8bEoiet/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAuuTtJ5v77Dr+9rF/F+xY2DSC6WS7sgB275UsbjPUnYLLKt+kHVfULKTN6LCvz3ELvuIyFBN0gxHMw38oC91yH1fkgCPhBkJ1Ipda3lAohzvCvcE88tRDcS2+UHpBxbUka1Qi1b/SfVnfic3YJx/LrhE4Z+OXolBQYKDEMApqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3yGlqSG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747637848; x=1779173848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Di0hLMru24RKRY3YzZc6Y9MvEdO3nbHR5M8bEoiet/4=;
  b=k3yGlqSGWPfuI2vewy75luApwNjwtV1aAGSTQG0AFmp85JuJe7F0Ki4S
   7TY3d3gnOLeloJuQ71HlLhd9Lt8XpdhsEgfoG/kx79Bs3DkNVreAOCgTx
   CegfihMZmJX8jXamgi8QWW0gDPExxS3e9dhPqogZfVkX+73DyzzFbwb88
   5OE5AGHOfsFCZw5Zr1TVwnPPPtcPSdzgyFCT7uxgRYjTSGpAFWowb004J
   ti2k+NBXpDc01qWgULORaRyYsmU1VZPDCtuRYPO/P/eIt3LkHe0JOH/WI
   ymsbH1yefrrxOrwCC7/D2vCDJFLVTI6i+ndUK2c/OMmjnqg+e9VmcA8JA
   A==;
X-CSE-ConnectionGUID: gwcXNcr6RFaWs6VLr73klA==
X-CSE-MsgGUID: wTPB87E2Tse7MbON6wkgDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="37140919"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="37140919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:56:52 -0700
X-CSE-ConnectionGUID: cPxtIwFURUWmFMQ4A8ySOw==
X-CSE-MsgGUID: wUok9d0cQV2ppJI5+P4rwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139698043"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:56:50 -0700
Date: Mon, 19 May 2025 08:56:17 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next] net: libwx: Fix log level
Message-ID: <aCrV/xlFlxoDsOVl@mev-dev.igk.intel.com>
References: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>

On Mon, May 19, 2025 at 02:33:57PM +0800, Jiawen Wu wrote:
> There is a log should be printed as info level, not error level.
> 
> Fixes: 9bfd65980f8d ("net: libwx: Add sriov api for wangxun nics")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index 52e6a6faf715..195f64baedab 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -76,7 +76,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
>  	u32 value = 0;
>  
>  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> -	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
> +	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
>  
>  	/* Enable VMDq flag so device will be set in VM mode */
>  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);

It is unclear if you want it to go to net, or net-next (net-next in
subject, but fixes tag in commit message). I think it should go to
net-next, so fixes tag can be dropped.

> -- 
> 2.48.1

