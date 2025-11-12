Return-Path: <netdev+bounces-237828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B0C50A9A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864FA4E2D13
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D412D5A14;
	Wed, 12 Nov 2025 06:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CA10A1E
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927243; cv=none; b=iHE3tpHN/IZ1cDlFr3HuPfy1xQTBN+6WIAV282shmyX1POf/nSy6g/6pQUrzDETfWhVmrdlnx3qEaRvcWDhPTbwJ1s2r0SqTDGuPp4AB9YYZC+2VQ2bvpdFidzwVecY320dg/L/Z/aeUGVc4W8aJCL084c+qph42TKjAnev6GF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927243; c=relaxed/simple;
	bh=dBH+kij3ogW5OHl1iISsd5Yxyb/CGVabpsuhFQ0BK80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4AZv68QoyN+95uSTyzklcUMR94e4aDKwN+MbjailPIJbxEEYfgg4ArKNWwrhsMrGytza1UBISd9U0ezW34SvnK/ZdkMuHByoCzWC7jSSkGiO22buB+A1nf/o3M9j5uA+FTW3mJ9e9nvUFdXr9dJ9qzJl78v/PWWiR54cjC58B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1762927131t6163ee7b
X-QQ-Originating-IP: DNZ8jI0QcrglsnTLkH+So0/Iqqz3BMA6mvjg+7rAbRo=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.224.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Nov 2025 13:58:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12239705343244470778
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/5] net: txgbe: support CR modules for AML devices
Date: Wed, 12 Nov 2025 13:58:37 +0800
Message-Id: <20251112055841.22984-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251112055841.22984-1-jiawenwu@trustnetic.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ma+A2HZKKIKovT9rcAOC1nRGpO+NFJWN/d1U5C+e0T95fqimPKZOrZfI
	1yXjcUMfBfQ4fj4Aq/p9oEZ9805nudcK057te6XDSHDGqJ5L9xgA89aK40hYZldMDoQsjwV
	Gm93CX2SVdbHdvbzxAxFdPYex4UG4sHW++cO/JW9GCq/devzV0pTXj4j/MKw4CO4/rD/M1v
	97ql4IuUxO62RnBYOIA+faVLnE6ntbH5Eq++NV4G8RzljpJ+msFWljCCp4kSZ1zBfegFeRG
	6+9rbA106RN/eoZr2Kf3lnPgWjqv+9+sjmNnQK99cpvNNNA5xhMp4pdu9UbtHjiTrU7Wt/p
	WBMAb5pw0t18cWRIK+ISAF3RXCOv2vHJ6B0ZB+xm1LtKEOL+Lmx8dRVVuUoOWAwOZFD4amP
	2laaFMEBhKfWHAGezFgCZd59sWxufRdMgUIyu+XQh77jn6nRh8bE15nw9Srz57zBIDYc4iB
	2hh7GxrCixTN1zdp3JtaINY2I6fEjQ/Ls6qk7qpzT9HYPrcz7eiSgYt0zrJi2IP2lk6Zd2T
	MwJ9eUtWAMQKXHmWNuyLHnscXoVDG6DOIM4tkn5jR38aSc+DzBluSUqN/9Yc+jYVSgERZ4g
	dPsOY6upXwpjxpehUzUbSLWG7Qy4OBmRpYjQdPw9F8cYVaCgvO+jv+XSZrvTmbyRFQwVfeW
	n8jS1oPXltXaG57UnzsxSX/qDk4pXzA4a/DWXp3LdYmiW33Xv+bnXsIFQniT5f+5zGwYGN6
	zN+igB/EG8ZEXOiD9O1pAw3HOOatc5LmImLlIfZ2T6ICTLHkiqgKDSsDfuzqZ+O7GBXTNNF
	Bgh8teJiTNAMOqfz0QCVX5iSoV9pl2mSJrLRDYRiEAaHfO4g1VsInjoKur2LSnlfYVOfEB1
	sFVMxpU8IgpbRvbaG2fw5hQhSULPG2/SiKvBaFfaXlAMKXUX9PgyzNA8KIo6rA1MTErDmvi
	QNrMI+voDM6NuOtHEFS+8xcN1EY1YWof/WVIBGiVX64CnoliwA8dVgNjAlokwAWF19Z2bUh
	VbPRpQLEcUSZQKlfAnbP+DPrAIWi7QKqBnz8bBoQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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



