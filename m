Return-Path: <netdev+bounces-206875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978CB04A93
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC0C16D49C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA82277CB2;
	Mon, 14 Jul 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErDfMZ7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C3277CB0
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532070; cv=none; b=BvWceCXXJysjpU5hl+o9kf/vK9I/ZEaZFBkyEYJGlsvix1W5JVUerYAkJOYJOCkENRYYDvPyBmNS9FvVcwHlt+XTc2mzj0yX/PDxxg0DVMkuthLZXrpEh0o0INfgaUMmLDR2llde/lcu5ld0I2biccTHnKitsBxvFzMry2uTzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532070; c=relaxed/simple;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4BbNOs6hTfo1hI9x2fLlQ8Cw40wKVYyEvdj9ONhTg9HB7IhUXIH41xafB8wlrcOJIaZOutv8bG6zUl+IQEzeUB8nogUZjDSv0DzPk070/rfO4kwFCrt0vdBHCCX+zJu8AOquTrT1XLoHBkWa7kv8ZwF9mvAde2kLBx4dSiTaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErDfMZ7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86C6C4CEF9;
	Mon, 14 Jul 2025 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532070;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErDfMZ7lWhKYHBGFioHoDb2P2ewh+0e8Vo1MzL02NMuTkyLCUToplinXROx0xhYjv
	 ZgRzThM//A1SpxH7zOj9XoSb9H3i+ta4H4p/NfIddGyhkR0oHQ80nTYwiWPmFkXTDg
	 rMSWm2yMmiBuLDl678LDGkZkr4JD9oOYU6cKgZorzXg6umbiuDtvQ6tg1aqaL/+tPw
	 ibZf0r8w3kjT1sK0E6RwYHZ8RA6OyEsgq6NEea0RI8NkVxhHXhiDHoHDuZkL+pICqM
	 WD9TfMTGXyFoZ4YQnA8hGm/UdHLWGoP33X7QzsDwJPLwJKXtmCniAQG3bwN+AQss4n
	 HMPhyNlSEwaww==
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
Subject: [PATCH net-next v2 02/11] selftests: drv-net: rss_api: factor out checking min queue count
Date: Mon, 14 Jul 2025 15:27:20 -0700
Message-ID: <20250714222729.743282-3-kuba@kernel.org>
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

Multiple tests check min queue count, create a helper.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/rss_api.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 6ae908bed1a4..2c76fbdb2617 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -13,6 +13,13 @@ from lib.py import EthtoolFamily
 from lib.py import NetDrvEnv
 
 
+def _require_2qs(cfg):
+    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
+    if qcnt < 2:
+        raise KsftSkipEx(f"Local has only {qcnt} queues")
+    return qcnt
+
+
 def _ethtool_create(cfg, act, opts):
     output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
     # Output will be something like: "New RSS context is 1" or
@@ -57,10 +64,7 @@ from lib.py import NetDrvEnv
     Check that Netlink notifications are generated when RSS indirection
     table was modified.
     """
-
-    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
-    if qcnt < 2:
-        raise KsftSkipEx(f"Local has only {qcnt} queues")
+    _require_2qs(cfg)
 
     ethnl = EthtoolFamily()
     ethnl.ntf_subscribe("monitor")
@@ -88,10 +92,7 @@ from lib.py import NetDrvEnv
     Check that Netlink notifications are generated when RSS indirection
     table was modified on an additional RSS context.
     """
-
-    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
-    if qcnt < 2:
-        raise KsftSkipEx(f"Local has only {qcnt} queues")
+    _require_2qs(cfg)
 
     ctx_id = _ethtool_create(cfg, "-X", "context new")
     defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
-- 
2.50.1


