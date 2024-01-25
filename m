Return-Path: <netdev+bounces-65733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658F83B864
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CD71C22969
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D056FD1;
	Thu, 25 Jan 2024 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHy9lIB/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2556FC8
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153962; cv=none; b=U4yThCC6J2SR80prrqcKIYU1dW9ojKOHn5taWITvTo/FhHM7uUycOtXM8XdR2Jb8H6Cb8iEEhRzDojpFo0efoANjevN9pMshXujSeDrC2pzizIxsguA+qGbbHhkadgyk7UdYb+cK57En6nmfx8KARcCwzjmzg8yyDMQXA9QOSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153962; c=relaxed/simple;
	bh=aYtraKeg/phW07/7iPMWoTxqzaJdJOv0+Sxt7exwBJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB99+kifJ2EwW77s2fT8kOcxaa8AleXJn+EW0E3ASzksklMvJPDRthz/NYgMMMQ1NfAPSORXzSrnHWyXdx/4D+zRTsa8Nlu2WzmbQgji/fE6wRVTv3lPoOCXrBJSH7Z/qZR3PkzW36KWDYR7iUAvAY94UvKQE9MRGdxrBSDuFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHy9lIB/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
	b=VHy9lIB/8j8ZlgqWfAC2o5Ee0qR3aT3XvK1ll3WmvcPm289JNJnb5DAdsuZO9OwfGz/bhd
	pMNbO5sibE3T6LW/4Gztxp14fgw5AJQoKVboNCrzBXmLfeWJm/V/fOB9DTz4Tm6Jhstb1R
	M6pEI0xgq37YtdpfKqJB559GfXE5VTY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-16_EUNbEM_iv8S-oKQvbHw-1; Wed, 24 Jan 2024 22:39:16 -0500
X-MC-Unique: 16_EUNbEM_iv8S-oKQvbHw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf2714e392so329378a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153955; x=1706758755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
        b=GSq8cGBEgF0E+AygLhx6Sl9mMUEBTuP1wYO4aEpMlkk3uYXZnVSjedRiie3P8TbXkH
         jElRnHiTS4DnOdfLuzU2za1jJqPOT1+OjrHgZFRbe9rRKl08Xrv/EtA+heWO8EGRmvEZ
         nru91iZTgDSKhhabNk7sRi1vqbQsKuEsbwxF6YqN8pAnE2CN5RGRRRYyn2qdCWCQr0O2
         vR7n69ZuFy7mus3eYuVK3LnW5ZSi5yVoQeATtiVHg6/LJdw4sFNVxnNvH636uSW50/ZX
         P0N9yTHyQF79SU5wnOFFm/dp656pnbvzfg0Hkv0DaVt8DfxFG7Sx/7UdEUAty9IrAKMN
         KSQg==
X-Gm-Message-State: AOJu0YyjO2kjVbv4xwjPX6t+K9I5eazoGaIli1SoUMs9avcck/SMszc7
	P5jqZRQvL6tmPi4Jcd+elODTlgGjyaV2dQ6aBUfWgmsRDducIkQakIrniqlHvGgGNV85u5Xxz//
	1HlJpjwA70WMIMIdlC7zr90rRvZCD8RbiebvijN521u5fZwzVcXPc5e5gwoK2j9jZzru8s1XvaQ
	H1YHnEBWzUDTPdzj7C2bnHJJq3zmQ0
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id x13-20020a056a20938d00b0019af0ef0ffcmr561792pzh.3.1706153954782;
        Wed, 24 Jan 2024 19:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVvYsNNKLu8vKw6h7D0IpqxiuwRhcQvL/n+p++mwu2Jx6DGQNuoinfcujLAu57LUqNpXdniTVSTxpEPUGA4Ms=
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id
 x13-20020a056a20938d00b0019af0ef0ffcmr561774pzh.3.1706153954482; Wed, 24 Jan
 2024 19:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:03 +0800
Message-ID: <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Introduce helper virtqueue_get_dma_premapped(), then the driver
> can know whether dma unmap is needed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 22 +++++++++-------------
>  drivers/net/virtio/virtio_net.h |  3 ---
>  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
>  include/linux/virtio.h          |  1 +
>  4 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 186b2cf5d8fc..4fbf612da235 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq=
, u32 *len, void **ctx)
>         void *buf;
>
>         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf && rq->do_dma)
> +       if (buf && virtqueue_get_dma_premapped(rq->vq))
>                 virtnet_rq_unmap(rq, buf, *len);
>
>         return buf;
> @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtnet_rq =
*rq, void *buf, u32 len)
>         u32 offset;
>         void *head;
>
> -       if (!rq->do_dma) {
> +       if (!virtqueue_get_dma_premapped(rq->vq)) {
>                 sg_init_one(rq->sg, buf, len);
>                 return;
>         }
> @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, =
u32 size, gfp_t gfp)
>
>         head =3D page_address(alloc_frag->page);
>
> -       if (rq->do_dma) {
> +       if (virtqueue_get_dma_premapped(rq->vq)) {
>                 dma =3D head;
>
>                 /* new pages */
> @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct virtnet_=
info *vi)
>         if (!vi->mergeable_rx_bufs && vi->big_packets)
>                 return;
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> -
> -               vi->rq[i].do_dma =3D true;
> -       }
> +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +               virtqueue_set_dma_premapped(vi->rq[i].vq);
>  }
>
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct virtnet_rq *rq,
>
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct virtnet_=
info *vi)
>         int i;
>         for (i =3D 0; i < vi->max_queue_pairs; i++)
>                 if (vi->rq[i].alloc_frag.page) {
> -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> +                       if (virtqueue_get_dma_premapped(vi->rq[i].vq) && =
vi->rq[i].last_dma)
>                                 virtnet_rq_unmap(&vi->rq[i], vi->rq[i].la=
st_dma, 0);
>                         put_page(vi->rq[i].alloc_frag.page);
>                 }
> @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struct virt=
queue *vq)
>         rq =3D &vi->rq[i];
>
>         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>
>                 virtnet_rq_free_buf(vi, rq, buf);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index b28a4d0a3150..066a2b9d2b3c 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -115,9 +115,6 @@ struct virtnet_rq {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> -
> -       /* Do dma by self */
> -       bool do_dma;
>  };
>
>  struct virtnet_info {
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2c5089d3b510..9092bcdebb53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtqueue *=
_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
>
> +/**
> + * virtqueue_get_dma_premapped - get the vring premapped mode
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Get the premapped mode of the vq.
> + *
> + * Returns bool for the vq premapped mode.
> + */
> +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       bool premapped;
> +
> +       START_USE(vq);
> +       premapped =3D vq->premapped;
> +       END_USE(vq);

Why do we need to protect premapped like this? Is the user allowed to
change it on the fly?

Thanks


