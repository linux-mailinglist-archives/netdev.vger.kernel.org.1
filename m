Return-Path: <netdev+bounces-167093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B93A38C9E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A5B3A5583
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0AD237A4F;
	Mon, 17 Feb 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtZF1Y+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B16237718
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821326; cv=none; b=jG26noqC9XFBsqv+5ZRxOnyJZeiKjxyhfdp4vNdkPKFrFjLYcpo0TrHzkx4+GbDJz5Tu+25qKNGlGZyWjWACnnEMoXR7P8IZYng8hJazWo96HmEFIGwRmne4PXngtb6yuPXkzSat3yAbiXDZcGrEB+Q5nF6P9/OWOncKKu00kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821326; c=relaxed/simple;
	bh=9uOOwpzG0gyDXVI/6CzJQoTufxIL/ydY0cQavrDTEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKBIUsm+4T0mXjbrKnKdv2ZnCrKllYBt3d+dOoZKjtVerwny57ovEUAbvP7K5oHQL+lLdWcEHS2OVFJ7sfIhM9ze0gN/8B52frKnb3VrwjpFCMFf1g3jJqZkIc9zNJAvI/AzTNH/U1Ibcbpjg8rOV5SxyJw02t1TAwhKzi2v0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtZF1Y+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A0AC4CEE8;
	Mon, 17 Feb 2025 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821326;
	bh=9uOOwpzG0gyDXVI/6CzJQoTufxIL/ydY0cQavrDTEpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtZF1Y+5+wTlzr2QZJs+MxnG9F9N1E9h6kRExbWxf0DAHLyUwOuh6JP4WPDKt1JYj
	 hHf88eQnXW5w45tTnAL7oSn/XkCOA6tAHMaH8JY0yQ2Dj6C8T+2hdY4lOqSKGpvnCm
	 uyca27CHMGsIH8B88z6eMlKO7WM8ijBf5X0bEhOiJ8P6lIq7QBeK4SIIk8bm7rOJZS
	 4wfMEccB22JknmMy/RVErdbEQEoUw73vjwutHrh99Zy0vUQAXb0idf9cu/cAmxYJPE
	 rmOJaIlhMVnlS/zgdaJWEq2X5B4Z0hwzdwUkWH5ldEgLoqrFP1YS/ugSsg6MWW69y6
	 ze0OObH+iFHXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	stfomichev@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 4/4] selftests: drv-net: add a simple TSO test
Date: Mon, 17 Feb 2025 11:42:00 -0800
Message-ID: <20250217194200.3011136-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217194200.3011136-1-kuba@kernel.org>
References: <20250217194200.3011136-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for TSO. Send a few MB of data and check device
stats to verify that the device was performing segmentation.
Do the same thing over a few tunnel types.

Injecting GSO packets directly would give us more ability to test
corner cases, but perhaps starting simple is good enough?

  # ./ksft-net-drv/drivers/net/hw/tso.py
  # Detected qstat for LSO wire-packets
  KTAP version 1
  1..14
  ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
  ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
  ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
  ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
  ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
  ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
  ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
  ok 8 tso.ipv6
  ok 9 tso.vxlan4_ipv6
  ok 10 tso.vxlan6_ipv6
  ok 11 tso.vxlan_csum4_ipv6
  ok 12 tso.vxlan_csum6_ipv6
  ok 13 tso.gre4_ipv6
  ok 14 tso.gre6_ipv6
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0

Note that the test currently depends on the driver reporting
the LSO count via qstat, which appears to be relatively rare
(virtio, cisco/enic, sfc/efc; but virtio needs host support).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - rework after the v4/v6 address split
v2: https://lore.kernel.org/20250214234631.2308900-4-kuba@kernel.org
 - lower max noise
 - mention header overhead in the comment
 - fix the basic v4 TSO feature name
 - also run a stream with just GSO partial for tunnels
v1: https://lore.kernel.org/20250213003454.1333711-4-kuba@kernel.org
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/tso.py | 222 ++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 21ba64ce1e34..ae783e18be83 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS = \
 	nic_performance.py \
 	pp_alloc_fail.py \
 	rss_ctx.py \
+	tso.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
new file mode 100755
index 000000000000..ac457def73b6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -0,0 +1,222 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run the tools/testing/selftests/net/csum testsuite."""
+
+import fcntl
+import socket
+import struct
+import termios
+import time
+
+from lib.py import ksft_pr, ksft_run, ksft_exit, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_eq, ksft_ge, ksft_lt
+from lib.py import EthtoolFamily, NetdevFamily, NetDrvEpEnv
+from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
+
+
+def sock_wait_drain(sock, max_wait=1000):
+    """Wait for all pending write data on the socket to get ACKed."""
+    for _ in range(max_wait):
+        one = b'\0' * 4
+        outq = fcntl.ioctl(sock.fileno(), termios.TIOCOUTQ, one)
+        outq = struct.unpack("I", outq)[0]
+        if outq == 0:
+            break
+        time.sleep(0.01)
+    ksft_eq(outq, 0)
+
+
+def tcp_sock_get_retrans(sock):
+    """Get the number of retransmissions for the TCP socket."""
+    info = sock.getsockopt(socket.SOL_TCP, socket.TCP_INFO, 512)
+    return struct.unpack("I", info[100:104])[0]
+
+
+def run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso):
+    cfg.require_cmd("socat", remote=True)
+
+    port = rand_port()
+    listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
+
+    with bkg(listen_cmd, host=cfg.remote) as nc:
+        wait_port_listen(port, host=cfg.remote)
+
+        if ipver == "4":
+            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+            sock.connect((remote_v4, port))
+        else:
+            sock = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
+            sock.connect((remote_v6, port))
+
+        # Small send to make sure the connection is working.
+        sock.send("ping".encode())
+        sock_wait_drain(sock)
+
+        # Send 4MB of data, record the LSO packet count.
+        qstat_old = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+        buf = b"0" * 1024 * 1024 * 4
+        sock.send(buf)
+        sock_wait_drain(sock)
+        qstat_new = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+        # No math behind the 10 here, but try to catch cases where
+        # TCP falls back to non-LSO.
+        ksft_lt(tcp_sock_get_retrans(sock), 10)
+        sock.close()
+
+        # Check that at least 90% of the data was sent as LSO packets.
+        # System noise may cause false negatives. Also header overheads
+        # will add up to 5% of extra packes... The check is best effort.
+        total_lso_wire  = len(buf) * 0.90 // cfg.dev["mtu"]
+        total_lso_super = len(buf) * 0.90 // cfg.dev["tso_max_size"]
+        if should_lso:
+            if cfg.have_stat_super_count:
+                ksft_ge(qstat_new['tx-hw-gso-packets'] -
+                        qstat_old['tx-hw-gso-packets'],
+                        total_lso_super,
+                        comment="Number of LSO super-packets with LSO enabled")
+            if cfg.have_stat_wire_count:
+                ksft_ge(qstat_new['tx-hw-gso-wire-packets'] -
+                        qstat_old['tx-hw-gso-wire-packets'],
+                        total_lso_wire,
+                        comment="Number of LSO wire-packets with LSO enabled")
+        else:
+            if cfg.have_stat_super_count:
+                ksft_lt(qstat_new['tx-hw-gso-packets'] -
+                        qstat_old['tx-hw-gso-packets'],
+                        15, comment="Number of LSO super-packets with LSO disabled")
+            if cfg.have_stat_wire_count:
+                ksft_lt(qstat_new['tx-hw-gso-wire-packets'] -
+                        qstat_old['tx-hw-gso-wire-packets'],
+                        500, comment="Number of LSO wire-packets with LSO disabled")
+
+
+def build_tunnel(cfg, outer_ipver, tun_info):
+    local_v4  = NetDrvEpEnv.nsim_v4_pfx + "1"
+    local_v6  = NetDrvEpEnv.nsim_v6_pfx + "1"
+    remote_v4 = NetDrvEpEnv.nsim_v4_pfx + "2"
+    remote_v6 = NetDrvEpEnv.nsim_v6_pfx + "2"
+
+    local_addr  = cfg.addr_v[outer_ipver]
+    remote_addr = cfg.remote_addr_v[outer_ipver]
+
+    tun_type = tun_info[0]
+    tun_arg  = tun_info[2]
+    ip(f"link add {tun_type}-ksft type {tun_type} {tun_arg} local {local_addr} remote {remote_addr} dev {cfg.ifname}")
+    defer(ip, f"link del {tun_type}-ksft")
+    ip(f"link set dev {tun_type}-ksft up")
+    ip(f"addr add {local_v4}/24 dev {tun_type}-ksft")
+    ip(f"addr add {local_v6}/64 dev {tun_type}-ksft")
+
+    ip(f"link add {tun_type}-ksft type {tun_type} {tun_arg} local {remote_addr} remote {local_addr} dev {cfg.remote_ifname}",
+        host=cfg.remote)
+    defer(ip, f"link del {tun_type}-ksft", host=cfg.remote)
+    ip(f"link set dev {tun_type}-ksft up", host=cfg.remote)
+    ip(f"addr add {remote_v4}/24 dev {tun_type}-ksft", host=cfg.remote)
+    ip(f"addr add {remote_v6}/64 dev {tun_type}-ksft", host=cfg.remote)
+
+    return remote_v4, remote_v6
+
+
+def test_builder(name, cfg, ipver, feature, tun=None, inner_ipver=None):
+    """Construct specific tests from the common template."""
+    def f(cfg):
+        cfg.require_ipver(ipver)
+
+        if not cfg.have_stat_super_count and \
+           not cfg.have_stat_wire_count:
+            raise KsftSkipEx(f"Device does not support LSO queue stats")
+
+        if tun:
+            remote_v4, remote_v6 = build_tunnel(cfg, ipver, tun)
+        else:
+            remote_v4 = cfg.remote_addr_v["4"]
+            remote_v6 = cfg.remote_addr_v["6"]
+
+        tun_partial = tun and tun[1]
+        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
+
+        # First test without the feature enabled.
+        ethtool(f"-K {cfg.ifname} {feature} off")
+        if has_gso_partial:
+            ethtool(f"-K {cfg.ifname} tx-gso-partial off")
+        run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=False)
+
+        # Now test with the feature enabled.
+        # For compatible tunnels only - just GSO partial, not specific feature.
+        if has_gso_partial:
+            ethtool(f"-K {cfg.ifname} tx-gso-partial on")
+            run_one_stream(cfg, ipver, remote_v4, remote_v6,
+                           should_lso=tun_partial)
+
+        # Full feature enabled.
+        if feature in cfg.features:
+            ethtool(f"-K {cfg.ifname} {feature} on")
+            run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=True)
+        else:
+            raise KsftXfailEx(f"Device does not support {feature}")
+
+    f.__name__ = name + ((ipver + "_") if tun else "") + "ipv" + ipver
+    return f
+
+
+def query_nic_features(cfg) -> None:
+    """Query and cache the NIC features."""
+    cfg.features = set()
+
+    cfg.have_stat_super_count = False
+    cfg.have_stat_wire_count = False
+
+    features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
+    for f in features["active"]["bits"]["bit"]:
+        cfg.features.add(f["name"])
+    for f in features["hw"]["bits"]["bit"]:
+        cfg.features.add(f["name"])
+
+    stats = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)
+    if stats:
+        if 'tx-hw-gso-packets' in stats[0]:
+            ksft_pr("Detected qstat for LSO super-packets")
+            cfg.have_stat_super_count = True
+        if 'tx-hw-gso-wire-packets' in stats[0]:
+            ksft_pr("Detected qstat for LSO wire-packets")
+            cfg.have_stat_wire_count = True
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+
+        query_nic_features(cfg)
+
+        test_info = (
+            # name,       v4/v6  ethtool_feature              tun:(type,    partial, args)
+            ("",            "4", "tx-tcp-segmentation",           None),
+            ("",            "6", "tx-tcp6-segmentation",          None),
+            ("vxlan",        "", "tx-udp_tnl-segmentation",       ("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
+            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  False, "id 100 dstport 4789 udpcsum")),
+            ("gre",         "4", "tx-gre-segmentation",           ("ipgre",  False,  "")),
+            ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", False,  "")),
+        )
+
+        cases = []
+        for outer_ipver in ["4", "6"]:
+            for info in test_info:
+                # Skip if test which only works for a specific IP version
+                if info[1] and outer_ipver != info[1]:
+                    continue
+
+                cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
+                                          tun=info[3], inner_ipver="4"))
+                if info[3]:
+                    cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
+                                              tun=info[3], inner_ipver="6"))
+
+        ksft_run(cases=cases, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.48.1


