Return-Path: <netdev+bounces-200748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB217AE6BE7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C8D178A22
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56348274B51;
	Tue, 24 Jun 2025 15:57:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4706274B53;
	Tue, 24 Jun 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780670; cv=none; b=b4qT1Yu86BkkvXSmgHxSvMxoNtd/QK392zlpvb9trom4Ov34hKfH7QTbgXmKJsu318eccv16W0ussCa/YAmkmsQx2Wnnjj8fPHmohjnFZTtARKnMvD06InD5LBgvPNdMmbHIyjD+BEsPKCFaG9oAJ3pjLITAn3pZU831nzjt9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780670; c=relaxed/simple;
	bh=RC5ZgJDLkWMTeAbozsGB8YDxW3in6rk1C1G/IezhUi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dndKD4FPGF7w/rXKYEdxFSyT5LmGCwAFL2ebgzEhEzt/JZsB6P1UaAxBHUY9+ZtoDrmgDraucAQxt99+0pByDgkLHxGPsU+BmL8mObE/66VVDHuhO42DRus+dbxMyHb9IjobL8sE+4LhGpwQeP0TTg0guFZB2oF1E7CvswIUung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (gd3k3bs-lt03.asicdesigners.com [10.193.191.21] (may be forged))
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 55OFHPgU020471;
	Tue, 24 Jun 2025 08:17:25 -0700
Date: Tue, 24 Jun 2025 20:47:04 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethernet: cxgb4: Fix dma_unmap_sg() nents value
Message-ID: <aFrBED5rhHtrN0sv@chelsio.com>
References: <20250623122557.116906-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623122557.116906-2-fourier.thomas@gmail.com>

On Monday, June 06/23/25, 2025 at 14:25:55 +0200, Thomas Fourier wrote:
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
> 
> Fixes: 8b4e6b3ca2ed ("cxgb4: Add HMA support")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 51395c96b2e9..73bb1f413761 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -3998,7 +3998,7 @@ static void adap_free_hma_mem(struct adapter *adapter)
>  
>  	if (adapter->hma.flags & HMA_DMA_MAPPED_FLAG) {
>  		dma_unmap_sg(adapter->pdev_dev, adapter->hma.sgt->sgl,
> -			     adapter->hma.sgt->nents, DMA_BIDIRECTIONAL);
> +			     adapter->hma.sgt->orig_nents, DMA_BIDIRECTIONAL);
>  		adapter->hma.flags &= ~HMA_DMA_MAPPED_FLAG;
>  	}
Thanks for the patch Thomas.
this fix needs below change as well:
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -4000,7 +4000,7 @@ static void adap_free_hma_mem(struct adapter *adapter)
        }

	for_each_sg(adapter->hma.sgt->sgl, iter,	
-                   adapter->hma.sgt->orig_nents, i) {
+                   adapter->hma.sgt->nents, i) {
                page = sg_page(iter);
		if (page)
                        __free_pages(page, HMA_PAGE_ORDER);		
 

> -- 
> 2.43.0
> 

