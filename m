Return-Path: <netdev+bounces-161889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACEA24637
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04993167A24
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66D3596B;
	Sat,  1 Feb 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKctGAuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BA3595B
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373460; cv=none; b=mpSVclSF0U+NDe0j89yeO58WTGOhg9ZiziHumBf26VC2cFvBt6KrKhZxeG7KZUcs+nkMjsCp7geGvbQ5+mnT2PukWxgNfs+pS3/pq7kbQzuLXQppIpygJpZSRMU5eymUu1pgin7CQJd1MTJodvS00a2+2CQ9M3+hqsuZrZgwSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373460; c=relaxed/simple;
	bh=oZ5hG6MZ0mOl6SyF5a3MmSGiuya6GK4fXDqhZNFV2CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJkhCr+3asKzvf7p4k4bLmhbcc2H9ZAhYw5xYKF8deDQEcOOsgHoFFls7s8vuXLIk3pcOoKqznKVjBrU+HUn+UtV7rsVHGziwdAAWdQhZ3KLeKdGuxeHXX205xjhgT539C/czaoABnIzsNOl0UPNGrik4PRaGEUccWBbmF2jEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKctGAuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07B2C4CED1;
	Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738373460;
	bh=oZ5hG6MZ0mOl6SyF5a3MmSGiuya6GK4fXDqhZNFV2CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKctGAuVWLay3dO8LGOFSreikpYFHVmQ4vbQtkLgZDajsr6k+wnHEKGsdhOzIceK+
	 ye6YCcofWXd2q3sqauXjM2odJ0v8+26zXHRYPEnt4OJWL/+IAjxEawxRQ7/36guTr5
	 XR9eFI9QZChDh0Yxt/OQInyZQyAHB1lz5KwC9wjaapV6WKKJtdC5wCK6KxN2ewcE74
	 A0Saw5OMvYfo1/rgftCnJJh0Nay0YrwboCApwoc3CBMygTrcJbR98isw8RZmq+HLTM
	 gYNPHxaailfbF4vN6ECl5DSR83+nK67/cHS3vYhOSemh3cyrsrrumQGzL6WWuV6gOe
	 OI1lgNljHac5Q==
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
Subject: [PATCH net 4/4] selftests: drv-net: rss_ctx: don't fail reconfigure test if queue offset not supported
Date: Fri, 31 Jan 2025 17:30:40 -0800
Message-ID: <20250201013040.725123-5-kuba@kernel.org>
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

Vast majority of drivers does not support queue offset.
Simply return if the rss context + queue ntuple fails.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 27e24e20749f..319aaa004c40 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -260,7 +260,12 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         # change the table to target queues 0 and 2
         ethtool(f"-X {cfg.ifname} {ctx_ref} weight 1 0 1 0")
         # ntuple rule therefore targets queues 1 and 3
-        ntuple2 = ethtool_create(cfg, "-N", flow)
+        try:
+            ntuple2 = ethtool_create(cfg, "-N", flow)
+        except CmdExitFailure:
+            ksft_pr("Driver does not support rss + queue offset")
+            return
+
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple2}")
         # should replace existing filter
         ksft_eq(ntuple, ntuple2)
-- 
2.48.1


