Return-Path: <netdev+bounces-110028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EA92AB55
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2D1C21706
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66128149C6A;
	Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9R7Cm7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A11EB44
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474597; cv=none; b=WiPwTTubomi6zS06M2IYgD/EuGHw2+DgdOjuuTxFFhI5bM7wpOivBBbCTH+47TNWA78SPK7adLvA+acRqZ9dLmV8LiSMDwpFxXGXHOkipJJvLJPsD6aHw5MeM48io2BuBgkYDNM6Ldt63+1rgQQXdqWSaV2pQxlYHPbmg9boHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474597; c=relaxed/simple;
	bh=7zLUzKGwrc/i7QjceDjbRwSn83AZIRFuk9F8q49RAZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwsZAh8zixFA5rJVC9o2duRuGQHtOH5OhxLINRLkts4rcmO5WMV68w27JNetBj+n0RsRgtjtxkidQ6oF8D6oizYboFwo/Lym1g8d4NqLQxC0OVwh5d7zi3E9ljwnxPh6avq95c4LVLSO7L5aQMH4TXhmYFMcGBV4du0GcgfXHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9R7Cm7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC5C3277B;
	Mon,  8 Jul 2024 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474597;
	bh=7zLUzKGwrc/i7QjceDjbRwSn83AZIRFuk9F8q49RAZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9R7Cm7eN2ssglCqyF57YOhA0b2Mb/l05Ubo3T3GaxwbwETu+ocYmFD9KS6eXRB4I
	 63xvP1yVBt04FBGsLxQLU1MRM4PIPJD3FWrWWSSZHJYYB5jLbBCTxgUw43A/S5eQ+u
	 sfBvjsE3LfUjBzKQIahTu4K3uJI1mzbnU7Z0QI+qepc5zrBfc13JT3TmWqpsA4gqlt
	 hhKLCppK2jiTU9Z2Q69cieezj/PN9Lz0TvOnfKcUqyPO4U3Ze62CmMXNShJ9cMWL/1
	 eGR3GT7HpE9eX5mQr/hgUgJVlobbVVBjZWf2vGZsIsUBeXHphoP2mqH29X7g6/FWbY
	 62e7J9z6DeZ4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/5] selftests: drv-net: rss_ctx: fix cleanup in the basic test
Date: Mon,  8 Jul 2024 14:36:23 -0700
Message-ID: <20240708213627.226025-2-kuba@kernel.org>
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

The basic test may fail without resetting the RSS indir table.
Use the .exec() method to run cleanup early since we re-test
with traffic that returning to default state works.
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


