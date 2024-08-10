Return-Path: <netdev+bounces-117380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFC94DAF9
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7993B212F7
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068A13D633;
	Sat, 10 Aug 2024 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCzUrVFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050213D626
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268494; cv=none; b=uAvL1s3/Y8srZZkQtylY93peKLMnQBC6DHtBbGdka10LJtA6QJvqD7Z2d/BKEfkDjxnSA3C1tPVwPfPKjtqu3od+9YbmNrHiHFWq/XXFaPrzBPfQwDEC88l8ItVVJKFJL2fdeZtbRpqkl5TSPzhZvmeyyncg9/6i3PMm+AshDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268494; c=relaxed/simple;
	bh=Cr63pKk4pkX6lUs023whrYDKXYv3dwHcYT7lbXO34Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m33+FctLNyj47/joClsK89r2j8+86HbcgboSFe5A/+dMSAHGHMu6Uy1Yhj4FbreliSqI3NbvIiPKSUOBYHUcXnku318vJcmj/qJqrGNOOQjMd5B+BAmyN7b51eNDXZ9iK/Fi40owvlnaxEOSJrtnDvnnaR7vKv5cNomuo8bRSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCzUrVFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20044C4AF0E;
	Sat, 10 Aug 2024 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268493;
	bh=Cr63pKk4pkX6lUs023whrYDKXYv3dwHcYT7lbXO34Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCzUrVFNvFx3/6OajmeE9Of1JbqWmz8jGC+CoSawNiMqFRzO7yXE1p6EB21439JKW
	 sk/rT5nKMHN+yjeGs2qBiBAset3aJsENUYUHeOsR/8XojtFdKUWNojXYDZ+RJ0nxQ5
	 UM1LP0KQW3xUOsJG+yKpP/my50zrrQWGEKKv9JqCRi3ak3e1/iUGwWQUTyg05kVFOL
	 QTDQqgGoHKCm7WxRY3ugchuToONwAd1ZxEm6TeOrDBuOz6il8X62fxx8KReequw3zA
	 GvA0p/9rPhnVXEd+kYq/DS+3sT7bQl6PwRsDiqWaRABBnKMJgxBVNOs1toKIzISEoM
	 DRn591pFcwQxg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v5 12/12] selftests: drv-net: rss_ctx: test dumping RSS contexts
Date: Fri,  9 Aug 2024 22:37:28 -0700
Message-ID: <20240810053728.2757709-13-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for dumping RSS contexts. Make sure indir table
and key are sane when contexts are created with various
combination of inputs. Test the dump filtering by ifname
and start-context.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - filter results by ifindex
 - check for duplicates
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 76 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  6 ++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 1da6b214f4fe..9d7adb3cf33b 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -3,7 +3,7 @@
 
 import datetime
 import random
-from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ge, ksft_lt
+from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ne, ksft_ge, ksft_lt
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx
@@ -302,6 +302,78 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_eq(carrier1 - carrier0, 0)
 
 
+def test_rss_context_dump(cfg):
+    """
+    Test dumping RSS contexts. This tests mostly exercises the kernel APIs.
+    """
+
+    # Get a random key of the right size
+    data = get_rss(cfg)
+    if 'rss-hash-key' in data:
+        key_data = _rss_key_rand(len(data['rss-hash-key']))
+        key = _rss_key_str(key_data)
+    else:
+        key_data = []
+        key = "ba:ad"
+
+    ids = []
+    try:
+        ids.append(ethtool_create(cfg, "-X", f"context new"))
+        defer(ethtool, f"-X {cfg.ifname} context {ids[-1]} delete")
+
+        ids.append(ethtool_create(cfg, "-X", f"context new weight 1 1"))
+        defer(ethtool, f"-X {cfg.ifname} context {ids[-1]} delete")
+
+        ids.append(ethtool_create(cfg, "-X", f"context new hkey {key}"))
+        defer(ethtool, f"-X {cfg.ifname} context {ids[-1]} delete")
+    except CmdExitFailure:
+        if not ids:
+            raise KsftSkipEx("Unable to add any contexts")
+        ksft_pr(f"Added only {len(ids)} out of 3 contexts")
+
+    expect_tuples = set([(cfg.ifname, -1)] + [(cfg.ifname, ctx_id) for ctx_id in ids])
+
+    # Dump all
+    ctxs = cfg.ethnl.rss_get({}, dump=True)
+    tuples = [(c['header']['dev-name'], c.get('context', -1)) for c in ctxs]
+    ksft_eq(len(tuples), len(set(tuples)), "duplicates in context dump")
+    ctx_tuples = set([ctx for ctx in tuples if ctx[0] == cfg.ifname])
+    ksft_eq(expect_tuples, ctx_tuples)
+
+    # Sanity-check the results
+    for data in ctxs:
+        ksft_ne(set(data['indir']), {0}, "indir table is all zero")
+        ksft_ne(set(data.get('hkey', [1])), {0}, "key is all zero")
+
+        # More specific checks
+        if len(ids) > 1 and data.get('context') == ids[1]:
+            ksft_eq(set(data['indir']), {0, 1},
+                    "ctx1 - indir table mismatch")
+        if len(ids) > 2 and data.get('context') == ids[2]:
+            ksft_eq(data['hkey'], bytes(key_data), "ctx2 - key mismatch")
+
+    # Ifindex filter
+    ctxs = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}}, dump=True)
+    tuples = [(c['header']['dev-name'], c.get('context', -1)) for c in ctxs]
+    ctx_tuples = set(tuples)
+    ksft_eq(len(tuples), len(ctx_tuples), "duplicates in context dump")
+    ksft_eq(expect_tuples, ctx_tuples)
+
+    # Skip ctx 0
+    expect_tuples.remove((cfg.ifname, -1))
+
+    ctxs = cfg.ethnl.rss_get({'start-context': 1}, dump=True)
+    tuples = [(c['header']['dev-name'], c.get('context', -1)) for c in ctxs]
+    ksft_eq(len(tuples), len(set(tuples)), "duplicates in context dump")
+    ctx_tuples = set([ctx for ctx in tuples if ctx[0] == cfg.ifname])
+    ksft_eq(expect_tuples, ctx_tuples)
+
+    # And finally both with ifindex and skip main
+    ctxs = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}, 'start-context': 1}, dump=True)
+    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])
+    ksft_eq(expect_tuples, ctx_tuples)
+
+
 def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
     """
     Test separating traffic into RSS contexts.
@@ -542,7 +614,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         ksft_run([test_rss_key_indir, test_rss_queue_reconfigure,
                   test_rss_resize, test_hitless_key_update,
                   test_rss_context, test_rss_context4, test_rss_context32,
-                  test_rss_context_queue_reconfigure,
+                  test_rss_context_dump, test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg],
                  args=(cfg, ))
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f663e0daec0d..477ae76de93d 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -55,6 +55,12 @@ KSFT_DISRUPTIVE = True
         _fail("Check failed", a, "!=", b, comment)
 
 
+def ksft_ne(a, b, comment=""):
+    global KSFT_RESULT
+    if a == b:
+        _fail("Check failed", a, "==", b, comment)
+
+
 def ksft_true(a, comment=""):
     if not a:
         _fail("Check failed", a, "does not eval to True", comment)
-- 
2.46.0


