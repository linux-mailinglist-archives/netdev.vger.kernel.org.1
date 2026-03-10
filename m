Return-Path: <netdev+bounces-266128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LyNHCQjsGmVgQIAu9opvQ
	(envelope-from <netdev+bounces-266128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:56:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB5251103
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13C5533E0A12
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DD3C9426;
	Tue, 10 Mar 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnNzcu/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAD3BD229;
	Tue, 10 Mar 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145716; cv=none; b=bvVslDCsOs0IrBqVB3ejFDTbEMMimuZx2pmaWNCCsYd59QNT5MxQGy2x509AAF8+E6MeDUsWTCSdsmvYw44d/ukxv5jXC6rwAonUaGBpvYTUiOz37qiuv5QNCZO4x+P6Jsw3g1noKDdR/GZtJQYKiDmyh3jdCO5V7ZLqDyo6EIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145716; c=relaxed/simple;
	bh=ko9HkUb2AI93RhBU7DamCMCqLLYRQwX0pSLqGFllu5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isyoixZSXBeK6zyCaiaevE6R7TcTOgIBhdTSKNIRr0Bv1LLrnhvKPtCfpQSVM+vDxBAKNlnWuzy3HrsMl5883Ukj/ni/cRvLdypQhrHu5B6xnMGziM4kxkXHk/FaPe8ggZcehoS1oW5CpyPz7VLT5OG12lm6gvWdhDFi053w65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnNzcu/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438A3C2BC9E;
	Tue, 10 Mar 2026 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773145716;
	bh=ko9HkUb2AI93RhBU7DamCMCqLLYRQwX0pSLqGFllu5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rnNzcu/5djaDfPAKtueNVj2aKKwO91uTK43GFTejm1oESuVAzawBxSJG6tjpDPaBP
	 2CgzP/JKbSrVrM9RlT0xzFKeKFJ6AXt1ordfAOrr+PxhPoj/Qandcrl9TZKsexOS2T
	 QCpoHA00UUEA3Q9tOTZQKUpAcE4632nkkN/QlCGGwPp4Lx8Y4zKA69lySHrZDFFg7t
	 +YjqFQ1JovO6s+PlQ/l6iLunjaazNoMygc5vy+Otw6L6LJdrkaipJ/sBbJpT6fEO5q
	 1Mm0xcnIe+Hc9PCpU4JQM4Va0tzA5GdkeEZkoQgg5vI93UmmKBBsFhdXz3g27UPlk9
	 o7cALt6lFwXIw==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, Netdev
 <netdev@vger.kernel.org>, rcu@vger.kernel.org, MPTCP Linux
 <mptcp@lists.linux.dev>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 luto@kernel.org, Michal =?utf-8?Q?Koutn=C3=BD?= <MKoutny@suse.com>, Waiman
 Long
 <longman@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <20260310115433.GV1282955@noisy.programming.kicks-ass.net>
References: <87v7f61cnl.ffs@tglx>
 <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org> <87pl5ds88r.ffs@tglx>
 <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org> <87eclsrtqg.ffs@tglx>
 <e846cb5f-65c4-4a9b-9f9b-593e4af526d8@kernel.org>
 <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org> <878qc0rofr.ffs@tglx>
 <874imorobw.ffs@tglx> <4cad1b9a-e157-427b-9896-cf54cf6fba36@kernel.org>
 <20260310115433.GV1282955@noisy.programming.kicks-ass.net>
Date: Tue, 10 Mar 2026 13:28:32 +0100
Message-ID: <87y0jzrhqn.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E8CB5251103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266128-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10 2026 at 12:54, Peter Zijlstra wrote:
> On Tue, Mar 10, 2026 at 12:24:02PM +0100, Matthieu Baerts wrote:
>> Only 7.7k lines this time.
>
> Same damn thing again...
>
> [    2.533811] virtme-n-1         3d..1. 849756us : mmcid_user_add: pid=1 users=1 mm=000000002b3f8459
> [    4.523998] virtme-n-1         3d..1. 1115085us : mmcid_user_add: pid=71 users=2 mm=000000002b3f8459
> [    4.529065] virtme-n-1         3d..1. 1115937us : mmcid_user_add: pid=72 users=3 mm=000000002b3f8459
>
> [    4.529448] virtme-n-71        2d..1. 1115969us : mmcid_user_add: pid=73 users=4 mm=000000002b3f8459         <=== missing!
> [    4.529946] virtme-n-71        2d..1. 1115971us : mmcid_getcid: mm=000000002b3f8459 cid=00000003
>
> 71 spawns 73, assigns cid 3
>
> [    4.530573]   <idle>-0         1d..2. 1115991us : sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=virtme-ng-init next_pid=73 next_prio=120
> [    4.530865]   <idle>-0         1d..2. 1115993us : mmcid_cpu_update: cpu=1 cid=00000003 mm=000000002b3f8459
>
> It gets scheduled on CPU-1, sets CID...
>
> [    4.531038] virtme-n-1         3d..1. 1116013us : mmcid_user_add: pid=74 users=5 mm=000000002b3f8459
>
> Then 1 spawns 74 on CPU 3, this is the 5th task, so we initiate a
> task->cpu cid transition:
>
> [    4.531203] virtme-n-1         3d..1. 1116014us : mmcid_task_update: pid=1 cid=20000000 mm=000000002b3f8459
> [    4.531369] virtme-n-1         3d..1. 1116014us : mmcid_cpu_update: cpu=3 cid=20000000 mm=000000002b3f8459
>
> Task 1
>
> [    4.531530] virtme-n-1         3..... 1116014us : mmcid_fixup_task: pid=71 cid=00000001 active=1 users=4 mm=000000002b3f8459
> [    4.531790] virtme-n-1         3d..2. 1116015us : mmcid_task_update: pid=71 cid=80000000 mm=000000002b3f8459
> [    4.532000] virtme-n-1         3d..2. 1116015us : mmcid_putcid: mm=000000002b3f8459 cid=00000001
>
> Task 71
>
> [    4.532169] virtme-n-1         3..... 1116015us : mmcid_fixup_task: pid=72 cid=00000002 active=1 users=3 mm=000000002b3f8459
> [    4.532362] virtme-n-1         3d..2. 1116016us : mmcid_task_update: pid=72 cid=20000002 mm=000000002b3f8459
> [    4.532514] virtme-n-1         3d..2. 1116016us : mmcid_cpu_update: cpu=0 cid=20000002 mm=000000002b3f8459
>
> Task 72
>
> [    4.532649] virtme-n-1         3..... 1116016us : mmcid_fixup_task: pid=74 cid=80000000 active=1 users=2 mm=000000002b3f8459
>
> Task 74, note the glaring lack of 73!!! which all this time is running
> on CPU 1. Per the fact that it got scheduled it must be on tasklist,
> per the fact that 1 spawns 74 after it on CPU3, we must observe any
> prior tasklist changes and per the fact that it got a cid ->active must
> be set. WTF!
>
> That said, we set active after tasklist_lock now, so it might be
> possible we simply miss that store, observe the 'old' 0 and skip over
> it?

No. We'd see it and print:

  virtme-n-1         3..... 1116017us : mmcid_fixup_task: pid=73 cid=00000003 active=0 ...

But we don't see it at all.

> Let me stare hard at that...
>
>
> [    4.532912] virtme-n-1         3..... 1116017us : mmcid_fixup_task: pid=71 cid=80000000 active=1 users=1 mm=000000002b3f8459
>
> I *think* this is the for_each_process_thread() hitting 71 again.

Correct, because the user count did not get down to zero in the pass
going through the thread list of the process.

Duh. I just noticed that this is stupid as it stops right there based on
@users becoming 0. So it fails to take the already handled tasks out of
the picture.

If 73 is result of a vfork() then it won't show up in the thread list of
the process, but is accounted to the MM. And then the (--users == 0 )
condition prevents to look it up. Duh!

I've updated the debug patch and removed the @users conditionals so it
keeps searching. So it should find that magic 73.

Thanks,

        tglx
---
 include/linux/sched.h        |    2 
 include/trace/events/mmcid.h |  171 +++++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c                |    2 
 kernel/sched/core.c          |   39 +++++++--
 kernel/sched/sched.h         |   20 ++++-
 5 files changed, 216 insertions(+), 18 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2354,7 +2354,6 @@ static __always_inline void alloc_tag_re
 #ifdef CONFIG_SCHED_MM_CID
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
-void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
@@ -2363,7 +2362,6 @@ static __always_inline int task_mm_cid(s
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
-static inline void sched_mm_cid_fork(struct task_struct *t) { }
 static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
--- /dev/null
+++ b/include/trace/events/mmcid.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mmcid
+
+#if !defined(_TRACE_MMCID_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MMCID_H
+
+#include <linux/sched.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(mmcid_class,
+
+	TP_PROTO(struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(mm, cid),
+
+	TP_STRUCT__entry(
+		__field( void *,	mm	)
+		__field( unsigned int,	cid	)
+	),
+
+	TP_fast_assign(
+		__entry->mm	= mm;
+		__entry->cid	= cid;
+	),
+
+	TP_printk("mm=%p cid=%08x", __entry->mm, __entry->cid)
+);
+
+DEFINE_EVENT(mmcid_class, mmcid_getcid,
+
+	TP_PROTO(struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(mm, cid)
+);
+
+DEFINE_EVENT(mmcid_class, mmcid_putcid,
+
+	TP_PROTO(struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(mm, cid)
+);
+
+DECLARE_EVENT_CLASS(mmcid_task_class,
+
+	TP_PROTO(struct task_struct *t, struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(t, mm, cid),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	pid	)
+		__field( unsigned int,	cid	)
+		__field( void *,	mm	)
+	),
+
+	TP_fast_assign(
+		__entry->pid	= t->pid;
+		__entry->cid	= cid;
+		__entry->mm	= mm;
+	),
+
+	TP_printk("pid=%u cid=%08x mm=%p", __entry->pid, __entry->cid, __entry->mm)
+);
+
+DEFINE_EVENT(mmcid_task_class, mmcid_task_update,
+
+	TP_PROTO(struct task_struct *t, struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(t, mm, cid)
+);
+
+DECLARE_EVENT_CLASS(mmcid_fixup_class,
+
+	TP_PROTO(struct task_struct *t, unsigned int users),
+
+	TP_ARGS(t, users),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	pid	)
+		__field( unsigned int,	cid	)
+		__field( unsigned int,	active	)
+		__field( unsigned int,	users	)
+		__field( void *,	mm	)
+	),
+
+	TP_fast_assign(
+		__entry->pid	= t->pid;
+		__entry->cid	= t->mm_cid.cid;
+		__entry->active	= t->mm_cid.active;
+		__entry->users	= users;
+		__entry->mm	= t->mm;
+	),
+
+	TP_printk("pid=%u cid=%08x active=%u users=%u mm=%p", __entry->pid, __entry->cid,
+		  __entry->active, __entry->users, __entry->mm)
+);
+
+DEFINE_EVENT(mmcid_fixup_class, mmcid_fixup_task,
+
+	TP_PROTO(struct task_struct *t, unsigned int users),
+
+	TP_ARGS(t, users)
+);
+
+DECLARE_EVENT_CLASS(mmcid_cpu_class,
+
+	TP_PROTO(unsigned int cpu, struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(cpu, mm, cid),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	cpu	)
+		__field( unsigned int,	cid	)
+		__field( void *,	mm	)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->cid	= cid;
+		__entry->mm	= mm;
+	),
+
+	TP_printk("cpu=%u cid=%08x mm=%p", __entry->cpu, __entry->cid, __entry->mm)
+);
+
+DEFINE_EVENT(mmcid_cpu_class, mmcid_cpu_update,
+
+	TP_PROTO(unsigned int cpu, struct mm_struct *mm, unsigned int cid),
+
+	TP_ARGS(cpu, mm, cid)
+);
+
+DECLARE_EVENT_CLASS(mmcid_user_class,
+
+	TP_PROTO(struct task_struct *t, struct mm_struct *mm),
+
+	TP_ARGS(t, mm),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	pid	)
+		__field( unsigned int,	users	)
+		__field( void *,	mm	)
+	),
+
+	TP_fast_assign(
+		__entry->pid	= t->pid;
+		__entry->users	= mm->mm_cid.users;
+		__entry->mm	= mm;
+	),
+
+	TP_printk("pid=%u users=%u mm=%p", __entry->pid, __entry->users, __entry->mm)
+);
+
+DEFINE_EVENT(mmcid_user_class, mmcid_user_add,
+
+	TP_PROTO(struct task_struct *t, struct mm_struct *mm),
+
+	TP_ARGS(t, mm)
+);
+
+DEFINE_EVENT(mmcid_user_class, mmcid_user_del,
+
+	TP_PROTO(struct task_struct *t, struct mm_struct *mm),
+
+	     TP_ARGS(t, mm)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1586,7 +1586,6 @@ static int copy_mm(u64 clone_flags, stru
 
 	tsk->mm = mm;
 	tsk->active_mm = mm;
-	sched_mm_cid_fork(tsk);
 	return 0;
 }
 
@@ -2498,7 +2497,6 @@ static bool need_futex_hash_allocate_def
 	exit_nsproxy_namespaces(p);
 bad_fork_cleanup_mm:
 	if (p->mm) {
-		sched_mm_cid_exit(p);
 		mm_clear_owner(p->mm, p);
 		mmput(p->mm);
 	}
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -86,6 +86,7 @@
 #include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #include <trace/events/ipi.h>
+#include <trace/events/mmcid.h>
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
@@ -4729,8 +4730,12 @@ void sched_cancel_fork(struct task_struc
 	scx_cancel_fork(p);
 }
 
+static void sched_mm_cid_fork(struct task_struct *t);
+
 void sched_post_fork(struct task_struct *p)
 {
+	if (IS_ENABLED(CONFIG_SCHED_MM_CID))
+		sched_mm_cid_fork(p);
 	uclamp_post_fork(p);
 	scx_post_fork(p);
 }
@@ -10569,7 +10574,9 @@ static inline void mm_cid_transit_to_tas
 		unsigned int cid = cpu_cid_to_cid(t->mm_cid.cid);
 
 		t->mm_cid.cid = cid_to_transit_cid(cid);
+		trace_mmcid_task_update(t, t->mm, t->mm_cid.cid);
 		pcp->cid = t->mm_cid.cid;
+		trace_mmcid_cpu_update(task_cpu(t), t->mm, pcp->cid);
 	}
 }
 
@@ -10602,7 +10609,9 @@ static void mm_cid_fixup_cpus_to_tasks(s
 			if (!cid_in_transit(cid)) {
 				cid = cid_to_transit_cid(cid);
 				rq->curr->mm_cid.cid = cid;
+				trace_mmcid_task_update(rq->curr, rq->curr->mm, cid);
 				pcp->cid = cid;
+				trace_mmcid_cpu_update(cpu, mm, cid);
 			}
 		}
 	}
@@ -10613,7 +10622,9 @@ static inline void mm_cid_transit_to_cpu
 {
 	if (cid_on_task(t->mm_cid.cid)) {
 		t->mm_cid.cid = cid_to_transit_cid(t->mm_cid.cid);
+		trace_mmcid_task_update(t, t->mm, t->mm_cid.cid);
 		pcp->cid = t->mm_cid.cid;
+		trace_mmcid_cpu_update(task_cpu(t), t->mm, pcp->cid);
 	}
 }
 
@@ -10646,15 +10657,17 @@ static void mm_cid_do_fixup_tasks_to_cpu
 	 * possible switch back to per task mode happens either in the
 	 * deferred handler function or in the next fork()/exit().
 	 *
-	 * The caller has already transferred. The newly incoming task is
-	 * already accounted for, but not yet visible.
+	 * The caller has already transferred so remove it from the users
+	 * count. The incoming task is already visible and has mm_cid.active,
+	 * but has task::mm_cid::cid == UNSET. Still it needs to be accounted
+	 * for. Concurrent fork()s might add more threads, but all of them have
+	 * task::mm_cid::active = 0, so they don't affect the accounting here.
 	 */
-	users = mm->mm_cid.users - 2;
-	if (!users)
-		return;
+	users = mm->mm_cid.users - 1;
 
 	guard(rcu)();
 	for_other_threads(current, t) {
+		trace_mmcid_fixup_task(t, users);
 		if (mm_cid_fixup_task_to_cpu(t, mm))
 			users--;
 	}
@@ -10666,10 +10679,8 @@ static void mm_cid_do_fixup_tasks_to_cpu
 	for_each_process_thread(p, t) {
 		if (t == current || t->mm != mm)
 			continue;
-		if (mm_cid_fixup_task_to_cpu(t, mm)) {
-			if (--users == 0)
-				return;
-		}
+		trace_mmcid_fixup_task(t, users);
+		mm_cid_fixup_task_to_cpu(t, mm);
 	}
 }
 
@@ -10685,15 +10696,19 @@ static bool sched_mm_cid_add_user(struct
 {
 	t->mm_cid.active = 1;
 	mm->mm_cid.users++;
+	trace_mmcid_user_add(t, mm);
 	return mm_update_max_cids(mm);
 }
 
-void sched_mm_cid_fork(struct task_struct *t)
+static void sched_mm_cid_fork(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 	bool percpu;
 
-	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
+	if (!mm)
+		return;
+
+	WARN_ON_ONCE(t->mm_cid.cid != MM_CID_UNSET);
 
 	guard(mutex)(&mm->mm_cid.mutex);
 	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
@@ -10727,6 +10742,7 @@ void sched_mm_cid_fork(struct task_struc
 	} else {
 		mm_cid_fixup_cpus_to_tasks(mm);
 		t->mm_cid.cid = mm_get_cid(mm);
+		trace_mmcid_task_update(t, t->mm, t->mm_cid.cid);
 	}
 }
 
@@ -10739,6 +10755,7 @@ static bool sched_mm_cid_remove_user(str
 		mm_unset_cid_on_task(t);
 	}
 	t->mm->mm_cid.users--;
+	trace_mmcid_user_del(t, t->mm);
 	return mm_update_max_cids(t->mm);
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -75,6 +75,7 @@
 #include <linux/delayacct.h>
 #include <linux/mmu_context.h>
 
+#include <trace/events/mmcid.h>
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
 
@@ -3809,6 +3810,7 @@ static __always_inline bool cid_on_task(
 
 static __always_inline void mm_drop_cid(struct mm_struct *mm, unsigned int cid)
 {
+	trace_mmcid_putcid(mm, cid);
 	clear_bit(cid, mm_cidmask(mm));
 }
 
@@ -3817,6 +3819,7 @@ static __always_inline void mm_unset_cid
 	unsigned int cid = t->mm_cid.cid;
 
 	t->mm_cid.cid = MM_CID_UNSET;
+	trace_mmcid_task_update(t, t->mm, t->mm_cid.cid);
 	if (cid_on_task(cid))
 		mm_drop_cid(t->mm, cid);
 }
@@ -3838,6 +3841,7 @@ static inline unsigned int __mm_get_cid(
 		return MM_CID_UNSET;
 	if (test_and_set_bit(cid, mm_cidmask(mm)))
 		return MM_CID_UNSET;
+	trace_mmcid_getcid(mm, cid);
 	return cid;
 }
 
@@ -3845,9 +3849,17 @@ static inline unsigned int mm_get_cid(st
 {
 	unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
 
-	while (cid == MM_CID_UNSET) {
-		cpu_relax();
-		cid = __mm_get_cid(mm, num_possible_cpus());
+	if (cid == MM_CID_UNSET) {
+		ktime_t t0 = ktime_get();
+
+		while (cid == MM_CID_UNSET) {
+			cpu_relax();
+			cid = __mm_get_cid(mm, num_possible_cpus());
+			if (ktime_get() - t0 > 50 * NSEC_PER_MSEC) {
+				tracing_off();
+				WARN_ON_ONCE(1);
+			}
+		}
 	}
 	return cid;
 }
@@ -3874,6 +3886,7 @@ static inline unsigned int mm_cid_conver
 static __always_inline void mm_cid_update_task_cid(struct task_struct *t, unsigned int cid)
 {
 	if (t->mm_cid.cid != cid) {
+		trace_mmcid_task_update(t, t->mm, cid);
 		t->mm_cid.cid = cid;
 		rseq_sched_set_ids_changed(t);
 	}
@@ -3881,6 +3894,7 @@ static __always_inline void mm_cid_updat
 
 static __always_inline void mm_cid_update_pcpu_cid(struct mm_struct *mm, unsigned int cid)
 {
+	trace_mmcid_cpu_update(smp_processor_id(), mm, cid);
 	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
 }
 



