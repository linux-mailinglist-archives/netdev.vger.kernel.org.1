Return-Path: <netdev+bounces-260453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILTQGT2BnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:45:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C9185979
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD7853044328
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C1379981;
	Tue, 24 Feb 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTMyVgJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8431CA6A
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929909; cv=none; b=M3dUltcdx5m6QKFWYFQ7zC2pSxk0j8UVjw1QSKiDMr0mesu97aX7EAmtsz2kC36eRHZ3I2935wzY+B8uipO+SHXiDioiD/9/bsLoJhmhYsJZbKt+XEWKoSq+LxbrVNr0SkZ0XSZFFcJqstij21X6WX1RyDDPQAkMmEa5+CYPAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929909; c=relaxed/simple;
	bh=4sWOiOmov7pXHesk/kMClarPFFoDVRWZZWw5FqizKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct5WTsyxNB0XFtzOkcFri6f1S9Qa/tkQx/jDRglH2eN6qXhnkdbDgdG2EOCWpCmxu2j0evQkHidwpHkPpWIrPlZtcDrzra1GP6C7zt5bDvUK549Cc8/cag+93sOBWL9WIAB45luNL/5i1AkvVVWQ29vF3sJtlggyJotqv+E+Ne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTMyVgJ3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d513bc15c7so3931233a34.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771929907; x=1772534707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0osYvSfuq+cEJNXKz69BQQO4P3x6o0j/TaGapvJ+PU=;
        b=fTMyVgJ3IrxPZmEE+If2O3VRFfJ1hT4FIMcjIJaSO8qqOVljRX5mFl/D0HP/7KxNoA
         XkhdUWhlIFvE2x5MRqyLa4/5mg47Hu02W9Z5HPe4UfZJjxnkH2ePNsCq5N46RJHLxd6j
         PUi0UsjGn3zr/UFIrdy77z1xkyr3hdk2Ploev4j7dhJ6rXHI9VHjybkZRR+K0lOuRaS+
         J3Q/fO/WfDBiBuU7srADiMX6L4nzOOV5Qqf4YfTosP+ZSApqMz7gyW5ve5fKNBsDtrCW
         yHYjPPAEyQ9x88dSKv6WYZYaPJpqrp9OsL11IQfSKsYQm9xR1a/eLCfN8/9OJZm2fDWi
         WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929907; x=1772534707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0osYvSfuq+cEJNXKz69BQQO4P3x6o0j/TaGapvJ+PU=;
        b=M41MXGZFyRotAV4TyrcKP3FbuWEnwdj837c8SZB+eE5AsQtXoRDl6jnsLwBnk8UFmT
         b80NpuQVX4kaEyK4Y+j4UIpuE9TiaLG6wzeJQPZJnxaaftob5ecfRHKwb7Z3Y1++EYIE
         0fBy4k2wGAdIsS5QoaVmoZsS5DZd3GSXJPqBGqCUL+h0XiwbcNxjsqkUglPpSJY/9NKd
         lfBUFU99RFFK+UoKBVfH58n+qL72kviuGxPVBLT83Bc94POJUHc1hvpgpMlIAkaz4TGC
         WvlPf8YdcSfHWgBWtvgB3o+RnDZYAPeMcmsjV0y1b9Hd9glgx/4rPikD2oDMK2gvfjCR
         KnHQ==
X-Gm-Message-State: AOJu0Yzmo3Zc2clLzoYJ6Bd9esPEfyu3Vgo6mp4oAjsoQYh+hvL6Ib73
	8spLDAoJuMZPntSGhVr8f48dTHrVedBnNYgVKa5l7TH2A5a5u2ZCph3VCJFNqg==
X-Gm-Gg: ATEYQzwcfAo6979n/OPvDJaCBdGBnbb0wZxKot6eVr+++M7DGdpZ1Ckg/ZbzjHodij8
	qpgLW6nqb8dJ42JHgQFBmEE/6AOYGecPiDWWC2sz0blhf59E8Sdv/x8UqW8P3vVJh/714+MWFkS
	KcVKU9xH3tD/lmUfid67A/Fk23v/CqwlCGF1fqyQY+d2LaeXjtFLFXOLpVvMi8aa9A7Of+dHAZ6
	EE+/GiNjH5gJdlsL/DDzyxG/7sGKyW7iMkfR7Atm2MCfo5mbDzyTkFb8h1IVoeadLPZE3jNotpo
	iU8ZZS5oqjZho3EDS1Bbhzp4Qfm/ovkof0ojDDp4xeBVVKGtdkQUyI4/5d1YHg/ZLyAss3UOmzZ
	a5+Wmra//Hsm/gGaqnS55Bf5iJ15fwP2Gl7xsx+NihqJuhiF5SnBTfdbVtfajvrXQQQCD7yedYe
	rJi+0OWIbqddXFFZlPf/ZXSdwkNlUYU/Ib6yACF5Bx94Vlpt6qfoQhl/qBCdLtW3WYm94gBb0zl
	JJzv/vHWAaoU61YtTJ5uvg=
X-Received: by 2002:a05:6871:4724:b0:409:5ade:7063 with SMTP id 586e51a60fabf-4157b103319mr7212812fac.32.1771929906635;
        Tue, 24 Feb 2026 02:45:06 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfa6624sm11210270fac.8.2026.02.24.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:45:05 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
Date: Tue, 24 Feb 2026 18:44:33 +0800
Message-ID: <20260224104434.14912-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,amacapital.net,chromium.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 890C9185979
X-Rspamd-Action: no action

TEST_F() allocates and registers its struct __test_metadata via mmap()
inside its constructor, and only then assigns the
_##fixture_##test##_object pointer.

XFAIL_ADD() runs in a constructor too and reads
_##fixture_##test##_object to initialize xfail->test. If XFAIL_ADD runs
first, xfail->test can be NULL and the expected failure will be reported
as FAIL.

Use constructor priorities to ensure TEST_F registration runs before
XFAIL_ADD, without adding extra state or runtime lookups.

Fixes: 2709473c9386 ("selftests: kselftest_harness: support using xfail")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2:
  - Switch from name-based fallback matching to ctor priorities.
  - Drop the extra xfail state and runtime matching.
---
 tools/testing/selftests/kselftest_harness.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 16a119a4656c..afcba0c4e98d 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -175,6 +175,9 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
  *
  * EXPECT_* and ASSERT_* are valid in a TEST() { } context.
  */
+#define KSELFTEST_PRIO_TEST_F  20000
+#define KSELFTEST_PRIO_XFAIL   20001
+
 #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
 
 #define __TEST_IMPL(test_name, _signal) \
@@ -465,7 +468,7 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 			fixture_name##_teardown(_metadata, self, variant); \
 	} \
 	static struct __test_metadata *_##fixture_name##_##test_name##_object; \
-	static void __attribute__((constructor)) \
+	static void __attribute__((constructor(KSELFTEST_PRIO_TEST_F))) \
 			_register_##fixture_name##_##test_name(void) \
 	{ \
 		struct __test_metadata *object = mmap(NULL, sizeof(*object), \
@@ -880,7 +883,7 @@ struct __test_xfail {
 		.fixture = &_##fixture_name##_fixture_object, \
 		.variant = &_##fixture_name##_##variant_name##_object, \
 	}; \
-	static void __attribute__((constructor)) \
+	static void __attribute__((constructor(KSELFTEST_PRIO_XFAIL))) \
 		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
 	{ \
 		_##fixture_name##_##variant_name##_##test_name##_xfail.test = \

base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0


