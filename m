Return-Path: <netdev+bounces-109736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E160B929CA6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE81C214E0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BE1BC5C;
	Mon,  8 Jul 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxtAlRWq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB718E1E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422071; cv=none; b=Xo11YSl9FdQzz+8bmRiIPtWjInZbanMvoAHBRy2UmGouDNrDD9NQG4m2F0JSpmZdgf78L7D2hnUcainu5nPI7O2KIueA3znKlaPHpvlBNZysb1vrnVPvEdH3grUmnynaLBA/x6DRKZZSRGi05k+c6X2RnDI/khRWutWcaGbuwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422071; c=relaxed/simple;
	bh=abzvPZ9aMqHcWYduVBI7v95AXAHY1ldyKfg0qH647b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHTf64fW/Vi8+UY6pNea8CRExCGaSnkFC2jLpc07E7H1PHOHaYRnGc3OjYNkZwYrJ4BUQpakBG6bUfDYzDQ3WN/T5g/jtz37Bj2N9zTZZcP7GlUSYQQk5+mvSn1qFAtuzvmgEU0xQcWet/GexckmcnqDLMPDU/4EQnODxxBU4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxtAlRWq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIiSiOPGT74LKdsGWbRlafq9sMVz9Zj8uvoYvrXoHLI=;
	b=SxtAlRWqk69hlrh0hbGkUjZ1Vr7hp9dRRydhWo5ShRfgQgCBUYPh6TlE91GvOEUBac1ot/
	WGj/lfO6/fD3kbJoomhxZ9ovpusQcjFHT92wYAus/+ucGRjn6L4BY1muAPJBr3k7LdBKwS
	3diFfyANgcihXtRff0Tv9oXT1Ec0ZyU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-P4JWplr9MkmPHrg77WZqJg-1; Mon, 08 Jul 2024 03:01:03 -0400
X-MC-Unique: P4JWplr9MkmPHrg77WZqJg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-25e46c20b00so3229444fac.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422063; x=1721026863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIiSiOPGT74LKdsGWbRlafq9sMVz9Zj8uvoYvrXoHLI=;
        b=s9zjIapcBfss0+uXBGyqwwsT9NTkhegJAv5fBX4N5oFvXpwdZB9u55/dB7nes6dL6Y
         jeXrhYp2Rq9TUX/KAu6/soK7S5t5WsKv3mqbXj/4F60UK3wh5ItNV+3oa9xn9eC2BJsg
         0pEfNcM82dsgB0mYuoIr5T1uy/ZEJLBLJ2DfXYXD75YVSU6N0Oi+SDc8pgHsvjuadZ1f
         nbyGTuvvW+tbK2VBMMo528lg+0XXxQ54Q6EwNsSz1aqkJyI07U/5jtFzw4GXbM3hYKkW
         hLOT0r/l12F1gBegmp4HKatmNI2tEp7tclrNA7ygj0Sgploq56Z6G6KAvq6i/plVlnAn
         Eh6g==
X-Gm-Message-State: AOJu0Ywg5uPTzRAlgtWweKdyl2sNVlveMIOF8RG10tOL2HrmDEMidHLN
	U31YdRodRvG3Ow8xo+lWgsnBjZN1vt0amzWq+KKap8E/DfHyEV9n9V0NcTFaWVQKTgIrjtsor85
	09IqS3AtbptH1Bd8zGkQtdtUqahhwAuGS00W9zhCFBb8ynCnd7DLxpD8iU6rP4ZL8XLlp7lzQ1w
	HsABkpZv7Gtkzae6zS0+YTHoYUN1Do
X-Received: by 2002:a05:6870:fb8b:b0:259:89a5:440e with SMTP id 586e51a60fabf-25e2bb7fb35mr10043087fac.27.1720422062733;
        Mon, 08 Jul 2024 00:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFazS2vrLBF7mr6COd4hzxBHu/Wd4B/eVuXoVldrurab2QJeEsJRFzSmFq0IZSYZwx+a0prDz/Fkp629+/OW+Y=
X-Received: by 2002:a05:6870:fb8b:b0:259:89a5:440e with SMTP id
 586e51a60fabf-25e2bb7fb35mr10043066fac.27.1720422062307; Mon, 08 Jul 2024
 00:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:00:50 +0800
Message-ID: <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/10] virtio_net: xsk: rx: support recv small mode
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

On Fri, Jul 5, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> In the process:
> 1. We may need to copy data to create skb for XDP_PASS.
> 2. We may need to call xsk_buff_free() to release the buffer.
> 3. The handle for xdp_buff is difference from the buffer.
>
> If we pushed this logic into existing receive handle(merge and small),
> we would have to maintain code scattered inside merge and small (and big)=
.
> So I think it is a good choice for us to put the xsk code into an
> independent function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>    1. rename xdp_construct_skb to xsk_construct_skb
>    2. refactor virtnet_receive()
>
>  drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 168 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2b27f5ada64a..64d8cd481890 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
>  };
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
> +                              struct net_device *dev,
> +                              unsigned int *xdp_xmit,
> +                              struct virtnet_rq_stats *stats);
> +static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
> +                                struct sk_buff *skb, u8 flags);
>
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist *sg, d=
ma_addr_t addr, u32 len)
>         sg->length =3D len;
>  }
>
> +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> +                                  struct receive_queue *rq, void *buf, u=
32 len)
> +{
> +       struct xdp_buff *xdp;
> +       u32 bufsize;
> +
> +       xdp =3D (struct xdp_buff *)buf;
> +
> +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_le=
n;
> +
> +       if (unlikely(len > bufsize)) {
> +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +                        vi->dev->name, len, bufsize);
> +               DEV_STATS_INC(vi->dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       xsk_buff_set_size(xdp, len);
> +       xsk_buff_dma_sync_for_cpu(xdp);
> +
> +       return xdp;
> +}
> +
> +static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
> +                                        struct xdp_buff *xdp)
> +{
> +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> +       struct sk_buff *skb;
> +       unsigned int size;
> +
> +       size =3D xdp->data_end - xdp->data_hard_start;
> +       skb =3D napi_alloc_skb(&rq->napi, size);
> +       if (unlikely(!skb)) {
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +
> +       size =3D xdp->data_end - xdp->data_meta;
> +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> +
> +       if (metasize) {
> +               __skb_pull(skb, metasize);
> +               skb_metadata_set(skb, metasize);
> +       }
> +
> +       xsk_buff_free(xdp);
> +
> +       return skb;
> +}
> +
> +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev,=
 struct virtnet_info *vi,
> +                                                struct receive_queue *rq=
, struct xdp_buff *xdp,
> +                                                unsigned int *xdp_xmit,
> +                                                struct virtnet_rq_stats =
*stats)
> +{
> +       struct bpf_prog *prog;
> +       u32 ret;
> +
> +       ret =3D XDP_PASS;
> +       rcu_read_lock();
> +       prog =3D rcu_dereference(rq->xdp_prog);
> +       if (prog)
> +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       rcu_read_unlock();
> +
> +       switch (ret) {
> +       case XDP_PASS:
> +               return xsk_construct_skb(rq, xdp);
> +
> +       case XDP_TX:
> +       case XDP_REDIRECT:
> +               return NULL;
> +
> +       default:
> +               /* drop packet */
> +               xsk_buff_free(xdp);
> +               u64_stats_inc(&stats->drops);
> +               return NULL;
> +       }
> +}
> +
> +static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct rece=
ive_queue *rq,
> +                                   void *buf, u32 len,
> +                                   unsigned int *xdp_xmit,
> +                                   struct virtnet_rq_stats *stats)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       struct sk_buff *skb =3D NULL;
> +       struct xdp_buff *xdp;
> +       u8 flags;
> +
> +       len -=3D vi->hdr_len;
> +
> +       u64_stats_add(&stats->bytes, len);
> +
> +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> +       if (!xdp)
> +               return;
> +
> +       if (unlikely(len < ETH_HLEN)) {
> +               pr_debug("%s: short packet %i\n", dev->name, len);
> +               DEV_STATS_INC(dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return;
> +       }
> +
> +       flags =3D ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_l=
en))->hdr.flags;
> +
> +       if (!vi->mergeable_rx_bufs)
> +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_x=
mit, stats);

I wonder if we add the mergeable support in the next patch would it be
better to re-order the patch? For example, the xsk binding needs to be
moved to the last patch, otherwise we break xsk with a mergeable
buffer here?

Or anything I missed here?

Thanks


