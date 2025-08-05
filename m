Return-Path: <netdev+bounces-211778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611EB1BAF7
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4050E18A7B8A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399C224B1F;
	Tue,  5 Aug 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVO1Gy+/"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725D221FB6
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422374; cv=none; b=MPixQoD4VgpQDypUx4/njgCpck6himcnbgCXcuuISrUqKlriRKAsPPQ5D/Cq0vjkseDBrJpMWkYMAE6uCgRl3tN5oBPsdN9l55woq+HQJiVaK1QBEqIZbzooqbL864eiRfCFV9URQgUjN0J7ro+acx2E3FrII8/BNwLLGIK8tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422374; c=relaxed/simple;
	bh=f5YTjW9VECJW0G23VM5eCIi2OhPiZ2wKeAH97xCkiHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kURavsy185SUyoklZyCoOAPob6b82jDxdRygAnN4DigyjcE2H8La/RWjvl+kcCS3gEDn0n3myNjZIv8UNKBfKGlXhFPR1o5THmIFHxsHj2Q+iKRVl3Sapps+X2bI3r5EzOd2dFUTTruVjZFuQTVLIiLV9Pa/re0sfzQWze10Z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVO1Gy+/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08bd431d-c887-4f69-9c1e-4b40a301ecf7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754422369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYUMZ7E+6vJC5FpLL2HyF+nE/45hsY2ZWy2Xc7WZ050=;
	b=rVO1Gy+/hQM6eI5atg/ciXvbT7rpZLZEeM39lIPN0WohD6C7XJ489W4czPj/rOnkMi04OR
	DVNGL/YRdy1/OxMAAdbHeP1fk73KWF7aLMPbsaYZqcmIkJz2fJ7rlmhuYE0mnch2kEv9Yg
	1J2TJBm7uGAVcGLOyj6bpl7t1riDkqc=
Date: Tue, 5 Aug 2025 15:32:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250805191958.412220-1-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 15:19, Suraj Gupta wrote:
> In DMAengine flow, AXI DMA driver invokes callback before freeing BD in
> irq handling path.
> In Rx callback (axienet_dma_rx_cb()), axienet driver tries to allocate
> new BD after processing skb.
> This will be problematic if both AXI-DMA and AXI ethernet have same
> BD count as all Rx BDs will be allocated initially and it won't be
> able to allocate new one after Rx irq. Incrementing head pointer w/o
> checking for BD allocation will result in garbage values in skb BD and
> cause the below kernel crash:
> 
> Unable to handle kernel paging request at virtual address fffffffffffffffa
> <snip>
> Internal error: Oops: 0000000096000006 [#1]  SMP
> pc : axienet_dma_rx_cb+0x78/0x150
> lr : axienet_dma_rx_cb+0x78/0x150
>  Call trace:
>   axienet_dma_rx_cb+0x78/0x150 (P)
>   xilinx_dma_do_tasklet+0xdc/0x290
>   tasklet_action_common+0x12c/0x178
>   tasklet_action+0x30/0x3c
>   handle_softirqs+0xf8/0x230
> <snip>
> 
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 6011d7eae0c7..acd5be60afec 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1457,7 +1457,6 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
>  	if (!skbuf_dma)
>  		return;
>  
> -	lp->rx_ring_head++;
>  	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
>  	if (!skb)
>  		return;
> @@ -1482,6 +1481,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
>  	skbuf_dma->desc = dma_rx_desc;
>  	dma_rx_desc->callback_param = lp;
>  	dma_rx_desc->callback_result = axienet_dma_rx_cb;
> +	lp->rx_ring_head++;
>  	dmaengine_submit(dma_rx_desc);
>  
>  	return;

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

