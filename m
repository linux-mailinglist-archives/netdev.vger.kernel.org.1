Return-Path: <netdev+bounces-163002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D7A28BA7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4610B1887547
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D4136326;
	Wed,  5 Feb 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZsTVMC6/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA7127E18
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762096; cv=none; b=pQka0Fxjgj1fkl++Ezd575zeSYw7+76ZLad2aShjmZKRAnRhfwvFdi4FzyIDulrULjH2nEEiJhKRCfWLbwOy0uBEJFls4nJVF+RBYyOTYpaSnnyF4806rIj3k0DYPw9W4qB8sMS6/uc445Adk/E8mAdkacYCG/cKyA+hN7bWh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762096; c=relaxed/simple;
	bh=s4FRzLkdbDAVdmpko115M+dWhUuMIPAQFvO2jZlQMvI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uz1O5PxydlRuc1gVyHFvpkqgvGYm3WEYOMS8a36fklWt0SKJGTnYzvwlizLZK1H5VTITwncKLDtpBjd34alCS8ql05gdniwYWVPZl8MS3If3AZlILlf+c5uhGa8kfVV/vhxYJFwf6u6qsVx92aeh589Ehh9sDboh8Sd/bfimWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZsTVMC6/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Js/PGKYXmZWwi4mSKiZuKnNk6qnIeCvWDO0obIBgBwk=; b=ZsTVMC6/Nb9Z7WCEf3+VZJkGer
	ho/OMg8jbETgc+EFNyrzm9K2XyVb4yik+opRYnFzfS9Vewlm1AFVNiCT4ZMcNxKe7GTUc+h7PaNJR
	3eeZZ8CV9f6xvzhuOds4+IKUPQyj0/MF7VJBMbwJSogAoCqLB1Iwl/emOLDFXeioS8HkWz9/6N91S
	mg1mSK9TGeosY03bqePQ3H7hvOtdsjFDNeAaxZCdkyrzqif/skY8i8VLo1y1muP6vF9LIKp6X0E20
	Md05WYFokv7Uou0HzqdV5YUjop/VGBbgzUvLtEqb/DdOo0NFWq/USR3zQlKXrF/Knm/VSQ94DRsvv
	kIEPlsKg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57974 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffRn-00077N-0A;
	Wed, 05 Feb 2025 13:28:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffRT-003Z5u-CY; Wed, 05 Feb 2025 13:27:47 +0000
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
Subject: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work with
 older XPCS IP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:27:47 +0000

Older XPCS IP requires SGMII_LINK and PHY_SIDE_SGMII to be set when
operating in 1000BASE-X mode even though the XPCS is not configured for
SGMII. An example of a device with older XPCS IP is KSZ9477.

We already don't clear these bits if we switch from SGMII to 1000BASE-X
on TXGBE - which would result in 1000BASE-X with the PHY_SIDE_SGMII bit
left set.

It is currently believed to be safe to set both bits on newer IP
without side-effects.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 13 +++++++++++--
 drivers/net/pcs/pcs-xpcs.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1eba0c583f16..d522e4a5a138 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -774,9 +774,18 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 			return ret;
 	}
 
-	mask = DW_VR_MII_PCS_MODE_MASK;
+	/* Older XPCS IP requires PHY_MODE (bit 3) and SGMII_LINK (but 4) to
+	 * be set when operating in 1000BASE-X mode. See page 233
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf
+	 * "5.5.9 SGMII AUTO-NEGOTIATION CONTROL REGISTER"
+	 */
+	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_AN_CTRL_SGMII_LINK |
+	       DW_VR_MII_TX_CONFIG_MASK;
 	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
-			 DW_VR_MII_PCS_MODE_C37_1000BASEX);
+			 DW_VR_MII_PCS_MODE_C37_1000BASEX) |
+	      FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
+			 DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII) |
+	      DW_VR_MII_AN_CTRL_SGMII_LINK;
 
 	if (!xpcs->pcs.poll) {
 		mask |= DW_VR_MII_AN_INTR_EN;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 96117bd9e2b6..f0ddd93c7a22 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -73,6 +73,7 @@
 
 /* VR_MII_AN_CTRL */
 #define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
+#define DW_VR_MII_AN_CTRL_SGMII_LINK		BIT(4)
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
 #define DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII	0x0
-- 
2.30.2


