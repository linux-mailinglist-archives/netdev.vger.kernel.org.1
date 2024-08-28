Return-Path: <netdev+bounces-122736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBFC9625E1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DFD284D4A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326E16BE1D;
	Wed, 28 Aug 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ITyTJqp8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5D316C874
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844097; cv=none; b=cP5u563KO6DRfoCDP7T0oban0yr18aYKiAdofnxPueoDIwr8lB25rSutb5c1vQq5w+IqK+bX9BqTggUwM2oZ3TlPfHVY+Rn3N2IsuZixHr4q0xibf59hAWlMJb3/q03rSVIZ2Z8hoJFCoatdShoOiLoe9JOiKnqfvD78KS5ASy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844097; c=relaxed/simple;
	bh=UNV7JH6m2a1MuuhB1+IRLJfWqg2zBYTydGu0oSFf87M=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Z/dHtCi++hY6qPSUylxd1R0OmrJDPekE6lfEddP4k1Aus4aSPnFjvovvmX60fAStguqq0rg7JAgIEiFmNd4I7XdG5uWe4QHHIXaJsKqcASIVfv0n0pMTUH3t4bNII1qGp/2GpYguUj0ErL476t4hQfZrKkqBvLmxveIrtLUQhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ITyTJqp8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844093; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=j3p9KG0CSZeojcigRdAXnXA72d33sr+/nYfyiqyIrnE=;
	b=ITyTJqp8In8WT//s2s/YZwslUhrbrJFMNNhVZh1jzCI+wJUMIGN51ZfJdoAgn0ZJnFH1x9DCoMJ7PrU54or2f7LGpyxn7EsB5P4xjLjcpD7n8qu0vFksUcncmvtHUz9QG/b+hrk5whK0TQWlGzx5h08qoAThDAEp9IiZazEaWwU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDphlID_1724844092)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:21:32 +0800
Message-ID: <1724843499.0572476-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Wed, 28 Aug 2024 19:11:39 +0800
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
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com>
In-Reply-To: <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 27 Aug 2024 11:38:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > leads to regression on VM with the sysctl value of:
> >
> > - net.core.high_order_alloc_disable=3D1
> >
> > which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> >
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur. In this case, if an overflow is possible, I adjust
> > the buffer size. If net.core.high_order_alloc_disable=3D1, the maximum
> > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0, only
> > the first buffer of the frag is affected.
>
> I wonder instead of trying to make use of headroom, would it be
> simpler if we allocate dedicated arrays of virtnet_rq_dma=EF=BC=9F

Sorry for the late reply. My mailbox was full, so I missed the reply to this
thread. Thanks to Si-Wei for reminding me.

If the virtnet_rq_dma is at the headroom, we can get the virtnet_rq_dma by =
buf.

	struct page *page =3D virt_to_head_page(buf);

	head =3D page_address(page);

If we use a dedicated array, then we need pass the virtnet_rq_dma pointer to
virtio core, the array has the same size with the rx ring.

The virtnet_rq_dma will be:

struct virtnet_rq_dma {
	dma_addr_t addr;
	u32 ref;
	u16 len;
	u16 need_sync;
+	void *buf;
};

That will be simpler.

>
> Btw, I see it has a need_sync, I wonder if it can help for performance
> or not? If not, any reason to keep that?

I think yes, we can skip the cpu sync when we do not need it.

Thanks.


>
> >
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_d=
ma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a=
@oracle.com
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c6af18948092..e5286a6da863 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue =
*rq, u32 size, gfp_t gfp)
> >         void *buf, *head;
> >         dma_addr_t addr;
> >
> > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > -               return NULL;
> > -
> >         head =3D page_address(alloc_frag->page);
> >
> >         dma =3D head;
> > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info =
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
> > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_=
info *vi,
> >          */
> >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> >
> > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)=
))
> > +               return -ENOMEM;
> > +
> > +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_r=
q_dma) > alloc_frag->size)
> > +               len -=3D sizeof(struct virtnet_rq_dma);
> > +
> >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> >         if (unlikely(!buf))
> >                 return -ENOMEM;
> > --
> > 2.32.0.3.g01195cf9f
>
> Thanks
>
> >
>
>
>

