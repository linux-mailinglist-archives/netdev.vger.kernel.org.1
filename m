Return-Path: <netdev+bounces-49221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9937F1379
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF041C217CE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33701101F3;
	Mon, 20 Nov 2023 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44927D2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:37:38 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwoRDEI_1700483854;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwoRDEI_1700483854)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 20:37:36 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v4 0/4] virtio-net: support dynamic coalescing moderation
Date: Mon, 20 Nov 2023 20:37:30 +0800
Message-Id: <cover.1700478183.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, virtio-net already supports per-queue moderation parameter
setting. Based on this, we use the linux dimlib to support
dynamic coalescing moderation for virtio-net.

Due to some scheduling issues, we only support and test the rx dim.

Some test results:

I. Sockperf UDP
=================================================
1. Env
rxq_0 with affinity to cpu_0.

2. Cmd
client: taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
server: taskset -c 0 sockperf sr -p 8989

3. Result
dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
dim on:  1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
=================================================

II. Redis
=================================================
1. Env
There are 8 rxqs, and rxq_i with affinity to cpu_i.

2. Result
When all cpus are 100%, ops/sec of memtier_benchmark client is
dim off:  978437.23
dim on:  1143638.28
=================================================

III. Nginx
=================================================
1. Env
There are 8 rxqs and rxq_i with affinity to cpu_i.

2. Result
When all cpus are 100%, requests/sec of wrk client is
dim off:  877931.67
dim on:  1019160.31
=================================================

IV. Latency of sockperf udp
=================================================
1. Rx cmd
taskset -c 0 sockperf sr -p 8989

2. Tx cmd
taskset -c 0 sockperf pp -i ${ip} -p 8989 -t 10

After running this cmd 5 times and averaging the results,

3. Result
dim off: 17.7735 usec
dim on:  18.0110 usec
=================================================

Changelog:
v3->v4:
- Patch(5/5): drop.

v2->v3:
- Patch(4/5): some minor modifications.

v1->v2:
- Patch(2/5): a minor fix.
- Patch(4/5):
   - improve the judgment of dim switch conditions.
   - Cancel the work when vq reset. 
- Patch(5/5): drop the tx dim implementation.

Heng Qi (4):
  virtio-net: returns whether napi is complete
  virtio-net: separate rx/tx coalescing moderation cmds
  virtio-net: extract virtqueue coalescig cmd for reuse
  virtio-net: support rx netdim

 drivers/net/virtio_net.c | 312 ++++++++++++++++++++++++++++++++-------
 1 file changed, 255 insertions(+), 57 deletions(-)

-- 
2.19.1.6.gb485710b


