Return-Path: <netdev+bounces-88181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2628A62E6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D29C1C22829
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90F3B293;
	Tue, 16 Apr 2024 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jO52yfZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020E39FD7
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244540; cv=none; b=kSK9Rr/civElztpUs7VrJi6L3qsjr8Ab/by1FFqgYIOJGhnRvhePwATC8zaWWagYG3wGTeLcPdhYsYrkbnvweA3KS90EM7v3dmbr350HGlq9JPVuJgqbwwDjQLoAup7FR1Ez/zcPGjH5ju2K20Mwib8JMv9JqkO+BP7T+up5TNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244540; c=relaxed/simple;
	bh=MfwabN8GFP7uKl9lFa9vQpoQpqTIW8cOwoTzIhU/Nbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YocwnV1qxO039fiIzovKHvb0QzdBKxZnfcfftGTyto99w6PqMC1Y36MWWZiUm1BJe3Xz3oEgEqyd3rHMyiDRsPvGe8NaEID45Nu/WnGGeLn2KGpQalszwuW/l0ubBU5mA9WQRW0DceI1u3aiQ145eKXCZ6YiO5/cZPK+nAabbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jO52yfZw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f00f24f761so1153541b3a.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713244538; x=1713849338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PQb3BpYqjMgrRgLh2qbIFgqXM+Ujv0wGjlr43ONtBo=;
        b=jO52yfZwPz3EY44Tu2Fu2W3hk+SNvFp6CnMCkiwNSk+KPBet2NfJ5oiWazqC/X4mqV
         n946ORpJ3kBL2F9OgxMNNiQP4PvW6+I1QwJW3lRYo6UeL46u/KWmRlsIjqa1xawg3PJO
         t4ZUQqRoij5+Gzt5pgds0Ovw3tpgK8yW276J+7DiDSiyXh86rgM30TjGuiC+NnxfU8nF
         XKdEJpoNbOZfnPW7MSHBoEIavdQv1y8PygL9fLnQHf44FFfHwLx6tZLcylu6+8UWmIb6
         pJkvjYbdD7ZgFQp7NHs1HSgxUop3WjhE6d9gewdPBWocpLD3xoc4tGmKz7ThPq/JeXZa
         GeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713244538; x=1713849338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PQb3BpYqjMgrRgLh2qbIFgqXM+Ujv0wGjlr43ONtBo=;
        b=Wg6N9+kT5gCEOfQsXv/18Z+/vCfai9dUaZB43fNe6rQMk7XjTOPsk9/xSmrwStE9MP
         5G1btPrTvrXXVboTBTTIOQsEA+IUuNybkkr9DMh3Khn2lq7WxX4qanaujiifm9EsOIx6
         H0z7na6eyrzWvrmlHQ/cYVfJQStzmBtdbDImjN6lVRu0Tdf98Rt9gwb3kbAcKDtKws/n
         W+oC4Axrw4GpHn9ByvVkH6LELSeD+eWCCVoCS5v73S5k7XUPEihAZJbNr8VFC+8wHq5A
         X5H45Tb0LX4pWIVFSteKjbkNS8CK34YWzDvZL4sGSQ11sGHd7kqMqKOAvGOZCDiMQcxB
         lxTg==
X-Gm-Message-State: AOJu0YzlkwZSde0CtDlXoWOkGWwtTTXNDD/ZMAqLq4U8y5+ZzeofqzwS
	EmkMMaRV93haPPeVzt3t2WTvQCDvY5apLEa+dyYpbyje0mT7ChBD/pQys7HMIGBTAVRqeJuw1U2
	Z
X-Google-Smtp-Source: AGHT+IF4x9YGe/V9dwrNflwFglCEL0X8iiSf2E99rJwndlrTg0h/IO0SmkktMD7qe4sHhiZmUKJmkA==
X-Received: by 2002:a05:6a00:10cc:b0:6ed:6b11:4076 with SMTP id d12-20020a056a0010cc00b006ed6b114076mr11660612pfu.12.1713244537752;
        Mon, 15 Apr 2024 22:15:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id b22-20020a056a000cd600b006ead792b6f2sm8154944pfv.1.2024.04.15.22.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 22:15:37 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1 2/2] net: selftest: add test for netdev netlink queue-get API
Date: Mon, 15 Apr 2024 22:15:27 -0700
Message-ID: <20240416051527.1657233-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416051527.1657233-1-dw@davidwei.uk>
References: <20240416051527.1657233-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for Netdev Netlink queue-get API. The ground truth is
determined by sysfs.

The test works with netdevsim by default or with a real device by
setting NETIF.

Minor changes to NetdevSimDev to accept the number of queues to create
per port and pass through NetdevSimDev args in NetDrvEnv ctor.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 .../selftests/drivers/net/lib/py/env.py       | 10 ++-
 tools/testing/selftests/drivers/net/queues.py | 67 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/nsim.py    |  4 +-
 4 files changed, 78 insertions(+), 4 deletions(-)
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
index e1abe9491daf..7187aca5c516 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -7,7 +7,7 @@ from lib.py import ip
 from lib.py import NetdevSimDev
 
 class NetDrvEnv:
-    def __init__(self, src_path):
+    def __init__(self, src_path, **kwargs):
         self._ns = None
 
         self.env = os.environ.copy()
@@ -16,7 +16,7 @@ class NetDrvEnv:
         if 'NETIF' in self.env:
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
         else:
-            self._ns = NetdevSimDev()
+            self._ns = NetdevSimDev(**kwargs)
             self.dev = self._ns.nsims[0].dev
         self.ifindex = self.dev['ifindex']
 
@@ -50,3 +50,9 @@ class NetDrvEnv:
             else:
                 self.env[k] = token
                 k = None
+
+    def dev_up(self):
+        ip(f"link set dev {self.dev['ifname']} up")
+
+    def dev_down(self):
+        ip(f"link set dev {self.dev['ifname']} down")
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
new file mode 100755
index 000000000000..de2820f2759a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_in, ksft_true, ksft_eq, KsftSkipEx, KsftXfailEx
+from lib.py import NetdevFamily, NlError
+from lib.py import NetDrvEnv
+from lib.py import cmd
+import glob
+
+netnl = NetdevFamily()
+
+
+def sys_get_queues(ifname) -> int:
+    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
+    return len(folders)
+
+
+def nl_get_queues(cfg):
+    global netnl
+    queues = netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if queues:
+        return len([q for q in queues if q['type'] == 'rx'])
+    return None
+
+
+def get_queues(cfg) -> None:
+    global netnl
+
+    queues = nl_get_queues(cfg)
+    if not queues:
+        raise KsftSkipEx("queue-get not supported by device")
+
+    expected = sys_get_queues(cfg.dev['ifname'])
+    ksft_eq(queues, expected)
+
+
+def addremove_queues(cfg) -> None:
+    global netnl
+
+    queues = nl_get_queues(cfg)
+    if not queues:
+        raise KsftSkipEx("queue-get not supported by device")
+
+    expected = sys_get_queues(cfg.dev['ifname'])
+    ksft_eq(queues, expected)
+
+    # reduce queue count by 1
+    expected = expected - 1
+    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
+    queues = nl_get_queues(cfg)
+    ksft_eq(queues, expected)
+
+    # increase queue count by 1
+    expected = expected + 1
+    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
+    queues = nl_get_queues(cfg)
+    ksft_eq(queues, expected)
+
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=3) as cfg:
+        cfg.dev_up()
+        ksft_run([get_queues, addremove_queues], args=(cfg, ))
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


