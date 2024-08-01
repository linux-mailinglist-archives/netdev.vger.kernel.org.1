Return-Path: <netdev+bounces-114810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C199444A1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7FE1F22DA3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EF158207;
	Thu,  1 Aug 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIf877/Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20284156F54
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494585; cv=none; b=ZUJbb5+HbDTuGuJg2793F/sHa+BlmH4DUfBf4XIfKrcrv9PIdybzj444p2u4MfV9tKy7nMtJlkV2qVNcbWdlOkFkM5uPkNNj0Z+F0xgkafNScDIP96TV/ZFyX/mKqxOGVAi/Ic2bqfvTqeEB5wuPPAk403Y5QGgfUB7Gr2A+Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494585; c=relaxed/simple;
	bh=3sMNL6Z7EG1MeEDzLcDu6Fn40q1N9CzmRoNeKZEocEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGXtw4Eu1vbiey5Y7GkBH6hVv4b9IbO/6W3f+Gxz4UmFvfhBiqTRMRSxwDojdcRaY+qiQY47rh+tevBuOo1klJll10OwcfuMP1FypoFhB9nQ8C07PUzr0rddOUOLTlr/ciO6xj82vPP5xFETFIHkyAsX4qX3a0Uc4VK2JuSWC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIf877/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTapdtzj27M15zsvYJgRhP2T/m6CymdqAZspv0g68V4=;
	b=XIf877/QFrV0opQAYsP1ff9256xgBGrw1GALVkYNxNeCjcbjJZNEYCQOTTEt4tzlsztoIu
	YnlTJPCCrqawung5OnuNxhOGCzWyPVihju4zJokGQjy7hhLVvZ7aE+ZNaZElRJSL1fBdxg
	4s5lnaDzDWP6ENUVSLiNR1YcXVg511k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-oGBxVEUuPqiItG-WGX3RRw-1; Thu, 01 Aug 2024 02:43:02 -0400
X-MC-Unique: oGBxVEUuPqiItG-WGX3RRw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77f0eca75bso608105766b.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494581; x=1723099381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTapdtzj27M15zsvYJgRhP2T/m6CymdqAZspv0g68V4=;
        b=YMRCDaq5J4gYkGZP0ojdoQmlqQPHe4bFffFwBHTUsuo0BANKrDcgMkGXzUAvWbRQ+5
         mzZFYdDErZjV2FWFNSjQEPKKoJzJU0qX38DKbH61afyKsp2N+Gq8vnfKGxs7duhSSmtg
         hlAr8fuP3NdPSaia5/EikySMuyIhOv9h+pZ1aedpwWH8CeHUjctN3v96zYQeK1q5TSQS
         F68j+0aOzF5t6zC8e9AsNKg5MlVYTfcGsNYzpt1jF+WLb7DCIVVQJ8a6HmJjXzRPjcC4
         aCt3yaRni1qOtSudlY39X0xTkQ3sVN1xfe65KJoyTTcKM/BvduwowoNLUOlO+jk6QJMA
         /fgA==
X-Forwarded-Encrypted: i=1; AJvYcCXgzSXiocP1zxq3sT3i78gbOOk+oRnq1efvRFfD70zPW0EU3dX6wyMNWOXOOja33VDJuUzulIB4/LG235KxgU1kC5Wl39He
X-Gm-Message-State: AOJu0Yy1GCLJQSP82sZhDreH0/W6uAbL9+CEJb/v7FAkPQhsv3eXfwEE
	wi5OU5soiLzrtdzwYQvPJd2lTRU3PoGyw/Paw5ldhGitV8Q99yLjyOgsPUDkjAuwc3Y+eD3BWpw
	TruiCRLkxefdlyYxoFa3sONRyXCTCNX50n5BJcnXqwG+RaGaSUKTQ1g==
X-Received: by 2002:a17:907:3daa:b0:a77:e48d:bc3 with SMTP id a640c23a62f3a-a7daf2c7b39mr110053466b.19.1722494580624;
        Wed, 31 Jul 2024 23:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFYIVTleb5GYHeRfZuurOsc5huVzTp10qrxekRHEANef0oAua51wtAUXul9lfV15Vn9a99A==
X-Received: by 2002:a17:907:3daa:b0:a77:e48d:bc3 with SMTP id a640c23a62f3a-a7daf2c7b39mr110049066b.19.1722494579471;
        Wed, 31 Jul 2024 23:42:59 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4146dsm849826166b.114.2024.07.31.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:42:57 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:42:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240801024202-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240801015914-mutt-send-email-mst@kernel.org>
 <CACGkMEs_0O3Bc_oe9XF9=qMRv7+a8wG3N9=EMA1nxpiDF56V2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs_0O3Bc_oe9XF9=qMRv7+a8wG3N9=EMA1nxpiDF56V2Q@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:13:49PM +0800, Jason Wang wrote:
> On Thu, Aug 1, 2024 at 2:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
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
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
> > >  1 file changed, 54 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0383a3e136d6..0cb93261eba1 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >       return err;
> > >  }
> > >
> > > +
> > >  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > >  {
> > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
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
> > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > +                     netif_carrier_on(vi->dev);
> > > +             virtio_config_driver_enable(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             netif_carrier_on(dev);
> > > +             virtnet_update_settings(vi);
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
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
> > > +     netif_carrier_off(dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> > > @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               goto free_failover;
> > >       }
> > >
> > > +     /* Forbid config change notification until ndo_open. */
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating work is done */
> >
> > Wait a second, how can anything run here, this is probe,
> > config change callbacks are never invoked at all.
> 
> For buggy devices.

buggy or not, virtio core will not invoke callbacks until
after probe and scan.

> >
> > > +     cancel_work_sync(&vi->config_work);
> > > +
> >
> >
> > this is pointless, too.
> >
> > >       virtio_device_ready(vdev);
> > >
> > >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               vi->device_stats_cap = le64_to_cpu(v);
> > >       }
> > >
> > > +     /* Assume link up if device can't report link status,
> > > +           otherwise get link status from config. */
> > > +        netif_carrier_off(dev);
> > > +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             /* This is safe as config notification change has been
> > > +                disabled. */
> >
> > What "this"? pls explain what this does: get config data from
> > device.
> >
> > Actually not because it was disabled. probe can poke at
> > config with impunity no change callbacks trigger during probe.
> 
> Only if we have a good device.

not if you read the core code.

> >
> > > +                virtnet_config_changed_work(&vi->config_work);
> >
> >
> >
> 
> Thanks
> 
> 
> >
> > > +        } else {
> > > +                vi->status = VIRTIO_NET_S_LINK_UP;
> > > +                virtnet_update_settings(vi);
> > > +                netif_carrier_on(dev);
> > > +        }
> > > +
> > >       rtnl_unlock();
> > >
> > >       err = virtnet_cpu_notif_add(vi);
> > > @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               goto free_unregister_netdev;
> > >       }
> > >
> > > -     /* Assume link up if device can't report link status,
> > > -        otherwise get link status from config. */
> > > -     netif_carrier_off(dev);
> > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > -             schedule_work(&vi->config_work);
> > > -     } else {
> > > -             vi->status = VIRTIO_NET_S_LINK_UP;
> > > -             virtnet_update_settings(vi);
> > > -             netif_carrier_on(dev);
> > > -     }
> > > -
> > >       for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > > --
> > > 2.31.1
> >


