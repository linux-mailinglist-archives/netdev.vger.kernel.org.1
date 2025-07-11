Return-Path: <netdev+bounces-206023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C34B010FB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113505A8476
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80917A31E;
	Fri, 11 Jul 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tooErw38"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5317A316
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198822; cv=none; b=bFVSXS7FpZOizpiDO8zjzBHBPKG35k11PWWaJSl/NxluITx4w1e6dK4CYjMs/72xsTNIcnmg9oLx8R5FhZl4jRJUNEorhHC2DOPhwkI4DYFRZqgGDJFxK6LfhVLNqlUwNha6auqLUs7GRl62Z8SINdBiAjgJNOZXp4qlnEgKmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198822; c=relaxed/simple;
	bh=WiaUBask73cFQwjSAKniPdMcJAwcU8HPnP7soXMMAOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap6qNCplxQr6h41fTM/6MeN9g24gZbYbwApr/21Y6BSuz4reivcXvS2vs85tHTGJBpudWbrZBM0vAoz6yqRdQm3d37ArszJbDUj0XGpejBty/gNaT4CumtRfJhzeQ4rd3mfIVzIjysxpLx85M3zNqf/joE8gWO2F6zavgLFAbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tooErw38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F70C4CEFD;
	Fri, 11 Jul 2025 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198821;
	bh=WiaUBask73cFQwjSAKniPdMcJAwcU8HPnP7soXMMAOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tooErw387yydt8pgzh52XEzQ0C6adfmaCr2Llp5IkRA9nLOiT4VHMY9Q/xwZCrt5O
	 PHGvllHxEpCFYFO63psG2oSiWXlr0z1n+ggn0gDpZaZ/4/Sc5yuOcg8PF/gi/7XjYW
	 m+fTV0gqbWN5I4oUUqKpJtDr9Kn38Vgbm9E4V6ZXvs7Z2yTjHKzvukpMpiCjIvnBxo
	 4/3M97g9GQ+HBWjOaTBp3LlvFT10hN1mIfOSMM6YIRxn6z336JCHPrZveNwOa9F1C6
	 ssC5MpqCaRuAmTNTbtR9nM7jsqgvO14JQZ4PnnN58qN8BgdLd5gd8c5PVctDy3ny54
	 catzrR90y7QAg==
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
Subject: [PATCH net-next 07/11] selftests: drv-net: rss_api: test setting hashing key via Netlink
Date: Thu, 10 Jul 2025 18:52:59 -0700
Message-ID: <20250711015303.3688717-8-kuba@kernel.org>
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

Test setting hashing key via Netlink.

  # ./tools/testing/selftests/drivers/net/hw/rss_api.py
  TAP version 13
  1..7
  ok 1 rss_api.test_rxfh_nl_set_fail
  ok 2 rss_api.test_rxfh_nl_set_indir
  ok 3 rss_api.test_rxfh_nl_set_indir_ctx
  ok 4 rss_api.test_rxfh_indir_ntf
  ok 5 rss_api.test_rxfh_indir_ctx_ntf
  ok 6 rss_api.test_rxfh_nl_set_key
  ok 7 rss_api.test_rxfh_fields
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_api.py       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index e40a1b6730bb..a0f3f9937de8 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -6,6 +6,7 @@ API level tests for RSS (mostly Netlink vs IOCTL).
 """
 
 import glob
+import random
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne, ksft_raises
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import defer, ethtool, CmdExitFailure
@@ -195,6 +196,38 @@ from lib.py import NetDrvEnv
     ksft_eq(set(ntf["msg"]["indir"]), {1})
 
 
+def test_rxfh_nl_set_key(cfg):
+    """
+    Test setting hashing key via Netlink.
+    """
+
+    dflt = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    defer(cfg.ethnl.rss_set,
+          {"header": {"dev-index": cfg.ifindex},
+           "hkey": dflt["hkey"], "indir": None})
+
+    # Empty key should error out
+    with ksft_raises(NlError) as cm:
+        cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                           "hkey": None})
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.hkey')
+
+    # Set key to random
+    mod = random.randbytes(len(dflt["hkey"]))
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "hkey": mod})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(rss.get("hkey", [-1]), mod)
+
+    # Set key to random and indir tbl to something at once
+    mod = random.randbytes(len(dflt["hkey"]))
+    cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                       "indir": [0, 1], "hkey": mod})
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    ksft_eq(rss.get("hkey", [-1]), mod)
+    ksft_eq(set(rss.get("indir", [-1])), {0, 1})
+
+
 def test_rxfh_fields(cfg):
     """
     Test reading Rx Flow Hash over Netlink.
-- 
2.50.1


