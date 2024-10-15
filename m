Return-Path: <netdev+bounces-135474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA499E0C4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AA1C21A49
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78141CACF9;
	Tue, 15 Oct 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XB+ebulV"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692518A6A9;
	Tue, 15 Oct 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980309; cv=none; b=pzeFLtT/E8aq7KOvq5gtLMBqah6hpPksLmz0gpqaw9xC2EkV7ueYUIaxDk3a/coPCkVEOOALXO43Vy9mCKpBRm2hwRoa0q3U/09Pz1NtZ0nJRnqXW9jcHlVsX2ZsYCBsJBVF+DfK0iw1w51dF7eEgDqaVUAGxfIlYNHL6Kyz2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980309; c=relaxed/simple;
	bh=NbHr+sWsDbevorbbFL4J6SWjgNNZ/c1Zpl7MLnFkww8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTk7SLrX/+uG5zMiqyDX0wFPb3osVNj14+tS2Ro0qZuiqNYRE4HVGu9gKFYcpmsInHYptBqT4d/880s9c+/h8g92y2wL1iQwaypHYgvwnFHZ423pTSokyPxOhJ6vDALXWp4maLVl+sNMewFL0mCJbPz7LPopyFArClAR78y8w00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XB+ebulV; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y+olST8w9L1bmQWPvzyB/DLsZjm8Pf3Fnd+REUY4aOQ=; b=XB+ebulVCajAqXaxMgX/MKVrqq
	lA7o3FZP43feVJV9Ul2yrWBLfPf9RjMpY7QIOLjcf+i+/nUyiV9H1KRUEA+vdYzjEO12BCJZd16np
	tX5dL4xQIMjTeCur1G3N6g7q7F6FJqD8Wv5pNoXTuzjFu1rI7llYzM15DxOGsGLw7Grs=;
Received: from p54ae9bfc.dip0.t-ipconnect.de ([84.174.155.252] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1t0ckm-0091io-0H;
	Tue, 15 Oct 2024 10:18:04 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix memory corruption during fq dma init
Date: Tue, 15 Oct 2024 10:17:55 +0200
Message-ID: <20241015081755.31060-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop responsible for allocating up to MTK_FQ_DMA_LENGTH buffers must
only touch as many descriptors, otherwise it ends up corrupting unrelated
memory. Fix the loop iteration count accordingly.

Fixes: c57e55819443 ("net: ethernet: mtk_eth_soc: handle dma buffer size soc specific")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..ed7313c10a05 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1171,7 +1171,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 		if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
 			return -ENOMEM;
 
-		for (i = 0; i < cnt; i++) {
+		for (i = 0; i < len; i++) {
 			struct mtk_tx_dma_v2 *txd;
 
 			txd = eth->scratch_ring + (j * MTK_FQ_DMA_LENGTH + i) * soc->tx.desc_size;
-- 
2.47.0


