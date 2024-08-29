Return-Path: <netdev+bounces-123144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8C963D2A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D7EB21E6F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F615A865;
	Thu, 29 Aug 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjOJ53To"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97F184549
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916972; cv=none; b=e/BSFSdRlXDXhbb35QDBfVBR2/b7A28K0GL5Dy9fqNf9I61WWqDobojY2kdTaMfSm+UDPEIg54enF+AHvYHGR3CRBocB8SN9UHfpFViaeFjEfKwTcr/2Pqg+szpEw7TI5N3CRV7su1ANYLDVWk4JJtkxXq7jHw+NtQsjmKg51HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916972; c=relaxed/simple;
	bh=cVjJYV3Z/dOa1Mqk/ebZiTjWBkbZ/d8vI//Tn7ABX7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnDUUfAOYM4GCV36gmxdpJRrL7/YNZdbYkSRTj0wiz1gCyNQ0RL2a4vt6NkRTq1UygqcakzxAygdMar/cyuukv2m2zXn50pgaEb2FqyxC/CAcOK0LQ49aZ3VfMJ9JgbxowZ85VfROSbtYmBYVWMONWi/8efk3ZR7mqYhMq0NQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjOJ53To; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724916968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohk1fQ2YMSfcyLTh4WiLQ+42ujiY1Vu4hR2nTH7HZPc=;
	b=YjOJ53ToR3yhHoKkaNdSJySCXDECNhp4D7ulylxuPr+q7/8rK8+E3uWbMn0phiZWLYeP4n
	CSHDOBDK+diNC42I0OGTj4G3VMN0jk8fk5QWZb4UNKHaVcoQg/lR96usqLZP0cyauvV/QJ
	vk6GhV/OtKOFo/3slLZ+Oc6Vnlr+jqY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Kyn5WEZ-MKypmMEk2eaBng-1; Thu, 29 Aug 2024 03:36:07 -0400
X-MC-Unique: Kyn5WEZ-MKypmMEk2eaBng-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a86915aeb32so27038266b.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724916966; x=1725521766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohk1fQ2YMSfcyLTh4WiLQ+42ujiY1Vu4hR2nTH7HZPc=;
        b=L54JMLqsWcIbt4AhLjZ3K9NpSLMDhVf6kOXNq0etGocuBI1gzjT3CrGAIGZJ+aRbPi
         HxKyCoegnz1S8fkZGTxqdwIkbdAhbUNTl+WCyrV0/rNOaaoL0Ljbwpj7pPCl/q4/SvR9
         qmJsPZwNDBzIkFEztMLjHl4IQ7Z4IJvmagFMZ1VWNjKyw4S/dQxTOQsDDSmeTUmol/G4
         BV4jAuY5710HMhvQrLkmqMfOdo2gvem6Mw7EJLFZnDL9tgBKl6DlXN3DfoVDGzqmbiii
         SohWuoz7dQ3GSBCNcjeEPR9MZRejTobyJWPn6mSdBqFs5kvSwZ/eTqf40rqixX87RmEw
         IcGg==
X-Forwarded-Encrypted: i=1; AJvYcCVfUlUgO2XAuhuiECU3KJrZH/GFsRiLwnbrVA9zkdcujNtMmEPlNyVcQmtkOlb/uaVn9spqhs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPna1A2sitVGzPufl8+e7DQQRGiWaat1SD+YpcBCnsJr2Z/ji
	spdbii5PMeNgc7cO6fCy4Uteh1XF6Jkd5tpSoTJ5XYyoSlE+yDYMiqqmEaDcPQVYk3n3fbcnH0h
	4G+/YcL1YZmbj/3RBA9mgsfaqX0toJ9Iz5ZFwhJwfAITbDELfYsU03A==
X-Received: by 2002:a17:907:3f24:b0:a86:9c41:cfc1 with SMTP id a640c23a62f3a-a897f775dd1mr150157866b.8.1724916965758;
        Thu, 29 Aug 2024 00:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY4tDrnYyIp4XqYAajLJXRVCYVThMt5vYfRf0oEzyI1i5Mv46dq6eXSulL0YuqDUOF1Ev4Fg==
X-Received: by 2002:a17:907:3f24:b0:a86:9c41:cfc1 with SMTP id a640c23a62f3a-a897f775dd1mr150152966b.8.1724916964907;
        Thu, 29 Aug 2024 00:36:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm40795866b.181.2024.08.29.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:36:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 03:35:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240829033209-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com>
 <1724843499.0572476-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsNk7iYti3hSJ0EiXfusF8Kw9YEJjXFH-DApQaEY6o-cQ@mail.gmail.com>
 <1724916360.9746847-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1724916360.9746847-3-xuanzhuo@linux.alibaba.com>

On Thu, Aug 29, 2024 at 03:26:00PM +0800, Xuan Zhuo wrote:
> On Thu, 29 Aug 2024 12:51:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Aug 28, 2024 at 7:21 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Tue, 27 Aug 2024 11:38:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Tue, Aug 20, 2024 at 3:19 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > leads to regression on VM with the sysctl value of:
> > > > >
> > > > > - net.core.high_order_alloc_disable=1
> > > > >
> > > > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > > > to VM):
> > > > >
> > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > everything is fine. However, if the frag is only one page and the
> > > > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > > > the first buffer of the frag is affected.

I don't exactly get it, when you say "only the first buffer of the frag
is affected" what do you mean? Affected how?

> > > >
> > > > I wonder instead of trying to make use of headroom, would it be
> > > > simpler if we allocate dedicated arrays of virtnet_rq_dma？
> > >
> > > Sorry for the late reply. My mailbox was full, so I missed the reply to this
> > > thread. Thanks to Si-Wei for reminding me.
> > >
> > > If the virtnet_rq_dma is at the headroom, we can get the virtnet_rq_dma by buf.
> > >
> > >         struct page *page = virt_to_head_page(buf);
> > >
> > >         head = page_address(page);
> > >
> > > If we use a dedicated array, then we need pass the virtnet_rq_dma pointer to
> > > virtio core, the array has the same size with the rx ring.
> > >
> > > The virtnet_rq_dma will be:
> > >
> > > struct virtnet_rq_dma {
> > >         dma_addr_t addr;
> > >         u32 ref;
> > >         u16 len;
> > >         u16 need_sync;
> > > +       void *buf;
> > > };
> > >
> > > That will be simpler.
> >
> > I'm not sure I understand here, did you mean using a dedicated array is simpler?
> 
> I found the old version(that used a dedicated array):
> 
> http://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo@linux.alibaba.com
> 
> If you think that is ok, I can port a new version based that.
> 
> Thanks.
> 

That one got a bunch of comments that likely still apply.
And this looks like a much bigger change than what this
patch proposes.

> >
> > >
> > > >
> > > > Btw, I see it has a need_sync, I wonder if it can help for performance
> > > > or not? If not, any reason to keep that?
> > >
> > > I think yes, we can skip the cpu sync when we do not need it.
> >
> > I meant it looks to me the needs_sync is not necessary in the
> > structure as we can call need_sync() any time if we had dma addr.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > >
> > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index c6af18948092..e5286a6da863 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > > > >         void *buf, *head;
> > > > >         dma_addr_t addr;
> > > > >
> > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > > -               return NULL;
> > > > > -
> > > > >         head = page_address(alloc_frag->page);
> > > > >
> > > > >         dma = head;
> > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >         len = SKB_DATA_ALIGN(len) +
> > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > >         buf = virtnet_rq_alloc(rq, len, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > >          */
> > > > >         len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > > > +               len -= sizeof(struct virtnet_rq_dma);
> > > > > +
> > > > >         buf = virtnet_rq_alloc(rq, len + room, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > > > Thanks
> > > >
> > > > >
> > > >
> > > >
> > > >
> > >
> >


