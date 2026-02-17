Return-Path: <netdev+bounces-259158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEE1DSXllGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9B1513FC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BD2300BCA4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C42DB7B3;
	Tue, 17 Feb 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="W3zvoICm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2343EBF3E;
	Tue, 17 Feb 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365665; cv=none; b=M88jhcUTRUY6b7bVCKa1dByit3dfBnwRV4SeK2mnfddMjgxnlPkAraLeRP9yQdeTZ4JMq5CtEImakSljNsMmXXFcTB/AthlHNEg0YKBLBji/khAkwbl7wINXgnSJ6jcYZbG6kNlGaTaTNI7hOlIZOw6cUp8bmtNJey94txXrsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365665; c=relaxed/simple;
	bh=dZXbT0FPlpWI/oEY6acsZoKMF11PStZPT3boiB6uP78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv+bI2Gp0jtNauI45+CAxQwtj+M4BwROo62yrmgjHsq/+FOUrn/91czP9TVR/oNOJ0ansrVAxA1wa8k/btcPYb8O78/aquSMCKJFa35PLcuATmPgR/p+ZNzuQNrjqRWdKylXsBJAyrtZBpTrNrdMQXe0AJfmnrKX7kt5u9MRFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=W3zvoICm; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HIkD4Y101030;
	Tue, 17 Feb 2026 21:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=4yWaRrYYaApVNQIpjJA8DzDckN/5dmfE+ZhHsnqTpEw=; b=W3zv
	oICmN44sgT9drO0733GqkfWdDdU/23d2xNMTNr2rKFy40hyKq8lvuFphC2tz4bfc
	Tb3MnmBrshGKYfRb1tXdrtgM61EFlChc1JjVPIv/86a3jTOwqs4KlIFCLjKv9Kua
	IW1Ac+bUHvCdLhRs0623tR9Kl8oy1b4uww1X0zUgQ6czhj64EQAqgIFXBlPu2Gph
	eOM6l+NFoIqVy8YZQfQ60mZ78eMuAdqHKenIN/aLfEjZYJCuhgLDvWozo4DtfsZP
	G8dh7fC8CzTTCMwE+qx7cOBWTFHrEEQjsMPpa6jVh1dj8zxleg72F6MspbaQ7/+H
	Wkwp0Z9bgXVp+N/85A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cb6v0hamw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 21:46:05 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 21:45:59 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <sast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: <sartin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add trampolines multi-level pointer params test coverage
Date: Wed, 18 Feb 2026 08:45:33 +1100
Message-ID: <20260217214533.17776-3-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217214533.17776-1-slava.imameev@crowdstrike.com>
References: <20260217214533.17776-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: b_cWNYh2La1-DSrIvPEGKl6NZqmhMBO-
X-Proofpoint-GUID: b_cWNYh2La1-DSrIvPEGKl6NZqmhMBO-
X-Authority-Analysis: v=2.4 cv=VNPQXtPX c=1 sm=1 tr=0 ts=6994e19d cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pl6vuDidAAAA:8
 a=V3eiiaalqBfsq9eYpuYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3OSBTYWx0ZWRfX2VErXI9s8Upn
 5wQtdWJgaQ8o30AMZ41f2tUnwbGJUkJXCoRx8jc7punn6SJjgGSnp8CD1UIzsj9pMwXPWJw0EeC
 2+U9FT6GCibpH1esn9W8yBWX+FX9xWHNO4qQCdmfKZLx/w+3uXjrFX+ghvA+/RkWH8i/waSxuYh
 1OZPvQqY45hU+n53/MtpEc1TbZysK9RpyoZL3BjWXYCktc0vjmhS2P0MLoQjlVAKeJo3oqfF7L8
 FQhB7tvjM2nh9I3MAJYAR2zNl1r5NfsLuFnQnlocrwFmuLzFXXWUx+TLMfyS7k+oD7xEVEJQje6
 EHll7X4U4LEmgY8v93y/qQfFKQgwaoiXscaX55bXndfpLhaT1qWJQ19YS8x0vXcfGPi7LEBdbgs
 g7gdULvjIaVq6W5yU+yXm1qj6C5RoSvlIJhyVun6pB+Y+tBayc28UZ0HG8d4ok+ThguWlkHqWyQ
 ocnoaB9SxwuW0+AHKSw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-259158-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim,crowdstrike.com:email]
X-Rspamd-Queue-Id: 87C9B1513FC
X-Rspamd-Action: no action

Multi-level pointer params and return value test coverage for BPF
trampolines:
- fentry/fexit programs covering struct and void double/triple pointer
  parameters
- nullable pointer cases to validate required NULL checks
- verifier context tests for lsm to check trusted parameters handling
- verifier context tests to exercise PTR_TO_MEM sizing and read-only
  behavior
- verifier BPF helper tests to validate no change in verifier behaviour

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 net/bpf/test_run.c                            | 128 ++++++
 .../prog_tests/fentry_fexit_multi_level_ptr.c | 204 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/fentry_fexit_pptr_nullable_test.c   |  52 +++
 .../bpf/progs/fentry_fexit_pptr_test.c        |  60 +++
 .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  31 ++
 .../bpf/progs/fentry_fexit_void_pptr_test.c   |  64 +++
 .../bpf/progs/verifier_ctx_multilevel_ptr.c   | 429 ++++++++++++++++++
 8 files changed, 970 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..19c82ae9bfe6 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -24,6 +24,8 @@
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 #include <net/netfilter/nf_bpf_link.h>
+#include <linux/set_memory.h>
+#include <linux/string.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -563,6 +565,41 @@ noinline int bpf_fentry_test10(const void *a)
 	return (long)a;
 }
 
+struct bpf_fentry_test_pptr_t {
+	int value;
+};
+
+noinline int bpf_fentry_test11_pptr_nullable(struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	if (!pptr__nullable)
+		return -1;
+
+	return (*pptr__nullable)->value;
+}
+
+noinline u32 **bpf_fentry_test12_pptr(u32 id, u32 **pptr)
+{
+	/* prevent DCE */
+	asm volatile("" : "+r"(id));
+	asm volatile("" : "+r"(pptr));
+	return pptr;
+}
+
+noinline u8 bpf_fentry_test13_pptr(void **pptr)
+{
+	void *ptr;
+
+	return copy_from_kernel_nofault(&ptr, pptr, sizeof(pptr)) == 0;
+}
+
+/* Test the verifier can handle multi-level pointer types with qualifiers. */
+noinline void ***bpf_fentry_test14_ppptr(void **volatile *const ppptr)
+{
+	/* prevent DCE */
+	asm volatile("" :: "r"(ppptr) : "memory");
+	return (void ***)ppptr;
+}
+
 noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
@@ -670,20 +707,110 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	return data;
 }
 
+static void *create_bad_kaddr(void)
+{
+	/*
+	 * Try to get an address that passes kernel range checks but causes
+	 * a page fault handler invocation if accessed from a BPF program.
+	 */
+#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)
+	void *addr = vmalloc(PAGE_SIZE);
+
+	if (!addr)
+		return NULL;
+	/* Make it non-present - any access will fault */
+	if (set_memory_np((unsigned long)addr, 1)) {
+		vfree(addr);
+		return NULL;
+	}
+	return addr;
+#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
+	struct page *page = alloc_page(GFP_KERNEL);
+
+	if (!page)
+		return NULL;
+	/* Remove from direct map - any access will fault */
+	if (set_direct_map_invalid_noflush(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	flush_tlb_kernel_range((unsigned long)page_address(page),
+			       (unsigned long)page_address(page) + PAGE_SIZE);
+	return page_address(page);
+#endif
+	return NULL;
+}
+
+static void free_bad_kaddr(void *addr)
+{
+	if (!addr)
+		return;
+
+	/*
+	 * Free an invalid test address created by get_invalid_address().
+	 * Restores the page to present state before freeing.
+	 */
+#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)
+	set_memory_p((unsigned long)addr, 1);
+	vfree(addr);
+#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
+	struct page *page = virt_to_page(addr);
+
+	set_direct_map_default_noflush(page);
+	flush_tlb_kernel_range((unsigned long)addr,
+			       (unsigned long)addr + PAGE_SIZE);
+	__free_page(page);
+#endif
+}
+
+#define CONSUME(val) do { \
+	typeof(val) __var = (val); \
+	__asm__ __volatile__("" : "+r" (__var)); \
+	(void)__var; \
+} while (0)
+
 int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
 	struct bpf_fentry_test_t arg = {};
+	struct bpf_fentry_test_pptr_t ts = { .value = 1979 };
+	struct bpf_fentry_test_pptr_t *ptr = &ts;
+	void *kaddr = NULL;
+	u32 *u32_ptr = (u32 *)29;
 	u16 side_effect = 0, ret = 0;
 	int b = 2, err = -EFAULT;
 	u32 retval = 0;
+	const char *attach_name;
 
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
+	attach_name = prog->aux->attach_func_name;
+	if (!attach_name)
+		attach_name = "!";
+
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+		if (!strcmp(attach_name, "bpf_fentry_test11_pptr_nullable")) {
+			CONSUME(bpf_fentry_test11_pptr_nullable(&ptr));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test12_pptr")) {
+			CONSUME(bpf_fentry_test12_pptr(0, &u32_ptr));
+			CONSUME(bpf_fentry_test12_pptr(1, (u32 **)17));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test13_pptr")) {
+			kaddr = create_bad_kaddr();
+			WARN_ON(!kaddr);
+			CONSUME(bpf_fentry_test13_pptr(kaddr));
+			CONSUME(bpf_fentry_test13_pptr((void **)19));
+			CONSUME(bpf_fentry_test13_pptr(ERR_PTR(-ENOMEM)));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test14_ppptr")) {
+			CONSUME(bpf_fentry_test14_ppptr(ERR_PTR(-ENOMEM)));
+			break;
+		}
+		fallthrough;
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
@@ -717,6 +844,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 
 	err = 0;
 out:
+	free_bad_kaddr(kaddr);
 	trace_bpf_test_finish(&err);
 	return err;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
new file mode 100644
index 000000000000..48cb8a3d3967
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <test_progs.h>
+#include "fentry_fexit_pptr_nullable_test.skel.h"
+#include "fentry_fexit_pptr_test.skel.h"
+#include "fentry_fexit_void_pptr_test.skel.h"
+#include "fentry_fexit_void_ppptr_test.skel.h"
+
+static void test_fentry_fexit_pptr_nullable(void)
+{
+	struct fentry_fexit_pptr_nullable_test *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_pptr_nullable_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_pptr_nullable_test__open_and_load"))
+		return;
+
+	err = fentry_fexit_pptr_nullable_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_pptr_nullable_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs. */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_pptr_nullable);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	/* Verify fentry was called and captured the correct value. */
+	ASSERT_EQ(skel->bss->fentry_called, 1, "fentry_called");
+	ASSERT_EQ(skel->bss->fentry_ptr_field_value, 1979, "fentry_ptr_field_value");
+
+	/* Verify fexit captured correct values and return code. */
+	ASSERT_EQ(skel->bss->fexit_called, 1, "fexit_called");
+	ASSERT_EQ(skel->bss->fexit_ptr_field_value, 1979, "fexit_ptr_field_value");
+	ASSERT_EQ(skel->bss->fexit_retval, 1979, "fexit_retval");
+
+cleanup:
+	fentry_fexit_pptr_nullable_test__destroy(skel);
+}
+
+static void test_fentry_fexit_pptr(void)
+{
+	struct fentry_fexit_pptr_test *skel = NULL;
+	int err, prog_fd, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_pptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_pptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs. */
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		skel->bss->telemetry[i].id = 30;
+		skel->bss->telemetry[i].fentry_pptr = 31;
+		skel->bss->telemetry[i].fentry_ptr = 32;
+		skel->bss->telemetry[i].fexit_pptr = 33;
+		skel->bss->telemetry[i].fexit_ptr = 34;
+		skel->bss->telemetry[i].fexit_ret_pptr = 35;
+		skel->bss->telemetry[i].fexit_ret_ptr = 36;
+	}
+
+	err = fentry_fexit_pptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_pptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_pptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		ASSERT_TRUE(skel->bss->telemetry[i].id == 0 ||
+			skel->bss->telemetry[i].id == 1, "id");
+		if (skel->bss->telemetry[i].id == 0) {
+			/* Verify fentry captured the correct value. */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_ptr, (u64)29, "fentry_ptr");
+
+			/* Verify fexit captured correct values and return address. */
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_pptr,
+				skel->bss->telemetry[i].fentry_pptr, "fexit_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, (u64)29, "fexit_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_pptr,
+				skel->bss->telemetry[i].fentry_pptr, "fexit_ret_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_ptr, (u64)29, "fexit_ret_ptr");
+		} else if (skel->bss->telemetry[i].id == 1) {
+			/* Verify fentry captured the correct value */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr, 17, "fentry_pptr");
+
+			/*
+			 * Verify fexit captured correct values and return address,
+			 * fentry_ptr value depends on kernel address space layout
+			 * and a mapped page presence at NULL.
+			 */
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_pptr, 17, "fexit_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr,
+				skel->bss->telemetry[i].fentry_ptr, "fexit_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_pptr, 17, "fexit_ret_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_ptr,
+				skel->bss->telemetry[i].fentry_ptr, "fexit_ret_ptr");
+		}
+	}
+
+cleanup:
+	fentry_fexit_pptr_test__destroy(skel);
+}
+
+static void test_fentry_fexit_void_pptr(void)
+{
+	struct fentry_fexit_void_pptr_test *skel = NULL;
+	int err, prog_fd, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_void_pptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_void_pptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs. */
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		skel->bss->telemetry[i].fentry_pptr = 30;
+		skel->bss->telemetry[i].fentry_ptr = 31;
+		skel->bss->telemetry[i].fexit_pptr = 32;
+		skel->bss->telemetry[i].fexit_ptr = 33;
+	}
+
+	err = fentry_fexit_void_pptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_void_pptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs. */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_void_pptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+		ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr, skel->bss->telemetry[i].fexit_pptr,
+			"fentry_pptr == fexit_pptr");
+		ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, skel->bss->telemetry[i].fentry_ptr,
+			"fexit_ptr");
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr_addr_valid,
+			skel->bss->telemetry[i].fexit_pptr_addr_valid, "fexit_pptr_addr_valid");
+		if (!skel->bss->telemetry[i].fentry_pptr_addr_valid) {
+			/* Should be set to 0 by kernel address boundaries check or an exception handler. */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_ptr, 0, "fentry_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, 0, "fexit_ptr");
+		}
+	}
+cleanup:
+	fentry_fexit_void_pptr_test__destroy(skel);
+}
+
+static void test_fentry_fexit_void_ppptr(void)
+{
+	struct fentry_fexit_void_ppptr_test *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_void_ppptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_void_ppptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs */
+	skel->bss->fentry_pptr = 31;
+
+	err = fentry_fexit_void_ppptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_void_ppptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_void_ppptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	/* Verify invalid memory access results in zeroed register */
+	ASSERT_EQ(skel->bss->fentry_called, 1, "fentry_called");
+	ASSERT_EQ(skel->bss->fentry_pptr, 0, "fentry_pptr");
+
+	/* Verify fexit captured correct values and return value */
+	ASSERT_EQ(skel->bss->fexit_called, 1, "fexit_called");
+	ASSERT_EQ(skel->bss->fexit_retval, (u64)ERR_PTR(-ENOMEM), "fexit_retval");
+
+cleanup:
+	fentry_fexit_void_ppptr_test__destroy(skel);
+}
+
+void test_fentry_fexit_multi_level_ptr(void)
+{
+	if (test__start_subtest("pptr_nullable"))
+		test_fentry_fexit_pptr_nullable();
+	if (test__start_subtest("pptr"))
+		test_fentry_fexit_pptr();
+	if (test__start_subtest("void_pptr"))
+		test_fentry_fexit_void_pptr();
+	if (test__start_subtest("void_ppptr"))
+		test_fentry_fexit_void_ppptr();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8cdfd74c95d7..5bcc6406c0b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -115,6 +115,7 @@
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
+#include "verifier_ctx_multilevel_ptr.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
+void test_verifier_ctx_multilevel_ptr(void)       { RUN(verifier_ctx_multilevel_ptr); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
new file mode 100644
index 000000000000..b88d4a1ebba2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_fentry_test_pptr_t {
+	__u32 value;
+};
+
+__u32 fentry_called = 0;
+__u32 fentry_ptr_field_value = 0;
+__u32 fexit_called = 0;
+__u32 fexit_ptr_field_value = 0;
+__u32 fexit_retval = 0;
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+int BPF_PROG(test_fentry_pptr_nullable, struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	fentry_called = 1;
+	if (!pptr__nullable)
+		return 0;
+
+	ptr = *pptr__nullable;
+	if (!ptr)
+		return 0;
+
+	bpf_probe_read_kernel(&fentry_ptr_field_value, sizeof(fentry_ptr_field_value), &ptr->value);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test11_pptr_nullable")
+int BPF_PROG(test_fexit_pptr_nullable, struct bpf_fentry_test_pptr_t **pptr__nullable, int ret)
+{
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	fexit_called = 1;
+	fexit_retval = ret;
+	if (!pptr__nullable)
+		return 0;
+
+	ptr = *pptr__nullable;
+	if (!ptr)
+		return 0;
+
+	bpf_probe_read_kernel(&fexit_ptr_field_value, sizeof(fexit_ptr_field_value), &ptr->value);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
new file mode 100644
index 000000000000..37764b030669
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TELEMETRY_COUNT 2
+
+struct {
+	__u32 id;
+	__u32 fentry_called;
+	__u32 fexit_called;
+	__u64 fentry_pptr;
+	__u64 fentry_ptr;
+	__u64 fexit_pptr;
+	__u64 fexit_ptr;
+	__u64 fexit_ret_pptr;
+	__u64 fexit_ret_ptr;
+} telemetry[TELEMETRY_COUNT];
+
+volatile unsigned int current_index = 0;
+
+SEC("fentry/bpf_fentry_test12_pptr")
+int BPF_PROG(test_fentry_pptr, __u32 id, __u32 **pptr)
+{
+	void *ptr;
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	if (bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr) != 0)
+		ptr = NULL;
+
+	telemetry[i].id = id;
+	telemetry[i].fentry_called = 1;
+	telemetry[i].fentry_pptr = (__u64)pptr;
+	telemetry[i].fentry_ptr = (__u64)ptr;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+int BPF_PROG(test_fexit_pptr, __u32 id, __u32 **pptr, __u32 **ret)
+{
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fexit_called = 1;
+	telemetry[i].fexit_pptr = (__u64)pptr;
+	telemetry[i].fexit_ptr = (__u64)*pptr;
+	telemetry[i].fexit_ret_pptr = (__u64)ret;
+	telemetry[i].fexit_ret_ptr = ret ? (__u64)*ret : 0;
+
+	current_index = i + 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
new file mode 100644
index 000000000000..3e0e908f6eda
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 fentry_called = 0;
+__u32 fexit_called = 0;
+__u64 fentry_pptr = 0;
+__u64 fexit_retval = 0;
+
+typedef void **volatile *const ppvpc_t;
+
+SEC("fentry/bpf_fentry_test14_ppptr")
+int BPF_PROG(test_fentry_void_ppptr, ppvpc_t ppptr)
+{
+	fentry_called = 1;
+	/* Invalid memory access is fixed by boundaries check or exception handler */
+	fentry_pptr = (unsigned long)*ppptr;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test14_ppptr")
+int BPF_PROG(test_fexit_void_ppptr, ppvpc_t ppptr, void ***ret)
+{
+	fexit_called = 1;
+	fexit_retval = ret ? (__u64)ret : 0;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
new file mode 100644
index 000000000000..0ec86da97ec5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TELEMETRY_COUNT 3
+
+struct {
+	__u32 fentry_called;
+	__u32 fexit_called;
+	__u32 fentry_pptr_addr_valid;
+	__u32 fexit_pptr_addr_valid;
+	__u64 fentry_pptr;
+	__u64 fentry_ptr;
+	__u64 fexit_pptr;
+	__u64 fexit_ptr;
+} telemetry[TELEMETRY_COUNT];
+
+volatile unsigned int current_index = 0;
+
+SEC("fentry/bpf_fentry_test13_pptr")
+int BPF_PROG(test_fentry_void_pptr, void **pptr)
+{
+	void *ptr;
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fentry_pptr_addr_valid =
+		(bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr) == 0);
+	if (!telemetry[i].fentry_pptr_addr_valid)
+		ptr = NULL;
+
+	telemetry[i].fentry_called = 1;
+	telemetry[i].fentry_pptr = (__u64)pptr;
+	telemetry[i].fentry_ptr = (__u64)ptr;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test13_pptr")
+int BPF_PROG(test_fexit_void_pptr, void **pptr, __u8 ret)
+{
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fexit_called = 1;
+	telemetry[i].fexit_pptr = (__u64)pptr;
+	telemetry[i].fexit_pptr_addr_valid = ret;
+
+	/*
+	 * For invalid addresses, the destination register for *dptr is set
+	 * to 0 by the BPF exception handler, JIT address range check, or
+	 * the BPF interpreter.
+	 */
+	telemetry[i].fexit_ptr = (__u64)*pptr;
+	current_index = i + 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c b/tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c
new file mode 100644
index 000000000000..9635aed66ba4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verifier tests for double and triple pointer parameter handling
+ * Copyright (c) 2026 CrowdStrike, Inc.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - valid ctx access")
+__success __retval(0)
+__naked void ctx_double_ptr_valid_load(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL	*/\
+	r2 = *(u64 *)(r1 + 0);		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid load without null")
+__failure __msg("R2 invalid mem access 'rdonly_untrusted_mem_or_null'")
+__naked void ctx_double_ptr_load_no_check_nullable(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	/*							\
+	 * invalid dereference without check for NULL when a parameter	\
+	 * is marked nullable (PTR_MAYBE_NULL)	\
+	 */							\
+	r3 = *(u64 *)(r2 + 0);		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test12_pptr")
+__description("fentry/double pointer parameter (rdonly, untrusted) - valid load without null")
+__success __retval(0)
+__naked void ctx_double_ptr_load_no_check(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED */\
+	r2 = *(u64 *)(r1 + 8);		\
+	/* valid dereference without check for NULL as the parameter is not marked as nullable */\
+	r3 = *(u64 *)(r2 + 0);		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - valid load with null")
+__success __retval(0)
+__naked void ctx_double_ptr_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	r3 = *(u64 *)(r2 + 0);		\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted) - valid load with arbitrary offset")
+__success __retval(0)
+__naked void ctx_double_ptr_valid_load_with_offset(void)
+{
+	asm volatile ("					\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null (PTR_MAYBE_NULL) */\
+	/* load with arbitrary offset is protected by an exception handler */\
+	r3 = *(u64 *)(r2 + 0x1000);	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid load with double dereference with offset")
+__failure __msg("R3 invalid mem access 'scalar'")
+__naked void ctx_double_ptr_invalid_load_with_offset(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null (PTR_MAYBE_NULL) */\
+	r3 = *(u64 *)(r2 + 0);		\
+	r4 = *(u64 *)(r3 + 0x1000);	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid narrow load")
+__failure __msg("size 4 must be 8")
+__naked void ctx_double_ptr_size_check(void)
+{
+	asm volatile ("				\
+	r2 = *(u32 *)(r1 + 0);		/* invalid narrow load */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid store to read only memory")
+__failure __msg("R2 cannot write into rdonly_untrusted_mem")
+__naked void ctx_double_ptr_write_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0x0) = 1;		/* read only */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid store with offset")
+__failure __msg("R2 cannot write into rdonly_untrusted_mem")
+__naked void ctx_double_ptr_write_offset_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0x1000) = 1;	/* read only */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter (rdonly, untrusted, nullable) - invalid store with offset, scalar type")
+__failure __msg("R3 invalid mem access 'scalar'")
+__naked void ctx_double_ptr_write2_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	r3 = *(u64 *)(r2 + 0);		/* R3 is a scalar */	\
+	*(u64 *)(r3 + 0) = 1;		/* scalar */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test14_ppptr")
+__description("fentry/triple pointer parameter (rdonly, untrusted, nullable) - invalid store to read only memory")
+__failure __msg("R2 cannot write into rdonly_untrusted_mem")
+__naked void ctx_double_ptr_write3_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0) = 1;		/* read only */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test14_ppptr")
+__description("fentry/triple pointer parameter (rdonly, untrusted, nullable) - invalid mem access (scalar)")
+__failure __msg("R3 invalid mem access 'scalar'")
+__naked void ctx_double_ptr_write4_readonly(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 0);		\
+	if r2 == 0 goto l0_%=;		/* check for null (PTR_MAYBE_NULL) */\
+	r3 = *(u64 *)(r2 + 0);		/* R3 type is scalar */	\
+	*(u64 *)(r3 + 0) = 1;		/* mem access for scalar */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/double pointer parameter (rdonly, trusted) - invalid load outside boundaries")
+__failure __msg("R2 min value is outside of the allowed memory range")
+__naked void sb_eat_lsm_opts_trusted_offset_outside_boundaries(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY, PTR_UNTRUSTED is not set */\
+	r2 = *(u64 *)(r1 + 8);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	/* should fail as for a trusted parameter verifier checks boundaries */\
+	r3 = *(u64 *)(r2 + 0x1000);	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/double pointer parameter (rdonly, trusted) - load within boundaries")
+__success
+__naked void sb_eat_lsm_opts_trusted_offset_within_boundaries(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY , PTR_UNTRUSTED is not set */\
+	r2 = *(u64 *)(r1 + 8);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	/*							\
+	 * should pass as for a trusted parameter verifier checks boundaries	\
+	 * and access is within boundaries	\
+	 */							\
+	r3 = *(u64 *)(r2 + 0x0);	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/double pointer parameter (rdonly, trusted) - load within boundaries, no check for null")
+__success
+__naked void sb_eat_lsm_opts_trusted_offset_within_boundaries_no_null_check(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY , PTR_UNTRUSTED is not set */\
+	r2 = *(u64 *)(r1 + 8);		\
+	/*							\
+	 * should pass as for a trusted parameter verifier checks boundaries	\
+	 * and PTR_MAYBE_NULL is not set	\
+	 */							\
+	r3 = *(u64 *)(r2 + 0x0);	\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/double pointer parameter (rdonly, trusted) - invalid store within boundaries to read only mem")
+__failure __msg("R2 cannot write into rdonly_mem")
+__naked void sb_eat_lsm_opts_trusted_modification_within_boundaries(void)
+{
+	asm volatile ("				\
+	/* load double pointer - should be PTR_TO_MEM | MEM_RDONLY , PTR_UNTRUSTED is not set */\
+	r2 = *(u64 *)(r1 + 8);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0x0) = 1;		/* read only */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/double pointer parameter (rdonly, trusted) - invalid store outside boundaries to read only mem")
+__failure __msg("R2 cannot write into rdonly_mem")
+__naked void sb_eat_lsm_opts_trusted_modification_outside_boundaries(void)
+{
+	asm volatile ("				\
+	/* load double pointer - PTR_TO_MEM | MEM_RDONLY , PTR_UNTRUSTED is not set */\
+	r2 = *(u64 *)(r1 + 8);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0x1000) = 1;	/* read only */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - valid load")
+__success __retval(0)
+__naked void ctx_double_ptr_return_load1(void)
+{
+	asm volatile ("				\
+	/* load double pointer return value - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 16);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	r3 = *(u64 *)(r2 + 0);		/* R3 is a scalar */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - valid load with offset")
+__success __retval(0)
+__naked void ctx_double_ptr_return_load2(void)
+{
+	asm volatile ("				\
+	/* load double pointer return value - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 16);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	/* verifier doesn't check boundaries for access protect by an exception handler */\
+	r3 = *(u64 *)(r2 - 0x100);	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - invalid load with double dereference")
+__failure __msg("R3 invalid mem access 'scalar'")
+__naked void ctx_double_ptr_return_load3(void)
+{
+	asm volatile ("				\
+	/* load double pointer return value - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 16);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	r3 = *(u64 *)(r2 + 0);		/* R3 is a scalar */	\
+	r4 = *(u64 *)(r3 + 0);	    /* load from scalar */\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - invalid store to read only memory")
+__failure __msg("R2 cannot write into rdonly_untrusted_mem")
+__naked void ctx_double_ptr_return_write1(void)
+{
+	asm volatile ("				\
+	/* load double pointer return value - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 16);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	*(u64 *)(r2 + 0) = 1;		/* R2 contains read only memory address */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - invalid store to read only memory with double dereference")
+__failure __msg("R3 invalid mem access 'scalar'")
+__naked void ctx_double_ptr_return_write2(void)
+{
+	asm volatile ("				\
+	/* load double pointer return value - PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED | PTR_MAYBE_NULL */\
+	r2 = *(u64 *)(r1 + 16);		\
+	if r2 == 0 goto l0_%=;		/* check for null */\
+	r3 = *(u64 *)(r2 + 0);		/* R3 is a scalar */	\
+	*(u64 *)(r3 + 0) = 1;		/* mem access for scalar */	\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+struct bpf_fentry_test_pptr_t;
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - bpf helpers with nullable var")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_nulable_var_access_bpf_helpers,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	/* Check compatibility with BPF helpers; NULL checks should not be required. */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr__nullable);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - bpf helpers with return val")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_return_access_bpf_helpers, __u32 id,
+	__u32 **pptr, __u32 **ret)
+{
+	/* Check compatibility with BPF helpers; NULL checks should not be required. */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr);
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), ret);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - bpf helpers with nullable var, direct ctx pointer")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_nulable_var_access_bpf_helpers_ctx,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	/* Check compatibility with BPF helpers; NULL checks should not be required. */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[0] /*pptr__nullable*/);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return (rdonly, untrusted, nullable) - bpf helpers with return val, direct ctx pointer")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_return_access_bpf_helpers_ctx, __u32 id,
+	__u32 **pptr, __u32 **ret)
+{
+	/* Check compatibility with BPF helpers; NULL checks should not be required. */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[1] /*pptr*/);
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[2] /*ret*/);
+	return 0;
+}
+
+
+char _license[] SEC("license") = "GPL";
-- 
2.50.1 (Apple Git-155)


