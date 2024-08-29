Return-Path: <netdev+bounces-123142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03354963CD1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285531C21192
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEF15DBC1;
	Thu, 29 Aug 2024 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SXq3SDL5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E06173331
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916470; cv=none; b=jLACFpJmpJJ3+BbTcXRlBXoOxFQ9D0Z7IcCZ/QKeIRwdPkljvEOPDeIDf0ZX274/808Hvv3Lt7GOFpA/1bko+kgb9qPz6l+zTlHYr/iIn3MycUbDgqZi4lM3/19sCBOig1AhnmCR0FucBdTivOrvEUIAaNQ+xDtlbBsqhiCq+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916470; c=relaxed/simple;
	bh=hbiT2qTnhOAt2CAppaXESoCNbVJgqi23NawoY0s22bA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=AvY2Kc9Xk/YVPBQXdeA6gi9Vi9A5h5vFucqSvZEqjtJemeS04kPWb0YWlL+rzs3/vFEdgN8ubdkBReCZ4mR1Qh6OtSzhPsPa/sSZSvqyq3B7s4oq5yVKt1S0JUswFN+yZamMFZlJFivrlY0wrLj70uXBSTRiRTfDZ/DGwUaoroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SXq3SDL5; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724916459; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=oJRSiRNEcTxrexA0I+3k45YaDUqdl/8Ri0szKWJVOK8=;
	b=SXq3SDL56fwT9CMUOrPgxI1BT5aPRPj1nxteVjFEwKqUHjIbCZpsjib5KkMtupU9u6eZkyPuf9r+5fo4dq6iShl9Vf7m9tNMLbBl22fsLIpSjHgwi3NDCq1xoaOhiESSIkcSxu+Z8fTGHlli/85PSVVt7/hwgJsJrKlfQQ4qcck=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDsDtI7_1724916457)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 15:27:38 +0800
Message-ID: <1724916360.9746847-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Thu, 29 Aug 2024 15:26:00 +0800
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
 <1724843499.0572476-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsNk7iYti3hSJ0EiXfusF8Kw9YEJjXFH-DApQaEY6o-cQ@mail.gmail.com>
In-Reply-To: <CACGkMEsNk7iYti3hSJ0EiXfusF8Kw9YEJjXFH-DApQaEY6o-cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 29 Aug 2024 12:51:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Aug 28, 2024 at 7:21=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 27 Aug 2024 11:38:45 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Aug 20, 2024 at 3:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > leads to regression on VM with the sysctl value of:
> > > >
> > > > - net.core.high_order_alloc_disable=3D1
> > > >
> > > > which could see reliable crashes or scp failure (scp a file 100M in=
 size
> > > > to VM):
> > > >
> > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the begin=
ning
> > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > everything is fine. However, if the frag is only one page and the
> > > > total size of the buffer and virtnet_rq_dma is larger than one page=
, an
> > > > overflow may occur. In this case, if an overflow is possible, I adj=
ust
> > > > the buffer size. If net.core.high_order_alloc_disable=3D1, the maxi=
mum
> > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0,=
 only
> > > > the first buffer of the frag is affected.
> > >
> > > I wonder instead of trying to make use of headroom, would it be
> > > simpler if we allocate dedicated arrays of virtnet_rq_dma=EF=BC=9F
> >
> > Sorry for the late reply. My mailbox was full, so I missed the reply to=
 this
> > thread. Thanks to Si-Wei for reminding me.
> >
> > If the virtnet_rq_dma is at the headroom, we can get the virtnet_rq_dma=
 by buf.
> >
> >         struct page *page =3D virt_to_head_page(buf);
> >
> >         head =3D page_address(page);
> >
> > If we use a dedicated array, then we need pass the virtnet_rq_dma point=
er to
> > virtio core, the array has the same size with the rx ring.
> >
> > The virtnet_rq_dma will be:
> >
> > struct virtnet_rq_dma {
> >         dma_addr_t addr;
> >         u32 ref;
> >         u16 len;
> >         u16 need_sync;
> > +       void *buf;
> > };
> >
> > That will be simpler.
>
> I'm not sure I understand here, did you mean using a dedicated array is s=
impler?

I found the old version(that used a dedicated array):

http://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo@linux.alibaba.c=
om

If you think that is ok, I can port a new version based that.

Thanks.


>
> >
> > >
> > > Btw, I see it has a need_sync, I wonder if it can help for performance
> > > or not? If not, any reason to keep that?
> >
> > I think yes, we can skip the cpu sync when we do not need it.
>
> I meant it looks to me the needs_sync is not necessary in the
> structure as we can call need_sync() any time if we had dma addr.
>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > >
> > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever u=
se_dma_api")
> > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a54=
0c0a@oracle.com
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index c6af18948092..e5286a6da863 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_qu=
eue *rq, u32 size, gfp_t gfp)
> > > >         void *buf, *head;
> > > >         dma_addr_t addr;
> > > >
> > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > -               return NULL;
> > > > -
> > > >         head =3D page_address(alloc_frag->page);
> > > >
> > > >         dma =3D head;
> > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_i=
nfo *vi, struct receive_queue *rq,
> > > >         len =3D SKB_DATA_ALIGN(len) +
> > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > >
> > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gf=
p)))
> > > > +               return -ENOMEM;
> > > > +
> > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > >         if (unlikely(!buf))
> > > >                 return -ENOMEM;
> > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virt=
net_info *vi,
> > > >          */
> > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, roo=
m);
> > > >
> > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, =
gfp)))
> > > > +               return -ENOMEM;
> > > > +
> > > > +       if (!alloc_frag->offset && len + room + sizeof(struct virtn=
et_rq_dma) > alloc_frag->size)
> > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > +
> > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > >         if (unlikely(!buf))
> > > >                 return -ENOMEM;
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
> > > Thanks
> > >
> > > >
> > >
> > >
> > >
> >
>

