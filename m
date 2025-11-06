Return-Path: <netdev+bounces-236201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C32C39B0F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA334FCBF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42E3093D3;
	Thu,  6 Nov 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S73lW9BN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054893093C8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419498; cv=none; b=U6v8H3psv+6rntBDqfJQSN3lQ3VUsUjO6gf5UdNmwgAS90hfVIcgyRBoi9GabSAHAv2G6L1AR1GUvZf0AStYRGxCVsdZmh5f7Qnjs0CN6vyi91+aJRBqemDxrq3UxZkWkSJx1o9L138GOzJGXGBkE39Hw+yfbdrCWmceU/PTio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419498; c=relaxed/simple;
	bh=sj0/KmliJOadjYLwUIJ9eyZAuwByM4ZfaE3yoV8KE/M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XeyO8F3QdPi+4xR3y2NKG/930GhzJFoUkNY8qgLLE4Ks0QNB2EW0o9HtrExxa1/SbpFzD44+Wvvj1liA4ZSQG2VYXg0BKg5TIIyBk5l5hp8za8MZ/OZM4UL6EE0orEroahCCdrlcxug6KTdZ5CCkrOj6Vis5zz+cFW1M64+asT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S73lW9BN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u/lxMaLNSqpUS5O62kF3KWUfJenTxFgAPX7am6R6hq8=; b=S73lW9BNMDKi6AFTIi6YJBOAh2
	vSEv3+7Iu8vk93Jk6nmjxtp2BUiTvl8bILrAOJTdGj4GXkXD3xoiqktZagr1pALqbBoK3LJxT7JEf
	yB6sVs3KuWJ1O18FlHFOXCFVvjgfVcUY0N6UDbb3Ucu4HMiZZkAB06RYRcllo+n0M+u08A6o5SMxY
	spN+J74qv4PdUaTPgKIsCeQczSBSqlxuFjrm+nVlOYdSCfs4KlfPtoShp+6OaWi5B/rusc457tfHr
	dcxh8S1JTG4KMqLEtcmWQl0c6Lj+smeCIOUgXzp0bUS8lJrNCiRKwC+JQ/1nFtcu6Ac4cCCMcPkFv
	iB6usyCQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59010 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvol-000000004Zm-1QUi;
	Thu, 06 Nov 2025 08:58:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoj-0000000DWpE-3b5C;
	Thu, 06 Nov 2025 08:58:05 +0000
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 10/11] net: stmmac: ingenic: pass ingenic_mac
 struct rather than plat_dat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoj-0000000DWpE-3b5C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:58:05 +0000

It no longer makes sense to pass a pointer to struct
plat_stmmacenet_data when calling the set_mode() methods to only use it
to get a pointer to the ingenic_mac structure that we already had in
the caller. Simplify this by passing the struct ingenic_mac pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 25 ++++++-------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index eb5744e0b9ea..41a2071262bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -64,15 +64,13 @@ struct ingenic_soc_info {
 	enum ingenic_mac_version version;
 	u32 mask;
 
-	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
+	int (*set_mode)(struct ingenic_mac *mac, u8 phy_intf_sel);
 
 	u8 valid_phy_intf_sel;
 };
 
-static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			       u8 phy_intf_sel)
+static int jz4775_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
@@ -82,19 +80,14 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
-
 	/* Update MAC PHY control register */
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
 }
 
-static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1600_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
@@ -103,10 +96,8 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1830_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
@@ -116,10 +107,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
@@ -165,7 +154,7 @@ static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
 			phy_modes(interface));
 
-		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
+		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


