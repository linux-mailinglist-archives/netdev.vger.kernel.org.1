Return-Path: <netdev+bounces-106362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FEC915FB6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A691F2264F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC731465B0;
	Tue, 25 Jun 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq6UPiEQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B601465BE
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299506; cv=none; b=ofn3G330dlyg/NbTDsajtCr+bcuGM9yw7K1fh9yBDNxUsbfSPVqLaAKWa7z7fckeC1YqxY3N2AiHbF7M710GVNOEczr8YrzP7ToS3UbzePFwXMv4HVGV051xMAyoNdngaHGhxR+9GbnppfgRlJKpgME+PPGhXHq7mSh5WVV0XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299506; c=relaxed/simple;
	bh=TLrvzNSGRIjfjk0ds0hDGYrbMsuv7YV9Cx8PsRvbsvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPPvNUr9j7gjssZXoF//+kkSZVw8Y79/sv3tlMiu74CI6w4YkOOuX6qDI7ziLcmeBodoQzD4kkXgHKSaAF1m+4N7V9zRlQcQA7NSnB1wDLS4ghxDJn8NW23IW5eRQBVF5+9Gfs1w4xgGQTs3Sff97BuRtMxdGn+Hw4dSs2AWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq6UPiEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719299503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnIdsJMqMkoDF6UPKRzG7Hc37h3V7D0wsMm0QIPwULU=;
	b=cq6UPiEQ/IEO3eokqd1njKcZGoJqm/v2ZN05x8Db6dEo2EzKBNOyweNlObzVuMqT9/KbIm
	fLh+iTeyqTD2drelqgvseDovEuc27k52+QeMXTU/BBd7hbZ1FPDReTL8qy04IYGFliBd8/
	KWaeKohRt1fUJrJdqrNWVKmq0FjLhbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-51qjJhBCNJSyAfJKogbJwA-1; Tue, 25 Jun 2024 03:11:41 -0400
X-MC-Unique: 51qjJhBCNJSyAfJKogbJwA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42476eda16cso3415635e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299500; x=1719904300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnIdsJMqMkoDF6UPKRzG7Hc37h3V7D0wsMm0QIPwULU=;
        b=gIJsAroCSTSoTWQf7F/cEGJNLyK+1mmkNRZHvaJodcE5HDqrmfeeo3dFQlyCDckU1m
         uwv9ORqZCYIGi2eEPCOD0kKF9C5AprqEDkiBP7qETiZtMSf5MXz+7zvbE9YwwKFirRjf
         7NgUDJNpnRADlE9uSuDyKsQiBM4h9zfszBk+D5BzfdtMBRuApuo+ZOtFdVChhSeYauAl
         geshohu5/j8964GJ5LmsOk1vpd/iICCQCU9f6DHQqr1wuFn6jHWZ5LP8gezRkJBSe2h1
         7Sy4b283Sfol2xBo+3VcBuQvBjWN3EpdRm0qBNPUo3QK1j39st95bRNMCLfFpDEjt2+F
         aXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwH94Xw1HZw16f1JY6GpkjuAJCsqgy9ILDAGzZlpUzxsFewcra4JBw9JLgUCaovVg+Kxy3pDkzVQPCSeI/OIvroROaXz3q
X-Gm-Message-State: AOJu0YzABaqBK5bMI7jevMkuamy24ukwp3XsfRLmU7+TezgDgQJNtWGp
	kWb1qu36AMfo4JZjqvoYgnPrF0cYANXyRWao0lj/1hhfUSZejlNqCXvl7M/FjPbcphtl5naHrLT
	hDoOf5OoZVbcPO3aSzT2mjgsQXCB5rvHyKyFEVMfsytzVGulW6zgoiA==
X-Received: by 2002:a05:600c:4fcb:b0:421:c211:a57e with SMTP id 5b1f17b1804b1-4248cc6673emr41636645e9.35.1719299500120;
        Tue, 25 Jun 2024 00:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLLu5OdsdrE20B7Tz2kH8m837OaXN5E0lckyzm0dvKRWIthJJP3coYroXleaJKHDI2+Pm53w==
X-Received: by 2002:a05:600c:4fcb:b0:421:c211:a57e with SMTP id 5b1f17b1804b1-4248cc6673emr41636375e9.35.1719299499386;
        Tue, 25 Jun 2024 00:11:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8ad2sm11987747f8f.33.2024.06.25.00.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:11:38 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240625030259-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
 <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>

On Tue, Jun 25, 2024 at 09:27:04AM +0800, Jason Wang wrote:
> On Mon, Jun 24, 2024 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> > > Somtime driver may want to enable or disable the config callback. This
> > > requires a synchronization with the core. So this patch change the
> > > config_enabled to be a integer counter. This allows the toggling of
> > > the config_enable to be synchronized between the virtio core and the
> > > virtio driver.
> > >
> > > The counter is not allowed to be increased greater than one, this
> > > simplifies the logic where the interrupt could be disabled immediately
> > > without extra synchronization between driver and core.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio.c | 20 +++++++++++++-------
> > >  include/linux/virtio.h  |  2 +-
> > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index b968b2aa5f4d..d3aa74b8ae5d 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
> > >  {
> > >       struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > >
> > > -     if (!dev->config_enabled)
> > > +     if (dev->config_enabled < 1)
> > >               dev->config_change_pending = true;
> > >       else if (drv && drv->config_changed)
> > >               drv->config_changed(dev);
> > > @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
> > >  static void virtio_config_disable(struct virtio_device *dev)
> > >  {
> > >       spin_lock_irq(&dev->config_lock);
> > > -     dev->config_enabled = false;
> > > +     --dev->config_enabled;
> > >       spin_unlock_irq(&dev->config_lock);
> > >  }
> > >
> > >  static void virtio_config_enable(struct virtio_device *dev)
> > >  {
> > >       spin_lock_irq(&dev->config_lock);
> > > -     dev->config_enabled = true;
> > > -     if (dev->config_change_pending)
> > > -             __virtio_config_changed(dev);
> > > -     dev->config_change_pending = false;
> > > +
> > > +     if (dev->config_enabled < 1) {
> > > +             ++dev->config_enabled;
> > > +             if (dev->config_enabled == 1 &&
> > > +                 dev->config_change_pending) {
> > > +                     __virtio_config_changed(dev);
> > > +                     dev->config_change_pending = false;
> > > +             }
> > > +     }
> > > +
> > >       spin_unlock_irq(&dev->config_lock);
> > >  }
> > >
> >
> > So every disable decrements the counter. Enable only increments it up to 1.
> > You seem to be making some very specific assumptions
> > about how this API will be used. Any misuse will lead to under/overflow
> > eventually ...
> >
> 
> Well, a counter gives us more information than a boolean. With
> boolean, misuse is even harder to be noticed.

With boolean we can prevent misuse easily because previous state
is known exactly. E.g.:

static void virtio_config_driver_disable(struct virtio_device *dev)
{
	BUG_ON(dev->config_driver_disabled);
	dev->config_driver_disabled = true;
}



static void virtio_config_driver_enable(struct virtio_device *dev)
{
	BUG_ON(!dev->config_driver_disabled);
	dev->config_driver_disabled = false;
}


Does not work with integer you simply have no idea what the value
should be at point of call.


> >
> >
> > My suggestion would be to
> > 1. rename config_enabled to config_core_enabled
> > 2. rename virtio_config_enable/disable to virtio_config_core_enable/disable
> > 3. add bool config_driver_disabled and make virtio_config_enable/disable
> >    switch that.
> > 4. Change logic from dev->config_enabled to
> >    dev->config_core_enabled && !dev->config_driver_disabled
> 
> If we make config_driver_disabled by default true,

No, we make it false by default.

> we need someone to
> enable it explicitly. If it's core, it breaks the semantic that it is
> under the control of the driver (or needs to synchronize with the
> driver). If it's a driver, each driver needs to enable it at some time
> which can be easily forgotten. And if we end up with workarounds like:
> 
>         /* If probe didn't do it, mark device DRIVER_OK ourselves. */
>         if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
>                 virtio_device_ready(dev);
> 
> It's another break of the semantics. And actually the above is also racy.
> 
> It seems the only choice is to make config_driver_disabled by default
> false. But the driver needs to be aware of this and take extra care
> when calling virtio_device_ready() which is also tricky.


No, false by default simply means no change to semantics.


> 
> So in conclusion, two booleans seems sut-optimal than a counter. For
> example we can use different bits for the counter as preempt_count
> did. With counter(s), core and driver don't need any implicit/explicit
> synchronization.
> 
> Thanks
> 

We have a simple problem, we can solve it simply. reference counting
is tricky to get right and hard to debug, if we don't need it let us
not go there.



But in conclusion ;) if you don't like my suggestion do something else
but make the APIs make sense, at least do better than +5
on Rusty's interface design scale.

> 
> 
> 
> >
> >
> >
> >
> > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
> > >               goto out_ida_remove;
> > >
> > >       spin_lock_init(&dev->config_lock);
> > > -     dev->config_enabled = false;
> > > +     dev->config_enabled = 0;
> > >       dev->config_change_pending = false;
> > >
> > >       INIT_LIST_HEAD(&dev->vqs);
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 96fea920873b..4496f9ba5d82 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > >  struct virtio_device {
> > >       int index;
> > >       bool failed;
> > > -     bool config_enabled;
> > > +     int config_enabled;
> > >       bool config_change_pending;
> > >       spinlock_t config_lock;
> > >       spinlock_t vqs_list_lock;
> > > --
> > > 2.31.1
> >


