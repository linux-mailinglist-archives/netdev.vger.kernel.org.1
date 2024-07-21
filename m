Return-Path: <netdev+bounces-112333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D859385A8
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231781C20621
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3581667D8;
	Sun, 21 Jul 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeJxNZzA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0F1F5FA;
	Sun, 21 Jul 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583337; cv=none; b=KNWDRDtkWlgVGOcHa7XiTGtBWJTkZM3DrJ3SjpZHm3rdfL0jUOjpATVfjKqbdkHueBETBDuTrSyJOj0k0vXvIZsIgz7sWizJYwz2makRK6wIuiWAcguBp2haNTHL0bPUy643i9SN2kw5WUlTFA7GqQnueN7HYTiyeYGwEZqBoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583337; c=relaxed/simple;
	bh=u0bKMacT8yp9qFHKyTLcKJi5OF03HhMW70P3wZKBGtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4sEcc1Ed1XcnW09MMaiFnMSEvrJY7FuG1OW+Tg09Yg+FtPnJjRvfkN0IMffcngxnbFDn3vvi9gLgmKieRzUzkvPrYDFM50nsMkbwetLW3tXsQau/rS0Qtgzd9Mq0QBcGii5OdWBo/GeORhy96FKIUIDRkRSO8aH/M2+NgYpdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeJxNZzA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so1377263f8f.3;
        Sun, 21 Jul 2024 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721583334; x=1722188134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1wRN2geVh1OnVHbu9p6xPlPkrXgHozUglD7BZEKzJI=;
        b=PeJxNZzABkFxqCcs82fPuHsFOYGc4p366/yzMNlNx0Lqk9/HqlibSEOXGRymCnNXgo
         5XC5GNB5ERno4/kCSi4dN4sCSlI0UDugjvIbPo5jf3brVPHClX5W9gkPnhalI8js/slS
         3exazhUCjQX50FKuqb/rqs2ah7bhOxm2p1JkdO6a0IBLhiexP9mO3vaAISfMvBM8l7nB
         g/tr6ipxNGr1X/+fc7EG5WiPuSUaAruGaHAbho/P9E/sq20pqglCvPnwgPMdvgX3Y5zh
         ij6Twr+NMsmX9dCDpihcZ9aJZ8kggxVg7mBXIfuJj90azhzkFS294ii+sHVrCxJn/4Cc
         gaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721583334; x=1722188134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1wRN2geVh1OnVHbu9p6xPlPkrXgHozUglD7BZEKzJI=;
        b=v0m9m6pt8YqFwgYtOkyLmD2CMzSgp4g2/Dx1+diJDw/eM2he7PIaNmU/q3DQOXNYm6
         uGsMDHSiAyXQjoZxQ53e47nVZ4ZOW9aDpayB3FI64dab5EcHpi5eU+FbpaaJ+3+9SvCg
         pP4w3xhOHt343SagyY+khAqdivfBd7shcyL6L3abBVpOn4vK03ibYwp4AGGKtfNMcRk9
         sTGAslt9asxyH6BOU/bApXgleN8tYdLhDiMVddPezvMNFaFlZnKkSnC8RiHwYcXE7CM+
         2X7lKQw0m+ECD6puZtEFdnrVdPgTvaS+gRtn1rlaiuqwKUk8OwWOzLrFtoSqWQz6ISwU
         iR3g==
X-Forwarded-Encrypted: i=1; AJvYcCVGEySxgo6sIbGk4kBk2q+KolKdNuXJYyCkd42FbR2h1D8fK8bwBpbYOvSNW1TTCTE4I6YSvWuaoQIyKz98kif24FnOtZ66RrbaVyp971wkmA6MkG95rXWvb3O95kk/PGI7LBe8
X-Gm-Message-State: AOJu0YxPxTteJi+ewGrnN5PpztmIHHkWEQ0HloUDgelRdM/em06kvauq
	s6msboCiJ2pKDvYtrGUu0XTFwlfUE2s0LGzztLJ48od7SyXRB2srp8UWUM1avVsEo7yM4N71tje
	ud1qsorizWgOyACGTVPUKCpInpc5UOw==
X-Google-Smtp-Source: AGHT+IFT0z+ALrh1cjd6ka7TygbKMaAUuNH/SrxDViyEpG5pa7L4Q8NZul/aUGoTDbPTPRFPbBVlQbtvk2r1lteSDHI=
X-Received: by 2002:a5d:522a:0:b0:368:3789:1b6 with SMTP id
 ffacd0b85a97d-369bb09fe9cmr2679197f8f.47.1721583333607; Sun, 21 Jul 2024
 10:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com> <20240719093338.55117-2-linyunsheng@huawei.com>
In-Reply-To: <20240719093338.55117-2-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Jul 2024 10:34:56 -0700
Message-ID: <CAKgT0UcsBGKR+AGU6wDUpXY48FnEA4hdvvti-YC87=8zfGPLdg@mail.gmail.com>
Subject: Re: [RFC v11 01/14] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:36=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Basing on the lib/objpool.c, change it to something like a
> ptrpool, so that we can utilize that to test the correctness
> and performance of the page_frag.
>
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptrpool
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptrpool and free the fragment.
>
> We may refactor out the common part between objpool and ptrpool
> if this ptrpool thing turns out to be helpful for other place.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/Kconfig.debug    |   8 +
>  mm/Makefile         |   1 +
>  mm/page_frag_test.c | 393 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 402 insertions(+)
>  create mode 100644 mm/page_frag_test.c

I might have missed it somewhere. Is there any reason why this isn't
in the selftests/mm/ directory? Seems like that would be a better fit
for this.

> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index afc72fde0f03..1ebcd45f47d4 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -142,6 +142,14 @@ config DEBUG_PAGE_REF
>           kernel code.  However the runtime performance overhead is virtu=
ally
>           nil until the tracepoints are actually enabled.
>
> +config DEBUG_PAGE_FRAG_TEST

This isn't a "DEBUG" feature. This is a test feature.

> +       tristate "Test module for page_frag"
> +       default n
> +       depends on m && DEBUG_KERNEL

I am not sure it is valid to have a tristate depend on being built as a mod=
ule.

I think if you can set it up as a selftest it will have broader use as
you could compile it against any target kernel going forward and add
it as a module rather than having to build it as a part of a debug
kernel.

> +       help
> +         This builds the "page_frag_test" module that is used to test th=
e
> +         correctness and performance of page_frag's implementation.
> +
>  config DEBUG_RODATA_TEST
>      bool "Testcase for the marking rodata read-only"
>      depends on STRICT_KERNEL_RWX
> diff --git a/mm/Makefile b/mm/Makefile
> index 8fb85acda1b1..29d9f7618a33 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_MEMORY_FAILURE) +=3D memory-failure.o
>  obj-$(CONFIG_HWPOISON_INJECT) +=3D hwpoison-inject.o
>  obj-$(CONFIG_DEBUG_KMEMLEAK) +=3D kmemleak.o
>  obj-$(CONFIG_DEBUG_RODATA_TEST) +=3D rodata_test.o
> +obj-$(CONFIG_DEBUG_PAGE_FRAG_TEST) +=3D page_frag_test.o
>  obj-$(CONFIG_DEBUG_VM_PGTABLE) +=3D debug_vm_pgtable.o
>  obj-$(CONFIG_PAGE_OWNER) +=3D page_owner.o
>  obj-$(CONFIG_MEMORY_ISOLATION) +=3D page_isolation.o
> diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
> new file mode 100644
> index 000000000000..cf2691f60b67
> --- /dev/null
> +++ b/mm/page_frag_test.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test module for page_frag cache
> + *
> + * Copyright: linyunsheng@huawei.com
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/atomic.h>
> +#include <linux/irqflags.h>
> +#include <linux/cpumask.h>
> +#include <linux/log2.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +
> +#define OBJPOOL_NR_OBJECT_MAX  BIT(24)
> +
> +struct objpool_slot {
> +       u32 head;
> +       u32 tail;
> +       u32 last;
> +       u32 mask;
> +       void *entries[];
> +} __packed;
> +
> +struct objpool_head {
> +       int nr_cpus;
> +       int capacity;
> +       struct objpool_slot **cpu_slots;
> +};
> +
> +/* initialize percpu objpool_slot */
> +static void objpool_init_percpu_slot(struct objpool_head *pool,
> +                                    struct objpool_slot *slot)
> +{
> +       /* initialize elements of percpu objpool_slot */
> +       slot->mask =3D pool->capacity - 1;
> +}
> +
> +/* allocate and initialize percpu slots */
> +static int objpool_init_percpu_slots(struct objpool_head *pool,
> +                                    int nr_objs, gfp_t gfp)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < pool->nr_cpus; i++) {
> +               struct objpool_slot *slot;
> +               int size;
> +
> +               /* skip the cpu node which could never be present */
> +               if (!cpu_possible(i))
> +                       continue;
> +
> +               size =3D struct_size(slot, entries, pool->capacity);
> +
> +               /*
> +                * here we allocate percpu-slot & objs together in a sing=
le
> +                * allocation to make it more compact, taking advantage o=
f
> +                * warm caches and TLB hits. in default vmalloc is used t=
o
> +                * reduce the pressure of kernel slab system. as we know,
> +                * minimal size of vmalloc is one page since vmalloc woul=
d
> +                * always align the requested size to page size
> +                */
> +               if (gfp & GFP_ATOMIC)
> +                       slot =3D kmalloc_node(size, gfp, cpu_to_node(i));
> +               else
> +                       slot =3D __vmalloc_node(size, sizeof(void *), gfp=
,
> +                                             cpu_to_node(i),
> +                                             __builtin_return_address(0)=
);

When would anyone ever call this with atomic? This is just for your
test isn't it?

> +               if (!slot)
> +                       return -ENOMEM;
> +
> +               memset(slot, 0, size);
> +               pool->cpu_slots[i] =3D slot;
> +
> +               objpool_init_percpu_slot(pool, slot);
> +       }
> +
> +       return 0;
> +}
> +
> +/* cleanup all percpu slots of the object pool */
> +static void objpool_fini_percpu_slots(struct objpool_head *pool)
> +{
> +       int i;
> +
> +       if (!pool->cpu_slots)
> +               return;
> +
> +       for (i =3D 0; i < pool->nr_cpus; i++)
> +               kvfree(pool->cpu_slots[i]);
> +       kfree(pool->cpu_slots);
> +}
> +
> +/* initialize object pool and pre-allocate objects */
> +static int objpool_init(struct objpool_head *pool, int nr_objs, gfp_t gf=
p)
> +{
> +       int rc, capacity, slot_size;
> +
> +       /* check input parameters */
> +       if (nr_objs <=3D 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX)
> +               return -EINVAL;
> +
> +       /* calculate capacity of percpu objpool_slot */
> +       capacity =3D roundup_pow_of_two(nr_objs);
> +       if (!capacity)
> +               return -EINVAL;
> +
> +       gfp =3D gfp & ~__GFP_ZERO;
> +
> +       /* initialize objpool pool */
> +       memset(pool, 0, sizeof(struct objpool_head));
> +       pool->nr_cpus =3D nr_cpu_ids;
> +       pool->capacity =3D capacity;
> +       slot_size =3D pool->nr_cpus * sizeof(struct objpool_slot *);
> +       pool->cpu_slots =3D kzalloc(slot_size, gfp);
> +       if (!pool->cpu_slots)
> +               return -ENOMEM;
> +
> +       /* initialize per-cpu slots */
> +       rc =3D objpool_init_percpu_slots(pool, nr_objs, gfp);
> +       if (rc)
> +               objpool_fini_percpu_slots(pool);
> +
> +       return rc;
> +}
> +
> +/* adding object to slot, abort if the slot was already full */
> +static int objpool_try_add_slot(void *obj, struct objpool_head *pool, in=
t cpu)
> +{
> +       struct objpool_slot *slot =3D pool->cpu_slots[cpu];
> +       u32 head, tail;
> +
> +       /* loading tail and head as a local snapshot, tail first */
> +       tail =3D READ_ONCE(slot->tail);
> +
> +       do {
> +               head =3D READ_ONCE(slot->head);
> +               /* fault caught: something must be wrong */
> +               if (unlikely(tail - head >=3D pool->capacity))
> +                       return -ENOSPC;
> +       } while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +
> +       /* now the tail position is reserved for the given obj */
> +       WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> +       /* update sequence to make this obj available for pop() */
> +       smp_store_release(&slot->last, tail + 1);
> +
> +       return 0;
> +}
> +
> +/* reclaim an object to object pool */
> +static int objpool_push(void *obj, struct objpool_head *pool)
> +{
> +       unsigned long flags;
> +       int rc;
> +
> +       /* disable local irq to avoid preemption & interruption */
> +       raw_local_irq_save(flags);
> +       rc =3D objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> +       raw_local_irq_restore(flags);
> +
> +       return rc;
> +}
> +
> +/* try to retrieve object from slot */
> +static void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
> +{
> +       struct objpool_slot *slot =3D pool->cpu_slots[cpu];
> +       /* load head snapshot, other cpus may change it */
> +       u32 head =3D smp_load_acquire(&slot->head);
> +
> +       while (head !=3D READ_ONCE(slot->last)) {
> +               void *obj;
> +
> +               /*
> +                * data visibility of 'last' and 'head' could be out of
> +                * order since memory updating of 'last' and 'head' are
> +                * performed in push() and pop() independently
> +                *
> +                * before any retrieving attempts, pop() must guarantee
> +                * 'last' is behind 'head', that is to say, there must
> +                * be available objects in slot, which could be ensured
> +                * by condition 'last !=3D head && last - head <=3D nr_ob=
js'
> +                * that is equivalent to 'last - head - 1 < nr_objs' as
> +                * 'last' and 'head' are both unsigned int32
> +                */
> +               if (READ_ONCE(slot->last) - head - 1 >=3D pool->capacity)=
 {
> +                       head =3D READ_ONCE(slot->head);
> +                       continue;
> +               }
> +
> +               /* obj must be retrieved before moving forward head */
> +               obj =3D READ_ONCE(slot->entries[head & slot->mask]);
> +
> +               /* move head forward to mark it's consumption */
> +               if (try_cmpxchg_release(&slot->head, &head, head + 1))
> +                       return obj;
> +       }
> +
> +       return NULL;
> +}
> +
> +/* allocate an object from object pool */
> +static void *objpool_pop(struct objpool_head *pool)
> +{
> +       void *obj =3D NULL;
> +       unsigned long flags;
> +       int i, cpu;
> +
> +       /* disable local irq to avoid preemption & interruption */
> +       raw_local_irq_save(flags);
> +
> +       cpu =3D raw_smp_processor_id();
> +       for (i =3D 0; i < num_possible_cpus(); i++) {
> +               obj =3D objpool_try_get_slot(pool, cpu);
> +               if (obj)
> +                       break;
> +               cpu =3D cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
> +       }
> +       raw_local_irq_restore(flags);
> +
> +       return obj;
> +}
> +
> +/* release whole objpool forcely */
> +static void objpool_free(struct objpool_head *pool)
> +{
> +       if (!pool->cpu_slots)
> +               return;
> +
> +       /* release percpu slots */
> +       objpool_fini_percpu_slots(pool);
> +}
> +

Why add all this extra objpool overhead? This seems like overkill for
what should be a simple test. Seems like you should just need a simple
array located on one of your CPUs. I'm not sure what is with all the
extra overhead being added here.

> +static struct objpool_head ptr_pool;
> +static int nr_objs =3D 512;
> +static atomic_t nthreads;
> +static struct completion wait;
> +static struct page_frag_cache test_frag;
> +
> +static int nr_test =3D 5120000;
> +module_param(nr_test, int, 0);
> +MODULE_PARM_DESC(nr_test, "number of iterations to test");
> +
> +static bool test_align;
> +module_param(test_align, bool, 0);
> +MODULE_PARM_DESC(test_align, "use align API for testing");
> +
> +static int test_alloc_len =3D 2048;
> +module_param(test_alloc_len, int, 0);
> +MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
> +
> +static int test_push_cpu;
> +module_param(test_push_cpu, int, 0);
> +MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
> +
> +static int test_pop_cpu;
> +module_param(test_pop_cpu, int, 0);
> +MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
> +
> +static int page_frag_pop_thread(void *arg)
> +{
> +       struct objpool_head *pool =3D arg;
> +       int nr =3D nr_test;
> +
> +       pr_info("page_frag pop test thread begins on cpu %d\n",
> +               smp_processor_id());
> +
> +       while (nr > 0) {
> +               void *obj =3D objpool_pop(pool);
> +
> +               if (obj) {
> +                       nr--;
> +                       page_frag_free(obj);
> +               } else {
> +                       cond_resched();
> +               }
> +       }
> +
> +       if (atomic_dec_and_test(&nthreads))
> +               complete(&wait);
> +
> +       pr_info("page_frag pop test thread exits on cpu %d\n",
> +               smp_processor_id());
> +
> +       return 0;
> +}
> +
> +static int page_frag_push_thread(void *arg)
> +{
> +       struct objpool_head *pool =3D arg;
> +       int nr =3D nr_test;
> +
> +       pr_info("page_frag push test thread begins on cpu %d\n",
> +               smp_processor_id());
> +
> +       while (nr > 0) {
> +               void *va;
> +               int ret;
> +
> +               if (test_align) {
> +                       va =3D page_frag_alloc_align(&test_frag, test_all=
oc_len,
> +                                                  GFP_KERNEL, SMP_CACHE_=
BYTES);
> +
> +                       WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - =
1),
> +                                 "unaligned va returned\n");
> +               } else {
> +                       va =3D page_frag_alloc(&test_frag, test_alloc_len=
, GFP_KERNEL);
> +               }
> +
> +               if (!va)
> +                       continue;
> +
> +               ret =3D objpool_push(va, pool);
> +               if (ret) {
> +                       page_frag_free(va);
> +                       cond_resched();
> +               } else {
> +                       nr--;
> +               }
> +       }
> +
> +       pr_info("page_frag push test thread exits on cpu %d\n",
> +               smp_processor_id());
> +
> +       if (atomic_dec_and_test(&nthreads))
> +               complete(&wait);
> +
> +       return 0;
> +}
> +

So looking over these functions they seem to overlook how the network
stack works in many cases. One of the main motivations for the page
frags approach is page recycling. For example with GRO enabled the
headers allocated to record the frags might be freed for all but the
first. As such you can end up with 17 fragments being allocated, and
16 freed within the same thread as NAPI will just be recycling the
buffers.

With this setup it doesn't seem very likely to be triggered since you
are operating in two threads. One test you might want to look at
adding is a test where you are allocating and freeing in the same
thread at a fairly constant rate to test against the "ideal" scenario.

> +static int __init page_frag_test_init(void)
> +{
> +       struct task_struct *tsk_push, *tsk_pop;
> +       ktime_t start;
> +       u64 duration;
> +       int ret;
> +
> +       test_frag.va =3D NULL;
> +       atomic_set(&nthreads, 2);
> +       init_completion(&wait);
> +
> +       if (test_alloc_len > PAGE_SIZE || test_alloc_len <=3D 0)
> +               return -EINVAL;
> +
> +       ret =3D objpool_init(&ptr_pool, nr_objs, GFP_KERNEL);
> +       if (ret)
> +               return ret;
> +
> +       tsk_push =3D kthread_create_on_cpu(page_frag_push_thread, &ptr_po=
ol,
> +                                        test_push_cpu, "page_frag_push")=
;
> +       if (IS_ERR(tsk_push))
> +               return PTR_ERR(tsk_push);
> +
> +       tsk_pop =3D kthread_create_on_cpu(page_frag_pop_thread, &ptr_pool=
,
> +                                       test_pop_cpu, "page_frag_pop");
> +       if (IS_ERR(tsk_pop)) {
> +               kthread_stop(tsk_push);
> +               return PTR_ERR(tsk_pop);
> +       }
> +
> +       start =3D ktime_get();
> +       wake_up_process(tsk_push);
> +       wake_up_process(tsk_pop);
> +
> +       pr_info("waiting for test to complete\n");
> +       wait_for_completion(&wait);
> +
> +       duration =3D (u64)ktime_us_delta(ktime_get(), start);
> +       pr_info("%d of iterations for %s testing took: %lluus\n", nr_test=
,
> +               test_align ? "aligned" : "non-aligned", duration);
> +
> +       objpool_free(&ptr_pool);
> +       page_frag_cache_drain(&test_frag);
> +
> +       return -EAGAIN;
> +}
> +
> +static void __exit page_frag_test_exit(void)
> +{
> +}
> +
> +module_init(page_frag_test_init);
> +module_exit(page_frag_test_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yunsheng Lin <linyunsheng@huawei.com>");
> +MODULE_DESCRIPTION("Test module for page_frag");
> --
> 2.33.0
>

