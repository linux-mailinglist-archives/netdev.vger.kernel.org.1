Return-Path: <netdev+bounces-94360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563268BF463
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D51C2300B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7575944D;
	Wed,  8 May 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B99NTBLJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F78F6A
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134764; cv=none; b=n5muKdLtf+pBHJqoVfXQKkX7K7/PCdUgBnpZNQ0J4qPNkJmZ1bbsvM3syTGN6JaZVq2D+vpx4hy4c7zKV+nDFQrSJ41HAIRUyBCgG+n4phtyJHJDoa42pyk5s4aOfZri0Ukw41KtT9rj3hXzvltCeyput1JbHCdMmFzo12wpyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134764; c=relaxed/simple;
	bh=UXWE5og41l4b6b2YVTVHSkJpeQzxkxzzK+70Oy9Hsk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT7UmjSIqPFq/b1uSesPnu4C/z164SBpB3LcI4lSbMxpxUQxnlu2MzTD0NKlHZQyIayq92OARPgrYWXZaxGL0jAiGG6OaMlZ4MYYeu/bsg0OxLTmsh1qTrN9PRwPKSPqKNEYdfQWFraaFiX6E1X0BjrZE5AtAQjbR967DCRHgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B99NTBLJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715134762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6/myYjmxuu8WGxOZGerbp+45oc0xhd9Aifc530Op7E=;
	b=B99NTBLJLcbkSaMkl89Fh8EZ6t4KnmG/omCqDeUl+wtj07NbXUW0ONRZ0EV4ddoTzmdl3q
	0edlNDhkvt103p7lJzlBhaKMMgcCUrKMy/xfIKebz/SDTEQyulLeDm/13exxtO7zUNPW6J
	kOrNpZMwSxvpgZaMlB46CuclO7uSV4I=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-qwcJ8fS3PUGC8QuRsTtp3Q-1; Tue, 07 May 2024 22:19:19 -0400
X-MC-Unique: qwcJ8fS3PUGC8QuRsTtp3Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-61c4c57e97bso4326953a12.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 19:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134758; x=1715739558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6/myYjmxuu8WGxOZGerbp+45oc0xhd9Aifc530Op7E=;
        b=InqmxltgoeoAlaa6n4Rk+zzjvsIkEclbMUQZ+DWu56e6gImyisid0270nRPUtt13tZ
         4XdwDvGsbuejGIYUNBzoV0cNnUFHfsHXtos6Ez/EUtq2EBI3k9Eku1baets4zqbAABS0
         SHyb7dtVznYH+WXbTtiAB1pedT7hO5OdxQc/ugypdskEJ9SiFM+UxYy8QpOl1FLCDSHy
         YH5Id1WT4MXGECYVvVeSuqiXr0WWN1hd8oGufeNwz7sTcp44kp6Vt5JXpI+68PWO7Jzk
         7+NRR+7vnW8xBqlj/IEMGwP4ysFR5YlHYpNf0j/L967GcqF177hW4Gj6wGP51GwRPODW
         lG/Q==
X-Gm-Message-State: AOJu0YxuWEhlaAG8kROghlJ120XAeFdD8AIbunIyokY3NzzeaLcBYUis
	Cj1HntxZaKVR3qSi1C0CwDzdmzGGQ5bYYFokSPbcUgYGB0Wrg+QaACZFpIdwTmC10kFXn0tQSWO
	Co/5pacXM4ocCpMA6k+P5nOuMrEEI5eoOwCb07Cd9iDrVySJ6fXFaRtJN9M4vH3ZzcT9o/yOBvB
	zDkCmvR/QHXIgp9Nbrh2Ar0WGnEmcP
X-Received: by 2002:a05:6a20:9496:b0:1aa:92b3:acd0 with SMTP id adf61e73a8af0-1afc8d3ce82mr1684844637.25.1715134758582;
        Tue, 07 May 2024 19:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqeuBJo8cXWEDWMoYPEUKuVAQIU3TyYIXKqDdUFb7J8dunKy9SY8bE7aDO8yQfZlFLyAUklT63b6Scv84DieU=
X-Received: by 2002:a05:6a20:9496:b0:1aa:92b3:acd0 with SMTP id
 adf61e73a8af0-1afc8d3ce82mr1684824637.25.1715134758227; Tue, 07 May 2024
 19:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
 <20240425125855.87025-2-hengqi@linux.alibaba.com> <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
 <1715054136.4593592-1-hengqi@linux.alibaba.com> <CACGkMEtkH+O+cQQ_3Ar=6-tJyRurzr6ZrGf6mtWZW4VjAt4Hfw@mail.gmail.com>
 <1715063231.736974-2-hengqi@linux.alibaba.com>
In-Reply-To: <1715063231.736974-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 10:19:06 +0800
Message-ID: <CACGkMEse44QCQ16z9K=+73U57OXYLY3qF7_yraN1UcQHe8jyfQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:33=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Tue, 7 May 2024 14:24:16 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Tue, May 7, 2024 at 12:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > On Tue, 7 May 2024 11:15:22 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > > On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.aliba=
ba.com> wrote:
> > > > >
> > > > > Control vq polling request results consume more CPU.
> > > > > Especially when dim issues more control requests to the device,
> > > > > it's beneficial to the guest to enable control vq's irq.
> > > > >
> > > > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index a4d3c76654a4..79a1b30c173c 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -287,6 +287,12 @@ struct virtnet_info {
> > > > >         bool has_cvq;
> > > > >         struct mutex cvq_lock;
> > > > >
> > > > > +       /* Wait for the device to complete the request */
> > > > > +       struct completion completion;
> > > > > +
> > > > > +       /* Work struct for acquisition of cvq processing results.=
 */
> > > > > +       struct work_struct get_cvq;
> > > > > +
> > > > >         /* Host can handle any s/g split between our header and p=
acket data */
> > > > >         bool any_header_sg;
> > > > >
> > > > > @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct n=
api_struct *napi,
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > > +{
> > > > > +       struct virtnet_info *vi =3D cvq->vdev->priv;
> > > > > +
> > > > > +       schedule_work(&vi->get_cvq);
> > > > > +}
> > > > > +
> > > > >  static void skb_xmit_done(struct virtqueue *vq)
> > > > >  {
> > > > >         struct virtnet_info *vi =3D vq->vdev->priv;
> > > > > @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_i=
nfo *vi, struct receive_queue *rq,
> > > > >         return !oom;
> > > > >  }
> > > > >
> > > > > +static void virtnet_get_cvq_work(struct work_struct *work)
> > > > > +{
> > > > > +       struct virtnet_info *vi =3D
> > > > > +               container_of(work, struct virtnet_info, get_cvq);
> > > > > +       unsigned int tmp;
> > > > > +       void *res;
> > > > > +
> > > > > +       mutex_lock(&vi->cvq_lock);
> > > > > +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> > > > > +       if (res)
> > > > > +               complete(&vi->completion);
> > > > > +       mutex_unlock(&vi->cvq_lock);
> > > > > +}
> > > > > +
> > > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > > >  {
> > > > >         struct virtnet_info *vi =3D rvq->vdev->priv;
> > > > > @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct vir=
tnet_info *vi, u8 class, u8 cmd,
> > > > >                                  struct scatterlist *out)
> > > > >  {
> > > > >         struct scatterlist *sgs[4], hdr, stat;
> > > > > -       unsigned out_num =3D 0, tmp;
> > > > > +       unsigned out_num =3D 0;
> > > > >         int ret;
> > > > >
> > > > >         /* Caller should know better */
> > > > > @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct v=
irtnet_info *vi, u8 class, u8 cmd,
> > > > >                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > >         }
> > > > >
> > > > > -       /* Spin for a response, the kick causes an ioport write, =
trapping
> > > > > -        * into the hypervisor, so the request should be handled =
immediately.
> > > > > -        */
> > > > > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > -              !virtqueue_is_broken(vi->cvq)) {
> > > > > -               cond_resched();
> > > > > -               cpu_relax();
> > > > > -       }
> > > > > -
> > > > >         mutex_unlock(&vi->cvq_lock);
> > > > > +
> > > > > +       wait_for_completion(&vi->completion);
> > > > > +
> > > >
> > > > A question here, can multiple cvq requests be submitted to the devi=
ce?
> > > > If yes, what happens if the device completes them out of order?
> > >
> > > For user commands (such as ethtool cmds), multiple cvq requests is no=
t allowed.
> > > because it holds the netlink lock when waiting for the response.
> > >
> > > For multiple dim commands and a user command allowed to be sent simul=
taneously
> > > , the corresponding command-specific information(desc_state) will be =
used to
> > > distinguish different responses.
> >
> > Just to make sure we are on the same page. I meant at least we are
> > still use the global completion which seems to be problematic.
> >
> > wait_for_completion(&vi->completion);
>
>
> This completion is only used by the ethtool command, so it is the global =
one.
>
> dim commands use specific coal_free_list and coal_wait_list to complete
> multiple command issuance (please see patch 3).

If I was not wrong, at least for this patch the global completion will
be used by both dim and rtnl. If yes, it's not good to introduce a bug
in patch 1 and fix it in patch 3.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > >  }
> > > > >
> > > > > @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_=
info *vi)
> > > > >
> > > > >         /* Parameters for control virtqueue, if any */
> > > > >         if (vi->has_cvq) {
> > > > > -               callbacks[total_vqs - 1] =3D NULL;
> > > > > +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > >                 names[total_vqs - 1] =3D "control";
> > > > >         }
> > > > >
> > > > > @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_devi=
ce *vdev)
> > > > >         if (vi->has_rss || vi->has_rss_hash_report)
> > > > >                 virtnet_init_default_rss(vi);
> > > > >
> > > > > +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> > > > > +       init_completion(&vi->completion);
> > > > >         enable_rx_mode_work(vi);
> > > > >
> > > > >         /* serialize netdev register + virtio_device_ready() with=
 ndo_open() */
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> >
>


