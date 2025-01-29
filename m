Return-Path: <netdev+bounces-161544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF12A222E9
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35481881FA0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F71E376C;
	Wed, 29 Jan 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="si3kvSEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC321E0DD9
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171494; cv=none; b=o/b9XeB1g1qJUvxhLoiIHhxrtuOhlQJIn3sW9C3HcBA8ZVOfPLgFlfnX2DU2CoXDOqXZ9tRkYnS5kPc5ORp69dluuKrjEmuZkRZ/NOKCd0ZetDmVayqDUavUlJc87L0UmFmckMT+5yymy7iQZLjXnKMVr5ZhWIasj0RimPUdZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171494; c=relaxed/simple;
	bh=BozksO6LrJi91zWTtnxb5prUWQsVfI9vGsKzYHUvw/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2jk9ETJpCbyOTEB5wgCGfWctmJ1hd0cbxkTyQ5rYUlpfi/TL0eGtzFV62LoqPVyd0bL+UD8yp1Fkybiz3SUQnYLJCQakcm/QlBrcVnf7g8hcAdF1ZO1wxD7xNKNKIK7QOHYNXqZMV77HFjnJvojm7vdl5ekZv+wjCPIpDWC0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=si3kvSEw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so141420025ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738171492; x=1738776292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IxZoTSZC8XkF6q0qbcWevoPwZ9BA7mGu7R6RBmsTJw=;
        b=si3kvSEwF3+vza/NrKTOGpls4Z8nEdhR6CbvO9LSC/cgdWJdvR+DCdHGO88OpleZKg
         3x6HlShsnk47wM/Ign1PwPqs1bCC+Y5F6W67bqfLgGGlb7YBgvEGun2H9bLeop7AwxNm
         AzC7xq8GoSKgdE7YPdOik57jMssXY8wkcGG5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171492; x=1738776292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IxZoTSZC8XkF6q0qbcWevoPwZ9BA7mGu7R6RBmsTJw=;
        b=oT6sOWFiNeNfjj+iRXE1o2RtI6FX59DKg9WncUNdEYhniLUMZh44qIcdx+giPKnmuP
         ec186Bjc0JFgkGCSLeterLaUGzYnXGWj1VD/SoELfRsNlmTd55jc1cZ6TkQoXCLUbGFO
         WrHrHH3oq7RgXit/usOq13onMA/ZezK6Fopm0YWW3TsS0gScCXaoIFQpeCoZ9SJuwLPG
         QJXB67Xs1navYKGlJj0m+t8USJe6XqW5RPzuanLR1nzifM8P8kOEOydV586Nnx1cIRFX
         HKUWcY9g7R0BKTWk6pZixb3MwXr6m0o1b4Nz0sIs7jw7NNO4u1ssMvNkhheqrbDyStUU
         sLMA==
X-Gm-Message-State: AOJu0YwKqmlhLD1LF6UFIpRpYLMUVJJsGWJsUUdbJsf7iTy464VL5EB6
	8d/bGkDL3F636OOagFRvw01hs2bGrR4RH2CkkbKAP3GIT8nvVgqv/IeaRmfnF+gFM+m7JKZ1Sac
	BEeyP5SXpCFgYCATjTZCAv+5gjkAi2FlAAIt1jIoXT0rWodg+ewUwdNBDUsqGrJHhYmoxrcBttZ
	e875fZpY+JXAf00RzUFWDFkbYYPyKUN31zRrg=
X-Gm-Gg: ASbGnctQBAdOCjBn5MHQTO8aiaDhSfyv41tPbCR5RFMI3bEm8dAU8+uj6zpT3lh/cLj
	A6MFQQS9xh60fxKxwImqKEKV35cfYaCwBT9NzNKcXv3cgmTHutZ2OEvj4Ak7RI9QRIf6AYBF6ZN
	QmNldj2kK9xH2VFbTpGdsAY7aekw+lIBgANe+RZkg+pxHp5pEq0MG9XkL4OvWr/kHEN2i9oJBLH
	5MUeDLJLylwSk/M0RbT2YAFKZIYIXPYuLRJAtC9ISsYPv7LJQ3n8m4f4qtWj89lpILku60QFCOW
	eLz/BjQgDMIGNUg7CK6yt/M=
X-Google-Smtp-Source: AGHT+IFqx522D4nQTHyMFazUvJWxvG0j+Zqt3odIeyZB35qDEJj8NgO23teWx1vp1NnyLXGolcBjJQ==
X-Received: by 2002:a17:903:1cb:b0:21c:2f41:f4cd with SMTP id d9443c01a7336-21dd7dea7b3mr66633765ad.43.1738171491752;
        Wed, 29 Jan 2025 09:24:51 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4bc5c1fsm101147295ad.82.2025.01.29.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:24:51 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [RFC net-next 2/2] selftests: drv-net: Test queue xsk attribute
Date: Wed, 29 Jan 2025 17:24:25 +0000
Message-Id: <20250129172431.65773-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129172431.65773-1-jdamato@fastly.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that queues which are used for AF_XDP have the xsk attribute set.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/.gitignore    |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 32 ++++++-
 .../selftests/drivers/net/xdp_helper.c        | 90 +++++++++++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
index 09e23b5afa96..3c109144f7ff 100644
--- a/tools/testing/selftests/drivers/.gitignore
+++ b/tools/testing/selftests/drivers/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /dma-buf/udmabuf
 /s390x/uvdevice/test_uvdevice
+/net/xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 137470bdee0c..f6ec08680f48 100644
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
 	netcons_overflow.sh \
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..4bd4710b1a79 100755
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
@@ -21,6 +24,31 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None
 
+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if queues:
+        for q in queues:
+            if q['id'] == 0:
+                if q['type'] == 'rx':
+                    rx = True
+                if q['type'] == 'tx':
+                    tx = True
+
+                ksft_eq(q['xsk'], 1)
+            else:
+                ksft_eq(q['xsk'], 0)
+
+    ksft_eq(rx, True)
+    ksft_eq(tx, True)
+    xdp.kill()
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
@@ -81,7 +109,7 @@ def check_down(cfg, nl) -> None:
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..8ed5f0e7233e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,90 @@
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
+/**
+ * this is a simple helper program that creates an XDP socket and does the
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
2.25.1


