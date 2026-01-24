Return-Path: <netdev+bounces-253045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKtxMX1mdGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:28:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5917CB73
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618DB300D946
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A62BD015;
	Sat, 24 Jan 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBIKZSp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC1286D5D
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235722; cv=none; b=Dtc9TGYbN/6d8odsKyVMPX7FV7nnIbN1yfVv3FYLBl/Ml28IQMBedZlXRVxUC8cvS4KdguXe8UNXmDfaDsUBxeFqsJdhS30q2V2+Q0HdGSmzlNbqR4SUWgtDFMSKXFm3y0zFB5kbbVH1WW4bRqLnpOANgrudgLTBl92HItl+ESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235722; c=relaxed/simple;
	bh=h4fZJ5/eB6h3kRSc5/YL4hLV3+bf/vzJfsSepeg4Yyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLnDn1VMuyguCm1OnDvQo2GUO1cxczr/KZJJegC/NcGNtHmzUsJ1cSYsLTzM73yG1Vtd7bOcXWt5l1ht5/2tmiCnOzXSGp/yA6XcFCqx6ybB9C5CSzfPFbXirocwf4K4atsaUXJ/xyJBZvViPPGjIFzM7ZaAG8Ll08XSFdACFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBIKZSp0; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso2030025a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235721; x=1769840521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm+ye49UjjJWSoY/pCeQ81QIgmdFuPgzbXJ82TRTTWs=;
        b=SBIKZSp0RT3bp6o20NjcU6iGvBRI9FgXOQ8LGfu99xfiVacpZlz/cKmv/5INO/uFqX
         py8EIusIUqpKGMFEV/QLmoFe0O5CSCkYO+4izMpBEpQw72rYqdJgfcKRjju9yTEk8q4n
         GYEAuZFO30NYk09QlDXKgzQCkv05nIs2ZGokBc/41jLOMqxG+1NdKSdcVkcHcl0lzD/R
         bG7XnOxLIQ1EKUIEKloULFa3rv409dWg53BtvZ6rFyDUrVEq1k0bC9Ke0heuSwDBq6YA
         GM1MVUgagbtA8HuwlyCpZfuJH1O52QJl7MHs5bh5LvZnTTOy0StC1TqMteK2PONxo1W7
         FkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235721; x=1769840521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm+ye49UjjJWSoY/pCeQ81QIgmdFuPgzbXJ82TRTTWs=;
        b=VmQSFLqwHsYG1hjDKZ3ehe43BzN4ggjAElx8vYQNYJipehk6QTOuJ2L9HUqhdt6AUA
         1+GiXvvZ6x5V0iggzZK2kutUl4SA3EEjBV3o2D5k51RW4KNRxhb7z8A0d1iWvwZ1KLb+
         HZRLzgrmaQ5fV8uVKCobPwYU5ZFFFfZNjRtNZFqXpjBbFYgjGjLCCqAMi5PexD0d3HVN
         zvl9iKLEVM7gNEAkyAVEJWYwsIBUoYPz4+V+noPFGPt0l1rfbTaHyrsJlL+eGVuuprw1
         dLkYfLA9AtGZ4yphh2U8kegXnxohNo7c8o93ltJTssYEm/bjgz9o0FEVMlyDHsR/Zo3O
         j9lw==
X-Forwarded-Encrypted: i=1; AJvYcCVUfoWRqBeAIDDnSBj8GcbbdoS5se/NePa8dR6vGOKrROj58IvC808dnAKJ/6MuliAfHkrSye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVvDKHDjurmVyUEs0mboqk6I94uDQ3IgQz8q8lMj1gN4oCmR3
	zv6kP+SzX44eo5E9jlgwwTTJJCRiXRt64tTdmsGzw+hTnUrE46xcF6Ud
X-Gm-Gg: AZuq6aL2F6fu+xahc38gPrR6VA5nZRQhOlCLRrexKJ3Lo1Tnq8TsM+5ttiUq+hOQ29k
	UBVEiigP/bHPw2PrYISDBZAMqixpmue5cgNMrVwoULUGXyPUFvgLBCbrYTW+gvhpUkFao3wmqPP
	5i/TStMbfvda1CmFRaJBFdOqNk1+c+UI54bovbfl+7BIyKryi+Dx62L78tDMYWem9cgQI1bDgX0
	EKzGWTefjB5ukFdzxOeijg5QWMphCx5WOU6OeO/XdANlB31XWMucnIghnWDQ1PvB3UoG6x15MFI
	mds5A5IqOv+UFNv29gNRYtLaPraUfR5YvbwaPMWLB3mU9VyK1i2lqSeyA9DVJWUc0E+hlfxjf8r
	ShSBy5YF7KKYXn7wJClJ1Y0d+nJAfUU478ALyqbUMI0rMKrh5ju9jAytRAu4iTbEKkBVmfYSGrc
	dHWKrZvNgu
X-Received: by 2002:a17:90b:4c4b:b0:34e:5aa2:cf61 with SMTP id 98e67ed59e1d1-35368c436e7mr4203172a91.28.1769235720770;
        Fri, 23 Jan 2026 22:22:00 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:00 -0800 (PST)
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
Subject: [PATCH bpf-next v13 11/13] selftests/bpf: test bpf_get_func_* for fsession
Date: Sat, 24 Jan 2026 14:20:06 +0800
Message-ID: <20260124062008.8657-12-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253045-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.811];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A5917CB73
X-Rspamd-Action: no action

Test following bpf helper for fsession:
  bpf_get_func_arg()
  bpf_get_func_arg_cnt()
  bpf_get_func_ret()
  bpf_get_func_ip()

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v13:
- fix the selftests fail on !x86_64
---
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../bpf/prog_tests/get_func_ip_test.c         |  2 +
 .../selftests/bpf/progs/get_func_args_test.c  | 40 ++++++++++++++++++-
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 +++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index fadee95d3ae8..96b27de05524 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -41,6 +41,7 @@ void test_get_func_args_test(void)
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
+	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..7772a0f288d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
+	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 5b7233afef05..0a3236a7a109 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -165,3 +165,41 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
+
+__u64 test7_result = 0;
+#ifdef __TARGET_ARCH_x86
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0, ret = 0;
+	__s64 err;
+
+	test7_result = cnt == 1;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test7_result &= err == 0 && ((int) a == 1);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test7_result &= err == -EINVAL;
+
+	if (bpf_session_is_return(ctx)) {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 2;
+	} else {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 0;
+	}
+
+	return 0;
+}
+#else
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test7)
+{
+	test7_result = 1;
+	return 0;
+}
+#endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..65f7e1f182bf 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,26 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+#ifdef __TARGET_ARCH_x86
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+#else
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	test9_entry_result = test9_exit_result = 1;
+	return 0;
+}
+#endif
-- 
2.52.0


