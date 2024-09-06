Return-Path: <netdev+bounces-125867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE196F071
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CAA1C21957
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8A1C8FC8;
	Fri,  6 Sep 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7eniZIF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A61C8FB6
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616455; cv=none; b=s7Mh1Y3NmTv8Yt+AZuKxNO0r2HpgygxdQPwBhgOh9cUHAHjL/0Qk0NOi0GX8m5JOlCO1MrVo3yF9yPk2oj5K4A/IEdsP3YclJ/2Ds1HEAOQb4qBfqAvmPIzCDNeICQWQZixqLZXPPjGzX3c1lceH0cmF8AwDil1j2Ldgz0mJYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616455; c=relaxed/simple;
	bh=vzaOlZpLLkD75hlMSMPR8SY9c1CzSMqnZNX6RunHd40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkp/3RejzleK3qer0POosrYGGNfcTPFIFSZH9UVh9XzHrz544/0cVXU5wwj3bhASPnbQd/CbAXxuBcQEAnrv4AppyzEifvEUrIEwE3hChm+TNqMKzAXzsDy6RLXm4zHKKY635DOsI34qitzOO54sDbpXyRqgUMYo0Qvd3nChUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7eniZIF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aksakBHDE0/j8ahTBvKG/EiOnaQlZoL63vLFTpifaU=;
	b=S7eniZIFzvj6BZOTq47SoPbPVWR0Cdy6fs8VAtRIsleQ8UtzeBEWoEKqSgQYhpRl8phC+y
	L71p83t66tix841Bj8KuVSsI5cB2b6t4ZB6DouAAFAS7bQlwGRYGJoQNYLWpfyKaKiS9Gq
	Rg2aukYKwmL/RJn9EeaQVCsqnoHw5uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-2k1P1da1MxOFHDttqnhVNw-1; Fri, 06 Sep 2024 05:54:11 -0400
X-MC-Unique: 2k1P1da1MxOFHDttqnhVNw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c35b8e38so950472f8f.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616450; x=1726221250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aksakBHDE0/j8ahTBvKG/EiOnaQlZoL63vLFTpifaU=;
        b=V94iUFXuDwjqv9XcFPIVak2NtfpzroGBj6LlU4yg8lVqhztCHv0jQdhqcXC2mpiZ1J
         IjbiYU5HcTzi9FRFS+oN38kvO9IOXsJAnkd2Pfm+8MI+QKg0T93OHCrLFC3B0ZWfRvNi
         5U/WRgAUtM84qkyEtsJ3G6T9Hl2pg36P2zhuLz5S7fO0Sg3H9PjIXtQBhxDOa9s23WCm
         dApZvL+Ai3yQf1noxg8t+xykayv8vvRlSmMNswNp9wCWcn1mrshTmOlpc1h/Q8N2cHAB
         MsMPxm2hN/mSTjjK+0bqTgKQfPk13MKmYYCwJxdx1wXvzZerYBqqOhKIYixEfrn5/NVL
         XK+A==
X-Gm-Message-State: AOJu0YwIedTQj3pWqKLv6UCQWzTdUArsQLKGKCHnRUgqhcYqtl9qAOJO
	5JGFqHQ7VR9D0gezlnQ3kElcrgKc5VXZvwFnhSgt4cBG2yl3nBn7zQI6Dtlunf6JaAKFpMyZZB8
	mSwc57DPwty0IzQlKzM4b8UE3ML81wsWSOMdJPpIEb6leIqqjrPBVWw==
X-Received: by 2002:a05:6000:e07:b0:368:7fbc:4062 with SMTP id ffacd0b85a97d-378895e2f23mr1306361f8f.33.1725616449878;
        Fri, 06 Sep 2024 02:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBgDM7sxM/7ia1YEw96VEtGVk4zDjpQQBhV0XhFyisOAMnm+DvCVKo9/BPS+TEKK+xP5YFqA==
X-Received: by 2002:a05:6000:e07:b0:368:7fbc:4062 with SMTP id ffacd0b85a97d-378895e2f23mr1306334f8f.33.1725616449296;
        Fri, 06 Sep 2024 02:54:09 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c6db03afsm13987450f8f.16.2024.09.06.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:54:08 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:53:59 -0400
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
Message-ID: <20240906055236-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org>
 <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > >
> > > > > > > - net.core.high_order_alloc_disable=1
> > > > > > >
> > > > > > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > > > > > to VM):
> > > > > > >
> > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > everything is fine. However, if the frag is only one page and the
> > > > > > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > > > > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > > > > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > > > > > the first buffer of the frag is affected.
> > > > > > >
> > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >
> > > > > >
> > > > > > Guys where are we going with this? We have a crasher right now,
> > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > work Xuan Zhuo just did.
> > > > >
> > > > > I think this patch can fix it and I tested it.
> > > > > But Darren said this patch did not work.
> > > > > I need more info about the crash that Darren encountered.
> > > > >
> > > > > Thanks.
> > > >
> > > > So what are we doing? Revert the whole pile for now?
> > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > for this release.
> > >
> > > @Jason Could you review this?
> > >
> > > I think this problem is clear, though I do not know why it did not work
> > > for Darren.
> > >
> > > Thanks.
> > >
> >
> > No regressions is a hard rule. If we can't figure out the regression
> > now, we should revert and you can try again for the next release.
> 
> I see. I think I fixed it.
> 
> Hope Darren can reply before you post the revert patches.
> 
> Thanks.
> 

It's very rushed anyway. I posted the reverts, but as RFC for now.
You should post a debugging patch for Darren to help you figure
out what is going on.


> >
> >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index c6af18948092..e5286a6da863 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > > > > > >  	void *buf, *head;
> > > > > > >  	dma_addr_t addr;
> > > > > > >
> > > > > > > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > > > > -		return NULL;
> > > > > > > -
> > > > > > >  	head = page_address(alloc_frag->page);
> > > > > > >
> > > > > > >  	dma = head;
> > > > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > >  	len = SKB_DATA_ALIGN(len) +
> > > > > > >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > > >
> > > > > > > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > >  	buf = virtnet_rq_alloc(rq, len, gfp);
> > > > > > >  	if (unlikely(!buf))
> > > > > > >  		return -ENOMEM;
> > > > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > > > >  	 */
> > > > > > >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > > > > > >
> > > > > > > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > > > > > +		len -= sizeof(struct virtnet_rq_dma);
> > > > > > > +
> > > > > > >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > > > > > >  	if (unlikely(!buf))
> > > > > > >  		return -ENOMEM;
> > > > > > > --
> > > > > > > 2.32.0.3.g01195cf9f
> > > > > >
> > > >
> >


