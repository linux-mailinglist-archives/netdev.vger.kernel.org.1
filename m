Return-Path: <netdev+bounces-176641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF6A6B2DB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBF519C3CCC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FB1C5D46;
	Fri, 21 Mar 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mgi9lnCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816A1E3793
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523326; cv=none; b=P9C/wC2o+8BGvbgy9VsEmT/HN/owxBd9kzX7tOr1qDax9g21TWL+fItdoEYgsW5TkGlupuxt1N2VgpwVcPvbB/sPYZ+4Wxf7v89pi/R8vazIAjH/t9etL98IDW20nYkEtzMypQKvQtxV2zrRUMqUUOHjSBJkickxhaNh/hCC7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523326; c=relaxed/simple;
	bh=pkOdm3LVE5bfGbqLu+M0r5NzvqaZDjVURBnY9zGQhhI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jx8CKOxI4xDQH2G496fQeA8u44yjrdEICEpoV12wQ7NTLeUBa7Wn6+ELyASCcjlICu+AUxdQ4dpq2D3rDBOySSjOMzteP4xxsQw/zlEfveemlRMMEe3XwEMJU4aHWbU8WdSYxl7UWrcOTFMuHnecCpINSOKtj4eUXnd7STk86is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mgi9lnCQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-301bbe9e084so4160954a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742523323; x=1743128123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8LyBAErTL0Hl4/3apcGMDR43mJBGBGGCQlORuO+rrUw=;
        b=Mgi9lnCQYxelcvTznJl8ilmoROVXLiu7S5s/3K+hFfnxrtKwkzGfKo9n2g1LYchKG2
         SORoDI+IdX+Blsi2AWRhl2xLYvJ5GCqKOEeKT4AXWi3i1jox97QhOY+t7vHvVPwTWT5N
         s2STzXI3M/qY7qdBjQAM7u+gpRk4sD6Dr1YKN/FxRvmgTjWEdBmJRR4HiT4SMeUpEQvl
         2KW3ki2K4kbtmYZlv3tdoVgLfvYaPbM8Vh4Va/Fa5jmfxUQU0EYZY6OO4EeSIA74AKZm
         KO/3NG2Vge2ZmvNJUzvVjeXZzlcSz5XdeWHhrd81VOo+BkAnIBq/u2RVQXJRBZEPUG31
         ERyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523323; x=1743128123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LyBAErTL0Hl4/3apcGMDR43mJBGBGGCQlORuO+rrUw=;
        b=L+4BR/MyMjYTwqe0hGZo1Vl88qAXVbxqyOVn/aWjxhRy8YVQHsqec4S76QFBSSRX82
         8fHTxK+Llk3F2k5T8ghRfkjDofQR5R8pnKRR6PXMAFrVmnQXWsH470aSNOneTs0EPXpZ
         vyEkmcxWHtJqFlX9V2UCVK7Fr1b7euExcs2SPQP5a70eKCP5wkgzPdS30v+FtyYBG/RI
         mZIIZlAeNTk2olIkOMaY64FQwaMskC+RRVbKaoIj5XQ0WJDqMH69tAz6Nb/jIqUmkacf
         VBL0OYIxjoBX8AICVBwwit0Gg8IeMjM+u1+CeF0D2wnSBvkG1hYcqO5GH9o5/nZ7bOLj
         Ltkw==
X-Gm-Message-State: AOJu0YwWFlPI6EVs6e9Pre3Nes3t38VXtsBy3rFSd2c/jSUPOA/7Nm3Y
	8ixZuN4J0DJIvPrmS1oYJpGSuCAV5cZu06U9gA78HgGOj27hAGYdDxlkppzAZV1Kq1/8Bh57d6p
	IRiNqGxeutg==
X-Google-Smtp-Source: AGHT+IFsIrdlVf8V7Ie1vnWrS+zIzsvFIAuzsBf/iNjXjnF0TuldTSwMuv4Hdsd5vpon/1lbT4VOAoSE+Rp8sg==
X-Received: from pjbpq18.prod.google.com ([2002:a17:90b:3d92:b0:2fc:1158:9fe5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4a:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-3030ff21efdmr2733328a91.33.1742523322682;
 Thu, 20 Mar 2025 19:15:22 -0700 (PDT)
Date: Fri, 21 Mar 2025 02:15:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321021521.849856-1-skhawaja@google.com>
Subject: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
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

Currently threaded napi is only enabled at device level using sysfs. Add
support to enable/disable threaded mode for a napi individually. This
can be done using the netlink interface. Extend `napi-set` op in netlink
spec that allows setting the `threaded` attribute of a napi.

Extend the threaded attribute in napi struct to add an option to enable
continuous busy polling. Extend the netlink and sysfs interface to allow
enabling/disabling threaded busypolling at device or individual napi
level.

We use this for our AF_XDP based hard low-latency usecase with usecs
level latency requirement. For our usecase we want low jitter and stable
latency at P99.

Following is an analysis and comparison of available (and compatible)
busy poll interfaces for a low latency usecase with stable P99. Please
note that the throughput and cpu efficiency is a non-goal.

For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
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

The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.

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
  echo 2 | sudo tee /sys/class/net/eth0/threaded
  NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
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

If using idpf, the script needs to be run again after launching the
workload just to make sure that the configurations are not reverted. As
idpf reverts some configurations on software reset when AF_XDP program
is attached.

Once configured, the workload is run with various configurations using
following commands. Set period (1/frequency) and delay in usecs to
produce results for packet frequency and application processing delay.

 ## Interrupt Only and SO_BUSY_POLL (inline)

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

 ## SO_BUSY_POLL(done in separate core using recvfrom)

Argument -t spawns a seprate thread and continuously calls recvfrom.

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

| Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI Threaded |
|---|---|---|---|---|
| 12K pkt/s + 0us delay | | | | |
| | p5: 14000 | p5: 13300 | p5: 13000 | p5: 12800 |
| | p50: 14200 | p50: 13700 | p50: 14000 | p50: 13100 |
| | p95: 14200 | p95: 13800 | p95: 14200 | p95: 13100 |
| | p99: 14200 | p99: 13800 | p99: 14200 | p99: 13100 |
| 125K pkt/s + 6us delay | | | | |
| | p5: 14600 | p5: 17000 | p5: 14200 | p5: 13100 |
| | p50: 15300 | p50: 17200 | p50: 14900 | p50: 13200 |
| | p95: 15500 | p95: 17500 | p95: 14900 | p95: 13200 |
| | p99: 15500 | p99: 17500 | p99: 14900 | p99: 13200 |
| 25K pkt/s + 38us delay | | | | |
| | p5: 22300 | p5: 16800 | p5: 13700 | p5: 12700 |
| | p50: 22800 | p50: 16900 | p50: 14100 | p50: 12900 |
| | p95: 22800 | p95: 17000 | p95: 14200 | p95: 12900 |
| | p99: 22800 | p99: 17100 | p99: 14200 | p99: 12900 |
| 32K pkt/s + 30us delay | | | | |
| | p5: 20000 | p5: 16600 | p5: 13900 | p5: 12900 |
| | p50: 21000 | p50: 17000 | p50: 14500 | p50: 13100 |
| | p95: 21000 | p95: 17000 | p95: 14600 | p95: 13100 |
| | p99: 21300 | p99: 17000 | p99: 14600 | p99: 13100 |
| 12Kpkt/s + 78us delay | | | | |
| | p5: 13800 | p5: 16700 | p5: 13800 | p5: 12800 |
| | p50: 14100 | p50: 17100 | p50: 14300 | p50: 13000 |
| | p95: 14100 | p95: 17100 | p95: 14500 | p90: 13000 |
| | p99: 14100 | p99: 17100 | p99: 14500 | p99: 13000 |

 ## Observations

- Here without application processing all the approaches give the same
  latency within 1usecs range and NAPI threaded gives minimum latency.
- With application processing the latency increases by 3-4usecs when
  doing inline polling.
- Using a dedicated core to drive napi polling keeps the latency same
  even with application processing. This is observed both in userspace
  and threaded napi (in kernel).
- Using napi threaded polling in kernel gives lower latency by
  1-1.5usecs as compared to userspace driven polling in separate core.
- With application processing userspace will get the packet from recv
  ring and spend some time doing application processing and then do napi
  polling. While application processing is happening a dedicated core
  doing napi polling can pull the packet of the NAPI RX queue and
  populate the AF_XDP recv ring. This means that when the application
  thread is done with application processing it has new packets ready to
  recv and process in recv ring.
- Napi threaded busy polling in the kernel with a dedicated core gives
  the consistent P5-P99 latency.

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

Samiullah Khawaja (4):
  Add support to set napi threaded for individual napi
  net: Create separate gro_flush helper function
  Extend napi threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/ABI/testing/sysfs-class-net     |   3 +-
 Documentation/netlink/specs/netdev.yaml       |  14 ++
 Documentation/networking/napi.rst             |  80 ++++++++++-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   2 +-
 include/linux/netdevice.h                     |  24 +++-
 include/uapi/linux/netdev.h                   |   7 +
 net/core/dev.c                                | 135 +++++++++++++++---
 net/core/net-sysfs.c                          |   2 +-
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |   9 ++
 tools/include/uapi/linux/netdev.h             |   7 +
 tools/testing/selftests/net/busy_poll_test.sh |  25 +++-
 tools/testing/selftests/net/busy_poller.c     |  14 +-
 16 files changed, 298 insertions(+), 35 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


