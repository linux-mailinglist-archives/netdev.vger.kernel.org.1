Return-Path: <netdev+bounces-105488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9E59116BA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E260E1F2286F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7BA14F10E;
	Thu, 20 Jun 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFpic0tA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02714E2FB
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926155; cv=none; b=BrdxI19MIDZQ+1rFChUCxN00NfHmTgSDukH5z1yT5Zf2Ar0m0PTlIn9RI/L1bZE5EDwk0H/2Zb5jkHW+2QZ1cQ+O9kAY3Jp4kQWHMR3jAxX10s0vmDF/LY/EkRIB0cc+1KVs2qvSbXrE0s1VcNa0kPoE9P0u+Da/xC8LTEdonJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926155; c=relaxed/simple;
	bh=Qz+ECKR6tQQLmspO9tbFySS3E9KJ8NO3q8P9l0ZpPOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWTTYwIbaJ+Oi+w66unS2/t+FhhWvu4j9W3cpoltI0ZdNqR3npMcDezzid9+Gzh5e+pItSo1N14Psbil48u7GltS9Y5Y/gdw8akINpqH1hBWX8aQ0z/GPkMgDTIV9/nHZuSoF1/0QD/8n5MUInSM1mgvyjVtFQBxIe/awVcqRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFpic0tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721C6C2BD10;
	Thu, 20 Jun 2024 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926154;
	bh=Qz+ECKR6tQQLmspO9tbFySS3E9KJ8NO3q8P9l0ZpPOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFpic0tAYvl/ikePaCfIwJ3NnXVO0i0f/ZX7DYKvPBMBxw1D7RorSryuwIXdzwSy7
	 R50M72lx27Jx/sFFjnLUrmMszkMB5tRUgBPyqIlfvlbp1vsWiRjL+JS243+VrgfCI/
	 TEw/nH7VvPoqIJGyy9AptiLropdpblvubgu1WCuI7X1np0LWwL9rY2r3c82tSeFPc9
	 5mzbwC8zQdYRdyE3u9FNSw3xNfwLaTUlEOsqfPrRPaJloKMnfzQ7dlItCoveFPFUkL
	 OgFca838yTH5X8xzZYNp6dFm+irhLZiDINV9SpS7ycppyU6OvFhU/scpOKGZJLZ+Lk
	 eG2JlbEoTIVqA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for RSS configuration and contexts
Date: Thu, 20 Jun 2024 16:29:01 -0700
Message-ID: <20240620232902.1343834-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620232902.1343834-1-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests focusing on indirection table configuration and
creating extra RSS contexts in drivers which support it.

  $ ./drivers/net/hw/rss_ctx.py
  KTAP version 1
  1..6
  ok 1 rss_ctx.test_rss_key_indir
  ok 2 rss_ctx.test_rss_context
  ok 3 rss_ctx.test_rss_context4
  # Increasing queue count 44 -> 66
  # Failed to create context 32, trying to test what we got
  ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
  ok 5 rss_ctx.test_rss_context_overlap
  ok 6 rss_ctx.test_rss_context_overlap2
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rss_ctx.py       | 243 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |   7 +-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 tools/testing/selftests/net/lib/py/utils.py   |   8 +-
 5 files changed, 259 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 4933d045ab66..c9f2f48fc30f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS = \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
 	pp_alloc_fail.py \
+	rss_ctx.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
new file mode 100755
index 000000000000..74d2ca62083f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -0,0 +1,243 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import datetime
+import random
+from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ge, ksft_lt
+from lib.py import NetDrvEpEnv
+from lib.py import NetdevFamily
+from lib.py import KsftSkipEx
+from lib.py import rand_port
+from lib.py import ethtool, ip, GenerateTraffic, CmdExitFailure
+
+
+def _rss_key_str(key):
+    return ":".join(["{:02x}".format(x) for x in key])
+
+
+def _rss_key_rand(length):
+    return [random.randint(0, 255) for _ in range(length)]
+
+
+def get_rss(cfg):
+    return ethtool(f"-x {cfg.ifname}", json=True)[0]
+
+
+def ethtool_create(cfg, act, opts):
+    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
+    # Output will be something like: "New RSS context is 1" or
+    # "Added rule with ID 7", we want the integer from the end
+    return int(output.split()[-1])
+
+
+# Get Rx packet counts for all queues, as a simple list of integers
+# if @prev is specified the prev counts will be subtracted
+def _get_rx_cnts(cfg, prev=None):
+    cfg.wait_hw_stats_settle()
+    data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
+    data = [x for x in data if x['queue-type'] == "rx"]
+    max_q = max([x["queue-id"] for x in data])
+    queue_stats = [0] * (max_q + 1)
+    for q in data:
+        queue_stats[q["queue-id"]] = q["rx-packets"]
+        if prev and q["queue-id"] < len(prev):
+            queue_stats[q["queue-id"]] -= prev[q["queue-id"]]
+    return queue_stats
+
+
+def test_rss_key_indir(cfg):
+    """
+    Test basics like updating the main RSS key and indirection table.
+    """
+    data = get_rss(cfg)
+    want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
+    for k in want_keys:
+        if k not in data:
+            raise KsftFailEx("ethtool results missing key: " + k)
+        if not data[k]:
+            raise KsftFailEx(f"ethtool results empty for '{k}': {data[k]}")
+
+    key_len = len(data['rss-hash-key'])
+
+    # Set the key
+    key = _rss_key_rand(key_len)
+    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
+
+    data = get_rss(cfg)
+    ksft_eq(key, data['rss-hash-key'])
+
+    # Set the indirection table
+    ethtool(f"-X {cfg.ifname} equal 2")
+    data = get_rss(cfg)
+    ksft_eq(0, min(data['rss-indirection-table']))
+    ksft_eq(1, max(data['rss-indirection-table']))
+
+    # Check we only get traffic on the first 2 queues
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
+    # 2 queues, 20k packets, must be at least 5k per queue
+    ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts))
+    ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts))
+    # The other queues should be unused
+    ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
+
+    # Restore, and check traffic gets spread again
+    ethtool(f"-X {cfg.ifname} default")
+
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
+    # First two queues get less traffic than all the rest
+    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))
+
+
+def test_rss_context(cfg, ctx_cnt=1):
+    """
+    Test separating traffic into RSS contexts.
+    The queues will be allocated 2 for each context:
+     ctx0  ctx1  ctx2  ctx3
+    [0 1] [2 3] [4 5] [6 7] ...
+    """
+
+    requested_ctx_cnt = ctx_cnt
+
+    # Try to allocate more queues when necessary
+    qcnt = len(_get_rx_cnts(cfg))
+    if qcnt >= 2 + 2 * ctx_cnt:
+        qcnt = None
+    else:
+        try:
+            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
+            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
+        except:
+            raise KsftSkipEx("Not enough queues for the test")
+
+    ntuple = []
+    ctx_id = []
+    ports = []
+    try:
+        # Use queues 0 and 1 for normal traffic
+        ethtool(f"-X {cfg.ifname} equal 2")
+
+        for i in range(ctx_cnt):
+            try:
+                ctx_id.append(ethtool_create(cfg, "-X", "context new"))
+            except CmdExitFailure:
+                # try to carry on and skip at the end
+                if i == 0:
+                    raise
+                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
+                ctx_cnt = i
+                break
+
+            ethtool(f"-X {cfg.ifname} context {ctx_id[i]} start {2 + i * 2} equal 2")
+
+            ports.append(rand_port())
+            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
+            ntuple.append(ethtool_create(cfg, "-N", flow))
+
+        for i in range(ctx_cnt):
+            cnts = _get_rx_cnts(cfg)
+            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
+            cnts = _get_rx_cnts(cfg, prev=cnts)
+
+            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
+            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
+            ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
+    finally:
+        for nid in ntuple:
+            ethtool(f"-N {cfg.ifname} delete {nid}")
+        for cid in ctx_id:
+            ethtool(f"-X {cfg.ifname} context {cid} delete")
+        ethtool(f"-X {cfg.ifname} default")
+        if qcnt:
+            ethtool(f"-L {cfg.ifname} combined {qcnt}")
+
+    if requested_ctx_cnt != ctx_cnt:
+        raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
+
+
+def test_rss_context4(cfg):
+    test_rss_context(cfg, 4)
+
+
+def test_rss_context32(cfg):
+    test_rss_context(cfg, 32)
+
+
+def test_rss_context_overlap(cfg, other_ctx=0):
+    """
+    Test contexts overlapping with each other.
+    Use 4 queues for the main context, but only queues 2 and 3 for context 1.
+    """
+    ctx_id = None
+    ntuple = None
+    if other_ctx == 0:
+        ethtool(f"-X {cfg.ifname} equal 4")
+    else:
+        other_ctx = ethtool_create(cfg, "-X", "context new")
+        ethtool(f"-X {cfg.ifname} context {other_ctx} equal 4")
+
+    try:
+        ctx_id = ethtool_create(cfg, "-X", "context new")
+        ethtool(f"-X {cfg.ifname} context {ctx_id} start 2 equal 2")
+
+        port = rand_port()
+        if other_ctx:
+            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
+            ntuple = ethtool_create(cfg, "-N", flow)
+
+        # Test the main context
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+
+        ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
+        ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
+        ksft_ge(sum(cnts[2:4]),  7000, "traffic on main context (2/2): " + str(cnts))
+        if other_ctx == 0:
+            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
+
+        # Now create a rule for context 1 and make sure traffic goes to a subset
+        if other_ctx:
+            ethtool(f"-N {cfg.ifname} delete {ntuple}")
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+        ntuple = ethtool_create(cfg, "-N", flow)
+
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+
+        ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
+        ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
+        if other_ctx == 0:
+            ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
+    finally:
+        if ntuple:
+            ethtool(f"-N {cfg.ifname} delete {ntuple}")
+        if ctx_id:
+            ethtool(f"-X {cfg.ifname} context {ctx_id} delete")
+        if other_ctx == 0:
+            ethtool(f"-X {cfg.ifname} default")
+        else:
+            ethtool(f"-X {cfg.ifname} context {other_ctx} delete")
+
+
+def test_rss_context_overlap2(cfg):
+    test_rss_context_overlap(cfg, True)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.netdevnl = NetdevFamily()
+
+        ksft_run([test_rss_key_indir, test_rss_context, test_rss_context4,
+                  test_rss_context32, test_rss_context_overlap,
+                  test_rss_context_overlap2],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index ae60c438f6c2..1de62977433b 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -5,13 +5,14 @@ import time
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
 class GenerateTraffic:
-    def __init__(self, env):
+    def __init__(self, env, port=None):
         env.require_cmd("iperf3", remote=True)
 
         self.env = env
 
-        port = rand_port()
-        self._iperf_server = cmd(f"iperf3 -s -p {port}", background=True)
+        if port is None:
+            port = rand_port()
+        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
         wait_port_listen(port)
         time.sleep(0.1)
         self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 4769b4eb1ea1..91648c5baf40 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
         _fail("Check failed", a, "<", b, comment)
 
 
+def ksft_lt(a, b, comment=""):
+    if a > b:
+        _fail("Check failed", a, ">", b, comment)
+
+
 class ksft_raises:
     def __init__(self, expected_type):
         self.exception = None
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index bf8b5e4d9bac..b3ee57a650ae 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -8,6 +8,10 @@ import subprocess
 import time
 
 
+class CmdExitFailure(Exception):
+    pass
+
+
 class cmd:
     def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
         if ns:
@@ -42,8 +46,8 @@ import time
         if self.proc.returncode != 0 and fail:
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
-            raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
-                            (self.proc.args, stdout, stderr))
+            raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
+                                 (self.proc.args, stdout, stderr))
 
 
 class bkg(cmd):
-- 
2.45.2


