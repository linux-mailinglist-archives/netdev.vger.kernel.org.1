Return-Path: <netdev+bounces-206020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC4B010F7
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4F41C825DC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE027155A4D;
	Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNj/+5z8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FED154426
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198819; cv=none; b=sbi0BMvG6VkWeeaQGrNtuSyJu0H7JFqlQolKCWegWsVYCycjXS4iIteMiQ2hEj1VH8JjglkW+MDqYxaqKT9odukxcBCr/oZdJK1v7dqqbmjHoyu7XKZLgcGsVyeevmZqAhgzdmbsAhWoJOC0lWzN8BmZEhW6MCDhzObYq3jyQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198819; c=relaxed/simple;
	bh=PtC2J+Wrc1ykRgbt/l0sG+6cFFp6dzIRRvh90JF+MwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsVrsmcdyw5HvKP09jj0FrOc1wSd4QTjMT9uiRMvpNQw30Ej9LsorNjqVESXZYzAQ4cEWMig8FIypYmuvtWwqLTvWEAEdkoHgWSsgf55w7WhKB6TzqM2zoFqOzxUl54b9NmojHsfBftymwiWOPOQk0deIxIfQxbwF8PWBdfrn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNj/+5z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2EAC4CEF6;
	Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198819;
	bh=PtC2J+Wrc1ykRgbt/l0sG+6cFFp6dzIRRvh90JF+MwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNj/+5z8uhUZ2Q9IyIBUh2YXv6aoeqZ7CU0fPR1EPd63fA9FgtysEEfcglYqVPO0g
	 n3Ec/yWpSTvqExJ190hE85WpuIhzvGhq5PTZNoXhs3YnRfBv6PIBursitSskg2dX9o
	 79ygEOIuXwTX5CzFkc/2lOpRJK6FG7DS1YKo8IsGt1q1YL5U88kl6U5MyVlGfR32DD
	 bV+9N/kHwH0amAUgp2BukS45aY4EDOG5BBoDauAPteQtAbdRsd/hbBUGLDLwByDvav
	 npkSq85a92BK/41ncxtOQSaK9x3dbRfZBdIRy/TYj2DdFuiYMOZBsDdXzPc1K17r04
	 q6W7/JfA6axFQ==
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
Subject: [PATCH net-next 04/11] selftests: drv-net: rss_api: test setting indirection table via Netlink
Date: Thu, 10 Jul 2025 18:52:56 -0700
Message-ID: <20250711015303.3688717-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
References: <20250711015303.3688717-1-kuba@kernel.org>
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
 .../selftests/drivers/net/hw/rss_api.py       | 92 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 2c76fbdb2617..e40a1b6730bb 100755
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
 
 
@@ -59,6 +59,91 @@ from lib.py import NetDrvEnv
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
@@ -129,6 +214,7 @@ from lib.py import NetDrvEnv
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
     ksft_exit()
 
-- 
2.50.1


