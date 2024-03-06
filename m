Return-Path: <netdev+bounces-77875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2D8734E6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7090828A6BB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A8605BF;
	Wed,  6 Mar 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZvsP4LoG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1F605B6
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722307; cv=none; b=SvRC/1ukyZBhR9NL37LpqZ61V7PIJG8/E0H+pvS+nHSm4TwhRdVn4H6jY22S70KFD9UJ6Fn/LVzGjXtJjEbuD2E7pL7OZK+8KzsNx16VNfQQ3+yV7L8bBeeUTjKJpgeFZGIHO0Dp2OSXZYCbuJZNd52Z5MDWmqNrPdTFepXeqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722307; c=relaxed/simple;
	bh=QcP8yJWLf17IQe+xnQ5YEAhSrf8CNwC7dT8L6K0U420=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Ix0Zrbg3oi/FWw3qAhcV9Vl1xTIFFT3ZpeAvbWP0b/jsx3J1veNpZ6pJARxIyPwVjecCKBsoyLYdVN/jqiJteRkfDN3pZTLZZtyAb4faIQjYzGiKj8G7grpEOQRYJGXJI+5QzoTGU4+4cpTV3HaCz3Ge+NSmqvi0taixlosNW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZvsP4LoG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UrrKmj5hrNxnqYEzpIYJHdCYNBEpE4d24Vi0vLAhXQs=; b=ZvsP4LoG8FAz0kCd6l6pWb61lI
	ZtW1iiQR+03XmXAXsORJBhw10P0rd8f2UEXbFy+wvvjk8HiGGyXINE6evkKUehH7uvCk20HNVqrja
	x45xJJ6xUkpii0/pMzpqUaWGReAQ5wID36OwBCBsekP4fbEmGKC3n9FA3AOO0lPCxe4qsWejyxy92
	H9O6Oo2S/wBRu8WHY1ckhVLNKylsjLhJY1zdauw0vamTxo3WTzjWEnxvsCBOx2Hid6TIwxMji3ExI
	3CNusWfOmmTJQoAeUGlHeBk3mXMOeIyLop9UKdhBQ9mUnc+quP6fy+rVnwmFR9XAEoDEQP6e6K16T
	H0zMpgfQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41248 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rhos4-0008F2-1D;
	Wed, 06 Mar 2024 10:51:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rhos4-003yuQ-5p; Wed, 06 Mar 2024 10:51:36 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phy: marvell: add comment about
 m88e1111_config_init_1000basex()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rhos4-003yuQ-5p@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 06 Mar 2024 10:51:36 +0000

The comment in m88e1111_config_init_1000basex() is wrong - it claims
that Autoneg will be enabled, but this doesn't actually happen.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 1faa22f58366..42ed013385bf 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -919,7 +919,10 @@ static int m88e1111_config_init_1000basex(struct phy_device *phydev)
 	if (extsr < 0)
 		return extsr;
 
-	/* If using copper mode, ensure 1000BaseX auto-negotiation is enabled */
+	/* If using copper mode, ensure 1000BaseX auto-negotiation is enabled.
+	 * FIXME: this does not actually enable 1000BaseX auto-negotiation if
+	 * it was previously disabled in the Fiber BMCR!
+	 */
 	mode = extsr & MII_M1111_HWCFG_MODE_MASK;
 	if (mode == MII_M1111_HWCFG_MODE_COPPER_1000X_NOAN) {
 		err = phy_modify(phydev, MII_M1111_PHY_EXT_SR,
-- 
2.30.2


