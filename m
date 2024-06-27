Return-Path: <netdev+bounces-107430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6BF91AF5D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3702856D8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA27919ADB6;
	Thu, 27 Jun 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2JuM3Ud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF619ADA2
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514505; cv=none; b=MMXlWy8IRL3VZmGkNTRk3u2zp6rGN9E5W2eUYTZ759y2eddGO7UrutGif0S3B7W4cd6k6GvszTwjJB0NSJA1ci2DGc4PkzwXyXv+pSsbl0LsgGLjkVPsRx2RySEnUMG/5syvCftW7be8y184A1czPEYRviNfwxv8jrSUUTdnXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514505; c=relaxed/simple;
	bh=Jm93ft5jVK4K+M4nKGqPH/XpdIQhup2noPsX8PUrgMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqCXbzlcX/KUjvI999Pqxv0JPviIvXvQVQ5MJHkDtVEa3nCA9Yj+61DaBMGFrRHVeuVqJRI3T17wZybxgDhf/HprWw8tOrV6hb+1gqUQsUqEx32FyGZ+J2Gfs9vdogcBuE/ybL6kVgilXJJPBfECh51uNC1nTIEgZWLBaXr4Qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2JuM3Ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3ABC4AF0B;
	Thu, 27 Jun 2024 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719514505;
	bh=Jm93ft5jVK4K+M4nKGqPH/XpdIQhup2noPsX8PUrgMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2JuM3Ud8B9qNEpi0Htn95GDntmxQplnbnQbB0c5cgqNK6e9zsEaemCwTPpl6Q4cf
	 5eOdO4RWl/0vNJeXWH9rRwABs5Ewma7yEQDi9xa5a/dVL1c8t1vBv0EZPYmTxh3U7b
	 kjo9a1D7GYQIGIEcjrvvX238lcAX6YYbN4m1d1dx9a4e/KNBhDYBCx1REarHVqRq+G
	 nBmXeqT5G+EV+WJhohPxDXg3QZBPBELntGRZ1i4Al82IEbIqtPSdaORTOp4+k8ZJrp
	 7sxmlOxZoFG7O/U9XfLa+/DVp/DWP1hMHAoRzCoO8NBqdNlGzIiv1/tauk7u/6XCks
	 TChnKS1D09eFA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] selftests: drv-net: add ability to schedule cleanup with defer()
Date: Thu, 27 Jun 2024 11:55:01 -0700
Message-ID: <20240627185502.3069139-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627185502.3069139-1-kuba@kernel.org>
References: <20240627185502.3069139-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements what I was describing in [1]. When writing a test
author can schedule cleanup / undo actions right after the creation
completes, eg:

  cmd("touch /tmp/file")
  defer(cmd, "rm /tmp/file")

defer() takes the function name as first argument, and the rest are
arguments for that function. defer()red functions are called in
inverse order after test exits. It's also possible to capture them
and execute earlier (in which case they get automatically de-queued).

  undo = defer(cmd, "rm /tmp/file")
  # ... some unsafe code ...
  undo.exec()

As a nice safety all exceptions from defer()ed calls are captured,
printed, and ignored (they do make the test fail, however).
This addresses the common problem of exceptions in cleanup paths
often being unhandled, leading to potential leaks.

There is a global action queue, flushed by ksft_run(). We could support
function level defers too, I guess, but there's no immediate need..

Link: https://lore.kernel.org/all/877cedb2ki.fsf@nvidia.com/ # [1]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - split refactor to previous patch
 - user bare except instead of except Exception
 - rename _exec() -> exec_only() and use in flush
 - reorder queue removal vs calling callback
 - add print to indicate ID of failed callback
 - remove the state flags
---
 tools/testing/selftests/net/lib/py/ksft.py  | 21 +++++++++++++
 tools/testing/selftests/net/lib/py/utils.py | 34 +++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 789433262dc7..3aaa2748a58e 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -6,6 +6,7 @@ import sys
 import time
 import traceback
 from .consts import KSFT_MAIN_NAME
+from .utils import global_defer_queue
 
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
@@ -108,6 +109,24 @@ KSFT_RESULT_ALL = True
     print(res)
 
 
+def ksft_flush_defer():
+    global KSFT_RESULT
+
+    i = 0
+    qlen_start = len(global_defer_queue)
+    while global_defer_queue:
+        i += 1
+        entry = global_defer_queue.pop()
+        try:
+            entry.exec_only()
+        except:
+            ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
+            tb = traceback.format_exc()
+            for line in tb.strip().split('\n'):
+                ksft_pr("Defer Exception|", line)
+            KSFT_RESULT = False
+
+
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
     cases = cases or []
 
@@ -148,6 +167,8 @@ KSFT_RESULT_ALL = True
             KSFT_RESULT = False
             cnt_key = 'fail'
 
+        ksft_flush_defer()
+
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 405aa510aaf2..72590c3f90f1 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -66,6 +66,40 @@ import time
         return self.process(terminate=self.terminate, fail=self.check_fail)
 
 
+global_defer_queue = []
+
+
+class defer:
+    def __init__(self, func, *args, **kwargs):
+        global global_defer_queue
+
+        if not callable(func):
+            raise Exception("defer created with un-callable object, did you call the function instead of passing its name?")
+
+        self.func = func
+        self.args = args
+        self.kwargs = kwargs
+
+        self._queue =  global_defer_queue
+        self._queue.append(self)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        return self.exec()
+
+    def exec_only(self):
+        self.func(*self.args, **self.kwargs)
+
+    def cancel(self):
+        self._queue.remove(self)
+
+    def exec(self):
+        self.cancel()
+        self.exec_only()
+
+
 def tool(name, args, json=None, ns=None, host=None):
     cmd_str = name + ' '
     if json:
-- 
2.45.2


