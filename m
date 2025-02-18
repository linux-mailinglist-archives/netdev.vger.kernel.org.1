Return-Path: <netdev+bounces-167496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51101A3A802
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8963AA5ED
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB611EFF9A;
	Tue, 18 Feb 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6SFBFq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47E1EFF95
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908252; cv=none; b=Wx+R5fFEYDkp1h1/HK93QH+zqRQQP4JOcUHO4gdXoldWu7BgOMWOf+izTibKvw1wq7Rh9nZWAyG5AUwEzZ+l70kbN/D1OjPo3KIWi5vwEalPHzcxkTbf9eW76golFRf3G8wT8Cw5d6NTwu2VVxzdmYb76m287OyZPkoIUjRqrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908252; c=relaxed/simple;
	bh=XebP0Qwoc8x95qBOh6yoxljjuYMXaDLeVrkoATyZnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9u1TwPM4f5YSgFvVT8vjIK7ZD7QS301OqQUD8jW+xhlpLeX9uVkHWuoU51mIGSZ6y/dz6CTstK6J+k+Y9OY3ui/pDRxtm1ABelK6Oe/HlTD9R8jZW811TcG/IrYdoEqfPauR8rAb/0qRXl2+uQhv/M3OTrwV4D8eH6r4vF6gnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6SFBFq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405E5C4CEE8;
	Tue, 18 Feb 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908252;
	bh=XebP0Qwoc8x95qBOh6yoxljjuYMXaDLeVrkoATyZnPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6SFBFq9V8MaJeINquE/v6A/5+6gX26fp70r9euA9AOjWoymUknL35lx5V4RZwQON
	 k/K93Vl3Rzurd9PXmHRirzp4iDRmW5Ngarl/kSptkBFQZ7G5mGl8dSZspdkKV80eBo
	 8RSS2svOpXY2Uagzuq9znCmbAakXBupFqt8fKP/F2P8ACcpE+aPMozlcBPJjjD3Voq
	 E+bqEYYBLTW12/nOGH8kSuDXj6leH3s9DLpSHe0oiVl0p254YFpqxchscNnAdnJyt1
	 NxksoZ5OeersoHG67NhHih+AQ558ehbV3gpaZ9n140n2v36G6wBmckcsRmUKO/K5Lt
	 aSMYIR/14C5lg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	jdamato@fastly.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: drv-net: rename queues check_xdp to check_xsk
Date: Tue, 18 Feb 2025 11:50:48 -0800
Message-ID: <20250218195048.74692-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test is for AF_XDP, we refer to AF_XDP as XSK.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 3cbcbaf5eaeb..feff4d475ef8 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -23,7 +23,7 @@ import struct
         return len([q for q in queues if q['type'] == qtype])
     return None
 
-def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+def check_xsk(cfg, nl, xdp_queue_id=0) -> None:
     with bkg(f'{cfg.rpath("xdp_helper")} {cfg.ifindex} {xdp_queue_id}',
              wait_init=3):
 
@@ -109,7 +109,8 @@ import struct
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xsk],
+                 args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
-- 
2.48.1


