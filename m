Return-Path: <netdev+bounces-89756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A888AB719
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2E1F21CFD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177FF13D2A0;
	Fri, 19 Apr 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FwTvDyQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4713D27E
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564552; cv=none; b=rU4i1maRbb3bASDcFLKIJc9iB2rPQgrDIbYmKymMJQaWFgevL3w6AJmuj5FIVs8RH04fFHwKHY8xvXAXOHeLTPSZMl/KQVkiC5yWaHEPM+Ubt5NHjw3e9gl+WuDTOG7pnRiZzNbx+ZM+eBCeLxO0EzdCbUQc6rT7ck0gF1tvcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564552; c=relaxed/simple;
	bh=oLndSq323RJoUUBeJVwHK+wXtjHYOY899IcoV3L480Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEQznNg1Y52YH49NtcYHa1o5QBwmr5lNtCtdfqgC2kv6vXH1LbiaXGbNvhEfsT4dDaiqHZOczc389W/V+FNY1BnfeKdlSyIR2znVh0lMKjpltvhgq9UQiLxZkuOjvLCuLL6JUWNPbF/ApWZt3SNivft7WadlDSqpACqcGMNCFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FwTvDyQu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e834159f40so20663865ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713564549; x=1714169349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9clNm/2TNh3Cld8MNKIvS2XoVk57beqrqIb9UVvUVGU=;
        b=FwTvDyQuAmkuM5nG7RYl8EAMlb6bhC96LfdQz9rin9mF7qjTlaeSX9aU1j7CY9ShzC
         M41lhH+Tu/c361lDfLlpbF2GyHYiNGuPaDVXHhKKLq0KDwl9vmzl6E6uhdmHb/teykAp
         O/Ix3qTSOATfXML+0lLt4oLK0LfsKCYXvGLRvS/j6orShS46Z2ixpWXWPEOKUzR+i8nj
         uJEeW2bxEWhwpe65wcm11vJdyAtPMaifmZH7lD9fizRe3xKienlb7OWRp6KZDPop45Nc
         Nq0cJhKuWhyatXcIuIHQBwZ5x6RHizB6JlbAVbPEjWiGOaUqwyzBKSMlnDhfDbGZ0JSB
         MBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564549; x=1714169349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9clNm/2TNh3Cld8MNKIvS2XoVk57beqrqIb9UVvUVGU=;
        b=b1K5z72aPE1gppn6ugq4AMOBcyK4JF8cy03OjT2Qf/CBBkVg0NA06SFwezcxAKIVNO
         zfZ6WXApvIBPyrEpEujy2s2SgaAUyAmf9bsu7mGiSY2vPxPxfdfPUx3v4GxHALmtXvRG
         s47M9OgC8n+8jjOlw1mxkh9qOQsgX5q2wqmXCRNeQVdUouO/bWO1emcGDmcGUupLEysR
         xShgvz14r4g9g3PYE961pKIbkicP9ct/H76POqvFBq31Xc0u7tZAq0eJM9ckWoU6K7+m
         PRLczfU9uDwksqrqWWT81vnqvKcuH3EOuWrsyugtvrrM8CON2VEylU/S4eu3lEmMokFJ
         30wA==
X-Gm-Message-State: AOJu0YwDRQN0eh4YeEBWVeYDt2JUyGnmB2PEFCdiOB7zkpuh2e8755Aj
	OU2+jAe8ahJTfaR7N9yUpeaWCap/aCppENS39gHpuuWK46CLd+WQGQLIp8J18rxtA5JIvqrJstd
	e
X-Google-Smtp-Source: AGHT+IHNyu6x6adKlggRRNpdWO/K5I2/6vzq4Otc1vpvcBTXKZAojFZrSj+hczesdHTGfEYgSYSNRA==
X-Received: by 2002:a17:902:9a46:b0:1e4:4000:a576 with SMTP id x6-20020a1709029a4600b001e44000a576mr3214483plv.43.1713564549474;
        Fri, 19 Apr 2024 15:09:09 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e5e6877494sm3924299plk.238.2024.04.19.15.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:09:09 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] net: selftest: add test for netdev netlink queue-get API
Date: Fri, 19 Apr 2024 15:08:57 -0700
Message-ID: <20240419220857.2065615-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419220857.2065615-1-dw@davidwei.uk>
References: <20240419220857.2065615-1-dw@davidwei.uk>
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

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 .../selftests/drivers/net/lib/py/env.py       |  6 +-
 tools/testing/selftests/drivers/net/queues.py | 59 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/nsim.py    |  4 +-
 4 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 379cdb1960a7..118a73650dbc 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -3,5 +3,6 @@
 TEST_INCLUDES := $(wildcard lib/py/*.py)
 
 TEST_PROGS := stats.py
+TEST_PROGS += queues.py
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index e1abe9491daf..0ac4e9e6cd84 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -7,7 +7,7 @@ from lib.py import ip
 from lib.py import NetdevSimDev
 
 class NetDrvEnv:
-    def __init__(self, src_path):
+    def __init__(self, src_path, **kwargs):
         self._ns = None
 
         self.env = os.environ.copy()
@@ -16,11 +16,13 @@ class NetDrvEnv:
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
index 000000000000..c23cd5a932cb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -0,0 +1,59 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_eq, KsftSkipEx
+from lib.py import NetdevFamily
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
+        raise KsftSkipEx("queue-get not supported by device")
+
+    expected = sys_get_queues(cfg.dev['ifname'])
+    ksft_eq(queues, expected)
+
+
+def addremove_queues(cfg, nl) -> None:
+    queues = nl_get_queues(cfg, nl)
+    if not queues:
+        raise KsftSkipEx("queue-get not supported by device")
+
+    expected = sys_get_queues(cfg.dev['ifname'])
+    ksft_eq(queues, expected)
+
+    # reduce queue count by 1
+    expected = expected - 1
+    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
+    queues = nl_get_queues(cfg, nl)
+    ksft_eq(queues, expected)
+
+    # increase queue count by 1
+    expected = expected + 1
+    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
+    queues = nl_get_queues(cfg, nl)
+    ksft_eq(queues, expected)
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
-- 
2.43.0


