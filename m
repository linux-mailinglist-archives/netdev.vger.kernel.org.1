Return-Path: <netdev+bounces-236285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD1C3A8AD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC81A450CD
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EB30DD29;
	Thu,  6 Nov 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TxVYwpXX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5402E5B0E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428201; cv=none; b=HzhHlvZV2csl7EKyNaCS4kmTB9nvDUd3lVR/XSGpSN7lY/v9JKmUMRNxnQo+JuCZdP+4Ib/mqI4daYfS+9yZa8V2qBAbqIIWzncRjncRrztlKfEQH+oXGLCmGXyEGWykDRx/KJUQA/Im1eYJT2wKmhk/1kjVGJ6uzlEeWxpzTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428201; c=relaxed/simple;
	bh=c/cWgRnk+VO8IerRHoiEIiSWyknxj+MOfwESiP8g8/c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fpx8ebE44r6Y0mEgjZFI9oTzKU7tEb4MuGtMWsKSx+X1VyMvU6F/KRGf4m4rAofB2F3Os6t1eACRcUcr7MbWvq2wp6VZEl+VsvI238FVVr53J6fAZ9yp1FePCqODogUoMuQcyS7HPA3wc6QZgmA/cjANV1+Iwn7C5EKU4jhAzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TxVYwpXX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X4UCwVyKzHujgFhWgXUmNylgGLEyCpXl2odXacDq9ZE=; b=TxVYwpXXabYXNoW2h/c2rAsT8P
	cCYGxCLn0gXte1++gBcoznPEMv52vOOBn61Vtz3mfZMaQZ0/1xu4/8GKeZ/sgSQI4ULUUtOddylnZ
	G/0qRV3O4KMvfP+LzWDzMe4Jmtiy4m1hteKBR/A5mI8WlSXF9ff1JWOCztwML8ncaY6faREjcbyb0
	jQQBttWdKOdfpwFzCaS+Y7PA9zPN02LP3KRHAZjPq8EQiA/EmF6zCmSXWwOXnlvulr9nXU5HdDEbO
	OzqH+WZ0qCXZ9+IsF1zF7ZcOQ1P376/OBkgG/ixnUeJaW+lp9k7zWPxsEaVVxcXl+p1fHBfJj3MPw
	1sL0ak5A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44972 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5A-000000004uE-25o5;
	Thu, 06 Nov 2025 11:23:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy59-0000000DhQ1-393H;
	Thu, 06 Nov 2025 11:23:11 +0000
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
Subject: [PATCH net-next 1/9] net: stmmac: lpc18xx: convert to PHY_INTF_SEL_x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy59-0000000DhQ1-393H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:11 +0000

Use the common dwmac definitions for the PHY interface selection field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 6fffc9dfbae5..66c309a7afb3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -22,8 +22,8 @@
 /* Register defines for CREG syscon */
 #define LPC18XX_CREG_CREG6			0x12c
 # define LPC18XX_CREG_CREG6_ETHMODE_MASK	0x7
-# define LPC18XX_CREG_CREG6_ETHMODE_MII		0x0
-# define LPC18XX_CREG_CREG6_ETHMODE_RMII	0x4
+# define LPC18XX_CREG_CREG6_ETHMODE_MII		PHY_INTF_SEL_GMII_MII
+# define LPC18XX_CREG_CREG6_ETHMODE_RMII	PHY_INTF_SEL_RMII
 
 static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 {
-- 
2.47.3


