Return-Path: <netdev+bounces-148575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DC9E2323
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50335285439
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D81F8924;
	Tue,  3 Dec 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vz3DvbY+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CF1F4276
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239901; cv=none; b=vA56G7TnWjP1hwtJcvl3yu0Y56mBME5iiT0bJFKbk75fnGhfnEl2kDVp9NO5+SyGaJcomTdiqpx0D/Qi81WALOk24vwPf424zp1d7U51P1q42y9YJ5J6xiLReRKxdckYnKUloBHXBMVP+MipzUfeMW53fjfnz1EjszL0E14KT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239901; c=relaxed/simple;
	bh=X0qwapyUsrEpSHMNcscKWYHkLt2g6cYZNm8lpCbQ1Lk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=K8v8gvc6sH9si1+MnnkS1N3WrSinFv+GUq4i4x2ueKhKfHvdc45qSIZbRBceOHUVNT+7kpn1h3kwObOoCeiz9CSNt6XJWKiYw4Q8rrAb+1asW7aTt/79txNz9wxKE7ZO81q9TThkIEQHhVQ+vpVH0uK++x+v1rHmOuRp3ocnH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vz3DvbY+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8LWXyRzlh1tYzxSZ6UGZOAuIyZIbT0gxySKTN5+FJcI=; b=Vz3DvbY+8jO8ntvkWj2LqbEZ1l
	jiVqCc4Ble6g9/NsMaj4i59VarspQbQ48BGshtYn1HwT1CelZiHHyvT4PpEW8i0g9p3pLmoYS7n+D
	b8T0e+m93E6zygm/o6xSd9cCy+HRQordTMWf8maBVLc6DOygrjKnRPjlUKcU2tKCOaPdL2YPoRsmS
	7D80ywYKwAYMVpfWKQw1sbGWy5VtU39GYJ3k3cBWJzE2l1JidtaLgggSUTHeUPhtpv4Lsm/tap0k5
	WoRPLQ/Hrs58+1uIvmpDHrdrS2DGBhRqRRk03IPAtUAUFPUqeK5q3hdeqB841vcxpTcq7KCOt91CM
	oVPnPwcg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48906 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUsA-00029P-1L;
	Tue, 03 Dec 2024 15:31:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUs9-006IUb-Au; Tue, 03 Dec 2024 15:31:33 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 10/13] net: mvneta: implement pcs_inband_caps()
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
Message-Id: <E1tIUs9-006IUb-Au@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:33 +0000

Report the PCS in-band capabilities to phylink for Marvell NETA
interfaces.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


