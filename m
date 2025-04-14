Return-Path: <netdev+bounces-182040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C272EA877AC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E23B0956
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75031B4241;
	Mon, 14 Apr 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cScjNYd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CF1AAA2F;
	Mon, 14 Apr 2025 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610488; cv=none; b=pDIFqYKnewgB/hfZyvg0uVvSqk22Ym6RxZ0G244D1WpE5E88/g56DyLm17VzGA2Z/p2CLMyM9cwsIz4qB5kWHzrURiezYw6ThHa2IGw/9X9afixbitsrw/eDJxpS1FJqovPzVSCH6oCWRB9RWIWKMPKx7jnUfe/vxH5uTEx90j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610488; c=relaxed/simple;
	bh=vULrQ0jpP4keJ2UcJjqnghubGJoOGWiOvBA/vJ0Lm3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sywc5Qyi53VhWZDVviBBykrDrr5PmpwYqXzfeU1LnQd0qRmr+RVcAy1LJ9QkNvVFno8gwx2VG1obNQPKpHa5vlwfhJxRRoK33DjgNy3QW5kLzztvbx3fE88DZHbZdlAg631RJsNMQ0yFSb7p2xc47pTfqMxRbIhkL+0g03H+9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cScjNYd4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476ae781d21so39777631cf.3;
        Sun, 13 Apr 2025 23:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610485; x=1745215285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=feihuqhdShvh+PYbO8b6wItOkRthqGBFbDYSVZiL8z8=;
        b=cScjNYd4kySVJ1MhWNC8JRplznFXTIvj64gy+4oAKSNHizkztNPWDvBy7vnWgNxxpR
         6nK/FHbc3cTOqktJ4gHYc4NiLlXjj9j7xWJ8LUZ7NxRAPoOrNhX3MjkOZt2hM9uLjE1P
         HLNS87XRLVTe4OCd1KbprB/TTVdHe5/JNrhRSg/ctBQqWmtf9eGlqCkigUF2C9y3pqGn
         r5O+PSgTt9ivo7ly893PtbgTd5yxO5EB1oI7drtzz/wTLi3PePXhniTubyl+E1fi4s7U
         GJmfwBCP++Y9IgRviPoDs6DZ++t6wvEavVmCWrwOebil68bTt8ZW2pboSQJ+AWxJg3vR
         RZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610485; x=1745215285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feihuqhdShvh+PYbO8b6wItOkRthqGBFbDYSVZiL8z8=;
        b=EmDixZhporFLp2QMCfWep7D5XLxIwPGOhnsofrAf8fCclxtm+6Ql9+/vlG0nmgfiww
         tQHc8XfP+t/FAORDV7yndCwHI2WU0qZo9wFdI9XbJtB9r8fChnIjdLFdHq0sYQ+bGpPP
         ZlmEmWaYqkH/JsYQ7R5Aa6qSiMwcAr/FQ4NHfO+Np/29dozf6X+sYdF3cteUQiRIxHIt
         /6U06ojKbIaHRW/P2VtXH2A6PwNvJXN62PZar89vubV0DLxMW4Jk4Fwag37pojRBDCT8
         QE8Yo9runFWlx3Ht4i8b2qQmmTmz/fkUHKz1KgngqarnOPlgM+8v4Eyh0ilz5keyxpkM
         8ACg==
X-Forwarded-Encrypted: i=1; AJvYcCVJzWoO0r4ZuW4nzdCe7MVDFgsXlP30p9oq7LtD/XlbmfvXDsxS9C1BNFt10wXtd6Ayp0VK@vger.kernel.org, AJvYcCWIg4doOSscxYqULooipYWYYrvVQvCz4n4lcRUw1D7n+fZ9yZvYeBMJhvZYHXvXm4bqv8xMD/ma@vger.kernel.org, AJvYcCXcxjdGayxgFoxTURsdrs8k/0TK7ZPTa2qzHwtrZaEkaCiEu2tP/8P7kVP2V67CmqMstKyAO2ydgHwXphQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9JdO+6xdgseH7YADXD+IeiTcdNSj1+3SXyTHeGtHe/qfjtOX
	3HyP7PrLJVj49w8vhu17XYXpBEYzQzv76rwQxnwIJVY6fH1J+bKP
X-Gm-Gg: ASbGncuWvHoR/ZccdaVngpzPJUglKTU4gAMV2ftTk+EmWK0/M4CReX16qz2T4UqK9ZU
	4wcV1N3I0nTs3T6p9NzARGP7UrjIMNsZ1tB9euJbCHrtUpgHWjF4ChfrG1wUuudRKgCYEknjgdI
	cyWw4vifqAB1n1p1gRKB0AMYA6O5zSV8IusLizMyXSkTPNtZuSnsfOdXmXhDYpx3/w/lOsiyHpS
	Oloxt8KZ1XAOpMAyyxnwMjKrs2y9yj6FUNjBhQMX4jFVIv5t1biSq+X/BVbZWcsNfPFPQz9nT/Y
	i01m4kdw0ETxadoYQv7vf7FI5bJKRAMV57WzffDUanDD/02C/GyNZZ701L27MSBwq4BVxbO1zFy
	comCo8IDdlqSVyh8KXA32wlOIjZplGO4=
X-Google-Smtp-Source: AGHT+IGEJkYLHwxzmAyw65s263Q5wULXY2qJ8+qcdHRRZ40qmh84yNATRrITlB51bM300IVI1v4ibg==
X-Received: by 2002:ac8:5f95:0:b0:476:5fd5:4de6 with SMTP id d75a77b69052e-479775b92dcmr170988601cf.40.1744610485009;
        Sun, 13 Apr 2025 23:01:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb0b853sm69296191cf.14.2025.04.13.23.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:24 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0C74E1200068;
	Mon, 14 Apr 2025 02:01:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 02:01:24 -0400
X-ME-Sender: <xms:s6T8Zy04DamrdDChyZg8jQC46Zo12cwG8E9SaC4fsNIA8wco1amNCA>
    <xme:s6T8Z1F1i_J_5bPlUcLDbjKe74NwW3OrczK-euCIQTG6zuRKofXK_6-Um7zMugdcr
    xZFCjT3cOnttIQrhw>
X-ME-Received: <xmr:s6T8Z64R1OzPRJdZWn17aO_va3wrI7g7w4u3mw7yBXTx9ENlo3Xcgm2owFmVow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrvghhsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:s6T8Zz1HedNCV-DrFYRAjS5l4cWg7BthB7hDGMtCeUPskcpYK4-AiQ>
    <xmx:s6T8Z1HnI8_NU04DkgWnNnlNDwJKegUql4zdPzm2W--0ca_5lHDVIQ>
    <xmx:s6T8Z8_frnGiYEall1o-9rUm-ySEUqVpUk95mZ8wZNqrQJKlfIlL6Q>
    <xmx:s6T8Z6nW-st9YS9_gQwRVH8jWx6w_mReWNh8WclYT4JQeRPlOFIrmg>
    <xmx:tKT8Z9EIJrHJb-njXYp937l1sd6zB-E9CxZeGlSGprpyG6Z0HVXTShGW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:23 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Date: Sun, 13 Apr 2025 23:00:51 -0700
Message-ID: <20250414060055.341516-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414060055.341516-1-boqun.feng@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
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
2.47.1


