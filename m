Return-Path: <netdev+bounces-260912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCmvNgPonmkCXwQAu9opvQ
	(envelope-from <netdev+bounces-260912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECA197223
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CFD5302B46A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64333ACF0C;
	Wed, 25 Feb 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZpUpXtdD"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D43AE6F8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021737; cv=none; b=pXd8lUeJaovhiIczKnEeyIk51Lc7TlBvFot6QRrgPqpX5GvspPFF+CKUM5tG6fufbMExjlayHtcuuPJrqIwkAYwFHCLdCgCVShVkl6ycyzvY/7/iGKaxqX1eY8WauF6knbuIpyid3jbgSD6Yk508BMf0c3ftLgNXA9CT3O2rb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021737; c=relaxed/simple;
	bh=g7RtNiAx6OTRSX929EyC0r/iXrDYL5Y7WW6UrVu4DCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNK4DsY698da/PMytb5Kvvm0FsijLUwPEYBLxFb3kXTsSOcXXVhAiNY6bTdpjjnW+B/MJslO1fMeurzsOKW2VpriKJQU3Y6Sq2Ehn7ZN/AeksiKpBY/nvhwUFpVtN3VvLBmn3032wvDRl2c1EXpZ8dHYjhL+v2hMoIprMuAXxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZpUpXtdD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772021728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSfPXHAV066qAmlgrbJqoJU7Uy3WFkTtHw/fiXihJJg=;
	b=ZpUpXtdD1uTGYL1toz6g5W+8P7vgAd8fXc9mFjK1zXzkP/am2EJWQxjMnpm6HhMnPdSEaQ
	MAo3u4YCg6Is3ybEREujvEFsk0+gneS3n7zZ5PxVR13rBXoynOZpjVthmvjSZQuC6im/Dg
	MSAF21LDjnwmruw4kb5M77VonflVuqs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v4 2/2] bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT
Date: Wed, 25 Feb 2026 20:14:56 +0800
Message-ID: <20260225121459.183121-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260225121459.183121-1-jiayuan.chen@linux.dev>
References: <20260225121459.183121-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260912-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,linutronix.de,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,google.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E2ECA197223
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

On PREEMPT_RT kernels, the per-CPU xdp_dev_bulk_queue (bq) can be
accessed concurrently by multiple preemptible tasks on the same CPU.

The original code assumes bq_enqueue() and __dev_flush() run atomically
with respect to each other on the same CPU, relying on
local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
local_bh_disable() only calls migrate_disable() (when
PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
preemption, which allows CFS scheduling to preempt a task during
bq_xmit_all(), enabling another task on the same CPU to enter
bq_enqueue() and operate on the same per-CPU bq concurrently.

This leads to several races:

1. Double-free / use-after-free on bq->q[]: bq_xmit_all() snapshots
   cnt = bq->count, then iterates bq->q[0..cnt-1] to transmit frames.
   If preempted after the snapshot, a second task can call bq_enqueue()
   -> bq_xmit_all() on the same bq, transmitting (and freeing) the
   same frames. When the first task resumes, it operates on stale
   pointers in bq->q[], causing use-after-free.

2. bq->count and bq->q[] corruption: concurrent bq_enqueue() modifying
   bq->count and bq->q[] while bq_xmit_all() is reading them.

3. dev_rx/xdp_prog teardown race: __dev_flush() clears bq->dev_rx and
   bq->xdp_prog after bq_xmit_all(). If preempted between
   bq_xmit_all() return and bq->dev_rx = NULL, a preempting
   bq_enqueue() sees dev_rx still set (non-NULL), skips adding bq to
   the flush_list, and enqueues a frame. When __dev_flush() resumes,
   it clears dev_rx and removes bq from the flush_list, orphaning the
   newly enqueued frame.

4. __list_del_clearprev() on flush_node: similar to the cpumap race,
   both tasks can call __list_del_clearprev() on the same flush_node,
   the second dereferences the prev pointer already set to NULL.

The race between task A (__dev_flush -> bq_xmit_all) and task B
(bq_enqueue -> bq_xmit_all) on the same CPU:

  Task A (xdp_do_flush)          Task B (ndo_xdp_xmit redirect)
  ----------------------         --------------------------------
  __dev_flush(flush_list)
    bq_xmit_all(bq)
      cnt = bq->count  /* e.g. 16 */
      /* start iterating bq->q[] */
    <-- CFS preempts Task A -->
                                   bq_enqueue(dev, xdpf)
                                     bq->count == DEV_MAP_BULK_SIZE
                                     bq_xmit_all(bq, 0)
                                       cnt = bq->count  /* same 16! */
                                       ndo_xdp_xmit(bq->q[])
                                       /* frames freed by driver */
                                       bq->count = 0
    <-- Task A resumes -->
      ndo_xdp_xmit(bq->q[])
      /* use-after-free: frames already freed! */

Fix this by adding a local_lock_t to xdp_dev_bulk_queue and acquiring
it in bq_enqueue() and __dev_flush(). These paths already run under
local_bh_disable(), so use local_lock_nested_bh() which on non-RT is
a pure annotation with no overhead, and on PREEMPT_RT provides a
per-CPU sleeping lock that serializes access to the bq.

Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/devmap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..10cf0731f91d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -45,6 +45,7 @@
  * types of devmap; only the lookup and insertion is different.
  */
 #include <linux/bpf.h>
+#include <linux/local_lock.h>
 #include <net/xdp.h>
 #include <linux/filter.h>
 #include <trace/events/xdp.h>
@@ -60,6 +61,7 @@ struct xdp_dev_bulk_queue {
 	struct net_device *dev_rx;
 	struct bpf_prog *xdp_prog;
 	unsigned int count;
+	local_lock_t bq_lock;
 };
 
 struct bpf_dtab_netdev {
@@ -381,6 +383,8 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
+	lockdep_assert_held(&bq->bq_lock);
+
 	if (unlikely(!cnt))
 		return;
 
@@ -425,10 +429,12 @@ void __dev_flush(struct list_head *flush_list)
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
+		local_lock_nested_bh(&bq->dev->xdp_bulkq->bq_lock);
 		bq_xmit_all(bq, XDP_XMIT_FLUSH);
 		bq->dev_rx = NULL;
 		bq->xdp_prog = NULL;
 		__list_del_clearprev(&bq->flush_node);
+		local_unlock_nested_bh(&bq->dev->xdp_bulkq->bq_lock);
 	}
 }
 
@@ -451,12 +457,16 @@ static void *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 
 /* Runs in NAPI, i.e., softirq under local_bh_disable(). Thus, safe percpu
  * variable access, and map elements stick around. See comment above
- * xdp_do_flush() in filter.c.
+ * xdp_do_flush() in filter.c. PREEMPT_RT relies on local_lock_nested_bh()
+ * to serialise access to the per-CPU bq.
  */
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
+	struct xdp_dev_bulk_queue *bq;
+
+	local_lock_nested_bh(&dev->xdp_bulkq->bq_lock);
+	bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
 		bq_xmit_all(bq, 0);
@@ -477,6 +487,8 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	}
 
 	bq->q[bq->count++] = xdpf;
+
+	local_unlock_nested_bh(&dev->xdp_bulkq->bq_lock);
 }
 
 static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
@@ -1115,8 +1127,13 @@ static int dev_map_notification(struct notifier_block *notifier,
 		if (!netdev->xdp_bulkq)
 			return NOTIFY_BAD;
 
-		for_each_possible_cpu(cpu)
-			per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;
+		for_each_possible_cpu(cpu) {
+			struct xdp_dev_bulk_queue *bq;
+
+			bq = per_cpu_ptr(netdev->xdp_bulkq, cpu);
+			bq->dev = netdev;
+			local_lock_init(&bq->bq_lock);
+		}
 		break;
 	case NETDEV_UNREGISTER:
 		/* This rcu_read_lock/unlock pair is needed because
-- 
2.43.0


