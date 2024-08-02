Return-Path: <netdev+bounces-115192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B033994565A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF264B2203F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920B1BC4B;
	Fri,  2 Aug 2024 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzM1hgzs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D517758
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722566883; cv=none; b=dqu4ldJO8Kkpst+1ZP2KJR8qfdgMcNYUFLEPD4Afrrz7yeC+3LHgQE9C3JhH9dK9q95sLVYccL1C5EZceoGtAj9X545SCpJHkROlnPUkxn4IK494gfzguhX0IDFvT1BfAu2489XmJFbxbSTMGh8EbVk2GMyED878LKYXBk0Dy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722566883; c=relaxed/simple;
	bh=2Z7F72icVevQ1klL6R8O/uXtJuDgEBr7qbZrA7LfdCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQWbQY/cQXMc6crgjCX8ANlcgO2xaB4z5PsmJGJFRVHf5vECYN3vRLiiDNi3oCpBYkQUGM23z8oEYxUlWCGpUpQ01vH5NyJU3jjkRAb4HlFBSNgCRc3F5hl7sMGNWiopp6RGLUF8AqCLqwScxWqBYqkXmGPsvw29A4x5loLyV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzM1hgzs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722566880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPbaOUpXucwyKskl8GQVof98KSpY8idJ/l1lT8SrGMU=;
	b=ZzM1hgzsLc3kE4vCQxMjU3RtTa8C7bHQ08+LkTETn6LzRwv7St7sOqursThCbgIGjAcHjY
	hfr3GRiOIN+bgUAwIHX76T7IfiE7gmMfi6bOq0u15cHsDZW7Od+kddNr76vN6vPmyt+C/3
	ZLcnchzHsWTFE5PfEmR/YHtNKp/83Qk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ue73WBpvO7iddIGNLCs0zA-1; Thu, 01 Aug 2024 22:47:58 -0400
X-MC-Unique: ue73WBpvO7iddIGNLCs0zA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb696be198so7820727a91.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 19:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722566878; x=1723171678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPbaOUpXucwyKskl8GQVof98KSpY8idJ/l1lT8SrGMU=;
        b=A/q9TA9/+Ptsw+Gmbs4DhCeJs70aBcqBIfDE0eKBf57bxvoUbDOqkmAQKQMt0OY3jT
         /CtHoQlK7rEU1r14ermWvW21R6tl4LY9Y/xgo5NrSJKJywPg/SKvLXwjMX34nWU/AbSX
         rtho71tnNc0alR9nADsxcoJjgAdL9PXm9Lz/h3Tx24/ZobYbwqeDyj8QAPOl/IgccdZt
         Fxkn1byUD9QY1fYz2CSanZfP1WBrZt+4WrjnSJljp3i/21ukECMm+/QgWPsgF9RP4Fkw
         CmyctHJtcGtYXKfmfryD7RgcZ2cINKFt6A05bLY9+NpM/jscfdLJ/PRDy/d8H8XduLy/
         Eulg==
X-Forwarded-Encrypted: i=1; AJvYcCWPLgJCwtL8XoWwLOCfryhWuly4aSwU43lAXhYj1PG6S6U3/mtV62zw/iknFW+UgXyXfvIlak4Qk/pDKjrAeRKXJ65HDB2y
X-Gm-Message-State: AOJu0YwSJIT3XX9N19TwOejbrLsd8GL4svZMEJMEj2Wym5/YDMOGuaWh
	B1H5YN5pDUZ8qfZ06OqQ7S8Exw99Aa56/oHRd3UzUXkdCyGBVWPbgV3jPoozoec9HH/OEjhx8ne
	rXcqEFVHgAvj4flNJG8FzieWulBrzv+WTV05Ia7Q5FDy4sHNFB0tvp6DqubFN9SUfHIR1Eo9IVH
	zJsA427YH+QPl74HwPLoH9M6WhRPJD
X-Received: by 2002:a17:90a:f312:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2cff93c8c70mr2602192a91.5.1722566877672;
        Thu, 01 Aug 2024 19:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLENXJVak8i6LUD6xkK9QeCQ0ui20F9d4wF1PE7Y7MhEpsWmqKdbHbMdIxvUwX7XDh8XJUw3RS6da5qlMqT4=
X-Received: by 2002:a17:90a:f312:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2cff93c8c70mr2602176a91.5.1722566877185; Thu, 01 Aug 2024
 19:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org> <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org> <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
 <20240801024012-mutt-send-email-mst@kernel.org> <CACGkMEu1MO_UWObYY99SVMigjbRv0oaaKZKqXeVjdiFmUzUM2A@mail.gmail.com>
 <20240801025654-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801025654-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Aug 2024 10:47:46 +0800
Message-ID: <CACGkMEtGMtg4ggTBv5GW-p2HqF9YUzpVGJYEmUdeGXeYoEwEkg@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 01, 2024 at 02:55:10PM +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Aug 01, 2024 at 02:13:18PM +0800, Jason Wang wrote:
> > > > On Thu, Aug 1, 2024 at 1:58=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > > > > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struc=
t virtnet_info *vi, struct dim *dim)
> > > > > > > >       net_dim_work_cancel(dim);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void virtnet_update_settings(struct virtnet_info *v=
i)
> > > > > > > > +{
> > > > > > > > +     u32 speed;
> > > > > > > > +     u8 duplex;
> > > > > > > > +
> > > > > > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_=
DUPLEX))
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, s=
peed, &speed);
> > > > > > > > +
> > > > > > > > +     if (ethtool_validate_speed(speed))
> > > > > > > > +             vi->speed =3D speed;
> > > > > > > > +
> > > > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, d=
uplex, &duplex);
> > > > > > > > +
> > > > > > > > +     if (ethtool_validate_duplex(duplex))
> > > > > > > > +             vi->duplex =3D duplex;
> > > > > > > > +}
> > > > > > > > +
> > > > > > >
> > > > > > > I already commented on this approach.  This is now invoked on=
 each open,
> > > > > > > lots of extra VM exits. No bueno, people are working hard to =
keep setup
> > > > > > > overhead under control. Handle this in the config change inte=
rrupt -
> > > > > > > your new infrastructure is perfect for this.
> > > > > >
> > > > > > No, in this version it doesn't. Config space read only happens =
if
> > > > > > there's a pending config interrupt during ndo_open:
> > > > > >
> > > > > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) =
{
> > > > > > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > > +                       netif_carrier_on(vi->dev);
> > > > > > +               virtio_config_driver_enable(vi->vdev);
> > > > > > +       } else {
> > > > > > +               vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > > > +               netif_carrier_on(dev);
> > > > > > +               virtnet_update_settings(vi);
> > > > > > +       }
> > > > >
> > > > > Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> > > > > I do not see why do we need to bother re-reading settings in this=
 case at all,
> > > > > status is not there, nothing much changes.
> > > >
> > > > Ok, let me remove it from the next version.
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > >  static int virtnet_open(struct net_device *dev)
> > > > > > > >  {
> > > > > > > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_d=
evice *dev)
> > > > > > > >                       goto err_enable_qp;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)=
) {
> > > > > > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > > > > +                     netif_carrier_on(vi->dev);
> > > > > > > > +             virtio_config_driver_enable(vi->vdev);
> > > > > > > > +     } else {
> > > > > > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > > > > > +             netif_carrier_on(dev);
> > > > > > > > +             virtnet_update_settings(vi);
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > >       return 0;
> > > > > > > >
> > > > > > > >  err_enable_qp:
> > > > > > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net=
_device *dev)
> > > > > > > >       disable_delayed_refill(vi);
> > > > > > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > > > > > >       cancel_delayed_work_sync(&vi->refill);
> > > > > > > > +     /* Make sure config notification doesn't schedule con=
fig work */
> > > > > > >
> > > > > > > it's clear what this does even without a comment.
> > > > > > > what you should comment on, and do not, is *why*.
> > > > > >
> > > > > > Well, it just follows the existing style, for example the above=
 said
> > > > > >
> > > > > > "/* Make sure refill_work doesn't re-enable napi! */"
> > > > >
> > > > > only at the grammar level.
> > > > > you don't see the difference?
> > > > >
> > > > >         /* Make sure refill_work doesn't re-enable napi! */
> > > > >         cancel_delayed_work_sync(&vi->refill);
> > > > >
> > > > > it explains why we cancel: to avoid re-enabling napi.
> > > > >
> > > > > why do you cancel config callback and work?
> > > > > comment should say that.
> > > >
> > > > Something like "Prevent the config change callback from changing
> > > > carrier after close"?
> > >
> > >
> > > sounds good.
> > >
> > > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > > +     virtio_config_driver_disable(vi->vdev);
> > > > > > > > +     /* Make sure status updating is cancelled */
> > > > > > >
> > > > > > > same
> > > > > > >
> > > > > > > also what "status updating"? confuses more than this clarifie=
s.
> > > > > >
> > > > > > Does "Make sure the config changed work is cancelled" sounds be=
tter?
> > > > >
> > > > > no, this just repeats what code does.
> > > > > explain why you cancel it.
> > > >
> > > > Does something like "Make sure carrier changes have been done by th=
e
> > > > config change callback" works?
> > > >
> > > > Thanks
> > >
> > > I don't understand what this means.
> >
> > Maybe "Ensure the configuration change callback successfully modifies
> > the carrier status"?
> >
> > Thanks
>
> I don't know what this means either.
> Do you mean:
>
> /* Stop getting status/speed updates: we don't care until next open */

Somehow yes.

Thanks

>
>
> > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


