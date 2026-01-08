Return-Path: <netdev+bounces-248283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04730D067A8
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5593020CD1
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CA32E72F;
	Thu,  8 Jan 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRtGaj2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B772EFDBB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912787; cv=none; b=TGZsa+i7SammUWeN1CsIVE84yaSTC5KmF6MvYwF3AJ/aRVF6EpH0JqjvbT1HipGv8YqF+WBMVv8KwhPyObsHfthfTzCUzb9DH7xQD3I1Ow2ApKb/LWRHQrzq90J/Ng6vPU6m4AGbLCQ19YqzV62b7fxnXU7n5HAzZ+v8Jc4KVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912787; c=relaxed/simple;
	bh=KF543tFyVyQFbMPteudHIIpoUkvcrR9NX3QHcJt4WgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXrTvHNFplfxRh4LSJU9t6eh8qEcA7Q+YcUqvI9zS3/HZEyWfYO1lwFgExxSZTPAi7aFadRkXTYukUx//jmaG5byDXRDAG1DqxZlikyjUyWYyIqfGE0XWBNsmLO89HkkKNNEecAps6gxbfdx7TkgQFuIl4Jcntul8l/I6pdHmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRtGaj2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21DC116C6;
	Thu,  8 Jan 2026 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912786;
	bh=KF543tFyVyQFbMPteudHIIpoUkvcrR9NX3QHcJt4WgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tRtGaj2L49ZL1cq/QkpOGGF3XFy3vLNHPxhUJuLJ1hcF3Mv/qkj0h05OYEZvuzDiD
	 dPj5zZpI4hkXFFCA6X7Rfpd6b3Jql4qx/kNatTUW4j7oZLym3TR9Jue6pShdKS3sPF
	 cyJg3bSORg32fL9Tmh5Mx1oz6whEvqwCjtWnWw8hDqmDFTDacZkZDqOdFLkrqfk8xm
	 exSEH0rC2jODXuZLoS2rO9BknMP8OeBQhFmIx6vEIjLMCqpLXld+UsC02KY2F/IgIZ
	 i1Iegh8NEftT7WItqzOWdRAkYoQ6t1l+3hmCR+U3gSpcTAkjeLDdBbMlUqAETVd0HD
	 k4us72KQw4RIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	leitao@debian.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: net: py: capitalize defer queue and improve import
Date: Thu,  8 Jan 2026 14:52:56 -0800
Message-ID: <20260108225257.2684238-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Import utils and refer to the global defer queue that way instead
of importing the queue. This will make it possible to assign value
to the global variable. While at it capitalize the name, to comply
with the Python coding style.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py  | 8 ++++----
 tools/testing/selftests/net/lib/py/utils.py | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 531e7fa1b3ea..248cd1a723a3 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -8,7 +8,7 @@ import time
 import traceback
 from collections import namedtuple
 from .consts import KSFT_MAIN_NAME
-from .utils import global_defer_queue
+from . import utils
 
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
@@ -157,10 +157,10 @@ KSFT_DISRUPTIVE = True
     global KSFT_RESULT
 
     i = 0
-    qlen_start = len(global_defer_queue)
-    while global_defer_queue:
+    qlen_start = len(utils.GLOBAL_DEFER_QUEUE)
+    while utils.GLOBAL_DEFER_QUEUE:
         i += 1
-        entry = global_defer_queue.pop()
+        entry = utils.GLOBAL_DEFER_QUEUE.pop()
         try:
             entry.exec_only()
         except Exception:
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 106ee1f2df86..2dde34560d65 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -141,7 +141,7 @@ import time
         return self.process(terminate=terminate, fail=self.check_fail)
 
 
-global_defer_queue = []
+GLOBAL_DEFER_QUEUE = []
 
 
 class defer:
@@ -153,7 +153,7 @@ global_defer_queue = []
         self.args = args
         self.kwargs = kwargs
 
-        self._queue =  global_defer_queue
+        self._queue = GLOBAL_DEFER_QUEUE
         self._queue.append(self)
 
     def __enter__(self):
-- 
2.52.0


