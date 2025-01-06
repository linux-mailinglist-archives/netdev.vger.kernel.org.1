Return-Path: <netdev+bounces-155447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC27CA02561
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BA23A5A5B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D141DB34C;
	Mon,  6 Jan 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HTaQmiyv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329201D86C0
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166372; cv=none; b=PRt8iybwvtE4505WKTZdkAOChud9waIlx5MTPT1tTXPQRw+NmeE+yHgh104JtJevlPTtLFTwh+RfnmdWBTTH1oQTDuWG3O3d7KyaCvp+6rVQQMB8OvTeZrjdwXf9W7HLYcplxZ52+si4hP8bXJ1RKkUN09ypwXrWGketdbz641M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166372; c=relaxed/simple;
	bh=e0Kl+zXdy7AYy7IjcR5bgIdvtPZZANU+lPrO2SxezBM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CyVtzPoO5GtVxNl8xeNdcJgX1AiqoMIiwTRR3cEcLRK7T7AuarVvurmSaB92RgkAZu/UdcZsQwktIFDsrGqIBGy+Cozfalq8M8Jv/Obo+aON0fcPfx/l89FKd2HvM2niMv5XKH9zc7emGaO3aYg7jluJpzTt+4mwVQfkV0k3ipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HTaQmiyv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELZbe4ORBYcEswjWnSIgUcJQUopY3ta7DtPy0O6ILXg=; b=HTaQmiyv/4hw5y/kzU6bO4IjPu
	uXVM+N6K2D93jwmxZhnwvcjNdsqSfr63+NF6iyDmTO4Tu4qqMeOIlwvQzJdvMo22VCZwLUNJ1Jnyw
	8kauy6V8nu4n/mwuOyoC8+ptLx7kVAlh8PylcQuh7DuCH3cbR1kxPYNBCgY2xHyUCfKpf8ePWvWd4
	7p/cohbKmL5SrM0enUXvGBiu2NvdIJERuGa1EIjcwnIctYtRbZMhn+QiJWFx43mQ//QzovckSnTRe
	SvYgxp7LM0KxsMHVrCqwIqTVUOg/RD6PnRpts8LEw89CZ/sqCWkul3nbn8kIv+DUyynKT6+Nz2eud
	vVPQSxeA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36916 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmBH-0005uC-1e;
	Mon, 06 Jan 2025 12:26:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmBE-007VY5-DJ; Mon, 06 Jan 2025 12:26:00 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 15/17] net: stmmac: remove unnecessary EEE
 handling in stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmBE-007VY5-DJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:26:00 +0000

phylink_stop() will cause phylink to call the mac_link_down() operation
before phylink_stop() returns. As mac_link_down() will call
stmmac_eee_init(false), this will set both priv->eee_active and
priv->eee_enabled to be false, deleting the eee_ctrl_timer if
priv->eee_enabled was previously set.

As stmmac_release() calls phylink_stop() before checking whether
priv->eee_enabled is true, this is a condition that can never be
satisfied, and thus the code within this if() block will never be
executed. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index aac45c16d7b5..7ba3c7a8f535 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4027,11 +4027,6 @@ static int stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	if (priv->eee_enabled) {
-		priv->tx_path_in_lpi_mode = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
-	}
-
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
 
-- 
2.30.2


