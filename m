Return-Path: <netdev+bounces-167927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88180A3CDD7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BED18942BE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E46262D24;
	Wed, 19 Feb 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShR5ZXgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44452262D03
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009009; cv=none; b=lPLYa34zLz4P6rpZkaRDg/8FmQaIUffGaL94JiQtVKp5h2MlVJOhb5UpouuDV0JDNtEFsOyyehv4Komn6fZoLoVaAYA1A3CKYRM8EgUMMqobEhrZopFA/kY7uui8G36jEwKTrxAlWUgkdPKrgNS+qCeUzZc9eNd9L7aF660ennA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009009; c=relaxed/simple;
	bh=Tidh1f5P7ToYJXFwCAZTxT4/rDuyIXFFaVMp6l1vTT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lin4mgRwmUO9HrKFuKoM8D003bOtHBg5Qgy2K0wIVJ5YXXEsjLuLnzk63owp0ArEJItI6f5GDNgjwjuFz8Xi26vhfES0j72DiTxhUrQLsrzEhNxD2tRoSYThowCysEUQqYeFfN/JNCj3TLxCazvg8GLGsegkPOlGH0KXGgxl9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShR5ZXgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE3AC4CEEB;
	Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009008;
	bh=Tidh1f5P7ToYJXFwCAZTxT4/rDuyIXFFaVMp6l1vTT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShR5ZXgwLHZzx/2FsMyx3FscxtXLMjboYW+mZOtcg9Nn/LC1zGPg3LIBwwYoKFnZj
	 sZck8veatL9FiECp0gEzjVKarPkUATwDgnzqsPj4LanLD4iMyOFR/QjrI9QXuLd4YY
	 mUWUjDdi/qzuee2j8HAuumjb53EbcG5BuLDrwRaatRg1F+pEiISEpifAFsOsORqpl6
	 uRyVAZzxpJX4A8UPk206SbElgNPo7x+6w4Eh0GMHhmn1eO00l9HB7uw6O1hu2L/Ll7
	 COcgBBj5LqVTzbYNmzGeBrZFywocMcOM6J9oMZxmGjBYGwdAE4xADE0Q19LvD6siGA
	 Nnhko69RXzOWg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/7] selftests: drv-net: add a way to wait for a local process
Date: Wed, 19 Feb 2025 15:49:54 -0800
Message-ID: <20250219234956.520599-6-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
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

Similarly use KSFT_WAIT_FD to let the child process for a sign
that we are done and child should exit. Sending a signal to
a child with shell=True can get tricky.

Make use of this method in the queues test to make it less flaky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use fd for exit, too
 - warn if env variables are bad
v1: https://lore.kernel.org/20250218195048.74692-3-kuba@kernel.org
---
 .../selftests/drivers/net/xdp_helper.c        | 54 +++++++++++++--
 tools/testing/selftests/drivers/net/queues.py | 43 ++++++------
 tools/testing/selftests/net/lib/py/utils.py   | 68 +++++++++++++++++--
 3 files changed, 133 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index 2bad3b4d616c..aeed25914104 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -14,6 +14,54 @@
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
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		fd = STDOUT_FILENO;
+	}
+
+	write(fd, msg, sizeof(msg));
+	if (fd != STDOUT_FILENO)
+		close(fd);
+}
+
+static void ksft_wait(void)
+{
+	char *env_str;
+	char byte;
+	int fd;
+
+	env_str = getenv("KSFT_WAIT_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		/* Not running in KSFT env, wait for input from STDIN instead */
+		fd = STDIN_FILENO;
+	}
+
+	read(fd, &byte, sizeof(byte));
+	if (fd != STDIN_FILENO)
+		close(fd);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -32,7 +80,6 @@ int main(int argc, char **argv)
 	int ifindex;
 	int sock_fd;
 	int queue;
-	char byte;
 
 	if (argc != 3) {
 		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
@@ -92,13 +139,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	/* give the parent program some data when the socket is ready*/
-	fprintf(stdout, "%d\n", sock_fd);
+	ksft_ready();
+	ksft_wait();
 
 	/* parent program will write a byte to stdin when its ready for this
 	 * helper to exit
 	 */
-	read(STDIN_FILENO, &byte, 1);
 
 	close(sock_fd);
 	return 0;
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 0c959b2eb618..7af2adb61c25 100755
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
@@ -32,32 +31,30 @@ import subprocess
     elif xdp.ret > 0:
         raise KsftFailEx('unable to create AF_XDP socket')
 
-    xdp = subprocess.Popen([cfg.rpath("xdp_helper"), f"{cfg.ifindex}", f"{xdp_queue_id}"],
-                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
-                           text=True)
-    defer(xdp.kill)
+    with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
+             ksft_wait=3):
 
-    stdout, stderr = xdp.communicate(timeout=10)
-    rx = tx = False
+        rx = tx = False
 
-    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
-    if not queues:
-        raise KsftSkipEx("Netlink reports no queues")
+        queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+        if not queues:
+            raise KsftSkipEx("Netlink reports no queues")
 
-    for q in queues:
-        if q['id'] == 0:
-            if q['type'] == 'rx':
-                rx = True
-            if q['type'] == 'tx':
-                tx = True
+        for q in queues:
+            if q['id'] == 0:
+                if q['type'] == 'rx':
+                    rx = True
+                if q['type'] == 'tx':
+                    tx = True
 
-            ksft_eq(q['xsk'], {})
-        else:
-            if 'xsk' in q:
-                _fail("Check failed: xsk attribute set.")
+                ksft_eq(q['xsk'], {})
+            else:
+                if 'xsk' in q:
+                    _fail("Check failed: xsk attribute set.")
+
+        ksft_eq(rx, True)
+        ksft_eq(tx, True)
 
-    ksft_eq(rx, True)
-    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 33b153767d89..d879700ef2b9 100644
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
@@ -15,21 +17,56 @@ import time
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
+                 host=None, timeout=5, ksft_wait=None):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
         self.stdout = None
         self.stderr = None
         self.ret = None
+        self.ksft_term_fd = None
 
         self.comm = comm
         if host:
             self.proc = host.cmd(comm)
         else:
+            # ksft_wait lets us wait for the background process to fully start,
+            # we pass an FD to the child process, and wait for it to write back.
+            # Similarly term_fd tells child it's time to exit.
+            pass_fds = ()
+            env = os.environ.copy()
+            if ksft_wait is not None:
+                rfd, ready_fd = os.pipe()
+                wait_fd, self.ksft_term_fd = os.pipe()
+                pass_fds = (ready_fd, wait_fd, )
+                env["KSFT_READY_FD"] = str(ready_fd)
+                env["KSFT_WAIT_FD"]  = str(wait_fd)
+
             self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
-                                         stderr=subprocess.PIPE)
+                                         stderr=subprocess.PIPE, pass_fds=pass_fds,
+                                         env=env)
+            if ksft_wait is not None:
+                os.close(ready_fd)
+                os.close(wait_fd)
+                msg = fd_read_timeout(rfd, ksft_wait)
+                os.close(rfd)
+                if not msg:
+                    raise Exception("Did not receive ready message")
         if not background:
             self.process(terminate=False, fail=fail, timeout=timeout)
 
@@ -37,6 +74,8 @@ import time
         if fail is None:
             fail = not terminate
 
+        if self.ksft_term_fd:
+            os.write(self.ksft_term_fd, b"1")
         if terminate:
             self.proc.terminate()
         stdout, stderr = self.proc.communicate(timeout)
@@ -54,11 +93,30 @@ import time
 
 
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
+    by writing to a special file descriptor passed via KSFT_READY_FD.
+    Command will be terminated when we exit the context manager:
+
+        with bkg("my_binary", ksft_wait=5):
+    """
     def __init__(self, comm, shell=True, fail=None, ns=None, host=None,
-                 exit_wait=False):
+                 exit_wait=False, ksft_wait=None):
         super().__init__(comm, background=True,
-                         shell=shell, fail=fail, ns=ns, host=host)
-        self.terminate = not exit_wait
+                         shell=shell, fail=fail, ns=ns, host=host,
+                         ksft_wait=ksft_wait)
+        self.terminate = not exit_wait and not ksft_wait
         self.check_fail = fail
 
         if shell and self.terminate:
-- 
2.48.1


