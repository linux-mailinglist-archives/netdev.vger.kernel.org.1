Return-Path: <netdev+bounces-98516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFBE8D1A36
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715ACB246BD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512016D315;
	Tue, 28 May 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w+IK/nos"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0416ABEA
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896943; cv=none; b=GqNaEAYaH4fAW7oa4HR6ZFJuqbYRTaJiccgy+ryLjji473WtD73APgZMuB1eFE2s4UhzjbOQBfnqQx4Ijo/8iwGwcwPBpAQWgndX3E2UAcZfn7KwOF/MhheT/EKXfoH725rDoWcay/AjV0eRmMU7+hsnO3cSP+2v9omCVAexwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896943; c=relaxed/simple;
	bh=gVUfRcI5sRQ6/SJjAAEWezXddOe/+nmNu+w4xVGj9Y0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=paz54wy8T9g0aN6aQ4wjDkligrF6w92CMsQpMn4GEvg7eugOHtHzjGQfhN1gN1vzYhtWdRE9mu1VVsaAjZFiOveZWu7y3lGXNQ7qKfhIdl05TCFNVwuMdVJsnOcbhbj4dIxOjihzb/c0KnUoK61Q2SmyAgoAN9Y5Bv5uK5Bup5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w+IK/nos; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R0XsItn/IrljcCL2O1058cOw8l+WFLCPtVgaCijGlw4=; b=w+IK/nosrivEQTjkyR7fiuH1d9
	ZsH3Uatqn2T5MM9j3KlVcMeuSIC8mqVW9+Kb6HkSM5Kts5SqHkJW6kaCaQ4tEk4SuCJV6RbRi5DTA
	3xC+mA/gSyeCqUFdsKlePZ3rEkJr+9gXwo01ypJJdlaZI2C42GMzd5PG6vK0JMbnUmsL4n862oh4m
	VOgyJAoSiaFqeXa1Cb1pQIVtY5tT0LraNXEicEEuWvl6Jzh8owpm8Jqq5sN8A5p7+HhVGXq7qmN86
	KC/LtIm1tiKkFtof+Jly/lzU/uCZ8zgPJ1pe3mZkYDfGwqCQN+EkUUCJQ7eigIZFdbQxoiBqy99vR
	muiv3leg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38030 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBvJy-0004iW-1d;
	Tue, 28 May 2024 12:48:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBvK1-00EHyi-4l; Tue, 28 May 2024 12:48:53 +0100
In-Reply-To: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH net-next 4/5] net: stmmac: remove unnecessary
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
Message-Id: <E1sBvK1-00EHyi-4l@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 12:48:53 +0100

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

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e01340034d50..6e427ed7af05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4097,8 +4097,6 @@ static int stmmac_release(struct net_device *dev)
 	if (priv->plat->serdes_powerdown)
 		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
 
-	netif_carrier_off(dev);
-
 	stmmac_release_ptp(priv);
 
 	pm_runtime_put(priv->device);
@@ -7821,7 +7819,6 @@ void stmmac_dvr_remove(struct device *dev)
 
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2


