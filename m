Return-Path: <netdev+bounces-178027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27870A740B8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0E7189F4DC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690A1DE88C;
	Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMzLbU9E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E81DC9AB
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114203; cv=none; b=HsjGrdK8IrSIA37a0CeYjef+xfQlAVKI+W7mv5X4mWesq5faKavhoujamZMGkowXh29Kxisyf0F2J62Tt7iqab+/JdpcMXKth2JUzOOKjnaR1AZPbGsRFcD9BP74GqJwdSf/Z6pmHCKCrGyAm1hVmcV5mCSrs2+7mCQL/Gbhig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114203; c=relaxed/simple;
	bh=1J9jDLUdm+uyQyLly2UdXpzqRBADlJ68oaMqriBMqhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd1xEWMqya2bGifPbVJxiV8v2hCvZCfI3GW7qaGHeq7LGo3pfKHFko90SIvQP7H9eJyR+godExwWDJxyNosn5tys8RGk9txw2+9IpY1Icl3yQjjk9adF1FB/bCgzjzeFdKF5jM1VqPTWkzVoVSBS+DMRMH5wyGX7zR2kbtNl6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMzLbU9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4473C4CEEA;
	Thu, 27 Mar 2025 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743114203;
	bh=1J9jDLUdm+uyQyLly2UdXpzqRBADlJ68oaMqriBMqhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMzLbU9EcC1xQsJuNANiOxoSTESrhbpccL90+JA5UFGxjNzsvlSW4rhW4IbfVVu83
	 k5znXLzjj/pC9CiOvjRH5c98axAceddmHEY1C8pCSGdfqnIJ0GFWe+bd04wiQRNyVM
	 Eh2Yxdbtfk1O+wxiNcjdiVtxJHkaZ+NHVidcp2EqhqabUJQjYQUoznA+6SVuR0rs4y
	 1tNkRUZ5aGriSjxiB9WULv58hhUJQEEx7mZiz0N+1Z0XAYJFZjp+92U3kVXhNy/jNm
	 5ZF2GgrTQBtJ6meKJRFX+sKM9x4Gu86ykfBd8b/WgUXQ4lj24S09rbladxEKLOwTK6
	 KJdqqDI7c839Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 1/3] selftests: drv-net: replace the rpath helper with Path objects
Date: Thu, 27 Mar 2025 15:23:13 -0700
Message-ID: <20250327222315.1098596-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250327222315.1098596-1-kuba@kernel.org>
References: <20250327222315.1098596-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The single letter + "path" helpers do not have many fans (see Link).
Use a Path object with a better name. test_dir is the replacement
for rpath(), net_lib_dir is a new path of the $ksft/net/lib directory.

The Path() class overloads the "/" operator and can be cast to string
automatically, so to get a path to a file tests can do:

    path = env.test_dir / "binary"

Link: https://lore.kernel.org/CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - change the approach to use Path
v2: https://lore.kernel.org/20250306171158.1836674-1-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/hds.py    |  2 +-
 .../testing/selftests/drivers/net/hw/csum.py  |  2 +-
 tools/testing/selftests/drivers/net/hw/irq.py |  2 +-
 .../selftests/drivers/net/lib/py/env.py       | 21 +++++++------------
 tools/testing/selftests/drivers/net/queues.py |  4 ++--
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7cc74faed743..8b7f6acad15f 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -20,7 +20,7 @@ from lib.py import defer, ethtool, ip
 
 
 def _xdp_onoff(cfg):
-    prog = cfg.rpath("../../net/lib/xdp_dummy.bpf.o")
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     ip("link set dev %s xdp obj %s sec xdp" %
        (cfg.ifname, prog))
     ip("link set dev %s xdp off" % cfg.ifname)
diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index 701aca1361e0..cd23af875317 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -88,7 +88,7 @@ from lib.py import bkg, cmd, wait_port_listen
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         check_nic_features(cfg)
 
-        cfg.bin_local = cfg.rpath("../../../net/lib/csum")
+        cfg.bin_local = cfg.net_lib_dir / "csum"
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
         cases = []
diff --git a/tools/testing/selftests/drivers/net/hw/irq.py b/tools/testing/selftests/drivers/net/hw/irq.py
index 42ab98370245..d772a18d8a1b 100755
--- a/tools/testing/selftests/drivers/net/hw/irq.py
+++ b/tools/testing/selftests/drivers/net/hw/irq.py
@@ -69,7 +69,7 @@ from lib.py import cmd, ip, defer
 def check_reconfig_xdp(cfg) -> None:
     def reconfig(cfg) -> None:
         ip(f"link set dev %s xdp obj %s sec xdp" %
-            (cfg.ifname, cfg.rpath("xdp_dummy.bpf.o")))
+           (cfg.ifname, cfg.test_dir / "xdp_dummy.bpf.o"))
         ip(f"link set dev %s xdp off" % cfg.ifname)
 
     _check_reconfig(cfg, reconfig)
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index fd4d674e6c72..ad5ff645183a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -13,23 +13,18 @@ from .remote import Remote
 class NetDrvEnvBase:
     """
     Base class for a NIC / host envirnoments
+
+    Attributes:
+      test_dir: Path to the source directory of the test
+      net_lib_dir: Path to the net/lib directory
     """
     def __init__(self, src_path):
-        self.src_path = src_path
+        self.src_path = Path(src_path)
+        self.test_dir = self.src_path.parent.resolve()
+        self.net_lib_dir = (Path(__file__).parent / "../../../../net/lib").resolve()
+
         self.env = self._load_env_file()
 
-    def rpath(self, path):
-        """
-        Get an absolute path to a file based on a path relative to the directory
-        containing the test which constructed env.
-
-        For example, if the test.py is in the same directory as
-        a binary (built from helper.c), the test can use env.rpath("helper")
-        to get the absolute path to the binary
-        """
-        src_dir = Path(self.src_path).parent.resolve()
-        return (src_dir / path).as_posix()
-
     def _load_env_file(self):
         env = os.environ.copy()
 
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index cae923f84f69..06abd3f233e1 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -26,13 +26,13 @@ import struct
 
 def check_xsk(cfg, nl, xdp_queue_id=0) -> None:
     # Probe for support
-    xdp = cmd(cfg.rpath("xdp_helper") + ' - -', fail=False)
+    xdp = cmd(f'{cfg.test_dir / "xdp_helper"} - -', fail=False)
     if xdp.ret == 255:
         raise KsftSkipEx('AF_XDP unsupported')
     elif xdp.ret > 0:
         raise KsftFailEx('unable to create AF_XDP socket')
 
-    with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
+    with bkg(f'{cfg.test_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
              ksft_wait=3):
 
         rx = tx = False
-- 
2.49.0


