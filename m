Return-Path: <netdev+bounces-234497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E1C21D9A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE69188DF07
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECFE2DC331;
	Thu, 30 Oct 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvB/cgAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C4221714
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850992; cv=none; b=tKqj22Rwc1f/S/6lG5TZ1tgXKLtcnZu3PcidvVn0d4SgHu25xuH97+3kvceoAv0fnYR2ivyhgxhCYHM9DqiWf4DwJXlwse6orXlV72sJ/BefWth/1rFBCOSjL1R3YWRnIXueZ1CDv9PXaL0ERZ90Fs7dVNnTlie6hbjapVs1CPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850992; c=relaxed/simple;
	bh=AP7Ozpku/uWYJ4i1ywdxcaYWt5v6hmqW7n05MeheVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEpcWYBegd/kQCtgNvlzHnaHonsnhygJI0SQ3vozRGyIIBwtVQ0+so0AKjt3lYouO6BGlCSMhavVr0ossDljDPaUrnhDAPX9DEBt5wIvkrc5htOqeg9O0sdL2jnQPGwyWRHWx43u6yPxuIm0CmFIHiu2gd5cHNq46Z3Q3slFpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvB/cgAY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eccff716f4so54281cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761850988; x=1762455788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFitRZwUN4bhOAXfK0xHPXP64EiKGvEdrMearA0WxRQ=;
        b=tvB/cgAYFGKvDJiknA9i96dM24C8BTq7zRh1/0IewZLuLmZAPFZPDJFAjrEkbYMf2j
         Df/sFM+w+n+s1XP7Pl6pkZOSNnczkSl76fjoBH5kJWphL7vsNdzJuhOtmNg9zEtFj8pl
         ZrLC/bmyaa2Ptw+vPFRCkYWebYTGxt3KAabctbN+SSjl/ay/3ZDl4M96Psy5VGQP8CQE
         lIFYPg9hgCBohaLTeDG25ENE+yzFDXEDbiaIoBoC1i4rNRD36UkRI4mIYXOIbpCRJApv
         F7FDGkldqThqAHpWNDvAkWSIupSKbIjyt6hHR9qC2XeFJ2OmtpVwvT4UelE5OLe6fOk1
         BZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761850988; x=1762455788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFitRZwUN4bhOAXfK0xHPXP64EiKGvEdrMearA0WxRQ=;
        b=ou4r01+SqtFf2lbjFSzoKgJnHlQxf4MgLnLO4Wg2dPqghnoS726ggBeiJL72XTKGHL
         WbQSRNs1UKpUQwt3rUWGi1ZKxKXmcli/L+Lf0ubKmOVsROslHG8gRlpVh1+iaBSnUkw/
         h3EXiNgyj9O9vD9Ids3kNdGge9dtmbHHGsb4WzNbGHwmzL2+zkUdy7KxW2JCviMmoY9A
         g+XWvW4bXz0/7X03ym/A+XHaLz7d19jiYTOZVBuafAzXBffzoorxGnk7A0Py2m/6kO6i
         9WB71JHJdj7vCPYCr2AbuplNPb7ybpl+Jr4ZKM8UELoGzEJHNQJ0EpXKTVJEOidb6P86
         VIOg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8Mnn1i2qhtF8fwWH2zFWFodyEPxdauqxKCPA1o6CnslkvtZ+0d0hwIESTYLscuYsQiATVQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1wHKRPUcaR20R9rmDgYsUHbNLczSSDXk9B3qHB+gfiy2MCjv
	zMgwWyOahhQB3eCqx412ogK8uWwsBKv3i9LrJN082ogCrc6J+ehufRbwQ4RQb9k3KACZbAB1dks
	F0pCoBQKG8lM4HlSz4hYqxllwdceM3ZqvaKRwvOOy
X-Gm-Gg: ASbGncvWLtthvu89WFcSa75sHvTIkWh35SsIl47o4KvwVhQ4AinNT8CZvdC3TatUYZr
	8SBN8ITqxTDhqd957nrB62TFrw+LptKGpDp1MgQ+XTxKGnEsEtr3Fqkt4kn31M9HhFIZrzUKoRM
	sZ4oN64PigJxkczXZjMgF6CzamDXd2kAS3ftiJ6KOrff+hTl4Y9NBCoiseBtUaAbDtkGuz7qHtE
	Di8tQRKUfUjUUMlsli93849cadvX7dDoduGGy9c60Q3b7y79ttQ+w/tNHSjiY45TtxUJQ9Yehe7
	dnrhmSAHwS0ACiSnFA==
X-Google-Smtp-Source: AGHT+IFcVbggjsDMFmBLnbws7w6g9/K4H8Zp0HTfoVxUE0rA9kpm5bLK704NsOhgN030j5GGsY6fRzDQPG0fo2yAR5s=
X-Received: by 2002:ac8:5d08:0:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-4ed31efc28emr1009611cf.7.1761850987754; Thu, 30 Oct 2025
 12:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028203007.575686-1-skhawaja@google.com> <559f1484-c41b-4d45-bfd1-40291c62bfbf@uwaterloo.ca>
In-Reply-To: <559f1484-c41b-4d45-bfd1-40291c62bfbf@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 30 Oct 2025 12:02:56 -0700
X-Gm-Features: AWmQ_bkJxhVqGN5BAMD1LGIC3aEq8ci5h6p1B74eHvLdz-YSUziW_Zj0KWWUa98
Message-ID: <CAAywjhRzKLjhYkiS836Sk4pZO4-ACHzYTvRgLDw6F=4RBPM6Ew@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 7:25=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-10-28 16:30, Samiullah Khawaja wrote:
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
> >    NAPI_ID=3D$(ynl --family netdev --output-json --do queue-get \
> >      --json '{"ifindex": '${IFINDEX}', "id": '0', "type": "rx"}' | jq '=
."napi-id"')
> >
> >    ynl --family netdev --json '{"id": "'${NAPI_ID}'", "threaded": "busy=
-poll"}'
> >
> >    NAPI_T=3D$(ynl --family netdev --output-json --do napi-get \
> >      --json '{"id": "'$NAPI_ID'"}' | jq '."pid"')
> >
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
> >
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
> > Argument -t spawns a separate thread and continuously calls recvfrom.
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
> >
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
> >
> >   ## Observations
> >
> > - Here without application processing all the approaches give the same
> >    latency within 1usecs range and NAPI threaded gives minimum latency.
> > - With application processing the latency increases by 3-4usecs when
> >    doing inline polling.
> > - Using a dedicated core to drive napi polling keeps the latency same
> >    even with application processing. This is observed both in userspace
> >    and threaded napi (in kernel).
> > - Using napi threaded polling in kernel gives lower latency by
> >    1-2usecs as compared to userspace driven polling in separate core.
> > - Even on a dedicated core, SO_BUSYPOLL adds around 1-2usecs of latency=
.
> >    This is because it doesn't continuously busy poll until events are
> >    ready. Instead, it returns after polling only once, requiring the
> >    process to re-invoke the syscall for each poll, which requires a new
> >    enter/leave kernel cycle and the setup/teardown of the busy poll for
> >    every single poll attempt.
> > - With application processing userspace will get the packet from recv
> >    ring and spend some time doing application processing and then do na=
pi
> >    polling. While application processing is happening a dedicated core
> >    doing napi polling can pull the packet of the NAPI RX queue and
> >    populate the AF_XDP recv ring. This means that when the application
> >    thread is done with application processing it has new packets ready =
to
> >    recv and process in recv ring.
> > - Napi threaded busy polling in the kernel with a dedicated core gives
> >    the consistent P5-P99 latency.
> >
> > Note well that threaded napi busy-polling has not been shown to yield
> > efficiency or throughput benefits. In contrast, dedicating an entire
> > core to busy-polling one NAPI (NIC queue) is rather inefficient.
> > However, in certain specific use cases, this mechanism results in lower
> > packet processing latency. The experimental testing reported here only
> > covers those use cases and does not present a comprehensive evaluation
> > of threaded napi busy-polling.
> >
> > Following histogram is generated to measure the time spent in recvfrom
> > while using inline thread with SO_BUSYPOLL. The histogram is generated
> > using the following bpftrace command. In this experiment there are 32K
> > packets per second and the application processing delay is 30usecs. Thi=
s
> > is to measure whether there is significant time spent pulling packets
> > from the descriptor queue that it will affect the overall latency if
> > done inline.
> >
> > ```
> > bpftrace -e '
> >          kprobe:xsk_recvmsg {
> >                  @start[tid] =3D nsecs;
> >          }
> >          kretprobe:xsk_recvmsg {
> >                  if (@start[tid]) {
> >                          $sample =3D (nsecs - @start[tid]);
> >                          @xsk_recvfrom_hist =3D hist($sample);
> >                          delete(@start[tid]);
> >                  }
> >          }
> >          END { clear(@start);}'
> > ```
> >
> > Here in case of inline busypolling around 35 percent of calls are takin=
g
> > 1-2usecs and around 50 percent are taking 0.5-2usecs.
> >
> > @xsk_recvfrom_hist:
> > [128, 256)         24073 |@@@@@@@@@@@@@@@@@@@@@@                       =
       |
> > [256, 512)         55633 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [512, 1K)          20974 |@@@@@@@@@@@@@@@@@@@                          =
       |
> > [1K, 2K)           34234 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              =
       |
> > [2K, 4K)            3266 |@@@                                          =
       |
> > [4K, 8K)              19 |                                             =
       |
> >
> > v10:
> >   - Added a note to the cover letter suggested by Martin Karsten about
> >     the usability of the this feature.
> >   - Removed the NAPI_STATE_SCHED_THREADED_BUSY_POLL and using
> >     NAPI_STATE_IN_BUSY_POLL to return early from napi_complete_done.
> >   - Fixed grammar and spelling mistakes in documentation and commit
> >     messages.
> >   - Removed the usage of unnecessary atomic operations while enabling a=
nd
> >     disabling busy poll.
> >   - Changed the NAPI threaded enum name from busy-poll-enabled to
> >     busy-poll.
> >   - Changed the order in which NAPI threaded and napi threaded busy-pol=
l
> >     state bits are set.
> >   - Updated the Documentation to reflect the enum name change.
> >
> > v9:
> >   - Unset NAPI_STATE_THREADED_BUSY_POLL when stopping napi kthread to
> >     prevent network disruption as reported by Martin Karsten.
> >   - Updated napi threaded busy poll enable instructions to use netlink
> >     instead of sysfs. This is because the sysfs mechanism to enable nap=
i
> >     threaded busy poll is removed.
> >
> > v8:
> >   - Fixed selftest build error.
> >   - Removed support of enabling napi busy poll at device level.
> >   - Updated documentation to reflect removal of busy poll at device
> >     level.
> >   - Added paragraph in the cover letter mentioning that napi threaded
> >     busy polling allows busy polling a NAPI natively independent of API=
.
> >   - Added paragraph in the cover letter explaining why SO_BUSYPOLL is
> >     still not enough when run in a dedicated core.
> >
> > v7:
> >   - Rebased.
> >
> > v6:
> >   - Moved threaded in struct netdevice up to fill the cacheline hole.
> >   - Changed dev_set_threaded to dev_set_threaded_hint and removed the
> >     second argument that was always set to true by all the drivers.
> >     Exported only dev_set_threaded_hint and made dev_set_threaded core
> >     only function. This change is done in a separate commit.
> >   - Updated documentation comment for threaded in struct netdevice.
> >   - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Al=
so
> >     used it in kernel/bpf/cpumap.c
> >   - Updated documentation to explicitly state that the NAPI threaded bu=
sy
> >     polling would keep the CPU core busy at 100% usage.
> >   - Updated documentation and commit messages.
> >
> > v5:
> >   - Updated experiment data with 'SO_PREFER_BUSY_POLL' usage as
> >     suggested.
> >   - Sent 'Add support to set napi threaded for individual napi'
> >     separately. This series depends on top of that patch.
> >     https://lore.kernel.org/netdev/20250423201413.1564527-1-skhawaja@go=
ogle.com/
> >   - Added a separate patch to use enum for napi threaded state. Updated
> >     the nl_netdev python test.
> >   - Using "write all" semantics when napi settings set at device level.
> >     This aligns with already existing behaviour for other settings.
> >   - Fix comments to make them kdoc compatible.
> >   - Updated Documentation/networking/net_cachelines/net_device.rst
> >   - Updated the missed gro_flush modification in napi_complete_done
> >
> > v4:
> >   - Using AF_XDP based benchmark for experiments.
> >   - Re-enable dev level napi threaded busypoll after soft reset.
> >
> > v3:
> >   - Fixed calls to dev_set_threaded in drivers
> >
> > v2:
> >   - Add documentation in napi.rst.
> >   - Provide experiment data and usecase details.
> >   - Update busy_poller selftest to include napi threaded poll testcase.
> >   - Define threaded mode enum in netlink interface.
> >   - Included NAPI threaded state in napi config to save/restore.
> >
> > Samiullah Khawaja (2):
> >    net: Extend NAPI threaded polling to allow kthread based busy pollin=
g
> >    selftests: Add napi threaded busy poll test in `busy_poller`
> >
> >   Documentation/netlink/specs/netdev.yaml       |  5 +-
> >   Documentation/networking/napi.rst             | 50 +++++++++++++++-
> >   include/linux/netdevice.h                     |  4 +-
> >   include/uapi/linux/netdev.h                   |  1 +
> >   net/core/dev.c                                | 58 +++++++++++++++---=
-
> >   net/core/dev.h                                |  3 +
> >   net/core/netdev-genl-gen.c                    |  2 +-
> >   tools/include/uapi/linux/netdev.h             |  1 +
> >   tools/testing/selftests/net/busy_poll_test.sh | 24 +++++++-
> >   tools/testing/selftests/net/busy_poller.c     | 16 ++++-
> >   10 files changed, 145 insertions(+), 19 deletions(-)
> >
> >
> > base-commit: bfe62db5422b1a5f25752bd0877a097d436d876d
>
> I have tested this again. Not sure what's appropriate, so I'm offering
> both tags:
>
> Acked-by: Martin Karsten <mkarsten@uwaterloo.ca>
>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>

Thanks for testing and the tags.
>
> Best,
> Martin
>

