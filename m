Return-Path: <netdev+bounces-94374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360588BF496
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E511F243FD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231FF10A13;
	Wed,  8 May 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oSt6oKZA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9E8BE7
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135721; cv=none; b=T5ZXP0+WBqb1Zly2jIuJigNwkX+rDy3Fj99yrgDOibbeh9usJPshq6riGSDv9CcvcWCCja+aUNOHkKCOVJS4nrjx3aKTxHHP7bE66+ZKuqFQwLZdvGRhrFj1jsMqsIuuSy2xsjlL6yhVgG6xA/3YhFJEdXQbq73bVMKXhhSFEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135721; c=relaxed/simple;
	bh=Vlkv3W879GTq6yXICBYNLHiPQoJiV9UwWgVcxcMSZZk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=EooS6oc25Fwrm+mTqB99d+f4X0xV2a5WTQ1Ms9b1C1yRJzbU05xUk/aPW33wz1qjuL7fO/wPBIVFnL26uzFvgIoDORmWp4ZCVTD9tKDd16Z0TQoLLkXRNfQaN5s4TFh28VgD0275FWZFN+G9iHrPPjLqfuhU8SkLALiURRec+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oSt6oKZA; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135710; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=+ZJBJy3X6huim05h3HTp0o0WlRrfCXbUARHKAM2Llf4=;
	b=oSt6oKZAQmQ39S4Wbpd2Ihx//9y56csKzzeh2kZ7DCrlN2so7kuwO+6oLMo5tUMu2hDA9hBI11KGZvMFd3L+hR4OsMdyLFL+IfbvF/woUwwNEyZVmN+P5OIwx2SdR/m05jJMNIkNbuKsNrMlgAOt2FmEqjHy72pHypaFYokGpco=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W61relF_1715135708;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W61relF_1715135708)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:35:09 +0800
Message-ID: <1715135649.9281707-4-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
Date: Wed, 8 May 2024 10:34:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-3-hengqi@linux.alibaba.com>
 <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
 <1715065002.9314177-2-hengqi@linux.alibaba.com>
 <CACGkMEuQuzy9Mn1JN-phAW+bk64yZsM1xoKTKP+B9R8KP36K2w@mail.gmail.com>
In-Reply-To: <CACGkMEuQuzy9Mn1JN-phAW+bk64yZsM1xoKTKP+B9R8KP36K2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 8 May 2024 10:22:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, May 7, 2024 at 3:01=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
> >
> > On Tue, 7 May 2024 14:24:12 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> > > >
> > > > Currently, virtio-net lacks a way to obtain the default coalesce
> > > > values of the device during the probe phase. That is, the device
> > > > may have default experience values, but the user uses "ethtool -c"
> > > > to query that the values are still 0.
> > > >
> > > > Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete th=
e goal.
> > > >
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 61 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 3bc9b1e621db..fe0c15819dd3 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_de=
vice *vdev)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int virtnet_get_coal_init_value(struct virtnet_info *vi,
> > > > +                                      u16 _vqn, bool is_tx)
> > > > +{
> > > > +       struct virtio_net_ctrl_coal *coal =3D &vi->ctrl->coal_vq.co=
al;
> > > > +       __le16 *vqn =3D &vi->ctrl->coal_vq.vqn;
> > > > +       struct scatterlist sgs_in, sgs_out;
> > > > +       u32 usecs, pkts, i;
> > > > +       bool ret;
> > > > +
> > > > +       *vqn =3D cpu_to_le16(_vqn);
> > > > +
> > > > +       sg_init_one(&sgs_out, vqn, sizeof(*vqn));
> > > > +       sg_init_one(&sgs_in, coal, sizeof(*coal));
> > > > +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF=
_COAL,
> > > > +                                        VIRTIO_NET_CTRL_NOTF_COAL_=
VQ_GET,
> > > > +                                        &sgs_out, &sgs_in);
> > > > +       if (!ret)
> > > > +               return ret;
> > > > +
> > > > +       usecs =3D le32_to_cpu(coal->max_usecs);
> > > > +       pkts =3D le32_to_cpu(coal->max_packets);
> > > > +       if (is_tx) {
> > > > +               vi->intr_coal_tx.max_usecs =3D usecs;
> > > > +               vi->intr_coal_tx.max_packets =3D pkts;
> > > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > +                       vi->sq[i].intr_coal.max_usecs =3D usecs;
> > > > +                       vi->sq[i].intr_coal.max_packets =3D pkts;
> > > > +               }
> > > > +       } else {
> > > > +               vi->intr_coal_rx.max_usecs =3D usecs;
> > > > +               vi->intr_coal_rx.max_packets =3D pkts;
> > > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > +                       vi->rq[i].intr_coal.max_usecs =3D usecs;
> > > > +                       vi->rq[i].intr_coal.max_packets =3D pkts;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> > > >  {
> > > >         return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4=
) ||
> > > > @@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >                         vi->intr_coal_tx.max_packets =3D 0;
> > > >         }
> > > >
> > > > -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)=
) {
> > > > -               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL=
. */
> > > > -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > -                       if (vi->sq[i].napi.weight)
> > > > -                               vi->sq[i].intr_coal.max_packets =3D=
 1;
> > > > -       }
> > > > -
> > > >  #ifdef CONFIG_SYSFS
> > > >         if (vi->mergeable_rx_bufs)
> > > >                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_gr=
oup;
> > > > @@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >
> > > >         virtio_device_ready(vdev);
> > > >
> > > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)=
) {
> > > > +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL=
. */
> > > > +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > +                       if (vi->sq[i].napi.weight)
> > > > +                               vi->sq[i].intr_coal.max_packets =3D=
 1;
> > > > +
> > > > +               /* The loop exits if the default value from any
> > > > +                * queue is successfully read.
> > > > +                */
> > >
> > > So this assumes the default values are the same. Is this something
> > > required by the spec? If not, we probably need to iterate all the
> > > queues.
> > >
> >
> > From internal practice, and from the default behavior of other existing=
 drivers,
> > the queues all have the same value at the beginning, so here it seems f=
easible
> > that we get the value of queue 0 to represent the global value instead =
of using
> > a loop.
>=20
> Well, unless the spec says the values are equal, the driver needs to iter=
ate.

Ok. Will update this in the next version.

Thanks.

>=20
> >
> > Moreover, obtaining the value once for each queue initially does not se=
em to be
> > very friendly for devices with a large number of queues.
>=20
> We probably don't care too much about the time spent on the probe. For
> example, there would be a lot of registers read/write as well.
>=20
> Thanks
>=20
> >
> > Thanks.
> >
> > > Thanks
> > >
> > >
> > > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > +                       err =3D virtnet_get_coal_init_value(vi, rxq=
2vq(i), false);
> > > > +                       if (!err)
> > > > +                               break;
> > > > +               }
> > > > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > +                       err =3D virtnet_get_coal_init_value(vi, txq=
2vq(i), true);
> > > > +                       if (!err)
> > > > +                               break;
> > > > +               }
> > > > +       }
> > > > +
> > > >         _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > >
> > > >         /* a random MAC address has been assigned, notify the devic=
e.
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>=20

