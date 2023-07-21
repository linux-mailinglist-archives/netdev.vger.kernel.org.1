Return-Path: <netdev+bounces-19801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBC75C5EE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AF31C21670
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60141D303;
	Fri, 21 Jul 2023 11:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7461E507
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:34:31 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742621FD7
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=miC7CmzG9MtFEEzRMrL1rcuMOoqFJtoDWLMwaPRJqb8=; b=DMHXxpECG+EBu1tCwLHJ+nzN6c
	vR/pf9n1m5gKiFRr7KDB1MJ7ew7w4yPMNp+VfLnNrJP7H8WuFBohRSawrrHVSSTL3UmJiC6bHtanu
	47JcyKPrR75VEd+E1BENmoosHSyd13p5sc0RGIcJyqd7+Ghqb0GHT5f7R1J5DEWknX85wlb/r8HGZ
	z20H6PTkeBLl2b5nXjWPtx8R24vxDtQPmcyrd/wFTLCtGnz8rN1/pUDHu50HUbO5F6qzwCld0n0Wo
	3iAqbgOo9a4L2DmB6TKgSPNMAicn5o2gxNMQjQdagbwB0FtdZ+sCmMyM2S8HTWGvVGLFXpvgtJA8A
	Pzdu1yvA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59156 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qMoOq-0003ns-0I;
	Fri, 21 Jul 2023 12:34:20 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qMoOq-000hhL-1o; Fri, 21 Jul 2023 12:34:20 +0100
In-Reply-To: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	 Ar__n__ __NAL <arinc.unal@arinc9.com>,
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
Subject: [PATCH net-next 2/4] net: ethernet: mtk_eth_soc: remove
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
Message-Id: <E1qMoOq-000hhL-1o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Jul 2023 12:34:20 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the .mac_pcs_get_state function, since as far as I can tell is
never called - no DT appears to specify an in-band-status management
nor SFP support for this driver.

Removal of this, along with the previous patch to remove the incorrect
clocking configuration, means that the driver becomes non-legacy, so
we can remove the "legacy_pre_march2020" status from this driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 35 ---------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 46b80ec21b58..0d5f47e2279e 100644
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
@@ -4334,8 +4301,6 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 
 	mac->phylink_config.dev = &eth->netdev[id]->dev;
 	mac->phylink_config.type = PHYLINK_NETDEV;
-	/* This driver makes use of state->speed in mac_config */
-	mac->phylink_config.legacy_pre_march2020 = true;
 	mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
-- 
2.30.2


