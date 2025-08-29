Return-Path: <netdev+bounces-218401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5351B3C4C6
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6F3BD01E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256C276025;
	Fri, 29 Aug 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1WKsYev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AA221F0A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506364; cv=none; b=RUo0S8TL+0OkDoJihrrvZXS5BGfmDEw5tw7rLCCEUI8SKdmRBxX8p5FUhry98x/YLuWMK9x/tWlA1HcSLTwnj730qFecKIE7sjKH5FxKO6nH4gRx3C5PfVWpocPsfQCvdAIbzhVwAZOvZSnLyjv04ZEIyi7PQzpFo6szepP8Msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506364; c=relaxed/simple;
	bh=bh/zl/GNc+Z77PQdtPTVcpOrTJPgf+gk6WZMz3bYcqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcFpUnmTmK49IcQUY44X+O8ARzl+uDHwM+rs3g32eJ4NBe/ezhNZOORnfVt7KPqZrb1ysQiTFiF3I4sv3uDFRUn96MfPpP9S7C1V3VomEA1vgmWofQMwau5nBV0QyYcpg/Qh8H44BQDPL5VRNgtgYkKemEZ+eLKt0oAxq1Y6mDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1WKsYev; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-248f08d31dcso64645ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756506362; x=1757111162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qIByQebO/MPdvaK7Doq4KFf23pdENBlrufhvQiJDAc=;
        b=u1WKsYev6xUiyYK+1Z8a7oSs0DwIP/A6XIzHiuL+qcUdzT2P7y7QV7mjxVIPYc5/Hq
         GHt2NRg2N7gRhmHu1wRa/pOKrnuO18xB+WDawAHNsfIihWB4DBCUjdUxIZKo/PMfc/7O
         t0etYezyNqB01+MgQLIngI7jF5wWSrazQApyTCOLV6F1HZLJrNdKN4YLBHGtIpS4Nm0m
         XitZPpp0K4npCT2tU+spRQZ4Azuj06Z65LBuIBUblWzLFOJDx/x7/7dtWlbw4A5uUbEX
         bZ2IcpE0z/zLVUEH68SG48jxm5Syw0nvcqaARlz2FD0K0U0XsbMkfRUe57uqbLo9oLrp
         vbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756506362; x=1757111162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qIByQebO/MPdvaK7Doq4KFf23pdENBlrufhvQiJDAc=;
        b=o4LIr0zxPZfvxxZi82ZB993gl6x8B/XmY1vK/RFQd2x7fA07c3M9iHycUJlZaFLz0B
         uGmDAOXTB7erbPd05YVumQqIj14Ic3YBkAlWAS3dpPW4MEoFsZaaM3bJn1m4Ax6yFBce
         SfTWVFUHD9MA/VZujg/8aNXy416e5Had2EIj/5Uh9h6/rChsG8znPxJFoomUnMvCRTl6
         bXvthBBEimXvb5vDmCwebFqtsICUcMGcWMsrNDlu3b+EvUwKrOOlWXBUHQRAdld5Wyqz
         kPg9gMuOx8fOtjCiZ6mwGkgXE7RNKNHTNazv3532dLQA3jE9w3jVXCNSvBgX6pEvuJE3
         yupQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqGprcdI0OiiAA777KszxznKZB2pVY+ku2WslOYGrdHRxuaGn+6W7DuEUWke9HjofKD6eoP8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUinpzrNhGd0MNeytuxSXcfuuDJVWXC89aD0muVCtyRNqm3ze
	20xTacTXzmXqIdjEDLzJXlu5U3u9R4FPB4/Xd0Wtwy/X42tY3eppOo4XWcqTeT/XhU8B+4buhCA
	0Nko+olcy0b4qSus+7NCO1PPlF/FZs+hfrNqRVJwI
X-Gm-Gg: ASbGncvIR1AvtDIKx7lKlyNLh/NUoSz3u7o8mUb4/AB4P3Nognic0jKTE4UYL94kkyp
	0e2nU3ovLi8wgDOtUnW6FUS3OSPx8e/hdZ3xi7K0P0oNElkF4LMqH1/bL5agRzPzbVZoJUI44lR
	xqTCar37HUgFPzROq9S/xfEaAjlN7YDxs6zEnQ4ivj3FYoADnYBKY1iJxtvx5mrThjtejrc9Uar
	/Sw7AEH5MMp66W9UK2/hbFv60FHdz0pEeppnx5w6dd7BG4=
X-Google-Smtp-Source: AGHT+IHkEUaBB/U4AUPbK8AsGe7byFqKBD1dummuFVhEfwL72oMoPeUtoxje5aZCdBlX9o9tEVCsNysHohyM/fgkRVw=
X-Received: by 2002:a17:902:ea0f:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-2493e8e35b7mr1561545ad.5.1756506361979; Fri, 29 Aug 2025
 15:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com> <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca> <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
In-Reply-To: <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 15:25:49 -0700
X-Gm-Features: Ac12FXysmOAEYtHyMaspkx5_xGH_mHhMCZnPUH8-Rr4XDBHqf2Q5au7QmNo4lmQ
Message-ID: <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 3:19=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-29 14:08, Martin Karsten wrote:
> > On 2025-08-29 13:50, Samiullah Khawaja wrote:
> >> On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwate=
rloo.ca>
> >> wrote:
> >>>
> >>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>>> Extend the already existing support of threaded napi poll to do
> >>>> continuous
> >>>> busy polling.
> >>>>
> >>>> This is used for doing continuous polling of napi to fetch descripto=
rs
> >>>> from backing RX/TX queues for low latency applications. Allow enabli=
ng
> >>>> of threaded busypoll using netlink so this can be enabled on a set o=
f
> >>>> dedicated napis for low latency applications.
> >>>>
> >>>> Once enabled user can fetch the PID of the kthread doing NAPI pollin=
g
> >>>> and set affinity, priority and scheduler for it depending on the
> >>>> low-latency requirements.
> >>>>
> >>>> Extend the netlink interface to allow enabling/disabling threaded
> >>>> busypolling at individual napi level.
> >>>>
> >>>> We use this for our AF_XDP based hard low-latency usecase with usecs
> >>>> level latency requirement. For our usecase we want low jitter and
> >>>> stable
> >>>> latency at P99.
> >>>>
> >>>> Following is an analysis and comparison of available (and compatible=
)
> >>>> busy poll interfaces for a low latency usecase with stable P99. This
> >>>> can
> >>>> be suitable for applications that want very low latency at the expen=
se
> >>>> of cpu usage and efficiency.
> >>>>
> >>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a N=
API
> >>>> backing a socket, but the missing piece is a mechanism to busy poll =
a
> >>>> NAPI instance in a dedicated thread while ignoring available events =
or
> >>>> packets, regardless of the userspace API. Most existing mechanisms a=
re
> >>>> designed to work in a pattern where you poll until new packets or
> >>>> events
> >>>> are received, after which userspace is expected to handle them.
> >>>>
> >>>> As a result, one has to hack together a solution using a mechanism
> >>>> intended to receive packets or events, not to simply NAPI poll. NAPI
> >>>> threaded busy polling, on the other hand, provides this capability
> >>>> natively, independent of any userspace API. This makes it really
> >>>> easy to
> >>>> setup and manage.
> >>>>
> >>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
> >>>> description of the tool and how it tries to simulate the real worklo=
ad
> >>>> is following,
> >>>>
> >>>> - It sends UDP packets between 2 machines.
> >>>> - The client machine sends packets at a fixed frequency. To maintain
> >>>> the
> >>>>     frequency of the packet being sent, we use open-loop sampling.
> >>>> That is
> >>>>     the packets are sent in a separate thread.
> >>>> - The server replies to the packet inline by reading the pkt from th=
e
> >>>>     recv ring and replies using the tx ring.
> >>>> - To simulate the application processing time, we use a configurable
> >>>>     delay in usecs on the client side after a reply is received from
> >>>> the
> >>>>     server.
> >>>>
> >>>> The xsk_rr tool is posted separately as an RFC for tools/testing/
> >>>> selftest.
> >>>>
> >>>> We use this tool with following napi polling configurations,
> >>>>
> >>>> - Interrupts only
> >>>> - SO_BUSYPOLL (inline in the same thread where the client receives t=
he
> >>>>     packet).
> >>>> - SO_BUSYPOLL (separate thread and separate core)
> >>>> - Threaded NAPI busypoll
> >>>>
> >>>> System is configured using following script in all 4 cases,
> >>>>
> >>>> ```
> >>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>>
> >>>> sudo ethtool -L eth0 rx 1 tx 1
> >>>> sudo ethtool -G eth0 rx 1024
> >>>>
> >>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>>
> >>>>    # pin IRQs on CPU 2
> >>>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>>                                print arr[0]}' < /proc/interrupts)"
> >>>> for irq in "${IRQS}"; \
> >>>>        do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> >>>>
> >>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>>
> >>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>>                        do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>>
> >>>> if [[ -z "$1" ]]; then
> >>>>     echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>     echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>> fi
> >>>>
> >>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-
> >>>> usecs 0
> >>>>
> >>>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>>     echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>>     echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>>     NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }=
')
> >>>>     sudo chrt -f  -p 50 $NAPI_T
> >>>>
> >>>>     # pin threaded poll thread to CPU 2
> >>>>     sudo taskset -pc 2 $NAPI_T
> >>>> fi
> >>>>
> >>>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>>     echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>> fi
> >>>> ```
> >>>
> >>> The experiment script above does not work, because the sysfs paramete=
r
> >>> does not exist anymore in this version.
> >>>
> >>>> To enable various configurations, script can be run as following,
> >>>>
> >>>> - Interrupt Only
> >>>>     ```
> >>>>     <script> enable_interrupt
> >>>>     ```
> >>>>
> >>>> - SO_BUSYPOLL (no arguments to script)
> >>>>     ```
> >>>>     <script>
> >>>>     ```
> >>>>
> >>>> - NAPI threaded busypoll
> >>>>     ```
> >>>>     <script> enable_threaded
> >>>>     ```
> >>>>
> >>>> If using idpf, the script needs to be run again after launching the
> >>>> workload just to make sure that the configurations are not reverted.=
 As
> >>>> idpf reverts some configurations on software reset when AF_XDP progr=
am
> >>>> is attached.
> >>>>
> >>>> Once configured, the workload is run with various configurations usi=
ng
> >>>> following commands. Set period (1/frequency) and delay in usecs to
> >>>> produce results for packet frequency and application processing dela=
y.
> >>>>
> >>>>    ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>>
> >>>> - Server
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -
> >>>> h -v
> >>>> ```
> >>>>
> >>>> - Client
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>>> ```
> >>>>
> >>>>    ## SO_BUSYPOLL(done in separate core using recvfrom)
> >>>>
> >>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
> >>>>
> >>>> - Server
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >>>>        -h -v -t
> >>>> ```
> >>>>
> >>>> - Client
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>>> ```
> >>>>
> >>>>    ## NAPI Threaded Busy Poll
> >>>>
> >>>> Argument -n skips the recvfrom call as there is no recv kick needed.
> >>>>
> >>>> - Server
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> >>>>        -h -v -n
> >>>> ```
> >>>>
> >>>> - Client
> >>>> ```
> >>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> >>>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>>> ```
> >>>
> >>> I believe there's a bug when disabling busy-polled napi threading aft=
er
> >>> an experiment. My system hangs and needs a hard reset.
> >>>
> >>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) |
> >>>> NAPI threaded |
> >>>> |---|---|---|---|---|
> >>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>
> >>> On my system, routing the irq to same core where xsk_rr runs results =
in
> >>> lower latency than routing the irq to a different core. To me that ma=
kes
> >>> sense in a low-rate latency-sensitive scenario where interrupts are n=
ot
> >>> causing much trouble, but the resulting locality might be beneficial.=
 I
> >>> think you should test this as well.
> >>>
> >>> The experiments reported above (except for the first one) are
> >>> cherry-picking parameter combinations that result in a near-100% load
> >>> and ignore anything else. Near-100% load is a highly unlikely scenari=
o
> >>> for a latency-sensitive workload.
> >>>
> >>> When combining the above two paragraphs, I believe other interesting
> >>> setups are missing from the experiments, such as comparing to two pai=
rs
> >>> of xsk_rr under high load (as mentioned in my previous emails).
> >> This is to support an existing real workload. We cannot easily modify
> >> its threading model. The two xsk_rr model would be a different
> >> workload.
> >
> > That's fine, but:
> >
> > - In principle I don't think it's a good justification for a kernel
> > change that an application cannot be rewritten.
> >
> > - I believe it is your responsibility to more comprehensively document
> > the impact of your proposed changes beyond your one particular workload=
.>
> A few more observations from my tests for the "SO_BUSYPOLL(separate)" cas=
e:
>
> - Using -t for the client reduces latency compared to -T.
That is understandable and also it is part of the data I presented. -t
means running the SO_BUSY_POLL in a separate thread. Removing -T would
invalidate the workload by making the rate unpredictable.
>
> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
> reduces latency.
>
> Best,
> Martin
>

