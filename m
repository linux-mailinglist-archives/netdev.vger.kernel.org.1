Return-Path: <netdev+bounces-81476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDF889F8D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B72E025C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFDA1769E5;
	Mon, 25 Mar 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNPcrKOi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A5181309
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350657; cv=none; b=K37XNHIHODAYfoqJyH2gEggPlPFd1oHPDQchhlCt+1oSUaFExZSliieMluUjJ4DEFN4z0C5W9z7hTcQEwpmfU8WNNTwKFA3Tno9Kig1mYBEQE7lCVJf7VvCo2VhnPhoD5uZxkzKMmv8gSih7qDvs7Ocj30KC3cliWDewymU8Stg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350657; c=relaxed/simple;
	bh=VDqqc4FaS3nqEG410984TzqLk1OgwsUduElIlSglyJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTik3eH5SpM1J8QAaSAu/rRRBotqxo/hY3TVY/TVnkdovj95ZXLXSldjCo2bp77s/4aFOEE7hiay2DqMeiO7Lz7f7NGOP109vYh3hz7HEtDzpYl3GEqRCY0Bpr8evARBSaPNSxB0ziUxzIf9KW8yqg1jA0ShCz/ygIwKwvp4RQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNPcrKOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711350655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3FtN9QE0Nl7sj3xGWxMvMJxRPeJKkkDH54Kwbx0i5I=;
	b=XNPcrKOinux2kpXcr5XKhQC6/LB1gMAxCLeuWB/zCE2w9JM1ILp2tPr0q0YhLchU3zog//
	sGVw+zTkKIR36AzdL9Oyr5j3LDTMllgSHtc1iW2R7FwYB3nh17mi/M5LyTboLnSf/vEMmq
	VXiIMs59Xs9wKRB3X0j6ZLHXYi1DNgM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-DPF8vB_bOpu8y1OE8mPjGg-1; Mon, 25 Mar 2024 03:10:53 -0400
X-MC-Unique: DPF8vB_bOpu8y1OE8mPjGg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so2755191a12.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 00:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350652; x=1711955452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3FtN9QE0Nl7sj3xGWxMvMJxRPeJKkkDH54Kwbx0i5I=;
        b=X/OTU9iZFeLIRk4jPGHpOEBUu7E+jK9EUedBcPU3gTUzPmu6DP/aB7aEuoZIck828h
         GUTidzzFPJsz1Slo6cjfnV0lJPtNflXTMcXtjlIJrmhLzpCr/M87ZgFSX8viUq8qNx7a
         MhjZIMRd9FBogviDysSy+7F4Ez5iStx4LlcTf8CN6+JlPcITO1OC9TykMwkDqZkALOv8
         ySxwXnBCbroHqaixZJ1ZovAjnf6/BZ2TM1+1T1j+FObzknV2aeOBnfM3YLtf9O7Mk8wo
         IUFFnEKvweYQ/FxC3JA3K6l4ogwWAeFvzbVIb/q1G8OkYnJcJS6breAVdJiy1c4JZirK
         v/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUI67LWdGlKZkAdnZxpmalO6QS57lZl5hp+CYvnR64am4EST0ZutJ5khg3qnd1HYi9hejg5LO6iOkTWsXUAB+7IBrMEFJpb
X-Gm-Message-State: AOJu0YwfcVFZHP2G/jqBBgRxk++Ty8hKuXiY81M/L+c/8TyQ5Ok6AN4o
	FDGvfBbOuQjA4JIHXs0ntiU3H//QQvgxB2SBNkvaVkcuw4U8AcofEBTIpA17Z1Rud29cqfwyeAP
	FBHem9QgkFa4j/QvZ+RLGmxixSO4CbKH4po33pTC78sQcutLIwx7LHP60cLLMwRGBV2ZlLSnZWz
	xd0pavsJ/H6U6+55Rds7CpAyoQ4vEqLuwt1Yxi
X-Received: by 2002:a17:903:2ad0:b0:1e0:188c:ad4f with SMTP id lw16-20020a1709032ad000b001e0188cad4fmr7647661plb.26.1711350651805;
        Mon, 25 Mar 2024 00:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGryY0YwWrPcst5KxEzpJoy49ptg72bCQ1X4IHF3d4AYLcbOYwvZO8qUUvQddrOyR4NNHcKKNV1UBmnZjG7XvE=
X-Received: by 2002:a17:903:2ad0:b0:1e0:188c:ad4f with SMTP id
 lw16-20020a1709032ad000b001e0188cad4fmr7647643plb.26.1711350651504; Mon, 25
 Mar 2024 00:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-11-xuanzhuo@linux.alibaba.com> <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
 <1711009281.7778504-3-xuanzhuo@linux.alibaba.com> <CACGkMEs+x8bObJ0Fr0LbkPzWqYSoU8Y8504=bqZtjux2T5-_Vg@mail.gmail.com>
 <1711087439.5923152-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711087439.5923152-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 15:10:39 +0800
Message-ID: <CACGkMEsMJ+r6JfrHGnQVPeuEFzbWwqHxPgkxS8-SvzqG5VLiKw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped
 support disable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 22 Mar 2024 13:13:36 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 21, 2024 at 4:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 21 Mar 2024 14:02:14 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > Now, the API virtqueue_set_dma_premapped just support to
> > > > > enable premapped mode.
> > > > >
> > > > > If we allow enabling the premapped dynamically, we should
> > > > > make this API to support disable the premapped mode.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++----=
----
> > > > >  include/linux/virtio.h       |  2 +-
> > > > >  2 files changed, 27 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 34f4b2c0c31e..3bf69cae4965 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > >  /**
> > > > >   * virtqueue_set_dma_premapped - set the vring premapped mode
> > > > >   * @_vq: the struct virtqueue we're talking about.
> > > > > + * @premapped: enable/disable the premapped mode.
> > > > >   *
> > > > >   * Enable the premapped mode of the vq.
> > > > >   *
> > > > > @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > >   * 0: success.
> > > > >   * -EINVAL: vring does not use the dma api, so we can not enable=
 premapped mode.
> > > > >   */
> > > > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool prem=
apped)
> > > >
> > > > I think we need to document the requirement for calling this.
> > > >
> > > > Looking at the code, it seems it requires to stop the datapath and
> > > > detach all the used buffers?
> > >
> > >
> > > YES. The complete document is:
> > >
> > > /**
> > >  * virtqueue_set_dma_premapped - set the vring premapped mode
> > >  * @_vq: the struct virtqueue we're talking about.
> > >  *
> > >  * Enable the premapped mode of the vq.
> > >  *
> > >  * The vring in premapped mode does not do dma internally, so the dri=
ver must
> > >  * do dma mapping in advance. The driver must pass the dma_address th=
rough
> > >  * dma_address of scatterlist. When the driver got a used buffer from
> > >  * the vring, it has to unmap the dma address.
> > >  *
> > >  * This function must be called immediately after creating the vq, or=
 after vq
> > >  * reset, and before adding any buffers to it.
> >
> > I'm not sure this is a good design but we need at least some guard for
> > this, probably WARN for num_added or others.
>
>
> int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u32 num;
>
>         START_USE(vq);
>
>         num =3D vq->packed_ring ? vq->packed.vring.num : vq->split.vring.=
num;
>
>         if (num !=3D vq->vq.num_free) {
>                 END_USE(vq);
>                 return -EINVAL;
>         }
>
>
> Now, we have checked the num_free.

Ok, let's add it to the doc.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >  *
> > >  * Caller must ensure we don't call this with other virtqueue operati=
ons
> > >  * at the same time (except where noted).
> > >  *
> > >  * Returns zero or a negative error.
> > >  * 0: success.
> > >  * -EINVAL: vring does not use the dma api, so we can not enable prem=
apped mode.
> > >  */
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>


