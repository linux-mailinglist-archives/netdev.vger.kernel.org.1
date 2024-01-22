Return-Path: <netdev+bounces-64535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9775A835A05
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 05:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30DA1C2192B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B94A32;
	Mon, 22 Jan 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwEVtC7i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129E1FA4
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897147; cv=none; b=Ls8kpsHnCr6+x/nJMFLDGWqN9pYLnFdRwS3JjyKNHy6y5F8kSWek4o8CbH1mIGkweOwaI44mfpVWnpWhVHxnL/G4VFJcXv9WL+X93vZFJkIPzyYyeRXzD+dX2edgn0MF4tMHLEKoOJsuaILH7c1qGakmocKgcsCI8x9CQX49V3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897147; c=relaxed/simple;
	bh=Eec/WKAE2PzQjmyeeX450K95J0F0Wq+tXrRlsoNb/tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVxHrKkEnBFpORfFopLw1c0TusYp5EwD0Vd1rUMDC0XokV4b2spha9slh0a3TN2paCgyL2lDpw2Rjq4wgye72j+gekz3fayi/Bk/RW5xzcj1Csekgbzz0izff4S6fgZPG3Ft8p75Z704VDwSBcOtZW5Z70Inq1dQEpjPEkjxTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwEVtC7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOra4+3WkvmQK52hu1wsPjdf+F8jne7oahqaHbNMAuM=;
	b=IwEVtC7iBtAhOgpYl2A40hV+O4kuzL/sPnUD8Gv1hmVlDpvXf0nPUmppyvCRtME78Xa9yM
	KfCu24rkHhBqOhS+TMLsDVBmi34MG0luvyTCs0W6wyuXm0mwiAGLlQZ6Z9QpivGuGYjU8o
	5khfHP9w1MIxu1HwUEWtKZGxpAaBUGo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-DPfYZd7uNNCZyLIYA3tiVg-1; Sun, 21 Jan 2024 23:19:03 -0500
X-MC-Unique: DPfYZd7uNNCZyLIYA3tiVg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3bdcd87fso4711062b6e.3
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 20:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897142; x=1706501942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOra4+3WkvmQK52hu1wsPjdf+F8jne7oahqaHbNMAuM=;
        b=F53VGCYendFRdgMFhjXd3WHUVj2xs1E+804cKSpcUqjXkdDkYoLdtinOOmGtnEDi3d
         sSvEUBitSMzB4f2F9yt4ESfJznidwDV5O3IHp+6VWgQCiyl7/wWUcLIGUuKxv2jn3RqV
         zjNkSzXzqfAA6Cgj/DoCNH21foVYsxlw46IX2aOgEQskpinLWhtg44IoMAOwptIWK/Bv
         nHfnmq6GEPKFogox9T7YyII908d4t95K/4dEaSBV6uLmyP669XnAvlx5QVKRS6njaKzZ
         MUJomYtctn0ISB+dAsQlNKnAJZOVlHtwyDO+m0cF33Q7ao8EOzMJ4B3IDx01a/Ek/Bdf
         jCmw==
X-Gm-Message-State: AOJu0Yz16e84WT8w/abXEC9NZDuWt2irFfyLp82n37WBSN0+pb5CZbt+
	EbmVR+vY2ASxuuht0lE016D/egmKw4FlcyaI860N1T3igPpLx+csCKLkcWg/6oA0qJ9MMYA8ZDb
	Fbr6acQfVB7czDUt74bWOBgGh3Kry89NOHDG8j519Z9r8C/NCZERHGCw/itl3VmXZYioHzTYpFX
	X6O8i5pc0JDY28wNstHblPAbwsY1do
X-Received: by 2002:a05:6808:199e:b0:3bd:b503:90aa with SMTP id bj30-20020a056808199e00b003bdb50390aamr2297119oib.17.1705897142590;
        Sun, 21 Jan 2024 20:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF71j0bIeUwRrUjJww1p1VJ6O+pK4kbCDGkvc5YymXjMm81KRYqPckvaAIe2BEMr2jt2TgoQvfS1Xn+Olz+JI=
X-Received: by 2002:a05:6808:199e:b0:3bd:b503:90aa with SMTP id
 bj30-20020a056808199e00b003bdb50390aamr2297108oib.17.1705897142387; Sun, 21
 Jan 2024 20:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
 <20231229073108.57778-7-xuanzhuo@linux.alibaba.com> <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
 <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:18:51 +0800
Message-ID: <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > get buf from virtio core for premapped mode.
> > >
> > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > have many desc. Every desc dma address need to be unmap. So here we
> > > introduce a new helper to collect the dma address of the buffer from
> > > the virtio core.
> > >
> > > Because the BAD_RING is called (that may set vq->broken), so
> > > the relative "const" of vq is removed.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++--------=
--
> > >  include/linux/virtio.h       |  16 ++++
> > >  2 files changed, 142 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 51d8f3299c10..1374b3fd447c 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct=
 vring_virtqueue *vq)
> > >         return vq->dma_dev;
> > >  }
> > >
> > > +/*
> > > + *     use_dma_api premapped -> do_unmap
> > > + *  1. false       false        false
> > > + *  2. true        false        true
> > > + *  3. true        true         false
> > > + *
> > > + * Only #3, we should return the DMA info to the driver.
> >
> > Btw, I guess you meant "#3 is false" here?
> >
> > And could we reduce the size of these 3 * 3 matrices? It's usually a
> > hint that the code is not optmized.
>
> On the process of doing dma map, we force the (use_dma_api, premapped).
>
> if premapped:
>      virtio core skip dma map
> else:
>         if use_dma_api:
>                 do dma map
>         else:
>                 work with the physical address.
>
> Here we force the (premapped, do_unmap).
>
> do_unmap is an optimization. We just check this to know should we do dma =
unmap
> or not.
>
> Now, we introduced an new case, when the virtio core skip dma unmap,
> we may need to return the dma info to the driver. That just occur when
> the (premapped, do_unmap) is (true, false). Because that the (premmaped,
> do_unmap) may be (false, false).
>
> For the matrices, I just want to show where the do_unmap comes from.
> That is a optimization, we use this many places, not to check (use_dma_ap=
i,
> premapped) on the process of doing unmap. And only for the case #3, we sh=
ould
> return the dma info to drivers.

Ok, it tries to ease the life of the readers.

I wonder if something like

bool virtqueue_needs_unmap() can help, it can judge based on the value
of use_dma_api and premapped.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
>


