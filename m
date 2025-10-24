Return-Path: <netdev+bounces-232274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD03C03A46
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A13E634DA31
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B39270EBB;
	Thu, 23 Oct 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIispHrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984525A2BB
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257234; cv=none; b=jM2O4vgKbkwZNFaLYI48/AkNnP+51U/SKWu8UF6h7Fi+XQgD5Bi6d9wGnpAmBa3FTq8zxvm/lnvfs2yM8umRpPjM+kKQI9IRrnAf7LsV63tS8AtvyKCbUcciUwo2balWi5iegeQKMV0zNWTVopz3b2xXCq11drYOofE8zwEkZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257234; c=relaxed/simple;
	bh=lTNnDf1rAg7qRAW38f/WEdm7yRw5hmoLMS9ZeClJ7bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRpXZlaWYaVC53oZhzx4dPjv39eHrjMwaUPyxB/1ns9jzngNfNuVTIADXxFpuxvWQ28nHXIvpc0pfeJqZaWa5bqxvkIjfrHGLJAMrnPmF1EQHnh/yDVB9rGnNWlHGZUfBI3BDN4v4lBzIyDNALUH3ZOr9XYIkFCDH5s+fW6log8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WIispHrq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33e27cda4d7so2712968a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761257232; x=1761862032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCjLocsxqTh0RJXBqEJyhcalASleza4DX5F1KZZ25us=;
        b=WIispHrqSVoZPtOHBc0DDER/r/rEYi1rWQmKhyjo1N5dGPVJDNzrhif0A0gh6D7HE/
         av9rH5Zn6qXt9rWKWTRkEPXhzHk+jqZwoYxTNbGHAjKYlcoVvHYd/jTOPFaNTzlTJ3Of
         usGfao0+UqZIyRmEq6Ua5ZjBIrzrNG/qgmBIYJVgaC2uHVsZmjtu4yaewebVgEzS5AeA
         BiBlH1jpm47/v0s3VZ64PF2JTXxpEgV2GgOgzioL3+6woJyNL108Qt5UHv/F8SycdwBf
         ztaje7E4GjRDw3XZyavQTzvHuoHJJfNboYkBPmNd+n8TBRXnRTM9fjdb4Mu02mpbPLLR
         ddlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761257232; x=1761862032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCjLocsxqTh0RJXBqEJyhcalASleza4DX5F1KZZ25us=;
        b=lw0iJR+pDz0sHinOxoIeB695NTKB229Xer4WGMhStuQKPExGPnA0k6OP3RTdJgSJ2q
         eSEHwf763EdCaDrVYkuwWGlhmResgskAKmot4sFNOab0hgINw8FxxN5wJfTjnPqYXW9t
         artWhsP/wHFuAApTGFJe/3hwq5qQJXEhZ4UzvsoaTnjqnzfsdhz71D8806zCBmUC8gVV
         S+GI8P7U+D8XzdYgW/t+Da8LoJ0VV/yf5kJv8roKvRHBh5IMaGJVSBqu+22P/Cg7Ob54
         YShisA0kP9kT8/xQJRvyaNPHru4MaHygigiL5nXCX0ZMviFBaVPK3TiEaBUGOBJeEm6u
         hGwA==
X-Forwarded-Encrypted: i=1; AJvYcCXwAl30CCS1QXdoHHqx1ZOF7SBOB/aADPzQKxt46BbRejJ5yZ6aN8Ks2d3pierAjUqywh1zaCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lxo2VCOp39rSrJXHrgLTdJGJSiNS660BQwdKEYjjfRpofWIQ
	39wQWwJd09qVFpcugkMbS1kkjkC2JWNMn3LQelNTM061Tx78bSVjta8Uu1WxAQwTPtXcEZ907Ud
	xfw9chTXh3nF0k9jZrnca59te2/TJWszT+Rp7YEsi
X-Gm-Gg: ASbGncupAjsj3AAf8GLKG71Z+/Y/ps2PaRySxUUDYb/sFzjZ9tgtv/ZtJjr3qSPy65o
	hCfDWtvDaFA/0n/ZTgck9Z+M67fmDR906VuLEANkFO6mwuP2p51jB0c4KUtOo5L92ANBHg0RQxZ
	Hvp9mEAnUHFJTIXoxSF1rLY4D2YVhPd8S6af+CrjqURIPA8YsQ7TSpe7bixU/yyJ6VtptMLzSGU
	YrsD8+GxDp7YPghb35hbTcVQh8y+qEIQz2eVTqlz9XhRptiZu9lSY5ul+4QR3SfuaqccAnWu29Y
	XXVlkFZC3NzaJrNfzC/Gz0VOUW7cLZ5px9mA
X-Google-Smtp-Source: AGHT+IFsjv4lekw2MZ3SKOMpczn5Z8XYT/zaU+enOR2vFwiWyiPgS/3CllscgbjsAkrjrGIX3i4q68RKMxqPB4G4j6o=
X-Received: by 2002:a17:902:ce90:b0:293:639:6546 with SMTP id
 d9443c01a7336-29489e33cbdmr4686385ad.20.1761257231864; Thu, 23 Oct 2025
 15:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_eGSkXO1F168tCKd37hNqTVhPLprWpXOM-Z3KN29dB=Zg@mail.gmail.com>
 <20251023204833.3749214-1-kuniyu@google.com> <CADvbK_eObVPH9GJfkpCsHt1obg6sDY0jQ0cpA=c6yyjRiQEaYw@mail.gmail.com>
In-Reply-To: <CADvbK_eObVPH9GJfkpCsHt1obg6sDY0jQ0cpA=c6yyjRiQEaYw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 15:07:00 -0700
X-Gm-Features: AS18NWDON9nRgHPGqm_7FozN8hgAxw3F3MZtX_QAsvQp7B9vzMFy6dwiHnYhgyk
Message-ID: <CAAVpQUC9fKbJX+AzNZPs9cRQNakyuSOm68c31CG6Ae=xM0kO3g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Xin Long <lucien.xin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:57=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Thu, Oct 23, 2025 at 4:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > From: Xin Long <lucien.xin@gmail.com>
> > Date: Thu, 23 Oct 2025 15:55:57 -0400
> > > On Thu, Oct 23, 2025 at 3:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > On Thu, Oct 23, 2025 at 12:08=E2=80=AFPM Xin Long <lucien.xin@gmail=
.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu=
@google.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <ku=
niyu@google.com> wrote:
> > > > > > > >
> > > > > > > > sctp_accept() will use sk_clone_lock(), but it will be call=
ed
> > > > > > > > with the parent socket locked, and sctp_migrate() acquires =
the
> > > > > > > > child lock later.
> > > > > > > >
> > > > > > > > Let's add no lock version of sk_clone_lock().
> > > > > > > >
> > > > > > > > Note that lockdep complains if we simply use bh_lock_sock_n=
ested().
> > > > > > > >
> > > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > > ---
> > > > > > > >  include/net/sock.h |  7 ++++++-
> > > > > > > >  net/core/sock.c    | 21 ++++++++++++++-------
> > > > > > > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > > > > index 01ce231603db..c7e58b8e8a90 100644
> > > > > > > > --- a/include/net/sock.h
> > > > > > > > +++ b/include/net/sock.h
> > > > > > > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *ne=
t, int family, gfp_t priority,
> > > > > > > >  void sk_free(struct sock *sk);
> > > > > > > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > > > > > > >  void sk_destruct(struct sock *sk);
> > > > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gf=
p_t priority);
> > > > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t p=
riority, bool lock);
> > > > > > > > +
> > > > > > > > +static inline struct sock *sk_clone_lock(const struct sock=
 *sk, const gfp_t priority)
> > > > > > > > +{
> > > > > > > > +       return sk_clone(sk, priority, true);
> > > > > > > > +}
> > > > > > > >
> > > > > > > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned lon=
g size, int force,
> > > > > > > >                              gfp_t priority);
> > > > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > > > index a99132cc0965..0a3021f8f8c1 100644
> > > > > > > > --- a/net/core/sock.c
> > > > > > > > +++ b/net/core/sock.c
> > > > > > > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct s=
ock *sk)
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /**
> > > > > > > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > > > > > > - *     @sk: the socket to clone
> > > > > > > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC=
, etc)
> > > > > > > > + * sk_clone - clone a socket
> > > > > > > > + * @sk: the socket to clone
> > > > > > > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, et=
c)
> > > > > > > > + * @lock: if true, lock the cloned sk
> > > > > > > >   *
> > > > > > > > - *     Caller must unlock socket even in error path (bh_un=
lock_sock(newsk))
> > > > > > > > + * If @lock is true, the clone is locked by bh_lock_sock()=
, and
> > > > > > > > + * caller must unlock socket even in error path by bh_unlo=
ck_sock().
> > > > > > > >   */
> > > > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gf=
p_t priority)
> > > > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t p=
riority,
> > > > > > > > +                     bool lock)
> > > > > > > >  {
> > > > > > > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > > > > > > >         struct sk_filter *filter;
> > > > > > > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const str=
uct sock *sk, const gfp_t priority)
> > > > > > > >                 __netns_tracker_alloc(sock_net(newsk), &new=
sk->ns_tracker,
> > > > > > > >                                       false, priority);
> > > > > > > >         }
> > > > > > > > +
> > > > > > > >         sk_node_init(&newsk->sk_node);
> > > > > > > >         sock_lock_init(newsk);
> > > > > > > > -       bh_lock_sock(newsk);
> > > > > > > > +
> > > > > > > > +       if (lock)
> > > > > > > > +               bh_lock_sock(newsk);
> > > > > > > > +
> > > > > > > does it really need bh_lock_sock() that early, if not, maybe =
we can move
> > > > > > > it out of sk_clone_lock(), and names sk_clone_lock() back to =
sk_clone()?
> > > > > >
> > > > > > I think sk_clone_lock() and leaf functions do not have
> > > > > > lockdep_sock_is_held(), and probably the closest one is
> > > > > > security_inet_csk_clone() which requires lock_sock() for
> > > > > > bpf_setsockopt(), this can be easily adjusted though.
> > > > > > (see bpf_lsm_locked_sockopt_hooks)
> > > > > >
> > > > > Right.
> > > > >
> > > > > > Only concern would be moving bh_lock_sock() there will
> > > > > > introduce one cache line miss.
> > > > > I think it=E2=80=99s negligible, and it=E2=80=99s not even on the=
 data path, though others
> > > > > may have different opinions.
> > > >
> > > > For SCTP, yes, but I'd avoid it for TCP.
> > > Okay, not a problem, just doesn't look common to pass such a paramete=
r.
> >
> > Another option would be add a check like this ?
> >
> > ---8<---
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index c7e58b8e8a90..e708b70b04da 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2904,6 +2904,12 @@ static inline bool sk_is_inet(const struct sock =
*sk)
> >         return family =3D=3D AF_INET || family =3D=3D AF_INET6;
> >  }
> >
> > +static inline bool sk_is_sctp(const struct sock *sk)
> > +{
> > +       return IS_ENABLED(CONFIG_SCTP) &&
> > +               sk->sk_protocol =3D=3D IPPROTO_SCTP;
> > +}
> > +
> Oh, better not, I'm actually planning to use sk_clone() in quic_accept() =
:D
>
> https://github.com/lxin/quic/blob/main/modules/net/quic/socket.c#L1421

Okay, then I'll keep the current form.

