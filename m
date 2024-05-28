Return-Path: <netdev+bounces-98513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EA8D1A32
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6F41C21E5F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BC16C854;
	Tue, 28 May 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qPuJovhS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F113F431
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896928; cv=none; b=q56hM+6vDzTUC7VgEHOZ0Rg0teM1Gf9yOEcglG+1L+2Bb7nyephthW2YeMV5VGSqyUrIkDi03lV9e9KUtchpEbcr8joho2nAk6rGANMXeeCrTLJLDvuFJymAKHmpZAUh+0AK90lWETaaKaZ0g5pYwPqkMxCiKB1UTA9i7m6yvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896928; c=relaxed/simple;
	bh=Eszbhn/ZsV9DTU/t6bdV7ZOiFFgPLB/D/emCu8vEgvo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cp/UHVfRY44qc7nXMMgMiUDXfMs3jEgzc9ZPgAX1fKU3+2PlTL73cghYp3S8Bym2Hb7eH4Eed0oJrQxPhXZhawkqHpEJvq5gKkUn6JL0nUOLiG44gL+f0r41V93B0kjHdNbD9g0Qto7T06vPuc246wMcDPcHXZQW+vlwg+42nN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qPuJovhS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KVEmjIyZjwAf32hRUX+GaRO6qlU2SBQWPCvlwhyLLVM=; b=qPuJovhSET0wOA68BxvgPKNBSo
	r8BDwHEFlMezlAHYNvAL1uMK+wqvqjzIExn6p2Dycks9qqgD2zrgD9LhNMZZl7RzBmlL4bbnMIy4M
	4h/spUKYF2zOD1fy+3cegYi/sYxbup9ddTkF3IU1E6wlHzfVnPkWzDZY6arRSUtH7LuauEuEMOJb1
	OI4F1Ed0Sytov+9AbYyA4/Eqw5e+eFpeNBqd1hJGRypTnO6GYPxukIlAFt67T4Po0Ok7VurEiU3iQ
	nm62lkxk/XnYjG4JWrf13pjEj1/oVDMTRDIruYZr4r7tZgxBRa+aL+sPHYL5qVB6ZbMl+BeSiDTop
	I6lw8xxw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55014 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBvJj-0004hi-0P;
	Tue, 28 May 2024 12:48:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBvJl-00EHyQ-QG; Tue, 28 May 2024 12:48:37 +0100
In-Reply-To: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/5] net: stmmac: Drop TBI/RTBI PCS flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBvJl-00EHyQ-QG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 12:48:37 +0100

From: Serge Semin <fancer.lancer@gmail.com>

First of all the flags are never set by any of the driver parts. If nobody
have them set then the respective statements will always have the same
result. Thus the statements can be simplified or even dropped with no risk
to break things.

Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
registration will be bypassed. Why? It really seems weird. It's perfectly
fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
interface.

Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
simplifying the driver code.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..e01340034d50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7833,10 +7833,7 @@ void stmmac_dvr_remove(struct device *dev)
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
 
 	stmmac_pcs_clean(ndev);
-
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI)
-		stmmac_mdio_unregister(ndev);
+	stmmac_mdio_unregister(ndev);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
-- 
2.30.2


