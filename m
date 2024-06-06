Return-Path: <netdev+bounces-101194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2858FDB72
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7233228571C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA26AA7;
	Thu,  6 Jun 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f23lEubE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0933E1
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633672; cv=none; b=KpuZtqboR1bxIQgy170klVH7ph68fhQRm/JNRMWhLrhLp87vFZNfEc6dK79k+UmlM/Rsjv1fsPMMY7L9x+EBgWp0qH7XzDUqQeHWwG5Zwi85zY3BLeeYaTh03cs/XNl+nc1vQASgYQWglLu7Kbrj+FKa1ZfwNOZfjhI+JhZ9q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633672; c=relaxed/simple;
	bh=zr26jusdMN/HDmyfqkW3qZkc+5YxrngMjV7AhboxTVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK5e2wsJbRHCmXQlJ1Tyi8f6DxHyZV9nFUgUe+tKRD5YuveFpp1tsGhrew2/bAz6DT4zQ/QPk5GKgUiczCnjKTnawKoGRmBrbeaE/LyUFTgw3h4+GKBCKEtM/2bOX65jSrW10NTAM/yjg1pC/IfzAsXQcZamgHLQpURwqHzeE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f23lEubE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717633669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUg1YuZtuVj4QWNVtscwU1alSi3tMri8fkRF9RIe0s0=;
	b=f23lEubEjgTiszH4tXwJ6AfgUgZC3dLAQmN9MT4oQrdtKx4B5Pj9bJUBwSF3EEftAmLPaq
	be0MAEvRpc78H2QZNYKlBJzehptqU7BhXdmSGKig1VnPNqFH4ABz5bPxGtPsCX+yIa8isf
	wRKuYwUk3xtbwu8/OmdJr5yZ3PQUSd0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Gzdruzo8OKK3tlNhTnzbTQ-1; Wed, 05 Jun 2024 20:27:48 -0400
X-MC-Unique: Gzdruzo8OKK3tlNhTnzbTQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6cc288a7ee6so1138646a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 17:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633667; x=1718238467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUg1YuZtuVj4QWNVtscwU1alSi3tMri8fkRF9RIe0s0=;
        b=nFfK2NlcAJp3eQ+VtpShU/2hlfoszlQGGg8H1j4XKF/NNacVZCFCS4qyJoyWFmRi1i
         JAk30JFTkqzC14q8bJOjOFm2qVB5zyVvvtzZ6KAUq3JNx7WvJghZvGXsdureUC4ASK8D
         qNhtLrN1p7WEqW2nP1f/9y5z7QJ8MLsiyrYvYX9oUCxhfEqB9mNfe0T3dTQux0d9AFYd
         8fXRTM0vEeBIBfIsu0inpf82Mqc0xXjOToe7GgUKHSXqg0j+1S3se40NiM7YLTZDsgJz
         SS2LSMKYzTPM3FXZgE57y3l8lhnOpdpbMznar8dSuaIAf08TLSWpAdLWXAEzpEhniIXl
         TZfA==
X-Gm-Message-State: AOJu0Yw5l807txUJ4UYBjLaoD4jM3kQbCppanEHceNXHsx3BejxAbCdm
	uAKBiZniglT/zWcgm/QFx3IpgK4cWXOk1Z2DKl0R8Z6yIqa0ox4h8hUns/XVi0DCog272BVk8eo
	xL5Jw2Ws8h8c5ZWiZeb4hhAxurazmTPx9Zwa+hyx9MKq6nLKhbp/lWjC4OHhVKsbek2/FPnEkfv
	cVcPQn6se5kvaPHb3MGZpZk3YUs/OU
X-Received: by 2002:a17:90a:dd45:b0:2c1:9ea1:630c with SMTP id 98e67ed59e1d1-2c299973d53mr1493329a91.1.1717633666641;
        Wed, 05 Jun 2024 17:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuJbOBbClD7zfD4BwpIXisEe6lEVjRfd40rq/8UO2ZjSvGhK2+SwFOfyNu7QI5yRZdQlFKjdblHCzwLaFSPAM=
X-Received: by 2002:a17:90a:dd45:b0:2c1:9ea1:630c with SMTP id
 98e67ed59e1d1-2c299973d53mr1493311a91.1.1717633666213; Wed, 05 Jun 2024
 17:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605145533.86229-1-hengqi@linux.alibaba.com> <20240605145533.86229-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240605145533.86229-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:27:35 +0800
Message-ID: <CACGkMEu-HFw0n_WtxDDmypj4WLTEF=8W6Pa_1UCtmvhbTP_udw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: improve dim command request efficiency
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, the control queue (ctrlq) handles commands synchronously,
> leading to increased delays for dim commands during multi-queue
> VM configuration and directly impacting dim performance.
>
> To address this, we are shifting to asynchronous processing of
> ctrlq's dim commands.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 260 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 236 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9b556ce89546..7975084052ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -270,6 +270,14 @@ struct virtnet_interrupt_coalesce {
>         u32 max_usecs;
>  };
>
> +struct virtnet_coal_node {
> +       struct virtio_net_ctrl_hdr hdr;
> +       virtio_net_ctrl_ack status;
> +       struct virtio_net_ctrl_coal_vq coal_vqs;
> +       bool is_coal_wait;
> +       struct list_head list;
> +};
> +
>  /* The dma information of pages allocated at a time. */
>  struct virtnet_rq_dma {
>         dma_addr_t addr;
> @@ -421,6 +429,9 @@ struct virtnet_info {
>         /* Wait for the device to complete the cvq request. */
>         struct completion completion;
>
> +       /* Work struct for acquisition of cvq processing results. */
> +       struct work_struct get_cvq;
> +
>         /* Host can handle any s/g split between our header and packet da=
ta */
>         bool any_header_sg;
>
> @@ -465,6 +476,14 @@ struct virtnet_info {
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
> @@ -671,7 +690,7 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
>  {
>         struct virtnet_info *vi =3D cvq->vdev->priv;
>
> -       complete(&vi->completion);
> +       schedule_work(&vi->get_cvq);
>  }
>
>  static void skb_xmit_done(struct virtqueue *vq)
> @@ -2183,6 +2202,113 @@ static bool try_fill_recv(struct virtnet_info *vi=
, struct receive_queue *rq,
>         return !oom;
>  }
>
> +static int __virtnet_add_dim_command(struct virtnet_info *vi,
> +                                    struct virtnet_coal_node *ctrl)
> +{
> +       struct scatterlist *sgs[4], hdr, stat, out;
> +       unsigned int out_num =3D 0;
> +       int ret;
> +
> +       BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> +
> +       ctrl->hdr.class =3D VIRTIO_NET_CTRL_NOTF_COAL;
> +       ctrl->hdr.cmd =3D VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET;
> +
> +       sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
> +       sgs[out_num++] =3D &hdr;
> +
> +       sg_init_one(&out, &ctrl->coal_vqs, sizeof(ctrl->coal_vqs));
> +       sgs[out_num++] =3D &out;
> +
> +       ctrl->status =3D ~0;
> +       sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
> +       sgs[out_num] =3D &stat;
> +
> +       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATO=
MIC);
> +       if (ret < 0) {
> +               dev_warn(&vi->vdev->dev,
> +                        "Failed to add sgs for command vq: %d\n.", ret);
> +               return ret;
> +       }
> +
> +       if (unlikely(!virtqueue_kick(vi->cvq)))
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int virtnet_add_dim_command(struct virtnet_info *vi,
> +                                  struct virtnet_coal_node *ctrl)
> +{
> +       int ret;
> +
> +       mutex_lock(&vi->cvq_lock);
> +       ret =3D __virtnet_add_dim_command(vi, ctrl);
> +       mutex_unlock(&vi->cvq_lock);
> +
> +       return ret;
> +}
> +
> +static void virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
> +{
> +       struct virtnet_coal_node *node =3D (struct virtnet_coal_node *)re=
s;
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
> +               kfree(node);
> +       } else {
> +               mutex_lock(&vi->coal_free_lock);
> +               list_add(&node->list, &vi->coal_free_list);
> +               mutex_unlock(&vi->coal_free_lock);
> +       }
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
> +               if (res =3D=3D ((void *)vi))
> +                       complete(&vi->completion);
> +               else
> +                       virtnet_process_dim_cmd(vi, res);

This seems an ad-hoc optimization for dim? Instead of doing this, I
wonder if we can make it re-usable for other possible use cases.

For example, just allocation completion and store the completion as a
token. Then virtqueue_get_buf can wake up the correct completion?

Thanks

> +
> +               valid =3D true;
> +       }
> +
> +       if (!valid) {
> +               mutex_unlock(&vi->cvq_lock);
> +               return;
> +       }
> +
> +       mutex_lock(&vi->coal_wait_lock);
> +       while (!list_empty(&vi->coal_wait_list)) {
> +               wait_coal =3D list_first_entry(&vi->coal_wait_list,
> +                                            struct virtnet_coal_node, li=
st);
> +               if (__virtnet_add_dim_command(vi, wait_coal))
> +                       break;
> +               list_del(&wait_coal->list);
> +       }
> +       mutex_unlock(&vi->coal_wait_lock);
> +
> +       mutex_unlock(&vi->cvq_lock);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>         struct virtnet_info *vi =3D rvq->vdev->priv;
> @@ -2695,7 +2821,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>                                        struct scatterlist *in)
>  {
>         struct scatterlist *sgs[5], hdr, stat;
> -       u32 out_num =3D 0, tmp, in_num =3D 0;
> +       u32 out_num =3D 0, in_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2728,14 +2854,15 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
>                 return false;
>         }
>
> -       if (unlikely(!virtqueue_kick(vi->cvq)))
> -               goto unlock;
> +       if (unlikely(!virtqueue_kick(vi->cvq))) {
> +               mutex_unlock(&vi->cvq_lock);
> +               return false;
> +       }
> +
> +       mutex_unlock(&vi->cvq_lock);
>
>         wait_for_completion(&vi->completion);
> -       virtqueue_get_buf(vi->cvq, &tmp);
>
> -unlock:
> -       mutex_unlock(&vi->cvq_lock);
>         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
>
> @@ -4396,35 +4523,73 @@ static int virtnet_send_notf_coal_vq_cmds(struct =
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
> @@ -4837,6 +5002,7 @@ static void virtnet_freeze_down(struct virtio_devic=
e *vdev)
>         flush_work(&vi->config_work);
>         disable_rx_mode_work(vi);
>         flush_work(&vi->rx_mode_work);
> +       flush_work(&vi->get_cvq);
>
>         netif_tx_lock_bh(vi->dev);
>         netif_device_detach(vi->dev);
> @@ -5610,6 +5776,45 @@ static const struct xdp_metadata_ops virtnet_xdp_m=
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
> @@ -5795,6 +6000,9 @@ static int virtnet_probe(struct virtio_device *vdev=
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
> @@ -5836,6 +6044,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
> +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
>         init_completion(&vi->completion);
>         enable_rx_mode_work(vi);
>
> @@ -5965,11 +6174,14 @@ static void virtnet_remove(struct virtio_device *=
vdev)
>         flush_work(&vi->config_work);
>         disable_rx_mode_work(vi);
>         flush_work(&vi->rx_mode_work);
> +       flush_work(&vi->get_cvq);
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


