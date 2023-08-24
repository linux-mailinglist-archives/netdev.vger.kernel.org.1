Return-Path: <netdev+bounces-30369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042A787072
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DD281552
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311E11C8C;
	Thu, 24 Aug 2023 13:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8782288FD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:38:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C3A8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hVOCuc5IYYSeGY5UU7ESNANeOTu+gCFR0FT1EEk+RqY=; b=mgHCtcEt19F0fSW7QXJEptyhG9
	7ja+0yW8Bn8sCCwy56EadMjEk8TcdgjMIqOsp0O/hXJKevPMqNpuOqC+fC0O67NbGA2PNesLiItBM
	q4u6bS5eq0thKOtaiKpr/Mc7Ahx7SEaR5AiB1VxErhOcLIgR7QsERP9k+oVHAhgYYQvmvg6PnuNQU
	iho0910gOvZNY2zk1ZdmOBe6TifH1thQfgm7Wb5Dlx1Rzb59pok2csXEx1owmmvB4U+9OPKGt9q1+
	Y6tB6zdQE6jw4xYRbBvvLDApfGeWAdWUGRtn2QdpTJC1R7dbksANuO+dn7M630tMn5EKveMFYOP4H
	S7WnoZcw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38124 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZAXY-0004Dk-0G;
	Thu, 24 Aug 2023 14:38:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZAXY-005pUJ-Ez; Thu, 24 Aug 2023 14:38:24 +0100
In-Reply-To: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 07/10] net: stmmac: move gmac4 specific phylink
 capabilities to gmac4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZAXY-005pUJ-Ez@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 24 Aug 2023 14:38:24 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the setup of gmac4 speicifc phylink capabilities into gmac4 code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 03b1c5a97826..c6ff1fa0e04d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -68,6 +68,11 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 		init_waitqueue_head(&priv->tstamp_busy_wait);
 }
 
+static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
+{
+	priv->phylink_config.mac_capabilities |= MAC_2500FD;
+}
+
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
 				   u8 mode, u32 queue)
 {
@@ -1131,6 +1136,7 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
+	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1173,6 +1179,7 @@ const struct stmmac_ops dwmac4_ops = {
 
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
+	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1221,6 +1228,7 @@ const struct stmmac_ops dwmac410_ops = {
 
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
+	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9cf6aecdddf..0b02845e7e9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1227,9 +1227,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
 
-	if (priv->plat->has_gmac4) {
-		priv->phylink_config.mac_capabilities |= MAC_2500FD;
-	} else if (priv->plat->has_xgmac) {
+	if (priv->plat->has_xgmac) {
 		priv->phylink_config.mac_capabilities |= MAC_2500FD;
 		priv->phylink_config.mac_capabilities |= MAC_5000FD;
 		priv->phylink_config.mac_capabilities |= MAC_10000FD;
-- 
2.30.2


