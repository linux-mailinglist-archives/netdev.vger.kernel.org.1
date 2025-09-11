Return-Path: <netdev+bounces-222225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA9B539C3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2D51896347
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B635E4FC;
	Thu, 11 Sep 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0bGaTUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AC35E4DA
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609854; cv=none; b=WDk58Yqh5p8aoynXAjUgZNhV8Tq/MImnPzt3BqaMdLfLrkgvONHxU8IP4cQUSku51F/XO391AMjwG17D8qlEZugA0lcjIB80CEdcho6/jW7MHUxrPAxiDmB/twv7NllJx0jlu9yCZCA01kod4HmG99fgtOQOuxlfFiVXD7kl0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609854; c=relaxed/simple;
	bh=M8dHdO3QJcJ8ibY9tJiHH96NIDn30QtPIMLjcbsbiZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD7PKhLJgL3BvMJ8LaLGNv7kUES3YGtHqKuElpSDjoA4dNIrJH7k11xUpyT3A2eig/+A2Xdal3kFszwsG7F6M4sAAZxkwGRq24+NT0NueTs6tbwNGdiBGeFgk5eXGYovLj7NDU6Bq3xmEocsv38Cf3SPx8rEbx+6/E8uD+mGLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0bGaTUr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so1192571a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757609851; x=1758214651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqPrjjsiASC2+C8mCjWXot+usXG051htc/nU1e7szKc=;
        b=U0bGaTUr16zP/J0zlQoBI8cuzvnpJB1mSc9dR8JhiYi2uCxyL1sYecCMIVQAJk9i9/
         Ss3lRKyNRfg1TZJn18fd/B5kBmNX+bBPT1/fbX5g0aDdcPRfF+laRPQGCsNB+XE4RVSF
         fKnDUki4LIZrZwo8ntkUelDJBPpKJgmlfrbykWwXu7T2+YE2l6GtSNZxsFVUk7RZy54B
         jphfx0ohu+Vm2O9ROseUtFuPyGiIy/ROfS9bVlqGr2mkorqOXYYrWOOfO0td3XKySZ4l
         s+hlSxR4OxvXiGr1l22u7yyJN+l7daCzmHQR6YGlKBCJUqDIRBdoo6owLNSfKrQSuQ0I
         W3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609851; x=1758214651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqPrjjsiASC2+C8mCjWXot+usXG051htc/nU1e7szKc=;
        b=laW/tygOfiFilZRHb+WIVkMb0X3h/ROSQ1v+L9wkx0Xhl+pjqONYTOIgLno9kiT6JZ
         HqJutSgi31KDe9YHskrh8L3cp5mzHL+Z2y9j1pwZcu7UFcaB0NCRbY/qyS89MhyMJUQD
         GxJheqUMRNMX5TdDMennE3bSE9O6DBsMHKUg1dsLEs4scUfEPrQmTTbpmHsL8XDdPpqW
         jTib67+5rbW05PtJVri0O6hqypDlzESiHucqID4dRUFrueC5xSYgB+iTHOy3z8+4Mvms
         fbHPXh5F1BtXwZrqfwSrvIRue176jBmnuFYgJ4+bN+tC8wUR3gqbA9n+2wyIEePOn49e
         sBaw==
X-Forwarded-Encrypted: i=1; AJvYcCV6qHeIZ/dC2vekksZQv30DyqYytPnbnCkQsblE1ufGnD6u86Jjajxix7JqVCaaKiJv4VUD9LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQigbuBLHI86q9SJB5QJBa6bZhUutDbKElJSjQiQ7Sd5MDaK2B
	jNRLPe+ifVZDXEn6wBI6/PnfH2gygzVf5fTFzyN/qugNUYZtdDxTTo5zBWR/PnvK0L9PHNAyY5Y
	N2ZiYBvshISJ4FbGv6mxke5F5CIGOWZzkwzrQ7cEo
X-Gm-Gg: ASbGncvSZ79twWvL+SuFLNlLz64P3/+m9NVtEpwmHOamTlt/Pt4gY4msMd5EBR7wNOV
	laIcuAP+bRotmRqhJWRnCDlONiRhyCTmxbnB/0xg+F2N+JB3jl6Gv+jblJY6urXR+ovuzu8SXFN
	umtgBmwHLMMdI1/y7Z2Yne00bl3W/fih8ZfAyVX/6qPPSpSmlwGwVCo1MtMD/xpXa14NiwCaOCS
	Y4P1INrwr9w+e9YZI+XsRvHjNSIoyPUtlXurpvoZCvWYp0=
X-Google-Smtp-Source: AGHT+IGuCZ2QR5rjrRlLulq1ctUvT4bmdwIjGI6Ro784aZe2AmQO+erbWg0vxGsD5kwnpWPF4Td7pCjjTiFre+lIyGA=
X-Received: by 2002:a05:6402:4605:b0:61d:3d9d:3253 with SMTP id
 4fb4d7f45d1cf-62ed80d0e64mr252843a12.2.1757609850509; Thu, 11 Sep 2025
 09:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-4-kuniyu@google.com>
 <CANn89i+Z5X5eEDVyAAEayLK60ziAeAs4ynwzw8XLe9bWy9GDUw@mail.gmail.com>
In-Reply-To: <CANn89i+Z5X5eEDVyAAEayLK60ziAeAs4ynwzw8XLe9bWy9GDUw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Sep 2025 09:57:15 -0700
X-Gm-Features: AS18NWCeB3T0YzMDiSyoQgLn5beMNtZzdd6XZRr_XbTA8ilIouAOQmmxNbidylQ
Message-ID: <CAAVpQUAGbadNDhtn=vdwQHXc51vOA_22vH-SYyyi=ANhoS=ROQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 3/8] smc: Use sk_dst_dev_rcu() in in smc_clc_prfx_set().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:28=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Sep 10, 2025 at 8:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > smc_clc_prfx_set() is called during connect() and not under RCU
> > nor RTNL.
> >
> > Using sk_dst_get(sk)->dev could trigger UAF.
> >
> > Let's use sk_dst_get_rcu() under rcu_read_lock() after
> > kernel_getsockname().
> >
> > While at it, we change the 1st arg of smc_clc_prfx_set[46]_rcu()
> > not to touch dst there.
> >
> > Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> > Cc: Dust Li <dust.li@linux.alibaba.com>
> > Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
> > Cc: Tony Lu <tonylu@linux.alibaba.com>
> > Cc: Wen Gu <guwen@linux.alibaba.com>
> > Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> > ---
> >  net/smc/smc_clc.c | 39 ++++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> > index 08be56dfb3f2..9aa1d75d3079 100644
> > --- a/net/smc/smc_clc.c
> > +++ b/net/smc/smc_clc.c
> > @@ -509,10 +509,10 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_=
msg_hdr *clcm, bool check_trl)
> >  }
> >
> >  /* find ipv4 addr on device and get the prefix len, fill CLC proposal =
msg */
> > -static int smc_clc_prfx_set4_rcu(struct dst_entry *dst, __be32 ipv4,
> > +static int smc_clc_prfx_set4_rcu(struct net_device *dev, __be32 ipv4,
> >                                  struct smc_clc_msg_proposal_prefix *pr=
op)
> >  {
> > -       struct in_device *in_dev =3D __in_dev_get_rcu(dst->dev);
> > +       struct in_device *in_dev =3D __in_dev_get_rcu(dev);
> >         const struct in_ifaddr *ifa;
> >
> >         if (!in_dev)
> > @@ -530,12 +530,12 @@ static int smc_clc_prfx_set4_rcu(struct dst_entry=
 *dst, __be32 ipv4,
> >  }
> >
> >  /* fill CLC proposal msg with ipv6 prefixes from device */
> > -static int smc_clc_prfx_set6_rcu(struct dst_entry *dst,
> > +static int smc_clc_prfx_set6_rcu(struct net_device *dev,
> >                                  struct smc_clc_msg_proposal_prefix *pr=
op,
> >                                  struct smc_clc_ipv6_prefix *ipv6_prfx)
> >  {
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -       struct inet6_dev *in6_dev =3D __in6_dev_get(dst->dev);
> > +       struct inet6_dev *in6_dev =3D __in6_dev_get(dev);
> >         struct inet6_ifaddr *ifa;
> >         int cnt =3D 0;
> >
> > @@ -564,41 +564,42 @@ static int smc_clc_prfx_set(struct socket *clcsoc=
k,
> >                             struct smc_clc_msg_proposal_prefix *prop,
> >                             struct smc_clc_ipv6_prefix *ipv6_prfx)
> >  {
> > -       struct dst_entry *dst =3D sk_dst_get(clcsock->sk);
> >         struct sockaddr_storage addrs;
> >         struct sockaddr_in6 *addr6;
> >         struct sockaddr_in *addr;
> > +       struct net_device *dev;
> >         int rc =3D -ENOENT;
> >
> > -       if (!dst) {
> > -               rc =3D -ENOTCONN;
> > -               goto out;
> > -       }
> > -       if (!dst->dev) {
> > -               rc =3D -ENODEV;
> > -               goto out_rel;
> > -       }
> >         /* get address to which the internal TCP socket is bound */
> >         if (kernel_getsockname(clcsock, (struct sockaddr *)&addrs) < 0)
> > -               goto out_rel;
> > +               goto out;
> > +
> >         /* analyze IP specific data of net_device belonging to TCP sock=
et */
> >         addr6 =3D (struct sockaddr_in6 *)&addrs;
> > +
> >         rcu_read_lock();
> > +
> > +       dev =3D sk_dst_dev_rcu(clcsock->sk);
> > +       if (!dev) {
> > +               rc =3D -ENODEV;
> > +               goto out_unlock;
> > +       }
> > +
> >         if (addrs.ss_family =3D=3D PF_INET) {
> >                 /* IPv4 */
> >                 addr =3D (struct sockaddr_in *)&addrs;
> > -               rc =3D smc_clc_prfx_set4_rcu(dst, addr->sin_addr.s_addr=
, prop);
> > +               rc =3D smc_clc_prfx_set4_rcu(dev, addr->sin_addr.s_addr=
, prop);
> >         } else if (ipv6_addr_v4mapped(&addr6->sin6_addr)) {
> >                 /* mapped IPv4 address - peer is IPv4 only */
> > -               rc =3D smc_clc_prfx_set4_rcu(dst, addr6->sin6_addr.s6_a=
ddr32[3],
> > +               rc =3D smc_clc_prfx_set4_rcu(dev, addr6->sin6_addr.s6_a=
ddr32[3],
> >                                            prop);
> >         } else {
> >                 /* IPv6 */
> > -               rc =3D smc_clc_prfx_set6_rcu(dst, prop, ipv6_prfx);
> > +               rc =3D smc_clc_prfx_set6_rcu(dev, prop, ipv6_prfx);
> >         }
> > +
> > +out_unlock:
> >         rcu_read_unlock();
> > -out_rel:
> > -       dst_release(dst);
> >  out:
> >         return rc;
> >  }
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
> Same comment, I had a patch to fix this without a new helper.
>
> We have hundreds of dst->dev places to fix, very few  sk_dst_get().
>
> This is why I think sk_dst_dev_rcu() is not necessary.

I added helpers for new users not to read sk_dst_get()->dst
directly, but the point is fair.  Maybe we can convert all users
to __sk_dst_get() or remove rcu_read_lock() in sk_dst_get().

