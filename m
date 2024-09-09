Return-Path: <netdev+bounces-126735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E01972596
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FC2283610
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C718DF69;
	Mon,  9 Sep 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fokhnc60"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A318D64B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923361; cv=none; b=K94ARFzMLTIugAZQlwFZReF4K+rbkp+O5FDAodDoK0mjfQCmUhYtigow/RyLvXt9OAhjM4h2r4d3/PZmkd2ozHa2WkXAb7h0iWDmjO4dKkLdvB2jn+WBWu6yUDRhEhWp9F1WtsLfaKIHhoYtVi6yl3EQI4DknEjei4rd9W0KS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923361; c=relaxed/simple;
	bh=XBlmBZ8LFNCjnsRbnix/NcPqlypUOFlvAhyzhCweOFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsDqfgfZFBjEFlHnnu2DkI1er52RrcmFhwt0Cnt8SVT6t9WAg9BXuQjyojOG8j7AhwSzJykfoqiUQ5qlIG0YywWTUeeRTu8tyncDmRXz+j6yhCtxvCdObusszI/kRYJww1Vh89op3cWyNdFvlPr6xJv7FzyL6mHzcNmcPxLuos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fokhnc60; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725923355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oYqzLmU8Wwh+yV2OBnKEU0j9ng/GD4hfiT1RPK+msTg=;
	b=fokhnc608jJF/K2dN/Aq8rKKEJ2UXmEzP/3e38gbFBr/MY6gB2YUsF7heYJMyGirCtau99
	TYrQFQ/6YG4PPccrwhSQJ4CrvjxLGow9O3ieQNuuBsunpKWOH+/UvJ0C8/kMbQLU9Hy5lR
	Dn7XxZVg/T74ba+8ng8uRF3zbBcF7Uc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Andy Chiu <andy.chiu@sifive.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet count overflow
Date: Mon,  9 Sep 2024 19:09:08 -0400
Message-Id: <20240909230908.1319982-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If coalece_count is greater than 255 it will not fit in the register and
will overflow. This can be reproduced by running

    # ethtool -C ethX rx-frames 256

which will result in a timeout of 0us instead. Fix this by clamping the
counts to the maximum value.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
---

Changes in v2:
- Use FIELD_MAX to extract the max value from the mask
- Expand the commit message with an example on how to reproduce this
  issue

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 5 ++---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 1223fcc1a8da..54db69893565 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -109,11 +109,10 @@
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
 
-#define XAXIDMA_DELAY_MASK		0xFF000000 /* Delay timeout counter */
-#define XAXIDMA_COALESCE_MASK		0x00FF0000 /* Coalesce counter */
+#define XAXIDMA_DELAY_MASK		((u32)0xFF000000) /* Delay timeout counter */
+#define XAXIDMA_COALESCE_MASK		((u32)0x00FF0000) /* Coalesce counter */
 
 #define XAXIDMA_DELAY_SHIFT		24
-#define XAXIDMA_COALESCE_SHIFT		16
 
 #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion intr */
 #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay interrupt */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9eb300fc3590..89b63695293d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -252,7 +252,9 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 static void axienet_dma_start(struct axienet_local *lp)
 {
 	/* Start updating the Rx channel control register */
-	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
+	lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
+				   min(lp->coalesce_count_rx,
+				       FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
 			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
 	/* Only set interrupt delay timer if not generating an interrupt on
 	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
@@ -264,7 +266,9 @@ static void axienet_dma_start(struct axienet_local *lp)
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
 
 	/* Start updating the Tx channel control register */
-	lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
+	lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
+				   min(lp->coalesce_count_tx,
+				       FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
 			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
 	/* Only set interrupt delay timer if not generating an interrupt on
 	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
-- 
2.35.1.1320.gc452695387.dirty


