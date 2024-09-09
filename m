Return-Path: <netdev+bounces-126741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215219725E2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5299283DB6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843618EFF6;
	Mon,  9 Sep 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DogIhdY0"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9F18E740
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925940; cv=none; b=kJjZYKeueHb7Jek1LTIrR7xN5eyhCJSgNTmZL4Qh8KIEfBmIKZyNMpHlz4XoiNbAgJw5ifhQqyyOQ6gIEXn/9yz66cJStQQjU8aQ0G+4yx7kfh0Wxgm0tVZdaU9v5tLlNUR0sRaOd/FpcI/c2FivEElD6JWKkA7iwPexhopLXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925940; c=relaxed/simple;
	bh=x5eZqUkDEN+9iHJLjoZQK0UfXTF2zol+8fWa4wjcWJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgJTZFwEaoDw5HfLqiefKO74MLoVd3mFL/mP9lY1SMftLw1fpdtTZnfC/0OaTy8jkIb2/2N+R0DBPdwioSrTDkqWN1jLpqmNOLQHUerobFp+viMUSqr+4VZo+lYWO01WmJfyPIbdObftkEX17ScvbU7YJVqAMIDgS04Ua+4lwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DogIhdY0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHPzrmNPD3zzzc0VrtJQihZZBj2ZR2hmkkJkLH0acB0=;
	b=DogIhdY0vx9kvLt8BQMT32QfDlE563f9V443Zs9s2MJk429lOiZ8uMm1uguM4xTxeOjXLz
	eeoVhQurKw6t3D8o/Dcq6rH1rzmULUbU1rH/546AooWto0hD0G0o2l4Yi/wsWnjOGGssHy
	Tmk0eR9gh5hoYuc+gR9u/bdzxr9Js+M=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC PATCH net-next v2 1/6] net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
Date: Mon,  9 Sep 2024 19:52:03 -0400
Message-Id: <20240909235208.1331065-2-sean.anderson@linux.dev>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of using literals, add some symbolic constants for the IRQ delay
timer calculation.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 3 +++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index d70cb62ecf29..5c0a21ef96a4 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -119,6 +119,9 @@
 #define XAXIDMA_IRQ_ERROR_MASK		0x00004000 /* Error interrupt */
 #define XAXIDMA_IRQ_ALL_MASK		0x00007000 /* All interrupts */
 
+/* Constant to convert delay counts to microseconds */
+#define XAXIDMA_DELAY_SCALE		(125ULL * USEC_PER_SEC)
+
 /* Default TX/RX Threshold and delay timer values for SGDMA mode */
 #define XAXIDMA_DFT_TX_THRESHOLD	24
 #define XAXIDMA_DFT_TX_USEC		50
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b065979db196..cf67d455da48 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -238,11 +238,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 
 	/* 1 Timeout Interval = 125 * (clock period of SG clock) */
 	result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
-					 (u64)125000000);
-	if (result > 255)
-		result = 255;
-
-	return result;
+					 XAXIDMA_DELAY_SCALE);
+	return min(result, FIELD_MAX(XAXIDMA_DELAY_MASK));
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


