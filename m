Return-Path: <netdev+bounces-216371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F36DB33536
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B59189EA29
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D92820D5;
	Mon, 25 Aug 2025 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ingqzI70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5028151E;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096630; cv=none; b=DxGZnOyOLbAJ0vXBDK2EHhdZ/pUnHy24p1Wgyh1VBjAoSBDOxTq7JWQ98g3VQWQVjLVl9kEr8zadPZ+1E2jZ94OcQMpn2niTX52HOaLnkc6nydvH2QzEyNz0gZk5mGb7zuDsmj6Ng0V9cqp0hdG270FhzPW1skfTQGKg4xxUV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096630; c=relaxed/simple;
	bh=wwBDo6blRSFBdQltLRz6YF2EM5a8biOLLNX0om5ESo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNYpN5togGrRoclL3qWGW0mE+PnPiRhaUDMAMfyWWDps3c5S2IeE947ugHIl4F+Cx9TCJsc0SE23XyQ/XjDhODeMRlBMh38SEanuzxp9jZlNW8qn5R3TngGxAxoYl2VMBzji8jGeRpF7da6fn1RbI9cbX0/TOjKJQk5B++ZPFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ingqzI70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA11C19421;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756096629;
	bh=wwBDo6blRSFBdQltLRz6YF2EM5a8biOLLNX0om5ESo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ingqzI70i6HXHgnFLwoVGatOuF3KLFBApNL2jOz7nyXw3URUo7qLEAapFvxs7HezL
	 UobJM/jjX1HbxOwIZHqs9VoIPGy7RkNqUw8szQwDGBtXnDvP1ySSO1BQa7MymOSbfu
	 gasDZdY50aT3n951/cf2YTgfQq91vIev3QpgUKDoDSOrRezbE6TUC+dlvcorn0vmWM
	 CMYyzuyyNzSIFzHMmvtwnCUof8uveJPsvx7BzJuvCfr4cDddG7BsOMDrP6HPO3o7Dh
	 cCjH+0mjuOdCFsMOEzLWkWlpWWo3i57Nqb1nWCKpTzBJOxRVDsV/G0yngMRJW1e9Nd
	 q2ypFskKkk5pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E6CA0EED;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Mon, 25 Aug 2025 12:36:54 +0800
Subject: [PATCH net v3 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-xgmac-minor-fixes-v3-3-c225fe4444c0@altera.com>
References: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
In-Reply-To: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756096627; l=2589;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=ufHiTveJv2qBm24xiMB0gFsw0pu0zMd7hgFCJ9lPQkI=;
 b=J9xTvnesrv2sisMNAGCxcdrQoTHV2SLh3+3iW7faARF6ra+9ADLML6lJxH36GguS6UndD/PB5
 eTShfFdRmoiBgCrCLRf6pVPz270nXnPUja344HDqgLcK5teGx39zsAD
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Currently, in the AF_XDP transmit paths, the CIC bit of
TX Desc3 is set for all packets. Setting this bit for
packets transmitting through queues that don't support
checksum offloading causes the TX DMA to get stuck after
transmitting some packets. This patch ensures the CIC bit
of TX Desc3 is set only if the TX queue supports checksum
offloading.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa3d26c285025d01c72cef51add534fc722552b8..143e68639548f390e97b5a8dd09f3f4af12cec43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2585,6 +2585,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
+	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	struct xsk_buff_pool *pool = tx_q->xsk_pool;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc = NULL;
@@ -2672,7 +2673,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		}
 
 		stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
-				       true, priv->mode, true, true,
+				       csum, priv->mode, true, true,
 				       xdp_desc.len);
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
@@ -4987,6 +4988,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 {
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc;
 	dma_addr_t dma_addr;
@@ -5038,7 +5040,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
 
 	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       true, priv->mode, true, true,
+			       csum, priv->mode, true, true,
 			       xdpf->len);
 
 	tx_q->tx_count_frames++;

-- 
2.25.1



