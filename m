Return-Path: <netdev+bounces-136564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF19A217F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463E2289324
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457D1DA0E3;
	Thu, 17 Oct 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SqqI9RnV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B1DA614
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165990; cv=none; b=m/faOjSy1xWkuOD9FTLMeDt8e3zGFq1Zlqud25DZUTcrLTd5xO/CNXXCZ85LYbDdcwnF0prPp1HhTusRhDH5LkU3vVCxWpNNitg/68Tbltu7SNZgQxrz+H/X1byYtzlS704s5fUvwSUhdcHyydpZJ/PECsE0yR7N94hISok5x1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165990; c=relaxed/simple;
	bh=UdjbPSC1LonZSLQJWakc0nocLVQ0IrcrtU1UpYKR8VA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RiyhRR2ku3TDLnwHUb95e1j7M29oElCt5ueX2lpedEWZ+exmacjUTjYxBWQkVTxBU9tuYQFdz9kIZhWT4TZpmuP+T+zvCS5OpPpa3/ioYuXebIPhctqJNXwexZ1VWWxSTwk6xdymJiSIc4WP/yB+MP8cSVN57EURXi3Ru/JXZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SqqI9RnV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zdwXXkdfjq+M0C+NgQ7UV+yKaTbBHvv0leqhyD+68wE=; b=SqqI9RnVOQBA8aQFV+ZCYiSiff
	wiU45swwauX6hk3h0BxLZx9MVkyBk1uKt3pY8GWJPPvSoRnplQDoCMxAvyl7X75LKRF2E+7FeMUTH
	Imp7140kPl32pDJveCJan8Oz0m2VasApf2J53eq2vPWbZonvu7XM+dWbRTgy0SLbRxDjoHlmFN0dw
	bXgUB3FBhaeXHJvZya9IQFUCUzkAlgYidlUbI3GRPtSIz24W1reMC1TFWZTdRc6tgrK0BkzbcHB/p
	IyoUvof7MbpOGuST71e7MHCWI5u6/EV3uyJH760Hi68U0qp+UBLHeWaQEtLnFwZmlh68q+UXDEUhh
	DU+yfm1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40506 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3s-0006VN-0l;
	Thu, 17 Oct 2024 12:53:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3r-000EKR-U5; Thu, 17 Oct 2024 12:52:59 +0100
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 5/7] net: pcs: xpcs: combine
 xpcs_link_up_{1000basex,sgmii}()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3r-000EKR-U5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:52:59 +0100

xpcs_link_up_sgmii() and xpcs_link_up_1000basex() are almost identical
with the exception of checking the speed and duplex for 1000BASE-X.
Combine the two functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 54 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 5b38f9019f83..6cc658f8366c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1104,41 +1104,32 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 	}
 }
 
-static void xpcs_link_up_sgmii(struct dw_xpcs *xpcs, unsigned int neg_mode,
-			       int speed, int duplex)
+static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
+					 unsigned int neg_mode,
+					 phy_interface_t interface,
+					 int speed, int duplex)
 {
-	int val, ret;
+	int ret;
 
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
-	val = mii_bmcr_encode_fixed(speed, duplex);
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
-	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
-			__func__, ERR_PTR(ret));
-}
-
-static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
-				   int speed, int duplex)
-{
-	int val, ret;
-
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
-		return;
+	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
+		if (speed != SPEED_1000) {
+			dev_err(&xpcs->mdiodev->dev,
+				"%s: speed %dMbps not supported\n",
+				__func__, speed);
+			return;
+		}
 
-	if (speed != SPEED_1000) {
-		dev_err(&xpcs->mdiodev->dev, "%s: speed %dMbps not supported\n",
-			__func__, speed);
-		return;
+		if (duplex != DUPLEX_FULL)
+			dev_err(&xpcs->mdiodev->dev,
+				"%s: half duplex not supported\n",
+				__func__);
 	}
 
-	if (duplex != DUPLEX_FULL)
-		dev_err(&xpcs->mdiodev->dev, "%s: half duplex not supported\n",
-			__func__);
-
-	val = mii_bmcr_encode_fixed(speed, duplex);
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR, val);
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
+			 mii_bmcr_encode_fixed(speed, duplex));
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
@@ -1151,10 +1142,11 @@ static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	if (interface == PHY_INTERFACE_MODE_USXGMII)
 		return xpcs_config_usxgmii(xpcs, speed);
-	if (interface == PHY_INTERFACE_MODE_SGMII)
-		return xpcs_link_up_sgmii(xpcs, neg_mode, speed, duplex);
-	if (interface == PHY_INTERFACE_MODE_1000BASEX)
-		return xpcs_link_up_1000basex(xpcs, neg_mode, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_1000BASEX)
+		return xpcs_link_up_sgmii_1000basex(xpcs, neg_mode, interface,
+						    speed, duplex);
 }
 
 static void xpcs_an_restart(struct phylink_pcs *pcs)
-- 
2.30.2


