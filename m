Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65B740B14
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjF1IUV (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 04:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232546AbjF1IKy (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 04:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
        b=JnyFnOya9s8gJMKZGkl5dAEpxQrrgK81RLet327JTLi8f9/0O7hO1jsO2Mq099DTQYxwWk
        XFDIPe+l4z40+QhORXkW3CArccvo2q+VVu6OyUV+Eh2j2+Fsyor8BDAipK+nQl0pVRwHIi
        8ttLY2SldbrWO/RLauuk1hkjBcrZpQ4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-cB2gB9EfMJmeLAFUetMyNQ-1; Wed, 28 Jun 2023 00:07:23 -0400
X-MC-Unique: cB2gB9EfMJmeLAFUetMyNQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb911b4ffeso276810e87.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 21:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687925242; x=1690517242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
        b=FYuWx1XFKu41YVEO+2SdGdLw89f+tkh3bdHMBG2pWpEQ/Nj0M+iWPvYkYjO4ECmXP4
         2UgqUKrP1xThTJQJPLM5f9UUIBUqw0fqPfgha4pU29uKChDxTQqWukHNIZ1UXqbzl8eB
         Liv/SQRtk7/jwuMgBzrP5qiMa6j4MRAFh3OQYRSVTqLB63y026sxrwU46zzSXk8TyVRk
         2wAYKI9h+WBgT4MB2bnZ30KY1qy96Y30lhteDEhjEaFw5W0EBZlnU4gvt1vt4VtTreBC
         lp8FL1lFQMOiO66aiTo1sSGPVIbuFob0HbPvWsauu6D25RnvqOxmlfGN3SO8EU9NSIch
         RQYQ==
X-Gm-Message-State: AC+VfDwUi802tdkRgekZefDIo+oMdWprXkReG19cwY/2xiS482629xW9
        Wf8898JXHEChe6JMr+gszysc353bgjfheGS63GP4eSV8jSePZMWWgurumA5jZNNUNrkil6I4+vD
        kEUxVLM3ROCvnEX2sAk3kyHUkI3acSTMG
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id p8-20020a056512234800b004fb7592cc7amr6364680lfu.20.1687925242176;
        Tue, 27 Jun 2023 21:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hCTKWRmXZEpVs0DYgKad/Ul/B5vDH3+80UITOMrtYNREd0vSuAqCm4CbSBg4eNiR8SAwsYOxO/FVXJYEWXm8=
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id
 p8-20020a056512234800b004fb7592cc7amr6364664lfu.20.1687925241866; Tue, 27 Jun
 2023 21:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com> <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 12:07:10 +0800
Message-ID: <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 5:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 27 Jun 2023 16:03:26 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > If the vq is the premapped mode, use the sg_dma_address() directly.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++------------=
--
> > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 2afdfb9e3e30..18212c3e056b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -598,8 +598,12 @@ static inline int virtqueue_add_split(struct vir=
tqueue *_vq,
> > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > >                         dma_addr_t addr;
> > >
> > > -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &=
addr))
> > > -                               goto unmap_release;
> > > +                       if (vq->premapped) {
> > > +                               addr =3D sg_dma_address(sg);
> > > +                       } else {
> > > +                               if (vring_map_one_sg(vq, sg, DMA_TO_D=
EVICE, &addr))
> > > +                                       goto unmap_release;
> > > +                       }
> >
> > Btw, I wonder whether or not it would be simple to implement the
> > vq->premapped check inside vring_map_one_sg() assuming the
> > !use_dma_api is done there as well.
>
>
> YES,
>
> That will more simple for the caller.
>
> But we will have things like:
>
> int func(bool do)
> {
> if (!do)
>     return;
> }
>
> I like this way, but you don't like it in last version.

I see :)

So I think it depends on the error handling path, we should choose a
way that can let us easily deal with errors.

For example, it seems the current approach is better since it doesn't
need to change the unmap_release.

Thanks

>
> >
> > >
> > >                         prev =3D i;
> > >                         /* Note that we trust indirect descriptor
> > > @@ -614,8 +618,12 @@ static inline int virtqueue_add_split(struct vir=
tqueue *_vq,
> > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > >                         dma_addr_t addr;
> > >
> > > -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE,=
 &addr))
> > > -                               goto unmap_release;
> > > +                       if (vq->premapped) {
> > > +                               addr =3D sg_dma_address(sg);
> > > +                       } else {
> > > +                               if (vring_map_one_sg(vq, sg, DMA_FROM=
_DEVICE, &addr))
> > > +                                       goto unmap_release;
> > > +                       }
> > >
> > >                         prev =3D i;
> > >                         /* Note that we trust indirect descriptor
> > > @@ -689,21 +697,23 @@ static inline int virtqueue_add_split(struct vi=
rtqueue *_vq,
> > >         return 0;
> > >
> > >  unmap_release:
> > > -       err_idx =3D i;
> > > +       if (!vq->premapped) {
> >
> > Can vq->premapped be true here? The label is named as "unmap_relase"
> > which implies "map" beforehand which seems not the case for
> > premapping.
>
> I see.
>
> Rethink about this, there is a better way.
> I will fix in next version.
>
>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > > +               err_idx =3D i;
> > >
> > > -       if (indirect)
> > > -               i =3D 0;
> > > -       else
> > > -               i =3D head;
> > > -
> > > -       for (n =3D 0; n < total_sg; n++) {
> > > -               if (i =3D=3D err_idx)
> > > -                       break;
> > > -               if (indirect) {
> > > -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> > > -                       i =3D virtio16_to_cpu(_vq->vdev, desc[i].next=
);
> > > -               } else
> > > -                       i =3D vring_unmap_one_split(vq, i);
> > > +               if (indirect)
> > > +                       i =3D 0;
> > > +               else
> > > +                       i =3D head;
> > > +
> > > +               for (n =3D 0; n < total_sg; n++) {
> > > +                       if (i =3D=3D err_idx)
> > > +                               break;
> > > +                       if (indirect) {
> > > +                               vring_unmap_one_split_indirect(vq, &d=
esc[i]);
> > > +                               i =3D virtio16_to_cpu(_vq->vdev, desc=
[i].next);
> > > +                       } else
> > > +                               i =3D vring_unmap_one_split(vq, i);
> > > +               }
> > >         }
> > >
> > >         if (indirect)
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

