Return-Path: <netdev+bounces-94187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F848BE93D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370BE2903EF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844C16F8E4;
	Tue,  7 May 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nQ/gX/8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9816F851
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099554; cv=none; b=EJwW8g+Yat6PaGjNle8wCMDJYqJAuFT44a5RkG7WTXpw+uqD/IsjPKh6tn1M7qy5l+fA0AyRnlzvih1DLZh69Suo6EVEMcu3kl4T8gEmyVlAiCk6fKLjLf5VmdhToUM/6E8FKzxy/OXcbzL0mkf6cOavcOO+djSJz5tjk7Qy3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099554; c=relaxed/simple;
	bh=UUbwjC06ydMUThmfLke5UqCxz3WioE1USPt/gNQP5G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoVBe3nL4i4C892tIOamc21fzCeV/l02DXNxnc3bjrC9aZgkk3NoA3gn38Ccz6QHRF6gBAMKrYTwdsNNo0P7SkkFg/pvX39lfvyaYXvNdScZxwrODcCG+i+6CzX1vjLn85Bpgv5DCO1pp7c69p+Ubr++QOBgSshWVeMn6IdJH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nQ/gX/8d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed41eb3382so25521335ad.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715099552; x=1715704352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzVluPZwY4o12XY1NGzLY1jCjJTusSE0x10/Z+FwuqA=;
        b=nQ/gX/8dRTf4AQItT8yqp/Sl6BU7KGWq3ZPtdWDt7+I8sDWSKr1ybv624U9kEhOdfG
         bu+NEn639IBqp2WXtM9eXt0JcRdoklFmNAvyRC7riJnNkadbkJlK3/mSQZwrBdk4ShjQ
         NBTbc3rwRy4fz5bi3uRh8j5eycEKi+bgsxnbJXwwTv+Ay5vEq0vNGfLYORlE8X7w7MGo
         uvNOLCOydmLmogGa4OzVcmRal+r/cxOt4rIATcpMsHZRCZ3z63ZFqu3R+r1AXVrkfFY5
         TfqfZhLjYA2OVGp87d/zAdaPaRggla1PUdRbHWD9/Bsl4tPQvayrfKPUpGyBnJ+ECxdM
         hUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099552; x=1715704352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzVluPZwY4o12XY1NGzLY1jCjJTusSE0x10/Z+FwuqA=;
        b=JVMBWV0k012EU7UpvpjLHah1skOYh+pwemyISmGPi7AUiCpTDrlOFKFeI9wu1L/R5o
         F2N5k1mHyqLy7LzK0ozTwvlVQakb4iqYDPB07vSt8C5QDMrlTdfMQBwdFQFXjgUuqceP
         Qt7AEofBrP/Z9rmXxQjbRe1JXBGDaYiXjdA7PbgFGnZjxX/QzWbyW5U0NPjBE8Laaz88
         L5nKE6Io8/n86YT+mgL0XpfvWfk3MHBQXwq9WJWeKaWZst+cgmnIUSZmTxi8nzNj3oNe
         ua4GEWlHuCNbv34ALNEL9F9eysDXcObU+pYJh3TvVKQ1tLCJk7kljG397lUdvEftgaqs
         yXTg==
X-Gm-Message-State: AOJu0YwkL+WuMXCzNMt7UqbvBDy4P956V6b6iyUiW8qnEpkBb06wfwrM
	U7nWEbfc6iRR/rijOqO/L/VXTf8C1kZbVwSGz0A5cgBz3TjRMYub1WpzKoksqbFA9s+41ig4iBt
	U
X-Google-Smtp-Source: AGHT+IEXax2NN2bwPhuHSmgEAyb9TWX+hKZ5ynvIEbSrnEvNo1LZ2Eu/zZCyO6jJfZGca/1BQCoaOg==
X-Received: by 2002:a17:902:f54c:b0:1e5:1158:74f6 with SMTP id d9443c01a7336-1eeb089c226mr1486905ad.66.1715099552062;
        Tue, 07 May 2024 09:32:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b001e853d9bb42sm10206699plh.196.2024.05.07.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:32:31 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 2/2] net: selftest: add test for netdev netlink queue-get API
Date: Tue,  7 May 2024 09:32:28 -0700
Message-ID: <20240507163228.2066817-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507163228.2066817-1-dw@davidwei.uk>
References: <20240507163228.2066817-1-dw@davidwei.uk>
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
index ec8b086b4fcb..0540ea24921d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -8,7 +8,7 @@ import time
 
 
 class cmd:
-    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
+    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
@@ -23,15 +23,15 @@ class cmd:
             self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
                                          stderr=subprocess.PIPE)
         if not background:
-            self.process(terminate=False, fail=fail)
+            self.process(terminate=False, fail=fail, timeout=timeout)
 
-    def process(self, terminate=True, fail=None):
+    def process(self, terminate=True, fail=None, timeout=5):
         if fail is None:
             fail = not terminate
 
         if terminate:
             self.proc.terminate()
-        stdout, stderr = self.proc.communicate(timeout=5)
+        stdout, stderr = self.proc.communicate(timeout)
         self.stdout = stdout.decode("utf-8")
         self.stderr = stderr.decode("utf-8")
         self.proc.stdout.close()
-- 
2.43.0


