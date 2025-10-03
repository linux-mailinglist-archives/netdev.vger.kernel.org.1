Return-Path: <netdev+bounces-227736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F3BB6658
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055DD188D23A
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5F2D8370;
	Fri,  3 Oct 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLymtprB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8119309C;
	Fri,  3 Oct 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484669; cv=none; b=Y4xNy19NJCsq+AUKSD+QAqFDrS2mhf1S2Oc2j97csQvkonazarMM4OPvZ6hqi3f4pEfQlb3X282FF/wySQ96HG4NVFOg77BO8XWF2fhfv0tCBLK+Mp5qSNFpw26I/3clHNma4T2M7ePz4OW3/6elMUIDULj4X2JgoQPgLpJysMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484669; c=relaxed/simple;
	bh=YgMIPeGnk7HKbtds7+WX+M7VM+S3CyUiHHK866sdy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5b01Q3KfeMeHDmdb5f5eAEbuBHW4SXv8qTIO7h5ui7t/a560oKsM/xgO7C0KsBScUJ0WInBfy/hYxPN3caNQG0SZ9qVGVj7fL3Fsng4jiLJlvEqQYiaKMhh9GWe6ln76HsLmbo4Vs0bcB9fY8+hEQqS671wwdi4ZhwL742dPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLymtprB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DEC4CEF5;
	Fri,  3 Oct 2025 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759484667;
	bh=YgMIPeGnk7HKbtds7+WX+M7VM+S3CyUiHHK866sdy7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLymtprBHRf68jF83bmiF6Wd3OZvGZCNrCd6Au4LYHfiMHky7GwILXJ/6A7aACcw0
	 MRdbNZg61wYOwTgmQmaUwni0p7VjqnkXk63ftGty3P1UZ95dOQihXyxf2vjwY39sNn
	 sde1ijqW4yWYBwMPrFF+FZ7HvCjs5vJbTUfwrRxuRNsT/XRX8vKND1J8k48R1R3H0x
	 N1+dOw/5y5YvHA4K4swHKWDLTN45L5QXW+0QDUSnAT54MWNIGEfPmEHe5LLI3ekPnO
	 xn/bJkLlcyiolNNERD5WDRnJVw09c31v2rQs5iMW25OkiWwCwG6+tRwBJJuJ90b0KR
	 UhfCH13AOA1ng==
Date: Fri, 3 Oct 2025 10:44:24 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure properly
Message-ID: <20251003094424.GF2878334@horms.kernel.org>
References: <20251002152638.1165-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002152638.1165-1-yyyynoom@gmail.com>

On Fri, Oct 03, 2025 at 12:26:38AM +0900, Yeounsu Moon wrote:
> Add error handling by checking `dma_mapping_error()` and cleaning up
> the `skb` using the appropriate `dev_kfree_skb*()` variant.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> Tested-on: D-Link DGE-550T Rev-A3
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 49 ++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index 1996d2e4e3e2..a821c9921745 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -508,6 +508,7 @@ static int alloc_list(struct net_device *dev)
>  	for (i = 0; i < RX_RING_SIZE; i++) {
>  		/* Allocated fixed size of skbuff */
>  		struct sk_buff *skb;
> +		dma_addr_t addr;
>  
>  		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
>  		np->rx_skbuff[i] = skb;
> @@ -516,13 +517,19 @@ static int alloc_list(struct net_device *dev)
>  			return -ENOMEM;
>  		}
>  
> +		addr = dma_map_single(&np->pdev->dev, skb->data,
> +				      np->rx_buf_sz, DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&np->pdev->dev, addr)) {
> +			dev_kfree_skb(skb);
> +			np->rx_skbuff[i] = NULL;
> +			free_list(dev);
> +			return -ENOMEM;
> +		}
>  		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
>  						((i + 1) % RX_RING_SIZE) *
>  						sizeof(struct netdev_desc));
>  		/* Rubicon now supports 40 bits of addressing space. */
> -		np->rx_ring[i].fraginfo =
> -		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
> -					       np->rx_buf_sz, DMA_FROM_DEVICE));
> +		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
>  		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
>  	}
>  

Thanks.

I agree that this fixes a problem.
And I agree that these problems were introduced by the cited commit,
at a time when pci_map_single() was used instead of dma_map_single().

But I wonder if it would be slightly nicer to make this change by
using the idiomatic pattern of an unwind ladder of goto labels.

In the case of alloc_list(), something like the following.
(Compile tested only!)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..ba81373bbca8 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -508,25 +508,36 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
-		if (!skb) {
-			free_list(dev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_free_list;
+
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr))
+			goto err_kfree_skb;
 
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
 	return 0;
+
+err_kfree_skb:
+	dev_kfree_skb(np->rx_skbuff[i]);
+	np->rx_skbuff[i] = NULL;
+err_free_list:
+	free_list(dev);
+
+	return -ENOMEM;
+
 }
 
 static void rio_hw_init(struct net_device *dev)

