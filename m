Return-Path: <netdev+bounces-155955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B98A0466E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427F3A70F6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EF91F8910;
	Tue,  7 Jan 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HMfrrG++"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F11F868A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267369; cv=none; b=HtDJISqL7Yshm4oRTPwV+ufdtyhH9FkOdxRkVUutmzxsrHpNr8LcjzeIEBMvnBQXY49rW6Twxmk8KuysvWQWGPBPizyJvL5s9EFB4Sgr19YzEZ46kBumNQdVzbKBFPmdYp5u8g2V0OWdgZjNVaIFY6JR4VtCbv/t3/JrIIK5cz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267369; c=relaxed/simple;
	bh=KOkNxyK+lUNqj+7YDXau7UaJf7/Lm4N0lyvmmDyfGCw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LP81uw+SNi9ET8v55YbQLG+sMZmSlmC42MV/eWQ0Gn3V1X1Vbej7mjZtcypAlkfr6cG/YV5H53lS5oqfY+5pTPz1cJaxtrkx4fxeF0Vdk0xJ+R5ciqxg7lkOxOY0nVYz8jLgXYB6wm4WzRImVsHDckcFDU/HegAJq7hmn2ZvI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HMfrrG++; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ecrgOpPZJ++e0c3wZgjy52va9WtAhn5oj3/YTdAkwvw=; b=HMfrrG++GHUU8rvUXEPEhQRWlS
	gatTbS6rXa9MSNTF1488eUMQoOQbtQhJnpx6sXvFPDvzmkGkkYXG/QQDUXZ1/VF22M+8Eimd4ATBN
	pnWnN0AsEnXP/Z7oRCCtiOrOtSeOpfMCI1Wi53KOWKZSkl7HGplnhGrDGR+AOQ07CYQD/dO94r3aK
	TOC28ioo5pceGwByoyjzAMfEQKf9XVZaLcln2p/yGrWdYx/NjAXsflMaUgW4O2KOfzZOX3j6LbAs/
	XcqDvW3NpQt5gI2vKxG5gQ9lKG4Eqz4uX9RbvD11Te7RsiTRqm0f1RYBhgCP7Zj9U4tZocmkRgnVP
	SwZH/xHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51146 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSC-0007n6-0h;
	Tue, 07 Jan 2025 16:29:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCS9-007Y3l-3Z; Tue, 07 Jan 2025 16:29:13 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 09/18] net: stmmac: report EEE error statistics if
 EEE is supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCS9-007Y3l-3Z@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:13 +0000

Report the number of EEE error statistics in the xstats even when EEE
is not enabled in hardware, but is supported. The PHY maintains this
counter even when EEE is not enabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 693f59c3c47a..918a32f8fda8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -654,7 +654,7 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 					     (*(u32 *)p);
 			}
 		}
-		if (priv->eee_enabled) {
+		if (priv->dma_cap.eee) {
 			int val = phylink_get_eee_err(priv->phylink);
 			if (val)
 				priv->xstats.phy_eee_wakeup_error_n = val;
-- 
2.30.2


