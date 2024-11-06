Return-Path: <netdev+bounces-142243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30189BDF81
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FED2851F1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434B1CCEE6;
	Wed,  6 Nov 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3pD076H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12901CF2A5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878658; cv=none; b=hklqpoUK1KRVLZNlArISaOHy5TcVhuq4mIW97sFwg2uxiSP8IOWyFn9D4+KOotfG6Z/DJRJ69G0mirgifhRfeXGLHfeuEf6xJ3y6+GiQILDMwbGTrrbntUUagNlg8jdhsGca0ysifo3fP80M690Ic3kMPEUh6QJg5IkEdoU/jN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878658; c=relaxed/simple;
	bh=+CtSBqOOwTGniuZBGFfMv5NkBJPfqlQQudSVQJ8OF1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjA7gy0mXDzFN/8oQMV+TMik1gQTBP6rOhQakDBhSC6i0XUvDET8ow6oP/1jDFpGIqDYGnZ1rrfEw5ZLfhHpq2UsCNMPMVhEKqcC94+mz+ECBr9irdO+nhSxw16tVr5565fDzG55BtP3iw6yErHclqIuYaaFoPVQsv9wbphPc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3pD076H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3b9DjNcKsvHggFiK5mPA65X9tuneBxWXZg7PBVA6jZ0=;
	b=d3pD076H6w687dg91cEU9QJMSnzQ/XGdNGN/uzy3IW0CMcaW2LEX51l9zc8gzEX4+Ajeqe
	vwfBtaBWPFZG8fIeAztMAtmNIKiZb/VTTm27bE21c9W9UrWPGJuWMnfzBC/IenP+RvLBUB
	0VfkNrKW386OB10XzwzlCXeDp+4SaS0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Arv-ypi_MwycA8rdcCyOQQ-1; Wed, 06 Nov 2024 02:37:32 -0500
X-MC-Unique: Arv-ypi_MwycA8rdcCyOQQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539e4cd976dso3951414e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878651; x=1731483451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b9DjNcKsvHggFiK5mPA65X9tuneBxWXZg7PBVA6jZ0=;
        b=oY0XeKtsM0QHZ5jVceDM3O980PaEnZsPwGwhWTdCECWr31+6kIkajxETREXbUZ60v+
         NkjFIXWx6eiMDB6j/68X0thdMq2+gcmH4cQkKFrnlGZl662Sto4AJXjpsc4jSZ1Ua+Vo
         vTBJ0XpwDU38ZHpM1YXbh+L7y5HErUWhC/Ag/WXpXAD4524dPuiGqm6OYUoG/RYidqRP
         nXVCAetH0vDs1LPtKMZRoUDlrP9jzligvbMkqRqeiJFm9v9bzfN7O5fU+cQ9EV4vgGb/
         nQkXuVo44IxJV0nzBPfz49IuXnDfTIh0esFyn4wOjiBduWOto8R4+MSx2rt+37Y4fIxR
         7y3w==
X-Gm-Message-State: AOJu0YxOIiI7NVmHs7uJmD4OjKdryVjsfYfHEFeYjFJJBldf8yDu+kQ6
	Wj4GRdZOqW9B6/07TBzqTJdh7xf8WKxQynrA9n7k28ZNRCQQKgVUnRc2azS5scMEpsMiuc/FGgY
	ZWC611kDXH1Z4xyCEGw52rGVK/T8WKm/5TXu+3J7qJ5n30/b3WBsD2w==
X-Received: by 2002:a05:6512:3e1a:b0:539:ff5a:7ea5 with SMTP id 2adb3069b0e04-53b7ecdea88mr14128867e87.15.1730878650729;
        Tue, 05 Nov 2024 23:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwCBjxiu1G/SKVTKOlKOM1yVJqE1E31OlP/gMIsuEKkuBQuCgqbk1xFr6rvbgFnjhDdmMD3g==
X-Received: by 2002:a05:6512:3e1a:b0:539:ff5a:7ea5 with SMTP id 2adb3069b0e04-53b7ecdea88mr14128840e87.15.1730878650209;
        Tue, 05 Nov 2024 23:37:30 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b7fsm12425795e9.4.2024.11.05.23.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:37:29 -0800 (PST)
Date: Wed, 6 Nov 2024 02:37:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net-next v1 1/4] virtio-net: fix overflow inside
 virtnet_rq_alloc
Message-ID: <20241106023609-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>

On Tue, Oct 29, 2024 at 04:46:12PM +0800, Xuan Zhuo wrote:
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
> 
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM).
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
> 
> The commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever
> use_dma_api") introduced this problem. And we reverted some commits to
> fix this in last linux version. Now we try to enable it and fix this
> bug directly.
> 
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
> 
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


This one belongs in net I feel. However, patches 2 and on
depend on it not to cause regressions. So I suggest merging it
on both branches, git will figure out the conflict I think.


> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 792e9eadbfc3..d50c1940eb23 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  	void *buf, *head;
>  	dma_addr_t addr;
>  
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>  	head = page_address(alloc_frag->page);
>  
>  	if (rq->do_dma) {
> @@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;
> +
>  	buf = virtnet_rq_alloc(rq, len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> @@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
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


