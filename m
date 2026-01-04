Return-Path: <netdev+bounces-246751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C720CF0F1A
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939D6303CF70
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F862D8782;
	Sun,  4 Jan 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4XuCL38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9085C4A
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529833; cv=none; b=O/3XqY3RNz9IrT05mB3Bt+DUeiUsgwEkJ8r4JhVDhnCPiX1wdDbA4XalulTj8kP/VOE6URk4zdPpz1aay1rnVLxlMzlEIXbEFYQXKvbSakJAkBx4HAdu7IrDOzHiIE/jGtAQC9Y4guV9UFZ0ha/7EHSOB/WX8JlA3LEifRmE6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529833; c=relaxed/simple;
	bh=UJTrEvbHHc/LCR7ssI7rQ2WfdPkmcvBgvYjr55P9c74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogr3/mu1YMk2VmOIgkq8tjfI7izexQp4dHjuqMe6S9Etdj7wVSx1uVmP9Gfs/htPl3OCtsiVaIEaZfLmCcRHgGjapyFHwaaYk98zAlwc3ZiHzzOYb+x2cswD8ZrvFTjfcve1eKxR41oz0/fWjqKOypbDsjsWcCFHJ8YjhNVOleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4XuCL38; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fccbc683bso99727007b3.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529830; x=1768134630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as3rErWMsms+S9eR1OsrQ4sWO/jfg5iKakL+peUOPUQ=;
        b=Y4XuCL38pAHICMYZv49URD20XeaQJdqZ8nG7lK1FANUqBA3xCYq2XtNHbIy/X8qdvq
         WihzWVvp06w18ZRixChG6v6S2zPz9rssXRl/39ZYdt0Hq7eIm/u8zFdsGG1hvzZ3gIL8
         NCeubrcleZmmoWZnhkz8AZ0PhYNRHj9ug3F3UDewcTmOiVI4GAQtJGFD2b89A/3X0ZO5
         EMBaw81CTPdP0mg+X0bdbZOFGLtE0CiUckRXgs39itl1/bgcSmu3fzwiXIvVjIJVgJOY
         bLg/5QnkVR9+lClbqkSPY902kio16s3tQTcYxvF897P1Fyj8zBy+eunP6MlgwX+zqeWh
         49dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529830; x=1768134630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as3rErWMsms+S9eR1OsrQ4sWO/jfg5iKakL+peUOPUQ=;
        b=idVNvILvUDfJP1dsH56UU7PQ+k0KnEylF6UCXTz2uVB8V8OCAymQ7qqJfs9nh2UYI3
         mqdAx7HyvEMaZ2VJrcddQztYVdIBbajMUngn9cW2eEJ3iIwtgOVGe5CMI8jVQNOse32F
         Nuvri3xkHNrWWr7/xRiylP4ZIRRADBLaUHs1YwR48rbvnUei+//tGIy7OnNvXpK/TZ5u
         TgRTt7o2pMB5g5UEI64s4+jmccIvIZs/YoO8wGEuSavmj9Bdd6SB+r4r3qRnyMqMUQtm
         uE+mC3BoFHz2sVrtYUKwsE5hFV2ftTGqLWqQDecVzE16ITkHPQxLXnn2OFetwzW/Cyj9
         Igbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCFwHBUKiHR6Xl6vi0MwpNlR56ggq/Q9rpM7p+dCOsiSzywCXgw2oiktmptBfcO2wdUyTLu9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDs6A+F1tcoFK8NDADyDc1nbXmh7b37e9yESGDJuTKDAlTKlg+
	HcbrZgYBiXS7UDZDX21YbfwyhxIrtHzYKr0SxowCqTrQVip919lEXDMO
X-Gm-Gg: AY/fxX4sEo1S7HDUDuPAsFLfOMeLJEQSEg+zIJVWvEW21xY8GxkT/Pgtf6iKGdICWls
	nslsRqkOWU9BiEtFSCnplOEuS7PUMe4dN3ylHGI7zNdpeKPtM0LiFYt/a4Dgmy5rYxxkCVp5f4p
	meJupAhaJ7tOphE908cOOXoL2odF/XivpZaRoDCDVgElspYHGXZb3ChyZzzsXrNT1Alp5Be+hwB
	9SQIzV9OxdQEhxSyeckHacaXFwWN1XHB3VETxmpPXVdmJxNUyb8qK5YARtOeba2ejSCOa/o5Mfd
	nTOzuoxMxDCGp2O9v0EpkX3Enjjy0qoe5bA4YjU55xmdZK+VtcBxfzxsN4XcesV0HKIadsdvYv4
	DzZkKxmzgnfeKWY1WzapakVAxEjDbSmrSkSs6JP7nsuYxsfTnyz9eARS4RuftLY+0lXRec47fdK
	0vNt5sMx4=
X-Google-Smtp-Source: AGHT+IEJ9FbG+KJUSmyqe4GlcGQqpBKjEIjKXafZDNIvaw0YBShwM0FwK00UNy6MiyBtchGBy4NDkA==
X-Received: by 2002:a05:690c:23ca:b0:78f:bcc1:88e0 with SMTP id 00721157ae682-78fbcc18f16mr386621047b3.1.1767529830518;
        Sun, 04 Jan 2026 04:30:30 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:30 -0800 (PST)
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
Subject: [PATCH bpf-next v6 09/10] selftests/bpf: add testcases for fsession cookie
Date: Sun,  4 Jan 2026 20:28:13 +0800
Message-ID: <20260104122814.183732-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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


