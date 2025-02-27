Return-Path: <netdev+bounces-170100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5AA47444
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E848A3AAF41
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087511D90DB;
	Thu, 27 Feb 2025 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+LwwiZN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071E1E835B
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629930; cv=none; b=kuSTJDvGrujSteq+o9SFYSSAzQ1gPMxhe45+AteLgAhLmJzjxv6HOHRXZ1QB6ECfrrdc6iO6I2Ps2F7Ia7DOdTp9Agz9drHbZoAxvCKH6a44Z3rso4ymVGPJniQNk4LDhol9w8/7HtNzD0jCW+bncaVTAz9pXPhR4GlSIYrunXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629930; c=relaxed/simple;
	bh=1VVOB+5HIZbTuri2DD6/2MWlh5ARSLCqhqwCGD9JXTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XntglxaB1WCQRGQrOlqG//p1NO6kVsd/PQLqX11fWGZpP0xaIlbVlmh+Th/FgD2w/AHngf2+qr9odrG2qbJ22q0chzuYGNKVaovmLL7iAXy1l9q2tm9ooQCzReNZCSZSGgg+r7/S5niYyeI9cd4C0NF9lI2XOnI6FzzHY9phk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+LwwiZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740629927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZ0UDIL0wZfdL22hiRtuwOr2shEsAIgobx1O4hYXA98=;
	b=K+LwwiZNGhYFTjoKn24zCjKBmBoNDlFNPvTMJjLE/xl3sahq+l+ekrRkQ4Bo2Bwt5FPMhF
	UHFpZF9ev1rYi+wMI6nnwpTvi/81gLC0BW6NjDB58zD0dDxNSAbA691TU0mJsdb7S0PNYx
	iCRZHRgjUhqyrVusA+c2ouRNXOlFhj8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-BLlaC1lOP3yVEIuaIhfArA-1; Wed, 26 Feb 2025 23:18:46 -0500
X-MC-Unique: BLlaC1lOP3yVEIuaIhfArA-1
X-Mimecast-MFC-AGG-ID: BLlaC1lOP3yVEIuaIhfArA_1740629925
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc4fc93262so1168143a91.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629925; x=1741234725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ0UDIL0wZfdL22hiRtuwOr2shEsAIgobx1O4hYXA98=;
        b=dRRhbUzc5aQI+i2hmfbpiJ5FFRtXbK2YABDrbHURTfvG/UwtSJwosrTQ1kaoZZbs9X
         Ow98hGoQ805wIgw0QPvemNkAMoNjrWRyakPkiDXbrRoGnk4DkitX8hWdQsZnZw6wQWzq
         Es/D8ymM4dpdtYaCZNhhlvj1B/RRMo8AYH1r2svSmYbI+vnPPU74Ff/+jIACFeLsOYbT
         OGpTXNcv3zi++BlxbbtZ8Ny6O7rTv8z/V/M8GSegAZEiz34iubczOI5WL2YnRa8/LUCS
         JY+yphpyA+5ytovhNml6EUvQYgzFowvDEv4/vQhi+wSj1aqo6qdk5wqVdsdA6FrJJqFs
         QZpA==
X-Forwarded-Encrypted: i=1; AJvYcCX95rEYBfDbo7UPbyNvjCGWX7IvX1blofCEKp574XtZlakBAKS8QwY+C24Nf8TyPatrUk2aDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbL0V1BfG7a16CksnrQYA3o4iepsNKAmGnHORyqj73vUyNDNzl
	ogR2n82qPOp01QKEd9DMIvj2I4VZ4bznx4mKKv02+YIyuc5AszbVdw1QVchUTtemqDccbqe10mM
	t2Q1xOwIHwKCFQofNxEt61FHuAUhsqIlNKWB5youZbXTCeegUNnEDx+W7Ww2UzBm9FcbyKRmwen
	dB7AVEHXXKAn6ANYmb9in9W7ljCiuv
X-Gm-Gg: ASbGncvQWZOTjnLk5oAZsDxPywyAJ92iyGJURuB5gIZSRhNHPeBSQi0EwkY2Ek9gb5k
	YBP6nkIzDH2ruf3OlwExBQk9s4MwKHJ/4pVaU6ASwKgwbnM6d27WQygiYf/7v8C2U6bBa5uhHuA
	==
X-Received: by 2002:a17:90b:2411:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-2fea5454d1emr1541117a91.34.1740629925130;
        Wed, 26 Feb 2025 20:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpxoLlIbPBR1z+e3dptMbf0F6aseLOY6nkspSv1OJx3k/0gEXTNw6rvyxRnzs6DHRWsHIlvDdDlJHnaeA+Gzg=
X-Received: by 2002:a17:90b:2411:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-2fea5454d1emr1541087a91.34.1740629924715; Wed, 26 Feb 2025
 20:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2> <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2> <20250226171252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250226171252-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Feb 2025 12:18:33 +0800
X-Gm-Features: AQ5f1JrcgH-RY0XhWOvBxo3ebVPfT8pD_akPl5SaLe6th0YudFAaLBbFw06vL8o
Message-ID: <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:13=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > > On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fast=
ly.com> wrote:
> > > > > >
> > > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the =
mapping
> > > > > > can be accessed by user apps, taking care to hold RTNL as neede=
d.
> > > > >
> > > > > I may miss something but I wonder whether letting the caller hold=
 the
> > > > > lock is better.
> > > >
> > > > Hmm...
> > > >
> > > > Double checking all the paths over again, here's what I see:
> > > >   - refill_work, delayed work that needs RTNL so this change seems
> > > >     right?
> > > >
> > > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > > >     virtnet_close. When called via NDO these are safe and hold RTNL=
,
> > > >     but they can be called from power management and need RTNL.
> > > >
> > > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > > >     used via NDO but needs RTNL when used via power management.
> > > >
> > > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > > >     which needs RTNL and one which doesn't.
> > >
> > > Sorry, I missed more paths:
> > >
> > >     - virtnet_rx_resume
> > >     - virtnet_tx_pause and virtnet_tx_resume
> > >
> > > which are similar to path you mentioned (virtnet_rx_pause) and need
> > > rtnl in one of two different paths.
> > >
> > > Let me know if I missed any paths and what your preferred way to fix
> > > this would be?
> > >
> > > I think both options below are possible and I have no strong
> > > preference.
> >
> > OK, my apologies. I read your message and the code wrong. Sorry for
> > the back-to-back emails from me.
> >
> > Please ignore my message above... I think after re-reading the code,
> > here's where I've arrived:
> >
> >   - refill_work needs to hold RTNL (as in the existing patch)
> >
> >   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
> >     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
> >     already held in the ethtool resize path and the XSK path, as you
> >     explained, but I mis-read (sorry).
> >
> >   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
> >     need to hold RTNL only when called via power management, but not
> >     when called via ndo_open or ndo_close
> >
> > Is my understanding correct and does it match your understanding?
> >
> > If so, that means there are two issues:
> >
> >   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
> >      tx_resume (all should be false, RTNL is not needed).
> >
> >   2. Handling the power management case which calls virtnet_open and
> >      virtnet_close.
> >
> > I made a small diff included below as an example of a possible
> > solution:
> >
> >   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
> >      to take a "bool need_rtnl" and pass it through to the helpers
> >      they call.
> >
> >   2. Create two helpers, virtnet_do_open and virt_do_close both of
> >      which take struct net_device *dev, bool need_rtnl. virtnet_open
> >      and virtnet_close are modified to call the helpers and pass
> >      false for need_rtnl. The power management paths call the
> >      helpers and pass true for need_rtnl. (fixes issue 2 above)
> >
> >   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
> >      pass false since all paths that I could find that lead to these
> >      functions hold RTNL. (fixes issue 1 above)
> >
> > See the diff below (which can be applied on top of patch 3) to see
> > what it looks like.
> >
> > If you are OK with this approach, I will send a v5 where patch 3
> > includes the changes shown in this diff.
> >
> > Please let me know what you think:
>
>
>
> Looks ok I think.
>
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 13bb4a563073..76ecb8f3ce9a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *nap=
i, int budget)
> >       return received;
> >  }
> >
> > -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> > +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index,
> > +                                    bool need_rtnl)
> >  {
> > -     virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > -     virtnet_napi_disable(&vi->rq[qp_index], false);
> > +     virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> > +     virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
> >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
> > +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex,
> > +                                  bool need_rtnl)
> >  {
> >       struct net_device *dev =3D vi->dev;
> >       int err;
> > @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtn=
et_info *vi, int qp_index)
> >       if (err < 0)
> >               goto err_xdp_reg_mem_model;
> >
> > -     virtnet_napi_enable(&vi->rq[qp_index], false);
> > -     virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > +     virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> > +     virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
> >
> >       return 0;
> >
> > @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtne=
t_info *vi)
> >               vi->duplex =3D duplex;
> >  }
> >
> > -static int virtnet_open(struct net_device *dev)
> > +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> >       int i, err;
> > @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
> >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> >                               schedule_delayed_work(&vi->refill, 0);
> >
> > -             err =3D virtnet_enable_queue_pair(vi, i);
> > +             err =3D virtnet_enable_queue_pair(vi, i, need_rtnl);
> >               if (err < 0)
> >                       goto err_enable_qp;
> >       }
> > @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
> >       cancel_delayed_work_sync(&vi->refill);
> >
> >       for (i--; i >=3D 0; i--) {
> > -             virtnet_disable_queue_pair(vi, i);
> > +             virtnet_disable_queue_pair(vi, i, need_rtnl);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> >       return err;
> >  }
> >
> > +static int virtnet_open(struct net_device *dev)
> > +{
> > +     return virtnet_do_open(dev, false);
> > +}
> > +
> >  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> >  {
> >       struct send_queue *sq =3D container_of(napi, struct send_queue, n=
api);
> > @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
> >       bool running =3D netif_running(vi->dev);
> >
> >       if (running) {
> > -             virtnet_napi_disable(rq, true);
> > +             virtnet_napi_disable(rq, false);
> >               virtnet_cancel_dim(vi, &rq->dim);
> >       }
> >  }
> > @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info=
 *vi, struct receive_queue *rq)
> >               schedule_delayed_work(&vi->refill, 0);
> >
> >       if (running)
> > -             virtnet_napi_enable(rq, true);
> > +             virtnet_napi_enable(rq, false);
> >  }
> >
> >  static int virtnet_rx_resize(struct virtnet_info *vi,
> > @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info =
*vi, struct send_queue *sq)
> >       qindex =3D sq - vi->sq;
> >
> >       if (running)
> > -             virtnet_napi_tx_disable(sq, true);
> > +             virtnet_napi_tx_disable(sq, false);
> >
> >       txq =3D netdev_get_tx_queue(vi->dev, qindex);
> >
> > @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info=
 *vi, struct send_queue *sq)
> >       __netif_tx_unlock_bh(txq);
> >
> >       if (running)
> > -             virtnet_napi_tx_enable(sq, true);
> > +             virtnet_napi_tx_enable(sq, false);

Instead of this, it looks to me it would be much simpler if we can
just hold the rtnl lock in freeze/restore.

Thanks


