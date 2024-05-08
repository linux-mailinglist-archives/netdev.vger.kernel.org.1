Return-Path: <netdev+bounces-94364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13698BF46C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FC0B220F1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6D1A2C28;
	Wed,  8 May 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecMjqA2g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86856944E
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134941; cv=none; b=Kf3sANObS4U2iS6A4DKFHx5Q6rlh07Th5tlaKcxvQQ8P5CirtHHJnIDWVz+nbpNcCYB11+xW9TxmBrZcT7mn47eQ9LmlGywaoEm/PY/ZhGc6OY5Wojeg4Bbwqi1M3PWDRjYFVopLWzK+VUMsCEmuj73YTh+8mrKMKNaIIQ5mdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134941; c=relaxed/simple;
	bh=e9zqP3FRcYUtKl8zb8P8omFnhTOKBVZk+nPaB51sXiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbrL2Dcqp8P0SlP5eaSC7ZUTu0lYRTUi1JPsNSDAgYq7bX5pR5tpmateIV35gB5dHAn27GMWs1sKC2WbOy1fz14C8OBsTC7Ay5M1WxMrBaJ24DyXp6biA31PkHo2wE4VoNw5ArCWLyUaFkQJt3E2GAwuSUsV47qW26f2XFf6TBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecMjqA2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715134938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1JVE46JhsDjFTnbufVQCHxndRpyxDZpzIlRi1kXzqQ=;
	b=ecMjqA2gCkzlOjxh+hpxZAsHWZvsZDPED6I0pWEijiq4wEnDZHOKcExSNU0kxsVsGHwddG
	QkE3vMwkvoydjWbMPO3gypqGbnqDXK6llHIXYLK0WnRdUXwxL2xfq1hObcDYA/msj04Iii
	6863EG2CZ3XBIxIxNCBspZ7l8KoljBw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-wIzDqPj4PkWttz3cMJj9eg-1; Tue, 07 May 2024 22:22:16 -0400
X-MC-Unique: wIzDqPj4PkWttz3cMJj9eg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b38f8cac9dso301735a91.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 19:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134936; x=1715739736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1JVE46JhsDjFTnbufVQCHxndRpyxDZpzIlRi1kXzqQ=;
        b=qW5+xNJL58OQVHRv3SlBD6A5c4kI6gWo1hqNixYiV2YjCPqs67jK7SKcVK2FFgV0DC
         tpsvWAm2YN/V83U6tmFCdSOZUCdIBO/LCOFmGJLstUQs0SF/xpV0koii95m/xLolqQ17
         bkPTaCQW8t4tXuwv5ALT/8EOOJ012CYAVgvjOrAXdfIr1cGnNGyBkdfAJ+dfatKK4ASV
         UrNpvchp6dclmcg7fn6ADNZEORK3hkUJcmqnXDdPlma08+xEu7rzvmxJHHq2AwgVAaKj
         gX5cbIb35I2UMG+Hk9CNYNoh8aNRrh0ctMVNiGL3FPWxxq628ONYLTzy70bRiYIr2ROi
         Owlg==
X-Gm-Message-State: AOJu0YzdmBen83L8jNcfKaN1MLCv00MJf1zRtkdcaJG1zZBAc1gxrwjG
	pmOZhK8tzAVcyqV4QOKwKmqcsKWsfvVoJO4Xit10FUEz1sMd34Bnezb/Svbo7CXs6Qf/GbVik6N
	jDlRLOcrjELOpjq+TK34imWMDPGCQn8iFXgvCJiYf9ugyymqQPe/G8lekQxI7nDhimo2sEp1i/N
	YDKCLmY/Pl40HjaaDgwmTxndnI+aOv
X-Received: by 2002:a17:90b:1948:b0:2b0:e497:56f2 with SMTP id 98e67ed59e1d1-2b611696c1emr2327499a91.10.1715134935675;
        Tue, 07 May 2024 19:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+GdCgOx/SHzSNGRJLsXBp1V1/u80BZIwN8SAE4KV2A9bEsjroJeoko+rrUgx4G2fExC3P0tUSQlREaUygRfM=
X-Received: by 2002:a17:90b:1948:b0:2b0:e497:56f2 with SMTP id
 98e67ed59e1d1-2b611696c1emr2327473a91.10.1715134935281; Tue, 07 May 2024
 19:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-3-hengqi@linux.alibaba.com> <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
 <1715065002.9314177-2-hengqi@linux.alibaba.com>
In-Reply-To: <1715065002.9314177-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 10:22:04 +0800
Message-ID: <CACGkMEuQuzy9Mn1JN-phAW+bk64yZsM1xoKTKP+B9R8KP36K2w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:01=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Tue, 7 May 2024 14:24:12 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > Currently, virtio-net lacks a way to obtain the default coalesce
> > > values of the device during the probe phase. That is, the device
> > > may have default experience values, but the user uses "ethtool -c"
> > > to query that the values are still 0.
> > >
> > > Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete the =
goal.
> > >
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 61 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 3bc9b1e621db..fe0c15819dd3 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_devi=
ce *vdev)
> > >         return 0;
> > >  }
> > >
> > > +static int virtnet_get_coal_init_value(struct virtnet_info *vi,
> > > +                                      u16 _vqn, bool is_tx)
> > > +{
> > > +       struct virtio_net_ctrl_coal *coal =3D &vi->ctrl->coal_vq.coal=
;
> > > +       __le16 *vqn =3D &vi->ctrl->coal_vq.vqn;
> > > +       struct scatterlist sgs_in, sgs_out;
> > > +       u32 usecs, pkts, i;
> > > +       bool ret;
> > > +
> > > +       *vqn =3D cpu_to_le16(_vqn);
> > > +
> > > +       sg_init_one(&sgs_out, vqn, sizeof(*vqn));
> > > +       sg_init_one(&sgs_in, coal, sizeof(*coal));
> > > +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_C=
OAL,
> > > +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ=
_GET,
> > > +                                        &sgs_out, &sgs_in);
> > > +       if (!ret)
> > > +               return ret;
> > > +
> > > +       usecs =3D le32_to_cpu(coal->max_usecs);
> > > +       pkts =3D le32_to_cpu(coal->max_packets);
> > > +       if (is_tx) {
> > > +               vi->intr_coal_tx.max_usecs =3D usecs;
> > > +               vi->intr_coal_tx.max_packets =3D pkts;
> > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > +                       vi->sq[i].intr_coal.max_usecs =3D usecs;
> > > +                       vi->sq[i].intr_coal.max_packets =3D pkts;
> > > +               }
> > > +       } else {
> > > +               vi->intr_coal_rx.max_usecs =3D usecs;
> > > +               vi->intr_coal_rx.max_packets =3D pkts;
> > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > +                       vi->rq[i].intr_coal.max_usecs =3D usecs;
> > > +                       vi->rq[i].intr_coal.max_packets =3D pkts;
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> > >  {
> > >         return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) =
||
> > > @@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >                         vi->intr_coal_tx.max_packets =3D 0;
> > >         }
> > >
> > > -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) =
{
> > > -               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. =
*/
> > > -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > -                       if (vi->sq[i].napi.weight)
> > > -                               vi->sq[i].intr_coal.max_packets =3D 1=
;
> > > -       }
> > > -
> > >  #ifdef CONFIG_SYSFS
> > >         if (vi->mergeable_rx_bufs)
> > >                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_grou=
p;
> > > @@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >
> > >         virtio_device_ready(vdev);
> > >
> > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) =
{
> > > +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. =
*/
> > > +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > +                       if (vi->sq[i].napi.weight)
> > > +                               vi->sq[i].intr_coal.max_packets =3D 1=
;
> > > +
> > > +               /* The loop exits if the default value from any
> > > +                * queue is successfully read.
> > > +                */
> >
> > So this assumes the default values are the same. Is this something
> > required by the spec? If not, we probably need to iterate all the
> > queues.
> >
>
> From internal practice, and from the default behavior of other existing d=
rivers,
> the queues all have the same value at the beginning, so here it seems fea=
sible
> that we get the value of queue 0 to represent the global value instead of=
 using
> a loop.

Well, unless the spec says the values are equal, the driver needs to iterat=
e.

>
> Moreover, obtaining the value once for each queue initially does not seem=
 to be
> very friendly for devices with a large number of queues.

We probably don't care too much about the time spent on the probe. For
example, there would be a lot of registers read/write as well.

Thanks

>
> Thanks.
>
> > Thanks
> >
> >
> > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > +                       err =3D virtnet_get_coal_init_value(vi, rxq2v=
q(i), false);
> > > +                       if (!err)
> > > +                               break;
> > > +               }
> > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > +                       err =3D virtnet_get_coal_init_value(vi, txq2v=
q(i), true);
> > > +                       if (!err)
> > > +                               break;
> > > +               }
> > > +       }
> > > +
> > >         _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > >
> > >         /* a random MAC address has been assigned, notify the device.
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


