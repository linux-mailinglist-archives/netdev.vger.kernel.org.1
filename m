Return-Path: <netdev+bounces-103909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62F90A300
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950C31F22319
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 04:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D716190B;
	Mon, 17 Jun 2024 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGF+ifUG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F521E51F
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718597152; cv=none; b=uRfnBW2RqTq65871eqBG9BO5WbeAS71osR8oO5CfH/4K2KAJ2nyPP2KYlTjXNdIa0POPS7KvK0LTq0cm6q0LCcp3K+KPvciu922BhobsUis1qLM/IQq53g7vyqZ78wKeGyDHZQJxKv5Tc6nAIgH1I5VcWeLiY07BgPJRLdxoCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718597152; c=relaxed/simple;
	bh=Rtfl7hch8NWj211oMx8AgXZlkiC2pwwGwYzmLkI+qK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsX1nJ3Rz5D983cb7IvWIo9wII9FB6J47hDGZWUqBr1kpt7bg3wl9cqn7KcQAXvajJwTDr505OAYMDaG/cuEfoxyOdsxiHxpqyp30Iu47aGxbr8SCfaV0PWhLymHse8pHdjI/9Xb/wJ/JUbw5mpOPVojNh37a/Q+HEtPDz57bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGF+ifUG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718597148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OM1zjS7rpfokdK59I2i+VlOSE25tN2UrCfHkN7PORM=;
	b=PGF+ifUGBJEOuM1QTaC2fBFymVUSACLol3H59rMBkdzyJGqyQvsHD5ukhSkrwpkOY1lJ47
	8oyOqQr6JWIGXXzmSL0n9oSaBcYFCGvdOCWFYQeZYDckuwglAdG9OOl0OlcLmYXTY4f76g
	jndYPu3JwJmX9jaacuDzbZBSuic5iLo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Wgu8npULM_-M20_mbmvPbg-1; Mon, 17 Jun 2024 00:05:44 -0400
X-MC-Unique: Wgu8npULM_-M20_mbmvPbg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-705e5df7400so1730653b3a.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 21:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718597143; x=1719201943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OM1zjS7rpfokdK59I2i+VlOSE25tN2UrCfHkN7PORM=;
        b=ExKm9PhEytXemdSOgA76krVrvCA9aJINd6/HTuZwYUShRf4alLtp+qT9AwD5M0j3Fi
         mTlwjwAtUeYYEC7zsm9p7IsOtQ7mo4Sk5BoOoAIK6xYPmn6g2PrpydiXLuqn9U2JsKMK
         AgQZ+EZY4ZTYOhw93xj5CGmykK2ddJqqhRb0jX3nAq0TIZc1lej475fOq+flgsyUrApz
         18vlym4WgPJe6C5U+nc4VWb9OGLA9hlirNurVXPpp0o7uRifDkvuFPKzTF9nhOPBwD9g
         oUIoMqGOja/o+6p9jJ+7oJgV4kjVkGh2hiV1W8H59KJSFvW5//jexFMh085oklgCxi6W
         Mk1g==
X-Gm-Message-State: AOJu0YzEpw+ylFqBVrdXdUGLMkMCFPn0wbq29jUb6G4QUjiwZRzEoNds
	0dWtdag+opNN01C1COr9KS4wP2Oaw7S1bQT+g5eg5EE89bK/Ml30JNlX98GCrdLUsFcYi3j6Mw2
	ARPaKB41Az/Cj0280vvl0b3Xq963r4WPw3pF+/Iv7Cma9MnPPqChnchmL/ejcjzAkYT6jD34GYJ
	28yzY1kdF2zUUwHl8TsfblzDSznmRw
X-Received: by 2002:a05:6a20:d50a:b0:1b2:b816:72e7 with SMTP id adf61e73a8af0-1bae8335abbmr7467285637.58.1718597142995;
        Sun, 16 Jun 2024 21:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIztzJDA12fCWVY0NriNpZiBwrYoockcHu9gbdQvfPL2lFPkoUexqGn4Hnv9RmIb/rtw5fc7ysClTC25wmOes=
X-Received: by 2002:a05:6a20:d50a:b0:1b2:b816:72e7 with SMTP id
 adf61e73a8af0-1bae8335abbmr7467278637.58.1718597142583; Sun, 16 Jun 2024
 21:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606061446.127802-1-hengqi@linux.alibaba.com> <20240606061446.127802-5-hengqi@linux.alibaba.com>
In-Reply-To: <20240606061446.127802-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 12:05:30 +0800
Message-ID: <CACGkMEuFJ=xeeBt9GiCLj8AeJg-u-JG4F9_+8vBoH4dhZ-z=3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] virtio_net: improve dim command request efficiency
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Currently, control vq handles commands synchronously,
> leading to increased delays for dim commands during multi-queue
> VM configuration and directly impacting dim performance.
>
> To address this, we are shifting to asynchronous processing of
> ctrlq's dim commands.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 233 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 208 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e59e12bb7601..0338528993ab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -376,6 +376,13 @@ struct control_buf {
>         struct completion completion;
>  };
>
> +struct virtnet_coal_node {
> +       struct control_buf ctrl;
> +       struct virtio_net_ctrl_coal_vq coal_vqs;
> +       bool is_coal_wait;
> +       struct list_head list;
> +};
> +
>  struct virtnet_info {
>         struct virtio_device *vdev;
>         struct virtqueue *cvq;
> @@ -420,6 +427,9 @@ struct virtnet_info {
>         /* Lock to protect the control VQ */
>         struct mutex cvq_lock;
>
> +       /* Work struct for acquisition of cvq processing results. */
> +       struct work_struct get_cvq;
> +
>         /* Host can handle any s/g split between our header and packet da=
ta */
>         bool any_header_sg;
>
> @@ -464,6 +474,14 @@ struct virtnet_info {
>         struct virtnet_interrupt_coalesce intr_coal_tx;
>         struct virtnet_interrupt_coalesce intr_coal_rx;
>
> +       /* Free nodes used for concurrent delivery */
> +       struct mutex coal_free_lock;
> +       struct list_head coal_free_list;
> +
> +       /* Filled when there are no free nodes or cvq buffers */
> +       struct mutex coal_wait_lock;
> +       struct list_head coal_wait_list;
> +
>         unsigned long guest_offloads;
>         unsigned long guest_offloads_capable;
>
> @@ -670,7 +688,7 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
>  {
>         struct virtnet_info *vi =3D cvq->vdev->priv;
>
> -       complete(&vi->ctrl->completion);
> +       schedule_work(&vi->get_cvq);
>  }
>
>  static void skb_xmit_done(struct virtqueue *vq)
> @@ -2696,7 +2714,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi,
>                                        struct scatterlist *in)
>  {
>         struct scatterlist *sgs[5], hdr, stat;
> -       u32 out_num =3D 0, tmp, in_num =3D 0;
> +       u32 out_num =3D 0, in_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2730,14 +2748,14 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi,
>                 return false;
>         }
>
> -       if (unlikely(!virtqueue_kick(vi->cvq)))
> -               goto unlock;
> +       if (unlikely(!virtqueue_kick(vi->cvq))) {
> +               mutex_unlock(&vi->cvq_lock);
> +               return false;
> +       }
> +       mutex_unlock(&vi->cvq_lock);
>
> -       wait_for_completion(&vi->ctrl->completion);
> -       virtqueue_get_buf(vi->cvq, &tmp);
> +       wait_for_completion(&ctrl->completion);
>
> -unlock:
> -       mutex_unlock(&vi->cvq_lock);
>         return ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
>
> @@ -2747,6 +2765,86 @@ static bool virtnet_send_command(struct virtnet_in=
fo *vi, u8 class, u8 cmd,
>         return virtnet_send_command_reply(vi, class, cmd, vi->ctrl, out, =
NULL);
>  }
>
> +static void virtnet_process_dim_cmd(struct virtnet_info *vi,
> +                                   struct virtnet_coal_node *node)
> +{
> +       u16 qnum =3D le16_to_cpu(node->coal_vqs.vqn) / 2;
> +
> +       mutex_lock(&vi->rq[qnum].dim_lock);
> +       vi->rq[qnum].intr_coal.max_usecs =3D
> +               le32_to_cpu(node->coal_vqs.coal.max_usecs);
> +       vi->rq[qnum].intr_coal.max_packets =3D
> +               le32_to_cpu(node->coal_vqs.coal.max_packets);
> +       vi->rq[qnum].dim.state =3D DIM_START_MEASURE;
> +       mutex_unlock(&vi->rq[qnum].dim_lock);
> +
> +       if (node->is_coal_wait) {
> +               mutex_lock(&vi->coal_wait_lock);
> +               list_del(&node->list);
> +               mutex_unlock(&vi->coal_wait_lock);
> +               kfree(node);
> +       } else {
> +               mutex_lock(&vi->coal_free_lock);
> +               list_add(&node->list, &vi->coal_free_list);
> +               mutex_unlock(&vi->coal_free_lock);
> +       }
> +}
> +
> +static int virtnet_add_dim_command(struct virtnet_info *vi,
> +                                  struct virtnet_coal_node *coal_node)
> +{
> +       struct scatterlist sg;
> +       int ret;
> +
> +       sg_init_one(&sg, &coal_node->coal_vqs, sizeof(coal_node->coal_vqs=
));
> +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET=
,
> +                                        &coal_node->ctrl, &sg, NULL);
> +       if (!ret) {
> +               dev_warn(&vi->dev->dev,
> +                        "Failed to change coalescing params.\n");
> +               return ret;
> +       }
> +
> +       virtnet_process_dim_cmd(vi, coal_node);
> +
> +       return 0;
> +}
> +
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

How could we synchronize with the device in this case?

E.g what happens if the device finishes another buf here?

> +
> +       if (!valid)
> +               return;
> +
> +       while (true) {
> +               wait_coal =3D NULL;
> +               mutex_lock(&vi->coal_wait_lock);
> +               if (!list_empty(&vi->coal_wait_list))
> +                       wait_coal =3D list_first_entry(&vi->coal_wait_lis=
t,
> +                                                    struct virtnet_coal_=
node,
> +                                                    list);
> +               mutex_unlock(&vi->coal_wait_lock);
> +               if (wait_coal)
> +                       if (virtnet_add_dim_command(vi, wait_coal))
> +                               break;
> +               else
> +                       break;
> +       }

This is still an ad-hoc optimization for dim in the general path here.

Could we have a fn callback so for non dim it's just a completion and
for dim it would be a schedule_work()?

> +}
>  static int virtnet_set_mac_address(struct net_device *dev, void *p)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> @@ -4398,35 +4496,73 @@ static int virtnet_send_notf_coal_vq_cmds(struct =
virtnet_info *vi,
>         return 0;
>  }
>
> +static void virtnet_put_wait_coal(struct virtnet_info *vi,
> +                                 struct receive_queue *rq,
> +                                 struct dim_cq_moder moder)
> +{
> +       struct virtnet_coal_node *wait_node;
> +
> +       wait_node =3D kzalloc(sizeof(*wait_node), GFP_KERNEL);
> +       if (!wait_node) {
> +               rq->dim.state =3D DIM_START_MEASURE;
> +               return;
> +       }
> +
> +       wait_node->is_coal_wait =3D true;
> +       wait_node->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq));
> +       wait_node->coal_vqs.coal.max_usecs =3D cpu_to_le32(moder.usec);
> +       wait_node->coal_vqs.coal.max_packets =3D cpu_to_le32(moder.pkts);
> +       mutex_lock(&vi->coal_wait_lock);
> +       list_add_tail(&wait_node->list, &vi->coal_wait_list);
> +       mutex_unlock(&vi->coal_wait_lock);
> +}
> +
>  static void virtnet_rx_dim_work(struct work_struct *work)
>  {
>         struct dim *dim =3D container_of(work, struct dim, work);
>         struct receive_queue *rq =3D container_of(dim,
>                         struct receive_queue, dim);
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct net_device *dev =3D vi->dev;
> +       struct virtnet_coal_node *avail_coal;
>         struct dim_cq_moder update_moder;
> -       int qnum, err;
>
> -       qnum =3D rq - vi->rq;
> +       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->profil=
e_ix);
>
>         mutex_lock(&rq->dim_lock);
> -       if (!rq->dim_enabled)
> -               goto out;
> -
> -       update_moder =3D net_dim_get_rx_moderation(dim->mode, dim->profil=
e_ix);
> -       if (update_moder.usec !=3D rq->intr_coal.max_usecs ||
> -           update_moder.pkts !=3D rq->intr_coal.max_packets) {
> -               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> -                                                      update_moder.usec,
> -                                                      update_moder.pkts)=
;
> -               if (err)
> -                       pr_debug("%s: Failed to send dim parameters on rx=
q%d\n",
> -                                dev->name, qnum);
> -               dim->state =3D DIM_START_MEASURE;
> +       if (!rq->dim_enabled ||
> +           (update_moder.usec =3D=3D rq->intr_coal.max_usecs &&
> +            update_moder.pkts =3D=3D rq->intr_coal.max_packets)) {
> +               rq->dim.state =3D DIM_START_MEASURE;
> +               mutex_unlock(&rq->dim_lock);
> +               return;
>         }
> -out:
>         mutex_unlock(&rq->dim_lock);
> +
> +       mutex_lock(&vi->cvq_lock);
> +       if (vi->cvq->num_free < 3) {
> +               virtnet_put_wait_coal(vi, rq, update_moder);
> +               mutex_unlock(&vi->cvq_lock);
> +               return;
> +       }

Could we simply sleep instead of using a list here?

> +       mutex_unlock(&vi->cvq_lock);
> +
> +       mutex_lock(&vi->coal_free_lock);
> +       if (list_empty(&vi->coal_free_list)) {
> +               virtnet_put_wait_coal(vi, rq, update_moder);
> +               mutex_unlock(&vi->coal_free_lock);
> +               return;
> +       }
> +
> +       avail_coal =3D list_first_entry(&vi->coal_free_list,
> +                                     struct virtnet_coal_node, list);
> +       avail_coal->coal_vqs.vqn =3D cpu_to_le16(rxq2vq(rq - vi->rq));
> +       avail_coal->coal_vqs.coal.max_usecs =3D cpu_to_le32(update_moder.=
usec);
> +       avail_coal->coal_vqs.coal.max_packets =3D cpu_to_le32(update_mode=
r.pkts);
> +
> +       list_del(&avail_coal->list);
> +       mutex_unlock(&vi->coal_free_lock);
> +
> +       virtnet_add_dim_command(vi, avail_coal);
>  }
>
>  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
> @@ -4839,6 +4975,7 @@ static void virtnet_freeze_down(struct virtio_devic=
e *vdev)
>         flush_work(&vi->config_work);
>         disable_rx_mode_work(vi);
>         flush_work(&vi->rx_mode_work);
> +       flush_work(&vi->get_cvq);
>
>         netif_tx_lock_bh(vi->dev);
>         netif_device_detach(vi->dev);
> @@ -5612,6 +5749,45 @@ static const struct xdp_metadata_ops virtnet_xdp_m=
etadata_ops =3D {
>         .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
>  };
>
> +static void virtnet_del_coal_free_list(struct virtnet_info *vi)
> +{
> +       struct virtnet_coal_node *coal_node, *tmp;
> +
> +       list_for_each_entry_safe(coal_node, tmp,  &vi->coal_free_list, li=
st) {
> +               list_del(&coal_node->list);
> +               kfree(coal_node);
> +       }
> +}
> +
> +static int virtnet_init_coal_list(struct virtnet_info *vi)
> +{
> +       struct virtnet_coal_node *coal_node;
> +       int batch_dim_nums;
> +       int i;
> +
> +       INIT_LIST_HEAD(&vi->coal_free_list);
> +       mutex_init(&vi->coal_free_lock);
> +
> +       INIT_LIST_HEAD(&vi->coal_wait_list);
> +       mutex_init(&vi->coal_wait_lock);
> +
> +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +               return 0;
> +
> +       batch_dim_nums =3D min((unsigned int)vi->max_queue_pairs,
> +                            virtqueue_get_vring_size(vi->cvq) / 3);
> +       for (i =3D 0; i < batch_dim_nums; i++) {
> +               coal_node =3D kzalloc(sizeof(*coal_node), GFP_KERNEL);
> +               if (!coal_node) {
> +                       virtnet_del_coal_free_list(vi);
> +                       return -ENOMEM;
> +               }
> +               list_add(&coal_node->list, &vi->coal_free_list);
> +       }
> +
> +       return 0;
> +}
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>         int i, err =3D -ENOMEM;
> @@ -5797,6 +5973,9 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         if (err)
>                 goto free;
>
> +       if (virtnet_init_coal_list(vi))
> +               goto free;
> +
>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>                 vi->intr_coal_rx.max_usecs =3D 0;
>                 vi->intr_coal_tx.max_usecs =3D 0;
> @@ -5838,6 +6017,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
> +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
>         init_completion(&vi->ctrl->completion);
>         enable_rx_mode_work(vi);
>
> @@ -5967,11 +6147,14 @@ static void virtnet_remove(struct virtio_device *=
vdev)
>         flush_work(&vi->config_work);
>         disable_rx_mode_work(vi);
>         flush_work(&vi->rx_mode_work);
> +       flush_work(&vi->get_cvq);

Do we need to prevent cvq work from being scheduled here?

Thanks

>
>         unregister_netdev(vi->dev);
>
>         net_failover_destroy(vi->failover);
>
> +       virtnet_del_coal_free_list(vi);
> +
>         remove_vq_common(vi);
>
>         free_netdev(vi->dev);
> --
> 2.32.0.3.g01195cf9f
>


