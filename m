Return-Path: <netdev+bounces-167495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCAA3A801
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2363A2F10
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3691EFF87;
	Tue, 18 Feb 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQyNp3wp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550E1E832E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908252; cv=none; b=ELAaA7A1JAKTcVlsVq9nvabs7KR0e9kg5B0yz9rnw8IykBEdTmqVt98kWtfDHOA0TuJMO/Om5CufHaLo8tG6FctxAzR9jO3fIGNhDvzmo4bfe5lEqTZUy+ooOz3LxHuEdIIrqUN1d9gjofqnJrQx/z8926Rl42eYvaRP6TJ1Bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908252; c=relaxed/simple;
	bh=tu/Wq+9/JC9VjyF0XbQvZv3LRMZ3BfpVX1DLhkVN8mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbHLJOEH/91inu7qo7LaXpcTUxlfMMjF+rVSIsLGdlgDjeUXPl5Vp7CP4Bn50XfuYopv2OYXvoXspVBEMfjuLFj5LoSyCcPWw/1nvHgxCu+3X4ZuRdsUvmz+Ex932Io2JYcv4v46wxFkP4keToLTGxZxXS818+Wy03G4jYvo0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQyNp3wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D42C4CEEC;
	Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908251;
	bh=tu/Wq+9/JC9VjyF0XbQvZv3LRMZ3BfpVX1DLhkVN8mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQyNp3wpNBpyzRXptuXU1jaMxbJB0NKt1jXLiuc/I+T8lHgHwUklFKn7rT2qnBlXj
	 7NTdmYciXfB0Noji/5UiG1w47F1PwCJFCRn8c1pdY/G+MX4KMXHQKGCY31thxqG6zf
	 r/s/SWdwt8QcQhqO49mTW1VXI999wiQHiaZXraN0uy5VBQL0gKo2cSJ+wALwKYcMJ5
	 tq+Jei2zXCtav299uyFRii57UF/sVSCwQtlLT74AqJSzep9se1fLLSCIa7sJMPxwi9
	 8bcHvoqHX36D2nDHS/OMk8Oe7nM7fM4eqKAhn3hd0mlEwa/wQ7uFrfySK6XayRCi3s
	 tbMJ9sFyNCdyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	jdamato@fastly.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a local process
Date: Tue, 18 Feb 2025 11:50:46 -0800
Message-ID: <20250218195048.74692-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use wait_port_listen() extensively to wait for a process
we spawned to be ready. Not all processes will open listening
sockets. Add a method of explicitly waiting for a child to
be ready. Pass a FD to the spawned process and wait for it
to write a message to us. FD number is passed via KSFT_READY_FD
env variable.

Make use of this method in the queues test to make it less flaky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/xdp_helper.c        | 22 ++++++-
 tools/testing/selftests/drivers/net/queues.py | 46 ++++++---------
 tools/testing/selftests/net/lib/py/utils.py   | 58 +++++++++++++++++--
 3 files changed, 93 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index cf06a88b830b..8f77da4f798f 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -14,6 +14,25 @@
 #define UMEM_SZ (1U << 16)
 #define NUM_DESC (UMEM_SZ / 2048)
 
+/* Move this to a common header when reused! */
+static void ksft_ready(void)
+{
+	const char msg[7] = "ready\n";
+	char *env_str;
+	int fd;
+
+	env_str = getenv("KSFT_READY_FD");
+	if (!env_str)
+		return;
+
+	fd = atoi(env_str);
+	if (!fd)
+		return;
+
+	write(fd, msg, sizeof(msg));
+	close(fd);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -85,8 +104,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	/* give the parent program some data when the socket is ready*/
-	fprintf(stdout, "%d\n", sock_fd);
+	ksft_ready();
 
 	/* parent program will write a byte to stdin when its ready for this
 	 * helper to exit
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index b6896a57a5fd..91e344d108ee 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -5,13 +5,12 @@ from lib.py import ksft_disruptive, ksft_exit, ksft_run
 from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import cmd, defer, ip
+from lib.py import bkg, cmd, defer, ip
 import errno
 import glob
 import os
 import socket
 import struct
-import subprocess
 
 def sys_get_queues(ifname, qtype='rx') -> int:
     folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
@@ -25,37 +24,30 @@ import subprocess
     return None
 
 def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
-    xdp = subprocess.Popen([cfg.rpath("xdp_helper"), f"{cfg.ifindex}", f"{xdp_queue_id}"],
-                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
-                           text=True)
-    defer(xdp.kill)
+    with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
+             wait_init=3):
 
-    stdout, stderr = xdp.communicate(timeout=10)
-    rx = tx = False
+        rx = tx = False
 
-    if xdp.returncode == 255:
-        raise KsftSkipEx('AF_XDP unsupported')
-    elif xdp.returncode > 0:
-        raise KsftFailEx('unable to create AF_XDP socket')
+        queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+        if not queues:
+            raise KsftSkipEx("Netlink reports no queues")
 
-    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
-    if not queues:
-        raise KsftSkipEx("Netlink reports no queues")
+        for q in queues:
+            if q['id'] == 0:
+                if q['type'] == 'rx':
+                    rx = True
+                if q['type'] == 'tx':
+                    tx = True
 
-    for q in queues:
-        if q['id'] == 0:
-            if q['type'] == 'rx':
-                rx = True
-            if q['type'] == 'tx':
-                tx = True
+                ksft_eq(q['xsk'], {})
+            else:
+                if 'xsk' in q:
+                    _fail("Check failed: xsk attribute set.")
 
-            ksft_eq(q['xsk'], {})
-        else:
-            if 'xsk' in q:
-                _fail("Check failed: xsk attribute set.")
+        ksft_eq(rx, True)
+        ksft_eq(tx, True)
 
-    ksft_eq(rx, True)
-    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 9e3bcddcf3e8..efb9b8fc1447 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -2,8 +2,10 @@
 
 import errno
 import json as _json
+import os
 import random
 import re
+import select
 import socket
 import subprocess
 import time
@@ -15,8 +17,22 @@ import time
         self.cmd = cmd_obj
 
 
+def fd_read_timeout(fd, timeout):
+    rlist, _, _ = select.select([fd], [], [], timeout)
+    if rlist:
+        return os.read(fd, 1024)
+    else:
+        raise TimeoutError("Timeout waiting for fd read")
+
+
 class cmd:
-    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
+    """
+    Execute a command on local or remote host.
+
+    Use bkg() instead to run a command in the background.
+    """
+    def __init__(self, comm, shell=True, fail=True, ns=None, background=False,
+                 host=None, timeout=5, wait_init=None):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
@@ -28,8 +44,23 @@ import time
         if host:
             self.proc = host.cmd(comm)
         else:
+            # wait_init lets us wait for the background process to fully start,
+            # we pass an FD to the child process, and wait for it to write back
+            pass_fds = ()
+            env = os.environ.copy()
+            if wait_init is not None:
+                rfd, wfd = os.pipe()
+                pass_fds = (wfd, )
+                env["KSFT_READY_FD"] = str(wfd)
             self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
-                                         stderr=subprocess.PIPE)
+                                         stderr=subprocess.PIPE, pass_fds=pass_fds,
+                                         env=env)
+            if wait_init is not None:
+                os.close(wfd)
+                msg = fd_read_timeout(rfd, wait_init)
+                os.close(rfd)
+                if not msg:
+                    raise Exception("Did not receive ready message")
         if not background:
             self.process(terminate=False, fail=fail, timeout=timeout)
 
@@ -54,10 +85,29 @@ import time
 
 
 class bkg(cmd):
+    """
+    Run a command in the background.
+
+    Examples usage:
+
+    Run a command on remote host, and wait for it to finish.
+    This is usually paired with wait_port_listen() to make sure
+    the command has initialized:
+
+        with bkg("socat ...", exit_wait=True, host=cfg.remote) as nc:
+            ...
+
+    Run a command and expect it to let us know that it's ready
+    by writing to a special file decriptor passed via KSFT_READY_FD.
+    Command will be terminated when we exit the context manager:
+
+        with bkg("my_binary", wait_init=5):
+    """
     def __init__(self, comm, shell=True, fail=None, ns=None, host=None,
-                 exit_wait=False):
+                 exit_wait=False, wait_init=None):
         super().__init__(comm, background=True,
-                         shell=shell, fail=fail, ns=ns, host=host)
+                         shell=shell, fail=fail, ns=ns, host=host,
+                         wait_init=wait_init)
         self.terminate = not exit_wait
         self.check_fail = fail
 
-- 
2.48.1


