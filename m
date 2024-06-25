Return-Path: <netdev+bounces-106304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FE915BAA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CE11F210F1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C11759F;
	Tue, 25 Jun 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE2BtO6b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123AD2F5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278841; cv=none; b=ohYAsAy1zPMYSxu95REyZFIWy+mfmt3iXHVIJtZof7EqtzMjC3l62Rp9n0gDcpU/uvtMPTBvpa0P3ZNXNZu1Jdhlzh7NDjUVb6f/Je/z8L78Jzhym6J/+JBA1xHHh4RdypJLYz6JNXicFjp/YblMFNfmYQBErsHEHwac/+1ZkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278841; c=relaxed/simple;
	bh=TFq2o81xj+D5mehszs/J2nrfGlk8SQ6E/cWnhm5ah28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGQ7ZkAWaUGLUsfKN5ivmEukmCB7NN67+vEo4KpEBlnxZU+XXQ+xTYYRmUiu5vm2GNkz+Z8eiYGAV1o32xPOtkc8BFkGUofDwfmSG2NYmSVAmDm7lbsIa1ymKCqboRmjPcSqJTf8L2M+8yyo+cvcMpOCHlUWieZzOGL5ZDKAR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE2BtO6b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719278838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8kQNb5EfD34yNxxFqVj4ciSTXL56yHsNDtkbrfwSnA=;
	b=JE2BtO6blY9RSLaQAbqMvkPrhPNLPgZ91JH6TQBys97Iqz//E8L8v94F4NF6N67E/c1fB5
	sWAVusBOI0S1984o0k4I083lEpD9bznudUj3+z2qdwSkBdM0mH8kobLdeg73MvQp3e8Mdt
	Sv7OQGdhjTpwn74NeI5ChIzXu+JKgg0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Fa1_ZWvkNoyg3S3fH4nvsw-1; Mon, 24 Jun 2024 21:27:17 -0400
X-MC-Unique: Fa1_ZWvkNoyg3S3fH4nvsw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7d2380cb8so4196543a91.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278836; x=1719883636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8kQNb5EfD34yNxxFqVj4ciSTXL56yHsNDtkbrfwSnA=;
        b=asOOcfclMQNnI5yH6Z7EAvEHz+l/w1ltEqUSSfuZbt7GxamzwMn1Hu9OvrR+0fLF66
         JbeMfySxXqz0y4TS1w1QcUC8azrlheyvKV12mAKA9icCqCWvkCG0hEC8tfbh3qcBqMgC
         S9cffAU+zlo5IRD8/famqXJyvB0ffTjK/fwenin17HaA2OqNrJ2DjwRNZvRwyBI8DNK3
         rLLYc4q4a4mcvDZbHLUs6KIs3fCv+XdwVPpAEQb1+vsEFyP1XY9uoNagoajg7NIIJZzo
         JdPVNI87I0cOisFqIay4EVevxchscsc4kJOhJwBY73dQ5CmiyuMgIoEIYZPaUi6HKwtY
         8UeA==
X-Forwarded-Encrypted: i=1; AJvYcCW1jttlmu/BX9NIqqj0LTFIRYs9kf5dRYjnXeemMNLX49RZEcUK6FCKk61WbVRsm5iPEGIYArMN8jyLreyfAlGVVzQCqW9c
X-Gm-Message-State: AOJu0YzkbIQtbobq/K0ZZNbIdFRVQ1JS250FEZraVHggbZJmBLHqBriT
	dPksuFDbgJ3MkaIvtCCiP2G6br/GzlWj8eRgtI3xx154oqEFfc52J8PhfxxUqViEBCOh0Spi/VV
	llUwXN2pu3VZ55OvXZHIrhW7iwoTywJ5lA/QisqfoCpjASVGXNnFj30xStwfmj2LAThyN56Dw+l
	pfiVdOadtT3XfugUIsLULmvFhz/YJg
X-Received: by 2002:a17:90a:8b01:b0:2c2:4109:9466 with SMTP id 98e67ed59e1d1-2c8489d8f30mr9022475a91.8.1719278835956;
        Mon, 24 Jun 2024 18:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaZd1XI0zjFhUOWrh+9gqh9bmzen3jQeqjhsvC/jP4PD6fYug8QP1qXJFVt0XNP3ctQaTxPl7ljlHve/nL4+A=
X-Received: by 2002:a17:90a:8b01:b0:2c2:4109:9466 with SMTP id
 98e67ed59e1d1-2c8489d8f30mr9022450a91.8.1719278835436; Mon, 24 Jun 2024
 18:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624054403-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 09:27:04 +0800
Message-ID: <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure interrupt
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> > Somtime driver may want to enable or disable the config callback. This
> > requires a synchronization with the core. So this patch change the
> > config_enabled to be a integer counter. This allows the toggling of
> > the config_enable to be synchronized between the virtio core and the
> > virtio driver.
> >
> > The counter is not allowed to be increased greater than one, this
> > simplifies the logic where the interrupt could be disabled immediately
> > without extra synchronization between driver and core.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio.c | 20 +++++++++++++-------
> >  include/linux/virtio.h  |  2 +-
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index b968b2aa5f4d..d3aa74b8ae5d 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_d=
evice *dev)
> >  {
> >       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> >
> > -     if (!dev->config_enabled)
> > +     if (dev->config_enabled < 1)
> >               dev->config_change_pending =3D true;
> >       else if (drv && drv->config_changed)
> >               drv->config_changed(dev);
> > @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
> >  static void virtio_config_disable(struct virtio_device *dev)
> >  {
> >       spin_lock_irq(&dev->config_lock);
> > -     dev->config_enabled =3D false;
> > +     --dev->config_enabled;
> >       spin_unlock_irq(&dev->config_lock);
> >  }
> >
> >  static void virtio_config_enable(struct virtio_device *dev)
> >  {
> >       spin_lock_irq(&dev->config_lock);
> > -     dev->config_enabled =3D true;
> > -     if (dev->config_change_pending)
> > -             __virtio_config_changed(dev);
> > -     dev->config_change_pending =3D false;
> > +
> > +     if (dev->config_enabled < 1) {
> > +             ++dev->config_enabled;
> > +             if (dev->config_enabled =3D=3D 1 &&
> > +                 dev->config_change_pending) {
> > +                     __virtio_config_changed(dev);
> > +                     dev->config_change_pending =3D false;
> > +             }
> > +     }
> > +
> >       spin_unlock_irq(&dev->config_lock);
> >  }
> >
>
> So every disable decrements the counter. Enable only increments it up to =
1.
> You seem to be making some very specific assumptions
> about how this API will be used. Any misuse will lead to under/overflow
> eventually ...
>

Well, a counter gives us more information than a boolean. With
boolean, misuse is even harder to be noticed.

>
>
> My suggestion would be to
> 1. rename config_enabled to config_core_enabled
> 2. rename virtio_config_enable/disable to virtio_config_core_enable/disab=
le
> 3. add bool config_driver_disabled and make virtio_config_enable/disable
>    switch that.
> 4. Change logic from dev->config_enabled to
>    dev->config_core_enabled && !dev->config_driver_disabled

If we make config_driver_disabled by default true, we need someone to
enable it explicitly. If it's core, it breaks the semantic that it is
under the control of the driver (or needs to synchronize with the
driver). If it's a driver, each driver needs to enable it at some time
which can be easily forgotten. And if we end up with workarounds like:

        /* If probe didn't do it, mark device DRIVER_OK ourselves. */
        if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
                virtio_device_ready(dev);

It's another break of the semantics. And actually the above is also racy.

It seems the only choice is to make config_driver_disabled by default
false. But the driver needs to be aware of this and take extra care
when calling virtio_device_ready() which is also tricky.

So in conclusion, two booleans seems sut-optimal than a counter. For
example we can use different bits for the counter as preempt_count
did. With counter(s), core and driver don't need any implicit/explicit
synchronization.

Thanks





>
>
>
>
> > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *de=
v)
> >               goto out_ida_remove;
> >
> >       spin_lock_init(&dev->config_lock);
> > -     dev->config_enabled =3D false;
> > +     dev->config_enabled =3D 0;
> >       dev->config_change_pending =3D false;
> >
> >       INIT_LIST_HEAD(&dev->vqs);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 96fea920873b..4496f9ba5d82 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> >  struct virtio_device {
> >       int index;
> >       bool failed;
> > -     bool config_enabled;
> > +     int config_enabled;
> >       bool config_change_pending;
> >       spinlock_t config_lock;
> >       spinlock_t vqs_list_lock;
> > --
> > 2.31.1
>


