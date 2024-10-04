Return-Path: <netdev+bounces-131961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F749900C3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D4C1C23212
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23014BF92;
	Fri,  4 Oct 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DHxs7l+w"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A714BF8A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037265; cv=none; b=ehVrEsnIfSCaAmshUMViU7urV+uiCq7LNRyH6Tch9T4Q4fSJcjMKg7PAnAzl9X6gzE9vBo4f86XAN2qgSgGhCVgvbOBvd4hs2fJ6E6Wq8wLEeV+DCUiPR+sxFpZrOlzbgpwTg/SuS2wuW5z1aJaEbwJrE2J53L8jgFU6mR7XIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037265; c=relaxed/simple;
	bh=r9gH5HFS3nS6dE2Q/KSVxdqKX6IplyGiovL0leuyy5g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VMD7R/9uf8MN7pYw/ygBTGUU6CHn/TeX6ka7SCQ/WhCpWNoX0IWiqG80q1kKjZzqgg8sS6Vt3k4ruPuvNGNKHL8a0vivTDBq6QTx7lE/P2y2RKEr9h3hEmcFt6hW9Ghs0P3OgknEsqX1M6hLgsnpftQAHA9+Vh4EQ9lTbnEzlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DHxs7l+w; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l6dlWEsk1ObWrFwXZPlj5B3/mrN4qmVi0PI+FW2JyhM=; b=DHxs7l+wQL8DtRyYC+T4D1lyxb
	QtWrTw0p+6KueJ5XVJQBSHghFWTgXM1frypSgBKdvxt4SaD0M1qYd1J5j5tYGEoZrqJkh0X1knU3L
	A8xp3iLoQniiaf0JNk63fpXs71jb4lqz0k6AcQC8p76l/YOBOnVa18wdvNlRMfLU096Y0+UY3+VfE
	4eSrYs4PP7fQN48ARAJm0a5JBUwXDOpHSG3dOA7+sKwOyVp/qJZQx1JPA5PiI0je+tw+fMPdEkvqw
	ngMZJ5ksyQACdJXMCvtxmPWkxkKl/saQLjY51JNztUqWTSudt2s4zGsjalHh0F5TnKUAin7p9a2in
	8ts51DAQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42510 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQW-0001g8-0B;
	Fri, 04 Oct 2024 11:20:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQU-006Df2-EF; Fri, 04 Oct 2024 11:20:46 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 02/13] net: pcs: xpcs: don't use array for interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQU-006Df2-EF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:20:46 +0100

Currently, xpcs uses an array of interfaces that each "compat" entry
supports. When looking up the compat entry for an interface, we
iterate over the compat entries and then over each interface.

Since each compat entry only has a single interface in its interfaces
array, replace the array with a single member in the compat structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 71 ++++++++------------------------------
 1 file changed, 14 insertions(+), 57 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e1f264039c91..4fbf7c816ed5 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -107,38 +107,9 @@ static const int xpcs_2500basex_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
-static const phy_interface_t xpcs_usxgmii_interfaces[] = {
-	PHY_INTERFACE_MODE_USXGMII,
-};
-
-static const phy_interface_t xpcs_10gkr_interfaces[] = {
-	PHY_INTERFACE_MODE_10GKR,
-};
-
-static const phy_interface_t xpcs_xlgmii_interfaces[] = {
-	PHY_INTERFACE_MODE_XLGMII,
-};
-
-static const phy_interface_t xpcs_10gbaser_interfaces[] = {
-	PHY_INTERFACE_MODE_10GBASER,
-};
-
-static const phy_interface_t xpcs_sgmii_interfaces[] = {
-	PHY_INTERFACE_MODE_SGMII,
-};
-
-static const phy_interface_t xpcs_1000basex_interfaces[] = {
-	PHY_INTERFACE_MODE_1000BASEX,
-};
-
-static const phy_interface_t xpcs_2500basex_interfaces[] = {
-	PHY_INTERFACE_MODE_2500BASEX,
-};
-
 struct dw_xpcs_compat {
+	phy_interface_t interface;
 	const int *supported;
-	const phy_interface_t *interface;
-	int num_interfaces;
 	int an_mode;
 	int (*pma_config)(struct dw_xpcs *xpcs);
 };
@@ -153,12 +124,10 @@ static const struct dw_xpcs_compat *
 xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
-	int j;
 
 	for (compat = desc->compat; compat->supported; compat++)
-		for (j = 0; j < compat->num_interfaces; j++)
-			if (compat->interface[j] == interface)
-				return compat;
+		if (compat->interface == interface)
+			return compat;
 
 	return NULL;
 }
@@ -598,11 +567,9 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 {
 	const struct dw_xpcs_compat *compat;
-	int j;
 
 	for (compat = xpcs->desc->compat; compat->supported; compat++)
-		for (j = 0; j < compat->num_interfaces; j++)
-			__set_bit(compat->interface[j], interfaces);
+		__set_bit(compat->interface, interfaces);
 }
 EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
 
@@ -1285,39 +1252,32 @@ static int xpcs_get_id(struct dw_xpcs *xpcs)
 
 static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 	{
+		.interface = PHY_INTERFACE_MODE_USXGMII,
 		.supported = xpcs_usxgmii_features,
-		.interface = xpcs_usxgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_usxgmii_interfaces),
 		.an_mode = DW_AN_C73,
 	}, {
+		.interface = PHY_INTERFACE_MODE_10GKR,
 		.supported = xpcs_10gkr_features,
-		.interface = xpcs_10gkr_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_10gkr_interfaces),
 		.an_mode = DW_AN_C73,
 	}, {
+		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
-		.interface = xpcs_xlgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_xlgmii_interfaces),
 		.an_mode = DW_AN_C73,
 	}, {
+		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,
-		.interface = xpcs_10gbaser_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_10gbaser_interfaces),
 		.an_mode = DW_10GBASER,
 	}, {
+		.interface = PHY_INTERFACE_MODE_SGMII,
 		.supported = xpcs_sgmii_features,
-		.interface = xpcs_sgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
 		.an_mode = DW_AN_C37_SGMII,
 	}, {
+		.interface = PHY_INTERFACE_MODE_1000BASEX,
 		.supported = xpcs_1000basex_features,
-		.interface = xpcs_1000basex_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_1000basex_interfaces),
 		.an_mode = DW_AN_C37_1000BASEX,
 	}, {
+		.interface = PHY_INTERFACE_MODE_2500BASEX,
 		.supported = xpcs_2500basex_features,
-		.interface = xpcs_2500basex_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_2500basex_interfaces),
 		.an_mode = DW_2500BASEX,
 	}, {
 	}
@@ -1325,9 +1285,8 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 
 static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[] = {
 	{
+		.interface = PHY_INTERFACE_MODE_SGMII,
 		.supported = xpcs_sgmii_features,
-		.interface = xpcs_sgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
 		.an_mode = DW_AN_C37_SGMII,
 		.pma_config = nxp_sja1105_sgmii_pma_config,
 	}, {
@@ -1336,15 +1295,13 @@ static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[] = {
 
 static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[] = {
 	{
+		.interface = PHY_INTERFACE_MODE_SGMII,
 		.supported = xpcs_sgmii_features,
-		.interface = xpcs_sgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
 		.an_mode = DW_AN_C37_SGMII,
 		.pma_config = nxp_sja1110_sgmii_pma_config,
 	}, {
+		.interface = PHY_INTERFACE_MODE_2500BASEX,
 		.supported = xpcs_2500basex_features,
-		.interface = xpcs_2500basex_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_2500basex_interfaces),
 		.an_mode = DW_2500BASEX,
 		.pma_config = nxp_sja1110_2500basex_pma_config,
 	}, {
-- 
2.30.2


