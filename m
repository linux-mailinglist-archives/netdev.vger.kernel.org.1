Return-Path: <netdev+bounces-117768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D920494F1D0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C4D1C22147
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45F183CD4;
	Mon, 12 Aug 2024 15:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6B13C914;
	Mon, 12 Aug 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476782; cv=none; b=qemTIHBlsfsI+dqlVNiH/g0wqam+wAQJW017Aj8RwEFRn1HNMfrWkBmoTAsU9RUONMe2A7H1+yZHCOKnswYwOGc2Ql1sPppv1fF1YC+BhtDlCRR4e9j7i4GslH0dnM9YWzOteqTILnCYToHLDTgVmKIt8aG4wCsBxJwvmCSXY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476782; c=relaxed/simple;
	bh=BLbvn/87ILWYbaroE4COxSEQRPzgNX2bwMAS2wUomUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNJPL2+wPzO6JIHKILXkdbJu0mtWEkrpjBB+G4UtQSMhcbRvORln5fjaBVA9rjxHTjYAhQ/KtLuiBF7yIocxmiUBelbJrEf4AV24+RCldL28YWeALwIKu7BXqn6zW87U4JBc25bARzALjJ/QYFNKaEHy/hK28LAaf/ck/Xxoz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sdX2I-000000000SJ-1aqJ;
	Mon, 12 Aug 2024 15:32:42 +0000
Date: Mon, 12 Aug 2024 16:32:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in
 LRO rings release
Message-ID: <ZrorEoWOoe8inWcx@makrotopia.org>
References: <20240812152126.14598-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812152126.14598-1-eladwf@gmail.com>

On Mon, Aug 12, 2024 at 06:21:19PM +0300, Elad Yifee wrote:
> For LRO we allocate more than one page, yet 'skb_free_frag' is used
> to free the buffer, which only frees a single page.
> Fix it by using 'free_pages' instead.
> 
> Fixes: 2f2c0d2919a1 ("net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag")
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> ---
> v2: fixed compilation warnings
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 16ca427cf4c3..e25b552d70f7 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1762,8 +1762,10 @@ static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
>  	if (ring->page_pool)
>  		page_pool_put_full_page(ring->page_pool,
>  					virt_to_head_page(data), napi);
> -	else
> +	else if (ring->frag_size <= PAGE_SIZE)
>  		skb_free_frag(data);
> +	else
> +		free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
You miss on open '(' there. Won't even compile like that.
Please always compile- and run-time test patches before sending them
to the mailing list.

>  }
>  
>  static int mtk_xdp_frame_map(struct mtk_eth *eth, struct net_device *dev,
> @@ -2132,7 +2134,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				ring->buf_size, DMA_FROM_DEVICE);
>  			if (unlikely(dma_mapping_error(eth->dma_dev,
>  						       dma_addr))) {
> -				skb_free_frag(new_data);
> +				mtk_rx_put_buff(ring, new_data, true);
>  				netdev->stats.rx_dropped++;
>  				goto release_desc;
>  			}
> @@ -2146,7 +2148,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			skb = build_skb(data, ring->frag_size);
>  			if (unlikely(!skb)) {
>  				netdev->stats.rx_dropped++;
> -				skb_free_frag(data);
> +				mtk_rx_put_buff(ring, data, true);
>  				goto skip_rx;
>  			}
>  
> @@ -2691,7 +2693,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  				ring->buf_size, DMA_FROM_DEVICE);
>  			if (unlikely(dma_mapping_error(eth->dma_dev,
>  						       dma_addr))) {
> -				skb_free_frag(data);
> +				mtk_rx_put_buff(ring, data, false);
>  				return -ENOMEM;
>  			}
>  		}
> -- 
> 2.45.2
> 

