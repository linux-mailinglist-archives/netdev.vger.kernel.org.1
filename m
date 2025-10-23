Return-Path: <netdev+bounces-232255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB04C034B1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE751AA2794
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5834EEF2;
	Thu, 23 Oct 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHf5EVNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206934E77A
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249371; cv=none; b=DFkpuak32a/400J8rvQvYSfUkkjLwg8ijs3s6GQ69rNwXiW4LV3ml5MoI0j8S/kJAF70M1JnAOdMLAAiV3eLEEec+5y3jwT6ADFQ7DnodrVjxmM4zaBdMOQWbNE1PBx2exBg+0EdCtR19udl9rV6mVHVNheSjMucBJ3nwTDRaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249371; c=relaxed/simple;
	bh=ClIxS7nC5Jdpv8cvpt401eFHRx3ze3U98eYwnues3zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jxn3UuQuwQq2aCu8i+7X1iFba9jlB2ZTRHvfgUW9kfSs/iA4IRL5kaWvR7ujwUzQ7fhL+wZIPc0stnTvRT21k/3Vo3ZcvOGZ+POkhOvQQnaCm32JbuszPtlRmp/Bam6D6Wl7OGJ8BUUJRMO8SGeCbxU13I8lEBSD9LxVTZIT3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHf5EVNT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29470bc80ceso12890895ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761249368; x=1761854168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWBfPVgAmR8XGnCmfIQxh38vfG/MZ0cxdLxPEpjtPNI=;
        b=FHf5EVNTivYp2ntdeOKwP8gf0f5CDaDCKA6PeCqAz4hgG7356D9rvopgmGG0DS5Sp0
         yxq9UdGDv0k35oV1xIuTwHx7mk/v5E/PQfZhSGu5dRjuQlJ2fQ+0qkLmnZQPsgICqtT0
         R6FsOFTy0cI4hkl/ml7ZtqGid2JDbTF3bDaRNQ8X2IYUCeXTkv1E9LHUM8eaweaskU6y
         /4iE2fNyxia/J/Lj7JWLRpJNAyf3ZC4/yh30AWUAxmG+0WftfL3JNbwDWjIFZGpuC3Vz
         E6pT/HYpk+ZOteYiDc2tT55+yfcpo+mvmDmBPExBaJxoL/nDoLJfDXiIyh+RgvQqtwbG
         Orzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249368; x=1761854168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWBfPVgAmR8XGnCmfIQxh38vfG/MZ0cxdLxPEpjtPNI=;
        b=OBL0EBL2oEuhJ9K69Drf7TwNSL0HiwJs4ogvs1SHa57q0EVn53MUZvGs1QjKOhiiE5
         A3WZo1J8Ob9jb9R9EyefhmFyS6K0vN0bq7Mb/6Q1zBaZ9tTZE8Kc7F1s1tc6p5n10P3o
         szNH1CiOVScpnwKcAajkCz+EqXgBtYT6uSDW2flYHExy8maIp3NuahlPOeSVDCVwhvKl
         IubvWGX5zK3khZmoX0HdgK+tORNbPvfqRZitrPykVAmNdmlRjUA7WjGAzq4HOk0tE4l/
         vGL8r73yf7ycRYceDQyz19hbmlrgIq4aEQTVjxrymWvZILg39c/Iato4HPCLbGN0U+CH
         ff4g==
X-Forwarded-Encrypted: i=1; AJvYcCWEpe8/UZtodjwypVBh5MZvBzjWsf+pVrsxrMKbLvH/Z/AHd0lKXjoWwu37tMQkICI7t9YTbRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jCxKoPOZXLuFArO81I7L2/eiEmuaSXPGo7E1CY3b2RrGDJh5
	cugBv5+/hSQBK6hTavnkGc0wo9Xh0eMJ6eurphEDxgR5oGzqAMzZQdylDzlzynyGjtnv+5rvyqJ
	aDFt4EU51M4C9e0M/pJhgAZzsaNGem/I=
X-Gm-Gg: ASbGncsya8aW84fkO+d3ZW2ZxZu0vElg0AoelIM3xiyhFmaovL3/bTdbPRZETBi7ZyM
	FzS1LjbnjJpDHCpaxQOeAXPu2X3aZMGpt0R5m+soDL47+fOpASM+6KxlB4L75RRTNO7msnEIsYK
	SNjXret1itW0ZHBQ5HXyVQ4jv3R4zfL5K23YyNyO3ahZSvIBzaMP7WThHwFTdnAxNSerO8TAGe1
	Rujp8aiiV8rwD1IE/sUO/14XG0UCcPaUUDr9v6kA6MAOn7ltLgpN2cSQ5SRI3V58mBlaTTefdU+
	gOTwIEQRhO0RPjpGO16DDLB65k22cQ==
X-Google-Smtp-Source: AGHT+IHFddbdySw/9m/MedsvZ3ydB/2pkl+cWsV3kmtik3QfVJYNYHrlUHQXDTgkmzhx9npKDZyuRQjVh3G2nJJqoKQ=
X-Received: by 2002:a17:902:d4cc:b0:267:9601:dca0 with SMTP id
 d9443c01a7336-29489e68974mr1079335ad.27.1761249368378; Thu, 23 Oct 2025
 12:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
 <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
 <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com>
 <CADvbK_crn204Q5Ce6npx=zPuWfEb8NAV9gPveDUMHQgOB_tYeQ@mail.gmail.com> <CAAVpQUB1c5Y0w_ddrFfJnvOQGTi3SsrhgsbB9ni7KrOzx9Tejg@mail.gmail.com>
In-Reply-To: <CAAVpQUB1c5Y0w_ddrFfJnvOQGTi3SsrhgsbB9ni7KrOzx9Tejg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 15:55:57 -0400
X-Gm-Features: AS18NWB1QbHaUQXWWl90RLmQNPy5SxsrvM1GqUQzszzrIVa-wsGFgxOg0dTCGVY
Message-ID: <CADvbK_eGSkXO1F168tCKd37hNqTVhPLprWpXOM-Z3KN29dB=Zg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Oct 23, 2025 at 12:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> > > > >
> > > > > sctp_accept() will use sk_clone_lock(), but it will be called
> > > > > with the parent socket locked, and sctp_migrate() acquires the
> > > > > child lock later.
> > > > >
> > > > > Let's add no lock version of sk_clone_lock().
> > > > >
> > > > > Note that lockdep complains if we simply use bh_lock_sock_nested(=
).
> > > > >
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > ---
> > > > >  include/net/sock.h |  7 ++++++-
> > > > >  net/core/sock.c    | 21 ++++++++++++++-------
> > > > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > index 01ce231603db..c7e58b8e8a90 100644
> > > > > --- a/include/net/sock.h
> > > > > +++ b/include/net/sock.h
> > > > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int=
 family, gfp_t priority,
> > > > >  void sk_free(struct sock *sk);
> > > > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > > > >  void sk_destruct(struct sock *sk);
> > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t pr=
iority);
> > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priorit=
y, bool lock);
> > > > > +
> > > > > +static inline struct sock *sk_clone_lock(const struct sock *sk, =
const gfp_t priority)
> > > > > +{
> > > > > +       return sk_clone(sk, priority, true);
> > > > > +}
> > > > >
> > > > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size=
, int force,
> > > > >                              gfp_t priority);
> > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > index a99132cc0965..0a3021f8f8c1 100644
> > > > > --- a/net/core/sock.c
> > > > > +++ b/net/core/sock.c
> > > > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *s=
k)
> > > > >  }
> > > > >
> > > > >  /**
> > > > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > > > - *     @sk: the socket to clone
> > > > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > > + * sk_clone - clone a socket
> > > > > + * @sk: the socket to clone
> > > > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > > + * @lock: if true, lock the cloned sk
> > > > >   *
> > > > > - *     Caller must unlock socket even in error path (bh_unlock_s=
ock(newsk))
> > > > > + * If @lock is true, the clone is locked by bh_lock_sock(), and
> > > > > + * caller must unlock socket even in error path by bh_unlock_soc=
k().
> > > > >   */
> > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t pr=
iority)
> > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priorit=
y,
> > > > > +                     bool lock)
> > > > >  {
> > > > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > > > >         struct sk_filter *filter;
> > > > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct so=
ck *sk, const gfp_t priority)
> > > > >                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns=
_tracker,
> > > > >                                       false, priority);
> > > > >         }
> > > > > +
> > > > >         sk_node_init(&newsk->sk_node);
> > > > >         sock_lock_init(newsk);
> > > > > -       bh_lock_sock(newsk);
> > > > > +
> > > > > +       if (lock)
> > > > > +               bh_lock_sock(newsk);
> > > > > +
> > > > does it really need bh_lock_sock() that early, if not, maybe we can=
 move
> > > > it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clo=
ne()?
> > >
> > > I think sk_clone_lock() and leaf functions do not have
> > > lockdep_sock_is_held(), and probably the closest one is
> > > security_inet_csk_clone() which requires lock_sock() for
> > > bpf_setsockopt(), this can be easily adjusted though.
> > > (see bpf_lsm_locked_sockopt_hooks)
> > >
> > Right.
> >
> > > Only concern would be moving bh_lock_sock() there will
> > > introduce one cache line miss.
> > I think it=E2=80=99s negligible, and it=E2=80=99s not even on the data =
path, though others
> > may have different opinions.
>
> For SCTP, yes, but I'd avoid it for TCP.
Okay, not a problem, just doesn't look common to pass such a parameter.

There is also bh_unlock_sock(newsk) in the free path in sk_clone(),
does it also need a 'if (lock)' check?

