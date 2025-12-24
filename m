Return-Path: <netdev+bounces-245980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB91CDC54D
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BA73067314
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A994347BA8;
	Wed, 24 Dec 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e54ujjhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9607346FB3
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581796; cv=none; b=h9UAvTu+vR7BEWQVIpPMD2i8Ra6UV1/kClgW7z5laZ/Wg99MqrFhMlS5bIZTcQExBnKIOX+Gw7ZLu5buhZJIdihsN9/4qn+cVrRs7W7AjeeyfYMNvdvCy/iOY/5kCNYvssUunogJbOUC9OE1GxaTDbU6dZ0CIuRoU1VRnVB6vVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581796; c=relaxed/simple;
	bh=7SDJuFphpW3+olwFXj0xPVEig/npNUEHxEDid1Ga1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtiyQQoPlciwNp0dNwvkPO8x1PF0fONftiU/lyPP6joXq+1uNdhfqyZkJtQQ+MDr/r+ZyEXlOAqnRjIIKiaVUVzyoeLsj5VKAJlUGSfJ3elx+9GZG/yLxlTt8buOvwQ+fg8Cq5cDOCZKTI9b8sUuRQ53nWJAARKwH+q/vkyyfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e54ujjhf; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7ba55660769so4763657b3a.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581794; x=1767186594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h66nM9SmW+4KvKNcMfrx/eUWGHnc/5Crgy2rlwqjCZQ=;
        b=e54ujjhfhAfZrgyRuUUB/fnLE+/329MHOKPZK86MWG16vin7+5wg9p1MIkUQblZtxe
         iC1avUf8lM8HmWD12FBShl07YQm7NJypN/eDozi6B7OtfzPfe5SSEkFW1XSm5zf7n3lW
         bFNZjTEVWxhWHCwn/NzlTKCNySAyF/V3sF9XiFDAtYjAO+u2cIxrSSmFBqDlxD35J4Ej
         4RuCynPLKI6cZpM6JFBnf9P71wuqmcNrc5oJofCB3HJrSEOgCGUvm7ZCvtuKrVRo66nI
         5E6gG3TY36wKHDnJztsA6tu6D8M53gkvlAtPSyAjqXgBYWjJu4Sj2TVbwZnHTfRxHvIq
         eOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581794; x=1767186594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h66nM9SmW+4KvKNcMfrx/eUWGHnc/5Crgy2rlwqjCZQ=;
        b=uckx6RNlYOLVRshyxLdX35nbEmKnLjG2W5QR4IyqK/A15P6RhEm6HOWgT7UnKOtjkG
         gUARQylPjEu+MYe45eiLwbX9Qcnd0grJm6gVAZr6bqZbgByoSCcQNqER1sY2MBKYiK/i
         ma5HDSQq8gpB9JfkP4mzKbewdrdY+ron5iC0oCu9bpu0kQeYXfp/uj2O+VkAG2tXlC/q
         DZuh03sT1hURodtcncnyaKiBPgzruyf0qF/Wfa0iKrFmsfcTYpYuhr1PMqAx7DgP4iA0
         /hsJihdphIzNAfAgz9mH8THpwLZZBk4rkAqGHaXhA5PYGDJmlHw2lf101Yfzymx7SUp2
         Hpdg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xikxqMuonvljockpI+o1bLqVfJF5UGBYVwku09pxxYMtUbHR9EvIyT6XXYMl62h+LxXj2ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxDsYTBaPh2NWVDyk7ulWpR35Bs/zuAjtwy1Ck3LibagUdhst
	rdJ1HbcA5JBXzDXZXbQG6A0Q+1n2BUzW0FJ26IAOksmOpbeqU9t8Dba7
X-Gm-Gg: AY/fxX5FUDvcCpZnQJhRcH306FvuGH8ygAt3pDlmlQigevR7xsJnvHQv6XfrXl3Oqou
	hJJwTGwEPn5HCtMW6LzcX10GP+ywVCwTm60Caz9ONP7S+qh1kBual7zGxonmd4InWblsMzXAgHE
	efC6C7QV5mjZ8EbYIaDpswt3Qo3lMpVQPPoAAWccNepYMPC7w3eu1JE3imrvP3SnGCcOI+dygRz
	OeQ3cH4yX1iO17WvjTjDZei9fHeZivJWbeWjuWnxRFZoBU92zO7YxA4h8BaJR9IPCask4ZFwdRu
	stycnhAwsweG4UmszTQDcnwahKGNOt9mSb7ZHsPX2AMcZbqGIQmeQakfOqqdQrP50YR6CLXjKJr
	bQ6FL5eWAOqlPKBEviEKAYGFb1TR4A06BVFfeS2HMyDtqaoZr52d8rF9K89LEg5lCcS2ngxOZ4Y
	QZXbZRm98=
X-Google-Smtp-Source: AGHT+IFg2dw1lbCQhvhHSUK/xEBgEMEUo3jTVgV+JCGMWjyZREF95HQ3ZyvRsYpfI/0QHSvjsunkAA==
X-Received: by 2002:a05:6a00:1ca7:b0:7e8:4471:8dc with SMTP id d2e1a72fcca58-7ff66e5d527mr14511852b3a.61.1766581794132;
        Wed, 24 Dec 2025 05:09:54 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:53 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v5 09/10] selftests/bpf: add testcases for fsession cookie
Date: Wed, 24 Dec 2025 21:07:34 +0800
Message-ID: <20251224130735.201422-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 25 +++++++
 .../selftests/bpf/progs/fsession_test.c       | 72 +++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 83f3953a1ff6..2459f9db1c92 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -77,6 +77,29 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	err = bpf_program__set_autoload(skel->progs.test11, true);
+	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+		goto cleanup;
+
+	err = fsession_test__load(skel);
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	ASSERT_EQ(err, -E2BIG, "fsession_cookie");
+cleanup:
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -87,4 +110,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index b180e339c17f..5630cf3bbd8b 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -108,3 +108,75 @@ int BPF_PROG(test6, int a)
 		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
 	return 0;
 }
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		*cookie = 0xAAAABBBBCCCCDDDDull;
+		test7_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		return 0;
+	}
+
+	test7_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test8_entry_ok = 0;
+__u64 test8_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		*cookie = 0x1111222233334444ull;
+		test8_entry_ok = *cookie == 0x1111222233334444ull;
+		return 0;
+	}
+
+	test8_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		test9_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
+
+/* This is the 5th cookie, so it should fail */
+SEC("?fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
-- 
2.52.0


