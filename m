Return-Path: <netdev+bounces-114805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE2944422
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA611F20419
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A7170A13;
	Thu,  1 Aug 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbTOcpOp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C68170A02
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492816; cv=none; b=LcoEGbzgsBsPZ4ihus7nwwEQ+FTdiDg00tTYczBhkd3ScNiPiEIr99bW/f9sOXQimls6FBZjcdNUo5ORcLLl5NhEHzG1Lj2eLLLuvM3yGYt9yz/zJ+IcPLYmBg4CFlwd+lUf9KiMcPaEw7lJkAPJEVr+n+ZDGrxuILdsU/RqFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492816; c=relaxed/simple;
	bh=xKmXPWxcWyaUd8tDKHhbzOC9Wt5MRRHYTUlepiECDRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/nI8633+Qh/GBTjNLfM/yzudNHYjSw29fwAOmA/S/zpcQxIqypx5QQIl4AO58G/3jwp9aqAFNoxCEJ7bSY21fYSrZaRMO2TSW8NErzF5/no47O5CrlEoSghtDpsMNpTmkz+J0VS/JEzujxVgyt8tc1w2WHOOT9x5HjeIxdz3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbTOcpOp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722492813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIY7FTpGT9UjcMy+x0teV1zr33WWvG/GjniOJ5Es5Xo=;
	b=gbTOcpOpLossvULXUCvgjop7Yw28Ohz9GR4uH1tPPRyGjsuK/kLo7b5Ln8p4NdmFxXNKHm
	5MdZ4QGOFdKjTAaoB3aUQHzIR/YbsMqVeYXn7HoQwXxb8RbfFHBTtdD0OsVIVn9zeN31rN
	JRxEnggM2UmFUN65Eu9C2NekCBv5imA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-sOber0e-P_-RFJ6vlcC1zQ-1; Thu, 01 Aug 2024 02:13:32 -0400
X-MC-Unique: sOber0e-P_-RFJ6vlcC1zQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7a28217cfecso6825428a12.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492811; x=1723097611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIY7FTpGT9UjcMy+x0teV1zr33WWvG/GjniOJ5Es5Xo=;
        b=H5kDHCugV6ytNSNOur+oNoRfr3VNsfdJrgbwPcMSrsPRv0O3gcileXut2LADYkc3eB
         d9NoL2sDg32oSx30oWjZseFMMOdWrXQ9wvsHxwjvZJfUDQh04vk+/8pEbb3nZiCDsdhk
         STt/9w6a66efAUx4idxauP/JlF6Vcqv7I5MvnK7USu/FlCTVbcVoePLxvliVBcmFsTmY
         S9zgt+MAuNUmydybVGFwy/5ykwuWHBD8G7y6YtfEzt44/di38HSWxl8Qf4kLlB0c7gZc
         sEjxP4OLLT+4oUXoQ1dHrhfNiWvF+n6CjKagIWnvYz+ibqxBLIOFJsSff+58XLvwEQ6+
         PKbA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0e3oMfeKkQX03UDjq0jXq7mNYdxtgVEI8Yxixoz/JINfVUq7Q9vmQtJop9tSymCzB4XfPeUAIIAUPGfCa1esJL4+rrB9
X-Gm-Message-State: AOJu0YyI42j4HxTPb9kajq9+Dq/QYXoW99GKkuJZSFy4FEcXb/GGeBU9
	iTFioH9DVlhipf8BbAclopzC24ACQApvVa+5ZOvmB1bsCV2bDR52uemXV3+cNbpIJjEDtS+V7Qi
	lcrljarGGGyy3xZu7JYW0Z6uBw7BxdLoVSknLNXN8xjqDLdpLkxMxnHpM+7lm8aiVqLZHH483o0
	grKeb205wMBs7PmKvenLJgJFrp8gsh
X-Received: by 2002:a05:6a20:914f:b0:1be:c929:e269 with SMTP id adf61e73a8af0-1c68d0270f3mr2374338637.34.1722492811267;
        Wed, 31 Jul 2024 23:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY0U3r9f0bMsnnjn/d48QqLtBqSaMitlZrQfZm2ufPzt3F6BQUQlPgO/udGS4JKPAiLQhLgZE5LdZidATH6a8=
X-Received: by 2002:a05:6a20:914f:b0:1be:c929:e269 with SMTP id
 adf61e73a8af0-1c68d0270f3mr2374308637.34.1722492810630; Wed, 31 Jul 2024
 23:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org> <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801015344-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 14:13:18 +0800
Message-ID: <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 1:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
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
> > >
> > > I already commented on this approach.  This is now invoked on each op=
en,
> > > lots of extra VM exits. No bueno, people are working hard to keep set=
up
> > > overhead under control. Handle this in the config change interrupt -
> > > your new infrastructure is perfect for this.
> >
> > No, in this version it doesn't. Config space read only happens if
> > there's a pending config interrupt during ndo_open:
> >
> > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > +                       netif_carrier_on(vi->dev);
> > +               virtio_config_driver_enable(vi->vdev);
> > +       } else {
> > +               vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +               netif_carrier_on(dev);
> > +               virtnet_update_settings(vi);
> > +       }
>
> Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> I do not see why do we need to bother re-reading settings in this case at=
 all,
> status is not there, nothing much changes.

Ok, let me remove it from the next version.

>
>
> > >
> > >
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
> > >
> > > it's clear what this does even without a comment.
> > > what you should comment on, and do not, is *why*.
> >
> > Well, it just follows the existing style, for example the above said
> >
> > "/* Make sure refill_work doesn't re-enable napi! */"
>
> only at the grammar level.
> you don't see the difference?
>
>         /* Make sure refill_work doesn't re-enable napi! */
>         cancel_delayed_work_sync(&vi->refill);
>
> it explains why we cancel: to avoid re-enabling napi.
>
> why do you cancel config callback and work?
> comment should say that.

Something like "Prevent the config change callback from changing
carrier after close"?

>
>
>
> > >
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > >
> > > same
> > >
> > > also what "status updating"? confuses more than this clarifies.
> >
> > Does "Make sure the config changed work is cancelled" sounds better?
>
> no, this just repeats what code does.
> explain why you cancel it.

Does something like "Make sure carrier changes have been done by the
config change callback" works?

Thanks

>
>
>
> --
> MST
>


