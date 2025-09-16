Return-Path: <netdev+bounces-223672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67259B59EF2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E00A17A995
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC12FFF87;
	Tue, 16 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klMsETok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546582FFFA4
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042633; cv=none; b=rOop++tl2rWQnO2JBiGmUx4S7GIERR4IWbGpzHxZn91kOQ3Q9dESNrPJ5giTAU0ZwXJ6zeqqEbSS4NxMqhI4GKz5HFKHHQvaYqvMoNXH/ZtXVsUpJY3qW3NMU43QY4tZ6JH9li0G8a3HYEODtpkHNh6xBbrFzRyzi+wek9bb66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042633; c=relaxed/simple;
	bh=ogNem9gejnezoLVH9sItrmLsBevnjOsarN6dwwFNJZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL4zY8KJzyytDHLAphBbupe8q8G0KIALTt1CiLzANuxMTSyNU5MAxmaD0JPifAlmBxyuPCDamDoBmjA1iEF6Ue3bTDQVSJkrvRy6eB7xLfniehsw/RFN636YhgQPkEHYVfzPLrpfTusVjNzv/im17y2nZF90OutXguGCQdviS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klMsETok; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b7a434b2d0so18977471cf.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758042630; x=1758647430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Viat5OO6yMEs4XRramdXJafmSMafZACJT8wXT6FU07w=;
        b=klMsETokKtGw/nkzqIxIRU8JeRnz3qenPAaLmPLrwPuLGj/fAT3ojd9hWwFEVBZP37
         rXbC0qJ3rcSKuMjxWLgsxtXNzA/W8sft9SJpHrX2kkC6S3bmLX6wrRKqcgi3M9GVncrs
         BJ3Fe64y9VJRaD67Yavp9mr3oBM/CIR/3y3N1GAd2FiyZtIXj3a8wpixAtL9inuVxOZC
         edGgg22zb0b68hG4lxW6vAfTufW37c+a2KjTSzQfxVoTY2ux63T0wu9ca4SwHl/36UV+
         xfhW5YGd9FGh4b2d4CpA1nYDQYzwYaJyoat9nDLLD5PyOUMfaMdbspWpbVS3BF6YiPQY
         kabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042630; x=1758647430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Viat5OO6yMEs4XRramdXJafmSMafZACJT8wXT6FU07w=;
        b=xCUVxSHxfJr4TB8G1RUNXZmX8JLfBkyJ5XPR2nBQ2SMHW377aYFC7FenTXm3GVzuhc
         yoatYtm1FhZ7ka+6DFZJkSHauBJUm2qbcUuCFQLnfmp5OHC6dt+ucjesVzGoY6fIEpiA
         a0apnk6oR9JAW6PtCzEcmMSrtrzgDImAVFg1xN7H0QUGHztfWx9ZRmYa8xjByyhLjlOP
         WQzpDbKkLuJjyKf41eW1OXJWwgBakWpUtnFaUhQylHkutrQmiGSVF+zwtKCH+5b9OgDg
         1GAKdfv7cdb8BSbQ83hXEK+nHekLRumA3U0/UhU5nVbWONAntVgIPK7Zo1WIQfpGU0nP
         +Szg==
X-Forwarded-Encrypted: i=1; AJvYcCVoyktllity2xDh62jXY8o/Xi75NqnqwaCZR6NHOWgkbKk/zyoyYl2W/x5pryoQuGdMB68BlCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwp3MyLBAqNpigLnAjne1e1f/QyZ5YS880oQElkqRZh0Hgas5
	nJdDzphuv+7fche1J17g0Tw+/lNTbGZ3wDr5r5pizSRI1h7p9MvJSSfXuHdtapg86DeKEJZmvlE
	B5uUNrLtkulvp7z02MNyxTeVkNUKP5Jv9EFDVfbqL
X-Gm-Gg: ASbGncvPV7o6bqy6g+v331GvWxjDKABewW5BOuiw562SV9H4Vi8jjbFqcJsYY8/79+t
	GKSEb73MtzhTG09+pmM7WSdAiXDZf8eCoVUsqQxAswpc0MOqT2MvcqhGgDbZrjQByyW45H7ZNcf
	ilq6q9nOu+XPUP4HBBXyrazXWjLfbA6Aoss83nFKUs3ZY4gUy3GAhpQAmUZStPHVpMkokTWuVJT
	G/4X/1FG81hVMlX/5qRTvOH
X-Google-Smtp-Source: AGHT+IERpWv82mweWTSxS9JYZSPErjMnFnxYOnaP9d1hCazRaVKjDFXQfNMq7kmyRJF6qMIY6zSCeTu3TG+DuH13YcE=
X-Received: by 2002:ac8:5f4f:0:b0:4b4:9522:67a with SMTP id
 d75a77b69052e-4b77cfd6d44mr222988151cf.33.1758042629533; Tue, 16 Sep 2025
 10:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-10-edumazet@google.com>
 <willemdebruijn.kernel.e4b37db8cf47@gmail.com>
In-Reply-To: <willemdebruijn.kernel.e4b37db8cf47@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Sep 2025 10:10:17 -0700
X-Gm-Features: AS18NWD-jdMN7FhyiVHzBDE2_DJFVJg5V8R1PickSYj3x_9sKhZA6wdWErNh4f4
Message-ID: <CANn89i+KGxhZNmFw8TsD9GzQ8=Acag_ALDw9AB5A4gupBpRzQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:31=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > While having all spinlocks packed into an array was a space saver,
> > this also caused NUMA imbalance and hash collisions.
> >
> > UDPv6 socket size becomes 1600 after this patch.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/udp.h |  1 +
> >  include/net/udp.h   |  1 +
> >  net/ipv4/udp.c      | 20 ++------------------
> >  3 files changed, 4 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > index 6ed008ab166557e868c1918daaaa5d551b7989a7..e554890c4415b411f35007d=
3ece9e6042db7a544 100644
> > --- a/include/linux/udp.h
> > +++ b/include/linux/udp.h
> > @@ -109,6 +109,7 @@ struct udp_sock {
> >        */
> >       struct hlist_node       tunnel_list;
> >       struct numa_drop_counters drop_counters;
> > +     spinlock_t              busylock ____cacheline_aligned_in_smp;
> >  };
> >
> >  #define udp_test_bit(nr, sk)                 \
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > index a08822e294b038c0d00d4a5f5cac62286a207926..eecd64097f91196897f4553=
0540b9c9b68c5ba4e 100644
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
> > @@ -289,6 +289,7 @@ static inline void udp_lib_init_sock(struct sock *s=
k)
> >       struct udp_sock *up =3D udp_sk(sk);
> >
> >       sk->sk_drop_counters =3D &up->drop_counters;
> > +     spin_lock_init(&up->busylock);
> >       skb_queue_head_init(&up->reader_queue);
> >       INIT_HLIST_NODE(&up->tunnel_list);
> >       up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 25143f932447df2a84dd113ca33e1ccf15b3503c..7d1444821ee51a19cd5fd0d=
d5b8d096104c9283c 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1689,17 +1689,11 @@ static void udp_skb_dtor_locked(struct sock *sk=
, struct sk_buff *skb)
> >   * to relieve pressure on the receive_queue spinlock shared by consume=
r.
> >   * Under flood, this means that only one producer can be in line
> >   * trying to acquire the receive_queue spinlock.
> > - * These busylock can be allocated on a per cpu manner, instead of a
> > - * per socket one (that would consume a cache line per socket)
> >   */
> > -static int udp_busylocks_log __read_mostly;
> > -static spinlock_t *udp_busylocks __read_mostly;
> > -
> > -static spinlock_t *busylock_acquire(void *ptr)
> > +static spinlock_t *busylock_acquire(struct sock *sk)
> >  {
> > -     spinlock_t *busy;
> > +     spinlock_t *busy =3D &udp_sk(sk)->busylock;
> >
> > -     busy =3D udp_busylocks + hash_ptr(ptr, udp_busylocks_log);
> >       spin_lock(busy);
> >       return busy;
> >  }
> > @@ -3997,7 +3991,6 @@ static void __init bpf_iter_register(void)
> >  void __init udp_init(void)
> >  {
> >       unsigned long limit;
> > -     unsigned int i;
> >
> >       udp_table_init(&udp_table, "UDP");
> >       limit =3D nr_free_buffer_pages() / 8;
> > @@ -4006,15 +3999,6 @@ void __init udp_init(void)
> >       sysctl_udp_mem[1] =3D limit;
> >       sysctl_udp_mem[2] =3D sysctl_udp_mem[0] * 2;
> >
> > -     /* 16 spinlocks per cpu */
> > -     udp_busylocks_log =3D ilog2(nr_cpu_ids) + 4;
> > -     udp_busylocks =3D kmalloc(sizeof(spinlock_t) << udp_busylocks_log=
,
> > -                             GFP_KERNEL);
>
> A per sock busylock is preferable over increasing this array to be
> full percpu (and converting percpu to avoid false sharing)?
>
> Because that would take a lot of space on modern server platforms?
> Just trying to understand the trade-off made.

The goal of the busylock is to have a single gate before sk->sk_receive_que=
ue.

Having per-cpu spinlocks will not fit the need ?

Note that having per-NUMA receive queues is on my plate, but not finished y=
et.

I tried to remove the busylock (because modern UDP has a second queue
(up->reader_queue),
so __skb_recv_udp() splices things in batches), but busylock was still
beneficial.

