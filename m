Return-Path: <netdev+bounces-47609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58977EAA51
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F497280F49
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C6D30B;
	Tue, 14 Nov 2023 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE483D2E1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:55:52 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A35E1BC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:55:50 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwOPCfB_1699941347;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwOPCfB_1699941347)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 13:55:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v3 0/5] virtio-net: support dynamic coalescing moderation
Date: Tue, 14 Nov 2023 13:55:42 +0800
Message-Id: <cover.1699938946.git.hengqi@linux.alibaba.com>
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
v2->v3:
- Patch(4/5): some minor modifications.

v1->v2:
- Patch(2/5): a minor fix.
- Patch(4/5):
   - improve the judgment of dim switch conditions.
   - fix safe problem of work thread.
- Patch(5/5): drop the tx dim implementation.


Heng Qi (5):
  virtio-net: returns whether napi is complete
  virtio-net: separate rx/tx coalescing moderation cmds
  virtio-net: extract virtqueue coalescig cmd for reuse
  virtio-net: support rx netdim
  virtio-net: return -EOPNOTSUPP for adaptive-tx

 drivers/net/virtio_net.c | 335 ++++++++++++++++++++++++++++++++-------
 1 file changed, 278 insertions(+), 57 deletions(-)

-- 
2.19.1.6.gb485710b


