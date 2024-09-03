Return-Path: <netdev+bounces-124673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB096A6C2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9108A1F21FF0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F91925BF;
	Tue,  3 Sep 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugehQBYB"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB42192587
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389025; cv=none; b=Zze3trewuUdF3mTW8a6o5W0YQDSEqRjmrmYk7PW6FdGusNVMhwUJGzwMd8bss+AggUSlWQLlCR2MNAe7SyGFJ2lvZyCvJYiLTfgYnpLXQ09Rl6T9TIluf5GJH6QBtPMEsgdJHS8ts62X/IQ9ba2OgqX2woQgiycKdDvPS6a/jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389025; c=relaxed/simple;
	bh=cIDDSpZqdWOsRvNfYimdfZv8iQfBpc64WvolZFWHh68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8tan5DfJhKhPUaRYlABxB+xd2XiCDMqtF1LJB89sd2T2dPvusCS5dvoSoh6K7p+BB4zpphKqdpm/TWp3dt+LCncLJCz840t9xxT+lSyk7M5ykfdUK7TUsi7E907ntIzhIlgRTVwwTInOxP3S73RNp2pkrNiw7/BhStHI4EmwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ugehQBYB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miVlX6AWASpn/Rgevxfm45wsjcuK0SlwyRSflTtdySU=;
	b=ugehQBYBI5JaPFAjPagyMl042nSEprLVnVKT6vj3dJoqXxPZ+eUrThmyZairmugvjcakf9
	wftGOb5lDL8Alh3Qz9mcEB4HqSn5LbTxqovwJSTjgS5Gzs2I4gZrscUqwMBQ1blHpuCQV1
	aLnHp+XgIJa9gyHdJemulrL1ilzrBy4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum variables
Date: Tue,  3 Sep 2024 14:43:32 -0400
Message-Id: <20240903184334.4150843-2-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-1-sean.anderson@linux.dev>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These variables are set but never used. Remove them

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet.h      |  5 -----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index c301dd2ee083..b9d2d7319220 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -527,8 +527,6 @@ struct skbuf_dma_descriptor {
  *		  supported, the maximum frame size would be 9k. Else it is
  *		  1522 bytes (assuming support for basic VLAN)
  * @rxmem:	Stores rx memory size for jumbo frame handling.
- * @csum_offload_on_tx_path:	Stores the checksum selection on TX side.
- * @csum_offload_on_rx_path:	Stores the checksum selection on RX side.
  * @coalesce_count_rx:	Store the irq coalesce on RX side.
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
@@ -606,9 +604,6 @@ struct axienet_local {
 	u32 max_frm_size;
 	u32 rxmem;
 
-	int csum_offload_on_tx_path;
-	int csum_offload_on_rx_path;
-
 	u32 coalesce_count_rx;
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fe6a0e2e463f..60ec430f3eb0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2631,38 +2631,26 @@ static int axienet_probe(struct platform_device *pdev)
 	if (!ret) {
 		switch (value) {
 		case 1:
-			lp->csum_offload_on_tx_path =
-				XAE_FEATURE_PARTIAL_TX_CSUM;
 			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
 			/* Can checksum TCP/UDP over IPv4. */
 			ndev->features |= NETIF_F_IP_CSUM;
 			break;
 		case 2:
-			lp->csum_offload_on_tx_path =
-				XAE_FEATURE_FULL_TX_CSUM;
 			lp->features |= XAE_FEATURE_FULL_TX_CSUM;
 			/* Can checksum TCP/UDP over IPv4. */
 			ndev->features |= NETIF_F_IP_CSUM;
 			break;
-		default:
-			lp->csum_offload_on_tx_path = XAE_NO_CSUM_OFFLOAD;
 		}
 	}
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum", &value);
 	if (!ret) {
 		switch (value) {
 		case 1:
-			lp->csum_offload_on_rx_path =
-				XAE_FEATURE_PARTIAL_RX_CSUM;
 			lp->features |= XAE_FEATURE_PARTIAL_RX_CSUM;
 			break;
 		case 2:
-			lp->csum_offload_on_rx_path =
-				XAE_FEATURE_FULL_RX_CSUM;
 			lp->features |= XAE_FEATURE_FULL_RX_CSUM;
 			break;
-		default:
-			lp->csum_offload_on_rx_path = XAE_NO_CSUM_OFFLOAD;
 		}
 	}
 	/* For supporting jumbo frames, the Axi Ethernet hardware must have
-- 
2.35.1.1320.gc452695387.dirty


