Return-Path: <netdev+bounces-29768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F707849AE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23F0281180
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17B1DDED;
	Tue, 22 Aug 2023 18:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1601DDC3
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:50:44 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5538ACD6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hVOCuc5IYYSeGY5UU7ESNANeOTu+gCFR0FT1EEk+RqY=; b=OsfL23fKVLXUJo+ZsF5lvgJKSO
	pBZhMDBfgFyIjIqVsv4peZBbORaaZUKKqcfdndD9tAkMtg5GRKeL2PGHOE8Nqo/VIh8wnVahTd+w8
	IvUqgsL/KqUpCuQyZBCky+FFhlcYgCLcIlYtj5kBVbLF21cVGcn7Ls0+j+4Mu19ZWMg0v9T+kRIzb
	tGoQrTatHpz9ddVDi5q7TyrvNmZ1Y25oqPg5gCrle3G6zlar1x6sZFvTx8Xm+vnKJBcN0j9e+tG+C
	I9Qa5WZZrEKseIJF1H5mxGnF2oRQmYoITm3q2vNhjNbbJRMAhDeyzYUksbSqfyPfOISzrl9POh3Kh
	VGYoZOPA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46866 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qYWSY-0001si-0d;
	Tue, 22 Aug 2023 19:50:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qYWSY-005fY9-Gm; Tue, 22 Aug 2023 19:50:34 +0100
In-Reply-To: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
References: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 7/9] net: stmmac: move gmac4 specific phylink
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
Message-Id: <E1qYWSY-005fY9-Gm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Aug 2023 19:50:34 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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


