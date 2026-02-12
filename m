Return-Path: <netdev+bounces-258400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Oo9sBNc8jWmG0QAAu9opvQ
	(envelope-from <netdev+bounces-258400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 03:37:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36B1292D7
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 03:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C22B3015B8A
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FC202C48;
	Thu, 12 Feb 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBC9K2z/"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A71E0B9C
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770863823; cv=none; b=ghHTgkxrHjTfoJVAlFBqZkuPMF5c4Gp7kXrIhesy2xsJ5HkIzLHCTj1phxKSxs0iH/JhtmvpF+G/l6U4I7pYXyIIe22jPL4ACf5lqrzgPpPltnka8DmP2g++BEKUHjOAbosk4YNbU+8gPUZTgi+CTeNmjc+Fn+05nPTFJkRQxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770863823; c=relaxed/simple;
	bh=NHG1RfBq3USV9RR/GbLkCAj0C63n6d1HzMNzLjp/uoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juag02JeoKpKUPpRyxlD275v4cgCz8oyEfzFXiSu6gM4A2hnPXWKK/kdxqmCkBv4Xc/+NREp5P9EEyWV4OfdGD1eGxNlqUAmJJBTyjDf/WiR2l0XUZOB+HmucJAd1zmFJBQ9ii22uqs75CJZF36SSLUEnMtB0S6yaU3dzZNYw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBC9K2z/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770863809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H0zxS2+fpaIq5MDTkuYbUhqvkm69abmM5+m94S3DKjA=;
	b=iBC9K2z/hYuDRI0pTMC0Z0WrEoy4MyO0isfzHBtSRWwZHZcR9CZiTUhZu3Qn73w8CoF3wC
	BlZqYK0rJGwJy7t2nXoSyatfofLwLGrmc46Bf2qGj4oNQiU0vca5scW97uSkRUuaovkM+X
	dr+jDQhjImSveXRyAQucRzFt4Q3qgKU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xxx@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v2] bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
Date: Thu, 12 Feb 2026 10:36:33 +0800
Message-ID: <20260212023634.366343-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258400-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[shopee.com,syzkaller.appspotmail.com,linux.dev,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 1E36B1292D7
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

On PREEMPT_RT kernels, the per-CPU xdp_bulk_queue (bq) can be accessed
concurrently by multiple preemptible tasks on the same CPU.

The original code assumes bq_enqueue() and __cpu_map_flush() run
atomically with respect to each other on the same CPU, relying on
local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
local_bh_disable() only calls migrate_disable() and does not disable
preemption. spin_lock() also becomes a sleeping rt_mutex. Together,
this allows CFS scheduling to preempt a task during bq_flush_to_queue(),
enabling another task on the same CPU to enter bq_enqueue() and operate
on the same per-CPU bq concurrently.

This leads to several races:

1. Double __list_del_clearprev(): after spin_unlock() in
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
in bq_enqueue() and __cpu_map_flush(). On non-RT kernels, local_lock
maps to preempt_disable/enable with zero additional overhead. On
PREEMPT_RT, it provides a per-CPU sleeping lock that serializes
access to the bq. Use local_lock_nested_bh() since these paths already
run under local_bh_disable().

An alternative approach of snapshotting bq->count and bq->q[] before
releasing the producer_lock was considered, but it requires copying
the entire bq->q[] array on every flush, adding unnecessary overhead.

To reproduce, insert an mdelay(100) between spin_unlock() and
__list_del_clearprev() in bq_flush_to_queue(), then run reproducer
provided by syzkaller.

Panic:
===
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0002 [#1] SMP PTI
 CPU: 0 UID: 0 PID: 377 Comm: a.out Not tainted 6.19.0+ #21 PREEMPT_RT
 RIP: 0010:bq_flush_to_queue+0x145/0x200
 Call Trace:
  <TASK>
  __cpu_map_flush+0x2c/0x70
  xdp_do_flush+0x64/0x1b0
  xdp_test_run_batch.constprop.0+0x4d4/0x6d0
  bpf_test_run_xdp_live+0x24b/0x3e0
  bpf_prog_test_run_xdp+0x4a1/0x6e0
  __sys_bpf+0x44a/0x2760
  __x64_sys_bpf+0x1a/0x30
  x64_sys_call+0x146c/0x26e0
  do_syscall_64+0xd5/0x5a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v1 -> v2: https://lore.kernel.org/bpf/20260211064417.196401-1-jiayuan.chen@linux.dev/
- Use local_lock_nested_bh()/local_unlock_nested_bh() instead of
  local_lock()/local_unlock(), since these paths already run under
  local_bh_disable(). (Sebastian Andrzej Siewior)
- Replace "Caller must hold bq->bq_lock" comment with
  lockdep_assert_held() in bq_flush_to_queue(). (Sebastian Andrzej Siewior)
- Fix Fixes tag to 3253cb49cbad ("softirq: Allow to drop the
  softirq-BKL lock on PREEMPT_RT") which is the actual commit that
  makes the race possible. (Sebastian Andrzej Siewior)
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


