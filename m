Return-Path: <netdev+bounces-81519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D508188AB48
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BDCB40FA5
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F61741E0;
	Mon, 25 Mar 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp7iCw9n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7A177990
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350459; cv=none; b=WGxN5ZDFM5oU+f6B8MwXzRJNA6YGduQWz9+qH2x0VqDRA/WnpAfSx8dlonQzMfJ7aZBRMFkbaMs/zp81e1ci9JLhmBzY+dmRJ43gI1JgismncBAfv4xZj5z4FLE3SiioDS9G/c7V85xzVT+rajUNqglyDtl4hmt2wV2OrTKPh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350459; c=relaxed/simple;
	bh=ARjCIe424udFEsd3uJuk6RnAdYHEgY3jw+I7hjzyM8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsWTcNKRyYtYk0Ejec417GYvAPHfeuT4fnMiONWLtxtUUz9nUc4xMgp2330lmBA8wgo8CGB9fcYlyfaOiAzr5Bjnzk96n1QxI24ty0fX1Yguv6oBXfuzWoRHwZJ15rwyADCuC3tfYLpzVVtEwiHL7U9H5ZTRh5jaCpExp7rKH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp7iCw9n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711350455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUebwkaaw2af/0TNVuDlZf4w4TWMS5Clz0gVbmMgFgM=;
	b=Pp7iCw9nLcZ8qBynW5bzslVHHnJKuzZYVgC8ccqgrhaKx7b6sMvGitsEIApEQr340Lx5Bk
	OXAMxTJkX5qMe3Db+GqQHi7gH8zQvHllBNAzyKYMfyGYDOLRwX1wKr+4PaEhZ2S15yqnsc
	RBGe9OMXv07ZJGvjZMwZ63gbD2pFUGg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Iula5GXvNCCEFxGqT1YwDA-1; Mon, 25 Mar 2024 03:07:33 -0400
X-MC-Unique: Iula5GXvNCCEFxGqT1YwDA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dff9fccdbdso32989285ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 00:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350452; x=1711955252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUebwkaaw2af/0TNVuDlZf4w4TWMS5Clz0gVbmMgFgM=;
        b=aEQkvovPCNWOV/Xsf5SOzxe96nsaesD7+ZD2GAo2XJETF2cMPCZDyM4aXoPI6Rgysa
         2jHwiZzRfmdQWlHvmyNOFyAYh9/MWB21L+ueWEgwIALUlrFLFPER0W/hU1X27KbiK2ur
         GCgMauqcJ5RTxCbJbdBn1sNi0QfZA+WyXilKoe6B+QByYdfKuYFAmdi7pR6hN/yj0Tvl
         ePvz7Uokc/nYkR3v0/dCPBCyexNJ11/QhUcMjSfvvOneXAqidYz076xSi8uBWu67pvbj
         KmWsK106jx7ET3sk276MJiJkxjpgclBFLZptUDAtrO6YQZc7msVoBPNaPHHfyLD4nHlZ
         Q+sA==
X-Forwarded-Encrypted: i=1; AJvYcCVMwXu9WWIck+L89KLu849JrtpJyavmDcDYAO7DnbNfP4OwSTnT4mh7tKyvoN0wYETR+ZoaWupCkL2GCKHthLF+RSqKfw+Z
X-Gm-Message-State: AOJu0Yy/UQ3d3lAV0TvjvMbHrG9n0CIOQznCmkRsmt+6k8WvX3tzjvS2
	imiK6LiAIKZgxGZHEVxUifWyepD11DQemy0+HKjN1236akmZ+bj9pkUXp7JHwk511XG4CUgIS4c
	RFZr5GpWW4Q0i58w/p7pxXGzlNhPe0ZQTv2GI0nFVYpjDujXDC5pRUJiXV1fZiufmk33YCEXYM1
	N2tyC19rUb66cFe3cYx90DA3Vh1slT
X-Received: by 2002:a17:902:fc45:b0:1dd:651d:cc47 with SMTP id me5-20020a170902fc4500b001dd651dcc47mr8964220plb.28.1711350452660;
        Mon, 25 Mar 2024 00:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/BWFySxbF/18yFEVKedfsgxvmFX8m+dp9CMK81imISc1NkY+G2CRY2XNcdncErENNUcGTo4iXbIJ6WBwVRC8=
X-Received: by 2002:a17:902:fc45:b0:1dd:651d:cc47 with SMTP id
 me5-20020a170902fc4500b001dd651dcc47mr8964212plb.28.1711350452376; Mon, 25
 Mar 2024 00:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-4-xuanzhuo@linux.alibaba.com> <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
 <1711009465.784253-4-xuanzhuo@linux.alibaba.com> <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
 <1711093912.1488938-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711093912.1488938-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 15:07:21 +0800
Message-ID: <CACGkMEtG-zY2kmzV1hzRoKWz21mQa1QuopbEeRNa2EbYw2cNgg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 22 Mar 2024 13:15:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 21, 2024 at 4:29=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > This commit structure the indirect desc table.
> > > > > Then we can get the desc num directly when doing unmap.
> > > > >
> > > > > And save the dma info to the struct, then the indirect
> > > > > will not use the dma fields of the desc_extra. The subsequent
> > > > > commits will make the dma fields are optional. But for
> > > > > the indirect case, we must record the dma info.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------=
------
> > > > >  1 file changed, 38 insertions(+), 28 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 0dfbd17e5a87..22a588bba166 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > > > >         struct vring_desc *indir_desc;  /* Indirect descriptor, i=
f any. */
> > > > >  };
> > > > >
> > > > > +struct vring_packed_desc_indir {
> > > > > +       dma_addr_t addr;                /* Descriptor Array DMA a=
ddr. */
> > > > > +       u32 len;                        /* Descriptor Array lengt=
h. */
> > > > > +       u32 num;
> > > > > +       struct vring_packed_desc desc[];
> > > > > +};
> > > > > +
> > > > >  struct vring_desc_state_packed {
> > > > >         void *data;                     /* Data for callback. */
> > > > > -       struct vring_packed_desc *indir_desc; /* Indirect descrip=
tor, if any. */
> > > > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect d=
escriptor, if any. */
> > > >
> > > > Maybe it's better just to have a vring_desc_extra here.
> > >
> > >
> > > Do you mean replacing vring_packed_desc_indir by vring_desc_extra?
> >
> > Just add a vring_desc_extra in vring_desc_state_packed.
> >
> > >
> > > I am ok for that. But vring_desc_extra has two extra items:
> > >
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > >
> > > vring_packed_desc_indir has "desc". I think that is more convenient.
> > >
> > > So, I think vring_packed_desc_indir is appropriate.
> >
> > It reuses the existing structure so we had the chance to reuse the
> > helper.
>
> Do you mean vring_unmap_extra_packed()?

Yes.


>
> After last commit(virtio_ring: packed: remove double check of the unmap o=
ps):
>
>         /* caller must check vring_need_unmap_buffer() */
>         static void vring_unmap_extra_packed(const struct vring_virtqueue=
 *vq,
>                                              const struct vring_desc_extr=
a *extra)
>         {
>                 u16 flags;
>
>                 flags =3D extra->flags;
>
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra->addr, extra->len,
>                                (flags & VRING_DESC_F_WRITE) ?
>                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         }
>
> But we should call dma_unmap_single() for indirect desc.
>
> We know, dma_unmap_single() and dma_unmap_page() are same in essence.

Yes, it's worth tweaking in the future.

> So if we call dma_unmap_page for the indirect desc, we can reuse
> this function. But I do not prefer doing this.

Ok.

Thanks

>
> Thanks.
>
>
> > And it could be used for future chained indirect (if it turns
> > out to be necessary).
> >
> > Thanks
> >
> > > Or I missed something.
> > >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
> >
>


