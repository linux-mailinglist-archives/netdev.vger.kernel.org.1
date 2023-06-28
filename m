Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E255740BFA
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjF1I4F (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 04:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233103AbjF1IxK (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687942326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
        b=LBG6EHfMvK17vszyEaSMLJ5djXTd477VikidfAJCa0f2lHIbaeXkqdK3FmWk3lQRp4n9JN
        jQI63PAnO+u1H494laDu7K6r5bbt/tqmlbwkTKRjIcRg9Bs/ATAZOdIcE738O83Kkl/pIx
        yiYhEpnRHNEda1aIkgMnOxo4GHYSbhk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-6qH2dEwLNc2YJaN-MJwUvw-1; Wed, 28 Jun 2023 02:51:21 -0400
X-MC-Unique: 6qH2dEwLNc2YJaN-MJwUvw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fab61bb53bso3056541e87.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 23:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687935080; x=1690527080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
        b=Sl+vwPTdqnIo+oLCD8re5mHZ7JuYYJlw0MCGx8w8ZQklBJ69rlfl77Alvw88MUiNJB
         dYIcjRki5Xv5oCVuuozxTvgKeiRd7LOOnhfkS3v+e50nYGq21VhJXr7asI1UlYuOgw2+
         9AgaikR02F37qtYv5DNYY6+GaDmU+OzmOaASZiopRehG1OFWCZajTscylVsialf2aM4B
         AbsQlYFT3/DO33j+6DKIffBc2mmZNHrO30aj2R72div5/cYh2Ie/QruTV/iRuI3bRGQO
         E2yZo/I8mGW8ct1xh5gNWtuaU/0i7fRWbiVru6MbLmyk06cfXphJiGK42HTZzgfVoxXt
         uopg==
X-Gm-Message-State: AC+VfDyFE+8izOkVmcdyHOiABYLX/9HcjsxbeKTWHBAG0u0QbW1eGTgJ
        j6Z07zagdoJ8s63yV0H6aW3T8GCaX8Hw+vHGbTvUa4Tkz5KAUuepGh9a3+ucFqZNz4MsB1959Rz
        ooltKSe02oyv7hkj0oNm6jcpoFrtLh2bC
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id h24-20020a19ca58000000b004f8b3496938mr12994472lfj.65.1687935080146;
        Tue, 27 Jun 2023 23:51:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mv/3o+OYScVrxaKdO8aw/adM4SivgvUgQcZTOZQ3rB1LnCfP7sgXl+EWa854Ej82KZ6RtMTKkjSWEuj6scx8=
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id
 h24-20020a19ca58000000b004f8b3496938mr12994457lfj.65.1687935079753; Tue, 27
 Jun 2023 23:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com> <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com> <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
 <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 14:51:08 +0800
Message-ID: <CACGkMEumhkBShqXXbWXviS+xZA1aYrnZFoU_avdsWZ_9sBAwUQ@mail.gmail.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped buf
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 2:02=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 28 Jun 2023 12:07:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jun 27, 2023 at 5:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 27 Jun 2023 16:03:26 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > > >
> > > > > If the vq is the premapped mode, use the sg_dma_address() directl=
y.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++--------=
------
> > > > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 2afdfb9e3e30..18212c3e056b 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct=
 virtqueue *_vq,
> > > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > > >                         dma_addr_t addr;
> > > > >
> > > > > -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVIC=
E, &addr))
> > > > > -                               goto unmap_release;
> > > > > +                       if (vq->premapped) {
> > > > > +                               addr =3D sg_dma_address(sg);
> > > > > +                       } else {
> > > > > +                               if (vring_map_one_sg(vq, sg, DMA_=
TO_DEVICE, &addr))
> > > > > +                                       goto unmap_release;
> > > > > +                       }
> > > >
> > > > Btw, I wonder whether or not it would be simple to implement the
> > > > vq->premapped check inside vring_map_one_sg() assuming the
> > > > !use_dma_api is done there as well.
> > >
> > >
> > > YES,
> > >
> > > That will more simple for the caller.
> > >
> > > But we will have things like:
> > >
> > > int func(bool do)
> > > {
> > > if (!do)
> > >     return;
> > > }
> > >
> > > I like this way, but you don't like it in last version.
> >
> > I see :)
> >
> > So I think it depends on the error handling path, we should choose a
> > way that can let us easily deal with errors.
> >
> > For example, it seems the current approach is better since it doesn't
> > need to change the unmap_release.
>
> NO,
>
> The unmap_release is same for two way.
>
> Thanks.

Ok, so either is fine for me.

Thanks

>
>
> >
> > Thanks
> >
> > >
> > > >
> > > > >
> > > > >                         prev =3D i;
> > > > >                         /* Note that we trust indirect descriptor
> > > > > @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct=
 virtqueue *_vq,
> > > > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > > >                         dma_addr_t addr;
> > > > >
> > > > > -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEV=
ICE, &addr))
> > > > > -                               goto unmap_release;
> > > > > +                       if (vq->premapped) {
> > > > > +                               addr =3D sg_dma_address(sg);
> > > > > +                       } else {
> > > > > +                               if (vring_map_one_sg(vq, sg, DMA_=
FROM_DEVICE, &addr))
> > > > > +                                       goto unmap_release;
> > > > > +                       }
> > > > >
> > > > >                         prev =3D i;
> > > > >                         /* Note that we trust indirect descriptor
> > > > > @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struc=
t virtqueue *_vq,
> > > > >         return 0;
> > > > >
> > > > >  unmap_release:
> > > > > -       err_idx =3D i;
> > > > > +       if (!vq->premapped) {
> > > >
> > > > Can vq->premapped be true here? The label is named as "unmap_relase=
"
> > > > which implies "map" beforehand which seems not the case for
> > > > premapping.
> > >
> > > I see.
> > >
> > > Rethink about this, there is a better way.
> > > I will fix in next version.
> > >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > > +               err_idx =3D i;
> > > > >
> > > > > -       if (indirect)
> > > > > -               i =3D 0;
> > > > > -       else
> > > > > -               i =3D head;
> > > > > -
> > > > > -       for (n =3D 0; n < total_sg; n++) {
> > > > > -               if (i =3D=3D err_idx)
> > > > > -                       break;
> > > > > -               if (indirect) {
> > > > > -                       vring_unmap_one_split_indirect(vq, &desc[=
i]);
> > > > > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].=
next);
> > > > > -               } else
> > > > > -                       i =3D vring_unmap_one_split(vq, i);
> > > > > +               if (indirect)
> > > > > +                       i =3D 0;
> > > > > +               else
> > > > > +                       i =3D head;
> > > > > +
> > > > > +               for (n =3D 0; n < total_sg; n++) {
> > > > > +                       if (i =3D=3D err_idx)
> > > > > +                               break;
> > > > > +                       if (indirect) {
> > > > > +                               vring_unmap_one_split_indirect(vq=
, &desc[i]);
> > > > > +                               i =3D virtio16_to_cpu(_vq->vdev, =
desc[i].next);
> > > > > +                       } else
> > > > > +                               i =3D vring_unmap_one_split(vq, i=
);
> > > > > +               }
> > > > >         }
> > > > >
> > > > >         if (indirect)
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> >
>

