Return-Path: <netdev+bounces-167092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72771A38C96
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDC07A47A6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973B237706;
	Mon, 17 Feb 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M76t7BO9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D9237701
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821326; cv=none; b=TqAoN2K7ko1hQr/YtHCori8jy+BpnZAtueJ+qB1mAuHk0CpKfXkQqznNvFt751u9IlwFQ9So4LDP6M/k7k1BfcOlnzT5GuzjhlO3LgUQrWZH8bu070mB0osL6lwoeHuv4KmxK45codTvzUuzUJOIUzdpNb8MZXmiPCNpiK64U0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821326; c=relaxed/simple;
	bh=NDOUR1YdFclFVBZWrrhSjIdfua1VZJPZPCc5BILKvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvnZvzHYvIvhw1EfZak2narD7i3I4WgXVPEWFHVO9JvKnqQopY+HIj74Fui/QoW+xv1S/FRCwSp/9/aHMfLuyWfzPcXeny6tbczUwdFjKp4mIy/SqVX9YcGmzpvCzhWFe0C7yEyhPu6iHJqrCu1H8KzmI8RwNpsyjajq6QDlpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M76t7BO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AD1C4CED1;
	Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821325;
	bh=NDOUR1YdFclFVBZWrrhSjIdfua1VZJPZPCc5BILKvAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M76t7BO95VuoFf++JXJUy8P+EKhH9oA6GvbiFy+9a7NdbGcm1553UW90HLIYRJtWL
	 Ug3TeXXUEISdRtnQf5r2nYi44Gk1ekEooMAHUoQj6wbNmZvWcRtArO30ZCV43t+eI9
	 RkyU9ToWyDswteaDnKokvFXEM0Uv7fCfbQvkBHr/XuPsm/ukNcXriez0rlFED0xoHD
	 sB3y8qgmcoEVko9My3bl7/UXypxBp3mINEzoxlLVHojxnk5c2013i4qwKK0jHRXVWV
	 UnSmsuonDgygGJ+XqUDDlrUyvng192Du48KycGksDSCqbtZlk2VsvBBEv/qSG6hPgY
	 IiMcu+jI//7ig==
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
Subject: [PATCH net-next v3 3/4] selftests: drv-net: store addresses in dict indexed by ipver
Date: Mon, 17 Feb 2025 11:41:59 -0800
Message-ID: <20250217194200.3011136-4-kuba@kernel.org>
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

Looks like more and more tests want to iterate over IP version,
run the same test over ipv4 and ipv6. The current naming of
members in the env class makes it a bit awkward, we have
separate members for ipv4 and ipv6 parameters.

Store the parameters inside dicts, so that tests can easily
index them with ip version.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - new patch
---
 .../testing/selftests/drivers/net/hw/csum.py  | 48 +++++++------------
 .../selftests/drivers/net/hw/devmem.py        |  6 +--
 .../selftests/drivers/net/lib/py/env.py       | 47 +++++++++---------
 tools/testing/selftests/drivers/net/ping.py   | 12 ++---
 4 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index cd477f3440ca..701aca1361e0 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -9,15 +9,12 @@ from lib.py import ksft_run, ksft_exit, KsftSkipEx
 from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen
 
-def test_receive(cfg, ipv4=False, extra_args=None):
+def test_receive(cfg, ipver="6", extra_args=None):
     """Test local nic checksum receive. Remote host sends crafted packets."""
     if not cfg.have_rx_csum:
         raise KsftSkipEx(f"Test requires rx checksum offload on {cfg.ifname}")
 
-    if ipv4:
-        ip_args = f"-4 -S {cfg.remote_v4} -D {cfg.v4}"
-    else:
-        ip_args = f"-6 -S {cfg.remote_v6} -D {cfg.v6}"
+    ip_args = f"-{ipver} -S {cfg.remote_addr_v[ipver]} -D {cfg.addr_v[ipver]}"
 
     rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
     tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
@@ -27,17 +24,14 @@ from lib.py import bkg, cmd, wait_port_listen
         cmd(tx_cmd, host=cfg.remote)
 
 
-def test_transmit(cfg, ipv4=False, extra_args=None):
+def test_transmit(cfg, ipver="6", extra_args=None):
     """Test local nic checksum transmit. Remote host verifies packets."""
     if (not cfg.have_tx_csum_generic and
-        not (cfg.have_tx_csum_ipv4 and ipv4) and
-        not (cfg.have_tx_csum_ipv6 and not ipv4)):
+        not (cfg.have_tx_csum_ipv4 and ipver == "4") and
+        not (cfg.have_tx_csum_ipv6 and ipver == "6")):
         raise KsftSkipEx(f"Test requires tx checksum offload on {cfg.ifname}")
 
-    if ipv4:
-        ip_args = f"-4 -S {cfg.v4} -D {cfg.remote_v4}"
-    else:
-        ip_args = f"-6 -S {cfg.v6} -D {cfg.remote_v6}"
+    ip_args = f"-{ipver} -S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
 
     # Cannot randomize input when calculating zero checksum
     if extra_args != "-U -Z":
@@ -51,26 +45,20 @@ from lib.py import bkg, cmd, wait_port_listen
         cmd(tx_cmd)
 
 
-def test_builder(name, cfg, ipv4=False, tx=False, extra_args=""):
+def test_builder(name, cfg, ipver="6", tx=False, extra_args=""):
     """Construct specific tests from the common template.
 
        Most tests follow the same basic pattern, differing only in
        Direction of the test and optional flags passed to csum."""
     def f(cfg):
-        if ipv4:
-            cfg.require_v4()
-        else:
-            cfg.require_v6()
+        cfg.require_ipver(ipver)
 
         if tx:
-            test_transmit(cfg, ipv4, extra_args)
+            test_transmit(cfg, ipver, extra_args)
         else:
-            test_receive(cfg, ipv4, extra_args)
+            test_receive(cfg, ipver, extra_args)
 
-    if ipv4:
-        f.__name__ = "ipv4_" + name
-    else:
-        f.__name__ = "ipv6_" + name
+    f.__name__ = f"ipv{ipver}_" + name
     return f
 
 
@@ -104,15 +92,15 @@ from lib.py import bkg, cmd, wait_port_listen
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
         cases = []
-        for ipv4 in [True, False]:
-            cases.append(test_builder("rx_tcp", cfg, ipv4, False, "-t"))
-            cases.append(test_builder("rx_tcp_invalid", cfg, ipv4, False, "-t -E"))
+        for ipver in ["4", "6"]:
+            cases.append(test_builder("rx_tcp", cfg, ipver, False, "-t"))
+            cases.append(test_builder("rx_tcp_invalid", cfg, ipver, False, "-t -E"))
 
-            cases.append(test_builder("rx_udp", cfg, ipv4, False, ""))
-            cases.append(test_builder("rx_udp_invalid", cfg, ipv4, False, "-E"))
+            cases.append(test_builder("rx_udp", cfg, ipver, False, ""))
+            cases.append(test_builder("rx_udp_invalid", cfg, ipver, False, "-E"))
 
-            cases.append(test_builder("tx_udp_csum_offload", cfg, ipv4, True, "-U"))
-            cases.append(test_builder("tx_udp_zero_checksum", cfg, ipv4, True, "-U -Z"))
+            cases.append(test_builder("tx_udp_csum_offload", cfg, ipver, True, "-U"))
+            cases.append(test_builder("tx_udp_zero_checksum", cfg, ipver, True, "-U -Z"))
 
         ksft_run(cases=cases, args=(cfg, ))
     ksft_exit()
diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 1223f0f5c10c..3947e9157115 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -21,15 +21,15 @@ from lib.py import ksft_disruptive
 
 @ksft_disruptive
 def check_rx(cfg) -> None:
-    cfg.require_v6()
+    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
+    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
 
     with bkg(listen_cmd) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 128acff4f753..96b33b5ef9dd 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -113,6 +113,9 @@ from .remote import Remote
         self._ns = None
         self._ns_peer = None
 
+        self.addr_v        = { "4": None, "6": None }
+        self.remote_addr_v = { "4": None, "6": None }
+
         if "NETIF" in self.env:
             if nsim_test is True:
                 raise KsftXfailEx("Test only works on netdevsim")
@@ -120,10 +123,10 @@ from .remote import Remote
 
             self.dev = ip("-d link show dev " + self.env['NETIF'], json=True)[0]
 
-            self.v4 = self.env.get("LOCAL_V4")
-            self.v6 = self.env.get("LOCAL_V6")
-            self.remote_v4 = self.env.get("REMOTE_V4")
-            self.remote_v6 = self.env.get("REMOTE_V6")
+            self.addr_v["4"] = self.env.get("LOCAL_V4")
+            self.addr_v["6"] = self.env.get("LOCAL_V6")
+            self.remote_addr_v["4"] = self.env.get("REMOTE_V4")
+            self.remote_addr_v["6"] = self.env.get("REMOTE_V6")
             kind = self.env["REMOTE_TYPE"]
             args = self.env["REMOTE_ARGS"]
         else:
@@ -134,22 +137,22 @@ from .remote import Remote
 
             self.dev = self._ns.nsims[0].dev
 
-            self.v4 = self.nsim_v4_pfx + "1"
-            self.v6 = self.nsim_v6_pfx + "1"
-            self.remote_v4 = self.nsim_v4_pfx + "2"
-            self.remote_v6 = self.nsim_v6_pfx + "2"
+            self.addr_v["4"] = self.nsim_v4_pfx + "1"
+            self.addr_v["6"] = self.nsim_v6_pfx + "1"
+            self.remote_addr_v["4"] = self.nsim_v4_pfx + "2"
+            self.remote_addr_v["6"] = self.nsim_v6_pfx + "2"
             kind = "netns"
             args = self._netns.name
 
         self.remote = Remote(kind, args, src_path)
 
-        self.addr = self.v6 if self.v6 else self.v4
-        self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
+        self.addr_ipver = "6" if self.addr_v["6"] else "4"
+        self.addr = self.addr_v[self.addr_ipver]
+        self.remote_addr = self.remote_addr_v[self.addr_ipver]
 
-        self.addr_ipver = "6" if self.v6 else "4"
         # Bracketed addresses, some commands need IPv6 to be inside []
-        self.baddr = f"[{self.v6}]" if self.v6 else self.v4
-        self.remote_baddr = f"[{self.remote_v6}]" if self.remote_v6 else self.remote_v4
+        self.baddr = f"[{self.addr_v['6']}]" if self.addr_v["6"] else self.addr_v["4"]
+        self.remote_baddr = f"[{self.remote_addr_v['6']}]" if self.remote_addr_v["6"] else self.remote_addr_v["4"]
 
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
@@ -205,10 +208,10 @@ from .remote import Remote
 
     def resolve_remote_ifc(self):
         v4 = v6 = None
-        if self.remote_v4:
-            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
-        if self.remote_v6:
-            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
+        if self.remote_addr_v["4"]:
+            v4 = ip("addr show to " + self.remote_addr_v["4"], json=True, host=self.remote)
+        if self.remote_addr_v["6"]:
+            v6 = ip("addr show to " + self.remote_addr_v["6"], json=True, host=self.remote)
         if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
             raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
         if (v4 and len(v4) > 1) or (v6 and len(v6) > 1):
@@ -238,13 +241,9 @@ from .remote import Remote
             del self.remote
             self.remote = None
 
-    def require_v4(self):
-        if not self.v4 or not self.remote_v4:
-            raise KsftSkipEx("Test requires IPv4 connectivity")
-
-    def require_v6(self):
-        if not self.v6 or not self.remote_v6:
-            raise KsftSkipEx("Test requires IPv6 connectivity")
+    def require_ipver(self, ipver):
+        if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
+            raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index eb83e7b48797..6c5c21cb7265 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -8,17 +8,17 @@ from lib.py import bkg, cmd, wait_port_listen, rand_port
 
 
 def test_v4(cfg) -> None:
-    cfg.require_v4()
+    cfg.require_ipver("4")
 
-    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
-    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
+    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["4"]}", host=cfg.remote)
 
 
 def test_v6(cfg) -> None:
-    cfg.require_v6()
+    cfg.require_ipver("6")
 
-    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
-    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["6"]}")
+    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["6"]}", host=cfg.remote)
 
 
 def test_tcp(cfg) -> None:
-- 
2.48.1


