Return-Path: <netdev+bounces-107521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA3391B4FF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5925D2837A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C346B8;
	Fri, 28 Jun 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+llYpfv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9E1103
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541191; cv=none; b=H7mHmzgswFSb397k7HizZqoE6wajlabw2imj4UoP47qvQQXUS9pA/JVr8/EAf5roK4hIZ+WaWWJCIfJIILIAktSkM1eyFlS3ETYEWNK17er0jQZG2Ywp88vkJJLAnmFXjh7sr4qUvRqaF10qGpo83GoPz4f3QY/PW5oRNdEGxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541191; c=relaxed/simple;
	bh=fS9/cFuMgM0lZ8ejH+LXiAGmaBNxW0h/VZBmYDdLhe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5iBoNHuv895qpc6uoEJHOr4VfLhYMorRdyhIshNqhFBj3nIJ5CsYV/a8zP73jvk9GX3c4XZSfZSiZdKl+XS2Gsk0fSqck8pM7gdMfhcBco2ZIa8QVTHoU8jf2kOo8H87URmA+Bq+mWHXVDJ7uzSHN5kUanagYApcBkedzxFSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+llYpfv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFtsipCPOP/jakTRLVMoqNYxm8v6uKh7kTQGbc/1cIY=;
	b=h+llYpfvJ0uSY6hAHEXrU/mC2qjiVo4ip2PTOYQz6vBBpnuNHduXIV/cg/J/5gtB6BgPaz
	EiRL2VaeNwNhIBFN95AlZhVg7O/iLTdRBDotSnl9hXl+Fwc19aPXzy2GuycANu7DvsdA7k
	GXA7ZefdnL3LKerLo4aiNhoS9wbFngM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DscZWdXgNEK9xVIsXlcRzQ-1; Thu, 27 Jun 2024 22:19:47 -0400
X-MC-Unique: DscZWdXgNEK9xVIsXlcRzQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f9d1ec47f9so185238a34.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541186; x=1720145986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFtsipCPOP/jakTRLVMoqNYxm8v6uKh7kTQGbc/1cIY=;
        b=gNCm/q1g4dC2Y8w5W69KzM5s5ijoDLyxWBfnJLDiRiQmF6liy/HtDz97zdwn8qAt+V
         EpsiUdvXXK50T1u0F7XHUc8a/c6ZqdL6PxZKIbur9JjQwj4zxRfkZ/Jp/053TyCRfOQj
         0UCv9dr3ZWZtH70VjKjntx1ejgI/p/FgsT8HTmhWE1dQ2TKCFYFeq6SvAEJBp/eqIUku
         88GsqGl0IW+kma9tiFsRiZCFZoJoFkKxaOUv+To7HW2/M3PQFSKcluizHrZzPYzYDVQ0
         3PQkiwS+wiFZHDArtUVZXTZfVJPeJdwfe0SmiRjY06DWPSkjVaomTRRr05OXQc/NMXFf
         +37Q==
X-Gm-Message-State: AOJu0YyvvQ7+bR4Mz6AL3N6v5G5rMTzJ5vBp8kz8Qgcpf6aY/Z+UBz16
	4wPDzkAsSqqVn48Pmmeg8xu75aQuGlv4WZwjjm3tKsVTtydUiACmGCyc9l0X6j1BDC4HgDpWC1H
	LLl1ijn54GYmxq7qmlhajPAZxS0Bxy6rlB8fc+3a6RFZcVz+JMas2NpXrxzQCuTwD8Pz4ZBHmce
	IWwSf4yDH5h7UD//b1nNfVH7pUfGhE
X-Received: by 2002:a9d:760b:0:b0:6f9:6161:56d6 with SMTP id 46e09a7af769-700b118801amr16478944a34.3.1719541186328;
        Thu, 27 Jun 2024 19:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0cy9whsZGzhAzpp3vFWkjbwHKyu4q8WjSFEbZ4m1R5IwigdKQPr7kxsvvcJH5teLIRbMAoIj3o3ESGwRVCsA=
X-Received: by 2002:a9d:760b:0:b0:6f9:6161:56d6 with SMTP id
 46e09a7af769-700b118801amr16478922a34.3.1719541185825; Thu, 27 Jun 2024
 19:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:34 +0800
Message-ID: <CACGkMEtPwA2EN3xEH_T67cOQAWyZfYESso8LzeFDocJKYoXmTw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/10] virtio_net: xsk: bind/unbind xsk for rx
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 133 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index df885cdbe658..d8cce143be26 100644
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
> @@ -348,6 +349,13 @@ struct receive_queue {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> +
> +       struct {
> +               struct xsk_buff_pool *pool;
> +
> +               /* xdp rxq used by xsk */
> +               struct xdp_rxq_info xdp_rxq;
> +       } xsk;

I don't see a special reason for having a container struct here.


>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -4970,6 +4978,129 @@ static int virtnet_restore_guest_offloads(struct =
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
> +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qinde=
x, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0)
> +                       goto unreg;
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
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
> +       rq->xsk.pool =3D pool;
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       if (pool)
> +               return 0;
> +
> +unreg:
> +       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
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
> +       /* For the xsk, the tx and rx should have the same device. The af=
-xdp
> +        * may use one buffer to receive from the rx and reuse this buffe=
r to
> +        * send by the tx. So the dma dev of sq and rq should be the same=
 one.
> +        *
> +        * But vq->dma_dev allows every vq has the respective dma dev. So=
 I
> +        * check the dma dev of vq and sq is the same dev.

Not a native speaker, but it might be better to say "xsk assumes ....
to be the same device". And it might be better to replace "should"
with "must".

Others look good.

Thanks


