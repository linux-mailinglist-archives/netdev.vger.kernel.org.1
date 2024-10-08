Return-Path: <netdev+bounces-133300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D319957F4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D110E1F22CAC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD633213EF6;
	Tue,  8 Oct 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0VlMrnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68971E0488
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417370; cv=none; b=TN7nYG4858K8VIkNWMfGoPtAs0N8dsA/tOzdWI7vyNMOYCS1q4oiyyBX5F2s6/Jpde7vJVajiC94opTPOyM3SsrNynU+5aZSRgG9XyEWes4tnfdBvbmLW6ZiI51wwEzhE26QU17YQEVsnNQShHdQ1GIMgNe2B9TXbigyFHlwybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417370; c=relaxed/simple;
	bh=BlMociG+9VPQCetw24ErmbohkXazpLpbe9/p/hgBKFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXjvpEzMSr4sQlOcB2/osdFCiFLKveQBDFJ3an9vTeuZ1r/HDFIJnAWaQA57nMNjJq9382ist2goGb/zraGsVw3+QcUJDF4Q+BHCgzs6EgL3NeWjrqLihTnMRdr9FThdk8skSBeaEiIPyiTdWTfFcEETMw8CT5fy4e0lM7eRT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0VlMrnF; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a341ab4573so25421945ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728417368; x=1729022168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4vn+4lLSvAqRJ8lycEHTPdIKM80bx3ygsBdojCZ4zw=;
        b=C0VlMrnFHDY4arpocTRu/6UapXOjBehKj8U4UmOZFjLA0oHNCCrq89ue1FpKCLvxTM
         yQlr06iTUrTGAgJcaCYW4iVgttjXFO1e3eSyH/ApOyLLtcipOlfItSb8j8hlDeAqHLMn
         MX3pegAC1bVEhJ2OdHLOK2x1XsLnvF+X4GGYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417368; x=1729022168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4vn+4lLSvAqRJ8lycEHTPdIKM80bx3ygsBdojCZ4zw=;
        b=OafuHyYmrsNIl3HX/WMDaMPL13fUrPRxzdoRCA+HCT2hO+wlUv9slNaB6HeZfE9hj9
         RPmuETti8zEtZHi9LSQitRn9nnak2o5wTlqax1hK86Ka3l3VJ2X3ihCpUKX4Iyd0K2wh
         9GHE5ECAUNFzy7mP/1FJSJyLVZHQb7kiak2i9hLGK4NeF+xtMgnRGslaeUTxTW6jXV67
         lwMYGBaxS+/fRm70wIvHlr7zAJikG92uWa8J2oRao/xr3o5YXRDyLJIRoU6j0g5O+5aY
         gCWiRYsgCFCQCilPmhphsH9XzBzcoCSCQcxLlQq2vLXXqsTB/bppoW/QNNpX27sJv8/j
         FcWA==
X-Gm-Message-State: AOJu0YzDzJ66/f8NqnO52BHNUmUz0ho7ApnCtiP1DjL1N7wcGO/qD2b/
	UZNn1IHt7yg7GA49cbpLH6dMplDWjxl+bjDgbDfG2TH82CyMwQlAmPcwrAyb7BY=
X-Google-Smtp-Source: AGHT+IGy1JUD7mrjzrplO29fC4VCeuozkUy5c3M+kAWfdgfyzeeyzoIph75DLODLXY/7EB1kP/WFgQ==
X-Received: by 2002:a05:6e02:b41:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a397ce4ed9mr475555ab.7.1728417367678;
        Tue, 08 Oct 2024 12:56:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db900b6b4dsm738208173.98.2024.10.08.12.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 12:56:07 -0700 (PDT)
Message-ID: <cb1acab0-a4c9-4e31-b6f6-70b8049f1663@linuxfoundation.org>
Date: Tue, 8 Oct 2024 13:56:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/14] mm: page_frag: add a test module for
 page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-2-linyunsheng@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008112049.2279307-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 05:20, Yunsheng Lin wrote:
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptr_ring
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptr_ring and free the fragment.
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

Signed-off-by should be last. Same comment on all the other
patches in this series. When you have 4 patches, it is a good
practice to add cover-letter.

> ---
>   tools/testing/selftests/mm/Makefile           |   3 +
>   tools/testing/selftests/mm/page_frag/Makefile |  18 ++
>   .../selftests/mm/page_frag/page_frag_test.c   | 173 ++++++++++++++++++
>   tools/testing/selftests/mm/run_vmtests.sh     |   8 +
>   tools/testing/selftests/mm/test_page_frag.sh  | 171 +++++++++++++++++
>   5 files changed, 373 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
>   create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
>   create mode 100755 tools/testing/selftests/mm/test_page_frag.sh
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 02e1204971b0..acec529baaca 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -36,6 +36,8 @@ MAKEFLAGS += --no-builtin-rules
>   CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>   LDLIBS = -lrt -lpthread -lm
>   
> +TEST_GEN_MODS_DIR := page_frag
> +
>   TEST_GEN_FILES = cow
>   TEST_GEN_FILES += compaction_test
>   TEST_GEN_FILES += gup_longterm
> @@ -126,6 +128,7 @@ TEST_FILES += test_hmm.sh
>   TEST_FILES += va_high_addr_switch.sh
>   TEST_FILES += charge_reserved_hugetlb.sh
>   TEST_FILES += hugetlb_reparenting_test.sh
> +TEST_FILES += test_page_frag.sh
>   
>   # required by charge_reserved_hugetlb.sh
>   TEST_FILES += write_hugetlb_memory.sh
> diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
> new file mode 100644
> index 000000000000..58dda74d50a3
> --- /dev/null
> +++ b/tools/testing/selftests/mm/page_frag/Makefile
> @@ -0,0 +1,18 @@
> +PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +MODULES = page_frag_test.ko
> +
> +obj-m += page_frag_test.o
> +
> +all:
> +	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) modules
> +
> +clean:
> +	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) clean
> diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
> new file mode 100644
> index 000000000000..eeb2b6bc681a
> --- /dev/null
> +++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0

I think this would throw a checkpatch warning about
comment should be "/*" and not "//"
> +
> +/*
> + * Test module for page_frag cache
> + *
> + * Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/cpumask.h>
> +#include <linux/completion.h>
> +#include <linux/ptr_ring.h>
> +#include <linux/kthread.h>
> +
> +static struct ptr_ring ptr_ring;
> +static int nr_objs = 512;
> +static atomic_t nthreads;
> +static struct completion wait;
> +static struct page_frag_cache test_nc;
> +static int test_popped;
> +static int test_pushed;
> +
> +static int nr_test = 2000000;
> +module_param(nr_test, int, 0);
> +MODULE_PARM_DESC(nr_test, "number of iterations to test");
> +
> +static bool test_align;
> +module_param(test_align, bool, 0);
> +MODULE_PARM_DESC(test_align, "use align API for testing");
> +
> +static int test_alloc_len = 2048;
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
> +	struct ptr_ring *ring = arg;
> +
> +	pr_info("page_frag pop test thread begins on cpu %d\n",
> +		smp_processor_id());
> +
> +	while (test_popped < nr_test) {
> +		void *obj = __ptr_ring_consume(ring);
> +
> +		if (obj) {
> +			test_popped++;
> +			page_frag_free(obj);
> +		} else {
> +			cond_resched();
> +		}
> +	}
> +
> +	if (atomic_dec_and_test(&nthreads))
> +		complete(&wait);
> +
> +	pr_info("page_frag pop test thread exits on cpu %d\n",
> +		smp_processor_id());
> +
> +	return 0;
> +}
> +
> +static int page_frag_push_thread(void *arg)
> +{
> +	struct ptr_ring *ring = arg;
> +
> +	pr_info("page_frag push test thread begins on cpu %d\n",
> +		smp_processor_id());
> +
> +	while (test_pushed < nr_test) {
> +		void *va;
> +		int ret;
> +
> +		if (test_align) {
> +			va = page_frag_alloc_align(&test_nc, test_alloc_len,
> +						   GFP_KERNEL, SMP_CACHE_BYTES);
> +
> +			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
> +				  "unaligned va returned\n");
> +		} else {
> +			va = page_frag_alloc(&test_nc, test_alloc_len, GFP_KERNEL);
> +		}
> +
> +		if (!va)
> +			continue;
> +
> +		ret = __ptr_ring_produce(ring, va);
> +		if (ret) {
> +			page_frag_free(va);
> +			cond_resched();
> +		} else {
> +			test_pushed++;
> +		}
> +	}
> +
> +	pr_info("page_frag push test thread exits on cpu %d\n",
> +		smp_processor_id());
> +
> +	if (atomic_dec_and_test(&nthreads))
> +		complete(&wait);
> +
> +	return 0;
> +}
> +
> +static int __init page_frag_test_init(void)
> +{
> +	struct task_struct *tsk_push, *tsk_pop;
> +	ktime_t start;
> +	u64 duration;
> +	int ret;
> +
> +	test_nc.va = NULL;
> +	atomic_set(&nthreads, 2);
> +	init_completion(&wait);
> +
> +	if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0 ||
> +	    !cpu_active(test_push_cpu) || !cpu_active(test_pop_cpu))
> +		return -EINVAL;
> +
> +	ret = ptr_ring_init(&ptr_ring, nr_objs, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_ring,
> +					 test_push_cpu, "page_frag_push");
> +	if (IS_ERR(tsk_push))
> +		return PTR_ERR(tsk_push);
> +
> +	tsk_pop = kthread_create_on_cpu(page_frag_pop_thread, &ptr_ring,
> +					test_pop_cpu, "page_frag_pop");
> +	if (IS_ERR(tsk_pop)) {
> +		kthread_stop(tsk_push);
> +		return PTR_ERR(tsk_pop);
> +	}
> +
> +	start = ktime_get();
> +	wake_up_process(tsk_push);
> +	wake_up_process(tsk_pop);
> +
> +	pr_info("waiting for test to complete\n");
> +
> +	while (!wait_for_completion_timeout(&wait, msecs_to_jiffies(10000)))
> +		pr_info("page_frag_test progress: pushed = %d, popped = %d\n",
> +			test_pushed, test_popped);
> +
> +	duration = (u64)ktime_us_delta(ktime_get(), start);
> +	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
> +		test_align ? "aligned" : "non-aligned", duration);
> +
> +	ptr_ring_cleanup(&ptr_ring, NULL);
> +	page_frag_cache_drain(&test_nc);
> +
> +	return -EAGAIN;
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
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c5797ad1d37b..2c5394584af4 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -75,6 +75,8 @@ separated by spaces:
>   	read-only VMAs
>   - mdwe
>   	test prctl(PR_SET_MDWE, ...)
> +- page_frag
> +	test handling of page fragment allocation and freeing
>   
>   example: ./run_vmtests.sh -t "hmm mmap ksm"
>   EOF
> @@ -456,6 +458,12 @@ CATEGORY="mkdirty" run_test ./mkdirty
>   
>   CATEGORY="mdwe" run_test ./mdwe_test
>   
> +CATEGORY="page_frag" run_test ./test_page_frag.sh smoke
> +
> +CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
> +
> +CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
> +
>   echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
>   echo "1..${count_total}" | tap_output
>   
> diff --git a/tools/testing/selftests/mm/test_page_frag.sh b/tools/testing/selftests/mm/test_page_frag.sh
> new file mode 100755
> index 000000000000..d750d910c899
> --- /dev/null
> +++ b/tools/testing/selftests/mm/test_page_frag.sh
> @@ -0,0 +1,171 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
> +# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
> +#
> +# This is a test script for the kernel test driver to test the
> +# correctness and performance of page_frag's implementation.
> +# Therefore it is just a kernel module loader. You can specify
> +# and pass different parameters in order to:
> +#     a) analyse performance of page fragment allocations;
> +#     b) stressing and stability check of page_frag subsystem.
> +
> +DRIVER="./page_frag/page_frag_test.ko"
> +CPU_LIST=$(grep -m 2 processor /proc/cpuinfo | cut -d ' ' -f 2)
> +TEST_CPU_0=$(echo $CPU_LIST | awk '{print $1}')
> +
> +if [ $(echo $CPU_LIST | wc -w) -gt 1 ]; then
> +	TEST_CPU_1=$(echo $CPU_LIST | awk '{print $2}')
> +	NR_TEST=100000000
> +else
> +	TEST_CPU_1=$TEST_CPU_0
> +	NR_TEST=1000000
> +fi
> +
> +# 1 if fails
> +exitcode=1
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +#
> +# Static templates for testing of page_frag APIs.
> +# Also it is possible to pass any supported parameters manually.
> +#
> +SMOKE_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_1"
> +NONALIGNED_PARAM="$SMOKE_PARAM test_alloc_len=75 nr_test=$NR_TEST"
> +ALIGNED_PARAM="$NONALIGNED_PARAM test_align=1"
> +
> +check_test_requirements()
> +{
> +	uid=$(id -u)
> +	if [ $uid -ne 0 ]; then
> +		echo "$0: Must be run as root"
> +		exit $ksft_skip
> +	fi
> +
> +	if ! which insmod > /dev/null 2>&1; then
> +		echo "$0: You need insmod installed"
> +		exit $ksft_skip
> +	fi
> +
> +	if [ ! -f $DRIVER ]; then
> +		echo "$0: You need to compile page_frag_test module"
> +		exit $ksft_skip
> +	fi
> +}
> +
> +run_nonaligned_check()
> +{
> +	echo "Run performance tests to evaluate how fast nonaligned alloc API is."
> +
> +	insmod $DRIVER $NONALIGNED_PARAM > /dev/null 2>&1
> +	echo "Done."
> +	echo "Check the kernel ring buffer to see the summary."
> +}
> +
> +run_aligned_check()
> +{
> +	echo "Run performance tests to evaluate how fast aligned alloc API is."
> +
> +	insmod $DRIVER $ALIGNED_PARAM > /dev/null 2>&1
> +	echo "Done."
> +	echo "Check the kernel ring buffer to see the summary."
> +}
> +
> +run_smoke_check()
> +{
> +	echo "Run smoke test."
> +
> +	insmod $DRIVER $SMOKE_PARAM > /dev/null 2>&1
> +	echo "Done."
> +	echo "Check the kernel ring buffer to see the summary."
> +}
> +
> +usage()
> +{
> +	echo -n "Usage: $0 [ aligned ] | [ nonaligned ] | | [ smoke ] | "
> +	echo "manual parameters"
> +	echo
> +	echo "Valid tests and parameters:"
> +	echo
> +	modinfo $DRIVER
> +	echo
> +	echo "Example usage:"
> +	echo
> +	echo "# Shows help message"
> +	echo "$0"
> +	echo
> +	echo "# Smoke testing"
> +	echo "$0 smoke"
> +	echo
> +	echo "# Performance testing for nonaligned alloc API"
> +	echo "$0 nonaligned"
> +	echo
> +	echo "# Performance testing for aligned alloc API"
> +	echo "$0 aligned"
> +	echo
> +	exit 0
> +}
> +
> +function validate_passed_args()
> +{
> +	VALID_ARGS=`modinfo $DRIVER | awk '/parm:/ {print $2}' | sed 's/:.*//'`
> +
> +	#
> +	# Something has been passed, check it.
> +	#
> +	for passed_arg in $@; do
> +		key=${passed_arg//=*/}
> +		valid=0
> +
> +		for valid_arg in $VALID_ARGS; do
> +			if [[ $key = $valid_arg ]]; then
> +				valid=1
> +				break
> +			fi
> +		done
> +
> +		if [[ $valid -ne 1 ]]; then
> +			echo "Error: key is not correct: ${key}"
> +			exit $exitcode
> +		fi
> +	done
> +}
> +
> +function run_manual_check()
> +{
> +	#
> +	# Validate passed parameters. If there is wrong one,
> +	# the script exists and does not execute further.
> +	#
> +	validate_passed_args $@
> +
> +	echo "Run the test with following parameters: $@"

Is this marker good enough to isolate the test results in the
dmesg? Include the test name in the message.


> +	insmod $DRIVER $@ > /dev/null 2>&1
> +	echo "Done."

Is this marker good enough to isolate the test results in the
dmesg? Include the test name in the message.

> +	echo "Check the kernel ring buffer to see the summary."

Usually the test would run dmesg and filter out the test results
from the dmesg and include them in the test script output.

You can refer to other tests that do that: powerpc/scripts/hmi.sh
is one example.

> +}
> +
> +function run_test()
> +{
> +	if [ $# -eq 0 ]; then
> +		usage
> +	else
> +		if [[ "$1" = "smoke" ]]; then
> +			run_smoke_check
> +		elif [[ "$1" = "nonaligned" ]]; then
> +			run_nonaligned_check
> +		elif [[ "$1" = "aligned" ]]; then
> +			run_aligned_check
> +		else
> +			run_manual_check $@
> +		fi
> +	fi
> +}
> +
> +check_test_requirements
> +run_test $@
> +
> +exit 0

thanks,
-- Shuah

