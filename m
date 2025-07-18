Return-Path: <netdev+bounces-208268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D415B0AC84
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D914AAC26A2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0781222597;
	Fri, 18 Jul 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reuEUNbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89110957
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880855; cv=none; b=QzgJbVPXC0OMqGIudSZYtBsU7zVWhmqHZk+vj/8oKKh/EA6LHLrZz7o+4PQd9ZXxaswWhDS0vVEgsN3WmL5m9jh3T/PNnYpWIty3mkJP/B31eiJ8XMQLJhkgsiT/0plXFmzVmBUoi07XBgpIdCVGbBq1YYUOUxrTinYgioZD6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880855; c=relaxed/simple;
	bh=V6LljWATe0O+RDDe5lXPtf2bbAnYmrzuq8xSeGDW1AI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kG5grhCMmDtz4+bdbT117eIPBvNMilWX7WEeA/IjEgXu1v24OBXX1uNbMjMfOKjJ5Pj1sW5dEdH/ZPxUTWfYx5VQVDxhNybDtp47RQBVbL07F7HjUxN6r++NWks8MgerKgFhoAyws4AemwLQWs2d2qkKlNzHTCojw+CezWNSo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reuEUNbT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756bb07b029so2417600b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752880853; x=1753485653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1jQl7NPDOTTD0DDwQdmHKDPLhs5ix1600DeSyRaY5I=;
        b=reuEUNbTKRijcCp+1XjpPVyOUAIOFYdotuKXa41cqGWwOx1wonAaxmvIbur98aQr0k
         iYQrA98IfkJr455lhY1S0vmh6KU69ALWAhiX7I+Ip4Ens5ixkchgqRBe+dF7xjIPnaoG
         pRtX9400W2+wTz56O7TyX3vsQMHsK2V+n4dpUOmaSdGn1Cl1Ryg/js1b2iyLGIJobfyZ
         AJ/tEL2uuNok1kDV2Gz9uSX3s8715Fk+I7c3dxq+muYK+VXNtpES1P8khRthFkqqfalr
         6uqt3DdKSWwOu6noDwN/a0aufqlPF2z7dtL/lQjm/SF/2aB1W/1te68d71pFKi2Iky6y
         Uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880853; x=1753485653;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1jQl7NPDOTTD0DDwQdmHKDPLhs5ix1600DeSyRaY5I=;
        b=p/vFHRKxiquiCg4DYITSVlAWQwQDAPkzhJH3qW1lOwaq1GSMbr3BhTnqfsLieUALJx
         s0TuibiiJiTFq52HEvO9vZrr35zCGixTJbHjPzxcn3eDYFnpB6+MmmNRFYw0dwS+jeo6
         81K+SDK/ki3OOVPFw+imJag3Aa1SFsw4JS/bj1hG+Q6E0gv65x1GNveUpnzW9fqbmq5o
         EaCL3NSQG71cJZFdnt2WihGvtO/+M/wlQmrQVYLa7ZhkO6+zPGi/n4F+kHl6S2L/hSNS
         L3Z0jmsT2wOKFHvHxaaydLAXDE3gecnrkVBB/IxGx/bcyqXcAj6ONVwMs4g3AqTFYdBQ
         i1oQ==
X-Gm-Message-State: AOJu0Yzp+h6dXDU5ggDj8k3MG8A4Z++YzhhG8aRk1eYcPFXp/xX+78To
	sfaRtpNYgoApFi30sucLYx3S3gQiyPEYHNGGZ5oUiwg/DzStqo6KAI7AJKK3hYkji6GaHi3RJG/
	zCfwqnHFZSdnt+w==
X-Google-Smtp-Source: AGHT+IFY8RNhfRWTMQ7jiDdIb3Mp+o7kytqy+fPI8/2Wjg+MmfqlfmG8o+3rOc9r/2FvwfYwFoJjwI99ABMzUw==
X-Received: from pfbjo35.prod.google.com ([2002:a05:6a00:90a3:b0:748:d81f:a79e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2384:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-75725088c14mr14900218b3a.22.1752880853338;
 Fri, 18 Jul 2025 16:20:53 -0700 (PDT)
Date: Fri, 18 Jul 2025 23:20:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718232052.1266188-1-skhawaja@google.com>
Subject: [PATCH net-next v6 0/5] Add support to do threaded napi busy poll
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

Samiullah Khawaja (5):
  net: Create separate gro_flush_normal function
  net: Use dev_set_threaded_hint instead of dev_set_threaded in drivers
  net: define an enum for the napi threaded state
  Extend napi threaded polling to allow kthread based busy polling
  selftests: Add napi threaded busy poll test in `busy_poller`

 Documentation/ABI/testing/sysfs-class-net     |  3 +-
 Documentation/netlink/specs/netdev.yaml       | 14 ++-
 Documentation/networking/napi.rst             | 63 +++++++++++-
 .../networking/net_cachelines/net_device.rst  |  2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c  |  2 +-
 include/linux/netdevice.h                     | 18 +++-
 include/net/gro.h                             |  6 ++
 include/uapi/linux/netdev.h                   |  6 ++
 kernel/bpf/cpumap.c                           |  3 +-
 net/core/dev.c                                | 97 +++++++++++++++----
 net/core/dev.h                                | 16 ++-
 net/core/net-sysfs.c                          |  2 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  2 +-
 tools/include/uapi/linux/netdev.h             |  6 ++
 tools/testing/selftests/net/busy_poll_test.sh | 25 ++++-
 tools/testing/selftests/net/busy_poller.c     | 14 ++-
 tools/testing/selftests/net/nl_netdev.py      | 36 +++----
 23 files changed, 257 insertions(+), 70 deletions(-)


base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70
-- 
2.50.0.727.gbf7dc18ff4-goog


