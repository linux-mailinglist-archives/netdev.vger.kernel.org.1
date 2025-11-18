Return-Path: <netdev+bounces-239421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635BC6820C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 700F7357B40
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFE30597B;
	Tue, 18 Nov 2025 08:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024F3043B9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453127; cv=none; b=O9O0hWmOudYW/b+zdJTJUhnmyljWd3BPXSbwZPWAMzPgLvESdOFG/WOpEaPUjJgo7RgKRTRpvMMBHOKd9n7VeNQFnZijtr8Lp/QbW8eavU4GZO7AP5r9Y8cx5X8yTatBOANlm2BaI8eBvXGRSvnRvIegupJ4NEFKi5QR7Kp4ICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453127; c=relaxed/simple;
	bh=dBH+kij3ogW5OHl1iISsd5Yxyb/CGVabpsuhFQ0BK80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8SwnFGFGXI58WgleWGwFFxelnn66aElXWj8zbtvYWfFOA/8GIf0mV3pVP+jmomBKT43hZqOmMPwBF2O4EvsgSDG6wtYGYykgguCDAghjgCE06+SMXIE83o1nrT3uLHh1dUltM+DD+iLCb5fP4miYh9+zjYx8ApNppZhxBnbuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763452998tc0d9ee08
X-QQ-Originating-IP: 5qym2RaAPJnus7b25486Xp13Zd6D9GRyS/sdv0s+kjA=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7516545497380645640
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/5] net: txgbe: support CR modules for AML devices
Date: Tue, 18 Nov 2025 16:02:55 +0800
Message-Id: <20251118080259.24676-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MwQdfXoP8nuzZc8n1NpEU5QbZSdl7OX7HWPjzwOGYBJ/6jS4tvuoMj8L
	WDaPNWjVndKawlilrJBisSaN2A9rPucIq2KuI0OQ/t6Y5O3C9Q+XLeMcXfvwEm90xTUUVrO
	u3u6EIqbCFRWO15GOJOR8KvahMzngXUhbsOOd51vQsFIpK7RNlm0hO0uOht6AC0p1rBniLs
	zsu8P7BOQkUmwSkefSnvZBjMrJo3s22/LGdvr64icaFBfm9ddKB3cSoOFJDKj4rcBOIICaP
	r5BIbCU6fH1MpLR6pNVNtvd8eq9CZj6B7lH4ByRyHk5ikPu+qlawmEUJQzQy83LI1cta3wR
	+lIM0KuT0NmVvIEvxGMLx2gOOh6Yc03yLlvXiVsOlRShKwzI8YaszoVN2dYuFTXpteWEPaB
	OsNmsk+2Dyy3z7jx48CkeVZCJUcKOiwAMtqwiHc+IrVl+pIfg6zoMkhcNmsAPknJQ0ZZmKf
	5QOR+8l+J+z0NUn3gCcMaa2avGpPEgf8ZDJXoytiMr2ihExvul/9Ac8lSfdYsq517EKg16o
	IvMhaH46j3jSonbkmzKb3zODqlUPv+Ys+1H5ICnr0w3MHHATlWNGKbbPYG0qGN6kkFSTbbO
	zLOj8oWuuO13axdQPSJ38HPA5T90LHQm8pfLd+3cdcMDolAkbgBe8Uue4uFjRmleQ525ONW
	+iSSbMztMRwJGj20LkIcNxhlNSL+nVR9idlVJSrmFbN1pPQF5nu2eEwU2usCwe4QxjJNzyM
	ewjaF9ygd0ZFMB8kftxQURpY5oGInxKvBRT69rb//OWmoMaFta7DlldTdxWUToWkv5mij/F
	ESyfni+/iPcn4xzTEddsffS+5WctypK1bGEjbGTUIU97XaEJlh03tXq+a/uNeF+zoQpsAZo
	meYv+9ivWlqZl88qGtQSbdeEDLU69dKktMwS4D9pI0MyK5s/gHaK/aLCAWSWCQiiIx74TVI
	HtJmuWUScrzLRp9MJb2awLoTYPHc6z7uDg6emQ3XyDBRcXoWcx05OuwuxTOyQdUUFkFQXZI
	xw5yJRSGjRQNeNlk6jpdH45yMd2tt+SuYCk6iGKw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Support to identify 25G/10G CR modules for AML devices. Autoneg is
enbaled by default in CR mode.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 59 +++++++++++++------
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  3 +-
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 35eebdb07761..a7650f548fa4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -104,7 +104,8 @@ static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int
 					 WX_HI_COMMAND_TIMEOUT, true);
 }
 
-static void txgbe_get_link_capabilities(struct wx *wx, int *speed, int *duplex)
+static void txgbe_get_link_capabilities(struct wx *wx, int *speed,
+					int *autoneg, int *duplex)
 {
 	struct txgbe *txgbe = wx->priv;
 
@@ -115,6 +116,7 @@ static void txgbe_get_link_capabilities(struct wx *wx, int *speed, int *duplex)
 	else
 		*speed = SPEED_UNKNOWN;
 
+	*autoneg = phylink_test(txgbe->advertising, Autoneg);
 	*duplex = *speed == SPEED_UNKNOWN ? DUPLEX_HALF : DUPLEX_FULL;
 }
 
@@ -135,11 +137,11 @@ static void txgbe_get_mac_link(struct wx *wx, int *speed)
 
 int txgbe_set_phy_link(struct wx *wx)
 {
-	int speed, duplex, err;
+	int speed, autoneg, duplex, err;
 
-	txgbe_get_link_capabilities(wx, &speed, &duplex);
+	txgbe_get_link_capabilities(wx, &speed, &autoneg, &duplex);
 
-	err = txgbe_set_phy_link_hostif(wx, speed, 0, duplex);
+	err = txgbe_set_phy_link_hostif(wx, speed, autoneg, duplex);
 	if (err) {
 		wx_err(wx, "Failed to setup link\n");
 		return err;
@@ -154,19 +156,43 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
 	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
-	if (id->com_25g_code & (TXGBE_SFF_25GBASESR_CAPABLE |
-				TXGBE_SFF_25GBASEER_CAPABLE |
-				TXGBE_SFF_25GBASELR_CAPABLE)) {
-		phylink_set(modes, 25000baseSR_Full);
+	if (id->cable_tech & TXGBE_SFF_DA_PASSIVE_CABLE) {
+		txgbe->link_port = PORT_DA;
+		phylink_set(modes, Autoneg);
+		if (id->com_25g_code == TXGBE_SFF_25GBASECR_91FEC ||
+		    id->com_25g_code == TXGBE_SFF_25GBASECR_74FEC ||
+		    id->com_25g_code == TXGBE_SFF_25GBASECR_NOFEC) {
+			phylink_set(modes, 25000baseCR_Full);
+			phylink_set(modes, 10000baseCR_Full);
+			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+			__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+		} else {
+			phylink_set(modes, 10000baseCR_Full);
+			__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+		}
+	} else if (id->cable_tech & TXGBE_SFF_DA_ACTIVE_CABLE) {
+		txgbe->link_port = PORT_DA;
+		phylink_set(modes, Autoneg);
+		phylink_set(modes, 25000baseCR_Full);
 		__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
-	}
-	if (id->com_10g_code & TXGBE_SFF_10GBASESR_CAPABLE) {
-		phylink_set(modes, 10000baseSR_Full);
-		__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
-	}
-	if (id->com_10g_code & TXGBE_SFF_10GBASELR_CAPABLE) {
-		phylink_set(modes, 10000baseLR_Full);
-		__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+	} else {
+		if (id->com_25g_code == TXGBE_SFF_25GBASESR_CAPABLE ||
+		    id->com_25g_code == TXGBE_SFF_25GBASEER_CAPABLE ||
+		    id->com_25g_code == TXGBE_SFF_25GBASELR_CAPABLE) {
+			txgbe->link_port = PORT_FIBRE;
+			phylink_set(modes, 25000baseSR_Full);
+			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+		}
+		if (id->com_10g_code & TXGBE_SFF_10GBASESR_CAPABLE) {
+			txgbe->link_port = PORT_FIBRE;
+			phylink_set(modes, 10000baseSR_Full);
+			__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+		}
+		if (id->com_10g_code & TXGBE_SFF_10GBASELR_CAPABLE) {
+			txgbe->link_port = PORT_FIBRE;
+			phylink_set(modes, 10000baseLR_Full);
+			__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+		}
 	}
 
 	if (phy_interface_empty(interfaces)) {
@@ -177,7 +203,6 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
 	phylink_set(modes, Pause);
 	phylink_set(modes, Asym_Pause);
 	phylink_set(modes, FIBRE);
-	txgbe->link_port = PORT_FIBRE;
 
 	if (!linkmode_equal(txgbe->sfp_support, modes)) {
 		linkmode_copy(txgbe->sfp_support, modes);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index e285b088c7b2..e8dd277a35c7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -30,7 +30,8 @@ int txgbe_get_link_ksettings(struct net_device *netdev,
 		return 0;
 
 	cmd->base.port = txgbe->link_port;
-	cmd->base.autoneg = AUTONEG_DISABLE;
+	cmd->base.autoneg = phylink_test(txgbe->advertising, Autoneg) ?
+			    AUTONEG_ENABLE : AUTONEG_DISABLE;
 	linkmode_copy(cmd->link_modes.supported, txgbe->sfp_support);
 	linkmode_copy(cmd->link_modes.advertising, txgbe->advertising);
 
-- 
2.48.1



