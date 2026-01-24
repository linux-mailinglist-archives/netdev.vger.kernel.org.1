Return-Path: <netdev+bounces-253046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJbYKFZldGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:23:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D07CAD6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C89A4300D34A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C12BE02C;
	Sat, 24 Jan 2026 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTFVcNiq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B612D837C
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235732; cv=none; b=mAXoT1TCwGoYgXjCymwF+zDXi5j4pv0Aqqrv64ZEUSC6UjXU34L2Ezg59o50Nu2dZfE1+zLJbgqqYWiLYZ78nuvdH+i2Rn3MyYofwPQuyV6GVu7I0H4uQQoFGmysKOgTbKrEGE5CvYLkXcaaifyiPSJkGT4FLhqJdVSAj/33cCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235732; c=relaxed/simple;
	bh=MY0TzEwIF2cncGc4J2MGjes5OtwOQCXp+QMlMZ001rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz3oe/GrCcXB/ITlPGeg96lXdmYNgTM98RVCzkiIei/YTu/f40Y6L7V7t3o23YvzUKyGatUP+MTJy3EK5IbrYrglMC3Qk2yY9BP6lOHM7hjDoPf8jQzI6L8zhR0co8zeiNU9J7lrSYUf1kBqOEGyoOcCLnAOfvFASGu9od1IbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTFVcNiq; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a09d981507so20079075ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235730; x=1769840530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=TTFVcNiqPiJrrrHYoxUCBVHB70RvgoGvGb8IKFBwd8poQo/qBDB/k4lU1CIu8ujhV9
         0L3BSht2kzXWJIHdddQ6QtxSnlsnlVoJxpP/HcNINHWT9BynqdMtrZ4JpSCkKuAhIMri
         DLCmpLx16q9VTiwJDnRWibzUg6kwr5RAJHEw+kguqRcIze8BPAuUYVBeXviUdpWGAoUE
         J1UbVaazzy2ufBV3KgG3rA9Xc6Ajq/rDkCqyaJsAybsMX3ne/GA0IcQRJdSZq79HgwGX
         7o+6uaiGDx3UuBrhGU5849XBj7EaTQCDSwm8di0T02pHF70V6PVwZsURVUMRKDiAMy3n
         34Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235730; x=1769840530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=hq2hbS+pySLSAojAnCyblr8k1sxqknVQglsMdsikX9VRp3jqmiZmFdH7MtJPHvkYvy
         Gn4/niP6ep+zmz7250OBoIQfTUx2lYWS9y4FgcNp5+C4HIwqtegMv3WdhE+cU/ggH4Vs
         FcK+eBLmOCW3CYwHOMUv/IEBSLdfH0WofjFA/aUP8QX8jRMlH0t0FgOAOz3K73p8mp4L
         mMSCbFzwN89Rtl5Clwd3Cm1vj1Vb10KKj+zmA69tlCMhVkO/3XJ/bq1w0hMx/b3lM+mQ
         aJ/VlifHbDFQ1pOkb74OPIgTc66SN6+/oUf042X4Y4mwcIi1kWrfaAIek8d/80/6wGgu
         1RQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7KbUNv94NZyfiqZV+9j15Hti34494e25AaPYnOoqYeF4Sh7GA8oVjo4FnnXeVv0Ph4uCUkHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXlgKEiw7bmCdsG2xJvTB2MsPi91NGN1gOkydikH5JkzgkFbS
	qXfUPePOkscuYi3AEG5UBgN9uYy63uSdjrGBdKyfEQJ/3KpUCWDOtR3E
X-Gm-Gg: AZuq6aKR3XFbzD7qZin/5zCIm7JWUSU+Re0jfHr92wl0r3IhkONz97crDppun5HyeUD
	ZIEaohG6pKWh95sEx9i0y72dDa4YN16HElhD9QRQfLLdXHSeK91ZvUxPUIlxgps2dKHwLKyK0JA
	5lZ3NXIzv02NnPgnxRZWHjwBbRZUjVDG0p2824KT8kAjnJQ9IksRs2UxfSU0mG3CT7vtc0McYii
	3pYbX65NZ9qWkcjClKpDoEpDyDkcrsGyaFiQRVKcs1H9hziaZ7RGZo5TGDrBe58pdRtofiZn2po
	8BFQ6DHZN1y6wmSPNmjBKP+smisz+AMS8qrFlnG/NJZ15De3n/T3WsjUixYNRfK0G1NlKIdE6uz
	baJS1hqhMRFsC1EvJqljDyiJxrArhPNvSQRPHgjyr2YBygZEwt4mo/QDXeZqiOEJTmypQ2BG+kR
	ZgZb3LlIjp
X-Received: by 2002:a17:902:e744:b0:2a7:cb46:7069 with SMTP id d9443c01a7336-2a7d2fbaf36mr69604715ad.25.1769235730121;
        Fri, 23 Jan 2026 22:22:10 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:09 -0800 (PST)
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
Subject: [PATCH bpf-next v13 12/13] selftests/bpf: add testcases for fsession cookie
Date: Sat, 24 Jan 2026 14:20:07 +0800
Message-ID: <20260124062008.8657-13-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253046-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.798];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 4B0D07CAD6
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


