Return-Path: <netdev+bounces-106379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16235916098
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AE41F2140F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D6146D6C;
	Tue, 25 Jun 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC9EA9Lw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06078145B3F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302676; cv=none; b=ELKG4J/MBu/+YrgrTtfqCd+D/9hGdG9MEQKCa4RQXxkFm9jst0ld33rnLvJTRa7PHUC/S/GAwSZDKSepkD0aQmzN8Cyx4LP4II8rDMwEpw821vYVXpJClf5ETnT6XuHSSFjIvWO8n6bcSThPsVmW2oV+7QsxZoarUTn7tU4IHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302676; c=relaxed/simple;
	bh=jdAl9hgOe+lm4QJHggd51ixmWg6oswKRPQGrQWVujIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ1jdtI2pE0i/bztBnrmxxc4ZmtMjJo85zqgM8UwCX7HlTAGp1TWmxWysYi65mo8DiHNj2zHYXO6GIMQ6bxirGXxI0JdITzP5DLSp6ffTpbhWVBAyo4fh73lolmXXjKvnmYFIibG11L0WDseUyLo4KY1deEzaghaEPm6QZ2oiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC9EA9Lw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719302673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSS73y9Kiy+O00pohzbPddbUXuAkYxpsCkdkEqZR1A8=;
	b=dC9EA9LwTjOqWs4UHkf+PUWWPyEixclNhE30/oZlQ+vJUAa3zwu96l8ulgaWzmqF6zuf4l
	h+9nspxYYIH90A9BAkHucCdSiBRecEva6Rn/NOGATYlS1Cqw4unQk4xy4UTllUBlHBOmoX
	yPFDnZmNgkkQyxMF2OIU7pdhzZgjMU4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-_uwnbil7P3-BtoiEjdAu-Q-1; Tue, 25 Jun 2024 04:04:26 -0400
X-MC-Unique: _uwnbil7P3-BtoiEjdAu-Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d157cb3fcso2438996a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302666; x=1719907466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSS73y9Kiy+O00pohzbPddbUXuAkYxpsCkdkEqZR1A8=;
        b=PLXn1TBvHdCG6ZplZtIf6PHtUub9wQCOt6rtHikdv2ZBIaUHVoGi7T+lw762dk8Zf4
         lCKpxe4o56tjVvOnAQLCLKPo0T2wP1/Y3+HKtXTauyM7rx5Utgd39HLgp2XyV0KghJ7h
         s4OU1NvOZ68+4MH3mHWc3EklBOXz7yslquKTxMWTq3OazbUc8C7B1UD58KA6NcJ4Ngxa
         GpR++oveGclsqvsWLEqPp690MZekpg/sOWsQUJm4EqQU/tz8ow4ZuTdJMD+6G2JlPKOG
         sTjmp6QdsMJS/kKUS48iSkvU0D8KSXfWVxqG09QOkmM0yEgLNViUvKXIyvUsH+mE0LJb
         Iuyg==
X-Forwarded-Encrypted: i=1; AJvYcCWzEDLBLMkKA/8JCgCNU4D7lFONDcoXedsyXXzXMhtUsDQbpqq2f979wIOBCCVx61V8BZC07AKqJJBL6ETFjgZQ9oGOb4G3
X-Gm-Message-State: AOJu0YxLQhY3O7OMbWJ1tpTOBCQXHTUMuS42VxZz63Qlo8tUvXQkv6B/
	B7ko7hryFIbxHM42ekbTDFf+0aIEcGmWJe/CMS9xALP2cnm9xFFmPldDiSeTYqiVe4RATp1MPOK
	rf6l4UCS/tNhkWcekMpS+USeJgZyK0isSbJPqcY1VKIZxYZisCPV0cA==
X-Received: by 2002:a50:aa9d:0:b0:57d:ef3:c3b7 with SMTP id 4fb4d7f45d1cf-57d4580ab11mr5326060a12.36.1719302665575;
        Tue, 25 Jun 2024 01:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoYzcue/Hrd6k4TsIo7q/NbJMBliNIcO2bdnok/sTeZ5hfgBoqKAK4z/dZ6sDP+eLnFv6wNA==
X-Received: by 2002:a50:aa9d:0:b0:57d:ef3:c3b7 with SMTP id 4fb4d7f45d1cf-57d4580ab11mr5326012a12.36.1719302664647;
        Tue, 25 Jun 2024 01:04:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5827db501d9sm96342a12.7.2024.06.25.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:04:24 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:04:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240625035746-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
 <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org>
 <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>

On Tue, Jun 25, 2024 at 03:50:30PM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 3:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 09:27:04AM +0800, Jason Wang wrote:
> > > On Mon, Jun 24, 2024 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> > > > > Somtime driver may want to enable or disable the config callback. This
> > > > > requires a synchronization with the core. So this patch change the
> > > > > config_enabled to be a integer counter. This allows the toggling of
> > > > > the config_enable to be synchronized between the virtio core and the
> > > > > virtio driver.
> > > > >
> > > > > The counter is not allowed to be increased greater than one, this
> > > > > simplifies the logic where the interrupt could be disabled immediately
> > > > > without extra synchronization between driver and core.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio.c | 20 +++++++++++++-------
> > > > >  include/linux/virtio.h  |  2 +-
> > > > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index b968b2aa5f4d..d3aa74b8ae5d 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
> > > > >  {
> > > > >       struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > > > >
> > > > > -     if (!dev->config_enabled)
> > > > > +     if (dev->config_enabled < 1)
> > > > >               dev->config_change_pending = true;
> > > > >       else if (drv && drv->config_changed)
> > > > >               drv->config_changed(dev);
> > > > > @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
> > > > >  static void virtio_config_disable(struct virtio_device *dev)
> > > > >  {
> > > > >       spin_lock_irq(&dev->config_lock);
> > > > > -     dev->config_enabled = false;
> > > > > +     --dev->config_enabled;
> > > > >       spin_unlock_irq(&dev->config_lock);
> > > > >  }
> > > > >
> > > > >  static void virtio_config_enable(struct virtio_device *dev)
> > > > >  {
> > > > >       spin_lock_irq(&dev->config_lock);
> > > > > -     dev->config_enabled = true;
> > > > > -     if (dev->config_change_pending)
> > > > > -             __virtio_config_changed(dev);
> > > > > -     dev->config_change_pending = false;
> > > > > +
> > > > > +     if (dev->config_enabled < 1) {
> > > > > +             ++dev->config_enabled;
> > > > > +             if (dev->config_enabled == 1 &&
> > > > > +                 dev->config_change_pending) {
> > > > > +                     __virtio_config_changed(dev);
> > > > > +                     dev->config_change_pending = false;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > >       spin_unlock_irq(&dev->config_lock);
> > > > >  }
> > > > >
> > > >
> > > > So every disable decrements the counter. Enable only increments it up to 1.
> > > > You seem to be making some very specific assumptions
> > > > about how this API will be used. Any misuse will lead to under/overflow
> > > > eventually ...
> > > >
> > >
> > > Well, a counter gives us more information than a boolean. With
> > > boolean, misuse is even harder to be noticed.
> >
> > With boolean we can prevent misuse easily because previous state
> > is known exactly. E.g.:
> >
> > static void virtio_config_driver_disable(struct virtio_device *dev)
> > {
> >         BUG_ON(dev->config_driver_disabled);
> >         dev->config_driver_disabled = true;
> > }
> >
> >
> >
> > static void virtio_config_driver_enable(struct virtio_device *dev)
> > {
> >         BUG_ON(!dev->config_driver_disabled);
> >         dev->config_driver_disabled = false;
> > }
> >
> >
> > Does not work with integer you simply have no idea what the value
> > should be at point of call.
> 
> Yes but I meant if we want the config could be disabled by different
> parties (core, driver and others)

For now, we don't have others ;)

> >
> >
> > > >
> > > >
> > > > My suggestion would be to
> > > > 1. rename config_enabled to config_core_enabled
> > > > 2. rename virtio_config_enable/disable to virtio_config_core_enable/disable
> > > > 3. add bool config_driver_disabled and make virtio_config_enable/disable
> > > >    switch that.
> > > > 4. Change logic from dev->config_enabled to
> > > >    dev->config_core_enabled && !dev->config_driver_disabled
> > >
> > > If we make config_driver_disabled by default true,
> >
> > No, we make it false by default.
> >
> > > we need someone to
> > > enable it explicitly. If it's core, it breaks the semantic that it is
> > > under the control of the driver (or needs to synchronize with the
> > > driver). If it's a driver, each driver needs to enable it at some time
> > > which can be easily forgotten. And if we end up with workarounds like:
> > >
> > >         /* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > >         if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > >                 virtio_device_ready(dev);
> > >
> > > It's another break of the semantics. And actually the above is also racy.
> > >
> > > It seems the only choice is to make config_driver_disabled by default
> > > false. But the driver needs to be aware of this and take extra care
> > > when calling virtio_device_ready() which is also tricky.
> >
> >
> > No, false by default simply means no change to semantics.
> 
> No change to current semantics, probably. But we need to document
> 
> 1) driver config is enabled by default
> 2) no nested enabling and disabling
> 
> If you think they are all fine, I can go with that way.

yes, a good idea to document this.


> >
> >
> > >
> > > So in conclusion, two booleans seems sut-optimal than a counter. For
> > > example we can use different bits for the counter as preempt_count
> > > did. With counter(s), core and driver don't need any implicit/explicit
> > > synchronization.
> > >
> > > Thanks
> > >
> >
> > We have a simple problem, we can solve it simply. reference counting
> > is tricky to get right and hard to debug, if we don't need it let us
> > not go there.
> 
> I fully agree, and that's why I limit the change to virtio-net driver
> in the first version.

I got that. I didn't like the code duplication though.

> >
> >
> >
> > But in conclusion ;) if you don't like my suggestion do something else
> > but make the APIs make sense,
> 
> I don't say I don't like it:)
> 
> Limiting it to virtio-net seems to be the most easy way. And if we
> want to do it in the core, I just want to make nesting to be supported
> which might not be necessary now.

I feel limiting it to a single driver strikes the right balance ATM.

> 
> > at least do better than +5
> > on Rusty's interface design scale.
> >
> > >
> 
> Thanks
> 
> 
> > >
> > >
> > > >
> > > >
> > > >
> > > >
> > > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
> > > > >               goto out_ida_remove;
> > > > >
> > > > >       spin_lock_init(&dev->config_lock);
> > > > > -     dev->config_enabled = false;
> > > > > +     dev->config_enabled = 0;
> > > > >       dev->config_change_pending = false;
> > > > >
> > > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index 96fea920873b..4496f9ba5d82 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > > >  struct virtio_device {
> > > > >       int index;
> > > > >       bool failed;
> > > > > -     bool config_enabled;
> > > > > +     int config_enabled;
> > > > >       bool config_change_pending;
> > > > >       spinlock_t config_lock;
> > > > >       spinlock_t vqs_list_lock;
> > > > > --
> > > > > 2.31.1
> > > >
> >


