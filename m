Return-Path: <netdev+bounces-242987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080BC97E8C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28413A27CD
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A831A7F4;
	Mon,  1 Dec 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i3/F45th"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42F3101A7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600665; cv=none; b=etaE+CZlNmJcxZLG+7JmOj5T3yTsfBzoI5WCYBLnZooLPsyJit+W62Vjk7zswf0ZyHYDgyRB2q3ix2kjankuYhdaC1Z85C3xNu/Wb8KLk80PvihvSDTAKnSO16WTqBwfZqZwZPmJdf2b36G/WV5sdFa8lcdk7Eji1Xv0FLJoxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600665; c=relaxed/simple;
	bh=nNB6uPt7zobBmYwm9kirdYBQzkA8hCmwlrChC2duQkw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LtUEA/L+780hE8rbrOwgXkqMtPRepVNa9JdaFdYhz6JKTS0Aav/C6HakiULJy6MRR/jS2Mm5E8Slai78disXGRmlf/rH3o0AfC15SNczbK7hbul764+SjXFAqAEqMwYF4OTJZB+w0J4l8gDGq7fAuB2nxMw22Jy+lHNXcP181vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i3/F45th; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZaKSEvdDyeTiA0HMqOl6QsBhL6t6yklD6sx9tNZvcpA=; b=i3/F45thnTBz2RLGjkaZ6VfJzK
	WkPJbbsRuJt1c2iiDhQ4RgCBoRwGyCjdzlrrblq1iHQ8Ns2W2khF3vz4mLN9ad6uxSJZnz3dRSHgM
	l64SMXxOikLC/OKC7UG8urHTXOw03MZb6mOKNTtawrzuvTB1dacjTQ8sh4mqxmmJbuqgq1VdvEYp7
	QmjGsIigaHC9NLW6EyIAhsJ2l5MYi1rtDe5v286rPDDO1OoK4UIphmXKpr91JWvmD86M+bma7kCZ6
	zvPPwaTzjOtLz7atE6w9qf7QlMFBHqCQmVmDAbe1Ne3MjXcuLDj8V86XAGK41X29O+upeT8yR6F/S
	KnMukDPQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43530 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5Er-000000000fH-3Sz4;
	Mon, 01 Dec 2025 14:50:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5Eq-0000000GNva-3OiR;
	Mon, 01 Dec 2025 14:50:52 +0000
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 02/15] net: stmmac: rk: convert rk3328 to use
 bsp_priv->id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5Eq-0000000GNva-3OiR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:50:52 +0000

rk3328 contains two GMAC instances - gmac2io and gmac2phy. The gmac2io
instance can be connected to an external PHY, whereas gmac2phy is
connected via RMII to an on-SoC integrated PHY. This configuration can
not be changed.

The driver tests for the gmac2phy instance by checking
bsp_priv->integrated_phy (determined from the PHY's phy-is-integrated
property) and sometimes that the interface mode is RMII. This works
because the rk3328.dtsi has:

        gmac2phy: ethernet@ff550000 {
                compatible = "rockchip,rk3328-gmac";
                phy-mode = "rmii";

                mdio {
                        phy: ethernet-phy@0 {
                                phy-is-integrated;
                        };
                };
        };

The driver contains a mechanism to look up the MMIO address in a table
to determine bsp_priv->id, which is used for every other Rockchip
device. Switch rk3328 to use this mechanism to determine bsp_priv->id
and use that to select which GRF register is used for configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 3679081047e0..f9bc9b145ff4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -566,8 +566,7 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	unsigned int reg;
 
-	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
-		  RK3328_GRF_MAC_CON1;
+	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
 
 	regmap_write(bsp_priv->grf, reg,
 		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
@@ -587,10 +586,7 @@ static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 {
 	unsigned int reg;
 
-	if (interface == PHY_INTERFACE_MODE_RMII && bsp_priv->integrated_phy)
-		reg = RK3328_GRF_MAC_CON2;
-	else
-		reg = RK3328_GRF_MAC_CON1;
+	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
 
 	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data, reg,
 				interface, speed);
@@ -610,6 +606,13 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.set_speed = rk3328_set_speed,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
+
+	.regs_valid = true,
+	.regs = {
+		0xff540000, /* gmac2io */
+		0xff550000, /* gmac2phy */
+		0, /* sentinel */
+	},
 };
 
 #define RK3366_GRF_SOC_CON6	0x0418
-- 
2.47.3


