Return-Path: <netdev+bounces-184117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54482A9362C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABDE1B60C73
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FD2571B2;
	Fri, 18 Apr 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLCVt4IF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF3155C82
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973578; cv=none; b=GYccDHW+seJmm8wid3PsX8A0sS21/bhnjs6b/ngNikkiUZFjdgKMyHnMSEc19bmyGw8Iajh+nD/KpRPq3ur+vuIvrIYHWwJQdssHrk720u6IBx/OrbSlb9aK/YQM40GPjzfSPF97XrQzEo8+5bxD7+EKO9QQ/9ERHCqiwwgUcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973578; c=relaxed/simple;
	bh=tO4rRABdrAXcH8J/1mMfDNXkrVSYN5oXDVNClrrNKt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/Os93qCsR6CyurAAqpxBYOydGO+K2M0+Of+YaYheiYDrQsjp2XgUwy6a+jXotSn87wEA6hBkMsLAZ9h+7PpxnDEwkPVvm+A6CVunEqGawnrUVZmN6FlY5v1NjasOjZGeYULOAM83uNW+dutNLWH2oWO1hcDoN6P07N79PRExFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLCVt4IF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so609175a12.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973575; x=1745578375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO4rRABdrAXcH8J/1mMfDNXkrVSYN5oXDVNClrrNKt0=;
        b=BLCVt4IF4Iy+6AEsS4dOAe2rxD6FXXQ74+xiwshgWSHdD/WWODEbTDEjhNsRByIhCN
         sMXuilkMZnVF3SSU4nY1CY8s3EfMHmPVSftW1fUJS1+7UiL0QMnRQWtonPHLyqROJo7B
         5oHHW/zbcBAdaagjaft83TYKE6Ti0zpuQOLnqu2kyLDNdvAzFKVJRZ+MXq47X7ksqjnn
         UexJYDhThNcKy2x7HGJMzbXmbk+oBujG9ni0ropGuChBE/OgrgJQ2dLJjakAfRz8xCr1
         fDXh2YIexd1F23y3N6TMTOSoKVhZ6dfHs1CoZGf1OuBLFUvCcctT5DYRSvEySgLznrqx
         kX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973575; x=1745578375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO4rRABdrAXcH8J/1mMfDNXkrVSYN5oXDVNClrrNKt0=;
        b=a7ad0vLOjVY0sFXL54KxhFsY0XZjh+wTwRDPH6M0bgair1uzbBxQeZt+fvRUrntfSO
         kh4IYroU5i1meMUmfHigAluJgb6lgmh9uclvMQ14cAZ1UyzFzQaGOktB4MV7KY92/GTo
         yvhCgoxG2AKjeSjzs3Myyn8glK9gdnJPQprtn1yRymgc8RS9nk5LzaljtfxLH3l9n4jy
         9vZs7ws5Dky2RqUdTHLc+Wptn6ATVdpNko0hr5udRoAoDsp/otuawzl3puNdIMtO/4OT
         TAwhEYYsTjTOZdjylfEG/8k8gR87j30y2q/5io927LeKAaRlIuOOX3WaX3/Ey0AR5bC7
         E/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVPTiheDhlY4eRs03NCzd7PErSbAMZDDcIoOdg4V8XeC35K0tvTXRyRXw+nwrM9dDMe4i2EKis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBF8XA0GyTXn+GZpaGFLmc7Zvg5dXRzhOxAkWnj2xE7DRYL3r
	1xm0corqSfxKF5hzX6olCCpCVKGjV2aNufQLobQbAGUwgE4+nckCzB/2ztp9kheu0bf5vyuLhqu
	rKxJZXa3l5mTdJuvK3rJh4Ee/ffg=
X-Gm-Gg: ASbGncvk1ZomhdYiDbryw+jOzA8S+g6IR55iY+b6kqvjg9y1CNuswOW0vYcIZLdk4GP
	oqkGhBzTF/2Gj1scd5hRV0TgBw8k9I1jYprZ3i/A/Nk8DR/WL7nyrJXyoPu7Hvj6mDI0GiVNWbN
	1fIsGK4m3Q7LYFvrcBzObrOpY=
X-Google-Smtp-Source: AGHT+IG0e3i/7R7gsV6D/q18ZzfggRf33x7H+NAijiyhLibn73pFfy/Ikqrpt/VSENDpCqAzRCThSWKaykePZlDuwrI=
X-Received: by 2002:a05:6402:350c:b0:5f3:fbb4:b258 with SMTP id
 4fb4d7f45d1cf-5f628543c7emr1821823a12.14.1744973574868; Fri, 18 Apr 2025
 03:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
 <CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
 <20250416172711.0c6a1da8@kernel.org> <CAHS8izMV=0jVnn5KO1ZrDc2kUsF43Re=8e7otmEe=NKw7fMmJw@mail.gmail.com>
In-Reply-To: <CAHS8izMV=0jVnn5KO1ZrDc2kUsF43Re=8e7otmEe=NKw7fMmJw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 18 Apr 2025 19:52:43 +0900
X-Gm-Features: ATxdqUGn3KCANxipq2hgnmKgdmO41gap4i-CYeppKJKLywTLxfRcf15sEf9A878
Message-ID: <CAMArcTVog3pUQtXrytyRppkXvwBH6mHvcTsh9OsHZ3zPQYytiQ@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 6:07=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Apr 16, 2025 at 5:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 16 Apr 2025 08:47:14 -0700 Mina Almasry wrote:
> > > > Right, tho a bit of work and tricky handling will be necessary to g=
et
> > > > that right. We're not holding a ref on binding->dev.
> > > >
> > > > I think we need to invert the socket mutex vs instance lock orderin=
g.
> > > > Make the priv mutex protect the binding->list and binding->dev.
> > > > For that to work the binding needs to also store a pointer to its
> > > > owning socket?
> > > >
> > > > Then in both uninstall paths (from socket and from netdev unreg) we=
 can
> > > > take the socket mutex, delete from list, clear the ->dev pointer,
> > > > unlock, release the ref on the binding.
> > >
> > > I don't like that the ref obtained by the socket can be released by
> > > both the socket and the netdev unreg :( It creates a weird mental
> > > model where the ref owned by the socket can actually be dropped by th=
e
> > > netdev unreg path and then the socket close needs to detect that
> > > something else dropped its ref. It also creates a weird scenario wher=
e
> > > the device got unregistered and reregistered (I assume that's
> > > possible? Or no?) and the socket is alive and the device is registere=
d
> > > but actually the binding is not active.
> >
> > I agree. But it's be best I could come up with (and what we ended up
> > with in io-uring)...
> >
> > > > The socket close path would probably need to lock the socket, look =
at
> > > > the first entry, if entry has ->dev call netdev_hold(), release the
> > > > socket, lock the netdev, lock the socket again, look at the ->dev, =
if
> > > > NULL we raced - done. If not NULL release the socket, call unbind.
> > > > netdev_put(). Restart this paragraph.
> > > >
> > > > I can't think of an easier way.
> > > >
> > >
> > > How about, roughly:
> > >
> > > - the binding holds a ref on dev, making sure that the dev is alive
> > > until the last ref on the binding is dropped and the binding is freed=
.
> > > - The ref owned by the socket is only ever dropped by the socket clos=
e.
> > > - When we netdev_lock(binding->dev) to later do a
> > > net_devmem_dmabuf_unbind, we must first grab another ref on the
> > > binding->dev, so that it doesn't get freed if the unbind drops the
> > > last ref.
> >
> > Right now you can't hold a reference on a netdevice forever.
> > You have to register a notifier and when NETDEV_UNREGISTER triggers
> > you must give up the reference you took. Also, fun note, it is illegal
> > to take an "additional reference". You must re-lookup the device or
> > otherwise safely ensure device is not getting torn down.
> >
> > See netdev_wait_allrefs_any(), that blocks whoever called unregister
> > until all refs are reclaimed.
> >
> > > I think that would work too?
> > >
> > > Can you remind me why we do a dev_memory_provider_uninstall on a
> > > device unregister? If the device gets unregistered then re-registered
> > > (again, I'm kinda assuming that is possible, I'm not sure)
> >
> > It's not legal right now. I think there's a BUG_ON() somewhere.
> >
>
> Thanks, if re-registering is not possible, that makes this a lot simpler.
>
> > > I expect it
> > > to still be memory provider bound, because the netlink socket is stil=
l
> > > alive and the userspace is still expecting a live binding. Maybe
> > > delete the dev_memory_provider_uninstall code I added on unregister,
> > > and sorry I put it there...? Or is there some reason I'm forgetting
> > > that we have to uninstall the memory provider on unregister?
> >
> > IIRC bound_rxqs will point to freed memory once the netdev is gone.
> > If we had a ref on the netdev then yeah we could possibly potentially
> > keep the queues around. But holding refs on a netdev is.. a topic for
> > another time. I'm trying to limit amount of code we'd need to revert
> > if the instance locking turns out to be fundamentally broken :S
>
> OK, no need to hold a reference, please ignore that suggestion. Thanks
> for the detailed explanation.
>
> There are a lot of suggestions flying around at the moment as you
> noted so I'll refrain from adding more and I'll just review the next
> version. Agree with what Jakub says below, please do send Taehee even
> if it's not perfect, this may need some iteration.

Thanks for the review!
I=E2=80=99ll send the patch over shortly.

Thanks!
Taehee Yoo

>
> --
> Thanks,
> Mina

