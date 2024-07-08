Return-Path: <netdev+bounces-110032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557092AB59
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415781C21E47
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132D14F9E2;
	Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTqy4JRX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7714F9D9
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474598; cv=none; b=mlmRYAHz0F+pZWvvkt5tgcd8R3DGAeuQTPaJLfTu5gLrmpDVQS4BlkcF9gMwkIJ6/lTFAY/y+x+gWmN1Eciu+yj4Ic7Ix+PL+9C2R6ykIvGLMnX84TlusQycBAWbV/YDxPi8nQQCxquIKO82UHIuEIPggStr29lJd2kL6JyTUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474598; c=relaxed/simple;
	bh=TasaEvgOEjytwzCa6XRJW2LDZIsx/79Xy/4hCj1mU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPpC0Bobr24Nfs5jye77Gw+9bNN79A54uSauDIGtdNN8/G/EZGRFmGuJmOsAB54H7tG29h1Y3Tvz7fRpsHih/ywL0FoJkMMI8zGcfU7+63hHGMfsuC962YyKuQtZXKp9/9ZfhPMX15X7vBQ5TuTrYpTNfXPysuv+HGkovxHcuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTqy4JRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2441EC4AF10;
	Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474598;
	bh=TasaEvgOEjytwzCa6XRJW2LDZIsx/79Xy/4hCj1mU/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTqy4JRXIZS5BK5i1TVKSIiOvQi2/saGj4eFe7NKrU1y4B2gc++WERrx6qYOZn5mN
	 dmayOS+lQg3HQEMLcZmPEBr2FuxsEbZ+eQhNZ2hjZrKhmmx+ksSgY4Nc9kuWDHxRp7
	 Iewnjd7L7biXQkg+pax5WEIerspzr29CcMfo/2R9skpmOZNu+PZSGerNnQIMtWYny/
	 NG67rhjsoeiVmKINWngNfXgeorSf7jwckFIKSjao/U6qmC96SGb/v6HPMldvEIxi0a
	 xMN14SzOiSOhOWmk/wki47GQjfOy5PJUqVl4qE8eRGHAzm7tjx+VyoJxrA3EJNJysJ
	 7L72FjPUS08qg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/5] selftests: drv-net: rss_ctx: check behavior of indirection table resizing
Date: Mon,  8 Jul 2024 14:36:26 -0700
Message-ID: <20240708213627.226025-5-kuba@kernel.org>
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

Some devices dynamically increase and decrease the size of the RSS
indirection table based on the number of enabled queues.
When that happens driver must maintain the balance of entries
(preferably duplicating the smaller table).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 177abfd06412..38a871220bff 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -5,7 +5,7 @@ import datetime
 import random
 from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ge, ksft_lt
 from lib.py import NetDrvEpEnv
-from lib.py import NetdevFamily
+from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx
 from lib.py import rand_port
 from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
@@ -211,6 +211,39 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         raise Exception(f"Driver didn't prevent us from deactivating a used queue (context {ctx_id})")
 
 
+def test_rss_resize(cfg):
+    """Test resizing of the RSS table.
+
+    Some devices dynamically increase and decrease the size of the RSS
+    indirection table based on the number of enabled queues.
+    When that happens driver must maintain the balance of entries
+    (preferably duplicating the smaller table).
+    """
+
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels['combined-max']
+    qcnt = channels['combined-count']
+
+    if ch_max < 2:
+        raise KsftSkipEx(f"Not enough queues for the test: {ch_max}")
+
+    ethtool(f"-L {cfg.ifname} combined 2")
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    ethtool(f"-X {cfg.ifname} weight 1 7")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    data = get_rss(cfg)
+    ksft_eq(0, min(data['rss-indirection-table']))
+    ksft_eq(1, max(data['rss-indirection-table']))
+
+    ksft_eq(7,
+            data['rss-indirection-table'].count(1) /
+            data['rss-indirection-table'].count(0),
+            f"Table imbalance after resize: {data['rss-indirection-table']}")
+
+
 def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
     """
     Test separating traffic into RSS contexts.
@@ -442,9 +475,11 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
         cfg.netdevnl = NetdevFamily()
 
         ksft_run([test_rss_key_indir, test_rss_queue_reconfigure,
+                  test_rss_resize,
                   test_rss_context, test_rss_context4, test_rss_context32,
                   test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
-- 
2.45.2


