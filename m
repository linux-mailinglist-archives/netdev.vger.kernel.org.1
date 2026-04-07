Return-Path: <netdev+bounces-276040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCkBIBUh1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C293B0DDD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F41230BE7AF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED036402C;
	Tue,  7 Apr 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgTOJOjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F52363C7E;
	Tue,  7 Apr 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575037; cv=none; b=MTZmhMOMJknkCl5StHG8KW2Wre622XVtWegvOMMIt9L3JYdObV0wNj7fiXnpkRTsnKAQIHL1sGBsAJiSDIEa9FeJElgEtSDtM7mN2uGA0q+fALijMIV0uYvJjP7qxss8oE9+sVRM3pQbpqOn7wWWJxyGM0sAISgTVeDi+Jy3Ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575037; c=relaxed/simple;
	bh=TzZy2QRNVKVyji7zJM1j5GT5yE90CNpk1xMdl92uhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIlC9qQ9DMl1mg5UGRZNttyyZm9hopp0oGEAtX3npBHGF19zBGONfLrCw6c3suvb0dQ9iQsnBDJTR8qRGHJA77ZMdBMqckadk4X4YMgHbOeI3DdphayocOyzVzff5yb4qeaL5xGzzjxjgbgdPPnCVrF/Lgjbp+Wb3OiaIqVCzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgTOJOjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658DFC19424;
	Tue,  7 Apr 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775575036;
	bh=TzZy2QRNVKVyji7zJM1j5GT5yE90CNpk1xMdl92uhTk=;
	h=From:To:Cc:Subject:Date:From;
	b=YgTOJOjbtfZsqyJGWPPN4muFLhEbq6DlZ+vR61VoyGyO3260gpe9Rsa7fLfhbdlHw
	 XQ2DV1ZyoyR5ZOPlB3uoT0ZbuwouyoipOuvmW0KUIZ4+xrH3a6jxAILP7vJ/w/r0Oz
	 9fYo3yIeyaW8QU+rju5XxcYdUtKRRmOvJx2ujPxoYq6MzRMT45proi6ACw2/j3bKCx
	 knYVxc4CZ9MXjIo3xfxYo8fsyKDvMBQmV5a/CX0wqYOBTrrL8jBovu3neOEdRBhxCB
	 uzJCkRIcKsD7U6TVHa0JX183vw7PCJVzMngEMOFEpwCn3pFKSbmVicFhpJ2gYSWi0d
	 EHxq2pFkOQt/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: py: add test case filtering and listing
Date: Tue,  7 Apr 2026 08:17:15 -0700
Message-ID: <20260407151715.3800579-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276040-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 05C293B0DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When developing new test cases and reproducing failures in
existing ones we currently have to run the entire test which
can take minutes to finish.

Add command line options for test selection, modeled after
kselftest_harness.h:

  -l       list tests (all or filtered)
  -t name  include test
  -T name  exclude test

Since we don't have as clean separation into fixture / variant /
test as kselftest_harness this is not really a 1 to 1 match.
We have to lean on glob patterns instead.

Like in kselftest_harness filters are evaluated in order, first
match wins. If only exclusions are specified everything else is
included and vice versa.

Glob patterns (*, ?, [) are supported in addition to exact
matching.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Building on the support for colored output.. :)

CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 65 +++++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 7b8af463e35d..abde32874c17 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import fnmatch
 import functools
+import getopt
 import inspect
 import os
 import signal
@@ -32,6 +34,34 @@ KSFT_DISRUPTIVE = True
     pass
 
 
+class _KsftArgs:
+    def __init__(self):
+        self.list_tests = False
+        self.filters = []
+
+        try:
+            opts, _ = getopt.getopt(sys.argv[1:], 'hlt:T:')
+        except getopt.GetoptError as e:
+            print(e, file=sys.stderr)
+            sys.exit(1)
+
+        for opt, val in opts:
+            if opt == '-h':
+                print(f"Usage: {sys.argv[0]} [-h|-l] [-t|-T name]\n"
+                      f"\t-h       print help\n"
+                      f"\t-l       list all tests\n"
+                      f"\t-t name  include test\n"
+                      f"\t-T name  exclude test",
+                      file=sys.stderr)
+                sys.exit(0)
+            elif opt == '-l':
+                self.list_tests = True
+            elif opt == '-t':
+                self.filters.append((True, val))
+            elif opt == '-T':
+                self.filters.append((False, val))
+
+
 @functools.lru_cache()
 def _ksft_supports_color():
     if os.environ.get("NO_COLOR") is not None:
@@ -298,8 +328,26 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
 
 
-def _ksft_generate_test_cases(cases, globs, case_pfx, args):
-    """Generate a flat list of (func, args, name) tuples"""
+def _ksft_name_matches(name, pattern):
+    if '*' in pattern or '?' in pattern or '[' in pattern:
+        return fnmatch.fnmatchcase(name, pattern)
+    return name == pattern
+
+
+def _ksft_test_enabled(name, filters):
+    has_positive = False
+    for include, pattern in filters:
+        has_positive |= include
+        if _ksft_name_matches(name, pattern):
+            return include
+    return not has_positive
+
+
+def _ksft_generate_test_cases(cases, globs, case_pfx, args, cli_args):
+    """Generate a filtered list of (func, args, name) tuples.
+
+    If -l is given, prints matching test names and exits.
+    """
 
     cases = cases or []
     test_cases = []
@@ -329,11 +377,22 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         else:
             test_cases.append((func, args, func.__name__))
 
+    if cli_args.filters:
+        test_cases = [tc for tc in test_cases
+                      if _ksft_test_enabled(tc[2], cli_args.filters)]
+
+    if cli_args.list_tests:
+        for _, _, name in test_cases:
+            print(name)
+        sys.exit(0)
+
     return test_cases
 
 
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
-    test_cases = _ksft_generate_test_cases(cases, globs, case_pfx, args)
+    cli_args = _KsftArgs()
+    test_cases = _ksft_generate_test_cases(cases, globs, case_pfx, args,
+                                           cli_args)
 
     global term_cnt
     term_cnt = 0
-- 
2.53.0


