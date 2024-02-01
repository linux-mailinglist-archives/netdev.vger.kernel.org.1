Return-Path: <netdev+bounces-67826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C828450CB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E31F21B06
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 05:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E95FB81;
	Thu,  1 Feb 2024 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJpqtHj3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767F5F864
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765823; cv=none; b=f8qo4LeIRJ+Mw/OLX+1aBVZSqsAdWdyOHtk/Gk8fF+eF+RU2rj821DNNR9JQ19xXctZxyHwDVOEH44/fLSfTgQv9AStvfHcPCZWT1GjsbcSMR76OJUTE0zkAdmaNvX5YgHWYAu6ol3DSGegjbJ2Sp0RC7rIk9HPBd/CfyVem13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765823; c=relaxed/simple;
	bh=nra6zzS/JRV+K8QeyJAd/CD5xcBuEEvMa9M/FPya1sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP/Jwkt3jHCaABlxObN3xL+WBswud9eM7c4QPXE5A4FH6ebDi9q200f/Lhg+b18esAzf5rmexdsVJnpMfE1tRPDPrLwz2/RQRNKmQOJjF+SIL/zmRJBdkWu1zpBqh5Ek6D67kdIQ04P2xlrkGpFuzHRhB0lQQVhF5VVb2qDFABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJpqtHj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706765819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/fQ0BH5F2aehQQU9Gk1vRqtQBHCGxxy5UgZLwBpWwA=;
	b=NJpqtHj3xL788JiSGvwTNodo39tutvNM6uXAVdsgRQ2SzE+3PrbKBzWoN040+JdTRCS5gd
	R/zal2HPi8lwaVMgZ6637bOecxYSRaX4uT30ySTBURWpIpbQhKuEvcc6o+9ijoM/WRe21b
	IyXNmKfLLYGkIMc3HjEwueVbiKe+8Is=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-470V2BGmNP-h61UzThwx3Q-1; Thu, 01 Feb 2024 00:36:58 -0500
X-MC-Unique: 470V2BGmNP-h61UzThwx3Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so629342a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706765817; x=1707370617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/fQ0BH5F2aehQQU9Gk1vRqtQBHCGxxy5UgZLwBpWwA=;
        b=QTSIi75udfFlD4A7kdQrGOWE+jNkjsMjaYxPx8auXtkAiyf4iRhBhZOEYU8XEppTbz
         ePG9ASMyBaQcvif9q/uMjRP2CiYvIFgZiyq/j6qZENDfykXVA5tTMPGWlrPBX1ajkbF3
         kTBwmA6VH2LYdzhjaq4/FTb47P8MHkrfPwONA9v8lNSg6/IeBc0q2sFjeOomPZZr2YJA
         9FR2LyLWBKaSa+tapp76dcBoPNKxu2VeOhhxIKam1zlwP4S/3pTfDDdDQ/tnEaE+y5v+
         spZaSIBWKOdpnshzGTXWhGpIGKT6VYOGPMVgugWIRHkcSTjaPFv/OiJ0sfvzlNWRnqwC
         XCaw==
X-Gm-Message-State: AOJu0YwDbPnzxxfAi5TlmyU+A0AC+dc5+c9VNtmQGsQAr4iX/jqE7GF1
	gX9g25N5VqLr85Ezld4fSKY0rvvEhMUK4kUAVdntNLJ88Vb14TSvQGLtYizTqVHMC1r/UvCrpyV
	iXmy36RP8DihnNuFF9BJQ36HXZOiO46sKRZlXupOawMXJT+4ya6Mf7XX792BvRGntQXXQuZamVA
	sGtQbMme3E/EURYVHkzLkha2JCBbDC
X-Received: by 2002:a05:6a20:b187:b0:19c:a7a6:b08c with SMTP id ee7-20020a056a20b18700b0019ca7a6b08cmr3151729pzb.54.1706765817501;
        Wed, 31 Jan 2024 21:36:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC98+e+ZVl0QjGVZJGSE0np67yelG/88VrkADMcR5q9/YnOQsbM9n3sTAE+dwx9ePkpUzVuqoXNByTryM9dKQ=
X-Received: by 2002:a05:6a20:b187:b0:19c:a7a6:b08c with SMTP id
 ee7-20020a056a20b18700b0019ca7a6b08cmr3151696pzb.54.1706765817237; Wed, 31
 Jan 2024 21:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-18-xuanzhuo@linux.alibaba.com> <CACGkMEv2cyuesaTx899hwZt7uDdqwmAwXJ8fZDv00W9FbVbTpw@mail.gmail.com>
 <1706757660.3554723-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706757660.3554723-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:36:46 +0800
Message-ID: <CACGkMEtwWAijrLOrdgJ9ZPx5VjSfJtwVm1k1U8fsg9+tvgRHxg@mail.gmail.com>
Subject: Re: [PATCH vhost 17/17] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:28=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 31 Jan 2024 17:12:47 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 167 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 163 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 226ab830870e..cf0c67380b07 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
> > >  #define VIRTIO_XDP_REDIR       BIT(1)
> > >
> > >  #define VIRTIO_XDP_FLAG        BIT(0)
> > > +#define VIRTIO_DMA_FLAG        BIT(1)
> > >
> > >  /* RX packet size EWMA. The average packet size is used to determine=
 the packet
> > >   * buffer size when refilling RX rings. As the entire RX ring may be=
 refilled
> > > @@ -140,6 +141,21 @@ struct virtnet_rq_dma {
> > >         u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +       union {
> > > +               struct virtnet_sq_dma *next;
> > > +               void *data;
> > > +       };
> > > +       dma_addr_t addr;
> > > +       u32 len;
> > > +       bool is_tail;
> > > +};
> > > +
> > > +struct virtnet_sq_dma_head {
> > > +       struct virtnet_sq_dma *free;
> > > +       struct virtnet_sq_dma *head;
> >
> > Any reason the head must be a pointer instead of a simple index?
>
>
> The head is used for kfree.
> Maybe I need to rename it.
>
> About the index(next) of the virtnet_sq_dma.
> If we use the index, the struct will be:
>
> struct virtnet_sq_dma {
>        dma_addr_t addr;
>        u32 len;
>
>        u32 next;
>        void *data
> };
>
> The size of virtnet_sq_dma is same.

Ok.

>
>
> >
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct send_queue {
> > >         /* Virtqueue associated with this send _queue */
> > > @@ -159,6 +175,8 @@ struct send_queue {
> > >
> > >         /* Record whether sq is in reset state. */
> > >         bool reset;
> > > +
> > > +       struct virtnet_sq_dma_head dmainfo;
> > >  };
> > >
>
> ....
>
> > > +
> > > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> > > +{
> > > +       struct virtnet_sq_dma *d;
> > > +       int size, i;
> > > +
> > > +       size =3D virtqueue_get_vring_size(sq->vq);
> > > +
> > > +       size +=3D MAX_SKB_FRAGS + 2;
> >
> > Is this enough for the case where an indirect descriptor is used?
>
>
> This is for the case, when the ring is full, the xmit_skb is called.
>
> I will add comment.

Just to make sure we are at the same page.

I meant, we could have more pending #sg than allocated here.

For example, we can have up to (vring_size - 2 - MAX_SKB_FRAGS) *
MAX_SKB_FRAGS number of pending sgs?

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


