Return-Path: <netdev+bounces-163799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F6A2B97A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3226C164F04
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E818DB14;
	Fri,  7 Feb 2025 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ro0LhLYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69918C91F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897792; cv=none; b=fLoasBjwGHPCUtGi0/odBWnJgdyevoC4LPKjVJQVxWCk9yExso9zVZKJNPqc2QH8p5YFCOSqorZ/57/Ad29cK3nSAe04TUpw3zJRSvPO3hPxvgOase82N6W4EneYuqLPBxa0bYXab5FytBlDh6fbsKGCB/eOlSiRC2fp/352Fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897792; c=relaxed/simple;
	bh=TmFrieKafs0y9qgWW4DLzVPuAlNlJxW158B1qIqoulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Sh8Lga/PW9zktw6rnWTYqjTY23anhggXLNQFj0e2sPv0mnheMUo0CvY3v5vcbL6ih/p0803pPkaXjR9x/w9Bm3RSg1i6t1ENDB3QFnKPUBS8czUY1SvNtmcli0Q8Yop9Pozx+ulltMSlX1fhX6tmnZwhmSn7tZhqzhZ+iXim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ro0LhLYG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa2c456816so34757a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738897789; x=1739502589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7RUZIqHwLPt1JPkc0hYqOZYvl0G8thAspfJu2yEGWI=;
        b=ro0LhLYGYhuzHAu/hNKV84xL1bFap2uUJXzsNfNRVLTFYRZwarmHfbdLqqXMt/E0YS
         Uf81+eq8lqLvIUOlf5yQ69S0TQiNyOx7UQBq3w/7Oc6VyNpV2TW0RhZr2+FoTmpUbev0
         DO2hVT7JH5LIjT2lHGD3CbpO9vCipb/DlUsQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897789; x=1739502589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7RUZIqHwLPt1JPkc0hYqOZYvl0G8thAspfJu2yEGWI=;
        b=WXwbhyOgYh57kAAAOrar197uQYFG/RkSw6BBoDKwfy9+KEZlk0TxrvCU8SJy5Khp7s
         B7pqsAQkgTZwveRiGI1X4iuYMysiBHb8m1Z3PYnlwwz/fPD242nciDqHcWHlTopF0db5
         K5R/A3A9SdWJ7Nf7PUYL2Era8UlYj9USp3cj6WsM2/y1PP0D5bKd0DVC4leHiIqKW8FT
         T1yDeNV51NxV7ppiZkCNhv0VoBh19YooRdJ8cDLTNFv/SVyWGZE5IQmhpPYhSkGUQcYI
         A3xrrRKJZGMEuaXS/VkDVlJYAmcTkNy7f3Tp7DTgmOTcCjpIUmHsj/C/i7a3axvJOoQz
         7Z5A==
X-Gm-Message-State: AOJu0YyA2R9bOtJEFUquVDq+d1wH0kXMahUsIno8NlAViTt/ukKUcwiz
	qs0o0e31POV2nIqeKYDTQxDnLOO06lxvGrIy6HV3qwhyyop/uakMiA6WdHlyTM1HTnDDuuHBgU1
	dV7rAJz45fUaZvogofPaEK70g7UUeuEH4tCXY0kA/vL0KoY1flMpUzz9lB+qt82q9CWKmkOrAFJ
	FMx9hCZ83/o8DGY7YUgwpJN411GWp8b3uxCIA=
X-Gm-Gg: ASbGncviCQgmv94WJRt/+M+Yszc1CTxrDLMnvpmFD6R02aItfTq3nMR5ZH1Bz0kVxjp
	ugt+App5HNOnfQf0Ov6mF2egdLp5V50uLOQYiMLQHxAkPPxHPbRl1hJ1+k157PVQdoLvBTb4hIj
	G70HSKq3YETYiZwXGcUT+jZ3dou/TCfLO0XuMk6jxAgbRpI31vvLT/Sxw0LKgtofhDAMz0Be1H9
	I5QLy1pxL5WVSlfXiZmfSxcsbzM3yrZCCcwzwCOGGDsRFOWwFSroLkllO6tZqsO5A6vnbuUXebW
	qPntDixT7zdGwkBYaZ5XvCs=
X-Google-Smtp-Source: AGHT+IE/mTf+RgI6SASTcTKQhP0AQNPSWXueq68RE7gGuzT1ocUjhsKBGM/Nermff6/ehihz9yHN/g==
X-Received: by 2002:a17:90b:234e:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-2fa24175d44mr2496123a91.20.1738897788831;
        Thu, 06 Feb 2025 19:09:48 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368ab196sm20348955ad.222.2025.02.06.19.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:09:48 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v4 3/3] selftests: drv-net: Test queue xsk attribute
Date: Fri,  7 Feb 2025 03:08:55 +0000
Message-ID: <20250207030916.32751-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207030916.32751-1-jdamato@fastly.com>
References: <20250207030916.32751-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that queues which are used for AF_XDP have the xsk nest attribute.
The attribute is currently empty, but its existence means the AF_XDP is
being used for the queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v3:
   - Change comment style of helper C program to avoid kdoc warnings as
     suggested by Jakub. No other changes.

 v2:
   - Updated the Python test after changes to patch 1 which expose an
     empty nest
   - Updated Python test with general Python coding feedback

 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 4 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..ec746f374e85
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index c7f1c443f2af..81961c6e059d 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,10 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 $(wildcard lib/sh/*.sh) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
+TEST_GEN_PROGS := xdp_helper
+
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..55c2b296ad3c 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -8,7 +8,10 @@ from lib.py import NetDrvEnv
 from lib.py import cmd, defer, ip
 import errno
 import glob
-
+import os
+import socket
+import struct
+import subprocess
 
 def sys_get_queues(ifname, qtype='rx') -> int:
     folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
@@ -21,6 +24,34 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None
 
+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+    defer(xdp.kill)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if not queues:
+        raise KsftSkipEx("Netlink reports no queues")
+
+    for q in queues:
+        if q['id'] == 0:
+            if q['type'] == 'rx':
+                rx = True
+            if q['type'] == 'tx':
+                tx = True
+
+            ksft_eq(q['xsk'], {})
+        else:
+            if 'xsk' in q:
+                _fail("Check failed: xsk attribute set.")
+
+    ksft_eq(rx, True)
+    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
@@ -81,7 +112,7 @@ def check_down(cfg, nl) -> None:
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..b04d4e0ea30a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <linux/if_xdp.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include <inttypes.h>
+
+#define UMEM_SZ (1U << 16)
+#define NUM_DESC (UMEM_SZ / 2048)
+
+/* this is a simple helper program that creates an XDP socket and does the
+ * minimum necessary to get bind() to succeed.
+ *
+ * this test program is not intended to actually process packets, but could be
+ * extended in the future if that is actually needed.
+ *
+ * it is used by queues.py to ensure the xsk netlinux attribute is set
+ * correctly.
+ */
+int main(int argc, char **argv)
+{
+	struct xdp_umem_reg umem_reg = { 0 };
+	struct sockaddr_xdp sxdp = { 0 };
+	int num_desc = NUM_DESC;
+	void *umem_area;
+	int ifindex;
+	int sock_fd;
+	int queue;
+	char byte;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
+		return 1;
+	}
+
+	sock_fd = socket(AF_XDP, SOCK_RAW, 0);
+	if (sock_fd < 0) {
+		perror("socket creation failed");
+		return 1;
+	}
+
+	ifindex = atoi(argv[1]);
+	queue = atoi(argv[2]);
+
+	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			MAP_ANONYMOUS, -1, 0);
+	if (umem_area == MAP_FAILED)
+		return -1;
+
+	umem_reg.addr = (uintptr_t)umem_area;
+	umem_reg.len = UMEM_SZ;
+	umem_reg.chunk_size = 2048;
+	umem_reg.headroom = 0;
+
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_REG, &umem_reg,
+		   sizeof(umem_reg));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_FILL_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_RX_RING, &num_desc, sizeof(num_desc));
+
+	sxdp.sxdp_family = AF_XDP;
+	sxdp.sxdp_ifindex = ifindex;
+	sxdp.sxdp_queue_id = queue;
+	sxdp.sxdp_flags = 0;
+
+	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
+		perror("bind failed");
+		close(sock_fd);
+		return 1;
+	}
+
+	/* give the parent program some data when the socket is ready*/
+	fprintf(stdout, "%d\n", sock_fd);
+
+	/* parent program will write a byte to stdin when its ready for this
+	 * helper to exit
+	 */
+	read(STDIN_FILENO, &byte, 1);
+
+	close(sock_fd);
+	return 0;
+}
-- 
2.43.0


