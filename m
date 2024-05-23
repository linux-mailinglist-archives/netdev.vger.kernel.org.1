Return-Path: <netdev+bounces-97709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10898CCD43
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41B81C21BB8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF013A3E3;
	Thu, 23 May 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OG4GMW0u"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8912B159
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450421; cv=none; b=qVvBATW0gipW7jvYV8Ht1xZopct/EraeqMKPBf+JK7p7sT32Kd/GdzJtmcqXi11tJQDNmHcbcS1csBjjaN3qBwu27Au+sJ4LNu5Kdshf4iJ5nJRWutZOGKmXLJr+/+pklizXhXPU9F0VX/EXkF6k6vE4Mnylnv5W6x0f6lGG3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450421; c=relaxed/simple;
	bh=ViCfC/aEr7LkwGVtL8udMIEau4rxhm9JR7gzOGu9R8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igtijEigPH6Mnutwy2RvaFDITNwwPPuJYvWuOPYhltD0wFBJugCrQ21zyw8moa4uX9jCV4lJu/giBtTnmcIoiM4eliHJ1bgKKZSEaqvio+JK9CIerpTRh2pEz5Ptu4YNCRY/YrxbMw1zU5yi5Qj4PWZqDDQDQjGRs0ky5Qx6eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OG4GMW0u; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716450416; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mMUtysGWEDFdr0WcjaLT+HbaZU1uDgJoKQXdj7db1b8=;
	b=OG4GMW0uR6t+F+L8ISd/swfxWJPJuKqcczaqIrALzkgLeX/O2tD6j5BvOwgOSnBPh88+4etyERWCe9MviKK82BtHCF1yGCqbDhro2rB6FUxWcpQbmhlmtUu0Z8AKpjREdcgX4wodRvSdLnsbQfVmx8COS1EZhhelBwqGlpjLX+o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W71ys6r_1716450414;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W71ys6r_1716450414)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 15:46:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue RX coalesce"
Date: Thu, 23 May 2024 15:46:51 +0800
Message-Id: <20240523074651.3717-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240523074651.3717-1-hengqi@linux.alibaba.com>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.

When the following snippet is run, lockdep will report a deadlock[1].

  /* Acquire all queues dim_locks */
  for (i = 0; i < vi->max_queue_pairs; i++)
          mutex_lock(&vi->rq[i].dim_lock);

There's no deadlock here because the vq locks are always taken
in the same order, but lockdep can not figure it out, and we
can not make each lock a separate class because there can be more
than MAX_LOCKDEP_SUBCLASSES of vqs.

However, dropping the lock is harmless:
  1. If dim is enabled, modifications made by dim worker to coalescing
     params may cause the user's query results to be dirty data.
  2. In scenarios (a) and (b), a spurious dim worker is scheduled,
     but this can be handled correctly:
     (a)
       1. dim is on
       2. net_dim call schedules a worker
       3. dim is turning off
       4. The worker checks that dim is off and then exits after
          restoring dim's state.
       5. The worker will not be scheduled until the next time dim is on.

     (b)
       1. dim is on
       2. net_dim call schedules a worker
       3. The worker checks that dim is on and keeps going
       4. dim is turning off
       5. The worker successfully configure this parameter to the device.
       6. The worker will not be scheduled until the next time dim is on.

[1]
========================================================
WARNING: possible recursive locking detected
6.9.0-rc7+ #319 Not tainted
--------------------------------------------
ethtool/962 is trying to acquire lock:

but task is already holding lock:

other info that might help us debug this:
Possible unsafe locking scenario:

      CPU0
      ----
 lock(&vi->rq[i].dim_lock);
 lock(&vi->rq[i].dim_lock);

*** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by ethtool/962:
 #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
 #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
				ethnl_default_set_doit+0xbe/0x1e0

stack backtrace:
CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x79/0xb0
 check_deadlock+0x130/0x220
 __lock_acquire+0x861/0x990
 lock_acquire.part.0+0x72/0x1d0
 ? lock_acquire+0xf8/0x130
 __mutex_lock+0x71/0xd50
 virtnet_set_coalesce+0x151/0x190
 __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
 ethnl_set_coalesce+0x34/0x90
 ethnl_default_set_doit+0xdd/0x1e0
 genl_family_rcv_msg_doit+0xdc/0x130
 genl_family_rcv_msg+0x154/0x230
 ? __pfx_ethnl_default_set_doit+0x10/0x10
 genl_rcv_msg+0x4b/0xa0
 ? __pfx_genl_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x5a/0x110
 genl_rcv+0x28/0x40
 netlink_unicast+0x1af/0x280
 netlink_sendmsg+0x20e/0x460
 __sys_sendto+0x1fe/0x210
 ? find_held_lock+0x2b/0x80
 ? do_user_addr_fault+0x3a2/0x8a0
 ? __lock_release+0x5e/0x160
 ? do_user_addr_fault+0x3a2/0x8a0
 ? lock_release+0x72/0x140
 ? do_user_addr_fault+0x3a7/0x8a0
 __x64_sys_sendto+0x29/0x30
 do_syscall_64+0x78/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v1->v2: Rephase the commit log.

 drivers/net/virtio_net.c | 53 +++++++++-------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1cad06cef230..e4a1dff2a64a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -316,9 +316,6 @@ struct receive_queue {
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
-	/* Used to protect dim_enabled and inter_coal */
-	struct mutex dim_lock;
-
 	/* Dynamic Interrupt Moderation */
 	struct dim dim;
 
@@ -2368,10 +2365,6 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	/* Out of packets? */
 	if (received < budget) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
-		/* Intentionally not taking dim_lock here. This may result in a
-		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
-		 * will not act on the scheduled work.
-		 */
 		if (napi_complete && rq->dim_enabled)
 			virtnet_rx_dim_update(vi, rq);
 	}
@@ -3247,11 +3240,9 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
-			mutex_lock(&vi->rq[i].dim_lock);
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
-			mutex_unlock(&vi->rq[i].dim_lock);
 			if (err)
 				return err;
 		}
@@ -4257,7 +4248,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
-	int ret = 0;
 	int i;
 
 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -4267,22 +4257,16 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
 		return -EINVAL;
 
-	/* Acquire all queues dim_locks */
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		mutex_lock(&vi->rq[i].dim_lock);
-
 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = true;
 		for (i = 0; i < vi->max_queue_pairs; i++)
 			vi->rq[i].dim_enabled = true;
-		goto unlock;
+		return 0;
 	}
 
 	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
-	if (!coal_rx) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!coal_rx)
+		return -ENOMEM;
 
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
@@ -4300,10 +4284,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+				  &sgs_rx))
+		return -EINVAL;
 
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
@@ -4311,11 +4293,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
-unlock:
-	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
-		mutex_unlock(&vi->rq[i].dim_lock);
 
-	return ret;
+	return 0;
 }
 
 static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
@@ -4339,24 +4318,19 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 					     u16 queue)
 {
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
+	bool cur_rx_dim = vi->rq[queue].dim_enabled;
 	u32 max_usecs, max_packets;
-	bool cur_rx_dim;
 	int err;
 
-	mutex_lock(&vi->rq[queue].dim_lock);
-	cur_rx_dim = vi->rq[queue].dim_enabled;
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
 	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
-			       ec->rx_max_coalesced_frames != max_packets)) {
-		mutex_unlock(&vi->rq[queue].dim_lock);
+			       ec->rx_max_coalesced_frames != max_packets))
 		return -EINVAL;
-	}
 
 	if (rx_ctrl_dim_on && !cur_rx_dim) {
 		vi->rq[queue].dim_enabled = true;
-		mutex_unlock(&vi->rq[queue].dim_lock);
 		return 0;
 	}
 
@@ -4369,8 +4343,10 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->rx_coalesce_usecs,
 					       ec->rx_max_coalesced_frames);
-	mutex_unlock(&vi->rq[queue].dim_lock);
-	return err;
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
@@ -4404,7 +4380,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 
 	qnum = rq - vi->rq;
 
-	mutex_lock(&rq->dim_lock);
 	if (!rq->dim_enabled)
 		goto out;
 
@@ -4420,7 +4395,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	}
 out:
 	dim->state = DIM_START_MEASURE;
-	mutex_unlock(&rq->dim_lock);
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4558,13 +4532,11 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
-		mutex_lock(&vi->rq[queue].dim_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
-		mutex_unlock(&vi->rq[queue].dim_lock);
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -5396,7 +5368,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
-		mutex_init(&vi->rq[i].dim_lock);
 	}
 
 	return 0;
-- 
2.32.0.3.g01195cf9f


