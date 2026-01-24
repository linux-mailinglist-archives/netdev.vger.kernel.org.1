Return-Path: <netdev+bounces-253044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF2FFidldGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CCC7CAB2
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073B6300E4A2
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE581299954;
	Sat, 24 Jan 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnyPgBgk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3142848BE
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235712; cv=none; b=swNeJpisDjHtk5RzWrixdV4CxTNiFF1vCX9669c60B4iCa4cbtlM3MIWPscAGG1kbDfMZ5jUjY5nx/PahtFCF+c033JkuWZAIcD/+F8KHYeo8ZgTj9oBKfHNDtkaFpXzrc1Wrw/S+HuFw4klnZsRUPoF5KCdbXe1CTYzgeKwDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235712; c=relaxed/simple;
	bh=NMhfMKw+E8jT0WPxwfHo2GO3dNgWbESa3HXh/xZZFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgZQqNnWZT6WkQ47GGFUkVHv/i6AEdSwSSms/xgrLXtB7Ob3jbQbo5JZhnZYEL/CWUUo23xlP5e33fy+MWYK1mf/G78+vVdDLDGpC8vxC9i6MBuLnvGFoXU9z9HGBqxU6XDvAdltELvSfGAc+qNwuGR/lY6Kt5CsaUgL3w+hFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnyPgBgk; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0c20ee83dso29428955ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235711; x=1769840511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=nnyPgBgk0Qt6bK5+nC3N48gjjAI/cW3QWwZ3OAQoJgf2HUYBf6HofP8sSkco4f5WKU
         cRO704xHhrCzXG4coK6LtaZIa9mpNBJduPfaxOq5khBCsPNK6Ri9ZyR/mA9Ya9WE/HME
         Clmg4WIfqLjHU+lKYRrZQmJgYhiGaU3iKwi+y014xwG8iogBkNqim71dqZvMAtQJB7xl
         c126dt3UoWbtkeAlkB16OVBHUQxyypBVpi0uIjYGNygZYNEZtnD0RVtA8lmiCt818VYV
         3/2UlPwIIksq3MbriZEVS9+PlOwvXiZC4Y3xV9AjuX7aYCYNUwkm4B7F+Xpte9eoj47I
         ASfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235711; x=1769840511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=FOWt0uSwnfTQlt2V7L4Rm8RRJFxfXq7e963WzgY9UiBplNB8LewyhvGAcDLB2tszlD
         nSDduqmAGOBxBhkcCNPTH/Tqs/bpFaSf0QYfnjWBnNAL7hNCZAcLe6JVi+fFAzjgyprS
         6kZlYncSET9U2KixTclkFNAExNAuHmj/UOQc+GLMlqCo5B1GP87w1NLz7/tLrQHTk71w
         lvd2uhEaLGAKtbFLXjZxSounW3Fg2pQLAL0zmlELKw8WADHsJ2gnfl6KWVC/P44Ch6WT
         HKuO723TGox6j6Sn4dpnr56Vcjz0xs9r8EQ0uagspODEqL2m6OBqOj9uwp7XB3SRVzfJ
         fYzA==
X-Forwarded-Encrypted: i=1; AJvYcCWw+TRUPE12Q2hAYD+ok7nogwIMYgzlOTSora5bK0y/9O865Lo+VKHaCRZbED3btKznlZkQPzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytrBcaMT8Heg+DWVYvSZoLWExJnxBBRLZLvzoFjL9gefmRZuK
	yRJawMoQ9JKP5T4wbXPuaIciB4SuFeQp1OAf7Nn1cxw5JjxGjmDpExQi
X-Gm-Gg: AZuq6aI4a4l+hRAZvZ5EUkg04aMIy69iCRaQbXqA7+8UH4pyXGRN1CNQcSzOSNa8U5A
	BBS3JNFtiTIErBhhiphrzkDtsN0+c2GYAJI4rCu0jP7SGipVNf1ibewQqASUO0iwTY5ngbvBRSO
	T8mihGaehpEtZtTxELMrFnKWJtm30JOPBanUtFgHspH5GEvY7g+9DlzZQjVzfTuWdn8B6c9x4BD
	a48JGURwTxvzt96arPlanGFGncPKmim6mum75gtAgNzE3twDkG3Poh+6QIzpB5LSXGN1YZ+VdII
	w2tY3VwKeN6GmtbT1AJ8AhSF6UcrB9t0sPhaUDTXvNtsYR4515RIRk/M2DGq+h7Jahyyb3oJW3W
	FzgbBVCJWVTrgbbOjVECeKu9+y+4qPDwerwYZ5pYUOP0zWtlBytzJVCU91SWcOooWh70xeEzBSG
	ArBNiy9u+U
X-Received: by 2002:a17:903:1aa3:b0:2a7:b646:54d0 with SMTP id d9443c01a7336-2a7fe733e05mr55712075ad.41.1769235710737;
        Fri, 23 Jan 2026 22:21:50 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 10/13] selftests/bpf: add testcases for fsession
Date: Sat, 24 Jan 2026 14:20:05 +0800
Message-ID: <20260124062008.8657-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253044-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.823];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 05CCC7CAB2
X-Rspamd-Action: no action

Add testcases for BPF_TRACE_FSESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_session_is_ret() is also tested.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 90 +++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 97 +++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..75bb42942b67
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* first attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+	/* detach */
+	fsession_test__detach(skel);
+
+	/* reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_test"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..0e1b66b2dddc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test1_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test2, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test2_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test2_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test3, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test4, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test5_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test5_exit_result = 1;
+	return 0;
+}
+
-- 
2.52.0


