Return-Path: <netdev+bounces-206018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF794B010F5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1DE1C82313
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6714B96E;
	Fri, 11 Jul 2025 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu76alne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACF149DFF
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198818; cv=none; b=sJdNP2oCjTogAbL9/gCW2fHYp0uHlz3pwZ11M7j/2DMZhxEdm4WYPh8UlG5XXHshQQxy+QFVXuafXxuNU+mh1a1LzXigiTLtrdusbpF4NppguufwlkmQSNdv3/p0HpWhsyQbEq84TMcbml9ylGfUIrm1Dv9jy5n4Lvfq/y4yV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198818; c=relaxed/simple;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3AsbZEdZQkBywi9Aeidx9BE6cvdPI5hQ96WCVh51TDPIqjbTUGKIlJpS0iiRujNqHjLWeTzep9Ni203adoY0tuuSZDWXkuYn65bu6p381dQ4R3RweocG8ponEf9/OpABSR1cQZRI7tBlsXnegVRGtqblsmiSjf+TufF4H/eXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu76alne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB4C4CEF7;
	Fri, 11 Jul 2025 01:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198818;
	bh=KHPt8s4bKECNUQfB/9WjvpVUlEINokQhHtfz11aTCsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gu76alneLbClV79fTmGb1RtDhFrjH/sPLWMqovVvHWgN4j4DiOyCFItRfKVqpeCtx
	 xxCffPITIL9DPA/O3FcJPZpzB3grF7cXnksy+6JdTmYsFUWzGocqgxKph4Jk0ZB6sA
	 5maWnpf7DO2H9Rea5hz0vV2qvpTsgu2gpv+9xll6jM34met0lNN3RDtXNwRmRLw2F3
	 unYy9FcaCT98s6ADM4fTC7Qy9cp6Ppf+zxmG7ns9urpuq5DVySmxqVALQONTHj5mNW
	 2MM8vmXJfB5FSdfLli/aX0RcHmbL2Ej8gGoqfaQ6+Z9gTK4BAUc1bmbmLT6IvAg0i+
	 LbJwVcItNUs+w==
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
Subject: [PATCH net-next 02/11] selftests: drv-net: rss_api: factor out checking min queue count
Date: Thu, 10 Jul 2025 18:52:54 -0700
Message-ID: <20250711015303.3688717-3-kuba@kernel.org>
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


