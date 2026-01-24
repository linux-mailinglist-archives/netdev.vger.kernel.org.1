Return-Path: <netdev+bounces-253017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DM4LXk+dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AA7C5EC
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E193C3086C67
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5091266576;
	Sat, 24 Jan 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7EoH3Xe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6D22DFA4
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225591; cv=none; b=fPL+NBMA6CnX7KeG7RaNfPV0GW01fhVqDQleCQLcGIeXvOYAtNsR9ex0wxJjkwLOsA45BPfTJtbae4bc8+cVf3FaIAuPW/qWjtyxLQT5mJTlIfgHoU0rOkcN0QYkeTNZZCrjG+K33+4cy4mXXHR0fHpwq/NvrudevOmCt43J3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225591; c=relaxed/simple;
	bh=hiIpT3trYm3UFeAi+Ivpk1TCrDPx1rTtI+5jR2LaH1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBG/k4vJW+Qv7arD2QOf0MHoGk9tAC3YlwSegYMqpc70TuST+x//T9Odxh+fDFUGBusbuD94UQdDc0NPjAV26bVubQRv4jODFMetoRMtTpHfd/nOKEdBBYYXyhoCu1hS7rGrmr2VrNYo4jxaoRfdRYQnNNq4ciAE9z8gWTPTUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7EoH3Xe; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1055770a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225590; x=1769830390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sguImxus6ArC1Mtelx9uzhpdKAYVx6JRUGEnc74urEw=;
        b=l7EoH3XeR8u2n/jPQLVRF8V5OMoNT5YPvHsjivz565/15noL6EOR+3C3qMYTW9//tV
         +dKqHE6N9ZfhSMCfn07rjaLFHO09kEy0RUqlt8zpGLRk7FsGCmJac8bETSes9zLKKqZ6
         Y+MHlT4IXt/6nNjQr9kIExam+LaBKm8PL3yAJs8P6WrbwlACsjhsc6jbueEr/3ic+wbL
         Wzzid8f/n2s4QxP/GTaZo1i/cUnW4BiNiPHl6CTVCFShs6kyZCbbZ5RbO95JvZ33AU14
         ntcm27m1pu3VKxpB4M+d9IdCRRHwMf87NzGjJZwXKLAGZ/+t3X5wQWY+GmM78+9tfwge
         UMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225590; x=1769830390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sguImxus6ArC1Mtelx9uzhpdKAYVx6JRUGEnc74urEw=;
        b=EOBpMtD03s8ywQxlPi36JoIeS+7MVwDciWVhwmgFjKBfTBjRs8BrNQ8gVQh5ky6mB/
         AEs35GtPSoKTsj5WcB5qOe7XbPh7Yj2Nra1RbLpdMwQll4I8x23NH3m7r8P6jLQb/RQ3
         mJH0Yd6Edr2RPmnfdtr5OmX3ifssxQ1OUo7sYVcb5Bk9DSXOxgPlfBAduoaN4Tfx7gJA
         oC+vcASOJaA5ULHELZztSIaifPIs4r7LdTFCWskTvCoTNAkV0y0Kc5ABKC8ROWD6nWde
         063gRqSTY0XOpj/ZhAOyIthbv99pruCpoL4xUIFT24H+CnYlFdo1vuj681ua3vIwMuYc
         ffeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUe2WNpMlM1Nys26boR7Qgbo52QpEWEvdx9LiSB5k4fINimi/qD4AexOsH38WCvml9r8V6Oew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZz3uCQa+76kXIWOrl8kMSNE4YaVyMe00RyYLjUyWuy+alysgg
	TrxCUf4kEslPz9/dMUbgmpeEQHMvEGI8lTNjfO6BBzrUlWVNJDvcaI4X
X-Gm-Gg: AZuq6aISnrk8G5NpEvUUWXhjlv3BlGHY4e1pzMa44IiDqVyOEdEFD3g6ZTkGNIp/zbZ
	z1g8tp1+a6yIRLd67wjMw38Ot6Z2txuMkWQnToDYSowHFv8255QVbOlYXNs4e8GrPydaQQdFNTd
	+1+y0P1JinmZkiJfC/nCTrrflBMg2N+GQNJyDzvZWHdBxlHE9Uw+Y+GsbwZEkBQT/a5fM8o0xO8
	gnkbJooJoQ0No6ORHtVI9aqrZ6zqGODIptuZp5f+KOtD82KO6WtEcSaa9lxkge5DElvmD+YR815
	LVrgMxzqf/TtaTXVrGW0eC5B3h+oEAxtIxvMqRwwpZijE9Hoey4+y8aHqpQdwmWdngpb3h/+oFI
	3Oval6pBqmc2qVDA+HOAdZJh3dM7BtvfYAwnpbIaWGNYo7QCqRklUslkQxuvCAXYEEMZBchLXE0
	uWz1jjsQlk
X-Received: by 2002:a17:903:2351:b0:2a7:5ed3:ba88 with SMTP id d9443c01a7336-2a7fe628b45mr51932365ad.29.1769225589577;
        Fri, 23 Jan 2026 19:33:09 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:09 -0800 (PST)
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
Subject: [PATCH bpf-next v12 11/13] selftests/bpf: test bpf_get_func_* for fsession
Date: Sat, 24 Jan 2026 11:31:17 +0800
Message-ID: <20260124033119.28682-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253017-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.879];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 745AA7C5EC
X-Rspamd-Action: no action

Test following bpf helper for fsession:
  bpf_get_func_arg()
  bpf_get_func_arg_cnt()
  bpf_get_func_ret()
  bpf_get_func_ip()

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../bpf/prog_tests/get_func_ip_test.c         |  2 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 31 ++++++++++++++++++-
 .../selftests/bpf/progs/get_func_ip_test.c    | 14 +++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

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
index 5b7233afef05..8ecc5f339552 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -165,3 +165,32 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
+
+__u64 test7_result = 0;
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
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..bd7598a037cd 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_exit_result = 0;
+__u64 test9_entry_result = 0;
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
-- 
2.52.0


