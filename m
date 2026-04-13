Return-Path: <netdev+bounces-278176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJhGJ2U23Wl9agkAu9opvQ
	(envelope-from <netdev+bounces-278176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:31:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94A3F212F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D891302386E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046903845CA;
	Mon, 13 Apr 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l+QWbYiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDD366573;
	Mon, 13 Apr 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104974; cv=none; b=bxqFRXxP+KYJTl8QSzXEHCdVK3uJycFbpthitc3Jz5g/SOpU9O0Z68uPh0YmOwwyGPh2C9W0d4Hw2FOnvPs15g+m/E73FeeJiN6T3o/9o9nP6RhrmcXAHyjGeQMCrxw5MZBY8ztQuvu9J1wn7XR59bO7S13upUkDQaAna3+VaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104974; c=relaxed/simple;
	bh=2ArdSjKR2RlI+jqmygWwNX6zIeyTDO5eF6SkrpbWQO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLwwD40Yg5qcGxwLhg8kMrAybNcEj9dd77kCxFCNZxCj5d58X9yxhpqf/ofZy17LU+8zckngynHusyCQzAcz8DDYCPIyQEaVxjC0tTGVLoWkd4QeWLaiLQFGBPwJcNj7eZPLqq0YaHxl8xmGvUz4OLoBlcz1zjzS+y76sneQEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l+QWbYiW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DEF001A322D;
	Mon, 13 Apr 2026 18:29:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B31185FFB9;
	Mon, 13 Apr 2026 18:29:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB7DD104504B7;
	Mon, 13 Apr 2026 20:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=15vke5PQWZFrVkgnnIyubbncfs+/GAw/Iqj1wymNY98=;
	b=l+QWbYiWMGIz4qwFLYvxVvMGDaqNYLxl8K1kxh6kptb7szLGWRQXA8zBqpP99PBjYfp8qF
	hoA1ZbpPykPq9PL8Qqxin+5v7f2di/xPCQjqjFU6MHvnHnb7DzKKp7Kxr2TzD0HFALS1qP
	5ngtttZu6iq7pgtx9fYP2GUHSigLJA/zant3mcWAwXJWO57o7EYixDOPIMLE+oxnKesxjF
	k+Q6hecUSaC5jbC0cNStpOirpqlYFEaQFckGdH4/SvkvwlJl/Ra4Hd/e9I1L+OYr5wYV4c
	pl4AOaTC3FiTflrqPJAOjxm2TiiwfD3O7esj3A9Z/06x97gRP2S9RRjFwaQYsA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 13 Apr 2026 20:28:48 +0200
Subject: [PATCH RFC bpf-next 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-kasan-v1-8-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A94A3F212F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a basic KASAN test runner that loads and test-run programs that can
trigger memory management bugs. The test captures kernel logs and ensure
that the expected KASAN splat is emitted by searching for the
corresponding first lines in the report.

This version implements two faulty programs triggering either a
user-after-free, or an out-of-bounds memory usage. The bugs are
triggered thanks to some dedicated kfuncs in bpf_testmod.c, but two
different techniques are used, as some cases can be quite hard to
trigger in a pure "black box" approach:
- for reads, we can make the used kfuncs return some faulty pointers
  that ebpf programs will manipulate, they will generate legitimate
  kasan reports as a consequence
- applying the same trick for faulty writes is harder, as ebpf programs
  can't write kernel data freely. So ebpf programs can call another
  specific testing kfunc that will alter the shadow memory matching the
  passed memory (eg: a map). When the program will try to write to the
  corresponding memory, it will trigger a report as well.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
The way of bringing kasan_poison into bpf_testmod is definitely not
ideal.  But I would like to validate the testing approach (triggering
real faulty accesses, which is hard on some cases, VS manually poisoning
BPF-manipulated memory) before eventually making clean bridges between
KASAN APIs and bpf_testmod.c, if the latter approach is the valid one.
---
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 165 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 146 ++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  79 ++++++++++
 3 files changed, 390 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
new file mode 100644
index 000000000000..fd628aaa8005
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#include <bpf/bpf.h>
+#include <fcntl.h>
+#include <linux/if_ether.h>
+#include <sys/klog.h>
+#include <test_progs.h>
+#include <unpriv_helpers.h>
+#include "kasan.skel.h"
+
+#define SUBTEST_NAME_MAX_LEN	64
+#define SYSLOG_ACTION_READ_ALL	3
+#define SYSLOG_ACTION_CLEAR	5
+
+#define MAX_LOG_SIZE		(8*1024)
+#define READ_CHUNK_SIZE		128
+
+#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free in bpf_prog_"
+#define KASAN_PATTERN_GLOBAL_OOB "BUG: KASAN: global-out-of-bounds in bpf_prog_"
+
+static char klog_buffer[MAX_LOG_SIZE];
+
+static int read_kernel_logs(char *buf, size_t max_len)
+{
+	return klogctl(SYSLOG_ACTION_READ_ALL, buf, max_len);
+}
+
+static int clear_kernel_logs(void)
+{
+	return klogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
+}
+
+static int kernel_logs_have_matching_kasan_report(char *buf, char *pattern,
+						  bool is_write, int size)
+{
+	char *access_desc_start, *access_desc_end, *tmp;
+	char access_log[READ_CHUNK_SIZE];
+	char *kasan_report_start;
+	int hsize, nsize;
+	/* Searched kasan report is valid if
+	 * - it contains the expected kasan pattern
+	 * - the next line is the description of the faulty access
+	 * - faulty access properties match the tested type and size
+	 */
+	kasan_report_start = strstr(buf, pattern);
+
+	if (!kasan_report_start)
+		return 1;
+
+	/* Find next line */
+	access_desc_start = strchr(kasan_report_start, '\n');
+	if (!access_desc_start)
+		return 1;
+	access_desc_start++;
+
+	access_desc_end = strchr(access_desc_start, '\n');
+	if (!access_desc_end)
+		return 1;
+
+	nsize = snprintf(access_log, READ_CHUNK_SIZE, "%s of size %d at addr",
+		 is_write ? "Write" : "Read", size);
+
+	hsize = access_desc_end - access_desc_start;
+	tmp = memmem(access_desc_start, hsize, access_log, nsize);
+
+	if (!tmp)
+		return 1;
+
+	return 0;
+}
+
+struct test_spec {
+	char *prog_name;
+	char *expected_report_pattern;
+};
+
+static struct test_spec tests[] = {
+	{
+		.prog_name = "bpf_kasan_uaf",
+		.expected_report_pattern = KASAN_PATTERN_SLAB_UAF
+	},
+	{
+		.prog_name = "bpf_kasan_oob",
+		.expected_report_pattern = KASAN_PATTERN_GLOBAL_OOB
+	}
+};
+
+static void run_test_with_type_and_size(struct kasan *skel,
+					struct test_spec *test, bool is_write,
+					int access_size)
+{
+	char subtest_name[SUBTEST_NAME_MAX_LEN];
+	struct bpf_program *prog;
+	uint8_t buf[ETH_HLEN];
+	int ret;
+
+	prog = bpf_object__find_program_by_name(skel->obj, test->prog_name);
+	if (!ASSERT_OK_PTR(prog, "find test prog"))
+		return;
+
+	snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%s_%d",
+		 test->prog_name, is_write ? "write" : "read", access_size);
+
+	if (!test__start_subtest(subtest_name))
+		return;
+
+	ret = clear_kernel_logs();
+	if (!ASSERT_OK(ret, "reset log buffer"))
+		return;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	topts.sz = sizeof(struct bpf_test_run_opts);
+	topts.data_size_in = ETH_HLEN;
+	topts.data_in = buf;
+	skel->bss->is_write = is_write;
+	skel->bss->access_size = access_size;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_OK(ret, "run prog"))
+		return;
+
+	ret = read_kernel_logs(klog_buffer, MAX_LOG_SIZE);
+	if (ASSERT_GE(ret, 0, "read kernel logs"))
+		ASSERT_OK(kernel_logs_have_matching_kasan_report(
+				  klog_buffer, test->expected_report_pattern,
+				  is_write, access_size),
+			  test->prog_name);
+}
+
+static void run_test_with_type(struct kasan *skel, struct test_spec *test,
+			       bool is_write)
+{
+	run_test_with_type_and_size(skel, test, is_write, 1);
+	run_test_with_type_and_size(skel, test, is_write, 2);
+	run_test_with_type_and_size(skel, test, is_write, 4);
+	run_test_with_type_and_size(skel, test, is_write, 8);
+}
+
+static void run_test(struct kasan *skel, struct test_spec *test)
+{
+	run_test_with_type(skel, test, false);
+	run_test_with_type(skel, test, true);
+}
+
+void test_kasan(void)
+{
+	struct test_spec *test;
+	struct kasan *skel;
+	int i;
+
+	if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
+		test__skip();
+		return;
+	}
+
+	skel = kasan__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load prog"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		test = &tests[i];
+
+		run_test(skel, test);
+	}
+
+	kasan__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
new file mode 100644
index 000000000000..f713c9b7c9ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kasan.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define KASAN_SLAB_FREE 0xFB
+#define KASAN_GLOBAL_REDZONE 0xF9
+
+extern __u8 *bpf_kfunc_kasan_uaf_1(void) __ksym;
+extern __u16 *bpf_kfunc_kasan_uaf_2(void) __ksym;
+extern __u32 *bpf_kfunc_kasan_uaf_4(void) __ksym;
+extern __u64 *bpf_kfunc_kasan_uaf_8(void) __ksym;
+extern __u8 *bpf_kfunc_kasan_oob_1(void) __ksym;
+extern __u16 *bpf_kfunc_kasan_oob_2(void) __ksym;
+extern __u32 *bpf_kfunc_kasan_oob_4(void) __ksym;
+extern __u64 *bpf_kfunc_kasan_oob_8(void) __ksym;
+extern void bpf_kfunc_kasan_poison(void *mem, __u32 mem__sz, __u8 byte) __ksym;
+
+int access_size;
+int is_write;
+
+struct kasan_write_val {
+	__u8 data_1;
+	__u16 data_2;
+	__u32 data_4;
+	__u64 data_8;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct kasan_write_val);
+} test_map SEC(".maps");
+
+static void bpf_kasan_faulty_write(int size, __u8 poison_byte)
+{
+	struct kasan_write_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val),
+			       poison_byte);
+	switch (size) {
+	case 1:
+		val->data_1 = 0xAA;
+		break;
+	case 2:
+		val->data_2 = 0xAA;
+		break;
+	case 4:
+		val->data_4 = 0xAA;
+		break;
+	case 8:
+		val->data_8 = 0xAA;
+		break;
+	}
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val), 0x00);
+}
+
+
+static int bpf_kasan_uaf_read(int size)
+{
+	__u8 *result_1;
+	__u16 *result_2;
+	__u32 *result_4;
+	__u64 *result_8;
+	int ret = 0;
+
+	switch (size) {
+	case 1:
+		result_1 = bpf_kfunc_kasan_uaf_1();
+		ret = result_1[0] ? 1 : 0;
+		break;
+	case 2:
+		result_2 = bpf_kfunc_kasan_uaf_2();
+		ret = result_2[0] ? 1 : 0;
+		break;
+	case 4:
+		result_4 = bpf_kfunc_kasan_uaf_4();
+		ret = result_4[0] ? 1 : 0;
+		break;
+	case 8:
+		result_8 = bpf_kfunc_kasan_uaf_8();
+		ret = result_8[0] ? 1 : 0;
+		break;
+	}
+	return ret;
+}
+
+SEC("tcx/ingress")
+int bpf_kasan_uaf(struct __sk_buff *skb)
+{
+	if (is_write) {
+		bpf_kasan_faulty_write(access_size, KASAN_SLAB_FREE);
+		return 0;
+	}
+
+	return bpf_kasan_uaf_read(access_size);
+}
+
+static int bpf_kasan_oob_read(int size)
+{
+	__u8 *result_1;
+	__u16 *result_2;
+	__u32 *result_4;
+	__u64 *result_8;
+	int ret = 0;
+
+	switch (size) {
+	case 1:
+		result_1 = bpf_kfunc_kasan_oob_1();
+		ret = result_1[0] ? 1 : 0;
+		break;
+	case 2:
+		result_2 = bpf_kfunc_kasan_oob_2();
+		ret = result_2[0] ? 1 : 0;
+		break;
+	case 4:
+		result_4 = bpf_kfunc_kasan_oob_4();
+		ret = result_4[0] ? 1 : 0;
+		break;
+	case 8:
+		result_8 = bpf_kfunc_kasan_oob_8();
+		ret = result_8[0] ? 1 : 0;
+		break;
+	}
+	return ret;
+}
+
+SEC("tcx/ingress")
+int bpf_kasan_oob(struct __sk_buff *skb)
+{
+	if (is_write) {
+		bpf_kasan_faulty_write(access_size, KASAN_GLOBAL_REDZONE);
+		return 0;
+	}
+
+	return bpf_kasan_oob_read(access_size);
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index d876314a4d67..01554bcbbbb0 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -271,6 +271,76 @@ __bpf_kfunc void bpf_kfunc_put_default_trusted_ptr_test(struct prog_test_member
 	 */
 }
 
+static void *kasan_uaf(void)
+{
+	void *p = kmalloc(64, GFP_ATOMIC);
+
+	if (!p)
+		return NULL;
+	memset(p, 0xAA, 64);
+	kfree(p);
+
+	return p;
+}
+
+#ifdef CONFIG_KASAN_GENERIC
+extern void kasan_poison(const void *addr, size_t size, u8 value, bool init);
+
+__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte)
+{
+	kasan_poison(mem, mem__sz, byte, false);
+}
+#else
+__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte) { }
+#endif
+
+__bpf_kfunc u8 *bpf_kfunc_kasan_uaf_1(void)
+{
+	return kasan_uaf();
+}
+
+__bpf_kfunc u16 *bpf_kfunc_kasan_uaf_2(void)
+{
+	return kasan_uaf();
+}
+
+__bpf_kfunc u32 *bpf_kfunc_kasan_uaf_4(void)
+{
+	return kasan_uaf();
+}
+
+__bpf_kfunc u64 *bpf_kfunc_kasan_uaf_8(void)
+{
+	return kasan_uaf();
+}
+
+static u8 test_oob_buffer[64];
+
+static void *bpf_kfunc_kasan_oob(void)
+{
+	return test_oob_buffer+64;
+}
+
+__bpf_kfunc u8 *bpf_kfunc_kasan_oob_1(void)
+{
+	return bpf_kfunc_kasan_oob();
+}
+
+__bpf_kfunc u16 *bpf_kfunc_kasan_oob_2(void)
+{
+	return bpf_kfunc_kasan_oob();
+}
+
+__bpf_kfunc u32 *bpf_kfunc_kasan_oob_4(void)
+{
+	return bpf_kfunc_kasan_oob();
+}
+
+__bpf_kfunc u64 *bpf_kfunc_kasan_oob_8(void)
+{
+	return bpf_kfunc_kasan_oob();
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -740,6 +810,15 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_1)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_2)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_4)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_8)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_1)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_2)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_4)
+BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_8)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)

-- 
2.53.0


