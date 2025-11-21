Return-Path: <netdev+bounces-240715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F6C784E6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D519033BB4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44F34104F;
	Fri, 21 Nov 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mqgdmEMe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32A341066
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718759; cv=none; b=sg/B3Uo3FOIjza3bOObp79czqxsvjIRoGkU6boPBE9bDB3J4xWov+X+hDotsGr5z1r63hh8XUZvkLp8qsa8+xjyayjoWnauqtwKCaYnds0x9ODH0tdQmmLmU1N8K/XENRVzrPGDZdrBMVC4WlnmKUnej3753pvbLK4Q1gcZc3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718759; c=relaxed/simple;
	bh=q09HowKIXmOepWXIVFa6K+yuZbfFrwe4X4L7KmE+6+w=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=r8C8eJ2yaN6i5A1f+zNyN3UJKzb/FkmFoCx47yJZB7B8ePZ4TdOfq+BIl5CsEBKEPCh/+QfKseTFoxiqno6vB8hQrnJD39EGRjr3TDyBsHqnqi5ZFPRmHyJrgg9FpQoNtazJpsawr5Cwk/e/jQd3aBtAQ3Qh1MmRAJD24WICmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mqgdmEMe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wkuSdW/m+K9iRhoxrYgBEQ31vGYgUWWx+sS2BymvibQ=; b=mqgdmEMee4Tk+iILUqqE7QRP6h
	wyIr9LxGuL2thI/konwyhTmXSxLaxL35reY5/ArzZwKKPNRJAvedOUoEoPLIVPoKfsS9lQrioceD9
	ZNtFQ19zgCBxmo6NFljSXuaeJmAWpiu+mwFt7zTEdSv7Rtw7KL5V7j9/Cfa94ZT5HMj5hiJ6cyxwX
	jIqHEjCykUWoqPYfUT0bPEDlx+QTt6nW4jN2GrgtFmGWQrsrG5gHr+k10kU0VUuAy1BWbYtxQASqH
	9AttjBPWioEMtpmOyitm2tfFmhDNHveKvOFDUoobenEEHnvD7H/i3RKF0bJkLLq2aR1qN/IqTPmqY
	u3LQqTgw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51638 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vMNoY-000000007MR-2F8U;
	Fri, 21 Nov 2025 09:52:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vMNoX-0000000FTBd-3Oup;
	Fri, 21 Nov 2025 09:52:25 +0000
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
Subject: [PATCH net-next] net: stmmac: move stmmac_mac_finish() after
 stmmac_mac_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vMNoX-0000000FTBd-3Oup@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Nov 2025 09:52:25 +0000

Keep the functions and initialisers in the same order that they exist
in phylink_mac_ops. This is the preferred order for phylink methods
as it arranges the configuration methods by called order.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 970c670fc302..d16e522c1e7d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -932,7 +932,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
 	if (priv->plat->mac_finish)
-		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
+		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
+				       interface);
 
 	return 0;
 }
-- 
2.47.3


