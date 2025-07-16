Return-Path: <netdev+bounces-207315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1DEB06A49
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FA14E0843
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B68194C96;
	Wed, 16 Jul 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8B66Fa2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC88192D97
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624259; cv=none; b=fuBRG+7TVM1fdNmfHl0/RoaaI5mjGF7NLAg1T9WAL1G+gMk8uktRw4Dx/UeBWExCtuZOEhs8rC7xywIY2VhxP3WmHk3dR7PnH4K7rjtM4p5QZu4WyUsdSyXXTOwjOs9cUfCRpPIR0uVdPM4p0Jv3FIZpWKTDAgETu59JWYYj1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624259; c=relaxed/simple;
	bh=OIizu7WlZRkKdgpFGQptr1yIgd7IOxghWJ9tyoiRM9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk9e1vxjEGdlV7o2bIeudfIwQQ09SZ3+/n1fH56b6JQHTOAxEHEhsICe87CsmpUhgB9zJ8BPU50tbbU2ajO51KqnkGxUhwJHjf4cW9IiZWKNUeAnBFgt8lnFEEfkxQpSQCrpx76mByCcpXp9ODiXXc6RcDGw1u79uy3AzWnkA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8B66Fa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7619C4CEF6;
	Wed, 16 Jul 2025 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624259;
	bh=OIizu7WlZRkKdgpFGQptr1yIgd7IOxghWJ9tyoiRM9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8B66Fa2Po2fcppf9KyG8MnkvBPIRTR14pK9wmiFnC5plg1OL72M7FDjRewJTHhVL
	 lYuPso4WKFBEmemzCBywwyR+xQTIIGH7ziv5MqZF/G1PHqMx3AnvvIIhopSOeGpl62
	 /clGkvTbmTozCxtGHD/JZumJHBJhZDYRnDvDCorgSLTJk1pZ5xYEdiggck4qyYgGbO
	 r/v8KN328cGLOAAcEbjK2miv6b726WSin/E60EKcbHwKMLKQ+DfIk8P9eFl/wX1pHl
	 XkgHLN9Cua+zsAwJsQVCZrTo5QXEGdi/yWGVgBsk+WgDh4/tEcu2KXTu3p6RTRNjYY
	 qt7Kv/jX76dxg==
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
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 07/11] selftests: drv-net: rss_api: test setting hashing key via Netlink
Date: Tue, 15 Jul 2025 17:03:27 -0700
Message-ID: <20250716000331.1378807-8-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
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
index 7353e8f3e1a4..6d48799a423c 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -6,6 +6,7 @@ API level tests for RSS (mostly Netlink vs IOCTL).
 """
 
 import glob
+import random
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne, ksft_raises
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import defer, ethtool, CmdExitFailure
@@ -199,6 +200,38 @@ from lib.py import NetDrvEnv
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


