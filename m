Return-Path: <netdev+bounces-159943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645EBA17772
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 07:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBA16745C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13041AC884;
	Tue, 21 Jan 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X54saXbS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB71A76D0;
	Tue, 21 Jan 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441615; cv=none; b=ghbFKufuEMBltkGpnour39nxEc3QRnG9VoAmxWg0tBGqGh0aF/S0D/c16GPdyMG7jGD7gTTp5Bw/PDI7rx61kD1Yq+eu179je3xqTLFcCtOQvbFpkT2MTM0vzP57JrR1+nEoeChZlkAvMewdep/6wv8stGWz2E+hu4apIPExTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441615; c=relaxed/simple;
	bh=P+I0ddBF4WxkHA77wQLtg+oGGuGnepDkDcNaFgYxpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBLPMsHCVl7p6h79juO98dV1dMQORFkfscuaOn+o8MdPZWWaRe4omgXI5qD9ZzNNnp+g7M8oyWxmqfh3Vkcpf23IWSbd9eYwrk6Hw79THQHHjUJXG7bFwt2fhQqslnxMHIMx/bjSZT4JbySoqvjiwC0Y8zFJP8LPQN9/mXhOkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X54saXbS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737441614; x=1768977614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+I0ddBF4WxkHA77wQLtg+oGGuGnepDkDcNaFgYxpcI=;
  b=X54saXbS8HzOgrrWsjBTiUNOEU+sEG9jvy0lrr2UypVtkM9/DqM6Su0w
   5CFfpkha0ziJA6Tb6iRKuXMgQ8YFjpOYfeT1ZBS2xOLBZf6i2L2KFVqaD
   NVrNcMXhLbAzJKB2oXHz3ADP4baL1O+5aqF1uQCMyeFpBhx+qb9T8YJFb
   uADmWaBjccjZMgzRlIVmtlfuMMdI6WkRm76IToMV2vYCQDTFmEDsstmwx
   q0xpiwNipPQDFpVyOgCwYwdgUiPNHyJP1JHloCIB3eQGN3cgpwqfZbHG2
   DmN5FUCO4NgYfzBR3bH8pO7pXD6QrJXqFH4HeZU96xyX/JjCOnuSAHRig
   g==;
X-CSE-ConnectionGUID: DjpioxbLR6iCXTtCw9a+GA==
X-CSE-MsgGUID: bPwTYodMR06hRgJC+8h3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37753221"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="37753221"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:40:13 -0800
X-CSE-ConnectionGUID: LExPDTXgTzmawmWI2aNnZA==
X-CSE-MsgGUID: nxC0kHCfRLiHenYrGKeAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="111708082"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:40:10 -0800
Date: Tue, 21 Jan 2025 07:36:47 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
	paul@crapouillou.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, zijie98@gmail.com
Subject: Re: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
Message-ID: <Z49Af0yc6gbsyIyW@mev-dev.igk.intel.com>
References: <20250120222557.833100-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120222557.833100-1-chenyuan0y@gmail.com>

On Mon, Jan 20, 2025 at 04:25:57PM -0600, Chenyuan Yang wrote:
> dm is netdev private data and it cannot be
> used after free_netdev() call. Using adpt after free_netdev()
> can cause UAF bug. Fix it by moving free_netdev() at the end of the
> function.
> 
> This is similar to the issue fixed in commit
> ad297cd2db8953e2202970e9504cab247b6c7cb4 ("net: qcom/emac: fix UAF in emac_remove").
> 
> Fixes: cf9e60aa69ae ("net: davicom: Fix regulator not turned off on driver removal")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/net/ethernet/davicom/dm9000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
> index 8735e333034c..b87eaf0c250c 100644
> --- a/drivers/net/ethernet/davicom/dm9000.c
> +++ b/drivers/net/ethernet/davicom/dm9000.c
> @@ -1777,10 +1777,11 @@ static void dm9000_drv_remove(struct platform_device *pdev)
>  
>  	unregister_netdev(ndev);
>  	dm9000_release_board(pdev, dm);
> -	free_netdev(ndev);		/* free device structure */
>  	if (dm->power_supply)
>  		regulator_disable(dm->power_supply);
>  
> +	free_netdev(ndev);		/* free device structure */
> +
>  	dev_dbg(&pdev->dev, "released and freed device\n");
>  }

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> -- 
> 2.34.1

