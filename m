Return-Path: <netdev+bounces-109724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F0929C52
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63D81C2149A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FB171A5;
	Mon,  8 Jul 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnpZhXPr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68513AF2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420629; cv=none; b=T3w+Fud4gwWQThKEGzKHlvUDEBWZ5HF/eGjQtgSdApiiRJXnlPNHOI5NvYfc1wX5BMz4J3EbWTSOdyyM8Vv9Wn4aRQXabuMKewZdFfV/iuAVL/bR/9ThACVR2HCytQeJ6O/24lJ8jwXpjc5XBM6j/vmdlmyz55mPeiwkLwKJFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420629; c=relaxed/simple;
	bh=pVx1F0zlWrx9DLmbJp6pr9g/PqB7QQJH0tCPKUZ6gIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezTB1++OWp3hKu7MZ1Mzvwuz7Cfkv1L3dm/dWoEZQq3dlYqV2TnMo0ubfGun9w+XSrFW2bHibRsBytjHUiZSWeczvNmhfBwASValoHk1UH8c5SEWZ3lAnLH0fRckQMA84ap9MfvFK+SLbvQ1F8VsNuUAeZzUdv+xj+ERL0FYmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnpZhXPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720420626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=td2LS94WMnQRQc26m/n7PwwhPL7oKCXn1M0Y41ufmns=;
	b=QnpZhXPrvjQgJirjC2dS1vQUQJFIB25sqIDFO5T7CQvYacqrcp7mTUUUaMPgRu4xL9B+bP
	yTKjK/+Uhxj18nonIwOIuCyyGK8Rm1r9e/DQK0A0deql+vGLtSM+Oaan5/G9PBTVWB3Dbb
	kolw5bre8kMwmTRUTomGJSGG/L8Qp9I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-pd0_f4vUPxqHh2fn_shRqQ-1; Mon, 08 Jul 2024 02:37:04 -0400
X-MC-Unique: pd0_f4vUPxqHh2fn_shRqQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f6810e43e0so23765715ad.0
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 23:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420624; x=1721025424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td2LS94WMnQRQc26m/n7PwwhPL7oKCXn1M0Y41ufmns=;
        b=w0HyNlofv0kPpwZpauCNZfOOjTXS5chpWhkXnQYDpX6dUXEXJcfseZAIFrFkK2ozR1
         G0UL8dyH0S/2gw0uns9NMjEUcGTT/EyfZ6Hr9VSQv00026MLbFJKV0s1d2V2QoNvbmTC
         UEfIQJv2pqVCQiVFDLjQHlcS7XhMwi9MyZX7ij8aou8HE0UFlF2IBd4H98XGwtoNMBky
         LSWLByYmj7CkNproHI27oEDD7EahoBNQA+7Ks5VURbHyU2FB+8a1xe0bq+TMV9IoTpah
         /xO0kPfiOeCF26EGNhfs0fR/SRHWnhznIbQkTyNELyJb6mZvHWDn2btWVV4cv228xEe3
         1xoA==
X-Gm-Message-State: AOJu0Yz60IqeFG8FHlCnM8xDy7c9JVTnV1X43rhtAfCDXUbfsACoLMDd
	wrMjxcy5Rh6bhkhgE+dtQOgJ6mKUtUrd7KfRShDb1lQpBZpUKkxZls0S6/aCc9UspmukToL3WMI
	xiHn+sdFYblIEEj1Q9HlWEemc7IjIzmYiXHEKyvAjjXA+JqUJSmj9Xj0UVoeNmIi2Aes8Cifh8o
	fpagochCue4LC1T2jro0UdeX7wNooN
X-Received: by 2002:a17:902:c402:b0:1fb:15ff:8499 with SMTP id d9443c01a7336-1fb3700d240mr170145185ad.4.1720420623764;
        Sun, 07 Jul 2024 23:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgLDGLsNuvY7Y1CElM5YYLKX4FgQDMdRKPdIjjrlLfBf3G6j00b+bCV72mON6Sx9MTqtH82BSVcoCb3d6TO3Y=
X-Received: by 2002:a17:902:c402:b0:1fb:15ff:8499 with SMTP id
 d9443c01a7336-1fb3700d240mr170144945ad.4.1720420623343; Sun, 07 Jul 2024
 23:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:36:52 +0800
Message-ID: <CACGkMEscqKn6Wt76qZpWeiG=9Tj6LpzUq_0fqJb32AXEdiKMgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/10] virtio_net: xsk: bind/unbind xsk for rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>     1. remove a container struct for xsk
>     2. update comments
>     3. add check between hdr_len and xsk headroom
>
>  drivers/net/virtio_net.c | 134 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3c828cdd438b..cd87b39600d4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -25,6 +25,7 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
> +#include <net/xdp_sock_drv.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -348,6 +349,11 @@ struct receive_queue {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> +
> +       struct xsk_buff_pool *xsk_pool;
> +
> +       /* xdp rxq used by xsk */
> +       struct xdp_rxq_info xsk_rxq_info;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -5026,6 +5032,132 @@ static int virtnet_restore_guest_offloads(struct =
virtnet_info *vi)
>         return virtnet_set_guest_offloads(vi, offloads);
>  }
>
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct rece=
ive_queue *rq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D rq - vi->rq;
> +
> +       if (pool) {
> +               err =3D xdp_rxq_info_reg(&rq->xsk_rxq_info, vi->dev, qind=
ex, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk_rxq_info,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0)
> +                       goto unreg;
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk_rxq_info);
> +       }
> +
> +       virtnet_rx_pause(vi, rq);
> +
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
> +
> +               pool =3D NULL;
> +       }
> +
> +       rq->xsk_pool =3D pool;
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       if (pool)
> +               return 0;
> +
> +unreg:
> +       xdp_rxq_info_unreg(&rq->xsk_rxq_info);
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +                                  struct xsk_buff_pool *pool,
> +                                  u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct receive_queue *rq;
> +       struct device *dma_dev;
> +       struct send_queue *sq;
> +       int err;
> +
> +       if (vi->hdr_len > xsk_pool_get_headroom(pool))
> +               return -EINVAL;
> +
> +       /* In big_packets mode, xdp cannot work, so there is no need to
> +        * initialize xsk of rq.
> +        */
> +       if (vi->big_packets && !vi->mergeable_rx_bufs)
> +               return -ENOENT;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       /* xsk assumes that tx and rx must have the same dma device. The =
af-xdp
> +        * may use one buffer to receive from the rx and reuse this buffe=
r to
> +        * send by the tx. So the dma dev of sq and rq must be the same o=
ne.
> +        *
> +        * But vq->dma_dev allows every vq has the respective dma dev. So=
 I
> +        * check the dma dev of vq and sq is the same dev.
> +        */
> +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> +               return -EPERM;

I think -EINVAL is better.

> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +       if (!dma_dev)
> +               return -EPERM;

-EINVAL seems to be better.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

THanks


