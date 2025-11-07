Return-Path: <netdev+bounces-236696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4144C3EF6F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D8188C50D
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAE130FC2C;
	Fri,  7 Nov 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N2EDNrYy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C483101B8
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504179; cv=none; b=W45PqBBcwB6VYzaKT71IMeWS5MWy0VscAXTxZ3z6eTq0QDQB18jjLJbUxArMSyizh8ZOfXL/1e+xXwH0QOtbN4/isZGF8w+qP9qBoAzq7KMAILLiFeDlDG0krpQ7QpsMC8xm32Oz3WII+lyale28IojlPWoVdDyEB/L+WceLtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504179; c=relaxed/simple;
	bh=LoKsms1zSbOzPrrwFqiIKPUPSWzFdnaf5hSNV34iyyk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eSZQNsK6XVOMWECVZskWsENUXmkR0WPYCByUttlLHzyH+rl5T93/jQO2mwFGQr9THKNax5crMxD87SD7Z7fQErqlF3lusB4iwch/M7XRko/s1E2e+qDZiKVS9r4A54LuyRLajzb5iP3mUMnM2ToZ+oG5s9f5YIViXws0FhpCGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N2EDNrYy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6b2Jeag/15waNFP16mPLz7zFFYTMVqMxpfra85ewdwk=; b=N2EDNrYyhg0H3Yv2T5jPC1mMNh
	YAIeb+w4j06Kb0t1XN+W6BPwAc6NdgLITQjPiTDxj9rhKSs5u9BQWbAvcW+2E+ShCTkCTaZXoJyce
	ZYC8Jz+FEw2wqav8zHC4pjsPuosP7hVYvylRF4rMBBQfdwdJA2gvKIsoAykqkL2nFB8R7HRgUyqQC
	w40SPqg9HXXtCTFuApRdvcB1QKe5MIl6jqLRFmDMPJwP8DqqbnzkaSYYMpMSppTJ1ut+03ZLfG4Yn
	nSBm8mW+flfvZV7hAntpanIqYVAYmuBR1W5B/shu2sYO/Dqwol7z5aRCLoQFL3dz6PNrxqS7VeLZL
	JSUxWELg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33948 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vHHqa-000000006Bi-0VZP;
	Fri, 07 Nov 2025 08:29:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vHHqY-0000000Djrn-1D6H;
	Fri, 07 Nov 2025 08:29:26 +0000
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 11/11] net: stmmac: ingenic: use
 ->set_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vHHqY-0000000Djrn-1D6H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Nov 2025 08:29:26 +0000

Rather than placing the phy_intf_sel() setup in the ->init() method,
move it to the new ->set_phy_intf_sel() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v3: fix Smatch warning: phy_intf_sel is unsigned and thus cannot be
    negative
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++++++------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 41a2071262bc..8e4a30c11db0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -134,32 +134,21 @@ static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
+static int ingenic_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = bsp_priv;
-	phy_interface_t interface;
-	int phy_intf_sel, ret;
-
-	if (mac->soc_info->set_mode) {
-		interface = mac->plat_dat->phy_interface;
-
-		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
-		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
-		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
-			dev_err(mac->dev, "unsupported interface %s\n",
-				phy_modes(interface));
-			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
-		}
 
-		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
-			phy_modes(interface));
+	if (!mac->soc_info->set_mode)
+		return 0;
 
-		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
-		if (ret)
-			return ret;
-	}
+	if (phy_intf_sel >= BITS_PER_BYTE ||
+	    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel))
+		return -EINVAL;
+
+	dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
+		phy_modes(mac->plat_dat->phy_interface));
 
-	return 0;
+	return mac->soc_info->set_mode(mac, phy_intf_sel);
 }
 
 static int ingenic_mac_probe(struct platform_device *pdev)
@@ -221,7 +210,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 	mac->plat_dat = plat_dat;
 
 	plat_dat->bsp_priv = mac;
-	plat_dat->init = ingenic_mac_init;
+	plat_dat->set_phy_intf_sel = ingenic_set_phy_intf_sel;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
-- 
2.47.3


