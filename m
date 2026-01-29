Return-Path: <netdev+bounces-254865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOQ5HJeVe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:15:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8CB2B7D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A963039EE9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0085346E67;
	Thu, 29 Jan 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yc+FPp2q"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181E344DB7
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706744; cv=none; b=OCKhuz+sHUobJPA/XZQBK/2msXutcG84L5raA7KSaDaA5M7CZ4iMYvDvYh8jR2jG41Oy6SwOGA8OaXkMAhIJT87hqQFKwjsb9Kdru9hGCkB8ckbXZWakX5vLMT+c5VM1oKNqDItkRd6CAMoUKlastJbv6EtT39VdOeNwsH01sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706744; c=relaxed/simple;
	bh=qybAs14Tk/B/VbviKoMTmm5OO1vLCm4WD0+AIGzJ1nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEC0v1Q5mfGUQ352ukrItckTha13kGkrqAGmIrokSDlmqcWRngcuuktJ39SK8Q0gkd7+v3ol8uWlGignfvf7Va4nylN2fgIjCXU9Oay67qo1D6LDiNiKgTfHUQ9UhEWH2zwdT9MgrM6dNABXnpeFpzQ01El9pSvagIrszSPao0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yc+FPp2q; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769706741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5pLBA2aCbjk3Rn/mBNnd9QmkEtRl8t+qCyK15ASMvI=;
	b=Yc+FPp2qPK2GXfX+eDSFcW1/oOGur0LUZzVDYXBkVdqZwwEAb6YWUaN23tjPGHTth/RHSu
	s46Ks/zNnai4tGnjSoJMnfoeLurYfmwi/hL9cps6Ed6/fdzHvTHCnCREdE4+djQM46qSbe
	GoLiMrrhiozbzwcL+loCjkvnylkkz/A=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 2/2] net: phy: dp83867: Always program R/SGMII enable bits
Date: Thu, 29 Jan 2026 12:12:05 -0500
Message-Id: <20260129171205.3868605-3-sean.anderson@linux.dev>
In-Reply-To: <20260129171205.3868605-1-sean.anderson@linux.dev>
References: <20260129171205.3868605-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254865-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 0FF8CB2B7D
X-Rspamd-Action: no action

If the board designers have neglected to populate the appropriate
resistors on the strapping pins then the phy may default to the wrong
interface mode. Enable/disable the RGMII/SGMII enable bits as necessary
to select the correct interface.

The dp83867 strapping pins have four levels and typically configure two
features at once. LED_0 controls both port mirroring and whether SGMII
is enabled. If it is pulled to VDDIO, both port mirroring and SGMII
will be enabled. For variants of the dp83867 that do not support SGMII,
this will prevent data from being transferred. As we now explicitly set
the SGMII and RGMII enable bits, we do not need to detect whether SGMII
has been inadvertently enabled.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/phy/dp83867.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 7e16e9299457..3fb2293f568f 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -75,6 +75,7 @@
 #define MII_DP83867_MICR_JABBER_INT_EN		BIT(0)
 
 /* RGMIICTL bits */
+#define DP83867_RGMII_EN			BIT(7)
 #define DP83867_RGMII_TX_CLK_DELAY_EN		BIT(1)
 #define DP83867_RGMII_RX_CLK_DELAY_EN		BIT(0)
 
@@ -100,7 +101,7 @@
 #define DP83867_PHYCR_FIFO_DEPTH_MAX		0x03
 #define DP83867_PHYCR_TX_FIFO_DEPTH_MASK	GENMASK(15, 14)
 #define DP83867_PHYCR_RX_FIFO_DEPTH_MASK	GENMASK(13, 12)
-#define DP83867_PHYCR_RESERVED_MASK		BIT(11)
+#define DP83867_PHYCR_SGMII_EN			BIT(11)
 #define DP83867_PHYCR_FORCE_LINK_GOOD		BIT(10)
 
 /* RGMIIDCTL bits */
@@ -752,10 +753,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 	val |= (dp83867->tx_fifo_depth <<
 		DP83867_PHYCR_TX_FIFO_DEPTH_SHIFT);
 
+	val &= ~DP83867_PHYCR_SGMII_EN;
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val &= ~DP83867_PHYCR_RX_FIFO_DEPTH_MASK;
 		val |= (dp83867->rx_fifo_depth <<
-			DP83867_PHYCR_RX_FIFO_DEPTH_SHIFT);
+			DP83867_PHYCR_RX_FIFO_DEPTH_SHIFT) |
+		       DP83867_PHYCR_SGMII_EN;
 	}
 
 	ret = phy_write(phydev, MII_DP83867_PHYCTRL, val);
@@ -763,31 +766,10 @@ static int dp83867_config_init(struct phy_device *phydev)
 		return ret;
 
 	if (phy_interface_is_rgmii(phydev)) {
-		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-		if (val < 0)
-			return val;
-
-		/* The code below checks if "port mirroring" N/A MODE4 has been
-		 * enabled during power on bootstrap.
-		 *
-		 * Such N/A mode enabled by mistake can put PHY IC in some
-		 * internal testing mode and disable RGMII transmission.
-		 *
-		 * In this particular case one needs to check STRAP_STS1
-		 * register's bit 11 (marked as RESERVED).
-		 */
-
-		bs = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_STRAP_STS1);
-		if (bs & DP83867_STRAP_STS1_RESERVED)
-			val &= ~DP83867_PHYCR_RESERVED_MASK;
-
-		ret = phy_write(phydev, MII_DP83867_PHYCTRL, val);
-		if (ret)
-			return ret;
-
 		/* Set up RGMII delays */
 		val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
 
+		val |= DP83867_RGMII_EN;
 		val &= ~(DP83867_RGMII_TX_CLK_DELAY_EN | DP83867_RGMII_RX_CLK_DELAY_EN);
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 			val |= (DP83867_RGMII_TX_CLK_DELAY_EN | DP83867_RGMII_RX_CLK_DELAY_EN);
@@ -803,6 +785,10 @@ static int dp83867_config_init(struct phy_device *phydev)
 		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIIDCTL,
 			      dp83867->rx_id_delay |
 			      (dp83867->tx_id_delay << DP83867_RGMII_TX_CLK_DELAY_SHIFT));
+	} else {
+		val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
+		val &= ~DP83867_RGMII_EN;
+		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL, val);
 	}
 
 	/* If specified, set io impedance */
-- 
2.35.1.1320.gc452695387.dirty


