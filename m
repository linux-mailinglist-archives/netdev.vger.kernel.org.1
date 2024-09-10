Return-Path: <netdev+bounces-126810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2266972961
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B52285C0F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C5172773;
	Tue, 10 Sep 2024 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Za70h5tb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F45144D0C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949051; cv=none; b=Rk9hslfZ9PIsJNS+YNfP+j1RFqy5UkTjN6OKJ0O4BJtX9r5xcwAcG7DT00KdZoqvLPG/HXJnuzijR8Z03gSauRhiYoCjR9QszwQRibl1cCbT+vgmtsmqv+NQ0vsRHeuO7XEWh6C00F9yrQRAokFgDdGGKNrvVLBcmgyRw8iC2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949051; c=relaxed/simple;
	bh=apSLvM16KuVNlK4P/CKuNN6/KBmqfvU9I1gYpnamwq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obmo4CKqjQ4ECa2F+QhhjR+Wus4VdCN9uxSve3RC9jCz7vQ1ujro44WEaBEzYjZHvpy5KXmQjjonHrWEnNyHX/tqXtkSguX87AERC0DLgdTzg/T1XRkd7SSw0SHnrUbEhf3LkDuK3C7253FmNyEInw/7K3QvrAd5vLGNi4d7Lvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Za70h5tb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725949048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bj0nMfxoMR9WYn/fCaj2CQbQuewmYvIdWgi5BIJAKQ0=;
	b=Za70h5tblc5KNbocfezLNuQHQCMt+S943eM/1DGAmXDRsPoU4cp91loa58RcrJo+lkcn0h
	tKQjoyp2NYSeZkFTrV7jjy0C5BkpYNtrb+QB5g+lHffWlsmhjgmc6c9I/yB6h5fd+lRiZt
	5ujCUN8ZoN76x031ef62NZugwQALMTY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-BGDe6ZJ2MDuB6tauDfFdtQ-1; Tue, 10 Sep 2024 02:17:25 -0400
X-MC-Unique: BGDe6ZJ2MDuB6tauDfFdtQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso339835a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 23:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949044; x=1726553844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj0nMfxoMR9WYn/fCaj2CQbQuewmYvIdWgi5BIJAKQ0=;
        b=QQfcUFwDMp4QrnDy8nSTkxfHWJ/2eBFoP7OdqaOmqdqtBUu/MJ8+xHVqAOHNg5F2c4
         DMg1+2MvcWe2BR62lXQXcLXsLwgjqhGuKBbUCCv/IF5NVj/T/hpu62XUoXuGYJrsbyza
         KuG2E2ceuAW2nMNu8dgX7RVxL3rQN7UmFy9HsCcbUaqDs7s+DDccCmgxyDz/3I6EUJkk
         Ai2LNnRC3nOMA4vL+4CPWcq3Ut1vlAq7Hqn6seYg0xHAwq5Q+WwxRa/L8ikEnPMSpxgs
         8ifCNdyjkFkDCmWsMNYft5ygwXz2Pxieg5cdYax9zik1p39M87BS9IlYRGNjQlIH+SNT
         UNow==
X-Forwarded-Encrypted: i=1; AJvYcCWQWIRiWVcTkWSjw5GbEj/34E99HF7EZPTYgpxUMbE2rv8jFgjQrOEgEVsi3MGbRT0E2Vovv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOOXh+bc55qB5cGkfYZZZ7bIBLlVQaC1pg2tVeQBpgSXZwVj4
	mzNkUfmjRbhSPauJ4C7hmGdRODFGZu3bH3WM0aYZVCWrUN7xyGHVXJVB0j+24BQ3jaADUE73e5s
	/N4O2FvR64uI21PnP44TU69VUpp2Q5mb8MtuapyGJbYzvcDvOcYwYrFFyGQ4g7X0BiMCM2dMAKQ
	KhQMu0uWjC5VY8QIUb3XCnEzZYSq54
X-Received: by 2002:a17:90b:48d0:b0:2d8:9c97:3c33 with SMTP id 98e67ed59e1d1-2dad50e87f5mr11817676a91.28.1725949044454;
        Mon, 09 Sep 2024 23:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKc+OqQ9yWduDtl0C+YOrPtPAFc1naFHJxIYbXwEhs4t4ljMH4mChR8cgk7DUVT3rKLtmssrTfEVBU0bCb2HA=
X-Received: by 2002:a17:90b:48d0:b0:2d8:9c97:3c33 with SMTP id
 98e67ed59e1d1-2dad50e87f5mr11817656a91.28.1725949043908; Mon, 09 Sep 2024
 23:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240908153930-mutt-send-email-mst@kernel.org> <1725851336.7999291-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvirXU9816r31UCUz8ne-URj-h-txG6Ozd8vwBp-=sbSQ@mail.gmail.com> <1725871860.6174653-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1725871860.6174653-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 14:17:12 +0800
Message-ID: <CACGkMEtvabru_uja8chVhLC27pDoP6y_mBqTKEmN1ohWuAQFPw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Mon, 9 Sep 2024 16:47:02 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Mon, Sep 9, 2024 at 11:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Sun, 8 Sep 2024 15:40:32 -0400, "Michael S. Tsirkin" <mst@redhat.c=
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
> > > > BTW why isn't it needed if we revert f9dac92ba908?
> > >
> > >
> > > This patch fixes the bug in premapped mode.
> > >
> > > The revert operation just disables premapped mode.
> > >
> > > So I think this patch is enough to fix the bug, and we can enable
> > > premapped by default.
> > >
> > > If you worry about the premapped mode, I advice you merge this patch =
and do
> > > the revert[1]. Then the bug is fixed, and the premapped mode is
> > > disabled by default, we can just enable it for af-xdp.
> > >
> > > [1]: http://lore.kernel.org/all/20240906123137.108741-1-xuanzhuo@linu=
x.alibaba.com
> >
> > Though I think this is a good balance but if we can't get more inputs
> > from Darren. It seems safer to merge what he had tested.
>
> So you mean just merge this:
>
>         http://lore.kernel.org/all/20240906123137.108741-1-xuanzhuo@linux=
.alibaba.com
>
> Right?

It looks to me it hasn't been tested by Darren yet.

Thanks

>
> Thanks
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
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
> > > > >     void *buf, *head;
> > > > >     dma_addr_t addr;
> > > > >
> > > > > -   if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > > -           return NULL;
> > > > > -
> > > > >     head =3D page_address(alloc_frag->page);
> > > > >
> > > > >     dma =3D head;
> > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > >     len =3D SKB_DATA_ALIGN(len) +
> > > > >           SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > +   if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)=
))
> > > > > +           return -ENOMEM;
> > > > > +
> > > > >     buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > >     if (unlikely(!buf))
> > > > >             return -ENOMEM;
> > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct vi=
rtnet_info *vi,
> > > > >      */
> > > > >     len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room)=
;
> > > > >
> > > > > +   if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gf=
p)))
> > > > > +           return -ENOMEM;
> > > > > +
> > > > > +   if (!alloc_frag->offset && len + room + sizeof(struct virtnet=
_rq_dma) > alloc_frag->size)
> > > > > +           len -=3D sizeof(struct virtnet_rq_dma);
> > > > > +
> > > > >     buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > >     if (unlikely(!buf))
> > > > >             return -ENOMEM;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>


