Return-Path: <netdev+bounces-125875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768E96F119
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D691C211FD
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE01C9DCB;
	Fri,  6 Sep 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwbw/oJc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341913CFB6
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617573; cv=none; b=NOnSHXlsaK4fzUWZmehVXSSdDjERssTNMmpb6rcmTbfzfFc7iksvHp2wCmH0wdDqFTKS//Xf4GuSUCQzVJTxW7rqP5ObUn1f8pMU0s1rYZbwUgabFhADkWlcuD9H3zLBtQCR55pNKFNoDcldtEe/Tb6MkgH6QiSiFg37mx1PeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617573; c=relaxed/simple;
	bh=Q9TXSvDsVrJJkjBOgWLMxDjKglYwFps2Xb2s+cWc8UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbCQ/o5T+P0rim9kdkk6mPV0MxgDwqPUZFM1YC2zaCvZE1Nq+MVLo7j8IKIDk2M4K34hyzyFSkK3mDwPAIMNARzAr/ki3CGeKQnZI/vunXI5heAEpOIk++U4Z++egMsEWis1Jx4GwDdEFiNrefEgEEVMy6JhR1McFCj5jrlqbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jwbw/oJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725617570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHoMcpM/TTdua1Refqr6XchkQxlkBGAth1WdrFW7wCs=;
	b=Jwbw/oJcPaLzZ/Ty2pESd+mwxnlyUiBlHnJCL/Vm0vqUZcaMVkrO8bFsjneq7oE57VJoQi
	ETgtlL/YQk5I4nxVkbTR9JOpQFAp7rPky4/28fquCCBYZgCjLgNNg1lYgrge4U8IpAig3n
	SPDemFtJrQQDIMy3ZrSjMi23bGJCp7o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-WKGNLBUhMkCKCawJ492xMw-1; Fri, 06 Sep 2024 06:12:49 -0400
X-MC-Unique: WKGNLBUhMkCKCawJ492xMw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c7bc97425so9834765e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 03:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617568; x=1726222368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHoMcpM/TTdua1Refqr6XchkQxlkBGAth1WdrFW7wCs=;
        b=Jm3+bGYb7AN08OLEHkjzftut/t5GCLp/q2EmpdQ2z7gjG1r7cDwNcXrwWB4k30NNxA
         WoCRcjcnIidK8/cMfR/0++xqPABgihrYgbtZ1BPKsGGaMYnH5qwxW7TjghnCSrXmlp6t
         l1l5sw0QLgPDN7brGvTgyDQPnnzdm508tvyjC6zxo0HhciCiRu56jkMWfpzBTa3u1Pyo
         GcNRmJ6OCr50+CI7IwZWR8l1/KLSYed+sX511KHjF4hcuctRCnTLCzlD/o0z5b64n6a3
         u8CMei9dGfnIiNjAGbpAZJZm32B8tjaN70bEadHcEWh5xQCZ9wlZf4j+gPhqdIbEHpcl
         m6pg==
X-Forwarded-Encrypted: i=1; AJvYcCVeXrFmno/LvjJ14OaTi7LDNmQ4IMn1D1vjnBpJi+7cxOQDmJ9KXpK1F4BXyhJsZin9FKTag10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7v5skDAVKWAkO18kBFc1J2NcpktRFsjCNKrhEy0SjAw4L9pi+
	x0vsnCAYwN7by4L3x4z7E2hyVdUqukrbwPYPCJU+jIlS85E/jZprPluhnhT8WJRXJ9BbaGiE1a4
	xbaEpn6/uCV3cKQKeX0KJ0aB5fMLHtwQlPNpy98zKjkN5urmnFqJMhw==
X-Received: by 2002:a05:600c:4f53:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42c95af7f2fmr53544585e9.6.1725617568308;
        Fri, 06 Sep 2024 03:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMfGZxhbaSheOh3dZIC/k+Wm9PeRBDxUi0/bTiDhPKgwP4ARFmRyEdrGyTRIlflMDP6BaG0A==
X-Received: by 2002:a05:600c:4f53:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42c95af7f2fmr53544195e9.6.1725617567652;
        Fri, 06 Sep 2024 03:12:47 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccaa4sm15146275e9.14.2024.09.06.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:12:47 -0700 (PDT)
Date: Fri, 6 Sep 2024 06:12:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] Revert "virtio_net: rx remove premapped
 failover code"
Message-ID: <20240906061055-mutt-send-email-mst@kernel.org>
References: <cover.1725616135.git.mst@redhat.com>
 <69d3032b6560323844d6d9fb0ac4f832ed87f13d.1725616135.git.mst@redhat.com>
 <1725616970.1687496-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725616970.1687496-2-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 06:02:50PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 05:52:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.
> >
> > leads to crashes with no ACCESS_PLATFORM when
> > sysctl net.core.high_order_alloc_disable=1
> >
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
> >  1 file changed, 52 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0944430dfb1f..0a2ec9570521 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -348,6 +348,9 @@ struct receive_queue {
> >
> >  	/* Record the last dma info to free after new pages is allocated. */
> >  	struct virtnet_rq_dma *last_dma;
> > +
> > +	/* Do dma by self */
> > +	bool do_dma;
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for indirection table and keysize
> > @@ -867,7 +870,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >  	void *buf;
> >
> >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > -	if (buf)
> > +	if (buf && rq->do_dma)
> >  		virtnet_rq_unmap(rq, buf, *len);
> >
> >  	return buf;
> > @@ -880,6 +883,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> >  	u32 offset;
> >  	void *head;
> >
> > +	if (!rq->do_dma) {
> > +		sg_init_one(rq->sg, buf, len);
> > +		return;
> > +	}
> > +
> >  	head = page_address(rq->alloc_frag.page);
> >
> >  	offset = buf - head;
> > @@ -905,42 +913,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >
> >  	head = page_address(alloc_frag->page);
> >
> > -	dma = head;
> > +	if (rq->do_dma) {
> > +		dma = head;
> >
> > -	/* new pages */
> > -	if (!alloc_frag->offset) {
> > -		if (rq->last_dma) {
> > -			/* Now, the new page is allocated, the last dma
> > -			 * will not be used. So the dma can be unmapped
> > -			 * if the ref is 0.
> > +		/* new pages */
> > +		if (!alloc_frag->offset) {
> > +			if (rq->last_dma) {
> > +				/* Now, the new page is allocated, the last dma
> > +				 * will not be used. So the dma can be unmapped
> > +				 * if the ref is 0.
> > +				 */
> > +				virtnet_rq_unmap(rq, rq->last_dma, 0);
> > +				rq->last_dma = NULL;
> > +			}
> > +
> > +			dma->len = alloc_frag->size - sizeof(*dma);
> > +
> > +			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > +							      dma->len, DMA_FROM_DEVICE, 0);
> > +			if (virtqueue_dma_mapping_error(rq->vq, addr))
> > +				return NULL;
> > +
> > +			dma->addr = addr;
> > +			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > +
> > +			/* Add a reference to dma to prevent the entire dma from
> > +			 * being released during error handling. This reference
> > +			 * will be freed after the pages are no longer used.
> >  			 */
> > -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> > -			rq->last_dma = NULL;
> > +			get_page(alloc_frag->page);
> > +			dma->ref = 1;
> > +			alloc_frag->offset = sizeof(*dma);
> > +
> > +			rq->last_dma = dma;
> >  		}
> >
> > -		dma->len = alloc_frag->size - sizeof(*dma);
> > -
> > -		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > -						      dma->len, DMA_FROM_DEVICE, 0);
> > -		if (virtqueue_dma_mapping_error(rq->vq, addr))
> > -			return NULL;
> > -
> > -		dma->addr = addr;
> > -		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > -
> > -		/* Add a reference to dma to prevent the entire dma from
> > -		 * being released during error handling. This reference
> > -		 * will be freed after the pages are no longer used.
> > -		 */
> > -		get_page(alloc_frag->page);
> > -		dma->ref = 1;
> > -		alloc_frag->offset = sizeof(*dma);
> > -
> > -		rq->last_dma = dma;
> > +		++dma->ref;
> >  	}
> >
> > -	++dma->ref;
> > -
> >  	buf = head + alloc_frag->offset;
> >
> >  	get_page(alloc_frag->page);
> > @@ -957,9 +967,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  	if (!vi->mergeable_rx_bufs && vi->big_packets)
> >  		return;
> >
> > -	for (i = 0; i < vi->max_queue_pairs; i++)
> > -		/* error should never happen */
> > -		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +			continue;
> > +
> > +		vi->rq[i].do_dma = true;
> > +	}
> 
> This is too much code to revert. We can just revert this and next one.
> And add a patch to turn off the default premapped setting (return from this
> function directly). Otherwise, we will have to do all the work again in the
> future.
> 
> There is no need to revert xsk related code, xsk function cannot be enabled, in
> the case that premapped mode is not turned on. There is no direct impact itself.
> 
> Thanks.

I tried but quickly got lost as the automatic
revert did not work, and it's very close to release, so
I wanted to be sure it's right.

Post your own version of a revert for testing then please.


> 
> >  }
> >
> >  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > @@ -2107,7 +2120,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >
> > @@ -2221,7 +2235,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >  	ctx = mergeable_len_to_ctx(len + room, headroom);
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >
> > @@ -5392,7 +5407,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> >  	int i;
> >  	for (i = 0; i < vi->max_queue_pairs; i++)
> >  		if (vi->rq[i].alloc_frag.page) {
> > -			if (vi->rq[i].last_dma)
> > +			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> >  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
> >  			put_page(vi->rq[i].alloc_frag.page);
> >  		}
> > --
> > MST
> >


