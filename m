Return-Path: <netdev+bounces-284870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP9bMmNR+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB54DC45A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10943097D57
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74846AF35;
	Wed,  6 May 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="j5AoxeeO"
X-Original-To: netdev@vger.kernel.org
Received: from e3i439.smtp2go.com (e3i439.smtp2go.com [158.120.85.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64045421890
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077200; cv=none; b=vE1XFwrzoRFfKUCQDl3hHlaX0xG5JpjTDURRxFVDyNMqFnIxExwS/4FSLL4RVF0fYk7PppmMr5o2xFfgbxoT3rfBWDuYV2d65bDfCBH41EVSoZjVidmfpNJ+J25r5r8srcMBBS01ebvL92WrAkkgfnzMrNjOasK22SOYhYjHU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077200; c=relaxed/simple;
	bh=YkeQZFtiXgt58B6BhRqS7nupUuzLxE9TvgMLL0bOa+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktpQiweCddXTtEOJuMPJASE0MSCVin8axuHTG38AxoqAj5vOROVW/z4Cf3b3YP2GTscjsasB/V2dRrVmLg2O+fRbgxpifxPrMoQOlhjkTPBTyP8JKnUHNEnqkNpOQegwY5/VXXwEBRnDeg9tmSdn29SGRKLoviZBe/tENUH9O3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=j5AoxeeO; arc=none smtp.client-ip=158.120.85.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1778077190; h=from : subject : to
 : message-id : date; bh=leK7bUcmkCSB0GIeM0E1DOJ48uqzN9IZWq1tkaVx8g0=;
 b=j5AoxeeO1dqth1dec22D1idkQzcCmK60Zyf68ZlTBNPwTYH0tGdZ9NeeQebNhwZ8MAqx6
 h5omAUM9JJLOlM/i6v6qo2BrNF/Xm7b0+TVoHn42beGDWMQWDxoWFn1AsPpyPcwBVDy/FVO
 0Mviw1gUO/9QB8mVKLxps5hD51ZNS5G2bCNpz70xfUBOVSR/jO4n1L3iSUusRw7a6910VW7
 y7JdRubazEW/HNz1RlmxexvqvNswB8uSn4hAjVxvdZVsW0dy/CZgfHS8ja0mpcYfkO1rBIR
 dVnZAaKNXs7WNEp8hk6e4Fap6m3Gd1vW2vRNgC6Dy9jNn7aM0kB+ImMA/jbw==
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.99.1-S2G)
	(envelope-from <l.ellero@asem.it>)
	id 1wKd6G-FnQW0hPybXG-d0Tc;
	Wed, 06 May 2026 14:19:44 +0000
Received: from asem-ThinkStation-P330.asem.intra ([172.16.23.8]) by asas054.asem.intra with Microsoft
 SMTPSVC(10.0.14393.4169);	 Wed, 6 May 2026 16:19:29 +0200
From: Luca Ellero <l.ellero@asem.it>
To:
Cc: Luca Ellero <l.ellero@asem.it>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: dp83867: add MDI-X management
Date: Wed,  6 May 2026 16:19:06 +0200
Message-ID: <20260506141918.13136-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 May 2026 14:19:29.0477 (UTC) FILETIME=[59F17750:01DCDD63]
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174574m:1174574aXfMg4B:1174574slHq65a5AS
X-smtpcorp-track: qsu1muN0bPRH.fTs8PfxIGjpr.RsAtGwHbQq5
X-Rspamd-Queue-Id: 29CB54DC45A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asem.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asem.it:s=s1174574];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284870-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[asem.it,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[l.ellero@asem.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asem.it:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,asem.it:email,asem.it:dkim,asem.it:mid]

ethtool on this phy device always reports "MDI-X: Unknown" and doesn't
support forcing it to on or off.
This patch adds support for reading/forcing MDI-X mode from ethtool
properly.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
  - add net-next to patch subject (no code modifications)
v1: https://lore.kernel.org/netdev/9414fa96-05e1-4d7e-adca-4ccf3b96853b@lunn.ch/T/#t

 drivers/net/phy/dp83867.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 3fb2293f568f..88255e92b4cd 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -103,6 +103,10 @@
 #define DP83867_PHYCR_RX_FIFO_DEPTH_MASK	GENMASK(13, 12)
 #define DP83867_PHYCR_SGMII_EN			BIT(11)
 #define DP83867_PHYCR_FORCE_LINK_GOOD		BIT(10)
+#define DP83867_PHYCR_MDIX_MASK			GENMASK(6, 5)
+#define DP83867_PHYCR_MDIX_MDI			(0x0 << 5)
+#define DP83867_PHYCR_MDIX_MDIX			(0x1 << 5)
+#define DP83867_PHYCR_MDIX_AUTO			(0x3 << 5)
 
 /* RGMIIDCTL bits */
 #define DP83867_RGMII_TX_CLK_DELAY_MAX		0xf
@@ -123,6 +127,10 @@
 #define DP83867_PHYSTS_100			BIT(14)
 #define DP83867_PHYSTS_DUPLEX			BIT(13)
 #define DP83867_PHYSTS_LINK			BIT(10)
+#define DP83867_PHYSTS_MDIX_CD			BIT(9)
+#define DP83867_PHYSTS_MDIX_AB			BIT(8)
+#define DP83867_PHYSTS_MDIX_MASK		(DP83867_PHYSTS_MDIX_AB | \
+						DP83867_PHYSTS_MDIX_CD)
 
 /* CFG2 bits */
 #define DP83867_DOWNSHIFT_EN		(BIT(8) | BIT(9))
@@ -391,6 +399,22 @@ static int dp83867_read_status(struct phy_device *phydev)
 	else
 		phydev->speed = SPEED_10;
 
+	if (!(status & DP83867_PHYSTS_LINK)) {
+		phydev->mdix = ETH_TP_MDI_INVALID;
+	} else {
+		switch (status & DP83867_PHYSTS_MDIX_MASK) {
+		case 0:
+			phydev->mdix = ETH_TP_MDI;
+			break;
+		case DP83867_PHYSTS_MDIX_MASK:
+			phydev->mdix = ETH_TP_MDI_X;
+			break;
+		default:
+			phydev->mdix = ETH_TP_MDI_INVALID;
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -714,6 +738,8 @@ static int dp83867_config_init(struct phy_device *phydev)
 	struct dp83867_private *dp83867 = phydev->priv;
 	int ret, val, bs;
 
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83867_CFG2, DP83867_DOWNSHIFT_EN,
 			 DP83867_DOWNSHIFT_EN);
@@ -873,6 +899,39 @@ static int dp83867_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83867_config_mdix(struct phy_device *phydev, u8 ctrl)
+{
+	int val;
+
+	switch (ctrl) {
+	case ETH_TP_MDI:
+		val = DP83867_PHYCR_MDIX_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val = DP83867_PHYCR_MDIX_MDIX;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = DP83867_PHYCR_MDIX_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_modify(phydev, MII_DP83867_PHYCTRL,
+			  DP83867_PHYCR_MDIX_MASK, val);
+}
+
+static int dp83867_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = dp83867_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
 static int dp83867_phy_reset(struct phy_device *phydev)
 {
 	int err;
@@ -1127,6 +1186,7 @@ static struct phy_driver dp83867_driver[] = {
 
 		.probe          = dp83867_probe,
 		.config_init	= dp83867_config_init,
+		.config_aneg	= dp83867_config_aneg,
 		.soft_reset	= dp83867_phy_reset,
 
 		.read_status	= dp83867_read_status,
-- 
2.43.0


