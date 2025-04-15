Return-Path: <netdev+bounces-182888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD8A8A46A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72D1189EB7F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF529A3FE;
	Tue, 15 Apr 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m4EjXFXO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C3268C79
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735389; cv=none; b=XqpqvWoHeB5JvER9dG6oXXOH+uubB/CfbBcI/Ydq4hEkSEaru4YhDcfyGAKU/3To45BmvzkjEkbhvgL2/Z8i3jDhojQxXjEMTOzDotIy9Bse5fDOAmMrDgHizd2dUcp57rfBKX3zObkWC/FMFXxXFURg0y4EcGOXeCLYeBI94fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735389; c=relaxed/simple;
	bh=L/Jvz/AAVPSqXLAn0GTZrVh7/kiKPxS09awnmgOn/Jw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=iH/wJVN/lTKaYzBQXOH7mxtTOWT618YH3h1Ci+EgBN10AUJz7FT9xh8WsxukYaSRH8KU1yVUnLRMbMd5KlK9wsFMFK0+AshOcHdS3kFENOq2T0UkT81KWoJV8R/qXGyCi1asusPlxqMSqUw64V/76OgLQ/OtrZsw1uA+31Hj6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m4EjXFXO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ygajSd1GoADtgJHoVQD1nG09yoLswhvg7GNMQk1G7Ts=; b=m4EjXFXOke+PyYG0vZ0RghbcyP
	HzNUpBXNynINV4KieJZcX+97P4vS78uPA/HwlohSjU4CnDfYHZAuzX0J6FMiHpGEFO49G/fey2Xct
	y8PTmuL4RnbN2waGULstWrBlsmoTdorLqTKOH6So0ai1TrvIYN6kIYswW5UT0IfrFeR9Wm+731M6l
	kqKfXJugRikahFA0IDA9J6MUL+ZArBn4jMjPURNVOzzUZYYA0J0CWIKXmakOHochX99Who7oTm/zU
	Q5i8XX1HYQsnQm245bMw7FOkTF4zv9GcuOtYVv/zqR99TpL9vvHNqnJTG1fb4qwXGXIhNN9O6nDGD
	BcIhCVaQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35468 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jNF-0008Vr-1c;
	Tue, 15 Apr 2025 17:43:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4jMd-000rCG-VU; Tue, 15 Apr 2025 17:42:24 +0100
In-Reply-To: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/3] net: stmmac: sti: use
 phy_interface_mode_is_rgmii()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4jMd-000rCG-VU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:42:23 +0100

Replace the custom IS_PHY_IF_MODE_RGMII() macro with our generic
phy_interface_mode_is_rgmii() inline function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index be57c6c12c1c..c580647ff9dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -23,12 +23,7 @@
 
 #define DWMAC_50MHZ	50000000
 
-#define IS_PHY_IF_MODE_RGMII(iface)	(iface == PHY_INTERFACE_MODE_RGMII || \
-			iface == PHY_INTERFACE_MODE_RGMII_ID || \
-			iface == PHY_INTERFACE_MODE_RGMII_RXID || \
-			iface == PHY_INTERFACE_MODE_RGMII_TXID)
-
-#define IS_PHY_IF_MODE_GBIT(iface)	(IS_PHY_IF_MODE_RGMII(iface) || \
+#define IS_PHY_IF_MODE_GBIT(iface)	(phy_interface_mode_is_rgmii(iface) || \
 					 iface == PHY_INTERFACE_MODE_GMII)
 
 /* STiH4xx register definitions (STiH407/STiH410 families)
@@ -148,7 +143,7 @@ static void stih4xx_fix_retime_src(void *priv, int spd, unsigned int mode)
 			src = TX_RETIME_SRC_CLKGEN;
 			freq = DWMAC_50MHZ;
 		}
-	} else if (IS_PHY_IF_MODE_RGMII(dwmac->interface)) {
+	} else if (phy_interface_mode_is_rgmii(dwmac->interface)) {
 		/* On GiGa clk source can be either ext or from clkgen */
 		freq = rgmii_clock(spd);
 
-- 
2.30.2


