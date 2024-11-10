Return-Path: <netdev+bounces-143597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D19C32CB
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C0E28142C
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1C2D047;
	Sun, 10 Nov 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuJR+Jb5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F2DDD9;
	Sun, 10 Nov 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248590; cv=none; b=oQ8HSUBS/nHzffIGdB+IjLI2LrIvUS9j2zA1/iQJpvWoq3GcWbD3O0P2f9d7tu3svEB3ydWyMw+5lYTw81XiY8KfWbf0/yz9mrADvpBbBjLrWgQsuaWiGJvdRkw1NBe2y9HHuplAtgGmrTOa5jeA4Hlu3F0kW1yqpr2F292wj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248590; c=relaxed/simple;
	bh=X+lwtwOzUFGIoQmz/u8HCHbE4khCcQS/82+VHurV2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAQ3NcZ1laVlEIqcKgynOBGIaulXKGl90lA4+mj5b+NiSTI8shD4bvQ4VorHnxZ7zkfjSm0U3N6lesqqVhO7rIuqJn0lqh0qdETBdI4yuWm/GaF32c9r0l0Fmk5k3rx4PrDXxbLhx1MLCJNCYCXeh6dT0NrFMwUY1BtmXO+lqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuJR+Jb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B87C4CECD;
	Sun, 10 Nov 2024 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731248590;
	bh=X+lwtwOzUFGIoQmz/u8HCHbE4khCcQS/82+VHurV2yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuJR+Jb5gsV5jt2VeTE6lTPkYSHd+dJ5xDmbPwFrxBLFd3yol3QDO4U1yzxhCubpQ
	 4l6B+lRTgsn/w765zdpwcwPHNo1+7hHX1JRML177AVrt98oyVEVqH4YcVvtYDL+PSU
	 Mxll8jupLQKR2oLMBirdikdYOzs79+wd1h/xNsipqSPG/uIi9HNsSiA9OSGtR54Iha
	 4jIisMdfZD5m9LhGKF0l+BmoBG0SgzbKiZdRR/RePkbr1OgZMcYBplmYy2G24xjEQM
	 F29R1wboK/EPKrxDTNHo6K93MYYhxV7DicsfykA6koB6ycwDDHC5UWOTeOw6pp1fkz
	 FBfPqRnTr2LMg==
Date: Sun, 10 Nov 2024 16:23:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
Subject: Re: [net-next PATCH v9 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20241110142303.GA50588@unreal>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-2-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108045708.1205994-2-bbhushan2@marvell.com>

On Fri, Nov 08, 2024 at 10:27:01AM +0530, Bharat Bhushan wrote:
> Crypto hardware need write permission for in-place encrypt
> or decrypt operation on skb-data to support IPsec crypto
> offload. That patch uses skb_unshare to make skb data writeable
> for ipsec crypto offload and map skb fragment memory as
> device read-write.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v7->v8:
>  - spell correction (s/sdk/skb) in description
> 
> v6->v7:
>  - skb data was mapped as device writeable but it was not ensured
>    that skb is writeable. This version calls skb_unshare() to make
>    skb data writeable.
> 
>  .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 7aaf32e9aa95..49b6b091ba41 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -11,6 +11,7 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <net/ip6_checksum.h>
> +#include <net/xfrm.h>
>  
>  #include "otx2_reg.h"
>  #include "otx2_common.h"
> @@ -83,10 +84,17 @@ static unsigned int frag_num(unsigned int i)
>  static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
>  					struct sk_buff *skb, int seg, int *len)
>  {
> +	enum dma_data_direction dir = DMA_TO_DEVICE;
>  	const skb_frag_t *frag;
>  	struct page *page;
>  	int offset;
>  
> +	/* Crypto hardware need write permission for ipsec crypto offload */
> +	if (unlikely(xfrm_offload(skb))) {
> +		dir = DMA_BIDIRECTIONAL;
> +		skb = skb_unshare(skb, GFP_ATOMIC);
> +	}
> +
>  	/* First segment is always skb->data */
>  	if (!seg) {
>  		page = virt_to_page(skb->data);
> @@ -98,16 +106,22 @@ static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
>  		offset = skb_frag_off(frag);
>  		*len = skb_frag_size(frag);
>  	}
> -	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEVICE);
> +	return otx2_dma_map_page(pfvf, page, offset, *len, dir);

Did I read correctly and you perform DMA mapping on every SKB in data path?
How bad does it perform if you enable IOMMU?

Thanks

>  }
>  
>  static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
>  {
> +	enum dma_data_direction dir = DMA_TO_DEVICE;
> +	struct sk_buff *skb = NULL;
>  	int seg;
>  
> +	skb = (struct sk_buff *)sg->skb;
> +	if (unlikely(xfrm_offload(skb)))
> +		dir = DMA_BIDIRECTIONAL;
> +
>  	for (seg = 0; seg < sg->num_segs; seg++) {
>  		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
> -				    sg->size[seg], DMA_TO_DEVICE);
> +				    sg->size[seg], dir);
>  	}
>  	sg->num_segs = 0;
>  }
> -- 
> 2.34.1
> 
> 

