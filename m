Return-Path: <netdev+bounces-75017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF3867BBF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406721F25674
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB012C812;
	Mon, 26 Feb 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YaPaegVb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF612D761;
	Mon, 26 Feb 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964638; cv=none; b=Tk4j762Be+BJ7qBNpeCfIYMafposhoeHF0DvayBkM7zbRx0swUIQUgvt1miMvQosMkEO6N1wONHpmPxtst+/iAS4TcnGyKMc17T8+AIek1FwpsBGHxftcSbDGnV0yU95bTlN8m8NwkwWwGrvMPXYd7/s4M+AhQRMZDrrpM7NI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964638; c=relaxed/simple;
	bh=lzn0jtPveq2aZBuWKiD3pKlsYwgBRJ4U7D5p8D9Xa9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdezgmXiI/dp3bnU+QQWqJLhzXiy7SGRSJvOy5Zwjro6CJA3FRBnS8GYIwfRxATIr7meqEw29kqTV/Y0aoKTbTGaE8whiUzqrDCCT3VYIyvXOFJlSOPeeNVtlMlyBo1xbnguXMMT1WHv3NRa8Dk41U+u1uldXbaGlx7RM437Ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YaPaegVb; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5XL25Xkz7Km;
	Mon, 26 Feb 2024 17:23:46 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5XK57h5zsTl;
	Mon, 26 Feb 2024 17:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964626;
	bh=lzn0jtPveq2aZBuWKiD3pKlsYwgBRJ4U7D5p8D9Xa9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaPaegVb2VeR9n1J0G87joTNxA5lTSCmCLy4PBAVLu7Lqt12AqXXskAoqUqMEE+hT
	 XBVmzYf44ndBNqzZ/DtYwaTTZ/LFBed7UNWO5ng4R6qBVTShDC5haaNxsDTSXr3lnC
	 gRrSEET6p6I/quv+GrYOb4tdGkjEmqDxv9JQaQ0s=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	edumazet@google.com,
	jakub@cloudflare.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
Date: Mon, 26 Feb 2024 17:23:34 +0100
Message-ID: <20240226162335.3532920-2-mic@digikod.net>
In-Reply-To: <20240226162335.3532920-1-mic@digikod.net>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This has the effect of creating a new test process for either TEST_F()
or TEST_F_FORK(), which doesn't change tests but will ease potential
backports.  See next commit for the TEST_F_FORK() merge into TEST_F().

Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/common.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 425c5698aea2..0bc15d36971a 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -37,7 +37,7 @@
 		struct __test_metadata *_metadata, \
 		FIXTURE_DATA(fixture_name) *self, \
 		const FIXTURE_VARIANT(fixture_name) *variant); \
-	TEST_F(fixture_name, test_name) \
+	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT) \
 	{ \
 		int status; \
 		const pid_t child = fork(); \
@@ -80,6 +80,10 @@
 			__attribute__((unused)) *variant)
 /* clang-format on */
 
+/* Makes backporting easier. */
+#undef TEST_F
+#define TEST_F(fixture_name, test_name) TEST_F_FORK(fixture_name, test_name)
+
 #ifndef landlock_create_ruleset
 static inline int
 landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
-- 
2.44.0


