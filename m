Return-Path: <netdev+bounces-115145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3CB9454E2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDF81C23096
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7A14D2B3;
	Thu,  1 Aug 2024 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiFjdik5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAD14C5BA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554615; cv=none; b=tIWouugEfbHPb96KQfaPVCPaC3nd3qH3uwIlu9cDFRCOpd5I4ZopMtCnsgjsWkF7OfSXcVV6IWExLOGWl3/RhG9rP51m3V+vCjDoq+kbdcUi9TGStS7WfX/4YL5SuT4mDwMIx/TD60hzyUWsD7dzdJeLHwhrG6SdTGyJKgMefGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554615; c=relaxed/simple;
	bh=gqS9IWa9Wbj8AgzhCq2TPpUiS/FRPVtMKiHpSEMXQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oru/Xd5C98tV33oZ2DmRe18Mtwhj2VFEhBzYSbg1N3oM8xbOWuDk/mRAQKAdwnjDeuXMHFzfD+HFAphbP8XZYHyiNrUHlTR5YmZzzhz1X6Nf1YTMAnZjvEFYiW/Tp2n0yTb+wjb0m1QtniWmKiKwpdipk7gCndKADqPOxTepIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiFjdik5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A560EC32786;
	Thu,  1 Aug 2024 23:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722554615;
	bh=gqS9IWa9Wbj8AgzhCq2TPpUiS/FRPVtMKiHpSEMXQNE=;
	h=From:To:Cc:Subject:Date:From;
	b=NiFjdik5KrMHc+olQ4RVMbQ1mxklYoGoURYXuQcf/uXk4Bp7C1svr95LZDa7CS5XX
	 B/B2bu/BdoZPEiWToyQk9hg1Lbj1cy7CrywcZ9cAL9vD41VhD9LU+4Ys2wcamATo7A
	 T/c/a+GSvYpt4xJ2q866QOUrrkeHlGJFTlvxu0F0XkJnFA1Z4cHg90rvj9y3LkdcfU
	 8lldBSxcHVaEYSktM2trS/O+/h+ns7j9IYZYrtkNymBaoZAGcCiFTXJcKrtZogLhcP
	 uPyD+/hDIVxOAqoYrtIijSplY/J3w9A1xCYk2i21eNIqA1O4qDjuPieool1RmyBDWX
	 36SUG5pq7a2kw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com
Subject: [PATCH net-next v3] selftests: net: ksft: print more of the stack for checks
Date: Thu,  1 Aug 2024 16:23:17 -0700
Message-ID: <20240801232317.545577-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print more stack frames and the failing line when check fails.
This helps when tests use helpers to do the checks.

Before:

  # At ./ksft/drivers/net/hw/rss_ctx.py line 92:
  # Check failed 1037698 >= 396893.0 traffic on other queues:[344612, 462380, 233020, 449174, 342298]
  not ok 8 rss_ctx.test_rss_context_queue_reconfigure

After:

  # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
  # Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
  # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
  # Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
  # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
  # Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
  # Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
  not ok 8 rss_ctx.test_rss_context_queue_reconfigure

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - don't bitwise bools (Petr)
 - add a comment while at it
v2: https://lore.kernel.org/20240731013344.4102038-1-kuba@kernel.org
 - use Stan's iteration suggestion
v1: https://lore.kernel.org/20240729204536.3637577-1-kuba@kernel.org

CC: shuah@kernel.org
CC: petrm@nvidia.com
---
 tools/testing/selftests/net/lib/py/ksft.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..ed20508e1d71 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -32,8 +32,18 @@ KSFT_RESULT_ALL = True
     global KSFT_RESULT
     KSFT_RESULT = False
 
-    frame = inspect.stack()[2]
-    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
+    stack = inspect.stack()
+    started = False
+    for frame in reversed(stack[2:]):
+        # Start printing from the test case function
+        if not started:
+            if frame.function == 'ksft_run':
+                started = True
+            continue
+
+        ksft_pr("Check| At " + frame.filename + ", line " + str(frame.lineno) +
+                ", in " + frame.function + ":")
+        ksft_pr("Check|     " + frame.code_context[0].strip())
     ksft_pr(*args)
 
 
-- 
2.45.2


