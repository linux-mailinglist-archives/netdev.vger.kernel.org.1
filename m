Return-Path: <netdev+bounces-129446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F0983F31
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBED1F23384
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B95149DF0;
	Tue, 24 Sep 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPWUQo6j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C61494B3
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163323; cv=none; b=GRc2H1kFSjx4NH0LNzsc+PJ4adGQoEKpaYsNFgKqj8AfQjmOCc6mioqqN+78rwPWd7ahx6wlgfJ0oxIhtMcvj4ZwvvmvmVhyEosgXK7CpaEVzYtTmgHeYkYsMdCBIceEh6Sf0pXd7xa5exBzH4IBdhn/h/ucUJ5eWQ486zKKaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163323; c=relaxed/simple;
	bh=JOzBpmaTzmLzwSByr9HHunTnYotVyhV0Tr9z778H/xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUMIVVv3HcjSR63yAP0W7eV70G9PQXXGouadN6O6TpqERHhaVK+v5bYgwho2243hPjREQiuRlTAJ/y3ko2in0DlCVIfkfB1xofjchThKp5r5y6FKsLuYwfvBAWtiDixSVYbcp1wKJucYO5uQ1s2xgv98MYec1KARNPGKXSklYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPWUQo6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMLq1dERUaIKsogPS0ztdyTC78eUZtqilgCMzyVl9Bk=;
	b=fPWUQo6jJ/tRvx9kYtCGNLI3i7BRVx+gc/iOUbni0RJxXY61UvHFX+NREbEVzkrs0Ejq0b
	s7H5plmZ1dQoPdtKooxmpQDUrmHEmQMgZFsSE02nAK/tgZtmRR4I27f0TFy3WNCRRPIoGq
	BI2wIMuIMTk0qWThukSWb1gPGONDkoQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Q0T34HedMeiTuQqvGSmBbg-1; Tue, 24 Sep 2024 03:35:19 -0400
X-MC-Unique: Q0T34HedMeiTuQqvGSmBbg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8817d8e03so7681019a91.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 00:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163319; x=1727768119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMLq1dERUaIKsogPS0ztdyTC78eUZtqilgCMzyVl9Bk=;
        b=seYd4JGJ7M0LETEtgMmlc9++Err6v74ByDE/ql5JMzn+0/4C4DwA/1FUonjsI10sso
         D/mFpHbyqIAxrmTxfJ4KaI/5R8LP0vDBizBmkly9fcxzyhL+ZlTxg1/We8Dp9xg2IFU8
         MItLZs6beM4pcu4ushI6ozYqP172B6DnJr67qxjm5gFpsJoKFZerNIyCdt5rZ01qytWO
         QBkSIc1jghvOC6G49tQS9xwuhYnhJECj394ruuxUCCvOHQi6zoyEDE6jOKPCv70lnift
         Wa/4iQbMRJVgdhmXCu3UYqdQaOxiMEpNa8SoQs2gFnmGTLy4b3K9smhEGoAT/a3ME2kw
         /buw==
X-Gm-Message-State: AOJu0YzhmhAvSwSh74ImhMoIPm4dNBTesSTS1V9pZLoIEspxK6PBDELk
	8UTuTNQmt/1twIJb2R9IM797/4ICEkw/j9hyumxZoWLcGpxA1MQUgz5Ty4IMJycKxEF9fJraQX6
	+N01lmB1sPODfp5d4kG8s33SuqFONsKUJVavLSbexSt6mx9wE9UVHOkZT2WBPpv1/Dj6bFXGnLE
	UtqMVdsqwKzK9pTQjPsxnRwPexA+oK
X-Received: by 2002:a17:90a:9c8:b0:2e0:5959:1414 with SMTP id 98e67ed59e1d1-2e0595917e9mr2146674a91.10.1727163318884;
        Tue, 24 Sep 2024 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe50DNaDeyvcCchm9NAfLGNcC32Ud2Mm4+AUKBbVitVveA9Tm2QDEX75dDDoxKs74StXm+QFdjFY48RfujhvU=
X-Received: by 2002:a17:90a:9c8:b0:2e0:5959:1414 with SMTP id
 98e67ed59e1d1-2e0595917e9mr2146654a91.10.1727163318470; Tue, 24 Sep 2024
 00:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:05 +0800
Message-ID: <CACGkMEsTpJV=dQUHMWTnzuSmGTqdEKz4jYygHtbXGtA0q3HnoA@mail.gmail.com>
Subject: Re: [RFC net-next v1 08/12] virtio_net: xsk: bind/unbind xsk for tx
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

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 41a5ea9b788d..7c379614fd22 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -295,6 +295,10 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       struct xsk_buff_pool *xsk_pool;
> +
> +       dma_addr_t xsk_hdr_dma_addr;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -497,6 +501,8 @@ struct virtio_net_common_hdr {
>         };
>  };
>
> +static struct virtio_net_common_hdr xsk_hdr;
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
>                                struct net_device *dev,
> @@ -5488,6 +5494,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet=
_info *vi, struct receive_queu
>         return err;
>  }
>
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +                                   struct send_queue *sq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
> +               pool =3D NULL;
> +       }
> +
> +       sq->xsk_pool =3D pool;
> +
> +       virtnet_tx_resume(vi, sq);
> +
> +       return err;
> +}
> +
>  static int virtnet_xsk_pool_enable(struct net_device *dev,
>                                    struct xsk_buff_pool *pool,
>                                    u16 qid)
> @@ -5496,6 +5525,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>         struct receive_queue *rq;
>         struct device *dma_dev;
>         struct send_queue *sq;
> +       dma_addr_t hdr_dma;
>         int err, size;
>
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> @@ -5533,6 +5563,11 @@ static int virtnet_xsk_pool_enable(struct net_devi=
ce *dev,
>         if (!rq->xsk_buffs)
>                 return -ENOMEM;
>
> +       hdr_dma =3D virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->=
hdr_len,
> +                                                DMA_TO_DEVICE, 0);
> +       if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
> +               return -ENOMEM;
> +
>         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
>         if (err)
>                 goto err_xsk_map;
> @@ -5541,11 +5576,24 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
>         if (err)
>                 goto err_rq;
>
> +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +       if (err)
> +               goto err_sq;
> +
> +       /* Now, we do not support tx offset, so all the tx virtnet hdr is=
 zero.

What did you mean by "tx offset" here? (Or I don't see the connection
with vnet hdr).

Anyhow the patch looks good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


