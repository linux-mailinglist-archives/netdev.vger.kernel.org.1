Return-Path: <netdev+bounces-114817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D449444F9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1CB1C212B2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5319F170A20;
	Thu,  1 Aug 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti5+NDOX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AD16CD0E
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495336; cv=none; b=X6eDml48hLjJLM0qrgFIM/2jPi1242zFQoIU3PfV4sq8U7E7sHp3+LvSDhDEZ/301dyhBj9X7MXNJQH5GJ8E1D2W4NQgrg0lOmj+OcMadGdp0XgaDTRVScxtAwv5h5TobnSzRq57g/9zBoJdihbYRsifDs9KHsgb80268DBuHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495336; c=relaxed/simple;
	bh=XmnboEv8s3bbCYuApa/z4HR+4kvHOYqJS2JQgb3lN7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLuuXx+q5M6dvEPuhxa7XzlBaa6tEU8VeOn1NnHbt701PIUSzJp9NJaUUWp6oXoXl4dQ9ViHXgOmDIMPAbB2ReT/910cLPOoj5pWpQ/ptTTf0odoY9fNF56ws6pNUgJqGRS5DY0X1TzOr9XP036bsm7qxb7nZai30V0AQJyxApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti5+NDOX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722495333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/2BPCX2iEFS2x7x8P+6xvEQ8wkNWEdKFiA03A2xmsE=;
	b=Ti5+NDOXagg5u0MIn/buIOoLSIdEt31513Ot6n0Eu5lVkZNEpb/OsQ7GaNfLkDhaTtzht/
	5KgLXoYLqI9fuY5+cm+WpJpKpmOTXgc81KFnW5q4mM3QUlGABrLCB8jv+W/rSvj4Hkgf23
	q8TOFnhmNV/meABnwZdruFZ3Cq5+GmE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ctCOLFx2PIu_q4nVFVR_Cw-1; Thu, 01 Aug 2024 02:55:31 -0400
X-MC-Unique: ctCOLFx2PIu_q4nVFVR_Cw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70e97ac260eso6533042b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495331; x=1723100131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/2BPCX2iEFS2x7x8P+6xvEQ8wkNWEdKFiA03A2xmsE=;
        b=kP1yP1mQP3j4C2gxjCHx12B/3vDKoDuo0UmWGVuxjin5AQslJZ3+6lE8lmi6khlPN8
         wFLOLgtrivgl8hA/Hmy5T3RNJ3wsJgQc22cUeccqN2FWjSd2Y0Y9oaWajn1EYSl+M/D2
         3p3YEAOLBBoeMgli3bsAZe1R5KIAVN/ZXaLO9sAc+SWil+JWpXc9UxuqlqQ0nUOFK0xB
         CgY/bJ32PXMWfUnx4DHv63PUQ6+uJ6V6d7Xv1QS95YbmNdVTr5rUFtPz5v1GQQB1O8GL
         lW5iFMa98vB5nVVhzD0fljC6TcvaXiDAHjRPIKgovkN3Y7Z0gpmoFFXeaPe6Jg1kySG3
         DxHw==
X-Forwarded-Encrypted: i=1; AJvYcCUkACSrYbyTy7Mmyef8bwvcBiJBfQW7nRrRVUv9X00yjAnFwENclT2ENzi//YvV5Dojr6xyHT6Pn5NcTTdni4j1S/vPLAy8
X-Gm-Message-State: AOJu0YwI15tl6YSvhem2xQnPgyB7A01RAzxVffwImDRyOgpbFBieMjKI
	8ip0iJwwZNoUGUZOK4wcXQhtTkGC971bUnJ0g1wgk2l7mpU5ru8lx2wuC/7f+IcXs3kwgi+/h21
	FaxzI3NFIw7a5taCMhMC74J4ahcQwzo9OXzIDB4MMQwm3dJ+zOC+Bn9nMOz0c+//v9LSQHyDwBZ
	3PpVds6HLu/LaOOE4god4KhxkpGlXr
X-Received: by 2002:a05:6a20:7f93:b0:1c4:8da5:5825 with SMTP id adf61e73a8af0-1c68cd00bf6mr2402468637.0.1722495330766;
        Wed, 31 Jul 2024 23:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpCLihdYaTqSd19jfZQaY7T42e8Ti6xkXLOfjRWiTxpGzH3UkfsuJkq8k/QVINpbLTMq+Sq3QBs8L+YGgsG9I=
X-Received: by 2002:a05:6a20:7f93:b0:1c4:8da5:5825 with SMTP id
 adf61e73a8af0-1c68cd00bf6mr2402442637.0.1722495330165; Wed, 31 Jul 2024
 23:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240801015914-mutt-send-email-mst@kernel.org> <CACGkMEs_0O3Bc_oe9XF9=qMRv7+a8wG3N9=EMA1nxpiDF56V2Q@mail.gmail.com>
 <20240801024202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801024202-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 14:55:18 +0800
Message-ID: <CACGkMEvsx_6YNF0m0akVxk8LMVZztaGnbc-761CDKMZpxywR6g@mail.gmail.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 01, 2024 at 02:13:49PM +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 2:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate stat=
us
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 15=
00 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu =
1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 100=
0
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++----------=
----
> > > >  1 file changed, 54 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 0383a3e136d6..0cb93261eba1 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct v=
irtnet_info *vi, int qp_index)
> > > >       return err;
> > > >  }
> > > >
> > > > +
> > > >  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim=
 *dim)
> > > >  {
> > > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtne=
t_info *vi, struct dim *dim)
> > > >       net_dim_work_cancel(dim);
> > > >  }
> > > >
> > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > +{
> > > > +     u32 speed;
> > > > +     u8 duplex;
> > > > +
> > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > +             return;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > +
> > > > +     if (ethtool_validate_speed(speed))
> > > > +             vi->speed =3D speed;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > +
> > > > +     if (ethtool_validate_duplex(duplex))
> > > > +             vi->duplex =3D duplex;
> > > > +}
> > > > +
> > > >  static int virtnet_open(struct net_device *dev)
> > > >  {
> > > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *d=
ev)
> > > >                       goto err_enable_qp;
> > > >       }
> > > >
> > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > +                     netif_carrier_on(vi->dev);
> > > > +             virtio_config_driver_enable(vi->vdev);
> > > > +     } else {
> > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +             netif_carrier_on(dev);
> > > > +             virtnet_update_settings(vi);
> > > > +     }
> > > > +
> > > >       return 0;
> > > >
> > > >  err_enable_qp:
> > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device =
*dev)
> > > >       disable_delayed_refill(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > > +     /* Make sure config notification doesn't schedule config work=
 */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > > > +     cancel_work_sync(&vi->config_work);
> > > >
> > > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > >               virtnet_disable_queue_pair(vi, i);
> > > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > > >       }
> > > >
> > > > +     netif_carrier_off(dev);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net=
_device *dev)
> > > >       vi->duplex =3D DUPLEX_UNKNOWN;
> > > >  }
> > > >
> > > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > > -{
> > > > -     u32 speed;
> > > > -     u8 duplex;
> > > > -
> > > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > -             return;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > -
> > > > -     if (ethtool_validate_speed(speed))
> > > > -             vi->speed =3D speed;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > -
> > > > -     if (ethtool_validate_duplex(duplex))
> > > > -             vi->duplex =3D duplex;
> > > > -}
> > > > -
> > > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > > >  {
> > > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_siz=
e;
> > > > @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               goto free_failover;
> > > >       }
> > > >
> > > > +     /* Forbid config change notification until ndo_open. */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating work is done */
> > >
> > > Wait a second, how can anything run here, this is probe,
> > > config change callbacks are never invoked at all.
> >
> > For buggy devices.
>
> buggy or not, virtio core will not invoke callbacks until
> after probe and scan.

I think you're right, but we still need the
virtio_config_driver_disable(). Otherwise the config change callback
might race with ndo_open().

>
> > >
> > > > +     cancel_work_sync(&vi->config_work);
> > > > +
> > >
> > >
> > > this is pointless, too.
> > >
> > > >       virtio_device_ready(vdev);
> > > >
> > > >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > > @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               vi->device_stats_cap =3D le64_to_cpu(v);
> > > >       }
> > > >
> > > > +     /* Assume link up if device can't report link status,
> > > > +           otherwise get link status from config. */
> > > > +        netif_carrier_off(dev);
> > > > +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             /* This is safe as config notification change has bee=
n
> > > > +                disabled. */
> > >
> > > What "this"? pls explain what this does: get config data from
> > > device.
> > >
> > > Actually not because it was disabled. probe can poke at
> > > config with impunity no change callbacks trigger during probe.
> >
> > Only if we have a good device.
>
> not if you read the core code.

Right after the device is ready the config notification might be
triggered by the device, but the callback will be blocked by the core.

Thanks


>
> > >
> > > > +                virtnet_config_changed_work(&vi->config_work);
> > >
> > >
> > >
> >
> > Thanks
> >
> >
> > >
> > > > +        } else {
> > > > +                vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +                virtnet_update_settings(vi);
> > > > +                netif_carrier_on(dev);
> > > > +        }
> > > > +
> > > >       rtnl_unlock();
> > > >
> > > >       err =3D virtnet_cpu_notif_add(vi);
> > > > @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >               goto free_unregister_netdev;
> > > >       }
> > > >
> > > > -     /* Assume link up if device can't report link status,
> > > > -        otherwise get link status from config. */
> > > > -     netif_carrier_off(dev);
> > > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > -             schedule_work(&vi->config_work);
> > > > -     } else {
> > > > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > -             virtnet_update_settings(vi);
> > > > -             netif_carrier_on(dev);
> > > > -     }
> > > > -
> > > >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > >                       set_bit(guest_offloads[i], &vi->guest_offload=
s);
> > > > --
> > > > 2.31.1
> > >
>


