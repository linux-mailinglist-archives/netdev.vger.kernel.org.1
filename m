Return-Path: <netdev+bounces-162999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18AA28BA1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C31118864EF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBCB77104;
	Wed,  5 Feb 2025 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m5hW+ofY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6D39FD9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762079; cv=none; b=EMns7tuNPSC+ajdZzTBuRQnArWtPpNFjsHJZp+kSClVdLfJXDHK6ldsNp56o4xNZ6EMCRnHDS1V9pkW3bYeu1NakqftF4bm9RMsIf4K3lXukpxgdCsyDtlD05FHiVi0rYk56wVqEsz49shUVZKgfAbvernTwFpW4sU5N9DKN4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762079; c=relaxed/simple;
	bh=TPukQRdEFlVQ0oPmABxaCot4S2cmYCq1h3Vkkpn/UwI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dATGOrcBUqZmPMZ5pon9TN4tFG+dJ7op5QPXw5D+G9oyPstbjg+wCBoh7axlbVmbZS4J5dLKWW9N55u/oIZFgvLRx51kqTnt7N682036RBXpSEWLBqzRimeTOMbWhktGFzUbGpW7D+PUpKzFlJhz+9XE41n4za72Rg5ZwLTGiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m5hW+ofY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zhIV5VH9LDN6vTl3HRRd6HkIEuz0uHtIPSi4LyM0640=; b=m5hW+ofYZVHgdu8JXBNreT/rFU
	k5eH8Qjn9ZkGOUzFiFRXv3u1c7mKWFwRyQiq2KAsMN5QZC0xyuAoom1V29ljk8QwMatvufU7s8gXV
	gLzR+xX7NgTB53Gy/P3ZpID7lUoHKu4LH+q1MXXmCK2khMd6MEory6vdMHDIxVTU37X6i1f/JnuQB
	w4rldQcUbWezBbXMNKJV9S2r0aDj3I+3bKMaGB8r0UbMx96nhJRrZYUrpIR1RUsv0NRmo0I/Rg/9o
	3kqsMeeSeJwfgKcBt+BiphbWy0Z+VGGG1Va8TmrNpHzIbXQVAQpL1yBzufvISywmCmJjsQ25Z5ztA
	dOa6NqZQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50314 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffRX-00076g-1N;
	Wed, 05 Feb 2025 13:27:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffRE-003Z5c-0L; Wed, 05 Feb 2025 13:27:32 +0000
In-Reply-To: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	 UNGLinuxDriver@microchip.com,
	 Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 1/4] net: xpcs: add support for configuring width
 of 10/100M MII connection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffRE-003Z5c-0L@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:27:32 +0000

When in SGMII mode, the hardware can be configured to use either 4-bit
or 8-bit MII connection. Currently, we don't change this bit for most
implementations with the exception of TXGBE requiring 8-bit. Move this
decision to the creation code and act on it when configuring SGMII.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 19 +++++++++++++++----
 drivers/net/pcs/pcs-xpcs.h |  8 ++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1faa37f0e7b9..12a3d5a80b45 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -695,9 +695,18 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
 			 DW_VR_MII_PCS_MODE_C37_SGMII);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		mask |= DW_VR_MII_AN_CTRL_8BIT;
+	switch (xpcs->sgmii_10_100_8bit) {
+	case DW_XPCS_SGMII_10_100_8BIT:
 		val |= DW_VR_MII_AN_CTRL_8BIT;
+		fallthrough;
+	case DW_XPCS_SGMII_10_100_4BIT:
+		mask |= DW_VR_MII_AN_CTRL_8BIT;
+		fallthrough;
+	case DW_XPCS_SGMII_10_100_UNCHANGED:
+		break;
+	}
+
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		/* Hardware requires it to be PHY side SGMII */
 		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
 	} else {
@@ -1450,10 +1459,12 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
 	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
-	else
+		xpcs->sgmii_10_100_8bit = DW_XPCS_SGMII_10_100_8BIT;
+	} else {
 		xpcs->need_reset = true;
+	}
 
 	return xpcs;
 
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index adc5a0b3c883..4d53ccf917f3 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -114,6 +114,12 @@ enum dw_xpcs_clock {
 	DW_XPCS_NUM_CLKS,
 };
 
+enum dw_xpcs_sgmii_10_100 {
+	DW_XPCS_SGMII_10_100_UNCHANGED,
+	DW_XPCS_SGMII_10_100_4BIT,
+	DW_XPCS_SGMII_10_100_8BIT
+};
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
@@ -122,6 +128,8 @@ struct dw_xpcs {
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	bool need_reset;
+	/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
+	enum dw_xpcs_sgmii_10_100 sgmii_10_100_8bit;
 };
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
-- 
2.30.2


