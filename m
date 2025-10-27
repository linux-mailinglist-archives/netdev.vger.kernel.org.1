Return-Path: <netdev+bounces-233211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B12C0E9DE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90387466713
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC074308F36;
	Mon, 27 Oct 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaMIeQ/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442B1E505;
	Mon, 27 Oct 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575721; cv=none; b=rvHv5Png3Ut+QztvsOPOfRMqwB/3vGOaTmxEdMk6D2y73GtkKK2Mv7NNqQdKwxkjdWpdHn1fz+7dD4nT2hagc1jH/PQ7BKT79s4A9rFm9CAXuwjpszR+MHnpaNWkwUU7Lq0WJQVdqKZ0A4cqd4CC5o0JQE5eDE/iNUSrJSSi4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575721; c=relaxed/simple;
	bh=KMompSoz2y155bQ0qAq+gXfUc2mS23P0LNhll3E9WTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6YTMtcopsEVKBBFFUxhtOofqR1gz4+yJzFe5qUcpBi/d88hgBM0rGr81JsZmuzEf2ISgt+TIKhsY0DSEwngjfvoqpIuRbxAHwmDKuYqwJvz8pP3zq68yB/BHZ/Tx1ZoEcxS9UCaqva6ClDfM0kMGZlorRS2wasDxPGJNOmrQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaMIeQ/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675D3C4CEF1;
	Mon, 27 Oct 2025 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575720;
	bh=KMompSoz2y155bQ0qAq+gXfUc2mS23P0LNhll3E9WTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaMIeQ/eSyQhHs7WHZc9h4YqLc0maiNnXKRd2uaZ4BgTf0RaK1k8bmUk2aP1Ipn8Y
	 +Nmyk+egooCCFU36HOKl6kx61fakn4cjNphws4vBq+WWMVvWV8qj+VlVMA6SV3SiuY
	 mTBDNLuyv7crVgGufGn2U79JBaH53NrRYinr1awex6tIHZPtX/5VnVKoZiDQKPw86K
	 T6MatMgXg8qP3NKpxXllnH7IhvLD+VfuXRPRI7f5e2eVSAwnfxB9QlOf0DyOBDP9mt
	 Fheg6jppmylgV7cYRhVt1veBbXRi0hhODu7dpCyfDnz7hKgBFweoP4Li2vZackV7Fn
	 4zpDae+1iLrIw==
Date: Mon, 27 Oct 2025 16:35:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 1/1] net: jme: migrate to dma_map_phys instead
 of map_page
Message-ID: <20251027143516.GN12554@unreal>
References: <20251024070734.34353-1-chuguangqing@inspur.com>
 <20251024070734.34353-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024070734.34353-2-chuguangqing@inspur.com>

On Fri, Oct 24, 2025 at 03:07:34PM +0800, Chu Guangqing wrote:
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/ethernet/jme.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index d8be0e4dcb07..7ceeb706939d 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -735,9 +735,10 @@ jme_make_new_rx_buf(struct jme_adapter *jme, int i)
>  	if (unlikely(!skb))
>  		return -ENOMEM;
>  
> -	mapping = dma_map_page(&jme->pdev->dev, virt_to_page(skb->data),
> -			       offset_in_page(skb->data), skb_tailroom(skb),
> -			       DMA_FROM_DEVICE);
> +	mapping = dma_map_phys(&jme->pdev->dev, virt_to_phys(skb->data),
> +			       skb_tailroom(skb),
> +			       DMA_FROM_DEVICE,
> +			       0);

Same comment as before, dma_map_phys() should be paired with dma_unmap_phys().

Thanks

>  	if (unlikely(dma_mapping_error(&jme->pdev->dev, mapping))) {
>  		dev_kfree_skb(skb);
>  		return -ENOMEM;
> -- 
> 2.43.7
> 
> 

