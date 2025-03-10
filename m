Return-Path: <netdev+bounces-173531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737AA59497
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FF71886D48
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A617A2E7;
	Mon, 10 Mar 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sd0N0ZqJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3D22171A
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609920; cv=none; b=MkyLlxCQt8UFX14a677zoezdvMjnqqZLnJsVR/E7fC/B8ZV6i2MkOgdEKUOXT/yThJneKINSQJGf8LcCSEmK+wSznI/KAVD4LxrT9fat3lfzxacA7aFppZIDydF5+zmnSLDSH0ujbHmEKGSHnNpEeUrv0OnLwiE7Rkh/LOjlJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609920; c=relaxed/simple;
	bh=/PBlYoYoPiVBkIVh1GooR9no0jFcOokQ0sr6aAVm1FE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rwr15SCKQK8yWhmOUKXXU145TQ+XIZG/7EIcyTY8IqCP9qRWryRhC1cJ25Md6Rs/5OQgo8U5eZ7nHaSLKw4ctehDjsPh7nNAeaJRL1xfzWwjoXy/eLuOSKpuOcFJohG2HOIZ0gK3K/90cuaTBkNR+4v4tiQ1lw086q+lT2G/aBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sd0N0ZqJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TgHfgZdfHwr3VmPVenW/lrNRZErmyNxPVMe0JcfQ1QY=; b=sd0N0ZqJhCRyvdz2F7y6JUxNga
	YYjzwJUZ9cqkq0SbGlyNFiafge7+hDBemsZhscFCmXF1xwYYvEfPWRXV/BDQhs09pjLdCD+RSPx6K
	AlNomXJ1j43jZ7MZzM74owHqa8ljAJeMR4wrcGjBe8GS8p1daI8lJ4YWX3yTU3mmwpR1oZ6s7Txbi
	NfEPy6XyZ8sJk4Y7Zcp72l5nEE3vCcgY7tMYGX312OnhReoFu4hzVObVgR1DcPMamiuS+bojmci8U
	gu5V3KeLNGazv8OFNPzt3wQMswQy/O0z55r/Uf4PbVtc8AKdiKtqVnXd24kRcw0K1G+WPVJYqLwoc
	zEtum9tA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51248 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trcIQ-0002e9-2Y;
	Mon, 10 Mar 2025 12:31:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trcI6-005rn8-GV; Mon, 10 Mar 2025 12:31:30 +0000
In-Reply-To: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
References: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: remove unnecessary stmmac_mac_set()
 in stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trcI6-005rn8-GV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Mar 2025 12:31:30 +0000

stmmac_release() calls phylink_stop() and then goes on to call
stmmac_mac_set(, false). However, phylink_stop() will call
stmmac_mac_link_down() before returning, which will do this work.
Remove this unnecessary call.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ee6c0af3fd..839ecebf5f5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4129,9 +4129,6 @@ static int stmmac_release(struct net_device *dev)
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* Powerdown Serdes if there is */
 	if (priv->plat->serdes_powerdown)
 		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
-- 
2.30.2


