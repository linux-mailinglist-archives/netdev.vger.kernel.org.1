Return-Path: <netdev+bounces-126846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0592972A99
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8811F250C4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC317CA17;
	Tue, 10 Sep 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ivyMV4lZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AB17C235
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953078; cv=none; b=EbYVw7xVlBbQYsG/qDiRHMb9i1JSRfpDQe7dNQ/fJmJScVrQGEz3XuMsQJe4eZW7rrs3ZVb4baNikZRh1fL8z3UXtD4lRakjQysDTZmoz7crbCquEyyxquFAQfu8vOy+gLgo77v6UhNaZ7wp3VQZocqxArObruqPLLPPD4oaGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953078; c=relaxed/simple;
	bh=7IwH6haEzm4Rqu9LhJPD6LyGBW+mJ8G7P53oZ1NG8Ho=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mx0kuO4w8/4tNeGDDKiIeV8/ttHj87fsRgm3iBdYkA/o7UT2I6syVWQTpBDZFmm5ZASVX/sLS5cNajfPG9t6Z+oxsgetAf+T9Ui66/eCKyL/rgRZ89HFKDlcYNURKauuUGyL61lx+HpOg2Ig6VDTfRABZ3eEbMw4/cBvIKOdTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ivyMV4lZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725953066; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=a9GoHLXpUy/hLCKhmaTHAFlem+4f1TgxKJ2Pj4ZexRk=;
	b=ivyMV4lZc3weYhRp/ee553b6o76fhV9Sk6cbUwyTPPD4/XWtl1qdTtqG+x7QvCJCsq0+oIu6iO+4FniqI36xOlBca/Lqak/OulS3GL0Phm7D30j8D2Ejj4s1/Rx8Hb+dScVT7Icg3Nze1ifgfnDPbCu3T89RBqBv/LY12qTzRTc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEjOwzz_1725953065)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 15:24:26 +0800
Message-ID: <1725952844.7580578-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Tue, 10 Sep 2024 15:20:44 +0800
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
 <1725871401.4568927-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvfC=Jf169V-J7oU5Z3QY7ET7L5NH_WJvC2gsDYV2wfHg@mail.gmail.com>
In-Reply-To: <CACGkMEvfC=Jf169V-J7oU5Z3QY7ET7L5NH_WJvC2gsDYV2wfHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 10 Sep 2024 14:18:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Sep 9, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Mon, 9 Sep 2024 16:38:16 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Fri, Sep 6, 2024 at 5:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@re=
dhat.com> wrote:
> > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > >
> > > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > > >
> > > > > > > > which could see reliable crashes or scp failure (scp a file=
 100M in size
> > > > > > > > to VM):
> > > > > > > >
> > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at t=
he beginning
> > > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > > everything is fine. However, if the frag is only one page a=
nd the
> > > > > > > > total size of the buffer and virtnet_rq_dma is larger than =
one page, an
> > > > > > > > overflow may occur. In this case, if an overflow is possibl=
e, I adjust
> > > > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, =
the maximum
> > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disa=
ble=3D0, only
> > > > > > > > the first buffer of the frag is affected.
> > > > > > > >
> > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode wh=
atever use_dma_api")
> > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-=
ba164a540c0a@oracle.com
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > >
> > > > > > >
> > > > > > > Guys where are we going with this? We have a crasher right no=
w,
> > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > work Xuan Zhuo just did.
> > > > > >
> > > > > > I think this patch can fix it and I tested it.
> > > > > > But Darren said this patch did not work.
> > > > > > I need more info about the crash that Darren encountered.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > So what are we doing? Revert the whole pile for now?
> > > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > > for this release.
> > > >
> > > > @Jason Could you review this?
> > >
> > > I think we probably need some tweaks for this patch.
> > >
> > > For example, the changelog is not easy to be understood especially
> > > consider it starts something like:
> > >
> > > "
> > >     leads to regression on VM with the sysctl value of:
> > >
> > >     - net.core.high_order_alloc_disable=3D1
> > >
> > >     which could see reliable crashes or scp failure (scp a file 100M =
in size
> > >     to VM):
> > > "
> > >
> > > Need some context and actually sysctl is not a must to reproduce the
> > > issue, it can also happen when memory is fragmented.
> >
> > OK.
> >
> >
> > >
> > > Another issue is that, if we move the skb_page_frag_refill() out of
> > > the virtnet_rq_alloc(). The function semantics turns out to be weird:
> > >
> > > skb_page_frag_refill(len, &rq->alloc_frag, gfp);
> > > ...
> > > virtnet_rq_alloc(rq, len, gfp);
> >
> > YES.
> >
> > >
> > > I wonder instead of subtracting the dma->len, how about simply count
> > > the dma->len in len if we call virtnet_rq_aloc() in
> > > add_recvbuf_small()?
> >
> > 1. For the small mode, it is safe. That just happens in the merge mode.
> > 2. In the merge mode, if we count the dma->len in len, we should know
> >    if the frag->offset is zero or not. We can not do that before
> >    skb_page_frag_refill(), because skb_page_frag_refill() may allocate
> >    new page, the frag->offset is zero. So the judgment must is after
> >    skb_page_frag_refill().
>
> I may miss something. I mean always reserve dma->len for each frag.

This problem is a little complex.

We need to consider one point, if the frag reserves sizeof(dma), then
the len must minus that, otherwise we can not allocate from the
frag when frag is only one page and 'len' is PAGE_SIZE.

Thanks.


>
> But anyway, we need to tweak the function API, either explicitly pass
> the frag or use the rq->frag implicitly.
>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > >
> > > > I think this problem is clear, though I do not know why it did not =
work
> > > > for Darren.
> > >
> > > I had a try. This issue could be reproduced easily and this patch
> > > seems to fix the issue with a KASAN enabled kernel.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_=
net.c
> > > > > > > > index c6af18948092..e5286a6da863 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct re=
ceive_queue *rq, u32 size, gfp_t gfp)
> > > > > > > >         void *buf, *head;
> > > > > > > >         dma_addr_t addr;
> > > > > > > >
> > > > > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag=
, gfp)))
> > > > > > > > -               return NULL;
> > > > > > > > -
> > > > > > > >         head =3D page_address(alloc_frag->page);
> > > > > > > >
> > > > > > > >         dma =3D head;
> > > > > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct v=
irtnet_info *vi, struct receive_queue *rq,
> > > > > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info)=
);
> > > > > > > >
> > > > > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_=
frag, gfp)))
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > > > > >         if (unlikely(!buf))
> > > > > > > >                 return -ENOMEM;
> > > > > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(str=
uct virtnet_info *vi,
> > > > > > > >          */
> > > > > > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_=
len, room);
> > > > > > > >
> > > > > > > > +       if (unlikely(!skb_page_frag_refill(len + room, allo=
c_frag, gfp)))
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       if (!alloc_frag->offset && len + room + sizeof(stru=
ct virtnet_rq_dma) > alloc_frag->size)
> > > > > > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > > > > > +
> > > > > > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > > > > >         if (unlikely(!buf))
> > > > > > > >                 return -ENOMEM;
> > > > > > > > --
> > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > >
> > > > >
> > > >
> > >
> >
>

