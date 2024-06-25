Return-Path: <netdev+bounces-106372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCE91604F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44FB1F22D2F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBD1474AE;
	Tue, 25 Jun 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLS+cTZg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DA146D76
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301629; cv=none; b=KmlytYnkw8dezOPfmSkfYMa8AjgVycMTUS6GCdwr01DQiEchyM1r8Au9KUSDTjA5+VmVqo969OyDJxeulRJSSg9OJ2c5oUmM0zPyXqqaRo1fpeg3DkhLrv4ARNS/5L0qX8dXu/8mGVfY96Vg3eun3lWnCMtb90rvWNSx/dfFYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301629; c=relaxed/simple;
	bh=AgEdGFRlzxq13iNkT33ceYYAdgyNaBdPfg8YBCvTwrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9RGCTMKXJk2/ln8mmbSIcMXJpadMfD7pWJhSiu5ocfz1UU2txHKj9pctvL2O3hGzYZbsjQuYL6BXfd39jb7NMpK13WZDu1GD/ppYvmgEMtytAXW/MP8TCXf5MmxCtmvW0YBzzR96f9ofq1ApKTMGuaFUzY/SsAcmQ0KsG3uMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLS+cTZg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719301626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXuRueWXMrw0//4BwJxmj02bU1X+gIXBgkrl4FbZrQk=;
	b=FLS+cTZg+sjnSMYTPMR3Q+mvkDw37B8qBD1Fj5zjoIuMU5nt16T860Er/xyXfzoIMgQYN3
	rqi6oaI8vqp7V99LYGJR4TJGLOQ3kQyHhamxyUWHeYycLpbYNsd3Lo6JeWT5tG2Lnt93Xa
	TfKuEoy7vqYFlbFkoNOCsuJ3RurOI2c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-UsjhXF8xMIWiPghdLLvk-A-1; Tue, 25 Jun 2024 03:47:04 -0400
X-MC-Unique: UsjhXF8xMIWiPghdLLvk-A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-718c62ad099so4446135a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301623; x=1719906423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXuRueWXMrw0//4BwJxmj02bU1X+gIXBgkrl4FbZrQk=;
        b=qnI0DmrBUT2aYAVj65a/7vqBIF6+cA2gjUIbwx+eEdzq/ISQSLdI+kBF787Nxtb916
         ZjTrzBQLxZorapa8pI1jAvbFKHPdd5V+XGmvvDjLIWQgRvk5OrNNsQvilNk6rRVA8HNv
         QSLDQ5QUSYmhkAMeqXlfA+00SPxOMidQefbtvXRDftOLbXFOtsNsJtvHsn+AikCw6fJ7
         Zp+nW+43+9+Tdl07ss4FMWAZUSKaS9CpcFx/E0J3kXD09PuX4/4WLtF9uGaigzCJlIhu
         sdtBxAkaVUTYD/da31//52Z9/KtYanOhxzPSYSVAIklZj2PgSVGaRHEtdQLYR7RxmYV1
         6kDg==
X-Forwarded-Encrypted: i=1; AJvYcCVAtN7/zWyinjV4vYTX1l1+6jqqUmIWEblxH0Z1J4CwLMU6rhazBzh6tuSPXzEZqChg1z9Mzm4r4n4kZEYyKzGET27Vvy7X
X-Gm-Message-State: AOJu0Yx+uAKr1RJPfMS3IEonnD9xIZTh9hWBH/n783ITFZWUZrW6hj7E
	TIVWEjj627s0ZCow0L0Qjag5n4N7I5Iswlg9iegpxCzZlPMf/gIxM5FDsIZrSAgmFVOO1YkMXfu
	hanAp3awdlaYrW/m9c459Bs9zMcdsegM8ssG5fmdDFlS3a+bgrX1wjDhUPp0+m8WOcmXj4ouPvt
	3HIxUEQ2T8Ow1BmEoY2Kxq0fmkhTcg
X-Received: by 2002:a05:6a20:3ca5:b0:1bd:23de:e7e4 with SMTP id adf61e73a8af0-1bd23dee903mr356336637.3.1719301623322;
        Tue, 25 Jun 2024 00:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDBTj4XX23FYA275C5j9thFxHEkaAUx2Cd6m+DopLZnApVjmLiVAChHUsfAHgOor/2y/EzG1/i6EoKemT44lQ=
X-Received: by 2002:a05:6a20:3ca5:b0:1bd:23de:e7e4 with SMTP id
 adf61e73a8af0-1bd23dee903mr356319637.3.1719301622765; Tue, 25 Jun 2024
 00:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625031455-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 15:46:44 +0800
Message-ID: <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
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

On Tue, Jun 25, 2024 at 3:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 09:27:38AM +0800, Jason Wang wrote:
> > On Mon, Jun 24, 2024 at 6:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
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
> > > >  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-------------=
----
> > > >  1 file changed, 42 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index b1f8b720733e..eff3ad3d6bcc 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct =
virtnet_info *vi, int qp_index)
> > > >       return err;
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
> > > > @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *d=
ev)
> > > >                       goto err_enable_qp;
> > > >       }
> > > >
> > > > +     /* Assume link up if device can't report link status,
> > > > +        otherwise get link status from config. */
> > > > +     netif_carrier_off(dev);
> > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             virtio_config_enable(vi->vdev);
> > > > +             /* We are not sure if config interrupt is disabled by
> > > > +              * core or not, so we can't schedule config_work by
> > > > +              * ourselves.
> > > > +              */
> > >
> > > This comment confuses more than it explains.
> > > You seem to be arguing about some alternative design
> > > you had in mind, but readers don't have it in mind.
> > >
> > >
> > > Please just explain what this does and why.
> > > For what: something like "Trigger re-read of config - same
> > > as we'd do if config changed".
> > >
> > > Now, please do what you don't do here: explain the why:
> > >
> > >
> > > why do we want all these VM
> > > exits on each open/close as opposed to once on probe and later on
> > > config changed interrupt.
> >
> > Fine, the main reason is that a config interrupt might be pending
> > during ifdown and core may disable configure interrupt due to several
> > reasons.
> >
> > Thanks
>
> If the config changes exactly as command is executing?
> Then we'll get an interrupt later and update.

Workqueue is used to serialize those so we won't lose any change.

Currently the interrupt is only used to:

1) update link status, so according to rfc2863, no need to do that
when the interface is admin down
2) announce the link, it's also meaningless to announce the link when
the interface is down.

Or anything I miss here?

> You can't always win this race, even if you read it can
> change right after.

Thanks

>
>
> >
> > >
> > >
> > > > +             virtio_config_changed(vi->vdev);
> > > > +     } else {
> > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +             virtnet_update_settings(vi);
> > > > +             netif_carrier_on(dev);
> > > > +     }
> > > > +
> > > >       return 0;
> > > >
> > > >  err_enable_qp:
> > > > @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device =
*dev)
> > > >       disable_delayed_refill(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > > +     /* Make sure config notification doesn't schedule config work=
 */
> > > > +     virtio_config_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > > > +     cancel_work_sync(&vi->config_work);
> > > >
> > > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > >               virtnet_disable_queue_pair(vi, i);
> > > >               cancel_work_sync(&vi->rq[i].dim.work);
> > > >       }
> > > >
> > > > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > > > +     netif_carrier_off(dev);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net=
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
> > > > @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_devic=
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


