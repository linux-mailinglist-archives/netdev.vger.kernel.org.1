Return-Path: <netdev+bounces-22127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338C76621A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D74C1C21765
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F919C;
	Fri, 28 Jul 2023 02:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B523CF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:51:38 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4B2686;
	Thu, 27 Jul 2023 19:51:32 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qPDZc-000096-2m;
	Fri, 28 Jul 2023 02:51:24 +0000
Date: Fri, 28 Jul 2023 03:51:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] wifi: mt76: support per-band MAC addresses from OF
 child nodes
Message-ID: <4958730e4f88b91442fa96365785d467fad502de.1690512516.git.daniel@makrotopia.org>
References: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With dual-band-dual-congruent front-ends which appear as two independent
radios it is desirable to assign a per-band MAC address from device-tree,
eg. using nvmem-cells.
Support specifying MAC-address related properties in band-specific child
nodes, e.g.
        mt7915@0,0 {
                reg = <0x0000 0 0 0 0>;
                #addr-cells = <1>;
                #size-cells = <0>;

                band@0 {
                        /* 2.4 GHz */
                        reg = <0>;
                        nvmem-cells = <&macaddr 2>;
                        nvmem-cell-names = "mac-address";
                };

                band@1 {
                        /* 5 GHz */
                        reg = <1>;
                        nvmem-cells = <&macaddr 3>;
                        nvmem-cell-names = "mac-address";
                };
        };

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 36564930aef12..c2b3386cada1c 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -161,9 +161,25 @@ void
 mt76_eeprom_override(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct device_node *np = dev->dev->of_node;
+	struct device_node *np = dev->dev->of_node, *band_np;
+	bool found_mac = false;
+	u32 reg;
+	int ret;
+
+	for_each_child_of_node(np, band_np) {
+		ret = of_property_read_u32(band_np, "reg", &reg);
+		if (ret)
+			continue;
+
+		if (reg == phy->band_idx) {
+			found_mac = !of_get_mac_address(band_np, phy->macaddr);
+			of_node_put(band_np);
+			break;
+		}
+	}
 
-	of_get_mac_address(np, phy->macaddr);
+	if (!found_mac)
+		of_get_mac_address(np, phy->macaddr);
 
 	if (!is_valid_ether_addr(phy->macaddr)) {
 		eth_random_addr(phy->macaddr);
-- 
2.41.0

