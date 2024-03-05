Return-Path: <netdev+bounces-77574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50469872359
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18551F219C7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22B129A78;
	Tue,  5 Mar 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u/zwGug3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71E128394
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654233; cv=none; b=A5jvpfOSOF8eW4QkGZZxeKSW4V49aJ2PJwJ1Ud766TuhWt8DS1Q2Qc3X8N+yoKx+nk3UcMMHdzerHpf96NG2O7ZR3NZBB8abXyQVEbIBxRot3RE2waWijYwavAmCd/FDlLIJ1yo4oTDSVfHa7tgQG7RTJd8XV3ZEYLgJqcXoSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654233; c=relaxed/simple;
	bh=unUHeeD7nB7m3/v8iE28UJN8bXkub1FSGBrDIstyyUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJuJmGE8Bjt+7LbNzwdfe/LwkeryacZOK+u6WXvtFMF2me65j04MKcXT1FLpD1Sd2d17Oaz1Hrc1vhsqZF4A08lL+ox5uir9KMG9PfUPVCY2nnjAtHsX7i3Cw5vmCdYf53wOrR7NWjk+UAWWWU/7FRbvI9ip1CmlbFZysTz1aHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u/zwGug3; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0Yq2S04zMsWRx;
	Tue,  5 Mar 2024 16:57:03 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0Yp67lnz3W;
	Tue,  5 Mar 2024 16:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709654223;
	bh=unUHeeD7nB7m3/v8iE28UJN8bXkub1FSGBrDIstyyUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/zwGug3aleGhQg4KvJFTjK2nN+Apq9IC6epAkIqgUcw2T6pU0GUrEw4B/7RFJcMX
	 ayBXPgVJvZ2p/XAIh16xE6d0AGINZyMB97l/46fw9csSW0Eq9kgdX7qP4WAsD+E0Kg
	 QczqIixu1Hv4e3han6Vsrez5iiXtALzkzvejcxfg=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
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
Subject: [PATCH v1 1/2] selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
Date: Tue,  5 Mar 2024 16:56:47 +0100
Message-ID: <20240305155648.1292566-2-mic@digikod.net>
In-Reply-To: <20240305155648.1292566-1-mic@digikod.net>
References: <20240305.eth2Ohcawa7u@digikod.net>
 <20240305155648.1292566-1-mic@digikod.net>
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
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/common.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e64bbdf0e86e..f40146d40763 100644
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


