Return-Path: <netdev+bounces-173514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E8A593ED
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91383AB071
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881122B5AA;
	Mon, 10 Mar 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="en/7KjNl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760022B590;
	Mon, 10 Mar 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608699; cv=none; b=HczQvaSWGmgxINjQiiKIG3mZhMfBdv1LIHdGAJWBoNLoBetNbFj+fDOfdmAnm4bm9PEDBnvHEJMc9kCWA+WLdM0WObCCe1odRuKRkthI/352M/vJtHtXNmnWcjdOEsmpw9ku8fHLLYVPG7snt5dWm1TuGqiFoEGhHGs9I8YC+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608699; c=relaxed/simple;
	bh=cjzsDzXt34Yc4nkL0QxrvMD2TCgPcHaz0WX+0yrngMo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ogCd1NZQg4lLYrAGsJVx+C5gtqXVxBMyuVb72q3dvLb8mIBGIp5uQpu47KrGjUk+SPlKZel3ImAnzpPgz+Ehm6cb+N5lbtzqcx0zypcht2Rij/bYLhj1ElKo/uucxg16RzAStOoYnV6LhplmKBaEgqCi/nE1cCdjGGdSrwGig0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=en/7KjNl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lap+NCEO3qkAh4Z8F8rLb4aXPBqWoPmq7PJXAQzXCzE=; b=en/7KjNlhPw2h6/OaP67ZMJlvG
	jyBTLtO0dum9hUUbT4F44LiQ9RzEHPfMZXMUb0Feu+XWrVjauiYEuOAvEFSNQS+Ey9UZtQvWD4g0p
	/Rp2W9FJFVw1JGGAjQnyKqkpvD6mYpa+oxf4Ygh/uM8ZLdmXX/A6i1vfcXeg86NwI2ELVRRKfXr7a
	h7jDK/51D4OTJsZTBEhg6UUmqvLviQnKfkmpvIjqnzUrfrkfJvrPzJHVpC7Hv3VMnA599t7vfkk/4
	IB3B9QprwzUpdYHtHYO3h0Qnrbq3mUvgzPbY2QIQSKm4gRwOKWLcdOfL5UTtXX6V+i5Df5+zkZbfX
	P/2i7x8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54304 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trbyc-0002aV-2d;
	Mon, 10 Mar 2025 12:11:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trbyF-005qYl-Lu; Mon, 10 Mar 2025 12:10:59 +0000
In-Reply-To: <Z87WVk0NzMUyaxDj@shell.armlinux.org.uk>
References: <Z87WVk0NzMUyaxDj@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next 9/9] net: stmmac: sunxi: remove of_get_phy_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trbyF-005qYl-Lu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Mar 2025 12:10:59 +0000

devm_stmmac_probe_config_dt() already gets the PHY mode from firmware,
which is stored in plat_dat->phy_interface. Therefore, we don't need to
get it in platform code.

Set gmac->interface from plat_dat->phy_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 1b1ce2888b2e..9f098ff0ff05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -116,11 +116,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	if (!gmac)
 		return -ENOMEM;
 
-	ret = of_get_phy_mode(dev->of_node, &gmac->interface);
-	if (ret && ret != -ENODEV) {
-		dev_err(dev, "Can't get phy-mode\n");
-		return ret;
-	}
+	gmac->interface = plat_dat->phy_interface;
 
 	gmac->tx_clk = devm_clk_get(dev, "allwinner_gmac_tx");
 	if (IS_ERR(gmac->tx_clk)) {
-- 
2.30.2


