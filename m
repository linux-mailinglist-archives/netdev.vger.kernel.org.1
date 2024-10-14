Return-Path: <netdev+bounces-135214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2E99CD0B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D31C22667
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517941AAE19;
	Mon, 14 Oct 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av2Au3uD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B819E802
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916086; cv=none; b=nqT0AjR5HTkEx+ZnQiDtFoR6RuNHPAJlj16N5kRuNGSNOEKVDRszuB3bCmcFBupv+L3t8F1YlKjhV/pirOUuChILzFrTYJ9JjGZ9o9ZceoeawT24L7jLvbSoS6bTzPXDlRQglnspNerGkWk/KJVj7Rs/bpyusmeoFxXgQ1OZZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916086; c=relaxed/simple;
	bh=ABLvhPJ0Ad4mHuFbroqYzS8RSItbQ5SUiarLZcqb1bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkHUejZc4G4/ZAw4zs4xu7Q8GqTSnmOIidvBFoR2OP3Hk4oM4An8TYjwwbJlwCT+E4Ydqv8HNhnsr28QxbXs9aGD4h/Y3pMMtB7Uc60xzTs7tPHdiBsbGBp8JdU+B8VRNFWyoc41xSp8BWPsV4lQSDSGxNW6dfD3D4322r5umRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Av2Au3uD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4359172a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728916083; x=1729520883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbdxgvzXSdaSGFq7T5rkAEm/dudVmqLH/fKVfGJGkkI=;
        b=Av2Au3uD50lapCJNadrbZ+miiUF3O14rO6UwTLjdm3xooqgKYngGLAVexJMABtPfBY
         C6Sk+Mf6vVyADgiczYJXIKlOoK3zfILub3GPR4Y9UcHSqDs/Cxn3yhuznLAvdSPoExmi
         8Rnzi5kHVH5c5ijbqQZwNZfAfgpBIu3xv00An1TsZGvfrSHy6x8NgdIzrvw3FcWXr6R/
         jzZNaRfNMFK8Fp05NrpQbokmDCBAGXLwNFFKZjOU92sLDBmOp6yTBpAgqaSstoF8vGWz
         Ol4Y5xYppCHWn2wStt74Ui8DORhxVZiPW6M45xSyzhSpvdaLVjlZYLjuB9/uzU/k1QVp
         JpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916083; x=1729520883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbdxgvzXSdaSGFq7T5rkAEm/dudVmqLH/fKVfGJGkkI=;
        b=w/Id/O/SLSTq9alSimZrif1tfmYYSDZZhUWMF1UhiZnxqGRJAYYtgEOoKd1HElmdQq
         fvkr4pEC5FXA0/WNF/6GG+ANw534sVOjXlZAjCx/fr3TVIdRu0pzdDaPM7GivcACj9AV
         oyV+DcE3gRY/WKehd3XhFCj/e41uY4z5sEzIvuUuFbLBDhtqZ4rYsztGO5s4zmXN79zC
         fft87POJbfMu+3n8StDcr2pqnBIZTCpH8tTJMgP1kYeVOkoHCD4zmGkpV2PgjYh+Uzt4
         EM/WW49eIhV1+tnR31aub7SFX/GZIYA9so+dggOaIY5UMqO7sZ/S2+rvIROMle9FT1PB
         QftA==
X-Forwarded-Encrypted: i=1; AJvYcCUggegfF88D/U/7WbMzuRTbkEDhfqw6Mwpxu/Rmg2hJ1TsHOcF5xnzv4HkbT3qZGtYhJkE3x5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLR1S4OdVd4GfsZrujJTbiCXshnn7mhwlGV/YlYvVWYOqMx707
	RjY9tE6kJkdnC680QNmUghn2B9bFe7/8Z+nOmfX1g2TvpyQAPuImDL9DIWvSJ0TIHgLttCvUdAP
	I5/V48aFO5lb37YYDV8E6/bAKkZ6JzUn+JP70
X-Google-Smtp-Source: AGHT+IHUExpEPixo7y9KEO3B9QzSlyM2ZN3vi94Vo+MZ+2mbYy0RDGSS54HPovQnk3DeSeKBpMvx6HDm3Wr+zRRJQLo=
X-Received: by 2002:a05:6402:1ed0:b0:5c9:69d8:630e with SMTP id
 4fb4d7f45d1cf-5c969d867ebmr5567565a12.33.1728916082559; Mon, 14 Oct 2024
 07:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-2-edumazet@google.com>
 <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com>
In-Reply-To: <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 16:27:50 +0200
Message-ID: <CANn89iLv=7fqrYLEF-hO1_EOK4xVEHmD60bqeiJ5Kydc3bJ0+A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Brian Vazquez <brianvv@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:01=E2=80=AFPM Brian Vazquez <brianvv@google.com> =
wrote:
>
> Thanks Eric for the patch series!  I left some comments inline
>
>
> On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> >
> > Make sure sk_to_full_sk() detects this and does not return
> > a non full socket.
> >
> > v3: also changed sk_const_to_full_sk()
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/bpf-cgroup.h | 2 +-
> >  include/net/inet_sock.h    | 8 ++++++--
> >  net/core/filter.c          | 6 +-----
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea2666c4=
d09fd4d1a8091f844 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct s=
ock *sk,
> >         int __ret =3D 0;                                               =
          \
> >         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {            =
        \
> >                 typeof(sk) __sk =3D sk_to_full_sk(sk);                 =
          \
> > -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(skb=
) &&        \
> > +               if (__sk && __sk =3D=3D skb_to_full_sk(skb) &&         =
    \
> >                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS)) =
        \
> >                         __ret =3D __cgroup_bpf_run_filter_skb(__sk, skb=
,         \
> >                                                       CGROUP_INET_EGRES=
S); \
> > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5f94cf=
7c6383948881917df 100644
> > --- a/include/net/inet_sock.h
> > +++ b/include/net/inet_sock.h
> > @@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(const =
struct inet_sock *inet)
> >  static inline struct sock *sk_to_full_sk(struct sock *sk)
> >  {
> >  #ifdef CONFIG_INET
> > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> >                 sk =3D inet_reqsk(sk)->rsk_listener;
> > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> > +               sk =3D NULL;
> >  #endif
> >         return sk;
> >  }
> > @@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(struct so=
ck *sk)
> >  static inline const struct sock *sk_const_to_full_sk(const struct sock=
 *sk)
> >  {
> >  #ifdef CONFIG_INET
> > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> >                 sk =3D ((const struct request_sock *)sk)->rsk_listener;
> > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> > +               sk =3D NULL;
> >  #endif
> >         return sk;
> >  }
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9fc6e0a=
0d4a95986ba6d0ea8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_s=
ock_tuple *tuple, u32 len,
> >                 /* sk_to_full_sk() may return (sk)->rsk_listener, so ma=
ke sure the original sk
> >                  * sock refcnt is decremented to prevent a request_sock=
 leak.
> >                  */
> > -               if (!sk_fullsock(sk2))
> > -                       sk2 =3D NULL;
>
> IIUC, we still want the condition above since sk_to_full_sk can return
> the request socket in which case the helper should return NULL, so we
> still need the refcnt decrement?
>
> >                 if (sk2 !=3D sk) {
> >                         sock_gen_put(sk);

Note that we call sock_gen_put(sk) here, not sock_gen_put(sk2);

sk is not NULL here, so if sk2 is NULL, we will take this branch.

> >                         /* Ensure there is no need to bump sk2 refcnt *=
/
> > @@ -6826,8 +6824,6 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_soc=
k_tuple *tuple, u32 len,
> >                 /* sk_to_full_sk() may return (sk)->rsk_listener, so ma=
ke sure the original sk
> >                  * sock refcnt is decremented to prevent a request_sock=
 leak.
> >                  */
> > -               if (!sk_fullsock(sk2))
> > -                       sk2 =3D NULL;
>
> Same as above.

Should be fine I think.

