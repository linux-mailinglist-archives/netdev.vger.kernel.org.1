Return-Path: <netdev+bounces-114809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB194449F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1E61F22E00
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E858158539;
	Thu,  1 Aug 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0RkExqC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92437158219
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494522; cv=none; b=Bg3ehmeA3YvO13jYTWdEtKEwc+GfvQFQligA0rDg86lUfe7AAz6XWvn48b8zGOJVznxJ6T2jq1EbmImdnIXgCqZfmAyEOo40wCaka7vWGXVLoMpuWJnPsiI6Hsyn48Hi/eLtn+b8/TnqHUlnO9PXedXFVAuBtfZSfTA1mompZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494522; c=relaxed/simple;
	bh=ONPlwqgsSwpfRRn9JHD2Mbq2Sn2i4FFtY8EerdBkBIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4WD3ih6YeAmT55dud5+oWc8dHso0bQvnbH/5IuXmvKE85Zvlla8gGJChh+rY/ngx4CrTX6nMnpCtiCjPFGXF6QWzSMNnS/JaGGlWascySspuRJL7IJBKUuvI3vx2xtdRIZwePSaewi9SRKcuJr8IinzBxreJa389FJ/D31cj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0RkExqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TawFxjl8nzx90uXykegTmmxOqKJ1FqGRkr4dkAN2BZc=;
	b=F0RkExqCZqLHUl68406JzEtfKia5+I67pXKNCAK89Q5gah88IGU5SJoidpgeTFO7G461rP
	If0qsvLOwjGCl5KyBdGIKhcC4uQ/lrFy/qiU0nXPvv6HGvvS36sKRCxf7qj61zScEsJzOx
	CwGrLU3b1fz9iq9XuQovu3bLb44KgOM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-KGhC0m93OMii7TYZSvb_5Q-1; Thu, 01 Aug 2024 02:41:57 -0400
X-MC-Unique: KGhC0m93OMii7TYZSvb_5Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a745917ef7so2654051a12.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494516; x=1723099316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TawFxjl8nzx90uXykegTmmxOqKJ1FqGRkr4dkAN2BZc=;
        b=Osh9UXHsCEP7oa4Zp0ejhERoA5Dv1BlQ4ZzBTirscl9T7Vr10SBW8zeY4iT2vIWpJy
         jBKpfoaP3ld0P93Ichg2+dgxDCyQK7J4uUqRzNUawxnsmIksIV3kzjbNrIkyTNVb2OdL
         YDVHllByYHzP0E9ArAmdk4CN3FLaQx7sQNIK0oWKXwaEMqeZjXEKcjAZVAfOo71QkFGJ
         iIE1aJam0QzXU6dJ55CnKhs1qyUULi3thH+Ue6J2mPkGMvePBALMub+1mNV/47VnHh/x
         RkEdUXuQN8BkoOY5N6noBa21D7lVQTOL/7TF6yZ23HwJp9OluI7m4Id8DzQj7Iw6l4Es
         a5SA==
X-Forwarded-Encrypted: i=1; AJvYcCVEc7HxtA9RMs8m7bEEpM6p12bqVesM9rycJY3L/2/wFgDGmI+WInpQdp2E9dMNi4b7Mo/jm+YJmLHNXtmB3GieAFlOqNEO
X-Gm-Message-State: AOJu0YxsjZK/HWi+ZesPpBc8kaqfwhjP71Wzns2C/bDFXD9Oh52EHPX8
	DPjY/0bNzJCp9BMIFfNT85xJObNjgvLmGUSbZSpCR4V/vbjQFHNowUKjIKb/hh0xRrML4ipvwkH
	80NnKdD8c9IPrJLMHxOZMgk8Ubm0qx8DChEIx5cJq+ldLcORtOU8mdw==
X-Received: by 2002:aa7:d0cb:0:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5b700f81311mr921581a12.35.1722494515741;
        Wed, 31 Jul 2024 23:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuymEMetUjHr1Ev0KFWrRFuLScNLkGQ/meZSzIJWkY0dxNy2lm8YTQLTJyXEWNfuT7QsXObg==
X-Received: by 2002:aa7:d0cb:0:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5b700f81311mr921555a12.35.1722494514978;
        Wed, 31 Jul 2024 23:41:54 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af2f233be4sm8435006a12.41.2024.07.31.23.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:41:53 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:41:47 -0400
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
Message-ID: <20240801024012-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org>
 <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:13:18PM +0800, Jason Wang wrote:
> On Thu, Aug 1, 2024 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > > > >       net_dim_work_cancel(dim);
> > > > >  }
> > > > >
> > > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > > +{
> > > > > +     u32 speed;
> > > > > +     u8 duplex;
> > > > > +
> > > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > > +             return;
> > > > > +
> > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > > > +
> > > > > +     if (ethtool_validate_speed(speed))
> > > > > +             vi->speed = speed;
> > > > > +
> > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > > > +
> > > > > +     if (ethtool_validate_duplex(duplex))
> > > > > +             vi->duplex = duplex;
> > > > > +}
> > > > > +
> > > >
> > > > I already commented on this approach.  This is now invoked on each open,
> > > > lots of extra VM exits. No bueno, people are working hard to keep setup
> > > > overhead under control. Handle this in the config change interrupt -
> > > > your new infrastructure is perfect for this.
> > >
> > > No, in this version it doesn't. Config space read only happens if
> > > there's a pending config interrupt during ndo_open:
> > >
> > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > +                       netif_carrier_on(vi->dev);
> > > +               virtio_config_driver_enable(vi->vdev);
> > > +       } else {
> > > +               vi->status = VIRTIO_NET_S_LINK_UP;
> > > +               netif_carrier_on(dev);
> > > +               virtnet_update_settings(vi);
> > > +       }
> >
> > Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> > I do not see why do we need to bother re-reading settings in this case at all,
> > status is not there, nothing much changes.
> 
> Ok, let me remove it from the next version.
> 
> >
> >
> > > >
> > > >
> > > > >  static int virtnet_open(struct net_device *dev)
> > > > >  {
> > > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > > > >                       goto err_enable_qp;
> > > > >       }
> > > > >
> > > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > +                     netif_carrier_on(vi->dev);
> > > > > +             virtio_config_driver_enable(vi->vdev);
> > > > > +     } else {
> > > > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > > > +             netif_carrier_on(dev);
> > > > > +             virtnet_update_settings(vi);
> > > > > +     }
> > > > > +
> > > > >       return 0;
> > > > >
> > > > >  err_enable_qp:
> > > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
> > > > >       disable_delayed_refill(vi);
> > > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > > >       cancel_delayed_work_sync(&vi->refill);
> > > > > +     /* Make sure config notification doesn't schedule config work */
> > > >
> > > > it's clear what this does even without a comment.
> > > > what you should comment on, and do not, is *why*.
> > >
> > > Well, it just follows the existing style, for example the above said
> > >
> > > "/* Make sure refill_work doesn't re-enable napi! */"
> >
> > only at the grammar level.
> > you don't see the difference?
> >
> >         /* Make sure refill_work doesn't re-enable napi! */
> >         cancel_delayed_work_sync(&vi->refill);
> >
> > it explains why we cancel: to avoid re-enabling napi.
> >
> > why do you cancel config callback and work?
> > comment should say that.
> 
> Something like "Prevent the config change callback from changing
> carrier after close"?


sounds good.

> >
> >
> >
> > > >
> > > > > +     virtio_config_driver_disable(vi->vdev);
> > > > > +     /* Make sure status updating is cancelled */
> > > >
> > > > same
> > > >
> > > > also what "status updating"? confuses more than this clarifies.
> > >
> > > Does "Make sure the config changed work is cancelled" sounds better?
> >
> > no, this just repeats what code does.
> > explain why you cancel it.
> 
> Does something like "Make sure carrier changes have been done by the
> config change callback" works?
> 
> Thanks

I don't understand what this means.

> >
> >
> >
> > --
> > MST
> >


