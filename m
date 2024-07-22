Return-Path: <netdev+bounces-112452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255BB939268
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AFF1F221F1
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7F16E892;
	Mon, 22 Jul 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hq5VLwpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044116C6B5
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665057; cv=none; b=ombicmDJNp1op1gS3Dje6w+JTtW4vkoojgIX/+ECRgFS6h/ZK5uh6ubhVv19z3Z2Ykkcm5h4GJ3gG3cmS/hR6lvo7516l6PAgR5ASwqslcC7bpKB/XdriEJ4BF8PrZykE1ciUS1qRkKyAOvzjtB8EuzokyXAo4xlVRQizQRNZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665057; c=relaxed/simple;
	bh=r+a3M5u9pOMv/hVClE5hBqlyEDdBMEAW8unLWpcUwR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm4iGxnHgxTwhC4DzoGA7JkzdBSa+fvevE4GoK+uQcq3sQIE3+qBAkQBYOCACU5qCD2ToTSrETK9WUI58flqAx19HdYvE322xM10LZkSzwAnWlF6t2Zvdw9L9SRByyJ1SIANH2RD6Kg2gpTY5MnOuJl+/IcpSes4RF+v2CMDo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hq5VLwpm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc66fc35f2so28946105ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721665055; x=1722269855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac4TBOhO4Lvkf/O2AokVMuwcwMPMmOE7Ro7pJm1rvQk=;
        b=Hq5VLwpmREuwnMRPZQ+yCIBn2K2nMg/eykIi9J4qjoyMqf2IgM2qb7gSTVeI7aedH8
         EEgMn7vBvRZMllGUGzkqfKMIr5tnt2h1HYgLNcd9yz7KaihmfKdoyjIBOuQf2QejlRqM
         FkcIssgy/2ca0lpYScwZIUPghAoTQX7SRnMh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665055; x=1722269855;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4TBOhO4Lvkf/O2AokVMuwcwMPMmOE7Ro7pJm1rvQk=;
        b=ueiekGLUvnUa6pDcOyUyqoHqI1jRQhzEcs32Q69FMF+40b1VGEYI07TJjZfNzi6u9X
         vxZNtbIGprRkoo1b0S5QLbj2IatButW+pQAs9BUnfRSV/mS4PXeYJwscjnpnoyqN2IeT
         XV/18HZKZzlCm6XrhXuJLKEb4GOfhQSc/TE7hE/aa1thdo2Empqj1IPzP42baiz6744b
         m30/9q0NzdXvsmKDdFHep5fa8QJ89TDl5ImMDje34CPCHlWol5AI7hc2/VXKb0Xy1F2c
         fCCZhMyNAZ7u/N90rK0D+lmiGf+SXCa+pEbkajbKB1A8z+yx+4inYiIPFqOQKN+C9A8l
         51vA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zOxC7E9OHcLaXWaZ6iGBrEX5uOsRzeDfYeY05C8B1fEqYARAVSnoA62vrKH44Bn+wgRlUvJLG805V7xQ8gs1TmKNtzcS
X-Gm-Message-State: AOJu0Ywiy8kDI1YRYyFdc0Ha0PqaKEDVa+BZTasMOIZ4Lp6BvICgc3UQ
	JsDu02Xa/vIePMw+ThRMScKY+7cl4+f71eXp29ol2Fc3/roWsW0j8/PG/0TcSJw=
X-Google-Smtp-Source: AGHT+IFB2y7zOFl4+Y01VeT43wEsBkhPo0FQ49eT3GIcwc/I7mB7L8n/Y/dKG9HTsZ7eJjeY9OWniQ==
X-Received: by 2002:a17:902:cec4:b0:1fd:b5fe:ee91 with SMTP id d9443c01a7336-1fdb5fef138mr3886125ad.25.1721665054849;
        Mon, 22 Jul 2024 09:17:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1dbfe395sm2640504b3a.218.2024.07.22.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:17:34 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:17:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Elad Yifee <eladwf@gmail.com>, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
References: <20240720164621.1983-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720164621.1983-1-eladwf@gmail.com>

On Sat, Jul 20, 2024 at 07:46:18PM +0300, Elad Yifee wrote:
> Utilize kernel prefetch methods for faster cache line access.
> This change boosts driver performance,
> allowing the CPU to handle about 5% more packets/sec.

Nit: It'd be great to see before/after numbers and/or an explanation of
how you measured this in the commit message.

> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 0cc2dd85652f..1a0704166103 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1963,6 +1963,7 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mtk_rx_ring *ring,
>  	if (!prog)
>  		goto out;
>  
> +	prefetchw(xdp->data_hard_start);

Is there any reason to mix net_prefetch (as you have below) with
prefetch and prefetchw ?

IMHO: you should consider using net_prefetch and net_prefetchw
everywhere instead of using both in your code.

>  	act = bpf_prog_run_xdp(prog, xdp);
>  	switch (act) {
>  	case XDP_PASS:
> @@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
>  		rxd = ring->dma + idx * eth->soc->rx.desc_size;
>  		data = ring->data[idx];
> -
> +		prefetch(rxd);

Maybe net_prefetch instead, as mentioned above?

>  		if (!mtk_rx_get_desc(eth, &trxd, rxd))
>  			break;
>  
> @@ -2105,6 +2106,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			if (ret != XDP_PASS)
>  				goto skip_rx;
>  
> +			net_prefetch(xdp.data_meta);
>  			skb = build_skb(data, PAGE_SIZE);
>  			if (unlikely(!skb)) {
>  				page_pool_put_full_page(ring->page_pool,
> @@ -2113,6 +2115,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto skip_rx;
>  			}
>  
> +			prefetchw(skb->data);

Maybe net_prefetchw instead, as mentioned above?

>  			skb_reserve(skb, xdp.data - xdp.data_hard_start);
>  			skb_put(skb, xdp.data_end - xdp.data);
>  			skb_mark_for_recycle(skb);
> @@ -2143,6 +2146,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  
> +			net_prefetch(data);
>  			skb = build_skb(data, ring->frag_size);
>  			if (unlikely(!skb)) {
>  				netdev->stats.rx_dropped++;
> @@ -2150,6 +2154,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto skip_rx;
>  			}
>  
> +			prefetchw(skb->data);

Maybe net_prefetchw instead, as mentioned above?

