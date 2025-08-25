Return-Path: <netdev+bounces-216561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC708B34875
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F6A3BB5B0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4B2FE56E;
	Mon, 25 Aug 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDwmTUDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E9264F85
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142425; cv=none; b=teRD+7Xb61e/HsD16BgTF5HBACSFt6hXiqwH4TUOK/k20Fro6PnLEc4AoxwgeJJjY8HHpxVhyGqtfmwu1fqlVWOUrRC7TouglYPuk8bidAkQyOAYzqNW1oxQlzT1Lw1QyP8V1kXdD/T4F5iRfsUNHHgz/MOvm7FJTb8Of59H+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142425; c=relaxed/simple;
	bh=KZ3Ejs2j+eopBxoG8QMiH+oP7JVQRNGstAqqWIk+JlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZljTjiRDSrGh0sPPzVq2hi3vafKdjqhlUjV+/vPQ/MqxocCN30XcJMrJyLJKaJvih7NxXIjuICXurso6ym31m9Asa4Et9/24H68Y/dielZcA8FSxY4ikj6LhaOD+RYxKsHLcr2005Uj/IXcUdgNKrOatS0GBEuyYASomuulu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDwmTUDR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-246013de800so14205ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756142423; x=1756747223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QedPkmQ9jAFVD3fmRXCk4KxIyVoZH+FRQ3YAzIaprn8=;
        b=oDwmTUDRpJOROmsGghS4sJpfQ0cDi8030aIcME3994s8djWxfjdfT53HFpNZe3LJ6K
         1DlxFOGPOM8GpcrcEE2iNKEo9f81LdZd9NshxDIsj6uZOEPYCaacK5sJu96CVeLmNycF
         KWt85s6E4jXn4pRFx0a4FLaaDPnsaDpNl3hqhWXLfGSmFDIVTV++1vzqPALYvEQUuJdG
         eewG3JR+gsOKq5WypyVv8f0+vuFUbuvzlwJRzuv6AnZmhgO0erQnBFfpYNdoRXzXYPY9
         nUjBX9TQexr5VEZWvGgffKG2Oqx9KvYElTwiWUCA8Btdn+40n8BcnfX6SGKSqwrE/zZg
         e0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142423; x=1756747223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QedPkmQ9jAFVD3fmRXCk4KxIyVoZH+FRQ3YAzIaprn8=;
        b=nnp3mAY36l1nV6O6SUoUAsbzmxYGigUWt1gvRb/wdsPZ4EAjflOBqMlqaDcMvYGcCu
         KkX66XD8YLFZdx2+XDJIE0qWFa/DADA1e76lBVKCk6vQBEi/RaGk2e7A4hLrfedGHxx9
         GLDFhcbOdTIL/JOnARl3SJ8ykWVO4aPQeXwvH4enp2jGa005JuU97aHeUk6XyQ21imqw
         mVooX0l4Lv/bGe63w6CUzkjmSl8mkvRsE2XvVT+a8Zr1ZjlDD3G16uzMmmAVFOWwE9m6
         G6AAGlMJ7MMWbs1XauzRyb7IaClHzmEulucFmzs39wreFz9njtmg8W8tCmMUh1acXjyy
         nZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUicYm0UNtmV+9tDMq9dwLdRbWtdF2pp5158XXRlVM6fx09T9rBAUkx0gFTEtgEuRMWEwHzHHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAkfBlbF4DM4YMlJbMTIyS1ZT1GyCJQl2KG0i/rWEGQqnZ5kk
	KXt/+AvRTj2gRfPmMNr3157Jbl4AhfL7freMUer2AhuR5JTdNQ7uZ0iQ/qHuEmMHp0BLq6YtbyN
	EfzH9t3yH4exv3/4qWamKysJbCm9TUqQ0t+p4bx3VK9ElyNeUjvHPbg+ed64=
X-Gm-Gg: ASbGncvA3wEYyZqbY9VFMQPGmznDSe+Mfqil8TBv8u1xMAY3ZQ2i6HqzrJ7Qq9o6Yv+
	xNGpOxpWmAd7f9sryoajR/fI8LvsPD5DY6vJ390rXdl83DR4DvkS1DjwIFd+mCsitdYERcVU+Mf
	AV5+//4md6EEgnmBGmGBPVCTfKMUzAtVKHvxc8eUase/y7atv8YlC1/bHh4xpLvAbg8JNoARDtJ
	eVOBbhcUwafm3viH5i7wYsHFSknj/TdF+bXu4gbm28a
X-Google-Smtp-Source: AGHT+IHC3044WPUDcxPUgFhPnTFccyfchQ2bDD31tj/4TNNdK/5bMRlr9lcGgqwnCDZKcS5hifiBCh8q5YTsd258e3U=
X-Received: by 2002:a17:902:c408:b0:240:a4b5:fe0d with SMTP id
 d9443c01a7336-2466f9e2d9emr7313975ad.6.1756142422705; Mon, 25 Aug 2025
 10:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com> <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
In-Reply-To: <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 25 Aug 2025 10:20:10 -0700
X-Gm-Features: Ac12FXzicvjBi05JStq7PJQXp21KsgixLwT8psAyDgla6F5C_kV-XkYI0C6IF9w
Message-ID: <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 5:03=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-08-24 17:54, Samiullah Khawaja wrote:
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
> > Currently threaded napi is only enabled at device level using sysfs. Ad=
d
> > support to enable/disable threaded mode for a napi individually. This
> > can be done using the netlink interface. Extend `napi-set` op in netlin=
k
> > spec that allows setting the `threaded` attribute of a napi.
> >
> > Extend the threaded attribute in napi struct to add an option to enable
> > continuous busy polling. Extend the netlink and sysfs interface to allo=
w
> > enabling/disabling threaded busypolling at device or individual napi
> > level.
> >
> > We use this for our AF_XDP based hard low-latency usecase with usecs
> > level latency requirement. For our usecase we want low jitter and stabl=
e
> > latency at P99.
> >
> > Following is an analysis and comparison of available (and compatible)
> > busy poll interfaces for a low latency usecase with stable P99. Please
> > note that the throughput and cpu efficiency is a non-goal.
> >
> > For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
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
> > The xdp_rr tool is posted separately as an RFC for tools/testing/selfte=
st.
> >
> > We use this tool with following napi polling configurations,
> >
> > - Interrupts only
> > - SO_BUSYPOLL (inline in the same thread where the client receives the
> >    packet).
> > - SO_BUSYPOLL (separate thread and separate core)
This one uses separate thread and core for polling the napi.
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
> > If using idpf, the script needs to be run again after launching the
> > workload just to make sure that the configurations are not reverted. As
> > idpf reverts some configurations on software reset when AF_XDP program
> > is attached.
> >
> > Once configured, the workload is run with various configurations using
> > following commands. Set period (1/frequency) and delay in usecs to
> > produce results for packet frequency and application processing delay.
> >
> >   ## Interrupt Only and SO_BUSY_POLL (inline)
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
> >   ## SO_BUSY_POLL(done in separate core using recvfrom)
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
>
> Hi Samiullah,
>
Thanks for the review
> I believe you are comparing apples and oranges with these experiments.
> Because threaded busy poll uses two cores at each end (at 100%), you
The SO_BUSYPOLL(separate) column is actually running in a separate
thread and using two cores. So this is actually comparing apples to
apples.
> should compare with 2 pairs of xsk_rr processes using interrupt mode,
> but each running at half the rate. I am quite certain you would then see
> the same latency as in the baseline experiment - at much reduced cpu
> utilization.
>
> Threaded busy poll reduces p99 latency by just 100 nsec, while
The table in the experiments show much larger differences in latency.
> busy-spinning two cores, at each end - not more not less. I continue to
> believe that this trade-off and these limited benefits need to be
> clearly and explicitly spelled out in the cover letter.
Yes, if you just look at the first row of the table then there is
virtually no difference.
>
> Best,
> Martin
>

