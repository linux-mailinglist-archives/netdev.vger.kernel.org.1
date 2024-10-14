Return-Path: <netdev+bounces-135231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03299D0F0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A280B282530
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8A1AB505;
	Mon, 14 Oct 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+6BEWg9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEC19E806
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918525; cv=none; b=tJMB7pCVi88KVLARbW/aCoTq2o0Tsy93a10PpMPkEdLoQWsRKdFV5J1QpWeoVgOIoYHycL6/eNxLjqh2tHDa4UvsYLuR25yBsNhopgx7Innv0mPeeCE2aOEyUkxeUTh9IEXVJDh/0uUJYACGHWqD89y2/Pz0XXypU7/R9YQ5ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918525; c=relaxed/simple;
	bh=q8RMZa41kmt/BLEo2SVyiKRmhpCYo6669r97HonaVWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSMIr/ch0KfwGqyvBl5URKPISol0t9kuNsNOrobSzOR8ItjDDe7v6NzRCIDwJPcYAW3SfW7vP2nVg59YoUPGjekLjnIeS8RsrdFl7KrpspPpKtKqhZ/+qnYx/+JTAxzH9MY8IjpcMUG3qaseijnHORRHBBKG7beGMnHDu8iaKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+6BEWg9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb82317809so31438356d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728918522; x=1729523322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtHcEyGMct2lOXkrUpTPbLZPx+R9Ej62zeXWENXhut4=;
        b=y+6BEWg9i3h3o/kZvGLm4j4UyF/gl5XDHpW85xCLQ+Oq08K6nBgrOlvLNLEQvmL5AM
         Tb/0IfymNHTWwuGfVxNvk14Pj7dPQimsAxEp36PVlaDfXMq1ArhrYsp3dTY3AzWZxLGN
         k4jAXXnQjsp4WvkatjVpvkz6drew1b6chxFa9G18ITAr+7KS6RAWc4MUT3amwIsLsQxh
         t8YcKiJ0qmkvokuXWp3X8NoC527WrYCj6Wfrsn4GGCHhs86yBLhaSrIgx6i8oN3gU55J
         SspfNMpUubEfLAXBXNetsGibqV/XsmH+N+zF5KxmUAer1CmmlhGBofSn2KjNnshS5ijF
         hY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728918522; x=1729523322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtHcEyGMct2lOXkrUpTPbLZPx+R9Ej62zeXWENXhut4=;
        b=tsXX6gi4NohaFZFtP1DwLtUhb+s/40pmv/HQqkX+rWHnunQ8mfeoaRhCMFxE0GoPzp
         GvFBywU1L0/MtpxIGTMIhnfdhR1ZwXF02AJd48R9mACSvRV6FNqoFz5TySsqDeBlPDjQ
         OJLmxPE7SsWcz/XLlSklWqV7q027kFatNPArGtS0mkdfT0lg3LxOST6XTI/xCfgWGXlR
         +zsjTq1BucogdOTf62bnsFDYDTJCOKWTRsZsXKOhjHOtX/zYnVn+NS9iyAzC36eVD4NW
         QHH3PS3/JtYu7QmJRkasg8sZP7s62zzm5t4MbW7h068mbLmwjTBfAkQSNvoH8Hp0y6HA
         KYLA==
X-Forwarded-Encrypted: i=1; AJvYcCWtqATeUUt960QJIqF0SmISxbx5x7YH8jT5RvgqNMRThsxkbF/Bx6a9GCnTP9u65wZUQ/QHF8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVvV0BvhL0SgFYSpJ14GCcsTHghXyJbMf6AoMFFdDgUrY+hNx
	NDa4h2zU3NXdPZlZR1kvXShz/yRyUYAHKg2UIUbU/GK+vtpjp2/aq1IS5/Bwp1O78h77WFcZ4I+
	XLytGZbB5lxxBkuyCGzMoHGFMCwPzDm5HtckD
X-Google-Smtp-Source: AGHT+IHwiuyM02JYzoNVhoHHPU3vy2pGoGIEKvZn/Uu+XzLAwGgV8Lo08T3zeri8Jtjh8jnUePpgcuhwjZErfegc/es=
X-Received: by 2002:a05:6214:5f11:b0:6cb:ae56:1965 with SMTP id
 6a1803df08f44-6cbf9d20984mr126908796d6.15.1728918522077; Mon, 14 Oct 2024
 08:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-2-edumazet@google.com>
 <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com> <CANn89iLv=7fqrYLEF-hO1_EOK4xVEHmD60bqeiJ5Kydc3bJ0+A@mail.gmail.com>
In-Reply-To: <CANn89iLv=7fqrYLEF-hO1_EOK4xVEHmD60bqeiJ5Kydc3bJ0+A@mail.gmail.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 11:08:29 -0400
Message-ID: <CAMzD94SSS0DNh6zOYSB0UdUwbE6ots+_TtcKTjES-jqfJbHbYQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:28=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 4:01=E2=80=AFPM Brian Vazquez <brianvv@google.com=
> wrote:
> >
> > Thanks Eric for the patch series!  I left some comments inline
> >
> >
> > On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> > >
> > > Make sure sk_to_full_sk() detects this and does not return
> > > a non full socket.
> > >
> > > v3: also changed sk_const_to_full_sk()
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/linux/bpf-cgroup.h | 2 +-
> > >  include/net/inet_sock.h    | 8 ++++++--
> > >  net/core/filter.c          | 6 +-----
> > >  3 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > > index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea2666=
c4d09fd4d1a8091f844 100644
> > > --- a/include/linux/bpf-cgroup.h
> > > +++ b/include/linux/bpf-cgroup.h
> > > @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct=
 sock *sk,
> > >         int __ret =3D 0;                                             =
            \
> > >         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {          =
          \
> > >                 typeof(sk) __sk =3D sk_to_full_sk(sk);               =
            \
> > > -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(s=
kb) &&        \
> > > +               if (__sk && __sk =3D=3D skb_to_full_sk(skb) &&       =
      \
> > >                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS)=
)         \
> > >                         __ret =3D __cgroup_bpf_run_filter_skb(__sk, s=
kb,         \
> > >                                                       CGROUP_INET_EGR=
ESS); \
> > > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > > index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5f94=
cf7c6383948881917df 100644
> > > --- a/include/net/inet_sock.h
> > > +++ b/include/net/inet_sock.h
> > > @@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(cons=
t struct inet_sock *inet)
> > >  static inline struct sock *sk_to_full_sk(struct sock *sk)
> > >  {
> > >  #ifdef CONFIG_INET
> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> > >                 sk =3D inet_reqsk(sk)->rsk_listener;
> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> > > +               sk =3D NULL;
> > >  #endif
> > >         return sk;
> > >  }
> > > @@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(struct =
sock *sk)
> > >  static inline const struct sock *sk_const_to_full_sk(const struct so=
ck *sk)
> > >  {
> > >  #ifdef CONFIG_INET
> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
> > >                 sk =3D ((const struct request_sock *)sk)->rsk_listene=
r;
> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> > > +               sk =3D NULL;
> > >  #endif
> > >         return sk;
> > >  }
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9fc6e=
0a0d4a95986ba6d0ea8 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf=
_sock_tuple *tuple, u32 len,
> > >                 /* sk_to_full_sk() may return (sk)->rsk_listener, so =
make sure the original sk
> > >                  * sock refcnt is decremented to prevent a request_so=
ck leak.
> > >                  */
> > > -               if (!sk_fullsock(sk2))
> > > -                       sk2 =3D NULL;
> >
> > IIUC, we still want the condition above since sk_to_full_sk can return
> > the request socket in which case the helper should return NULL, so we
> > still need the refcnt decrement?
> >
> > >                 if (sk2 !=3D sk) {
> > >                         sock_gen_put(sk);
>
> Note that we call sock_gen_put(sk) here, not sock_gen_put(sk2);
>
> sk is not NULL here, so if sk2 is NULL, we will take this branch.

IIUC __bpf_sk_lookup calls __bpf_skc_lookup which can return a request
listener socket and takes a refcnt, but  __bpf_sk_lookup should only
return full_sk (no request nor time_wait).

I agree that after the change to sk_to_full_sk, for time_wait it will
return NULL, hence the condition is repetitive.

if (!sk_fullsock(sk2))
  sk2 =3D NULL;

but sk_to_full_sk can still retrieve the listener:   sk =3D
inet_reqsk(sk)->rsk_listener; in which case we would like to still use

if (!sk_fullsock(sk2))
  sk2 =3D NULL;

to invalidate the request socket, decrement the refcount and  sk =3D sk2
; // which makes sk =3D=3D NULL?

I think removing that condition allows __bpf_sk_lookup to return the
req socket, which wasn't possible before?

>
>
> > >                         /* Ensure there is no need to bump sk2 refcnt=
 */
> > > @@ -6826,8 +6824,6 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_s=
ock_tuple *tuple, u32 len,
> > >                 /* sk_to_full_sk() may return (sk)->rsk_listener, so =
make sure the original sk
> > >                  * sock refcnt is decremented to prevent a request_so=
ck leak.
> > >                  */
> > > -               if (!sk_fullsock(sk2))
> > > -                       sk2 =3D NULL;
> >
> > Same as above.
>
> Should be fine I think.

