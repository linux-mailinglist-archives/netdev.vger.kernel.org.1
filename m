Return-Path: <netdev+bounces-200000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4601AE2AA0
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D30D3BD08F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673022DF96;
	Sat, 21 Jun 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBBPuzy8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286722E3FD
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526397; cv=none; b=MQBucQxECjelCjPQhmPLiUb4E2S8Kc5DOi7jSohKpFh5fzW+pQTzSh+iyazUxPKur2Kcq3Lu4uLjX0GqBrRuiybvoLm8FHBXLoxd/AIfGWWUrw25Rn+rvkepiKxtwpMh/bNCIOZp5zbFo34axBiWslkAq13lwZy7Vy1UEUoFb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526397; c=relaxed/simple;
	bh=ZyUcIo/M3Wk6pi3v7SLLRD/UGjQ0q6bsNLEgGdz4Xtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM/aqwnxPjl0aH785UlFjU/aIj/k7cCjdTRIp07yzIWlGBMVGM/3DvD+4ioUf4CsxEmf7+G6vTUCtCBNpw9jmdji5Q9prbeaU6iPG7o1Y4H5OI5K+Im9z1L+2jowZlcM2oYlgCxYzb2hWMCHxXubHmNUK0/f3sxKlw3vBOf11e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBBPuzy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5752C4CEF3;
	Sat, 21 Jun 2025 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526397;
	bh=ZyUcIo/M3Wk6pi3v7SLLRD/UGjQ0q6bsNLEgGdz4Xtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBBPuzy8Ybr7DO7SaMI4XPv0FIAv4ZB/A+9AIklu+oUkwStfyO99UgVUATyCbvoXZ
	 DIOcgxFU9b4nKN7FvPiuj+wQrbA3IxneLiMSNZRW/3MWd2nskVVgBbXQdmiO9J1r9J
	 YZQ3zBwF9f78L+qmccp7Hd57imsdBtFKFgbohA3wAc6hnRMLBU1C41kbO5q/ryoIyF
	 0y0F4OWL8l9FGXpwY7l3KpKK2Un3ixCy7vyvmlpmuJsp8/H4DS65U7aOXT//2uZ8Kh
	 7MZdAX2WmCcTNiuvCh3fDMSgTcje6+HPOH8op+/9zQ9EtiXklMjAKszOt7YrUN7B44
	 kqvQVF+3WvTgw==
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
Subject: [PATCH net-next 9/9] selftests: drv-net: test RSS Netlink notifications
Date: Sat, 21 Jun 2025 10:19:44 -0700
Message-ID: <20250621171944.2619249-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
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


