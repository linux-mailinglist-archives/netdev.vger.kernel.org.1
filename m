Return-Path: <netdev+bounces-178029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C8A740BA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FF0189F575
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81681DFDAE;
	Thu, 27 Mar 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrol0NyG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C01DF75C
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114204; cv=none; b=RBgoitRXHTvAST2Lnq8NYzFStl1o9TYdR5FURfqox9/PCnEBfUSUFs+036jGEbwYUsChNLo1vtl0S4O2YXSBk1C1LyQ1sfWLY8eOgGgOh2UL2jod5jW/lsu4ShFVmr0FuxtXcW2z+N+ehR0akimztmR66q/6wwKF4TsTU2248kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114204; c=relaxed/simple;
	bh=zeicdEtx4xa3ZxYSJzfyGhAkDy8TJ8eztYnW5ZxEW3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZXMM9p9Ni5HSzNWL6l+uczdCLgw8jupNve0AB0v3BUOaiC82bRiJnUfROkkimNJEcXuKeg50y7z2XKLaxdNJNEHwuEjSHk5MWeodc+ISbHABcsyeDDbG8S4Hovq+13AczFjHodekloh2oHRc/Z/MQccsj6G+CDHlBOPTCJPX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrol0NyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2F3C4CEED;
	Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743114204;
	bh=zeicdEtx4xa3ZxYSJzfyGhAkDy8TJ8eztYnW5ZxEW3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vrol0NyGh6BaEAgyHgX1t7B6Qp7/xk0201d6x2UR7VHNY/Xa8YY6/Thyw2QK66XOx
	 R8uSknaxhkSKWC/6yLhp6oeBWgK8oOLIly2ACF4g6Oo0aDgyrerhGcDa50mBo2s7Ju
	 KWsWP0PO8Bg0DAgNHNmSk4oZzd4PqghJlVgjHX2Hcdx+QdyTYE6NqCqZpJEYGlVAXv
	 nW56tFhK7ogAJBxQvJmVAyqRaQD7/i7L7JKLpoKMXVGfG6Ga78PbNjEaKgthFq+pQp
	 +mCm+r403GcHYf0EXdzaWFfzWjA47duTZGlW2YvhvKmCj4lG1YFvM0XmDR6ZYKGVNp
	 sp8F6Snv5t5+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 3/3] selftests: net: use Path helpers in ping
Date: Thu, 27 Mar 2025 15:23:15 -0700
Message-ID: <20250327222315.1098596-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250327222315.1098596-1-kuba@kernel.org>
References: <20250327222315.1098596-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that net and net-next have converged we can use the Path
helpers in the ping test without conflicts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/ping.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 93120e86e102..4b6822866066 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -56,8 +56,7 @@ no_sleep=False
         return
 
 def _set_xdp_generic_sb_on(cfg) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip link set dev {cfg.ifname} mtu 1500 xdpgeneric obj {prog} sec xdp", shell=True)
     defer(cmd, f"ip link set dev {cfg.ifname} xdpgeneric off")
@@ -66,8 +65,7 @@ no_sleep=False
         time.sleep(10)
 
 def _set_xdp_generic_mb_on(cfg) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
     defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
     ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
@@ -77,8 +75,7 @@ no_sleep=False
         time.sleep(10)
 
 def _set_xdp_native_sb_on(cfg) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 1500", shell=True, host=cfg.remote)
     cmd(f"ip -j link set dev {cfg.ifname} mtu 1500 xdp obj {prog} sec xdp", shell=True)
     defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
@@ -95,8 +92,7 @@ no_sleep=False
         time.sleep(10)
 
 def _set_xdp_native_mb_on(cfg) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {remote_ifname} mtu 9000", shell=True, host=cfg.remote)
     defer(ip, f"link set dev {remote_ifname} mtu 1500", host=cfg.remote)
     try:
@@ -109,8 +105,7 @@ no_sleep=False
         time.sleep(10)
 
 def _set_xdp_offload_on(cfg) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {cfg.ifname} mtu 1500", shell=True)
     try:
         cmd(f"ip link set dev {cfg.ifname} xdpoffload obj {prog} sec xdp", shell=True)
-- 
2.49.0


