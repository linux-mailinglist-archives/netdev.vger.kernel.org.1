Return-Path: <netdev+bounces-161379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D355A20D95
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F727165818
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029571D63CC;
	Tue, 28 Jan 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a/aV2LOt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A181CF5E2
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079319; cv=none; b=lFql0I/N/wvWTORXjXreE8XArr6i+Klun1ua6Mxi1SBPC0hYPfC7g2mC18FY8ymAs+OLBTw9D4tLlZAtf2nDIqM8+1zbBwUuhgYleJ8rdhvJzl28ew3UsokYPKWh+lUJOx7MrW8e2MXPmvkyzqRhiwNZiCvIptJl0iUCZ1t3zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079319; c=relaxed/simple;
	bh=Sn/MEUMsk2TVTj/tfMTfKw4YYi1N2qB0G/JoTzTjh4c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=P2wPBOvkJWveRLjgs2Qeot/UnUx3qrYiLain8x51J9hpjoM1fKnq7xkNr/xNbzz99SO2D7FjWFGTvewxmkYND/VSTgO+woJvRMUIpENmhpDOgMjJYfGN53K4AXHcGLpd4QNrPTiX1dRjRdykjFG1JmcjP7xLeJapp4Ik6VXjiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a/aV2LOt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EBcD+jSZTJ87ExoztZaJ1Ni32E6UJjFerwHmJRvv+KY=; b=a/aV2LOt7xBw5yzLtxitUS1+2I
	L+G+Myvps3CvvfoW30NH3lqiYQYPEzbPKh2ZT5ocOFwslPs+8ApI6iZDyLIxfkxjkEdq4W8G6qvS7
	VDAQfUFivavg5dU/DPyM1tTXlc2b0JMmzUHj6wlsEL++riacU/Lkud4xKYjUnAO1kvudawn7Lmhy4
	avl4MXF8vu5H6byq3L4agO/dSFPJuhgl1vrKx3lrcYfN9iSCKEM/ytkDMuOtcPaYs7MbQGo4Zj9/L
	PA0n0HCl4DF8BgYLgCfJeFiV7BdiHvu03aVCFdg1F3zhaB7335az7NiP9nGS1FeR8ky4Weq+d9W0E
	6CEUynbw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45704 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpH-0007XK-1F;
	Tue, 28 Jan 2025 15:48:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnox-0037Hi-Su; Tue, 28 Jan 2025 15:48:11 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 17/22] net: stmmac: call
 xpcs_config_eee_mult_fact()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnox-0037Hi-Su@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:11 +0000

Arrange for stmmac to call the new xpcs_config_eee_mult_fact() function
to configure the EEE clock multiplying factor. This will allow the
removal of the xpcs_config_eee() calls in the next patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0c7d81ddd440..7c0a4046bbe3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -524,6 +524,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	if (ret)
 		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
+	xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
+
 	priv->hw->xpcs = xpcs;
 
 	return 0;
-- 
2.30.2


