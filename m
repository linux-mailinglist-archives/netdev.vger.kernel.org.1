Return-Path: <netdev+bounces-126306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A574A97098F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE700B21382
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D7176227;
	Sun,  8 Sep 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgvMWb99"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B438DDB
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824444; cv=none; b=b6yYuIj+ynqpd86gQHUyyt9ChFnRHUNWB5Ellyl7bllwF28YQxm18kQl9ewAqszIies+ODu5y88EojHa6papaFr2qvdRKX/rALcfzYHiVr1wSXnrGdyuMyQvxN1braVPWNafEA2veo9Icxgh2imzGOG9TvByc/HVXeJb1TWLGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824444; c=relaxed/simple;
	bh=U+nN3E1s6vUZvmNioTaYSXQCx1nQu47fLqE9xX6Xutg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPc9n4Tzu70IuwcM2g64KQ3oj1tRanmCWHiZve/iZkn0hKZa/c0zu2MvFW4v2kYW7g3Z6w/7SXtunYTE9kN4WbaHxnXeOsQolEg3F+nvQ1ip/tFYQjTQSOdwwV7D8oy87CLOQHmHTjaLlgZTJJwsN4wM7VGq8nx3QeQ0tOFID2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgvMWb99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725824442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xH+iRr4Jv3/HG+2A0joozYOEglclsfOIN30PzjLMvdI=;
	b=GgvMWb992+FcDEzVu1tEaBPqum/5WCpvxmbLKm1YiMcbMXd2b68JBy2dUpcT46gZMg6zQP
	QP+Y0sI0BN6zXDVaH9TTh5VbU75s6INEhGGUqrfbcPvqo4azUAKZu63BB8OMy3MXKBQnqn
	ZCCtSDcCG0mEK0TXYBL3BaPi0shTWJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-aZozZIUUNYiURefAK1hqwg-1; Sun, 08 Sep 2024 15:40:40 -0400
X-MC-Unique: aZozZIUUNYiURefAK1hqwg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so4453735e9.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725824439; x=1726429239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH+iRr4Jv3/HG+2A0joozYOEglclsfOIN30PzjLMvdI=;
        b=DdpB+kRDwbhN2a2MCk8y0SJ1G/njFkpGZMq7xd4nTfEYwXcF44a8GKYTCEBH0eTI7j
         G6QIUqT1VbUCes3RBP5MYtU382CDdduCRrEINwUR4VJoItf50KVGU3Web+7tGImzLDMF
         JAR6YUKdgNNv1/SkIF8q3Mw7ql8kQ2i/Z3eQ1ZU+QxjNXXjHvtDBQ10fEj+hcRI3cJD7
         7Tk//7OQK/lJVyLzVagvyAm+Z3TvWQ9DXanKKviIExBmTVR4hr0OPx4x3MI4jO74NRaE
         C61D/nQ71o7KTPfS9864sW6vihKurDSXY213xE0V3d6TGccBAX2YWpx/gy25HOdIpETy
         7Hgg==
X-Gm-Message-State: AOJu0Yz/kOaUYMw6oZZqE2O8Z4Hj9Tw+pWqL39qE/DpMdYhupvEPBv94
	mEB+Hh+Re75cKg+2zAwnPrrb5sLFpdiPOA0m8gZuUnF+HBw5tx9udJ91ev8t12oxIMCuumW1SI0
	7BRZHv8f9bHkeC0Tvgxa3oNw4RJZPWsRjKByG/nnMolF3nFUOd9OpkQ==
X-Received: by 2002:a05:600c:1d15:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42c95a5f971mr93118875e9.0.1725824439552;
        Sun, 08 Sep 2024 12:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHOz7cQatdno19/cbSkBNtm4eTHBagKro7YBoMXi0+DetATEzfS2VZvuZtLxKjiCr8GSSkGg==
X-Received: by 2002:a05:600c:1d15:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42c95a5f971mr93118765e9.0.1725824438134;
        Sun, 08 Sep 2024 12:40:38 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c2845sm85328365e9.3.2024.09.08.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:40:37 -0700 (PDT)
Date: Sun, 8 Sep 2024 15:40:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240908153930-mutt-send-email-mst@kernel.org>
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
> 
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


BTW why isn't it needed if we revert f9dac92ba908?

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


