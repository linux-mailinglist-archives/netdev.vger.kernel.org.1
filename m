Return-Path: <netdev+bounces-154974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4DA00881
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC25161C2A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C291F9F5A;
	Fri,  3 Jan 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P7wgdPrI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52F1E00B6
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903038; cv=none; b=Z8n9Gs2CdsbX1cQNlQT0r7EDpbfUVSQuMCtcCDTfz753vxNQsj7IbaMzq5I/q9d04iX28P4KtK6BweP2ADiKOLxMUmvPZWNVeO78R/MhMnpBmb0Yf3MhxtdZhI2PlVYgNV/7Ihgwy0C2gma45UGfN2ocqFapUkx1oduXEbBz0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903038; c=relaxed/simple;
	bh=6PaK1/XeyGsW5Y/kkbKKS+wBHQ+2vv4jjl0jFinFRMA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Wpxf8OR2kO3dnVoaVe9MTgVixK2HtqkwiDTIDBB/7o1D218I5byVpvxkznUiiJbfF23Qt+9f3L7sCi3jhDId2Jk4bD3T1ZdkL+Gc56dFRtJ9ze6ipEOXqKX5ubkyV7KTXZYk1gPQ1EgcLsuqru/wLGUySqMP6HK41Ecl3VJUA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P7wgdPrI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4s396obXaI1f8Yz3z+7hU/+8e3s2TBg9V0/XcDUux8s=; b=P7wgdPrI4AcqfEfWWuDx1a/tNT
	0Ax1clrro5GRgNFgLC8VP3GtrZYGo/YJNafuQ01+Lgv6h+TC4LRtbGfBunbBWoEXzV/2KoggfwLiv
	vwD/IHr0bV/PVYwuhdIeTG9jn4q4zxkOemjdPO0SLtPXymx4W8tEc3dBKRPr0XPU4IPRBK+W/LEOf
	tbwCumzIj9YiwFyYiKT8B3f0k/sK9OGW98C+ZCEReksBwvdTd3RoJD9VNpvQLkiFxv/QqAF2wcC7q
	/cLRRUFbHMIbpVPX3o9AiUubFdmaMScAPhUYMH0aAx68R83LfavnW39ixzTxTK0c0/QJdt/iDPcfv
	EDLSZ1iw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38368 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tTffj-00031K-0s;
	Fri, 03 Jan 2025 11:16:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tTfff-007Roc-Ff; Fri, 03 Jan 2025 11:16:51 +0000
In-Reply-To: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 5/6] net: stmmac: use PCS supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tTfff-007Roc-Ff@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 03 Jan 2025 11:16:51 +0000

Use the PCS' supported_interfaces member to build the MAC level
supported_interfaces bitmap.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6bc10ffe7a2b..fcb5649fb738 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1203,6 +1203,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
+	struct phylink_pcs *pcs;
 	struct phylink *phylink;
 
 	priv->phylink_config.dev = &priv->dev->dev;
@@ -1224,8 +1225,14 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 
 	/* If we have an xpcs, it defines which PHY interfaces are supported. */
 	if (priv->hw->xpcs)
-		xpcs_get_interfaces(priv->hw->xpcs,
-				    priv->phylink_config.supported_interfaces);
+		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
+	else
+		pcs = priv->hw->phylink_pcs;
+
+	if (pcs)
+		phy_interface_or(priv->phylink_config.supported_interfaces,
+				 priv->phylink_config.supported_interfaces,
+				 pcs->supported_interfaces);
 
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
-- 
2.30.2


