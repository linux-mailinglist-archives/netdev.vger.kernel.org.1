Return-Path: <netdev+bounces-187659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E8AA8928
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 21:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D069B173A2F
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71581E22FC;
	Sun,  4 May 2025 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX1PFvyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D31DED42
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746387303; cv=none; b=a8W4hDc4leBxdpeGPUYDZL1FYxxHoDcORci3HPkxBdbJCkNYipekcytYCbTPMsXPl49X5tExUxLShoyrVUw6oeZAvuE09TqZOZbrZ2sx9FPXfs63js+o8+B3IKC2Grf/chlk4OznKGJzHimJNdzGOqitcNegsDWrFjpicd2HJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746387303; c=relaxed/simple;
	bh=HVGlQW56S+UtskdwDWYa/7HnVlVpcEZ7KodhWlZAjdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg+8Hp6LlG4e5g40WQLAOb9zlTJLL6KEvL9St4ZnHoYPbXd5LVkaloH220YtdaZgYI9TAhVr/QubtGVreqSujenixqrTaMj5hq35gCImPXK9lx3A6CNW9putYb+Zp5zUkQhmq3bS7KPmc+3NYgaBj/1oQRm5EltP5HOX0QssdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX1PFvyq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4775ccf3e56so57908751cf.0
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746387301; x=1746992101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jToSzjwzq8IuYcM/y90bsUQiwsuJyuSgFgu8oX88TGw=;
        b=aX1PFvyqEixn0r1NADvvVAQTnvbCovwpr1+4qr6Aji+eHIgpoYxhSihtaJjr83gJfv
         jor8aYlvVXmeRhXWJbRLfcoaWAFVOClqcChEC5pOW3iLPW5hkxID0k7Hq0n1z1wedEDz
         TQ5kv0kLfE2GUUuzkMCDzzorFBVKDIKNqE1iJTmWci7gEGnICPIeKjmeU2CwqlEdzKW7
         u+BvGnZZhXtYQ8RA1xneuM2IDA0wa0XWuJP2ahqpxFz44siSFZeTytq37S0kJPdh7CDi
         T3zCqxxnMumBFzASVb2LXoo59e5xLDrEitPyCtrG8Lpr3RN8ijDybnFPblHqDkUBeWdt
         iK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746387301; x=1746992101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jToSzjwzq8IuYcM/y90bsUQiwsuJyuSgFgu8oX88TGw=;
        b=XOrANiosocqBR+uziWlFmz8Gv8M7SDtf87NBdcRVpbDnU8mhC87X6yn6gJE3b8iwdg
         syRwd5LKrcDTfBgB4QEGuLZVin+9D6MNQHP+H4HLlHvhMvPbj/y2suSx+fHELINf1tt4
         X5Lx9xEMLX/SoZmA6ZgPeBPyVJNZOXmssxFe2XzFQpNwCejLbG+c4quXoYwQZtCQshGl
         dQlKjQRCvSFJSc9nShCh4DhO+ciKIOPY0Lr0KZ2Vn4yQCQpiIXj+yVmDsUCyNr/8mNkO
         NoHJOMM6AMnis3apKhUqV7qcU5TE1/J5Acpi8TiRUQJolJD5oGwvMzw7oXTcqIfDKc1O
         cw9A==
X-Forwarded-Encrypted: i=1; AJvYcCWbsdv4US6qDvocy13atIEToiSqM1mhYnEzs/Afxk/jYgCL8dNgX1lSxz+W6YI47uJKkbM0k84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4zRqJuY+eGtMXtp7erxMuShZAOTLeTHiqD39sYbk7SKKdPPL
	T5QLRX9fqZdc2YJPYHwDElkynE7AOXT38IIhj2QsBvI1HsRUBN1Zi4pJd5r+IoDGgukoWHjYT/0
	jTvxL79fwQu/b5ckJntWuqeEp5xwGgjcSuSid
X-Gm-Gg: ASbGnctqLG72waS6JavEr5JNOGkcu22/urr+c2LHnWHI0j21ZQ4nW0rywjrTgg+IVNE
	PQDgqrcm43XKDRsldpQMOh26SO/jCTaX1fGSB3jYD5iD2zyDmm6LyrIk0hYnqYBwCmSjaNS67qt
	XLYQKNfM+dcdRHdX0GKV1Sljtq1cA36wcOlQ==
X-Google-Smtp-Source: AGHT+IEL/APVRZMsef9iBGn9RF+yAmac/BBCSX+AUn34PuyMjNmo6MIpnEf123tg9zNYe9bQnkwjGFQeVDmJyvkioog=
X-Received: by 2002:a05:622a:588a:b0:48e:5cbc:bc6 with SMTP id
 d75a77b69052e-48e5cbc0be2mr62325831cf.16.1746387300725; Sun, 04 May 2025
 12:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+r1cGacVC_6n3-A-WSkAa_Nr+pmxJ7Gt+oP-P9by2aGw@mail.gmail.com>
 <20250504172159.7358-1-kuniyu@amazon.com>
In-Reply-To: <20250504172159.7358-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 4 May 2025 12:34:49 -0700
X-Gm-Features: ATxdqUEN1q2aGBTyfnnaEEyfjEm2fZxaNM9s4XwSp8L3gjUrsn6ekbp_56iAflM
Message-ID: <CANn89i+fLC6fd-1ea7W3OhL+562qpjBEbKj7sgtCG7ogZj=dOQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 10:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Sun, 4 May 2025 02:16:13 -0700
> > On Thu, Apr 17, 2025 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.
> > >
> > > The remaining things to do are
> > >
> > >   1. pass false to lwtunnel_valid_encap_type_attr()
> > >   2. use rcu_dereference_rtnl() in fib6_check_nexthop()
> > >   3. place rcu_read_lock() before ip6_route_info_create_nh().
> > >
> > > Let's complete the RTNL-free conversion.
> > >
> > > When each CPU-X adds 100000 routes on table-X in a batch
> > > concurrently on c7a.metal-48xl EC2 instance with 192 CPUs,
> > >
> > > without this series:
> > >
> > >   $ sudo ./route_test.sh
> > >   ...
> > >   added 19200000 routes (100000 routes * 192 tables).
> > >   time elapsed: 191577 milliseconds.
> > >
> > > with this series:
> > >
> > >   $ sudo ./route_test.sh
> > >   ...
> > >   added 19200000 routes (100000 routes * 192 tables).
> > >   time elapsed: 62854 milliseconds.
> > >
> > > I changed the number of routes in each table (1000 ~ 100000)
> > > and consistently saw it finish 3x faster with this series.
> > >
> > > Note that now every caller of lwtunnel_valid_encap_type() passes
> > > false as the last argument, and this can be removed later.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/ipv4/nexthop.c |  4 ++--
> > >  net/ipv6/route.c   | 18 ++++++++++++------
> > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > > index 6ba6cb1340c1..823e4a783d2b 100644
> > > --- a/net/ipv4/nexthop.c
> > > +++ b/net/ipv4/nexthop.c
> > > @@ -1556,12 +1556,12 @@ int fib6_check_nexthop(struct nexthop *nh, st=
ruct fib6_config *cfg,
> > >         if (nh->is_group) {
> > >                 struct nh_group *nhg;
> > >
> > > -               nhg =3D rtnl_dereference(nh->nh_grp);
> > > +               nhg =3D rcu_dereference_rtnl(nh->nh_grp);
> >
> > Or add a condition about table lock being held ?
>
> I think in this context the caller is more of an rcu reader
> than a ipv6 route writer.
>
>
>
> >
> > >                 if (nhg->has_v4)
> > >                         goto no_v4_nh;
> > >                 is_fdb_nh =3D nhg->fdb_nh;
> > >         } else {
> > > -               nhi =3D rtnl_dereference(nh->nh_info);
> > > +               nhi =3D rcu_dereference_rtnl(nh->nh_info);
> > >                 if (nhi->family =3D=3D AF_INET)
> > >                         goto no_v4_nh;
> > >                 is_fdb_nh =3D nhi->fdb_nh;
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index c8c1c75268e3..bb46e724db73 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -3902,12 +3902,16 @@ int ip6_route_add(struct fib6_config *cfg, gf=
p_t gfp_flags,
> > >         if (IS_ERR(rt))
> > >                 return PTR_ERR(rt);
> > >
> > > +       rcu_read_lock();
> >
> > This looks bogus to me (and syzbot)
> >
> > Holding rcu_read_lock() from writers is almost always wrong.
>
> Yes, but I added it as a reader of netdev and nexthop to guarantee
> that they won't go away.

We have standard ways for preventing this, acquiring a refcount on the obje=
cts.
>
>
> >
> > In this case, this prevents any GFP_KERNEL allocations to happen
> > (among other things)
>
> Oh, I completely missed this path, thanks!
>
> Fortunately, it seems all ->build_state() except for
> ip_tun_build_state() use GFP_ATOMIC.
>
> So, simply changing GFP_KERNEL to GFP_ATOMIC is acceptable ?

What protects against writers' mutual exclusion ?

I dislike using GFP_ATOMIC in control paths. This is something that we
must avoid.

This will make admin operations unpredictable. Many scripts would
break under pressure.

>
>
> lwtunnel_state_alloc
>   - kzalloc(GFP_ATOMIC)
>
> ip_tun_build_state
>   - dst_cache_init(GFP_KERNEL)
>
> ip6_tun_build_state / mpls_build_state / xfrmi_build_state
> -> no alloc other than lwtunnel_state_alloc()
>
> bpf_build_state
>   - bpf_parse_prog
>     - nla_memdup(GFP_ATOMIC)
>
> ila_build_state / ioam6_build_state / rpl_build_state / seg6_build_state
>   - dst_cache_init(GFP_ATOMIC)
>
> seg6_local_build_state
>   - seg6_end_dt4_build / seg6_end_dt6_build / seg6_end_dt46_build
>     -> no alloc other than lwtunnel_state_alloc()
>

You mean, following the wrong fix done in :

14a0087e7236228d56bfa3fab7084c19fcb513fb ipv6: sr: switch to
GFP_ATOMIC flag to allocate memory during seg6local LWT setup

