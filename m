Return-Path: <netdev+bounces-74702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76C862466
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F4283E51
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10207249F9;
	Sat, 24 Feb 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhfvdlsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338402233A
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708772954; cv=none; b=p4v65+RjyTbdvLcv59m+5cGxDNP7BSSJk/HQt/xGv3V9JH0NGOVWeUstl7CbJJJtRApsbC4u0REAiTM6p0WOmfg8Zy/haXUIUHwZDdFpfUv+aoEIh0Cih2QNJ40pOhbsQlYAVWN5WP5/G7MANoF2LzrGeBuv9D6e83CeBRCrgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708772954; c=relaxed/simple;
	bh=QZFminq0i1dBVZT3rCp7anLPAqVd4mISwG5lE43fgT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlhq/vDaTG5yNfeYQV8dK/cvxd4VoKMWZ5sSNI2XoXiQ9P8kY2n7uvYXhzosicAAXOZ+qDgLUrp6k86OZOTHp0XSnsFdUx85wEhwx7zVLHrdLKzbfZgRmRJ7NFlGGjBxYsmHrHZEBJU1yUNH+Tx3IUNQkVl7QfNX0lVByVGbeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhfvdlsG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso7361a12.0
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708772950; x=1709377750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YAK0uyIemz+oNTxVwQg206keJJt22UhiDSzciyTOOc=;
        b=EhfvdlsGGHB2q2je18w5q6rUvM+Jx0GyY5fcqbTZX49q4zno2/CzI9mh2lvbVv63IP
         WPlFyeRkxtoNY69cbWA83NokZKxFiv6r4Ql3mTdQQPyp5yxNxrYlRVMLwbXGQxGznUFy
         oZLRFU13ACKx2QwU6xr6UybYvd/zjE43x+F2a8+FvgjHq2swKPBINMoId81pulGkdtX6
         US/5zZBcnqCrXOQ0GErGHgW+uvgf7VMcLlfmO7I7rxlyveBHDc9BqWSiOs1CDUfyVm3x
         JDAgrKJo2uB2WxzuMqJN7Uv2sc9yNofhRgbOJQW911j+BM5RnQ6hh3qhJw5M+yHr0FI1
         PrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708772950; x=1709377750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YAK0uyIemz+oNTxVwQg206keJJt22UhiDSzciyTOOc=;
        b=JJigyWcg/+qZkV6r4mbTj555yeeLU3zVDjVNZ7swuIQ1ZEuiqEMmA4oWkPlUUGweyW
         Yz/HxXtYprUs5YV9ut2GbFkfY4DZvLEYoZtTc38/oCViO/+zcgDzz62cOmG21MpYroB5
         kaZ/QPnRZ9TfSF4MrmPxdD/wBSktK4GYyTNL5qrNIPgGBlXEt2noMiKKqxfPOd0wa3xC
         uTNLTAlSI8MhnnYZgaqzsjwFnG0lxiOXVmpdSKVeJwlqYNMaD/1wzy5Cs+USptuI87jw
         CYHyR/XckgvmCeDloBvfoNkit9AX4o2j1WB7DQQHWTNw7BSoYVZhMGIq8ieW99xSQL+z
         lxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTnW++1eQ3n2CM3WWAWKPxqbnsJfer2OoYnrcf1Rg0HQ/zV3Fkse3usqJSjf0bbbwOkIStMzlKjq9Ou/ioA+zwGr6nroq
X-Gm-Message-State: AOJu0YwrYRdgdGzQYM55xM7DUZNaKdM9G2PS0c8KQQfjkFALgoq3y+eE
	HYekF79DfVbRjyOquGi0UqiGRqY7PUDVgmffx+D9XY67L45+sesjmW2bj+BCauNyJUBnvynDNNR
	3U81f6r04g/PIdIvpqUVWtOlw1SkP7R4cWw16
X-Google-Smtp-Source: AGHT+IFOIraJnnP7M8SvUvOI8Te56yuLM3loJh1Vn+RYw7XnlnkNUws1uVYPSWco4v0ZxJmEmuTilOy388/B0r41J9U=
X-Received: by 2002:a50:9549:0:b0:563:f48a:aa03 with SMTP id
 v9-20020a509549000000b00563f48aaa03mr147703eda.2.1708772950112; Sat, 24 Feb
 2024 03:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-2-edumazet@google.com>
 <m2wmqvqpex.fsf@gmail.com> <CANn89i+UXeRoG4yMF+xYVDDNv-j2iZYTwUogQWsHk_OiDwoukA@mail.gmail.com>
 <CAD4GDZyV5H4RK_8H2CiUfEj_DSu=w12HqeCzy+2mmu3cMivGww@mail.gmail.com>
In-Reply-To: <CAD4GDZyV5H4RK_8H2CiUfEj_DSu=w12HqeCzy+2mmu3cMivGww@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 12:08:56 +0100
Message-ID: <CANn89i+PPT7QDQKs9c-fUeshr_+Heh_mCLfFxwCEtbnUM5fjxA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink() to
 run under RCU
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 11:46=E2=80=AFAM Donald Hunter <donald.hunter@gmail=
.com> wrote:
>
> On Sat, 24 Feb 2024 at 08:21, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Feb 23, 2024 at 4:25=E2=80=AFPM Donald Hunter <donald.hunter@gm=
ail.com> wrote:
> > >
> > > I notice that several of the *_get_iflink() implementations are wrapp=
ed
> > > with rcu_read_lock()/unlock() and many are not. Shouldn't this be don=
e
> > > consistently for all?
> >
> > I do not understand the question, could you give one example of what
> > you saw so that I can comment ?
>
> I did include a snippet of your patch showing ipoib_get_iflink() which
> does not use rcu_read_lock() / unlock() and vxcan_get_iflink() which
> does. Sorry if that wasn't clear. My concern is that I'd expect all
> implementers of .ndo_get_iflink to need to be consistent, whether that
> is with or without the calls. Does it just mean that individual
> drivers are being overly cautious, or are protecting internal usage?
>
> No use of rcu_read_lock() / unlock() here:
>
> > index 7a5be705d71830d5bb3aa26a96a4463df03883a4..6f2a688fccbfb02ae7bdf3d=
55cca0e77fa9b56b4 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > @@ -1272,10 +1272,10 @@ static int ipoib_get_iflink(const struct net_de=
vice *dev)
> >
> >       /* parent interface */
> >       if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags))
> > -             return dev->ifindex;
> > +             return READ_ONCE(dev->ifindex);

No need here, because dev is guaranteed to be alive during this call.

> >
> >       /* child/vlan interface */
> > -     return priv->parent->ifindex;
> > +     return READ_ONCE(priv->parent->ifindex);

Sure, no need for rcu_read_lock() here because priv->parent is stable
(can not change during lifetime)


> >  }
>
> And use of them here:
>
> > diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> > index 98c669ad5141479b509ee924ddba3da6bca554cd..f7fabba707ea640cab8863e=
63bb19294e333ba2c 100644
> > --- a/drivers/net/can/vxcan.c
> > +++ b/drivers/net/can/vxcan.c
> > @@ -119,7 +119,7 @@ static int vxcan_get_iflink(const struct net_device=
 *dev)
> >
> >       rcu_read_lock();
> >       peer =3D rcu_dereference(priv->peer);
> > -     iflink =3D peer ? peer->ifindex : 0;
> > +     iflink =3D peer ? READ_ONCE(peer->ifindex) : 0;
> >       rcu_read_unlock();
> >
> >       return iflink;
>
>
> > We do not need an rcu_read_lock() only to fetch dev->ifindex, if this
> > is what concerns you.
>
> In which case, it seems that no .ndo_get_iflink implementations should
> need the rcu_read_* calls?

rcu_read_lock() is needed in all cases a dereference is performed,
expecting RCU protection of the pointer.

In vxcan_get_iflink(), we access priv->peer, then peer->ifindex.

rcu_read_lock() is needed because of the second dereference, peer->ifindex.

Without rcu_read_lock(), peer could be freed before we get a chance to
read peer->ifindex.

