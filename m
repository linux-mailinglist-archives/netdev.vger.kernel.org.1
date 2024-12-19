Return-Path: <netdev+bounces-153216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD969F7354
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4647A1946
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7913B59A;
	Thu, 19 Dec 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1q1//G2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC513AA38
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734578916; cv=none; b=L2AzxKxv6paizM9Chcrz84jX1vBzbW9iKuZCP180o9YwSq0YNaHRkY4uy7175+8yxStpEDXp1zUQyCFuwY3lOctYygLzpB/QKoEUDjBrm+C2GBztWzshXsqbHQ97ZKSbcQ84FSj9cNssCuVxR2Jmy1hzjnN2LNQSJRjXYCyxSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734578916; c=relaxed/simple;
	bh=awvvBD8hci1kx6hi2UiFqAE+XhnyA5OqaVkbmdQOcL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWQFJ/dAgGC0iwV1zme3JNnhfSVuelOn83wpN1WTF3qNkD2+cLe81JgcoRYXzUakb2rrdv5Ky/b6iO1nofcrxq4G+AIublu6BYogZA9+S+LtkgrJyVVlbVk08eP96ZB3ASRA81mtk7jRHrAT8SC8+QDz2HnVrRHvbpsNH5Dl9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1q1//G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD32C4CEDC;
	Thu, 19 Dec 2024 03:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734578915;
	bh=awvvBD8hci1kx6hi2UiFqAE+XhnyA5OqaVkbmdQOcL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1q1//G2O0Yd8WQzTk7RSx1l7FWEefexvF50ysE36UjwUdoj8ucKaJXiHXn0+nqIE
	 HwQNbcHaUIU1PYc1zBmQiPiAwyPIMLaIzgpjao0ODaSnT5qPdBWQhUIckPo12GZxr2
	 4kL/oZ0CaTKPfes+1DMDNxdKCSGGeTaOkqLizRx53qB86I3U0xghLOsXN0dszhyC22
	 7jM4+GqdDC4zinnglN/zdvx8NBUGMthXsOmfmlXGK87keyWXGCqmJ7/5IM1Xp2FSTD
	 wXX49J6Qc0n+p1MNl1iBV8n6ShlXywIOYNdBUYU/j8NCDDFqYX3gKHJVkNicm0c4Kv
	 JnTQKVZDcqBFQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/2] selftests: drv-net: test empty queue and NAPI responses in netlink
Date: Wed, 18 Dec 2024 19:28:33 -0800
Message-ID: <20241219032833.1165433-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219032833.1165433-1-kuba@kernel.org>
References: <20241219032833.1165433-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure kernel doesn't respond to GETs for queues and NAPIs when
link is down. Not with valid data, or with empty message, we want
a ENOENT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 9c5473abbd78..38303da957ee 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -1,10 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, KsftSkipEx
-from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import ksft_disruptive, ksft_exit, ksft_run
+from lib.py import ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import cmd
+from lib.py import cmd, defer, ip
+import errno
 import glob
 
 
@@ -59,9 +61,27 @@ import glob
     ksft_eq(queues, expected)
 
 
+@ksft_disruptive
+def check_down(cfg, nl) -> None:
+    # Check the NAPI IDs before interface goes down and hides them
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+
+    ip(f"link set dev {cfg.dev['ifname']} down")
+    defer(ip, f"link set dev {cfg.dev['ifname']} up")
+
+    with ksft_raises(NlError) as cm:
+        nl.queue_get({'ifindex': cfg.ifindex, 'id': 0, 'type': 'rx'})
+    ksft_eq(cm.exception.nl_msg.error, -errno.ENOENT)
+
+    if napis:
+        with ksft_raises(NlError) as cm:
+            nl.napi_get({'id': napis[0]['id']})
+        ksft_eq(cm.exception.nl_msg.error, -errno.ENOENT)
+
+
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
-- 
2.47.1


