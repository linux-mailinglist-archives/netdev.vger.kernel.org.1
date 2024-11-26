Return-Path: <netdev+bounces-147433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167889D97AF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32262B26C19
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FC1D362B;
	Tue, 26 Nov 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SoGqfoe0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24111D356C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625636; cv=none; b=hWpn7iXK0hwvfpqZ64xYdhw7N2u+JX7+rlbiVT9rUGSgdDg8k0SIzr2FYJBLF8gRAcvNsHUL+xOzULE6aqjPGbip4buIGZbhp820TsqMSgy4D0I7jifsE0SqPcXgQh8AibOZnPIEKBOdVw5GN5Vv0SGlPeuewzFrIIVTOqoXUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625636; c=relaxed/simple;
	bh=n5NLFnypIfAueeyolyMBL3A++jamh37CyV5faxiE5xo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=J+JvUAlDioc4Uz8Uat19QFB7aZyitxeT8MxrBI9jFcE5Gk8PCbzrCe8iFb+L4bJb5mMM/ey+H3Iy1oeUlGAZVtZTXDSfDX6ZZ+PCawvMiq3c3ezk1okYpTFjgLNAhYIgX5r7LcVp5SewAe+SyxK8kVV811dwIRHfmfGXUAipGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SoGqfoe0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=erQdNHouBR7ArNuUG7F5cvZUczb4K+0l0/qJJwOPKXY=; b=SoGqfoe0s8uuIWBMZkdVplRsQk
	ZPyOxCg7o+u75WuiWpAyPk+KwNZQ+LxJ8g0HqtbLI7Bml15ms3WFzpIed3muNo3jRwoIEfue0apSx
	a2PlJFp8YF7XU1UFPTUsHsUPVkGXtFsZx9zLbLus8rYMMMtIECLoUV52pDbnh+9Ls0RQF2v+EooYk
	m4+NubcvT+tWOaJbFA//jgTsAxLDDjbuiHVD5My3rWKVp8ofA7zPK0HdZsQaw/ObM+++SrTSSPWPm
	3aOZzMPdZoAraVYXVpeN4lLLxxHkjJcuYSUPMcYscmGZ2lSSyUY1zQPaAdZpaOq2J4e9YYem9pyK5
	KAJ9P3uQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv4a-0006xE-0u;
	Tue, 26 Nov 2024 12:53:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv4Z-005yj8-3U; Tue, 26 Nov 2024 12:53:43 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 18/23] net: stmmac: make EEE depend on
 phy->enable_tx_lpi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv4Z-005yj8-3U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:53:43 +0000

Make stmmac EEE depend on phylib's evaluation of user settings and PHY
negotiation, as indicated by phy->enable_tx_lpi. This will ensure when
phylib has evaluated that the user has disabled LPI, phy_init_eee()
will not be called, and priv->eee_active will be false, causing LPI/EEE
to be disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 61d85281d75b..8bdf8bc9a728 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1084,7 +1084,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active =
+		priv->eee_active = phy->enable_tx_lpi &&
 			phy_init_eee(phy, !(priv->plat->flags &
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->eee_enabled = stmmac_eee_init(priv);
-- 
2.30.2


