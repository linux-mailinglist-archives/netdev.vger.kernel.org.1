Return-Path: <netdev+bounces-101245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162508FDD25
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EE81C211BC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672A1BDD5;
	Thu,  6 Jun 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MahMwqka"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2C1DFD1
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643170; cv=none; b=pbpNhAGYPxZ9wVBfMvM75KR87bdDzW6AGGbL42RQwzJlpGxfXucQZDpanYvbtX5pr8CpQ5woSBB/i/jXfJS8h8uA3xZWGGRH0cQ/PmgyV5d3b0yQSWvjhhniPL+wpM1j3YUjNibp6rSqU22NZjSjIXB+cdxdWWSi/1R9UqnLWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643170; c=relaxed/simple;
	bh=6VY/OhqdB7YwAOB6VnvcsGbiCQqTmgpBdjJIphmRSLU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=AvSGLHxwU9DkU+pPo+6RsgwTIdyPqve27L8MhS2MVujw4Si1W3DjA8NZFNEGJXDNvP1uOEYygc94zDosvaKfuR/UQKT/JJdpDbpFfhvu29izr8QZk/VmZ/TQB5ei3cvFRqG0HhcjZRtgctUDuAuQN2CbhKRQH5I/3nM4YCRGk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MahMwqka; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717643163; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=I1FLNRVgPfZex60y7UTLgH1N1syFYtHTE9N+rIvQ/eU=;
	b=MahMwqkaDdAqj53YQpFrx87tIsxMZqibGZlti8kf9K+sdu3d9T1jSavlQCCVUpVw9fN0LbEp0qKHq0i6kgAsG7/ymbO1Rdard8em6wMGNNQyqPJ+PIxKs13lmMRyKg7EQtiqtyj0pv3ZOMfOCo2wCdHqGnmykKDqp9VutoWlWX4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7waqZm_1717643162;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7waqZm_1717643162)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:06:03 +0800
Message-ID: <1717643130.589116-6-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: improve dim command request efficiency
Date: Thu, 6 Jun 2024 11:05:30 +0800
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
References: <20240605145533.86229-1-hengqi@linux.alibaba.com>
 <20240605145533.86229-3-hengqi@linux.alibaba.com>
 <CACGkMEu-HFw0n_WtxDDmypj4WLTEF=8W6Pa_1UCtmvhbTP_udw@mail.gmail.com>
In-Reply-To: <CACGkMEu-HFw0n_WtxDDmypj4WLTEF=8W6Pa_1UCtmvhbTP_udw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 6 Jun 2024 08:27:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jun 5, 2024 at 10:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Currently, the control queue (ctrlq) handles commands synchronously,
> > leading to increased delays for dim commands during multi-queue
> > VM configuration and directly impacting dim performance.
> >
> > To address this, we are shifting to asynchronous processing of
> > ctrlq's dim commands.
> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 260 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 236 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9b556ce89546..7975084052ad 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -270,6 +270,14 @@ struct virtnet_interrupt_coalesce {
> >         u32 max_usecs;
> >  };
> >
> > +struct virtnet_coal_node {
> > +       struct virtio_net_ctrl_hdr hdr;
> > +       virtio_net_ctrl_ack status;
> > +       struct virtio_net_ctrl_coal_vq coal_vqs;
> > +       bool is_coal_wait;
> > +       struct list_head list;
> > +};
> > +
> >  /* The dma information of pages allocated at a time. */
> >  struct virtnet_rq_dma {
> >         dma_addr_t addr;
> > @@ -421,6 +429,9 @@ struct virtnet_info {
> >         /* Wait for the device to complete the cvq request. */
> >         struct completion completion;
> >
> > +       /* Work struct for acquisition of cvq processing results. */
> > +       struct work_struct get_cvq;
> > +
> >         /* Host can handle any s/g split between our header and packet =
data */
> >         bool any_header_sg;
> >
> > @@ -465,6 +476,14 @@ struct virtnet_info {
> >         struct virtnet_interrupt_coalesce intr_coal_tx;
> >         struct virtnet_interrupt_coalesce intr_coal_rx;
> >
> > +       /* Free nodes used for concurrent delivery */
> > +       struct mutex coal_free_lock;
> > +       struct list_head coal_free_list;
> > +
> > +       /* Filled when there are no free nodes or cvq buffers */
> > +       struct mutex coal_wait_lock;
> > +       struct list_head coal_wait_list;
> > +
> >         unsigned long guest_offloads;
> >         unsigned long guest_offloads_capable;
> >
> > @@ -671,7 +690,7 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
> >  {
> >         struct virtnet_info *vi =3D cvq->vdev->priv;
> >
> > -       complete(&vi->completion);
> > +       schedule_work(&vi->get_cvq);
> >  }
> >
> >  static void skb_xmit_done(struct virtqueue *vq)
> > @@ -2183,6 +2202,113 @@ static bool try_fill_recv(struct virtnet_info *=
vi, struct receive_queue *rq,
> >         return !oom;
> >  }
> >
> > +static int __virtnet_add_dim_command(struct virtnet_info *vi,
> > +                                    struct virtnet_coal_node *ctrl)
> > +{
> > +       struct scatterlist *sgs[4], hdr, stat, out;
> > +       unsigned int out_num =3D 0;
> > +       int ret;
> > +
> > +       BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> > +
> > +       ctrl->hdr.class =3D VIRTIO_NET_CTRL_NOTF_COAL;
> > +       ctrl->hdr.cmd =3D VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET;
> > +
> > +       sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
> > +       sgs[out_num++] =3D &hdr;
> > +
> > +       sg_init_one(&out, &ctrl->coal_vqs, sizeof(ctrl->coal_vqs));
> > +       sgs[out_num++] =3D &out;
> > +
> > +       ctrl->status =3D ~0;
> > +       sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
> > +       sgs[out_num] =3D &stat;
> > +
> > +       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_A=
TOMIC);
> > +       if (ret < 0) {
> > +               dev_warn(&vi->vdev->dev,
> > +                        "Failed to add sgs for command vq: %d\n.", ret=
);
> > +               return ret;
> > +       }
> > +
> > +       if (unlikely(!virtqueue_kick(vi->cvq)))
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static int virtnet_add_dim_command(struct virtnet_info *vi,
> > +                                  struct virtnet_coal_node *ctrl)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&vi->cvq_lock);
> > +       ret =3D __virtnet_add_dim_command(vi, ctrl);
> > +       mutex_unlock(&vi->cvq_lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static void virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
> > +{
> > +       struct virtnet_coal_node *node =3D (struct virtnet_coal_node *)=
res;
> > +       u16 qnum =3D le16_to_cpu(node->coal_vqs.vqn) / 2;
> > +
> > +       mutex_lock(&vi->rq[qnum].dim_lock);
> > +       vi->rq[qnum].intr_coal.max_usecs =3D
> > +               le32_to_cpu(node->coal_vqs.coal.max_usecs);
> > +       vi->rq[qnum].intr_coal.max_packets =3D
> > +               le32_to_cpu(node->coal_vqs.coal.max_packets);
> > +       vi->rq[qnum].dim.state =3D DIM_START_MEASURE;
> > +       mutex_unlock(&vi->rq[qnum].dim_lock);
> > +
> > +       if (node->is_coal_wait) {
> > +               kfree(node);
> > +       } else {
> > +               mutex_lock(&vi->coal_free_lock);
> > +               list_add(&node->list, &vi->coal_free_list);
> > +               mutex_unlock(&vi->coal_free_lock);
> > +       }
> > +}
> > +
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
> > +               if (res =3D=3D ((void *)vi))
> > +                       complete(&vi->completion);
> > +               else
> > +                       virtnet_process_dim_cmd(vi, res);
>=20
> This seems an ad-hoc optimization for dim? Instead of doing this, I
> wonder if we can make it re-usable for other possible use cases.
>=20

The purpose of this is that I don't see the need for concurrent ctrlq reque=
sts
in addition to dim. But I can try your suggestion.

Thanks.

> For example, just allocation completion and store the completion as a
> token. Then virtqueue_get_buf can wake up the correct completion?
>=20
> Thanks
>=20
> > +
> > +               valid =3D true;
> > +       }
> > +
> > +       if (!valid) {
> > +               mutex_unlock(&vi->cvq_lock);
> > +               return;
> > +       }
> > +
> > +       mutex_lock(&vi->coal_wait_lock);
> > +       while (!list_empty(&vi->coal_wait_list)) {
> > +               wait_coal =3D list_first_entry(&vi->coal_wait_list,
> > +                                            struct virtnet_coal_node, =
list);
> > +               if (__virtnet_add_dim_command(vi, wait_coal))
> > +                       break;
> > +               list_del(&wait_coal->list);
> > +       }
> > +       mutex_unlock(&vi->coal_wait_lock);
> > +
> > +       mutex_unlock(&vi->cvq_lock);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >         struct virtnet_info *vi =3D rvq->vdev->priv;
> > @@ -2695,7 +2821,7 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
> >                                        struct scatterlist *in)
> >  {
> >         struct scatterlist *sgs[5], hdr, stat;
> > -       u32 out_num =3D 0, tmp, in_num =3D 0;
> > +       u32 out_num =3D 0, in_num =3D 0;
> >         int ret;
> >
> >         /* Caller should know better */
> > @@ -2728,14 +2854,15 @@ static bool virtnet_send_command_reply(struct v=
irtnet_info *vi, u8 class, u8 cmd
> >                 return false;
> >         }
> >
> > -       if (unlikely(!virtqueue_kick(vi->cvq)))
> > -               goto unlock;
> > +       if (unlikely(!virtqueue_kick(vi->cvq))) {
> > +               mutex_unlock(&vi->cvq_lock);
> > +               return false;
> > +       }
> > +
> > +       mutex_unlock(&vi->cvq_lock);
> >
> >         wait_for_completion(&vi->completion);
> > -       virtqueue_get_buf(vi->cvq, &tmp);
> >
> > -unlock:
> > -       mutex_unlock(&vi->cvq_lock);
> >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >  }
> >
> > @@ -4396,35 +4523,73 @@ static int virtnet_send_notf_coal_vq_cmds(struc=
t virtnet_info *vi,
> >         return 0;
> >  }
> >
> > +static void virtnet_put_wait_coal(struct virtnet_info *vi,
> > +                                 struct receive_queue *rq,
> > +                                 struct dim_cq_moder moder)
> > +{
> > +       struct virtnet_coal_node *wait_node;
> > +
> > +       wait_node =3D kzalloc(sizeof(*wait_node), GFP_KERNEL);
> > +       if (!wait_node) {
> > +               rq->dim.state =3D DIM_START_MEASURE;
> > +               return;
> > +       }
> > +
> > +       wait_node->is_coal_wait =3D true;
> > +       wait_node->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq));
> > +       wait_node->coal_vqs.coal.max_usecs =3D cpu_to_le32(moder.usec);
> > +       wait_node->coal_vqs.coal.max_packets =3D cpu_to_le32(moder.pkts=
);
> > +       mutex_lock(&vi->coal_wait_lock);
> > +       list_add_tail(&wait_node->list, &vi->coal_wait_list);
> > +       mutex_unlock(&vi->coal_wait_lock);
> > +}
> > +
> >  static void virtnet_rx_dim_work(struct work_struct *work)
> >  {
> >         struct dim *dim =3D container_of(work, struct dim, work);
> >         struct receive_queue *rq =3D container_of(dim,
> >                         struct receive_queue, dim);
> >         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> > -       struct net_device *dev =3D vi->dev;
> > +       struct virtnet_coal_node *avail_coal;
> >         struct dim_cq_moder update_moder;
> > -       int qnum, err;
> >
> > -       qnum =3D rq - vi->rq;
> > +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->prof=
ile_ix);
> >
> >         mutex_lock(&rq->dim_lock);
> > -       if (!rq->dim_enabled)
> > -               goto out;
> > -
> > -       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->prof=
ile_ix);
> > -       if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> > -           update_moder.pkts !=3D rq->intr_coal.max_packets) {
> > -               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> > -                                                      update_moder.use=
c,
> > -                                                      update_moder.pkt=
s);
> > -               if (err)
> > -                       pr_debug("%s: Failed to send dim parameters on =
rxq%d\n",
> > -                                dev->name, qnum);
> > -               dim->state =3D DIM_START_MEASURE;
> > +       if (!rq->dim_enabled ||
> > +           (update_moder.usec =3D=3D rq->intr_coal.max_usecs &&
> > +            update_moder.pkts =3D=3D rq->intr_coal.max_packets)) {
> > +               rq->dim.state =3D DIM_START_MEASURE;
> > +               mutex_unlock(&rq->dim_lock);
> > +               return;
> >         }
> > -out:
> >         mutex_unlock(&rq->dim_lock);
> > +
> > +       mutex_lock(&vi->cvq_lock);
> > +       if (vi->cvq->num_free < 3) {
> > +               virtnet_put_wait_coal(vi, rq, update_moder);
> > +               mutex_unlock(&vi->cvq_lock);
> > +               return;
> > +       }
> > +       mutex_unlock(&vi->cvq_lock);
> > +
> > +       mutex_lock(&vi->coal_free_lock);
> > +       if (list_empty(&vi->coal_free_list)) {
> > +               virtnet_put_wait_coal(vi, rq, update_moder);
> > +               mutex_unlock(&vi->coal_free_lock);
> > +               return;
> > +       }
> > +
> > +       avail_coal =3D list_first_entry(&vi->coal_free_list,
> > +                                     struct virtnet_coal_node, list);
> > +       avail_coal->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq));
> > +       avail_coal->coal_vqs.coal.max_usecs =3D cpu_to_le32(update_mode=
r.usec);
> > +       avail_coal->coal_vqs.coal.max_packets =3D cpu_to_le32(update_mo=
der.pkts);
> > +
> > +       list_del(&avail_coal->list);
> > +       mutex_unlock(&vi->coal_free_lock);
> > +
> > +       virtnet_add_dim_command(vi, avail_coal);
> >  }
> >
> >  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
> > @@ -4837,6 +5002,7 @@ static void virtnet_freeze_down(struct virtio_dev=
ice *vdev)
> >         flush_work(&vi->config_work);
> >         disable_rx_mode_work(vi);
> >         flush_work(&vi->rx_mode_work);
> > +       flush_work(&vi->get_cvq);
> >
> >         netif_tx_lock_bh(vi->dev);
> >         netif_device_detach(vi->dev);
> > @@ -5610,6 +5776,45 @@ static const struct xdp_metadata_ops virtnet_xdp=
_metadata_ops =3D {
> >         .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> >  };
> >
> > +static void virtnet_del_coal_free_list(struct virtnet_info *vi)
> > +{
> > +       struct virtnet_coal_node *coal_node, *tmp;
> > +
> > +       list_for_each_entry_safe(coal_node, tmp,  &vi->coal_free_list, =
list) {
> > +               list_del(&coal_node->list);
> > +               kfree(coal_node);
> > +       }
> > +}
> > +
> > +static int virtnet_init_coal_list(struct virtnet_info *vi)
> > +{
> > +       struct virtnet_coal_node *coal_node;
> > +       int batch_dim_nums;
> > +       int i;
> > +
> > +       INIT_LIST_HEAD(&vi->coal_free_list);
> > +       mutex_init(&vi->coal_free_lock);
> > +
> > +       INIT_LIST_HEAD(&vi->coal_wait_list);
> > +       mutex_init(&vi->coal_wait_lock);
> > +
> > +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > +               return 0;
> > +
> > +       batch_dim_nums =3D min((unsigned int)vi->max_queue_pairs,
> > +                            virtqueue_get_vring_size(vi->cvq) / 3);
> > +       for (i =3D 0; i < batch_dim_nums; i++) {
> > +               coal_node =3D kzalloc(sizeof(*coal_node), GFP_KERNEL);
> > +               if (!coal_node) {
> > +                       virtnet_del_coal_free_list(vi);
> > +                       return -ENOMEM;
> > +               }
> > +               list_add(&coal_node->list, &vi->coal_free_list);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >         int i, err =3D -ENOMEM;
> > @@ -5795,6 +6000,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >         if (err)
> >                 goto free;
> >
> > +       if (virtnet_init_coal_list(vi))
> > +               goto free;
> > +
> >         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> >                 vi->intr_coal_rx.max_usecs =3D 0;
> >                 vi->intr_coal_tx.max_usecs =3D 0;
> > @@ -5836,6 +6044,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >         if (vi->has_rss || vi->has_rss_hash_report)
> >                 virtnet_init_default_rss(vi);
> >
> > +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> >         init_completion(&vi->completion);
> >         enable_rx_mode_work(vi);
> >
> > @@ -5965,11 +6174,14 @@ static void virtnet_remove(struct virtio_device=
 *vdev)
> >         flush_work(&vi->config_work);
> >         disable_rx_mode_work(vi);
> >         flush_work(&vi->rx_mode_work);
> > +       flush_work(&vi->get_cvq);
> >
> >         unregister_netdev(vi->dev);
> >
> >         net_failover_destroy(vi->failover);
> >
> > +       virtnet_del_coal_free_list(vi);
> > +
> >         remove_vq_common(vi);
> >
> >         free_netdev(vi->dev);
> > --
> > 2.32.0.3.g01195cf9f
> >
>=20

