Return-Path: <netdev+bounces-93072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E08B9EC1
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF992281F4B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEF16D32C;
	Thu,  2 May 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JtbDK/Fi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7815E5A1
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667974; cv=none; b=Tc41gHBVMUuh5Ohxgad8CWV07wvVm50ifFh5fHpymKqe5gtiKtLy1ouIuHs8aobWIgc4mGDkS+hDrD/JLhkY5woITf7xQcmQsAdq34fPHYXh8vZFwYlg7y6QGLXb9plo3aprXs/z95oRdVd9JeF30NMpD3GKxL1+GdsCfgbAmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667974; c=relaxed/simple;
	bh=ON/MH5ojawv5201fqa/16BOtIzz0SosZ+xsld1be3K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJd7+BDYygDxNIgbG0muH5kNOv2YxbIqHNwxrIPOTn3JvtC2SJqwdp2h7Hc+61W58onc2cHc8HCAZFl59YjHu2fOqkO7zJf1edC9xRoMAmwioxuJkdC5TCU68bZcdPdO2P4U1nPpGgNRMh9NTnwsKQhcmf4wO5ZXsYPJMRCB7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JtbDK/Fi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so597516a91.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714667972; x=1715272772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcbiOSruuHd0h56qePNOk6APfRPoDfrP8AyXT9PO0w0=;
        b=JtbDK/Fi4dJk0kw1N9mbOjidEXQtmu89fMvv9oqKO1BF+E8MBcSgsihXMG9lpzGCx+
         g2wrVFy5mu0HSdrIBNx3mFHpcn5Q5Thzs5JQ4a7i+tEQS7iaKzH1idFdDCl78rl25Ln1
         rmiwsAzEToqeLWwYsVJncJape/LHONB9uTuShguVH+Jb+tbixYoYvXNsks7FrcYW1An0
         GYd57pVW39PJP/psHkpuHdhtcPtwo8EUZDNeShHcYSNkEBi43zJZtCw0OjsNShCD9109
         9tSGlV91HxLU7Tl+GACH8sDAYoReiqCJYMIrXDPxZRDNWE9POpRT3rgwijMPyG5bn7ta
         f2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667972; x=1715272772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcbiOSruuHd0h56qePNOk6APfRPoDfrP8AyXT9PO0w0=;
        b=uFa7LxUrbZaiUNWPQA14dv4FZwHq0Bdp8xcMYqcxtOjwmLfH3PZL1rytpl1cF0Er3p
         IzLPQwdx6z2WgA49Bi8GshanzB8Dqu/hX7Iv4qZGM3F+ZWvDwHMplMqio0A7O4Irj6Pi
         oPn/p8nUcKfXawVArha2pxisxnLQhM6U/oUi2hLCY2bq5Cd/KXDRwNFk8+iT4zEhCDBO
         d5TVWByvH1nUdsuuBftaQhNMffqJTwPiyVVridDfngOS8lGz5HpXCBIOLPjqFNsX4mJ6
         d1qrzF8FPZH8eoI8Jbbd/v6EQh4zYXzvmeeEMCDvSgj/Lxr+lR9RN/UVU1srMaQBqce6
         ju+A==
X-Gm-Message-State: AOJu0YzqjKrUiTvYRbaRR06iFEly3UetqBAFaeNRzfekaX1lv2U9uCTg
	5YhgBHhkfTyLowvbMXalFevm0Kj7BQkfsHJnBHg8WVNAawN42wbWcaB7Gxs1GCsTT/ZHb3EXis6
	+
X-Google-Smtp-Source: AGHT+IHw8felvpfgJ9vkYVg0hbsVc13vgIjp6l1+DBh6A7ooXK3gfsZSnxydx+c/NbIPCRaV6WTs9w==
X-Received: by 2002:a17:90a:4083:b0:2ab:a825:ae5 with SMTP id l3-20020a17090a408300b002aba8250ae5mr336123pjg.22.1714667972263;
        Thu, 02 May 2024 09:39:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id bg20-20020a17090b0d9400b002b297a49713sm3367614pjb.45.2024.05.02.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:39:31 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 2/2] net: selftest: add test for netdev netlink queue-get API
Date: Thu,  2 May 2024 09:39:28 -0700
Message-ID: <20240502163928.2478033-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502163928.2478033-1-dw@davidwei.uk>
References: <20240502163928.2478033-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for netdev generic netlink. For now there is only a
single test that exercises the `queue-get` API.

The test works with netdevsim by default or with a real device by
setting NETIF.

Add a timeout param to cmd() since ethtool -L can take a long time on
real devices.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 .../selftests/drivers/net/lib/py/env.py       |  6 +-
 tools/testing/selftests/drivers/net/queues.py | 66 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/nsim.py    |  4 +-
 tools/testing/selftests/net/lib/py/utils.py   |  8 +--
 5 files changed, 77 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 754ec643768a..e54f382bcb02 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -4,6 +4,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py)
 
 TEST_PROGS := \
 	ping.py \
+	queues.py \
 	stats.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 5c8f695b2536..edcedd7bffab 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -36,7 +36,7 @@ class NetDrvEnv:
     """
     Class for a single NIC / host env, with no remote end
     """
-    def __init__(self, src_path):
+    def __init__(self, src_path, **kwargs):
         self._ns = None
 
         self.env = _load_env_file(src_path)
@@ -44,11 +44,13 @@ class NetDrvEnv:
         if 'NETIF' in self.env:
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
         else:
-            self._ns = NetdevSimDev()
+            self._ns = NetdevSimDev(**kwargs)
             self.dev = self._ns.nsims[0].dev
         self.ifindex = self.dev['ifindex']
 
     def __enter__(self):
+        ip(f"link set dev {self.dev['ifname']} up")
+
         return self
 
     def __exit__(self, ex_type, ex_value, ex_tb):
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
new file mode 100755
index 000000000000..30f29096e27c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, KsftSkipEx
+from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import NetDrvEnv
+from lib.py import cmd
+import glob
+
+
+def sys_get_queues(ifname) -> int:
+    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
+    return len(folders)
+
+
+def nl_get_queues(cfg, nl):
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if queues:
+        return len([q for q in queues if q['type'] == 'rx'])
+    return None
+
+
+def get_queues(cfg, nl) -> None:
+    queues = nl_get_queues(cfg, nl)
+    if not queues:
+        raise KsftSkipEx('queue-get not supported by device')
+
+    expected = sys_get_queues(cfg.dev['ifname'])
+    ksft_eq(queues, expected)
+
+
+def addremove_queues(cfg, nl) -> None:
+    queues = nl_get_queues(cfg, nl)
+    if not queues:
+        raise KsftSkipEx('queue-get not supported by device')
+
+    curr_queues = sys_get_queues(cfg.dev['ifname'])
+    if curr_queues == 1:
+        raise KsftSkipEx('cannot decrement queue: already at 1')
+
+    netnl = EthtoolFamily()
+    channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    if channels['combined-count'] == 0:
+        rx_type = 'rx'
+    else:
+        rx_type = 'combined'
+
+    expected = curr_queues - 1
+    cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
+    queues = nl_get_queues(cfg, nl)
+    ksft_eq(queues, expected)
+
+    expected = curr_queues
+    cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
+    queues = nl_get_queues(cfg, nl)
+    ksft_eq(queues, expected)
+
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=3) as cfg:
+        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 06896cdf7c18..f571a8b3139b 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -49,7 +49,7 @@ class NetdevSimDev:
         with open(fullpath, "w") as f:
             f.write(val)
 
-    def __init__(self, port_count=1, ns=None):
+    def __init__(self, port_count=1, queue_count=1, ns=None):
         # nsim will spawn in init_net, we'll set to actual ns once we switch it there
         self.ns = None
 
@@ -59,7 +59,7 @@ class NetdevSimDev:
         addr = random.randrange(1 << 15)
         while True:
             try:
-                self.ctrl_write("new_device", "%u %u" % (addr, port_count))
+                self.ctrl_write("new_device", "%u %u %u" % (addr, port_count, queue_count))
             except OSError as e:
                 if e.errno == errno.ENOSPC:
                     addr = random.randrange(1 << 15)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index b57d467afd0f..0916d175f332 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -8,7 +8,7 @@ import time
 
 
 class cmd:
-    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
+    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
@@ -23,12 +23,12 @@ class cmd:
             self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
                                          stderr=subprocess.PIPE)
         if not background:
-            self.process(terminate=False, fail=fail)
+            self.process(terminate=False, fail=fail, timeout=timeout)
 
-    def process(self, terminate=True, fail=None):
+    def process(self, terminate=True, fail=None, timeout=5):
         if terminate:
             self.proc.terminate()
-        stdout, stderr = self.proc.communicate(timeout=5)
+        stdout, stderr = self.proc.communicate(timeout)
         self.stdout = stdout.decode("utf-8")
         self.stderr = stderr.decode("utf-8")
         self.proc.stdout.close()
-- 
2.43.0


