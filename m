Return-Path: <netdev+bounces-147370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889249D949F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AEB2D315
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0971D47D2;
	Tue, 26 Nov 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xujefXPZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33001D47C3
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613128; cv=none; b=jWFn0r/GsDO7f+eVWI7OgKA7WxIR1O1/N55jUWyeAxVdsZjZcBdLCnbPNlEqK18Tx070jvPVQqL2FhNxZxCXqMaWRrboJX5XgUdRZjput3x9lS8wuwV28AtSgXLqheTOnE6Yxz5dVHFLgFQuJfEsQpCp7twUTg9yW4KskiVC4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613128; c=relaxed/simple;
	bh=NXZUkVyX4OD6isDkhqk7ctD+OLKDh8NLiondv4K7d+0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TSIVeLSDJLlPrMAJ1+gK0CBiNWGNG1lWp8DGsT8/ylyZwrtFlz+7nyWgKdiP2Q1G2YXM34LPZg5tfcoAwZV4eQLBamq1CGF9UT5yHnbQQ5gBMRphVALYt7HDAzB7RWzn2sFPw3Uv1JQU7zI0F0BIJKjBXDpqwCEk9ZsHYl6dyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xujefXPZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q29RUPutLmuuyf9faHhOKORrc2m54NhTCroX/m+7cLM=; b=xujefXPZgKsCaPwA+WmgsyBufV
	qVsTNt6ZLHLgj4SLSbZsU9Jb5UgSObfpkn0fiWBlNKgKVgu5iHD6oOELmMA6sM2K0o7FdjDu0a801
	RiPa7faoW8PNqOqbls68dwNmuKPLzaYDjwEpccptH7FC+WwLNoZDvA46E9yPgc5djQXoSpBJoMYfr
	2wd1v48XpX0mfRQ/TfMB3DqdPKL2o+3INNRreyT7uN0W9p11zf4aTJiPVmfZvWzKxPy7QbltAa0rV
	IuqP9ztqJEYFl3TPYDnCcxMbgMZdBLHtRBml3Ym2s/1lDD9vI7w+3Ovj9sB8mjkUlD+nuyyELeNru
	8Gb4VZbQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48390 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFron-0006V0-0J;
	Tue, 26 Nov 2024 09:25:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrol-005xQe-Ou; Tue, 26 Nov 2024 09:25:11 +0000
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
Subject: [PATCH RFC net-next 11/16] net: mvpp2: implement pcs_inband_caps()
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
Message-Id: <E1tFrol-005xQe-Ou@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:11 +0000

Report the PCS in-band capabilities to phylink for Marvell PP2
interfaces.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 571631a30320..f85229a30844 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6224,19 +6224,26 @@ static const struct phylink_pcs_ops mvpp2_phylink_xlg_pcs_ops = {
 	.pcs_config = mvpp2_xlg_pcs_config,
 };
 
-static int mvpp2_gmac_pcs_validate(struct phylink_pcs *pcs,
-				   unsigned long *supported,
-				   const struct phylink_link_state *state)
+static unsigned int mvpp2_gmac_pcs_inband_caps(struct phylink_pcs *pcs,
+					       phy_interface_t interface)
 {
-	/* When in 802.3z mode, we must have AN enabled:
+	/* When operating in an 802.3z mode, we must have AN enabled:
 	 * Bit 2 Field InBandAnEn In-band Auto-Negotiation enable. ...
 	 * When <PortType> = 1 (1000BASE-X) this field must be set to 1.
+	 * Therefore, inband is "required".
 	 */
-	if (phy_interface_mode_is_8023z(state->interface) &&
-	    !phylink_test(state->advertising, Autoneg))
-		return -EINVAL;
+	if (phy_interface_mode_is_8023z(interface))
+		return LINK_INBAND_ENABLE;
 
-	return 0;
+	/* SGMII and RGMII can be configured to use inband signalling of the
+	 * AN result. Indicate these as "possible".
+	 */
+	if (interface == PHY_INTERFACE_MODE_SGMII ||
+	    phy_interface_mode_is_rgmii(interface))
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	/* For any other modes, indicate that inband is not supported. */
+	return LINK_INBAND_DISABLE;
 }
 
 static void mvpp2_gmac_pcs_get_state(struct phylink_pcs *pcs,
@@ -6343,7 +6350,7 @@ static void mvpp2_gmac_pcs_an_restart(struct phylink_pcs *pcs)
 }
 
 static const struct phylink_pcs_ops mvpp2_phylink_gmac_pcs_ops = {
-	.pcs_validate = mvpp2_gmac_pcs_validate,
+	.pcs_inband_caps = mvpp2_gmac_pcs_inband_caps,
 	.pcs_get_state = mvpp2_gmac_pcs_get_state,
 	.pcs_config = mvpp2_gmac_pcs_config,
 	.pcs_an_restart = mvpp2_gmac_pcs_an_restart,
-- 
2.30.2


