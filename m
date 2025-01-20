Return-Path: <netdev+bounces-159670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2DA1653F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 02:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840551884EA4
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60528E3F;
	Mon, 20 Jan 2025 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPx2S4gX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F71BE4A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338313; cv=none; b=ffjV2Zr/5fzqQzTrUXDnq5l+7u1BA3SL7MUpWhWLyUyLWKjQaglMeBT5TIKEbk9KH5fM9KVcaPGxzcLxiEpQeCD1aPhAQvtpIPiGOTkTVXoXPtjiY+Vt+yEkuQi0U+8KmwDz+i7RejwMdX6CgMRA16Snww/0EuaQolqfdd9CEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338313; c=relaxed/simple;
	bh=yuBc5+h/9lwzieCgUsFLqW7znh5vXegnrIKqqEjuQzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZlk9VdUkQhpVNTPFoLtpOBEwsPTgGvyMc8WrA91iMmWu720iQ048H7cTX6gVt0VNmVb7xnrjSrupnFxFeZk/KP8pR3PWocNU5rcvXiqK6Y2pIjTrDgy4f5KQpJ5XS1PMl/SLJncd+kV6+EMisUpIpg5xLIMdZM4NVUACh+Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPx2S4gX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737338309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
	b=QPx2S4gXvSD8RjYsshD3PG/iACjtUml4Oxpnq+AkYQFpzd4GGXFXB4XPAEB++VKWUpStb4
	MgauW51ouKmThxgZ5GuG59vf0kTAGtTVKC1aN4HTXyLxhSpBSgG1dazp8ojI6FREkT5wnO
	mqBIaEcRLNLa87CjpcY6dd0+BORNX3g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Cy-XSko5OtSS27eWtMDr8g-1; Sun, 19 Jan 2025 20:58:27 -0500
X-MC-Unique: Cy-XSko5OtSS27eWtMDr8g-1
X-Mimecast-MFC-AGG-ID: Cy-XSko5OtSS27eWtMDr8g
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so11283111a91.3
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 17:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737338306; x=1737943106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
        b=Y6opNd/gVdO1cFQtHkZjQIfbpMnW2MsXxKY636+tkiwj6jzTrLT5HKhph2+VDOtFq2
         xYAY1LB9Uqza82tt84SmP/uGlQXG/zTI4znhePkUJoHC40YmnZEIF7M6ZfWGm3LE6hnC
         roWXLJYLQOBS/Of5cmicVf3+wuoYPlKsOc/egMLsuH7Kggn6lVrMWF3tKxLZbi7dMz2C
         5GIjgzcm9Vl8ujKfcGiLhd+fdHVMiFAAh/pQiOhil90P8bbw2JZoB2SwBVPQSZa7U9Yf
         E7PMZUFSM/B2uEOERFoUyVKKMff8pKt9TtkaouN0BiNhM8IbnbyCpmSekkoHB5ZianEb
         nt1g==
X-Forwarded-Encrypted: i=1; AJvYcCX059kVLg6HqCcJcQnqrlMi6x0Xej4UOfaOM6uaFRbZo1ktvFtBIKvUfFf5fJbt8ezwOlh5pQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QMc8hV6G+u9nRpN3QpdHtlGJrIago2uRCe8F4rRuqbJbWKjE
	ibNE3lmP2zh5yyV/W4VrvcFwmh4e3BlYbj9g9bIH71FBW9S1q7OYTaiNxMgZZULfQz6dUwhbgRk
	X4wUwSRzqnmPGqkwVF8lc03q7SThFJQNNdjSdtMYX3HdIK0LpHR3/elAAh7C5rhKyzq1TqNMzHO
	zS9Bw3TB7Ebqz2SUa95HNhvo8ihShL
X-Gm-Gg: ASbGncvzAN05zqHggkiIhh8EXCYyL5EPchZg5oEcwo1wmg/04i2BqKpdaPKiq/P7cth
	0Ew1F3Nqt2JlkVhlBJohH4ZDItTWt/gted/WsR072m3aT4ZEsx2dT
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2f782d32bdcmr14441688a91.26.1737338306240;
        Sun, 19 Jan 2025 17:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxcO+gcU6GGpItpVaST+mP+lotfH8ALDufTNkb6YlviJFAQ1S+ZPqhw8EXYw//ooixqAGk20ku9VsIkuS7U5A=
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f782d32bdcmr14441654a91.26.1737338305832; Sun, 19 Jan 2025
 17:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116055302.14308-1-jdamato@fastly.com> <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 09:58:13 +0800
X-Gm-Features: AbW1kvarckGogeshrcvCGai-_wdzjzim8Cy3XTbYBj63sr-Fx1KKQaClUhGQeVc
Message-ID: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Joe Damato <jdamato@fastly.com>, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote=
:
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json=3D'{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Eliminate RTNL code paths using the API Jakub introduced in patch =
1
> >      of this v2.
> >    - Added virtnet_napi_disable to reduce code duplication as
> >      suggested by Jason Wang.
> >
> >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cff18c66b54a..c6fda756dd07 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqu=
eue *vq,
> >       local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_stru=
ct *napi)
> > +static void virtnet_napi_enable(struct virtqueue *vq,
> > +                             struct napi_struct *napi)
> >  {
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> >       virtnet_napi_do_enable(vq, napi);
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, na=
pi);
>
> So what case the check of xdp_enabled is for?

+1 and I think the XDP related checks should be done by the caller not here=
.

>
> And I think we should merge this to last commit.
>
> Thanks.
>

Thanks

> >  }
> >
> >  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> > @@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtne=
t_info *vi,
> >       virtnet_napi_do_enable(vq, napi);
> >  }
> >
> > +static void virtnet_napi_disable(struct virtqueue *vq,
> > +                              struct napi_struct *napi)
> > +{
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> > +
> > +     napi_disable(napi);
> > +}
> > +
> >  static void virtnet_napi_tx_disable(struct napi_struct *napi)
> >  {
> >       if (napi->weight)
> > @@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
> >       for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >               struct receive_queue *rq =3D &vi->rq[i];
> >
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> > +
> >               still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> >               virtnet_napi_enable(rq->vq, &rq->napi);
> >
> > @@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> >  {
> >       virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> > -     napi_disable(&vi->rq[qp_index].napi);
> > +     virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi)=
;
> >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > @@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
> >       bool running =3D netif_running(vi->dev);
> >
> >       if (running) {
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> >               virtnet_cancel_dim(vi, &rq->dim);
> >       }
> >  }
> > @@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev=
, struct bpf_prog *prog,
> >       /* Make sure NAPI is not using any XDP TX queues for RX. */
> >       if (netif_running(dev)) {
> >               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -                     napi_disable(&vi->rq[i].napi);
> > +                     virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].nap=
i);
> >                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> >               }
> >       }
> > --
> > 2.25.1
> >
>


