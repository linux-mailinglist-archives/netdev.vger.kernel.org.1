Return-Path: <netdev+bounces-104569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E936890D5AB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3611F218A0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55A16DC3B;
	Tue, 18 Jun 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kHoeutkq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29318EFDB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720828; cv=none; b=JNQcuDW7ZFT+p7uX6K8rsd0ZbipKY0qYMykru5PGbjdOlvZy5anqzomLPho2udjXBx6eEPCgkCsa3KRijQJFQMY9+xP7ZFtqzkf7YR4zka1s1ef5Ix9Up3yOO79MsG++7WphEiQbzBH47+UaysxKkxAag44cdOw4sUJIhANJS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720828; c=relaxed/simple;
	bh=j6f6k89P/o+TXtECuGqkt/T2nXvYfh7dZZYPmRfqtSU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=i7HKn/YS2fs1J54TKv4z6J9fBlG9gg/qlimlMBaVuMdT3d4xwUYZrvW+sEYOYZ+GTc9ZRDNTW3AT+9T9Cr/PGfIMn/c/6ErApOGk2NT6QU3JiQwQTEV8R5+XIywpneZlWu9eRL/jRgIveu6oVut+kKJCfrEFQJPZpa1PUjJqR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kHoeutkq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718720822; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=9hex085qX81oSlvsM3+d3NY5b0KiSOKjVLCylIWLvvQ=;
	b=kHoeutkqb6L909YgmBQoqTqy3T7oFrx8tDEN7/7lT4hvURhd6AzZjNvPLMO1yaw5AUxy7T37XY8UyXyR7OX1gVByo2v/Z67TWC95LspxgeyiZKIaNmZb2xhq7Kq3eyl79YRfxcxPX39+O+7K6pNs0TKRLQfeGOuE/eX1iev+/os=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8kLtdH_1718720821;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8kLtdH_1718720821)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 22:27:02 +0800
Message-ID: <1718720650.657001-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 4/4] virtio_net: improve dim command request efficiency
Date: Tue, 18 Jun 2024 22:24:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240606061446.127802-1-hengqi@linux.alibaba.com>
 <20240606061446.127802-5-hengqi@linux.alibaba.com>
 <CACGkMEuFJ=xeeBt9GiCLj8AeJg-u-JG4F9_+8vBoH4dhZ-z=3Q@mail.gmail.com>
 <1718609268.7814527-9-hengqi@linux.alibaba.com>
 <CACGkMEvdbUzxMKoz+=TO8C5H06TvdL-nFPpe8qd==5PiXRjpTA@mail.gmail.com>
In-Reply-To: <CACGkMEvdbUzxMKoz+=TO8C5H06TvdL-nFPpe8qd==5PiXRjpTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 09:29:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 4:08=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > On Mon, 17 Jun 2024 12:05:30 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Jun 6, 2024 at 2:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> > > >
> > > > Currently, control vq handles commands synchronously,
> > > > leading to increased delays for dim commands during multi-queue
> > > > VM configuration and directly impacting dim performance.
> > > >
> > > > To address this, we are shifting to asynchronous processing of
> > > > ctrlq's dim commands.
> > > >
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 233 ++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 208 insertions(+), 25 deletions(-)
> > > >

Hi Jason,

I will incorporate your feedback and update the next version.

Thanks

> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index e59e12bb7601..0338528993ab 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -376,6 +376,13 @@ struct control_buf {
> > > >         struct completion completion;
> > > >  };
> > > >
> > > > +struct virtnet_coal_node {
> > > > +       struct control_buf ctrl;
> > > > +       struct virtio_net_ctrl_coal_vq coal_vqs;
> > > > +       bool is_coal_wait;
> > > > +       struct list_head list;
> > > > +};
> > > > +
> > > >  struct virtnet_info {
> > > >         struct virtio_device *vdev;
> > > >         struct virtqueue *cvq;
> > > > @@ -420,6 +427,9 @@ struct virtnet_info {
> > > >         /* Lock to protect the control VQ */
> > > >         struct mutex cvq_lock;
> > > >
> > > > +       /* Work struct for acquisition of cvq processing results. */
> > > > +       struct work_struct get_cvq;
> > > > +
> > > >         /* Host can handle any s/g split between our header and pac=
ket data */
> > > >         bool any_header_sg;
> > > >
> > > > @@ -464,6 +474,14 @@ struct virtnet_info {
> > > >         struct virtnet_interrupt_coalesce intr_coal_tx;
> > > >         struct virtnet_interrupt_coalesce intr_coal_rx;
> > > >
> > > > +       /* Free nodes used for concurrent delivery */
> > > > +       struct mutex coal_free_lock;
> > > > +       struct list_head coal_free_list;
> > > > +
> > > > +       /* Filled when there are no free nodes or cvq buffers */
> > > > +       struct mutex coal_wait_lock;
> > > > +       struct list_head coal_wait_list;
> > > > +
> > > >         unsigned long guest_offloads;
> > > >         unsigned long guest_offloads_capable;
> > > >
> > > > @@ -670,7 +688,7 @@ static void virtnet_cvq_done(struct virtqueue *=
cvq)
> > > >  {
> > > >         struct virtnet_info *vi =3D cvq->vdev->priv;
> > > >
> > > > -       complete(&vi->ctrl->completion);
> > > > +       schedule_work(&vi->get_cvq);
> > > >  }
> > > >
> > > >  static void skb_xmit_done(struct virtqueue *vq)
> > > > @@ -2696,7 +2714,7 @@ static bool virtnet_send_command_reply(struct=
 virtnet_info *vi,
> > > >                                        struct scatterlist *in)
> > > >  {
> > > >         struct scatterlist *sgs[5], hdr, stat;
> > > > -       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > > +       u32 out_num =3D 0, in_num =3D 0;
> > > >         int ret;
> > > >
> > > >         /* Caller should know better */
> > > > @@ -2730,14 +2748,14 @@ static bool virtnet_send_command_reply(stru=
ct virtnet_info *vi,
> > > >                 return false;
> > > >         }
> > > >
> > > > -       if (unlikely(!virtqueue_kick(vi->cvq)))
> > > > -               goto unlock;
> > > > +       if (unlikely(!virtqueue_kick(vi->cvq))) {
> > > > +               mutex_unlock(&vi->cvq_lock);
> > > > +               return false;
> > > > +       }
> > > > +       mutex_unlock(&vi->cvq_lock);
> > > >
> > > > -       wait_for_completion(&vi->ctrl->completion);
> > > > -       virtqueue_get_buf(vi->cvq, &tmp);
> > > > +       wait_for_completion(&ctrl->completion);
> > > >
> > > > -unlock:
> > > > -       mutex_unlock(&vi->cvq_lock);
> > > >         return ctrl->status =3D=3D VIRTIO_NET_OK;
> > > >  }
> > > >
> > > > @@ -2747,6 +2765,86 @@ static bool virtnet_send_command(struct virt=
net_info *vi, u8 class, u8 cmd,
> > > >         return virtnet_send_command_reply(vi, class, cmd, vi->ctrl,=
 out, NULL);
> > > >  }
> > > >
> > > > +static void virtnet_process_dim_cmd(struct virtnet_info *vi,
> > > > +                                   struct virtnet_coal_node *node)
> > > > +{
> > > > +       u16 qnum =3D le16_to_cpu(node->coal_vqs.vqn) / 2;
> > > > +
> > > > +       mutex_lock(&vi->rq[qnum].dim_lock);
> > > > +       vi->rq[qnum].intr_coal.max_usecs =3D
> > > > +               le32_to_cpu(node->coal_vqs.coal.max_usecs);
> > > > +       vi->rq[qnum].intr_coal.max_packets =3D
> > > > +               le32_to_cpu(node->coal_vqs.coal.max_packets);
> > > > +       vi->rq[qnum].dim.state =3D DIM_START_MEASURE;
> > > > +       mutex_unlock(&vi->rq[qnum].dim_lock);
> > > > +
> > > > +       if (node->is_coal_wait) {
> > > > +               mutex_lock(&vi->coal_wait_lock);
> > > > +               list_del(&node->list);
> > > > +               mutex_unlock(&vi->coal_wait_lock);
> > > > +               kfree(node);
> > > > +       } else {
> > > > +               mutex_lock(&vi->coal_free_lock);
> > > > +               list_add(&node->list, &vi->coal_free_list);
> > > > +               mutex_unlock(&vi->coal_free_lock);
> > > > +       }
> > > > +}
> > > > +
> > > > +static int virtnet_add_dim_command(struct virtnet_info *vi,
> > > > +                                  struct virtnet_coal_node *coal_n=
ode)
> > > > +{
> > > > +       struct scatterlist sg;
> > > > +       int ret;
> > > > +
> > > > +       sg_init_one(&sg, &coal_node->coal_vqs, sizeof(coal_node->co=
al_vqs));
> > > > +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF=
_COAL,
> > > > +                                        VIRTIO_NET_CTRL_NOTF_COAL_=
VQ_SET,
> > > > +                                        &coal_node->ctrl, &sg, NUL=
L);
> > > > +       if (!ret) {
> > > > +               dev_warn(&vi->dev->dev,
> > > > +                        "Failed to change coalescing params.\n");
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       virtnet_process_dim_cmd(vi, coal_node);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void virtnet_get_cvq_work(struct work_struct *work)
> > > > +{
> > > > +       struct virtnet_info *vi =3D
> > > > +               container_of(work, struct virtnet_info, get_cvq);
> > > > +       struct virtnet_coal_node *wait_coal;
> > > > +       bool valid =3D false;
> > > > +       unsigned int tmp;
> > > > +       void *res;
> > > > +
> > > > +       mutex_lock(&vi->cvq_lock);
> > > > +       while ((res =3D virtqueue_get_buf(vi->cvq, &tmp)) !=3D NULL=
) {
> > > > +               complete((struct completion *)res);
> > > > +               valid =3D true;
> > > > +       }
> > > > +       mutex_unlock(&vi->cvq_lock);
> > >
> > > How could we synchronize with the device in this case?
> > >
> > > E.g what happens if the device finishes another buf here?
> >
> > That's a good question. I think we can solve it using the following sni=
ppet?
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e59e12bb7601..5dc3e1244016 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> >
> > @@ -420,6 +427,12 @@ struct virtnet_info {
> >         /* Lock to protect the control VQ */
> >         struct mutex cvq_lock;
> >
> > +       /* Atomic to confirm whether the cvq work is scheduled. */
> > +       atomic_t scheduled;
> > +
> > +       /* Work struct for acquisition of cvq processing results. */
> > +       struct work_struct get_cvq;
> > +
> >
> >
> > @@ -670,7 +691,9 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
> >  {
> >         struct virtnet_info *vi =3D cvq->vdev->priv;
> >
> > -       complete(&vi->ctrl->completion);
> > +       virtqueue_disable_cb(cvq);
> > +       if (!atomic_xchg(&vi->scheduled, 1))
> > +               schedule_work(&vi->get_cvq);
>=20
> I think workqueue subsystem should already handle things like this.
>=20
> >  }
> >
> >
> > +static void virtnet_get_cvq_work(struct work_struct *work)
> > +{
> > +       struct virtnet_info *vi =3D
> > +               container_of(work, struct virtnet_info, get_cvq);
> > +       struct virtnet_coal_node *wait_coal;
> > +       bool valid =3D false;
> > +       unsigned int tmp;
> > +       void *res;
> > +
> > +       mutex_lock(&vi->cvq_lock);
> > +       while ((res =3D virtqueue_get_buf(vi->cvq, &tmp)) !=3D NULL) {
> > +               complete((struct completion *)res);
> > +               valid =3D true;
> > +       }
> > +       mutex_unlock(&vi->cvq_lock);
> > +
> > +       atomic_set(&vi->scheduled, 0);
> > +       virtqueue_enable_cb_prepare(vi->cvq);
>=20
> We have a brunch of examples in the current codes. Generally it should
> be something like.
>=20
> again:
>     disable_cb()
>     while(get_buf());
>     if (enable_cb())
>         disable_cb()
>         goto again;
>=20
> > +}
> >
> > >
> > > > +
> > > > +       if (!valid)
> > > > +               return;
> > > > +
> > > > +       while (true) {
> > > > +               wait_coal =3D NULL;
> > > > +               mutex_lock(&vi->coal_wait_lock);
> > > > +               if (!list_empty(&vi->coal_wait_list))
> > > > +                       wait_coal =3D list_first_entry(&vi->coal_wa=
it_list,
> > > > +                                                    struct virtnet=
_coal_node,
> > > > +                                                    list);
> > > > +               mutex_unlock(&vi->coal_wait_lock);
> > > > +               if (wait_coal)
> > > > +                       if (virtnet_add_dim_command(vi, wait_coal))
> > > > +                               break;
> > > > +               else
> > > > +                       break;
> > > > +       }
> > >
> > > This is still an ad-hoc optimization for dim in the general path here.
> > >
> > > Could we have a fn callback so for non dim it's just a completion and
> > > for dim it would be a schedule_work()?
> > >
> >
> > OK, I will try this.
> >
> > And how about this :
> >
> > +static void virtnet_cvq_work_sched(struct virtqueue *cvq)
> > +{
> > +       struct virtnet_info *vi =3D cvq->vdev->priv;
> > +
> > +       virtqueue_disable_cb(cvq);
> > +       if (!atomic_xchg(&vi->scheduled, 1))
> > +               schedule_work(&vi->get_cvq);
> > +}
> > +
> >  static void virtnet_cvq_done(struct virtqueue *cvq)
> >  {
> >         struct virtnet_info *vi =3D cvq->vdev->priv;
> > +       unsigned int tmp;
> >
> > +       virtqueue_get_buf(vi->cvq, &tmp);
> >         complete(&vi->ctrl->completion);
> >  }
> >
> > @@ -5318,7 +5472,11 @@ static int virtnet_find_vqs(struct virtnet_info =
*vi)
> >
> >         /* Parameters for control virtqueue, if any */
> >         if (vi->has_cvq) {
> > -               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_C=
OAL))
> > +                       callbacks[total_vqs - 1] =3D virtnet_cvq_work_s=
ched;
> > +               else
> > +                       callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > +
> >                 names[total_vqs - 1] =3D "control";
> >         }
>=20
> Just to clarify, I meant a callback function per control_buf. (I've
> avoid touching virtqueue callback layers)
>=20
>=20
> >
> > > > +}
> > > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > >  {
> > > >         struct virtnet_info *vi =3D netdev_priv(dev);
> > > > @@ -4398,35 +4496,73 @@ static int virtnet_send_notf_coal_vq_cmds(s=
truct virtnet_info *vi,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static void virtnet_put_wait_coal(struct virtnet_info *vi,
> > > > +                                 struct receive_queue *rq,
> > > > +                                 struct dim_cq_moder moder)
> > > > +{
> > > > +       struct virtnet_coal_node *wait_node;
> > > > +
> > > > +       wait_node =3D kzalloc(sizeof(*wait_node), GFP_KERNEL);
> > > > +       if (!wait_node) {
> > > > +               rq->dim.state =3D DIM_START_MEASURE;
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       wait_node->is_coal_wait =3D true;
> > > > +       wait_node->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq)=
);
> > > > +       wait_node->coal_vqs.coal.max_usecs =3D cpu_to_le32(moder.us=
ec);
> > > > +       wait_node->coal_vqs.coal.max_packets =3D cpu_to_le32(moder.=
pkts);
> > > > +       mutex_lock(&vi->coal_wait_lock);
> > > > +       list_add_tail(&wait_node->list, &vi->coal_wait_list);
> > > > +       mutex_unlock(&vi->coal_wait_lock);
> > > > +}
> > > > +
> > > >  static void virtnet_rx_dim_work(struct work_struct *work)
> > > >  {
> > > >         struct dim *dim =3D container_of(work, struct dim, work);
> > > >         struct receive_queue *rq =3D container_of(dim,
> > > >                         struct receive_queue, dim);
> > > >         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> > > > -       struct net_device *dev =3D vi->dev;
> > > > +       struct virtnet_coal_node *avail_coal;
> > > >         struct dim_cq_moder update_moder;
> > > > -       int qnum, err;
> > > >
> > > > -       qnum =3D rq - vi->rq;
> > > > +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->=
profile_ix);
> > > >
> > > >         mutex_lock(&rq->dim_lock);
> > > > -       if (!rq->dim_enabled)
> > > > -               goto out;
> > > > -
> > > > -       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->=
profile_ix);
> > > > -       if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> > > > -           update_moder.pkts !=3D rq->intr_coal.max_packets) {
> > > > -               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> > > > -                                                      update_moder=
.usec,
> > > > -                                                      update_moder=
.pkts);
> > > > -               if (err)
> > > > -                       pr_debug("%s: Failed to send dim parameters=
 on rxq%d\n",
> > > > -                                dev->name, qnum);
> > > > -               dim->state =3D DIM_START_MEASURE;
> > > > +       if (!rq->dim_enabled ||
> > > > +           (update_moder.usec =3D=3D rq->intr_coal.max_usecs &&
> > > > +            update_moder.pkts =3D=3D rq->intr_coal.max_packets)) {
> > > > +               rq->dim.state =3D DIM_START_MEASURE;
> > > > +               mutex_unlock(&rq->dim_lock);
> > > > +               return;
> > > >         }
> > > > -out:
> > > >         mutex_unlock(&rq->dim_lock);
> > > > +
> > > > +       mutex_lock(&vi->cvq_lock);
> > > > +       if (vi->cvq->num_free < 3) {
> > > > +               virtnet_put_wait_coal(vi, rq, update_moder);
> > > > +               mutex_unlock(&vi->cvq_lock);
> > > > +               return;
> > > > +       }
> > >
> > > Could we simply sleep instead of using a list here?
> >
> > Do you mean using a semaphore, or a waitqueue?
>=20
> I meant sleep and wait for more space.
>=20
> Thanks
>=20

