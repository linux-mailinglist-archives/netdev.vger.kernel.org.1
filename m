Return-Path: <netdev+bounces-225579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC98FB95A48
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05127B16EE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB6321F5A;
	Tue, 23 Sep 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="icr6MKXc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D254321F22
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626774; cv=none; b=ZE39hj2WP/MFzxXEq8vd+NZeZ48guMRYyJuct6L0EIYBkUNoTlTEfGV3+VFeJUAL8SDDvF4UvHNS00t4WLBcVZylPsypRmtJbUldTcnOby6EXcUXeU4MzpZzAQS0cTYUIwq0zVWM9ZjAmOkeOSaIU3QNG4v+YyvcN8d3Z+Iac/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626774; c=relaxed/simple;
	bh=2US0PNCc7c6VcoC8sRy5Nd+ichAKK8v3XK9ADzk2SyY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=O/7DNWe5jBED0e/SpVzX2KOhume9aLION8MugeeeSH49wbmraJzmB81pKPvVbO/BwNwvUvYmPrFpipjWUjdjDrsR8Q79ACH9q5DpOSOP+xqmN9U7cf0hRo+nOYOSEBYlBCs2OsT8gXWu2FstqhopYCKh5eTlhqLSJzLyEZdEFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=icr6MKXc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S1UnBS/udUDw2oFqICie23zcbp8kBYeEaJ1ff4koAi4=; b=icr6MKXc7MHzrUWRDtWH6tq4er
	FCpPaZnDzajBGYQNNuvgiOQqc65bxFEajXzGbbW9IBDwOsKM0ai3NnpIVzQ169FPGfgr3Vr2Ort2S
	Mxi61kFMG0ZqyHaKAGhU77QtOi5rm6F7KP0Q2KHK4My9U7X8zqMnI+DT0bhBipZM7alHgXl/FyR5m
	6wtMtmDAcr4gV7a4nE0V/6HbxeXem2ElBlFTm8dbqHFNYzaC4s6q4d3AvFnony8FXw2/bEIIPijDX
	DHDeozJIBLS/bI5MAF2GoVT+wUgkDa0fxDUIQfxx7Y1vd+rJi4e4b0BiXCbGYpoZI3oDAtXYCybkF
	EpafMbsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38072 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v119p-0000000078L-1iX6;
	Tue, 23 Sep 2025 12:26:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v119o-0000000773y-21gs;
	Tue, 23 Sep 2025 12:26:04 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/6] net: stmmac: move xpcs clause 73 test into
 stmmac_init_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v119o-0000000773y-21gs@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:26:04 +0100

We avoid binding a PHY if the XPCS is using clause 73 negotiation.
Rather than having this complexity in __stmmac_open(), move it to
stmmac_init_phy() instead. There is no point checking the XPCS
state this unless phylink wants a PHY, so place this appropriately.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 517b25b2bcae..3b47d4ca24ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1112,6 +1112,7 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 static int stmmac_init_phy(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *phy_fwnode;
 	struct fwnode_handle *fwnode;
 	int ret;
@@ -1119,6 +1120,10 @@ static int stmmac_init_phy(struct net_device *dev)
 	if (!phylink_expects_phy(priv->phylink))
 		return 0;
 
+	if (priv->hw->xpcs &&
+	    xpcs_get_an_mode(priv->hw->xpcs, mode) == DW_AN_C73)
+		return 0;
+
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
@@ -3926,7 +3931,6 @@ static int __stmmac_open(struct net_device *dev,
 			 struct stmmac_dma_conf *dma_conf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int mode = priv->plat->phy_interface;
 	u32 chan;
 	int ret;
 
@@ -3934,15 +3938,12 @@ static int __stmmac_open(struct net_device *dev,
 	if (!priv->tx_lpi_timer)
 		priv->tx_lpi_timer = eee_timer * 1000;
 
-	if ((!priv->hw->xpcs ||
-	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
-		ret = stmmac_init_phy(dev);
-		if (ret) {
-			netdev_err(priv->dev,
-				   "%s: Cannot attach to PHY (error: %d)\n",
-				   __func__, ret);
-			return ret;
-		}
+	ret = stmmac_init_phy(dev);
+	if (ret) {
+		netdev_err(priv->dev,
+			   "%s: Cannot attach to PHY (error: %d)\n",
+			   __func__, ret);
+		return ret;
 	}
 
 	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
-- 
2.47.3


