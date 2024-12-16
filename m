Return-Path: <netdev+bounces-152082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BF9F2A43
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417B318808FB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7E1CCB4A;
	Mon, 16 Dec 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJhfPsGB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AE19258E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331421; cv=none; b=R61aIWAvG3tu3s1toETS5l2YIhYQ+7z1M/umFUihLwqOQtCzw8SvnGXtxRDfJJzaEkIzNYUKoi3xvxB5WSKlbDJ+VU0j/b7RxPKrrGHm23DfUfgfHbY800dt9f22SiHDr2OKcYPMiFC4hU9JibHK/GsVGkTsyRFXu+Nlcm9WaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331421; c=relaxed/simple;
	bh=ChfLP4zPu919XKwzljMZw3LmmcV3xj7gqkrVOcXQJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+hBZzyeRwNwiEFcGfy++QBYT27eOazi2WY/JrF7fHlgAkqS3ZCH6nszxAY49mACHX+1rcitEq+svSEEjZpTsUKTGoH1SLh3bEA1z1mODjq7xpF7hMc2ItXQHzbSyOq3lr9a60eWSjD3gyyLaX3E/2B/Q4S+fkILUAnc6PzaHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJhfPsGB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331420; x=1765867420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ChfLP4zPu919XKwzljMZw3LmmcV3xj7gqkrVOcXQJz4=;
  b=DJhfPsGBAsyK/YjPpLi2HP9Of8gMgYFCkxcEd8dPKO8sHvLe0vpL8wax
   BtmwnbNbLKR0nwHqDKmtV2YAuEFxjA10FVVIVn90Rgp7rkF+WhWz63Tke
   puNsn6i7ufriyHVoh0am2k/PGFaTmml8oKi68YgLXoTu9RbPhligqW+rN
   FiukK+k3RQHJB9QC/Lw6gno017YRVACOdDXsweEKLdg8wcsOR2GZf2clD
   MHWqADbyhn/YkarNm83Z2qk2dfUu61bOe4jgAk9WyZNhbF3R/eLKN+yut
   X1Gl0fMDFzws8vBUsp1Fs7XCPInMNsscJkRsc79k5pQI4zZRrDRfs1mmP
   Q==;
X-CSE-ConnectionGUID: mlwHJsFHT9Se8mRqUBTnHg==
X-CSE-MsgGUID: dJ7dG4ilR+O5pyKdy5E4pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34582666"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34582666"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:43:39 -0800
X-CSE-ConnectionGUID: GZUokINAQWehMNC9uAAw6Q==
X-CSE-MsgGUID: 4cExk9YjQAeRNty/dsfTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97658437"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:43:37 -0800
Date: Mon, 16 Dec 2024 07:40:33 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
Message-ID: <Z1/LYQJrO73BaDKS@mev-dev.igk.intel.com>
References: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Dec 16, 2024 at 01:22:47PM +0900, Joe Hattori wrote:
> Current implementation of mv643xx_eth_shared_of_add_port() calls
> of_parse_phandle(), but does not release the refcount on error. Call
> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Insert a null check before accessing the platform data.
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index a06048719e84..917ff7bd43d4 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2705,8 +2705,12 @@ static struct platform_device *port_platdev[3];
>  static void mv643xx_eth_shared_of_remove(void)
>  {
>  	int n;
> +	struct mv643xx_eth_platform_data *pd;
>  
>  	for (n = 0; n < 3; n++) {
> +		pd = dev_get_platdata(&port_platdev[n]->dev);
> +		if (pd)
> +			of_node_put(pd->phy_node);
>  		platform_device_del(port_platdev[n]);
>  		port_platdev[n] = NULL;
>  	}
> @@ -2769,8 +2773,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>  	}
>  
>  	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
> -	if (!ppdev)
> -		return -ENOMEM;
> +	if (!ppdev) {
> +		ret = -ENOMEM;
> +		goto put_err;
> +	}
>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  	ppdev->dev.of_node = pnp;
>  
> @@ -2792,6 +2798,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>  
>  port_err:
>  	platform_device_put(ppdev);
> +put_err:
> +	of_node_put(ppd.phy_node);
>  	return ret;
>  }
>
Looks good
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks
> -- 
> 2.34.1

