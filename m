Return-Path: <netdev+bounces-93604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7748BC633
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 05:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B0AB2134F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095A43AB2;
	Mon,  6 May 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXJq8JDl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEA3F9EC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965884; cv=none; b=f4GcouinwNGHcMg0H86YLAaXnmInO/TIrxbPQxYVA1m1qOWxDhSznUog21jumJtFjCxSG7ICuirMlf7m1lXOUAClVz6ivuql8qDf0eWirjxn9OZnWFfHFxrz3zIl4bxJnhqTV9JeYYhYpcUuJmHKxM8LuVZ/YQmCJUngrDyhSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965884; c=relaxed/simple;
	bh=bBHRYR+zXOeAjZ6EPCrBlhNWwq4VARwBFLo2xTUGLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJx/qwhaAHXvHiKQcKneakJYPBX9+9DJzGiAckNOOdfdSs3e7GpnDy2QfHaxP0FsPfoUo11AoHuvNjsBAYJlpzqfB0sdIwRb8YMXq+go2q4TADuPMLtVeS7a5/snR5qYHGaIV8FDh9e+Kb9hna7iDicz/Hc7jeEqIeEH+yGPN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXJq8JDl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714965880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
	b=WXJq8JDlWzX2RreasT/YGBM98hdl/Ps6Nslp+qsHicoB3wDUpJVbd28NgUA3uM2svU9kWM
	1bF5ZbqLs7sMebBejVEygyQYgHl/StRkfX0QWPz0Vz4ndVVRF/XohxGAqpAuFGakyU3aHD
	wlbKwPhLpS6D+aU4vQdMHqkdfAz/pUs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ROIDwoKZPy-21w1yXlEGwg-1; Sun, 05 May 2024 23:24:38 -0400
X-MC-Unique: ROIDwoKZPy-21w1yXlEGwg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-618a2b1a441so2782016a12.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 20:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714965878; x=1715570678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
        b=TL+408XpIGTLYdv0frUnEIEj9MrUpmjV/OEi/pHNtaO8YwEE3nGP1jHqfwPtZlghXX
         /UaASKZkXRZuK3UTmOoaazy/OT3XSma4jWXbaBhJCArGKIhmkUSgJ7QyotObJhLcbcyR
         jM7Exu7cpo3g0pPacBk1TGeiyYe4NKbyH0PF0uZxkz278vAVQYfZSWvOyluTMnepvblO
         PQqyBYg1fStXYa2w8SzyLnfJc/IN1VXzo2pu1StzXPuAMvbPtUzmsp8jXUHja4wVBjfe
         W1nezL84FYnl7sZHBiT8SJXnR/8NjmCtE3Do+SP3JCpzsRDfJURvT2+eqYPkgnf4Zf1h
         bqUg==
X-Forwarded-Encrypted: i=1; AJvYcCUFy74ijmZGrqDryC0TwgLJ3OSFjelqYg7hD9NGKUyBqTPwpGn3p5HjCda7cPP4MXrVh4KtioXptEzTtE8FTqYeanxbidhr
X-Gm-Message-State: AOJu0YzZUWTGqnNMNVSFbFnSw18gKAa9D2Pu8JxyilJJSlgokIcqoHQU
	9sRnt7yF8VvIaNa3Uuc0lLvyxMkhToblwMw1enMp+Zocdh1NnfWyEFlrlo0PmYqRjtCCUkN+W87
	wzlt9UXJV0TiZFKuZw3KdbAHWt/BWPxhP8uU9JfdlgLxS8iSp/HTV6Hlx+Rm6NAtpNwveqOBHqw
	pUg27h771PXE9nIgUTfMM6VG3KEeLR
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id nm12-20020a17090b19cc00b002b20da72c83mr12511969pjb.4.1714965877813;
        Sun, 05 May 2024 20:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgR09huJq7794Kr7Va7gw9HzoZRK/fRVHd00z788cM7NjAkL3DywsEKb+A/xOZDmoDbwkRNX9xodgt7fyblY=
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id
 nm12-20020a17090b19cc00b002b20da72c83mr12511949pjb.4.1714965877400; Sun, 05
 May 2024 20:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjFH7Xb5gyTtOpWd@localhost.localdomain> <20240430121730-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240430121730-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 May 2024 11:24:25 +0800
Message-ID: <CACGkMEsFMXdswxgguH1P_TkY9wnKgE8RbhUdw_Pd+niSp2UjSg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Warn if insufficient queue length for transmitting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Darius Rad <darius@bluespec.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Apr 30, 2024 at 03:35:09PM -0400, Darius Rad wrote:
> > The transmit queue is stopped when the number of free queue entries is =
less
> > than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_=
MAX)
> > is less than then this, transmission will immediately trigger a netdev
> > watchdog timeout.  Report this condition earlier and more directly.
> >
> > Signed-off-by: Darius Rad <darius@bluespec.com>
> > ---
> >  drivers/net/virtio_net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 115c3c5414f2..72ee8473b61c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> >       vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +     if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
> > +             netdev_warn_once(dev, "not enough queue entries, expect x=
mit timeout\n");
> > +
>
> How about actually fixing it though? E.g. by linearizing...

Actually, the linearing is only needed for the case when the indirect
descriptor is not supported.

>
> It also bothers me that there's practically
> /proc/sys/net/core/max_skb_frags
> and if that's low then things could actually work.

Probably not as it won't exceed MAX_SKB_FRAGS.

>
> Finally, while originally it was just 17 typically, now it's
> configurable. So it's possible that you change the config to make big
> tcp

Note that virtio-net doesn't fully support big TCP.

> work better and device stops working while it worked fine
> previously.

For this patch, I guess not as we had:

        if (sq->vq->num_free < 2+MAX_SKB_FRAGS)

in the tx path. So it won't even work before this patch.

Thanks

>
>
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.39.2
>


