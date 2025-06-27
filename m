Return-Path: <netdev+bounces-201722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E7AEAC20
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DF24A5A81
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAA18027;
	Fri, 27 Jun 2025 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yM9xKz9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A733F6
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986158; cv=none; b=leqg82hhZjFC7yiQ9trGlVzBCqNjDRP8cz7cgq1XbTIQ7yzqBw5TOtKEld5y++VDQSeXdt56LWTaxF1lQNj19IEDP7CVO+a2Vyo70p3TwT/kY/Z6bRXeDUVEYuzwMpOM325cABKi4ZSD82xxOUpvVzNHH6FLrBFSQa5XHT7WdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986158; c=relaxed/simple;
	bh=NrNgvrrz81noP6ns453c/1JtNX/1cDG1pootNLpI6S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbHz3WtHM657U0txGTKF7LXKbpoxCukbE/ZLF/wMNBSNZ/3nK1C58nHei+JLOsS4/UB/lrvDrzRFPuaymvRXQ8nBs9jQ8Ddd1RyFelNWKpGHnmYTOlzc3w2A1DWxDfihbXjs59lU2AZnNTWeaYde6Kvtzc9SY5ecTT1cbQw3T5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yM9xKz9m; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c978688dso973409a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750986154; x=1751590954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wsnlm/Qp7khDYn8hr1ZM7th0D2BiyAMEkqWNqTAqFV4=;
        b=yM9xKz9mgnGqx+CBXynREC4NJupyDXFkY9olSl0O09mI/mThWE3UBiQuCdF9MaoFb/
         xh6eE5U8CvNNwi0adqXe+xrV5l3v8wUdqe6CzjCxGyxYVrbUJU+qtssAJ2aNW0nlQU/S
         fa1HECsVsg1meD8ElUE6BSW0TV5l5JOccTHODbQCocMBK7vIm0aisZL+Jdrm7cBQIk9u
         wLbckT3ZWQtsCITy+3PhFS8Ehw9tTdXMv5Iiqc1F4+kiFci7D9/mZAUE/jeqQzZhNMdO
         fnFEaW6PscK8C/hHh+FnI7+U8UqUZxEpl1mdpgDkUBWmGt+yDcvmTUK/odekhw18cstD
         bZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750986154; x=1751590954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsnlm/Qp7khDYn8hr1ZM7th0D2BiyAMEkqWNqTAqFV4=;
        b=AXnOGHi4Rv8fgT2WC07QgL41MLIZ15vdqMjY4G8StNx36WE7YbioaFf677z7Ujuulv
         sJ1MPjga5f0zJ++nY/DQXoaiPPKW3RRRsQYvsh3m5CCfFFTw8e0BvRLw03Cm2A5a7Q9W
         6aFcsOhBMl6jU2h1pH8aZkxaH5sWL97TvFmxSSK7D0a9Li2k8bpIWG+pPTDj8mjJOmV8
         uA0ZEPCgIGw5qzSzpnFGSygiInWKzh+7fnBImImZni5dl73rJ9Kla0CZ9CUyVK1OnIcE
         LEM1+Sn90GsF8p9c6ydzJaju0euLe5EGQTH0zmsmV4vMA/mKiuLBiHngR+QmHRe7QCUW
         DnOA==
X-Forwarded-Encrypted: i=1; AJvYcCW67p1rQRtdccEpp/GYv/vingFuo/PHjrDigkwCINCc61x4rt+eqcqngYPJz8utQewr0lerRiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFnXPWdfODYtz5EnnGwKjjJ92AhXCRORjRCiJjWK6wN2fRSsx
	8v4qtp0S8JBZcDVs1etdRy8w0yqDGz40xC4TosMaqGIrEzf/EYaGiIBFWx2shtt9Nx37Vct4erV
	60cSwL88mebVhQk1C9JOgSpPD6d8MQEKC+MJ1fLp6
X-Gm-Gg: ASbGncv+TukGW6w9xG5kofE8LgUD8cQruqNXw9NyOe9aLihg/tiDpNtzeyj0W1Ck8JX
	BVyYpF2Xji1Q8UsioVg/4OqRIQ2ITpkFSBee/YBnwRDG6KyDWIHDfj68rPwTuWXW0XcqyRe8FyL
	Vak4zz5OI5JGyCecteCc1pzMcUiayAue6JH0N+MgNv+7/opUIebped+4z/WYorMH6RuNBU0WAH6
	XnZ
X-Google-Smtp-Source: AGHT+IGTgKXaAA1x5i6QZoEttLV/x1M1s3bH2xAN2Bfc0MtFN9FAySW0+L6uh0JGag5hNhoSUyT0j9XRU/s5dBj/XT4=
X-Received: by 2002:a17:90b:278b:b0:316:d69d:49fb with SMTP id
 98e67ed59e1d1-318c8edb091mr1778274a91.14.1750986153722; Thu, 26 Jun 2025
 18:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-14-kuni1840@gmail.com>
 <CANn89iJs9Z1PgRUTik63tLwTJATVMzZGe0Cpg1MNwCW0F2Mihg@mail.gmail.com>
In-Reply-To: <CANn89iJs9Z1PgRUTik63tLwTJATVMzZGe0Cpg1MNwCW0F2Mihg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Jun 2025 18:02:22 -0700
X-Gm-Features: Ac12FXykTjTmMiLwwcwxRpqKHFXyLGcPo99dIrvD6EJP5dikGwoz_BvoJL8ICvY
Message-ID: <CAAVpQUBWepaZYZvPjNMzSYiERWuvM15wtBJE+y5iWavO+saCqA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail=
.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > The next patch will replace __dev_get_by_index() and __dev_get_by_flags=
()
> > to RCU + refcount version.
> >
> > Then, we will need to call dev_put() in some error paths.
> >
> > Let's unify two error paths to make the next patch cleaner.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv6/anycast.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> > index 8440e7b27f6d..e0a1f9d7622c 100644
> > --- a/net/ipv6/anycast.c
> > +++ b/net/ipv6/anycast.c
> > @@ -67,12 +67,11 @@ static u32 inet6_acaddr_hash(const struct net *net,
> >  int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_a=
ddr *addr)
> >  {
> >         struct ipv6_pinfo *np =3D inet6_sk(sk);
> > +       struct ipv6_ac_socklist *pac =3D NULL;
> > +       struct net *net =3D sock_net(sk);
> >         struct net_device *dev =3D NULL;
> >         struct inet6_dev *idev;
> > -       struct ipv6_ac_socklist *pac;
> > -       struct net *net =3D sock_net(sk);
> > -       int     ishost =3D !net->ipv6.devconf_all->forwarding;
> > -       int     err =3D 0;
> > +       int err =3D 0, ishost;
> >
> >         ASSERT_RTNL();
> >
> > @@ -84,15 +83,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex,=
 const struct in6_addr *addr)
> >         if (ifindex)
> >                 dev =3D __dev_get_by_index(net, ifindex);
> >
> > -       if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENT=
ATIVE))
> > -               return -EINVAL;
> > +       if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENT=
ATIVE)) {
> > +               err =3D -EINVAL;
> > +               goto error;
> > +       }
> >
> >         pac =3D sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_K=
ERNEL);
> > -       if (!pac)
> > -               return -ENOMEM;
> > +       if (!pac) {
> > +               err =3D -ENOMEM;
> > +               goto error;
> > +       }
> > +
> >         pac->acl_next =3D NULL;
> >         pac->acl_addr =3D *addr;
> >
> > +       ishost =3D !net->ipv6.devconf_all->forwarding;
>
> RTNL will no longer protect this read, you should add a READ_ONCE()

Ah exactly.  Will use it.

Thank you!


>
> Other than that :
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

