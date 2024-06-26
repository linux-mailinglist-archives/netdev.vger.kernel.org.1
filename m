Return-Path: <netdev+bounces-106733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B232E9175B1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40CC1C21BB2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07911BC44;
	Wed, 26 Jun 2024 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coDdlr4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89D18C0B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365781; cv=none; b=t+T7moxiVfMPCcRrGxp+XnH3KvYKLCie0jQqb6760ApncxR6h0pCH3VERJYjdL7YpcRO38Bq3C8+dPMdsIKJ3GdMec4D07gDgjMynPer0sgH2AOntquhZWmEgAuJuenxwCTzhgGX42fuPVww9BHAhq9SbcbeV39zDBKzkNjTIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365781; c=relaxed/simple;
	bh=Z6L93fsW2dGGCOC3vONfH6Gyh08hVAZHiKBF1eU8yOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0AwYAZAMpTrQuB5kOz/XR/KlI+Y5SuYxO7I850q5AQqhoHDnXSp5jwQngO0RXebg6AXbQbxM+vabw7OmdqrmfK+fxbwKNO8BvqgRpeWejeqXR3nwTTdG2NmqWvWjU6BSyc1Xxl8E+NWnYNWblz/yWK7Z1iYj0aZRJtplPSQgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coDdlr4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F327C32786;
	Wed, 26 Jun 2024 01:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365780;
	bh=Z6L93fsW2dGGCOC3vONfH6Gyh08hVAZHiKBF1eU8yOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coDdlr4q6loRbSqTaK66AQxaqxyi5S4x0SNOhgKkEaRyzq27ioAihZTfsv4RmCIb4
	 OH+59+mHf0kSxix1HkQ4xcsCyKFvLM64Ub/eNhNzBJi+yKogQsAw+4OHHiZ35UiXrW
	 or8T7ZUbLVPQxCxhpMUvAGx53UolwHp4RMZAMt/9JurypjsjvR+DYv7a+vTuykd/uo
	 aXnD6zyURsLxQkEM1IxeuCowdkqJ2J4ogdsOPTN8mmKEu3Aif2uFRNUaxUzM98ty/o
	 Zj9ZBw5ht9MTucKQdrDCd0UWcB0j26/FIUwJxFtEHwx9CSOhpJWo2eNOs99EKltncw
	 eSy765IhubN+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	przemyslaw.kitszel@intel.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 1/2] selftests: drv-net: add ability to schedule cleanup with defer()
Date: Tue, 25 Jun 2024 18:36:10 -0700
Message-ID: <20240626013611.2330979-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626013611.2330979-1-kuba@kernel.org>
References: <20240626013611.2330979-1-kuba@kernel.org>
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
 tools/testing/selftests/net/lib/py/ksft.py  | 49 +++++++++++++++------
 tools/testing/selftests/net/lib/py/utils.py | 41 +++++++++++++++++
 2 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 45ffe277d94a..4a72b9cbb27d 100644
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
+    while global_defer_queue:
+        entry = global_defer_queue[-1]
+        try:
+            entry.exec()
+        except Exception:
+            if global_defer_queue and global_defer_queue[-1] == entry:
+                global_defer_queue.pop()
+
+            ksft_pr("Exception while handling defer / cleanup!")
+            tb = traceback.format_exc()
+            for line in tb.strip().split('\n'):
+                ksft_pr("Defer Exception|", line)
+            KSFT_RESULT = False
+
+
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
     cases = cases or []
 
@@ -130,29 +149,31 @@ KSFT_RESULT_ALL = True
     for case in cases:
         KSFT_RESULT = True
         cnt += 1
+        comment = ""
+        cnt_key = ""
+
         try:
             case(*args)
         except KsftSkipEx as e:
-            ktap_result(True, cnt, case, comment="SKIP " + str(e))
-            totals['skip'] += 1
-            continue
+            comment = "SKIP " + str(e)
+            cnt_key = 'skip'
         except KsftXfailEx as e:
-            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
-            totals['xfail'] += 1
-            continue
+            comment = "XFAIL " + str(e)
+            cnt_key = 'xfail'
         except Exception as e:
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
-            ktap_result(False, cnt, case)
-            totals['fail'] += 1
-            continue
+            KSFT_RESULT = False
+            cnt_key = 'fail'
 
-        ktap_result(KSFT_RESULT, cnt, case)
-        if KSFT_RESULT:
-            totals['pass'] += 1
-        else:
-            totals['fail'] += 1
+        ksft_flush_defer()
+
+        if not cnt_key:
+            cnt_key = 'pass' if KSFT_RESULT else 'fail'
+
+        ktap_result(KSFT_RESULT, cnt, case, comment=comment)
+        totals[cnt_key] += 1
 
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 405aa510aaf2..1ef6ebaa369e 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -66,6 +66,47 @@ import time
         return self.process(terminate=self.terminate, fail=self.check_fail)
 
 
+global_defer_queue = []
+
+
+class defer:
+    def __init__(self, func, *args, **kwargs):
+        global global_defer_queue
+        if global_defer_queue is None:
+            raise Exception("defer environment has not been set up")
+
+        if not callable(func):
+            raise Exception("defer created with un-callable object, did you call the function instead of passing its name?")
+
+        self.func = func
+        self.args = args
+        self.kwargs = kwargs
+
+        self.queued = True
+        self.executed = False
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
+    def _exec(self):
+        self.func(*self.args, **self.kwargs)
+
+    def cancel(self):
+        self._queue.remove(self)
+        self.queued = False
+
+    def exec(self):
+        self._exec()
+        self.cancel()
+        self.executed = True
+
+
 def tool(name, args, json=None, ns=None, host=None):
     cmd_str = name + ' '
     if json:
-- 
2.45.2


