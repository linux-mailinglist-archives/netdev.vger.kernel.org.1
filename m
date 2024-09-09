Return-Path: <netdev+bounces-126429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008F97123D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD1A281098
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A961B1437;
	Mon,  9 Sep 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YttxzTkP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D1176246
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871115; cv=none; b=hmz/zX17DhppYRxM+htruskiuq65T14kBdgVIww5xxhJ5dLOQUmgmJb+ixWsJ8SYRSKZW+fcR5zHnbwuy/LM+/HrPCoSBVTMrx+KT1ke4h1UMEk+MjCd9BvjsPHvBSZ9l9jk0DkLmR8heg2F92+QXsW1Q69s5Ka+idkgONX5B0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871115; c=relaxed/simple;
	bh=zVEcBD+3ykM/XDeE6mmT2VSdshOt2EblcTEOJFfHh5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1xtx3KZTosm1l1gEch+6K/u1B312KoGNdgBWtgKw//q0AlAk5G9+eqh9TjKHFclnUMLNRe7TSrq05n5olDGuPyB1utniz1unXvc9YeIIqF4KQWT8pwxYKVQoP+AxeqMXB8vEafaw0v2M8haL1ZxOOOHkVf48A+T4GrXypEvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YttxzTkP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725871112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krv/geMIzelSmSJ8w0OjsqkM55iDto6Ca93etdR5PI8=;
	b=YttxzTkPWXWZ5G5dalNeOVEMNI4hivOVGvPcjtLBsFsQq/R7ExxVBXxcqqkyZI+kRZIieL
	NVG/nELsJJNEzGcrMGfwH620ha+hbE3ve2W1tbem2PQXPXavqGRTcuBxHCQjT1yNYCrpRy
	v6uwChTb8sB5lVR9eB0B8cgaskTCMLs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-8txKVCGFM7Oe2wlxSVqeRQ-1; Mon, 09 Sep 2024 04:38:31 -0400
X-MC-Unique: 8txKVCGFM7Oe2wlxSVqeRQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8a1a63f3dso4388575a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871110; x=1726475910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Krv/geMIzelSmSJ8w0OjsqkM55iDto6Ca93etdR5PI8=;
        b=dvMRCXBgUomdDKsQjpC7qOTZQDF21gDKFnrZUtFHrwf1OzSRQslc9J3jA4V0oINdab
         1S7Sk727GdkYO36CrxX/inWlC+3ni2E06WOSVy2g5Rm9ZmE8UrrDrut3Vqduc4nrPcRN
         O691ISlAKrrD+zyAMBqFkT/q2hI1wD4bJq/dbCxIEG/InNUQxWzQ9HBuGrqLwHaulMfz
         q+PA6Vrlr3qanOPmOvTx4TW5eEm3r1+x69eoZF3x5XyeaV//TdmQc0VvbcqoBXmIUroB
         vGTIWNZjRLUQhf9qHkbyG3Z8qF1d3Q2wFoYquoe+219awmsy9nxlpav17FXtuo/dxHMY
         ptSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkrnoNOWrm6zkzw1bWNv2RRbERxgkHz7K2ZlvhL8Jz4E+M9Ab4tubkUPfuoifVrR3mZ5t23Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/fiaKPNqvp7mVeYbC0nf07PF1VAvNXZ3ODkwqZGMbGmZKS+T
	2nspSWofQvP6pFHeuIOpX3rx48DmcGfba4OGq4yNyu0YfhV0bW997SddP2u2V5t6wQwYhJPK4e6
	TCzAmiOG/Ie+bPctU/h6J+V0rmcemYbGtAHVZIVxg29o+681uCy0NegFry+hDIUSRKvjT9Mc+hY
	y8Joab5x+ap+rJCsVcVrmKDaU/RMV1
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr7658861a91.40.1725871109697;
        Mon, 09 Sep 2024 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQYgAZQeWv5/kCTe63E0d+azPK0nA5/zjAGcSeHbPrkeYpXNNIwvTRsiLsbwJV7pYomo8GsqnxKmtZW2QW6w=
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id
 98e67ed59e1d1-2dad513a8d5mr7658840a91.40.1725871109068; Mon, 09 Sep 2024
 01:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 16:38:16 +0800
Message-ID: <CACGkMEt4XmMnZWEK56npxiA_QB0x48AU9fWfA63y5PHuHpLdBQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > leads to regression on VM with the sysctl value of:
> > > > >
> > > > > - net.core.high_order_alloc_disable=3D1
> > > > >
> > > > > which could see reliable crashes or scp failure (scp a file 100M =
in size
> > > > > to VM):
> > > > >
> > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beg=
inning
> > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > everything is fine. However, if the frag is only one page and the
> > > > > total size of the buffer and virtnet_rq_dma is larger than one pa=
ge, an
> > > > > overflow may occur. In this case, if an overflow is possible, I a=
djust
> > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, the ma=
ximum
> > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D=
0, only
> > > > > the first buffer of the frag is affected.
> > > > >
> > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever=
 use_dma_api")
> > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a=
540c0a@oracle.com
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > >
> > > > Guys where are we going with this? We have a crasher right now,
> > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > work Xuan Zhuo just did.
> > >
> > > I think this patch can fix it and I tested it.
> > > But Darren said this patch did not work.
> > > I need more info about the crash that Darren encountered.
> > >
> > > Thanks.
> >
> > So what are we doing? Revert the whole pile for now?
> > Seems to be a bit of a pity, but maybe that's the best we can do
> > for this release.
>
> @Jason Could you review this?

I think we probably need some tweaks for this patch.

For example, the changelog is not easy to be understood especially
consider it starts something like:

"
    leads to regression on VM with the sysctl value of:

    - net.core.high_order_alloc_disable=3D1

    which could see reliable crashes or scp failure (scp a file 100M in siz=
e
    to VM):
"

Need some context and actually sysctl is not a must to reproduce the
issue, it can also happen when memory is fragmented.

Another issue is that, if we move the skb_page_frag_refill() out of
the virtnet_rq_alloc(). The function semantics turns out to be weird:

skb_page_frag_refill(len, &rq->alloc_frag, gfp);
...
virtnet_rq_alloc(rq, len, gfp);

I wonder instead of subtracting the dma->len, how about simply count
the dma->len in len if we call virtnet_rq_aloc() in
add_recvbuf_small()?

>
> I think this problem is clear, though I do not know why it did not work
> for Darren.

I had a try. This issue could be reproduced easily and this patch
seems to fix the issue with a KASAN enabled kernel.

Thanks

>
> Thanks.
>
>
> >
> >
> > > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index c6af18948092..e5286a6da863 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_=
queue *rq, u32 size, gfp_t gfp)
> > > > >         void *buf, *head;
> > > > >         dma_addr_t addr;
> > > > >
> > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)=
))
> > > > > -               return NULL;
> > > > > -
> > > > >         head =3D page_address(alloc_frag->page);
> > > > >
> > > > >         dma =3D head;
> > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, =
gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct vi=
rtnet_info *vi,
> > > > >          */
> > > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, r=
oom);
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag=
, gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       if (!alloc_frag->offset && len + room + sizeof(struct vir=
tnet_rq_dma) > alloc_frag->size)
> > > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > > +
> > > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >
>


