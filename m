Return-Path: <netdev+bounces-103910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1490A336
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6848B1C215EF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 05:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFD18132A;
	Mon, 17 Jun 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YER1bPIu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE217B4F7
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600431; cv=none; b=MoDDspez6e2dWhpdfxP+8XIDH/OCeFX+fpaeXucf14FuMZFPCPuUOr4i6DXp9EBb6i62tHpRwFc/ltxhIW1q/oil1h8Ds1uJmb+PRjmAFSCwKZzRvzeo09/MR5NOEgD6s0hQFxlL/KvXUDw+3/rhtUulAja/ZE1ykcey7mYiO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600431; c=relaxed/simple;
	bh=oxo6+jiKynzv+9qj8SZLPfkOHHZJhGzPOo6ZIDmnSdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuYHmvEIquLT0AbHOUVNchebc5PaAo56kgRUOVpADvbzHFGrgl6Q/s7+/1JrWDsLjZ2sRTyFI1zrLx3iQ/V/jtZ3Yzmx4uQX/GHHUab6hl9nroKEPeLZ7ywyT4z/Y324eG6ut8XbmTvgUt1wcZ9JCM64UQwd/LqqfXeR4vGlJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YER1bPIu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718600428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkUqMwiAFYnBSP12rDKX/+KT7iTFCb4wtgi00ahfES8=;
	b=YER1bPIub57R4JjtiLI9aTTvctRbjf77UhDCzevy5bDmH9IQrrrJ/exmi1uc3gdNnaWXVC
	vQCAzVRp6nn0evP6DJt8n7zNROslWXgXaFHwWc/Wi+t2jKRYc6ebg3aUZdWVrgRQyIY05m
	SJIhA9ccDTLYaJvzC3nSUuKvCrGf+Lo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-ByINgOkeOBSPvYu1crLl4A-1; Mon, 17 Jun 2024 01:00:27 -0400
X-MC-Unique: ByINgOkeOBSPvYu1crLl4A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so4421973a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 22:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718600425; x=1719205225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkUqMwiAFYnBSP12rDKX/+KT7iTFCb4wtgi00ahfES8=;
        b=a95B6MaGVMgfohMK0MOdqIrFzL/q6Vt+iCxKxkAWeNkxu+N/LAhCS2zWvI793FBg4+
         F1ua3twqHEZB/rqUFEdzgm8iRBWFB2lyU//unsIGQXbovMu0mMcymbHK6d2bczshMdOj
         flKxF9wIGbdHEBwKCPQlnFegIGfBXyfB/4R/xS5USJyvLGFO0rk7pELtFgUdlRhbX8zY
         +GTfOp4F2jlMsDm42zDWeKIpgQpRIvPKMD+PwRc3CGcWnnKO6Qdd68Rs8MnZj4+qctHy
         xKmR2qUTi1nhnxRb6WBxTS/oXAOLdDA0WBN9IYZG17zteeFNjSnM32kUJbbd9LTcwz2z
         LTtg==
X-Gm-Message-State: AOJu0YzO+9cWiwIWzH5KaKJYRBbdS7s/F2J3Fdt3eEaQ7JX3sXb3G2zc
	sX7KVgSqk7wmcLb1YPWAPetbzb5fm2fUQP6w/nuiJ943QfajcpJMhdTN1BlGT+vr8GeV+YPHAnE
	FaoxrYXTpaX8T2Lnit9Kq58et3tvpgf31v7UPbSGpxNM0pY/qlj87wGKcNN8XeL9t5stFZJv+Xc
	CZQhsckHGuhznPq9Yj/eD+TxlNjrCEMozLy0mEqfs=
X-Received: by 2002:a17:90a:d50:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2c4db242511mr9060886a91.18.1718600425463;
        Sun, 16 Jun 2024 22:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqtMGfudX1PmJa1U5nBzpIF4Q6R5sTi9QqcBa0NkN+wrTEMqETS6dqCNZm61YOvGcE+soy4YQkPs05zomq63w=
X-Received: by 2002:a17:90a:d50:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2c4db242511mr9060869a91.18.1718600425121; Sun, 16 Jun 2024
 22:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 13:00:13 +0800
Message-ID: <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
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

On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode when it is bound to
> af-xdp.
>
> * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
>
>     In this mode, the driver will record the dma info when skb or xdp
>     frame is sent.
>
>     Currently, the SQ premapped mode is operational only with af-xdp. In
>     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
>     the same SQ. Af-xdp independently manages its DMA. The kernel stack
>     and xdp tx/redirect utilize this DMA metadata to manage the DMA
>     info.
>
>     If the indirect descriptor feature be supported, the volume of DMA
>     details we need to maintain becomes quite substantial. Here, we have
>     a cap on the amount of DMA info we manage.
>
>     If the kernel stack and xdp tx/redirect attempt to use more
>     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. But
>     the af-xdp can work continually.

Rethink of this whole logic, it looks like all the complication came
as we decided to go with a pre queue pre mapping flag. I wonder if
things could be simplified if we do that per buffer?

Then we don't need complex logic like dmainfo and cap.

>
> * virtnet_sq_set_premapped(sq, false) is used to disable premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 228 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 224 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e84a4624549b..88ab9ea1646f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -25,6 +25,7 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
> +#include <uapi/linux/virtio_ring.h>

Why do we need this?

>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -276,6 +277,26 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       union {
> +               struct llist_node node;
> +               struct llist_head head;

If we want to cap the #dmas, could we simply use an array instead of
the list here?

> +               void *data;
> +       };
> +       dma_addr_t addr;
> +       u32 len;
> +       u8 num;
> +};
> +
> +struct virtnet_sq_dma_info {
> +       /* record for kfree */
> +       void *p;
> +
> +       u32 free_num;
> +
> +       struct llist_head free;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>         /* Virtqueue associated with this send _queue */
> @@ -295,6 +316,11 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       /* SQ is premapped mode or not. */
> +       bool premapped;
> +
> +       struct virtnet_sq_dma_info dmainfo;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -492,9 +518,11 @@ static void virtnet_sq_free_unused_buf(struct virtqu=
eue *vq, void *buf);
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
>         VIRTNET_XMIT_TYPE_XDP,
> +       VIRTNET_XMIT_TYPE_DMA,

I think the name is confusing, how about TYPE_PREMAPPED?

>  };
>
> -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYP=
E_XDP)
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYP=
E_XDP \
> +                               | VIRTNET_XMIT_TYPE_DMA)
>
>  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> @@ -510,12 +538,180 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum =
virtnet_xmit_type type)
>         return (void *)((unsigned long)ptr | type);
>  }
>
> +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> +{
> +       struct virtnet_sq_dma *head, *tail, *p;
> +       int i;
> +
> +       head =3D *data;
> +
> +       p =3D head;
> +
> +       for (i =3D 0; i < head->num; ++i) {
> +               virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->len,
> +                                              DMA_TO_DEVICE, 0);
> +               tail =3D p;
> +               p =3D llist_entry(llist_next(&p->node), struct virtnet_sq=
_dma, node);
> +       }
> +
> +       *data =3D tail->data;
> +
> +       __llist_add_batch(&head->node, &tail->node,  &sq->dmainfo.free);
> +
> +       sq->dmainfo.free_num +=3D head->num;
> +}
> +
> +static void *virtnet_dma_chain_update(struct send_queue *sq,
> +                                     struct virtnet_sq_dma *head,
> +                                     struct virtnet_sq_dma *tail,
> +                                     u8 num, void *data)
> +{
> +       sq->dmainfo.free_num -=3D num;
> +       head->num =3D num;
> +
> +       tail->data =3D data;
> +
> +       return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, i=
nt num, void *data)
> +{
> +       struct virtnet_sq_dma *head =3D NULL, *p =3D NULL;
> +       struct scatterlist *sg;
> +       dma_addr_t addr;
> +       int i, err;
> +
> +       if (num > sq->dmainfo.free_num)
> +               return NULL;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               sg =3D &sq->sg[i];
> +
> +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg)=
,
> +                                                   sg->offset,
> +                                                   sg->length, DMA_TO_DE=
VICE,
> +                                                   0);
> +               err =3D virtqueue_dma_mapping_error(sq->vq, addr);
> +               if (err)
> +                       goto err;
> +
> +               sg->dma_address =3D addr;
> +
> +               p =3D llist_entry(llist_del_first(&sq->dmainfo.free),
> +                               struct virtnet_sq_dma, node);
> +
> +               p->addr =3D sg->dma_address;
> +               p->len =3D sg->length;

I may miss something, but I don't see how we cap the total number of dmainf=
os.

Thanks


