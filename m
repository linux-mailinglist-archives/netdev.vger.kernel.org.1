Return-Path: <netdev+bounces-216332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14877B332E3
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 23:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD031B21E2C
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75C221264;
	Sun, 24 Aug 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2f1/zR0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F0188580
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756072463; cv=none; b=WoW1pVMoBToMTnyVDiUn54jdZ16dC7uvmv6o5CnZS7qOJ1xSAg4MRU0yb1f8k5yU/YGnFcXHeLTdVB51kBz3iNeDhjA+INg8/kmviVR4NOlyNpkAUyiFqWfxAtAivUzyMTKpl1KXYfS+arrqYuLiSRhV/iQjn6l/bikGW4UxY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756072463; c=relaxed/simple;
	bh=dMrGo6QiK49JNr8WKvhliAJMned7TSy+xW2ywFZxGK8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kx20P+cTB7YBCPbd+x9hWKDtRal8LL8fhbu06pK0sRkix6IE9zUAc5jTIODFJKaawaYDSlj/3VZCKmXtLpEnm6xHFuHcbwPS7DssJq4s7nMgKO0bM019oPjk0vQ5NMg9+/31mUZAfmlINncJZV5Wa4ago7hHTQmYxfrmqINQLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2f1/zR0T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so38265095ad.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756072460; x=1756677260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CXvXXToAG4aU4mSeQyRDJSdFn0iV+aTCHrQl/V0W970=;
        b=2f1/zR0TbvlnJCYeBoB15SWJWbjqyLZEcMTB8h5Q14edvTchC/qwnU0PSF7cW9e5DN
         KkwP3cGP2qiC5rCtkXjbPMzvTPFML78fp3iFU6BR+dhrdpSEUhcRuDIX8ZotmfvnkKxS
         EYCd3EC6yWFbihslZApzi6MsPreugZmY/WGgEbh8sTtynVnE1TygqgE46F/f341J2oAJ
         XdsJdzwaRwB75/Aga+bxYoB/N/TbXECuO0wGGP5WesOgEX8FCbZFGsuezbdiFd/vBICy
         lH6XR0BwrT+mav8Fbnll1TIfVqpRgM8akvC06CE6NyvRzORd/hu6/NoK1J62nqu6K1oS
         EdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756072460; x=1756677260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXvXXToAG4aU4mSeQyRDJSdFn0iV+aTCHrQl/V0W970=;
        b=DHkd3gIKBYWCBTwsyw3SnnYPCSAhSuuALaOo/O2IoKxWfv7m1oVT1WYrPEGzKFcF67
         81plf2Qi32LwP/G3I308FvDVc6s2z+V0oVSHxMc+xUKOQ7B5ofBhvTSW61uMUHfl331U
         2Zxdfq4OXv0gP5vetHahzLApxY0NV3Ron0G2dT/UfR/RjPAF/nIK+w6SzHDujG13oF3M
         hLn0kI/h963erg27LHQ3E3iDEJjGphM6MB4OZTxvtAeda09pipUjS6JvLj/V2MRvF8DB
         GTJKAulKBGcaRER3qV3P1Mu9r+7Tr26MFMPGU1eWl8hCxUekpi1XDWhOBiZiwjmm5iZI
         4toQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrp7Z/dLkaLDQRNPMdXZj7tdPlbSpOBHzwNLyt0k7biiBV+r1ktBnBwGwJnQRdcNRoXq9gQ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhhSLMEp9QR0mHjdOAH4ATQbR6R+Ir9FXQ0BheO0mB+UUTsSO
	f5Qjb4gEIMHpm6Oi5oBuF1KWxw0Ccn8QHb/ty7CPdrkmhuzRk/skipdyz4Wrwr166UglZJXswrb
	Ar4mwuokzP8AJ3A==
X-Google-Smtp-Source: AGHT+IGuvbHY8hHC4Hrd3g9hx1GjLnQiu2+EL1vn/ND9iRqrIvioPdEhDJDVa/zoZD4eDW8InIseeHK4xT7dVw==
X-Received: from plzt4.prod.google.com ([2002:a17:902:bc44:b0:246:22da:b381])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:246:b0:240:49d1:6347 with SMTP id d9443c01a7336-2462ef1f2e0mr128686445ad.35.1756072459838;
 Sun, 24 Aug 2025 14:54:19 -0700 (PDT)
Date: Sun, 24 Aug 2025 21:54:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250824215418.257588-1-skhawaja@google.com>
Subject: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, skhawaja@google.com
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
  Extend napi threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/ABI/testing/sysfs-class-net     |  3 +-
 Documentation/netlink/specs/netdev.yaml       |  5 +-
 Documentation/networking/napi.rst             | 63 +++++++++++++++++-
 include/linux/netdevice.h                     | 11 +++-
 include/uapi/linux/netdev.h                   |  1 +
 net/core/dev.c                                | 66 ++++++++++++++++---
 net/core/dev.h                                |  3 +
 net/core/net-sysfs.c                          |  2 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 tools/include/uapi/linux/netdev.h             |  1 +
 tools/testing/selftests/net/busy_poll_test.sh | 25 ++++++-
 tools/testing/selftests/net/busy_poller.c     | 14 +++-
 12 files changed, 177 insertions(+), 19 deletions(-)


base-commit: c3199adbe4ffffc7b6536715e0290d1919a45cd9
-- 
2.51.0.rc1.193.gad69d77794-goog


