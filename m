Return-Path: <netdev+bounces-135604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8A99E537
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29321C22966
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03C1EF08C;
	Tue, 15 Oct 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="aD1+u7GX"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB91EBA0B;
	Tue, 15 Oct 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990598; cv=none; b=mQYfcZJ6kJQLjUtlqHwv2IWdHHGFnP51X04GelXzgSKi6eAZyCDfs8Crcif6rUxtouoJzvhWsKR0nj6IP2gBh/iriGTZHaQ2km6SeFPXnIgGhsM8ePlxceC9sq/uMhY8WnXI/VkdNWNTSavSdaiyVC3x3uSLtYT8NdaX6ZPMkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990598; c=relaxed/simple;
	bh=7yEZgy3yzYjwO9hiRzcUmZ+0/A5KAGSrL/AaZJ6BsMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3iESYSr8Q+JIAjBuBNqTWaiJ9wnuHTud0RzSuIVGC9ehV4bUb0xYmn+u4iKugIhiqeKDCNuFvE8z0lIsTqWn930Y0UmE5UiBpaXj35tLfyEstIBwX1tMq2aiVDAmni/l8lnxxocfz6J11lkt+e5VbAkMruJqpdJKV3/aJKZwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=aD1+u7GX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FT6atkLxU1yFTV6GUySFpuOea9HLCvMp3YdIekBRWKI=; b=aD1+u7GXCpWjfSmqmQjmJhwpN6
	Uz8ZkaHBcyaKEkE4nxpT+yAfBSmu/sm5ZrcuhKXnAXbJ0f35IdbnjnRn82RwumQu6nGrZhGiRbvXs
	Zmz9PhpuhMXWHVU5ylyUHDCHw01JBL84acUYr6r0GJcHF+Qa35Sf5UwVjd63L663KN/M=;
Received: from p54ae9bfc.dip0.t-ipconnect.de ([84.174.155.252] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1t0fQs-0096bC-2a;
	Tue, 15 Oct 2024 13:09:42 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Frank Wunderlich <frank-w@public-files.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 3/4] net: ethernet: mtk_eth_soc: reduce rx ring size for older chipsets
Date: Tue, 15 Oct 2024 13:09:37 +0200
Message-ID: <20241015110940.63702-3-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015110940.63702-1-nbd@nbd.name>
References: <20241015110940.63702-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c57e55819443 ("net: ethernet: mtk_eth_soc: handle dma buffer
size soc specific") resolved some tx timeout issues by bumping FQ and
tx ring sizes from 512 to 2048 entries (the value used in the MediaTek
SDK), however it also changed the rx ring size for all chipsets in the
same way.

Based on a few tests, it seems that a symmetric rx/tx ring size of 2048
really only makes sense on MT7988, which is capable of 10G ethernet links.

Older chipsets are typically deployed in systems that are more memory
constrained and don't actually need the larger rings to handle received
packets.

In order to reduce wasted memory set the ring size based on the SoC to
the following values:
- 2048 on MT7988
- 1024 on MT7986
- 512 (previous value) on everything else, except:
- 256 on RT5350 (the oldest supported chipset)

Fixes: c57e55819443 ("net: ethernet: mtk_eth_soc: handle dma buffer size soc specific")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 4e4ece5e257a..58b80af7230b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5140,7 +5140,7 @@ static const struct mtk_soc_data mt2701_data = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5168,7 +5168,7 @@ static const struct mtk_soc_data mt7621_data = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5198,7 +5198,7 @@ static const struct mtk_soc_data mt7622_data = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5227,7 +5227,7 @@ static const struct mtk_soc_data mt7623_data = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5253,7 +5253,7 @@ static const struct mtk_soc_data mt7629_data = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5285,7 +5285,7 @@ static const struct mtk_soc_data mt7981_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(512),
 	},
 };
 
@@ -5315,7 +5315,7 @@ static const struct mtk_soc_data mt7986_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(1K),
 	},
 };
 
@@ -5368,7 +5368,7 @@ static const struct mtk_soc_data rt5350_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_PDMA,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
-		.dma_size = MTK_DMA_SIZE(2K),
+		.dma_size = MTK_DMA_SIZE(256),
 	},
 };
 
-- 
2.47.0


