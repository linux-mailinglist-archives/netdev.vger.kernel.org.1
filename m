Return-Path: <netdev+bounces-47329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8E7E9AA9
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466F1280CC7
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAF61CA94;
	Mon, 13 Nov 2023 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFTOq4h4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC561CA93
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF6AC433C7;
	Mon, 13 Nov 2023 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873646;
	bh=ZR/DMZiyPsFy+qz8rEgRfcpH4vlRg6uq7If8iaVqgDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFTOq4h4BIeRZgABsCAYrICCROmZWg0yTLFR3qD5fmh+i5iCyUQPRjfQQGloe+CVs
	 lbKAIqSv4CnJYPudxvm8kyBTs91R49XO6RJ6A2xp5He0htSmV9aVPldmxwsGB8rwrZ
	 Ng8UTO3zR9LsV/fzOKooOF7ko/kbkiFsvfyj7jMGh0DDWKpUhwwuaLNF4zO8uCl6mk
	 7mkAxj25in57JrKMZ1+nhdbOpPMNwNOH3pkhgAqZbg/8E2U7YhD6qVQ/Xkna2IHyOZ
	 UIiwbsQI2ssUJURO2STSw9ZqQUUHJSBYnoN4h68JvpsNEGGhTmEknEc0p1n/tGDMMo
	 rSYeDRj26szDg==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	srk@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if Enable TX/RX channel fails
Date: Mon, 13 Nov 2023 13:07:08 +0200
Message-Id: <20231113110708.137379-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113110708.137379-1-rogerq@kernel.org>
References: <20231113110708.137379-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

k3_udma_glue_enable_rx/tx_chn returns error code on failure.
Bail out on error while enabling TX/RX channel.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 33 +++++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7c440899c93c..340f25bf33b1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -372,7 +372,7 @@ static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
-	int port_idx, i, ret;
+	int port_idx, i, ret, tx;
 	struct sk_buff *skb;
 	u32 val, port_mask;
 
@@ -453,13 +453,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		}
 		kmemleak_not_leak(skb);
 	}
-	k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
 
-	for (i = 0; i < common->tx_ch_num; i++) {
-		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[i].tx_chn);
-		if (ret)
-			return ret;
-		napi_enable(&common->tx_chns[i].napi_tx);
+	ret = k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
+	if (ret) {
+		dev_err(common->dev, "couldn't enable rx chn: %d\n", ret);
+		return ret;
+	}
+
+	for (tx = 0; tx < common->tx_ch_num; tx++) {
+		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[tx].tx_chn);
+		if (ret) {
+			dev_err(common->dev, "couldn't enable tx chn %d: %d\n",
+				tx, ret);
+			tx--;
+			goto fail_tx;
+		}
+		napi_enable(&common->tx_chns[tx].napi_tx);
 	}
 
 	napi_enable(&common->napi_rx);
@@ -470,6 +479,16 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
 	dev_dbg(common->dev, "cpsw_nuss started\n");
 	return 0;
+
+fail_tx:
+	while (tx >= 0) {
+		napi_disable(&common->tx_chns[tx].napi_tx);
+		k3_udma_glue_disable_tx_chn(common->tx_chns[tx].tx_chn);
+		tx--;
+	}
+
+	k3_udma_glue_disable_rx_chn(common->rx_chns.rx_chn);
+	return ret;
 }
 
 static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma);
-- 
2.34.1


