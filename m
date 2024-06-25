Return-Path: <netdev+bounces-106300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1C915B75
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DF11C21627
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383910A19;
	Tue, 25 Jun 2024 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7kuGm3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B991BC4E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277338; cv=none; b=lZkER2bSS1YxY7bJwHrzD26ByRqLrZoabn/JerNLAs+roX7COxroomIo/fsS1/nrWyTevfLWcTvIqehbKxpkvFg7/GmFO49MSj54Xvp/K8AVeTpf9lZpTPSGzcwvm+jYsCBaFDFzYAhEiZlbUxlTYSRYBME74ieBJNYTwx6pnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277338; c=relaxed/simple;
	bh=vILZoVPR4bHW15rSAQvifagc4XSQk6AVyFKkCzMZVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBKlMybWPYBX1wTCLMSwkm71Z3Ju2IKHHc+1VLyffBmmwkBFaL5ahEEvf7VxHz0vSTCMZh2vJQTsbxWouKAaLigxfHCz7nhgw4vCDYw05GvL4xx5l/5cNF3kGpZRrk/yvAVirxMOpuY66uWJkkVxCrRbPggca1Bd3qrA3DdMqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7kuGm3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8EC4AF0D;
	Tue, 25 Jun 2024 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719277337;
	bh=vILZoVPR4bHW15rSAQvifagc4XSQk6AVyFKkCzMZVes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7kuGm3GltIcWJ6o6xhdrZSjGqSZdxpcUa/2Yh/xF4hD5y7teiMzTzjj088CnnuXk
	 KqudBq3tn9WWtopzuExTzO2pQkM88HPzwEg0wUIhf9qr4aDPt6sxyDr5eDY1qHYLyt
	 UeDz2Tm0FVqmLefyyDq9znojeev9f4ZMAFJrZhkZZuNBHU7uQ1GJzyngPdR6h9MLjj
	 knb6vf40PLSblv21+dP/XKLik7Z0Hm3pH7SY/0us+7mPwsiCRjwVSPHLtX2duXtdHP
	 P940NkdxiMXzCCiYsh04gOL6e9V/rp0fnTT3CMmWJsYgBctIIYqf5byYFWjEPb7xm5
	 8exIXeUg8hRAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests for RSS configuration and contexts
Date: Mon, 24 Jun 2024 18:02:10 -0700
Message-ID: <20240625010210.2002310-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625010210.2002310-1-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests focusing on indirection table configuration and
creating extra RSS contexts in drivers which support it.

  $ export NETIF=eth0 REMOTE_...
  $ ./drivers/net/hw/rss_ctx.py
  KTAP version 1
  1..8
  ok 1 rss_ctx.test_rss_key_indir
  ok 2 rss_ctx.test_rss_context
  ok 3 rss_ctx.test_rss_context4
  # Increasing queue count 44 -> 66
  # Failed to create context 32, trying to test what we got
  ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
  ok 5 rss_ctx.test_rss_context_overlap
  ok 6 rss_ctx.test_rss_context_overlap2
  # .. sprays traffic like a headless chicken ..
  not ok 7 rss_ctx.test_rss_context_out_of_order
  ok 8 rss_ctx.test_rss_context4_create_with_cfg
  # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0

Note that rss_ctx.test_rss_context_out_of_order fails with the device
I tested with, but it seems to be a device / driver bug.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - ensure right queue count for each test (David)
 - check driver has ntuple filters before starting (Willem)
 - add test for creating contexts with indir table specified (Ed)
 - fix ksft_lt (Ed)
 - query and validate indirection tables of non-first context (Ed)
 - test traffic steering vs OOO context removal (Ed)
 - make sure overlap test deletes all rules, 0 is a valid ntuple ID,
   so we can't do "if ntuple: remove()"
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rss_ctx.py       | 383 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |   7 +-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 tools/testing/selftests/net/lib/py/utils.py   |   8 +-
 5 files changed, 399 insertions(+), 5 deletions(-)
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
index 000000000000..c9c864d5f7d1
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -0,0 +1,383 @@
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
+def get_rss(cfg, context=0):
+    return ethtool(f"-x {cfg.ifname} context {context}", json=True)[0]
+
+
+def get_drop_err_sum(cfg):
+    stats = ip("-s -s link show dev " + cfg.ifname, json=True)[0]
+    cnt = 0
+    for key in ['errors', 'dropped', 'over_errors', 'fifo_errors',
+                'length_errors', 'crc_errors', 'missed_errors',
+                'frame_errors']:
+        cnt += stats["stats64"]["rx"][key]
+    return cnt, stats["stats64"]["tx"]["carrier_changes"]
+
+
+def ethtool_create(cfg, act, opts):
+    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
+    # Output will be something like: "New RSS context is 1" or
+    # "Added rule with ID 7", we want the integer from the end
+    return int(output.split()[-1])
+
+
+def require_ntuple(cfg):
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not features["ntuple-filters"]["active"]:
+        # ntuple is more of a capability than a config knob, don't bother
+        # trying to enable it (until some driver actually needs it).
+        raise KsftSkipEx("Ntuple filters not enabled on the device: " + str(features["ntuple-filters"]))
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
+    if len(_get_rx_cnts(cfg)) < 2:
+        KsftSkipEx("Device has only one queue (or doesn't support queue stats)")
+
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
+def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
+    """
+    Test separating traffic into RSS contexts.
+    The queues will be allocated 2 for each context:
+     ctx0  ctx1  ctx2  ctx3
+    [0 1] [2 3] [4 5] [6 7] ...
+    """
+
+    require_ntuple(cfg)
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
+            want_cfg = f"start {2 + i * 2} equal 2"
+            create_cfg = want_cfg if create_with_cfg else ""
+
+            try:
+                ctx_id.append(ethtool_create(cfg, "-X", f"context new {create_cfg}"))
+            except CmdExitFailure:
+                # try to carry on and skip at the end
+                if i == 0:
+                    raise
+                ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
+                ctx_cnt = i
+                break
+
+            if not create_with_cfg:
+                ethtool(f"-X {cfg.ifname} context {ctx_id[i]} {want_cfg}")
+
+            # Sanity check the context we just created
+            data = get_rss(cfg, ctx_id[i])
+            ksft_eq(min(data['rss-indirection-table']), 2 + i * 2, "Unexpected context cfg: " + str(data))
+            ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
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
+def test_rss_context4_create_with_cfg(cfg):
+    test_rss_context(cfg, 4, create_with_cfg=True)
+
+
+def test_rss_context_out_of_order(cfg, ctx_cnt=4):
+    """
+    Test separating traffic into RSS contexts.
+    Contexts are removed in semi-random order, and steering re-tested
+    to make sure removal doesn't break steering to surviving contexts.
+    Test requires 3 contexts to work.
+    """
+
+    require_ntuple(cfg)
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
+    removed = [False] * ctx_cnt
+    ntuple = []
+    ctx_id = []
+    ports = []
+
+    def remove_ctx(idx):
+        ethtool(f"-N {cfg.ifname} delete {ntuple[idx]}")
+        del ntuple[idx]
+        ethtool(f"-X {cfg.ifname} context {ctx_id[idx]} delete")
+        del ctx_id[idx]
+        removed[idx] = True
+
+    def check_traffic():
+        for i in range(ctx_cnt):
+            cnts = _get_rx_cnts(cfg)
+            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
+            cnts = _get_rx_cnts(cfg, prev=cnts)
+
+            if not removed[i]:
+                ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
+                ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
+                ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
+            else:
+                ksft_ge(sum(cnts[ :2]), 20000, "traffic on main context:" + str(cnts))
+                ksft_eq(sum(cnts[2: ]),     0, "traffic on other contexts: " + str(cnts))
+
+    try:
+        # Use queues 0 and 1 for normal traffic
+        ethtool(f"-X {cfg.ifname} equal 2")
+
+        for i in range(ctx_cnt):
+            ctx_id.append(ethtool_create(cfg, "-X", f"context new start {2 + i * 2} equal 2"))
+
+            ports.append(rand_port())
+            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
+            ntuple.append(ethtool_create(cfg, "-N", flow))
+
+        check_traffic()
+
+        # Remove middle context
+        remove_ctx(ctx_cnt // 2)
+        check_traffic()
+
+        # Remove first context
+        remove_ctx(0)
+        check_traffic()
+
+        # Remove last context
+        remove_ctx(-1)
+        check_traffic()
+
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
+def test_rss_context_overlap(cfg, other_ctx=0):
+    """
+    Test contexts overlapping with each other.
+    Use 4 queues for the main context, but only queues 2 and 3 for context 1.
+    """
+
+    require_ntuple(cfg)
+
+    queue_cnt = len(_get_rx_cnts(cfg))
+    if queue_cnt >= 4:
+        queue_cnt = None
+    else:
+        try:
+            ksft_pr(f"Increasing queue count {queue_cnt} -> 4")
+            ethtool(f"-L {cfg.ifname} combined 4")
+        except:
+            raise KsftSkipEx("Not enough queues for the test")
+
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
+            ntuple = None
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
+        if ntuple is not None:
+            ethtool(f"-N {cfg.ifname} delete {ntuple}")
+        if ctx_id:
+            ethtool(f"-X {cfg.ifname} context {ctx_id} delete")
+        if other_ctx == 0:
+            ethtool(f"-X {cfg.ifname} default")
+        else:
+            ethtool(f"-X {cfg.ifname} context {other_ctx} delete")
+        if queue_cnt:
+            ethtool(f"-L {cfg.ifname} combined {queue_cnt}")
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
+        ksft_run([test_rss_key_indir,
+                  test_rss_context, test_rss_context4, test_rss_context32,
+                  test_rss_context_overlap, test_rss_context_overlap2,
+                  test_rss_context_out_of_order, test_rss_context4_create_with_cfg],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index 31f82f1e32c1..0f40a13926d0 100644
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
index 4769b4eb1ea1..45ffe277d94a 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -57,6 +57,11 @@ KSFT_RESULT_ALL = True
         _fail("Check failed", a, "<", b, comment)
 
 
+def ksft_lt(a, b, comment=""):
+    if a >= b:
+        _fail("Check failed", a, ">", b, comment)
+
+
 class ksft_raises:
     def __init__(self, expected_type):
         self.exception = None
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 11dbdd3b7612..231e4a2f0252 100644
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


