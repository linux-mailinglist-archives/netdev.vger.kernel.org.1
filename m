Return-Path: <netdev+bounces-236290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3AC3A939
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECECE4608D3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6D30BF66;
	Thu,  6 Nov 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fj68tNPd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A782C0F67
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428227; cv=none; b=hQ0KzKySKU0M2D2uxFulhnc63wadSs9gN1mXAPkm4FDRZ4dNa+Z0SKUGV7OuIgY5aK6tcaeN69FuSe1FISLeTC/HrwnuQMlyfrWSa+3GNLF7iaIUX3XKUClROPtr4FtrZ4rXN6SdvUizBU/gXAzrpG2JwS2t6jDtJVnJQOs15FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428227; c=relaxed/simple;
	bh=E80DxlZj6gmYDzct0lCEywDEfFijD3se+8++J6e/rUE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=htL3ZxdHE8ajRuP0Zbcou9DjOJL9V9IaPFJwVMFjfhoaSXVg4CUqBNu9qwoISetjN+1IJLK3ztjjhws/7S3LzBiPTj7NY5E7h0HsyThZD4c0w6bJMjXpL4aPJjZltyB9e8VsQ86FRC7hyRd0i7DksoLfE0de0Q0P8yfFvO1Mpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fj68tNPd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ixru25OiBe6UnUEPl+muwDgqr8p/6jSsc5BNi9e89ws=; b=Fj68tNPd2VxqZ8XghYzQkIoEXr
	EjU9T1/58Z9OZ0C3QYmHnNvx8HK5uQNP+W5Ngq06fR0uBOgGj8zKbTHNjq8ahfwZPisl8ISzs/aQc
	MvHUuCLt1oECcMKx5dn4NPs7cu4YjNKxewgg8Z8OYfEBW6U6qIHd+8s8LJ2IsUtgNz7e5go5UGLm5
	MB7xZjnw9b/IKI00zE9Pl3M4RksNQW7uLrVCMQmp5FHy05ll2xmYwO+g0kdj8VePD01my2iOmJS6L
	hMhzj5sLjkok8BM9EDoWnFgSmrjCnLdhcIiUXTJcCZ5jSarnl5elyyiXtwmDP2neWEUMK7BP1N23D
	ELJRWDUA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53560 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5a-000000004vk-1bev;
	Thu, 06 Nov 2025 11:23:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5Z-0000000DhQV-1e2l;
	Thu, 06 Nov 2025 11:23:37 +0000
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
Subject: [PATCH net-next 6/9] net: stmmac: sti: use PHY_INTF_SEL_x to select
 PHY interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5Z-0000000DhQV-1e2l@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:37 +0000

Use the common dwmac definitions for the PHY interface selection field,
adding MII_PHY_SEL_VAL() temporarily to avoid line wrapping.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index 53d5ce1f6dc6..1e8769a81d77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -77,13 +77,15 @@
  *	001-RGMII
  *	010-SGMII
  *	100-RMII
+ * These are the DW MAC phy_intf_sel values
  */
 #define MII_PHY_SEL_MASK	GENMASK(4, 2)
-#define ETH_PHY_SEL_RMII	BIT(4)
-#define ETH_PHY_SEL_SGMII	BIT(3)
-#define ETH_PHY_SEL_RGMII	BIT(2)
-#define ETH_PHY_SEL_GMII	0x0
-#define ETH_PHY_SEL_MII		0x0
+#define MII_PHY_SEL_VAL(val)	FIELD_PREP_CONST(MII_PHY_SEL_MASK, val)
+#define ETH_PHY_SEL_RMII	MII_PHY_SEL_VAL(PHY_INTF_SEL_RMII)
+#define ETH_PHY_SEL_SGMII	MII_PHY_SEL_VAL(PHY_INTF_SEL_SGMII)
+#define ETH_PHY_SEL_RGMII	MII_PHY_SEL_VAL(PHY_INTF_SEL_RGMII)
+#define ETH_PHY_SEL_GMII	MII_PHY_SEL_VAL(PHY_INTF_SEL_GMII_MII)
+#define ETH_PHY_SEL_MII		MII_PHY_SEL_VAL(PHY_INTF_SEL_GMII_MII)
 
 struct sti_dwmac {
 	phy_interface_t interface;	/* MII interface */
-- 
2.47.3


