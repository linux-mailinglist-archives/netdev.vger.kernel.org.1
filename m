Return-Path: <netdev+bounces-259487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wICpEIofl2m9uwIAu9opvQ
	(envelope-from <netdev+bounces-259487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:34:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A315F8D8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95CFC302FEAF
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C433F8C4;
	Thu, 19 Feb 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSagwInd"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4233A9CE
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511519; cv=none; b=eiqX+z/NdrtppJY4PKrJRAcx+zjyB5C1QNd/fBUDD1zB8o0JeQXNuXN42t2ceenryfbgyXutT1n8qz4w6jiY8I+4avuIAr1iM33wEJ/MFCRhr9BHxI4nkgsUFBNO/rlJyewPYmTQ8sOnqKSleM1jeXxnjpL1j4B/1MPLkDIFno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511519; c=relaxed/simple;
	bh=4nZ/Hxz+9njS2oPp6AwC1Vd/k0sBQjMCSloOzzXzEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRXmUtxEsirvjU89WS0QQwnW2G/5zXo95/TTHdqaonelV3hOqK/NwrIHCGLfwVnPtXom9QcaztHJoHaF5fo8JIMhXNxIElSQ3dcmqFxvLmU+Y5eMaNmE8ddlZI+atnd3R6CYomuEKW4v7ishs7As/zP9Rt4/Ez1Hps1OhlPABXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSagwInd; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDysQwXc7CzQOBmT/kFdKL3V02JclHexDCmLhDyq0UI=;
	b=eSagwIndy6NTov4HnTmGveVQ7Qn3mncFyVvmyz6/94sXxh9PvILdu/4ZsjM/jt0WTU9S2a
	BLdhXtWb30gxjHiVKtHZ/zt/WN0NAILwChi84PC8tvqHMBEEPCQsRcj3+ZmZh4gq04SNWw
	ALGgmG0EwvspQPRPbgdPHikpTLSCxls=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Add __cpu_feature annotation for CPU-feature-gated tests
Date: Thu, 19 Feb 2026 22:29:27 +0800
Message-ID: <20260219142933.13904-6-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-1-leon.hwang@linux.dev>
References: <20260219142933.13904-1-leon.hwang@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-259487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: EA9A315F8D8
X-Rspamd-Action: no action

Add a new __cpu_feature("...") test annotation and parse it in
selftests/bpf test_loader.

Behavior:
- Annotation value is matched against CPU feature tokens from
  /proc/cpuinfo (case-insensitive).
- Multiple __cpu_feature annotations can be specified for one test; all
  required features must be present.
- If any required feature is missing, the test is skipped.

Limitation:
- __cpu_feature is evaluated per test function and is not scoped per
  __arch_* block. A single test that combines multiple architectures
  cannot express different per-arch feature requirements.

This lets JIT/disassembly-sensitive tests declare explicit CPU feature
requirements and avoid false failures on unsupported systems.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |   7 +
 tools/testing/selftests/bpf/test_loader.c    | 150 +++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..75e66373a64d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -126,6 +126,12 @@
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
  * __caps_unpriv     Specify the capabilities that should be set when running the test.
+ * __cpu_feature     Specify required CPU feature for test execution.
+ *                   Multiple __cpu_feature annotations could be specified.
+ *                   Value must match a CPU feature token exposed by
+ *                   /proc/cpuinfo (case-insensitive).
+ *                   Can't be used together with multiple __arch_* tags.
+ *                   If any required feature is not present, test case is skipped.
  *
  * __linear_size     Specify the size of the linear area of non-linear skbs, or
  *                   0 for linear skbs.
@@ -156,6 +162,7 @@
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
+#define __cpu_feature(feat)	__attribute__((btf_decl_tag("comment:test_cpu_feature=" feat)))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
 #define __stderr(msg)		__attribute__((btf_decl_tag("comment:test_expect_stderr=" XSTR(__COUNTER__) "=" msg)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..3729d1572589 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include <ctype.h>
 
 #include "autoconf_helper.h"
 #include "disasm_helpers.h"
@@ -44,6 +45,7 @@
 #define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
 #define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
 #define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
+#define TEST_TAG_CPU_FEATURE_PFX "comment:test_cpu_feature="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -67,6 +69,11 @@ enum load_mode {
 	NO_JITED	= 1 << 1,
 };
 
+struct cpu_feature_set {
+	char **names;
+	size_t cnt;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
@@ -93,6 +100,7 @@ struct test_spec {
 	int linear_sz;
 	bool auxiliary;
 	bool valid;
+	struct cpu_feature_set cpu_features;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -145,6 +153,16 @@ static void free_test_spec(struct test_spec *spec)
 	free(spec->unpriv.name);
 	spec->priv.name = NULL;
 	spec->unpriv.name = NULL;
+
+	if (spec->cpu_features.names) {
+		size_t i;
+
+		for (i = 0; i < spec->cpu_features.cnt; i++)
+			free(spec->cpu_features.names[i]);
+		free(spec->cpu_features.names);
+		spec->cpu_features.names = NULL;
+		spec->cpu_features.cnt = 0;
+	}
 }
 
 /* Compiles regular expression matching pattern.
@@ -394,6 +412,122 @@ static int get_current_arch(void)
 	return ARCH_UNKNOWN;
 }
 
+static int cpu_feature_set_add(struct cpu_feature_set *set, const char *name)
+{
+	char **tmp, *norm;
+	size_t i, len;
+
+	if (!name || !name[0]) {
+		PRINT_FAIL("bad cpu feature spec: empty string");
+		return -EINVAL;
+	}
+
+	len = strlen(name);
+	norm = malloc(len + 1);
+	if (!norm)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		if (isspace(name[i])) {
+			free(norm);
+			PRINT_FAIL("bad cpu feature spec: whitespace is not allowed in '%s'", name);
+			return -EINVAL;
+		}
+		norm[i] = tolower((unsigned char)name[i]);
+	}
+	norm[len] = '\0';
+
+	for (i = 0; i < set->cnt; i++) {
+		if (strcmp(set->names[i], norm) == 0) {
+			free(norm);
+			return 0;
+		}
+	}
+
+	tmp = realloc(set->names, (set->cnt + 1) * sizeof(*set->names));
+	if (!tmp) {
+		free(norm);
+		return -ENOMEM;
+	}
+	set->names = tmp;
+	set->names[set->cnt++] = norm;
+	return 0;
+}
+
+static bool cpu_feature_set_has(const struct cpu_feature_set *set, const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < set->cnt; i++) {
+		if (strcmp(set->names[i], name) == 0)
+			return true;
+	}
+	return false;
+}
+
+static bool cpu_feature_set_includes(const struct cpu_feature_set *have,
+				     const struct cpu_feature_set *need)
+{
+	size_t i;
+
+	for (i = 0; i < need->cnt; i++) {
+		if (!cpu_feature_set_has(have, need->names[i]))
+			return false;
+	}
+	return true;
+}
+
+static const struct cpu_feature_set *get_current_cpu_features(void)
+{
+	static struct cpu_feature_set set;
+	static bool initialized;
+	char *line = NULL;
+	size_t len = 0;
+	FILE *fp;
+	int err;
+
+	if (initialized)
+		return &set;
+
+	initialized = true;
+	fp = fopen("/proc/cpuinfo", "r");
+	if (!fp)
+		return &set;
+
+	while (getline(&line, &len, fp) != -1) {
+		char *p = line, *colon, *tok;
+
+		while (*p && isspace(*p))
+			p++;
+		if (!str_has_pfx(p, "flags") &&
+		    !str_has_pfx(p, "Features") &&
+		    !str_has_pfx(p, "features"))
+			continue;
+
+		colon = strchr(p, ':');
+		if (!colon)
+			continue;
+
+		for (tok = strtok(colon + 1, " \t\n"); tok; tok = strtok(NULL, " \t\n")) {
+			err = cpu_feature_set_add(&set, tok);
+			if (err) {
+				PRINT_FAIL("failed to parse cpu feature from '/proc/cpuinfo': '%s'",
+					   tok);
+				break;
+			}
+		}
+	}
+
+	free(line);
+	fclose(fp);
+	return &set;
+}
+
+static int parse_cpu_feature(const char *name, struct cpu_feature_set *set)
+{
+	return cpu_feature_set_add(set, name);
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -650,9 +784,20 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
+		} else if (str_has_pfx(s, TEST_TAG_CPU_FEATURE_PFX)) {
+			val = s + sizeof(TEST_TAG_CPU_FEATURE_PFX) - 1;
+			err = parse_cpu_feature(val, &spec->cpu_features);
+			if (err)
+				goto cleanup;
 		}
 	}
 
+	if (spec->cpu_features.cnt && __builtin_popcount(arch_mask) != 1) {
+		PRINT_FAIL("__cpu_feature requires exactly one __arch_* tag");
+		err = -EINVAL;
+		goto cleanup;
+	}
+
 	spec->arch_mask = arch_mask ?: -1;
 	spec->load_mask = load_mask ?: (JITED | NO_JITED);
 
@@ -1161,6 +1306,11 @@ void run_subtest(struct test_loader *tester,
 		return;
 	}
 
+	if (!cpu_feature_set_includes(get_current_cpu_features(), &spec->cpu_features)) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
-- 
2.52.0


