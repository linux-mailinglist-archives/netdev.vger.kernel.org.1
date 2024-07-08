Return-Path: <netdev+bounces-110033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BD92AB5A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253FF283852
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0F14F9F4;
	Mon,  8 Jul 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd7s0lps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842E14F9EB
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474599; cv=none; b=XH4ivLeO1RQz1fOEBGODGvoMVH+FBnbUaiEJHH6CfLAqiWt5CrBLLPjQaKiblBgl19I4hdqNuATeiR6Ib0HTgCBLLEbsdADnvypN++xaWPX77lDTXPknzDWm9nN5Kr+scluYOBlbAxv1OnONHYCiiQGcm1bN07umVoTj04dmbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474599; c=relaxed/simple;
	bh=BWQmSedJKaa3iUbF7YenGfJMut/BqyYdonrtfc9pHbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+kRjHVTHMEhnbMKz36dmyyi1bLZR45dqQuvlgK/30htRFZcWAwg7KMEYySGc2u7nqA7ZeGCFSuu8kaQO+SniHq+4cEsLwaUtPvORu9bOCMgpM5DD/79qKij+sD4cHhQltDjGudkHsG67F+n+HXIbl5KriD2B7o8mL/2sd6RYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd7s0lps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9BCC4AF0B;
	Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474598;
	bh=BWQmSedJKaa3iUbF7YenGfJMut/BqyYdonrtfc9pHbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hd7s0lpsiEb98Ze0TAQVuwcoi0X1T1jKSdURW+tjZm1qXuhIew4/8ddlyW2O7E+YI
	 QvU9pCCVnAjb3uWXuAaR3RfUAnO9bIHP1TeEvhm/tYusSla+SxZCBAS6UPfU0Xf4Mm
	 Mv6JBj12C8UFW7AQGsRcd4lO5xSPdPAVi3uIO15rI/Ll9Xdi396wnr/0agEf4BY+X5
	 bXv0HnvHw/gYkUWFFRCDxSsqXxu3Pd4hyox+8K3Hm/xqCKR49ggioq5re4eDu/WQQB
	 Wsgn2bEjVqSGnzN3fLALhkkI/wmjnab97D2j5eDK0JGKfntEfu8bK2QP1+ShG3XlbZ
	 pYQBFCcMxTTLA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/5] selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic
Date: Mon,  8 Jul 2024 14:36:27 -0700
Message-ID: <20240708213627.226025-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708213627.226025-1-kuba@kernel.org>
References: <20240708213627.226025-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some workloads may want to rehash the flows in response to an imbalance.
Most effective way to do that is changing the RSS key. Check that changing
the key does not cause link flaps or traffic disruption.

Disrupting traffic for key update is not incorrect, but makes the key
update unusable for rehashing under load.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 38a871220bff..931dbc36ca43 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -244,6 +244,36 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
             f"Table imbalance after resize: {data['rss-indirection-table']}")
 
 
+def test_hitless_key_update(cfg):
+    """Test that flows may be rehashed without impacting traffic.
+
+    Some workloads may want to rehash the flows in response to an imbalance.
+    Most effective way to do that is changing the RSS key. Check that changing
+    the key does not cause link flaps or traffic disruption.
+
+    Disrupting traffic for key update is not a bug, but makes the key
+    update unusable for rehashing under load.
+    """
+    data = get_rss(cfg)
+    key_len = len(data['rss-hash-key'])
+
+    key = _rss_key_rand(key_len)
+
+    tgen = GenerateTraffic(cfg)
+    try:
+        errors0, carrier0 = get_drop_err_sum(cfg)
+        t0 = datetime.datetime.now()
+        ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
+        t1 = datetime.datetime.now()
+        errors1, carrier1 = get_drop_err_sum(cfg)
+    finally:
+        tgen.wait_pkts_and_stop(5000)
+
+    ksft_lt((t1 - t0).total_seconds(), 0.2)
+    ksft_eq(errors1 - errors1, 0)
+    ksft_eq(carrier1 - carrier0, 0)
+
+
 def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
     """
     Test separating traffic into RSS contexts.
@@ -479,7 +509,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         cfg.netdevnl = NetdevFamily()
 
         ksft_run([test_rss_key_indir, test_rss_queue_reconfigure,
-                  test_rss_resize,
+                  test_rss_resize, test_hitless_key_update,
                   test_rss_context, test_rss_context4, test_rss_context32,
                   test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
-- 
2.45.2


