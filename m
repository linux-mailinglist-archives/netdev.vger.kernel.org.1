Return-Path: <netdev+bounces-231907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD5BFE75A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C663A254B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8E2D9499;
	Wed, 22 Oct 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjRyB3Sr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914329AB05
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173822; cv=none; b=XajXBDki5HsY+gjxJx/1XdhSHsH7dTqPXGCXXzzMh4jX7FXoOAjQsa3s1P1Xf9Ztzxb1/RRtYelGJQFy2zSNTMUjCeYFl2j9vUwLyZ+wDBZvH4BKOf7H2YqaXs9FjLF0FAKANLCS58bZ/03yduwR1xfy/NIqZL6uD1R9Zn74uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173822; c=relaxed/simple;
	bh=trZcEH5fbIfpy/dy4uIh80UnlmTcj8EtKaSfbZVY90c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYJyVB3aIoMVI/JHHNQtOoCzC0SUSF06F1JaIhkT2FK4N1Y44wfemWQYdxrM+w/FjWQ61N3jXpA2Hb0RxRNjQwpjxTYtZu6aUb3po1LWUtplGikcfqJBljyIz2eMfDs31mOPMOginy+ILiACdks92pbHQW7y5X1YmNS7yoa5a14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjRyB3Sr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2907948c1d2so1276035ad.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761173820; x=1761778620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0E4BJaLARHiiBGcGtJuIEWLcE6spNNO+nXwVK4hnAA=;
        b=yjRyB3SrHAzUgxF19tdzC8rd47tPMrErsaKsfPRfu8dNjMebsFgTP4ABSbwSQoHp3c
         liOfqSaK5VfGWpPGGvM/RC7MXQUpnWQJiY3Kxpyu2+kE8njXI7GSSdHaYtfjQCTG6BlX
         mijMWu4HmGhWndZcJpCQID2KxmwIsOEiA3RMmgKJ7HfK4ylCfskn6BoCPSVcYEqqPiFr
         IvQuCEeLalDwLJvo7Mr0HJji7INpJIwmp2C64Z8MLEhiopEw8dmz8UgHVWtNPGD2c2rI
         VC+mTcdR/qrZNHBa9qbqJvkahdnLhlWDGwnKyR9UDBQZstpDgCa783VdKNJ1R5awzCjk
         PDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761173820; x=1761778620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0E4BJaLARHiiBGcGtJuIEWLcE6spNNO+nXwVK4hnAA=;
        b=UGS46qv0bjuXOUL8zHFl5DCDC24wsYfWSmmBSpOGTIt6hCi8kvEQxQpcZ/fRnD7eEK
         UTKuC0q97XLrUWOxsTh3SlNGUXhoTulo40UmMkoQ0OohY3+u2z4ASbJ86Dfb+Moig4X7
         lHkGbzJcatCUYkAhLlHLcB5/A9Tfe11/NWZh3ryTkJRd4zGxPEevmOP8MKZLtm0YIvFg
         XuV5me3PxcUrwH7M5hMw8Tu6WJewGDUASKKpq5x3VR52wBEGb2x9UdBGwcguNrz1XZs9
         CFKLfYgvz/LOfCvDuA+qk23Wh0d3Pftzuzes7XQmLM3fcLPykYSeVnsxMqw5Q+oEyj16
         KSTw==
X-Forwarded-Encrypted: i=1; AJvYcCXjyPzb95pU9FcCr8JGQq0wpzMZLjB3QEjxs7vhhyBoSMx1jfldjZcLWlblOtRtQb8fInzyRRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfcjp9IXVyq7/LConG9m/ob2u6DYVYE4kuPhZX9lK1JjWLD2x
	T6o07P0+lwfbkYVccNosOLw9Oh6+Dx1EIuOazvZWSy3tRh65os+Kk6jbaVjUVlVVYUE1kT+aP14
	Vf2qdOZbaQsLGYaUAh8kk2kJme6KURu4YOXxpqDy/Sa6oFfrJI7IvW+EJ
X-Gm-Gg: ASbGncvlFkles6bo2pAqIkB7UZy+iSTLpsJH6rc/5kzrWQkZ/OYdXpIJ5ISCgifDkTG
	BLFB/WPjsiwuyD3Rh/msSVeTtamXL77YEfn2nM4dewa5948qLu6tz4F88BEBwP05Y2PFlroeTCx
	3Kb1XENnSdmh7E8hCRz8nGQOdP1RjQaisB9QxqBhFooziWkL7PXEKHil6H9VuNgFSaisu6fIr2D
	h0BDTioCMjLXtoRy767eWNxeD0IrTrGAMuDV9YJo8GvqJbZowKrW1QgPytLk1ZiICvnC0oq8+dD
	Z4mWcpQoI/2FEKY=
X-Google-Smtp-Source: AGHT+IGxpDwt4YvjZ56YxobTy3ltNAHy7C7Pud3TA9U1beR9QmaCB+kX/1DAeKFCc4faFAeG8XREdykN8LEjQHPkT0c=
X-Received: by 2002:a17:902:f551:b0:290:9576:d6ef with SMTP id
 d9443c01a7336-2946e27fb28mr4220875ad.54.1761173819769; Wed, 22 Oct 2025
 15:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
 <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
In-Reply-To: <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 15:56:48 -0700
X-Gm-Features: AS18NWD_AvQFuKAQMs4vtLDRJ1JQ043_7Ul1gYcUTwYE2sK9UaiNk_RN_p3beqA
Message-ID: <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > sctp_accept() will use sk_clone_lock(), but it will be called
> > with the parent socket locked, and sctp_migrate() acquires the
> > child lock later.
> >
> > Let's add no lock version of sk_clone_lock().
> >
> > Note that lockdep complains if we simply use bh_lock_sock_nested().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/sock.h |  7 ++++++-
> >  net/core/sock.c    | 21 ++++++++++++++-------
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 01ce231603db..c7e58b8e8a90 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int famil=
y, gfp_t priority,
> >  void sk_free(struct sock *sk);
> >  void sk_net_refcnt_upgrade(struct sock *sk);
> >  void sk_destruct(struct sock *sk);
> > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority=
);
> > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority, boo=
l lock);
> > +
> > +static inline struct sock *sk_clone_lock(const struct sock *sk, const =
gfp_t priority)
> > +{
> > +       return sk_clone(sk, priority, true);
> > +}
> >
> >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int =
force,
> >                              gfp_t priority);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index a99132cc0965..0a3021f8f8c1 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
> >  }
> >
> >  /**
> > - *     sk_clone_lock - clone a socket, and lock its clone
> > - *     @sk: the socket to clone
> > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > + * sk_clone - clone a socket
> > + * @sk: the socket to clone
> > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > + * @lock: if true, lock the cloned sk
> >   *
> > - *     Caller must unlock socket even in error path (bh_unlock_sock(ne=
wsk))
> > + * If @lock is true, the clone is locked by bh_lock_sock(), and
> > + * caller must unlock socket even in error path by bh_unlock_sock().
> >   */
> > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority=
)
> > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> > +                     bool lock)
> >  {
> >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >         struct sk_filter *filter;
> > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk=
, const gfp_t priority)
> >                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_track=
er,
> >                                       false, priority);
> >         }
> > +
> >         sk_node_init(&newsk->sk_node);
> >         sock_lock_init(newsk);
> > -       bh_lock_sock(newsk);
> > +
> > +       if (lock)
> > +               bh_lock_sock(newsk);
> > +
> does it really need bh_lock_sock() that early, if not, maybe we can move
> it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone()?

I think sk_clone_lock() and leaf functions do not have
lockdep_sock_is_held(), and probably the closest one is
security_inet_csk_clone() which requires lock_sock() for
bpf_setsockopt(), this can be easily adjusted though.
(see bpf_lsm_locked_sockopt_hooks)

Only concern would be moving bh_lock_sock() there will
introduce one cache line miss.

