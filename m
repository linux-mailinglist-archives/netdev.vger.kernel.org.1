Return-Path: <netdev+bounces-120284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE995958C99
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9141C20E9B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542A19DF85;
	Tue, 20 Aug 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLqIjVaD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07C7E59A
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172651; cv=none; b=FA5CfOvKWHczaLdw6K8GpLXUku6ru7izGuA0j1XbZQuj9Yv5zp1WftCl9enm3tw5ESVQOThA0f1hceomKKeHbe4w4QkTY0PXh9MoO9lkk853oZW52L0AiT6MMWvpHePqFvJJwe42FvSyjXxlzl9J7U1rc0ZaB71uyj4IDtSvdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172651; c=relaxed/simple;
	bh=iRRJm5hnANTCCbMz3TFjJ+p/itYxSWlkd70jymZn400=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTJuFbeTZJCbsOsVGwXJm6ZX/dbNK6AtM92/JnWYqwSO6ltffCx5HgJ5m1vIBWGN0mZzjJ8OOht+6D6+Cc0VNIZJ9B6sxepf+l9tdcTcOklMwtQS/rBBisovrXH0rvrbga8aRCLIIaRQ+E99WAnOkxF9agC6ApeNgkh2ZAs4+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLqIjVaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724172648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSrnuWgvFayGHBrJKp41lIH2eBIptiQndAvaubL6bOo=;
	b=FLqIjVaDsXDasOc4Jo+nTgGeQwlAT3xPhT21W8X5QdyseRmB49nqSO0XihITkmW1dhjJk8
	80TbO64gMegDbaBL8l6KegkWQo67M5atsMScvb6KrKFF6mR2eRj9S7FZkGwraH+eyiJtqb
	zWiBtp3RKLoL1M2sY7OlI5HcKud0Z1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-vXkSDCvyPaGzaVRH2Stk_A-1; Tue, 20 Aug 2024 12:50:47 -0400
X-MC-Unique: vXkSDCvyPaGzaVRH2Stk_A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429097df54bso46209475e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724172646; x=1724777446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSrnuWgvFayGHBrJKp41lIH2eBIptiQndAvaubL6bOo=;
        b=VVoLGgsIUo9C8Z9fylQXHX9d1F8EqgDIxGlngrJMXSKNtbFlXXDNXHaU/2dvyV8+7J
         0xxDFl25efYWh93nkl65EYwuLUToxBbXG5HhYMv5HtvYe3IhzS/HUojM5vbqRkVZe+PD
         YDKt8G9E4Jky/T8o0AA2qN6Dpyzcx8Q1SMNpJxPoN7tUzU7jwFNbzHS/9Zh4kfNGZhqu
         PIibThjQWVIwiNaDmbx4xEe9lHZePBivWKpDsL+NPlz//jnzMkI5mTmS7HMZg2nxIyCm
         jTQCwIrfNya4ToF+X0dorxZxCLdXCF1eLYuJSOF+8fMEJJXbfxs8QV+1f/FmULcqCTpC
         KE+A==
X-Gm-Message-State: AOJu0YyFf3C2Q386LsqV+/4XV72VwAfDkIzCueG4fkW2T9dH4sET7TIB
	F9c+P3Y5GpzXoCh29ivgHicqgnvmi0HkYDUNzDkMql8gar38gf7741w6wHOdgyeDID8F/OjPEcT
	90oDpO+QycpRTEEua5JkwNdQaxOsON/KC4B118CSJVEqTiz7xOKuAYg+psWqD8g==
X-Received: by 2002:a05:600c:3b83:b0:426:6688:2421 with SMTP id 5b1f17b1804b1-429ed7ba99dmr92131615e9.11.1724172645777;
        Tue, 20 Aug 2024 09:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVSre1isLav46+Pl58gyrfdKG0OOq/aM+82s+Wgpt/eMCCTkpP6nwYmfBfXDXr6SqR1mHPDw==
X-Received: by 2002:a05:600c:3b83:b0:426:6688:2421 with SMTP id 5b1f17b1804b1-429ed7ba99dmr92131395e9.11.1724172644905;
        Tue, 20 Aug 2024 09:50:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:61f9:60b2:d178:7b81:4387])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded180e7sm201783445e9.3.2024.08.20.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:50:44 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:50:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240820125006-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>

On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> leads to regression on VM with the sysctl value of:
> 
> - net.core.high_order_alloc_disable=1




> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> the first buffer of the frag is affected.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Darren, could you pls test and confirm?

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  	void *buf, *head;
>  	dma_addr_t addr;
>  
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>  	head = page_address(alloc_frag->page);
>  
>  	dma = head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;
> +
>  	buf = virtnet_rq_alloc(rq, len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +		return -ENOMEM;
> +
> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> +		len -= sizeof(struct virtnet_rq_dma);
> +
>  	buf = virtnet_rq_alloc(rq, len + room, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> -- 
> 2.32.0.3.g01195cf9f


