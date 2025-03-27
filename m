Return-Path: <netdev+bounces-178028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C2A740B9
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9881B7A534F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2431DED64;
	Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcvzJRcz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2F1DE89D
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114203; cv=none; b=GNog2JDYTI2ZGnJmSpJ9Y7PFCrwYKoVJRsIUQjiMTMH151e7GqY6jkV0OkYyTZWqhyGpEVPlbqZ6dHjPIdBCTzfzawbYx0sV06h5/11/Xq5fXPPQp9y7JwQNw/tjE3G6Khu3vjcdjS5dlQUvMarUgyXf2BaRb+qhj7pHp6POKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114203; c=relaxed/simple;
	bh=XjJ9aP+2NRuq1+0cLMY1B3KwKqgw/TQZtBjaOswJBJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgQAvTGAD/4zhzsOlt/cHnbYYS+Q6TprGipxvtdJ2qOSGPsWLLjC2GXJfcW+3naGDfdweve0aHxAmr4BXLCVobGxuqeTZZub7e91Dw/PEtLvIabokQL8TvPDrvgTsu6gMKn3tVS1xw40cpoVSyFFNhBs8LYTsihBrMMPnXfTvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcvzJRcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44893C4CEEB;
	Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743114203;
	bh=XjJ9aP+2NRuq1+0cLMY1B3KwKqgw/TQZtBjaOswJBJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcvzJRczFiBaSowRgDO1uzqGcLmGcOyLDulnkD2ZjguAOW/CQAZDhG31lm31AA/sa
	 UF94iQy/n1ltLLKnxS0ettVVEqMQBA7c/sunTz+zF+sQXE92t8hepAY3d5JEJv3Jzx
	 gJrOA53x3sFfBd1CHGPueFIlm0tS/g8zbER+fkLFFe091ANizdsys67mGXYykXo1jk
	 PFzGxgXi6rLHfRJnDkkI9dShUkGiPQO0A//iq0DT7RT3WbRe2h7eXlNuGN178zO3x+
	 U+0AGblLassn9zz09EODPhS6/n8LXdeyzcpnQm+TY/S/afzKGMd9GgP01nSFCObrLj
	 JQ17ZGqqW/wYw==
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
Subject: [PATCH net v3 2/3] selftests: net: use the dummy bpf from net/lib
Date: Thu, 27 Mar 2025 15:23:14 -0700
Message-ID: <20250327222315.1098596-3-kuba@kernel.org>
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

Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
the ioctl path") added an sample XDP_PASS prog in net/lib, so
that we can reuse it in various sub-directories. Delete the old
sample and use the one from the lib in existing tests.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - adjust to use of Path
v2: https://lore.kernel.org/20250306171158.1836674-2-kuba@kernel.org
 - also remove the one in drivers/net/hw/
v1: https://lore.kernel.org/20250228212956.25399-2-kuba@kernel.org
---
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c        | 13 -------------
 tools/testing/selftests/net/xdp_dummy.bpf.c         | 13 -------------
 tools/testing/selftests/drivers/net/hw/irq.py       |  2 +-
 tools/testing/selftests/net/udpgro_bench.sh         |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh       |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh           |  2 +-
 tools/testing/selftests/net/veth.sh                 |  2 +-
 7 files changed, 5 insertions(+), 31 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
 delete mode 100644 tools/testing/selftests/net/xdp_dummy.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c b/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
deleted file mode 100644
index d988b2e0cee8..000000000000
--- a/tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define KBUILD_MODNAME "xdp_dummy"
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("xdp")
-int xdp_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/xdp_dummy.bpf.c b/tools/testing/selftests/net/xdp_dummy.bpf.c
deleted file mode 100644
index d988b2e0cee8..000000000000
--- a/tools/testing/selftests/net/xdp_dummy.bpf.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define KBUILD_MODNAME "xdp_dummy"
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("xdp")
-int xdp_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hw/irq.py b/tools/testing/selftests/drivers/net/hw/irq.py
index d772a18d8a1b..0699d6a8b4e2 100755
--- a/tools/testing/selftests/drivers/net/hw/irq.py
+++ b/tools/testing/selftests/drivers/net/hw/irq.py
@@ -69,7 +69,7 @@ from lib.py import cmd, ip, defer
 def check_reconfig_xdp(cfg) -> None:
     def reconfig(cfg) -> None:
         ip(f"link set dev %s xdp obj %s sec xdp" %
-           (cfg.ifname, cfg.test_dir / "xdp_dummy.bpf.o"))
+           (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
         ip(f"link set dev %s xdp off" % cfg.ifname)
 
     _check_reconfig(cfg, reconfig)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index c51ea90a1395..815fad8c53a8 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 17404f49cdb6..5f3d1a110d11 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 550d8eb3e224..f22f6c66997e 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -3,7 +3,7 @@
 
 source net_helper.sh
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
 readonly DST=1
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 6bb7dfaa30b6..9709dd067c72 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_FILE="xdp_dummy.bpf.o"
+BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
 readonly BASE=`basename $STATS`
 readonly SRC=2
-- 
2.49.0


