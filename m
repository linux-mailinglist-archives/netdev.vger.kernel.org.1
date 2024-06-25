Return-Path: <netdev+bounces-106488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17B91698B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC4DB2120B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063716B397;
	Tue, 25 Jun 2024 13:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954311607A7;
	Tue, 25 Jun 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323729; cv=none; b=nAedV1NaAjXb3H7HwPm5EanzRf65iobh9DFQUJVOIY9yiIL/KkAUH6KkBn6PfGGlEoGtlHD9dvmIB8yP4o5xwidwb8+ZYPSGb0a+ymSSTS8zMt8VRzswnW70nCQROmGPwH48tfbVwxSTzpHSsPbyAHDHJBSl6QjdWng/5EldG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323729; c=relaxed/simple;
	bh=9PEZ6Jlcg1jlT/A4nUeHkqu3X7cLx1O/8S3pL5RW7CI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6zK6i01/6P/YFNBVVfc1Qoj/GFNm3Sy5TOC2znWO+pVAvUObZ2D2MAqO7Lt0LLiy2xf2ZC4fwpDmrWRmUd1vmFqvdmZELWElwOZzXJSuacszHzjd1f++Oh6e0/yrHOhn65HdWe4H9wV7twxX5vxanAodCtpynxK5ha5n+ti7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7mWv4Nj6zddkK;
	Tue, 25 Jun 2024 21:53:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F6118006E;
	Tue, 25 Jun 2024 21:55:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 21:55:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v9 01/13] mm: page_frag: add a test module for page_frag
Date: Tue, 25 Jun 2024 21:52:04 +0800
Message-ID: <20240625135216.47007-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240625135216.47007-1-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Basing on the lib/objpool.c, change it to something like a
ptrpool, so that we can utilize that to test the correctness
and performance of the page_frag.

The testing is done by ensuring that the fragment allocated
from a frag_frag_cache instance is pushed into a ptrpool
instance in a kthread binded to a specified cpu, and a kthread
binded to a specified cpu will pop the fragment from the
ptrpool and free the fragment.

We may refactor out the common part between objpool and ptrpool
if this ptrpool thing turns out to be helpful for other place.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/Kconfig.debug    |   8 +
 mm/Makefile         |   1 +
 mm/page_frag_test.c | 389 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 mm/page_frag_test.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index afc72fde0f03..1ebcd45f47d4 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -142,6 +142,14 @@ config DEBUG_PAGE_REF
 	  kernel code.  However the runtime performance overhead is virtually
 	  nil until the tracepoints are actually enabled.
 
+config DEBUG_PAGE_FRAG_TEST
+	tristate "Test module for page_frag"
+	default n
+	depends on m && DEBUG_KERNEL
+	help
+	  This builds the "page_frag_test" module that is used to test the
+	  correctness and performance of page_frag's implementation.
+
 config DEBUG_RODATA_TEST
     bool "Testcase for the marking rodata read-only"
     depends on STRICT_KERNEL_RWX
diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1..29d9f7618a33 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
 obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
+obj-$(CONFIG_DEBUG_PAGE_FRAG_TEST) += page_frag_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
new file mode 100644
index 000000000000..5ee3f33b756d
--- /dev/null
+++ b/mm/page_frag_test.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for page_frag cache
+ *
+ * Copyright: linyunsheng@huawei.com
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/irqflags.h>
+#include <linux/cpumask.h>
+#include <linux/log2.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+
+#define OBJPOOL_NR_OBJECT_MAX	BIT(24)
+
+struct objpool_slot {
+	u32 head;
+	u32 tail;
+	u32 last;
+	u32 mask;
+	void *entries[];
+} __packed;
+
+struct objpool_head {
+	int nr_cpus;
+	int capacity;
+	struct objpool_slot **cpu_slots;
+};
+
+/* initialize percpu objpool_slot */
+static void objpool_init_percpu_slot(struct objpool_head *pool,
+				     struct objpool_slot *slot)
+{
+	/* initialize elements of percpu objpool_slot */
+	slot->mask = pool->capacity - 1;
+}
+
+/* allocate and initialize percpu slots */
+static int objpool_init_percpu_slots(struct objpool_head *pool,
+				     int nr_objs, gfp_t gfp)
+{
+	int i;
+
+	for (i = 0; i < pool->nr_cpus; i++) {
+		struct objpool_slot *slot;
+		int size;
+
+		/* skip the cpu node which could never be present */
+		if (!cpu_possible(i))
+			continue;
+
+		size = struct_size(slot, entries, pool->capacity);
+
+		/*
+		 * here we allocate percpu-slot & objs together in a single
+		 * allocation to make it more compact, taking advantage of
+		 * warm caches and TLB hits. in default vmalloc is used to
+		 * reduce the pressure of kernel slab system. as we know,
+		 * minimal size of vmalloc is one page since vmalloc would
+		 * always align the requested size to page size
+		 */
+		if (gfp & GFP_ATOMIC)
+			slot = kmalloc_node(size, gfp, cpu_to_node(i));
+		else
+			slot = __vmalloc_node(size, sizeof(void *), gfp,
+					      cpu_to_node(i),
+					      __builtin_return_address(0));
+		if (!slot)
+			return -ENOMEM;
+
+		memset(slot, 0, size);
+		pool->cpu_slots[i] = slot;
+
+		objpool_init_percpu_slot(pool, slot);
+	}
+
+	return 0;
+}
+
+/* cleanup all percpu slots of the object pool */
+static void objpool_fini_percpu_slots(struct objpool_head *pool)
+{
+	int i;
+
+	if (!pool->cpu_slots)
+		return;
+
+	for (i = 0; i < pool->nr_cpus; i++)
+		kvfree(pool->cpu_slots[i]);
+	kfree(pool->cpu_slots);
+}
+
+/* initialize object pool and pre-allocate objects */
+static int objpool_init(struct objpool_head *pool, int nr_objs, gfp_t gfp)
+{
+	int rc, capacity, slot_size;
+
+	/* check input parameters */
+	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX)
+		return -EINVAL;
+
+	/* calculate capacity of percpu objpool_slot */
+	capacity = roundup_pow_of_two(nr_objs);
+	if (!capacity)
+		return -EINVAL;
+
+	gfp = gfp & ~__GFP_ZERO;
+
+	/* initialize objpool pool */
+	memset(pool, 0, sizeof(struct objpool_head));
+	pool->nr_cpus = nr_cpu_ids;
+	pool->capacity = capacity;
+	slot_size = pool->nr_cpus * sizeof(struct objpool_slot *);
+	pool->cpu_slots = kzalloc(slot_size, gfp);
+	if (!pool->cpu_slots)
+		return -ENOMEM;
+
+	/* initialize per-cpu slots */
+	rc = objpool_init_percpu_slots(pool, nr_objs, gfp);
+	if (rc)
+		objpool_fini_percpu_slots(pool);
+
+	return rc;
+}
+
+/* adding object to slot, abort if the slot was already full */
+static int objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	u32 head, tail;
+
+	/* loading tail and head as a local snapshot, tail first */
+	tail = READ_ONCE(slot->tail);
+
+	do {
+		head = READ_ONCE(slot->head);
+		/* fault caught: something must be wrong */
+		if (unlikely(tail - head >= pool->capacity))
+			return -ENOSPC;
+	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
+
+	/* now the tail position is reserved for the given obj */
+	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
+	/* update sequence to make this obj available for pop() */
+	smp_store_release(&slot->last, tail + 1);
+
+	return 0;
+}
+
+/* reclaim an object to object pool */
+static int objpool_push(void *obj, struct objpool_head *pool)
+{
+	unsigned long flags;
+	int rc;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
+	raw_local_irq_restore(flags);
+
+	return rc;
+}
+
+/* try to retrieve object from slot */
+static void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	/* load head snapshot, other cpus may change it */
+	u32 head = smp_load_acquire(&slot->head);
+
+	while (head != READ_ONCE(slot->last)) {
+		void *obj;
+
+		/*
+		 * data visibility of 'last' and 'head' could be out of
+		 * order since memory updating of 'last' and 'head' are
+		 * performed in push() and pop() independently
+		 *
+		 * before any retrieving attempts, pop() must guarantee
+		 * 'last' is behind 'head', that is to say, there must
+		 * be available objects in slot, which could be ensured
+		 * by condition 'last != head && last - head <= nr_objs'
+		 * that is equivalent to 'last - head - 1 < nr_objs' as
+		 * 'last' and 'head' are both unsigned int32
+		 */
+		if (READ_ONCE(slot->last) - head - 1 >= pool->capacity) {
+			head = READ_ONCE(slot->head);
+			continue;
+		}
+
+		/* obj must be retrieved before moving forward head */
+		obj = READ_ONCE(slot->entries[head & slot->mask]);
+
+		/* move head forward to mark it's consumption */
+		if (try_cmpxchg_release(&slot->head, &head, head + 1))
+			return obj;
+	}
+
+	return NULL;
+}
+
+/* allocate an object from object pool */
+static void *objpool_pop(struct objpool_head *pool)
+{
+	void *obj = NULL;
+	unsigned long flags;
+	int i, cpu;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+
+	cpu = raw_smp_processor_id();
+	for (i = 0; i < num_possible_cpus(); i++) {
+		obj = objpool_try_get_slot(pool, cpu);
+		if (obj)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	}
+	raw_local_irq_restore(flags);
+
+	return obj;
+}
+
+/* release whole objpool forcely */
+static void objpool_free(struct objpool_head *pool)
+{
+	if (!pool->cpu_slots)
+		return;
+
+	/* release percpu slots */
+	objpool_fini_percpu_slots(pool);
+}
+
+static struct objpool_head ptr_pool;
+static int nr_objs = 512;
+static atomic_t nthreads;
+static struct completion wait;
+static struct page_frag_cache test_frag;
+
+static int nr_test = 5120000;
+module_param(nr_test, int, 0);
+MODULE_PARM_DESC(nr_test, "number of iterations to test");
+
+static bool test_align;
+module_param(test_align, bool, 0);
+MODULE_PARM_DESC(test_align, "use align API for testing");
+
+static int test_alloc_len = 2048;
+module_param(test_alloc_len, int, 0);
+MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
+
+static int test_push_cpu;
+module_param(test_push_cpu, int, 0);
+MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
+
+static int test_pop_cpu;
+module_param(test_pop_cpu, int, 0);
+MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
+
+static int page_frag_pop_thread(void *arg)
+{
+	struct objpool_head *pool = arg;
+	int nr = nr_test;
+
+	pr_info("page_frag pop test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (nr > 0) {
+		void *obj = objpool_pop(pool);
+
+		if (obj) {
+			nr--;
+			page_frag_free(obj);
+		} else {
+			cond_resched();
+		}
+	}
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	pr_info("page_frag pop test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	return 0;
+}
+
+static int page_frag_push_thread(void *arg)
+{
+	struct objpool_head *pool = arg;
+	int nr = nr_test;
+
+	pr_info("page_frag push test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (nr > 0) {
+		void *va;
+		int ret;
+
+		if (test_align)
+			va = page_frag_alloc_align(&test_frag, test_alloc_len,
+						   GFP_KERNEL, SMP_CACHE_BYTES);
+		else
+			va = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);
+
+		if (!va)
+			continue;
+
+		ret = objpool_push(va, pool);
+		if (ret) {
+			page_frag_free(va);
+			cond_resched();
+		} else {
+			nr--;
+		}
+	}
+
+	pr_info("page_frag push test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	return 0;
+}
+
+static int __init page_frag_test_init(void)
+{
+	struct task_struct *tsk_push, *tsk_pop;
+	ktime_t start;
+	u64 duration;
+	int ret;
+
+	test_frag.va = NULL;
+	atomic_set(&nthreads, 2);
+	init_completion(&wait);
+
+	if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0)
+		return -EINVAL;
+
+	ret = objpool_init(&ptr_pool, nr_objs, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_pool,
+					 test_push_cpu, "page_frag_push");
+	if (IS_ERR(tsk_push))
+		return PTR_ERR(tsk_push);
+
+	tsk_pop = kthread_create_on_cpu(page_frag_pop_thread, &ptr_pool,
+					test_pop_cpu, "page_frag_pop");
+	if (IS_ERR(tsk_pop)) {
+		kthread_stop(tsk_push);
+		return PTR_ERR(tsk_pop);
+	}
+
+	start = ktime_get();
+	wake_up_process(tsk_push);
+	wake_up_process(tsk_pop);
+
+	pr_info("waiting for test to complete\n");
+	wait_for_completion(&wait);
+
+	duration = (u64)ktime_us_delta(ktime_get(), start);
+	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
+		test_align ? "aligned" : "non-aligned", duration);
+
+	objpool_free(&ptr_pool);
+	page_frag_cache_drain(&test_frag);
+
+	return -EAGAIN;
+}
+
+static void __exit page_frag_test_exit(void)
+{
+}
+
+module_init(page_frag_test_init);
+module_exit(page_frag_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yunsheng Lin <linyunsheng@huawei.com>");
+MODULE_DESCRIPTION("Test module for page_frag");
-- 
2.33.0


