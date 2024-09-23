Return-Path: <netdev+bounces-129356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C297F00F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9731F225AE
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224119F40F;
	Mon, 23 Sep 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vy3i8IgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291E101DE
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114297; cv=none; b=AYu9g6bpBuJIWYzz7S7qwJdJMA6s4G4qlPDaWyR4EcvkUNJ1A+15ESnCtyf4O69TPWfMYfhU3dkpyhhmcBVbaTziVcFWeHaNWy5HP5yAXjDIA1zqKiozdMMYKlmTLUVOnLP9OB3kc68ZY6hESXUNqxiWce2ccGociQyOJMtcwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114297; c=relaxed/simple;
	bh=dip0ICXtUjZdWOcHwVlH3/P0ydIAJ2eHbKJW70bFN6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGsoY+QDtz5z3/QTYAzRy7gkJSuaTIWCtz2y1502+8NGNMxQJEA8lgA9CTrOti7jjMNlvnEzw9teE0o3YTQia2Rle4swEQd2ldclayRaPSUROov/LLWHlcJcWp8cg5lDufRXLnbvfwzN6Iftm9NND/d/e9iqYWfihH/bwogVirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vy3i8IgM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so5605651a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727114294; x=1727719094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Z9WWARFyUgy3iazjx+STEWaRW57EpOgTa/xbBAeGw=;
        b=Vy3i8IgM+Mqy8KhXHmIgomipcMANWpgAw8tu1V63clpjgT1znpQ83xMtkmNpptG6JQ
         EGN3Ay/9RE+Dyq45aPW1XmYdVeDpe8ZWdKpwhX458L5fx7Rr/vEOyHM9ezrxDFTbmjdv
         nN95hPSc0pZxt8yASZYT8jvqXGVk0atBbz6LEJh4DmLOks/Ts63rOiXlj2ZlsKwQduq5
         e6T5trRz2w/zfaHBdBos5wI/kAedlBl8QstYrHXf+haIbOo26kS94/mE2FY2+hdVK3zG
         Cg4HGtebMZiAAaFuZtowU/h1OwYZYHaAz/wy2W+YC0Hz4GhtriwXCxYLNpyGgt9kBK6T
         S5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114294; x=1727719094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5Z9WWARFyUgy3iazjx+STEWaRW57EpOgTa/xbBAeGw=;
        b=llqEMsM9uPoT/u6zitLTNqaJgJ/16Xz97POHrhVvbu0uf3yR7eCvoyWcUO5wm2CpXW
         AG+dBkpIweMG7VEjBnS/lEn3CVsW7YbNk5B+QW9MjaA9aVQJsSuTt4u0ObqkMLL+DbAl
         X1byQKKlb/JvapaKv25MD4IwctZbeCWMBn0Dz31q3cBgeCA0r13CJ9GQ/va3dIFB5GHV
         UKn84UFXHSoniYB2K6e3RpcI8nBDUDUbjvFv4cMyit7DjXziV0358SrbuxiDZAmvl2bY
         2VLlRSVt02C/sJMPt+4nFdQP9N4P09fhO4zhpQSJKjqJKVGKGQRd7u1Dnnfm7nDbOcDy
         uLNg==
X-Forwarded-Encrypted: i=1; AJvYcCWDnDhP/pZKr1FHuI2cTwJ3Bq5CYZkHgyG3wZukbY3zI5/3/URYBpi/hPNnCCGWud+0cYiQ1Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkaReJ+xOMAxdQ6tp5g+Sq/h3Rc5ACvNbJpxyNCFhkVEtWEZ7
	hxYDm/9Ewd1nc6BYqC/0U7OQig4F+Y4IeOGsnCRwrqoKPJgY0tC5pzjYt3JmE6HVyWYxlyn1DeC
	36v0/dviyxvgCyzEmcDajT4OR69WtLCSm/xOR
X-Google-Smtp-Source: AGHT+IH4nBMXk04zxjnrwa58vw4gTOgM/tIukkPLnld9Z2YRBHMm7MEidqRRg5CUZlxpBJe4gA+w7LsUC2E0J0IPAcY=
X-Received: by 2002:a05:6402:27d4:b0:5c2:75d3:fbf7 with SMTP id
 4fb4d7f45d1cf-5c464db3de0mr12456829a12.14.1727114294084; Mon, 23 Sep 2024
 10:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923170322.535940-1-sahandevs@gmail.com> <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
In-Reply-To: <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 19:58:00 +0200
Message-ID: <CANn89i+asgFpSSAxavvLe22TW897VaEdyYzMJ_s0JpH+2_RzUA@mail.gmail.com>
Subject: Re: [PATCH] net: expose __sock_sendmsg() symbol
To: Jordan Rife <jrife@google.com>
Cc: Sahand <sahandevs@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:48=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Should this be backported? I'm wondering if this needs a "Fixes" tag.
>
> -Jordan
>
> On Mon, Sep 23, 2024 at 10:03=E2=80=AFAM Sahand <sahandevs@gmail.com> wro=
te:
> >
> > From: Sahand Akbarzadeh <sahandevs@gmail.com>
> >
> > Commit 86a7e0b69bd5b812e48a20c66c2161744f3caa16 ("net: prevent rewrite
> > of msg_name in sock_sendmsg()") moved the original implementation of
> > sock_sendmsg() to __sock_sendmsg() and made sock_sendmsg() a wrapper
> > with extra checks. However, __sys_sendto() still uses __sock_sendmsg()
> > directly, causing BPF programs attached to kprobe:sock_sendmsg() to not
> > trigger on sendto() calls.
> >
> > This patch exposes the __sock_sendmsg() symbol to allow writing BPF
> > programs similar to those for older kernels.
> >
> > Signed-off-by: Sahand Akbarzadeh <sahandevs@gmail.com>
> > ---
> >  include/linux/net.h | 1 +
> >  net/socket.c        | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/net.h b/include/linux/net.h
> > index b75bc534c..983be8a14 100644
> > --- a/include/linux/net.h
> > +++ b/include/linux/net.h
> > @@ -258,6 +258,7 @@ int sock_create_kern(struct net *net, int family, i=
nt type, int proto, struct so
> >  int sock_create_lite(int family, int type, int proto, struct socket **=
res);
> >  struct socket *sock_alloc(void);
> >  void sock_release(struct socket *sock);
> > +int __sock_sendmsg(struct socket *sock, struct msghdr *msg);
> >  int sock_sendmsg(struct socket *sock, struct msghdr *msg);
> >  int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
> >  struct file *sock_alloc_file(struct socket *sock, int flags, const cha=
r *dname);
> > diff --git a/net/socket.c b/net/socket.c
> > index 8d8b84fa4..5c790205d 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -737,7 +737,7 @@ static inline int sock_sendmsg_nosec(struct socket =
*sock, struct msghdr *msg)
> >         return ret;
> >  }
> >
> > -static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
> > +int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
> >  {
> >         int err =3D security_socket_sendmsg(sock, msg,
> >                                           msg_data_left(msg));
> > --
> > 2.43.0
> >

Old programs were using kprobe:sock_sendmsg

How will this patch restore the operations ?

It seems programs have to use kprobe:__sock_sendmsg even after this patch ?

Please provide a more precise changelog.

I _think_ that perf does not care :

# perf probe -a __sock_sendmsg
Added new events:
  probe:__sock_sendmsg (on __sock_sendmsg)
  probe:__sock_sendmsg (on __sock_sendmsg)
  probe:__sock_sendmsg (on __sock_sendmsg)
  probe:__sock_sendmsg (on __sock_sendmsg)

You can now use it in all perf tools, such as:

perf record -e probe:__sock_sendmsg -aR sleep 1

