Return-Path: <netdev+bounces-206877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD2CB04A95
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199384A1309
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C47279359;
	Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXxUjoyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5D27933E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532071; cv=none; b=mvvEs8Z1pf6FTp5xpcIOimubxJ27DPQtpbK/XjwmF+dfrt3OMTfdmOOfulRB1DRtMPSbyzkY+RUtRiJAom3p6forq2bxInKHlX+o8Vx8rlJq9Jn3NBfNys5jJsOgCLcAve5wSpaoNHdNQ/T3SSeSdNLX+OQ7Pvhlas1cwTS3TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532071; c=relaxed/simple;
	bh=POt7q2m1m4zcRD5W2BysReBTDRKremxfmQCsi+bU+Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX3oHXOj9+y1JuBh7mT0WUuuWDMv1qSqzuym6tedpyd6hVKrhgSg+JWSNsCWX84Skm7RzV+f2KdGB2TZrnTInGAWASedI6ka/4vKZ3CQvNbBwGOuMkspdw7N5kqtfGHhy21YqijVsmy4pb5M/Clpzue3zPEuAJ9COMkLLycGhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXxUjoyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E1C4CEF0;
	Mon, 14 Jul 2025 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532071;
	bh=POt7q2m1m4zcRD5W2BysReBTDRKremxfmQCsi+bU+Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXxUjoySegZwLMlIfr6LwjoSskGkTUHB3osdyxiDkzBeVPPQdwooGMyQNsfT2wZwY
	 kKA2KvctY/xh3ymyg247eMhdoc/cf/qA1q+LRZYGGwHY1O7Ck7phBqjIB4HwyELg0G
	 Gf1BssCPcR86ACFK8FKNbkORrRCseWQmEap9aIz8d4NCb38Xpf2JItFXRlz1A8v6YJ
	 cbzTaOl2gzvQKvxHnMtdsXRueP/ZWjStEqNKTZCB/ddKnugxMbi0fRT+/f2nu4t/9d
	 IzttnjT6N0++SI6CQI6gNyoqzyn4YXiJ1kgLIySr/DAzaN/wH0Kj7BgwS3Yp2jSrVS
	 OUMaYp+knReTA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/11] selftests: drv-net: rss_api: test setting indirection table via Netlink
Date: Mon, 14 Jul 2025 15:27:22 -0700
Message-ID: <20250714222729.743282-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714222729.743282-1-kuba@kernel.org>
References: <20250714222729.743282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test setting indirection table via Netlink.

  # ./tools/testing/selftests/drivers/net/hw/rss_api.py
  TAP version 13
  1..6
  ok 1 rss_api.test_rxfh_nl_set_fail
  ok 2 rss_api.test_rxfh_nl_set_indir
  ok 3 rss_api.test_rxfh_nl_set_indir_ctx
  ok 4 rss_api.test_rxfh_indir_ntf
  ok 5 rss_api.test_rxfh_indir_ctx_ntf
  ok 6 rss_api.test_rxfh_fields
  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

---
v2:
 - test set on lo which doesn't have any ops (expected to fail)
---
 .../selftests/drivers/net/hw/rss_api.py       | 96 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 2c76fbdb2617..07079da6a311 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -6,10 +6,10 @@ API level tests for RSS (mostly Netlink vs IOCTL).
 """
 
 import glob
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne, ksft_raises
 from lib.py import KsftSkipEx, KsftFailEx
-from lib.py import defer, ethtool
-from lib.py import EthtoolFamily
+from lib.py import defer, ethtool, CmdExitFailure
+from lib.py import EthtoolFamily, NlError
 from lib.py import NetDrvEnv
 
 
@@ -59,6 +59,95 @@ from lib.py import NetDrvEnv
     return ret
 
 
+def test_rxfh_nl_set_fail(cfg):
+    """
+    Test error path of Netlink SET.
+    """
+    _require_2qs(cfg)
+
+    ethnl = EthtoolFamily()
+    ethnl.ntf_subscribe("monitor")
+
+    with ksft_raises(NlError):
+        ethnl.rss_set({"header": {"dev-name": "lo"},
+                       "indir": None})
+
+    with ksft_raises(NlError):
+        ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "indir": [100000]})
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    ksft_is(ntf, None)
+
+
+def test_rxfh_nl_set_indir(cfg):
+    """
+    Test setting indirection table via Netlink.
+    """
+    qcnt = _require_2qs(cfg)
+
+    # Test some SETs with a value
+    reset = defer(cfg.ethnl.rss_set,
+                  {"header": {"dev-index": cfg.ifindex}, "indir": None})
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "indir": [1]})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(set(rss.get("indir", [-1])), {1})
+
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "indir": [0, 1]})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(set(rss.get("indir", [-1])), {0, 1})
+
+    # Make sure we can't set the queue count below max queue used
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 0 rx 1")
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 1 rx 0")
+
+    # Test reset back to default
+    reset.exec()
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(set(rss.get("indir", [-1])), set(range(qcnt)))
+
+
+def test_rxfh_nl_set_indir_ctx(cfg):
+    """
+    Test setting indirection table via Netlink.
+    """
+    _require_2qs(cfg)
+
+    # Get setting for ctx 0, we'll make sure they don't get clobbered
+    dflt = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+
+    # Create context
+    ctx_id = _ethtool_create(cfg, "-X", "context new")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "context": ctx_id, "indir": [1]})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex},
+                             "context": ctx_id})
+    ksft_eq(set(rss.get("indir", [-1])), {1})
+
+    ctx0 = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(ctx0, dflt)
+
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "context": ctx_id, "indir": [0, 1]})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex},
+                             "context": ctx_id})
+    ksft_eq(set(rss.get("indir", [-1])), {0, 1})
+
+    ctx0 = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(ctx0, dflt)
+
+    # Make sure we can't set the queue count below max queue used
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 0 rx 1")
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 1 rx 0")
+
+
 def test_rxfh_indir_ntf(cfg):
     """
     Check that Netlink notifications are generated when RSS indirection
@@ -129,6 +218,7 @@ from lib.py import NetDrvEnv
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
     ksft_exit()
 
-- 
2.50.1


