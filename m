Return-Path: <netdev+bounces-233649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3FC16C84
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CC774FA8A3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2A2D239A;
	Tue, 28 Oct 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4zagWp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB082C21C3
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683415; cv=none; b=IH0AHwr3DkamA6esdNbb0tw7dNOOyj03dEvS+OBUCs/DgBj7t4YMGEKA/8u5dg3IFbBVIIxxV6i1ccCQ1HT36qexu9Sb61YskpJ/Yla6bsgI1KgDleikkgnSi6ZWP1upS+kcXu2ALxyjj5xsq050xNI3IUDXRUniP38MafvWWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683415; c=relaxed/simple;
	bh=P2oIOr8GX6sqSANmbPHywqeRaxch6Ps8a7GGCBre+PQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DVKjGnLVg945D/X8QG1g4vQKpJLRd2kLgn/C9/5Z2IrdNF60GDChLvZwzK2uH8a77+gfxH1qaAm3koOezqb+7rGfNNXDYxPsBN3pLJOhe8ZMLgkO1gj9Jjuajtib4rdFRBUCVDRXFI8g9uAuhenP7XNraeWzRactSHXwZnFhg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4zagWp8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d8970ae47so5905529a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761683409; x=1762288209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wSibEWFR6NL1uHIIQIW4gn6GVrzBwxcD5VH5r3nlZZk=;
        b=R4zagWp8+HNJ6ytVTPqW8Y9BsCAdxCSSov8nt0t5ijPf0VPquW9mQUhocZOB27f8TO
         dVDPhoflGN47x0EhLuvPusJY+B49BcPK1M6CSCb+YorhhzCdWfwwbxvSNuYqW5lLnzdv
         G5U9rvmLcSJupM5AycTSP75tERV9T8TJSmnZWzEWOT4rDFV8LP1WnDsr5tC+AmBRcULP
         MfChGLr7Zoo0/4yLqaK9Nc3UUK8vjxYDjQv6KPqRJCptRK0im0QrOzIFUYkUPZmzKp84
         5DA0/mQSvf9LRbrrkKdO7RPutF+AjwDdebtI2hrl+1rQ6O9ER8qdqMKP5gOrVYrbP9DJ
         kzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683409; x=1762288209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSibEWFR6NL1uHIIQIW4gn6GVrzBwxcD5VH5r3nlZZk=;
        b=GmYXnUGb4YF1bpNrzy394fpDLeu3PSVYmhFcz5KYbRVOZ3LMUPVlbwbtJisrkgVcaw
         61LwazlDidQ0QjlygkQaXJ8zPFT7UzCm9EjdJH0VbHcJ0Pp0f7OPSFPq5/B0jKe88s6x
         kt+zPY7yz9C6zWn8rGwzVJdeaLPQFOYZKbjSU0VzXYP4d0EG5ZMEmIY+sAEsHxvoX9B5
         nlcBaYDi4sZQhvQrdCOBJcjWeEONX2Nqcs9IaJ3jaMYp+zsKMqcVTjsTmV1UIswQIs/N
         +QQv/AILo6k7Aq/p5Dcj3NyM4jwh65HD8BNLw9be6AEqdJxzRY/yibp8N2bdI2xOFc/4
         g5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUBWYq6J5RoRmF7RvXXIIVfgy2qJJp1+c8a/8Zc8C99cTI+jH/KMhHSkZD1lvegNtFVZ7A4Cjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7MDE+e+3uF6xJwzkdqtFh6a+516FkI15N6zoh5Xif2msTxIP
	7BZtAt6SEFLEKERk8NjRMkBugltyB6G+7HX2A14S0CK2K49cygBdmbXEU9KM9zV+ZxRmYvSdi/7
	p4liw8/6FLhiUTA==
X-Google-Smtp-Source: AGHT+IEHNX/YAFNQ7jWOfx5dJ8vSAG2HALCVrspOSiaHF+M5SHV8QBTJXF2XO0k4j+dDMFg6Ln0dlzcsYqMNCQ==
X-Received: from pjot4.prod.google.com ([2002:a17:90a:9504:b0:33b:c327:1273])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c8d:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-3403a25a759mr349080a91.2.1761683408708;
 Tue, 28 Oct 2025 13:30:08 -0700 (PDT)
Date: Tue, 28 Oct 2025 20:30:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028203007.575686-1-skhawaja@google.com>
Subject: [PATCH net-next v10 0/2] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: Joe Damato <joe@dama.to>, mkarsten@uwaterloo.ca, netdev@vger.kernel.org, 
	skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Extend the already existing support of threaded napi poll to do continuous
busy polling.

This is used for doing continuous polling of napi to fetch descriptors
from backing RX/TX queues for low latency applications. Allow enabling
of threaded busypoll using netlink so this can be enabled on a set of
dedicated napis for low latency applications.

Once enabled user can fetch the PID of the kthread doing NAPI polling
and set affinity, priority and scheduler for it depending on the
low-latency requirements.

Extend the netlink interface to allow enabling/disabling threaded
busypolling at individual napi level.

We use this for our AF_XDP based hard low-latency usecase with usecs
level latency requirement. For our usecase we want low jitter and stable
latency at P99.

Following is an analysis and comparison of available (and compatible)
busy poll interfaces for a low latency usecase with stable P99. This can
be suitable for applications that want very low latency at the expense
of cpu usage and efficiency.

Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
backing a socket, but the missing piece is a mechanism to busy poll a
NAPI instance in a dedicated thread while ignoring available events or
packets, regardless of the userspace API. Most existing mechanisms are
designed to work in a pattern where you poll until new packets or events
are received, after which userspace is expected to handle them.

As a result, one has to hack together a solution using a mechanism
intended to receive packets or events, not to simply NAPI poll. NAPI
threaded busy polling, on the other hand, provides this capability
natively, independent of any userspace API. This makes it really easy to
setup and manage.

For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
description of the tool and how it tries to simulate the real workload
is following,

- It sends UDP packets between 2 machines.
- The client machine sends packets at a fixed frequency. To maintain the
  frequency of the packet being sent, we use open-loop sampling. That is
  the packets are sent in a separate thread.
- The server replies to the packet inline by reading the pkt from the
  recv ring and replies using the tx ring.
- To simulate the application processing time, we use a configurable
  delay in usecs on the client side after a reply is received from the
  server.

The xsk_rr tool is posted separately as an RFC for tools/testing/selftest.

We use this tool with following napi polling configurations,

- Interrupts only
- SO_BUSYPOLL (inline in the same thread where the client receives the
  packet).
- SO_BUSYPOLL (separate thread and separate core)
- Threaded NAPI busypoll

System is configured using following script in all 4 cases,

```
echo 0 | sudo tee /sys/class/net/eth0/threaded
echo 0 | sudo tee /proc/sys/kernel/timer_migration
echo off | sudo tee  /sys/devices/system/cpu/smt/control

sudo ethtool -L eth0 rx 1 tx 1
sudo ethtool -G eth0 rx 1024

echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus

 # pin IRQs on CPU 2
IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
				print arr[0]}' < /proc/interrupts)"
for irq in "${IRQS}"; \
	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done

echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us

for i in /sys/devices/virtual/workqueue/*/cpumask; \
			do echo $i; echo 1,2,3,4,5,6 > $i; done

if [[ -z "$1" ]]; then
  echo 400 | sudo tee /proc/sys/net/core/busy_read
  echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
  echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
fi

sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0

if [[ "$1" == "enable_threaded" ]]; then
  echo 0 | sudo tee /proc/sys/net/core/busy_poll
  echo 0 | sudo tee /proc/sys/net/core/busy_read
  echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
  echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
  NAPI_ID=$(ynl --family netdev --output-json --do queue-get \
    --json '{"ifindex": '${IFINDEX}', "id": '0', "type": "rx"}' | jq '."napi-id"')

  ynl --family netdev --json '{"id": "'${NAPI_ID}'", "threaded": "busy-poll"}'

  NAPI_T=$(ynl --family netdev --output-json --do napi-get \
    --json '{"id": "'$NAPI_ID'"}' | jq '."pid"')

  sudo chrt -f  -p 50 $NAPI_T

  # pin threaded poll thread to CPU 2
  sudo taskset -pc 2 $NAPI_T
fi

if [[ "$1" == "enable_interrupt" ]]; then
  echo 0 | sudo tee /proc/sys/net/core/busy_read
  echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
  echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
fi
```

To enable various configurations, script can be run as following,

- Interrupt Only
  ```
  <script> enable_interrupt
  ```

- SO_BUSYPOLL (no arguments to script)
  ```
  <script>
  ```

- NAPI threaded busypoll
  ```
  <script> enable_threaded
  ```

Once configured, the workload is run with various configurations using
following commands. Set period (1/frequency) and delay in usecs to
produce results for packet frequency and application processing delay.

 ## Interrupt Only and SO_BUSYPOLL (inline)

- Server
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
```

- Client
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
```

 ## SO_BUSYPOLL(done in separate core using recvfrom)

Argument -t spawns a separate thread and continuously calls recvfrom.

- Server
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
	-h -v -t
```

- Client
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
```

 ## NAPI Threaded Busy Poll

Argument -n skips the recvfrom call as there is no recv kick needed.

- Server
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
	-h -v -n
```

- Client
```
sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
```

| Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
|---|---|---|---|---|
| 12 Kpkt/s + 0us delay | | | | |
|  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
|  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
|  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
|  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
| 32 Kpkt/s + 30us delay | | | | |
|  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
|  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
|  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
|  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
| 125 Kpkt/s + 6us delay | | | | |
|  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
|  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
|  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
|  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
| 12 Kpkt/s + 78us delay | | | | |
|  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
|  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
|  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
|  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
| 25 Kpkt/s + 38us delay | | | | |
|  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
|  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
|  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
|  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |

 ## Observations

- Here without application processing all the approaches give the same
  latency within 1usecs range and NAPI threaded gives minimum latency.
- With application processing the latency increases by 3-4usecs when
  doing inline polling.
- Using a dedicated core to drive napi polling keeps the latency same
  even with application processing. This is observed both in userspace
  and threaded napi (in kernel).
- Using napi threaded polling in kernel gives lower latency by
  1-2usecs as compared to userspace driven polling in separate core.
- Even on a dedicated core, SO_BUSYPOLL adds around 1-2usecs of latency.
  This is because it doesn't continuously busy poll until events are
  ready. Instead, it returns after polling only once, requiring the
  process to re-invoke the syscall for each poll, which requires a new
  enter/leave kernel cycle and the setup/teardown of the busy poll for
  every single poll attempt.
- With application processing userspace will get the packet from recv
  ring and spend some time doing application processing and then do napi
  polling. While application processing is happening a dedicated core
  doing napi polling can pull the packet of the NAPI RX queue and
  populate the AF_XDP recv ring. This means that when the application
  thread is done with application processing it has new packets ready to
  recv and process in recv ring.
- Napi threaded busy polling in the kernel with a dedicated core gives
  the consistent P5-P99 latency.

Note well that threaded napi busy-polling has not been shown to yield
efficiency or throughput benefits. In contrast, dedicating an entire
core to busy-polling one NAPI (NIC queue) is rather inefficient.
However, in certain specific use cases, this mechanism results in lower
packet processing latency. The experimental testing reported here only
covers those use cases and does not present a comprehensive evaluation
of threaded napi busy-polling.

Following histogram is generated to measure the time spent in recvfrom
while using inline thread with SO_BUSYPOLL. The histogram is generated
using the following bpftrace command. In this experiment there are 32K
packets per second and the application processing delay is 30usecs. This
is to measure whether there is significant time spent pulling packets
from the descriptor queue that it will affect the overall latency if
done inline.

```
bpftrace -e '
        kprobe:xsk_recvmsg {
                @start[tid] = nsecs;
        }
        kretprobe:xsk_recvmsg {
                if (@start[tid]) {
                        $sample = (nsecs - @start[tid]);
                        @xsk_recvfrom_hist = hist($sample);
                        delete(@start[tid]);
                }
        }
        END { clear(@start);}'
```

Here in case of inline busypolling around 35 percent of calls are taking
1-2usecs and around 50 percent are taking 0.5-2usecs.

@xsk_recvfrom_hist:
[128, 256)         24073 |@@@@@@@@@@@@@@@@@@@@@@                              |
[256, 512)         55633 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)          20974 |@@@@@@@@@@@@@@@@@@@                                 |
[1K, 2K)           34234 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
[2K, 4K)            3266 |@@@                                                 |
[4K, 8K)              19 |                                                    |

v10:
 - Added a note to the cover letter suggested by Martin Karsten about
   the usability of the this feature.
 - Removed the NAPI_STATE_SCHED_THREADED_BUSY_POLL and using
   NAPI_STATE_IN_BUSY_POLL to return early from napi_complete_done.
 - Fixed grammar and spelling mistakes in documentation and commit
   messages.
 - Removed the usage of unnecessary atomic operations while enabling and
   disabling busy poll.
 - Changed the NAPI threaded enum name from busy-poll-enabled to
   busy-poll.
 - Changed the order in which NAPI threaded and napi threaded busy-poll
   state bits are set.
 - Updated the Documentation to reflect the enum name change.

v9:
 - Unset NAPI_STATE_THREADED_BUSY_POLL when stopping napi kthread to
   prevent network disruption as reported by Martin Karsten.
 - Updated napi threaded busy poll enable instructions to use netlink
   instead of sysfs. This is because the sysfs mechanism to enable napi
   threaded busy poll is removed.

v8:
 - Fixed selftest build error.
 - Removed support of enabling napi busy poll at device level.
 - Updated documentation to reflect removal of busy poll at device
   level.
 - Added paragraph in the cover letter mentioning that napi threaded
   busy polling allows busy polling a NAPI natively independent of API.
 - Added paragraph in the cover letter explaining why SO_BUSYPOLL is
   still not enough when run in a dedicated core.

v7:
 - Rebased.

v6:
 - Moved threaded in struct netdevice up to fill the cacheline hole.
 - Changed dev_set_threaded to dev_set_threaded_hint and removed the
   second argument that was always set to true by all the drivers.
   Exported only dev_set_threaded_hint and made dev_set_threaded core
   only function. This change is done in a separate commit.
 - Updated documentation comment for threaded in struct netdevice.
 - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Also
   used it in kernel/bpf/cpumap.c
 - Updated documentation to explicitly state that the NAPI threaded busy
   polling would keep the CPU core busy at 100% usage.
 - Updated documentation and commit messages.

v5:
 - Updated experiment data with 'SO_PREFER_BUSY_POLL' usage as
   suggested.
 - Sent 'Add support to set napi threaded for individual napi'
   separately. This series depends on top of that patch.
   https://lore.kernel.org/netdev/20250423201413.1564527-1-skhawaja@google.com/
 - Added a separate patch to use enum for napi threaded state. Updated
   the nl_netdev python test.
 - Using "write all" semantics when napi settings set at device level.
   This aligns with already existing behaviour for other settings.
 - Fix comments to make them kdoc compatible.
 - Updated Documentation/networking/net_cachelines/net_device.rst
 - Updated the missed gro_flush modification in napi_complete_done

v4:
 - Using AF_XDP based benchmark for experiments.
 - Re-enable dev level napi threaded busypoll after soft reset.

v3:
 - Fixed calls to dev_set_threaded in drivers

v2:
 - Add documentation in napi.rst.
 - Provide experiment data and usecase details.
 - Update busy_poller selftest to include napi threaded poll testcase.
 - Define threaded mode enum in netlink interface.
 - Included NAPI threaded state in napi config to save/restore.

Samiullah Khawaja (2):
  net: Extend NAPI threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/netlink/specs/netdev.yaml       |  5 +-
 Documentation/networking/napi.rst             | 50 +++++++++++++++-
 include/linux/netdevice.h                     |  4 +-
 include/uapi/linux/netdev.h                   |  1 +
 net/core/dev.c                                | 58 +++++++++++++++----
 net/core/dev.h                                |  3 +
 net/core/netdev-genl-gen.c                    |  2 +-
 tools/include/uapi/linux/netdev.h             |  1 +
 tools/testing/selftests/net/busy_poll_test.sh | 24 +++++++-
 tools/testing/selftests/net/busy_poller.c     | 16 ++++-
 10 files changed, 145 insertions(+), 19 deletions(-)


base-commit: bfe62db5422b1a5f25752bd0877a097d436d876d
-- 
2.51.1.838.g19442a804e-goog


