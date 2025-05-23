Return-Path: <netdev+bounces-193087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3097AC2774
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAB1C008C0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76992957C1;
	Fri, 23 May 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aYBb8WPx"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91E152DE7
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017234; cv=none; b=Xm3sb5+hrM1cYu5sZansugrt30VesgBOg6fiVmVO0SGcKRvtGTmBXCDDRfUwm350PfGE8NLvgnt2xxYBJrbINfBYNc2rzgjXoyoNt1GwJcOyYKtLzeGMAW6meONHHHWXzRXfFgjf/yMan5snEUoEK3dJehtlCN5KskKUVcjBxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017234; c=relaxed/simple;
	bh=jGxO6861Lmn7/Z44Z7K3Do0qeo894R19psmFZQ+OepI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBgFW6DwdtoiNg1qVFm/tKTrdYXi1FEB98h6vMFdwlO5FdPpynMcX52+d6iihvruZBEV0AYEhBd1PG2kws84ljtj5cto7tKX5zCC+/HYfdF8+nsNeqoBM9iEQBDY81Dkv9bQkwJ9aYCRIZyj3y1qgP+GomJ59H5WBvZkgXYze5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aYBb8WPx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <57443336-2098-42c9-be6d-468cdbd9b312@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748017230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqYcc7RAH3L3qXW8h+9jH0kK0v745MDC6DUdwNHLo7M=;
	b=aYBb8WPxMh1tdXa3jnwRwsd/FS5Q+vtqK13Hna190/W1z6kwQ/GTIW6Iqn97e6P/EGBDfU
	/GJ3WUyRfHkpElC6S9AB7d8ow9lfNsIyycZrc+j+xIrrA4aibhC1tgfjSUxvDdK6wxZ0iJ
	WyCi9JzSdI41Kdzbiqks1wYLnIV2wR0=
Date: Fri, 23 May 2025 12:20:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Fix Tx skb circular buffer
 occupancy check in dmaengine xmit
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
References: <20250521181608.669554-1-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250521181608.669554-1-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/21/25 14:16, Suraj Gupta wrote:
> In Dmaengine flow, driver maintains struct skbuf_dma_descriptor rings each
> element of which corresponds to a skb. In Tx datapath, compare available
> space in skb ring with number of skbs instead of skb fragments.
> Replace x * (MAX_SKB_FRAGS) in netif_txq_completed_wake() and
> netif_txq_maybe_stop() with x * (1 skb) to fix the comparison.
> 
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1b7a653c1f4e..6011d7eae0c7 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -880,7 +880,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
>  	dev_consume_skb_any(skbuf_dma->skb);
>  	netif_txq_completed_wake(txq, 1, len,
>  				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
> -				 2 * MAX_SKB_FRAGS);
> +				 2);
>  }
>  
>  /**
> @@ -914,7 +914,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>  
>  	dma_dev = lp->tx_chan->device;
>  	sg_len = skb_shinfo(skb)->nr_frags + 1;
> -	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= sg_len) {
> +	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= 1) {
>  		netif_stop_queue(ndev);
>  		if (net_ratelimit())
>  			netdev_warn(ndev, "TX ring unexpectedly full\n");
> @@ -964,7 +964,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>  	txq = skb_get_tx_queue(lp->ndev, skb);
>  	netdev_tx_sent_queue(txq, skb->len);
>  	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
> -			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
> +			     1, 2);
>  
>  	dmaengine_submit(dma_tx_desc);
>  	dma_async_issue_pending(lp->tx_chan);

Reviwed-by: Sean Anderson <sean.anderson@linux.dev>

