Return-Path: <netdev+bounces-94387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A458BF50D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8661F231ED
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57B14A90;
	Wed,  8 May 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FLckfB14"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CF1426E
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140036; cv=none; b=HSBEkdKTMrD/P+q63Vg9ddrzQW75GP4vWNVm61xqXEyUNxyPnKHlFtSmrc0s00gWshuZiYE96DzKBBuv1buFFdmtrDqGTmhY66OQogqjo/Hvc/5jk3Ui/DNkpn3biuMWpKIOp51ZzpjMebGSiTBWm2Xdf/sFwJPUfkBqIW7/YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140036; c=relaxed/simple;
	bh=IEhIMwzlleMdiPD0IwjVOrDr8XORmwHHazEMOOKBDNw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=MU2LRZITYM4pZ1U/Z3FHLAMDdTEfzdzgUn/kaoRVKBVBrdwthT6WFanjYujZMaBa7Lwz4IH/s7PV0x7Q30tP9c5kHnE8AVmfAs2r/ViHBQpWI6BNaHFXl2sxDgqCOz8f5w69N5A4dAJmgphdA52utJ+Y6Yj4tPkPvtI1etZTVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FLckfB14; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715140026; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=w1hKNu1eY8HncZ9Q+tRuXsbA9JXQ4KPHtkSt8TfeS1I=;
	b=FLckfB148oPgm3Z8r6JrdsqWv/502JskYjmKenbeysTNuUQo8ydbXSv+lEy36OG8bHINQVNqPaDRIa0Ll/XmJGsIbuOsW//XMsTUp423a0c4fEz6xAhjPlYn4MTwZphw5O2dD+QcCOMoKbumLPvtDocfRsH/x8OF4Rtr3vwAF08=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W629eDn_1715140024;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W629eDn_1715140024)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 11:47:05 +0800
Message-ID: <1715139832.2284784-6-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
Date: Wed, 8 May 2024 11:43:52 +0800
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
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
 <20240425125855.87025-2-hengqi@linux.alibaba.com>
 <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
 <1715054136.4593592-1-hengqi@linux.alibaba.com>
 <CACGkMEtkH+O+cQQ_3Ar=6-tJyRurzr6ZrGf6mtWZW4VjAt4Hfw@mail.gmail.com>
 <1715063231.736974-2-hengqi@linux.alibaba.com>
 <CACGkMEse44QCQ16z9K=+73U57OXYLY3qF7_yraN1UcQHe8jyfQ@mail.gmail.com>
In-Reply-To: <CACGkMEse44QCQ16z9K=+73U57OXYLY3qF7_yraN1UcQHe8jyfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 8 May 2024 10:19:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, May 7, 2024 at 2:33=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
> >
> > On Tue, 7 May 2024 14:24:16 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Tue, May 7, 2024 at 12:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> > > >
> > > > On Tue, 7 May 2024 11:15:22 +0800, Jason Wang <jasowang@redhat.com>=
 wrote:
> > > > > On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> > > > > >
> > > > > > Control vq polling request results consume more CPU.
> > > > > > Especially when dim issues more control requests to the device,
> > > > > > it's beneficial to the guest to enable control vq's irq.
> > > > > >
> > > > > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++--=
--------
> > > > > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index a4d3c76654a4..79a1b30c173c 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -287,6 +287,12 @@ struct virtnet_info {
> > > > > >         bool has_cvq;
> > > > > >         struct mutex cvq_lock;
> > > > > >
> > > > > > +       /* Wait for the device to complete the request */
> > > > > > +       struct completion completion;
> > > > > > +
> > > > > > +       /* Work struct for acquisition of cvq processing result=
s. */
> > > > > > +       struct work_struct get_cvq;
> > > > > > +
> > > > > >         /* Host can handle any s/g split between our header and=
 packet data */
> > > > > >         bool any_header_sg;
> > > > > >
> > > > > > @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct=
 napi_struct *napi,
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > > > +{
> > > > > > +       struct virtnet_info *vi =3D cvq->vdev->priv;
> > > > > > +
> > > > > > +       schedule_work(&vi->get_cvq);
> > > > > > +}
> > > > > > +
> > > > > >  static void skb_xmit_done(struct virtqueue *vq)
> > > > > >  {
> > > > > >         struct virtnet_info *vi =3D vq->vdev->priv;
> > > > > > @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > > >         return !oom;
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_get_cvq_work(struct work_struct *work)
> > > > > > +{
> > > > > > +       struct virtnet_info *vi =3D
> > > > > > +               container_of(work, struct virtnet_info, get_cvq=
);
> > > > > > +       unsigned int tmp;
> > > > > > +       void *res;
> > > > > > +
> > > > > > +       mutex_lock(&vi->cvq_lock);
> > > > > > +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> > > > > > +       if (res)
> > > > > > +               complete(&vi->completion);
> > > > > > +       mutex_unlock(&vi->cvq_lock);
> > > > > > +}
> > > > > > +
> > > > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > > > >  {
> > > > > >         struct virtnet_info *vi =3D rvq->vdev->priv;
> > > > > > @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct v=
irtnet_info *vi, u8 class, u8 cmd,
> > > > > >                                  struct scatterlist *out)
> > > > > >  {
> > > > > >         struct scatterlist *sgs[4], hdr, stat;
> > > > > > -       unsigned out_num =3D 0, tmp;
> > > > > > +       unsigned out_num =3D 0;
> > > > > >         int ret;
> > > > > >
> > > > > >         /* Caller should know better */
> > > > > > @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct=
 virtnet_info *vi, u8 class, u8 cmd,
> > > > > >                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > > >         }
> > > > > >
> > > > > > -       /* Spin for a response, the kick causes an ioport write=
, trapping
> > > > > > -        * into the hypervisor, so the request should be handle=
d immediately.
> > > > > > -        */
> > > > > > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > -              !virtqueue_is_broken(vi->cvq)) {
> > > > > > -               cond_resched();
> > > > > > -               cpu_relax();
> > > > > > -       }
> > > > > > -
> > > > > >         mutex_unlock(&vi->cvq_lock);
> > > > > > +
> > > > > > +       wait_for_completion(&vi->completion);
> > > > > > +
> > > > >
> > > > > A question here, can multiple cvq requests be submitted to the de=
vice?
> > > > > If yes, what happens if the device completes them out of order?
> > > >
> > > > For user commands (such as ethtool cmds), multiple cvq requests is =
not allowed.
> > > > because it holds the netlink lock when waiting for the response.
> > > >
> > > > For multiple dim commands and a user command allowed to be sent sim=
ultaneously
> > > > , the corresponding command-specific information(desc_state) will b=
e used to
> > > > distinguish different responses.
> > >
> > > Just to make sure we are on the same page. I meant at least we are
> > > still use the global completion which seems to be problematic.
> > >
> > > wait_for_completion(&vi->completion);
> >
> >
> > This completion is only used by the ethtool command, so it is the globa=
l one.
> >
> > dim commands use specific coal_free_list and coal_wait_list to complete
> > multiple command issuance (please see patch 3).
>=20
> If I was not wrong, at least for this patch the global completion will
> be used by both dim and rtnl. If yes, it's not good to introduce a bug
> in patch 1 and fix it in patch 3.

Ok, patches 1 and 3 will be refactored.

Thanks.

>=20
> Thanks
>=20
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > > >  }
> > > > > >
> > > > > > @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtne=
t_info *vi)
> > > > > >
> > > > > >         /* Parameters for control virtqueue, if any */
> > > > > >         if (vi->has_cvq) {
> > > > > > -               callbacks[total_vqs - 1] =3D NULL;
> > > > > > +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > > >                 names[total_vqs - 1] =3D "control";
> > > > > >         }
> > > > > >
> > > > > > @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_de=
vice *vdev)
> > > > > >         if (vi->has_rss || vi->has_rss_hash_report)
> > > > > >                 virtnet_init_default_rss(vi);
> > > > > >
> > > > > > +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> > > > > > +       init_completion(&vi->completion);
> > > > > >         enable_rx_mode_work(vi);
> > > > > >
> > > > > >         /* serialize netdev register + virtio_device_ready() wi=
th ndo_open() */
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > > >
> > > > >
> > > >
> > >
> >
>=20

