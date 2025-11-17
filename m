Return-Path: <netdev+bounces-239155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D287C64A63
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 224F128BBE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A35328B6E;
	Mon, 17 Nov 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmNsJ4Tm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C24C676
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389936; cv=none; b=j9oPl2cH/sYc6l+580yelElmpQ3mlXAIsnQGh5xq7FvBScAgGu2z9sDA+/Gvj9fZwoDmInZzf2j0st11uddJ9vb/47dwzy0zJIYWHD9gb8bMHBAOcuqVvOp+boTweogyqcj+J58qbTGYVG5NycWa+5SykN2HVCyycj5jHzl7Ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389936; c=relaxed/simple;
	bh=3B7oQYQXxISpc0yFEceVqJz2wkI4hp4t6apF7PARqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz069ZNz/dhOwr3WusvXx10l9WbQynLLQYHNZwbsfP19NigEW4iqomqwXu6ccBPRO0ByPwnfX+fj6sA8jfWKNnmHAmj4IyAVNNK0cKtl5YoYmKshJNzZJC+v0vfgGxVY1oNRsBwywQy8bgB0eVtV3Q6kTQcV3rPkkaVd61vOMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmNsJ4Tm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4331709968fso15859565ab.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763389934; x=1763994734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rphyKd6lx5vXiMn4wS+v0AFlFan4k7wZ5A0z4ZjVXvQ=;
        b=UmNsJ4TmzPdwkQYp+WSw7xh1ws7+A7ZpEXpNfbwEz13wsRhMW9S86cs9UGM42fezJH
         pTDtjan7x1HezaP2IEIK0VJ4aUB9ebBVFDxzDGUfhzsrK4Qnhc/7oQ7MjTC5+T5pr/yP
         AnBo6a45IPwfGXO5g3HvoZV/VPtPYLmP8RGqIgxQQAiCR5hNCETBuyyXuco44HE/2/2s
         1HE7dac4QKrNM27MK4b/LgeUaaWaQPJtqb2sO9AweEOlRRjq5iE87/UvC/Gr0Fp0X2Bw
         +P1fTqX2kez12fcrSFIkzS0yW3IgRoEOW9N7rjGqs1IrEuFBq9x/5PqsBjYnXsTRQ4k2
         zBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389934; x=1763994734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rphyKd6lx5vXiMn4wS+v0AFlFan4k7wZ5A0z4ZjVXvQ=;
        b=QKmIjf6bezKF4jpvQj6yCMGjgjoJTYgix+0n0zWfPItVLoYN3LRQwBOTGxgVpuGqiK
         zBw7gBtQv6Z7wAc+Ee8jsOjzEiA8uLwNlx7aAIz4mhipHVLkXbnKs33IhVAPnkm3edL5
         Tymi1pfSjoxLIfD6x+HvbFhs3zLmh0yQnJ18Bzws+vppQ0bCS0PRxVFrfOK9UF5kBKKe
         FooVz79ZNPCPPagOn2Q8P6uXJKo5yIBFdW4He6ZQBhVAmQeEjjavM202ppnt7tohzicD
         789yZh1iT27UF9sSy+WkM2nCRhi3qzVxB8wtXqjZGvFvHO2idftdGy2BMZTT/FT2lJQX
         KhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV+sy8GdibgtUVR4pI3u9mYVp/ap2eI8uBNvm7bgdapmSEF9rbpDzTFLUizLhBV8pmGEd9rOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9uSfIRIPq93kMaZvRvr5Ukq7Uj+oPKnfEdATnY0d+8H1aUxq
	D0JcYh4gkuDera7YPA+phpt9bnU3bU6GQcN0SiTz32gIjNJNJLsMiFsxA1r2JP86pdln2FhDnIR
	UIanWDqCLQ85IryLBJdBTt/9YXyFkRGI=
X-Gm-Gg: ASbGncuFql7aZxxjnLOljlf7N3bAOUedCRTKXr5dj4qoFhLRxTwZ9ScAfAP9BhlJ+oj
	/POR5QDpjnaQvXMHwiOSWe/a+NCn58sFD70uwoBbPh+EMeILphu+amvFrBEIwVa8gbzgOlD4kER
	RLoiOJF6Y3mLctRFjWf9x8pQJZNo5KRrxAKeRuuRDQ9O3gYvfp3zolq//mabzB7fsDpEACOi3UC
	SFIugT6wjg5zPtbdMpESpv0NXGynndV9nZ+8pJxonVR5y407X/ptkZoyv3bR48MVVmU+Rk=
X-Google-Smtp-Source: AGHT+IF0MlryiRyh2cGtu1dYZK5+v+yYd1YN4/TITZfb7WUGfWDVF5Xk5Vki95YCRShyRiYKoDkUGdNYitAZ1KHry+0=
X-Received: by 2002:a05:6e02:156c:b0:433:4f9c:96a7 with SMTP id
 e9e14a558f8ab-4348c864ab4mr171162245ab.10.1763389933765; Mon, 17 Nov 2025
 06:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
 <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
 <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
 <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com> <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com>
In-Reply-To: <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 22:31:36 +0800
X-Gm-Features: AWmQ_bm_KExQz8ccKCiAUEDGoM_HdAph8snpO2Jjoch1rLDw3g8O-CROBqQBcMY
Message-ID: <CAL+tcoAJR3Du1ZsJC5KU=pNB7G9FP+qYVe8314GXu8xv7-PC3g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Nov 17, 2025 at 1:17=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 4:57=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 12:41=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > This is a followup of commit e20dfbad8aab ("net: fix napi_consu=
me_skb()
> > > > > > with alien skbs").
> > > > > >
> > > > > > Now the per-cpu napi_skb_cache is populated from TX completion =
path,
> > > > > > we can make use of this cache, especially for cpus not used
> > > > > > from a driver NAPI poll (primary user of napi_cache).
> > > > > >
> > > > > > We can use the napi_skb_cache only if current context is not fr=
om hard irq.
> > > > > >
> > > > > > With this patch, I consistently reach 130 Mpps on my UDP tx str=
ess test
> > > > > > and reduce SLUB spinlock contention to smaller values.
> > > > > >
> > > > > > Note there is still some SLUB contention for skb->head allocati=
ons.
> > > > > >
> > > > > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > > > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > > > > on the platform taxonomy.
> > > > > >
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > >
> > > > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > >
> > > > > Thanks for working on this. Previously I was thinking about this =
as
> > > > > well since it affects the hot path for xsk (please see
> > > > > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). B=
ut I
> > > > > wasn't aware of the benefits between disabling irq and allocating
> > > > > memory. AFAIK, I once removed an enabling/disabling irq pair and =
saw a
> > > > > minor improvement as this commit[1] says. Would you share your
> > > > > invaluable experience with us in this case?
> > > > >
> > > > > In the meantime, I will do more rounds of experiments to see how =
they perform.
> > > >
> > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > Done! I managed to see an improvement. The pps number goes from
> > > > 1,458,644 to 1,647,235 by running [2].
> > > >
> > > > But sadly the news is that the previous commit [3] leads to a huge
> > > > decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]

I have to rephrase a bit. What I did is on top of the commit just
before [3], I tried out the tests to see the number w/o [3] series, so
the numbers were respectively 1,458,644 and 1,980,000. That means
reverting commit [3] brought back that much performance.

Furthermore, I did a few more tests and my env changed:
1) I tried the latest kernel, the number is around 1,680,000. And then
revert commit [3], it's increased to 1,850,000.
2) I tried to apply the current series, the number was around 1,730,000.
3) I tried to apply the current series and reverted [3], the number
was still around 1,730,000.

That means the current series negates the benefits of that commit [3].
I've done many rounds of tests, so the above numbers are quite stable.
I feel I need to directly use the fallback memory allocation instead
of trying napi_skb_cache_get for xsk? I'm not sure if any theory
supports which one is good or not. From my instinct, trying
disabling/enabling is saving time while using napi_skb_cache_get is
also saving time...

> > > > applied, I observed and found xdpsock always allocated the skb on c=
pu
> > > > 0 but the napi poll triggered skb_attempt_defer_free() on another
> > > > call[4], which affected the final results.
> > > >
> > > > [2]
> > > > taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> > > >
> > > > [3]
> > > > commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:   Thu Nov 6 20:29:34 2025 +0000
> > > >
> > > >     net: fix napi_consume_skb() with alien skbs
> > > >
> > > >     There is a lack of NUMA awareness and more generally lack
> > > >     of slab caches affinity on TX completion path.
> > > >
> > > > [4]
> > > > @c[
> > > >     skb_attempt_defer_free+1
> > > >     ixgbe_clean_tx_irq+723
> > > >     ixgbe_poll+119
> > > >     __napi_poll+48
> > > > , ksoftirqd/24]: 1964731
> > > >
> > > > @c[
> > > >     kick_defer_list_purge+1
> > > >     napi_consume_skb+333
> > > >     ixgbe_clean_tx_irq+723
> > > >     ixgbe_poll+119
> > > > , 34, swapper/34]: 123779
> > > >
> > > > Thanks,
> > > > Jason
> > >
> > > Hi Jason.
> > >
> > > It is a bit hard to guess without more details (cpu you are using),
> > > and perhaps perf profiles.
> >
> > Xdpsock only calculates the speed on the cpu where it sends packets.
> > To put in more details, it will check if the packets are sent by
> > inspecting the completion queue and then send another group of packets
> > over and over again.
> >
> > My test env is relatively old:
> > [root@localhost ~]# lscpu
> > Architecture:                x86_64
> >   CPU op-mode(s):            32-bit, 64-bit
> >   Address sizes:             46 bits physical, 48 bits virtual
> >   Byte Order:                Little Endian
> > CPU(s):                      48
> >   On-line CPU(s) list:       0-47
> > Vendor ID:                   GenuineIntel
> >   BIOS Vendor ID:            Intel(R) Corporation
> >   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> >     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> >  CPU @ 2.3GHz
> >     BIOS CPU family:         179
> >     CPU family:              6
> >     Model:                   63
> >     Thread(s) per core:      2
> >     Core(s) per socket:      12
> >     Socket(s):               2
> >     Stepping:                2
> >     CPU(s) scaling MHz:      84%
> >     CPU max MHz:             3100.0000
> >     CPU min MHz:             1200.0000
> >
> > After that commit [3], the perf differs because of the interrupts
> > jumping in the tx path frequently:
> > -   98.72%     0.09%  xdpsock          libc.so.6          [.]
> > __libc_sendto
> >       =E2=96=92
> >    - __libc_sendto
> >                                                                     =E2=
=97=86
> >       - 98.28% entry_SYSCALL_64_after_hwframe
> >                                                                     =E2=
=96=92
> >          - 98.19% do_syscall_64
> >                                                                     =E2=
=96=92
> >             - 97.94% x64_sys_call
> >                                                                     =E2=
=96=92
> >                - 97.91% __x64_sys_sendto
> >                                                                     =E2=
=96=92
> >                   - 97.80% __sys_sendto
> >                                                                     =E2=
=96=92
> >                      - 97.28% xsk_sendmsg
> >                                                                     =E2=
=96=92
> >                         - 97.18% __xsk_sendmsg.constprop.0.isra.0
> >                                                                     =E2=
=96=92
> >                            - 87.85% __xsk_generic_xmit
> >                                                                     =E2=
=96=92
> >                               - 41.71% xsk_build_skb
> >                                                                     =E2=
=96=92
> >                                  - 33.06% sock_alloc_send_pskb
> >                                                                     =E2=
=96=92
> >                                     + 22.06% alloc_skb_with_frags
> >                                                                     =E2=
=96=92
> >                                     + 7.61% skb_set_owner_w
> >                                                                     =E2=
=96=92
> >                                     + 0.58%
> > asm_sysvec_call_function_single
> >                         =E2=96=92
> >                                    1.66% skb_store_bits
> >                                                                     =E2=
=96=92
> >                                    1.60% memcpy_orig
> >                                                                     =E2=
=96=92
> >                                    0.69% xp_raw_get_data
> >                                                                     =E2=
=96=92
> >                               - 32.56% __dev_direct_xmit
> >                                                                     =E2=
=96=92
> >                                  + 15.62% 0xffffffffa064e5ac
> >                                                                     =E2=
=96=92
> >                                  - 7.33% __local_bh_enable_ip
> >                                                                     =E2=
=96=92
> >                                     + 6.18% do_softirq
> >                                                                     =E2=
=96=92
> >                                     + 0.70%
> > asm_sysvec_call_function_single
> >                         =E2=96=92
> >                                  + 5.78% validate_xmit_skb
> >                                                                     =E2=
=96=92
> >                               - 6.08% asm_sysvec_call_function_single
> >                                                                     =E2=
=96=92
> >                                  + sysvec_call_function_single
> >                                                                     =E2=
=96=92
> >                               + 1.62% xp_raw_get_data
> >                                                                     =E2=
=96=92
> >                            - 8.29% _raw_spin_lock
> >                                                                     =E2=
=96=92
> >                               + 3.01% asm_sysvec_call_function_single
> >
> > Prior to that patch, I didn't see any interrupts coming in, so I
> > assume the defer part caused the problem.
>
> This is a trade off.
>
> If you are using a single cpu to send packets, then it will not really
> have contention on SLUB structures.
>
> A bit like RFS : If you want to reach max throughput on a single flow,
> it is probably better _not_ using RFS/RPS,
> so that more than one cpu can be involved in the rx work.

Point taken!

>
> We can add a static key to enable/disable the behaviors that are most
> suited to a particular workload.

Are we going to introduce a new knob to control this snippet in
napi_consume_skb()?

>
> We could also call skb_defer_free_flush() (now it is IRQ safe) from
> napi_skb_cache_get() before
> we attempt to allocate new sk_buff. This would prevent IPI from being sen=
t.

Well, it can but it adds more complexity into the allocation phase. I
would prefer the static key approach :)

Thanks,
Jason

>
> >
> > > In particular which cpu is the bottleneck ?
> > >
> > > 1) There is still the missing part about tuning NAPI_SKB_CACHE_SIZE /
> > > NAPI_SKB_CACHE_BULK, I was hoping you could send the patch we
> > > discussed earlier ?
> >
> > Sure thing :) I've done that part locally, thinking I will post it as
> > long as the current series gets merged?
> >
> > >
> > > 2) I am also working on allowing batches of skbs for skb_attempt_defe=
r_free().
> > >
> > > Another item I am working on is to let the qdisc being serviced
> > > preferably not by the cpu performing TX completion,
> > > I mentioned about making qdisc->running a sequence that we can latch
> > > in __netif_schedule().
> > > (Idea is to be able to not spin on qdisc spinlock from net_tx_action(=
)
> > > if another cpu was able to call qdisc_run())
> >
> > Awesome work. Hope to see it very soon :)
> >
> > Thanks,
> > Jason

