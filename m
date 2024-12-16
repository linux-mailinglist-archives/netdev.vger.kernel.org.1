Return-Path: <netdev+bounces-152099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824F9F2AC8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6373F1613EC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6918DF62;
	Mon, 16 Dec 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biRcPi1V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDA1487F6
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333535; cv=none; b=MaaUw1APkip67TZ/biOC1fGYyLXR+gwAHU2tMk4mSLrBophmOrV/jSMwI0Vu6dV/xIXnBAbtR5SFeKQVRSH/8VB2LTXaK40+cv0C+hnnOfpmwSPKSxoJkwzoRa9FSQRc4784J0+YmSzOcnxe5cWVJ5ZSU3Gue5teoajRoGJ7Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333535; c=relaxed/simple;
	bh=B/tur1yDRhI3VM5DW8SthX7SrdrUxSR+1BZUyF4vNVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql9GimBZMYopYV7cpLRuxc750b5gOXZAYwdSCjTjymmKa6+B20mgZUaEwgKf2CySG0utnkScJeCBqrLUzK9omAcwp7jvrf4zFqEw5mrng+xryZELFt4y6UFXjvFRmbAawN4Kp1wWJ7F1pEMOPh8PyeYLdO3SAbQFdx0kEWCbHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biRcPi1V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734333533; x=1765869533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B/tur1yDRhI3VM5DW8SthX7SrdrUxSR+1BZUyF4vNVo=;
  b=biRcPi1VjwrxTnbfnbS/5iPX8FUllojVDA12iWZG8Ke/f+gt6qlkAqiV
   S79D9/2fdo2lGpJkNkOAbfpqjQMAVqI2nlrF+w/jFeS26afhIJgr7jirc
   CpFcrboyNsiAYEUDacImphMHuhldubIZRAuFHwiedg14RWY8xC9vb3wWe
   llJFXJIjhLtvnVASb42nl12wWSznkY8sTh2tZ61YH2S3Hs0FV4SVDQzCy
   ytpE2l7PJNr5l2z/K/y8VlzDtzmq0bKyJB892SlTMfgm0Kr6q/W7jJzyl
   DOil9jzfoWPx5j7bAyCD07I8diaVVopIBNHbvS7i6Za9kfYjlibouye/2
   Q==;
X-CSE-ConnectionGUID: 22sOqj2DT5Wz2335IiTeoQ==
X-CSE-MsgGUID: qoHP/TnlT/KCuH65TKc+og==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38634189"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38634189"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:18:50 -0800
X-CSE-ConnectionGUID: ilnka3aKQXKw1mue8TxNVg==
X-CSE-MsgGUID: 5zZfyqJdQ2WJrAy7tOosFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97543225"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:18:48 -0800
Date: Mon, 16 Dec 2024 08:15:42 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix error patch in airoha_probe()
Message-ID: <Z1/Tng80hii4dBQU@mev-dev.igk.intel.com>
References: <20241215-airoha_probe-error-path-fix-v1-1-dd299122d343@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-airoha_probe-error-path-fix-v1-1-dd299122d343@kernel.org>

On Sun, Dec 15, 2024 at 06:36:35PM +0100, Lorenzo Bianconi wrote:
> Do not run napi_disable if airoha_hw_init() fails since Tx/Rx napi
> has not been started yet. In order to fix the issue, introduce
> airoha_qdma_disable_napi routine and remove napi_disable in
> airoha_hw_cleanup().
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 33 ++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index 6c683a12d5aa52dd9d966df123509075a989c0b3..5bbf5fee2802135ff6083233d0bda78f2ba5606a 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -2138,17 +2138,14 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
>  		if (!qdma->q_rx[i].ndesc)
>  			continue;
>  
> -		napi_disable(&qdma->q_rx[i].napi);
>  		netif_napi_del(&qdma->q_rx[i].napi);
>  		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
>  		if (qdma->q_rx[i].page_pool)
>  			page_pool_destroy(qdma->q_rx[i].page_pool);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
> -		napi_disable(&qdma->q_tx_irq[i].napi);
> +	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
>  		netif_napi_del(&qdma->q_tx_irq[i].napi);
> -	}
>  
>  	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
>  		if (!qdma->q_tx[i].ndesc)
> @@ -2173,6 +2170,21 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
>  	}
>  }
>  
> +static void airoha_qdma_disable_napi(struct airoha_qdma *qdma)
Nit: similar function for enabling napi is named airoha_qdma_start_napi()
maybe stop here or enable there to be consistent.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
> +		napi_disable(&qdma->q_tx_irq[i].napi);
> +
> +	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> +		if (!qdma->q_rx[i].ndesc)
> +			continue;
> +
> +		napi_disable(&qdma->q_rx[i].napi);
> +	}
> +}
> +

[...]

