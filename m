Return-Path: <netdev+bounces-161888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A712A24636
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE20A3A7CF8
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF729D0D;
	Sat,  1 Feb 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJy2bVzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47670224FD
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373460; cv=none; b=YEcyHpuYCzWNBx6qtt+BfNZfH9P7VBYdjc0SVRLqwZ6CMP7jkFvDtylsR+ddSZx12/S+6Hk3+QtLvlBsCw2abOX2jpt6UWVN8USzjdCWNiJTLuo/eKXk+0PFNdpRMToHvhLl0vwCChMjZjA4luagypYxhm16jhOo+hnX3FF3KVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373460; c=relaxed/simple;
	bh=KiEUqwPPWXAqF3kEmR5c07XcygThCNoHTn6GCjiq178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9aHp0XC4ifRuJclLPUA101rjlVw5VxZApvX7AiI19JG9ygv7R9Tg3a/cKOiy99ZEiOq4AyGoxKDXhXil2gD9d4ApA5PPnR5S/5yQ2MYA1mIHI8eGUbjjTGHQbz08Yqm5I0Q9Zib2wBG/Mef+A9sEcw8/zbykJoP/R0OUXqyhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJy2bVzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F406C4CEE5;
	Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738373459;
	bh=KiEUqwPPWXAqF3kEmR5c07XcygThCNoHTn6GCjiq178=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJy2bVzWkaCuaXsQ2Dg9bjju82qC9oLt6ajtPYzG9p+EymmqHMX9og4YxF6cIiNvJ
	 ZvF1zVHXL41xqQC2FpNwZk1j1XFBRYSs5NCHFOCOmrcah1VBiDAJd7En6qdGPC1Nlv
	 +N5QZVBxaN7s7lNCm0Q4eLFsa8PRjTJufoF9aBXf/VvnZbxfrK83FfVztGlWQR9mX5
	 6fsnGg/5qYhvCiy1ANrf/LslVKDEpTAREeANNXktcLKo/Zq71695xk3WnhCsU1hV32
	 up0VvF8kn3pa+hu3ktATYIk/NJ0OFUsLnCHQjUadXqnVHnRbWC6GyK//Vle0vhNSWq
	 Oxmzksn34So/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/4] selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure
Date: Fri, 31 Jan 2025 17:30:39 -0800
Message-ID: <20250201013040.725123-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201013040.725123-1-kuba@kernel.org>
References: <20250201013040.725123-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under Fixes adds ntuple rules but never deletes them.

Fixes: 29a4bc1fe961 ("selftest: extend test_rss_context_queue_reconfigure for action addition")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ca8a7edff3dd..27e24e20749f 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -252,6 +252,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         try:
             # this targets queue 4, which doesn't exist
             ntuple2 = ethtool_create(cfg, "-N", flow)
+            defer(ethtool, f"-N {cfg.ifname} delete {ntuple2}")
         except CmdExitFailure:
             pass
         else:
@@ -260,6 +261,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         ethtool(f"-X {cfg.ifname} {ctx_ref} weight 1 0 1 0")
         # ntuple rule therefore targets queues 1 and 3
         ntuple2 = ethtool_create(cfg, "-N", flow)
+        defer(ethtool, f"-N {cfg.ifname} delete {ntuple2}")
         # should replace existing filter
         ksft_eq(ntuple, ntuple2)
         _send_traffic_check(cfg, port, ctx_ref, { 'target': (1, 3),
-- 
2.48.1


