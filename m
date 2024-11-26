Return-Path: <netdev+bounces-147434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE69D97AC
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE79A285E96
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF01D4324;
	Tue, 26 Nov 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QJGFpZxw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872A1D356C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625640; cv=none; b=CYooTcdJwxthpqzh6SCOcebe+nL6nsMJKq6l7jpdNYpCxwM9zfwnZo2/BIzh34taWCfEKxBeBssZ3JClGid8j4FchlTyRz2DuPFS5YYDpFvHT7eR/qTE8NC5QP8NUCfJkD2frLDwp5JfaB03H856DOVhmIUMDPovrdDcxU3c7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625640; c=relaxed/simple;
	bh=t72I1wq7xzmwyLw7lflMmONX+uh8fql3CSrOe1FrsbY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ro/gA88GFuEIUml8V4kxZGW/NSme2YsK5+VcQWaWEEyOyn5ZDXy17g/9KIdTSREWUi+2WwS69uL+cazdpyCy8ZFYZpHk7QAnb0vt2GwuWHp/hqxdXj9Y59QpZLo1xGI/vAGcoMVAp8M2jiEELLp6DfAsPYMh/IA3fb01pfZ1LMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QJGFpZxw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4HBoc1V84zZZDTw2ZJjLSZ/1JxmRHpoM8xEarjHfrSs=; b=QJGFpZxwR4D9EBF3+JrGABH3EP
	5KH7U7iku5i1vl9dQNEFjRTYERdidDETQalarU35kpaQ2SiKnU2nPj7eDxlcedTAbHkkxd/n0JQyj
	aSP0sZK2PN8oZYCq0UvWEyHVj07M79NSF1EYlM2BnGKR0Zg9NnhyMJtTKolrVRU7sbzxYOofB3+8g
	nHN4m4jHK+j8oHNHnyGN4BIrwEs6ELHxJjgrLdQKthYv3xBKFVHBRXJiBAqLlQPD1bWvN43k94gGg
	3vguL9I0eUMOM1ZpOK9/2RF9UMb474wLdWy5aTSGdsOZelNcXlytPFSVmvwhZ6kxHBucCagzLvFc5
	bp5OVUWg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42622 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv4f-0006xX-1I;
	Tue, 26 Nov 2024 12:53:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv4e-005yjE-7Z; Tue, 26 Nov 2024 12:53:48 +0000
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
Subject: [PATCH RFC net-next 19/23] net: stmmac: remove redundant code from
 ethtool EEE ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv4e-005yjE-7Z@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:53:48 +0000

Now that stmmac is using the result of phylib's evaluation of EEE,
there is no need to handle anything in the ethtool EEE ops other than
calling through to the appropriate phylink function, which will pass
on to phylib the users request.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 5ce095a62feb..3a10788bb210 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -898,8 +898,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
-
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -911,13 +909,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	if (priv->tx_lpi_enabled != edata->tx_lpi_enabled)
-		netdev_warn(priv->dev,
-			    "Setting EEE tx-lpi is not supported\n");
-
-	if (!edata->eee_enabled)
-		stmmac_disable_eee_mode(priv);
-
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
-- 
2.30.2


