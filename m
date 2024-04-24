Return-Path: <netdev+bounces-90755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC08AFE8B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FE9B22FE7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432684D1F;
	Wed, 24 Apr 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="h3PbPSMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C4824B7
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926201; cv=none; b=X4t/QigRI7TBB/8jTurma2jYLfCemFXDEEmdw3UBWhEMwVtlFlAxcY37ntIyndvDhP0+QwI50oSJBWfGPEh9ykXRSgEWWHJdV4Nae70Yjg8ZeWw19L43yYUbvrhzycoM45fTeamKNsr3CrXVxgAQ3Cem3ucnlTPT5I2bfzspdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926201; c=relaxed/simple;
	bh=1THUEo3G247e7zefG3pfowffe5NPoT3M7vHYZfTIjig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjwP0fDlz+0crOi0OLw17liiUMSgMshsYKEVb6CxJqyoWACj26LHSTjZcnM+C0D4w7lgTeteB67wTwqIxamzFQ2jtetaCjOZQlhcZZJymzefhXCm5gu+nigfSqFrcqWn/izvjCS7ZprnyNYQBil7FKhBKB/scvdz8+QcO7VZ5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=h3PbPSMB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e834159f40so47592665ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713926200; x=1714531000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwRv/cL5AZ4D8xI7gB67bfsoOnSIpMFEJN97WAr9HMI=;
        b=h3PbPSMBCKcLTMhH+L0lDT4YesCCYcLDyEegAzMXvogpjW8I2poylSkNSp95DMxgEn
         +gk9VKouR9Mbh+7GomuqUV9GE4aBpQuuxkWYfqdDc9HW/cPpouWrogjKJ3PQD7tIs3Fk
         CXgjpfGBVjmRcTa5fxtMo1BJw7tQmoj3TJLzKOcMMG6e1jvaWiT+DYJAkZi9zBvAeTmU
         0AUTvRh9Rp464HwlXA6FjtoOzXPrJR2roNvpPGKfNahqX7KjmDNEU+INSi8lGUjjz7aM
         znMXkpsFB1NwpkGtBHEbnivNxfwvPiwrafyx+c9f4ftqo5ME50vS+pC0Qw6OT+ZHLloY
         i55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926200; x=1714531000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwRv/cL5AZ4D8xI7gB67bfsoOnSIpMFEJN97WAr9HMI=;
        b=lKjSX0C6V09b9w9L2XeLJxFZp74FyBaE0nS+VaNvGRgQ1jTY4kj0YydwQvY80Wq26b
         leZcgyAEP7bcVd5EG7uz6aNNpGNxhVyOLbgA/lO0xP/d9Ow72mpG2scrcThujlcESuVR
         1jxILRYjf9Yhb6BULKp+ANOYHokRwo1J1iCIrq9K7xWatmrDAZ64eywxPEtMbQYcQS1F
         PQgyTrCLNODpNEueBCtJaicDE9giDKCVgfUEsP1ofwJmAen2oW4ENK9Ci+QBgjOvZfrn
         3/C7wcCdEmGb+c+gmzfZb+OnOUk3tOsQcIAeYYgQ3vUWV4RSoeTH4sfzmvmk0zUN4taw
         vQPg==
X-Gm-Message-State: AOJu0Yz1qBqISOSHEqn56J1ohuJICRE6wM0FIj4bdSNoQuSCxO5q4PZ7
	gMMdg9Mu5l/80DEbXrMfeGE8GHEC+1ch0qyrJbylJ6Fvf6xKjl1v3abKVNXxiSJfG0PZflwhGkd
	b
X-Google-Smtp-Source: AGHT+IH8MeBb0O6bUzbe4AjozeHyQve8QpV6EKKSSbmFHvqiQuy7yUQAnSuT+LWXlDtUMFLEowlJ+w==
X-Received: by 2002:a17:902:b18e:b0:1e2:3d05:5f4c with SMTP id s14-20020a170902b18e00b001e23d055f4cmr1175890plr.39.1713926199554;
        Tue, 23 Apr 2024 19:36:39 -0700 (PDT)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm10690294plt.287.2024.04.23.19.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:36:39 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 2/2] net: selftest: add test for netdev netlink queue-get API
Date: Tue, 23 Apr 2024 19:36:24 -0700
Message-ID: <20240424023624.2320033-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424023624.2320033-1-dw@davidwei.uk>
References: <20240424023624.2320033-1-dw@davidwei.uk>
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
index a3db1bb1afeb..04702b2298f9 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -34,7 +34,7 @@ class NetDrvEnv:
     """
     Class for a single NIC / host env, with no remote end
     """
-    def __init__(self, src_path):
+    def __init__(self, src_path, **kwargs):
         self._ns = None
 
         self.env = _load_env_file(src_path)
@@ -42,11 +42,13 @@ class NetDrvEnv:
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
index 000000000000..35e5073bd1f9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_eq, KsftSkipEx
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
+    try:
+        expected = curr_queues - 1
+        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
+        queues = nl_get_queues(cfg, nl)
+        if not queues:
+            raise KsftSkipEx('queue-get not supported by device')
+        ksft_eq(queues, expected)
+
+        expected = curr_queues
+        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
+        queues = nl_get_queues(cfg, nl)
+        ksft_eq(queues, expected)
+    except Exception as ex:
+        raise KsftSkipEx(ex)
+
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=3) as cfg:
+        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
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
index d3715e6c21f2..77e4f5a00eda 100644
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


