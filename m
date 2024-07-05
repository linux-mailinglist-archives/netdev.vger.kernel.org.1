Return-Path: <netdev+bounces-109333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A5927FF5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A07287A5B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBD18C1A;
	Fri,  5 Jul 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3o3lcT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BA18AF4
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144654; cv=none; b=bUszajS7vHAFANwAcbyWg0/G3v6iqfY7MmdZP/eK0umyv5imC+Y5X7aJNAevhwbWIOJTida5qfEW4/sOBeGzMFq6vqtSqV4i2lGgSysbANEZzFe/e8AqEgLK8d+kyYInqDQgJGRWMsF3bXXWrm3bd2kXYpiJEUlNh/VvnfzSkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144654; c=relaxed/simple;
	bh=hHRSFUKZHAxlpHNuibtOX065mAxD8so0S2R7I11pZ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4YZVIG3nu62tEFKVM6w3MaXXqSyx+UTE6yGU8BU5cJI8Iz9DoldvZerMzmgONrHTprUd3PCEP3En7wmrsjWjIaicNrRvnVeDy6/RWU/BYPrzRMuh05uPIpLrO3GKj55+HaucCcH0kxZvbyR/OwuRFuR0eeISuGWNiO4liU6h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3o3lcT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4681FC4AF17;
	Fri,  5 Jul 2024 01:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144653;
	bh=hHRSFUKZHAxlpHNuibtOX065mAxD8so0S2R7I11pZ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3o3lcT+WnW/ug5UEAGhLCIFLTZ6jqPR8BJ2u84uJcYmY42lU/Wlzk4alIkIkU/V7
	 1dXknfxVT155t4KspTZKgrAN+i/uwr7vs/jD936oB1LkqhAtB0RQXCni+5pAOapBLy
	 oFrjljKfN+4JRTvw5JeVgTObH7KI+UoNsL4Ttjdn35TU+6mtMHor3V3JQvix7Ohc1G
	 bn1oMdVfXrl46Y0+wRTGE84YynKrtm46r3eBY7WKuKAl+ybIrSZKF7n7RovaQZveMe
	 sDUU3SN0lph7gGKACgkmljg6mPhNl0/fzQKHi8AAVwMQy58ipsFUDyhVnSd3XC5AO4
	 fJqaUmZONUHJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] selftests: drv-net: rss_ctx: check behavior of indirection table resizing
Date: Thu,  4 Jul 2024 18:57:24 -0700
Message-ID: <20240705015725.680275-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705015725.680275-1-kuba@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
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

Disrupting traffic for key update is not a bug, but makes the key
update unusable for rehashing under load.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index fbc234d6c395..f42807e39e0d 100755
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
@@ -203,6 +203,39 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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
@@ -434,9 +467,11 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
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


