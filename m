Return-Path: <netdev+bounces-104303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECD90C144
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B262813A7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31747FF;
	Tue, 18 Jun 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROGwoCQP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0974C79
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674206; cv=none; b=bBTeFEBJdHJTRfP8cAtAWu2fTwcZr0goroJHlTY5n01cbO40akRkAozvj1NcDffHjWKhVefK5FQlcwlxz/I7yoKrh2/TQJYsOV4NCUOBHxvRJdLVucdfIYEMQAe4I4WJlsUMT6cZDQkCrzRJ8ZAwWkzOo+T9JfV31oV1itLteCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674206; c=relaxed/simple;
	bh=B/Ep8RX5l2mqJEqfnM3zAkxZq69Nfkk6Ubyzcatj5Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6VG09RzWxR2gEktgfYnpAijW+dBdoHeITPOcQWSetBfRgWAh6jxzgPOMCT1/cnmCUH3hjZabXVZLkQK4/bNukKH+niIpWonfZhSyEJ30LjZ8YrvWGLQufxwmTwxDnk4iLzidrOZRwP4rcVz095lGhg1aw12X8mPPYl+mKGuUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROGwoCQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718674203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d32pFFJRxG6xa7aHMA41Drh8lfoVaHYvzVDe49jaFto=;
	b=ROGwoCQPQului12SKUNgzRjEysipXUC8nBY3XaaIX7eh+RJ04MFNK0ngZvPrSdh0vdzPpQ
	XxnDv15/37KYF6zqviWjNZ/tkDRpxRy5crHkFrtldPFVal9ZpJEgSgjWr/Psb4edyePTJm
	ugaTM14u0CV0hqYoxjC/9JO+pmno3+o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-xVLGa-x5MHu7BzCASNjiFQ-1; Mon, 17 Jun 2024 21:30:02 -0400
X-MC-Unique: xVLGa-x5MHu7BzCASNjiFQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6e3341c8865so4671213a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718674201; x=1719279001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d32pFFJRxG6xa7aHMA41Drh8lfoVaHYvzVDe49jaFto=;
        b=b6BJGKu4iPUN+UEM3SxFdtVmED3+S5xYhELXPn9YooHIotZWkVRAQ9CvWLnnRrKXH2
         IwjPzL/sNfZDZXD5m9XnTOxBjHCRN3KGrf21DTSyz5lhrUu4dkB8i/hrZf6jvVysaPA0
         2XG3INShSJAfVNUuaOJUOJ5WASChgqudt7PstjBh3ntZr3tfnerVBWEyDdpKQuiAB8QI
         VnKRAtGW6KbG53fuTjQxIRiWGHaoxKw3FFMsHEy8sNIZQEeLAsBWyAbz1beZU1OjWZYM
         A26xjBS0p5LF96iXY0p1/GSYOUrKlKjOXkigHJyCzbAEHfOrAAuZlFCnj1Dl61idSSIh
         +E1Q==
X-Gm-Message-State: AOJu0YwbiM8wLa9U4K3IbmUeMXjkwPfv277JYB5PqFB2354xesDWxxDx
	/9sz8D5FFGGVBjFJXySNjn0/hTP+DA6s9QhR2pjcVVP79p4svaFzZl0TxVzJm3m337tYBmH+pwU
	QPl1lruM9mirAIrALogjJKM5LNUlFt+ygjK2ret0ibiIPzok1PBEj6azitQpG5dPXRnJGHlmGBg
	frCyfun5lT5IhQcj/amPKWNZEFZo1Z
X-Received: by 2002:a05:6a20:7f94:b0:1b7:4adb:1dcc with SMTP id adf61e73a8af0-1bae83551eemr11923761637.60.1718674200953;
        Mon, 17 Jun 2024 18:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3U+fynsDP8MHk8QAgkUH6RvkqOH/q/a3/hTrPEqxppBkeB9rjsrgzl0Kanxv9dqpqcR4/XIAmbZCnJktX+nI=
X-Received: by 2002:a05:6a20:7f94:b0:1b7:4adb:1dcc with SMTP id
 adf61e73a8af0-1bae83551eemr11923739637.60.1718674200393; Mon, 17 Jun 2024
 18:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606061446.127802-1-hengqi@linux.alibaba.com>
 <20240606061446.127802-5-hengqi@linux.alibaba.com> <CACGkMEuFJ=xeeBt9GiCLj8AeJg-u-JG4F9_+8vBoH4dhZ-z=3Q@mail.gmail.com>
 <1718609268.7814527-9-hengqi@linux.alibaba.com>
In-Reply-To: <1718609268.7814527-9-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:29:48 +0800
Message-ID: <CACGkMEvdbUzxMKoz+=TO8C5H06TvdL-nFPpe8qd==5PiXRjpTA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] virtio_net: improve dim command request efficiency
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:08=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Mon, 17 Jun 2024 12:05:30 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jun 6, 2024 at 2:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> > >
> > > Currently, control vq handles commands synchronously,
> > > leading to increased delays for dim commands during multi-queue
> > > VM configuration and directly impacting dim performance.
> > >
> > > To address this, we are shifting to asynchronous processing of
> > > ctrlq's dim commands.
> > >
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 233 ++++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 208 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e59e12bb7601..0338528993ab 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -376,6 +376,13 @@ struct control_buf {
> > >         struct completion completion;
> > >  };
> > >
> > > +struct virtnet_coal_node {
> > > +       struct control_buf ctrl;
> > > +       struct virtio_net_ctrl_coal_vq coal_vqs;
> > > +       bool is_coal_wait;
> > > +       struct list_head list;
> > > +};
> > > +
> > >  struct virtnet_info {
> > >         struct virtio_device *vdev;
> > >         struct virtqueue *cvq;
> > > @@ -420,6 +427,9 @@ struct virtnet_info {
> > >         /* Lock to protect the control VQ */
> > >         struct mutex cvq_lock;
> > >
> > > +       /* Work struct for acquisition of cvq processing results. */
> > > +       struct work_struct get_cvq;
> > > +
> > >         /* Host can handle any s/g split between our header and packe=
t data */
> > >         bool any_header_sg;
> > >
> > > @@ -464,6 +474,14 @@ struct virtnet_info {
> > >         struct virtnet_interrupt_coalesce intr_coal_tx;
> > >         struct virtnet_interrupt_coalesce intr_coal_rx;
> > >
> > > +       /* Free nodes used for concurrent delivery */
> > > +       struct mutex coal_free_lock;
> > > +       struct list_head coal_free_list;
> > > +
> > > +       /* Filled when there are no free nodes or cvq buffers */
> > > +       struct mutex coal_wait_lock;
> > > +       struct list_head coal_wait_list;
> > > +
> > >         unsigned long guest_offloads;
> > >         unsigned long guest_offloads_capable;
> > >
> > > @@ -670,7 +688,7 @@ static void virtnet_cvq_done(struct virtqueue *cv=
q)
> > >  {
> > >         struct virtnet_info *vi =3D cvq->vdev->priv;
> > >
> > > -       complete(&vi->ctrl->completion);
> > > +       schedule_work(&vi->get_cvq);
> > >  }
> > >
> > >  static void skb_xmit_done(struct virtqueue *vq)
> > > @@ -2696,7 +2714,7 @@ static bool virtnet_send_command_reply(struct v=
irtnet_info *vi,
> > >                                        struct scatterlist *in)
> > >  {
> > >         struct scatterlist *sgs[5], hdr, stat;
> > > -       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > +       u32 out_num =3D 0, in_num =3D 0;
> > >         int ret;
> > >
> > >         /* Caller should know better */
> > > @@ -2730,14 +2748,14 @@ static bool virtnet_send_command_reply(struct=
 virtnet_info *vi,
> > >                 return false;
> > >         }
> > >
> > > -       if (unlikely(!virtqueue_kick(vi->cvq)))
> > > -               goto unlock;
> > > +       if (unlikely(!virtqueue_kick(vi->cvq))) {
> > > +               mutex_unlock(&vi->cvq_lock);
> > > +               return false;
> > > +       }
> > > +       mutex_unlock(&vi->cvq_lock);
> > >
> > > -       wait_for_completion(&vi->ctrl->completion);
> > > -       virtqueue_get_buf(vi->cvq, &tmp);
> > > +       wait_for_completion(&ctrl->completion);
> > >
> > > -unlock:
> > > -       mutex_unlock(&vi->cvq_lock);
> > >         return ctrl->status =3D=3D VIRTIO_NET_OK;
> > >  }
> > >
> > > @@ -2747,6 +2765,86 @@ static bool virtnet_send_command(struct virtne=
t_info *vi, u8 class, u8 cmd,
> > >         return virtnet_send_command_reply(vi, class, cmd, vi->ctrl, o=
ut, NULL);
> > >  }
> > >
> > > +static void virtnet_process_dim_cmd(struct virtnet_info *vi,
> > > +                                   struct virtnet_coal_node *node)
> > > +{
> > > +       u16 qnum =3D le16_to_cpu(node->coal_vqs.vqn) / 2;
> > > +
> > > +       mutex_lock(&vi->rq[qnum].dim_lock);
> > > +       vi->rq[qnum].intr_coal.max_usecs =3D
> > > +               le32_to_cpu(node->coal_vqs.coal.max_usecs);
> > > +       vi->rq[qnum].intr_coal.max_packets =3D
> > > +               le32_to_cpu(node->coal_vqs.coal.max_packets);
> > > +       vi->rq[qnum].dim.state =3D DIM_START_MEASURE;
> > > +       mutex_unlock(&vi->rq[qnum].dim_lock);
> > > +
> > > +       if (node->is_coal_wait) {
> > > +               mutex_lock(&vi->coal_wait_lock);
> > > +               list_del(&node->list);
> > > +               mutex_unlock(&vi->coal_wait_lock);
> > > +               kfree(node);
> > > +       } else {
> > > +               mutex_lock(&vi->coal_free_lock);
> > > +               list_add(&node->list, &vi->coal_free_list);
> > > +               mutex_unlock(&vi->coal_free_lock);
> > > +       }
> > > +}
> > > +
> > > +static int virtnet_add_dim_command(struct virtnet_info *vi,
> > > +                                  struct virtnet_coal_node *coal_nod=
e)
> > > +{
> > > +       struct scatterlist sg;
> > > +       int ret;
> > > +
> > > +       sg_init_one(&sg, &coal_node->coal_vqs, sizeof(coal_node->coal=
_vqs));
> > > +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_C=
OAL,
> > > +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ=
_SET,
> > > +                                        &coal_node->ctrl, &sg, NULL)=
;
> > > +       if (!ret) {
> > > +               dev_warn(&vi->dev->dev,
> > > +                        "Failed to change coalescing params.\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       virtnet_process_dim_cmd(vi, coal_node);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void virtnet_get_cvq_work(struct work_struct *work)
> > > +{
> > > +       struct virtnet_info *vi =3D
> > > +               container_of(work, struct virtnet_info, get_cvq);
> > > +       struct virtnet_coal_node *wait_coal;
> > > +       bool valid =3D false;
> > > +       unsigned int tmp;
> > > +       void *res;
> > > +
> > > +       mutex_lock(&vi->cvq_lock);
> > > +       while ((res =3D virtqueue_get_buf(vi->cvq, &tmp)) !=3D NULL) =
{
> > > +               complete((struct completion *)res);
> > > +               valid =3D true;
> > > +       }
> > > +       mutex_unlock(&vi->cvq_lock);
> >
> > How could we synchronize with the device in this case?
> >
> > E.g what happens if the device finishes another buf here?
>
> That's a good question. I think we can solve it using the following snipp=
et?
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e59e12bb7601..5dc3e1244016 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
>
> @@ -420,6 +427,12 @@ struct virtnet_info {
>         /* Lock to protect the control VQ */
>         struct mutex cvq_lock;
>
> +       /* Atomic to confirm whether the cvq work is scheduled. */
> +       atomic_t scheduled;
> +
> +       /* Work struct for acquisition of cvq processing results. */
> +       struct work_struct get_cvq;
> +
>
>
> @@ -670,7 +691,9 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
>  {
>         struct virtnet_info *vi =3D cvq->vdev->priv;
>
> -       complete(&vi->ctrl->completion);
> +       virtqueue_disable_cb(cvq);
> +       if (!atomic_xchg(&vi->scheduled, 1))
> +               schedule_work(&vi->get_cvq);

I think workqueue subsystem should already handle things like this.

>  }
>
>
> +static void virtnet_get_cvq_work(struct work_struct *work)
> +{
> +       struct virtnet_info *vi =3D
> +               container_of(work, struct virtnet_info, get_cvq);
> +       struct virtnet_coal_node *wait_coal;
> +       bool valid =3D false;
> +       unsigned int tmp;
> +       void *res;
> +
> +       mutex_lock(&vi->cvq_lock);
> +       while ((res =3D virtqueue_get_buf(vi->cvq, &tmp)) !=3D NULL) {
> +               complete((struct completion *)res);
> +               valid =3D true;
> +       }
> +       mutex_unlock(&vi->cvq_lock);
> +
> +       atomic_set(&vi->scheduled, 0);
> +       virtqueue_enable_cb_prepare(vi->cvq);

We have a brunch of examples in the current codes. Generally it should
be something like.

again:
    disable_cb()
    while(get_buf());
    if (enable_cb())
        disable_cb()
        goto again;

> +}
>
> >
> > > +
> > > +       if (!valid)
> > > +               return;
> > > +
> > > +       while (true) {
> > > +               wait_coal =3D NULL;
> > > +               mutex_lock(&vi->coal_wait_lock);
> > > +               if (!list_empty(&vi->coal_wait_list))
> > > +                       wait_coal =3D list_first_entry(&vi->coal_wait=
_list,
> > > +                                                    struct virtnet_c=
oal_node,
> > > +                                                    list);
> > > +               mutex_unlock(&vi->coal_wait_lock);
> > > +               if (wait_coal)
> > > +                       if (virtnet_add_dim_command(vi, wait_coal))
> > > +                               break;
> > > +               else
> > > +                       break;
> > > +       }
> >
> > This is still an ad-hoc optimization for dim in the general path here.
> >
> > Could we have a fn callback so for non dim it's just a completion and
> > for dim it would be a schedule_work()?
> >
>
> OK, I will try this.
>
> And how about this :
>
> +static void virtnet_cvq_work_sched(struct virtqueue *cvq)
> +{
> +       struct virtnet_info *vi =3D cvq->vdev->priv;
> +
> +       virtqueue_disable_cb(cvq);
> +       if (!atomic_xchg(&vi->scheduled, 1))
> +               schedule_work(&vi->get_cvq);
> +}
> +
>  static void virtnet_cvq_done(struct virtqueue *cvq)
>  {
>         struct virtnet_info *vi =3D cvq->vdev->priv;
> +       unsigned int tmp;
>
> +       virtqueue_get_buf(vi->cvq, &tmp);
>         complete(&vi->ctrl->completion);
>  }
>
> @@ -5318,7 +5472,11 @@ static int virtnet_find_vqs(struct virtnet_info *v=
i)
>
>         /* Parameters for control virtqueue, if any */
>         if (vi->has_cvq) {
> -               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COA=
L))
> +                       callbacks[total_vqs - 1] =3D virtnet_cvq_work_sch=
ed;
> +               else
> +                       callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> +
>                 names[total_vqs - 1] =3D "control";
>         }

Just to clarify, I meant a callback function per control_buf. (I've
avoid touching virtqueue callback layers)


>
> > > +}
> > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > >  {
> > >         struct virtnet_info *vi =3D netdev_priv(dev);
> > > @@ -4398,35 +4496,73 @@ static int virtnet_send_notf_coal_vq_cmds(str=
uct virtnet_info *vi,
> > >         return 0;
> > >  }
> > >
> > > +static void virtnet_put_wait_coal(struct virtnet_info *vi,
> > > +                                 struct receive_queue *rq,
> > > +                                 struct dim_cq_moder moder)
> > > +{
> > > +       struct virtnet_coal_node *wait_node;
> > > +
> > > +       wait_node =3D kzalloc(sizeof(*wait_node), GFP_KERNEL);
> > > +       if (!wait_node) {
> > > +               rq->dim.state =3D DIM_START_MEASURE;
> > > +               return;
> > > +       }
> > > +
> > > +       wait_node->is_coal_wait =3D true;
> > > +       wait_node->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq));
> > > +       wait_node->coal_vqs.coal.max_usecs =3D cpu_to_le32(moder.usec=
);
> > > +       wait_node->coal_vqs.coal.max_packets =3D cpu_to_le32(moder.pk=
ts);
> > > +       mutex_lock(&vi->coal_wait_lock);
> > > +       list_add_tail(&wait_node->list, &vi->coal_wait_list);
> > > +       mutex_unlock(&vi->coal_wait_lock);
> > > +}
> > > +
> > >  static void virtnet_rx_dim_work(struct work_struct *work)
> > >  {
> > >         struct dim *dim =3D container_of(work, struct dim, work);
> > >         struct receive_queue *rq =3D container_of(dim,
> > >                         struct receive_queue, dim);
> > >         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> > > -       struct net_device *dev =3D vi->dev;
> > > +       struct virtnet_coal_node *avail_coal;
> > >         struct dim_cq_moder update_moder;
> > > -       int qnum, err;
> > >
> > > -       qnum =3D rq - vi->rq;
> > > +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->pr=
ofile_ix);
> > >
> > >         mutex_lock(&rq->dim_lock);
> > > -       if (!rq->dim_enabled)
> > > -               goto out;
> > > -
> > > -       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->pr=
ofile_ix);
> > > -       if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> > > -           update_moder.pkts !=3D rq->intr_coal.max_packets) {
> > > -               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> > > -                                                      update_moder.u=
sec,
> > > -                                                      update_moder.p=
kts);
> > > -               if (err)
> > > -                       pr_debug("%s: Failed to send dim parameters o=
n rxq%d\n",
> > > -                                dev->name, qnum);
> > > -               dim->state =3D DIM_START_MEASURE;
> > > +       if (!rq->dim_enabled ||
> > > +           (update_moder.usec =3D=3D rq->intr_coal.max_usecs &&
> > > +            update_moder.pkts =3D=3D rq->intr_coal.max_packets)) {
> > > +               rq->dim.state =3D DIM_START_MEASURE;
> > > +               mutex_unlock(&rq->dim_lock);
> > > +               return;
> > >         }
> > > -out:
> > >         mutex_unlock(&rq->dim_lock);
> > > +
> > > +       mutex_lock(&vi->cvq_lock);
> > > +       if (vi->cvq->num_free < 3) {
> > > +               virtnet_put_wait_coal(vi, rq, update_moder);
> > > +               mutex_unlock(&vi->cvq_lock);
> > > +               return;
> > > +       }
> >
> > Could we simply sleep instead of using a list here?
>
> Do you mean using a semaphore, or a waitqueue?

I meant sleep and wait for more space.

Thanks


