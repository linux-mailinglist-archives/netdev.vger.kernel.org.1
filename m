Return-Path: <netdev+bounces-236105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE0C387BA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBD4E2A66
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A13B7A8;
	Thu,  6 Nov 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3IBbOEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B733EA8D
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389073; cv=none; b=VbgD7BMcIWJy/u9pJG9Gy6+Ygx8GPNxxqkbbCY+UFKqbzBinZnAEERsrEpZPJTCjaUOXkO8ApKi74z657QhKsWhjSMwGCl4mrrWJXviPmZcldeaHh5EbYFol3jYZqJXPHXfJ/59rSe0lB2xubl/1u77zFQRUvyCm3WZYOhgLkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389073; c=relaxed/simple;
	bh=YwK0dzjnIzie+cIro6blVg+02ewp8AJjSQ0wXem3n/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt/rbDX+4kpY7z/FjEuIgJmDhT2Klt9t4zCLnBnnUoS6Kf1o29PV49hHxEPvqT0iGx2l04wJOCzPMfPkqeE510ydn7E+JBt+9Bi/f8Ms8y9tNzFGL+hs5KJdDWxauyiysBwZlNV/wGnZTwr6krkn054AdgT5lXmZGBHLfH3Putk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3IBbOEv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340cccf6956so319724a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762389071; x=1762993871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npZ4ZHY9IYcq8FuNNSe7GYz7F1gks+mG+CKUhrgqFF4=;
        b=X3IBbOEvaTR0osHfmPIqFUzCc9w/RJRN5XyXUuJvI+tqfRELdSQ85gLuYe48PcXdAh
         5/Bb4rfNKlTRgPrZwEqQduy1SrM1Eityac+3Erk4ZW3d9j7jg88nkwMeXayA/Nyz+yfs
         TAUXYmBDhgT7TkD6QJ6O9F8xMTxOAP6DFNjecI/3FvCyD429ZTuGwYZl6iwONuIpbGsO
         HxDSc3Fu/xj5zuft3ElTGekwKyA4/hfWGzw5QhkJ4+PBOAje++WJbzlggCWZ1WkcTK4d
         klVZoOqzl7KA0ZqEtGL4Bvjf6raFfL31+v5q6Jd75OAZUmvAAsKNaI3rthdWSH+PeH2Y
         8Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389071; x=1762993871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npZ4ZHY9IYcq8FuNNSe7GYz7F1gks+mG+CKUhrgqFF4=;
        b=HQHkko3qT4490cgwGckO8TrvY7RgHu+DWtDX/5FJ3lLrHU5iyH1LTtvaFOqvccyOA6
         tQpnYbMIZWMiKj1eRtsqvYnLQSswtRF48XA1L9NXu4ykReH9RBb1kqwgR/NI0Mg6z6+K
         JaSWuz3srMoGOhFuN90zuy6pPE1mMsNRKh2RtHG1/Ha/E2l4cpyj8RYveUMawT/FTSzT
         lhexrlkovZ0oF82FQmQc9qFYAhT+8lnS86pJTEI9ABWn4Eewsay9d7kQiHP71GJ+qD/n
         d4kXv8rpEba/flVkXH0HAVOKl8Y0zyhglrosajY/XQrKXT/bYulpDg3er21S3xfilvLI
         ompw==
X-Forwarded-Encrypted: i=1; AJvYcCXcS5qdd9Mf2LZO8Qz6ffCPUWKbfcCN3Ih3ZBH0VdEIqO5vhtuB76WfyhNz6PQ7Q2Pd8tIbSzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nhTVIkLccHDRsVx5UqfeU/rOi6z8JBM2BQ5CAXe7SlEB5Nm8
	G3HxV2RDZlyjyDcweL/OCstG39dMbuL4X3bkUFui+bepf0cHrBKkjGHaDg0BF4HVk4uBzbq36Ax
	ei6nBjS+xn6KXryvLaguL1MajaX2hSmk=
X-Gm-Gg: ASbGncspYdCkPwnXZv4ZpSqVtdMwqQWjt0/ezkwoQ7RctuX4iQ+opl/lOqPUb0aU8si
	xnqasXScLy2XNYWGNeyLR43pWgMbPBzgqsrAwUEtXS8YIafWkWFSU6eXSBFGs+GQINJ4SHjGZkT
	5trYuZqt0p/kbeY9+kcqDLeK0LJ6lzrvv5+Rr3tUzqb6RFPpxPACrS6VZzCL3Wqz051+FzIv54P
	6ZJg2Tev8p68MiL+wztDoJaU3mD/N9m4AxMGSF9bDJcOuliuixkl4orrDPz3Q==
X-Google-Smtp-Source: AGHT+IHwES9bDUP8SbFObycvgyOEk5THTTrkQ7ePguRlLgOcH2Ti5zcYIrhYryoX80izxcM+hg6IjqYm2Yv9QgPGk+4=
X-Received: by 2002:a17:90b:1641:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-341a700a3bemr5949611a91.36.1762389071497; Wed, 05 Nov 2025
 16:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com> <aQtubP3V6tUOaEl5@shredder>
In-Reply-To: <aQtubP3V6tUOaEl5@shredder>
From: chuang <nashuiliang@gmail.com>
Date: Thu, 6 Nov 2025 08:31:00 +0800
X-Gm-Features: AWmQ_bmJbeEEhs1HgJzOSB3cbz-wmgiV7SpPt3It_0aKQ1KdQVVYbK5786sv_X4
Message-ID: <CACueBy6LKYmusLjQPnQGCoSZQLEVAo5_X47B-gaH-2dSx6xDuw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Networking <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, your analysis is excellent and makes perfect sense. I can
briefly describe the issue.

This problem took quite some time to analyze overall =E2=80=94 we enabled
netdev refcnt, added dst tracepoints, and eventually captured a race
condition between fnhe deletion and rt_bind_exception.

In our environment, we use the sit driver(ip tunnel). During the xmit
path, it records the PMTU for each destination, creating or updating
fnhe entries (even when the MTU is already appropriate). Because there
are many data flows, the sit driver updates PMTU very frequently,
which leads to the race condition mentioned above.

Sorry for the brief summary =E2=80=94 I=E2=80=99ll provide a more detailed =
explanation
later, along with the patch verification method.

On Wed, Nov 5, 2025 at 23:34 Ido Schimmel <idosch@idosch.org> wrote:
>
> On Wed, Nov 05, 2025 at 06:26:22AM -0800, Eric Dumazet wrote:
> > On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> w=
rote:
> > >
> > > From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 200=
1
> > > From: Chuang Wang <nashuiliang@gmail.com>
> > > Date: Tue, 4 Nov 2025 02:52:11 +0000
> > > Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from re=
binding
> > >  stale fnhe
> > >
> > > A race condition exists between fnhe_remove_oldest() and
> > > rt_bind_exception() where a fnhe that is scheduled for removal can be
> > > rebound to a new dst.
> > >
> > > The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> > > for deletion, but before it can be flushed and freed via RCU,
> > > CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> > >
> > > CPU 0                             CPU 1
> > > __mkroute_output()
> > >   find_exception() [fnheX]
> > >                                   update_or_create_fnhe()
> > >                                     fnhe_remove_oldest() [fnheX]
> > >   rt_bind_exception() [bind dst]
> > >                                   RCU callback [fnheX freed, dst leak=
]
> > >
> > > If rt_bind_exception() successfully binds fnheX to a new dst, the
> > > newly bound dst will never be properly freed because fnheX will
> > > soon be released by the RCU callback, leading to a permanent
> > > reference count leak on the old dst and the device.
> > >
> > > This issue manifests as a device reference count leak and a
> > > warning in dmesg when unregistering the net device:
> > >
> > >   unregister_netdevice: waiting for ethX to become free. Usage count =
=3D N
> > >
> > > Fix this race by clearing 'oldest->fnhe_daddr' before calling
> > > fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> > > setting it to zero prevents the stale fnhe from being reused and
> > > bound to a new dst just before it is freed.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> >
> > I do not see how this commit added the bug you are looking at ?
>
> Not the author, but my understanding is that the issue is that an
> exception entry which is queued for deletion allows a dst entry to be
> bound to it. As such, nobody will ever release the reference from the
> dst entry and the associated net device.
>
> Before 67d6d681e15b, exception entries were only queued for deletion by
> ip_del_fnhe() and it prevented dst entries from binding themselves to
> the deleted exception entry by clearing 'fnhe->fnhe_daddr' which is
> checked in rt_bind_exception(). See ee60ad219f5c7.
>
> 67d6d681e15b added another point in the code that queues exception
> entries for deletion, but without clearing 'fnhe->fnhe_daddr' first.
> Therefore, it added another instance of the bug that was fixed in
> ee60ad219f5c7.
>
> >
> > > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > > ---
> > >  net/ipv4/route.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > > index 6d27d3610c1c..b549d6a57307 100644
> > > --- a/net/ipv4/route.c
> > > +++ b/net/ipv4/route.c
> > > @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> > > fnhe_hash_bucket *hash)
> > >                         oldest_p =3D fnhe_p;
> > >                 }
> > >         }
> > > +
> > > +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> > > +        * rebound with new dsts in rt_bind_exception().
> > > +        */
> > > +       oldest->fnhe_daddr =3D 0;
> > >         fnhe_flush_routes(oldest);
> > >         *oldest_p =3D oldest->fnhe_next;
> > >         kfree_rcu(oldest, rcu);
> > > --
> >

