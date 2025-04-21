Return-Path: <netdev+bounces-184471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D9A9596F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A897016E77F
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC222D4D7;
	Mon, 21 Apr 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3U/BQV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF622ACE3
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274528; cv=none; b=BRmBs1cOV6659id49gjCKk/VqHIHk67Ro80TDQu8rbOP89tTx24AYbu+R4An4PDpRosTLbyG/XYXjWnXqTfgg7mMp1NZ7jbmAniX4CwDtYcP8yxQbaSEisAs7eFFSoW9hFRsAYgl8pqfJq49sDb9tWijnwvrnt0rl+/xvNj+iRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274528; c=relaxed/simple;
	bh=32GMHh5CuiLsWF5wNK3XaIk4DWPlImrojhZQKH5NXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQqK8w85H+DIP1Q/yErcI5mLYRhLeC1z+kV0HXZQHgvl9kyyC3yJVzoZKtHRP+dAiZEuK+Gxq5pEJ6G0Py2t0vwmaletl0U/RVyeZWChPWtuGoqFWcLMSY7G/p5bhTl4GbYmAxw3aRy5XtTx0tr9f6OmM6vqGFikJqWaKc7Lqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3U/BQV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B3C4CEE4;
	Mon, 21 Apr 2025 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274528;
	bh=32GMHh5CuiLsWF5wNK3XaIk4DWPlImrojhZQKH5NXeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3U/BQV1TeqiaGZMogISaJJ+3iRvr1hhE6iMGhK997hcSV3q98kio6d2bCfkct6jT
	 ly8vmQMBNStpFh41ju8ilPFEdjtAeL91YFhHDksOzLT3yX9/HjMMJNoRfXoUpDnOFU
	 ZIbwwUVl+ZZ+Y8uD5SuXstK4sGVEF20UIdzm0ae2d1ZcsBJHblroYdsp+LnfujuTYO
	 EG3GsuYs+wMdREccXhYlSeGSFvRgVN3hVxmj402eQLWGbvbtDfT8wAuXzQKlCyfYC1
	 F/urhWP+d1bwsB5R2qq/pba70Ncb6w1omt2FUPWuGz7XnMs7OqCT1bYoB+2xvMFmVW
	 /NmDzR0WSXChQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 22/22] selftests: drv-net: add test for rx-buf-len
Date: Mon, 21 Apr 2025 15:28:27 -0700
Message-ID: <20250421222827.283737-23-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for rx-buf-len. Check both nic-wide and per-queue settings.

  # ./drivers/net/hw/rx_buf_len.py
  TAP version 13
  1..6
  ok 1 rx_buf_len.nic_wide
  ok 2 rx_buf_len.nic_wide_check_packets
  ok 3 rx_buf_len.per_queue
  ok 4 rx_buf_len.per_queue_check_packets
  ok 5 rx_buf_len.queue_check_ring_count
  ok 6 rx_buf_len.queue_check_ring_count_check_packets
  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rx_buf_len.py    | 299 ++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rx_buf_len.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 07cddb19ba35..88625c0e86c8 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS = \
 	pp_alloc_fail.py \
 	rss_ctx.py \
 	rss_input_xfrm.py \
+	rx_buf_len.py \
 	tso.py \
 	#
 
diff --git a/tools/testing/selftests/drivers/net/hw/rx_buf_len.py b/tools/testing/selftests/drivers/net/hw/rx_buf_len.py
new file mode 100755
index 000000000000..d8a6d07fac5e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rx_buf_len.py
@@ -0,0 +1,299 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno, time
+from typing import Tuple
+from lib.py import ksft_run, ksft_exit, KsftSkipEx, KsftFailEx
+from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_not_in
+from lib.py import EthtoolFamily, NetdevFamily, NlError
+from lib.py import NetDrvEpEnv, GenerateTraffic
+from lib.py import cmd, defer, bpftrace, ethtool, rand_port
+
+
+def _do_bpftrace(cfg, mul, base_size, tgt_queue=None):
+    queue_filter = ''
+    if tgt_queue is not None:
+        queue_filter = 'if ($skb->queue_mapping != %d) {return;}' % (tgt_queue + 1, )
+
+    t = ('tracepoint:net:netif_receive_skb { ' +
+         '$skb = (struct sk_buff *)args->skbaddr; '+
+         '$sh = (struct skb_shared_info *)($skb->head + $skb->end); ' +
+         'if ($skb->dev->ifindex != ' + str(cfg.ifindex) + ') {return;} ' +
+         queue_filter +
+         '@[$skb->len - $skb->data_len] = count(); ' +
+         '@h[$skb->len - $skb->data_len] = count(); ' +
+         'if ($sh->nr_frags > 0) { @[$sh->frags[0].len] = count(); @d[$sh->frags[0].len] = count();} }'
+        )
+    maps = bpftrace(t, json=True, timeout=2)
+    # We expect one-dim array with something like:
+    # {"type": "map", "data": {"@": {"1500": 1, "719": 1,
+    sizes = maps["@"]
+    h = maps["@h"]
+    d = maps["@d"]
+    good = 0
+    bad = 0
+    for k, v in sizes.items():
+        k = int(k)
+        if mul == 1 and k > base_size:
+            bad += v
+        elif mul > 1 and k > base_size:
+            good += v
+        elif mul < 1 and k >= base_size:
+            bad += v
+    ksft_eq(bad, 0, "buffer was decreased but large buffers seen")
+    if mul > 1:
+        ksft_ge(good, 100, "buffer was increased but no large buffers seen")
+
+
+def _ethtool_create(cfg, act, opts):
+    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
+    # Output will be something like: "New RSS context is 1" or
+    # "Added rule with ID 7", we want the integer from the end
+    return int(output.split()[-1])
+
+
+def nic_wide(cfg, check_geometry=False) -> None:
+    """
+    Apply NIC wide rx-buf-len change. Run some traffic to make sure there
+    are no crashes. Test that setting 0 restores driver default.
+    Assume we start with the default.
+    """
+    try:
+        rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        rings = {}
+    if "rx-buf-len" not in rings:
+        raise KsftSkipEx('rx-buf-len configuration not supported by device')
+
+    if rings['rx-buf-len'] * 2 <= rings['rx-buf-len-max']:
+        mul = 2
+    else:
+        mul = 1/2
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'rx-buf-len': rings['rx-buf-len'] * mul})
+
+    # Use zero to restore default, per uAPI, we assume we started with default
+    reset = defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                       'rx-buf-len': 0})
+
+    new = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(new['rx-buf-len'], rings['rx-buf-len'] * mul, "config after change")
+
+    # Runs some traffic thru them buffers, to make things implode if they do
+    traf = GenerateTraffic(cfg)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, mul, rings['rx-buf-len'])
+    finally:
+        traf.wait_pkts_and_stop(20000)
+
+    reset.exec()
+    new = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(new['rx-buf-len'], rings['rx-buf-len'], "config reset to default")
+
+
+def nic_wide_check_packets(cfg) -> None:
+    nic_wide(cfg, check_geometry=True)
+
+
+def _check_queues_with_config(cfg, buf_len, qset):
+    cnt = 0
+    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    for q in queues:
+        if 'rx-buf-len' in q:
+            cnt += 1
+            ksft_eq(q['type'], "rx")
+            ksft_in(q['id'], qset)
+            ksft_eq(q['rx-buf-len'], buf_len, "buf size")
+    if cnt != len(qset):
+        raise KsftFailEx('queue rx-buf-len config invalid')
+
+
+def _per_queue_configure(cfg) -> Tuple[dict, int, defer]:
+    """
+    Prep for per queue test. Set the config on one queue and return
+    the original ring settings, the multiplier and reset defer.
+    """
+    # Validate / get initial settings
+    try:
+        rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        rings = {}
+    if "rx-buf-len" not in rings:
+        raise KsftSkipEx('rx-buf-len configuration not supported by device')
+
+    try:
+        queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    except NlError as e:
+        raise KsftSkipEx('queue configuration not supported by device')
+
+    if len(queues) < 2:
+        raise KsftSkipEx('not enough queues: ' + str(len(queues)))
+    for q in queues:
+        if 'rx-buf-len' in q:
+            raise KsftFailEx('queue rx-buf-len already configured')
+
+    # Apply a change, we'll target queue 1
+    if rings['rx-buf-len'] * 2 <= rings['rx-buf-len-max']:
+        mul = 2
+    else:
+        mul = 1/2
+    try:
+        cfg.netnl.queue_set({'ifindex': cfg.ifindex, "type": "rx", "id": 1,
+                             'rx-buf-len': rings['rx-buf-len'] * mul })
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx('per-queue rx-buf-len configuration not supported')
+        raise
+
+    reset = defer(cfg.netnl.queue_set, {'ifindex': cfg.ifindex,
+                                        "type": "rx", "id": 1,
+                                        'rx-buf-len': 0})
+    # Make sure config stuck
+    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
+
+    return rings, mul, reset
+
+
+def per_queue(cfg, check_geometry=False) -> None:
+    """
+    Similar test to nic_wide, but done a single queue (queue 1).
+    Flow filter is used to direct traffic to that queue.
+    """
+
+    rings, mul, reset = _per_queue_configure(cfg)
+    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
+
+    # Check with traffic, we need to direct the traffic to the expected queue
+    port = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} action 1"
+    nid = _ethtool_create(cfg, "-N", flow)
+    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
+
+    traf = GenerateTraffic(cfg, port=port)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, mul, rings['rx-buf-len'], tgt_queue=1)
+    finally:
+        traf.wait_pkts_and_stop(20000)
+    ntuple.exec()
+
+    # And now direct to another queue
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} action 0"
+    nid = _ethtool_create(cfg, "-N", flow)
+    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
+
+    traf = GenerateTraffic(cfg, port=port)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=0)
+    finally:
+        traf.wait_pkts_and_stop(20000)
+
+    # Back to default
+    reset.exec()
+    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    for q in queues:
+        ksft_not_in('rx-buf-len', q)
+
+
+def per_queue_check_packets(cfg) -> None:
+    per_queue(cfg, check_geometry=True)
+
+
+def queue_check_ring_count(cfg, check_geometry=False) -> None:
+    """
+    Make sure the change of ring count is handled correctly.
+    """
+    rings, mul, reset = _per_queue_configure(cfg)
+
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    if channels.get('combined-count', 0) < 4:
+        raise KsftSkipEx('need at least 4 rings, have',
+                         channels.get('combined-count'))
+
+    # Move the channel count up and down, should make no difference
+    moves = [1, 0]
+    if channels['combined-count'] == channels['combined-max']:
+        moves = [-1, 0]
+    for move in moves:
+        target = channels['combined-count'] + move
+        cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
+                                'combined-count': target})
+
+    _check_queues_with_config(cfg, rings['rx-buf-len'] * mul, {1})
+
+    # Check with traffic, we need to direct the traffic to the expected queue
+    port1 = rand_port()
+    flow1 = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port1} action 1"
+    nid = _ethtool_create(cfg, "-N", flow1)
+    ntuple = defer(ethtool, f"-N {cfg.ifname} delete {nid}")
+
+    traf = GenerateTraffic(cfg, port=port1)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, mul, rings['rx-buf-len'], tgt_queue=1)
+    finally:
+        traf.wait_pkts_and_stop(20000)
+
+    # And now direct to another queue
+    port0 = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port0} action 0"
+    nid = _ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {nid}")
+
+    traf = GenerateTraffic(cfg, port=port0)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=0)
+    finally:
+        traf.wait_pkts_and_stop(20000)
+
+    # Go to a single queue, should reset
+    ntuple.exec()
+    cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
+                            'combined-count': 1})
+    cfg.ethnl.channels_set({'header': {'dev-index': cfg.ifindex},
+                            'combined-count': channels['combined-count']})
+
+    nid = _ethtool_create(cfg, "-N", flow1)
+    defer(ethtool, f"-N {cfg.ifname} delete {nid}")
+
+    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    for q in queues:
+        ksft_not_in('rx-buf-len', q)
+
+    # Check with traffic that queue is now getting normal buffers
+    traf = GenerateTraffic(cfg, port=port1)
+    try:
+        if check_geometry:
+            _do_bpftrace(cfg, 1, rings['rx-buf-len'], tgt_queue=1)
+    finally:
+        traf.wait_pkts_and_stop(20000)
+
+
+def queue_check_ring_count_check_packets(cfg):
+    queue_check_ring_count(cfg, True)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.netnl = NetdevFamily()
+        cfg.ethnl = EthtoolFamily()
+
+        o = [nic_wide,
+             per_queue,
+             nic_wide_check_packets]
+
+        ksft_run([nic_wide,
+                  nic_wide_check_packets,
+                  per_queue,
+                  per_queue_check_packets,
+                  queue_check_ring_count,
+                  queue_check_ring_count_check_packets],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.49.0


