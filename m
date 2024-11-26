Return-Path: <netdev+bounces-147371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B99D9467
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184B4163F1D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074D1D4352;
	Tue, 26 Nov 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LnPuZ5cM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D41BA86C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613134; cv=none; b=p7MKYnjLxGX/UqHj6dCiLXyU5aB4xTkHS85bdokpvliyaJUzAOoMe2L0vj84KbXldvho6R1/WmeIAJOuiwf36omEb0ckxRCYKKtfNEPOsCu+suSlFzWv/fZrGSOPkhm3dru1W6RB92PAM8iRRsQBI4AKiBX0wYmcEKiZlu7tdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613134; c=relaxed/simple;
	bh=3q2GSUIfMLuYYHPDl+5tah3ircLf3D4P5iLONXakGTo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=izD2RPWl24URJXNnnVuP65AA4gz4FZfA6XYdQoo9uN9GOjd6ph/ZGubMRc81XhSZ2N4ffDVcLCCnX1kQeNZKlAVkFfjL7KfjIWkQrp4SoQ1gP7MvHiZ3Q0ZZ1FhpNWHUuTD543JGBlAPBKvBQTA5wKFJWlIrjfNnP+uoFn/pOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LnPuZ5cM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CpTJ7ep7WjNgRdD+PpFVRfcu1rVLPyYDfT8jjGhsaVw=; b=LnPuZ5cM/QCEy7/toUkkCR2DJI
	Kmc7f/FM73ibcxdv6sLAU1AFBh0/aRfTwx99wKGolnP5yH6geh2UAbUIHttlBji/1UOkqbAK06aVv
	TIfJ/qp0eftWm07O0Kdc68e6y+MvMl/UgFFte7as5W2iQfmE3sZbU7od5JXmipeosu//+E3XeFxro
	3gwxNoZhxeTF1iohFsbs+9yT5Ryzld0oYvjEdOyAS4f4YrmUtirsT0ccfwmKCaty3mzm3MxjOLafp
	MDQCjHy9ZkJMUFzjIks9aiPe7jEny+2bUHFJpqCa6t22ss1TpTy/ggYdUzWbQWPaEnJWpBIwU+ZxK
	sGC3dkcg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35156 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFros-0006VM-13;
	Tue, 26 Nov 2024 09:25:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroq-005xQk-SU; Tue, 26 Nov 2024 09:25:16 +0000
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
Subject: [PATCH RFC net-next 12/16] net: pcs: pcs-lynx: implement
 pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroq-005xQk-SU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:16 +0000

Report the PCS in-band capabilities to phylink for the Lynx PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-lynx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index b79aedad855b..767a8c0714ac 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -35,6 +35,27 @@ enum sgmii_speed {
 #define phylink_pcs_to_lynx(pl_pcs) container_of((pl_pcs), struct lynx_pcs, pcs)
 #define lynx_to_phylink_pcs(lynx) (&(lynx)->pcs)
 
+static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
+					 phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE;
+
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LINK_INBAND_ENABLE;
+
+	default:
+		return 0;
+	}
+}
+
 static void lynx_pcs_get_state_usxgmii(struct mdio_device *pcs,
 				       struct phylink_link_state *state)
 {
@@ -306,6 +327,7 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 }
 
 static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
+	.pcs_inband_caps = lynx_pcs_inband_caps,
 	.pcs_get_state = lynx_pcs_get_state,
 	.pcs_config = lynx_pcs_config,
 	.pcs_an_restart = lynx_pcs_an_restart,
-- 
2.30.2


