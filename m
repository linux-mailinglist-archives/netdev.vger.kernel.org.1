Return-Path: <netdev+bounces-167556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB20A3AD15
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772F63AEC0D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5DF12B71;
	Wed, 19 Feb 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJgOmtPr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C071819
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925094; cv=none; b=X9aq/iFJzy4YPHQtXd++0wNuEB7/Bc0j+UyAg1JhBm3NXCJY/PUn2nFJqFytPNFv/GN/J5rHjtkO5FobH3vldKzyalnaFDCN9VbKVsKnxinvusMmyuBWPynRqtI7NedtLLrfb5iranUD58HcmQ38itf/KLg/HAxUQy0Gc+GsT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925094; c=relaxed/simple;
	bh=Na0GNiLT4L4zLHxrtoE/rvr4Nade4nh6Grlkymh5FJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeB7Ee89uUs01XTzo5QdHRAeCZLDuw0LM4MWSeALzKhV2lj7rOM7Ym+qDwUe+oLPaijKlPiN1ykoVxWCMYx48LiklPOI5hmh+pUj69KxjxOplcmBuraqCxIceVVy8PfM6m6NQVvQ0xhhrGVHAWCIRlKec5DcqupyUTXcEqhvsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJgOmtPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739925091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAmwz/TJol3C4T2p6erXBkDQSw4VvEw2r6fPlWa4qmk=;
	b=EJgOmtPrtnKiajRCZ7cYKceX5D+vv5uKLbB8DRnfr1QgQV2cuLo8GXpCmXIFZafHsQdqvH
	NtlcpijrkFAflwEWUE4nHXRG2LB+iZihZFn6sn9jfQx0BRIIzVJKLWPj6JlmwmjjcinpSN
	AVRW5PI6ig6AGTgMDb4iJcu+gr53qvk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-reOY1gbRMqmVTFjqYBQYzg-1; Tue, 18 Feb 2025 19:31:29 -0500
X-MC-Unique: reOY1gbRMqmVTFjqYBQYzg-1
X-Mimecast-MFC-AGG-ID: reOY1gbRMqmVTFjqYBQYzg_1739925088
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so10788078a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739925088; x=1740529888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAmwz/TJol3C4T2p6erXBkDQSw4VvEw2r6fPlWa4qmk=;
        b=MyPhaDVCnVnvJmjEJsa0gqBO738z5KASGkt2q+wJxeAJhswp8tt1KcQpboznF/4HG9
         sxx5ns+O5HLWY2jgu/jkFdv+tsAsV2URkSIQm2MjIvSDCZh6+V/14LjzaxaYMQrdDO0P
         qDQesVNg4B2qxNax+PDtu6bcDwmp+RvhUqayexWoYjKlWuVj1PguIKsEdJ+dqC/JR65P
         NFR5c6RxLmc+Rw3fAwpxDG9+peBJDgr2wZG/slynENU9GZdBaeYG30vPknU0RRY+NQM1
         lEO6wY0VY9t44TYJGTW49gmftHuP7hibcC0w44BFqxOzbK6Jk0h0nfOQ1O41xG056MQD
         NsBg==
X-Forwarded-Encrypted: i=1; AJvYcCWqr07CvQ38QJDU31aVMH7ksJxN7HM8K+JYCscvUSQCiphHTeDDWAt4hOZvoEKVfn6axH0Kbgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIxeCLoxTdpM/GOhrKe4kXY5Cob7CYihTVIvT0aKtk2kZ4Ksp
	Wd4BeQdsgMNOVtjyCC+8efglTvIIxbpdwwiNpJPIpDIx7FaQmISifG4wfJ6wxPhi92F92ir5Nev
	acQBwiJB19YeIgDB0Pf9Pv3e+mEPnZ+Xass83FCwxoQsRyGlE7AlIKiO5GLSPSB8VMsHF9fcqfB
	5WzQCjmLiIDKmsRC+nj2+fZ4L2QfKh
X-Gm-Gg: ASbGncuOf0rDmy3VB9c3DXJo6Nq1HZ9HZ+zsxrnN/kLZAHFMEDXiKnaF5Hcsla8yGrk
	zRJ5jr5tymQnxWBbzZGHcTJv4NWTQdUmhUj6/OBg2a5egdhTYfnHIdPlPVu3D/mA=
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id 98e67ed59e1d1-2fc40f22d67mr28344806a91.18.1739925088335;
        Tue, 18 Feb 2025 16:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN+NiCiTEw2BOo1eSpKQjrIpmFz6sGzkC9hWo0e38VXbikFKkp+S2HXR9/BCBMga/6/gY/Qx+e/Anbnv7VRik=
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2fc40f22d67mr28344773a91.18.1739925087954; Tue, 18 Feb 2025
 16:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <20250218034919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250218034919-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Feb 2025 08:31:16 +0800
X-Gm-Features: AWEUYZmcRGjFhBQePkw-Og0LRELmpBWQ_jYA7oPxy5AXeKWPLYOKXF4KpjxgiY4
Message-ID: <CACGkMEu5UtkDvVuNd5fxsbVSOtqzNE92R6SzjsREaLFTJ8=NUA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > So this patch tries to avoid those issues by not cleaning transmitted
> > packets in start_xmit() when TX NAPI is enabled and disable
> > notifications even more aggressively. Notification will be since the
> > beginning of the start_xmit(). But we can't enable delayed
> > notification after TX is stopped as we will lose the
> > notifications. Instead, the delayed notification needs is enabled
> > after the virtqueue is kicked for best performance.
> >
> > Performance numbers:
> >
> > 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
> >    (burst 256) + testpmd (rxonly) on the host:
> >
> > - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
> >   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
> >   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
> >   10.7 Mpps, 99% TX interrupts were eliminated.
> >
> > - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
> >   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
> >   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
> >   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> >
> > 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
> >    session netperf from guest to host shows 82% improvement from
> >    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
> >    of TX interrupts were eliminated.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> can you pls also test perf with tx irq disabled mode, to be sure?

Yes, performance doesn't change in orphan mode (both PPS and throughput).

This matches the patch that doesn't not change any logic for orphan mode.

Thanks

>
> > ---
> >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..ac26a6201c44 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virt=
net_info *vi, int q)
> >               return false;
> >  }
> >
> > -static void check_sq_full_and_disable(struct virtnet_info *vi,
> > -                                   struct net_device *dev,
> > -                                   struct send_queue *sq)
> > +static bool tx_may_stop(struct virtnet_info *vi,
> > +                     struct net_device *dev,
> > +                     struct send_queue *sq)
> >  {
> > -     bool use_napi =3D sq->napi.weight;
> >       int qnum;
> >
> >       qnum =3D sq - vi->sq;
> > @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >               u64_stats_update_begin(&sq->stats.syncp);
> >               u64_stats_inc(&sq->stats.stop);
> >               u64_stats_update_end(&sq->stats.syncp);
> > +
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void check_sq_full_and_disable(struct virtnet_info *vi,
> > +                                   struct net_device *dev,
> > +                                   struct send_queue *sq)
> > +{
> > +     bool use_napi =3D sq->napi.weight;
> > +     int qnum;
> > +
> > +     qnum =3D sq - vi->sq;
> > +
> > +     if (tx_may_stop(vi, dev, sq)) {
> > +             struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnu=
m);
> > +
> >               if (use_napi) {
> >                       if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> >                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> > @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> >       bool use_napi =3D sq->napi.weight;
> >       bool kick;
> >
> > -     /* Free up any pending old buffers before queueing new ones. */
> > -     do {
> > -             if (use_napi)
> > -                     virtqueue_disable_cb(sq->vq);
> > -
> > +     if (!use_napi)
> >               free_old_xmit(sq, txq, false);
> > -
> > -     } while (use_napi && !xmit_more &&
> > -            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > +     else
> > +             virtqueue_disable_cb(sq->vq);
> >
> >       /* timestamp packet in software */
> >       skb_tx_timestamp(skb);
> > @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
> >               nf_reset_ct(skb);
> >       }
> >
> > -     check_sq_full_and_disable(vi, dev, sq);
> > +     if (use_napi)
> > +             tx_may_stop(vi, dev, sq);
> > +     else
> > +             check_sq_full_and_disable(vi, dev,sq);
> >
> >       kick =3D use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_mo=
re) :
> >                         !xmit_more || netif_xmit_stopped(txq);
> > @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >               }
> >       }
> >
> > +     if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq-=
>vq)))
> > +             virtqueue_napi_schedule(&sq->napi, sq->vq);
> > +
> >       return NETDEV_TX_OK;
> >  }
> >
> > --
> > 2.34.1
>


