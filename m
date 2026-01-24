Return-Path: <netdev+bounces-253018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sItGLZU+dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:37:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317387C601
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2C1B308DBFE
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082C26AAAB;
	Sat, 24 Jan 2026 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Ktq0i2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0471A073F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225600; cv=none; b=PbWi84AaZZ4hWYMMHOpLql/HtEh3q3ZrHRvg2hm9ZrFrtlmGLNL9XSZqOuU9KTrYKLnGxT+DSzaCS/To8JqEr3Ph6DvN2zQ8r7dndDVANw6GtvLp+sqn8L/m46k6fRajUk+Az9S8rC/Lz5lXsi4JL8QxuIAwQ+9HJcIhKqRdFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225600; c=relaxed/simple;
	bh=MY0TzEwIF2cncGc4J2MGjes5OtwOQCXp+QMlMZ001rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvCyR+tNsVBEjrMJmYt5MKnkNZDTZGmR5fj175Z55qpMjiNsetGnMEeMtO0oEiTbMFfllknnQZXLrHaGTKSjEAAHkd3bXH9fSlkBCk761/yGEFDJSqPVbz0DZ0zl77HImH53HMrDDaJs2y+kYXOrnp+sqoCx1KH7VNzB83CU/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Ktq0i2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0fe77d141so16687515ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225598; x=1769830398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=T2Ktq0i2acqqKiOMV8Kuo2CUC3O7L5j6ASCRSCDI+RxNv7a+BxckrcDGtH69cnUHi/
         2P8/kCWurwddyGxqpSW9FBXIGfc4e5Kpd9S6K7Rk6mOZSbsgAtioDDbirhMqvmc5Ws3D
         D3AMZ+z58quWI9Jvqtv5HDgoiiYJWkh5kfIVsgcB3O05GTRwjOG5+qrf7jr2+l/4lUEn
         SS/adGdDzZdYWCsZY01OsVSq2VL1Sy9LUD1DAsand1iuOG1pgGKL8XP69iQqjJuMcO7R
         9YJjBRM3R2l5YE8iHu0GV/0zryinbitQMEyl+ojJTPscoUFjErLDffW8r1PUQM8w0N/N
         GjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225598; x=1769830398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=VWNvRQ4eKh9rMIWZw9MxHdYiJtOHUJQ8QcB5IJkpkVlkbL7CME+ps+RAwxtbjs6E6I
         HJ98p6sXl1IMgQwMdHGUgzv/iDr/HDmRNyw9lhhQlTw9d1taJHGbzzN2chnmfO4+Dj8w
         C7TkU5R2ml5E5EeAOwHJ9FH/y1JkV5SYmVubsiPZqWtF8Z7oHyT64hVUGLZ54aA/c5pa
         yAt+hl2Wn0T8KFysYfN9/MOYHdChtUg0Z+FoUo+5lYQKhS+3KJw6ZQ9hHjegqI17f7by
         b9zQlFU6jFp87GV52467l2rQxIUYL9yb9T/WmpJWhA6N1z0fUDXZ473FMnkBLKwCwTM/
         j/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVv5X6U6Vu+wKZfImKPFMDCv8yzjLxJn9qzrJvfS5ELYKZ9dmWEgD7FnQatH8crmzVBvAi+UjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5+Ks/djqIG3EA1SHa6CqJTJypa5zgO+Wqgu2K+9W0rgrP0FL
	mYc8PFvmVQ9p782dIR5/cEpRjgSG5lmmlrvQOmGkhPUG+muOA2OzgLT/
X-Gm-Gg: AZuq6aKXS8nGRxNhqD4Oh2TvYXlDqzNzIBqoWnlxjRzX5XaT++5xpd6Ao9yT6YIOFuP
	RwB7gJy+4zifc48J6uOU3GQrhRNobB/G098j5lhxmMcAxmdIXPQTHuIOet/QMwR8EiYcaUVJn+H
	c6yEzV26n76Qalxq3Y5ew7btZUMzEMaBZCId13v1w4TiTy1+ifSiS9lBA8swBMIvXJjjZZeGjeY
	qaDLNih5idH+Ier3jIkeuMtJCMHN2cHkIAHZBACoydfPTYaVS61marHDYJJUe/3sixGpKeFulx8
	Cmk8ihx4wMyXKFIiGoSKOKGUZ6vz+UV0uxmkUCPAkD9RJq9KOmHwHVNWA2ojLdsPtYPFzjvvZz4
	DelTk+YUVObp9B4PnFtFXOrUAHXFle8rn6/FRfKJt5DZ0GMnOFp6KIcpK8V2y9NJp367gyvKFgB
	tMyPiqPfGb
X-Received: by 2002:a17:902:db0b:b0:295:20b8:e104 with SMTP id d9443c01a7336-2a80ec7fa5amr32307055ad.58.1769225598537;
        Fri, 23 Jan 2026 19:33:18 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:18 -0800 (PST)
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
Subject: [PATCH bpf-next v12 12/13] selftests/bpf: add testcases for fsession cookie
Date: Sat, 24 Jan 2026 11:31:18 +0800
Message-ID: <20260124033119.28682-13-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253018-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 317387C601
X-Rspamd-Action: no action

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

bpf_get_func_ip() will influence the layout of the session cookies, so we
test the cookie in two case: with and without bpf_get_func_ip().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v12:
- add the case to test session cookie without bpf_get_func_ip()

v11:
- add "volatile" to the variable "cookie"

v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 34 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 66 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 75bb42942b67..0c4b428e1cee 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -77,6 +77,38 @@ static void test_fsession_reattach(void)
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
+	/*
+	 * The test_fsession_basic() will test the session cookie with
+	 * bpf_get_func_ip() case, so we need only check
+	 * the cookie without bpf_get_func_ip() case here
+	 */
+	bpf_program__set_autoload(skel->progs.test6, false);
+
+	err = fsession_test__load(skel);
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	skel->bss->test6_entry_result = 1;
+	skel->bss->test6_exit_result = 1;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -87,4 +119,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 0e1b66b2dddc..211332bdcccb 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -95,3 +95,69 @@ int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
 	return 0;
 }
 
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
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
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
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
-- 
2.52.0


