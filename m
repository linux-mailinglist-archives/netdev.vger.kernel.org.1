Return-Path: <netdev+bounces-218352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF3B3C20E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505D31CC04B9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9F1EF091;
	Fri, 29 Aug 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSWxmbem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33221A2547
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489839; cv=none; b=FUzMGrW3HcYX38s0JTmybVYNFueKd38ABuB0p6tJRLFp22CkA6GsrESl/4fWQluldoPDz69BqfU41e9V9RCve2u7ksO/eSVOs15EHz9LJpWTddVgC/19ui7jCasQMxAdtsZ6APxiSikpLQ9DaZ5Vfzp5EA6leVCwFoPDKO1YG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489839; c=relaxed/simple;
	bh=ZyukgMwVLoPM3MVNu32YYWynmLHpDTjXpv0LtyuvVrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKf3sXhe1F1kW5TVA6oPZyer7PVp3q4TFF9jB5RscoN44pE0zGdo0UlvOb4Gxy0y/nxgQMh83OoxSGH5rA/HwNXIOtJx1dFIjU753hAGHgHaytkFOsfG4G0LLHJcBRXZis7gohrkqi6+TvqcZPyVjK1J6IT6H7hK46C6YN5VRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSWxmbem; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24936b6f29bso15005ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756489837; x=1757094637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twh1U4Iq60euQqU08Z7e8uCuzpKnHBCpf2s5XttWBZs=;
        b=CSWxmbemMa8uAp7XkZcOu73WnPW93Z8sGEQ0+m/p+54FXgs8RRAOpuRpv6ofuyrOm9
         RL2vlOyv8uzKYvWyHlkHJXdHWm7qqx1+LcHuU/hpuOefkgjQleTCF4EglRyU0dtxIsep
         nm1pET5XNW19Aow6J90luWLhTEsz/tvr6T6fFPrJPdjuytYvJ3Aeu2Bzbu6KEgu+6Vz0
         C9jJ+BkmXtzBdVNbLdJD7Vld+W5m6r/P9ekT8Gb/yWXN1Yz0IoGvawkmhQzPQXvCJaGY
         V1fmYec6iu0muudtHN7l3LmTvZAFoYGBs5D47WoegrzFDcChlC2jUbcykoZBKTa3VkGU
         si2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489837; x=1757094637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twh1U4Iq60euQqU08Z7e8uCuzpKnHBCpf2s5XttWBZs=;
        b=wTDIipda2JKu3+NYWziqOgnr/qnbE2HrJQi/BMPhJRDHJSInAU0p0fPYHypIACIvax
         uiOujw9e8PZRQ6eAub+nzJWbCuX9FaZYFOOOoE22f+O/sgogTP1AhJP8yEZHMfVvDQjP
         Hje9mJZ5Shd+L2mb9Ir8/AsIJCaZaK/M9Gm+4H/B1qLWewe+pG+oW4/qjpZ4CV+oh2X8
         7Sdx1Gzttzhxd3RRwXYLPeIEZm9gyG0PIfW23yqQBq2zbKRabP/YDURChUGquazi6w4H
         1f5qajby9t0dl3H0SjJjcy1glZic1+KzmNmlo0bL5zmSLaAaUN069A0ZVQ41jctlX3VN
         rZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbeehmhqEw8udTzQnyZ0J8nbkYVpwP2LPhxzDq4WJCHdKEgkkYCN93UHt6dvugb8sr5MoVlcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGspUw84np7WWeu4tL9M7fyd0TBCeKKErxlZuu58loSb/yxTWe
	PpCuQojUT+Ih+P+2ul5AkkakRpx+aMb6cQdjNPmFx1zSlEtj5vwsIaErAK6pHvBpFJhP7WX7KFW
	FDbDD4DXKrvwFaGn5cFb68yBlzFc2CSYZANyrTahs
X-Gm-Gg: ASbGnctAyS+KLoPfaTOS8fidWPjjdvC3AD3CYIBwnz83cEmruSMQyIX5aPfyiqwiey2
	NNvHfcprVio5a/1hckWqljgYjLDg1Tx6WPvTC8Pid5uDmm9YYge9mm/KkzMztySB6tTJJu8RHNn
	uySmorb2UF66YPWYxd5oNW5kM8/le+UbqEERgUFDch4Pd23jf5/5Yi/2Y5Xw9OAeel2hWgrE+UL
	oOuWr7VQO1ndlMmqv5m2AyAOrPNVxDXGR9ARkfSPMKvn3OudOhDuLRBbA==
X-Google-Smtp-Source: AGHT+IGNH41GT0nalIgB8LTsZM4Q97gJ/ivJNO5wpnvkmpCd5ITBUoGy7Fin9DY41rBXfjFrONBCjNidrDfBXaYYGno=
X-Received: by 2002:a17:902:e544:b0:249:17ef:8309 with SMTP id
 d9443c01a7336-2493e911ef1mr209265ad.7.1756489836520; Fri, 29 Aug 2025
 10:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
In-Reply-To: <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 10:50:24 -0700
X-Gm-Features: Ac12FXzGYfJbBDhg0q6xH03Ky1rD935CZcxwO-S64EHiBC1ETImssFVe1cFb0VI
Message-ID: <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continu=
ous
> > busy polling.
> >
> > This is used for doing continuous polling of napi to fetch descriptors
> > from backing RX/TX queues for low latency applications. Allow enabling
> > of threaded busypoll using netlink so this can be enabled on a set of
> > dedicated napis for low latency applications.
> >
> > Once enabled user can fetch the PID of the kthread doing NAPI polling
> > and set affinity, priority and scheduler for it depending on the
> > low-latency requirements.
> >
> > Extend the netlink interface to allow enabling/disabling threaded
> > busypolling at individual napi level.
> >
> > We use this for our AF_XDP based hard low-latency usecase with usecs
> > level latency requirement. For our usecase we want low jitter and stabl=
e
> > latency at P99.
> >
> > Following is an analysis and comparison of available (and compatible)
> > busy poll interfaces for a low latency usecase with stable P99. This ca=
n
> > be suitable for applications that want very low latency at the expense
> > of cpu usage and efficiency.
> >
> > Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
> > backing a socket, but the missing piece is a mechanism to busy poll a
> > NAPI instance in a dedicated thread while ignoring available events or
> > packets, regardless of the userspace API. Most existing mechanisms are
> > designed to work in a pattern where you poll until new packets or event=
s
> > are received, after which userspace is expected to handle them.
> >
> > As a result, one has to hack together a solution using a mechanism
> > intended to receive packets or events, not to simply NAPI poll. NAPI
> > threaded busy polling, on the other hand, provides this capability
> > natively, independent of any userspace API. This makes it really easy t=
o
> > setup and manage.
> >
> > For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> > description of the tool and how it tries to simulate the real workload
> > is following,
> >
> > - It sends UDP packets between 2 machines.
> > - The client machine sends packets at a fixed frequency. To maintain th=
e
> >    frequency of the packet being sent, we use open-loop sampling. That =
is
> >    the packets are sent in a separate thread.
> > - The server replies to the packet inline by reading the pkt from the
> >    recv ring and replies using the tx ring.
> > - To simulate the application processing time, we use a configurable
> >    delay in usecs on the client side after a reply is received from the
> >    server.
> >
> > The xsk_rr tool is posted separately as an RFC for tools/testing/selfte=
st.
> >
> > We use this tool with following napi polling configurations,
> >
> > - Interrupts only
> > - SO_BUSYPOLL (inline in the same thread where the client receives the
> >    packet).
> > - SO_BUSYPOLL (separate thread and separate core)
> > - Threaded NAPI busypoll
> >
> > System is configured using following script in all 4 cases,
> >
> > ```
> > echo 0 | sudo tee /sys/class/net/eth0/threaded
> > echo 0 | sudo tee /proc/sys/kernel/timer_migration
> > echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >
> > sudo ethtool -L eth0 rx 1 tx 1
> > sudo ethtool -G eth0 rx 1024
> >
> > echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> > echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >
> >   # pin IRQs on CPU 2
> > IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >                               print arr[0]}' < /proc/interrupts)"
> > for irq in "${IRQS}"; \
> >       do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> >
> > echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >
> > for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >                       do echo $i; echo 1,2,3,4,5,6 > $i; done
> >
> > if [[ -z "$1" ]]; then
> >    echo 400 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > fi
> >
> > sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usec=
s 0
> >
> > if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >    echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >    echo 0 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >    echo 2 | sudo tee /sys/class/net/eth0/threaded
> >    NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
> >    sudo chrt -f  -p 50 $NAPI_T
> >
> >    # pin threaded poll thread to CPU 2
> >    sudo taskset -pc 2 $NAPI_T
> > fi
> >
> > if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >    echo 0 | sudo tee /proc/sys/net/core/busy_read
> >    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > fi
> > ```
>
> The experiment script above does not work, because the sysfs parameter
> does not exist anymore in this version.
>
> > To enable various configurations, script can be run as following,
> >
> > - Interrupt Only
> >    ```
> >    <script> enable_interrupt
> >    ```
> >
> > - SO_BUSYPOLL (no arguments to script)
> >    ```
> >    <script>
> >    ```
> >
> > - NAPI threaded busypoll
> >    ```
> >    <script> enable_threaded
> >    ```
> >
> > If using idpf, the script needs to be run again after launching the
> > workload just to make sure that the configurations are not reverted. As
> > idpf reverts some configurations on software reset when AF_XDP program
> > is attached.
> >
> > Once configured, the workload is run with various configurations using
> > following commands. Set period (1/frequency) and delay in usecs to
> > produce results for packet frequency and application processing delay.
> >
> >   ## Interrupt Only and SO_BUSYPOLL (inline)
> >
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> > ```
> >
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >       -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> > ```
> >
> >   ## SO_BUSYPOLL(done in separate core using recvfrom)
> >
> > Argument -t spawns a seprate thread and continuously calls recvfrom.
> >
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >       -h -v -t
> > ```
> >
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >       -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> > ```
> >
> >   ## NAPI Threaded Busy Poll
> >
> > Argument -n skips the recvfrom call as there is no recv kick needed.
> >
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >       -h -v -n
> > ```
> >
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >       -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >       -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> > ```
>
> I believe there's a bug when disabling busy-polled napi threading after
> an experiment. My system hangs and needs a hard reset.
>
> > | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI =
threaded |
> > |---|---|---|---|---|
> > | 12 Kpkt/s + 0us delay | | | | |
> > |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> > |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> > |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> > |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> > | 32 Kpkt/s + 30us delay | | | | |
> > |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> > |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> > |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> > |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> > | 125 Kpkt/s + 6us delay | | | | |
> > |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> > |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> > |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> > |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> > | 12 Kpkt/s + 78us delay | | | | |
> > |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> > |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> > |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> > |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> > | 25 Kpkt/s + 38us delay | | | | |
> > |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> > |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> > |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> > |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>
> On my system, routing the irq to same core where xsk_rr runs results in
> lower latency than routing the irq to a different core. To me that makes
> sense in a low-rate latency-sensitive scenario where interrupts are not
> causing much trouble, but the resulting locality might be beneficial. I
> think you should test this as well.
>
> The experiments reported above (except for the first one) are
> cherry-picking parameter combinations that result in a near-100% load
> and ignore anything else. Near-100% load is a highly unlikely scenario
> for a latency-sensitive workload.
>
> When combining the above two paragraphs, I believe other interesting
> setups are missing from the experiments, such as comparing to two pairs
> of xsk_rr under high load (as mentioned in my previous emails).
This is to support an existing real workload. We cannot easily modify
its threading model. The two xsk_rr model would be a different
workload.
>
> Thanks,
> Martin
>

