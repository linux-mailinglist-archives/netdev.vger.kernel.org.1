Return-Path: <netdev+bounces-260482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG8aI5iOnWkXQgQAu9opvQ
	(envelope-from <netdev+bounces-260482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:42:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26486186749
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4190318D224
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE237D116;
	Tue, 24 Feb 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ5CgP3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F2D0603
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933156; cv=none; b=PIasBDyOXI2PeQxHMij+5fqRLD6OEHUvd5HLapHqJDvp20GOkn+zlS1xukKjkcLUfXxujY79uMxq8J3VpIE5z1k/O0pCImPrAHY3fDwmLyt10nYQTrP2X2w9PZWBENEjBCZcCh1WiImOSZBfiQedazsEcmNx0Duqqg+fuLOQ4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933156; c=relaxed/simple;
	bh=4sWOiOmov7pXHesk/kMClarPFFoDVRWZZWw5FqizKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+W0D64VA3D4dgtTlk2uToX7C4xgWvhaEixx3Ti0WlZkTcydrPbFabwMvRuOZakqN30zOt4Nv/BZcAxsYt1ZWDc1avQ+6Odp5IlypaB90ok0WBBHMFOAu72JKrj4g/zOCBqnBCvhEAP2xc4K4wbxIgM84hChpcVrEFSEykgvo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ5CgP3R; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-463208653d6so3582576b6e.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771933154; x=1772537954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0osYvSfuq+cEJNXKz69BQQO4P3x6o0j/TaGapvJ+PU=;
        b=FZ5CgP3R5HHfbrIgwR3SiARfElLPTInzEuDrZm/n709TwrFaDnTxAMMm9vOxzZKcW3
         2D5bKRUA+KgK94sZxWDALffpjsMflTWXYOe8VWz2jkQQ4y6h24//+j2uZnY6f+b76eJq
         2u71LBr+eBcFUcxTZpWMwqIK5U9vTVFe0hhai3HaLm1MDhyUDrm/k6PLQt7PKMHa1ux7
         dkhe+p9C2GgL2SIPQI9cf3InjCATc2lDGiQSwd0V4v71U0xuEFTt623REtrNuMB+fXJe
         MEGVidVsgW06MNN9WQDkZvb0xVlDvi8yC3stTDwcDRSllrPKfzGLjovGh4da8u4QsPpQ
         GuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933154; x=1772537954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0osYvSfuq+cEJNXKz69BQQO4P3x6o0j/TaGapvJ+PU=;
        b=WX7QUpicEMvdOlSDz7taxoRk9+yXqrjJhodOdZDSJLD/iK4E7Qlx1tU4MSfoJgzBWY
         GAxam/tNQnVTpGdIKTn9FkIIVnLFsS2zblW5agOEdO/aFUV7hPSZzRZmddl3gBHV6tAd
         CpZ5qkS4IfJKbP/1ZX0NGn26dA/VoMUacrniogiKi9gvEfZpefOu3dvKgM4YZVetuw6B
         yISgT4W+OLPacpSFAU95bUXQEjD02J0qzv2x2vZO1KrUNIEhGmmvT7dE2TyjkNQh6NjH
         vTDZCid5UP+Vme8wSHH/hLmpDAk84zacx2WxF9WUriy3WC0tY0G5AYH3odg9Y0IOHaO5
         k7Ug==
X-Gm-Message-State: AOJu0Yx6biizBJGYBNfvvrbXJeSYK6p/VwH/2ETWcMjOltNmDiKacIvK
	9WbRJYRh8N9rqQqM15WKMp7bMwliKA3mvsuWwXSi7k0odoX7vsK0kk0pDqqG3w==
X-Gm-Gg: ATEYQzznUs2xX+Stt0TZu/8vPaYXE7iA0IJypNjf+/fGE//3bUVWEnqrn1XquVpTgI1
	il2beCwNoeDePWojtLu2AIftlTDqTXgGaYGuVsZ4ILsIr5yDhTofdyr8GanU8YsQ87Vb8C0WRW9
	/CdEpOyV3Ed9tG0Rw+axpkg+DaZ4A27omP/E6Isgielzb/3t21tLsE8nqnZlVl3BroNMrn01CtB
	0TtF3GBOUr0Z2bdVrDo/vw6knU+Hl8i/a6fv3eK47/ul2Yu+QyKvMaD5eYdXYb6KgoEU2zVdqlK
	NCnbS8HmUPiOGd7o6YtcNfQ3bmg1XH0sB4lhlX1O7CexTeYD/ntNwn176tIGv/MPaIAPyurYRaX
	GlDWeO7HFIg8IPf7kQt5G5HuXhC9MWd+8ubbsRbn0gzWkmQlVHa7CdngqTRvK5TRQvIIMrEzAIA
	MlLiYjTimmN23lMBwgJCAvIzAWqZpahsil/vQ8mveBdfBvvRrw3hsn9IWoCc28nSKx2xOO5+ft5
	At6eABgPqJyGMyG0Hjsf+0=
X-Received: by 2002:a05:6870:8587:b0:404:1967:d6f7 with SMTP id 586e51a60fabf-4157af8cb38mr5873853fac.28.1771933154180;
        Tue, 24 Feb 2026 03:39:14 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9a388sm9899241fac.6.2026.02.24.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:39:13 -0800 (PST)
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
Subject: [PATCH v2 1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
Date: Tue, 24 Feb 2026 19:38:59 +0800
Message-ID: <20260224113900.3331-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,amacapital.net,chromium.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260482-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26486186749
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


