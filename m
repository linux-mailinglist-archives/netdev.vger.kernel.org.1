Return-Path: <netdev+bounces-106306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83353915BB1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CC3283473
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68762175BF;
	Tue, 25 Jun 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHqfEIvN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056B1BC23
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278875; cv=none; b=Xb9fjUEErQF42y0jvcH5xzw1liIDgv1wHjwiJCzYPUikExibVhYQlGR2TintF2ySQ94O0nj7Hk3sCY5VGmuRlyUnNo1AD9NjZxZvXeFqF0FYI1cPtPRbMd5DDB7kdbkUTsFxXuClO6OImz193or11bL4QiU4nPVH/qGAuPkQvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278875; c=relaxed/simple;
	bh=yjjQUUKXhxytqvA2OHxeNfjdJ0+LI/24Ja29DIooPo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krywo1zlej0zjbtOV6eTrhxI2b4KG71l+3oZD0yPnQeYsgvSSfD4D/PJm2MTkoNs9YBJO5o6lZilqbFk849UA/kVA3SVYAKHeIiIKvFmdkX2k2U6nMzZbsYWGIY2jvNGsZfqUsA8STZWi9hwM33n26ZhIcr8vztlFVRLOc2vbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHqfEIvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719278872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqCzMsWS7cK7fhBVzoWPTT37VEQ1CT6mCtp7QCXX3Sc=;
	b=hHqfEIvNZocZx8WIhLmoofVp1dNt3MCX7wheYKuabNXaRJ8842d6EiIPe9j7dRHYz/HTFJ
	8vd1b+BF5gfg7WkbzdRvRhGjqCTtV7RAOTKIFwnk6WrNQYGkPbI7/BdUkKny88hIlluJZS
	FiRZanEx7tZ+vEJYjMVlJngCUS3SmLM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-GEBV_l1xM_uIkSzJ10cVCQ-1; Mon, 24 Jun 2024 21:27:50 -0400
X-MC-Unique: GEBV_l1xM_uIkSzJ10cVCQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-718c62ad099so4034293a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278870; x=1719883670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqCzMsWS7cK7fhBVzoWPTT37VEQ1CT6mCtp7QCXX3Sc=;
        b=Zz6h0eVqVkm2jir85br3D4cFZp+UEBpPtq+y1tTMzxSERvoN9db2O5Dk4IHioL0p8O
         n3GIlgIAGTWxfixH+QXU+mOatihL153sYAz6y2LLx25pzUhEf4AkRqaXzSWmTyxYd4FN
         bdh8Vq4/qcrrD/UJT2gNOjKvMwh4bhEI1kMrZTcF7mzBijhQZVK9/oieTtlwW3TjDsbr
         5BGwo5QHFSYBWIA/WLJCB20Qj4obfdyWc/y+A1xXikZRflkK0WTb6dHJgwGP+gi/eaD4
         j6V6Y6z3M10FzaTshavlvlYWscr3fAt5Z3H4m1x+7xvsLNSmbyHkcIyyx0xblzoqWk1L
         JMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX66N64oxPC447kN52SU96D4jDfMJYF3/l6pGyTbqAiEU7j/7hvgOwE8WmeXcrzucUmigefmF+yNFYShoE55cGqIKgQB4qv
X-Gm-Message-State: AOJu0Yz7zOSSv+J0bK/TMM7zbA6u81uJ3pvTLd0IKfsI1DJv53OSOQhY
	QfIa2izPUZvfCGuFc63I4UYBflz4CzQ52ugeJgq2y2yn3TnL2+OSnh6ii78p1ZXjixpBFvbdeQC
	ZQaBSpSwq8+bgPbblOeAwU3Bfha4WyvzZSIXESqVPTCls8IcHmEd+88ssm0hHanOwC1kCpMEo1e
	bSo9jwdcJkdkuDH33/aNnHSJ/KqMZq
X-Received: by 2002:a05:6a20:3f15:b0:1bd:b69:f0e3 with SMTP id adf61e73a8af0-1bd0b69f2e6mr2859703637.44.1719278869790;
        Mon, 24 Jun 2024 18:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnSD1Ch6q09/yixw0OjRjgosSIFbkYnngHKOWbkFx4RhraQi66A+gxlTJvgHuMxTB4ShwvJ3EbZnK+L4FKMIw=
X-Received: by 2002:a05:6a20:3f15:b0:1bd:b69:f0e3 with SMTP id
 adf61e73a8af0-1bd0b69f2e6mr2859683637.44.1719278869254; Mon, 24 Jun 2024
 18:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624060057-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 09:27:38 +0800
Message-ID: <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
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
> > ---
> >  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b1f8b720733e..eff3ad3d6bcc 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virt=
net_info *vi, int qp_index)
> >       return err;
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
> > @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     /* Assume link up if device can't report link status,
> > +        otherwise get link status from config. */
> > +     netif_carrier_off(dev);
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             virtio_config_enable(vi->vdev);
> > +             /* We are not sure if config interrupt is disabled by
> > +              * core or not, so we can't schedule config_work by
> > +              * ourselves.
> > +              */
>
> This comment confuses more than it explains.
> You seem to be arguing about some alternative design
> you had in mind, but readers don't have it in mind.
>
>
> Please just explain what this does and why.
> For what: something like "Trigger re-read of config - same
> as we'd do if config changed".
>
> Now, please do what you don't do here: explain the why:
>
>
> why do we want all these VM
> exits on each open/close as opposed to once on probe and later on
> config changed interrupt.

Fine, the main reason is that a config interrupt might be pending
during ifdown and core may disable configure interrupt due to several
reasons.

Thanks


>
>
> > +             virtio_config_changed(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             virtnet_update_settings(vi);
> > +             netif_carrier_on(dev);
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Make sure config notification doesn't schedule config work */
> > +     virtio_config_disable(vi->vdev);
> > +     /* Make sure status updating is cancelled */
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               cancel_work_sync(&vi->rq[i].dim.work);
> >       }
> >
> > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_dev=
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
> > @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *v=
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


