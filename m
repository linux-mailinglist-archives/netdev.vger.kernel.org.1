Return-Path: <netdev+bounces-239065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA19C63538
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A5C3ACB74
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC342877F1;
	Mon, 17 Nov 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VS8A1yTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579827B331
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372902; cv=none; b=o0l8ohOsBrvVAcxqproPP7z8GehZmWqtztCPHXDHaSaJy0MKS+9recu2/YczC46UEeQszVQvBPt9AQa2LD/Ii9lkbNYEJ1hvnPVZ8KXvBloPFRgIsGcrVmVtZHRJpAb7O2am3dEtnzHgeQhS4BUOlhRjWA8Bc5J4NqZsQ28upaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372902; c=relaxed/simple;
	bh=EVbGrZOGj/YAUIphl4OHF/ghhxFQf4Zo1SkhAUui0nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq03I5mAHVGGxlh7w4yj5eNj/9xSKnNIKf5HIdil5q1H7nTidF+HT7LilDyVsglY0fJ8tZrdyOqeNGpUJs5SnU5i3MHozGyuyfooIZR1fa74CQ9jqHFRTTL0iPKc1KHLOWok+zQ3ctErzI80inl1MQDDwABXFijtvYk0rWduiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VS8A1yTC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb6e678ddso54411361cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763372900; x=1763977700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0NlhtDQi2w6WHgS9jPueq6EpC5EQ1m1cdN5q8cfxPU=;
        b=VS8A1yTCpUZsNE78hIneU/SdGVQ0v8KrYqtAUoSVF+9UvNVNHEq7qVpSaPKdsuY6bi
         wymY/GN0+hyALc83rEr2PcF6Li6QwtKIv6eO246ifV+raT7tiHz32Evzs/jY1F6oLlWD
         BrG/ehLoXzIGfesNCwlWyp6uBIjgOxYk2QCllvauZM1H/z4A4fu93GAspi4h6zdYVE7S
         pPJc0CnGRAw9a9cEDF4eCzNJYOZmPociYIdHkiE6feWaQetmZZh3bYFvV+dd+NWmdIiA
         OlIlgHPD6X6U3P9phQvgSY+plGCkrar2s81HaIyQDcNHVNeLyu9zErufDEcQo+Tw1LdC
         KtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372900; x=1763977700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0NlhtDQi2w6WHgS9jPueq6EpC5EQ1m1cdN5q8cfxPU=;
        b=uvdgKXvXuzISY/sNpbEpelOzHnHKLxTj5rCtD619KDKnmRO2kbNsGKh4jb2WpkH+22
         9tigl2TrWAqOv2P0528xRk6qgwhrBuuZyTeN7iaPVaYYNAK/2k7mQEqAR6Vlezt7+SSR
         IJ09wCrYeSalMdGYDNIW23pJA/c3mzyPGiZ3RicHge6IBjAVxkwDb0Xnts0/nV1Haaza
         nn5bwvccm478JGDzVNGrIilVOkSaWDQHiXDJnQPOmduX59w6hqz7yCkMQKw1bIE9RR20
         U3cazWxmf9Fhk61h8t5LRIS50Ul4zUJjHZ2DpRKp8eqw0UDwHIR4vbiBnpmyeslLeKpC
         oBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5ESkmic1aZdr2WeEmFHhV2CA8Yw+FWvOOq1voBF8dW5DTkZXGJHSJvIaDDXgMocViqLJcuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdAMp2KNmQ1a3enHY6PTs7DkEwEsIzxXmcd6V8MOBTxi2RzoE
	DMppm127yUDS1cRN1ewOwJmJHjeJZg8YqCUFLcVdNjxPTY4sZ0lCGkQRUlTmwP8bXQtrGPmHZs/
	V8+VCfHFr0ATWq8gXXbzAQzcQKxu+7pHBwlptZ+H0
X-Gm-Gg: ASbGncvPo0Z8vylNVzFAqIcMl3jQo9CoauN6lGgjpYCwVJ1bOdEc3XDk0MGcLF3pyjV
	Lf2HFhdd47AwgMhirjoiS5E1gKCTEaVnK/j/S3BfOLNVtfDOiiQ4y8TlvyRMdjKImWXDF+z6Fd2
	vRjEyvMxmHy9rV5+5sH2FMuVuejbTW3Hdx3uYkahqwVAK5ShHb3pZAPtOhdzttP+nYafyQ2at7m
	P8qYLaEIsnlQOmUR95ELjaNnGEGBtez9CUnFU7+XrJULxd5cM/zo2YuNkD+Bm9g6WA+WE9cX1IH
	9ujZtg==
X-Google-Smtp-Source: AGHT+IF3mJ29I0O2pGFHvriYUl9fKxoVm4I/qEk1KL1gKwgbvqPulrt2Z4fVNBk8hZjHddF0Q1TpKRrAVfLi9TsyjhM=
X-Received: by 2002:a05:622a:1392:b0:4ec:f156:883d with SMTP id
 d75a77b69052e-4edf20f1ac6mr164958871cf.43.1763372899548; Mon, 17 Nov 2025
 01:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
 <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
 <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com> <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
In-Reply-To: <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 01:48:06 -0800
X-Gm-Features: AWmQ_bnUDlRlFxEMHViKd4sgIQfBun7qEL3i5Kju_46CpsDnNs1K5o2USsivM5I
Message-ID: <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:17=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Nov 17, 2025 at 4:57=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Nov 17, 2025 at 12:41=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > This is a followup of commit e20dfbad8aab ("net: fix napi_consume=
_skb()
> > > > > with alien skbs").
> > > > >
> > > > > Now the per-cpu napi_skb_cache is populated from TX completion pa=
th,
> > > > > we can make use of this cache, especially for cpus not used
> > > > > from a driver NAPI poll (primary user of napi_cache).
> > > > >
> > > > > We can use the napi_skb_cache only if current context is not from=
 hard irq.
> > > > >
> > > > > With this patch, I consistently reach 130 Mpps on my UDP tx stres=
s test
> > > > > and reduce SLUB spinlock contention to smaller values.
> > > > >
> > > > > Note there is still some SLUB contention for skb->head allocation=
s.
> > > > >
> > > > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > > > on the platform taxonomy.
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > > >
> > > > Thanks for working on this. Previously I was thinking about this as
> > > > well since it affects the hot path for xsk (please see
> > > > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But=
 I
> > > > wasn't aware of the benefits between disabling irq and allocating
> > > > memory. AFAIK, I once removed an enabling/disabling irq pair and sa=
w a
> > > > minor improvement as this commit[1] says. Would you share your
> > > > invaluable experience with us in this case?
> > > >
> > > > In the meantime, I will do more rounds of experiments to see how th=
ey perform.
> > >
> > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > Done! I managed to see an improvement. The pps number goes from
> > > 1,458,644 to 1,647,235 by running [2].
> > >
> > > But sadly the news is that the previous commit [3] leads to a huge
> > > decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
> > > applied, I observed and found xdpsock always allocated the skb on cpu
> > > 0 but the napi poll triggered skb_attempt_defer_free() on another
> > > call[4], which affected the final results.
> > >
> > > [2]
> > > taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> > >
> > > [3]
> > > commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Thu Nov 6 20:29:34 2025 +0000
> > >
> > >     net: fix napi_consume_skb() with alien skbs
> > >
> > >     There is a lack of NUMA awareness and more generally lack
> > >     of slab caches affinity on TX completion path.
> > >
> > > [4]
> > > @c[
> > >     skb_attempt_defer_free+1
> > >     ixgbe_clean_tx_irq+723
> > >     ixgbe_poll+119
> > >     __napi_poll+48
> > > , ksoftirqd/24]: 1964731
> > >
> > > @c[
> > >     kick_defer_list_purge+1
> > >     napi_consume_skb+333
> > >     ixgbe_clean_tx_irq+723
> > >     ixgbe_poll+119
> > > , 34, swapper/34]: 123779
> > >
> > > Thanks,
> > > Jason
> >
> > Hi Jason.
> >
> > It is a bit hard to guess without more details (cpu you are using),
> > and perhaps perf profiles.
>
> Xdpsock only calculates the speed on the cpu where it sends packets.
> To put in more details, it will check if the packets are sent by
> inspecting the completion queue and then send another group of packets
> over and over again.
>
> My test env is relatively old:
> [root@localhost ~]# lscpu
> Architecture:                x86_64
>   CPU op-mode(s):            32-bit, 64-bit
>   Address sizes:             46 bits physical, 48 bits virtual
>   Byte Order:                Little Endian
> CPU(s):                      48
>   On-line CPU(s) list:       0-47
> Vendor ID:                   GenuineIntel
>   BIOS Vendor ID:            Intel(R) Corporation
>   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
>     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
>  CPU @ 2.3GHz
>     BIOS CPU family:         179
>     CPU family:              6
>     Model:                   63
>     Thread(s) per core:      2
>     Core(s) per socket:      12
>     Socket(s):               2
>     Stepping:                2
>     CPU(s) scaling MHz:      84%
>     CPU max MHz:             3100.0000
>     CPU min MHz:             1200.0000
>
> After that commit [3], the perf differs because of the interrupts
> jumping in the tx path frequently:
> -   98.72%     0.09%  xdpsock          libc.so.6          [.]
> __libc_sendto
>       =E2=96=92
>    - __libc_sendto
>                                                                     =E2=
=97=86
>       - 98.28% entry_SYSCALL_64_after_hwframe
>                                                                     =E2=
=96=92
>          - 98.19% do_syscall_64
>                                                                     =E2=
=96=92
>             - 97.94% x64_sys_call
>                                                                     =E2=
=96=92
>                - 97.91% __x64_sys_sendto
>                                                                     =E2=
=96=92
>                   - 97.80% __sys_sendto
>                                                                     =E2=
=96=92
>                      - 97.28% xsk_sendmsg
>                                                                     =E2=
=96=92
>                         - 97.18% __xsk_sendmsg.constprop.0.isra.0
>                                                                     =E2=
=96=92
>                            - 87.85% __xsk_generic_xmit
>                                                                     =E2=
=96=92
>                               - 41.71% xsk_build_skb
>                                                                     =E2=
=96=92
>                                  - 33.06% sock_alloc_send_pskb
>                                                                     =E2=
=96=92
>                                     + 22.06% alloc_skb_with_frags
>                                                                     =E2=
=96=92
>                                     + 7.61% skb_set_owner_w
>                                                                     =E2=
=96=92
>                                     + 0.58%
> asm_sysvec_call_function_single
>                         =E2=96=92
>                                    1.66% skb_store_bits
>                                                                     =E2=
=96=92
>                                    1.60% memcpy_orig
>                                                                     =E2=
=96=92
>                                    0.69% xp_raw_get_data
>                                                                     =E2=
=96=92
>                               - 32.56% __dev_direct_xmit
>                                                                     =E2=
=96=92
>                                  + 15.62% 0xffffffffa064e5ac
>                                                                     =E2=
=96=92
>                                  - 7.33% __local_bh_enable_ip
>                                                                     =E2=
=96=92
>                                     + 6.18% do_softirq
>                                                                     =E2=
=96=92
>                                     + 0.70%
> asm_sysvec_call_function_single
>                         =E2=96=92
>                                  + 5.78% validate_xmit_skb
>                                                                     =E2=
=96=92
>                               - 6.08% asm_sysvec_call_function_single
>                                                                     =E2=
=96=92
>                                  + sysvec_call_function_single
>                                                                     =E2=
=96=92
>                               + 1.62% xp_raw_get_data
>                                                                     =E2=
=96=92
>                            - 8.29% _raw_spin_lock
>                                                                     =E2=
=96=92
>                               + 3.01% asm_sysvec_call_function_single
>
> Prior to that patch, I didn't see any interrupts coming in, so I
> assume the defer part caused the problem.

This is a trade off.

If you are using a single cpu to send packets, then it will not really
have contention on SLUB structures.

A bit like RFS : If you want to reach max throughput on a single flow,
it is probably better _not_ using RFS/RPS,
so that more than one cpu can be involved in the rx work.

We can add a static key to enable/disable the behaviors that are most
suited to a particular workload.

We could also call skb_defer_free_flush() (now it is IRQ safe) from
napi_skb_cache_get() before
we attempt to allocate new sk_buff. This would prevent IPI from being sent.

>
> > In particular which cpu is the bottleneck ?
> >
> > 1) There is still the missing part about tuning NAPI_SKB_CACHE_SIZE /
> > NAPI_SKB_CACHE_BULK, I was hoping you could send the patch we
> > discussed earlier ?
>
> Sure thing :) I've done that part locally, thinking I will post it as
> long as the current series gets merged?
>
> >
> > 2) I am also working on allowing batches of skbs for skb_attempt_defer_=
free().
> >
> > Another item I am working on is to let the qdisc being serviced
> > preferably not by the cpu performing TX completion,
> > I mentioned about making qdisc->running a sequence that we can latch
> > in __netif_schedule().
> > (Idea is to be able to not spin on qdisc spinlock from net_tx_action()
> > if another cpu was able to call qdisc_run())
>
> Awesome work. Hope to see it very soon :)
>
> Thanks,
> Jason

