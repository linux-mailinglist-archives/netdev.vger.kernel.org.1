Return-Path: <netdev+bounces-218424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F960B3C617
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE45A443C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63A2869E;
	Sat, 30 Aug 2025 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEivAr56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA73C17
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513296; cv=none; b=Eh6qDmUEs/AQZlzDFXa8ptQacqJhizP/my5za1IXi6QzQIMJ4v7X+IitGlI5U0PWgeOGCs5oUev62QGYi09JwYxPRbn5VOT5lbtuX5Hg3jOqKcAnkhOMUDz028kvY9xrvKS4iU0H9/x/Rd2E0pJDK/9MHmJWsulW5f/Ky6uJEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513296; c=relaxed/simple;
	bh=Eun8TGDRUV8n9Or7bHHQp88b5xVDC8BOsBT0qTW/m2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba9vJ+m+7BmvlHIn78EfHO+Vi/q1ek/YF098X0gAMxRR/mSDIctnfzt07rHcdSOOId36aHzZRtoN8gBJipIZ9wWnENviy761FdXDL8p20L0vwV42fQxpc47Q4xK9ZZ4/F5+y1RDJHK7L2S7feSg9RmmWL9OOxMe9etyDW+u58rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEivAr56; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24936b6f321so30405ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756513294; x=1757118094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqAzCQ8Fo3OU+wUKEuadYcnDclljxp+sY22y6to+weY=;
        b=gEivAr56tAMuMxIVlwV3R6HpPMHubfdq6T31Pn9RQtcOEtM0hb9UGkdspsorsQZghm
         9so3AzWTu0zDJv50SOyPpUNJLVWYDL55oe9tMyYjJsB/eKMg4vkDHUP7BngnfU8ZW3vt
         /NlKyWms++lA54umcGkkYEetKuQjZYdCp7+qkRKSuzNzLV55ZfKlaqBXhcevr7ZIhPML
         F142iNkDxeoYXrvdaYr4VH0o0WhKC8wkwo3LsKscEkBhuQdz46WKUB0o3pTiWCEiSKIN
         S8n1nIQ0jlJf0h1K17uFGXTSlMtZtNUPUmWGOJcSHGzouBal5Pep+MbRb9GD55OQxvHg
         CTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513294; x=1757118094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqAzCQ8Fo3OU+wUKEuadYcnDclljxp+sY22y6to+weY=;
        b=hnxII1ztoUuTVRXyJp0snzK/oWB8lpstvlpJnrzXsaiJeM0+uqVGl7twLM2enNrRDt
         ZO2aNFAi4y5dzH1WKIXWVmTXofY2U5wDGR4abs60AyYJty+2meFQ8k8Jz4wk4uL2lkWC
         YpcGKKtI3FGszlm+w/bLKknn8BaONflFmljZnYQ742uIcYEpK1b3kHPQtpxw5GZ/64vJ
         9aTn7VAykl9Bl7O9kLH6oOdcJpqSIb0uTqSQVnZFFpkx/+Qd1nKlEZGWqZHtPbFouiXn
         YAFytN1KiqhyCzCZU57fR0qd2/D1K68IUGotgh0WyNrYWTkRemucqWXj0zAFsuyERw+S
         YNYA==
X-Forwarded-Encrypted: i=1; AJvYcCUg26wgxrRAS85CXsIpxEPllTjayVqDo8zsxs5+0Dg9gutPydTy7R4cRN3fHnKNKX67uJ810UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ54THFYJ7JS0p9CG+c0gO2lTiAQk9ed/JEtKkUxR83HvEtXND
	S6OdYmxoKrrp1thq0Mbbqsleg0uoWDrZJP9Y3YFz1ZbCMzmL4w4XmYfRl90COTU6EN56U4ck+fV
	zLSt1ymsllsMZuMmotCWNSorfFFQX/m4RGChHkx9f
X-Gm-Gg: ASbGncuRhvS2k6HAn5l3gB7w6Uh99A8SBpFom8GADfrYRNmukmVADcW5No7xIHJCzfH
	jinjJDfJX0deSnJ5K9wE5I6EF9/xhE1FXrMEkCYmtlswfs2lmKtoSnjYjxCFkZhvQgjmHPnswXk
	o8EPYf0BIwmN4T4fbO5LAXTN1pS8SRgS8sqrkoz8nBWDG/WrpPd4lagolLAVJfnj3x3JCHk5dj8
	sRmKsQFEK6TE96ZbWKYjMQ/SE6r+AVtCpZOhI0BmV+SPMAJdRFhPvPLwQ==
X-Google-Smtp-Source: AGHT+IECPKef46k0lY+oLfRd74UxShj/OElVbc9mFFa3vqzQtpD+66DWyp+pUK+9+PFvkUGPhqocSGIiQZ0PcqcRe3E=
X-Received: by 2002:a17:902:d2c5:b0:248:d063:7511 with SMTP id
 d9443c01a7336-2493e914f27mr1521675ad.9.1756513293482; Fri, 29 Aug 2025
 17:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca> <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
 <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
 <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca> <CAAywjhRbk_mH16GViYqOh4mphBzQWPb+DGHAycMY4JYmkaLR=Q@mail.gmail.com>
 <f62085ff-ab39-4452-8862-7352901f1d86@uwaterloo.ca>
In-Reply-To: <f62085ff-ab39-4452-8862-7352901f1d86@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 17:21:21 -0700
X-Gm-Features: Ac12FXwpQjB7Yfiu3SEJOqtR7NHHq4RrBH7yTK41_37NwikuPLQJCbpLWJRZFGY
Message-ID: <CAAywjhQa6uzBwtR5M3Y1D8zJ9P3mBW+BU7j2AzSiX4+d-77tMg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:37=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-29 19:31, Samiullah Khawaja wrote:
> > On Fri, Aug 29, 2025 at 3:56=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-08-29 18:25, Samiullah Khawaja wrote:
> >>> On Fri, Aug 29, 2025 at 3:19=E2=80=AFPM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>>>
> >>>> On 2025-08-29 14:08, Martin Karsten wrote:
> >>>>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
> >>>>>> On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@u=
waterloo.ca>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>>>>>>> Extend the already existing support of threaded napi poll to do
> >>>>>>>> continuous
> >>>>>>>> busy polling.
> >>>>>>>>
> >>>>>>>> This is used for doing continuous polling of napi to fetch descr=
iptors
> >>>>>>>> from backing RX/TX queues for low latency applications. Allow en=
abling
> >>>>>>>> of threaded busypoll using netlink so this can be enabled on a s=
et of
> >>>>>>>> dedicated napis for low latency applications.
> >>>>>>>>
> >>>>>>>> Once enabled user can fetch the PID of the kthread doing NAPI po=
lling
> >>>>>>>> and set affinity, priority and scheduler for it depending on the
> >>>>>>>> low-latency requirements.
> >>>>>>>>
> >>>>>>>> Extend the netlink interface to allow enabling/disabling threade=
d
> >>>>>>>> busypolling at individual napi level.
> >>>>>>>>
> >>>>>>>> We use this for our AF_XDP based hard low-latency usecase with u=
secs
> >>>>>>>> level latency requirement. For our usecase we want low jitter an=
d
> >>>>>>>> stable
> >>>>>>>> latency at P99.
> >>>>>>>>
> >>>>>>>> Following is an analysis and comparison of available (and compat=
ible)
> >>>>>>>> busy poll interfaces for a low latency usecase with stable P99. =
This
> >>>>>>>> can
> >>>>>>>> be suitable for applications that want very low latency at the e=
xpense
> >>>>>>>> of cpu usage and efficiency.
> >>>>>>>>
> >>>>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling=
 a NAPI
> >>>>>>>> backing a socket, but the missing piece is a mechanism to busy p=
oll a
> >>>>>>>> NAPI instance in a dedicated thread while ignoring available eve=
nts or
> >>>>>>>> packets, regardless of the userspace API. Most existing mechanis=
ms are
> >>>>>>>> designed to work in a pattern where you poll until new packets o=
r
> >>>>>>>> events
> >>>>>>>> are received, after which userspace is expected to handle them.
> >>>>>>>>
> >>>>>>>> As a result, one has to hack together a solution using a mechani=
sm
> >>>>>>>> intended to receive packets or events, not to simply NAPI poll. =
NAPI
> >>>>>>>> threaded busy polling, on the other hand, provides this capabili=
ty
> >>>>>>>> natively, independent of any userspace API. This makes it really
> >>>>>>>> easy to
> >>>>>>>> setup and manage.
> >>>>>>>>
> >>>>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. =
The
> >>>>>>>> description of the tool and how it tries to simulate the real wo=
rkload
> >>>>>>>> is following,
> >>>>>>>>
> >>>>>>>> - It sends UDP packets between 2 machines.
> >>>>>>>> - The client machine sends packets at a fixed frequency. To main=
tain
> >>>>>>>> the
> >>>>>>>>       frequency of the packet being sent, we use open-loop sampl=
ing.
> >>>>>>>> That is
> >>>>>>>>       the packets are sent in a separate thread.
> >>>>>>>> - The server replies to the packet inline by reading the pkt fro=
m the
> >>>>>>>>       recv ring and replies using the tx ring.
> >>>>>>>> - To simulate the application processing time, we use a configur=
able
> >>>>>>>>       delay in usecs on the client side after a reply is receive=
d from
> >>>>>>>> the
> >>>>>>>>       server.
> >>>>>>>>
> >>>>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing=
/
> >>>>>>>> selftest.
> >>>>>>>>
> >>>>>>>> We use this tool with following napi polling configurations,
> >>>>>>>>
> >>>>>>>> - Interrupts only
> >>>>>>>> - SO_BUSYPOLL (inline in the same thread where the client receiv=
es the
> >>>>>>>>       packet).
> >>>>>>>> - SO_BUSYPOLL (separate thread and separate core)
> >>>>>>>> - Threaded NAPI busypoll
> >>>>>>>>
> >>>>>>>> System is configured using following script in all 4 cases,
> >>>>>>>>
> >>>>>>>> ```
> >>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>>>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>>>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>>>>>>
> >>>>>>>> sudo ethtool -L eth0 rx 1 tx 1
> >>>>>>>> sudo ethtool -G eth0 rx 1024
> >>>>>>>>
> >>>>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>>>>>>
> >>>>>>>>      # pin IRQs on CPU 2
> >>>>>>>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>>>>>>                                  print arr[0]}' < /proc/interrup=
ts)"
> >>>>>>>> for irq in "${IRQS}"; \
> >>>>>>>>          do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; =
done
> >>>>>>>>
> >>>>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>>>>>>
> >>>>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>>>>>>                          do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>>>>>>
> >>>>>>>> if [[ -z "$1" ]]; then
> >>>>>>>>       echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>>>       echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_ir=
qs
> >>>>>>>>       echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_time=
out
> >>>>>>>> fi
> >>>>>>>>
> >>>>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 =
tx-
> >>>>>>>> usecs 0
> >>>>>>>>
> >>>>>>>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>>>       echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_ir=
qs
> >>>>>>>>       echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeou=
t
> >>>>>>>>       echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>>>>>>       NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ prin=
t $2 }')
> >>>>>>>>       sudo chrt -f  -p 50 $NAPI_T
> >>>>>>>>
> >>>>>>>>       # pin threaded poll thread to CPU 2
> >>>>>>>>       sudo taskset -pc 2 $NAPI_T
> >>>>>>>> fi
> >>>>>>>>
> >>>>>>>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>>>>>>       echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>>>       echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>>>>       echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeou=
t
> >>>>>>>> fi
> >>>>>>>> ```
> >>>>>>>
> >>>>>>> The experiment script above does not work, because the sysfs para=
meter
> >>>>>>> does not exist anymore in this version.
> >>>>>>>
> >>>>>>>> To enable various configurations, script can be run as following=
,
> >>>>>>>>
> >>>>>>>> - Interrupt Only
> >>>>>>>>       ```
> >>>>>>>>       <script> enable_interrupt
> >>>>>>>>       ```
> >>>>>>>>
> >>>>>>>> - SO_BUSYPOLL (no arguments to script)
> >>>>>>>>       ```
> >>>>>>>>       <script>
> >>>>>>>>       ```
> >>>>>>>>
> >>>>>>>> - NAPI threaded busypoll
> >>>>>>>>       ```
> >>>>>>>>       <script> enable_threaded
> >>>>>>>>       ```
> >>>>>>>>
> >>>>>>>> If using idpf, the script needs to be run again after launching =
the
> >>>>>>>> workload just to make sure that the configurations are not rever=
ted. As
> >>>>>>>> idpf reverts some configurations on software reset when AF_XDP p=
rogram
> >>>>>>>> is attached.
> >>>>>>>>
> >>>>>>>> Once configured, the workload is run with various configurations=
 using
> >>>>>>>> following commands. Set period (1/frequency) and delay in usecs =
to
> >>>>>>>> produce results for packet frequency and application processing =
delay.
> >>>>>>>>
> >>>>>>>>      ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>>>>>>
> >>>>>>>> - Server
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5=
4321 -
> >>>>>>>> h -v
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> - Client
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5=
4321 \
> >>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>>      ## SO_BUSYPOLL(done in separate core using recvfrom)
> > Defines this test case clearly here.
> >>>>>>>>
> >>>>>>>> Argument -t spawns a seprate thread and continuously calls recvf=
rom.
> > This defines the -t argument and clearly states that it spawns the
> > separate thread.
> >>>>>>>>
> >>>>>>>> - Server
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5=
4321 \
> >>>>>>>>          -h -v -t
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> - Client
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5=
4321 \
> >>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>>>>>>> ```
> >>
> >> see below
> >>>>>>>>      ## NAPI Threaded Busy Poll
> > Section for NAPI Threaded Busy Poll scenario
> >>>>>>>>
> >>>>>>>> Argument -n skips the recvfrom call as there is no recv kick nee=
ded.
> > States -n argument and defines it.
> >>>>>>>>
> >>>>>>>> - Server
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5=
4321 \
> >>>>>>>>          -h -v -n
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> - Client
> >>>>>>>> ```
> >>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>>>          -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5=
4321 \
> >>>>>>>>          -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>>>>>>> ```
> >>
> >> see below
> >>>>>>> I believe there's a bug when disabling busy-polled napi threading=
 after
> >>>>>>> an experiment. My system hangs and needs a hard reset.
> >>>>>>>
> >>>>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) =
|
> >>>>>>>> NAPI threaded |
> >>>>>>>> |---|---|---|---|---|
> >>>>>>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>>>>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>>>>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>>>>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>>>>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>>>>>
> >>>>>>> On my system, routing the irq to same core where xsk_rr runs resu=
lts in
> >>>>>>> lower latency than routing the irq to a different core. To me tha=
t makes
> >>>>>>> sense in a low-rate latency-sensitive scenario where interrupts a=
re not
> >>>>>>> causing much trouble, but the resulting locality might be benefic=
ial. I
> >>>>>>> think you should test this as well.
> >>>>>>>
> >>>>>>> The experiments reported above (except for the first one) are
> >>>>>>> cherry-picking parameter combinations that result in a near-100% =
load
> >>>>>>> and ignore anything else. Near-100% load is a highly unlikely sce=
nario
> >>>>>>> for a latency-sensitive workload.
> >>>>>>>
> >>>>>>> When combining the above two paragraphs, I believe other interest=
ing
> >>>>>>> setups are missing from the experiments, such as comparing to two=
 pairs
> >>>>>>> of xsk_rr under high load (as mentioned in my previous emails).
> >>>>>> This is to support an existing real workload. We cannot easily mod=
ify
> >>>>>> its threading model. The two xsk_rr model would be a different
> >>>>>> workload.
> >>>>>
> >>>>> That's fine, but:
> >>>>>
> >>>>> - In principle I don't think it's a good justification for a kernel
> >>>>> change that an application cannot be rewritten.
> >>>>>
> >>>>> - I believe it is your responsibility to more comprehensively docum=
ent
> >>>>> the impact of your proposed changes beyond your one particular work=
load.>
> >>>> A few more observations from my tests for the "SO_BUSYPOLL(separate)=
" case:
> >>>>
> >>>> - Using -t for the client reduces latency compared to -T.
> >>> That is understandable and also it is part of the data I presented. -=
t
> >>> means running the SO_BUSY_POLL in a separate thread. Removing -T woul=
d
> >>> invalidate the workload by making the rate unpredictable.
> >>
> >> That's another problem with your cover letter then. The experiment as
> >> described should match the data presented. See above.
> > The experiments are described clearly. I have pointed out the areas in
> > the cover letter where these are documented. Where is the mismatch?
>
> Ah, I missed the -t at the end, sorry, my bad.
>
> >>>> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
> >>>> reduces latency.
> >>
> >> Any thoughts on this one?
> > I think we discussed this already in the previous iteration, with
> > Stanislav, and how it will suffer the same way SO_BUSYPOLL suffers. As
> > I have already stated, for my workload every microsecond matters and
> > the CPU efficiency is not an issue.
>
> Discussing is one thing. Testing is another. In my setup I observe a
> noticeable difference between using recvfrom and poll.
I experimented with it and it seems to improve a little bit in some
cases (maybe 200nsecs) but performs really badly with a low packet
rate as expected. As discussed in the last iteration and also in the
cover letter, this is because it only polls when there are no events.

count: 1249 p5: 17200
count: 12436 p50: 21100
count: 21106 p95: 21700
count: 21994 p99: 21700
rate: 24995
outstanding packets: 5

Like I stated in the cover letter and documentation, one can try to
hack together something using APIs designed to recv packets or events
but it's better to have a native mechanism supported by OS that is
designed to poll underlying NAPIs if that is what user wants.
>
> Thanks,
> Martin
>

