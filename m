Return-Path: <netdev+bounces-169241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F916A430C6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BFC3BB45A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499E20E33F;
	Mon, 24 Feb 2025 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKbwJDOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEA20E6E0
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439397; cv=none; b=XIpdlVMKIwYiUTV95jPKy3UPFqNTLyBQInwmsQfGG/XrW9/EzZnSzFjIBIWLXciDI9pOrnIoN7qNnt/OrRumBahUiAF05ca7ddVcv9f/f0tTvB5Fr04cbBdFbw2YhOYWvEOJQHiFmnm3pTMzPOSypV2HuVUeG29ZR03k0FbS2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439397; c=relaxed/simple;
	bh=hPujxlQXl1wFkVtGHaPX61YAUwQi+g+Z5zLvtQWyEu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnzXmaw9Ax7ETB4HeQZzuHI/jRPf72yMgaOqeCA6fJHmkL9VRiUGqQHAz6iH8EaHyzMzAsGR0pJsijy221ludlF2FD78J9KLV0ApluytxFS756DUO4PreY9d1q4cCqy8IVoiVTaWIW7IsjKSk8bN4cS4mOBUs2M6c3Ca5uC62jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKbwJDOJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740439396; x=1771975396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hPujxlQXl1wFkVtGHaPX61YAUwQi+g+Z5zLvtQWyEu0=;
  b=lKbwJDOJinK53TjWj2+Op/C0UvU/UJTvlg7wL6DOLUMGlcuVLJEvel3b
   dfO+7e/P7qLGeOGHTLHcBuv2GMP7TJ83BNpIM7rE61OhJw7jPeRytz5pN
   DQLycqz0hT7IV3ZfOmivtzWd2UndVxvv/qeJFBctJkobXouzecXqlfR8B
   YVd2pnIvtVnYR93lCCHGJ20AKiEQGusaBk+20ZIO4SdZmFYFtAnL0fxyo
   mNezMFQjcxgbfxQLuZTVPcqv6oinmaDn3vUkYv396PJ4s+EqEaMQLoiDT
   mA3aW8mI3fJCBMjNi0xEyu1RC2OOV0Tvgpr3kUDpJgTtpoFw/T/A3KfVN
   A==;
X-CSE-ConnectionGUID: IU+x8ltSSVeV3yUt4sQ82Q==
X-CSE-MsgGUID: qmggP9YZSiuGgq9DASoIMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40406735"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40406735"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:23:16 -0800
X-CSE-ConnectionGUID: IeYZEdD0SDC/I4K0ahO3bQ==
X-CSE-MsgGUID: S9jyQtTjT32k7VP+6oSkeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115997860"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:23:10 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v9 6/6] selftests: drv-net: add tests for napi IRQ affinity notifiers
Date: Mon, 24 Feb 2025 16:22:27 -0700
Message-ID: <20250224232228.990783-7-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224232228.990783-1-ahmed.zaki@intel.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add tests to check that the napi retained the IRQ after down/up,
multiple changes in the number of rx queues and after
attaching/releasing XDP program.

Tested on ice and idpf:

   # NETIF=<iface> tools/testing/selftests/drivers/net/hw/irq.py
    KTAP version 1
    1..4
    ok 1 irq.check_irqs_reported
    ok 2 irq.check_reconfig_queues
    ok 3 irq.check_reconfig_xdp
    ok 4 irq.check_down
    # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Tested-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |  4 +
 tools/testing/selftests/drivers/net/hw/irq.py | 99 +++++++++++++++++++
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c  | 13 +++
 .../selftests/drivers/net/lib/py/env.py       |  8 +-
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/irq.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index ae783e18be83..73e7b826a141 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS = \
 	ethtool_rmon.sh \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
+	irq.py \
 	loopback.sh \
 	nic_link_layer.py \
 	nic_performance.py \
@@ -33,9 +34,12 @@ TEST_INCLUDES := \
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := ncdevmem
 TEST_GEN_FILES += $(YNL_GEN_FILES)
+TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
 include ../../../lib.mk
 
 # YNL build
 YNL_GENS := ethtool netdev
 include ../../../net/ynl.mk
+
+include ../../../net/bpf.mk
diff --git a/tools/testing/selftests/drivers/net/hw/irq.py b/tools/testing/selftests/drivers/net/hw/irq.py
new file mode 100755
index 000000000000..42ab98370245
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/irq.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_ge, ksft_eq
+from lib.py import KsftSkipEx
+from lib.py import ksft_disruptive
+from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import NetDrvEnv
+from lib.py import cmd, ip, defer
+
+
+def read_affinity(irq) -> str:
+    with open(f'/proc/irq/{irq}/smp_affinity', 'r') as fp:
+        return fp.read().lstrip("0,").strip()
+
+
+def write_affinity(irq, what) -> str:
+    if what != read_affinity(irq):
+        with open(f'/proc/irq/{irq}/smp_affinity', 'w') as fp:
+            fp.write(what)
+
+
+def check_irqs_reported(cfg) -> None:
+    """ Check that device reports IRQs for NAPI instances """
+    napis = cfg.netnl.napi_get({"ifindex": cfg.ifindex}, dump=True)
+    irqs = sum(['irq' in x for x in napis])
+
+    ksft_ge(irqs, 1)
+    ksft_eq(irqs, len(napis))
+
+
+def _check_reconfig(cfg, reconfig_cb) -> None:
+    napis = cfg.netnl.napi_get({"ifindex": cfg.ifindex}, dump=True)
+    for n in reversed(napis):
+        if 'irq' in n:
+            break
+    else:
+        raise KsftSkipEx(f"Device has no NAPI with IRQ attribute (#napis: {len(napis)}")
+
+    old = read_affinity(n['irq'])
+    # pick an affinity that's not the current one
+    new = "3" if old != "3" else "5"
+    write_affinity(n['irq'], new)
+    defer(write_affinity, n['irq'], old)
+
+    reconfig_cb(cfg)
+
+    ksft_eq(read_affinity(n['irq']), new, comment="IRQ affinity changed after reconfig")
+
+
+def check_reconfig_queues(cfg) -> None:
+    def reconfig(cfg) -> None:
+        channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+        if channels['combined-count'] == 0:
+            rx_type = 'rx'
+        else:
+            rx_type = 'combined'
+        cur_queue_cnt = channels[f'{rx_type}-count']
+        max_queue_cnt = channels[f'{rx_type}-max']
+
+        cmd(f"ethtool -L {cfg.ifname} {rx_type} 1")
+        cmd(f"ethtool -L {cfg.ifname} {rx_type} {max_queue_cnt}")
+        cmd(f"ethtool -L {cfg.ifname} {rx_type} {cur_queue_cnt}")
+
+    _check_reconfig(cfg, reconfig)
+
+
+def check_reconfig_xdp(cfg) -> None:
+    def reconfig(cfg) -> None:
+        ip(f"link set dev %s xdp obj %s sec xdp" %
+            (cfg.ifname, cfg.rpath("xdp_dummy.bpf.o")))
+        ip(f"link set dev %s xdp off" % cfg.ifname)
+
+    _check_reconfig(cfg, reconfig)
+
+
+@ksft_disruptive
+def check_down(cfg) -> None:
+    def reconfig(cfg) -> None:
+        ip("link set dev %s down" % cfg.ifname)
+        ip("link set dev %s up" % cfg.ifname)
+
+    _check_reconfig(cfg, reconfig)
+
+
+def main() -> None:
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        cfg.netnl = NetdevFamily()
+
+        ksft_run([check_irqs_reported, check_reconfig_queues,
+                  check_reconfig_xdp, check_down],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c b/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
new file mode 100644
index 000000000000..d988b2e0cee8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define KBUILD_MODNAME "xdp_dummy"
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_dummy_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 96b33b5ef9dd..fd4d674e6c72 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -58,14 +58,20 @@ class NetDrvEnv(NetDrvEnvBase):
     """
     Class for a single NIC / host env, with no remote end
     """
-    def __init__(self, src_path, **kwargs):
+    def __init__(self, src_path, nsim_test=None, **kwargs):
         super().__init__(src_path)
 
         self._ns = None
 
         if 'NETIF' in self.env:
+            if nsim_test is True:
+                raise KsftXfailEx("Test only works on netdevsim")
+
             self.dev = ip("-d link show dev " + self.env['NETIF'], json=True)[0]
         else:
+            if nsim_test is False:
+                raise KsftXfailEx("Test does not work on netdevsim")
+
             self._ns = NetdevSimDev(**kwargs)
             self.dev = self._ns.nsims[0].dev
         self.ifname = self.dev['ifname']
-- 
2.43.0


