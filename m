Return-Path: <netdev+bounces-185720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B555A9B8B4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5744E17F109
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C71E98E0;
	Thu, 24 Apr 2025 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUbCp2aq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDD1E8837
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524946; cv=none; b=KU10LKFBsUSSjJ3y/JDt67rIgfKE8+eYELTPM7O9NA1UTfqq5yU7QR7W/qO/1B8B5EiicbXtEfWJM9dxVqQPV4pfUXS6Ayw0exkDqsS+larFUjk0NwbQ1kKeoIEXjZpsiCZteooaLBhFLmbeQVAEXrg/1j2+nc2BVgZO+qY+XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524946; c=relaxed/simple;
	bh=/fgtOE5ynXviqm9MKFV+uE789F+qbv9CXSQIZmSPVkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CYiTPRVhnBnNpsVgZszN3ssvVHmdK9Jqxo5FCGIlQbGlGP9gSAZ1IGor3y7tviPolbVYs6NREZRv4AgbatdkateeZUHTYvh5v3EYZJxYZfMLsKnH13PKQaqIdkGeHxQe5pfJu23zVp9Da7qmIQkszVX3qgBqaizsJXdnL8sK65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUbCp2aq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7369c5ed395so1493659b3a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524943; x=1746129743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/j6qDUCSodRxM7o32g4JnZg2Q8JLOAEvPQp+KmuUzE=;
        b=UUbCp2aqFBWfE9PEnfip9YwOLhnBeaNRKSup53c6+O8nYyib7CCAPL3cuxuDsLYJ3E
         eEGusBwQYBeMQTK38o0AJAktn1ZsRl/u52C/jillMfUNmQCbReui5EOeaVY66QnG9Vte
         udciziCc6DFaBssfpT78/RsN48P1xt1eC2HPxJhrolO5T7pNxBQhSck/gfDQAGeJ65w4
         1eoEkVice12Rh0sEruxaFidqnsTyz3vkCiG2yTB+dUyBmbhNJ2GWUKqCvylqDLVlj0+U
         hzhXrYt20R/Krs/WCyAP0+NSmWMcybO9oCphSp+TbyEFT43RHm8M5h7zvvlUAs8yDtap
         JC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524943; x=1746129743;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/j6qDUCSodRxM7o32g4JnZg2Q8JLOAEvPQp+KmuUzE=;
        b=XrJHQ+X9oBF3H0w2qIOewoVcDSfdjaqGUaCfMAXZAnOwUxAbaufcc+1T+UN3h4M1x5
         4cHFD5aL3Kbph+z/ewQSAry1xN5iydmZAq/Cvv00Ipe7XkayQkOa46JB6H9sIrFB1irF
         gk/r1X5OJp5SHdVbM0Bbk7IWGHBvdYNxJE7EKBoEv7I6KTG5TY/DSVy9LYhCujPvqFrG
         haCfGIYPtzowVmcV82NVQiV15jRFObrc5uJl5kEnmvB66oz3bDx/UW4XBWwxm/eCtFN8
         76IFMD2z/jNRwYR+ihYxF95LjrCIfdtWAM7PnBuX//bmqaaxx5bPuEArLAu1UrD0VRK2
         IhgA==
X-Gm-Message-State: AOJu0YwiI0SMFSWm3Gx854bNWnglyLjuz/nFsDV0OxySz70bgahaRCYW
	AATtWXqAzomgphWESMLZLZHNs5wgeoxQYcXDhGTJnKopITIvTQrXd1Ic9giF2wgv6i2QKMNa/I0
	N5b0po7RO/A==
X-Google-Smtp-Source: AGHT+IEy408+YmvpYelHsgH4GClYrT1U52HgU2/3xTZSCvsar6MzPMZ0pjrJ/sXSZL3VsRXker78fHKabRSHyA==
X-Received: from pfna17.prod.google.com ([2002:aa7:80d1:0:b0:73d:65cb:b18b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:e16:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-73e32fbb020mr1190930b3a.1.1745524943471;
 Thu, 24 Apr 2025 13:02:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:02:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424200222.2602990-1-skhawaja@google.com>
Subject: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
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

Samiullah Khawaja (4):
  net: Create separate gro_flush helper function
  net: define an enum for the napi threaded state
  Extend napi threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/ABI/testing/sysfs-class-net     |   3 +-
 Documentation/netlink/specs/netdev.yaml       |  14 ++-
 Documentation/networking/napi.rst             |  67 ++++++++++-
 .../networking/net_cachelines/net_device.rst  |   2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   2 +-
 include/linux/netdevice.h                     |  15 ++-
 include/uapi/linux/netdev.h                   |   6 +
 net/core/dev.c                                | 110 ++++++++++++++----
 net/core/dev.h                                |  15 ++-
 net/core/net-sysfs.c                          |   2 +-
 net/core/netdev-genl-gen.c                    |   2 +-
 net/core/netdev-genl.c                        |   4 +-
 tools/include/uapi/linux/netdev.h             |   6 +
 tools/testing/selftests/net/busy_poll_test.sh |  25 +++-
 tools/testing/selftests/net/busy_poller.c     |  14 ++-
 tools/testing/selftests/net/nl_netdev.py      |  28 ++---
 19 files changed, 259 insertions(+), 62 deletions(-)


base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
prerequisite-patch-id: 776deffc3e807688dc224901adcb183fc59ea9d1
-- 
2.49.0.850.g28803427d3-goog


