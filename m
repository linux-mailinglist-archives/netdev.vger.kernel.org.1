Return-Path: <netdev+bounces-260910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A+RAW/onmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:17:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54F197258
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76F45301C5A5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDA3ACF1E;
	Wed, 25 Feb 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3eC2bCW"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDF3ACEF6
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021723; cv=none; b=lHqNW6jOdvH77nXcifOLaPdSxVZH/Q0EQmG4MDpt05hmGXln31SPKHCe5m/LYyHbDysGdvByGbm6WhnyTCdb3ESXHUBD4DsWqSCdd6wh2OSVb3jzks1BCMeqGOGiQQFzsjrsW6EDdDyGBt8J+I3ObGF3kKq/2qwABhrH2bq+TS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021723; c=relaxed/simple;
	bh=SoIASlQHQkl2l2grY9dFi8gICeiVCKREbAsjLqwKoCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYDRArKwJWZminGV3/SbzvR0QDeCoTJhG8A6tjhSTPd6L2q3LZPoSkmJUKxLD9BpWxnVwqAIxXf3uCmjY2i4NDbYCusORRvS/L0ckbbjWsOJynvlFFXXMhM61hHOne+VWHYw7gAEKTKK6v7/F7Pscq1jWcf2EyolpcsRLHp8sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3eC2bCW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772021719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSBZzSEqUJvM4KWzWVEwXGx1jyBYabVLcqc6HiuSlLA=;
	b=m3eC2bCWO6AO1U3jzWKMT3OOQzW83GzyuMmktszlvw+E43I1R/1KIGM73H9DC2K02Si/jE
	muAL3KY0eeTOvMKYX1V6z10ZmqjOdV96yjD9lpR4Aq8YVXiZuS5f9jZnHd0XNPzn3umM3x
	XV2GaBSkQhnjDadJFjqp9Viq+fAss5E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
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
Subject: [PATCH bpf v4 1/2] bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
Date: Wed, 25 Feb 2026 20:14:55 +0800
Message-ID: <20260225121459.183121-2-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260910-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,syzkaller.appspotmail.com,linutronix.de,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,google.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6F54F197258
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

On PREEMPT_RT kernels, the per-CPU xdp_bulk_queue (bq) can be accessed
concurrently by multiple preemptible tasks on the same CPU.

The original code assumes bq_enqueue() and __cpu_map_flush() run
atomically with respect to each other on the same CPU, relying on
local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
local_bh_disable() only calls migrate_disable() (when
PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
preemption, which allows CFS scheduling to preempt a task during
bq_flush_to_queue(), enabling another task on the same CPU to enter
bq_enqueue() and operate on the same per-CPU bq concurrently.

This leads to several races:

1. Double __list_del_clearprev(): after bq->count is reset in
   bq_flush_to_queue(), a preempting task can call bq_enqueue() ->
   bq_flush_to_queue() on the same bq when bq->count reaches
   CPU_MAP_BULK_SIZE. Both tasks then call __list_del_clearprev()
   on the same bq->flush_node, the second call dereferences the
   prev pointer that was already set to NULL by the first.

2. bq->count and bq->q[] races: concurrent bq_enqueue() can corrupt
   the packet queue while bq_flush_to_queue() is processing it.

The race between task A (__cpu_map_flush -> bq_flush_to_queue) and
task B (bq_enqueue -> bq_flush_to_queue) on the same CPU:

  Task A (xdp_do_flush)          Task B (cpu_map_enqueue)
  ----------------------         ------------------------
  bq_flush_to_queue(bq)
    spin_lock(&q->producer_lock)
    /* flush bq->q[] to ptr_ring */
    bq->count = 0
    spin_unlock(&q->producer_lock)
                                   bq_enqueue(rcpu, xdpf)
    <-- CFS preempts Task A -->      bq->q[bq->count++] = xdpf
                                     /* ... more enqueues until full ... */
                                     bq_flush_to_queue(bq)
                                       spin_lock(&q->producer_lock)
                                       /* flush to ptr_ring */
                                       spin_unlock(&q->producer_lock)
                                       __list_del_clearprev(flush_node)
                                         /* sets flush_node.prev = NULL */
    <-- Task A resumes -->
    __list_del_clearprev(flush_node)
      flush_node.prev->next = ...
      /* prev is NULL -> kernel oops */

Fix this by adding a local_lock_t to xdp_bulk_queue and acquiring it
in bq_enqueue() and __cpu_map_flush(). These paths already run under
local_bh_disable(), so use local_lock_nested_bh() which on non-RT is
a pure annotation with no overhead, and on PREEMPT_RT provides a
per-CPU sleeping lock that serializes access to the bq.

To reproduce, insert an mdelay(100) between bq->count = 0 and
__list_del_clearprev() in bq_flush_to_queue(), then run reproducer
provided by syzkaller.

Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@google.com/T/
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/cpumap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..32b43cb9061b 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
+#include <linux/local_lock.h>
 #include <linux/completion.h>
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
@@ -52,6 +53,7 @@ struct xdp_bulk_queue {
 	struct list_head flush_node;
 	struct bpf_cpu_map_entry *obj;
 	unsigned int count;
+	local_lock_t bq_lock;
 };
 
 /* Struct for every remote "destination" CPU in map */
@@ -451,6 +453,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	for_each_possible_cpu(i) {
 		bq = per_cpu_ptr(rcpu->bulkq, i);
 		bq->obj = rcpu;
+		local_lock_init(&bq->bq_lock);
 	}
 
 	/* Alloc queue */
@@ -722,6 +725,8 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 	struct ptr_ring *q;
 	int i;
 
+	lockdep_assert_held(&bq->bq_lock);
+
 	if (unlikely(!bq->count))
 		return;
 
@@ -749,11 +754,15 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 }
 
 /* Runs under RCU-read-side, plus in softirq under NAPI protection.
- * Thus, safe percpu variable access.
+ * Thus, safe percpu variable access. PREEMPT_RT relies on
+ * local_lock_nested_bh() to serialise access to the per-CPU bq.
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 {
-	struct xdp_bulk_queue *bq = this_cpu_ptr(rcpu->bulkq);
+	struct xdp_bulk_queue *bq;
+
+	local_lock_nested_bh(&rcpu->bulkq->bq_lock);
+	bq = this_cpu_ptr(rcpu->bulkq);
 
 	if (unlikely(bq->count == CPU_MAP_BULK_SIZE))
 		bq_flush_to_queue(bq);
@@ -774,6 +783,8 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 
 		list_add(&bq->flush_node, flush_list);
 	}
+
+	local_unlock_nested_bh(&rcpu->bulkq->bq_lock);
 }
 
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
@@ -810,7 +821,9 @@ void __cpu_map_flush(struct list_head *flush_list)
 	struct xdp_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
+		local_lock_nested_bh(&bq->obj->bulkq->bq_lock);
 		bq_flush_to_queue(bq);
+		local_unlock_nested_bh(&bq->obj->bulkq->bq_lock);
 
 		/* If already running, costs spin_lock_irqsave + smb_mb */
 		wake_up_process(bq->obj->kthread);
-- 
2.43.0


