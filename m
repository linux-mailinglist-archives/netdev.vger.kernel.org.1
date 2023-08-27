Return-Path: <netdev+bounces-30944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603EC78A07C
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839661C20937
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13835111B8;
	Sun, 27 Aug 2023 17:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE211184
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 17:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803DC433C7;
	Sun, 27 Aug 2023 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693157529;
	bh=ltTu/DB+KlPajN5lwh5plKx10tfYzoiX7IY7VpEw0h0=;
	h=From:To:Cc:Subject:Date:From;
	b=Qs4smJl2+4UT9+9d1Dr4t9wXicdbE2V7dmAnJ9rjAX14pcD6nqDSZ1JHb4CZfFO7M
	 BB02F4ihkuG9MmXfA22juun17Q7JWLTCOHKAu5SP8b/z6UR4Wfe6Wo6gGydBoRqUXO
	 ZqY65wmYbsUNUfgTsoTTcNP5opvKqFOAZfQH1o/EN0Ycy3LPVEZD5x5oeuPNf+88RP
	 8sU9qo7N0LscfhzC6kTAC1fPf0WkqRvCCZ6A0fL6jSd25zzc69piBdgaFy6PoK9Mw1
	 dN+JLbnE6pQZnJdX31BO8jBHoUQPw784WYsjFnIdH92RKQtdkLYyJSsIW5HroU4XLs
	 b1r5bVh3GFQtQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: add some more info in wed_txinfo_show handler
Date: Sun, 27 Aug 2023 19:31:41 +0200
Message-ID: <3390292655d568180b73d2a25576f61aa63310e5.1693157377.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some new info in Wireless Ethernet Dispatcher wed_txinfo_show
debugfs handler useful during debugging.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c | 11 ++++++++++-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h    |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index b244c02c5b51..5446d3be1c3a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -127,8 +127,17 @@ wed_txinfo_show(struct seq_file *s, void *data)
 		DUMP_WDMA_RING(WDMA_RING_RX(0)),
 		DUMP_WDMA_RING(WDMA_RING_RX(1)),
 
-		DUMP_STR("TX FREE"),
+		DUMP_STR("WED TX FREE"),
 		DUMP_WED(WED_RX_MIB(0)),
+		DUMP_WED_RING(WED_RING_RX(0)),
+		DUMP_WED(WED_WPDMA_RX_COHERENT_MIB(0)),
+		DUMP_WED(WED_RX_MIB(1)),
+		DUMP_WED_RING(WED_RING_RX(1)),
+		DUMP_WED(WED_WPDMA_RX_COHERENT_MIB(1)),
+
+		DUMP_STR("WED WPDMA TX FREE"),
+		DUMP_WED_RING(WED_WPDMA_RING_RX(0)),
+		DUMP_WED_RING(WED_WPDMA_RING_RX(1)),
 	};
 	struct mtk_wed_hw *hw = s->private;
 	struct mtk_wed_device *dev = hw->wed_dev;
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 0a50bb98c5ea..47ea69feb3b2 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -266,6 +266,8 @@ struct mtk_wdma_desc {
 
 #define MTK_WED_WPDMA_TX_MIB(_n)			(0x5a0 + (_n) * 4)
 #define MTK_WED_WPDMA_TX_COHERENT_MIB(_n)		(0x5d0 + (_n) * 4)
+#define MTK_WED_WPDMA_RX_MIB(_n)			(0x5e0 + (_n) * 4)
+#define MTK_WED_WPDMA_RX_COHERENT_MIB(_n)		(0x5f0 + (_n) * 4)
 
 #define MTK_WED_WPDMA_RING_TX(_n)			(0x600 + (_n) * 0x10)
 #define MTK_WED_WPDMA_RING_RX(_n)			(0x700 + (_n) * 0x10)
-- 
2.41.0


