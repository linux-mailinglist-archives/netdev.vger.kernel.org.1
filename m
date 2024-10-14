Return-Path: <netdev+bounces-135266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09C99D3B1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D03E1F249C4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B441AD3E1;
	Mon, 14 Oct 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMgInr7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0D1ABEB0
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920395; cv=none; b=OyloFO9hbzw0ho+LQeI+VJGtC4whiUuXn7aZtR9fEChn5YKt+cUdVEJVW4TkS3sjmuwOTD4B8b+InyFDsaApveG+Gm3gXDjYpspMwMv/fgvWWaBO1fJ+ESZFgMmrSlhlMstZ/lENzbwogPjOmpqQv/I64psXKd17cZt/2dwC0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920395; c=relaxed/simple;
	bh=r06WpUBTd3DQTk88VK+6uPKLRVrfdycLWjJdlL5qqTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6FV5cTCCziMuUuNcSTsJyFa7b5mYXRWieVt+Gc0WSbtgg5mBJiNZFRdu5A23WOku5m+OzO8qj3z0otLO3sSaslQV8Jeb7hSD1Tj9R45S1BJyOaySudBrtVZnEzb7bFvsIWIKw71c2p/l9c16RP+KX0wkT9zkHs6LHRZaEOIiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMgInr7N; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e3dfae8b87so2520768b6e.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728920393; x=1729525193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj3juKxkd/TAPEbrearbD1tpcKqIBErL5XuPMzoVNtY=;
        b=GMgInr7N9Ggt8TK0lPE43IBC3Vk9izIqQKOaiDtM5jdSbVoQxBb6p5miM5Kz+P5EuT
         jT7UkPsODtyJFAREBXCD0O02jCRB4Hp/MPeOAzZpqql8rFzKrkftrktemAFNB9YyhyUZ
         +EVMfboTeZ+b/FqMuhQmiu8PWBuSEYM/07IX61nKSbcKnpjwQgeb/49fnGVAs29IKyRl
         pMxcCHt+2KO8ScL5p+CgNlRqsFrHv3tvBGVft+1eXPCfAPsOI13zZPVM0MB/mB6pGwwO
         13U62Dh0mwcVY2pkdow1CxYCVLoHKC9Oy7hgYCNV+o+x3ZA32BsGqQCF26LrTKpGdtVo
         DUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920393; x=1729525193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj3juKxkd/TAPEbrearbD1tpcKqIBErL5XuPMzoVNtY=;
        b=tvDQ3TcgYtGhZwYNMYaS3JLnzibR/SHnl8QAqGByrkso8gyQownycVgMxDNhBVIBzG
         PKv4kErN7Ob3q30KJT8YHDWqWLkwqgm2Yhv/Nra3WeG6w9RclBgjG8Df9L3rulHqlkMx
         sSgKtlLl45TMpTUMm1kw25gPMfLovjwZuboJw0Hqo89hubhqP/bCQ/A0g6jatWu3aLKJ
         NH8JgYtt/tAMlddFkkx+c3BYzLgoXF0oh5WStls3ht8/FkubksvKBZGXi80dtBBDkNlx
         vuBfN2cgGCS85+/7ATScd4NtoDKZnap9ilgw94UOutHBxR1mH4XSA+Haki43caIDjU+s
         bNTw==
X-Forwarded-Encrypted: i=1; AJvYcCU4w0909yLckmRMF+U2PUmzZ7GO33uHgb/4OcoYP8HhdStc/VrgX+ceiXmkwGC/DfijVaUN8iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRxveluoJuavStvbq758eFqx/HbSC2olY2Pm4cPl1vbYhNxxW
	mZgslUgi2rDfPBPjP7Lmhed5BhMT5beEvkiaLAz3mWbahzUQn8cvXUdEngk23VBJiibk77O/5pF
	F9z1D8FLtL+9emCiJOTBHMDv1mRIdORNxrC6B
X-Google-Smtp-Source: AGHT+IEeVcCGwzgTrfLHw8iFRVR2zwqJCOvqSkooOWKGiNS0PFIa+OBYtWMzxupDg2BZAzvIzahA+wSXnMu7ZnzijpE=
X-Received: by 2002:a05:6808:23c4:b0:3e3:9b23:98fd with SMTP id
 5614622812f47-3e5c90f1911mr8217078b6e.23.1728920392744; Mon, 14 Oct 2024
 08:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-2-edumazet@google.com>
 <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com>
 <CANn89iLv=7fqrYLEF-hO1_EOK4xVEHmD60bqeiJ5Kydc3bJ0+A@mail.gmail.com>
 <CAMzD94TytK5RfDvLKXfxR7nys=voptywE3_3zSFymXNCky0AsQ@mail.gmail.com> <CANn89iKJQ4_ROo3WSQySGfnzM3reJOAspY3WVx1RZGyqWudZgw@mail.gmail.com>
In-Reply-To: <CANn89iKJQ4_ROo3WSQySGfnzM3reJOAspY3WVx1RZGyqWudZgw@mail.gmail.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 11:39:38 -0400
Message-ID: <CAMzD94RYOysq0zmDzqqSwHUZNt57-Vob_zvBmJ=em7iZEd=9AQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:24=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 5:03=E2=80=AFPM Brian Vazquez <brianvv@google.com=
> wrote:
> >
> > On Mon, Oct 14, 2024 at 10:28=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>
> >> On Mon, Oct 14, 2024 at 4:01=E2=80=AFPM Brian Vazquez <brianvv@google.=
com> wrote:
> >> >
> >> > Thanks Eric for the patch series!  I left some comments inline
> >> >
> >> >
> >> > On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >> > >
> >> > > TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> >> > >
> >> > > Make sure sk_to_full_sk() detects this and does not return
> >> > > a non full socket.
> >> > >
> >> > > v3: also changed sk_const_to_full_sk()
> >> > >
> >> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> > > ---
> >> > >  include/linux/bpf-cgroup.h | 2 +-
> >> > >  include/net/inet_sock.h    | 8 ++++++--
> >> > >  net/core/filter.c          | 6 +-----
> >> > >  3 files changed, 8 insertions(+), 8 deletions(-)
> >> > >
> >> > > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup=
.h
> >> > > index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea2=
666c4d09fd4d1a8091f844 100644
> >> > > --- a/include/linux/bpf-cgroup.h
> >> > > +++ b/include/linux/bpf-cgroup.h
> >> > > @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(str=
uct sock *sk,
> >> > >         int __ret =3D 0;                                          =
               \
> >> > >         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {       =
             \
> >> > >                 typeof(sk) __sk =3D sk_to_full_sk(sk);            =
               \
> >> > > -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_s=
k(skb) &&        \
> >> > > +               if (__sk && __sk =3D=3D skb_to_full_sk(skb) &&    =
         \
> >> > >                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRE=
SS))         \
> >> > >                         __ret =3D __cgroup_bpf_run_filter_skb(__sk=
, skb,         \
> >> > >                                                       CGROUP_INET_=
EGRESS); \
> >> > > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> >> > > index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5=
f94cf7c6383948881917df 100644
> >> > > --- a/include/net/inet_sock.h
> >> > > +++ b/include/net/inet_sock.h
> >> > > @@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(c=
onst struct inet_sock *inet)
> >> > >  static inline struct sock *sk_to_full_sk(struct sock *sk)
> >> > >  {
> >> > >  #ifdef CONFIG_INET
> >> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> >> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> >> > >                 sk =3D inet_reqsk(sk)->rsk_listener;
> >> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> >> > > +               sk =3D NULL;
> >> > >  #endif
> >> > >         return sk;
> >> > >  }
> >> > > @@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(stru=
ct sock *sk)
> >> > >  static inline const struct sock *sk_const_to_full_sk(const struct=
 sock *sk)
> >> > >  {
> >> > >  #ifdef CONFIG_INET
> >> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> >> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> >> > >                 sk =3D ((const struct request_sock *)sk)->rsk_list=
ener;
> >> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> >> > > +               sk =3D NULL;
> >> > >  #endif
> >> > >         return sk;
> >> > >  }
> >> > > diff --git a/net/core/filter.c b/net/core/filter.c
> >> > > index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9f=
c6e0a0d4a95986ba6d0ea8 100644
> >> > > --- a/net/core/filter.c
> >> > > +++ b/net/core/filter.c
> >> > > @@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct =
bpf_sock_tuple *tuple, u32 len,
> >> > >                 /* sk_to_full_sk() may return (sk)->rsk_listener, =
so make sure the original sk
> >> > >                  * sock refcnt is decremented to prevent a request=
_sock leak.
> >> > >                  */
> >> > > -               if (!sk_fullsock(sk2))
> >> > > -                       sk2 =3D NULL;
> >> >
> >> > IIUC, we still want the condition above since sk_to_full_sk can retu=
rn
> >> > the request socket in which case the helper should return NULL, so w=
e
> >> > still need the refcnt decrement?
> >> >
> >> > >                 if (sk2 !=3D sk) {
> >> > >                         sock_gen_put(sk);
> >>
> >> Note that we call sock_gen_put(sk) here, not sock_gen_put(sk2);
> >>
> >>
> >> sk is not NULL here, so if sk2 is NULL, we will take this branch.
> >
> >
> > IIUC __bpf_sk_lookup calls __bpf_skc_lookup which can return a request =
listener socket and takes a refcnt, but  __bpf_sk_lookup should only return=
 full_sk (no request nor time_wait).
> >
> > That's why the function tries to detect whether req or time_wait was re=
trieved by __bpf_skc_lookup and if so, we invalidate the return:  sk =3D NU=
LL, and decrement the refcnt. This is done by having sk2 and then comparing=
 vs sk, and if sk2 is invalid because time_wait or listener, then we decrem=
ent sk (the original return from __bpf_skc_lookup, which took a refcnt)
> >
> > I agree that after the change to sk_to_full_sk, for time_wait it will r=
eturn NULL, hence the condition is repetitive.
> >
> > if (!sk_fullsock(sk2))
> >   sk2 =3D NULL;
> >
> > but sk_to_full_sk can still retrieve the listener:   sk =3D inet_reqsk(=
sk)->rsk_listener; in which case we would like to still use
> > if (!sk_fullsock(sk2))
> >   sk2 =3D NULL;
> >
> > to invalidate the request socket, decrement the refcount and  sk =3D sk=
2 ; // which makes sk =3D=3D NULL?
> >
> > I think removing that condition allows __bpf_sk_lookup to return the re=
q socket, which wasn't possible before?
>
> It was not possible before, and not possible after :
>
> static inline struct sock *sk_to_full_sk(struct sock *sk)
> {
> #ifdef CONFIG_INET
>     if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>         sk =3D inet_reqsk(sk)->rsk_listener;
>     if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)    // NEW COD=
E
>         sk =3D NULL;  // NEW CODE
> #endif
>     return sk;
> }
>
> if sk was a request socket, sk2 would be the listener.

This is the part that I missed, I got misled by the comment above the dead =
code.

Thanks for clarifying!

>
> sk2 being a listener means that sk_fullsock(sk2) is true.
>
> if (!sk_fullsock(sk2))
>    sk2 =3D NULL;
>
> So really this check was only meant for TIME_WAIT, and it is now done
> directly from sk_to_full_sk()
>
> Therefore we can delete this dead code.

Reviewed-by: Brian Vazquez <brianvv@google.com>

