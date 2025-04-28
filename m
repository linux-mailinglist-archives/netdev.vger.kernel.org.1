Return-Path: <netdev+bounces-186490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20537A9F63B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E1177EC2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221F280A5E;
	Mon, 28 Apr 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpy10ugL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B527A122
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859136; cv=none; b=K0mKl1OVJTnJAuW1yGrb4AS8r8tqHZp3bBsqZs4fCV1w+ygs0G9FWWvW/lf02J4MRVSz6BTlN1eN5nmJ/cmZGP5prFiW8je545IHibnohyWeH9EFLeSXFMP8gNIvC6nmNSHmTKRjur9WKhJB6fu7XQCJHK9ud5jgXoh3UdjT+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859136; c=relaxed/simple;
	bh=0ZD9qSVQwToN8FSjq7DF0U2ZHXcZG8Gg7JWw/83gfEY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J6lDMPq0/byq3bh51MELncEedIOOEQFbIILQgQdd7/YX9WjS/oGb8LYSdtbUxIA5qzljhPdqxJSx0ye4LLJ/3uffd6eFJCvWgePCAAe0vV6cGRp3g9+r/SpNnDJVmyIb0rwg1qfINPBAfSmAscBC4WoOwbZJZAwMEM/CuiLjn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpy10ugL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so562786185a.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745859133; x=1746463933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddvgJUJeg53nZFmJicdOmV6fZH2hAdDKzwv87SgC2Rg=;
        b=gpy10ugLUyVwQGI/eYid2gnzPHgmCAXw224IzBCYtKTc+BsuUj5NpYIk1PCw42YBvY
         G7Tf5H5SgUtKVdh4ikAnWE9qA6un6MrRFY1JnKCHrUmQgV4LWrW3BujvTmbG9jPDjLvC
         1FHLW+pQIx4uV0KoRra6xvPH1PwDWjKV2WR+LrZS41EPg4MG3BJi2PDdWhkS3CsSVbGG
         RuLmSF3N6NBbwfOzcL34dj6NB77QoQDhOwZ9ITvQhkKzVFahG7tJ6/pJN0u0aIZ/sfn2
         ekT0/jHT7OmBXEHe1te+QxKesFK/+30muik12EME26JHoAU1aT4o344TPvJDAhnb2DmG
         zeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745859133; x=1746463933;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddvgJUJeg53nZFmJicdOmV6fZH2hAdDKzwv87SgC2Rg=;
        b=K7wtE9XFVshR/nzXZj8winl3yKBq6hOH0i80ki6WDPJQpnlkwsclWvny9az+ZmNp/q
         4mECqu16I8HbuldJ3TUQPLDIauXse46JyFHlB7QUUmu1NOpOhjLFDKGb7RbNp9pIDM+4
         bojXm5d0nCW/jufvrwlwWyaJDPlSiSllssd790PbH4ouUQ0rHRRWPaSTvlcAJ2x7pOHZ
         LyZvbcSpbpKt4AYAjlbmgDzNfJhJ8IOuRl3ip5mi8H7cqopAIwz9kweBosAGYG+TQsvJ
         23z9vM5eT/zObX6fREtKsNE/s+fJ6BAU3HsaQNf5xvGTj5VOn17mVPyJw4iL3Ed2Vzfg
         yuXA==
X-Gm-Message-State: AOJu0YxKe6uJJA0CKsoEHbdh16wja1sR0qmi4+QLL3BcKFXKxYE8Uogl
	djJ/d4kg6oI9MlIqi/Ap6xkXqbYxs/InwLSNuMAD7vNX/7fKU9lhbRSYjA==
X-Gm-Gg: ASbGncudrNcyb2FWrewYI3UWiH9oYhCzoWOetW9cubjGljP+p8f796jakRLBvMZoyY8
	zcJaxn6XcuO9Wh/AaJGyKPVW4IF4eEP+5v8t1t+DlL+bqfaS2xcG9g9QCIWin/uPWfvDnB8DMIJ
	JPayqPANOey2N3KShua9IPVvZHvtFIYYNgc7MkP6KVc2C3kQ/k0DO3HqUX8sIzwF6dlWolEkX4/
	IVV21XEln+KeQHXqJdkIYTC9w5eA/MHSLF1b7XguOTf3CeFeYrf+npfjfiOSbjrEkuSDzZKd/Yj
	3DIw+wZmkR3BrmEF7tJj4hGa1DPikQbfabz6H2V74xUmFzZwe5O0BAM7V15SF2OyDE9OPVsINjg
	JLmnjRbHitQ2kD9JSBKsq
X-Google-Smtp-Source: AGHT+IHpyQMPL27H6J6fxMvFhCQv4orE6B/NdZmB6t8szlsd329s3a4mgaGBuxMAgc801zADFQt1+Q==
X-Received: by 2002:a05:620a:3727:b0:7c5:4673:a224 with SMTP id af79cd13be357-7c9607ac4e5mr2115000285a.50.1745859132727;
        Mon, 28 Apr 2025 09:52:12 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958e7c001sm640695285a.82.2025.04.28.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:52:12 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:52:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com, 
 jdamato@fastly.com
Cc: netdev@vger.kernel.org
Message-ID: <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
In-Reply-To: <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin Karsten wrote:
> On 2025-04-24 16:02, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continuous
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
> > Currently threaded napi is only enabled at device level using sysfs. Add
> > support to enable/disable threaded mode for a napi individually. This
> > can be done using the netlink interface. Extend `napi-set` op in netlink
> > spec that allows setting the `threaded` attribute of a napi.
> > 
> > Extend the threaded attribute in napi struct to add an option to enable
> > continuous busy polling. Extend the netlink and sysfs interface to allow
> > enabling/disabling threaded busypolling at device or individual napi
> > level.
> > 
> > We use this for our AF_XDP based hard low-latency usecase with usecs
> > level latency requirement. For our usecase we want low jitter and stable
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
> > - The client machine sends packets at a fixed frequency. To maintain the
> >    frequency of the packet being sent, we use open-loop sampling. That is
> >    the packets are sent in a separate thread.
> > - The server replies to the packet inline by reading the pkt from the
> >    recv ring and replies using the tx ring.
> > - To simulate the application processing time, we use a configurable
> >    delay in usecs on the client side after a reply is received from the
> >    server.
> > 
> > The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
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
> > IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> > 				print arr[0]}' < /proc/interrupts)"
> > for irq in "${IRQS}"; \
> > 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> > 
> > echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> > 
> > for i in /sys/devices/virtual/workqueue/*/cpumask; \
> > 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> > 
> > if [[ -z "$1" ]]; then
> >    echo 400 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > fi
> > 
> > sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> > 
> > if [[ "$1" == "enable_threaded" ]]; then
> >    echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >    echo 0 | sudo tee /proc/sys/net/core/busy_read
> >    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >    echo 2 | sudo tee /sys/class/net/eth0/threaded
> >    NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
> >    sudo chrt -f  -p 50 $NAPI_T
> > 
> >    # pin threaded poll thread to CPU 2
> >    sudo taskset -pc 2 $NAPI_T
> > fi
> > 
> > if [[ "$1" == "enable_interrupt" ]]; then
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
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> > ```
> > 
> >   ## SO_BUSY_POLL(done in separate core using recvfrom)
> > 
> > Argument -t spawns a seprate thread and continuously calls recvfrom.
> > 
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> > 	-h -v -t
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> > ```
> > 
> >   ## NAPI Threaded Busy Poll
> > 
> > Argument -n skips the recvfrom call as there is no recv kick needed.
> > 
> > - Server
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> > 	-h -v -n
> > ```
> > 
> > - Client
> > ```
> > sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> > 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> > 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> > ```
> > 
> > | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
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
> >    1-1.5usecs as compared to userspace driven polling in separate core.
> > - With application processing userspace will get the packet from recv
> >    ring and spend some time doing application processing and then do napi
> >    polling. While application processing is happening a dedicated core
> >    doing napi polling can pull the packet of the NAPI RX queue and
> >    populate the AF_XDP recv ring. This means that when the application
> >    thread is done with application processing it has new packets ready to
> >    recv and process in recv ring.
> > - Napi threaded busy polling in the kernel with a dedicated core gives
> >    the consistent P5-P99 latency.
> I've experimented with this some more. I can confirm latency savings of 
> about 1 usec arising from busy-looping a NAPI thread on a dedicated core 
> when compared to in-thread busy-polling. A few more comments:
> 
> 1) I note that the experiment results above show that 'interrupts' is 
> almost as fast as 'NAPI threaded' in the base case. I cannot confirm 
> these results, because I currently only have (very) old hardware 
> available for testing. However, these results worry me in terms of 
> necessity of the threaded busy-polling mechanism - also see Item 4) below.
> 
> 2) The experiments reported here are symmetric in that they use the same 
> polling variant at both the client and the server. When mixing things up 
> by combining different polling variants, it becomes clear that the 
> latency savings are split between both ends. The total savings of 1 usec 
> are thus a combination of 0.5 usec are either end. So the ultimate 
> trade-off is 0.5 usec latency gain for burning 1 core.
> 
> 3) I believe the savings arise from running two tight loops (separate 
> NAPI and application) instead of one longer loop. The shorter loops 
> likely result in better cache utilization on their respective dedicated 
> cores (and L1 caches). However I am not sure right how to explicitly 
> confirm this.
> 
> 4) I still believe that the additional experiments with setting both 
> delay and period are meaningless. They create corner cases where rate * 
> delay is about 1. Nobody would run a latency-critical system at 100% 
> load. I also note that the experiment program xsk_rr fails when trying 
> to increase the load beyond saturation (client fails with 'xsk_rr: 
> oustanding array full').
> 
> 5) I worry that a mechanism like this might be misinterpreted as some 
> kind of magic wand for improving performance and might end up being used 
> in practice and cause substantial overhead without much gain. If 
> accepted, I would hope that this will be documented very clearly and 
> have appropriate warnings attached. Given that the patch cover letter is 
> often used as a basis for documentation, I believe this should be 
> spelled out in the cover letter.
> 
> With the above in mind, someone else will need to judge whether (at 
> most) 0.5 usec for burning a core is a worthy enough trade-off to 
> justify inclusion of this mechanism. Maybe someone else can take a 
> closer look at the 'interrupts' variant on modern hardware.

Ack on documentation of the pros/cons.

There is also a functional argument for this feature. It brings
parity with userspace network stacks like DPDK and Google's SNAP [1].
These also run packet (and L4+) network processing on dedicated cores,
and by default do so in polling mode. An XDP plane currently lacks
this well understood configuration. This brings it closer to parity.

Users of such advanced environments can be expected to be well
familiar with the cost of polling. The cost/benefit can be debated
and benchmarked for individual applications. But there clearly are
active uses for polling, so I think it should be an operating system
facility.

[1] https://research.google/pubs/snap-a-microkernel-approach-to-host-networking/

