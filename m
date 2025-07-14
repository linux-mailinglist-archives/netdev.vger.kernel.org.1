Return-Path: <netdev+bounces-206880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C2B04A99
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84B71A61B96
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FE27A455;
	Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoc3XcbU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4027A44D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532073; cv=none; b=eNyAq2JKj6fFuCxotsCn8tE58k6p8kgSQ3EiDI1CDX6B23BLUMdWcEvSLL0gLT6dFC46OnLnbDZ87/Wcq/YTh8lZu0cIQ9jk7ihqWs4HIbPp/SUCm8eTfakZ/W9DbUxySPim2abEvx/B9RjujHDQbAC7wQpI0lnN5i2nsl0lAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532073; c=relaxed/simple;
	bh=2mDMM+6fxqWx+/1j62AU2nx//+9cbelxjvCvmEC1gy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLs7oiJlAY/cRC0VQjt5mQZZzW7VVXbNDLhaa2RDBKXlBHFI8Y1K8gJohTGm9VmzmSnl7R2WS0zWrWhw4tcaEBtNilLs9Pz152l61YXN7HvEXpohRX/V9Skpx9saVeDJ/JvpmBcA435q1mnNqUG86+Ix8tw2kqSMlg+g0Rs4g8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoc3XcbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4593C4CEF6;
	Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532073;
	bh=2mDMM+6fxqWx+/1j62AU2nx//+9cbelxjvCvmEC1gy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoc3XcbU1zseYhdV9DoV+JUnNVxSrg/d8dY0ZjYpfFVrz7n2VenRtTgRIg+pL2MWX
	 FEPGMWeXurqFI8PQpJqEVsp4zWAqqf6GVP2uxQ7W3YmysCFZBlPBE4s7tVQb003hGd
	 cZEVBgFwKE/YZfzASkrL6zY+ZtAuY1UiyeQn72K74FPsy00ToqnTbuee3S96wrQrxc
	 XyVLD91RQ6KILG6SoYPAUseG34ZFWNccxFa/zv5G3xKiIpeLwOISZv3xpQ3fnbAUo3
	 hLnn9xIdWgkD/zBcA1LoZKu0+tAxVl6QR4xIOsUq4/CWZih1aiLi4vlOfVuP+GEmEn
	 aB49mn7A8FILw==
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
Subject: [PATCH net-next v2 07/11] selftests: drv-net: rss_api: test setting hashing key via Netlink
Date: Mon, 14 Jul 2025 15:27:25 -0700
Message-ID: <20250714222729.743282-8-kuba@kernel.org>
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
index 07079da6a311..4de566edb313 100755
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


