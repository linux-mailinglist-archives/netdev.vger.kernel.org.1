Return-Path: <netdev+bounces-114351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F0494242A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5E1F2417F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AE1AA3C3;
	Wed, 31 Jul 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZXbd5VQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE2564
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389629; cv=none; b=H4j4RmnUzyvXQn6B+N73MSdXMatIjrofz0HCjQRIF7znx5kiOJURK3FUUWR0N/puixPvvxGAEmiNu/vePw9JCG8T1Jr+jrUxDCVURdL0Qim+v8u5KhbTtBNgg28o9LD7lS+chHjEu5qZ5j94dnLcQ/Oo6p0LztktmTaSwoue3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389629; c=relaxed/simple;
	bh=JvfPZ3zLIy50XvcqbDjF04Q6eEle/IeVTD/WQphvUAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcA0So0xK34RiiOMQorhyWqoneibmUWvfvlOzVZN3Z7mIfmcvWaTR9vtZAlRPCFz8+dnEeXu5NrirlKv77hooy1ongnYAaJ0Ai3AMKlatWiFRAtYldFIawNPtsNbTSMRNFtX68nQtOHH9I/G/dHyGjv6Sph/1zC+iOx6BhZ+AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZXbd5VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBFC32782;
	Wed, 31 Jul 2024 01:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722389629;
	bh=JvfPZ3zLIy50XvcqbDjF04Q6eEle/IeVTD/WQphvUAI=;
	h=From:To:Cc:Subject:Date:From;
	b=lZXbd5VQ2AZnjX78zmUoqVt668ruug8jLQQk3IC1tgHi6S8cTg7KSC1WfJ3fZoIL5
	 +7EspTf4pXvaGC+fKo1mh0NxeHW/GdtNxNay4eySmZgok5LOhi0ltl6Un9LmRSzj4E
	 kG92+RdetORUkPOUIA405Tqy3PFNKbJZ/O2Y+gIf/iVNUVvlPUd2uFd53giXW3tL6Z
	 HqSMPWkYoBjCZVTzy4bFn3kdDVnNFaXD9nG5do7kU5vdGY5CbekHXiNW/Kylhno2mW
	 VSHA8OjVB2zkJgIPQPuN2wU/jwJCvSx/IAZb/N0LlrqaMtNsqE7Dutmueo1cEaLA/N
	 3og4dhtvUX3vg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com
Subject: [PATCH net-next v2] selftests: net: ksft: print more of the stack for checks
Date: Tue, 30 Jul 2024 18:33:43 -0700
Message-ID: <20240731013344.4102038-1-kuba@kernel.org>
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
v2:
 - use Stan's iteration suggestion
v1: https://lore.kernel.org/all/20240729204536.3637577-1-kuba@kernel.org/

CC: shuah@kernel.org
CC: petrm@nvidia.com
---
 tools/testing/selftests/net/lib/py/ksft.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..707e0dfc7b9d 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -32,8 +32,15 @@ KSFT_RESULT_ALL = True
     global KSFT_RESULT
     KSFT_RESULT = False
 
-    frame = inspect.stack()[2]
-    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
+    stack = inspect.stack()
+    started = False
+    for frame in reversed(stack[2:]):
+        if not started:
+            started |= frame.function == 'ksft_run'
+            continue
+        ksft_pr("Check| At " + frame.filename + ", line " + str(frame.lineno) +
+                ", in " + frame.function + ":")
+        ksft_pr("Check|     " + frame.code_context[0].strip())
     ksft_pr(*args)
 
 
-- 
2.45.2


