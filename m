Return-Path: <netdev+bounces-200912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED1AE7525
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC1F1775A0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E101E5B7B;
	Wed, 25 Jun 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEv4+NhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF71DF982;
	Wed, 25 Jun 2025 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821094; cv=none; b=Ysu7uZRbkYHH1w/FV+BAZZrsEy/SID0hkfufVzbFn+Sedj4pkGWZRiQTcG24ZbAIlwA9PU3s55755/lFmVQG9EHOjDXhHt8BMdGkpJpUPI2XuuacI4YpDRdqakI9aiLn5KGIB7SXuEnVuGQa5m2siMZs0Atr1NkgFKvCpj3RsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821094; c=relaxed/simple;
	bh=sxyTkmClYKCx2KAlJR1DYraQKkP+bsD2bxeiep/d0Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/qyxvDIfV84gV0PC3P15SyfHW8jv8uYxem0kCpcCdgEjHCwFrNjy0X3SjaF/ZVivUazbHx6+JtjJm86ZSfcpwTp/o0hlc9iZuMWTtpRszpSXOlVAZkpg+6VWPqwiv+riwWDtMK9/8V7KjOWBscZfJHV1w47M8dhOvH9xqbjthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEv4+NhE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d21cecc11fso182447585a.3;
        Tue, 24 Jun 2025 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821091; x=1751425891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/jmQRtJolvJ8MRtLxIpfpnxQl5ZuerDrjfqxOk6x7w=;
        b=QEv4+NhEtZDTxMxx1ReFFiMhECxwzAT3DsNchtjJQ4LEblXhUKuIm1rdnZRVVkodz/
         UNJm3Ai93ZR+Q1ted9guYUqDgir6FteXzO0jiUZdXkg1/nRaxIzVIhvuTVou8QPyoYt8
         2fHJAaNl9tNjA5RY/YSB2N2oELupHzhOKIqS1pN7y+Uf2TztKV8cnqnKj9kq8bRmSf5p
         KfMJ/ZEg0ORFbJ2a7ZE2Pyz9e3hjOtLbu4Zbi+5vAr/jtikNQQOJf0q11NHtKpxezdqO
         RUfR+8aK0afTN4ELU2X98QI590KHRqgrxgYBXOE6pHjMn/rMiZnGuV5wToCUJq2gaGFG
         N3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821091; x=1751425891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/jmQRtJolvJ8MRtLxIpfpnxQl5ZuerDrjfqxOk6x7w=;
        b=awiCBRZ46Vog2XshN2zCYQ1Bxp4PdnE45kdmFg8VpIfqLtWix/J4StoSKvnI6eZ+CL
         Hh27vPyJAykEfSpsuiOW1l32gIqPfSbWMf0E6gdcMh2TtbzXCeRDBmP+xDD1Th+b+wNg
         0AMlOkMzHmj0VNe3asOcQZpg3BwsF3p0sglZ1FACoo76W7Fg990bAUjUYYrxW7rqRANn
         VI4yPOPCWwQrIFkwz5Bf4ymSP3ItevNiqETrNbqe/+Y3mKoLTxKgljHmDFMMsdSzjqSt
         tdHKCt/sBcGLtqzp0n8AxH2KQaECQeGXl+v/GjKrBMHYRwwYfH4wMX9u09PE7V3C2w9c
         7UzA==
X-Forwarded-Encrypted: i=1; AJvYcCU+W5qfH6+7SYL/SWnjLsMeWKVPNjp9ieYiC1FHjbU6r9kDpXHsFuY1YhpfP4VRv2laF71EBYM=@vger.kernel.org, AJvYcCUMtUKIb2nPYuCnj8CQ3rn8EcUnuEwyzg6+pp30e+h0p3uJlII34yc1J5ZmpaCvfmljRTHC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TEfq3Jbdfywo4CEdwQbFQ0n9hpN9ya8sIO+KNvZK0w2wU0wU
	UtoKxr4wz/xGTSmXKS0HPgPFeGrYv92kyAv6CRMVmMCPkq0MIb865Q6y
X-Gm-Gg: ASbGncu3GalY0fmQ/B7pTZC2EY/kT0RSdCQo4dvMWwEcoW7fBsuqeyfgvrMIW8biNHY
	nKztbTDv7qP0u/0BZwViIzPWXAKypMq0gpK9nxnERWC/WHWJpvd8i3LsBnkMbxGEfYdnRAA7HSg
	ZtRZx5mgkit3DQafkug82NFaV//53BvsxD2Eq+1aHk4Vm3K4QlOmk1hePmEQt/7E7JmYdCLTBPz
	inyuyyuLFKBvWOA2avEvw2hOqQw+y4DvY1hcPc9fGJZ4Yn5ccqoyQzIpclBxvy1RGQS0DosUZ8O
	Jcj8xisAYuPW6YspBn41X3QObVjWtq/c8N8akWF5tnG/51oZDMm8D3VzvW8E6cJ7MdK8KgXoWYI
	oPDLsoBEZDIFiZ2J7aRas18uxR+D+aPiOTAOHRMQXFn0JTXnHNGUV
X-Google-Smtp-Source: AGHT+IFVRwKccPAflt2V1XXD1Q8zsrzo7w5VtHeTyKZceopLjwAcJzQGavaQnodNpvUONHM1DDrC7Q==
X-Received: by 2002:a05:620a:2916:b0:7cf:159:9aea with SMTP id af79cd13be357-7d4296ca04bmr190876685a.2.1750821091010;
        Tue, 24 Jun 2025 20:11:31 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd167ff184sm52004366d6.43.2025.06.24.20.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:30 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0FAF7F40066;
	Tue, 24 Jun 2025 23:11:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 23:11:30 -0400
X-ME-Sender: <xms:4WhbaN1dh-h06R-SU3a5PE7gX5AxFjRHQLUf6xKvQ4HAnkArXyeCYQ>
    <xme:4WhbaEGhqRXSPNvbfnU_Mp0eSpXLW-49qiQriFXrOiKlhbk7zuodgl_wfkQaMrsSO
    PxLQqWNy0ocjjfeBQ>
X-ME-Received: <xmr:4WhbaN5mZp3zhhKpyr_uJlW34wmF2Gjq5PwZO_iDPx6p4yeiyFKX-sSisA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhm
    mheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:4WhbaK2skKI-2MKOA5gqwpAC-ON425xF9k29PiYf6sHg1nddyk6I-A>
    <xmx:4WhbaAG4fKTjtsp2aTLxMmsF5ht-YurZXKT7rmqOPvpMEibLRsCMjQ>
    <xmx:4WhbaL_aPRYxzNznPVI2bLLJS91_poAkyPzCIiC-dIMgwcSEHxck9w>
    <xmx:4WhbaNlOj8eXT5vSOnCIx-_cEyfILvf7Omn900FTrFJXkw_A8z8JCg>
    <xmx:4mhbaEFVmJ9tZ29Nzc96Tk8OCu0QcmIUp3or0LauR8Xn0c9SGhfY6_UN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:29 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	aeh@meta.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: [PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Date: Tue, 24 Jun 2025 20:10:57 -0700
Message-Id: <20250625031101.12555-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a general purpose hazard pointers implemenation, always busy waiting
is not an option. It may benefit some special workload, but overall it
hurts the system performance when more and more users begin to call
synchronize_shazptr(). Therefore avoid busy waiting for hazard pointer
slots changes by using a scan kthread, and each synchronize_shazptr()
queues themselves if a quick scan shows they are blocked by some slots.

A simple optimization is done inside the scan: each
synchronize_shazptr() tracks which CPUs (or CPU groups if nr_cpu_ids >
BITS_PER_LONG) are blocking it and the scan function updates this
information for each synchronize_shazptr() (via shazptr_wait)
individually. In this way, synchronize_shazptr() doesn't need to wait
until a scan result showing all slots are not blocking (as long as the
scan has observed each slot has changed into non-block state once).

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/shazptr.c | 277 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
index 991fd1a05cfd..a8559cb559f8 100644
--- a/kernel/locking/shazptr.c
+++ b/kernel/locking/shazptr.c
@@ -7,18 +7,243 @@
  * Author: Boqun Feng <boqun.feng@gmail.com>
  */
 
+#define pr_fmt(fmt) "shazptr: " fmt
+
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/shazptr.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
 EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
 
-void synchronize_shazptr(void *ptr)
+/* Wait structure for synchronize_shazptr(). */
+struct shazptr_wait {
+	struct list_head list;
+	/* Which groups of CPUs are blocking. */
+	unsigned long blocking_grp_mask;
+	void *ptr;
+	struct completion done;
+};
+
+/* Snapshot for hazptr slot. */
+struct shazptr_snapshot {
+	unsigned long ptr;
+	unsigned long grp_mask;
+};
+
+static inline int
+shazptr_snapshot_cmp(const void *a, const void *b)
+{
+	const struct shazptr_snapshot *snap_a = (struct shazptr_snapshot *)a;
+	const struct shazptr_snapshot *snap_b = (struct shazptr_snapshot *)b;
+
+	if (snap_a->ptr > snap_b->ptr)
+		return 1;
+	else if (snap_a->ptr < snap_b->ptr)
+		return -1;
+	else
+		return 0;
+}
+
+/* *In-place* merge @n together based on ->ptr and accumulate the >grp_mask. */
+static int shazptr_snapshot_merge(struct shazptr_snapshot *snaps, int n)
+{
+	int new, i;
+
+	/* Sort first. */
+	sort(snaps, n, sizeof(*snaps), shazptr_snapshot_cmp, NULL);
+
+	new = 0;
+
+	/* Skip NULLs. */
+	for (i = 0; i < n; i++) {
+		if (snaps[i].ptr)
+			break;
+	}
+
+	while (i < n) {
+		/* Start with a new address. */
+		snaps[new] = snaps[i];
+
+		for (; i < n; i++) {
+			/* Merge if the next one has the same address. */
+			if (snaps[new].ptr == snaps[i].ptr) {
+				snaps[new].grp_mask |= snaps[i].grp_mask;
+			} else
+				break;
+		}
+
+		/*
+		 * Either the end has been reached or need to start with a new
+		 * record.
+		 */
+		new++;
+	}
+
+	return new;
+}
+
+/*
+ * Calculate which group is still blocking @ptr, this assumes the @snaps is
+ * already merged.
+ */
+static unsigned long
+shazptr_snapshot_blocking_grp_mask(struct shazptr_snapshot *snaps,
+				   int n, void *ptr)
+{
+	unsigned long mask = 0;
+
+	if (!n)
+		return mask;
+	else if (snaps[n-1].ptr == (unsigned long)SHAZPTR_WILDCARD) {
+		/*
+		 * Take SHAZPTR_WILDCARD slots, which is ULONG_MAX, into
+		 * consideration if any.
+		 */
+		mask = snaps[n-1].grp_mask;
+	}
+
+	/* TODO: binary search if n is big. */
+	for (int i = 0; i < n; i++) {
+		if (snaps[i].ptr == (unsigned long)ptr) {
+			mask |= snaps[i].grp_mask;
+			break;
+		}
+	}
+
+	return mask;
+}
+
+/* Scan structure for synchronize_shazptr(). */
+struct shazptr_scan {
+	/* The scan kthread */
+	struct task_struct *thread;
+
+	/* Wait queue for the scan kthread */
+	struct swait_queue_head wq;
+
+	/* Whether the scan kthread has been scheduled to scan */
+	bool scheduled;
+
+	/* The lock protecting ->queued and ->scheduled */
+	struct mutex lock;
+
+	/* List of queued synchronize_shazptr() request. */
+	struct list_head queued;
+
+	int cpu_grp_size;
+
+	/* List of scanning synchronize_shazptr() request. */
+	struct list_head scanning;
+
+	/* Buffer used for hazptr slot scan, nr_cpu_ids slots*/
+	struct shazptr_snapshot* snaps;
+};
+
+static struct shazptr_scan shazptr_scan;
+
+static void shazptr_do_scan(struct shazptr_scan *scan)
+{
+	int cpu;
+	int snaps_len;
+	struct shazptr_wait *curr, *next;
+
+	scoped_guard(mutex, &scan->lock) {
+		/* Move from ->queued to ->scanning. */
+		list_splice_tail_init(&scan->queued, &scan->scanning);
+	}
+
+	memset(scan->snaps, nr_cpu_ids, sizeof(struct shazptr_snapshot));
+
+	for_each_possible_cpu(cpu) {
+		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
+		void *val;
+
+		/* Pair with smp_store_release() in shazptr_clear(). */
+		val = smp_load_acquire(slot);
+
+		scan->snaps[cpu].ptr = (unsigned long)val;
+		scan->snaps[cpu].grp_mask = 1UL << (cpu / scan->cpu_grp_size);
+	}
+
+	snaps_len = shazptr_snapshot_merge(scan->snaps, nr_cpu_ids);
+
+	/* Only one thread can access ->scanning, so can be lockless. */
+	list_for_each_entry_safe(curr, next, &scan->scanning, list) {
+		/* Accumulate the shazptr slot scan result. */
+		curr->blocking_grp_mask &=
+			shazptr_snapshot_blocking_grp_mask(scan->snaps,
+							   snaps_len,
+							   curr->ptr);
+
+		if (curr->blocking_grp_mask == 0) {
+			/* All shots are observed as not blocking once. */
+			list_del(&curr->list);
+			complete(&curr->done);
+		}
+	}
+}
+
+static int __noreturn shazptr_scan_kthread(void *unused)
+{
+	for (;;) {
+		swait_event_idle_exclusive(shazptr_scan.wq,
+					   READ_ONCE(shazptr_scan.scheduled));
+
+		shazptr_do_scan(&shazptr_scan);
+
+		scoped_guard(mutex, &shazptr_scan.lock) {
+			if (list_empty(&shazptr_scan.queued) &&
+			    list_empty(&shazptr_scan.scanning))
+				shazptr_scan.scheduled = false;
+		}
+	}
+}
+
+static int __init shazptr_scan_init(void)
+{
+	struct shazptr_scan *scan = &shazptr_scan;
+	struct task_struct *t;
+
+	init_swait_queue_head(&scan->wq);
+	mutex_init(&scan->lock);
+	INIT_LIST_HEAD(&scan->queued);
+	INIT_LIST_HEAD(&scan->scanning);
+	scan->scheduled = false;
+
+	/* Group CPUs into at most BITS_PER_LONG groups. */
+	scan->cpu_grp_size = DIV_ROUND_UP(nr_cpu_ids, BITS_PER_LONG);
+
+	scan->snaps = kcalloc(nr_cpu_ids, sizeof(scan->snaps[0]), GFP_KERNEL);
+
+	if (scan->snaps) {
+		t = kthread_run(shazptr_scan_kthread, NULL, "shazptr_scan");
+		if (!IS_ERR(t)) {
+			smp_store_release(&scan->thread, t);
+			/* Kthread creation succeeds */
+			return 0;
+		} else {
+			kfree(scan->snaps);
+		}
+	}
+
+	pr_info("Failed to create the scan thread, only busy waits\n");
+	return 0;
+}
+core_initcall(shazptr_scan_init);
+
+static void synchronize_shazptr_busywait(void *ptr)
 {
 	int cpu;
 
 	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
+
 	for_each_possible_cpu(cpu) {
 		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
 		/* Pair with smp_store_release() in shazptr_clear(). */
@@ -26,4 +251,54 @@ void synchronize_shazptr(void *ptr)
 				      VAL != ptr && VAL != SHAZPTR_WILDCARD);
 	}
 }
+
+static void synchronize_shazptr_normal(void *ptr)
+{
+	int cpu;
+	unsigned long blocking_grp_mask = 0;
+
+	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
+
+	for_each_possible_cpu(cpu) {
+		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
+		void *val;
+
+		/* Pair with smp_store_release() in shazptr_clear(). */
+		val = smp_load_acquire(slot);
+
+		if (val == ptr || val == SHAZPTR_WILDCARD)
+			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
+	}
+
+	/* Found blocking slots, prepare to wait. */
+	if (blocking_grp_mask) {
+		struct shazptr_scan *scan = &shazptr_scan;
+		struct shazptr_wait wait = {
+			.blocking_grp_mask = blocking_grp_mask,
+		};
+
+		INIT_LIST_HEAD(&wait.list);
+		init_completion(&wait.done);
+
+		scoped_guard(mutex, &scan->lock) {
+			list_add_tail(&wait.list, &scan->queued);
+
+			if (!scan->scheduled) {
+				WRITE_ONCE(scan->scheduled, true);
+				swake_up_one(&shazptr_scan.wq);
+			}
+		}
+
+		wait_for_completion(&wait.done);
+	}
+}
+
+void synchronize_shazptr(void *ptr)
+{
+	/* Busy waiting if the scan kthread has not been created. */
+	if (!smp_load_acquire(&shazptr_scan.thread))
+		synchronize_shazptr_busywait(ptr);
+	else
+		synchronize_shazptr_normal(ptr);
+}
 EXPORT_SYMBOL_GPL(synchronize_shazptr);
-- 
2.39.5 (Apple Git-154)


