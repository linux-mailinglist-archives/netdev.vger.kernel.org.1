Return-Path: <netdev+bounces-167545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD7A3AC0D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A37E188F078
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C91DD0E1;
	Tue, 18 Feb 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYRcuzYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B51DC99E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919274; cv=none; b=qgHWnlefVc7A7mXSXnfmKBAsqUlLkI53p6PZ8kwU0ny+nP4nNE4drKT92+VkPOUjue4GDghfk1ZY7VioEP/kK2w+dsW5gGWQzqDhSrI5r/UeABS77QeAg7121o386NKWV3vvcxa7GkK0Uq5PFMJSe2vq9prib0sQpQ6tm4hDOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919274; c=relaxed/simple;
	bh=cNcYkWScSE+sCMm53WCI0WjGatiWi6QKJP5kg9K8qzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkozmoGBIvRWW/U6iiZ4INTYvFQGY7k4Zuy+X0rQaCTuFFxI9oEB/p21a2Pq89AzBBEjpv8bSEhut0dma7NJAoZ7JKDIeWKZMxhJOVANhZ8FFy0ch/bFOORRZk0Um4Veusw7vjtlEu44OeA2Ao58wkflJLqWJsXWeMA2YzcfYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYRcuzYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5119C4CEEA;
	Tue, 18 Feb 2025 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919274;
	bh=cNcYkWScSE+sCMm53WCI0WjGatiWi6QKJP5kg9K8qzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYRcuzYp4UFJiohUMm1Jg5oXckDcFnqxxsMe0/LkSdPGL0/9dGsCpGHk1MHCfdYPn
	 epD+SkkiiVue2VP7i7HAVwiN29xb+drtSFvqQyV1hnoDMhDPW5Iu5NvW8ZsujmzBwq
	 h88eWEoESYvm6Z1xsFicArp42qCV06JBvuWaF7nMvz0+nkgT1/iuGZro6a9ZcyXgzk
	 xNfEKC5juzmCxglZcInU1fwMapPCRs7NrSoUANoEpj2y5raLPdsYYFm7d5V2FjssUh
	 ihI6spyY7jsLiX4vj8CiF5dQSBI1+Dt+SzlAX2l2wEXLuj3YgykQW31y4XDYlqoVyq
	 9ZX4rgJB2VVmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 4/4] selftests: drv-net: add a simple TSO test
Date: Tue, 18 Feb 2025 14:54:26 -0800
Message-ID: <20250218225426.77726-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218225426.77726-1-kuba@kernel.org>
References: <20250218225426.77726-1-kuba@kernel.org>
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
  # Testing with mangleid enabled
  ok 13 tso.gre4_ipv6
  ok 14 tso.gre6_ipv6
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0

Note that the test currently depends on the driver reporting
the LSO count via qstat, which appears to be relatively rare
(virtio, cisco/enic, sfc/efc; but virtio needs host support).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4:
 - fix v4/v6 test naming
 - correctly select the inner vs outer protocol version
 - enable mangleid if tunnel is supported via GSO partial
v3: https://lore.kernel.org/20250217194200.3011136-5-kuba@kernel.org
 - rework after the v4/v6 address split
v2: https://lore.kernel.org/20250214234631.2308900-4-kuba@kernel.org
 - lower max noise
 - mention header overhead in the comment
 - fix the basic v4 TSO feature name
 - also run a stream with just GSO partial for tunnels
v1: https://lore.kernel.org/20250213003454.1333711-4-kuba@kernel.org

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/tso.py | 241 ++++++++++++++++++
 2 files changed, 242 insertions(+)
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
index 000000000000..e1ecb92f79d9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -0,0 +1,241 @@
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
+    listen_cmd = f"socat -{ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
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
+def test_builder(name, cfg, outer_ipver, feature, tun=None, inner_ipver=None):
+    """Construct specific tests from the common template."""
+    def f(cfg):
+        cfg.require_ipver(outer_ipver)
+
+        if not cfg.have_stat_super_count and \
+           not cfg.have_stat_wire_count:
+            raise KsftSkipEx(f"Device does not support LSO queue stats")
+
+        ipver = outer_ipver
+        if tun:
+            remote_v4, remote_v6 = build_tunnel(cfg, ipver, tun)
+            ipver = inner_ipver
+        else:
+            remote_v4 = cfg.remote_addr_v["4"]
+            remote_v6 = cfg.remote_addr_v["6"]
+
+        tun_partial = tun and tun[1]
+        # Tunnel which can silently fall back to gso-partial
+        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
+
+        # For TSO4 via partial we need mangleid
+        if ipver == "4" and feature in cfg.partial_features:
+            ksft_pr("Testing with mangleid enabled")
+            if 'tx-tcp-mangleid-segmentation' not in cfg.features:
+                ethtool(f"-K {cfg.ifname} tx-tcp-mangleid-segmentation on")
+                defer(ethtool, f"-K {cfg.ifname} tx-tcp-mangleid-segmentation off")
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
+    f.__name__ = name + ((outer_ipver + "_") if tun else "") + "ipv" + inner_ipver
+    return f
+
+
+def query_nic_features(cfg) -> None:
+    """Query and cache the NIC features."""
+    cfg.have_stat_super_count = False
+    cfg.have_stat_wire_count = False
+
+    cfg.features = set()
+    features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
+    for f in features["active"]["bits"]["bit"]:
+        cfg.features.add(f["name"])
+
+    # Check which features are supported via GSO partial
+    cfg.partial_features = set()
+    if 'tx-gso-partial' in cfg.features:
+        ethtool(f"-K {cfg.ifname} tx-gso-partial off")
+
+        no_partial = set()
+        features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
+        for f in features["active"]["bits"]["bit"]:
+            no_partial.add(f["name"])
+        cfg.partial_features = cfg.features - no_partial
+        ethtool(f"-K {cfg.ifname} tx-gso-partial on")
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


