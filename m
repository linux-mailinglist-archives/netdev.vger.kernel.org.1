Return-Path: <netdev+bounces-169940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E63A468D0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FD3AEC35
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795422B595;
	Wed, 26 Feb 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NjVJC9qQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC890221F21
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592994; cv=none; b=lpuvm2QCAR8N6SmG67JVtnD8iTL2Pttak20IoNurPHZN+9KOJLLf7aWZMQlApt7g1EfTv1vdg/Zpl5TeVhiurUqvWR2DnuPwH4mcGRM39yZhD/8h5ejn3sO9BuuWr3vxEi2HkCNgUKNuNYJo/NGzDnB6zRVwMQyfU8jaZMgz2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592994; c=relaxed/simple;
	bh=pk0pC6t6um9qBn4p+8lB7nBwhVbJXCecjo9e4IElSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+rjKY27jFhWWYM/KqTa+c4ZgeLBs9OAjYBz8uCr8MDaGu9Yvi8Zwqr7X7cJqMG/CSDQZkn3+3W1uTzF/WVWXgaMoEKLaOpVaqFrde5Akap228pnyW3vjtDVZgDcDu+k0OkI+L5E+56wiwi8rrZSjX1rlG0znOyXNhP5uSqlCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NjVJC9qQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e6846bcde2so1183206d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740592991; x=1741197791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=of80sMkyjgbyIQl9C+Zi/ibA5uGcLRduGmbGJlBkuUg=;
        b=NjVJC9qQSibtK4Am5gDjJ77370i5b0uW57GiDzzZOuH8gTyCtOcsoodk1442wzvx4N
         NzYbAZ11w5QIjwgLAml350uidrKv+yBEG+RXA3cpv5BJdZoJXc99io65eI0zdikI4p2f
         xMcnKm7hWaECRKGY5sMx43AyCrtZGm//JGJMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592991; x=1741197791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of80sMkyjgbyIQl9C+Zi/ibA5uGcLRduGmbGJlBkuUg=;
        b=cfcbHxZZqvvprTvha10AOeUuYFjYmIBbzxlSzb1asKBTG45TqgtTp23dqfmsxogJIt
         vZq8HNI8JtFjMmspaKFcvCdZmgR1ivYfjAsyXxL7tRFo1ICHSZVewetOfzyl0G3N29jk
         Z2fdthNpekcdTgUUBYfWS/KppditX/AlEFkzC61Bq9Nz7eyZJ2bHrF1JF5bx0ptzHQ9i
         rzPGdyvKJOxjb1iXQr3ge9xUUSSUPQV77z0wqTfvWvWwVMkMPTdBY0ShiLfzXwrkxN7O
         fMSxRU15KPbm9owHegTFmjFI/6S12Kwqf3BRu4FYbrKnh7Xb7/e7u1cqe15Vk+yfatJB
         v/mw==
X-Gm-Message-State: AOJu0YzzgXmgaq8Ns4H8p8d5daWIqs4NMincy7+bOJ/3AnbUdl0nYbQT
	BFeRBYHP0cYKo97/g59PiBnezcmJ4WXkOYKf3uphIKyUW/m+Zpq3goNxe7pLiYE=
X-Gm-Gg: ASbGnctpZ4GTqE48zio29B0oz/WFdGrDY6DO7EG5lTCOR3XKXO3IZWVwb0q93YbW25p
	NPC+ww4WBrKd0i2Cv/aAHcEUcwWoaw1B9gEcwNn3n50evbRExNT0bonF5uDovt/4aXU4kRNRdLw
	Su5rYT8wUdwigs6QfBvQu8Ffx4AuHn3RTCIJ6o8K3Z6iQNBvg/jgujgCJZ0NXg5DddxwPLPUfe4
	dRpQFUqnmdon78avlkznaYtP+0bW74adwWhMwjgevi/V25FV1K1r8XrhDTEg8rugOPgpWoNJGTn
	My9vzVdkPxKMEOO7jxHQJ/fjZ5IAPgXKcUh0sTUgWGSQTtCkudoLu6BvgsSXruXW
X-Google-Smtp-Source: AGHT+IGAaBd6il+E1Xhz7b8qOTER0+iOVpZwG28KVQBnLO0jK5b6kJjGK/qvC93o6b4QspR98NE2kQ==
X-Received: by 2002:a05:6214:f25:b0:6e4:4331:aae4 with SMTP id 6a1803df08f44-6e87ab2f5bdmr108569456d6.1.1740592991562;
        Wed, 26 Feb 2025 10:03:11 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc57sm25238316d6.15.2025.02.26.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:03:11 -0800 (PST)
Date: Wed, 26 Feb 2025 13:03:09 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>

On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps, taking care to hold RTNL as needed.
> 
> I may miss something but I wonder whether letting the caller hold the
> lock is better.

Hmm...

Double checking all the paths over again, here's what I see:
  - refill_work, delayed work that needs RTNL so this change seems
    right?

  - virtnet_disable_queue_pair, called from virtnet_open and
    virtnet_close. When called via NDO these are safe and hold RTNL,
    but they can be called from power management and need RTNL.

  - virtnet_enable_queue_pair called from virtnet_open, safe when
    used via NDO but needs RTNL when used via power management.

  - virtnet_rx_pause called in both paths as you mentioned, one
    which needs RTNL and one which doesn't.

I think there are a couple ways to fix this:

  1. Edit this patch to remove the virtnet_queue_set_napi helper,
     and call netif_queue_set_napi from the napi_enable and
     napi_disable helpers directly. Modify code calling into these
     paths to hold rtnl (or not) as described above.

  2. Modify virtnet_enable_queue_pair, virtnet_disable_queue_pair,
     and virtnet_rx_pause to take a "bool need_rtnl" as an a
     function argument and pass that through.

I'm not sure which is cleaner and I do not have a preference.

Can you let me know which you prefer? I am happy to implement either
one for the next revision.

[...]

> > ---
> >  drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
> >  1 file changed, 52 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e578885c1093..13bb4a563073 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
> >         virtqueue_napi_schedule(&rq->napi, rvq);
> >  }
> >
> > +static void virtnet_queue_set_napi(struct net_device *dev,
> > +                                  struct napi_struct *napi,
> > +                                  enum netdev_queue_type q_type, int qidx,
> > +                                  bool need_rtnl)
> > +{
> > +       if (need_rtnl)
> > +               rtnl_lock();
> > +
> > +       netif_queue_set_napi(dev, qidx, q_type, napi);
> > +
> > +       if (need_rtnl)
> > +               rtnl_unlock();
> > +}
> > +
> >  static void virtnet_napi_do_enable(struct virtqueue *vq,
> >                                    struct napi_struct *napi)
> >  {
> > @@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> >         local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct receive_queue *rq)
> > +static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > +       int qidx = vq2rxq(rq->vq);
> > +
> >         virtnet_napi_do_enable(rq->vq, &rq->napi);
> > +       virtnet_queue_set_napi(vi->dev, &rq->napi,
> > +                              NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
> >  }
> >
> > -static void virtnet_napi_tx_enable(struct send_queue *sq)
> > +static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
> >  {
> >         struct virtnet_info *vi = sq->vq->vdev->priv;
> >         struct napi_struct *napi = &sq->napi;
> > +       int qidx = vq2txq(sq->vq);
> >
> >         if (!napi->weight)
> >                 return;
> > @@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
> >         }
> >
> >         virtnet_napi_do_enable(sq->vq, napi);
> > +       virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
> > +                              need_rtnl);
> >  }
> >
> > -static void virtnet_napi_tx_disable(struct send_queue *sq)
> > +static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = sq->vq->vdev->priv;
> >         struct napi_struct *napi = &sq->napi;
> > +       int qidx = vq2txq(sq->vq);
> >
> > -       if (napi->weight)
> > +       if (napi->weight) {
> > +               virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
> > +                                      qidx, need_rtnl);
> >                 napi_disable(napi);
> > +       }
> >  }
> >
> > -static void virtnet_napi_disable(struct receive_queue *rq)
> > +static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> >         struct napi_struct *napi = &rq->napi;
> > +       int qidx = vq2rxq(rq->vq);
> >
> > +       virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
> > +                              need_rtnl);
> >         napi_disable(napi);
> >  }
> >
> > @@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
> >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq = &vi->rq[i];
> >
> > -               virtnet_napi_disable(rq);
> > +               virtnet_napi_disable(rq, true);
> >                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > -               virtnet_napi_enable(rq);
> > +               virtnet_napi_enable(rq, true);
> >
> >                 /* In theory, this can happen: if we don't get any buffers in
> >                  * we will *never* try to fill again.
> > @@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> >  {
> > -       virtnet_napi_tx_disable(&vi->sq[qp_index]);
> > -       virtnet_napi_disable(&vi->rq[qp_index]);
> > +       virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > +       virtnet_napi_disable(&vi->rq[qp_index], false);
> >         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > @@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> >         if (err < 0)
> >                 goto err_xdp_reg_mem_model;
> >
> > -       virtnet_napi_enable(&vi->rq[qp_index]);
> > -       virtnet_napi_tx_enable(&vi->sq[qp_index]);
> > +       virtnet_napi_enable(&vi->rq[qp_index], false);
> > +       virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> >
> >         return 0;
> >
> > @@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> >         bool running = netif_running(vi->dev);
> >
> >         if (running) {
> > -               virtnet_napi_disable(rq);
> > +               virtnet_napi_disable(rq, true);
> 
> During the resize, the rtnl lock has been held on the ethtool path
> 
>         rtnl_lock();
>         rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
>         rtnl_unlock();
> 
> virtnet_rx_resize()
>     virtnet_rx_pause()
> 
> and in the case of XSK binding, I see ASSERT_RTNL in xp_assign_dev() at least.

Thanks for catching this. I re-read all the paths and I think I've
outlined a few other issues above.

Please let me know which of the proposed methods above you'd like me
to implement to get this merged.

Thanks.

---
pw-bot: cr

