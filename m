Return-Path: <netdev+bounces-148576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE119E2814
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1048BC1CF1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4C1F76DD;
	Tue,  3 Dec 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DhFrAZxJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03061F75A8
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239906; cv=none; b=JyZNCNavQfBkhEFK15aGFbeTxHSAk9NPjqpC53ww+XtEZAh1hHoh7CRzTdcqzsxTfZc/tz2ZDBcFwE5eg55kkNkH2hb/9Fpv3FRDGwfrn28SvLmIdDlV2fN2WIm7GqgRgKi5sG5B2azNRZ3TOoxI2OQVcRx4xBYrJfbgq5YhTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239906; c=relaxed/simple;
	bh=EbOVfMEe1oG5j0juZEyB2UY0MGxtGv2CKVVqc0xUUEw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hTLHfVyKQF1ZyTrTOi0R0COG1yFpabDelE/b9uZyTOLmmsTJj7XH6/Vux+JjCA+OBXS43euV4bNe89FB8anDaRyEbYJwSlw9hRKB4BAJJ1c3Vce0moaOxUdmjf4FjMCcal5saTBHCXoHYZVs+UunwlgDMPEeZuBHstgcQskWBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DhFrAZxJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CwmjIWgWS0Yo2hvUAdTCMu08253eld1fcGvWjxo5kCw=; b=DhFrAZxJ5G5+h03ILKH3rEF0lY
	pAWG5MlGKlWxSnHaQ/zqChDsS2nXavsl6UPYMogtcH9ATh9735wX2BKiYoGdpyiMS1TzYgajCy2ta
	PV61+FACwyag9FO4DETwk8IPR2TWaur2Hr4HRAwikXKaRlm8g5Q+wrqZe/K1xL0wEjaWQCyo2qrf7
	GLbeBe9xLdmEQD2LfuUalMYQ33z9UblUsiI4BhyvV1YmbxH2s3N/odhYf5RV65Ypu8KxYyJvs6/GV
	k1yym5kKRfb8v1ju9t7G4f7HIrDXHzzTcZLcYfPOVlcT9ZCZSPnesssWteS8WWI7NTtMjEBA9RvTS
	pZzq03OQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44304 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUsF-00029c-1k;
	Tue, 03 Dec 2024 15:31:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUsE-006IUh-E7; Tue, 03 Dec 2024 15:31:38 +0000
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
Subject: [PATCH net-next 11/13] net: mvpp2: implement pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUsE-006IUh-E7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:38 +0000

Report the PCS in-band capabilities to phylink for Marvell PP2
interfaces.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


