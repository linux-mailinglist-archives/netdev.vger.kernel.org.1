Return-Path: <netdev+bounces-170109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7360A474DE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC20916B8C7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3466E1D89FA;
	Thu, 27 Feb 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="daEsRvgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6063C38
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631689; cv=none; b=Hybx8pbBdJEaQHL71SU1FIqdcDtc7UEEj3kWRyO8DrPWx8z+3DKanWzEYcjUaX2B0NYRhB3OqwBU8fffwOIA7LIm1pgw7Z6lf2P9worDf21fgt5U2L6pZBaNBw0WMCT2JDm4s7KGKYZ+qe1VZxHzfxBBBPyOJQU5Nu2sn+OIxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631689; c=relaxed/simple;
	bh=Dz5CLJbJtxhty0xg8roq/GxXUaSa9CenQ02zc3yTaa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJoz0cAFdnixKR7llikX9EXUzl5A2vdQ8QybGwyYBYbOIb7K0CnlBj9CoYa76jQQwOX5EDgv/Gw7PfGhyGXbQLPXQ1+o/yaFm3rqP53OmNvL0rNwBcwZNx3lkMDMOXqt9MEz8igDi2mTpawI464QxxcIVfl9hTBbUU64yJr0a1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=daEsRvgc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472003f8c47so5520641cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740631685; x=1741236485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9RrWBQnGmr7pfCKfDKI3Or5JbQRE5y4Ygu5ENY7AJw=;
        b=daEsRvgcoYYCEMrJEdGNv1L2iPUswcd8MuchKmHWiGo77AukfOWpM3zn76hYBsn75p
         vSYeu3jT0Z0w0j56n3L1k5GplIb4WQpXsXQ7zPLMtXAid+N+Q41Fd0fUMQqSVPcjmQbj
         ax3mR/XFjPjXsndmfR8qfgjIzrFmrrrVM0EuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631685; x=1741236485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9RrWBQnGmr7pfCKfDKI3Or5JbQRE5y4Ygu5ENY7AJw=;
        b=KTXtuwGCO0naCd1viKY5BpMnvFkS+3EAyG607jaQNjEpcbOboGZDS91zXS1C4uJqgW
         o8Vy3cpXPgP8zj1spoyLvFE+GvIxKNzbN7D3RtH5CZOAr2ey2+Cun9xLBMqE9Bt+Mr1P
         cggWjdQi3YAA0HmoEyQJgYzggEmCmWAwrTgZjwxxVIPlTj96j2gsbldmAZWKv8mFYnEX
         ExbRaA6Y96KqufZwdgsM9kT9aTiHD4zLjY3W0H7kj1ItRwCZuHAWyfnqU6OWWBWf2Ooy
         qRYPWR6hGDycsFBD5pKdqXKivneQYQyrt6Q4fVeK5XliWWbuB++oNgw+Dsqk5mPXTRXT
         fAyw==
X-Forwarded-Encrypted: i=1; AJvYcCXPZatfj7OMP0s93BFkTGwJjzxR5qLPLvl45DwQQQclDxzsYxW/hDBUHDBg5itSTLUNks7rBSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q6fG840fMCuckpBErsluC/X0Qb4ybWZjLPZ8zIMefKhhkX2d
	3KE79sJHXRjqVtpyNNNarDhssAs4DuGSUaKqFH8dkLpL2QKoQDLoorpFCxkwpvk=
X-Gm-Gg: ASbGnctdQVWAWt3Og+QVLQ1ZuEabH4UzKpUG0bN+zkIZA+4bg2RcWsC6QSRNlxNbTNK
	mIS+9Mmm/GIS/70gDnYUA4cmtxID+YdWPZz6mkWKLcBLWX9mvt4KAGispc5nDPcQqppJTV0fU3b
	ZZk2yER70iR9DeK3qtiUg0EJ1bY+wxk+GNN2Z+74/kdCjJN8Pmhbj0KG7+ETNky9rZdrrCc4wzp
	qZTYTz+mj6GrRnn37vIQngDTrfojYm5T/SY/LDVPRSC7ftKrXo1N1RyxT/dNeaTrZ8xQb+B2KVc
	rzF5QOJNw2pMZClmGbo5jCtvL1TV+aPpUjohA6mxfgDd9KztyZB7S73qWcFpuskW
X-Google-Smtp-Source: AGHT+IG6AMaCEtuGDNAymqPMHPgx7iO0OQVDvaKjbVaa0iyhzZP9jJJbU8LowBwmScd9NGrAxjr9OQ==
X-Received: by 2002:a05:622a:1187:b0:46f:d6c3:2ddc with SMTP id d75a77b69052e-473d8f7f11emr31340551cf.1.1740631685293;
        Wed, 26 Feb 2025 20:48:05 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409ac2sm6469901cf.58.2025.02.26.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:48:04 -0800 (PST)
Date: Wed, 26 Feb 2025 23:48:01 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z7_ugUyyE1WPV_bb@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
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
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
 <20250226171252-mutt-send-email-mst@kernel.org>
 <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>

On Thu, Feb 27, 2025 at 12:18:33PM +0800, Jason Wang wrote:
> On Thu, Feb 27, 2025 at 6:13 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > > > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > > >
> > > > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > > > >
> > > > > > I may miss something but I wonder whether letting the caller hold the
> > > > > > lock is better.
> > > > >
> > > > > Hmm...
> > > > >
> > > > > Double checking all the paths over again, here's what I see:
> > > > >   - refill_work, delayed work that needs RTNL so this change seems
> > > > >     right?
> > > > >
> > > > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > > > >     virtnet_close. When called via NDO these are safe and hold RTNL,
> > > > >     but they can be called from power management and need RTNL.
> > > > >
> > > > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > > > >     used via NDO but needs RTNL when used via power management.
> > > > >
> > > > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > > > >     which needs RTNL and one which doesn't.
> > > >
> > > > Sorry, I missed more paths:
> > > >
> > > >     - virtnet_rx_resume
> > > >     - virtnet_tx_pause and virtnet_tx_resume
> > > >
> > > > which are similar to path you mentioned (virtnet_rx_pause) and need
> > > > rtnl in one of two different paths.
> > > >
> > > > Let me know if I missed any paths and what your preferred way to fix
> > > > this would be?
> > > >
> > > > I think both options below are possible and I have no strong
> > > > preference.
> > >
> > > OK, my apologies. I read your message and the code wrong. Sorry for
> > > the back-to-back emails from me.
> > >
> > > Please ignore my message above... I think after re-reading the code,
> > > here's where I've arrived:
> > >
> > >   - refill_work needs to hold RTNL (as in the existing patch)
> > >
> > >   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
> > >     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
> > >     already held in the ethtool resize path and the XSK path, as you
> > >     explained, but I mis-read (sorry).
> > >
> > >   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
> > >     need to hold RTNL only when called via power management, but not
> > >     when called via ndo_open or ndo_close
> > >
> > > Is my understanding correct and does it match your understanding?
> > >
> > > If so, that means there are two issues:
> > >
> > >   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
> > >      tx_resume (all should be false, RTNL is not needed).
> > >
> > >   2. Handling the power management case which calls virtnet_open and
> > >      virtnet_close.
> > >
> > > I made a small diff included below as an example of a possible
> > > solution:
> > >
> > >   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
> > >      to take a "bool need_rtnl" and pass it through to the helpers
> > >      they call.
> > >
> > >   2. Create two helpers, virtnet_do_open and virt_do_close both of
> > >      which take struct net_device *dev, bool need_rtnl. virtnet_open
> > >      and virtnet_close are modified to call the helpers and pass
> > >      false for need_rtnl. The power management paths call the
> > >      helpers and pass true for need_rtnl. (fixes issue 2 above)
> > >
> > >   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
> > >      pass false since all paths that I could find that lead to these
> > >      functions hold RTNL. (fixes issue 1 above)
> > >
> > > See the diff below (which can be applied on top of patch 3) to see
> > > what it looks like.
> > >
> > > If you are OK with this approach, I will send a v5 where patch 3
> > > includes the changes shown in this diff.
> > >
> > > Please let me know what you think:
> >
> >
> >
> > Looks ok I think.
> >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 13bb4a563073..76ecb8f3ce9a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >       return received;
> > >  }
> > >
> > > -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
> > > +                                    bool need_rtnl)
> > >  {
> > > -     virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > > -     virtnet_napi_disable(&vi->rq[qp_index], false);
> > > +     virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> > > +     virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
> > >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> > >  }
> > >
> > > -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
> > > +                                  bool need_rtnl)
> > >  {
> > >       struct net_device *dev = vi->dev;
> > >       int err;
> > > @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >       if (err < 0)
> > >               goto err_xdp_reg_mem_model;
> > >
> > > -     virtnet_napi_enable(&vi->rq[qp_index], false);
> > > -     virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > > +     virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> > > +     virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
> > >
> > >       return 0;
> > >
> > > @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
> > >               vi->duplex = duplex;
> > >  }
> > >
> > > -static int virtnet_open(struct net_device *dev)
> > > +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i, err;
> > > @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
> > >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > >                               schedule_delayed_work(&vi->refill, 0);
> > >
> > > -             err = virtnet_enable_queue_pair(vi, i);
> > > +             err = virtnet_enable_queue_pair(vi, i, need_rtnl);
> > >               if (err < 0)
> > >                       goto err_enable_qp;
> > >       }
> > > @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
> > >       cancel_delayed_work_sync(&vi->refill);
> > >
> > >       for (i--; i >= 0; i--) {
> > > -             virtnet_disable_queue_pair(vi, i);
> > > +             virtnet_disable_queue_pair(vi, i, need_rtnl);
> > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > >       }
> > >
> > >       return err;
> > >  }
> > >
> > > +static int virtnet_open(struct net_device *dev)
> > > +{
> > > +     return virtnet_do_open(dev, false);
> > > +}
> > > +
> > >  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> > >  {
> > >       struct send_queue *sq = container_of(napi, struct send_queue, napi);
> > > @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > >       bool running = netif_running(vi->dev);
> > >
> > >       if (running) {
> > > -             virtnet_napi_disable(rq, true);
> > > +             virtnet_napi_disable(rq, false);
> > >               virtnet_cancel_dim(vi, &rq->dim);
> > >       }
> > >  }
> > > @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> > >               schedule_delayed_work(&vi->refill, 0);
> > >
> > >       if (running)
> > > -             virtnet_napi_enable(rq, true);
> > > +             virtnet_napi_enable(rq, false);
> > >  }
> > >
> > >  static int virtnet_rx_resize(struct virtnet_info *vi,
> > > @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
> > >       qindex = sq - vi->sq;
> > >
> > >       if (running)
> > > -             virtnet_napi_tx_disable(sq, true);
> > > +             virtnet_napi_tx_disable(sq, false);
> > >
> > >       txq = netdev_get_tx_queue(vi->dev, qindex);
> > >
> > > @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
> > >       __netif_tx_unlock_bh(txq);
> > >
> > >       if (running)
> > > -             virtnet_napi_tx_enable(sq, true);
> > > +             virtnet_napi_tx_enable(sq, false);
> 
> Instead of this, it looks to me it would be much simpler if we can
> just hold the rtnl lock in freeze/restore.

I disagree.

Holding RTNL for all of open and close instead of just the 1 API
call that needs it has the possibility of introducing other lock
ordering bugs now or in the future.

We only need RTNL for 1 API, why hold it for all of open or close?

