Return-Path: <netdev+bounces-123371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA7964A1A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8FC1C242E2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682E1B3F0A;
	Thu, 29 Aug 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKv9zzdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A71B2EF2
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945507; cv=none; b=UYzDwygUiVTPO6w+7PVyIoRkVOXMmZT0HINWd7OPgb0f1MNr37s5P8g4HZeXDwVe73++E4GVZWFO4dsutrIL+R/Mg94ycKsMIfswGjGcGiz+g+EkXeF2vLOrX3AfngCc0TWXLYs+yuzfZwNj39W/nvRSQA0CbMS9SouJLS1CBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945507; c=relaxed/simple;
	bh=HJmwn/0JFnzsnQnzKr8gkbD+ep4LL2U46xq8HCPKOfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hDxFvp7o9T5HVtww/rNENxACIt9XYH2t84eMrPsUODk67zUaRf91dQ1bLULohDOpc81aUWoMAU3hvPj9mhaazzneGeG4kXEKAb9uh1qgiZRjxPMvl94uj/VhlUipDbOEInaq3ygacUNnoaHZOWkkJBeW1oL0KcDS07n1wk1FRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKv9zzdq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5343617fdddso1471796e87.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724945503; x=1725550303; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U1YaxDrIZa5AMVlFHNmIflB8sd0no/S8DXcr9Xwqxg=;
        b=CKv9zzdqGnxK30sccuDFjpeOLYQW4LC4eoH+2xS28l8563eqXHPWPw4cIOTRftjUey
         CNpzUdi1yYultXRG25CTjP771zm6mCvoArfUdGGxwGAz80ki5e0TuZvTA//K9g9bxLjj
         g5S4n2ZlHoGfsN2fVwH3dLiz6dx9iHkflRnmXZo5wUPnLNHo51W1qCmrfgh0CA5wTrCo
         xnTWW7mCsvtEKFqAb6NPEOfjtsl+skJRkOv2xmoOXbU7JNrXaki2aeO5x0G/1FHLIQkH
         6MvTvuAvixWsML7FMGC1y+8183dQN7Dx4WwS8sBypEYS81aBxnhRUZiBSRGAcVZi/tx+
         WKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945503; x=1725550303;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U1YaxDrIZa5AMVlFHNmIflB8sd0no/S8DXcr9Xwqxg=;
        b=no8ANy5pz2kaAHylz9xcJztGHRoiBcUeXS/EGoOtPejqUBdrqy0Lz0xp71ECjlGrdw
         NJ88DxrMiUUQopioTsd0sjwqXPZ7fvKGLrN4DHDOSXPF7sg1j8MulTwnoZsnceCmdJi/
         /p2wp409vQ9pgyFWWB0cGXQGxwVLyCmHpd/oWuJVKLuh2lkhQj31glvUYbCTuKkMBtV8
         z9Umd0RammL9gaqwXBfRQyUTJvzL2Ya9Rjzfl7kvOQ+gbB0kTswOC+E51zhxZht4nrnZ
         2wA61cpuFrWpZsYN+OiT52uBMHb76WpWPwoPn0UMFiXRvg/bs22MRb9HsbnILSs5rVyl
         DoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiEYZbukKLm4uUd3Dc4k1xgHCyTpXlFNI1XDAxRJxbTMNYpoMGxS7DBu8GIACWFYfkn8Z0UDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjpTnUw6zqrtpoK6nmIBsSeahgGJuVDs/hoe5SOsuGHn7WTZFC
	R/fFrdnBVK5c7NuN9WOt+wjGRgmlDQf/OzBuDLlwt7KhkJMFx/pdNNI3W0Mps0bI6iHI3cWObfe
	4M8Sk+na0C5qeMjO9cr/n7SdRX8ZLflhiXC3TyJ+fLFBUjmwYMw==
X-Google-Smtp-Source: AGHT+IEU6GOaXKR9I2jPDVOQ4lVSi6XXLtyFi4pPPM5bH2cZUJwcifL4f/1ZEBLGQ9soQOhjCYDh5zF2yVTZbC+r6GE=
X-Received: by 2002:a05:6512:3d05:b0:535:3da7:5b59 with SMTP id
 2adb3069b0e04-5353e5431d9mr3651290e87.12.1724945501915; Thu, 29 Aug 2024
 08:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-4-jdamato@fastly.com>
 <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com> <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
In-Reply-To: <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 17:31:30 +0200
Message-ID: <CANn89iJgXsn7yjWaiuuq=LFsKpQi8RQFo89MDRxeNddxeZUC2A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, sdf@fomichev.me, 
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org, 
	willemdebruijn.kernel@gmail.com, skhawaja@google.com, kuba@kernel.org, 
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:28=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Thu, Aug 29, 2024 at 03:48:05PM +0200, Eric Dumazet wrote:
> > On Thu, Aug 29, 2024 at 3:13=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Allow per-NAPI gro_flush_timeout setting.
> > >
> > > The existing sysfs parameter is respected; writes to sysfs will write=
 to
> > > all NAPI structs for the device and the net_device gro_flush_timeout
> > > field.  Reads from sysfs will read from the net_device field.
> > >
> > > The ability to set gro_flush_timeout on specific NAPI instances will =
be
> > > added in a later commit, via netdev-genl.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > ---
> > >  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
> > >  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
> > >  net/core/net-sysfs.c      |  2 +-
> > >  3 files changed, 55 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 7d53380da4c0..d00024d9f857 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -372,6 +372,7 @@ struct napi_struct {
> > >         int                     rx_count; /* length of rx_list */
> > >         unsigned int            napi_id;
> > >         int                     defer_hard_irqs;
> > > +       unsigned long           gro_flush_timeout;
> > >         struct hrtimer          timer;
> > >         struct task_struct      *thread;
> > >         /* control-path-only fields follow */
> > > @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct=
 *n, int defer);
> > >   */
> > >  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer=
);
> > >
> >
> > Same remark :  dev->gro_flush_timeout is no longer read in the fast pat=
h.
> >
> > Please move gro_flush_timeout out of net_device_read_txrx and update
> > Documentation/networking/net_cachelines/net_device.rst
>
> Is there some tooling I should use to generate this file?
>
> I am asking because it seems like the file is missing two fields in
> net_device at the end of the struct:
>
> struct hlist_head          page_pools;
> struct dim_irq_moder *     irq_moder;
>

At first glance this is control path only, no big deal.

> Both of which seem to have been added just before and long after
> (respectively) commit 14006f1d8fa2 ("Documentations: Analyze heavily
> used Networking related structs").
>
> If this is a bug, I can submit one patch (with two fixes tags) which
> adds both fields to the file?

No need for a Fixes: tag for this, just submit to net-next.

This file is really 'needed' for current development, for people
caring about data locality.

