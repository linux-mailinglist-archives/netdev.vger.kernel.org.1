Return-Path: <netdev+bounces-148484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218A9E1D01
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED13B28241C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C41F1315;
	Tue,  3 Dec 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ8pHvU/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E31EE03D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231043; cv=none; b=UK5z8YkbVmq4jhQAL3acUBveidWiJFiPDSaZ/tFXYnpukac36ZaMy5bHY0bdMaOQcsWaDg0rG3pBM53CtNH1CKAOTnbWqSeYtke5TDeGmOXs/xWKFeqZOby3nzcOYdG0Sjju08qqdn291obYjKJRYMsa4S4nIjkGhfXWSmGIFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231043; c=relaxed/simple;
	bh=wu2s73brSDTnGtds7rbg/x0tB9Qq3ALK610XdIXbziU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo3YZWtxNs3pcBIuRgzkPdTE7cbMsysc2VK1HWSXCOx+hNzl+2Ms3goGbSRVuDfB7JTuOnWNVMFD8mLbrOnWsU0tsivvoe+wgZ3WSs537JC/nmMdQ6nvKBlgFfeITu/UKWZLh3d9i2TIe9e3+IUIBRak+Ls9FCJA8tJ9QoXCQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ8pHvU/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231042; x=1764767042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wu2s73brSDTnGtds7rbg/x0tB9Qq3ALK610XdIXbziU=;
  b=fZ8pHvU/JcIUnmzfe9oWcqIsRWkJgWC0uUxVjU72Kvt1n5x36KGxnstf
   oJMCYkrfm1SHY0UnHBreIpYiLz1RCLWFSFvFgSClxeKCKHXu19CqwT2CY
   PzbhaM/ooIWxMT+zTlErvRSyK9KHBlElNiuZFzOS+pCUotfxSQ//EQoC1
   CPYMj/C3g1EcjNViO5MIyzxovyXRyEikml07aOPHa+P4ZvU1vYTXSRClS
   3jdPfKvgJsEJFfTnOoyA3diqFG7bKX2iKV+5d9y0VrPPExWWAvEvuP/jO
   S2iv+UoYmBVlDLOmHQqiR1qJVQgwwPOEgNcymxrmb1/4x0A8XnNMDRNMp
   Q==;
X-CSE-ConnectionGUID: qc6FEiWQQ5ef5CRe4jdrTA==
X-CSE-MsgGUID: D8edFP+MROO9lTzuUSrO7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33571475"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33571475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:04:01 -0800
X-CSE-ConnectionGUID: 4VD1nCS7RpaQxfVd8BANEw==
X-CSE-MsgGUID: FLikq/YlQ6G6HYt4QNpnJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124258373"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:03:59 -0800
Date: Tue, 3 Dec 2024 14:01:02 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove unused flag
 RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE
Message-ID: <Z08BDgxPVVKbjJZo@mev-dev.igk.intel.com>
References: <d9dd214b-3027-4f60-b0e8-6f34a0c76582@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9dd214b-3027-4f60-b0e8-6f34a0c76582@gmail.com>

On Mon, Dec 02, 2024 at 09:14:35PM +0100, Heiner Kallweit wrote:
> After 854d71c555dfc3 ("r8169: remove original workaround for RTL8125
> broken rx issue") this flag isn't used any longer. So remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 739707a7b..4b96b4ad8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -623,7 +623,6 @@ struct rtl8169_tc_offsets {
>  
>  enum rtl_flag {
>  	RTL_FLAG_TASK_RESET_PENDING,
> -	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>  	RTL_FLAG_TASK_TX_TIMEOUT,
>  	RTL_FLAG_MAX
>  };
> @@ -4723,8 +4722,6 @@ static void rtl_task(struct work_struct *work)
>  reset:
>  		rtl_reset_work(tp);
>  		netif_wake_queue(tp->dev);
> -	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
> -		rtl_reset_work(tp);
>  	}
>  }
>  
> -- 
> 2.47.1
>

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Thanks

> 
> 

