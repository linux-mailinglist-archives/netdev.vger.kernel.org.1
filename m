Return-Path: <netdev+bounces-114801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB39442F5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803601C217EE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E57142651;
	Thu,  1 Aug 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFb+jWb0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61213E03E
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491930; cv=none; b=adVCRNnovQUWUpdybmwuaUFIbEi7BI73VureCmzVz/vNQyYk7mgXe4iHZnNcdIQ10MpFZ/NgVZpk5agsHP7zW6pKxrQJqmVr1XRosuG+7X+yVr+08B4F0KBtLO/myTF66B38xZE+KfpB1smyPDJbh7c3540C0vXSXE6gK1H1Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491930; c=relaxed/simple;
	bh=BQeirBRuPNmOYvkj19aFRvVKY+QYqsgfJredh3tRZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO8SYB/FrAdwQxg77Y/R/dkzvSsJQsiGyaENBeZx4Zu16oT0p1VXQA8g/eEAEd5o2+ezMKtIX1FeJJqug/zCKkQhw1W79d0JGEU4PUlljpWDQi+gYmUhVKIazhBOaTSXA3S3W/22fNYZC6mYw3iAdUaLkQeawaL+aEo7o9u/5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFb+jWb0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722491927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
	b=cFb+jWb0PG680w/jRhkDlgswPAR2TcWJxvDQF8hRG3thnJCydsrAB1EeiFV7L3RlYcsdup
	/LQgwtlCR9KDfgvvWcSx9um6If98qsv1JiHQLMgdbnl5qR5NI09JDpt5+Zh2MyzUeBB9rR
	kTldnCNDkEZ4ZIreKS9s2Z0Ey3jW8vw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-c0V_KP7tPyamM2vaZlAogw-1; Thu, 01 Aug 2024 01:58:46 -0400
X-MC-Unique: c0V_KP7tPyamM2vaZlAogw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52f00bde29dso8607390e87.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491925; x=1723096725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
        b=gbZvfihFreT4LvzHLXy+0XEAsZAatsiCWkLwYJnaDX3yVB7HMW8uHJt5Te1CbocXv/
         /FYSNUWd2CXai30VXBRq/0rBXQhVpPpN0cy+O6jqIiDRVn9cGPCjTDQV8lZwijRKlVPs
         xNMVAU/v35RsT2ZlvwWDrIvoigIS3ckWVOVSANliK03XZ/eH1Y39xiBG9T0rs+JoIcSZ
         9VqP348NTNA2chmCRKBwBjcPbXPE7QGwk5O6u8Vaia0QQM9FnNBJ5SUWr1BWXf5E7k3n
         GUVTUdJU9Cy4dsHZSf7IgHKuYKT6jmrnrGkLmOVf1zYDRkeo2zgktx5xrfLP4zQNLQv0
         kYZg==
X-Forwarded-Encrypted: i=1; AJvYcCXgebUY7xTZeyFqZJma1cK0eHQD25LQVf1om8PrxHPcJ3yth79ivbluoP3w5t+kXtCTQ5tJQ24qvuWI6X+KE7kqEmAQIqEJ
X-Gm-Message-State: AOJu0YxxfvFifMYeMj9ArU/ZxXFswLxFvnYFJ2GZWdvipRZzlu2NR2Sh
	ELi9WraGA3BJMI+woAPCX7gOnrQxHh8tjCE3IiaKEpNKgHOZkdHmfX9Y/dM9ZkAtdodT+Jg0Qbn
	vY8fs1o+si4cLFzDKFzyWqN757fS0bSXzdqZJV996ZAVEnrGRrKcBtg==
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028196e87.42.1722491924839;
        Wed, 31 Jul 2024 22:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBq5LsXMOtvElE6EOfY6fVtQyD07R6xmuzAO4uy70HRKTviw+Ngzs8GylVhzOCWgj7uUzpg==
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028165e87.42.1722491923947;
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41479sm849692166b.123.2024.07.31.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:58:36 -0400
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
Message-ID: <20240801015344-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
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
> >
> > I already commented on this approach.  This is now invoked on each open,
> > lots of extra VM exits. No bueno, people are working hard to keep setup
> > overhead under control. Handle this in the config change interrupt -
> > your new infrastructure is perfect for this.
> 
> No, in this version it doesn't. Config space read only happens if
> there's a pending config interrupt during ndo_open:
> 
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> +                       netif_carrier_on(vi->dev);
> +               virtio_config_driver_enable(vi->vdev);
> +       } else {
> +               vi->status = VIRTIO_NET_S_LINK_UP;
> +               netif_carrier_on(dev);
> +               virtnet_update_settings(vi);
> +       }

Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
I do not see why do we need to bother re-reading settings in this case at all,
status is not there, nothing much changes.


> >
> >
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
> >
> > it's clear what this does even without a comment.
> > what you should comment on, and do not, is *why*.
> 
> Well, it just follows the existing style, for example the above said
> 
> "/* Make sure refill_work doesn't re-enable napi! */"

only at the grammar level.
you don't see the difference?

        /* Make sure refill_work doesn't re-enable napi! */
        cancel_delayed_work_sync(&vi->refill);

it explains why we cancel: to avoid re-enabling napi.

why do you cancel config callback and work?
comment should say that.



> >
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> >
> > same
> >
> > also what "status updating"? confuses more than this clarifies.
> 
> Does "Make sure the config changed work is cancelled" sounds better?

no, this just repeats what code does.
explain why you cancel it.



-- 
MST


