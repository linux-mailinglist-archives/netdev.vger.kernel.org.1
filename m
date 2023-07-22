Return-Path: <netdev+bounces-20158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBDE75DE8B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B3F1C20A45
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B19808;
	Sat, 22 Jul 2023 20:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5258A5D
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 20:33:03 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9331B8
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b7o6K/jJA6ZoR8HhDQF21C/HKxRRr7+HtxLNhNXpxl0=; b=wra8zcHqo7cgkMOWQn8yOl7bG5
	1Bo5ouHdNXGqNG+1d1ln7V5K4RdheSSTsKrK4+du/09H1jQjfMjrrxacxSCZ8/+sGgryXSyur/NB2
	cCMaMHbo1jjeY2yixHtM8wlRwpxkc+W2zBEN5axKDbXVGI/pIjSVcoVzZU+jMdp8bevfjVkMdky2v
	jXUZuvV7c1dYF8SL2WPi+G6LwJSpQ73d3vIcM9wNgjcQA0tsrFXjv5MEhK+W7wuio6ofdGt907XOD
	CYET3NyklfxRgR9V7iMi5HZuwoohfTZYHU2Cy+QOejTZeragsNSjVsKVB6zZus0cz/6peilnlJbVW
	vi+wTxHA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qNJHa-000666-2Y;
	Sat, 22 Jul 2023 21:32:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qNJHa-000kFZ-PS; Sat, 22 Jul 2023 21:32:54 +0100
In-Reply-To: <ZLw8DoRskRXLQK37@shell.armlinux.org.uk>
References: <ZLw8DoRskRXLQK37@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	 =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	 Frank Wunderlich <frank-w@public-files.de>,
	 David Woodhouse <dwmw@amazon.co.uk>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>,
	John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next v2 2/4] net: ethernet: mtk_eth_soc: remove
 mac_pcs_get_state and modernise
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qNJHa-000kFZ-PS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 22 Jul 2023 21:32:54 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the .mac_pcs_get_state function, since as far as I can tell is
never called - no DT appears to specify an in-band-status management
nor SFP support for this driver.

Removal of this, along with the previous patch to remove the incorrect
clocking configuration, means that the driver becomes non-legacy, so
we can remove the "legacy_pre_march2020" status from this driver.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 35 ---------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fe8b7e38decc..7490d48000c2 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -568,38 +568,6 @@ static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
-static void mtk_mac_pcs_get_state(struct phylink_config *config,
-				  struct phylink_link_state *state)
-{
-	struct mtk_mac *mac = container_of(config, struct mtk_mac,
-					   phylink_config);
-	u32 pmsr = mtk_r32(mac->hw, MTK_MAC_MSR(mac->id));
-
-	state->link = (pmsr & MAC_MSR_LINK);
-	state->duplex = (pmsr & MAC_MSR_DPX) >> 1;
-
-	switch (pmsr & (MAC_MSR_SPEED_1000 | MAC_MSR_SPEED_100)) {
-	case 0:
-		state->speed = SPEED_10;
-		break;
-	case MAC_MSR_SPEED_100:
-		state->speed = SPEED_100;
-		break;
-	case MAC_MSR_SPEED_1000:
-		state->speed = SPEED_1000;
-		break;
-	default:
-		state->speed = SPEED_UNKNOWN;
-		break;
-	}
-
-	state->pause &= (MLO_PAUSE_RX | MLO_PAUSE_TX);
-	if (pmsr & MAC_MSR_RX_FC)
-		state->pause |= MLO_PAUSE_RX;
-	if (pmsr & MAC_MSR_TX_FC)
-		state->pause |= MLO_PAUSE_TX;
-}
-
 static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 			      phy_interface_t interface)
 {
@@ -722,7 +690,6 @@ static void mtk_mac_link_up(struct phylink_config *config,
 
 static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_select_pcs = mtk_mac_select_pcs,
-	.mac_pcs_get_state = mtk_mac_pcs_get_state,
 	.mac_config = mtk_mac_config,
 	.mac_finish = mtk_mac_finish,
 	.mac_link_down = mtk_mac_link_down,
@@ -4327,8 +4294,6 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 
 	mac->phylink_config.dev = &eth->netdev[id]->dev;
 	mac->phylink_config.type = PHYLINK_NETDEV;
-	/* This driver makes use of state->speed in mac_config */
-	mac->phylink_config.legacy_pre_march2020 = true;
 	mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
-- 
2.30.2


