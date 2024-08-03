Return-Path: <netdev+bounces-115479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522694676B
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A9E1F21C63
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B757013B2A8;
	Sat,  3 Aug 2024 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbDyV4KP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB313B298
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659219; cv=none; b=WICx2W9bMXuxkfh/u5tlS6oWJ+IIGMY/BxiAsbQrOA/F5Q8GdNBtePlM+pZMVNRpfi9UYQ+Vu9DKSFa7L7GcYY3VnS80X/ErHDCFLA2ASxm4y6ay7XLlNMSjy2cgV7X57WE849KlWdWb2912fB7lPcaV5KSuuiIvZwGBnAxKZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659219; c=relaxed/simple;
	bh=R+Vpo+Zoi94kDm1aFXbXMeQIVDFqrqjHP83Dk6AqSfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqQFgal5kTbDzNGTgxdwy6CRCmVb1EDu/cBSXFxh3pZQ4TQFQiB+dXKzC8JpVShVLezTJrV06izSlri7xmH9Q25y9dBGm4jAuuWt+T40JNH25eJiQrT2tCct8fsgRtuH8vG+h4eo52RptZrp5W0xPCP6TyqeR7lS1bGr5k6g1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbDyV4KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98053C4AF10;
	Sat,  3 Aug 2024 04:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659219;
	bh=R+Vpo+Zoi94kDm1aFXbXMeQIVDFqrqjHP83Dk6AqSfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbDyV4KP6GUUxhZuM2rX+I/q/7UV4VvBedOOxJfNsq5T0Bg9JqbmoPANGmAsAR35K
	 kqH62QM4aWYjpZTL4H+MMBi8izm68kYG1EgSbTDGVskdH8FHu3KtNM4GlMGDjZ4b2a
	 +B4ISERH7kX5XZvl6r5aqU04Wum7jIgWY+ByVHxaHWztI3jXlcjXQ/DbZbXYY0Q1O/
	 ZZ9oXQeTCqImJLE1RR8hSSzoNwWmoAiYpFt4UmYs7DVLgVs4oVunJEhGCmiRj7k2vh
	 w4QaPH5nimLxPq6pmeEsL6Thpa3vDG0022uQ6za++aC/z6jg0trIyrN16Md/w7lsXG
	 SaKWgEoyKU5Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 12/12] selftests: drv-net: rss_ctx: test dumping RSS contexts
Date: Fri,  2 Aug 2024 21:26:24 -0700
Message-ID: <20240803042624.970352-13-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 70 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  6 ++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 1da6b214f4fe..cbff3061abd7 100755
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
@@ -302,6 +302,72 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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
+    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])
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
+    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])
+    ksft_eq(expect_tuples, ctx_tuples)
+
+    # Skip ctx 0
+    expect_tuples.remove((cfg.ifname, -1))
+
+    ctxs = cfg.ethnl.rss_get({'start-context': 1}, dump=True)
+    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])
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
@@ -542,7 +608,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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
2.45.2


