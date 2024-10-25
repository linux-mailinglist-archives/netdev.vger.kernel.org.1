Return-Path: <netdev+bounces-138935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC909AF79B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8578C1F229B1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16718A6CE;
	Fri, 25 Oct 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jivnttyL"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC722B64E
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824299; cv=none; b=d4PmaDrW3DnyOJG3pO7qJZ3ig9n2+lKAB5A36e2d79tiDPTK7cIIQ/I6Ai2t4LOEO/IrDs/qhuGEDr4JgT/50VorhPRaNp/KREVsBjAY2hXE8B6TdTTN9nNTqGkO+KWK+cxsJQWi9hKs/a6uajeqlTprnxABCpoHXajua7S9SWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824299; c=relaxed/simple;
	bh=BQWhKiWlILV4IJTS1RbaBnUS/ecDkJwXH+RM+Pn6y28=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=SEVPHM9pIw/7pJ8zBBL3jXTaBaSpkoZ4yi+5x1bNykyzG4PN2OUGRedcUJ+N493AyqJOktqx7m1OHe1NBx4kZN6potn+0WvBAi5O5Y5+wURieh5xdD7GTve8ip7wxXIerY3e/rQLjpl1WB5U+W8glFZm0GMVVajaixCVEfIni4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jivnttyL; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729824294; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=jjqfRn2+8EBuwasZ9vNJuIxk7DlUiV+pkN4rH5G/Yy8=;
	b=jivnttyLDHgI6mddesPg5rby9HvvVJ1RcR81DAW2ZvrOZ+a+CCRjMTBSfyHGYFtw7QQ2ImuGAmU15OvkPaEW+9v+BA9mkGXIXBnlfiLmISOCtYY83v4HC0IW5m3E4DhUW7Nhv7PDIV7gw3nob2amfvM87dEl7BIM6q8a/3oVYHI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WHqkyuW_1729824293 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 10:44:53 +0800
Message-ID: <1729824026.1486967-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Fri, 25 Oct 2024 10:40:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-TYVqjP3GYx_4SmWRGMtYDFZY3s3QpV3nkgXNXhk7kQ@mail.gmail.com>
In-Reply-To: <CACGkMEv-TYVqjP3GYx_4SmWRGMtYDFZY3s3QpV3nkgXNXhk7kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 18 Oct 2024 15:41:41 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > When the frag just got a page, then may lead to regression on VM.
> > Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> > then the frag always get a page when do refill.
> >
> > Which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> >
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur.
> >
> > Here, when the frag size is not enough, we reduce the buffer len to fix
> > this problem.
> >
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_d=
ma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Though this may fix the problem and we need it now, I would like to
> have some tweaks in the future. Basically because of the security
> implication for sharing driver metadata with the device (most IOMMU
> can only do protection at the granule at the page). So we may end up
> with device-triggerable behaviour. For safety, we should use driver
> private memory for DMA metadata.
>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f8131f92a392..59a99bbaf852 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue =
*rq, u32 size, gfp_t gfp)
> >         void *buf, *head;
> >         dma_addr_t addr;
> >
> > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > -               return NULL;
> > -
> >         head =3D page_address(alloc_frag->page);
> >
> >         if (rq->do_dma) {
> > @@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info =
*vi, struct receive_queue *rq,
> >         len =3D SKB_DATA_ALIGN(len) +
> >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >
> > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > +               return -ENOMEM;
> > +
> >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> >         if (unlikely(!buf))
> >                 return -ENOMEM;
> > @@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_=
info *vi,
> >          */
> >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> >
> > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)=
))
> > +               return -ENOMEM;
>
> This makes me think of another question, how could we guarantee len +
> room is less or equal to PAGE_SIZE. Especially considering we need
> extra head and tailroom for XDP? If we can't it is a bug:

get_mergeable_buf_len() do this.

>
> """
> /**
>  * skb_page_frag_refill - check that a page_frag contains enough room
>  * @sz: minimum size of the fragment we want to get
>  * @pfrag: pointer to page_frag
>  * @gfp: priority for memory allocation
>  *
>  * Note: While this allocator tries to use high order pages, there is
>  * no guarantee that allocations succeed. Therefore, @sz MUST be
>  * less or equal than PAGE_SIZE.
>  */
> """
>
> > +
> > +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_r=
q_dma) > alloc_frag->size)
> > +               len -=3D sizeof(struct virtnet_rq_dma);
>
> Any reason we need to check alloc_frag->offset?

We just need to check when the page of the alloc frag is new.
In this case, we need to allocate space to store dma meta.
If the offset > 0, then we do not need to allocate extra space,
so it is safe.


>
> > +
> >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
>
> Btw, as pointed out in previous review, we should have a consistent API:
>
> 1) hide the alloc_frag like virtnet_rq_alloc()
>
> or
>
> 2) pass the alloc_frag to virtnet_rq_alloc()


Now we need to check len+room before calling skb_page_frag_refill()
so we must move  virtnet_rq_alloc() outside virtnet_rq_alloc().

Thanks

>
> >         if (unlikely(!buf))
> >                 return -ENOMEM;
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

