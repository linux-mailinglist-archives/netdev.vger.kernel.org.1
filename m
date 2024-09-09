Return-Path: <netdev+bounces-126441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E64971290
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE141C224D6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C31B150A;
	Mon,  9 Sep 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mbq1LeAj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797411B1D4B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871816; cv=none; b=GXE9guUbT/WZj+yS5df4zDZEyoa+qEbeqSXt+QJPQRPYeMfS04RlxpEsysT7xKHtbyVlvbw+rU1cqaW7vB9fPJ9+s3wz/Odx68NfLL5dPVCeMQyLhk1YWuQq8UHM+ZXBoB2SCKKXgb7oOxoGDitGLxRGxwWZoJcnwSfGgMXm5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871816; c=relaxed/simple;
	bh=/BxnH036p14jeYvFejRXZU5HBmtnml4/SDXd0+18YQE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=uhCqz6kDCv6tqZg0he+8YNGQNN2jIoUbDzbTFbdBCuAXYeWPHFoZaD+TbRP2gBijVW1APxGAA3z6x1aAm2GeTFLwojGEydbWJzofFAC7yhpjAQvXBsHIcmIdkvnanBE9SiWDJEDdAUeoHf4g7MEH5OxLZtNhi2KsLaQxJWC9DNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mbq1LeAj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725871809; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=radQgQEQZqISbTcR0YgFXwJGJRj5BFltJWnzzAOoYMc=;
	b=Mbq1LeAjuZSU+ulIhbVloJJOPXQavRB85uGEi1gDeJcVYTLwEM+gfbt+llNeXp3HDgRFYUylYYziIfHX3fX6b9JdFbaCtoqRB81bmNKCVAZbkDJcyPV5acZjJWZ4NNkqVczbBPZlQ0T9JwAdpCZTlBj5N59g4q8m/EQDFI0cbps=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEalK1E_1725871808)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 16:50:08 +0800
Message-ID: <1725871401.4568927-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Mon, 9 Sep 2024 16:43:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4XmMnZWEK56npxiA_QB0x48AU9fWfA63y5PHuHpLdBQ@mail.gmail.com>
In-Reply-To: <CACGkMEt4XmMnZWEK56npxiA_QB0x48AU9fWfA63y5PHuHpLdBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 9 Sep 2024 16:38:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Sep 6, 2024 at 5:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > leads to regression on VM with the sysctl value of:
> > > > > >
> > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > >
> > > > > > which could see reliable crashes or scp failure (scp a file 100=
M in size
> > > > > > to VM):
> > > > > >
> > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the b=
eginning
> > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > everything is fine. However, if the frag is only one page and t=
he
> > > > > > total size of the buffer and virtnet_rq_dma is larger than one =
page, an
> > > > > > overflow may occur. In this case, if an overflow is possible, I=
 adjust
> > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, the =
maximum
> > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=
=3D0, only
> > > > > > the first buffer of the frag is affected.
> > > > > >
> > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatev=
er use_dma_api")
> > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba16=
4a540c0a@oracle.com
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > >
> > > > >
> > > > > Guys where are we going with this? We have a crasher right now,
> > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > work Xuan Zhuo just did.
> > > >
> > > > I think this patch can fix it and I tested it.
> > > > But Darren said this patch did not work.
> > > > I need more info about the crash that Darren encountered.
> > > >
> > > > Thanks.
> > >
> > > So what are we doing? Revert the whole pile for now?
> > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > for this release.
> >
> > @Jason Could you review this?
>
> I think we probably need some tweaks for this patch.
>
> For example, the changelog is not easy to be understood especially
> consider it starts something like:
>
> "
>     leads to regression on VM with the sysctl value of:
>
>     - net.core.high_order_alloc_disable=3D1
>
>     which could see reliable crashes or scp failure (scp a file 100M in s=
ize
>     to VM):
> "
>
> Need some context and actually sysctl is not a must to reproduce the
> issue, it can also happen when memory is fragmented.

OK.


>
> Another issue is that, if we move the skb_page_frag_refill() out of
> the virtnet_rq_alloc(). The function semantics turns out to be weird:
>
> skb_page_frag_refill(len, &rq->alloc_frag, gfp);
> ...
> virtnet_rq_alloc(rq, len, gfp);

YES.

>
> I wonder instead of subtracting the dma->len, how about simply count
> the dma->len in len if we call virtnet_rq_aloc() in
> add_recvbuf_small()?

1. For the small mode, it is safe. That just happens in the merge mode.
2. In the merge mode, if we count the dma->len in len, we should know
   if the frag->offset is zero or not. We can not do that before
   skb_page_frag_refill(), because skb_page_frag_refill() may allocate
   new page, the frag->offset is zero. So the judgment must is after
   skb_page_frag_refill().

Thanks.


>
> >
> > I think this problem is clear, though I do not know why it did not work
> > for Darren.
>
> I had a try. This issue could be reproduced easily and this patch
> seems to fix the issue with a KASAN enabled kernel.
>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index c6af18948092..e5286a6da863 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receiv=
e_queue *rq, u32 size, gfp_t gfp)
> > > > > >         void *buf, *head;
> > > > > >         dma_addr_t addr;
> > > > > >
> > > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gf=
p)))
> > > > > > -               return NULL;
> > > > > > -
> > > > > >         head =3D page_address(alloc_frag->page);
> > > > > >
> > > > > >         dma =3D head;
> > > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtn=
et_info *vi, struct receive_queue *rq,
> > > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > >
> > > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag=
, gfp)))
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > > >         if (unlikely(!buf))
> > > > > >                 return -ENOMEM;
> > > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct =
virtnet_info *vi,
> > > > > >          */
> > > > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len,=
 room);
> > > > > >
> > > > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_fr=
ag, gfp)))
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       if (!alloc_frag->offset && len + room + sizeof(struct v=
irtnet_rq_dma) > alloc_frag->size)
> > > > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > > > +
> > > > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > > >         if (unlikely(!buf))
> > > > > >                 return -ENOMEM;
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > >
> > >
> >
>

