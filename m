Return-Path: <netdev+bounces-93951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E728BDB65
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB261C2149F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886486F07E;
	Tue,  7 May 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgvEnxqt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3D6FE07
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063074; cv=none; b=fimSwqIiqFRUOWhiCrZ9M761Zo6BK17LEG/KhmJP2GKhdtj6sCAimppM4OgVB10Xssn7Q8QZkNsWpYhfCP52e/H1QZ7hi63uu7P+1++aAeFvFiErG204GMVl8KavcqpW+kJWoXxICMFCRdJc9AAL1qSxan0AOMXAkYhAErMhIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063074; c=relaxed/simple;
	bh=vEqDJ+WkKhxYgKNwmtfwHo/ew8e3TC3Qg/V98F7xVQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAU/4MzGNW916+ydaJ773tShCBf3E5yn4K+pUC7TzBJFLFYvsZ96Jtid/Xm4zSXUTywoH0VzawJs5TDaMVSZGAHWGmXLanrsZUx4q2llXpvmXrUh8Ajzv72QSpLjhIYbU9mXCGX7av2vVueb3E92wR9hbx23sh8DUaIVYh1UkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgvEnxqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wI857S1mK7FIWHib1RCGMGJi8mHzB2261Zi2RzYLfX4=;
	b=BgvEnxqtSwLA2XLMIvX2F6ZUe5cmEeDEEjgiEFBpZyRTZlW8NOjCAfb0FlhvsGH+WIcN/L
	K8eBUWpvPRmAqiDrmzSSXgXyFmRwgVmOy96SXL6i4livHyY+1KiEX8a2TUaMMEUENOakfL
	ihj7FODBA2sWsODLW+VE95QZUojIvMQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Ph19lVYqPDOL21C8dNNlGg-1; Tue, 07 May 2024 02:24:30 -0400
X-MC-Unique: Ph19lVYqPDOL21C8dNNlGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b2a06c0caeso3195383a91.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 23:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063069; x=1715667869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI857S1mK7FIWHib1RCGMGJi8mHzB2261Zi2RzYLfX4=;
        b=jNscfpQnUv2G/7xg0VsL9nntM1xf2n9sv3qQco+ZHw4IKcnntWtaLqH52Nh9WwN9ji
         6P6KqzgWo+ugJt63AhdWm766cOa769RwIncoXWFejKS3M+tAwnYIHCaayWUUxZfljClf
         Dl9fp+R+KIPd2+mLQRGXIsaTeQQVoks7kXYymL9nwMYAhme7J8equnBLYq/59fmCXo0T
         ivD1d4mIQf+7DtwGRkYeqrIrV9b3og3henBDCAsrh+13+XhKaqRIQ93KEHCSxfzey3dZ
         u5t9+4AeRz+9qrTdfEv0gsir7LFCNAG6oaNvVbIe831JSdLHGCsxFgPd2p4sAPNqE+Ko
         mvYQ==
X-Gm-Message-State: AOJu0YydLYho9GfxXxYBRSrAr9HyzM4LBHxwQHspliQMVd7gFoF8cXYb
	UF0rq1K4rQvWu2j8R0BVB10uym58/ArOXz8GLnUCCEZL1Pn+HjHGm1z4ZWre4DTjNaO9pl0mNQV
	/ATrGdPFKRNqvjp4/WbIchz9TaQuN6M8wY3I1oYnlZEk0HaPr37opNMeg0XpnT2G4/wS0XhQaFL
	O4mT61upEyBoS+33ewXlG3Y9wJYZLg
X-Received: by 2002:a17:90a:4889:b0:2b5:afcf:10bf with SMTP id b9-20020a17090a488900b002b5afcf10bfmr2832253pjh.0.1715063069498;
        Mon, 06 May 2024 23:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMmhYVqQ+A93RaTMd5UB+yY8lOZ6elcLf+BedXpQQop3bZf8t8xjruGQ6T1SsPgTq/xw2/mUcP9dGDXYPKs04=
X-Received: by 2002:a17:90a:4889:b0:2b5:afcf:10bf with SMTP id
 b9-20020a17090a488900b002b5afcf10bfmr2832227pjh.0.1715063068991; Mon, 06 May
 2024 23:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
 <20240425125855.87025-2-hengqi@linux.alibaba.com> <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
 <1715054136.4593592-1-hengqi@linux.alibaba.com>
In-Reply-To: <1715054136.4593592-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:24:16 +0800
Message-ID: <CACGkMEtkH+O+cQQ_3Ar=6-tJyRurzr6ZrGf6mtWZW4VjAt4Hfw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Tue, 7 May 2024 11:15:22 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > Control vq polling request results consume more CPU.
> > > Especially when dim issues more control requests to the device,
> > > it's beneficial to the guest to enable control vq's irq.
> > >
> > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index a4d3c76654a4..79a1b30c173c 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -287,6 +287,12 @@ struct virtnet_info {
> > >         bool has_cvq;
> > >         struct mutex cvq_lock;
> > >
> > > +       /* Wait for the device to complete the request */
> > > +       struct completion completion;
> > > +
> > > +       /* Work struct for acquisition of cvq processing results. */
> > > +       struct work_struct get_cvq;
> > > +
> > >         /* Host can handle any s/g split between our header and packe=
t data */
> > >         bool any_header_sg;
> > >
> > > @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct napi_=
struct *napi,
> > >         return false;
> > >  }
> > >
> > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > +{
> > > +       struct virtnet_info *vi =3D cvq->vdev->priv;
> > > +
> > > +       schedule_work(&vi->get_cvq);
> > > +}
> > > +
> > >  static void skb_xmit_done(struct virtqueue *vq)
> > >  {
> > >         struct virtnet_info *vi =3D vq->vdev->priv;
> > > @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_info =
*vi, struct receive_queue *rq,
> > >         return !oom;
> > >  }
> > >
> > > +static void virtnet_get_cvq_work(struct work_struct *work)
> > > +{
> > > +       struct virtnet_info *vi =3D
> > > +               container_of(work, struct virtnet_info, get_cvq);
> > > +       unsigned int tmp;
> > > +       void *res;
> > > +
> > > +       mutex_lock(&vi->cvq_lock);
> > > +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> > > +       if (res)
> > > +               complete(&vi->completion);
> > > +       mutex_unlock(&vi->cvq_lock);
> > > +}
> > > +
> > >  static void skb_recv_done(struct virtqueue *rvq)
> > >  {
> > >         struct virtnet_info *vi =3D rvq->vdev->priv;
> > > @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct virtnet=
_info *vi, u8 class, u8 cmd,
> > >                                  struct scatterlist *out)
> > >  {
> > >         struct scatterlist *sgs[4], hdr, stat;
> > > -       unsigned out_num =3D 0, tmp;
> > > +       unsigned out_num =3D 0;
> > >         int ret;
> > >
> > >         /* Caller should know better */
> > > @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct virtn=
et_info *vi, u8 class, u8 cmd,
> > >                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > >         }
> > >
> > > -       /* Spin for a response, the kick causes an ioport write, trap=
ping
> > > -        * into the hypervisor, so the request should be handled imme=
diately.
> > > -        */
> > > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > -              !virtqueue_is_broken(vi->cvq)) {
> > > -               cond_resched();
> > > -               cpu_relax();
> > > -       }
> > > -
> > >         mutex_unlock(&vi->cvq_lock);
> > > +
> > > +       wait_for_completion(&vi->completion);
> > > +
> >
> > A question here, can multiple cvq requests be submitted to the device?
> > If yes, what happens if the device completes them out of order?
>
> For user commands (such as ethtool cmds), multiple cvq requests is not al=
lowed.
> because it holds the netlink lock when waiting for the response.
>
> For multiple dim commands and a user command allowed to be sent simultane=
ously
> , the corresponding command-specific information(desc_state) will be used=
 to
> distinguish different responses.

Just to make sure we are on the same page. I meant at least we are
still use the global completion which seems to be problematic.

wait_for_completion(&vi->completion);

Thanks


>
> Thanks.
>
> >
> > Thanks
> >
> > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > >  }
> > >
> > > @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> > >
> > >         /* Parameters for control virtqueue, if any */
> > >         if (vi->has_cvq) {
> > > -               callbacks[total_vqs - 1] =3D NULL;
> > > +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > >                 names[total_vqs - 1] =3D "control";
> > >         }
> > >
> > > @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> > >         if (vi->has_rss || vi->has_rss_hash_report)
> > >                 virtnet_init_default_rss(vi);
> > >
> > > +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> > > +       init_completion(&vi->completion);
> > >         enable_rx_mode_work(vi);
> > >
> > >         /* serialize netdev register + virtio_device_ready() with ndo=
_open() */
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


