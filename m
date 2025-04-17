Return-Path: <netdev+bounces-183854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38501A923A4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C637A4C66
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94E255238;
	Thu, 17 Apr 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nxnMqhLE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD558186E2E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910059; cv=none; b=K/Eo/7juKhpx42GJiIYIz34JFasVXfLrTAFUoMsVTe8BwYtR1VRP+eSFvgqM91Ww/bI9oLj+/bvbyIkQVqJuJiLebG0FATBgVgxWDMwDRKpYumqSqZ7+fQwyUv2MnU8qxxV3xjC8TkaVezyyt21nWewk4q8bvMdbR3XhlekKdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910059; c=relaxed/simple;
	bh=TwDz3TDNqvJqCkFQm7H4X30ItLunZD9sTp0ZyNrGCd0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eFhMOYfjekfulYM/T7HHplIm47jYOC09hvPnmWptWekEyG0UMKz3cwIcUHBsBlLmLkAJe1b1LTsD0bQODRiwKMYbPPRBUZp7DJbZJAMWwVoBb1tijVvXeATDRfwCOPReXi0fjhX+d7PWUvppAXZhrQhlRNlSDEQ1+lJ3KxBwI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nxnMqhLE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Av+e+xwJa3OI09Ag1r1Hzotm7mvuweVojm+b6LjeE4s=; b=nxnMqhLEb1TI0pUGVAnWFuqt2k
	Ak6NRrozkutqBVw2qHaUgYrgZ8w6zuo41z70cEiDr7HJEiCU6hCmDP/5j6ACsrhcjDXlB/aPol61M
	HKeo2ktRS1B317UiaLeC+WREg0140wah5+ucPRmBX3YThkEKR/3marfAgk5d1nvdZHUEfwft41ya0
	s69ipD0GdYmTL2/BLTz0lBMfEP7hpBBRHsmY/58yVO2TpPAkyhOJb3++xesxTexvSpPcgD31x5/qg
	k1az1qVUM1FdU6o01cozesllfOEsUM+mj3w8UGsVUGZOmd1HT2PpiHyfOd3qCoBb9ogRjLQ+TdTRi
	mqxBo29w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35752 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u5SoU-0007hW-0t;
	Thu, 17 Apr 2025 18:14:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u5Sns-001IJw-OY; Thu, 17 Apr 2025 18:13:32 +0100
In-Reply-To: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
References: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 5/5] net: stmmac: socfpga: convert to
 devm_stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u5Sns-001IJw-OY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Apr 2025 18:13:32 +0100

Convert socfpga to use devm_stmmac_pltfr_probe() to further simplify
the probe function, wrapping the call to the set_phy_mode() method
into socfpga_dwmac_init() which can be called from the plat_dat->init()
method. Also call this from socfpga_dwmac_resume() thereby simplifying
that function.

Using the devm variant also means we can remove the call to
stmmac_pltfr_remove().

Unfortunately, we can't also convert to stmmac_pltfr_pm_ops as there is
extra work done in socfpga_dwmac_resume().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c7c120e30297..59f90b123c5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -500,11 +500,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->riwt_off = 1;
 
-	ret = socfpga_dwmac_init(pdev, dwmac);
-	if (ret)
-		return ret;
-
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
@@ -524,7 +520,6 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.30.2


