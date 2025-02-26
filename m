Return-Path: <netdev+bounces-170019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C8A46E3A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8775F7A31F8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653826E62D;
	Wed, 26 Feb 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCcEjVid"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7726BD83
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607887; cv=none; b=Hlrt9KtHp5b2cmMoRomIuuhJHOlI6T8vWJtHVMtGC1APEgaPJHJ915adonLstmqBPVCmhLmEmlaafpipQZzu26Y+VUTvPMNfDvj7gfF23msF7BQBSWaQ8+oV9u1Jh7JCHMK04iZRACa3UJlh0QKkvWvVFOA6EEPZo/yrHuKDpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607887; c=relaxed/simple;
	bh=V++Xmlo2Nswu93mayQmVsWDhp4ss6pyFSfa1fzm2HeM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYmrgDaiW0fDOSVhy1ff6XYhe6zHYmMR81P1M9rRkoQt73SLDpLD/jodPbSFjMcUgcUluCUbPqfO5WPSzriY90iO8LCVxw8fweNQaCMBmAwLBs89uMmSgSDLR8cYWvuM2wIbA9jGn6vuK0LOJ/CLw8YDxGjjpMS+hTJF83y+r+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCcEjVid; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740607884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLn/itlfNCF0HlLfDkYsSVrwBFlxuyO81r68eizKZU=;
	b=cCcEjVidweduZlplLXxqqZ6v7yWtAM0DzS+JEjPo5FYrnc0eSB7rKbWOHN355hAvgKUp6Q
	vEU9fePnygNy2qzJWl/DFywTZdqp/QbcnaEfSd0LBlzmd9UiMeaWvQYlde3ZLgReG2/83T
	xpNk05+XKFKsUTGmbSOkzVBRsKKwIHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-jKeI16tCOOe1CeuImN3hXg-1; Wed, 26 Feb 2025 17:11:21 -0500
X-MC-Unique: jKeI16tCOOe1CeuImN3hXg-1
X-Mimecast-MFC-AGG-ID: jKeI16tCOOe1CeuImN3hXg_1740607881
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so3232905e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607881; x=1741212681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLn/itlfNCF0HlLfDkYsSVrwBFlxuyO81r68eizKZU=;
        b=MMAHDK2L1kaat7DjJ8cLCeZQKICZxEqXV5S573P+UzWQ5JjRAkbFHmYckofgFaBrxB
         T8U2g17Y34/5+iWvL4DPYhwta8+kyDzSytm9Vq4Jkyh9uTPEvwu40tpnMDa2OFOqwo+/
         Ssq9FvpMDKwmu1j254nJ7z3bFhcNBeQDe5rHgPBqIjEzJ9rmrv9+G6SfxSlanLRpoEfD
         ZjLY08eOUWcuzGoL2a4BRAkVyRPbmgQW7KBxbayC531lEaUH2vxAT2Ibu9Sbur/BMa0D
         huN0VaHfoLd/KERZ6oxGLPmkmt5HjrAnahgsr9HLLMNpMhC4C8NVUjIlt97hl4cLFAem
         Smuw==
X-Forwarded-Encrypted: i=1; AJvYcCUPz5qp2fIUiUxfvVcRZdF9/q0riHrC3GdrmuGGNvjzablRGwVf8VhyMnFzjf2VdAnDBBrjetw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO56D/mUswSKQ8a1F1yTCl0bIk//56m4IpllLOMs+p9mRf3YLk
	lCFj3sfEDiWq7z58dwSwdHMMBrVY+5iyHhx1iRY7HCQgxq9ThZJ1vr56DbMO/+Fm/5hAPTpkW2E
	hkJWicjkPscjBDFEJGyEew/3SXT6QUfyIrMIAOVpoTUvqG8pT6v67Yg==
X-Gm-Gg: ASbGnctyrdVKSW4ibbw4HY4uQgt6ofcEO4fI9xXYqjfIMKfzvvHt5Nvl2nlvw9ojxZU
	ej1Q3G1cMc8mpchLztrVcQYBZU/MRPOxzrRcCoq1ssH+AoPn7dAGi0j4AYY7lhW2cYfLImER2pi
	d6EVWsA1276YPuI75CPmL5+k2y+2xCKTUKSEuW9ZkBin6FcpFgPMhJTK2/xP905pm7MxflRvhWP
	/cpgPOek6GSAhPDWdcY2zTw+iaY2ejgh8nhS2VXmGPFw3YALSU30vgZn+MuMrfcglvEzZII1hai
	+NPsIz1LIg==
X-Received: by 2002:a05:600c:3b12:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43ad6834cedmr18689555e9.15.1740607880659;
        Wed, 26 Feb 2025 14:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaelfXZLDUuHI3CpMumlbbQdNQDUp+SKRLlXHIvXK8BQFYRaYdUr1OnrM+q+ZUTw6/bJjjHA==
X-Received: by 2002:a05:600c:3b12:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43ad6834cedmr18689355e9.15.1740607880188;
        Wed, 26 Feb 2025 14:11:20 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bcfdsm2512865e9.40.2025.02.26.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:11:19 -0800 (PST)
Date: Wed, 26 Feb 2025 17:11:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250226171034-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>

On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > >
> > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > can be accessed by user apps, taking care to hold RTNL as needed.
> > 
> > I may miss something but I wonder whether letting the caller hold the
> > lock is better.
> 
> Hmm...
> 
> Double checking all the paths over again, here's what I see:
>   - refill_work, delayed work that needs RTNL so this change seems
>     right?
> 
>   - virtnet_disable_queue_pair, called from virtnet_open and
>     virtnet_close. When called via NDO these are safe and hold RTNL,
>     but they can be called from power management and need RTNL.
> 
>   - virtnet_enable_queue_pair called from virtnet_open, safe when
>     used via NDO but needs RTNL when used via power management.
> 
>   - virtnet_rx_pause called in both paths as you mentioned, one
>     which needs RTNL and one which doesn't.
> 
> I think there are a couple ways to fix this:
> 
>   1. Edit this patch to remove the virtnet_queue_set_napi helper,
>      and call netif_queue_set_napi from the napi_enable and
>      napi_disable helpers directly. Modify code calling into these
>      paths to hold rtnl (or not) as described above.
> 
>   2. Modify virtnet_enable_queue_pair, virtnet_disable_queue_pair,
>      and virtnet_rx_pause to take a "bool need_rtnl" as an a
>      function argument and pass that through.
> 
> I'm not sure which is cleaner and I do not have a preference.
> 
> Can you let me know which you prefer? I am happy to implement either
> one for the next revision.


1  seems cleaner.
taking locks depending on paths is confusing

> [...]
> 
> > > ---
> > >  drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
> > >  1 file changed, 52 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e578885c1093..13bb4a563073 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
> > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > >  }
> > >
> > > +static void virtnet_queue_set_napi(struct net_device *dev,
> > > +                                  struct napi_struct *napi,
> > > +                                  enum netdev_queue_type q_type, int qidx,
> > > +                                  bool need_rtnl)
> > > +{
> > > +       if (need_rtnl)
> > > +               rtnl_lock();
> > > +
> > > +       netif_queue_set_napi(dev, qidx, q_type, napi);
> > > +
> > > +       if (need_rtnl)
> > > +               rtnl_unlock();
> > > +}
> > > +
> > >  static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >                                    struct napi_struct *napi)
> > >  {
> > > @@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >         local_bh_enable();
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct receive_queue *rq)
> > > +static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > > +       int qidx = vq2rxq(rq->vq);
> > > +
> > >         virtnet_napi_do_enable(rq->vq, &rq->napi);
> > > +       virtnet_queue_set_napi(vi->dev, &rq->napi,
> > > +                              NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
> > >  }
> > >
> > > -static void virtnet_napi_tx_enable(struct send_queue *sq)
> > > +static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
> > >  {
> > >         struct virtnet_info *vi = sq->vq->vdev->priv;
> > >         struct napi_struct *napi = &sq->napi;
> > > +       int qidx = vq2txq(sq->vq);
> > >
> > >         if (!napi->weight)
> > >                 return;
> > > @@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
> > >         }
> > >
> > >         virtnet_napi_do_enable(sq->vq, napi);
> > > +       virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
> > > +                              need_rtnl);
> > >  }
> > >
> > > -static void virtnet_napi_tx_disable(struct send_queue *sq)
> > > +static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = sq->vq->vdev->priv;
> > >         struct napi_struct *napi = &sq->napi;
> > > +       int qidx = vq2txq(sq->vq);
> > >
> > > -       if (napi->weight)
> > > +       if (napi->weight) {
> > > +               virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
> > > +                                      qidx, need_rtnl);
> > >                 napi_disable(napi);
> > > +       }
> > >  }
> > >
> > > -static void virtnet_napi_disable(struct receive_queue *rq)
> > > +static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > >         struct napi_struct *napi = &rq->napi;
> > > +       int qidx = vq2rxq(rq->vq);
> > >
> > > +       virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
> > > +                              need_rtnl);
> > >         napi_disable(napi);
> > >  }
> > >
> > > @@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
> > >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> > >                 struct receive_queue *rq = &vi->rq[i];
> > >
> > > -               virtnet_napi_disable(rq);
> > > +               virtnet_napi_disable(rq, true);
> > >                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > -               virtnet_napi_enable(rq);
> > > +               virtnet_napi_enable(rq, true);
> > >
> > >                 /* In theory, this can happen: if we don't get any buffers in
> > >                  * we will *never* try to fill again.
> > > @@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >
> > >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >  {
> > > -       virtnet_napi_tx_disable(&vi->sq[qp_index]);
> > > -       virtnet_napi_disable(&vi->rq[qp_index]);
> > > +       virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > > +       virtnet_napi_disable(&vi->rq[qp_index], false);
> > >         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> > >  }
> > >
> > > @@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >         if (err < 0)
> > >                 goto err_xdp_reg_mem_model;
> > >
> > > -       virtnet_napi_enable(&vi->rq[qp_index]);
> > > -       virtnet_napi_tx_enable(&vi->sq[qp_index]);
> > > +       virtnet_napi_enable(&vi->rq[qp_index], false);
> > > +       virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > >
> > >         return 0;
> > >
> > > @@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > >         bool running = netif_running(vi->dev);
> > >
> > >         if (running) {
> > > -               virtnet_napi_disable(rq);
> > > +               virtnet_napi_disable(rq, true);
> > 
> > During the resize, the rtnl lock has been held on the ethtool path
> > 
> >         rtnl_lock();
> >         rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
> >         rtnl_unlock();
> > 
> > virtnet_rx_resize()
> >     virtnet_rx_pause()
> > 
> > and in the case of XSK binding, I see ASSERT_RTNL in xp_assign_dev() at least.
> 
> Thanks for catching this. I re-read all the paths and I think I've
> outlined a few other issues above.
> 
> Please let me know which of the proposed methods above you'd like me
> to implement to get this merged.
> 
> Thanks.
> 
> ---
> pw-bot: cr


