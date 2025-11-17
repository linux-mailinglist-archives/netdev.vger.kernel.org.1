Return-Path: <netdev+bounces-239057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8AC63244
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8186350A98
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447231A577;
	Mon, 17 Nov 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddJ+kvs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1E324B3E
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371029; cv=none; b=AoZNoJ7zMOab0NfLpFKr/lpR4ZdMukkgFLOVOJTLm/X1DvCbYaFKQzPnc34ZW0KVQNPuMgHUbFLtU4E54jZvMJjppVvm9563osMg60iO8G1m1NpE+QlsW1zaHUitxFJnidtcAhPd6OsAyI7k/iT+Y4gd2GSlx6acakVoF/D3IxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371029; c=relaxed/simple;
	bh=2HMw2c61mmfFj0QXcDy5d5wdzf45tCU1MNgoW03okoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kt2PFHBNxTwL7E4txqCoqufz5e6Pb1qKSzRkRyT7TStjJrNJ0p4XZxxPWQq5E3YWoG+4L98rc+AtW167x1qrwcEjfHJWvIp3jekvH2M2cu5Kg/3e93JQCWsDokw5pCK5IPK4Mq86ZclVPbgf6e1XUP9rgpihguExtN/O1lfIjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddJ+kvs6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4336f492d75so21150965ab.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763371023; x=1763975823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiIZ091FZRo0EWuHbVoKq1pZLOP9KZWUy48AUIWb6p8=;
        b=ddJ+kvs6ovRb51moPc7AlcxuvlmSuCn0ZpH74tjR+Oh96n6/e0dZqRqe8gdHk6c9PL
         DyUhUFvXFMFVCqNYrYhe/jV1AfXJKGtNTnEnNqNcXtNPkQbPzEIkP8BZqjwWVgznfo2w
         0MBVoxyBiLMPUl5su1JnsEMoLdsaH54GVsfuXKUA7chQY1iQJEFQ9HjNNFmkXTExgUA5
         BxqMciSV53bOdbn6DtTKUlN5qlHImWc8RwAuwkVB3AfzLwewT1kN9KQbgbVnDl0tJoVU
         zNMMkiyZifqSJFuhOC2HlRbxP2zu1glDuWveMTvMLY98RZfsAgOAvR5OM3FvrpVu+eH5
         sVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763371023; x=1763975823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iiIZ091FZRo0EWuHbVoKq1pZLOP9KZWUy48AUIWb6p8=;
        b=JWNPXRZ7/MVU4BdDIsL/dtpxBLbxKEp60gf2Vu/KnrSOKS/GOOxbfIYdHrd3e//NL+
         dn3rF+zFYOP+3IVvwvY+X7ZOtcMuLy89NAVJ99KAunpuOIayCCnc64G7e2O/zZJhlW5o
         4jrKrIZ73EfrzaHuTS6hDOacAeNfikdgLpsuiL9aI9k0dHX70wa5qdNNxBgi87nM/wGJ
         KKz0nWCpulUkEJ+3qFSpusTnERkc3vjJGjbvXqorSVeYQOUuophfrgqDKOBWrqsgcGzR
         7Ofa700WefZIif6tdVh7fGpoKI8Lvumic+7N97QHoJXj4Deq8c6LYOsOrfm996dlN7mJ
         aRvg==
X-Forwarded-Encrypted: i=1; AJvYcCVnjr0RHrU8C14+P6vA6DuVzcvjtfY1CRUpOjFWjvy6Sy8TqHJGqECHRIceR33+TxHEjhzdszY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1/GfMEUMx3gUpIMUYWd+UWQ0lGcEty/POJo0RPP2sjMtPQaj
	sXE25hHvV7rsbwfSgC4GSlsN2q1R6i4hTcfQgqqUt/yI12pZY09tfQhHR8+Bl3f7wXnjAvdvL7T
	LcXIjtJI8gDnbNYGt2b/gGgs3tEuiL63M0oSMngo=
X-Gm-Gg: ASbGnct3EjPAZ2hag+gFZCv26leg46pDze5QpnoKZg1+eRr3Yyq9hY1F20UV8ptY4NU
	u6a5BxX27s2KAF247FOHxvHO2L7Nu7ZERACOHqRRiW/ME0ESs4kxL2A5E0i+8L8Sm6Y6G9eo4bW
	HQSs6D3fKWigyQJ1pgcqQYhRqjDQwXkpIFhojo5a7yaEBcw1GLwGZaITxB0iaKEDJI1uX3UvLOW
	FE8zbXJOHyHjH/qQtjrSvxDbGJ1KKceQNFUApLDUiSGgwDaX3N36JEtpcM=
X-Google-Smtp-Source: AGHT+IFbXxbspTn7RRSkJwsGwwbchGeFvqw2CByphSyDoz1rhDkuSZ8oa52gw6JxAFMqddWpgEUw04ayc/vDUzRmScE=
X-Received: by 2002:a05:6e02:2501:b0:430:aea6:833f with SMTP id
 e9e14a558f8ab-4348c8b63fdmr133865755ab.8.1763371023327; Mon, 17 Nov 2025
 01:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
 <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com> <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
In-Reply-To: <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 17:16:26 +0800
X-Gm-Features: AWmQ_bkeufONasDAQzphMBpMIqr8zCpLVF5ku_h3nTHR8iA8_BgCh39yirG0oAg
Message-ID: <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:57=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Nov 17, 2025 at 12:41=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > This is a followup of commit e20dfbad8aab ("net: fix napi_consume_s=
kb()
> > > > with alien skbs").
> > > >
> > > > Now the per-cpu napi_skb_cache is populated from TX completion path=
,
> > > > we can make use of this cache, especially for cpus not used
> > > > from a driver NAPI poll (primary user of napi_cache).
> > > >
> > > > We can use the napi_skb_cache only if current context is not from h=
ard irq.
> > > >
> > > > With this patch, I consistently reach 130 Mpps on my UDP tx stress =
test
> > > > and reduce SLUB spinlock contention to smaller values.
> > > >
> > > > Note there is still some SLUB contention for skb->head allocations.
> > > >
> > > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > > on the platform taxonomy.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Thanks for working on this. Previously I was thinking about this as
> > > well since it affects the hot path for xsk (please see
> > > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But I
> > > wasn't aware of the benefits between disabling irq and allocating
> > > memory. AFAIK, I once removed an enabling/disabling irq pair and saw =
a
> > > minor improvement as this commit[1] says. Would you share your
> > > invaluable experience with us in this case?
> > >
> > > In the meantime, I will do more rounds of experiments to see how they=
 perform.
> >
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > Done! I managed to see an improvement. The pps number goes from
> > 1,458,644 to 1,647,235 by running [2].
> >
> > But sadly the news is that the previous commit [3] leads to a huge
> > decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
> > applied, I observed and found xdpsock always allocated the skb on cpu
> > 0 but the napi poll triggered skb_attempt_defer_free() on another
> > call[4], which affected the final results.
> >
> > [2]
> > taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> >
> > [3]
> > commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Nov 6 20:29:34 2025 +0000
> >
> >     net: fix napi_consume_skb() with alien skbs
> >
> >     There is a lack of NUMA awareness and more generally lack
> >     of slab caches affinity on TX completion path.
> >
> > [4]
> > @c[
> >     skb_attempt_defer_free+1
> >     ixgbe_clean_tx_irq+723
> >     ixgbe_poll+119
> >     __napi_poll+48
> > , ksoftirqd/24]: 1964731
> >
> > @c[
> >     kick_defer_list_purge+1
> >     napi_consume_skb+333
> >     ixgbe_clean_tx_irq+723
> >     ixgbe_poll+119
> > , 34, swapper/34]: 123779
> >
> > Thanks,
> > Jason
>
> Hi Jason.
>
> It is a bit hard to guess without more details (cpu you are using),
> and perhaps perf profiles.

Xdpsock only calculates the speed on the cpu where it sends packets.
To put in more details, it will check if the packets are sent by
inspecting the completion queue and then send another group of packets
over and over again.

My test env is relatively old:
[root@localhost ~]# lscpu
Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             46 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      48
  On-line CPU(s) list:       0-47
Vendor ID:                   GenuineIntel
  BIOS Vendor ID:            Intel(R) Corporation
  Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
    BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
 CPU @ 2.3GHz
    BIOS CPU family:         179
    CPU family:              6
    Model:                   63
    Thread(s) per core:      2
    Core(s) per socket:      12
    Socket(s):               2
    Stepping:                2
    CPU(s) scaling MHz:      84%
    CPU max MHz:             3100.0000
    CPU min MHz:             1200.0000

After that commit [3], the perf differs because of the interrupts
jumping in the tx path frequently:
-   98.72%     0.09%  xdpsock          libc.so.6          [.]
__libc_sendto
      =E2=96=92
   - __libc_sendto
                                                                    =E2=97=
=86
      - 98.28% entry_SYSCALL_64_after_hwframe
                                                                    =E2=96=
=92
         - 98.19% do_syscall_64
                                                                    =E2=96=
=92
            - 97.94% x64_sys_call
                                                                    =E2=96=
=92
               - 97.91% __x64_sys_sendto
                                                                    =E2=96=
=92
                  - 97.80% __sys_sendto
                                                                    =E2=96=
=92
                     - 97.28% xsk_sendmsg
                                                                    =E2=96=
=92
                        - 97.18% __xsk_sendmsg.constprop.0.isra.0
                                                                    =E2=96=
=92
                           - 87.85% __xsk_generic_xmit
                                                                    =E2=96=
=92
                              - 41.71% xsk_build_skb
                                                                    =E2=96=
=92
                                 - 33.06% sock_alloc_send_pskb
                                                                    =E2=96=
=92
                                    + 22.06% alloc_skb_with_frags
                                                                    =E2=96=
=92
                                    + 7.61% skb_set_owner_w
                                                                    =E2=96=
=92
                                    + 0.58%
asm_sysvec_call_function_single
                        =E2=96=92
                                   1.66% skb_store_bits
                                                                    =E2=96=
=92
                                   1.60% memcpy_orig
                                                                    =E2=96=
=92
                                   0.69% xp_raw_get_data
                                                                    =E2=96=
=92
                              - 32.56% __dev_direct_xmit
                                                                    =E2=96=
=92
                                 + 15.62% 0xffffffffa064e5ac
                                                                    =E2=96=
=92
                                 - 7.33% __local_bh_enable_ip
                                                                    =E2=96=
=92
                                    + 6.18% do_softirq
                                                                    =E2=96=
=92
                                    + 0.70%
asm_sysvec_call_function_single
                        =E2=96=92
                                 + 5.78% validate_xmit_skb
                                                                    =E2=96=
=92
                              - 6.08% asm_sysvec_call_function_single
                                                                    =E2=96=
=92
                                 + sysvec_call_function_single
                                                                    =E2=96=
=92
                              + 1.62% xp_raw_get_data
                                                                    =E2=96=
=92
                           - 8.29% _raw_spin_lock
                                                                    =E2=96=
=92
                              + 3.01% asm_sysvec_call_function_single

Prior to that patch, I didn't see any interrupts coming in, so I
assume the defer part caused the problem.

> In particular which cpu is the bottleneck ?
>
> 1) There is still the missing part about tuning NAPI_SKB_CACHE_SIZE /
> NAPI_SKB_CACHE_BULK, I was hoping you could send the patch we
> discussed earlier ?

Sure thing :) I've done that part locally, thinking I will post it as
long as the current series gets merged?

>
> 2) I am also working on allowing batches of skbs for skb_attempt_defer_fr=
ee().
>
> Another item I am working on is to let the qdisc being serviced
> preferably not by the cpu performing TX completion,
> I mentioned about making qdisc->running a sequence that we can latch
> in __netif_schedule().
> (Idea is to be able to not spin on qdisc spinlock from net_tx_action()
> if another cpu was able to call qdisc_run())

Awesome work. Hope to see it very soon :)

Thanks,
Jason

