Return-Path: <netdev+bounces-120320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC5958F0E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A99D2846AA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D81B8E8A;
	Tue, 20 Aug 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE1LAn9e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724F1B86FC
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184725; cv=none; b=OU3/UJ06uJcwNtl4W4P412uajg30anCMqVDkh9rdY/dMZ8sofS/OYGQQuraIAvMRxaQ339tcP0fw0GOCy6njBQ/yAEeOu055IsgxxzoaiqH5egtb+ATo9e2K3tvpJaaq26GRxDRfh8iAHooDmqp0eZfsdRU5ot3Oh+S2Cc9AjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184725; c=relaxed/simple;
	bh=Qdb48a2spoj1Z2CL+Rgu8TqheK3+EqdNCApffkuRdoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvNT7I6e11k7b+7XYTB86nSkOZFx1uz+LVE5XcGm/ZgvAENvrI843EY73CfLVproeWzaaVS1H9eLx1sJbGbnR3hGtbEZtpjP/OvOuZ1MlzTTBKX+B+dFJZcLer5NGZTca+arjZaIn4KZiq8Gh1SdgfjzQOMuElt2tdtZH3kFLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KE1LAn9e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724184722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68TuSUMbg5Dtwr1fZHwgjM6dvF8jw7J+Ngw4TY1BJGE=;
	b=KE1LAn9e2lDAVXdpFHyo0LNZ5W4extwJ5q0lK5V1Ag53DVpbYJw2v9dbhbrqzsD/j5GHNY
	Qw665oj4EEm5P/dk5nVAjnC+BF5lTOn78jRwk4LaYA4BkT/1UY6dWz8KA6MqeUUebnEuPm
	6sYGqa2qSfQqu/Rey7KcpLrydlpNulk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-lQ5RjRHxNh-6whXfuqZCBg-1; Tue, 20 Aug 2024 16:11:58 -0400
X-MC-Unique: lQ5RjRHxNh-6whXfuqZCBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37189fc2977so3154797f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184717; x=1724789517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68TuSUMbg5Dtwr1fZHwgjM6dvF8jw7J+Ngw4TY1BJGE=;
        b=jV47MK2qPWG7b5nnI5L+4AgL0RgWUKS/e+qUg9fVM/qHblcCqlNtmU2AJyV5TxspnA
         zylEt3MfpLkJjIJ6zR0LH1fwwd9qCgUjEOYfOhQrCLKJtSh1L16h2EJSWdU0UQa8qsjs
         bUfuQF0aI+/yaYwhwGWuXZE7QGx2EuJYLQyfkXwdnEWuprbbZL7Xs8Nmmpd5nrBYhGui
         gE5kwuMkbJjhuDp8Q5tgNXoTLXfscwXK/IRZijdDi6XtlCLuPKaBeSMzxFvCWxQ/1iUs
         ugHtb8tGLGUXJDbZQjmafFJduJ3WqUXRaJShDOHaik+T0eWVWxR0plCwulSiQESjEnJG
         gkJQ==
X-Gm-Message-State: AOJu0YzD8LM9yhID3l0ghDiZdGryqcATqOIS/l0cBuhWRtjLkost/ozC
	B9I1D6+aDUMex44Zu7Osva9cZAXm340JkQ/oWjXr2ROYmMaLpk5xf8D6yWUzio1llDBfwyteZFi
	rn5nXpuTfd0K3XEGbASlNhmURWrar9P55bqkFbBGgIxXAe/XGMkieeg==
X-Received: by 2002:a5d:6a4a:0:b0:36b:aa9d:785c with SMTP id ffacd0b85a97d-372fd73101dmr62290f8f.52.1724184717396;
        Tue, 20 Aug 2024 13:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrTnPNJF+mrNURdrMjwXWN0UKounUGVPZsd/QtxDOJIR5LFamNYfLw6y/JpG/4uzIXVf0sQ==
X-Received: by 2002:a5d:6a4a:0:b0:36b:aa9d:785c with SMTP id ffacd0b85a97d-372fd73101dmr62270f8f.52.1724184716513;
        Tue, 20 Aug 2024 13:11:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984967dsm13918330f8f.34.2024.08.20.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:11:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:11:52 -0400
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
Message-ID: <20240820160920-mutt-send-email-mst@kernel.org>
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

From API POV, I don't like it that virtnet_rq_alloc relies on
the caller to invoke skb_page_frag_refill.
It's better to pass in the length to refill.

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


