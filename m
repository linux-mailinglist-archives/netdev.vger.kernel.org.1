Return-Path: <netdev+bounces-236286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964BC3A8B0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0771A4535A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441B30DEAC;
	Thu,  6 Nov 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HCDmMuFW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5A2E5B0E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428205; cv=none; b=YkgwXsscF5wQWGWAIeYvjXc5R3v8vLWc72dTrdzZSsrp74b11u9dcxX20QNBBpd4v2KZBUTc4GpoxnDTyGbsn3I6UsleIPMZAci7doOxlmEj3R3CbzpjBe16oCfH0Lr5KiYKz3JwkoFuE/PYZ+UH+ZSOhIF49ofyM++rspG8byA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428205; c=relaxed/simple;
	bh=2ubt1ieqFOLeVpZDjrIAFe2HWsEQ6RUoD2cqjT9S0gA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=neQSSfbL6IDQE0WAf3CTfWu/g0vaFDfldPZpYMhEubshoBjHy2y0jFSvh55hAn45icgVO8FbrXzBomzxUgTf6vaOTMEomvwTJivoC3NrGI5QEiJcfAXm86BiI6AS14BaXd07Su9kfcPD9khZ3nZhNVSROxqZjpWm73p+h3F9DOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HCDmMuFW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+qNx0Ni/kc8SkhRMYGZFqBomWjfjeFGuoDaPz2DpBLg=; b=HCDmMuFWVCBxIY/eIwflhjO8q7
	W4SwitUKmyqnX+gbgti54PyNSxS0k/H/Z0//RLLlRZGsf84qDi4XL5ghrUWxMCdIzXAHQUGjkTn+R
	2qU+JU/bZ6xabiRp/TE8H+s5nIhTcPVMoHG48rdjj2GvGmKWx86bMpJCl/71hlxOJxZ/vXNvWCSfB
	2DsH73sjpJP2wxzDraT34Zck/sfmqavnIH/tf4DM3Y4nAZBAk26gNMtyc58uY+1f3tE7/kY8ab0uZ
	29tgwARwYR7uNOQxVK7F67X1NIR3lIo48CcppS6Bqp3jUlHkMgVvOFedN5Zt5jMpAhLffh2VwNnYh
	EZgh5U/A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44978 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5F-000000004uQ-2bXZ;
	Thu, 06 Nov 2025 11:23:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5E-0000000DhQ7-3cuy;
	Thu, 06 Nov 2025 11:23:16 +0000
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 2/9] net: stmmac: lpc18xx: use PHY_INTF_SEL_x
 directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5E-0000000DhQ7-3cuy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:16 +0000

Use the PHY_INTF_SEL_x values directly rather than the driver private
LPC18XX_CREG_CREG6_ETHMODE_x definitions, and convert
LPC18XX_CREG_CREG6_ETHMODE_MASK to use GENMASK().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 66c309a7afb3..895d16dc0a4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -21,9 +21,7 @@
 
 /* Register defines for CREG syscon */
 #define LPC18XX_CREG_CREG6			0x12c
-# define LPC18XX_CREG_CREG6_ETHMODE_MASK	0x7
-# define LPC18XX_CREG_CREG6_ETHMODE_MII		PHY_INTF_SEL_GMII_MII
-# define LPC18XX_CREG_CREG6_ETHMODE_RMII	PHY_INTF_SEL_RMII
+# define LPC18XX_CREG_CREG6_ETHMODE_MASK	GENMASK(2, 0)
 
 static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 {
@@ -50,9 +48,9 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	}
 
 	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_MII) {
-		ethmode = LPC18XX_CREG_CREG6_ETHMODE_MII;
+		ethmode = PHY_INTF_SEL_GMII_MII;
 	} else if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) {
-		ethmode = LPC18XX_CREG_CREG6_ETHMODE_RMII;
+		ethmode = PHY_INTF_SEL_RMII;
 	} else {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
 		return -EINVAL;
-- 
2.47.3


