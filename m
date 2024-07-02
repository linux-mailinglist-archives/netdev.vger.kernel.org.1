Return-Path: <netdev+bounces-108624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B5924C2B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9C4B20A89
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE417A595;
	Tue,  2 Jul 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFavrjnV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A215B0FA
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963459; cv=none; b=GwbTY7cGcFIo3rHzphpvqf50GK2Fr7ou7OtA1Y4FPWigAS/Y+t2Nkeur8LiP8HcekNVZZEtsja5TGLi3fYtj7IEVhWFnwsr08rjaK+0yCNmqP7a9GpX6RSNyImvqMLAoo9QNEeOJRMhdzJCKrTMD8sGsWKTAO6bGf7a0jcps1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963459; c=relaxed/simple;
	bh=rCd3h614E3zhyrX+VxBEpTwr5YCTCIsaLXtdFJq4hfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUkiX5C/y46sUiEHWWfZE2JryTHcSshTqHw2ja2WdvkApXZOFS5NmyR7dDV/LTs7JbV1FN0uJtor402PAEgFPPHFEFtzfJaJEefBmz7FixR5hKYBK+Dc9ZnToCgbkuX4jjgHW0accLiw8pWi0kDTrMjsfNqUke2sMkM0JLcmt/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFavrjnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1087EC116B1;
	Tue,  2 Jul 2024 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719963458;
	bh=rCd3h614E3zhyrX+VxBEpTwr5YCTCIsaLXtdFJq4hfw=;
	h=From:To:Cc:Subject:Date:From;
	b=WFavrjnV3iRB3UYuQF+repmZVWWIKmcnPGitkkuu6yUyEqsEXORCVOhRNTqFwOTT/
	 L0xEUa1yQkHKxlYZM9oiCR1AmZgR14zCuIhIBwNURQ7CJQYYORF2g6CvCB0V76jBu7
	 tHrSs9al+erTpyB4jN6G+/84qucVEqCXWZbQDJNlDNCO/6WRxJDXGwYf0XS5IzuQ+2
	 Jt5eR7H1E5PExp9CkvcCrDe0FxkpjQJvGdMKxcXlpZbppDNYNidEYb2qduqylplHr1
	 KN5VW6K37tkrM1TEm6iUygLOKV1BCxVIGKzk6/bsFNug8Y3QEoVa3dq2dWnVIoSO+s
	 RvdvHAk3t+c2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	Jakub Kicinski <kuba@kernel.org>,
	petrm@nvidia.com,
	willemb@google.com
Subject: [PATCH net-next] selftests: drv-net: rss_ctx: allow more noise on default context
Date: Tue,  2 Jul 2024 16:37:28 -0700
Message-ID: <20240702233728.4183387-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As predicted by David running the test on a machine with a single
interface is a bit unreliable. We try to send 20k packets with
iperf and expect fewer than 10k packets on the default context.
The test isn't very quick, iperf will usually send 100k packets
by the time we stop it. So we're off by 5x on the number of iperf
packets but still expect default context to only get the hardcoded
10k. The intent is to make sure we get noticeably less traffic
on the default context. Use half of the resulting iperf traffic
instead of the hard coded 10k.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: petrm@nvidia.com
CC: willemb@google.com
---
 .../testing/selftests/drivers/net/hw/rss_ctx.py  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 26e9ecb13ecc..932b97aa1a03 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -199,8 +199,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
         cnts = _get_rx_cnts(cfg, prev=cnts)
 
-        ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
-        ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
+        directed = sum(cnts[2+i*2:4+i*2])
+
+        ksft_lt(sum(cnts[ :2]), directed / 2, "traffic on main context:" + str(cnts))
+        ksft_ge(directed, 20000, f"traffic on context {i}: " + str(cnts))
         ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
 
     if requested_ctx_cnt != ctx_cnt:
@@ -258,8 +260,9 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
             cnts = _get_rx_cnts(cfg, prev=cnts)
 
             if ctx[i]:
-                ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))
-                ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))
+                directed = sum(cnts[2+i*2:4+i*2])
+                ksft_lt(sum(cnts[ :2]), directed / 2, "traffic on main context:" + str(cnts))
+                ksft_ge(directed, 20000, f"traffic on context {i}: " + str(cnts))
                 ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
             else:
                 ksft_ge(sum(cnts[ :2]), 20000, "traffic on main context:" + str(cnts))
@@ -353,8 +356,9 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
     cnts = _get_rx_cnts(cfg, prev=cnts)
 
-    ksft_lt(sum(cnts[ :2]),  7000, "traffic on main context: " + str(cnts))
-    ksft_ge(sum(cnts[2:4]), 20000, "traffic on extra context: " + str(cnts))
+    directed = sum(cnts[2:4])
+    ksft_lt(sum(cnts[ :2]), directed / 2, "traffic on main context: " + str(cnts))
+    ksft_ge(directed, 20000, "traffic on extra context: " + str(cnts))
     if other_ctx == 0:
         ksft_eq(sum(cnts[4: ]),     0, "traffic on other queues: " + str(cnts))
 
-- 
2.45.2


