Return-Path: <netdev+bounces-284374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJjiJPnl+Wn2EwMAu9opvQ
	(envelope-from <netdev+bounces-284374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21584CDC93
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4399A302207E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422C429838;
	Tue,  5 May 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Rs4UWtQi"
X-Original-To: netdev@vger.kernel.org
Received: from e3i439.smtp2go.com (e3i439.smtp2go.com [158.120.85.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9B18DF80
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985009; cv=none; b=emdw1IT4s4yw36YHX0BEQ+pnpkhz8WcYzWjL3zw5KRwaBq85KmiE7lDJfg8QGxKUclpRsTyUYU3H6jt1Omb1qpYYR5WcRGfQV+Ks/0T0b+FY/fjH8JGE11ufdSZhBTtqIVjZDr+O0W7xFzSOEAs4W8xcqypioGRrxqoMKbNAG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985009; c=relaxed/simple;
	bh=mk+rFQLU+jQ2sP/cds/Xv011r7PxGkbieb1wnjY/+7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOiauFN7QWrsw1Ef0hmF7Gnt4EudOU1grAKdDqywXyKqOvUXPk+QTrfcl5t8M4yi/srr7fIemAXEZW0sKGJJmfiWHLi5WP5aU/k9uiUqhR8JL+/HxVSXKBa7+Qf5bUnCpYGSN9bFQRxVuLG9CK0DWehDTbtkfpLLcCnG67d8uZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Rs4UWtQi; arc=none smtp.client-ip=158.120.85.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1777984097; h=from : subject : to
 : message-id : date; bh=LX0JgHkYWsWkuj5Lnu48cQL8XdFDHKX3eJL79r215z0=;
 b=Rs4UWtQihllawG5JVljxTHzKe8wZiIDsWwk3SaVPt0STW5QxbsegXfNJB4/m7b/+boL6s
 2eMdWflFLt/5ec0qQgav77cKUhtoUf0cfYIIQca/nmmwlPdFbrSPwFFD69cHmVfKyBE+HFY
 oXr5SiS86YW+9tqJsQisF05hnQmwnCqOBleSHKTCHk+nZgw3kSaf8+Cacy1sNeggcEY2r00
 LOpjetTQ8FUNxUQwcVegPl4NYkZ9isE5N0Pv7FTjftbZypuuIOMaLzuZo8OaOfM51WbZSbJ
 Xclth2DMxm45155/RNnyJo9d2XbCUeVkMlu4mkiN1M0U+PEAymy3X9hbUyOQ==
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.99.1-S2G)
	(envelope-from <l.ellero@asem.it>)
	id 1wKEsn-4o5NDgrm55y-ur0n;
	Tue, 05 May 2026 12:28:13 +0000
Received: from asem-ThinkStation-P330.asem.intra ([172.16.23.8]) by asas054.asem.intra with Microsoft
 SMTPSVC(10.0.14393.4169);	 Tue, 5 May 2026 14:28:11 +0200
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
Subject: [PATCH] net: phy: dp83867: add MDI-X management
Date: Tue,  5 May 2026 14:27:30 +0200
Message-ID: <20260505122751.233764-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 May 2026 12:28:11.0853 (UTC) FILETIME=[A35B27D0:01DCDC8A]
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s4bGKX1ra-
X-smtpcorp-track: tYRSZz6a2PdU.h1WAbzruMo_K.ZkgqHgPBKM-
X-Rspamd-Queue-Id: F21584CDC93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asem.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asem.it:s=s1174574];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284374-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[asem.it,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[l.ellero@asem.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[asem.it:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asem.it:email,asem.it:dkim,asem.it:mid]

ethtool on this phy device always reports "MDI-X: Unknown" and doesn't
support forcing it to on or off.
This patch adds support for reading/forcing MDI-X mode from ethtool
properly.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
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


