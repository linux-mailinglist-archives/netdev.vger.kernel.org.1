Return-Path: <netdev+bounces-218416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06520B3C59C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 01:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8CA16D89C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349311C8604;
	Fri, 29 Aug 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4yf3Vr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E3273F9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510330; cv=none; b=TSNMJj83FUd13tRlQvwHfVbTChtivYl2prUzO8SQqFfWcvBmjSk1jpiBQLv9D5JjH1HcDY8YtwWolInzWeuPxLyjowuiipgg1JYIuURk5YUcLE9KEq6oXcRRgcpeN8Au+GU6fZp9ukt/qu4oQf8ocduTyQ8ipBR1PS8bBHASpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510330; c=relaxed/simple;
	bh=qvXEwqJJnCziny3qVSyVGchHb6Itt3HK3vCp8DDAfLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrCfndsare39AzqGYAvN4HD+O0I+rcu/RZY4CYIEHRUMh3hOh4wALpD+NpTSeGToZ7JnY+LX/z0LEvfmTxWWx88hIdzlE0Ds4vOFGzTqX4/1v3+2DYCkUmMDCqjMwLTnfq4o9uLJgFVoC2Jg9vjEXKQj2pPWWvQG44MbqV6H+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4yf3Vr8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24936b6f29bso28625ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756510327; x=1757115127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me2rie7dtOpzrx5+YGaCewjGp/+hEEPxCxgWik0QEWg=;
        b=K4yf3Vr8I3NU7DOelYuYYiIZikrOrHH7G9AeMh/xkpYpDtMJ3urRQmEEPKB1vNNoBf
         ZHigi8zLgGqBC5KUlxXRartPqOG4OmxUxfFja0E5vbRIU7Vidsk+ktch4QjZqlWLTY8o
         fwMrilW/K156XdV/722AsbelGbugwLWOJUm1r3kERG+2VvtRI2651M9ysAkoa2jZ+bCx
         o4T97Wwfkp4YHTlMk5Iot/4JHW0SRU6s9RVwLSY7UnM9NFTHPO1RSfFVX+9zQHxxFTR2
         yWXtRGAI4w1pKIJxoEbVDhuWhOO27338MzvZldx+DxsLHVslYkVmQRp3I+LOU36Mo9AL
         npjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510327; x=1757115127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me2rie7dtOpzrx5+YGaCewjGp/+hEEPxCxgWik0QEWg=;
        b=CPbNtrtuRAad+SM2tng22vWcAakT+dnxF/7EZ8c5U/lr507ltw4tpw1vcexgYSUPSM
         dEvbAcfX4kObhupVNAmYKIea23WehvxpXdpmbapBC10YynjKv6it4hIOeYxueSAJbygZ
         7iJBeWaHPETECyNOs9WfA0wEQz9X3QwKMolJlgdLaYpn541u+0gvb0WTvZIVVWY9D0HZ
         pw71GwYPqijTLcXwY5lARxSLWgSlUPa6gIZDz6g6iYs52RWUEzL9QOPm6nmLFsx57fgd
         sQZqkJyzD5CQrx56sxKCZw3zpsfMr8bh8IxzOSgOmPPFwMYJGKcWzJfqSyuusrMvWIgC
         5sOA==
X-Forwarded-Encrypted: i=1; AJvYcCWzgkUE3ww8a2jJlmwBEtPQ39/+FdbWCmnIkIGkYqsRGbX/lPEApvb/DbzwbDznwlPNMfZqgPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOiHOD07XcIeJ5+gA/JR2EoeHdSQfNcQTB+hB+mTUq9AKA5wu
	VUdtVRJI6AGvPKTB7O5GGE1R38bayNYnCxnQIqxtcx7lIiT0iNyWli2Frcmhn3NAakYQ9HPGMa3
	eiDleWEEZIFKaL26SUJM6qXjXTaBM4F54pweURRct
X-Gm-Gg: ASbGnctvf0OlooI0Vo6+DgRsqxj8ZELsIrFBfHuMKIjYncf50gxlISdEtYMXnY5yTrN
	ZAGv04ptr/aQpZN0jejg8hLSp5YRkjWofqze5aiD1oKvgVoF4leoN14srVCAwlcaiNlKsYWHJW+
	RyoQmYjy5KtvjmvrXiwx8tKD6QOhV9IfugThZW1S+bEuOKLn9rPGcTvVgSNJaj+uiAR9Fq2NxbC
	8zxT2PK8IlfyAxpi5n8mpSg1V4QZzBSMgacGl886eZTC/hiEWhLtVRJbz+Oupn5p3YN
X-Google-Smtp-Source: AGHT+IEgofgLiH8worPt8HgoEJjqdLMD9acyOO6XbyE6Q+mrgBSH8FYwxanOfHl4Xr8pRq6I3gC9wUSf52KT54oVYGE=
X-Received: by 2002:a17:902:f689:b0:248:a039:b6e3 with SMTP id
 d9443c01a7336-2493e9af74bmr1536975ad.10.1756510326876; Fri, 29 Aug 2025
 16:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca> <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
 <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com> <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca>
In-Reply-To: <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 16:31:54 -0700
X-Gm-Features: Ac12FXz4kxBgUGw5IF_OUab0FXSbWjbkj87aSve4sQ5qy0I9wRE1ZGh5j-bcIh8
Message-ID: <CAAywjhRbk_mH16GViYqOh4mphBzQWPb+DGHAycMY4JYmkaLR=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 3:56=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-29 18:25, Samiullah Khawaja wrote:
> > On Fri, Aug 29, 2025 at 3:19=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-08-29 14:08, Martin Karsten wrote:
> >>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
> >>>> On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwa=
terloo.ca>
> >>>> wrote:
> >>>>>
> >>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>>>>> Extend the already existing support of threaded napi poll to do
> >>>>>> continuous
> >>>>>> busy polling.
> >>>>>>
> >>>>>> This is used for doing continuous polling of napi to fetch descrip=
tors
> >>>>>> from backing RX/TX queues for low latency applications. Allow enab=
ling
> >>>>>> of threaded busypoll using netlink so this can be enabled on a set=
 of
> >>>>>> dedicated napis for low latency applications.
> >>>>>>
> >>>>>> Once enabled user can fetch the PID of the kthread doing NAPI poll=
ing
> >>>>>> and set affinity, priority and scheduler for it depending on the
> >>>>>> low-latency requirements.
> >>>>>>
> >>>>>> Extend the netlink interface to allow enabling/disabling threaded
> >>>>>> busypolling at individual napi level.
> >>>>>>
> >>>>>> We use this for our AF_XDP based hard low-latency usecase with use=
cs
> >>>>>> level latency requirement. For our usecase we want low jitter and
> >>>>>> stable
> >>>>>> latency at P99.
> >>>>>>
> >>>>>> Following is an analysis and comparison of available (and compatib=
le)
> >>>>>> busy poll interfaces for a low latency usecase with stable P99. Th=
is
> >>>>>> can
> >>>>>> be suitable for applications that want very low latency at the exp=
ense
> >>>>>> of cpu usage and efficiency.
> >>>>>>
> >>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a=
 NAPI
> >>>>>> backing a socket, but the missing piece is a mechanism to busy pol=
l a
> >>>>>> NAPI instance in a dedicated thread while ignoring available event=
s or
> >>>>>> packets, regardless of the userspace API. Most existing mechanisms=
 are
> >>>>>> designed to work in a pattern where you poll until new packets or
> >>>>>> events
> >>>>>> are received, after which userspace is expected to handle them.
> >>>>>>
> >>>>>> As a result, one has to hack together a solution using a mechanism
> >>>>>> intended to receive packets or events, not to simply NAPI poll. NA=
PI
> >>>>>> threaded busy polling, on the other hand, provides this capability
> >>>>>> natively, independent of any userspace API. This makes it really
> >>>>>> easy to
> >>>>>> setup and manage.
> >>>>>>
> >>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. Th=
e
> >>>>>> description of the tool and how it tries to simulate the real work=
load
> >>>>>> is following,
> >>>>>>
> >>>>>> - It sends UDP packets between 2 machines.
> >>>>>> - The client machine sends packets at a fixed frequency. To mainta=
in
> >>>>>> the
> >>>>>>      frequency of the packet being sent, we use open-loop sampling=
.
> >>>>>> That is
> >>>>>>      the packets are sent in a separate thread.
> >>>>>> - The server replies to the packet inline by reading the pkt from =
the
> >>>>>>      recv ring and replies using the tx ring.
> >>>>>> - To simulate the application processing time, we use a configurab=
le
> >>>>>>      delay in usecs on the client side after a reply is received f=
rom
> >>>>>> the
> >>>>>>      server.
> >>>>>>
> >>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/
> >>>>>> selftest.
> >>>>>>
> >>>>>> We use this tool with following napi polling configurations,
> >>>>>>
> >>>>>> - Interrupts only
> >>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives=
 the
> >>>>>>      packet).
> >>>>>> - SO_BUSYPOLL (separate thread and separate core)
> >>>>>> - Threaded NAPI busypoll
> >>>>>>
> >>>>>> System is configured using following script in all 4 cases,
> >>>>>>
> >>>>>> ```
> >>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>>>>
> >>>>>> sudo ethtool -L eth0 rx 1 tx 1
> >>>>>> sudo ethtool -G eth0 rx 1024
> >>>>>>
> >>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>>>>
> >>>>>>     # pin IRQs on CPU 2
> >>>>>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>>>>                                 print arr[0]}' < /proc/interrupts)=
"
> >>>>>> for irq in "${IRQS}"; \
> >>>>>>         do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; don=
e
> >>>>>>
> >>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>>>>
> >>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>>>>                         do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>>>>
> >>>>>> if [[ -z "$1" ]]; then
> >>>>>>      echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>>      echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>>> fi
> >>>>>>
> >>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx=
-
> >>>>>> usecs 0
> >>>>>>
> >>>>>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>>>      echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>>>>      NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $=
2 }')
> >>>>>>      sudo chrt -f  -p 50 $NAPI_T
> >>>>>>
> >>>>>>      # pin threaded poll thread to CPU 2
> >>>>>>      sudo taskset -pc 2 $NAPI_T
> >>>>>> fi
> >>>>>>
> >>>>>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>>>      echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>>> fi
> >>>>>> ```
> >>>>>
> >>>>> The experiment script above does not work, because the sysfs parame=
ter
> >>>>> does not exist anymore in this version.
> >>>>>
> >>>>>> To enable various configurations, script can be run as following,
> >>>>>>
> >>>>>> - Interrupt Only
> >>>>>>      ```
> >>>>>>      <script> enable_interrupt
> >>>>>>      ```
> >>>>>>
> >>>>>> - SO_BUSYPOLL (no arguments to script)
> >>>>>>      ```
> >>>>>>      <script>
> >>>>>>      ```
> >>>>>>
> >>>>>> - NAPI threaded busypoll
> >>>>>>      ```
> >>>>>>      <script> enable_threaded
> >>>>>>      ```
> >>>>>>
> >>>>>> If using idpf, the script needs to be run again after launching th=
e
> >>>>>> workload just to make sure that the configurations are not reverte=
d. As
> >>>>>> idpf reverts some configurations on software reset when AF_XDP pro=
gram
> >>>>>> is attached.
> >>>>>>
> >>>>>> Once configured, the workload is run with various configurations u=
sing
> >>>>>> following commands. Set period (1/frequency) and delay in usecs to
> >>>>>> produce results for packet frequency and application processing de=
lay.
> >>>>>>
> >>>>>>     ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>>>>
> >>>>>> - Server
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5432=
1 -
> >>>>>> h -v
> >>>>>> ```
> >>>>>>
> >>>>>> - Client
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5432=
1 \
> >>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>>>>> ```
> >>>>>>
> >>>>>>     ## SO_BUSYPOLL(done in separate core using recvfrom)
Defines this test case clearly here.
> >>>>>>
> >>>>>> Argument -t spawns a seprate thread and continuously calls recvfro=
m.
This defines the -t argument and clearly states that it spawns the
separate thread.
> >>>>>>
> >>>>>> - Server
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5432=
1 \
> >>>>>>         -h -v -t
> >>>>>> ```
> >>>>>>
> >>>>>> - Client
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5432=
1 \
> >>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>>>>> ```
>
> see below
> >>>>>>     ## NAPI Threaded Busy Poll
Section for NAPI Threaded Busy Poll scenario
> >>>>>>
> >>>>>> Argument -n skips the recvfrom call as there is no recv kick neede=
d.
States -n argument and defines it.
> >>>>>>
> >>>>>> - Server
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 5432=
1 \
> >>>>>>         -h -v -n
> >>>>>> ```
> >>>>>>
> >>>>>> - Client
> >>>>>> ```
> >>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 5432=
1 \
> >>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>>>>> ```
>
> see below
> >>>>> I believe there's a bug when disabling busy-polled napi threading a=
fter
> >>>>> an experiment. My system hangs and needs a hard reset.
> >>>>>
> >>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) |
> >>>>>> NAPI threaded |
> >>>>>> |---|---|---|---|---|
> >>>>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>>>
> >>>>> On my system, routing the irq to same core where xsk_rr runs result=
s in
> >>>>> lower latency than routing the irq to a different core. To me that =
makes
> >>>>> sense in a low-rate latency-sensitive scenario where interrupts are=
 not
> >>>>> causing much trouble, but the resulting locality might be beneficia=
l. I
> >>>>> think you should test this as well.
> >>>>>
> >>>>> The experiments reported above (except for the first one) are
> >>>>> cherry-picking parameter combinations that result in a near-100% lo=
ad
> >>>>> and ignore anything else. Near-100% load is a highly unlikely scena=
rio
> >>>>> for a latency-sensitive workload.
> >>>>>
> >>>>> When combining the above two paragraphs, I believe other interestin=
g
> >>>>> setups are missing from the experiments, such as comparing to two p=
airs
> >>>>> of xsk_rr under high load (as mentioned in my previous emails).
> >>>> This is to support an existing real workload. We cannot easily modif=
y
> >>>> its threading model. The two xsk_rr model would be a different
> >>>> workload.
> >>>
> >>> That's fine, but:
> >>>
> >>> - In principle I don't think it's a good justification for a kernel
> >>> change that an application cannot be rewritten.
> >>>
> >>> - I believe it is your responsibility to more comprehensively documen=
t
> >>> the impact of your proposed changes beyond your one particular worklo=
ad.>
> >> A few more observations from my tests for the "SO_BUSYPOLL(separate)" =
case:
> >>
> >> - Using -t for the client reduces latency compared to -T.
> > That is understandable and also it is part of the data I presented. -t
> > means running the SO_BUSY_POLL in a separate thread. Removing -T would
> > invalidate the workload by making the rate unpredictable.
>
> That's another problem with your cover letter then. The experiment as
> described should match the data presented. See above.
The experiments are described clearly. I have pointed out the areas in
the cover letter where these are documented. Where is the mismatch?
>
> >> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
> >> reduces latency.
>
> Any thoughts on this one?
I think we discussed this already in the previous iteration, with
Stanislav, and how it will suffer the same way SO_BUSYPOLL suffers. As
I have already stated, for my workload every microsecond matters and
the CPU efficiency is not an issue.
>
> Best,
> Martin
>

