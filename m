Return-Path: <netdev+bounces-117074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6294C8D2
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565A21C225E7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1838394;
	Fri,  9 Aug 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkarAWOH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEE33999
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173522; cv=none; b=SV1bjdYyNTB8ebCu9LIaZf71JoTm2oBoZUCIh4Y5ohn+yc3N3nYpfB1j82lgX9rLdsA6BDj3CD4yjh85FGrOMwHJeIGcjPLUPGXVMIaP7Ttoe3tFhJipP7awQCjTAwaUCqjkG6r139cFq2CfD0X6khNm7Y+7+4KD76JT+EVuqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173522; c=relaxed/simple;
	bh=Cr63pKk4pkX6lUs023whrYDKXYv3dwHcYT7lbXO34Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE2npC3JXnHW96cl3y91Pic+Ma92fN6FfJpAq0jm+sqNzlSEt6WO8w03qR9/NcCB3wWQmMh90LT3IrBHlt30WCtBeVpt541drsmeJcL3UekJe/m5tvejKmL2lCeCL2rcA9cURff0TDk39OeTesP9k3MAbwT09Pt9nXHVbG/tQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkarAWOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406CAC4AF11;
	Fri,  9 Aug 2024 03:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173522;
	bh=Cr63pKk4pkX6lUs023whrYDKXYv3dwHcYT7lbXO34Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkarAWOHr+TNYwF87nCkPzgoSUksvmU14I7yY4hE+eBdf+sJzH/8Jz+t33AFKpr1q
	 0OAfm0/13mAc+UDyToscKbaZkfWZApuuzj63Q5fxlBCtFCvmbGqL7wWkRx47Y8Q8UQ
	 rOUtndM3V2oNhnR5qnRRazYonjSD0GfIG0rZBsMZumJuD55FBOEH/Jy+x2OW+ACE7X
	 Rn952EYWFaKcIPcnkJQYw4Ki1Rqv8LQv1gMB1owsIsjD69PlLQM9fy2qmXphwtxSNT
	 J8YdT/mNJLemXSf0HC1gRZyCYA1L5TSVo5TvAvtCsBpLujtARAL5u6ZvSmz1GBhNec
	 x8I/4hHM5RECw==
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
Subject: [PATCH net-next v4 12/12] selftests: drv-net: rss_ctx: test dumping RSS contexts
Date: Thu,  8 Aug 2024 20:18:27 -0700
Message-ID: <20240809031827.2373341-13-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
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


