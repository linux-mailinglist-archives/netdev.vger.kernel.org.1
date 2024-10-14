Return-Path: <netdev+bounces-135245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16E99D266
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B661F25407
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FADE1ABEB0;
	Mon, 14 Oct 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jewRlCDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C03A1B6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919448; cv=none; b=EWQzbCkw3hOODq6f5alvDIO1pw1xP1bCi4jELf9jx++N6uZ/VXkoOlyLdd6mnMv7WdjaWQNcd1yCCmPiv/h1342ro5vNNqadnSqerI7xRJn8SNpT1zaKJjbBJOBv6msBknqstCIMUVNkeBaCh9dyGAbafdbFPQ+Z8W5tUSl8ZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919448; c=relaxed/simple;
	bh=rO0tJGNi3kLt3KPhl5sW3yuvDZw4Yl3HBaZnIKZZ+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLqFoxXBxGT+q/FibvzkvEtlQo/BLJ7Lq/RD8aVC85w7362sPMo51VeKc7SKfAJwTvpeli/LVHUhn1w3+xNc6nMINVIF33gG/bYRjAltHBhAoF8+KxWHPq5LgEoYT1IodvDP+KoKphyZPMV2j1dX8UlAbwS/gQJ0v1G7hh0TY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jewRlCDq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso2337029a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728919444; x=1729524244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKAxI22lrx4+MKfqF9+WvbPuha6tMHRMXTtSbnfk5xY=;
        b=jewRlCDqi5ephE1jLRKyp7IAp79wd3o8Z5AuRCO9K9mlTz7/YWATEK0HdjRZOTGPFy
         1yYAq/SFnYo2qdQb84b26ParGp3Lrfgq8sd7bR1NgKuZIM47QfMjfHNSS46gbsVuINtt
         +Cfv+MV6+Mi5xwiZHsYgnIELB5k3AmlJ/Xnzn6gDmYa8kU4oMr4wFbF6Tv3qm2Pi1n+I
         63mqAjSOGFQCjt9n/5pYG/7gs6OlwcpuqbY/8qLnMSb/xG7WqdwSv70wrhLV/cYWCwz8
         frrtvsxZ6apv2bVz3MREF3vlIdTNkEtDsMhz7Wkuo8s+R76f+6TAAdusTEERBA0uKf5T
         ICvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919444; x=1729524244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKAxI22lrx4+MKfqF9+WvbPuha6tMHRMXTtSbnfk5xY=;
        b=TCk7E4ffGj0LjXRJM2vCPA+6uDkloZLyYokcDsi16vQaGopXt+JF6NgSJVvIlgbZpB
         MsqmY8EXUHrqmBzdHFEbsP11RVRvgLGzKfrWn0vB2iCMWhpCJ44lIn3c4vn8ILEBwGrI
         jyrKxsoLeebx8BG4Snjdc5BmpM+GQLeWumkkXNR5Slt6bf5YQHi46m7RabwpE4I3ZNgH
         CHRgqUtY+IveuoXsJ5TKc8U86JtvqmMQu0llJDaDsS6z0JQgjRokJ1U8mFqvz6uNlM0n
         rA4HkhiSispSbBThD2GO+UGPU/8lk9OK7yOYWLVFQvRsnLNVhVLczeMHVuHZNVTJeG1K
         afBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BMQmAOFYVGBOlet/+MuOeoZgn4ih8F+EtrNi+B22PBnxWr6TwXQwuXONdqbddvOWc1vdo+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCy/F1ChQiZ12kXT/NsV/RSzvFGzauR55YQZ50LwH/As7KoGW
	ZnPXSkhsDqakdJw+eRb8iwHBK2yoAQ458HOKPPcyNUc3Byv6o4CrD278mx6X4lmcsaJ1Cu75LU5
	V7CeGWMmKsRtRC6WSe+5nnEOP3aFoh3GO/RmR
X-Google-Smtp-Source: AGHT+IEl4OWsG5/+/7tGc8+QJE8f+AJs4Nh0rawZ+SG6xXo53E1VZ9BWlh6x8YdFGRqhbbbMQGv2w8f4DQqXZ/6I5qg=
X-Received: by 2002:a05:6402:2b86:b0:5c8:95ce:8cc2 with SMTP id
 4fb4d7f45d1cf-5c948cd1d9cmr9374390a12.16.1728919444200; Mon, 14 Oct 2024
 08:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-2-edumazet@google.com>
 <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com>
 <CANn89iLv=7fqrYLEF-hO1_EOK4xVEHmD60bqeiJ5Kydc3bJ0+A@mail.gmail.com> <CAMzD94TytK5RfDvLKXfxR7nys=voptywE3_3zSFymXNCky0AsQ@mail.gmail.com>
In-Reply-To: <CAMzD94TytK5RfDvLKXfxR7nys=voptywE3_3zSFymXNCky0AsQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 17:23:50 +0200
Message-ID: <CANn89iKJQ4_ROo3WSQySGfnzM3reJOAspY3WVx1RZGyqWudZgw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Brian Vazquez <brianvv@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:03=E2=80=AFPM Brian Vazquez <brianvv@google.com> =
wrote:
>
> On Mon, Oct 14, 2024 at 10:28=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
>>
>> On Mon, Oct 14, 2024 at 4:01=E2=80=AFPM Brian Vazquez <brianvv@google.co=
m> wrote:
>> >
>> > Thanks Eric for the patch series!  I left some comments inline
>> >
>> >
>> > On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
>> > >
>> > > TCP will soon attach TIME_WAIT sockets to some ACK and RST.
>> > >
>> > > Make sure sk_to_full_sk() detects this and does not return
>> > > a non full socket.
>> > >
>> > > v3: also changed sk_const_to_full_sk()
>> > >
>> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > ---
>> > >  include/linux/bpf-cgroup.h | 2 +-
>> > >  include/net/inet_sock.h    | 8 ++++++--
>> > >  net/core/filter.c          | 6 +-----
>> > >  3 files changed, 8 insertions(+), 8 deletions(-)
>> > >
>> > > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> > > index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea266=
6c4d09fd4d1a8091f844 100644
>> > > --- a/include/linux/bpf-cgroup.h
>> > > +++ b/include/linux/bpf-cgroup.h
>> > > @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struc=
t sock *sk,
>> > >         int __ret =3D 0;                                            =
             \
>> > >         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {         =
           \
>> > >                 typeof(sk) __sk =3D sk_to_full_sk(sk);              =
             \
>> > > -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(=
skb) &&        \
>> > > +               if (__sk && __sk =3D=3D skb_to_full_sk(skb) &&      =
       \
>> > >                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS=
))         \
>> > >                         __ret =3D __cgroup_bpf_run_filter_skb(__sk, =
skb,         \
>> > >                                                       CGROUP_INET_EG=
RESS); \
>> > > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>> > > index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5f9=
4cf7c6383948881917df 100644
>> > > --- a/include/net/inet_sock.h
>> > > +++ b/include/net/inet_sock.h
>> > > @@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(con=
st struct inet_sock *inet)
>> > >  static inline struct sock *sk_to_full_sk(struct sock *sk)
>> > >  {
>> > >  #ifdef CONFIG_INET
>> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
>> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>> > >                 sk =3D inet_reqsk(sk)->rsk_listener;
>> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
>> > > +               sk =3D NULL;
>> > >  #endif
>> > >         return sk;
>> > >  }
>> > > @@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(struct=
 sock *sk)
>> > >  static inline const struct sock *sk_const_to_full_sk(const struct s=
ock *sk)
>> > >  {
>> > >  #ifdef CONFIG_INET
>> > > -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
>> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>> > >                 sk =3D ((const struct request_sock *)sk)->rsk_listen=
er;
>> > > +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
>> > > +               sk =3D NULL;
>> > >  #endif
>> > >         return sk;
>> > >  }
>> > > diff --git a/net/core/filter.c b/net/core/filter.c
>> > > index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9fc6=
e0a0d4a95986ba6d0ea8 100644
>> > > --- a/net/core/filter.c
>> > > +++ b/net/core/filter.c
>> > > @@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bp=
f_sock_tuple *tuple, u32 len,
>> > >                 /* sk_to_full_sk() may return (sk)->rsk_listener, so=
 make sure the original sk
>> > >                  * sock refcnt is decremented to prevent a request_s=
ock leak.
>> > >                  */
>> > > -               if (!sk_fullsock(sk2))
>> > > -                       sk2 =3D NULL;
>> >
>> > IIUC, we still want the condition above since sk_to_full_sk can return
>> > the request socket in which case the helper should return NULL, so we
>> > still need the refcnt decrement?
>> >
>> > >                 if (sk2 !=3D sk) {
>> > >                         sock_gen_put(sk);
>>
>> Note that we call sock_gen_put(sk) here, not sock_gen_put(sk2);
>>
>>
>> sk is not NULL here, so if sk2 is NULL, we will take this branch.
>
>
> IIUC __bpf_sk_lookup calls __bpf_skc_lookup which can return a request li=
stener socket and takes a refcnt, but  __bpf_sk_lookup should only return f=
ull_sk (no request nor time_wait).
>
> That's why the function tries to detect whether req or time_wait was retr=
ieved by __bpf_skc_lookup and if so, we invalidate the return:  sk =3D NULL=
, and decrement the refcnt. This is done by having sk2 and then comparing v=
s sk, and if sk2 is invalid because time_wait or listener, then we decremen=
t sk (the original return from __bpf_skc_lookup, which took a refcnt)
>
> I agree that after the change to sk_to_full_sk, for time_wait it will ret=
urn NULL, hence the condition is repetitive.
>
> if (!sk_fullsock(sk2))
>   sk2 =3D NULL;
>
> but sk_to_full_sk can still retrieve the listener:   sk =3D inet_reqsk(sk=
)->rsk_listener; in which case we would like to still use
> if (!sk_fullsock(sk2))
>   sk2 =3D NULL;
>
> to invalidate the request socket, decrement the refcount and  sk =3D sk2 =
; // which makes sk =3D=3D NULL?
>
> I think removing that condition allows __bpf_sk_lookup to return the req =
socket, which wasn't possible before?

It was not possible before, and not possible after :

static inline struct sock *sk_to_full_sk(struct sock *sk)
{
#ifdef CONFIG_INET
    if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
        sk =3D inet_reqsk(sk)->rsk_listener;
    if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)    // NEW CODE
        sk =3D NULL;  // NEW CODE
#endif
    return sk;
}

if sk was a request socket, sk2 would be the listener.

sk2 being a listener means that sk_fullsock(sk2) is true.

if (!sk_fullsock(sk2))
   sk2 =3D NULL;

So really this check was only meant for TIME_WAIT, and it is now done
directly from sk_to_full_sk()

Therefore we can delete this dead code.

