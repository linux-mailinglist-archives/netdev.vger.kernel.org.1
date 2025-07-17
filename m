Return-Path: <netdev+bounces-208045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096FB0986C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39A73BF759
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249225D546;
	Thu, 17 Jul 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2kRNOAZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46325A340
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795858; cv=none; b=cVmtiOIpted+dONVCBZYPrGsf8/taLj1+pKvLojU/q+q0+MPQY8E54Ee3O1TrXSNQWd0zIxL4O44jjkDYIxbAFIJNEBjHS0sYw7FB/i7iDRdHQBkVTzZRhcKXUTfGiitFivc6TUpCwJlc3tV0C5dAeNSSstNbEjbNF3QhODu+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795858; c=relaxed/simple;
	bh=mQ9lv54Ytd/dODujE8F3M/U6GgtuvRwx+S7Cgi6DzOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMD9jiJcrHez+AJKyX/bqCHXwtrog05XbIFnQga/ENh3xggmRwQYX2CQZeg8vKbddGDCS4wBEONd6QRwcMWQW44fozwPSiDZ58vLpVPdqzizbI8d4XeqMj7FtmGUJLI4VqseBHmKIdXKZlCZx593/v/11Fmwng/ixHY5X+z70IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2kRNOAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE330C4CEF8;
	Thu, 17 Jul 2025 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795857;
	bh=mQ9lv54Ytd/dODujE8F3M/U6GgtuvRwx+S7Cgi6DzOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2kRNOAZawfWw5smPglnS2DdH+ejE6sz/kdSHrzGBAapO3ZciwA1I0MRwBlhw65e8
	 VltVhkE0WCKBVveRazOsoSbyCPK8M1OS5qtdVu1yC2suksZcQRQgXi+MB39xukk74a
	 MHgCfihJmlT/VysTAqHYGoInCroImU2H3482afLG6fQlagabbJSyqFz+iisycb7cOj
	 KmNx1xL8UcIBFSYv6TK6dEkYh9iKyQVXDHbQu0mug5/+nRKBNNExrB8BYoYlzfcqF5
	 9UTVdc6mIcqfgvrkP4qxOOH3ntIDoB3V9ZhkQimGHkmfe3wdo0gJ2HoOVAoiE1dboo
	 hV2HNAqbHhpXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/8] selftests: drv-net: rss_api: context create and delete tests
Date: Thu, 17 Jul 2025 16:43:43 -0700
Message-ID: <20250717234343.2328602-9-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for creating and deleting contexts.

  TAP version 13
  1..12
  ok 1 rss_api.test_rxfh_nl_set_fail
  ok 2 rss_api.test_rxfh_nl_set_indir
  ok 3 rss_api.test_rxfh_nl_set_indir_ctx
  ok 4 rss_api.test_rxfh_indir_ntf
  ok 5 rss_api.test_rxfh_indir_ctx_ntf
  ok 6 rss_api.test_rxfh_nl_set_key
  ok 7 rss_api.test_rxfh_fields
  ok 8 rss_api.test_rxfh_fields_set
  ok 9 rss_api.test_rxfh_fields_set_xfrm # SKIP no input-xfrm supported
  ok 10 rss_api.test_rxfh_fields_ntf
  ok 11 rss_api.test_rss_ctx_add
  ok 12 rss_api.test_rss_ctx_ntf
  # Totals: pass:11 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_api.py       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 424743bb583b..19847f3d4a00 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -5,6 +5,7 @@
 API level tests for RSS (mostly Netlink vs IOCTL).
 """
 
+import errno
 import glob
 import random
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne, ksft_raises
@@ -390,6 +391,78 @@ from lib.py import NetDrvEnv
     ksft_eq(next(ethnl.poll_ntf(duration=0.01), None), None)
 
 
+def test_rss_ctx_add(cfg):
+    """ Test creating an additional RSS context via Netlink """
+
+    _require_2qs(cfg)
+
+    # Test basic creation
+    ctx = cfg.ethnl.rss_create_act({"header": {"dev-index": cfg.ifindex}})
+    d = defer(ethtool, f"-X {cfg.ifname} context {ctx.get('context')} delete")
+    ksft_ne(ctx.get("context", 0), 0)
+    ksft_ne(set(ctx.get("indir", [0])), {0},
+            comment="Driver should init the indirection table")
+
+    # Try requesting the ID we just got allocated
+    with ksft_raises(NlError) as cm:
+        ctx = cfg.ethnl.rss_create_act({
+            "header": {"dev-index": cfg.ifindex},
+            "context": ctx.get("context"),
+        })
+        ethtool(f"-X {cfg.ifname} context {ctx.get('context')} delete")
+    d.exec()
+    ksft_eq(cm.exception.nl_msg.error, -errno.EBUSY)
+
+    # Test creating with a specified RSS table, and context ID
+    ctx_id = ctx.get("context")
+    ctx = cfg.ethnl.rss_create_act({
+        "header": {"dev-index": cfg.ifindex},
+        "context": ctx_id,
+        "indir": [1],
+    })
+    ethtool(f"-X {cfg.ifname} context {ctx.get('context')} delete")
+    ksft_eq(ctx.get("context"), ctx_id)
+    ksft_eq(set(ctx.get("indir", [0])), {1})
+
+
+def test_rss_ctx_ntf(cfg):
+    """ Test notifications for creating additional RSS contexts """
+
+    ethnl = EthtoolFamily()
+    ethnl.ntf_subscribe("monitor")
+
+    # Create / delete via Netlink
+    ctx = cfg.ethnl.rss_create_act({"header": {"dev-index": cfg.ifindex}})
+    cfg.ethnl.rss_delete_act({
+        "header": {"dev-index": cfg.ifindex},
+        "context": ctx["context"],
+    })
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("[NL] No notification after context creation")
+    ksft_eq(ntf["name"], "rss-create-ntf")
+    ksft_eq(ctx, ntf["msg"])
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("[NL] No notification after context deletion")
+    ksft_eq(ntf["name"], "rss-delete-ntf")
+
+    # Create / deleve via IOCTL
+    ctx_id = _ethtool_create(cfg, "--disable-netlink -X", "context new")
+    ethtool(f"--disable-netlink -X {cfg.ifname} context {ctx_id} delete")
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("[IOCTL] No notification after context creation")
+    ksft_eq(ntf["name"], "rss-create-ntf")
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("[IOCTL] No notification after context deletion")
+    ksft_eq(ntf["name"], "rss-delete-ntf")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
-- 
2.50.1


