Return-Path: <netdev+bounces-169941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D5CA468FB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EFF3B033D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B49A221F21;
	Wed, 26 Feb 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KBjUKw8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3323373D
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593335; cv=none; b=lW7mEJTpi0hF0z+fTDA/zdAFcH0Fu/xhtgqDpHDA3XRSF4vLMQO88/luXkC96HNIyeT2mDn5psbkRKS9+n0W3iZv9gRp36aIX2kzLnupVGVDjSqsnUEWoTWqBUGE4X9dE9ujwOdmUaoLrmuQgHJIIYhVptA2/kTI9ukgEHSgue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593335; c=relaxed/simple;
	bh=eQfVgvwJoCtTzoFvvhrYJZfMhtm9FskkGfgkb0KFhkw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nscMvN8+q8CtFaOPMjaG0pOQHcf5lW1Gqpopc9G2/gi76dNESVx0LNP/PgdgqxBly6MdApdJPPECy/WibLozbz4vjQURp5mBsjTXirSjl0RlVtDvW8e70yi9y+va/MAsTYDLY8Hh6NR2VlMq7XVIU/VjPcOtZ5FsrLjcEwynygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KBjUKw8W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0a26b1c67so7028185a.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740593332; x=1741198132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5hco51rn2b0WLpgiphnk2K/t01uxewiYlNvszhvMD0=;
        b=KBjUKw8Wz767xyr3YxsJCsrdeTwhqEcmpbBeVJXhU1gkAKH4qxtzbzvkxnAR8h7Jy7
         fBjzdDWFI73SWkdkjGg018a6nZX3aMWR3qRIWvyAMOetlJdZl30hQZiQVGQQUaihJB5G
         Zvp6D+feI1nlCvGimAnqpXJwFwzD5urjf6B4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593332; x=1741198132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5hco51rn2b0WLpgiphnk2K/t01uxewiYlNvszhvMD0=;
        b=mhGm39t18VWNEwMxQUCKbgnqbTvDlmORiuYlGlsh8weBGQiCg5B5mV/tY6Y9btB2x9
         f3fFXDtjPTQeYfB7hXy4VJZfbDHiP2eMPTobJ5rdOvfQ6PpmFnqeSs9O8ZF/+Si7gZx4
         MWowY00pINw6IDt7RfHPk8xp3yHxreZDBiPqNbjIcW1iJJtUAydJEpbMliCCDN1bDMXT
         qcr6OqlA8anr7QKd0gpZ1jpwAfGqWDtHryoXzmRnDfPq2BPivV3HFnWb8/EFC9jjUsdA
         PYoAgkzklrMIWkIK00O37k2tlcRpM/ukv0VuH/eNoIEZ0ya/v+3L5b+HS/ixsTJocbbn
         tD4g==
X-Forwarded-Encrypted: i=1; AJvYcCWoyL7iaB2YeHQ+4zY7HrgWpOMjedCmNt4/Md4MeuY1uZ5IOA5CPVEq9VeHA/YXQH2FN0VrMvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCxldhX1h9KFuuZ1O9EYqPRmstL2kfJllX13e3WKWcQJG95Lc
	9QeNBTrCPsakEzNjanTgp55UDo0HV7Nm/MmqQwaEdPW6E2kxGT8XcKokoXFWSQQ=
X-Gm-Gg: ASbGnctV2NJx3niWa+SOyESZiLsos2+5I8pUO+dMkOCzNx4OyhLnEsjTIAZK/ZctW9f
	LdighSVMGxaoGwcIHbnJP+S2DxDZ4Y61WOcPZ9ytVPjekuUchAbLXGtSypsPDNdg/bQEwbMnToX
	m1zqrUPODHqHuzgVHFaThlzI4hcSS6NZsuVLqj1XXHBUjeH9nNgYsgHVse45gUp6lxGaB5vAbZi
	D9q/Nf8ge8mtHvwIzENdLT6KzXhsnsg5Eu/g0v2uAzLBd5jSTCcGpMk7OJcKRTAtU0+BcTtGCW5
	JpyfeuBe/Gm+dPeel1CMUDFPNchmpDoLl7JNjzHBzFNDPWXEpQX2MFUfJRt9vEA9
X-Google-Smtp-Source: AGHT+IHD+SRTmABVqVo915a+g39VuB63ibZY/m2RvcCVEk94m1sJpjFNQCXB+GTHQk9WzMW5eF+0Hg==
X-Received: by 2002:a05:620a:1706:b0:7c0:aaf7:76d9 with SMTP id af79cd13be357-7c23be12855mr893736385a.24.1740593332379;
        Wed, 26 Feb 2025 10:08:52 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c339e0dsm276446285a.91.2025.02.26.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:08:52 -0800 (PST)
Date: Wed, 26 Feb 2025 13:08:49 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z79YseiGrzYxoyvr@LQ3V64L9R2>
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

Sorry, I missed more paths:

    - virtnet_rx_resume
    - virtnet_tx_pause and virtnet_tx_resume

which are similar to path you mentioned (virtnet_rx_pause) and need
rtnl in one of two different paths.

Let me know if I missed any paths and what your preferred way to fix
this would be?

I think both options below are possible and I have no strong
preference.

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
> 
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

