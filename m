Return-Path: <netdev+bounces-164286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B82A2D3B1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B9416CAB7
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED81A8F93;
	Sat,  8 Feb 2025 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vXTumveD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAF1A5B9D
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988086; cv=none; b=C9jkaKLBOEmrLLUuyYrKSY2v+feM0IFQDl9yiLk4j9oZW88CCOgaD+vdqBj7Kqo4LHEYnOE0ZBe3E/49Q01Z36ec8Eo/8wuMaEIsAamedCzCIYKDGzFILLmXWn9Ar9JHQmyF8e3nX2cVx1nX9+d93Kchmqy0r6bUswtTAMuw2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988086; c=relaxed/simple;
	bh=TmFrieKafs0y9qgWW4DLzVPuAlNlJxW158B1qIqoulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SREMq5kAcW1HrAfbSztiIFdTk7AL0pbSRrtltyWr04J07VHWiH9E32lTeyDi+ChbCtNAnTXvendaQpvPiDnojD1Tt9DEXVbVKYpgMf//bESReEz36iTHOqMBVXAEENHoPLOaYnGMNHfdNxu4OUWXqE4F2cS7wQDTyjSFVYB9i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vXTumveD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f6f18b474so1386285ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 20:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738988082; x=1739592882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7RUZIqHwLPt1JPkc0hYqOZYvl0G8thAspfJu2yEGWI=;
        b=vXTumveDPV5D/h+W7pYAN4DirQaTAJqKXexuJu0+2+bNKw52aeL5aPrZSHgHnVaBBa
         n1XPnJNl1/jDz7gkji+zYZA08NA6k8vBVs+fJY/+0Us2fjF5b1NDRE49lhI/saHxzl/0
         6cix2VhcDW6fY2mfFaTQEMxDt/ATstN3EJIYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738988082; x=1739592882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7RUZIqHwLPt1JPkc0hYqOZYvl0G8thAspfJu2yEGWI=;
        b=GToRuCW0QKc2hOpEIsMsw1rl4Z+MdIpLugbiNGvMKxyxvIob16X+cGb7Ke2Zl7YbpG
         RqF7eot4kCRUyhby0R34I03ZpvSwkCHQwN9ge+UkG7KZQvO27zYaoKliy2tECLsiMrB5
         JQNYuI/UWRU1ekUEVH31zD+VCiUBHYDuNqamiH0R78q/iD9E8ExNWoVlLUnhF+GSoZBU
         FNu0ct/hdVwK3GJk0Q0vheIwyjq9D2LrXbAQCa/ViIHQe8LeIBWoC3WZdO9bKZBXxE9F
         jxqYmDPoTrnhjJwB0vDWIlM75LzOx7r7g0mU17twZbT0w+C4Bm1YgxJYixBig7LvUG5i
         KHjw==
X-Gm-Message-State: AOJu0Yw4GKLzU1ooTeuBrEI9KgeyCsw1EPWOuRfkil+XzRLP4doSlpjt
	Bge5Uv4nwtT2qUAHerVM5hTRaO2lmhtICZfagNGu0kc2Xn/UOhmBPdcvFXmZazyr7gQGVe9qgLx
	5NjqB62mnfLMh3DBpNY+8MZL7GCk3o4YvHOto6JKhfavL+otWrMMb+ly40c17Sd+cfF2U0HD8SJ
	+adnvsL7k9rpnDgF8EeSOUOsu8HB1khwi4LKA=
X-Gm-Gg: ASbGncvVpnk3V9e1LQznl3HM+NzZBEmRJJiRWQbyU+fJPbuZ8H8rx7yv7hDn8QH0y+7
	xhwL0idwdRFfGIPRRXFjPFb3Z+70Uo4rLjABnS22vVbdI06SEcl73I0GU7iNHy+rZ37Kw/Qu3Cs
	5vu+3nPETaJKEJvdbh8l1TEcuXfYBFkAa3zBilzdPJtTOECbXKhKLXqVTG3T5DJT7/fDbni6iIr
	jMORgQaax7rmgzH8zsFfZ74CGTdSQqv6UtCN0UEsYuefz6nELRH7zVQcCJ+PYS8MJ2eRN3YxX/l
	afc0HJdJjtpCGbrXD+8KYpU=
X-Google-Smtp-Source: AGHT+IEv7CcUWtUY/vHth+Pzo08OssxlhLb3z6WAsk4ULdVgEgbzIik2NIG6kbk+BkSy6XxFiRHClA==
X-Received: by 2002:a17:903:186:b0:21f:75f:295 with SMTP id d9443c01a7336-21f4e716a17mr85874165ad.31.1738988081807;
        Fri, 07 Feb 2025 20:14:41 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm38567715ad.21.2025.02.07.20.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:14:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v5 3/3] selftests: drv-net: Test queue xsk attribute
Date: Sat,  8 Feb 2025 04:12:25 +0000
Message-ID: <20250208041248.111118-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208041248.111118-1-jdamato@fastly.com>
References: <20250208041248.111118-1-jdamato@fastly.com>
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


