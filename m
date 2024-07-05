Return-Path: <netdev+bounces-109330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37852927FF2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB54287A13
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83011184;
	Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB9p92xu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A1EAC5
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144652; cv=none; b=H6X/EU27Z3vGx9p8F+jfg/Mf10wfd1LaS1JlTVulLwKk+1FwQKV5ZKY2Z10XfvCbvRdrACChzmzmZJdDovPPdTN8N1QwKTNPzXVehRZbRXBhGKntBRxM4J0+XB24V23/IOrA24mbIyzps5N4jsd/x/6R0oqhOZl7fiOXqsBhC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144652; c=relaxed/simple;
	bh=YurwP05hBMEW7i/lb6GoYsCicxSjn9PEync7OY/BWAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVTVw0/dEKbXcXhoGOGJyEMXJ8wrl6G/7GvElZNDsO8JKbf5MObH368F+1s/lbWdTzkUS1nIJ7BaywO4y7DDkHDAyNxjFL/c3Huf8uHc51bJDbZ8iFsNGObH36Z4zdpIqz2j7eZpPl6ORTemBPI38wfVIWyjzIW6N+O+0NlJHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB9p92xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3FC4AF0A;
	Fri,  5 Jul 2024 01:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144652;
	bh=YurwP05hBMEW7i/lb6GoYsCicxSjn9PEync7OY/BWAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LB9p92xuIrzCj9agE6wcBdRXhywOnkGyRPA2sCCseK1c5u6eA2t1506637wdA2MMm
	 2GneathS0jWN81Ey4q210k5Hjuwf1jXCJgzNVxy3eokV/WS2uLRxin2qiyFHmOMN4Z
	 uN67nE4iN1hLhD0LFhZWDWpEUKXZLMRar4w/qQCRhrg8e/W+wbwg+5AYjCRo6EHvEf
	 I/sjnQP4RcApm5blJ/NrmkgCdUC9/rDTRLg4NKPMcdJF2FwOkD6vOaDgum3G7pQHlX
	 aVf1EZFtE9wsB/DkNecbjXXAbd5VjVQ67hMjuBOGKFncR0pM0fyjvOssGqUsV7Y0EC
	 8+gYXVNUYDqYA==
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
Subject: [PATCH net-next 1/5] selftests: drv-net: rss_ctx: fix cleanup in the basic test
Date: Thu,  4 Jul 2024 18:57:21 -0700
Message-ID: <20240705015725.680275-2-kuba@kernel.org>
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

The basic test may fail without resetting the RSS indir table.
While at it reformat the doc a tiny bit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 475f2a63fcd5..de2a55c0f35c 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -64,9 +64,8 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
 
 def test_rss_key_indir(cfg):
-    """
-    Test basics like updating the main RSS key and indirection table.
-    """
+    """Test basics like updating the main RSS key and indirection table."""
+
     if len(_get_rx_cnts(cfg)) < 2:
         KsftSkipEx("Device has only one queue (or doesn't support queue stats)")
 
@@ -89,6 +88,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
     # Set the indirection table
     ethtool(f"-X {cfg.ifname} equal 2")
+    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
     data = get_rss(cfg)
     ksft_eq(0, min(data['rss-indirection-table']))
     ksft_eq(1, max(data['rss-indirection-table']))
@@ -104,7 +104,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
 
     # Restore, and check traffic gets spread again
-    ethtool(f"-X {cfg.ifname} default")
+    reset_indir.exec()
 
     cnts = _get_rx_cnts(cfg)
     GenerateTraffic(cfg).wait_pkts_and_stop(20000)
-- 
2.45.2


