Return-Path: <netdev+bounces-32743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BA79A025
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 23:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7485828107B
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8458BF2;
	Sun, 10 Sep 2023 21:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FE8BE5
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 21:41:04 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12037188;
	Sun, 10 Sep 2023 14:41:02 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qfSAe-0005D1-19;
	Sun, 10 Sep 2023 21:40:44 +0000
Date: Sun, 10 Sep 2023 22:40:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2] net: ethernet: mtk_eth_soc: fix uninitialized variable
Message-ID: <30044cf16ff83f73e5ef852c25682e9fde63af51.1694376191.git.daniel@makrotopia.org>
References: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Variable dma_addr in function mtk_poll_rx can be uninitialized on
some of the error paths. In practise this doesn't matter, even random
data present in uninitialized stack memory can safely be used in the
way it happens in the error path.

However, in order to make Smatch happy make sure the variable is
always initialized.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: initialize with DMA_MAPPING_ERROR instead of NULL

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 31090490d47ce..6145ddcff206c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2119,11 +2119,11 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	u8 *data, *new_data;
 	struct mtk_rx_dma_v2 *rxd, trxd;
 	int done = 0, bytes = 0;
+	dma_addr_t dma_addr = DMA_MAPPING_ERROR;
 
 	while (done < budget) {
 		unsigned int pktlen, *rxdcsum;
 		struct net_device *netdev;
-		dma_addr_t dma_addr;
 		u32 hash, reason;
 		int mac = 0;
 
@@ -2300,7 +2300,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		else
 			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA) &&
+		    likely(dma_addr != DMA_MAPPING_ERROR))
 			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
 
 		ring->calc_idx = idx;
-- 
2.42.0

