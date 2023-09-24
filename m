Return-Path: <netdev+bounces-36026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CB7ACA3D
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 506011C203DC
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94277D284;
	Sun, 24 Sep 2023 15:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F46D275
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:17:07 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E3B8;
	Sun, 24 Sep 2023 08:17:03 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vsir3vX_1695568613;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vsir3vX_1695568613)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:16:59 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wintera@linux.ibm.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/18] net/smc: implement virtual ISM extension and loopback-ism
Date: Sun, 24 Sep 2023 23:16:35 +0800
Message-Id: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hi, all

# Background

SMC-D is now used in IBM z with ISM function to optimize network interconnect
for intra-CPC communications. Inspired by this, we try to make SMC-D available
on the non-s390 architecture through a software-simulated virtual ISM device,
such as loopback-ism device here, to accelerate inter-process or inter-containers
communication within the same OS.

# Design

This patch set includes 4 parts:

 - Patch #1-#3: decouple ISM device hard code from SMC-D stack.
 - Patch #4-#8: implement virtual ISM extension defined in SMCv2.1.
 - Patch #9-#13: implement loopback-ism device.
 - Patch #14-#18: memory copy optimization for the case using loopback.

The loopback-ism device is designed as a kernel device and not be limited to
a specific net namespace, ends of both inter-process connection (1/1' in diagram
below) or inter-container connection (2/2' in diagram below) will find that peer
shares the same loopback-ism device during the CLC handshake. Then loopback-ism
device will be chosen.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+      +-------+      +-------+ |    |        +-------+        |
 | | App A |      | App B |      | App C | |    |        | App D |<-+     |
 | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
 |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
 |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
 |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
 +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
              |   |           |                                  |
 Kernel       |   |           |                                  |
 +----+-------v---+-----------v----------------------------------+---+----+
 |    |                            TCP                               |    |
 |    |                                                              |    |
 |    +--------------------------------------------------------------+    |
 |                                                                        |
 |                           +--------------+                             |
 |                           | smc loopback |                             |
 +---------------------------+--------------+-----------------------------+


loopback-ism device allocs RMBs and sndbufs for each connection peer and 'moves'
data from sndbuf at one end to RMB at the other end. Since communication occurs
within the same kernel, the sndbuf can be mapped to peer RMB so that the data
copy in loopback-ism case can be avoided.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+      +-------+      +-------+ |    |        +-------+        |
 | | App A |      | App B |      | App C | |    |        | App D |        |
 | +-------+      +--^----+      +-------+ |    |        +---^---+        |
 |       |           |               |     |    |            |            |
 |   (1) |      (1') |           (2) |     |    |       (2') |            |
 |       |           |               |     |    |            |            |
 +-------|-----------|---------------|-----+    +------------|------------+
         |           |               |                       |
 Kernel  |           |               |                       |
 +-------|-----------|---------------|-----------------------|------------+
 | +-----v-+      +-------+      +---v---+               +-------+        |
 | | snd A |-+    | RMB B |<--+  | snd C |-+          +->| RMB D |        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 | | RMB A | |    | snd B |   |  | RMB C | |          |  | snd D |        |
 | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
 |           |               +-------------v+         |                   |
 |           +-------------->| smc loopback |---------+                   |
 +---------------------------+--------------+-----------------------------+

# Benchmark Test

 * Test environments:
      - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
      - SMC sndbuf/RMB size 1MB.

 * Test object:
      - TCP: run on TCP loopback.
      - domain: run on UNIX domain.
      - SMC lo: run on SMC loopback device.

1. ipc-benchmark (see [1])

 - ./<foo> -c 1000000 -s 100

                            TCP                  SMC-lo
Message
rate (msg/s)              81539                  151251(+85.50%)

2. sockperf

 - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
 - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30

                            TCP                  SMC-lo
Bandwidth(MBps)         5313.66                 8270.51(+55.65%)
Latency(us)               5.806                   3.207(-44.76%)

3. nginx/wrk

 - serv: <smc_run> nginx
 - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80

                           TCP                   SMC-lo
Requests/s           194641.79                258656.13(+32.89%)

4. redis-benchmark

 - serv: <smc_run> redis-server
 - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024

                           TCP                   SMC-lo
GET(Requests/s)       85855.34                115640.35(+34.69%)
SET(Requests/s)       86337.15                118203.30(+36.90%)

[1] https://github.com/goldsborough/ipc-bench

v3->v4:
 - Fix build warning of patch#12 about:
   dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
 - Replace kzalloc with vzalloc to alloc DMB in loopback-ism, which
   may cause throughput or QPS to drop by 2% to 8%. see:
   https://lore.kernel.org/netdev/d6facfd5-e083-ffc7-05e5-2e8f3ef17735@linux.alibaba.com/
 - Add SMC_LO in Kconfig to turn on/off loopback-ism.
 - Make extension GID cleaner.

v2->v3:
 - Fix build warning of patch#1 and patch#10.

v1->v2:
 - Fix build error on s390 arch.

Wen Gu (18):
  net/smc: decouple ism_dev from SMC-D device dump
  net/smc: decouple ism_dev from SMC-D DMB registration
  net/smc: extract v2 check helper from SMC-D device registration
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: reserve CHID range for SMC-D virtual device
  net/smc: extend GID to 128bits only for virtual ISM device
  net/smc: disable SEID on non-s390 architecture
  net/smc: enable virtual ISM device feature bit
  net/smc: introduce SMC-D loopback device
  net/smc: implement ID-related operations of loopback
  net/smc: implement some unsupported operations of loopback
  net/smc: implement DMB-related operations of loopback
  net/smc: register loopback device as SMC-Dv2 device
  net/smc: add operation for getting DMB attribute
  net/smc: add operations for DMB attach and detach
  net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
  net/smc: modify cursor update logic when sndbuf mapped to RMB
  net/smc: add interface implementation of loopback device

 drivers/s390/net/ism_drv.c    |  20 +-
 include/net/smc.h             |  32 ++-
 include/uapi/linux/smc.h      |   3 +
 include/uapi/linux/smc_diag.h |   2 +
 net/smc/Kconfig               |  13 ++
 net/smc/Makefile              |   2 +-
 net/smc/af_smc.c              |  88 ++++++--
 net/smc/smc.h                 |   7 +
 net/smc/smc_cdc.c             |  56 ++++-
 net/smc/smc_cdc.h             |   1 +
 net/smc/smc_clc.c             |  64 ++++--
 net/smc/smc_clc.h             |  10 +-
 net/smc/smc_core.c            | 111 +++++++++-
 net/smc/smc_core.h            |   9 +-
 net/smc/smc_diag.c            |  11 +-
 net/smc/smc_ism.c             | 100 ++++++---
 net/smc/smc_ism.h             |  24 ++-
 net/smc/smc_loopback.c        | 489 ++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h        |  54 +++++
 net/smc/smc_pnet.c            |   4 +-
 20 files changed, 996 insertions(+), 104 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

-- 
1.8.3.1


