Return-Path: <netdev+bounces-174951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1C9A618F2
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC171B63FFF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02B20459A;
	Fri, 14 Mar 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JAZJLt2B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B4132111
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975399; cv=none; b=GFS/lwoUM7qG7e81TftuvV3Ied3A/P+D6vEmr4083MNCjnFRYjSY/DtgOLYtBnae8eEW9RcBHFwc1FUesQ5aIYBuJ7u5oKofKWOvcmISr0AT/05ST0TL9hM3F8bdRDhk8Uey2o2FxA6hl7zWfzfjGbuIMC+UR2/q7G/XjG6fGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975399; c=relaxed/simple;
	bh=1sP3XHwIQIDGMOM69P7DN2twEdFUfgOy2yKQoif4qBY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=PgY0X8VDj4RyLI2QAOK45Jz5uPfu0EhFzbAuPcK7eglTrBKUNGAWmgo806qdNPecfZpaJ/dAskO6nnD4E2JcGp7p3Fj+0RPvTaIJnkVFyYyeFQyE2YSSNkso+Iwzv3ggFKS7jbofejZyyZ1bM096Y0lTNn24zEsLDb/niTmcZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JAZJLt2B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UDOJjloH2trDjnCVarjV86T+ZpZnVfpEtrSMCzlD+kA=; b=JAZJLt2Bk+mCE5pzgJhw/WLTXD
	CKl31JUUTk9vXSOy6ZSf7piVnoSGcjCKdoxRk1cqt2y1DgjIHIv09YaYhFinNO4NmkswZa5D3eN2N
	n/Nt+j10MZA2jy3m2ReoFGESyXhh/D6aDttdwWa//k4ydrZt9jZRrR1+AJogjy7AboqU+ZC4Y4FpH
	bL7UsyotmH2rBVSpzamtF4b1D6yBFfuflj28SKNEr+7gTxyiP/oFXPtNMu6i8kxGxcbwhZNJ8Q+t1
	SVlLSoEOPUgzYF+iPvC9hd9hXyGpPMvSlcoq5wux0aG53l3tLOF091XUWDalkGqpUmPW7b4hKjFAU
	Nf+4vGcA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40120 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tt9N5-0000fN-2v;
	Fri, 14 Mar 2025 18:02:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tt9Ml-006xIA-EF; Fri, 14 Mar 2025 18:02:39 +0000
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
Subject: [PATCH net-next] net: stmmac: remove redundant racy tear-down in
 stmmac_dvr_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tt9Ml-006xIA-EF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Mar 2025 18:02:39 +0000

While the network device is registered, it is published to userspace,
and thus userspace can change its state. This means calling
functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
racy.

Moreover, unregister_netdev() will unpublish the network device, and
then if appropriate call the .ndo_stop() method, which is
stmmac_release(). This will first call phylink_stop() which will
synchronously take the link down, resulting in stmmac_mac_link_down()
and stmmac_mac_set(, false) being called.

stmmac_release() will also call stmmac_stop_all_dma().

Consequently, neither of these two functions need to called prior
to unregister_netdev() as that will safely call paths that will
result in this work being done if necessary.

Remove these redundant racy calls.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa1d7d3a2f43..c2ee6c0af3fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7768,8 +7768,6 @@ void stmmac_dvr_remove(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 
-	stmmac_stop_all_dma(priv);
-	stmmac_mac_set(priv, priv->ioaddr, false);
 	unregister_netdev(ndev);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2


