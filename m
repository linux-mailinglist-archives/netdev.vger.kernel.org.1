Return-Path: <netdev+bounces-124652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1082596A60B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46A32822A7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7718DF78;
	Tue,  3 Sep 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2C4phJd"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C46F9DF;
	Tue,  3 Sep 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386470; cv=none; b=mEPmcRrbQnbRbVcRPGPgcYtGB97//kGVu1fy4/fWBmC6rTTr63Eoshf+Sml/ibmWeUUFJTIy4/iNNcvNF5txG21Rwdo57oaDgKMBFcngohuGzumos22jSZJKYiLHJoyEpO4KlPM9rIuVEYjiw98htzztfhLX/D17BnVziKtZ4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386470; c=relaxed/simple;
	bh=/wfJeA9eaB7zEX5ZIxwXVNMe+j14r4V9KWqcxXTXAqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkB7A8uZvAW0l2Biik4vGRR6WsQTqAYeFwRFOL9c5jMHl1CzXmKY83jAbZSBHrYQSrILVYlzSBbrhzVQmv6PKpVj0dZIWt1vlJsjW7rna7oTn+dnziCbz9tzUQ1+j1Ucd/NPeb0vYWjS9lfndcHkk6e2mLN2wJ+lfyqFHCpLTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2C4phJd; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725386467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UrUsvRPk7SD8RHsYmK0LmFLnoRhb3Lw1NzhdFWeQiI=;
	b=t2C4phJdAOId0vLOoHlL+usNLJegUscDYiCzD1lfotVr45sXlovabJjB7vVeh93eTm6TZe
	h+bEg8efdEXfJNOcnaD++iroqPo82OwZDPjTfgGQ9lEQRjj+R/fV5FlXiNSC8pIG1YUFnW
	W0ief0g9Do1X+IC0iNykxURDvSOca+g=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andy Chiu <andy.chiu@sifive.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count overflow
Date: Tue,  3 Sep 2024 14:00:59 -0400
Message-Id: <20240903180059.4134461-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If coalesce_count is greater than 255 it will not fit in the register and
will overflow. Clamp it to 255 for more-predictable results.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9aeb7b9f3ae4..5f27fc1c4375 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 static void axienet_dma_start(struct axienet_local *lp)
 {
 	/* Start updating the Rx channel control register */
-	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
+	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
+			 XAXIDMA_COALESCE_SHIFT) |
 			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
 	/* Only set interrupt delay timer if not generating an interrupt on
 	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
@@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local *lp)
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
 
 	/* Start updating the Tx channel control register */
-	lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
+	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
+			 XAXIDMA_COALESCE_SHIFT) |
 			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
 	/* Only set interrupt delay timer if not generating an interrupt on
 	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
-- 
2.35.1.1320.gc452695387.dirty


