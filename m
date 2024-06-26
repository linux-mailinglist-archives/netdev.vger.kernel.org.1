Return-Path: <netdev+bounces-106732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C59175AF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403421F21C5C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B93175BE;
	Wed, 26 Jun 2024 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShSm7AMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574C11CAB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365780; cv=none; b=EfAtiGu3B82a2gdh6KfRKqX7RIXcDFmfwNIsRWhcC1z8wnD0MilNQJiwEgGc7GNkUEi5Fa3IqFM5t7uxaXsC6oat6cKnEKneXDKR7K39MSbLZdUrYNensB/XHp6RTO8Zxlzt0nVzs40Ylgir88wDIa+k5eF0VUfLP4kNgWDz+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365780; c=relaxed/simple;
	bh=g4MHVTRfL4kEKCKjyJ0E1c6YV6rrwNGfKCclkilHL1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSn3jxWRRYGFfRaWkmRYUKum1s4kXLAZTbja1v1XTGXlDZQO//KfDsi+VUFYkkkwpSdkbROHvTUyf0OfMQSdPPJGHmFnvC7rThnYLJB12lJRjycpQHNHjrAI5rAL5uVBjdPx5khjVnYeYCUfKTIhqILD8ltD/wZg4IEXy3I/TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShSm7AMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418D3C4AF0A;
	Wed, 26 Jun 2024 01:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365780;
	bh=g4MHVTRfL4kEKCKjyJ0E1c6YV6rrwNGfKCclkilHL1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShSm7AMKZ8rTfAndKZDAgjz+CotJVHFPraYAXJfvG+C+L+83A9ywMAcYijXcJfqM3
	 9DCkyn27ltqdcnGBaP7NAnhFQEdZ6DRenbTuYZvM8skh0mO8N1LMstor842+HkR5c6
	 yIM44b62pkLr1TGx0KDW0eBvOlEGg6ndT4T05GVx4TA43hmWw5LH7FLXFKoOZdyIWB
	 9hXZ8RezZpkkPJjLAKncKxxbS0YU8c2BueQhOS3PkhgzRjXlSnrdqy7dORb5kLW0up
	 r7bQW75yFwlfq6s6DYCpm5S0KOGL/Sa7ku7nawvx8w9eBKvuvbrpkkYMXXjhXsIfcz
	 IOpsG6P+yRWRw==
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
Subject: [RFC net-next 2/2] selftests: drv-net: rss_ctx: convert to defer()
Date: Tue, 25 Jun 2024 18:36:11 -0700
Message-ID: <20240626013611.2330979-3-kuba@kernel.org>
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

Use just added defer().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 225 ++++++++----------
 1 file changed, 97 insertions(+), 128 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 68c7d40214eb..6f55a3b49698 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -8,7 +8,7 @@ from lib.py import NetDrvEpEnv
 from lib.py import NetdevFamily
 from lib.py import KsftSkipEx
 from lib.py import rand_port
-from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
+from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
 
 def _rss_key_str(key):
@@ -127,64 +127,56 @@ from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
 
     # Try to allocate more queues when necessary
     qcnt = len(_get_rx_cnts(cfg))
-    if qcnt >= 2 + 2 * ctx_cnt:
-        qcnt = None
-    else:
+    if qcnt < 2 + 2 * ctx_cnt:
         try:
             ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
             ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
+            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
         except:
             raise KsftSkipEx("Not enough queues for the test")
 
-    ntuple = []
-    ctx_id = []
     ports = []
-    try:
-        # Use queues 0 and 1 for normal traffic
-        ethtool(f"-X {cfg.ifname} equal 2")
 
-        for i in range(ctx_cnt):
-            want_cfg = f"start {2 + i * 2} equal 2"
-            create_cfg = want_cfg if create_with_cfg else ""
+    # Use queues 0 and 1 for normal traffic
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
-            try:
-                ctx_id.append(ethtool_create(cfg, "-X", f"context new {create_cfg}"))
-            except CmdExitFailure:
-                # try to carry on and skip at the end
-                if i == 0:
-                    raise
-                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
-                ctx_cnt = i
-                break
+    for i in range(ctx_cnt):
+        want_cfg = f"start {2 + i * 2} equal 2"
+        create_cfg = want_cfg if create_with_cfg else ""
 
-            if not create_with_cfg:
-                ethtool(f"-X {cfg.ifname} context {ctx_id[i]} {want_cfg}")
+        try:
+            ctx_id = ethtool_create(cfg, "-X", f"context new {create_cfg}")
+            defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+        except CmdExitFailure:
+            # try to carry on and skip at the end
+            if i == 0:
+                raise
+            ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
+            ctx_cnt = i
+            break
 
-            # Sanity check the context we just created
-            data = get_rss(cfg, ctx_id[i])
-            ksft_eq(min(data['rss-indirection-table']), 2 + i * 2, "Unexpected context cfg: " + str(data))
-            ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
+        if not create_with_cfg:
+            ethtool(f"-X {cfg.ifname} context {ctx_id} {want_cfg}")
 
-            ports.append(rand_port())
-            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
-            ntuple.append(ethtool_create(cfg, "-N", flow))
+        # Sanity check the context we just created
+        data = get_rss(cfg, ctx_id)
+        ksft_eq(min(data['rss-indirection-table']), 2 + i * 2, "Unexpected context cfg: " + str(data))
+        ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
 
-        for i in range(ctx_cnt):
-            cnts = _get_rx_cnts(cfg)
-            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
-            cnts = _get_rx_cnts(cfg, prev=cnts)
+        ports.append(rand_port())
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
+        ntuple = ethtool_create(cfg, "-N", flow)
+        defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
-            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
-            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
-            ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
-    finally:
-        for nid in ntuple:
-            ethtool(f"-N {cfg.ifname} delete {nid}")
-        for cid in ctx_id:
-            ethtool(f"-X {cfg.ifname} context {cid} delete")
-        ethtool(f"-X {cfg.ifname} default")
-        if qcnt:
-            ethtool(f"-L {cfg.ifname} combined {qcnt}")
+    for i in range(ctx_cnt):
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+
+        ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
+        ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
+        ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
 
     if requested_ctx_cnt != ctx_cnt:
         raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
@@ -216,24 +208,21 @@ from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
 
     # Try to allocate more queues when necessary
     qcnt = len(_get_rx_cnts(cfg))
-    if qcnt >= 2 + 2 * ctx_cnt:
-        qcnt = None
-    else:
+    if qcnt < 2 + 2 * ctx_cnt:
         try:
             ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
             ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
+            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
         except:
             raise KsftSkipEx("Not enough queues for the test")
 
     ntuple = []
-    ctx_id = []
+    ctx = []
     ports = []
 
     def remove_ctx(idx):
-        ethtool(f"-N {cfg.ifname} delete {ntuple[idx]}")
-        ntuple[idx] = None
-        ethtool(f"-X {cfg.ifname} context {ctx_id[idx]} delete")
-        ctx_id[idx] = None
+        ntuple[idx].exec()
+        ctx[idx].exec()
 
     def check_traffic():
         for i in range(ctx_cnt):
@@ -241,7 +230,7 @@ from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
             GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
             cnts = _get_rx_cnts(cfg, prev=cnts)
 
-            if ctx_id[i] is None:
+            if ctx[i].queued:
                 ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
                 ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
                 ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
@@ -249,41 +238,32 @@ from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
                 ksft_ge(sum(cnts[ :2]), 20000, "traffic on main context:" + str(cnts))
                 ksft_eq(sum(cnts[2: ]),     0, "traffic on other contexts: " + str(cnts))
 
-    try:
-        # Use queues 0 and 1 for normal traffic
-        ethtool(f"-X {cfg.ifname} equal 2")
+    # Use queues 0 and 1 for normal traffic
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
-        for i in range(ctx_cnt):
-            ctx_id.append(ethtool_create(cfg, "-X", f"context new start {2 + i * 2} equal 2"))
+    for i in range(ctx_cnt):
+        ctx_id = ethtool_create(cfg, "-X", f"context new start {2 + i * 2} equal 2")
+        ctx.append(defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete"))
 
-            ports.append(rand_port())
-            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
-            ntuple.append(ethtool_create(cfg, "-N", flow))
+        ports.append(rand_port())
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
+        ntuple_id = ethtool_create(cfg, "-N", flow)
+        ntuple.append(defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}"))
 
-        check_traffic()
+    check_traffic()
 
-        # Remove middle context
-        remove_ctx(ctx_cnt // 2)
-        check_traffic()
+    # Remove middle context
+    remove_ctx(ctx_cnt // 2)
+    check_traffic()
 
-        # Remove first context
-        remove_ctx(0)
-        check_traffic()
+    # Remove first context
+    remove_ctx(0)
+    check_traffic()
 
-        # Remove last context
-        remove_ctx(-1)
-        check_traffic()
-
-    finally:
-        for nid in ntuple:
-            if nid is not None:
-                ethtool(f"-N {cfg.ifname} delete {nid}")
-        for cid in ctx_id:
-            if cid is not None:
-                ethtool(f"-X {cfg.ifname} context {cid} delete")
-        ethtool(f"-X {cfg.ifname} default")
-        if qcnt:
-            ethtool(f"-L {cfg.ifname} combined {qcnt}")
+    # Remove last context
+    remove_ctx(-1)
+    check_traffic()
 
     if requested_ctx_cnt != ctx_cnt:
         raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
@@ -298,69 +278,58 @@ from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
     require_ntuple(cfg)
 
     queue_cnt = len(_get_rx_cnts(cfg))
-    if queue_cnt >= 4:
-        queue_cnt = None
-    else:
+    if queue_cnt < 4:
         try:
             ksft_pr(f"Increasing queue count {queue_cnt} -> 4")
             ethtool(f"-L {cfg.ifname} combined 4")
+            defer(ethtool, f"-L {cfg.ifname} combined {queue_cnt}")
         except:
             raise KsftSkipEx("Not enough queues for the test")
 
-    ctx_id = None
-    ntuple = None
     if other_ctx == 0:
         ethtool(f"-X {cfg.ifname} equal 4")
+        defer(ethtool, f"-X {cfg.ifname} default")
     else:
         other_ctx = ethtool_create(cfg, "-X", "context new")
         ethtool(f"-X {cfg.ifname} context {other_ctx} equal 4")
+        defer(ethtool, f"-X {cfg.ifname} context {other_ctx} delete")
 
-    try:
-        ctx_id = ethtool_create(cfg, "-X", "context new")
-        ethtool(f"-X {cfg.ifname} context {ctx_id} start 2 equal 2")
+    ctx_id = ethtool_create(cfg, "-X", "context new")
+    ethtool(f"-X {cfg.ifname} context {ctx_id} start 2 equal 2")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
 
-        port = rand_port()
-        if other_ctx:
-            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
-            ntuple = ethtool_create(cfg, "-N", flow)
+    port = rand_port()
+    if other_ctx:
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
+        ntuple_id = ethtool_create(cfg, "-N", flow)
+        ntuple = defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 
-        # Test the main context
-        cnts = _get_rx_cnts(cfg)
-        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
-        cnts = _get_rx_cnts(cfg, prev=cnts)
+    # Test the main context
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
 
-        ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
-        ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
-        ksft_ge(sum(cnts[2:4]),  7000, "traffic on main context (2/2): " + str(cnts))
-        if other_ctx == 0:
-            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
+    ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
+    ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
+    ksft_ge(sum(cnts[2:4]),  7000, "traffic on main context (2/2): " + str(cnts))
+    if other_ctx == 0:
+        ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
 
-        # Now create a rule for context 1 and make sure traffic goes to a subset
-        if other_ctx:
-            ethtool(f"-N {cfg.ifname} delete {ntuple}")
-            ntuple = None
-        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
-        ntuple = ethtool_create(cfg, "-N", flow)
+    # Now create a rule for context 1 and make sure traffic goes to a subset
+    if other_ctx:
+        ntuple.exec()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+    ntuple_id = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 
-        cnts = _get_rx_cnts(cfg)
-        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
-        cnts = _get_rx_cnts(cfg, prev=cnts)
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
 
-        ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
-        ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
-        if other_ctx == 0:
-            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
-    finally:
-        if ntuple is not None:
-            ethtool(f"-N {cfg.ifname} delete {ntuple}")
-        if ctx_id:
-            ethtool(f"-X {cfg.ifname} context {ctx_id} delete")
-        if other_ctx == 0:
-            ethtool(f"-X {cfg.ifname} default")
-        else:
-            ethtool(f"-X {cfg.ifname} context {other_ctx} delete")
-        if queue_cnt:
-            ethtool(f"-L {cfg.ifname} combined {queue_cnt}")
+    ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
+    ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
+    if other_ctx == 0:
+        ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
 
 
 def test_rss_context_overlap2(cfg):
-- 
2.45.2


