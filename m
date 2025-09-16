Return-Path: <netdev+bounces-223691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC806B5A126
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86396523C2D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA02F5A25;
	Tue, 16 Sep 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0nZ8xZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816A283FD0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050104; cv=none; b=WsW9hWrpgN0iF/WuejF2h1bl0oKmHqp2EjUsxbUBNYGWAMopFrcbKXrRcMZn0+UmL+dZS/fYMrPq7fFQg+aX/LdDy3oI16gtNdMwZuHUtV5RBD4jJTCEklWWVaUTfFMhZGNerib1AAj1e6PpECGUFzTXDB1qAgPpQiVjQ+/ykvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050104; c=relaxed/simple;
	bh=c+EWKTYNyHf42e0Fru5vwEBa84g8bGa7yRNicMAjiiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fhPTKTkrTME1WKaXAtLYRuyi6Wy+w4je60ksR4GwFteqWwIxJa4jfBda2oRpKCaJLM6b0zfdVTXN/9PvIyjbtKQ7wEdx3ZGDyFnHMm3b4BIo13rfucVilNnrzcuemmaXpy+rRWrcQkJSfH01Gf8arFNEE8c8ciQEvERGRwTHOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0nZ8xZu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b79773a389so30632451cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758050102; x=1758654902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJgX4ZVONk4444uHBMJ6ZL0jLQUk5fEKkJAqY49cNQY=;
        b=j0nZ8xZuOz4p8UTWD4f27grJYjuB2RZs4m1z4+QXM6AjCG5cR31UeTa0nKSnCo0MQi
         xHWkd+cgvbJOBZjFFb/rxbb6zt2K4DjDESSrhRQbrc8pSIFrOAfDAQ7HjMI1loeppnYN
         64toak0wdT3WgXtdg6ta6k+0N8X9hdF3BLMonrYKXlVH4D1IJ0dmr/lO+DSmzOYP1gL+
         BlS5cCudP5NtIABLuzR89eZoHHydG07obbfCAyVR4sgWIqVw+uMzxhAvhKUGDpHZmKa1
         QqqyKr2xBz7SaluTPZ6C9ZTKOZ+gskpa3Pd3MpFWOSG+vugKHwdWmr8sMSUArQ8LCAX6
         HcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758050102; x=1758654902;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJgX4ZVONk4444uHBMJ6ZL0jLQUk5fEKkJAqY49cNQY=;
        b=THS+DbuKvKIkYTUmHrHK9AKxc5qaLHC4iQ+EnQsgxnfeH7Maye7iyRGjKQIZrdwzTu
         XWWS0gKol8fjrO8XVWyHpWN7UutSK/RtWdEBWutt+zzvmmasp8dlIYD5ol8CnDxtJhD+
         oSPsrRCBNnYbvpOVI96waFoACSw3zYSNLGX1jeaJcd1Axq5Nqz+aDnUh7p+SxprA4i2R
         0vLlkLc/gvUmhhAccQOWGDTW8Wv/phl+I+r5iVp3Lo8DY2VmYJ4/f5Xk8KaBaT1V/qWb
         q+WJoYgB0A6XZcT4egTD9qgdBhXhoQVqNnddU/8Qz2ZCmBlW2imekakEacQFwoIz7DGr
         Z+fA==
X-Forwarded-Encrypted: i=1; AJvYcCXWfLNsIsayTEmKVzdydQtAG2+5FIn9XYNPPZUiCX2AdlTbeNnGhQb2uhWVimuALZLdKxPaelA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMnc882lUpobmWpimyzhe6yC97vtvTBBtFBAPCArlAFQKDEpb
	pNOoUVDgnH8e4Dn/2pNnLmWCyPJ32smkGtJDE1w7zMRZhcPjLOrTG6ns
X-Gm-Gg: ASbGncsNVV2+XUgJcmRnWjpJ0sq8L4y0L0AZkTcxHnrtez04scVGllX1IIpGnQMFJr5
	i915Y86dMUS2OxlpkL+TVIO+ymNPXPFDKMdy1PGMwaI8dNR1aX6sdfBJKCet4454fBDocXqVAut
	BD3LEETU3JozU8fEDetDkpg5g5iWGvi5L0hVAg7FhmuUBIifL97RJxZNQeW/9CsWCxtn1nHU0Mn
	fjwJlDBUfN08ALhcndTP27dBS84bNP/ew3OalhT2OWEDSXUj3VYFJ2bLtB5kggBp08DLrxfEFNk
	v4nh62AxR/ObyzvH7YJvFu5FacQEXhsTRvdIMPKQyTjoiHZ3iHCsCh+JfPfNSCiQpWLaKP1UI7w
	wFMKLgINTG/mU25lmj4yI9/wMdCz1r0dWk43UWO0kwy5mQI+q1USNQiaKqniP26rER+6J071W+3
	0echIDzemrisJf
X-Google-Smtp-Source: AGHT+IE+Vwflbd0hOb/UZOJIBZdgEfbrgB6G+ThUuhIU0Sah9JfS0hnRU4r1Ow5Cq55Rqw3Emr/3sQ==
X-Received: by 2002:ac8:584a:0:b0:4b7:a62d:ef6f with SMTP id d75a77b69052e-4b7a62dfbecmr97874561cf.64.1758050101562;
        Tue, 16 Sep 2025 12:15:01 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b780290365sm70476281cf.18.2025.09.16.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 12:15:00 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:15:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.17894869e21ae@gmail.com>
In-Reply-To: <CANn89i+KGxhZNmFw8TsD9GzQ8=Acag_ALDw9AB5A4gupBpRzQQ@mail.gmail.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-10-edumazet@google.com>
 <willemdebruijn.kernel.e4b37db8cf47@gmail.com>
 <CANn89i+KGxhZNmFw8TsD9GzQ8=Acag_ALDw9AB5A4gupBpRzQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Sep 16, 2025 at 9:31=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > While having all spinlocks packed into an array was a space saver,
> > > this also caused NUMA imbalance and hash collisions.
> > >
> > > UDPv6 socket size becomes 1600 after this patch.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/linux/udp.h |  1 +
> > >  include/net/udp.h   |  1 +
> > >  net/ipv4/udp.c      | 20 ++------------------
> > >  3 files changed, 4 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > > index 6ed008ab166557e868c1918daaaa5d551b7989a7..e554890c4415b411f35=
007d3ece9e6042db7a544 100644
> > > --- a/include/linux/udp.h
> > > +++ b/include/linux/udp.h
> > > @@ -109,6 +109,7 @@ struct udp_sock {
> > >        */
> > >       struct hlist_node       tunnel_list;
> > >       struct numa_drop_counters drop_counters;
> > > +     spinlock_t              busylock ____cacheline_aligned_in_smp=
;
> > >  };
> > >
> > >  #define udp_test_bit(nr, sk)                 \
> > > diff --git a/include/net/udp.h b/include/net/udp.h
> > > index a08822e294b038c0d00d4a5f5cac62286a207926..eecd64097f91196897f=
45530540b9c9b68c5ba4e 100644
> > > --- a/include/net/udp.h
> > > +++ b/include/net/udp.h
> > > @@ -289,6 +289,7 @@ static inline void udp_lib_init_sock(struct soc=
k *sk)
> > >       struct udp_sock *up =3D udp_sk(sk);
> > >
> > >       sk->sk_drop_counters =3D &up->drop_counters;
> > > +     spin_lock_init(&up->busylock);
> > >       skb_queue_head_init(&up->reader_queue);
> > >       INIT_HLIST_NODE(&up->tunnel_list);
> > >       up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 25143f932447df2a84dd113ca33e1ccf15b3503c..7d1444821ee51a19cd5=
fd0dd5b8d096104c9283c 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1689,17 +1689,11 @@ static void udp_skb_dtor_locked(struct sock=
 *sk, struct sk_buff *skb)
> > >   * to relieve pressure on the receive_queue spinlock shared by con=
sumer.
> > >   * Under flood, this means that only one producer can be in line
> > >   * trying to acquire the receive_queue spinlock.
> > > - * These busylock can be allocated on a per cpu manner, instead of=
 a
> > > - * per socket one (that would consume a cache line per socket)
> > >   */
> > > -static int udp_busylocks_log __read_mostly;
> > > -static spinlock_t *udp_busylocks __read_mostly;
> > > -
> > > -static spinlock_t *busylock_acquire(void *ptr)
> > > +static spinlock_t *busylock_acquire(struct sock *sk)
> > >  {
> > > -     spinlock_t *busy;
> > > +     spinlock_t *busy =3D &udp_sk(sk)->busylock;
> > >
> > > -     busy =3D udp_busylocks + hash_ptr(ptr, udp_busylocks_log);
> > >       spin_lock(busy);
> > >       return busy;
> > >  }
> > > @@ -3997,7 +3991,6 @@ static void __init bpf_iter_register(void)
> > >  void __init udp_init(void)
> > >  {
> > >       unsigned long limit;
> > > -     unsigned int i;
> > >
> > >       udp_table_init(&udp_table, "UDP");
> > >       limit =3D nr_free_buffer_pages() / 8;
> > > @@ -4006,15 +3999,6 @@ void __init udp_init(void)
> > >       sysctl_udp_mem[1] =3D limit;
> > >       sysctl_udp_mem[2] =3D sysctl_udp_mem[0] * 2;
> > >
> > > -     /* 16 spinlocks per cpu */
> > > -     udp_busylocks_log =3D ilog2(nr_cpu_ids) + 4;
> > > -     udp_busylocks =3D kmalloc(sizeof(spinlock_t) << udp_busylocks=
_log,
> > > -                             GFP_KERNEL);
> >
> > A per sock busylock is preferable over increasing this array to be
> > full percpu (and converting percpu to avoid false sharing)?
> >
> > Because that would take a lot of space on modern server platforms?
> > Just trying to understand the trade-off made.
> =

> The goal of the busylock is to have a single gate before sk->sk_receive=
_queue.
> =

> Having per-cpu spinlocks will not fit the need ?

Oh of course. For high rate UDP servers I was mistakenly immediately
thinking of SO_REUSEPORT and CPU pinning.

And thus different sockets that may accidentally share a hashed lock
or hit cacheline false sharing.

But this is a single socket being hit with traffic from multiple
producers.
 =

> Note that having per-NUMA receive queues is on my plate, but not finish=
ed yet.

Interesting!

> I tried to remove the busylock (because modern UDP has a second queue
> (up->reader_queue),
> so __skb_recv_udp() splices things in batches), but busylock was still
> beneficial.

Good to know, thanks.

