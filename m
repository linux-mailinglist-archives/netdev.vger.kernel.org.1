Return-Path: <netdev+bounces-130276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E08989CD3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46096284C71
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94917BB0F;
	Mon, 30 Sep 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdTGEC2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321617C7A3
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685169; cv=none; b=myOt6/jmcNf20CaEn6eVJRs6yGnxtA/QtzEkMFQjNv710nMVp5OOXpgcz2Qu56RqnMVafoVlTVFCcIkagO7gOUe5IE9QQZAqfsYYhPF3zhK3W1JhDXNi9RPVdCTY5ojGZ0XBe0xRM10fvBJrifyk8dBVFwrXseDcXL6HY0wJVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685169; c=relaxed/simple;
	bh=4oAH2q5LgJa77lDdUdO3au+RMnFwx2NeZPL/DDhrb4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVLl2sdlV8MveCaqu9fU3HxG2qEteeFPaeYQqZQHcMBBnEjvobAYZPs1DmJWyjv7KljswtJz4OrLpk6lfny/M61o0wnfZh+smv5M2qP6yVAmXsgUW3MJg6t2iQC9e60/eHT0RBoZt4AaDWzTvSFv9ogI2tPFKpIez++67dRquPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdTGEC2C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so4491223a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727685165; x=1728289965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqQ+dGZVfXuccLMYgvXwuvTtFXbCCzWXTKFzhu6C6Ww=;
        b=IdTGEC2CYCPfh5D8x4awd/THJzOrVBNCIPP5VDBKdICE+SrfZjv324OKd5lwaLKViU
         mxPLDPlX/D6Xw8+XR+flIzIZP3JzqwX08qqds7FMaUc+3VxvbsrjsWGZIgz2QY94N4tk
         rvLLkltqlRwH+jna0vLse6JzcalyVGqVmknbW6JEOYX0zpJTvQoym7EZ/qeipr7Orwnd
         XiUsjEiygesVlmDrSTr36SwZOi050wAv02/7FlMTfoXO4TuP9NLLYhWxkGDKHL02CbHC
         lvRqD5OHCNlxWaZbZID2i2hBMEC+tEjoaR1WLZt+R3Q1W93MlDIzunWaTT0XmLJjivDf
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685165; x=1728289965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqQ+dGZVfXuccLMYgvXwuvTtFXbCCzWXTKFzhu6C6Ww=;
        b=WbGts1rnh3oJPabNmmqhcgL+3eEIFETvhTZTJ1kmq8acXjhVcvEBvdQxBcLSF+tYa9
         BOb7NH/wl3mCEjau9DmtKyT/YXc7fJYwAcKsJze3YoEf1VB46LewuQKPD5oi5TQIy/aj
         YK5jARlbmeo0QoJuHIIDdm9ptS8w0RbR5tpPQiGjHDXxF81UJ57hnHCmlcHfQEgqTPNT
         T05Aq0mueC1EKSDfbTwsvk2K7DNS9n8BrrtrGXP5LQBNH/s59vocsmKq30MFh/M1xOx/
         JdW2Zcfa86MA467r8uBfpq5ng5n6dB4tlCaB2ATNqXbpQyd99zzJqbTeMxx1+NSSgMOX
         tHHw==
X-Forwarded-Encrypted: i=1; AJvYcCU7V00Nj002Lz9NwOuHqaPzEAtc44p2fKL9ZyjjAdEkoyrfjn82k7uji6OVRsIkvi2D1kFq8K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywln9wkoZtMk/LWm8XimPV2qyHjq2EQMLKXU2CUl3Hv/LZZxcO8
	GsDNelm7aiIMKx9mIJ2lwbHztbB6O3/9x9qnrBzf4Th3kBDRHUNK067LjiGpIxCRKf/se5c5RHv
	Kf0H2jGEwrYiLd9Ws2PQh9VRHrCAB+fwKwW46
X-Google-Smtp-Source: AGHT+IHy8XeDUIiNC3SMc95v5D9yjZVVtIWK2fvcVeyJ1gkoxKp4d4Qxyo4bJzl+valSUmsdQ6necbmuLeN+6grlt18=
X-Received: by 2002:a05:6402:42cd:b0:5c3:cc6d:19df with SMTP id
 4fb4d7f45d1cf-5c8825fd803mr11505417a12.28.1727685164365; Mon, 30 Sep 2024
 01:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000657ecd0614456af8@google.com> <3483096f-4782-4ca1-bd8a-25a045646026@suse.de>
 <20240928122112.1412-1-hdanton@sina.com> <20240929114601.1584-1-hdanton@sina.com>
In-Reply-To: <20240929114601.1584-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Sep 2024 10:32:32 +0200
Message-ID: <CANn89iJwe-Q2Ve3O1OP4WTVuD6eawFvV+3eDvuvs4Xk=+j5yBg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
To: Hillf Danton <hdanton@sina.com>
Cc: Denis Kirjanov <dkirjanov@suse.de>, 
	syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:46=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Sat, 28 Sep 2024 20:21:12 +0800 Hillf Danton <hdanton@sina.com>
> > On Mon, 25 Mar 2024 14:08:36 +0100 Eric Dumazet <edumazet@google.com>
> > > On Mon, Mar 25, 2024 at 1:10=E2=80=AFPM Denis Kirjanov <dkirjanov@sus=
e.de> wrote:
> > > >
> > > > Hmm, report says that we have a net_device freed even that we have =
a dev_hold()
> > > > before __ethtool_get_link_ksettings()
> > >
> > > dev_hold(dev) might be done too late, the device is already being dis=
mantled.
> > >
> > > ib_device_get_netdev() should probably be done under RTNL locking,
> > > otherwise the final part is racy :
> > >
> > > if (res && res->reg_state !=3D NETREG_REGISTERED) {
> > >      dev_put(res);
> > >      return NULL;
> > > }
> >
> > Given paranoia in netdev_run_todo(),
> >
> >               /* paranoia */
> >               BUG_ON(netdev_refcnt_read(dev) !=3D 1);
> >
> > the claim that dev_hold(dev) might be done too late could not explain
> > the success of checking NETREG_REGISTERED, because of checking
> > NETREG_UNREGISTERING after rcu barrier.
> >
> >       /* Wait for rcu callbacks to finish before next phase */
> >       if (!list_empty(&list))
> >               rcu_barrier();
> >
> >       list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> >               if (unlikely(dev->reg_state !=3D NETREG_UNREGISTERING)) {
> >                       netdev_WARN(dev, "run_todo but not unregistering\=
n");
> >                       list_del(&dev->todo_list);
> >                       continue;
> >               }
> >
> As simply bumping kref up could survive the syzbot reproducer [1], Eric's=
 reclaim
> is incorrect.

I have about 50 different syzbot reports all pointing to netdevsim and
sysfs buggy interaction.

We will see if you can fix all of them :)

>
> --- l/drivers/infiniband/core/verbs.c
> +++ v/drivers/infiniband/core/verbs.c
> @@ -1979,6 +1979,7 @@ int ib_get_eth_speed(struct ib_device *d
>         netdev =3D ib_device_get_netdev(dev, port_num);
>         if (!netdev)
>                 return -ENODEV;
> +       dev_hold(netdev);
>
>         rtnl_lock();
>         rc =3D __ethtool_get_link_ksettings(netdev, &lksettings);
> @@ -1995,6 +1996,7 @@ int ib_get_eth_speed(struct ib_device *d
>                                 netdev->name, netdev_speed);
>         }
>
> +       dev_put(netdev);
>         ib_get_width_and_speed(netdev_speed, lksettings.lanes,
>                                speed, width);
>
> --
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
>
> [1] https://lore.kernel.org/lkml/66f9372f.050a0220.aab67.001a.GAE@google.=
com/

