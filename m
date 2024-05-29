Return-Path: <netdev+bounces-98900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F28D3231
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0917B27775
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEF163A97;
	Wed, 29 May 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zBrWrDbx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED397347D
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972064; cv=none; b=qvMc2iSzeVpY6lGCjv182jIo6zYP18UKWhjPfqhT/FQi1B3aXM8wf1ib9b7LUHpHucCE3jd3ovWB/PAqKiO3G8DyyD1x+d/8Je9h2b1o9oj5mXMisNF2ZRHH8zUU8MpUYJC9RkjxDPBx40y1bpFROSf/7KcPQUpy2aHck9M2jCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972064; c=relaxed/simple;
	bh=XDwwsq1Jg5qsn7bbi89lE1+bVtYGrsiDOOtsUNHkc8I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SrAcVGD81kH154kh4+/gfo1FraoUxmYWIr4779URis7Gby6Qk/hOvgdnHyQiB0bHJj+4XSzMYoHB6VcmZzhZljdeaC1TkQvhhgBp4paHTzWLr4NZdiamkVqdyWrZVQs88dFb5A+bmSDOZJwO0thWa+1WJuoUekX53sqraPfCHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zBrWrDbx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ki22ukjJ+Q20qB+nBL6L35jMrJzZTCq6rq/hxq5NThE=; b=zBrWrDbxEm7azr+Cav55JtHI3Z
	h51Bnzltfu0tp6bFUxOB4RPCkQ+uEWBSCMkX4bcE4cHOtkp0ngKDXz4s8mKvssBo281KJWuOVL7Dt
	dDV8leedBjyE1W3IxX3cpgbisS9y/4rv5674lXsf6+dXdO2snBA/7y0UaW68FCFYNr1wzeQi6Oc/M
	NmA6+FaAbpSY2Wi+3JdtivpRtTYo47d6Qli/FmqPDV9dXviTqaWFc+sqa/TfIUkkkZ9UgpyMeKiY0
	4R0cTJQUwLiEnAB4iMk5qe060OS1nDCgQjTCQDxqdHS1biPgPDFR5NjyvoYJ/lPeD8yaM6ik8NdGS
	T5JTq4cA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57986 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCErX-0005mH-0a;
	Wed, 29 May 2024 09:40:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCErZ-00EOPx-PF; Wed, 29 May 2024 09:40:49 +0100
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 4/6] net: stmmac: remove unnecessary
 netif_carrier_off()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCErZ-00EOPx-PF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 09:40:49 +0100

It is incorrect to call netif_carrier_off(), or in fact any driver
teardown, before unregister_netdev() has been called.

unregister_netdev() unpublishes the network device from userspace, and
takes the interface down if it was up prior to returning. Therefore,
once the call has returned, we are guaranteed that .ndo_stop() will
have been called for an interface that was up. Phylink will take the
carrier down via phylink_stop(), making any manipulation of the carrier
in the remove path unnecessary.

In the stmmac_release() path, the netif_carrier_off() call follows the
call to phylink_stop(), so this call is redundant.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3ab93f89be90..ca19b232431a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4088,8 +4088,6 @@ static int stmmac_release(struct net_device *dev)
 	if (priv->plat->serdes_powerdown)
 		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
 
-	netif_carrier_off(dev);
-
 	stmmac_release_ptp(priv);
 
 	pm_runtime_put(priv->device);
@@ -7806,7 +7804,6 @@ void stmmac_dvr_remove(struct device *dev)
 
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2


