Return-Path: <netdev+bounces-125846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18196EED1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116921C20A34
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99D158DA9;
	Fri,  6 Sep 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFZZr+zM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B21C7B68
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613750; cv=none; b=umQF2EjF00NOqbAGaSyFcFvoYF9YzcQ9k88WPyX0N/bISgPKZy9yBmh8Cj/M/k8NROSICC02D2yVZeT3BV+XKbOKgpW3UlXxX/CVgJAnj7vChy0d4g3I8M88iSslFgXIEX1Q8pNXK7fIhKhbWp+a0UGe3vwCLaCN8hHwnEyng3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613750; c=relaxed/simple;
	bh=kQnCn6UuRSmObUj2sDmdYIc+ehx2G6t88GoNv0oYrKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJTpg/6Vgzqq3gMnbPN5geKgbNEzbBa7YkgeapGHXIu47StpNjAyW42zJiFpeqDOo/V5Uf6LZfwvgCw+/YJX0r49DwdnvcOJSkGoGv0oZt+kvZnFsuhmKI1QrG4YtxjatLAkQIRN9drzA8tE4Jf9+q2n34lxf+wgd12bMeUh9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFZZr+zM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725613747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D24mRm5LrUYTcb7xHC0WCD/VrAupd5O09gSa9Wcuxe8=;
	b=YFZZr+zMejmTvN8qfMvNv5TalZkKkz6cE3kI/YeOy5crxJUa8qWHtsTY709SHFOSQSwRzR
	boBhph/iyC4DkE3wVvEBx1rhn/Tv+CakcJggr9L0SXcFCWiVX+FyVQIINPrLBLWHBwsUOz
	fVDnBBg5H2kG4/FLXB3HFdj6aJhXA/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-moZOo5QOPi-2g4Tt9hLSLQ-1; Fri, 06 Sep 2024 05:09:06 -0400
X-MC-Unique: moZOo5QOPi-2g4Tt9hLSLQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374b69e65e8so1116429f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613745; x=1726218545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D24mRm5LrUYTcb7xHC0WCD/VrAupd5O09gSa9Wcuxe8=;
        b=LDytcu4dwlEcf7ldBqGtFU6iK616wXtDX8zw6A/DeDf26WRfQXvQomN4cHI/bKa6ur
         538Wig3LOAW1TBAdDgLDaW7sFyg93E5iJJ3cmHHW2aedjuhscvbcwjtz5/B+gFkJvXW3
         DobIRJv8fRFVIwrh0nV0IPr3nbu/l0yQ1C7dd49hueD9F8wCTZQFoxDUWODcFGF9bmeK
         0WjYaMgTzPeEYPY6Pk/h9UDTZTzb725v1VJ7dZAkwcI2+OpOaR8U5RPXPthd8M+KMuOn
         U5STaMNwKuopVhYhmtXYkQKIFQNDvEZ+mWS0jA6HeheXkbFfiV4AKmE2O2wnS10uGmZE
         xGOw==
X-Gm-Message-State: AOJu0YzWFKCXMxCpwoyrSJ2qUmz9qcdha7ebnbyw2+FOUxRPO11gGpcQ
	FkVG8Eyt7uNUuFOqw2nVzSHcwZmwT7TZbHnvWQ+UCGp8JXSo1l+7hLUL1012f5JApfMhBf27Q3D
	6C8arMMPKITORV7nZs8a8IpA8WzJfPbPt1/oMg9ApAXcNB6SrMAJwSA==
X-Received: by 2002:adf:edd2:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378896c8082mr1231866f8f.49.1725613745472;
        Fri, 06 Sep 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMD4aX16S9LZGKe4EPTwXGfS6x36Rfr8HE2zqgzih2SEOtsrLoz+17HThNjBLPwX/BHpiRNA==
X-Received: by 2002:adf:edd2:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378896c8082mr1231823f8f.49.1725613744555;
        Fri, 06 Sep 2024 02:09:04 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cbbc8281sm12225923f8f.64.2024.09.06.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:09:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:08:56 -0400
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
Message-ID: <20240906045904-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725612818.815039-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > leads to regression on VM with the sysctl value of:
> > >
> > > - net.core.high_order_alloc_disable=1
> > >
> > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > to VM):
> > >
> > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > everything is fine. However, if the frag is only one page and the
> > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > the first buffer of the frag is affected.
> > >
> > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > Guys where are we going with this? We have a crasher right now,
> > if this is not fixed ASAP I'd have to revert a ton of
> > work Xuan Zhuo just did.
> 
> I think this patch can fix it and I tested it.
> But Darren said this patch did not work.
> I need more info about the crash that Darren encountered.
> 
> Thanks.

So what are we doing? Revert the whole pile for now?
Seems to be a bit of a pity, but maybe that's the best we can do
for this release.


> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948092..e5286a6da863 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > >  	void *buf, *head;
> > >  	dma_addr_t addr;
> > >
> > > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > -		return NULL;
> > > -
> > >  	head = page_address(alloc_frag->page);
> > >
> > >  	dma = head;
> > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > >  	len = SKB_DATA_ALIGN(len) +
> > >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >
> > > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > +		return -ENOMEM;
> > > +
> > >  	buf = virtnet_rq_alloc(rq, len, gfp);
> > >  	if (unlikely(!buf))
> > >  		return -ENOMEM;
> > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > >  	 */
> > >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > >
> > > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > +		return -ENOMEM;
> > > +
> > > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > +		len -= sizeof(struct virtnet_rq_dma);
> > > +
> > >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > >  	if (unlikely(!buf))
> > >  		return -ENOMEM;
> > > --
> > > 2.32.0.3.g01195cf9f
> >


