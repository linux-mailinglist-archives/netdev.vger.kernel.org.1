Return-Path: <netdev+bounces-147369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74599D9466
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C7F1664CF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88A1D47AE;
	Tue, 26 Nov 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JmL4qWR8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58971D4352
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613123; cv=none; b=F//P3VbYpo9OZr6sYmURX/COs6m/5I0E1em5PxMQTtxBHRFFi9myaqffFcjoDAe7eGa0t6Tqxz47UxT29/KInbqOzkr0EaQQ1MyejaS6nKzvClY7/rgI24TbDgkipgXNd7M9+RnzP0sjSq0TE9dPlZ+hFqootxLVnZCAxzt7K3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613123; c=relaxed/simple;
	bh=N4tY6A2u9Q0fTDqvGdRM7Mb8JEPH8zBB7CswbbDGJvY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YdDednSNrI0K8iE+HsRUjH/nqyUMidfocp5nCRueyp1GTZfZmD0vwtU4c0bKHZ67+zEjlWQp4kIGIcYaTyxy8sCyVj+G1lHvDHwMORSk6bzwBnilZ/Jd3wZU9/zU/LO5tVgzYrly2P7UDJYgPKkB6tH5e8GQOrPi1Cq29k1ePpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JmL4qWR8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d/SaYN5ixsZSGbz+KRnlynR+PwAA7B1T3Unbav9zZD0=; b=JmL4qWR8VpO2j/Csq6xn4np/Mk
	RksAJu2UIme7abwllYaKbsy75cpQ51onBnYlQ0hE0dWxCP4AOc4f/kO2A5StcQdDpSaFRWxKNzxP3
	8r7SRFsnAn7iYQLeO3julsMfpQEBr+i+5uWpix+K05vcsiSk1CNUzpk3SJhZQeikG/5AFP3sLtoIe
	vB6ewzMMd9ExR64ysc/XOhk2qqK4wo4AK3vrteTQoG21YjiPgsm718uMc/Um5YxsnPw1PqeaeT8fE
	ORFp66FQy2BKfU/Qm8+ZoK4ZQMY68XGxi8scdnWSN8waX81vXeXId6UCLrRCukrthvH044LsSQqO2
	dMZbJS9A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48388 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroi-0006Ue-09;
	Tue, 26 Nov 2024 09:25:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrog-005xQY-LH; Tue, 26 Nov 2024 09:25:06 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 10/16] net: mvneta: implement pcs_inband_caps()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFrog-005xQY-LH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:06 +0000

Report the PCS in-band capabilities to phylink for Marvell NETA
interfaces.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 1fb285fa0bdb..fe6261b81540 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3960,20 +3960,27 @@ static struct mvneta_port *mvneta_pcs_to_port(struct phylink_pcs *pcs)
 	return container_of(pcs, struct mvneta_port, phylink_pcs);
 }
 
-static int mvneta_pcs_validate(struct phylink_pcs *pcs,
-			       unsigned long *supported,
-			       const struct phylink_link_state *state)
+static unsigned int mvneta_pcs_inband_caps(struct phylink_pcs *pcs,
+					   phy_interface_t interface)
 {
-	/* We only support QSGMII, SGMII, 802.3z and RGMII modes.
-	 * When in 802.3z mode, we must have AN enabled:
+	/* When operating in an 802.3z mode, we must have AN enabled:
 	 * "Bit 2 Field InBandAnEn In-band Auto-Negotiation enable. ...
 	 * When <PortType> = 1 (1000BASE-X) this field must be set to 1."
+	 * Therefore, inband is "required".
 	 */
-	if (phy_interface_mode_is_8023z(state->interface) &&
-	    !phylink_test(state->advertising, Autoneg))
-		return -EINVAL;
+	if (phy_interface_mode_is_8023z(interface))
+		return LINK_INBAND_ENABLE;
 
-	return 0;
+	/* QSGMII, SGMII and RGMII can be configured to use inband
+	 * signalling of the AN result. Indicate these as "possible".
+	 */
+	if (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_QSGMII ||
+	    phy_interface_mode_is_rgmii(interface))
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	/* For any other modes, indicate that inband is not supported. */
+	return LINK_INBAND_DISABLE;
 }
 
 static void mvneta_pcs_get_state(struct phylink_pcs *pcs,
@@ -4071,7 +4078,7 @@ static void mvneta_pcs_an_restart(struct phylink_pcs *pcs)
 }
 
 static const struct phylink_pcs_ops mvneta_phylink_pcs_ops = {
-	.pcs_validate = mvneta_pcs_validate,
+	.pcs_inband_caps = mvneta_pcs_inband_caps,
 	.pcs_get_state = mvneta_pcs_get_state,
 	.pcs_config = mvneta_pcs_config,
 	.pcs_an_restart = mvneta_pcs_an_restart,
-- 
2.30.2


