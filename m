Return-Path: <netdev+bounces-29721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A497847A2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68109281180
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2801C9EC;
	Tue, 22 Aug 2023 16:31:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA21E524
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:31:42 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E2193;
	Tue, 22 Aug 2023 09:31:41 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qYUI0-0000GQ-18;
	Tue, 22 Aug 2023 16:31:32 +0000
Date: Tue, 22 Aug 2023 17:31:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 1/4] net: ethernet: mtk_eth_soc: fix register
 definitions for MT7988
Message-ID: <1c8da012e2ca80939906d85f314138c552139f0f.1692721443.git.daniel@makrotopia.org>
References: <cover.1692721443.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692721443.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

More register macros need to be adjusted for the 3rd GMAC on MT7988.
Account for added bit in SYSCFG0_SGMII_MASK.

Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 4a2470fbad2cf..8d2d35b322351 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -133,10 +133,12 @@
 #define MTK_GDMA_XGDM_SEL	BIT(31)
 
 /* Unicast Filter MAC Address Register - Low */
-#define MTK_GDMA_MAC_ADRL(x)	(0x508 + (x * 0x1000))
+#define MTK_GDMA_MAC_ADRL(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x548 : 0x508 + (_x * 0x1000); })
 
 /* Unicast Filter MAC Address Register - High */
-#define MTK_GDMA_MAC_ADRH(x)	(0x50C + (x * 0x1000))
+#define MTK_GDMA_MAC_ADRH(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x54C : 0x50C + (_x * 0x1000); })
 
 /* FE global misc reg*/
 #define MTK_FE_GLO_MISC         0x124
@@ -503,7 +505,7 @@
 #define ETHSYS_SYSCFG0		0x14
 #define SYSCFG0_GE_MASK		0x3
 #define SYSCFG0_GE_MODE(x, y)	(x << (12 + (y * 2)))
-#define SYSCFG0_SGMII_MASK     GENMASK(9, 8)
+#define SYSCFG0_SGMII_MASK     GENMASK(9, 7)
 #define SYSCFG0_SGMII_GMAC1    ((2 << 8) & SYSCFG0_SGMII_MASK)
 #define SYSCFG0_SGMII_GMAC2    ((3 << 8) & SYSCFG0_SGMII_MASK)
 #define SYSCFG0_SGMII_GMAC1_V2 BIT(9)
-- 
2.41.0

