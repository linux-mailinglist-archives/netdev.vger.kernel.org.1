Return-Path: <netdev+bounces-171584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19267A4DB78
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B151895E31
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A591FCFD2;
	Tue,  4 Mar 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lh4ka0Nk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C961FCCF7
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085639; cv=none; b=TSH9APA7bwYucDCx4E4bkqrtMsCdMFn9/7sg96tZJUDNoVhoSrFV8AJ26IN8z7hxRUgrFUqBGXEjgWjWEfOq4UMGLAr11+cRpqWVwNQ9Z6//s2QMBsQ6GwRJK1g7nFZLfRIiDEpR07JhXICkMRHaM9mmfYucgLRNDZoeZSQL41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085639; c=relaxed/simple;
	bh=gIEPkqrhCaiaiaxEpkU0+xbTfh1UaNCSahdzb7CA9HU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qiQR0xpHnwNgzvWao8z88wIIiiDQAc9tPFexg6mageS8czHpjgxjPkJ5iCei1Q0yOT30nHhuyfg7bdxKagea/le1f5CR3vhoGfqAphBe1o06n29v/Vm6GLcJNhbokZZSz7vj8V+aAGuTsN76ZeAbuehd3p61MVBUH7kIh+gPvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lh4ka0Nk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q7/Gww1ENpC837SwvsCTFVZ9QRakJWgHkP5LP1staZE=; b=lh4ka0NkLMEHSTKSrqmdmbio09
	RtIq+fIX4+c0G4Ld2OwqnZLUbJVoSjxq7DoAT/7iP7m5MJAk4/55GOGkaf8e8b6/gVNL7V7x3S90d
	Q2ifwzUQ94Ien7pTBC1ljckaiqCLujdK/s1Z6/qW1G1I07iTKbpwHN3R1ty8FdNaremJKCmonVpL+
	+KwEeSP1UNkW4QmG0VfdgAjcZ4ds+RyIbHoxoLVrn/arhYW4MUFxGGZr5NdD8Uk12qyF7epuBEbyM
	RjFXtifnTrrtGEqyKW2zbKuWk+UTMUa1UZO7sM817gwMF/scdORig4eyz9M22V/p6qnbT8rz/l+io
	QtGxV0vQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53422 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tpPuJ-0002VG-29;
	Tue, 04 Mar 2025 10:53:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tpPtz-005Soh-EG; Tue, 04 Mar 2025 10:53:31 +0000
In-Reply-To: <Z8bbnSG67rqTj0pH@shell.armlinux.org.uk>
References: <Z8bbnSG67rqTj0pH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>,
	 Thierry Reding <treding@nvidia.com>,
	 "Lad,
	 Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 3/3] net: stmmac: block PHY rx clock-stop over
 reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tpPtz-005Soh-EG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 04 Mar 2025 10:53:31 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index aec230353ac4..21026ea7541c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3097,7 +3097,10 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
 		priv->plat->dma_cfg->atds = 1;
 
+	/* Note that the PHY clock must be running for reset to complete. */
+	phylink_rx_clk_stop_block(priv->phylink);
 	ret = stmmac_reset(priv, priv->ioaddr);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to reset the dma\n");
 		return ret;
-- 
2.30.2


