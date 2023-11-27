Return-Path: <netdev+bounces-51184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A787F97AD
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 03:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A344280AB6
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 02:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15317E3;
	Mon, 27 Nov 2023 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19010F
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 18:55:47 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vx7utgD_1701053744;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vx7utgD_1701053744)
          by smtp.aliyun-inc.com;
          Mon, 27 Nov 2023 10:55:45 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
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
	xuanzhuo@linux.alibaba.com,
	yinjun.zhang@corigine.com
Subject: [PATCH net-next v5 0/4] virtio-net: support dynamic coalescing moderation
Date: Mon, 27 Nov 2023 10:55:40 +0800
Message-Id: <cover.1701050450.git.hengqi@linux.alibaba.com>
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
v4->v5:
- Patch(4/4):
   - Fix possible synchronization issues with cancel_work_sync.
   - Reduce if/else nesting levels

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

 drivers/net/virtio_net.c | 287 +++++++++++++++++++++++++++++++++------
 1 file changed, 242 insertions(+), 45 deletions(-)

-- 
2.19.1.6.gb485710b


