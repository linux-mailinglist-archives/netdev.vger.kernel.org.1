Return-Path: <netdev+bounces-218402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F1B3C4CA
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466E01B21AA7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38461276025;
	Fri, 29 Aug 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yCHCNoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516ED221F0A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506447; cv=none; b=LNnlNbRmLw2u6ZMmZe3uSf43/crhEq1rhgZ1tG301fcVQr+FP1erNtA8wRvfxavPPGutdEMXaUL9TOsolyl9e/bRQX8e9raHnCapHQuCwu9nedqDDUWYEvqznRNnjz0rw3DDFlgrrdmT/H1jMpsJFqXgkW3Gvp43WxcBPbWa5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506447; c=relaxed/simple;
	bh=ObatWfNX6foL1tkPTjLKWx5FEutYZ+gnEhg4MJl7GwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3e3jubu/JphyPogxlmkUKzGBE7gE/dE+/WTTkLQ1w3xh3u5NzQNNI1ebdVkW2ewjadORdezYpelf0njq35XMxCywE5j/ieZG6K1S64TaYmJzOOwl5KSyFwYwW2evIbXSd4cq2Nz4kXTCBKHuYSAUsPJjHVNdAS+4LIvRAlAg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yCHCNoy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248f08d31dcso64815ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756506444; x=1757111244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsEQDrjeY0flaIDI6Ufozu96b3JzKL55wnMtca2JLRw=;
        b=1yCHCNoy9qaVtajv2lIQqP1Z7jeBmGAOXJFZ0edkFIS8LTVCRTqWNOQG/u10Ru1DKC
         Lq7vBH8+lyxN2B7K0vo4J+G8RQr0CIB60OkqUv8Kj/Qc/1vBb4Z/ZrKsGwqnJ7AJWnJd
         522RQ8FDE1Pq8p8+jnFz71G99ku4YEz2X6H0GlnJanUj3zKn+8RYjb481qM5S8xkipoL
         eDytzMH35CNeky2UM3mU/gKBrQGVxzu0TaVaHSfB2Gp5ZQcFawZG6A3RVzhoRkZTKy3y
         bK2nvKz1Yu+kHVlxsTZjxVzfCgU/ygnG5vpsLanAyc8M2bdHrCaTAv5sh/VeLHQvyC6Y
         l/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756506444; x=1757111244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsEQDrjeY0flaIDI6Ufozu96b3JzKL55wnMtca2JLRw=;
        b=pyiS95t3akfTNL9qkFfL0H4fJ/IHAo2JiAhV4igNho584vx0dLjaPNpSLWqlsYK/LW
         rPGNYLGjUCOjTTbfSyzdeozAFM5SdKpDhY1qtcpeK4i1toNLuz/XWnH+2XmQyPauD0O+
         VqhgKJFmDyemXSFQ61qQROHlBvjYGNzueCurW0IPJ5HaNLjNhwqcypAhBOnIGkDGKFWe
         TKoOzON5ufA8BqQpNRvj+mxcDSs7f597SOFeL+XjK3M+KgKxI2BrugXfIsi5ufeBUF/B
         +Z/c/hHNrbvXu47Qh0VrT+smd8nxkgjkjXjeuuK0TN83bUbEL5tmfsP0201m/E6htPfN
         +TZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXF15S+IBG45DJkGNjyIVaYMUI4fT51rA0N4+4tuOjy/KQB2stXT8grJ4EYDz83lqZd/j5YF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzteponmeorayXMwAvMxxIEFbuD8Yd9SGk9Ol5i/mwTuShbryk
	0RCFKFPAizUrrncK/yRFyMou927l62rnG4JlHfzegZ6fmk+eGBiIphmYDyEbVATYAe4QI31QSjf
	pCIPOq30whwG9jpYq/OlAPHSKi+XxVFHb6fP9ovXe
X-Gm-Gg: ASbGncumOThl01hHst9IBl+Mw9V5cpKUShFMu24/QyLqYFcK5Db3AAtyVgf9LUqGeI6
	6IiAs6ZyozJAmSuArGr5MwoTw8oUcHqwTL2j4LGGbW5YaptyIM08S61btPCQAZV3yEIs1vHdmEd
	72qgWbgNuTb1VEnUW+TRJNX9yykWfNgc4Qo2rsBV+oPzHA3jFs4Ua5Y3OcpWKk0yU4U+aQZEhg7
	KqfXU2xCyZDNWMD9Xl/0iDK1+OtdWC0o9zICIHQVyhTLrc=
X-Google-Smtp-Source: AGHT+IHBsnuS1exdweNEwnSxEYgYyGj5hZVagJD+QVlQjOZVTM4QgUwc0QPptvYKn9Xu4J7O14MX+qMyJp/sXdIS2j4=
X-Received: by 2002:a17:902:e544:b0:249:17ef:8309 with SMTP id
 d9443c01a7336-2493e911ef1mr1372035ad.7.1756506444148; Fri, 29 Aug 2025
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca> <CAAywjhQJHNN6MSuioJWo+siV8KDM-7BUQa3Ge+z7-V00KWJhtA@mail.gmail.com>
 <0d66c174-32d1-435d-9b1a-5672201dd2e0@uwaterloo.ca>
In-Reply-To: <0d66c174-32d1-435d-9b1a-5672201dd2e0@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 15:27:11 -0700
X-Gm-Features: Ac12FXyCtCb4xdZ5P50bYt0a8wtqtYtx4o1IQqJV1iIzCjxs_VbcR7TovDDsAPA
Message-ID: <CAAywjhRmdNJ0HswejGxBn9o4sCF7QM3e88QmyO=uV9nYYYdffw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:27=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-29 16:49, Samiullah Khawaja wrote:
> > On Fri, Aug 29, 2025 at 11:08=E2=80=AFAM Martin Karsten <mkarsten@uwate=
rloo.ca> wrote:
> >>
> >> On 2025-08-29 13:50, Samiullah Khawaja wrote:
> >>> On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>>>
> >>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>>>> Extend the already existing support of threaded napi poll to do con=
tinuous
> >>>>> busy polling.
> >>>>>
> >>>>> This is used for doing continuous polling of napi to fetch descript=
ors
> >>>>> from backing RX/TX queues for low latency applications. Allow enabl=
ing
> >>>>> of threaded busypoll using netlink so this can be enabled on a set =
of
> >>>>> dedicated napis for low latency applications.
> >>>>>
> >>>>> Once enabled user can fetch the PID of the kthread doing NAPI polli=
ng
> >>>>> and set affinity, priority and scheduler for it depending on the
> >>>>> low-latency requirements.
> >>>>>
> >>>>> Extend the netlink interface to allow enabling/disabling threaded
> >>>>> busypolling at individual napi level.
> >>>>>
> >>>>> We use this for our AF_XDP based hard low-latency usecase with usec=
s
> >>>>> level latency requirement. For our usecase we want low jitter and s=
table
> >>>>> latency at P99.
> >>>>>
> >>>>> Following is an analysis and comparison of available (and compatibl=
e)
> >>>>> busy poll interfaces for a low latency usecase with stable P99. Thi=
s can
> >>>>> be suitable for applications that want very low latency at the expe=
nse
> >>>>> of cpu usage and efficiency.
> >>>>>
> >>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a =
NAPI
> >>>>> backing a socket, but the missing piece is a mechanism to busy poll=
 a
> >>>>> NAPI instance in a dedicated thread while ignoring available events=
 or
> >>>>> packets, regardless of the userspace API. Most existing mechanisms =
are
> >>>>> designed to work in a pattern where you poll until new packets or e=
vents
> >>>>> are received, after which userspace is expected to handle them.
> >>>>>
> >>>>> As a result, one has to hack together a solution using a mechanism
> >>>>> intended to receive packets or events, not to simply NAPI poll. NAP=
I
> >>>>> threaded busy polling, on the other hand, provides this capability
> >>>>> natively, independent of any userspace API. This makes it really ea=
sy to
> >>>>> setup and manage.
> >>>>>
> >>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> >>>>> description of the tool and how it tries to simulate the real workl=
oad
> >>>>> is following,
> >>>>>
> >>>>> - It sends UDP packets between 2 machines.
> >>>>> - The client machine sends packets at a fixed frequency. To maintai=
n the
> >>>>>      frequency of the packet being sent, we use open-loop sampling.=
 That is
> >>>>>      the packets are sent in a separate thread.
> >>>>> - The server replies to the packet inline by reading the pkt from t=
he
> >>>>>      recv ring and replies using the tx ring.
> >>>>> - To simulate the application processing time, we use a configurabl=
e
> >>>>>      delay in usecs on the client side after a reply is received fr=
om the
> >>>>>      server.
> >>>>>
> >>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/se=
lftest.
> >>>>>
> >>>>> We use this tool with following napi polling configurations,
> >>>>>
> >>>>> - Interrupts only
> >>>>> - SO_BUSYPOLL (inline in the same thread where the client receives =
the
> >>>>>      packet).
> >>>>> - SO_BUSYPOLL (separate thread and separate core)
> >>>>> - Threaded NAPI busypoll
> >>>>>
> >>>>> System is configured using following script in all 4 cases,
> >>>>>
> >>>>> ```
> >>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>>>
> >>>>> sudo ethtool -L eth0 rx 1 tx 1
> >>>>> sudo ethtool -G eth0 rx 1024
> >>>>>
> >>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>>>
> >>>>>     # pin IRQs on CPU 2
> >>>>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>>>                                 print arr[0]}' < /proc/interrupts)"
> >>>>> for irq in "${IRQS}"; \
> >>>>>         do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> >>>>>
> >>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>>>
> >>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>>>                         do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>>>
> >>>>> if [[ -z "$1" ]]; then
> >>>>>      echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>      echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>> fi
> >>>>>
> >>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-=
usecs 0
> >>>>>
> >>>>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>>      echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>>>      NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2=
 }')
> >>>>>      sudo chrt -f  -p 50 $NAPI_T
> >>>>>
> >>>>>      # pin threaded poll thread to CPU 2
> >>>>>      sudo taskset -pc 2 $NAPI_T
> >>>>> fi
> >>>>>
> >>>>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>      echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>> fi
> >>>>> ```
> >>>>
> >>>> The experiment script above does not work, because the sysfs paramet=
er
> >>>> does not exist anymore in this version.
> >>>>
> >>>>> To enable various configurations, script can be run as following,
> >>>>>
> >>>>> - Interrupt Only
> >>>>>      ```
> >>>>>      <script> enable_interrupt
> >>>>>      ```
> >>>>>
> >>>>> - SO_BUSYPOLL (no arguments to script)
> >>>>>      ```
> >>>>>      <script>
> >>>>>      ```
> >>>>>
> >>>>> - NAPI threaded busypoll
> >>>>>      ```
> >>>>>      <script> enable_threaded
> >>>>>      ```
> >>>>>
> >>>>> If using idpf, the script needs to be run again after launching the
> >>>>> workload just to make sure that the configurations are not reverted=
. As
> >>>>> idpf reverts some configurations on software reset when AF_XDP prog=
ram
> >>>>> is attached.
> >>>>>
> >>>>> Once configured, the workload is run with various configurations us=
ing
> >>>>> following commands. Set period (1/frequency) and delay in usecs to
> >>>>> produce results for packet frequency and application processing del=
ay.
> >>>>>
> >>>>>     ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>>>
> >>>>> - Server
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321=
 -h -v
> >>>>> ```
> >>>>>
> >>>>> - Client
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321=
 \
> >>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>>>> ```
> >>>>>
> >>>>>     ## SO_BUSYPOLL(done in separate core using recvfrom)
> >>>>>
> >>>>> Argument -t spawns a seprate thread and continuously calls recvfrom=
.
> >>>>>
> >>>>> - Server
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321=
 \
> >>>>>         -h -v -t
> >>>>> ```
> >>>>>
> >>>>> - Client
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321=
 \
> >>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>>>> ```
> >>>>>
> >>>>>     ## NAPI Threaded Busy Poll
> >>>>>
> >>>>> Argument -n skips the recvfrom call as there is no recv kick needed=
.
> >>>>>
> >>>>> - Server
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321=
 \
> >>>>>         -h -v -n
> >>>>> ```
> >>>>>
> >>>>> - Client
> >>>>> ```
> >>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321=
 \
> >>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>>>> ```
> >>>>
> >>>> I believe there's a bug when disabling busy-polled napi threading af=
ter
> >>>> an experiment. My system hangs and needs a hard reset.
> >>>>
> >>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | N=
API threaded |
> >>>>> |---|---|---|---|---|
> >>>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>>
> >>>> On my system, routing the irq to same core where xsk_rr runs results=
 in
> >>>> lower latency than routing the irq to a different core. To me that m=
akes
> >>>> sense in a low-rate latency-sensitive scenario where interrupts are =
not
> >>>> causing much trouble, but the resulting locality might be beneficial=
. I
> >>>> think you should test this as well.
> >>>>
> >>>> The experiments reported above (except for the first one) are
> >>>> cherry-picking parameter combinations that result in a near-100% loa=
d
> >>>> and ignore anything else. Near-100% load is a highly unlikely scenar=
io
> >>>> for a latency-sensitive workload.
> >>>>
> >>>> When combining the above two paragraphs, I believe other interesting
> >>>> setups are missing from the experiments, such as comparing to two pa=
irs
> >>>> of xsk_rr under high load (as mentioned in my previous emails).
> >>> This is to support an existing real workload. We cannot easily modify
> >>> its threading model. The two xsk_rr model would be a different
> >>> workload.
> >>
> >> That's fine, but:
> >>
> >> - In principle I don't think it's a good justification for a kernel
> >> change that an application cannot be rewritten.
> >>
> >> - I believe it is your responsibility to more comprehensively document
> >> the impact of your proposed changes beyond your one particular workloa=
d.
> >>
> >> Also, I do believe there's a bug as mentioned before. I can't quite pi=
n
> >> it down, but every time after running a "NAPI threaded" experiment, my
> >> servers enters a funny state and eventually becomes largely unresponsi=
ve
> >> without much useful output and needs a hard reset. For example:
> >>
> >> 1) Run "NAPI threaded" experiment
> >> 2) Disabled "threaded" parameter in NAPI config
> >> 3) Run IRQ experiment -> xsk_rr hangs and apparently holds a lock,
> >> because other services stop working successively.
> > I just tried with this scenario and it seems to work fine.
>
> Ok. I've reproduced it more concisely. This is after a fresh reboot:
>
> sudo ethtool -L ens15f1np1 combined 1
>
> sudo net-next/tools/net/ynl/pyynl/cli.py --no-schema --output-json\
>   --spec net-next/Documentation/netlink/specs/netdev.yaml --do napi-set\
>   --json=3D'{"id": 8209, "threaded": "busy-poll-enabled"}'
>
> # ping from another machine to this NIC works
> # napi thread busy at 100%
>
> sudo net-next/tools/net/ynl/pyynl/cli.py --no-schema --output-json\
>   --spec net-next/Documentation/netlink/specs/netdev.yaml --do napi-set\
>   --json=3D'{"id": 8209, "threaded": "disabled"}'
>
> # napi thread gone
> # ping from another machine does not work
> # tcpdump does not show incoming icmp packets
> # but machine still responsive on other NIC
>
> sudo ethtool -L ens15f1np1 combined 12
Ok I have found it. It's related to stopping the kthreads. Will send a
revision out.
>
> # networking hangs on all NICs
> # sudo reboot on console hangs
> # hard reset needed, no useful output
> >> Do you not have this problem?
> > Not Really. Jakub actually fixed a deadlock in napi threaded recently.
> > Maybe you are hitting that? Are you using the latest base-commit that
> > I have in this patch series?
>
> Yep:
> - Ubuntu 24.04.3 LTS system
> - base commit before patches is c3199adbe4ffffc7b6536715e0290d1919a45cd9
> - NIC driver is ice, PCI id 8086:159b.
>
> Let me know, if you need any other information?
>
> Best,
> Martin

