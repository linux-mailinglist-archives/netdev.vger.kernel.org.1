Return-Path: <netdev+bounces-110476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BE92C8DC
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCAD1F23B81
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D933A8E4;
	Wed, 10 Jul 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="int8JCc/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE639863
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580642; cv=none; b=Ttt+Hl8J+aLEJdBExI89bXl1LINAONsBk+uuYxkLioo5PXtWj15xEgUPqkBGNxtsmQVkQLLN+d7kDOA/n7JU905swGO4aI1n0AIy8po/N2yaCXXYRALAe7kMBbyBByW2D+aJBrRIF5qP8/HfRPGJxJTBpD78NULt+1M83riaX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580642; c=relaxed/simple;
	bh=XA3jDlwSixNEAdzZAZ0lj2ZmgEHMHAtJJdsdEdSgD6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffaAGJ2EbpsMTvmwbau2j/gyhAaSBkrVmYmpgOheTy3LY2fAF7ix5MV5eFGGTNJbxG4ddrM1XBJzq9n8qxsPP8HvMZ/3gC6Uc4TgvRsHpF8c5IGxBJBbKo8RXO0tIdC2SMJaeZNugCaIGu2rgr2CvT9ZmKVR4MpM9RlekQREPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=int8JCc/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720580639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m8aCjteDF9kv5HFxPoL2hFaYO5mkTuxflvGPvTpOws=;
	b=int8JCc/pmTZ8f0gLxg+80ACI4aT0dD8NDqHGCJF266tDDYDJo+43e+1yH8TUiz1ARTi1j
	NSI9un/+EFDTH05tDwHAbuTepbjUAJBM18Z6VPpUWRcGTO9ibL2tXc54XphSmqXBi//u5s
	LDG3WegG/rBKq7I8aff9wUnLc2K9vEQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-8Rtc75aCOG21MyvkOTHKYg-1; Tue, 09 Jul 2024 23:03:57 -0400
X-MC-Unique: 8Rtc75aCOG21MyvkOTHKYg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70b0bb79c49so4108188b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 20:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580636; x=1721185436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m8aCjteDF9kv5HFxPoL2hFaYO5mkTuxflvGPvTpOws=;
        b=Lgk482g69TBvjM+sJ7/P5OJ9gbVU7pyI/OuusYMSUd7cT9f+N7dzFogMynX2nGY5Gd
         orKh0fgLxz4WnQ6dEbxs5KDMswr5McnGZ804/SETCg5GuW82GtLSDOBaQrIuSbWtoNmM
         /Zs4r6XM4jcnKaMjCxa0ifmTCjJL5L3WgPHUjtnYF5TUrGkzVqt8Q2fVCO2NeC9dhOkx
         rf7Pf9iIMYzOM/9XrEEbtCj+aM1dUeLXm5CyS1cbGEWWPoW6slJEn5LfKjMEotlg/LOE
         VZ488MNetRwbHnjTT5pQDymIjvRcjo+sCfrN4XxO2q0WkRqiv765prvrmnyUYyPr0Gf8
         aYeA==
X-Forwarded-Encrypted: i=1; AJvYcCXoA4vT5/SXnCPPZmzNxOs0bCcJrGOGambhQSR4mG4FOgvHB9CmcDdmUUj0PLO26S3LCF2s3AFi+1EyIbwkAhalzEjYD7hg
X-Gm-Message-State: AOJu0YyKh3Fh4BE++ecmPJuJSfnLTUCBd7W9Avq9XZSfWInTeEHp/KMi
	7xbwkv0nS92nN3kLLCRyiq3feSe2Ehi7qxhoGXHq+1EB1t7byzWHwReus0MZSyAXt5OIlAqPQnL
	xOHTcCluVEpRZ3r86Qh7Mxrvfs36P4LO96O/umTQAna14ubRH8O1bg1KqtxiXwQWwJMm4rKopbg
	AeGW833xMo6betzUYolv6BwGCMuqVx
X-Received: by 2002:a05:6a00:c8a:b0:705:d755:69b0 with SMTP id d2e1a72fcca58-70b435220d3mr5508387b3a.6.1720580636463;
        Tue, 09 Jul 2024 20:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFublIsXU0BfwCjnTffxoMHi/da7XFgFcc6uHDMAQm11f4mpJOU1lqfWF698upr5Urx3OWHCsJsXBaobF0fkvo=
X-Received: by 2002:a05:6a00:c8a:b0:705:d755:69b0 with SMTP id
 d2e1a72fcca58-70b435220d3mr5508363b3a.6.1720580635855; Tue, 09 Jul 2024
 20:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240709090743-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:03:42 +0800
Message-ID: <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
>
> I think that the commit log is confusing. It seems to say that
> the issue fixed is synchronizing state with hardware
> config change.
> But your example does not show any
> hardware change. Isn't this example really just
> a side effect of setting carrier off on close?

The main goal for this patch is to make virtio-net follow RFC2863. The
main thing that is missed is to synchronize the operstate with admin
state, if we do this, we get several good results, one of the obvious
one is to allow virtio-net to propagate status to the upper layer, for
example if the admin state of the lower virtio-net is down it should
be propagated to the macvlan on top, so I give the example of using a
stacked device. I'm not we had others but the commit log is probably
too small to say all of it.

>
>
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Yes but this just forces lots of re-reads of config on each
> open/close for no good reason.

Does it really harm? Technically the link status could be changed
several times when the admin state is down as well.

> Config interrupt is handled in core, you can read once
> on probe and then handle config changes.

Per RFC2863, the code tries to avoid dealing with any operstate change
via config space read when the admin state is down.

>
>
>
>
>
> > ---
> >  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
> >  1 file changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0b4747e81464..e6626ba25b29 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtnet_in=
fo *vi, struct dim *dim)
> >       net_dim_work_cancel(dim);
> >  }
> >
> > +static void virtnet_update_settings(struct virtnet_info *vi)
> > +{
> > +     u32 speed;
> > +     u8 duplex;
> > +
> > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > +             return;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > +
> > +     if (ethtool_validate_speed(speed))
> > +             vi->speed =3D speed;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > +
> > +     if (ethtool_validate_duplex(duplex))
> > +             vi->duplex =3D duplex;
> > +}
> > +
> >  static int virtnet_open(struct net_device *dev)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             virtio_config_driver_enable(vi->vdev);
> > +             /* Do not schedule the config change work as the
> > +              * config change notification might have been disabled
> > +              * by the virtio core. */
>
> I don't get why you need this.
> If the notification was disabled it will just trigger later.
> This is exactly why using core is a good idea.

So we need a read here (this seems to be not rare for most modern
hardware NICs) because we don't know if the link status is changed or
not and it is not guaranteed by virtio_config_driver_enable() since it
only works when there's a pending config change. Another thing is that
the device is being freezed, so the virtio core may prevent the device
from accessing the device.

So using virtio_config_changed() will guaranteed that:

1) if the device is not being freezed, it will read the config space soon
2) if the device is being freezed, the read of the config space will
be delayed to resume

>
>
> > +             virtio_config_changed(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             virtnet_update_settings(vi);
>
>
> And why do we need this here I don't get at all.

See above, because doing this on a probe is racy and buggy: The
opersate is up even if the adminstate is not, this is conflict with
RFC2863:

"
If ifAdminStatus is down(2) then ifOperStatus
            should be down(2)
"

>
> > +             netif_carrier_on(dev);
> > +     }
>
>
>
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Make sure config notification doesn't schedule config work */
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Make sure status updating is cancelled */
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net_dev=
ice *dev)
> >       vi->duplex =3D DUPLEX_UNKNOWN;
> >  }
> >
> > -static void virtnet_update_settings(struct virtnet_info *vi)
> > -{
> > -     u32 speed;
> > -     u8 duplex;
> > -
> > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > -             return;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > -
> > -     if (ethtool_validate_speed(speed))
> > -             vi->speed =3D speed;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > -
> > -     if (ethtool_validate_duplex(duplex))
> > -             vi->duplex =3D duplex;
> > -}
> > -
> >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> >  {
> >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >       /* Assume link up if device can't report link status,
> >          otherwise get link status from config. */
> >       netif_carrier_off(dev);
> > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > -     } else {
> > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > -             virtnet_update_settings(vi);
> > -             netif_carrier_on(dev);
> > -     }
>
>
> Here it all made sense - we were reading config for the 1st time.

See above.

Thanks

>
>
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > --
> > 2.31.1
>
>


