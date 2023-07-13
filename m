Return-Path: <netdev+bounces-17377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5415751664
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8161C211F6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9736A;
	Thu, 13 Jul 2023 02:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4A7C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:43:00 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B245E7E;
	Wed, 12 Jul 2023 19:42:58 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qJmI7-0005fA-2h;
	Thu, 13 Jul 2023 02:42:53 +0000
Date: Thu, 13 Jul 2023 03:42:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Lee <igvtee@gmail.com>
Subject: [PATCH] net: ethernet: mtk_eth_soc: handle probe deferral
Message-ID: <ZK9klTi7XoZZDMeE@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the call to of_get_ethdev_address to mtk_add_mac which is part of
the probe function and can hence itself return -EPROBE_DEFER should
of_get_ethdev_address return -EPROBE_DEFER. This allows us to entirely
get rid of the mtk_init function.

The problem of of_get_ethdev_address returning -EPROBE_DEFER surfaced
in situations in which the NVMEM provider holding the MAC address has
not yet be loaded at the time mtk_eth_soc is initially probed. In this
case probing of mtk_eth_soc should be deferred instead of falling back
to use a random MAC address, so once the NVMEM provider becomes
available probing can be repeated.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 29 ++++++++-------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 834c644b67db5..2d15342c260ae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3846,23 +3846,6 @@ static int mtk_hw_deinit(struct mtk_eth *eth)
 	return 0;
 }
 
-static int __init mtk_init(struct net_device *dev)
-{
-	struct mtk_mac *mac = netdev_priv(dev);
-	struct mtk_eth *eth = mac->hw;
-	int ret;
-
-	ret = of_get_ethdev_address(mac->of_node, dev);
-	if (ret) {
-		/* If the mac address is invalid, use random mac address */
-		eth_hw_addr_random(dev);
-		dev_err(eth->dev, "generated random MAC address %pM\n",
-			dev->dev_addr);
-	}
-
-	return 0;
-}
-
 static void mtk_uninit(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -4278,7 +4261,6 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-	.ndo_init		= mtk_init,
 	.ndo_uninit		= mtk_uninit,
 	.ndo_open		= mtk_open,
 	.ndo_stop		= mtk_stop,
@@ -4340,6 +4322,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->hw = eth;
 	mac->of_node = np;
 
+	err = of_get_ethdev_address(mac->of_node, eth->netdev[id]);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
+		/* If the mac address is invalid, use random mac address */
+		eth_hw_addr_random(eth->netdev[id]);
+		dev_err(eth->dev, "generated random MAC address %pM\n",
+			eth->netdev[id]->dev_addr);
+	}
+
 	memset(mac->hwlro_ip, 0, sizeof(mac->hwlro_ip));
 	mac->hwlro_ip_cnt = 0;
 
-- 
2.41.0

