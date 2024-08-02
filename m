Return-Path: <netdev+bounces-115205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C939456B6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2191F23154
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1D211C;
	Fri,  2 Aug 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZNo11l6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1A18B1A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570135; cv=none; b=EHErob9trw0Ha2pX6BMmF7ry9/gmXT75DBvOp0wElOnsFJN+xT5vXwgO20DoXEYHRhqTdQ/D8g4pdjOFJTAMfnXvdafWcw0/yOIKW2qZJxZZhNU3jrVksvN4Bb0IO/zneuUZkOwJYMjKvJEnq5HS3wgcXhjrq864A7rmSKUA/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570135; c=relaxed/simple;
	bh=hPoyjBdZjmFGySibSvx13EH3+vAmNm84KqW+f+HFYEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUvyvJtkz3Ve41kfuWMC5uoyIKiahdwFAtwOmEvgY4wCy8nHBhuuV6pfii3bBjxcIthMKy9mCBCyinUEQkZcnYXQn2k0svukqXLvklDgvfSz/tPBcAk12GQBQraQFODV2hCsj0q591xamukGl4cU635GCVCznaTfKmpMTzGJ5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZNo11l6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722570132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSVipcYTMq1UM5G2Tl6to6hqRsTiwB2iAEZ53b+0iWk=;
	b=TZNo11l6f69lY1r0D3fJYjv4p11KV0RFC62mSUp1Wr/aP7ANb4xSOdIpnWfS2nB6XXbCtS
	nZRLoSWE0ErjeQsnbrXJ6Ey6vByD7oMJMfuHyH8+c57xjpiGaSMIwkoCUo7Zov9yCqjcUm
	/UYTJel/8xTICEzm3EZpI4Str+kU0yI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-buwzn1BbM_2dkprHL-U5AA-1; Thu, 01 Aug 2024 23:42:11 -0400
X-MC-Unique: buwzn1BbM_2dkprHL-U5AA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-778702b9f8fso2201033a12.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 20:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722570129; x=1723174929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSVipcYTMq1UM5G2Tl6to6hqRsTiwB2iAEZ53b+0iWk=;
        b=vBxLd6CA8XVcFKNk1Wum4Clgfd3QueNWjx4bpCSOjAuhu9MXl3kuneiPWDUeFGGp+/
         Hf+yx2+HCw3YIimZxtqW0pUGHyXPm6tehBHJwanypXLdwswvBbwrMM+QtFj3LvPwnylN
         sJLG88JaKi5vzhIfGPSXtBXwKpHm9tSGi8Xp1V4mV1R1JH70w7sFDNnRUO7fqbdmUQxd
         awQBCJ/eAcc1/kYWgihMuM9Dfr5zxzXnJIlJIIP+2Twyw+vb9hEJJLcZvYlaJlDonXGT
         wcLQ9ecfkq7ezVkkma/eYwEr3T0QWpuwGk6IYDLf5x57InQDSgPmoC8nlFLYIh56Imfo
         qWwA==
X-Forwarded-Encrypted: i=1; AJvYcCWmxfvq2MwYg1ur9/3Y3mhv4YT/Y16UbO81IPNM4vipBAhe1AY2BKyVTvfgQ/eAybWnDTapl9uJvIawqBp/XuwjomNnIiOc
X-Gm-Message-State: AOJu0YxFEeWBl+sSVlDWpUG8Qvm28SYa1aGZerRJWrKqa2J5A9Qnid5w
	j7+T9PWc9abBcPlm6NWb15tDvzJS15ghqS+NL9yMOsuem7Mz8yTAoKysui1qBm05QKnJuK6xsRA
	fwCCsvUORGoO28hL6eeic0wE7+kalSITt64EaimmaGKLGAGgYhzNhpKYXqK+n1wORsxadifcUTz
	qkX/0wqpyl3StKcGsYWDF4opJMCO73
X-Received: by 2002:a17:90a:3e84:b0:2c3:34f4:5154 with SMTP id 98e67ed59e1d1-2cff0904753mr5436702a91.1.1722570128815;
        Thu, 01 Aug 2024 20:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOCcO7naxOX17lI/ZiRDsIY3QNQVXq1NBziW2DaddzwfsnicWbTq3qUXH+FPIvqoNRDUvQx81f5+kl5wC1yao=
X-Received: by 2002:a17:90a:3e84:b0:2c3:34f4:5154 with SMTP id
 98e67ed59e1d1-2cff0904753mr5436662a91.1.1722570128171; Thu, 01 Aug 2024
 20:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240801135639.11400-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Aug 2024 11:41:57 +0800
Message-ID: <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Michael has effectively reduced the number of spurious interrupts in
> commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> irq callbacks before cleaning old buffers.
>
> But it is still possible that the irq is killed by mistake:
>
>   When a delayed tx interrupt arrives, old buffers has been cleaned in
>   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt i=
s
>   mistakenly identified as a spurious interrupt in vring_interrupt.
>
>   We should refrain from labeling it as a spurious interrupt; otherwise,
>   note_interrupt may inadvertently kill the legitimate irq.

I think the evil came from where we do free_old_xmit() in
start_xmit(). I know it is for performance, but we may need to make
the code work correctly instead of adding endless hacks. Personally, I
think the virtio-net TX path is over-complicated. We probably pay too
much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
the performance.

How about just don't do free_old_xmit and do that solely in the TX NAPI?

>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c     |  9 ++++++
>  drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 ++
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..6d8739418203 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2769,6 +2769,7 @@ static void virtnet_poll_cleantx(struct receive_que=
ue *rq, int budget)
>                 do {
>                         virtqueue_disable_cb(sq->vq);
>                         free_old_xmit(sq, txq, !!budget);
> +                       virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
>                 if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> @@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>
>                 free_old_xmit(sq, txq, false);
>
> +               if (use_napi)
> +                       virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
> +
>         } while (use_napi && !xmit_more &&
>                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> @@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         /* Try to transmit */
>         err =3D xmit_skb(sq, skb, !use_napi);
>
> +       if (use_napi) {
> +               virtqueue_set_tx_newbuf_sent(sq->vq, true);
> +               virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
> +       }
> +
>         /* This should not happen! */
>         if (unlikely(err)) {
>                 DEV_STATS_INC(dev, tx_fifo_errors);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..fb2afc716371 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -180,6 +180,11 @@ struct vring_virtqueue {
>          */
>         bool do_unmap;
>
> +       /* Has any new data been sent? */
> +       bool is_tx_newbuf_sent;
> +       /* Is the old data recently sent cleaned up? */
> +       bool is_tx_oldbuf_cleaned;
> +
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>         vq->premapped =3D false;
>         vq->do_unmap =3D vq->use_dma_api;
> +       vq->is_tx_newbuf_sent =3D false; /* Initially, no new buffer to s=
end. */
> +       vq->is_tx_oldbuf_cleaned =3D true; /* Initially, no old buffer to=
 clean. */
> +
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2375,6 +2383,38 @@ bool virtqueue_notify(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>
> +/**
> + * virtqueue_set_tx_newbuf_sent - set whether there is new tx buf to sen=
d.
> + * @_vq: the struct virtqueue
> + *
> + * If is_tx_newbuf_sent and is_tx_oldbuf_cleaned are both true, the
> + * spurious interrupt is caused by polling TX vq in other paths outside
> + * the tx irq callback.
> + */
> +void virtqueue_set_tx_newbuf_sent(struct virtqueue *_vq, bool val)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       vq->is_tx_newbuf_sent =3D val;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_tx_newbuf_sent);
> +
> +/**
> + * virtqueue_set_tx_oldbuf_cleaned - set whether there is old tx buf to =
clean.
> + * @_vq: the struct virtqueue
> + *
> + * If is_tx_oldbuf_cleaned and is_tx_newbuf_sent are both true, the
> + * spurious interrupt is caused by polling TX vq in other paths outside
> + * the tx irq callback.
> + */
> +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *_vq, bool val)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       vq->is_tx_oldbuf_cleaned =3D val;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
> +
>  /**
>   * virtqueue_kick - update after add_buf
>   * @vq: the struct virtqueue
> @@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!more_used(vq)) {
> +               /* When the delayed TX interrupt arrives, the old buffers=
 are
> +                * cleaned in other cases(start_xmit and virtnet_poll_cle=
antx).
> +                * We'd better not identify it as a spurious interrupt,
> +                * otherwise note_interrupt may kill the interrupt.
> +                */
> +               if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cl=
eaned)) {
> +                       vq->is_tx_newbuf_sent =3D false;
> +                       return IRQ_HANDLED;
> +               }

This is the general virtio code, it's better to avoid any device specific l=
ogic.

> +
>                 pr_debug("virtqueue interrupt with no work for %p\n", vq)=
;
>                 return IRQ_NONE;
>         }
> @@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsi=
gned int index,
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>         vq->premapped =3D false;
>         vq->do_unmap =3D vq->use_dma_api;
> +       vq->is_tx_newbuf_sent =3D false; /* Initially, no new buffer to s=
end. */
> +       vq->is_tx_oldbuf_cleaned =3D true; /* Initially, no old buffer to=
 clean. */
> +
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index ecc5cb7b8c91..ba3be9276c09 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  int virtqueue_reset(struct virtqueue *vq,
>                     void (*recycle)(struct virtqueue *vq, void *buf));
>
> +void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
> +void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
> +
>  struct virtio_admin_cmd {
>         __le16 opcode;
>         __le16 group_type;
> --
> 2.32.0.3.g01195cf9f
>


