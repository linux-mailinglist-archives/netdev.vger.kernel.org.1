Return-Path: <netdev+bounces-218373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3784CB3C3EB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1550A643D3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A322A7E4;
	Fri, 29 Aug 2025 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqnVL6rD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62EA19D07A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500579; cv=none; b=jP5zj6ZsJnLvQRTaTOtMQhlBMv8+B72ka/zPP8ffHr9sfcAl70YItsby0ZoHPzyVxL6pu5r6HG4IIrdFh78uQGxpYezOjESVnY+WVmLGSjAmrcuToPt1aTYYfERNwTDhqi4np8VEzZsX9tcROhmH/E8b31LbKFHj5FRvt6AldqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500579; c=relaxed/simple;
	bh=5IrouPABf9K4GPQ9C5L0kA/6y4F72zKTquGPIWppTfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6JPwca0aafM9t1qa5eHogjYhrN3Hwsaod4vF+eukf8N6kHzFoiV5Q4EO/PCinjq+QFPjegQAizNtroLX1WYBYZqK9WGvMRdd6w8MrPV3pmS+hzR18dDBnPQV/yHjaYjFLGYp/e19Qqe4o5gRUZMKor35eQHPCKBYh0fGGlWAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqnVL6rD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-248f08d31dcso52865ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756500577; x=1757105377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsVmFN3aYCz3Cy5GG//B8ZDmvr4tzdpMgWm9z1TY0Dw=;
        b=yqnVL6rDcU7HBB7IygJhJJ7kyNT2fYw0SVxEFZjSCOMZDQm8eDH9ucYaNkQKfpr+B0
         yMo6CQ0+SyBQbG2Jq9bga8YFHw6OpiGSPp2bGgplbzyUADFJvEXRDaXNrwpxH6LWMuMM
         M/hCjQahV6GxPEauPoKryKuFnzBlmH0pCDck1BpcwEo10FloY3c84u56M3MyjItYkMiO
         SJOmvVkyQkSkbU3uRXmsVyA2uq3tz35pJ8tqlk8BAA0PchvdRTLMbWgWrRyG204Wqd/g
         zPCIJIS0DABwRpgCYgl1FyOeW5TgHPeiXFxfcGexTu7rqwObuh2KB0n8K/z7Tl2DnA3t
         50eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500577; x=1757105377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsVmFN3aYCz3Cy5GG//B8ZDmvr4tzdpMgWm9z1TY0Dw=;
        b=YNbJfOs2VpfSf4q1VscZJMtJAi1fyqh8jrAXjLhgd7AXeEg3P6Oq8xvqHgCiX07bOv
         XCxcueNqySxN+UAZqLnixPCCBaQzyaHKisdG8Yf767KtG7JakpmMAuGWhM0wodg8R7EM
         KOuqq94iHUKIamXRI8fyGB8a0/OCezIz4ucXuKeu9XF9GlZMU9mDz/O7XwJu7odGW65H
         2vYZ1FLGLbmVys5AEMGDzxsJqL37NXEezCo2AE0rTV7/HipdjIYCRNvq8wVyHW6t6QFG
         56epV5MRd3I/PKrHfTHPR1r+DRIL2x031QBxfpGJ3wqzox/tgLVeAuzPRMaw0E3rcm0s
         3flw==
X-Forwarded-Encrypted: i=1; AJvYcCWQGX6eAydj9ueRPdzeA1yenQLhH3Ayb3cLXctFy8Xzsw60rYRV5ZgYOah5SwaKeVOhb5XJPWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8HubNXsgpBRO0CPljdUdu/ix1hJ6bLJD6iGgiSG3jN3oBQRv
	VLKq3eiCcr0JZFUsAUCtC7+MGaUIYScuI4MvImfPlCH8xFJ02cfyOZsUiNTn/+0rLVaNUS5eNn6
	YQ+E1pt/sBZ/gbZaO8TobNto8n6e3kAAH8PnwZA1b
X-Gm-Gg: ASbGncsSxxPvoImJuMZjGaZf0WsqkXMw2dUfvYcFDiaa+0jTAX7/zHqHDfIO/TGbLFe
	XXIJ8G9HUIuS5ytpSNbXyFtmIoTc9t5DWOCVibv9yc7z36umCW2EPGgZ9vya79fVgzw0YaYL1RI
	YKPxvBIs9qnVUNTJBq6yY81VkU54+5Ue0L4AKPQy1HNB9fbjD1GKxP5qwx5O/v1VmZjhMnTSHak
	gvVMHEz3NG2FUZUoGwL943A5gTy/tCJZ8muMIAo6EAhgT4=
X-Google-Smtp-Source: AGHT+IHW9B+oprkG6TCjEZuiXLEL+Kl0ZYLuEBACy4ZCmcSF/qoCGlqyzFx5vIEv0uAAIL4vsoUOX/p0EyHiFLqHpYM=
X-Received: by 2002:a17:903:32c7:b0:248:bac6:4fd8 with SMTP id
 d9443c01a7336-2493e9db864mr988035ad.15.1756500576615; Fri, 29 Aug 2025
 13:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com> <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
In-Reply-To: <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 13:49:21 -0700
X-Gm-Features: Ac12FXzCftYXaOIFTgp3-J1OWZ284Ye3ASRf_EhWfiKyvHu2d3IEc-tU9VLHQZM
Message-ID: <CAAywjhQJHNN6MSuioJWo+siV8KDM-7BUQa3Ge+z7-V00KWJhtA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 11:08=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo=
.ca> wrote:
>
> On 2025-08-29 13:50, Samiullah Khawaja wrote:
> > On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>> Extend the already existing support of threaded napi poll to do conti=
nuous
> >>> busy polling.
> >>>
> >>> This is used for doing continuous polling of napi to fetch descriptor=
s
> >>> from backing RX/TX queues for low latency applications. Allow enablin=
g
> >>> of threaded busypoll using netlink so this can be enabled on a set of
> >>> dedicated napis for low latency applications.
> >>>
> >>> Once enabled user can fetch the PID of the kthread doing NAPI polling
> >>> and set affinity, priority and scheduler for it depending on the
> >>> low-latency requirements.
> >>>
> >>> Extend the netlink interface to allow enabling/disabling threaded
> >>> busypolling at individual napi level.
> >>>
> >>> We use this for our AF_XDP based hard low-latency usecase with usecs
> >>> level latency requirement. For our usecase we want low jitter and sta=
ble
> >>> latency at P99.
> >>>
> >>> Following is an analysis and comparison of available (and compatible)
> >>> busy poll interfaces for a low latency usecase with stable P99. This =
can
> >>> be suitable for applications that want very low latency at the expens=
e
> >>> of cpu usage and efficiency.
> >>>
> >>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NA=
PI
> >>> backing a socket, but the missing piece is a mechanism to busy poll a
> >>> NAPI instance in a dedicated thread while ignoring available events o=
r
> >>> packets, regardless of the userspace API. Most existing mechanisms ar=
e
> >>> designed to work in a pattern where you poll until new packets or eve=
nts
> >>> are received, after which userspace is expected to handle them.
> >>>
> >>> As a result, one has to hack together a solution using a mechanism
> >>> intended to receive packets or events, not to simply NAPI poll. NAPI
> >>> threaded busy polling, on the other hand, provides this capability
> >>> natively, independent of any userspace API. This makes it really easy=
 to
> >>> setup and manage.
> >>>
> >>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> >>> description of the tool and how it tries to simulate the real workloa=
d
> >>> is following,
> >>>
> >>> - It sends UDP packets between 2 machines.
> >>> - The client machine sends packets at a fixed frequency. To maintain =
the
> >>>     frequency of the packet being sent, we use open-loop sampling. Th=
at is
> >>>     the packets are sent in a separate thread.
> >>> - The server replies to the packet inline by reading the pkt from the
> >>>     recv ring and replies using the tx ring.
> >>> - To simulate the application processing time, we use a configurable
> >>>     delay in usecs on the client side after a reply is received from =
the
> >>>     server.
> >>>
> >>> The xsk_rr tool is posted separately as an RFC for tools/testing/self=
test.
> >>>
> >>> We use this tool with following napi polling configurations,
> >>>
> >>> - Interrupts only
> >>> - SO_BUSYPOLL (inline in the same thread where the client receives th=
e
> >>>     packet).
> >>> - SO_BUSYPOLL (separate thread and separate core)
> >>> - Threaded NAPI busypoll
> >>>
> >>> System is configured using following script in all 4 cases,
> >>>
> >>> ```
> >>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>
> >>> sudo ethtool -L eth0 rx 1 tx 1
> >>> sudo ethtool -G eth0 rx 1024
> >>>
> >>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>
> >>>    # pin IRQs on CPU 2
> >>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>                                print arr[0]}' < /proc/interrupts)"
> >>> for irq in "${IRQS}"; \
> >>>        do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> >>>
> >>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>
> >>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>                        do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>
> >>> if [[ -z "$1" ]]; then
> >>>     echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>> fi
> >>>
> >>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-us=
ecs 0
> >>>
> >>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>     echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>     NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }'=
)
> >>>     sudo chrt -f  -p 50 $NAPI_T
> >>>
> >>>     # pin threaded poll thread to CPU 2
> >>>     sudo taskset -pc 2 $NAPI_T
> >>> fi
> >>>
> >>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>> fi
> >>> ```
> >>
> >> The experiment script above does not work, because the sysfs parameter
> >> does not exist anymore in this version.
> >>
> >>> To enable various configurations, script can be run as following,
> >>>
> >>> - Interrupt Only
> >>>     ```
> >>>     <script> enable_interrupt
> >>>     ```
> >>>
> >>> - SO_BUSYPOLL (no arguments to script)
> >>>     ```
> >>>     <script>
> >>>     ```
> >>>
> >>> - NAPI threaded busypoll
> >>>     ```
> >>>     <script> enable_threaded
> >>>     ```
> >>>
> >>> If using idpf, the script needs to be run again after launching the
> >>> workload just to make sure that the configurations are not reverted. =
As
> >>> idpf reverts some configurations on software reset when AF_XDP progra=
m
> >>> is attached.
> >>>
> >>> Once configured, the workload is run with various configurations usin=
g
> >>> following commands. Set period (1/frequency) and delay in usecs to
> >>> produce results for packet frequency and application processing delay=
.
> >>>
> >>>    ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h=
 -v
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>> ```
> >>>
> >>>    ## SO_BUSYPOLL(done in separate core using recvfrom)
> >>>
> >>> Argument -t spawns a seprate thread and continuously calls recvfrom.
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >>>        -h -v -t
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>> ```
> >>>
> >>>    ## NAPI Threaded Busy Poll
> >>>
> >>> Argument -n skips the recvfrom call as there is no recv kick needed.
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >>>        -h -v -n
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>> ```
> >>
> >> I believe there's a bug when disabling busy-polled napi threading afte=
r
> >> an experiment. My system hangs and needs a hard reset.
> >>
> >>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAP=
I threaded |
> >>> |---|---|---|---|---|
> >>> | 12 Kpkt/s + 0us delay | | | | |
> >>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>> | 32 Kpkt/s + 30us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>> | 125 Kpkt/s + 6us delay | | | | |
> >>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>> | 12 Kpkt/s + 78us delay | | | | |
> >>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>> | 25 Kpkt/s + 38us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>
> >> On my system, routing the irq to same core where xsk_rr runs results i=
n
> >> lower latency than routing the irq to a different core. To me that mak=
es
> >> sense in a low-rate latency-sensitive scenario where interrupts are no=
t
> >> causing much trouble, but the resulting locality might be beneficial. =
I
> >> think you should test this as well.
> >>
> >> The experiments reported above (except for the first one) are
> >> cherry-picking parameter combinations that result in a near-100% load
> >> and ignore anything else. Near-100% load is a highly unlikely scenario
> >> for a latency-sensitive workload.
> >>
> >> When combining the above two paragraphs, I believe other interesting
> >> setups are missing from the experiments, such as comparing to two pair=
s
> >> of xsk_rr under high load (as mentioned in my previous emails).
> > This is to support an existing real workload. We cannot easily modify
> > its threading model. The two xsk_rr model would be a different
> > workload.
>
> That's fine, but:
>
> - In principle I don't think it's a good justification for a kernel
> change that an application cannot be rewritten.
>
> - I believe it is your responsibility to more comprehensively document
> the impact of your proposed changes beyond your one particular workload.
>
> Also, I do believe there's a bug as mentioned before. I can't quite pin
> it down, but every time after running a "NAPI threaded" experiment, my
> servers enters a funny state and eventually becomes largely unresponsive
> without much useful output and needs a hard reset. For example:
>
> 1) Run "NAPI threaded" experiment
> 2) Disabled "threaded" parameter in NAPI config
> 3) Run IRQ experiment -> xsk_rr hangs and apparently holds a lock,
> because other services stop working successively.
I just tried with this scenario and it seems to work fine.
>
> Do you not have this problem?
Not Really. Jakub actually fixed a deadlock in napi threaded recently.
Maybe you are hitting that? Are you using the latest base-commit that
I have in this patch series?
>
> Thanks,
> Martin
>

