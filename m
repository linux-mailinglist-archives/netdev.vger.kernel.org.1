Return-Path: <netdev+bounces-232095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7EDC00E97
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EA018C7B78
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251E30EF7B;
	Thu, 23 Oct 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsXB9ZTF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CE29BDA3
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220467; cv=none; b=ZuVcnUUfkevRULoiGCLKTwkQnX2KyYj1ETGf11g+1BOeB0Rf1sVIBcirxGfpsfnnzNaRQbLg+h+YJo/ZO7IlsAs9mQZofBwLWtv7nncFlgDfZiQJ+CntTjc9nr+zc3Ibs+fC0WcOSDNg2+Vy82jXtRWHaAu9Aej86cmUel2sqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220467; c=relaxed/simple;
	bh=WRt/DcHFyVQCUj2nKIuiHXnnK3ayNkXOxmMkACYehvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0NZc1qWRbGON/VGB6zRWIsrzuaQ+5uoyhn6ErM3tLlNKgo7kM6y/6suWcKLc1nkabdTLJGv8FmXT3THs1qflZbT/kRwOcajHJiQimCiNFJJKpFz5VXnDn+RIGo9MNhiMp9BWCCy0HyGsJqqRnm+b3KdGGjnK1S6QnohqOr83aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsXB9ZTF; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e8b90e9328so5324841cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761220464; x=1761825264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcRTFIsNfqtqINMSUqvwdCmpc1Pr0XIO2OTRxxjhVa4=;
        b=dsXB9ZTFf15YF3uA6FNCCLIO0UnPvTuokC0IFcAHhKTQ0ZpkNt6fFtd22JaQSY2egd
         TPvpOyO9cYTvbE4GOt65qFWMQkDPnxAdpVA7fd7oEjf18+fo1stVsQ3y3N/d5MsyPRin
         n8qBWloP6Lu6QRAjCl8WcKa21GUc3rSMdkrcLVnWKsJwcCj9cQ4AU+RJ7crWGbLoiAhX
         7GrM52jkFytivp0cSOfuUqsXQANuKGvEILH3zYKVumseTL7R7po5+UXhugJnEDVHonsA
         tvHarb8PhM3Sqd2sXBNGMKab19EKWvhWd4zQlPRXFzdhuzG0cKdham1qQ90r4QzebayC
         kepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220464; x=1761825264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcRTFIsNfqtqINMSUqvwdCmpc1Pr0XIO2OTRxxjhVa4=;
        b=uDzLJ+JKXScNgLWeGjYF9skNVkXA7ZGHrKYUsgfaAg3gs5hHZwsnjCinEeH9pPnDjO
         mI243IZjaJon/4rRzdV3+VhygiSFvFd5CtsBT5s8R7HPKUewB5n5otlGnrLeRAkmeYVh
         pqXwtiR1pNYq2LatDou6LTM2ZMvmPOC2nFaLOzaOYlI9vG47a4C8cocdwdjR5hhz7wgI
         R44TvuPLIKs21hWKVOOCbnhR/whEVnKilOFGWjOaNtb63KOFuE/PirnB4f7XdK18mExX
         o0qvA36QrD9unv5sKH/Ku+7B8IFg/NLeuOKHO9PRtIt7EEL84mv8KTNHFCTFU/Y0UJL+
         PZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWAOolgpk7F0jxd9jT6B5EkT64MOoM+0uoi2CApO/ueo3TSqgBUyBHJa/WGu1/ukkVArUtzX/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJoynieBUhJVoApa2CPBeJBM6s8XxZrAfRHD/k+0Kc+Y0w3Ce
	4swIsKLx8GhjDB/0eqo4MaJH5nN3mwmX0Bno++sqcmrmCElC83czORDW+p0db1d1FYqojjpesot
	sXPnGxbJC4NZlTF1dKuYR7dpbVl7IHkMa4vntFIx2
X-Gm-Gg: ASbGnctSxJ9N1zhnsT41J3u0HTwdreBPlrlAt0c61stzlqvKZG8liSUk5Aq2WGbMqHu
	zh+1hi4jV9aFwnmGQ01xzeEdOSw2XIZA+WLnX6f++edy6E3JrAcWBIrewAGMU7ZSZy6JfOBTBTU
	3iT5nJBNLPM2vqJgL7Xv9/Qog5C+W7kQrCU3/GqZtuUnsn8oBuPeYWB1JUl1g0ZnjpTkdqKpOAh
	KwKEUF2GqK2MrTsJD/XHezbGEqHTC88aosdoRabsHX/h0VIe+LUDYe6abgR
X-Google-Smtp-Source: AGHT+IFwRsjXFwOVquH93Ov+wkUcdOodRX9YBEt002vnoRNK+OjJBZ8/zDqB/x6qABeRz/8ZEZIGvRrfcxa4bm43FmM=
X-Received: by 2002:ac8:5a88:0:b0:4b3:119b:ce78 with SMTP id
 d75a77b69052e-4e89d215680mr277950761cf.6.1761220463337; Thu, 23 Oct 2025
 04:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPcp_xemzpDuw-MW@stanley.mountain> <20251021083505.3049794-1-lizhi.xu@windriver.com>
 <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>
In-Reply-To: <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 04:54:12 -0700
X-Gm-Features: AS18NWAbKgVO0Sapt_HB1jGQJt1BlcGe-9cCoPLe451vSidlOu-GnSXxYRPeOSI
Message-ID: <CANn89i+td+wS2=VpCB6Jb6m6arR5qv+PTkJ6G1Sc6y7ZBY2q-w@mail.gmail.com>
Subject: Re: [PATCH V3] netrom: Prevent race conditions between neighbor operations
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, dan.carpenter@linaro.org, davem@davemloft.net, 
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:44=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/21/25 10:35 AM, Lizhi Xu wrote:
> > The root cause of the problem is that multiple different tasks initiate
> > SIOCADDRT & NETROM_NODE commands to add new routes, there is no lock
> > between them to protect the same nr_neigh.
> >
> > Task0 can add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> > When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> > release the neighbour because its refcount value is 1.
> >
> > In this case, the following situation causes a UAF on Task2:
> >
> > Task0                                 Task1                            =
               Task2
> > =3D=3D=3D=3D=3D                                 =3D=3D=3D=3D=3D        =
                                   =3D=3D=3D=3D=3D
> > nr_add_node()
> > nr_neigh_get_dev()                    nr_add_node()
> >                                       nr_node_lock()
> >                                       nr_node->routes[2].neighbour->cou=
nt--
> >                                       nr_neigh_put(nr_node->routes[2].n=
eighbour);
> >                                       nr_remove_neigh(nr_node->routes[2=
].neighbour)
> >                                       nr_node_unlock()
> > nr_node_lock()
> > nr_node->routes[2].neighbour =3D nr_neigh
> > nr_neigh_hold(nr_neigh);                                               =
               nr_add_node()
> >                                                                        =
               nr_neigh_put()
> >                                                                        =
               if (nr_node->routes[2].neighbour->count
> > Description of the UAF triggering process:
> > First, Task 0 executes nr_neigh_get_dev() to set neighbor refcount to 3=
.
> > Then, Task 1 puts the same neighbor from its routes[2] and executes
> > nr_remove_neigh() because the count is 0. After these two operations,
> > the neighbor's refcount becomes 1. Then, Task 0 acquires the nr node
> > lock and writes it to its routes[2].neighbour.
> > Finally, Task 2 executes nr_neigh_put(nr_node->routes[2].neighbour) to
> > release the neighbor. The subsequent execution of the neighbor->count
> > check triggers a UAF.
> >
> > The solution to the problem is to use a lock to synchronize each add a
> > route to node, but for rigor, I'll add locks to related ioctl and route
> > frame operations to maintain synchronization.
>
> I think that adding another locking mechanism on top of an already
> complex and not well understood locking and reference infra is not the
> right direction.
>
> Why reordering the statements as:
>
>         if (nr_node->routes[2].neighbour->count =3D=3D 0 &&
> !nr_node->routes[2].neighbour->locked)
>                 nr_remove_neigh(nr_node->routes[2].neighbour);
>         nr_neigh_put(nr_node->routes[2].neighbour);
>
> is not enough?
>
> > syzbot reported:
> > BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom=
/nr_route.c:248
> > Read of size 4 at addr ffff888051e6e9b0 by task syz.1.2539/8741
> >
> > Call Trace:
> >  <TASK>
> >  nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
> >
> > Reported-by: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2860e75836a08b172755
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>
>
>
> > ---
> > V1 -> V2: update comments for cause uaf
> > V2 -> V3: sync neighbor operations in ioctl and route frame, update com=
ments
> >
> >  net/netrom/nr_route.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
> > index b94cb2ffbaf8..debe3e925338 100644
> > --- a/net/netrom/nr_route.c
> > +++ b/net/netrom/nr_route.c
> > @@ -40,6 +40,7 @@ static HLIST_HEAD(nr_node_list);
> >  static DEFINE_SPINLOCK(nr_node_list_lock);
> >  static HLIST_HEAD(nr_neigh_list);
> >  static DEFINE_SPINLOCK(nr_neigh_list_lock);
> > +static DEFINE_MUTEX(neighbor_lock);
> >
> >  static struct nr_node *nr_node_get(ax25_address *callsign)
> >  {
> > @@ -633,6 +634,8 @@ int nr_rt_ioctl(unsigned int cmd, void __user *arg)
> >       ax25_digi digi;
> >       int ret;
> >
> > +     guard(mutex)(&neighbor_lock);
>
> See:
>
> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/process/m=
aintainer-netdev.rst#L395
>

I would also try to use a single spinlock : ie fuse together
nr_node_list_lock and nr_neigh_list_lock

Having two locks for something that is primarily used by fuzzers
nowadays is wasting our time.

