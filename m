Return-Path: <netdev+bounces-141849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1729BC849
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A0628227F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D061BD50C;
	Tue,  5 Nov 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXbKzF44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A770837
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796417; cv=none; b=OOa1OaV8CdgXQnbPf8k63GXBVl5FfOZhiMgfvxo9zKJN9j+JDaHZua1tmVQIzFGaTxjw9HAosnQYpfEyVPa6B9KdlOBiOjd3Mjrw1tJN95+cAj9mRssxVahaU3cEA8RjBxLVqlwKQyEJtowYT0NmKxhQaeDWxLlMhjsLYMU6gEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796417; c=relaxed/simple;
	bh=lz46w3w9y3OIp9uhJnKaTVCU1Vb4YxR1Pa7KZVnb+M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YamG1KqQ64uqkmZNGsK6sRBa4tgCikNgXXZr8WcdCVgZ0bk+V9DKF2tYzBlDdsBDyv2BEe1NyIPHbqL/ZVDXzp4eUBP1Wb53sHfmPliQmR3JlCdZOOG71e4V2ogRT0BOgkzk+Sy7vHIrzyrIr8NaoidFer+6IBR6j4LrIkbkRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXbKzF44; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso5482300e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730796414; x=1731401214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iMhZkDS+u7rLshm1oK3Z/OFVvJH+7ihkLEqZbSBHvw=;
        b=EXbKzF44jLQFM0+A33i9We+BGx4m+Q92phqUKWigz+BybtT0B5jWKqQmRM61gH3uAy
         9ByvIP+r2bfED1CvTew3gsfSsWkvywXBsL59GKQHU+6MLzbatdgyO6sgW+rDDsC7pcB6
         UrevHlMHzcCrGLvrhiJdCB8kxjI+79G/VxlXz007LZ2n/zi8PPE0FJouHoGBHUhJa4Er
         Cw0oKRtQEW9+v85XPw8EVPqxJIWtF+YA0sBFpXB3Rgi4rYevnEGHb7iwx8Dvio9MzjfW
         8I/I9uHENCfBs4lurl4wvbwKTpIl94iP+uS06nDVsiFUNH+tZAfNotdv9VXicQbtyXP6
         H4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730796414; x=1731401214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iMhZkDS+u7rLshm1oK3Z/OFVvJH+7ihkLEqZbSBHvw=;
        b=f4qEH5C1PTlnuxWclu9utPmiCvnXd6GoSt0bu+p4XsCuIiR6xKGZOISSfEV+jmVN3U
         IEDgU/LrbPxSMWV5jTHLpblUZsBlesEy9WPlbkyfZBzHvjjqtsubSvVVPluP8bFmV08W
         w/MpdApBOH8CAfpfNPnbjU12C4mq/RsUNxA+XCt8Q4KyzYPGoqNkuFCBd67fegGxbksS
         v9cDgMAL6luPlJiO9wVvQp6vdT2g78pEfP8WzV1z2jBTtiMgwyyLj3BKSCruEWCQsNPu
         uMKqIDv8zGJN7mE6z4KLY5s3VIzV5AldfoOmAWcyXvF31zpXYSRpOpu9seZsKTLO7thN
         upTA==
X-Forwarded-Encrypted: i=1; AJvYcCVinXZvlqR1wHJS1D94tlEtwvoN+uS3us17nsUKGElHkkz5yxcNiHh859u0/DCuwTo0qbgVbPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZy9zDUnkHpkSS8Ilqik/hesUG1zOqBil7oEU/gEkzrMOz0zBi
	2WUJjR83DXMt0SUzUlVA68KzMkKLcdc9Otnn9sHz+w1a24L0uXoa49pkqdVpnvIkEw++B/aHxpN
	Lr/6UP8q9WzBcSD+zvK/29V6O3d2ILEybxOXnWOLNJpqeLRJSBh8Y
X-Google-Smtp-Source: AGHT+IFgPIw15hlQO2evJi2mffY2eV1XrscJG5+iJsl0I3vYoNcrPdeJ1KR3RrJmYdNqM8VevD2Vnoox+piUb5YJ64s=
X-Received: by 2002:a05:6402:90e:b0:5ce:b1da:3003 with SMTP id
 4fb4d7f45d1cf-5ceb928c6f6mr11152661a12.20.1730796400869; Tue, 05 Nov 2024
 00:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104152622.3580037-1-edumazet@google.com> <20241104204005.86813-1-kuniyu@amazon.com>
In-Reply-To: <20241104204005.86813-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 09:46:29 +0100
Message-ID: <CANn89iJ09MAg5Zf0b7LPby--1YVi9vcwKQDDGH=E5_Bvw1P89Q@mail.gmail.com>
Subject: Re: [PATCH net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: courmisch@gmail.com, davem@davemloft.net, eric.dumazet@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon,  4 Nov 2024 15:26:22 +0000
> > Calling synchronize_rcu() while holding rcu_read_lock() is not
> > permitted [1]
>
> Thanks for catching this !
>
> >
> > Move the synchronize_rcu() to route_doit().
> >
> > [1]
> > WARNING: suspicious RCU usage
> > 6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
> > -----------------------------
> > kernel/rcu/tree.c:4092 Illegal synchronize_rcu() in RCU read-side criti=
cal section!
> >
> > other info that might help us debug this:
> >
> > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > 1 lock held by syz-executor427/5840:
> >   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquir=
e include/linux/rcupdate.h:337 [inline]
> >   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock i=
nclude/linux/rcupdate.h:849 [inline]
> >   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: route_doit+0x3d=
6/0x640 net/phonet/pn_netlink.c:264
> >
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6.12.0-rc5-sy=
zkaller-01056-gf07a6e6ceb05 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >   lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
> >   synchronize_rcu+0xea/0x360 kernel/rcu/tree.c:4089
> >   phonet_route_del+0xc6/0x140 net/phonet/pn_dev.c:409
> >   route_doit+0x514/0x640 net/phonet/pn_netlink.c:275
> >   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6790
> >   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
> >   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
> >   sock_sendmsg_nosec net/socket.c:729 [inline]
> >   __sock_sendmsg+0x221/0x270 net/socket.c:744
> >   sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
> >   new_sync_write fs/read_write.c:590 [inline]
> >   vfs_write+0xaeb/0xd30 fs/read_write.c:683
> >   ksys_write+0x183/0x2b0 fs/read_write.c:736
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit().")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Remi Denis-Courmont <courmisch@gmail.com>
> > ---
> >  net/phonet/pn_dev.c     |  4 +++-
> >  net/phonet/pn_netlink.c | 10 ++++++++--
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> > index 19234d664c4fb537eba0267266efbb226cf103c3..578d935f2b11694fd1004c5=
f854ec344b846eeb2 100644
> > --- a/net/phonet/pn_dev.c
> > +++ b/net/phonet/pn_dev.c
> > @@ -406,7 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 dad=
dr)
> >
> >       if (!dev)
> >               return -ENOENT;
> > -     synchronize_rcu();
> > +
> > +     /* Note : our caller must call synchronize_rcu() */
> > +
> >       dev_put(dev);
>
> Are these synchronize_rcu() + dev_put() paired with rcu_read_lock()
> and dev_hold() in phonet_route_output() ?

This dev_put() was before your patch.

It is paired the dev_hold() in phonet_route_add()

>
> If so, we need to move dev_put() too or maybe we can remove
> synchronize_rcu() here and replace rcu_read_lock() with
> spin_lock(&routes->lock) in phonet_route_output().

Not at all, let's not make phonet slower than needed :)

