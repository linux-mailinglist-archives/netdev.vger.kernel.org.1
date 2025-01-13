Return-Path: <netdev+bounces-157578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D4A0AE15
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F380188674B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569814A4E1;
	Mon, 13 Jan 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G95jvfEy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F02AF09
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741170; cv=none; b=g4QzUmcnbJAa+w3fmkHExb6VxPaGebM0l9rr4IoU5C9kKMw4BmmO13thJtDHWA1i4csysHYzrehdkIG/hwhYuKXk8it63Cued6urHCEymHPUvVct/e8+BmEw+AeS3Mxj9lHfcfCcbbPVt8m/OWJxAMrA8a9q9pknkuBe0ft0vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741170; c=relaxed/simple;
	bh=YZZ9I+l3G7qr3EMipQUJR0fSHci2HaxgX7ZkbidFbrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA643ex4WZQbc2qtEkMO8g7wIOsLMVrZBiEc0On901k6+J8PhGgpTGlrykvwR+xRtDui8qges2gKOQlPXLD/T7WzCHqpYHvgh5TpabJJ+kfJihwXVX5tpkjDfY1XiVd67ih4KGBC5a3Bw2sqEjg3pk1lHAjOOH+wq/TGPn7kTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G95jvfEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736741166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ9KVJCNW1gWH14rRZNf+IonExJW3H1qiVrWM9RW4co=;
	b=G95jvfEyKW2e8/Bxsw37AJGdLLAsiadCx7fkf1dWMhu0cX/cwekBWKCGTtGUC4OoExX7mw
	sAg8JzO4V2jwinAIDyNnk9mgv4A3dKfml6NJsM9qbBYvR/0YFxmlRb0TZBMaROEKMw8tCY
	z/LMg7MqCdsF8FVu44WJAH7JflxVASc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-t6bCvC1sMW-qpHGvHvN9hw-1; Sun, 12 Jan 2025 23:06:04 -0500
X-MC-Unique: t6bCvC1sMW-qpHGvHvN9hw-1
X-Mimecast-MFC-AGG-ID: t6bCvC1sMW-qpHGvHvN9hw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee6dccd3c9so6582437a91.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 20:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736741163; x=1737345963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ9KVJCNW1gWH14rRZNf+IonExJW3H1qiVrWM9RW4co=;
        b=w820q8to+LyBF61FjltDaYVwCFvDTo33CdeVpDynsQSrBjfKdlkOa2U7/5kA9eWf2U
         h4Fg4C0JNxs+e4C1X7/rDnJ+dCEZlv+5vy6wsQlqeV9B7J1R717enomStRlyNVycpTBA
         A+TMIGIMHhKrjMh+OGRSTQRbRbRmLlVILNCpJgVU7B1HpbjRHSjezznV0mpvsidB4Vqq
         wb61elD5HRBpwV1ekBBuGSKhKm3qt3HvfdXOh0oxwqQM/82BZVk1gXtLvKRGzK8YyRYN
         cNLESw2g+0Hns1SpIWtUjR6uY/INUWtXeviL3RLjlRQeZAWdhPFQkbIUeFmowuEBL5Kt
         nrew==
X-Gm-Message-State: AOJu0YxOYX7NwCqJd+A3D0oR2eycpzG7+G0nsCKirvGwtjneY3hymkSX
	yPl8DDwqQHZpsr5AdhQEflrzS3FHN44clSwpYYZ9827af/rOBqwFwTHFXUvvpKeqGa8EkxTRtK+
	03G144zQuvFStBBzobi+l+343TIRMjaRbWLnGw8IILQ7ZzVcHPFrOYd8NK9lE/JBXI3g5UnVodc
	SoiFEKG5SPZexSwZSIde8LtsHcXGNj
X-Gm-Gg: ASbGncv/QgDYQ67KZ3+DwgyrRypzJT+WkmLytmFKn2lc3+8qILgSYbEQhhZHoYV9b3g
	D9a1JDmVdCIt0uvryBmvdpo8U1Q/tWS4PeseawhI=
X-Received: by 2002:a17:90b:51cb:b0:2ef:3192:d280 with SMTP id 98e67ed59e1d1-2f548f162acmr26190264a91.5.1736741163604;
        Sun, 12 Jan 2025 20:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1A+G5TTiOBCTRJzQQc8LlM21qz/pIEYJLiWzPbeMHcvlPcNaP8l/WEchbVIhmKLEDwqkhau6vUzNiW09UCBo=
X-Received: by 2002:a17:90b:51cb:b0:2ef:3192:d280 with SMTP id
 98e67ed59e1d1-2f548f162acmr26190231a91.5.1736741163106; Sun, 12 Jan 2025
 20:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110202605.429475-1-jdamato@fastly.com> <20250110202605.429475-4-jdamato@fastly.com>
In-Reply-To: <20250110202605.429475-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 12:05:51 +0800
X-Gm-Features: AbW1kvbJjBsqd5MxoROEXNyf-c5A5BV1qq0kCSqjUPSk4kLtr3sC7nlacQgsc78
Message-ID: <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 4:26=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4e88d352d3eb..8f0f26cc5a94 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtque=
ue *vq,
>  }
>
>  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> -                                    struct napi_struct *napi)
> +                                    struct napi_struct *napi,
> +                                    bool need_rtnl)
>  {
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       int q =3D vq2rxq(vq);
> +
>         virtnet_napi_do_enable(vq, napi);
> +
> +       if (q < vi->curr_queue_pairs) {
> +               if (need_rtnl)
> +                       rtnl_lock();

Can we tweak the caller to call rtnl_lock() instead to avoid this trick?

> +
> +               netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, na=
pi);
> +
> +               if (need_rtnl)
> +                       rtnl_unlock();
> +       }
>  }
>
>  static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct=
 *napi)
>  {
> -       virtnet_napi_enable_lock(vq, napi);
> +       virtnet_napi_enable_lock(vq, napi, false);
>  }
>
>  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> @@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq =3D &vi->rq[i];
>
> +               rtnl_lock();
> +               netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> +               rtnl_unlock();
>                 napi_disable(&rq->napi);

I wonder if it's better to have a helper to do set napi to NULL as
well as napi_disable().

> +
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> -               virtnet_napi_enable_lock(rq->vq, &rq->napi);
> +               virtnet_napi_enable_lock(rq->vq, &rq->napi, true);
>
>                 /* In theory, this can happen: if we don't get any buffer=
s in
>                  * we will *never* try to fill again.
> @@ -3048,6 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
>  {
>         virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +       netif_queue_set_napi(vi->dev, qp_index, NETDEV_QUEUE_TYPE_RX, NUL=
L);
>         napi_disable(&vi->rq[qp_index].napi);
>         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
> @@ -3317,8 +3336,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_que=
ue *rq)
>  {
>         bool running =3D netif_running(vi->dev);
> +       int q =3D vq2rxq(rq->vq);
>
>         if (running) {
> +               netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NU=
LL);
>                 napi_disable(&rq->napi);
>                 virtnet_cancel_dim(vi, &rq->dim);
>         }
> @@ -5943,6 +5964,8 @@ static int virtnet_xdp_set(struct net_device *dev, =
struct bpf_prog *prog,
>         /* Make sure NAPI is not using any XDP TX queues for RX. */
>         if (netif_running(dev)) {
>                 for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYP=
E_RX,
> +                                            NULL);
>                         napi_disable(&vi->rq[i].napi);
>                         virtnet_napi_tx_disable(&vi->sq[i].napi);
>                 }
> --
> 2.25.1
>

Thanks


