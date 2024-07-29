Return-Path: <netdev+bounces-113795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E0693FFBF
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939F72827BB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F018A924;
	Mon, 29 Jul 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipZQSDyi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2D1891DE
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285939; cv=none; b=eoX5AUq2yetSwTiIGsk5/EXTr3m5vST/kSSRV27FS8q7LRX4en4B8KswCFWLvF4faY+Iv6FcYqpph0411y6QFOz7EYpuoBxves+27Bdq0uNYezW3JL2CZfcYHX/KmdDxU1CLJD1OJMxJo8XeRyDu0UAbDtWE9+zRh+AxgeprakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285939; c=relaxed/simple;
	bh=s6pThrCZE3l3Le8tOo1JRPMJKmmXP1Dm4mjwxmcPwY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rS/xY92rVXpu2bXFr+6qQFlBtbTDoezqqB+PepQgmqt2MhvK+BElkzr45ifmHKcwAowJIBEKbmNOCJiARTWBF7W+vA4nzvatcp1XpUFiYF54ElKva3r7AnxpFCK+6ZfWdrbBSkkOkrWVPweVZ/9HotjH5D7DsWQYSmN0ebjoBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipZQSDyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E526C32786;
	Mon, 29 Jul 2024 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722285938;
	bh=s6pThrCZE3l3Le8tOo1JRPMJKmmXP1Dm4mjwxmcPwY0=;
	h=From:To:Cc:Subject:Date:From;
	b=ipZQSDyisTBi9I2AJkbXkN3kh0lgh6Te5niFPfljwqNuT4752XBz7MC8F7aye7W5l
	 eE34jRr4saWiZRcQl16pm350i0ePAzH+4qFnBGoD24qzlOxv8887P5JfiQFlkqiayE
	 Iw97aNoH05MbtkEDirGbUkebHC/C1A6KKXd38Y5Lc7hKOZ+aSZA6WIXE+7Eb/l8GIl
	 NZ/kUFQIjFtC/CttDscrbIPMtXgCMdTVUPSfnKE3b8M2AmKTMLt0ycoS4UZ9e7CJp/
	 TMmg0C+Slto6ejOo0YDWCvpIPIdDdNzIPXaKzALCoMjRStMezI6FCaiRrhcYt+7Gsf
	 jSUT64m7KRHZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com
Subject: [PATCH net-next] selftests: net: ksft: print more of the stack for checks
Date: Mon, 29 Jul 2024 13:45:36 -0700
Message-ID: <20240729204536.3637577-1-kuba@kernel.org>
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
CC: shuah@kernel.org
CC: petrm@nvidia.com
---
 tools/testing/selftests/net/lib/py/ksft.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..c2356e07c34c 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -32,8 +32,16 @@ KSFT_RESULT_ALL = True
     global KSFT_RESULT
     KSFT_RESULT = False
 
-    frame = inspect.stack()[2]
-    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
+    stack = inspect.stack()
+    started = False
+    for i in reversed(range(2, len(stack))):
+        frame = stack[i]
+        if not started:
+            started |= frame.function == 'ksft_run'
+            continue
+        ksft_pr("Check| At " + frame.filename + ", line " + str(frame.lineno) +
+                ", in " + frame.function + ":")
+        ksft_pr("Check|     " + frame.code_context[0].strip())
     ksft_pr(*args)
 
 
-- 
2.45.2


