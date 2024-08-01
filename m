Return-Path: <netdev+bounces-114790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33602944107
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7DB285701
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8113CA8E;
	Thu,  1 Aug 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVcdusS4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5A13CA81
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478578; cv=none; b=g17jntFSm460OSf6sVrJy0Vx8KbmDL9ngDN+twPEbVSj8id5qsoFg4y9a5TN4UgFOusyggE0xGe8wPzl+K5Rqd+mi7xfYgEXLpTShrn/H8K9DmF15lk6fWjatzLXzQneyz0t3SvjzfCZa8yM1LphjjeKz7ENpISy2ovdhpSrQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478578; c=relaxed/simple;
	bh=o6PFUAQP6n4iINcwnj6E0kd/dUbkRxPvTCRl2KDcr6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpn0nHtYi1yeGJbKT2GR4wo90F8xMPKnZ5AtvHgnVpLWXzG7+yp+fJHipTIrcvHbyLmz7NXo8sc0rUYGlkhLmPPTlUTHJOoOD1thuGAFrbMwwgqX19Q/7dlSyHJIaRFUOK41meOtTzor4MeKymmLupJxxZ9ZuQCgfNmYzzMB1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVcdusS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722478575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua6nG0vETgrG1OpgpXq7//M6ysuBXjEjgqSIXxbMmgk=;
	b=YVcdusS4XgsWgt58bp7sUI9wspYkpO83UxeB6mMD9g+Ro24Kxks5VRyQe2gmb7aJkVEoaE
	S45CMNlgPkW3VWumFs8CBuyX5mThTXV3M7LB2AytyMDn0/g27uRi/SD0xYD1U3I9gDGTeC
	BhKnlxfE6pVP0FzCtrM08YieS5ns4Q0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-0wb0vBWqPxOIRKMDhEwRHg-1; Wed, 31 Jul 2024 22:16:13 -0400
X-MC-Unique: 0wb0vBWqPxOIRKMDhEwRHg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cf1a80693cso6411127a91.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 19:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722478572; x=1723083372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua6nG0vETgrG1OpgpXq7//M6ysuBXjEjgqSIXxbMmgk=;
        b=sZkfPUyX20R2ZmU5mRNGSsWYlRYWpSvtSQzekDV0cM8kYRmA4uIkoOTSPFZI98X5vX
         NY7aaD021V++yQEJPpeThiPv6U32U7bfhYmOxi5B2lzfumbTirZbR7UCqCJXx+J7bjiv
         cf4vQbjLSoPjXxzxDDUoqTdFGVP53ZZlv8Ewgpby8J+eOvnAVJ4pwOlE0Ldjb0MoWUB7
         HX+2IimAWdhvybkSDBMAX2E7pWCd5rWhZlBqqSO1L8w18tAms+6Gq31E/MeRCHCjpHf9
         6TxvCk/4vvm5Go1vI0HEY1Np8QohS/BeKeDsJ0eXvo0Ss3WURjjk8yfDN5w7TNvAhgj4
         EDug==
X-Forwarded-Encrypted: i=1; AJvYcCUiq1GpJOLFqfmrYLC5CaYx3338HG//9u3wQ8f/55nR5Hshb7nBZCBf40ihHSgpsKyJIMH8OeAvib/R0RFVg5LWfo/Rsdwu
X-Gm-Message-State: AOJu0Yx1meBCk7Ga0XPiQTEQoNW46Eb+QWAP5PSQ+9vO/fa8q9bhiV6f
	GudvxNd727/GY6xpFefLYxUMQf0WrpJr+2kilm0pkUo0tH8ezc/J5MAg89EF6c/stKhWE92T4fC
	n42SUG4wUZwEBcvz6l91qMk/4VNo5/aCXzJColmiiEaBFSYfmuqU/IsocC7B8RGn1Pm2XFKBe3A
	Jc9zTWhQnCGlqaeWOehP6mUQzO2P6k
X-Received: by 2002:a17:90a:46cf:b0:2bf:8824:c043 with SMTP id 98e67ed59e1d1-2cfe789aad1mr1434178a91.18.1722478572278;
        Wed, 31 Jul 2024 19:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqW9NgruQCD+EvLzmuy5CyNmv4inSltsP9yptey73epp8EnnzeMm7IILdoMS44MVyjEBFQe4KhhBSMSqggxbI=
X-Received: by 2002:a17:90a:46cf:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2cfe789aad1mr1434151a91.18.1722478571719; Wed, 31 Jul 2024
 19:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240731172020-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 10:16:00 +0800
Message-ID: <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 5:26=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
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
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Changelog?

In the cover letter actually.

>
> > ---
> >  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
> >  1 file changed, 54 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..0cb93261eba1 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtn=
et_info *vi, int qp_index)
> >       return err;
> >  }
> >
> > +
> >  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *di=
m)
> >  {
> >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>
> hmm
>
> > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_in=
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
>
> I already commented on this approach.  This is now invoked on each open,
> lots of extra VM exits. No bueno, people are working hard to keep setup
> overhead under control. Handle this in the config change interrupt -
> your new infrastructure is perfect for this.

No, in this version it doesn't. Config space read only happens if
there's a pending config interrupt during ndo_open:

+       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+               if (vi->status & VIRTIO_NET_S_LINK_UP)
+                       netif_carrier_on(vi->dev);
+               virtio_config_driver_enable(vi->vdev);
+       } else {
+               vi->status =3D VIRTIO_NET_S_LINK_UP;
+               netif_carrier_on(dev);
+               virtnet_update_settings(vi);
+       }

>
>
> >  static int virtnet_open(struct net_device *dev)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > +                     netif_carrier_on(vi->dev);
> > +             virtio_config_driver_enable(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             netif_carrier_on(dev);
> > +             virtnet_update_settings(vi);
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Make sure config notification doesn't schedule config work */
>
> it's clear what this does even without a comment.
> what you should comment on, and do not, is *why*.

Well, it just follows the existing style, for example the above said

"/* Make sure refill_work doesn't re-enable napi! */"

>
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Make sure status updating is cancelled */
>
> same
>
> also what "status updating"? confuses more than this clarifies.

Does "Make sure the config changed work is cancelled" sounds better?

>
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_dev=
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
> > @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_failover;
> >       }
> >
> > +     /* Forbid config change notification until ndo_open. */
>
> notifications
>
> Disable, not forbid.

Ok.

>
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Make sure status updating work is done */
>
>
>
> > +     cancel_work_sync(&vi->config_work);
> > +
> >       virtio_device_ready(vdev);
> >
> >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               vi->device_stats_cap =3D le64_to_cpu(v);
> >       }
> >
> > +     /* Assume link up if device can't report link status,
> > +           otherwise get link status from config. */
> > +        netif_carrier_off(dev);
> > +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             /* This is safe as config notification change has been
>
> config change notification
>
> > +                disabled. */
> > +                virtnet_config_changed_work(&vi->config_work);
> > +        } else {
> > +                vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +                virtnet_update_settings(vi);
> > +                netif_carrier_on(dev);
> > +        }
> > +
> >       rtnl_unlock();
> >
> >       err =3D virtnet_cpu_notif_add(vi);
> > @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     /* Assume link up if device can't report link status,
> > -        otherwise get link status from config. */
> > -     netif_carrier_off(dev);
> > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > -     } else {
> > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > -             virtnet_update_settings(vi);
> > -             netif_carrier_on(dev);
> > -     }
> > -
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > --
> > 2.31.1
>


