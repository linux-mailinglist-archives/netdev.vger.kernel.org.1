Return-Path: <netdev+bounces-232246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DCC03235
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338993ACC9B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130F34B433;
	Thu, 23 Oct 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdMiN/Us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82D34B41E
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246494; cv=none; b=DK9QIA6WhpHmy0AHTpZ9OQid/UESv2+0hKIvNzInbDaab+oiJx3EDhfm6l4yneT6JJm83fm66EMXX2b+dccVauUIxioQbRoZDxqvnqN2ZPahyaWXWnk1iXdkOee34MetakxdSqfiRoeosbN/ZIlziP/J7EaA5TYaOeE7LGbL/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246494; c=relaxed/simple;
	bh=fQ0tr1YueoCDapc1qGc2156+QDqDX6GAyReZ5OSQnPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1xZPTEn7dPU1xrwyTpgbO6KUpjy5xwMg2vR8D+XWDMO2+wB7hYZRDWemgH067r6Yvg5/UMa03+yYMk+3mlq/yxdw4cPbmR5zXaiRza0AWgDl225TyCn+vSaYbntzrLCxnCJNqp9MdZsvOlv38cqnWjYB4frFp4VxAJd8ut+8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdMiN/Us; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf257f325so1062107a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761246492; x=1761851292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIj0Q6GxvGtyTl8RxrhtLE4kToH3M+ykcjU3zcHyxO0=;
        b=AdMiN/UsPJwnkZW9Ur1F4TJIIVhDxR0HE2u1sGHHmxSRy8LAKd5B4tkVZYdrPJgRjk
         0nOttL1T8td3fvgxXt2mna+gDxSYPYSXhUznv0uyHtvbYr0MgufiFXHCrJ+kSROJS74p
         mlpt9tBZVErd9PbZr/QAzsQBYbzavOe4Ftk1nTlbqLkQJxB9GHRDJ+rwL4TJpk1eS2qv
         wuBzRiMkue7Vbxh432uqBI12wlOG+usXT5jsCB56wM/qOLspfKoamKfZIBoEd0TKUNwD
         5nD6wg2j8bqUtWx74AU5FmSK83nqZd+s5NqYuqeO4SSrefwmpWCoXnXvhM4WRwiZiLvB
         wRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246492; x=1761851292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIj0Q6GxvGtyTl8RxrhtLE4kToH3M+ykcjU3zcHyxO0=;
        b=B7I4nitAGNrylrH0SgYJ05Yfz4oqL9Z4OSX84SiKMAZ2UDMYUIwBisUfIlOR2tdmou
         sKlMrivv87V1CNU/oTzHLu5etUC3vITQia30cDLc0HUhvo1dikBRI66E9WD83zIkEawh
         rhNVKfCl3bUV+iUUfgeSvsh0e5ug9dOTEMiaKLH5ispWEAyRAfLbchG0KZ6orHoDGqxa
         81ZeHNz2gml6iF6Cy2tjewe08HCQeqehXPLvpkxqTlZI9E0zGXclck1gDAtFmmeM+tjZ
         OopSvqYX6x0eIwmTYIPHacXEMwaYudY4Smza99nVDvvFa7TAv0LpXob7UaArnYqdD0c2
         4rMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD0bARvI42N1iZijG/amjOnea4yXcdR9ZkhWNPLk3f93rYj2b9iRz15SQthTTSq4znheYfv2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRZ+Ul0/FNy5BpnlyO/jk7uCIBcUW+HzFhrtTzpn+TZ46cJYv
	Qh47R/PCJQc6o9pV+C0MqZEiCYAr3Smd2ijoff+rtWeeqGeLl1iJNewuywHKzwJhh0HiHsFLFSF
	dHkUgVvbgB5/9tsPEH4pnGsEFFf/f3Y4=
X-Gm-Gg: ASbGncsHdEFOxmaO7iR/9VB/UfIX062Z1G8oUzE3Z40CRWarn8OzOXdvVeqmM4goTZ2
	By5LKxuOc3EclugnFNcyY0I6gxD9ebl7G0zSkY8HWG1fHQdlJrPkqIUJZd315chQehfrLrzwTcF
	hsYDwuGeb5d3ktzdOVgTsoK+JJKxGoyxfoKM9aUC45qxxx9i1Ff2xQO21t+nr/WnKeU+kAc8S2c
	x6js0oDys3U+N45e34TsjWZUsDCpg9S+G9Yi3yMktlCEOXYfYrToDaQCzOs9lMJmBveqikFrSr4
	aaSlbsbMI1OXVT9g1H0CSyjG1APhBuCCd4T6CZA=
X-Google-Smtp-Source: AGHT+IGk0CbPJWmHgLa0FEtp0w0oqJWsAtV9NCI28SzVegb0LefGsbn0+slrxvu477msKzYKJ3XyaKNNn17pkHvL/QY=
X-Received: by 2002:a17:902:ec87:b0:25d:5b09:a201 with SMTP id
 d9443c01a7336-290ca5f0e86mr353283325ad.27.1761246492009; Thu, 23 Oct 2025
 12:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
 <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com> <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com>
In-Reply-To: <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 15:07:59 -0400
X-Gm-Features: AS18NWAAFGZwQ5j02jxjDgPtcWMQjexN39Yakhw-I9nKyTBGbCdkzLKEH6xptrs
Message-ID: <CADvbK_crn204Q5Ce6npx=zPuWfEb8NAV9gPveDUMHQgOB_tYeQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > sctp_accept() will use sk_clone_lock(), but it will be called
> > > with the parent socket locked, and sctp_migrate() acquires the
> > > child lock later.
> > >
> > > Let's add no lock version of sk_clone_lock().
> > >
> > > Note that lockdep complains if we simply use bh_lock_sock_nested().
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  include/net/sock.h |  7 ++++++-
> > >  net/core/sock.c    | 21 ++++++++++++++-------
> > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 01ce231603db..c7e58b8e8a90 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int fam=
ily, gfp_t priority,
> > >  void sk_free(struct sock *sk);
> > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > >  void sk_destruct(struct sock *sk);
> > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priori=
ty);
> > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority, b=
ool lock);
> > > +
> > > +static inline struct sock *sk_clone_lock(const struct sock *sk, cons=
t gfp_t priority)
> > > +{
> > > +       return sk_clone(sk, priority, true);
> > > +}
> > >
> > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, in=
t force,
> > >                              gfp_t priority);
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index a99132cc0965..0a3021f8f8c1 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
> > >  }
> > >
> > >  /**
> > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > - *     @sk: the socket to clone
> > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > + * sk_clone - clone a socket
> > > + * @sk: the socket to clone
> > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > + * @lock: if true, lock the cloned sk
> > >   *
> > > - *     Caller must unlock socket even in error path (bh_unlock_sock(=
newsk))
> > > + * If @lock is true, the clone is locked by bh_lock_sock(), and
> > > + * caller must unlock socket even in error path by bh_unlock_sock().
> > >   */
> > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priori=
ty)
> > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> > > +                     bool lock)
> > >  {
> > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > >         struct sk_filter *filter;
> > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *=
sk, const gfp_t priority)
> > >                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_tra=
cker,
> > >                                       false, priority);
> > >         }
> > > +
> > >         sk_node_init(&newsk->sk_node);
> > >         sock_lock_init(newsk);
> > > -       bh_lock_sock(newsk);
> > > +
> > > +       if (lock)
> > > +               bh_lock_sock(newsk);
> > > +
> > does it really need bh_lock_sock() that early, if not, maybe we can mov=
e
> > it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone()=
?
>
> I think sk_clone_lock() and leaf functions do not have
> lockdep_sock_is_held(), and probably the closest one is
> security_inet_csk_clone() which requires lock_sock() for
> bpf_setsockopt(), this can be easily adjusted though.
> (see bpf_lsm_locked_sockopt_hooks)
>
Right.

> Only concern would be moving bh_lock_sock() there will
> introduce one cache line miss.
I think it=E2=80=99s negligible, and it=E2=80=99s not even on the data path=
, though others
may have different opinions.

