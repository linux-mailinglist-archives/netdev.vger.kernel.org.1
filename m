Return-Path: <netdev+bounces-113152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94A93CEC7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A266D1C20DB5
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF6548EE;
	Fri, 26 Jul 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtMAT9xn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF464C99
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978658; cv=none; b=neMBg2yPpc8nTvoqWT5tI/inXNpDbyRcL1b7eJRvFOJFZ8SxlXg9SW5uULZlyIlwWHSLSaBEthama/LXxgKLO9L82kjSIoyrbl5XPDzWsytl7pOqC2AK6BiFG/0kGDFH6MO7CNWnfvnSlFmcO87p+gMcvxeenblcXmp18bJrwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978658; c=relaxed/simple;
	bh=GQeSyv4N5SdbkiPJs5POgpGYb2TUStJ9CU8JvqFmuWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC86tX/6b15+jfnaWdXH7zsrNiz+u3aaroCrvB9t1MbWxLP/uB+GqZULKxJ3soU+kvQ+pQYY7gHM64+ttcIVyy82PhR9sE5bqYqoQCUHxo46OLxwvtzrTe+OPEwraayOB1SG4DzI4Bgl7+dBQ9U0BsldkJd7psyv96U+yei463U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtMAT9xn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721978655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YGbuDu0E8KnXcvUSphuRz/04CtrQyD3tS84OrHdxww=;
	b=VtMAT9xnlAyTu7yDN3jwPfrnvL41xEL3J3aC/Nl+V/9NlRKOYyB6faCFU9GPYXWdOKc4rk
	GgUvWxmMzGHZ6cx6KiQ9MgQy2eBtK28NCx6orhBhkBhOiU4bDjvwZOGOlUUSOrzhsj5Ld6
	we2wMLOFFVSbVyUrp2NBtD2SjFUSIoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-sOVxUtfSOFOFSxOaw8x7Dw-1; Fri, 26 Jul 2024 03:24:14 -0400
X-MC-Unique: sOVxUtfSOFOFSxOaw8x7Dw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so3677735e9.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 00:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978653; x=1722583453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YGbuDu0E8KnXcvUSphuRz/04CtrQyD3tS84OrHdxww=;
        b=txvTNxndjHdKOkz27Y2fOPozpq7GJEHzozme9WuA2QKl+uKF8Gfwwtr35fj+sdqR64
         lQg4SEZ89GpT6pL+hfH0BoRKiKs8uU8PcEFgIfg8yhYdl3Z/4vfU84DRZjs5p4lkaNv/
         oZo6GU8sUcgl/Odbc/LdpJcNlzJL0dQmfGU3gau4b6IHd5G1y5ljlSCl1RD9Abo7cc1K
         /a7ojCgijz2wYp2P53XuPO78KrC5YgI4erQ0YZX8PVrK2C964ubXRfTDCrB/AAufzOpq
         m6/EtFQKk9Blai3sJyM6a3g1OSvFqG+z3/A0PjygJFBCPUGEWGoEHl8z1no3RlCBvr5f
         Zgdw==
X-Forwarded-Encrypted: i=1; AJvYcCWOTm97q8YB2zx6mLV7FKQUuwsXkL6YrU7RSlkH/ZXZPMrdxQvKo3ejroSRQg4vmwO1oI+jlHH0Etl41gbm2BSzxLr2QlOj
X-Gm-Message-State: AOJu0Yz+QQBaXCH3AE7zLJKFjuJTRafSZHEufRP5XhWUkUh+HY4ZfjIG
	fC248EzYK9Zv8OSgjvAANRrk5JXVEeZhkvV/CETaHttdFjhcQdLU6ELsjvGoXwTZ0wXzg3W+syi
	ibJizTSbHiF4yxeem9cf3p/ZXyH+f2scn6Tl1iJbQJABESHyzd60EMA==
X-Received: by 2002:a05:600c:511e:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-427f9a20690mr52826985e9.12.1721978652800;
        Fri, 26 Jul 2024 00:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQYsGATkZTZpg8Cs1l5poCLdeX4a7jfOInIQ56jNxWqMMLLltlnF+FkNjo7UPa5dEAqOMj8w==
X-Received: by 2002:a05:600c:511e:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-427f9a20690mr52826585e9.12.1721978652084;
        Fri, 26 Jul 2024 00:24:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9359516sm109048635e9.2.2024.07.26.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:24:11 -0700 (PDT)
Date: Fri, 26 Jul 2024 03:24:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240726031947-mutt-send-email-mst@kernel.org>
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org>
 <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:03:42AM +0800, Jason Wang wrote:
> On Tue, Jul 9, 2024 at 9:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > I think that the commit log is confusing. It seems to say that
> > the issue fixed is synchronizing state with hardware
> > config change.
> > But your example does not show any
> > hardware change. Isn't this example really just
> > a side effect of setting carrier off on close?
> 
> The main goal for this patch is to make virtio-net follow RFC2863. The
> main thing that is missed is to synchronize the operstate with admin
> state, if we do this, we get several good results, one of the obvious
> one is to allow virtio-net to propagate status to the upper layer, for
> example if the admin state of the lower virtio-net is down it should
> be propagated to the macvlan on top, so I give the example of using a
> stacked device. I'm not we had others but the commit log is probably
> too small to say all of it.
> 
> >
> >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Yes but this just forces lots of re-reads of config on each
> > open/close for no good reason.
> 
> Does it really harm? Technically the link status could be changed
> several times when the admin state is down as well.

It's a bunch of extra vmexits on each VM boot, yes.

> > Config interrupt is handled in core, you can read once
> > on probe and then handle config changes.
> 
> Per RFC2863, the code tries to avoid dealing with any operstate change
> via config space read when the admin state is down.

what exactly in RFC2863 are you referring to? This?
   (2)   if ifAdminStatus is down, then ifOperStatus will normally also
         be down (or notPresent) i.e., there is not (necessarily) a
         fault condition on the interface.
So basically, just call virtio_config_driver_disable on close,
and then config interrupt will not trigger.
Why is that not enough?


> >
> >
> >
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
> > >  1 file changed, 38 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0b4747e81464..e6626ba25b29 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > >       net_dim_work_cancel(dim);
> > >  }
> > >
> > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > +{
> > > +     u32 speed;
> > > +     u8 duplex;
> > > +
> > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > +             return;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > +
> > > +     if (ethtool_validate_speed(speed))
> > > +             vi->speed = speed;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > +
> > > +     if (ethtool_validate_duplex(duplex))
> > > +             vi->duplex = duplex;
> > > +}
> > > +
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             virtio_config_driver_enable(vi->vdev);
> > > +             /* Do not schedule the config change work as the
> > > +              * config change notification might have been disabled
> > > +              * by the virtio core. */
> >
> > I don't get why you need this.
> > If the notification was disabled it will just trigger later.
> > This is exactly why using core is a good idea.
> 
> So we need a read here (this seems to be not rare for most modern
> hardware NICs) because we don't know if the link status is changed or
> not and it is not guaranteed by virtio_config_driver_enable() since it
> only works when there's a pending config change. Another thing is that
> the device is being freezed, so the virtio core may prevent the device
> from accessing the device.
> 
> So using virtio_config_changed() will guaranteed that:
> 
> 1) if the device is not being freezed, it will read the config space soon
> 2) if the device is being freezed, the read of the config space will
> be delayed to resume
> 
> >
> >
> > > +             virtio_config_changed(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             virtnet_update_settings(vi);
> >
> >
> > And why do we need this here I don't get at all.
> 
> See above, because doing this on a probe is racy and buggy: The
> opersate is up even if the adminstate is not, this is conflict with
> RFC2863:
> 
> "
> If ifAdminStatus is down(2) then ifOperStatus
>             should be down(2)
> "
> 
> >
> > > +             netif_carrier_on(dev);
> > > +     }
> >
> >
> >
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device *dev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work */
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> > > +     cancel_work_sync(&vi->config_work);
> > >
> > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > >               virtnet_disable_queue_pair(vi, i);
> > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > >       }
> > >
> > > +     vi->status &= ~VIRTIO_NET_S_LINK_UP;
> > > +     netif_carrier_off(dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net_device *dev)
> > >       vi->duplex = DUPLEX_UNKNOWN;
> > >  }
> > >
> > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > -{
> > > -     u32 speed;
> > > -     u8 duplex;
> > > -
> > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > -             return;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > -
> > > -     if (ethtool_validate_speed(speed))
> > > -             vi->speed = speed;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > -
> > > -     if (ethtool_validate_duplex(duplex))
> > > -             vi->duplex = duplex;
> > > -}
> > > -
> > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > >  {
> > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > > @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       /* Assume link up if device can't report link status,
> > >          otherwise get link status from config. */
> > >       netif_carrier_off(dev);
> > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > -             schedule_work(&vi->config_work);
> > > -     } else {
> > > -             vi->status = VIRTIO_NET_S_LINK_UP;
> > > -             virtnet_update_settings(vi);
> > > -             netif_carrier_on(dev);
> > > -     }
> >
> >
> > Here it all made sense - we were reading config for the 1st time.
> 
> See above.
> 
> Thanks
> 
> >
> >
> > >       for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > --
> > > 2.31.1
> >
> >


