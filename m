Return-Path: <netdev+bounces-229073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51BBD7F32
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17FE04E60AB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832622BE03E;
	Tue, 14 Oct 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPdPH1cl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65D2D12E7
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427298; cv=none; b=QInL2O4S/JGu5egGjBRewt1Y9NAR2yd4H+65ouStYYKgq446inaXqa+pg+JTFXeUuF3lXMarkYYIva7QVcY8vv2bffWnu5nuG3F3qlWICZ9hew2GYcTseP7AlGwJWOWQWe8qxE2eWjWz+1Cv4a1KkCKYGfENNfJQpnTU92F4sCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427298; c=relaxed/simple;
	bh=EYuf8DHHxkdHjdFEtWjnQW2Phpb6t2X+BCewO9UYNjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgiTZlNNSctR6bck4vXl054SM4tCfAjxo8dVCvXxGgDmZBfZBLyDIdIaGJtUau+/MNGlToUs5zbTBOPe/MmQDVxVMjQRFNGsdBiagytH8vp8PM7jXWH3Vvim6UKIXwqO5Ikz/Hl4+c3x4QuKh/jlvpVtsykHGZCfxrEv3/zUCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPdPH1cl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8599c274188so603583685a.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760427294; x=1761032094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhZBe+KFOEeALHAC0hgpJAVd9jryKs5wE2JX/wXp70g=;
        b=mPdPH1clLVBRQ3RL6NVw64v/N350/l7gfEso906YVZXmKF+quDL4yeqAmmF+8fgW28
         PVooUqGUBZiatq1wJmRgrWxBoFGzq8IN/uLMMMby0zCGqvc7Ew8aRHZLE/Ciqmvackoz
         aPpXsWLR+RIBW+y8WihP3RllGHjYGPvJpzOfXldq98KNTzlmTucpgiYNpQTsErc4F6Fd
         /JJhK7kRQHtwYVewwD/RddCBol5eoqeVQcFxehRcPi9KYbw9tbFKC2u0EEUDt/s/jsH3
         t9WSYP/Zj9jMjM5R7Z5Oe9zkgpCHlZ4xzBPBpVCIQa3n/YTrGbxMWxMqsURMTPG+gskH
         8BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427294; x=1761032094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhZBe+KFOEeALHAC0hgpJAVd9jryKs5wE2JX/wXp70g=;
        b=mv/0M2vq2kzUxsBUw18/Pc24CvPXFATXEwe1TZZPUuqysbAlhbRa7catPMJSnxyj8J
         xPG3h8PZ3pKDiNbrYILbMO0GFKiH2VR3xCVtK075pbnS9wcLA/EIU0A2MUOUu4inza8m
         /v/qBdld32JHW8t1+l4V+1MWX0xBs5Mc3huSFGG6ac0b6F0VYbTQNXm7Kq0lnZmPJ5Xq
         K9AbM6yF1Hu2XnbpmPvGQFroBb7TxI2JaZ5JdyU9D/3gBUbbP5K4CrO32uwKtX5XcFJC
         T13hzp8VoAkZc8e/+KWVEccTD7HJ83qI5OHl5rdIkXzz7SYiQjanBlMPoBUldshSh2CX
         BpGg==
X-Forwarded-Encrypted: i=1; AJvYcCXBri2fkJNLqgb8T+U6niTqA9wYIZy8XQS7h8UoKuNUjCcoTl8K3Lms8ebknKoEohXpkEOoCN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIwe/OlXWt9m00srJM6gLQpXK6InYzlftVkPZc5wz1ArCYvCh
	FyFnw7ZuI4Vqp7KqWdG5PEzPEbCXC4gorJczI48U8TDNcGyOu04V9PWuxM5KolMgzK0XI9xVIdn
	bK4D2DJKmwbrhi5pHw78mtSUZwv70f8gK0NrNXEX1
X-Gm-Gg: ASbGncvz3NCEYkRDGD23LQ9m53XS2ORfBy8bNboWAIvzfkOgJaBXM3nU2tZ2GKgnC8f
	mCo5LIL+NJKUCf+c4wK5ZZjEr3pVCJ93fr514+tAeIp4KSiy6Tl/WCYvkDw5xIQedt01BXkAEqT
	mG1QuekjupoNvhZ9O0JDkniIg1uF7Mex3/NqTPEnPt9GCHtYSCV5l2n3aecVln2KaW7zybGY5Ek
	lLUbyvEniN6MPSwG0nDiMO+aTRYKNxRzZH4gLWtBO0=
X-Google-Smtp-Source: AGHT+IHJEIxi921ZD4M7azPZ62gPwDEuiVT3ypq17JktND2xu8zdGhMSgjewDozjYQNfILi5VeRmV2VA+/8l0QGKqPI=
X-Received: by 2002:a05:622a:1107:b0:4dd:1a2f:4889 with SMTP id
 d75a77b69052e-4e6ead678ccmr384029681cf.76.1760427293756; Tue, 14 Oct 2025
 00:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev> <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
 <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev> <CANn89iLQMVms1GF_oY1WSCtmxLZaBJrTKaeHnwRo5p9uzFwnVw@mail.gmail.com>
 <82a04cb1-9451-493c-9b1e-b4a34f2175cd@linux.dev>
In-Reply-To: <82a04cb1-9451-493c-9b1e-b4a34f2175cd@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 00:34:42 -0700
X-Gm-Features: AS18NWDtyvOI1IPpyCshTcEul3NvF3nRdMgaXbL6D6QG_yACLHfOUfDdZPYdkho
Message-ID: <CANn89iJdXiE3b8x8vQtbOOi2DTC5P9bOO1HsnRwSPC8qQC--8g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:21=E2=80=AFAM luoxuanqiang <xuanqiang.luo@linux.=
dev> wrote:
>
>
> =E5=9C=A8 2025/10/13 17:49, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Oct 13, 2025 at 1:26=E2=80=AFAM luoxuanqiang <xuanqiang.luo@lin=
ux.dev> wrote:
> >>
> >> =E5=9C=A8 2025/10/13 15:31, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev> wr=
ote:
> >>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>>
> >>>> Add two functions to atomically replace RCU-protected hlist_nulls en=
tries.
> >>>>
> >>>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> >>>> mentioned in the patch below:
> >>>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->nex=
t for
> >>>> rculist_nulls")
> >>>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->ppr=
ev for
> >>>> hlist_nulls")
> >>>>
> >>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>>> ---
> >>>>    include/linux/rculist_nulls.h | 59 ++++++++++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 59 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_n=
ulls.h
> >>>> index 89186c499dd4..c26cb83ca071 100644
> >>>> --- a/include/linux/rculist_nulls.h
> >>>> +++ b/include/linux/rculist_nulls.h
> >>>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struc=
t hlist_nulls_node *n)
> >>>>    #define hlist_nulls_next_rcu(node) \
> >>>>           (*((struct hlist_nulls_node __rcu __force **)&(node)->next=
))
> >>>>
> >>>> +/**
> >>>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
> >>>> + * @node: element of the list.
> >>>> + */
> >>>> +#define hlist_nulls_pprev_rcu(node) \
> >>>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
> >>>> +
> >>>>    /**
> >>>>     * hlist_nulls_del_rcu - deletes entry from hash list without re-=
initialization
> >>>>     * @n: the element to delete from the hash list.
> >>>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct =
hlist_nulls_node *n)
> >>>>           n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
> >>>> + * @old: the element to be replaced
> >>>> + * @new: the new element to insert
> >>>> + *
> >>>> + * Description:
> >>>> + * Replace the old entry with the new one in a RCU-protected hlist_=
nulls, while
> >>>> + * permitting racing traversals.
> >>>> + *
> >>>> + * The caller must take whatever precautions are necessary (such as=
 holding
> >>>> + * appropriate locks) to avoid racing with another list-mutation pr=
imitive, such
> >>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running =
on this same
> >>>> + * list.  However, it is perfectly legal to run concurrently with t=
he _rcu
> >>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rc=
u().
> >>>> + */
> >>>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node =
*old,
> >>>> +                                          struct hlist_nulls_node *=
new)
> >>>> +{
> >>>> +       struct hlist_nulls_node *next =3D old->next;
> >>>> +
> >>>> +       WRITE_ONCE(new->next, next);
> >>>> +       WRITE_ONCE(new->pprev, old->pprev);
> >>> I do not think these two WRITE_ONCE() are needed.
> >>>
> >>> At this point new is not yet visible.
> >>>
> >>> The following  rcu_assign_pointer() is enough to make sure prior
> >>> writes are committed to memory.
> >> Dear Eric,
> >>
> >> I=E2=80=99m quoting your more detailed explanation from the other patc=
h [0], thank
> >> you for that!
> >>
> >> However, regarding new->next, if the new object is allocated with
> >> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in co=
mmit
> >> efd04f8a8b45 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->next=
 for
> >> rculist_nulls=E2=80=9D)?
> >>
> >> Also, for the WRITE_ONCE() assignments to ->pprev introduced in commit
> >> 860c8802ace1 (=E2=80=9Crcu: Use WRITE_ONCE() for assignments to ->ppre=
v for
> >> hlist_nulls=E2=80=9D) within hlist_nulls_add_head_rcu(), is that also =
unnecessary?
> > I forgot sk_unhashed()/sk_hashed() could be called from lockless contex=
ts.
> >
> > It is a bit weird to annotate the writes, but not the lockless reads,
> > even if apparently KCSAN
> > is okay with that.
> >
> Dear Eric,
>
> I=E2=80=99m sorry=E2=80=94I still haven=E2=80=99t fully grasped the scena=
rio you mentioned where
> sk_unhashed()/sk_hashed() can be called from lock=E2=80=91less contexts. =
It seems
> similar to the race described in commit 860c8802ace1 (=E2=80=9Crcu: Use
> WRITE_ONCE() for assignments to ->pprev for hlist_nulls=E2=80=9D), e.g.: =
[0].
>

inet_unhash() does a lockless sk_unhash(sk) call, while no lock is
held in some cases (look at tcp_done())

void inet_unhash(struct sock *sk)
{
struct inet_hashinfo *hashinfo =3D tcp_get_hashinfo(sk);

if (sk_unhashed(sk))    // Here no lock is held
    return;

Relevant lock (depending on (sk->sk_state =3D=3D TCP_LISTEN)) is acquired
a few lines later.

Then

__sk_nulls_del_node_init_rcu() is called safely, while the bucket lock is h=
eld.




> Two CPUs invoke inet_unhash() from the tcp_retransmit_timer() path on the
> same sk, causing a race even though tcp_retransmit_timer() checks
> lockdep_sock_is_held(sk).
>
> How does this race happen? I can=E2=80=99t find more details to understan=
d the
> situation, so any hints would be greatly appreciated.
>
> My simple understanding is that=E2=80=AFhlist_nulls_replace_rcu()=E2=80=
=AFmight have the
> same call path as=E2=80=AFhlist_nulls_add_head_rcu(), so I keep using=E2=
=80=AFWRITE_ONCE().
>
> Finally, Kuniyuki Iwashima also raised a similar discussion in the v3
> series; here=E2=80=99s the link [1].
>
> [0]:
> ------------------------------------------------------------------------
>
> BUG: KCSAN: data-race in inet_unhash / inet_unhash
>
> write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
>   __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
>   hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
>   __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
>   inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
>   tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
>   tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
>   tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
>   tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
>   tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
>   tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
>   call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
>   expire_timers kernel/time/timer.c:1449 [inline]
>   __run_timers kernel/time/timer.c:1773 [inline]
>   __run_timers kernel/time/timer.c:1740 [inline]
>   run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
>   __do_softirq+0x115/0x33f kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0xbb/0xe0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>   native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
>   arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
>   default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
>   cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>   do_idle+0x1af/0x280 kernel/sched/idle.c:263
>   cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
>   start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
>   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
>
> read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
>   sk_unhashed include/net/sock.h:607 [inline]
>   inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
>   tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
>   tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
>   tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
>   tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
>   tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
>   tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
>   call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
>   expire_timers kernel/time/timer.c:1449 [inline]
>   __run_timers kernel/time/timer.c:1773 [inline]
>   __run_timers kernel/time/timer.c:1740 [inline]
>   run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
>   __do_softirq+0x115/0x33f kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0xbb/0xe0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>   native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
>   arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
>   default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
>   cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>   do_idle+0x1af/0x280 kernel/sched/idle.c:263
>   cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
>   rest_init+0xec/0xf6 init/main.c:452
>   arch_call_rest_init+0x17/0x37
>   start_kernel+0x838/0x85e init/main.c:786
>   x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
>   x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
>   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
>
> ------------------------------------------------------------------------
>
> [1]: https://lore.kernel.org/all/CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds=
3YvuBfBvrhg@mail.gmail.com/
>
> Thanks!
>

