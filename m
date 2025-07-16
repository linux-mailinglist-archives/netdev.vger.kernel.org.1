Return-Path: <netdev+bounces-207311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F466B06A45
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6221563D1A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02C72639;
	Wed, 16 Jul 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGSNokCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823570830
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624257; cv=none; b=dczDNIPwOlPPan/DdIUUmH5nLpaqtPQWbCdrMuhlIX158FpWg9r3ie7XzPJhJe23r14KFDFw/kqPZMaK9T2X2zo6BwVd9Ie7blG10TPKnLtOZ7rjTlGNjtJZEWffZPjCxFxJX5i5uRCl79nuL5QqEkkOTJ1EnvpfIgxgyuqKsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624257; c=relaxed/simple;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwTnSfdKUXGhh1gpXvU9k7Z6EyKFVVSVQcnOC2cq/9QrQXy6rFvWNw+AzVprWg6tBAmf/xyR94RSmE8tdmqYVPW3uolv7NIyOkF8DRYNSC731U22L5SjuCoVyamMOWZ0A2KEJZhPvnNssLxrKwqY0vaMgGOMsYiRibb1WDxte8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGSNokCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FBAC4CEFA;
	Wed, 16 Jul 2025 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624255;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGSNokCxDL3JIZKOvAhNn3DkteyOccM6SJJ+c79eZFEc5a+5w3pQlj0UiMmHCekZx
	 0UPkDTveF3yVljMspUcOuoJYN/1xnpVAx3/lJeeX0C4KJGi00ZjiGytBEcFEyATTy2
	 jGC8WSzlsNzkc0xAHWF/3hPyzsEA64HsLGUL1tvp4KZGG9nDGUcFW+hfvePo62NroK
	 Bcc6+7FtgbgigeOAjvHoy9+Y+y6SbTr7I2AZDNqsvDiJOiG0FuwYIYveJZswJqZ8/z
	 AQblUiJzjZlYOR0mzqaoE8kk875QYDwxYXH34WyL1+/TIBjPek6P5mD++lxxKsu3gy
	 tm6peqMK79p3A==
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
Subject: [PATCH net-next v3 02/11] selftests: drv-net: rss_api: factor out checking min queue count
Date: Tue, 15 Jul 2025 17:03:22 -0700
Message-ID: <20250716000331.1378807-3-kuba@kernel.org>
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


