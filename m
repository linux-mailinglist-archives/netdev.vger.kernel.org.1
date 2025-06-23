Return-Path: <netdev+bounces-200428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB6AE57DD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E54B17C6C2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759029B78C;
	Mon, 23 Jun 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECV6cwKp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7B29B771
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720648; cv=none; b=r2tv32giQrPpJYIynNbFhhgyR6IZLBiXf2BYUSR29X0snWUZU5LQIBK+clEXOckeLf+83C2W34soYewHsYfrWWb8LhdbZph4poULks7HzQVx/lZ3vA9He1f7k/tRn0L9ioP6LGiMvxgaCveqi+QGOS0Rxlt3mpb7UdfjbPoKbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720648; c=relaxed/simple;
	bh=ZyUcIo/M3Wk6pi3v7SLLRD/UGjQ0q6bsNLEgGdz4Xtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8q3D6WR3VTAqPkS/OUNP1ao5gjnGBa+8Z0n2xBci/FayAHbF2Cq+0MONceA1F0WR2DuWsam0fgkCnAAd751idmeS1ILq6iO33LL60Laexbk5XDGw6/yoM13m54CtgC5wFjMr/p4ASrKvwWDKVq6pSCDU5KY+YTuJXPXXAnciwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECV6cwKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1379C4CEEA;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720648;
	bh=ZyUcIo/M3Wk6pi3v7SLLRD/UGjQ0q6bsNLEgGdz4Xtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECV6cwKpKqx3rblRl1hAZKvNkIEUTGOM9RNSkLswcNSYziNiSsFAnqKJDPCNC0yB7
	 LogVAIgWBYr3P7efjRqmrQnOpI2fCZ491kjIrAyQU/Pz/zr1Opfln9OeX9sdmlo0dG
	 LqUWMowMus4RMkWoqH4T8eaywMhuGFJjLDvRCczPYFDU3hb8GId0v7fJ7+X+FKw9EX
	 6xBbi3kLtMSNg5nsfdIZ1b2s8nJFJjyhu8cEQBqTA9a0sgrxzExwzu5igkME91Ottq
	 YO/qTxf2+IpeDssSHyegU3SOFvLnN6mLcHBGD0BtjLJMPoFozRldHanQkztYVp339H
	 imox4ryl1J3dg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 8/8] selftests: drv-net: test RSS Netlink notifications
Date: Mon, 23 Jun 2025 16:17:20 -0700
Message-ID: <20250623231720.3124717-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that changing the RSS config generates Netlink notifications.

  # ./tools/testing/selftests/drivers/net/hw/rss_api.py
  TAP version 13
  1..2
  ok 1 rss_api.test_rxfh_indir_ntf
  ok 2 rss_api.test_rxfh_indir_ctx_ntf
  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_api.py       | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_api.py

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
new file mode 100755
index 000000000000..db0f723a674b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -0,0 +1,89 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+API level tests for RSS (mostly Netlink vs IOCTL).
+"""
+
+import glob
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import defer, ethtool
+from lib.py import EthtoolFamily
+from lib.py import NetDrvEnv
+
+
+def _ethtool_create(cfg, act, opts):
+    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
+    # Output will be something like: "New RSS context is 1" or
+    # "Added rule with ID 7", we want the integer from the end
+    return int(output.split()[-1])
+
+
+def test_rxfh_indir_ntf(cfg):
+    """
+    Check that Netlink notifications are generated when RSS indirection
+    table was modified.
+    """
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Local has only {qcnt} queues")
+
+    ethnl = EthtoolFamily()
+    ethnl.ntf_subscribe("monitor")
+
+    ethtool(f"--disable-netlink -X {cfg.ifname} weight 0 1")
+    reset = defer(ethtool, f"-X {cfg.ifname} default")
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("No notification received")
+    ksft_eq(ntf["name"], "rss-ntf")
+    ksft_eq(set(ntf["msg"]["indir"]), {1})
+
+    reset.exec()
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("No notification received after reset")
+    ksft_eq(ntf["name"], "rss-ntf")
+    ksft_is(ntf["msg"].get("context"), None)
+    ksft_ne(set(ntf["msg"]["indir"]), {1})
+
+
+def test_rxfh_indir_ctx_ntf(cfg):
+    """
+    Check that Netlink notifications are generated when RSS indirection
+    table was modified on an additional RSS context.
+    """
+
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Local has only {qcnt} queues")
+
+    ctx_id = _ethtool_create(cfg, "-X", "context new")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    ethnl = EthtoolFamily()
+    ethnl.ntf_subscribe("monitor")
+
+    ethtool(f"--disable-netlink -X {cfg.ifname} context {ctx_id} weight 0 1")
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("No notification received")
+    ksft_eq(ntf["name"], "rss-ntf")
+    ksft_eq(ntf["msg"].get("context"), ctx_id)
+    ksft_eq(set(ntf["msg"]["indir"]), {1})
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.49.0


