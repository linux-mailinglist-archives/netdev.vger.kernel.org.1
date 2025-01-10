Return-Path: <netdev+bounces-157256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F8A09BD4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F216B359
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD27214803;
	Fri, 10 Jan 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxQH/BGn"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D124B240
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537188; cv=none; b=CKgfbR087GhOQHBSrKhWOLDOQyIIOLlq7AQpFucPe7i+j56rhSMt3z8puawTDpZdWdoq9k27WXlnW6esuZv4A6U3WbPERvdwNgR4XLcYp99+PIVClF6F6H3nXRKb5sLGJNMmabky56S5rFeqkDRldghBl/lx6nk+xUW7ZDpug9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537188; c=relaxed/simple;
	bh=lafMeC3IVJwl2scqQhsRcwxfUALM68HREpRYFlnGP+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCrZsJh34z9MiJYEturfFSYbT2Leg484Q9yskLFSw7HsiBqniNzPCFYSYOud5UF40Lwv0r2ENWIFTtjd1g/zYzqm1mA8uzmPhNQYjaX+Gn/6Zhf3uwHMqkY04ybwxfZdK1ObeonRiYUth5m8lApx8xmWFoXE4UI6u13VIMrDyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxQH/BGn; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736537184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxtNKnXtGG2RerY8yHOdZZuD70UM+T9bfGtOFf/xcMw=;
	b=hxQH/BGnm/yae6MCS5tk3JyBGXqbZymGi8NcB29z/IYfHbg8adEhKSHkVkvP8m4/pCe8G/
	tOTl15Wy9KBOywtVA8y/UHnP0H56uJo22U8UiZ/W1OLLRdz2bczLRLCDenMjhtYZC05+zl
	leZOgT2jBQCr6JLN5pNVvxB28iSVucw=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 1/6] net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
Date: Fri, 10 Jan 2025 14:26:11 -0500
Message-Id: <20250110192616.2075055-2-sean.anderson@linux.dev>
In-Reply-To: <20250110192616.2075055-1-sean.anderson@linux.dev>
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
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
Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
---

(no changes since v2)

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 3 +++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index d64b8abcf018..a3f4f3e42587 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -120,6 +120,9 @@
 #define XAXIDMA_IRQ_ERROR_MASK		0x00004000 /* Error interrupt */
 #define XAXIDMA_IRQ_ALL_MASK		0x00007000 /* All interrupts */
 
+/* Constant to convert delay counts to microseconds */
+#define XAXIDMA_DELAY_SCALE		(125ULL * USEC_PER_SEC)
+
 /* Default TX/RX Threshold and delay timer values for SGDMA mode */
 #define XAXIDMA_DFT_TX_THRESHOLD	24
 #define XAXIDMA_DFT_TX_USEC		50
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ae743991117c..62638e2a086e 100644
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


