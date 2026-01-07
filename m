Return-Path: <netdev+bounces-247600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0871CFC406
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 07:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5BB73010745
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB55F2C0261;
	Wed,  7 Jan 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLk4fZ3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1F2BE7CD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768353; cv=none; b=PSNLRJTSKQzphgJW/DCqCX8yb/mNw6pUaJ9XLJsaG3H3F3mpijd9nqqPzLV4uoOpB6C7CruTTvlHPe/YJyiYWh8VNz/AIRtS1RsbpGwh0uEX2zVbR9TAojePT4NH3qeg1YWJyBqyeIz2Mc6Gl6Jvfya4dedrsSHcVcHSqZ9hCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768353; c=relaxed/simple;
	bh=gXCuEnHLqfXsAH6FAwsjxm9SB5MyEaZI5cp68UEcCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXMK3Z9VJrVAid/+lUiXuzleYw+aOfe7AeMZHTecTanhKW6czz/3zyPrpDR3PoN4zzQ99jfxvn0RILY6RHSVlHkK6/jsIZhpAkU8Cw/9j3qLzuNxTwOR9MGk8syoaXDLJ6P0a3asqAozxXPwZ4FSIgOY6l8ssqWE6eB9xd7EoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLk4fZ3G; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fc4425b6bso18424797b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768351; x=1768373151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=OLk4fZ3GjbQr2LNTSf/r+QXaDUr5FWJ5THsDhrzOybt6jDt7jiIouDfS7Tpbo8/HMo
         WTzj6NQDmbdLxQTI5Vre77hz1BdhvslwVYAECyrneGFQqMBDeJVp1OX2Tg5kDtvsO9rV
         qb4NeaxZL8RU76nDF0kkX9y1JJqpGRcKPZw/57WAUSKDpiJrmAZpWMpIb46jtxjcVo/m
         uJGSmrwKEVlk83PAiJWSeqzQRBjiq19L+EfRo37QwxkOHX1vuDAZJ4e2ki/oUEn/BGJw
         2BXYK16d5SYvVjvFPbuWddfHfkMREVk1v/Ljrah0hO00t/Tfjk5JGYwFS6x9jHbXgwa4
         DS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768351; x=1768373151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=UcBsoYLK4HEm++svLWUXDYDWHcrXczeIffgvPazLfgH6zR376FU7TcQRjmUdBkZaxN
         UMG89qSceOgJMsnojfiT0HiGbBeEylsHiqmhh/uknidP1j6Ztq6dhdS5WuXWG+1jgUjq
         S2MawOX2bvsLuQ05XapjA9QynpGp8UHhiKjaUf9zc7GjcaIVO9W/r11nDHDpU4k0TLLN
         QVDcSa5IbDqEFm4VAIe7KfquWEhYRIQZzHdXAg69v78t50spvqR52O96Y5VgLkqOVDHe
         9aN+BRrcL/KBg2yDSFHNsZbGMNhCYPxwx3yZL63XH4ikKw7b4QZ++dkpw0o78eInghjy
         2ejw==
X-Forwarded-Encrypted: i=1; AJvYcCVoyrIryZv4xy4iCjgJI4qyHHo/+jV4b0snHKZ2TIoLtt6pdxibTPKetQGE7vpNOHgzdB/L+oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCC6x0gEkm27OSIRoZaBgV2SHpxyKLgYxmD8jSq3KosR4QlS5n
	Afcbnuk3NiV2ZFmR1bxDRkHnfRNEktEDcmtgw1Gh0T++t1rDIzVipZ07
X-Gm-Gg: AY/fxX4+kcXtpSnPfof0yv0CFZ8g6VLrc091GkRglT8oIn2L/wyqW6Dd1X6mOURHor3
	WGuc/eRkogv6rA6kN4IBkQh6iZZl4WsXB9ddFqbfri6MTQfFaOz8kDIqXZzXa9FKMXf/obfNP7z
	xnE6BkQalWlvCxup+qetjJZrajfEtt3IjYrjRPJN4D3t3te6YF9boulmg9j0gWOQ45R5U1hBc8E
	DlAx/eshP/G7RAjoyWFJeSOzdzATr5DVQl8HrTAxBzFHjlj7SnvMy0Sw+MADK7ZKKkM36RsecdP
	z/BDhhTvXAgSa9nJac5J709T1JsdiAcWHVyxDUULg48FKkvgpI+fxbeuNRu4/IdctrS5iwHZTXZ
	K5jNhk9jOwL9OGyUN2NVQqA4nRKx+KQokZDshdbODhB8ziOETiDQmX8hkeFI+FNfbLWpweU+6Yf
	jRHbg2Abs=
X-Google-Smtp-Source: AGHT+IHMifI7034zc2YBt79WxlXBE/YcCt485G3onMhXwhhsMw8KLx2Ddjp8zBhrqNHrFRl6QB+UyA==
X-Received: by 2002:a05:690e:1248:b0:646:7c7a:c5d8 with SMTP id 956f58d0204a3-64716c67bd6mr1480927d50.61.1767768350995;
        Tue, 06 Jan 2026 22:45:50 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:50 -0800 (PST)
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
Subject: [PATCH bpf-next v7 10/11] selftests/bpf: add testcases for fsession cookie
Date: Wed,  7 Jan 2026 14:43:51 +0800
Message-ID: <20260107064352.291069-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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
index f504984d42f2..85e89f7219a7 100644
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
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
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
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
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
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
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
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
+
+/* This is the 5th cookie, so it should fail */
+SEC("?fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
-- 
2.52.0


