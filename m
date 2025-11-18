Return-Path: <netdev+bounces-239336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61EC66FA0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF04E385B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D477270572;
	Tue, 18 Nov 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tosif4vQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE41D2F42
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431626; cv=none; b=KizgHVr3X26j6hHo6jfeiuo9H0gQYo8Cl+8fW00f2ld/lwKOieZ8fU1wRFXzjxH3xpyKoAP+Z2gzlmRrACqONoYY8W7Fv+e+gHrQg6+ctVGIRpJqir6tbmQDWrLmkWXE37dP+fzLKpQ3ouZdbNVfoYQoYxnmG0HM0PXAtjDD/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431626; c=relaxed/simple;
	bh=ysUT8XmS5RM3/04O79IdnXeMZCG9ASccEOaLStliQgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3BAd7AdjbPDeI5NDjvSzaiNZz2yh5Bj5yAmAcQJ2kXCHgZt1FJHKR53VSp55DJBe7No/3mozZqWn9e2cu9tUJkDerW093M9flmnX0de5pBsGfa6n79HuF5X9EhgYjqszZQ+3uInLVtsnV/fq0IJ6HzOLVidiulTH9iiQiKXztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tosif4vQ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4337076ae3fso20996925ab.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431623; x=1764036423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqpT54KTKOXPNOqJWrIzm+BQDop4Km2af08b40oOz7Q=;
        b=Tosif4vQmO4vzdEKAUQt4pDcL8gBZcdTPfIq/c6vk7aTm2JJeEpGH0fjl48z+sgKye
         btla/XuB+scuYofhtQxUbBOeyRCMYCSZZrgS079H1b/j20U1cyvMXtxmlMcaACyW2IQa
         XkADOcNHZYW2CzPTJoc33roL5JRSk/GLT6GH3irmKZ47nPdPxwIL3BmWYCUFuYyCQSLD
         qM6UFInpjyhV8F0DnrsarCVMQgOksQVB5lw/qDnY50oe2nd/jfB6dEgIKOsRLQ6+GBlB
         /9MA552+RE7UptD3BGJwnZgIYKwRKL+alnSFMr9k6dV6I9bE0h4PK5V48oHJRqiNyk9j
         GGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431623; x=1764036423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FqpT54KTKOXPNOqJWrIzm+BQDop4Km2af08b40oOz7Q=;
        b=QsLSeditxBh8RZbih/pRD/1mqUG8Q8fCbHEgaf8dU1FvAMS5MYczDvWHHLKIJL2ALj
         Z2RrJmLQlSfiitV/8/SUavVM1iK0QxKwfVQWgmYWGAZN4Qei/eSUEkLWo8uNwNerIXO8
         cN+/wRJVqOfJctpgsPdnDGwqgxBR0zRpWEI6GMG4hxeua3dWGjWYd5NyGjeQzqGS2Zx4
         8ZvbScz0CRdaEllieHzq4TYgEN6d5zG+pE6fO9NhWumPOazNRbxiC7T8wjupQ7drwqYG
         ppYC4N8uzhWyzOVHax5xKWouqvr4YoKMiSRpVam8A3FP/CUkOud8TQSAlaUOkciXEW8r
         oooA==
X-Forwarded-Encrypted: i=1; AJvYcCUEsSv5NGNSf7J12l0vUyYFlBChAh7OqS8/G70W2F/0q3nVRYnS/4Kdqd373BJlpQigg+TwoBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzOR2ePg09QHiXL3nrgEkEmSLhFHigaHStSka4PStioGGaJ0U
	sgbYOe4IT1aL8kKya2faCdy1BDzg56cmbpxjJQTePC6GDcpwxmDn4pIaSvaZpl/F5n1kdJD9asQ
	l/sMRh9LTo9AwZp/4gs4PbG/8Zl4ycul9/j78klE=
X-Gm-Gg: ASbGncvp+bqauHZaUnENOocWHgKKI4cv15fSxQiUWCOECEsO/qsKchJ6Ho7rYRdeVMm
	W9afwZSjSjlgCXAWkptM3y4l+bD0Jkj0qL6F0eDmAyeTOkzlRfgayImEQuNxcSI7pu6nrdbcWgm
	kNo8FaYl1WW4l6TaMu9gUffafV0KC5cYmUfS64cXUogVU5ze8dnWYcPQbAvNg8Tmc3CYo0gse5b
	984Dug/bXX14liphPi9CQD0yIJVh4hw+hGLLViDxwTKqUXsBQLGGdoHsx6YkYjMrzyV4mk=
X-Google-Smtp-Source: AGHT+IHLJGRSZsqqlhCutmO7gAtX2dXe07W42rxITdXfcpjcLNAu0o8nEvBSVgn9cXEmLRTLaFpr+esqe9Q6aRx/nFw=
X-Received: by 2002:a05:6e02:1aa4:b0:433:2dbd:e93c with SMTP id
 e9e14a558f8ab-4348c8961f6mr179524455ab.4.1763431623556; Mon, 17 Nov 2025
 18:07:03 -0800 (PST)
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
 <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
 <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com> <CAL+tcoAJR3Du1ZsJC5KU=pNB7G9FP+qYVe8314GXu8xv7-PC3g@mail.gmail.com>
In-Reply-To: <CAL+tcoAJR3Du1ZsJC5KU=pNB7G9FP+qYVe8314GXu8xv7-PC3g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 10:06:27 +0800
X-Gm-Features: AWmQ_blV828FAzLUx0u7BVkglIcaAFJ6r7janL7clGirG6TcASXFzcsTJqazbLg
Message-ID: <CAL+tcoC8v9QpTxRJWA17ciu=sB-RAZJ_eWNZZTVFYwUXEQHtbA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:31=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Mon, Nov 17, 2025 at 5:48=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Nov 17, 2025 at 1:17=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 4:57=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 12:41=E2=80=AFAM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > This is a followup of commit e20dfbad8aab ("net: fix napi_con=
sume_skb()
> > > > > > > with alien skbs").
> > > > > > >
> > > > > > > Now the per-cpu napi_skb_cache is populated from TX completio=
n path,
> > > > > > > we can make use of this cache, especially for cpus not used
> > > > > > > from a driver NAPI poll (primary user of napi_cache).
> > > > > > >
> > > > > > > We can use the napi_skb_cache only if current context is not =
from hard irq.
> > > > > > >
> > > > > > > With this patch, I consistently reach 130 Mpps on my UDP tx s=
tress test
> > > > > > > and reduce SLUB spinlock contention to smaller values.
> > > > > > >
> > > > > > > Note there is still some SLUB contention for skb->head alloca=
tions.
> > > > > > >
> > > > > > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > > > > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > > > > > on the platform taxonomy.
> > > > > > >
> > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >
> > > > > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > >
> > > > > > Thanks for working on this. Previously I was thinking about thi=
s as
> > > > > > well since it affects the hot path for xsk (please see
> > > > > > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()).=
 But I
> > > > > > wasn't aware of the benefits between disabling irq and allocati=
ng
> > > > > > memory. AFAIK, I once removed an enabling/disabling irq pair an=
d saw a
> > > > > > minor improvement as this commit[1] says. Would you share your
> > > > > > invaluable experience with us in this case?
> > > > > >
> > > > > > In the meantime, I will do more rounds of experiments to see ho=
w they perform.
> > > > >
> > > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Done! I managed to see an improvement. The pps number goes from
> > > > > 1,458,644 to 1,647,235 by running [2].
> > > > >
> > > > > But sadly the news is that the previous commit [3] leads to a hug=
e
> > > > > decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
>
> I have to rephrase a bit. What I did is on top of the commit just
> before [3], I tried out the tests to see the number w/o [3] series, so
> the numbers were respectively 1,458,644 and 1,980,000. That means
> reverting commit [3] brought back that much performance.
>
> Furthermore, I did a few more tests and my env changed:
> 1) I tried the latest kernel, the number is around 1,680,000. And then
> revert commit [3], it's increased to 1,850,000.
> 2) I tried to apply the current series, the number was around 1,730,000.
> 3) I tried to apply the current series and reverted [3], the number
> was still around 1,730,000.
>
> That means the current series negates the benefits of that commit [3].
> I've done many rounds of tests, so the above numbers are quite stable.
> I feel I need to directly use the fallback memory allocation instead
> of trying napi_skb_cache_get for xsk? I'm not sure if any theory
> supports which one is good or not. From my instinct, trying
> disabling/enabling is saving time while using napi_skb_cache_get is
> also saving time...
>
> > > > > applied, I observed and found xdpsock always allocated the skb on=
 cpu
> > > > > 0 but the napi poll triggered skb_attempt_defer_free() on another
> > > > > call[4], which affected the final results.
> > > > >
> > > > > [2]
> > > > > taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> > > > >
> > > > > [3]
> > > > > commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:   Thu Nov 6 20:29:34 2025 +0000
> > > > >
> > > > >     net: fix napi_consume_skb() with alien skbs
> > > > >
> > > > >     There is a lack of NUMA awareness and more generally lack
> > > > >     of slab caches affinity on TX completion path.
> > > > >
> > > > > [4]
> > > > > @c[
> > > > >     skb_attempt_defer_free+1
> > > > >     ixgbe_clean_tx_irq+723
> > > > >     ixgbe_poll+119
> > > > >     __napi_poll+48
> > > > > , ksoftirqd/24]: 1964731
> > > > >
> > > > > @c[
> > > > >     kick_defer_list_purge+1
> > > > >     napi_consume_skb+333
> > > > >     ixgbe_clean_tx_irq+723
> > > > >     ixgbe_poll+119
> > > > > , 34, swapper/34]: 123779
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > >
> > > > Hi Jason.
> > > >
> > > > It is a bit hard to guess without more details (cpu you are using),
> > > > and perhaps perf profiles.
> > >
> > > Xdpsock only calculates the speed on the cpu where it sends packets.
> > > To put in more details, it will check if the packets are sent by
> > > inspecting the completion queue and then send another group of packet=
s
> > > over and over again.
> > >
> > > My test env is relatively old:
> > > [root@localhost ~]# lscpu
> > > Architecture:                x86_64
> > >   CPU op-mode(s):            32-bit, 64-bit
> > >   Address sizes:             46 bits physical, 48 bits virtual
> > >   Byte Order:                Little Endian
> > > CPU(s):                      48
> > >   On-line CPU(s) list:       0-47
> > > Vendor ID:                   GenuineIntel
> > >   BIOS Vendor ID:            Intel(R) Corporation
> > >   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GH=
z
> > >     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GH=
z
> > >  CPU @ 2.3GHz
> > >     BIOS CPU family:         179
> > >     CPU family:              6
> > >     Model:                   63
> > >     Thread(s) per core:      2
> > >     Core(s) per socket:      12
> > >     Socket(s):               2
> > >     Stepping:                2
> > >     CPU(s) scaling MHz:      84%
> > >     CPU max MHz:             3100.0000
> > >     CPU min MHz:             1200.0000
> > >
> > > After that commit [3], the perf differs because of the interrupts
> > > jumping in the tx path frequently:
> > > -   98.72%     0.09%  xdpsock          libc.so.6          [.]
> > > __libc_sendto
> > >       =E2=96=92
> > >    - __libc_sendto
> > >                                                                     =
=E2=97=86
> > >       - 98.28% entry_SYSCALL_64_after_hwframe
> > >                                                                     =
=E2=96=92
> > >          - 98.19% do_syscall_64
> > >                                                                     =
=E2=96=92
> > >             - 97.94% x64_sys_call
> > >                                                                     =
=E2=96=92
> > >                - 97.91% __x64_sys_sendto
> > >                                                                     =
=E2=96=92
> > >                   - 97.80% __sys_sendto
> > >                                                                     =
=E2=96=92
> > >                      - 97.28% xsk_sendmsg
> > >                                                                     =
=E2=96=92
> > >                         - 97.18% __xsk_sendmsg.constprop.0.isra.0
> > >                                                                     =
=E2=96=92
> > >                            - 87.85% __xsk_generic_xmit
> > >                                                                     =
=E2=96=92
> > >                               - 41.71% xsk_build_skb
> > >                                                                     =
=E2=96=92
> > >                                  - 33.06% sock_alloc_send_pskb
> > >                                                                     =
=E2=96=92
> > >                                     + 22.06% alloc_skb_with_frags
> > >                                                                     =
=E2=96=92
> > >                                     + 7.61% skb_set_owner_w
> > >                                                                     =
=E2=96=92
> > >                                     + 0.58%
> > > asm_sysvec_call_function_single
> > >                         =E2=96=92
> > >                                    1.66% skb_store_bits
> > >                                                                     =
=E2=96=92
> > >                                    1.60% memcpy_orig
> > >                                                                     =
=E2=96=92
> > >                                    0.69% xp_raw_get_data
> > >                                                                     =
=E2=96=92
> > >                               - 32.56% __dev_direct_xmit
> > >                                                                     =
=E2=96=92
> > >                                  + 15.62% 0xffffffffa064e5ac
> > >                                                                     =
=E2=96=92
> > >                                  - 7.33% __local_bh_enable_ip
> > >                                                                     =
=E2=96=92
> > >                                     + 6.18% do_softirq
> > >                                                                     =
=E2=96=92
> > >                                     + 0.70%
> > > asm_sysvec_call_function_single
> > >                         =E2=96=92
> > >                                  + 5.78% validate_xmit_skb
> > >                                                                     =
=E2=96=92
> > >                               - 6.08% asm_sysvec_call_function_single
> > >                                                                     =
=E2=96=92
> > >                                  + sysvec_call_function_single
> > >                                                                     =
=E2=96=92
> > >                               + 1.62% xp_raw_get_data
> > >                                                                     =
=E2=96=92
> > >                            - 8.29% _raw_spin_lock
> > >                                                                     =
=E2=96=92
> > >                               + 3.01% asm_sysvec_call_function_single
> > >
> > > Prior to that patch, I didn't see any interrupts coming in, so I
> > > assume the defer part caused the problem.
> >
> > This is a trade off.
> >
> > If you are using a single cpu to send packets, then it will not really
> > have contention on SLUB structures.
> >
> > A bit like RFS : If you want to reach max throughput on a single flow,
> > it is probably better _not_ using RFS/RPS,
> > so that more than one cpu can be involved in the rx work.
>
> Point taken!
>
> >
> > We can add a static key to enable/disable the behaviors that are most
> > suited to a particular workload.
>
> Are we going to introduce a new knob to control this snippet in
> napi_consume_skb()?

That's it. For single flow in xsk scenarios, adding something like a
static key to avoid 1) using napi_skb_cache_get() in this patch, 2)
deferring free in commit [3] can contribute to a higher performance
back to more than 1,900,000 pps. I have no clue if adding a new sysctl
is acceptable.

Thanks,
Jason

