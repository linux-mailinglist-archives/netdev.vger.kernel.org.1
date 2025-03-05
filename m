Return-Path: <netdev+bounces-172173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DFA507DB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4632F1893D83
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4A1C5D4E;
	Wed,  5 Mar 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1IjUqJmZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963478F3A
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197674; cv=none; b=IxWgwYDkI7B0ocQ2lT9oZmuJQEI9HF/xUBUxaaP8fB0sYGtnr0rn7zeUlgDqSIHH10sqpy1N5I5ekHk8YJLChtV73SeaGPR/RjPyvuW2uuadVWfJpnnQys/1yqftkF64RLid7ejider18muPwLM9/4FVZifwGvvMoUT6su8FFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197674; c=relaxed/simple;
	bh=2BgLe8zKjL1lF2NmWsoI6WXTc04lNfHWtGAqmYTQb10=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mgvSmat0a67sLHg74z2qikJb68qbEgameRy3z9CDbDr1fR4IPPu6Kvg11atVc6KuBiCmhd0jyEa3pantkBqS2s1omqPad61NBR2yY40CwYdK+tcUr/7yfuJUz5xE79OZ09iVlXKzQVhGQQuYtSQItTW9u4dz+bsGQkN078w939A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1IjUqJmZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1osmxLM0JPtN1QjPJqhrKT1uQMk9kT2l9BrM2YTPnUY=; b=1IjUqJmZ20ZEzPYdnKOvwh17C6
	gWttHMBeDJsebI58cev2xemiQvLC3l3AZe1FzwsBoTkCD8yLGZm7ikGskaUabDvlHN1sXbW3HtlH8
	/8W/MSUESg3OHXJonAk6TuMgVPrb3lMsUW4dE7Jrwvl3ODqEHX+udzQ8gugC5VmgZWHgKwd/mGIjx
	YfCYIvpjymQlwfjjABJKh8v69ujswXaX/x423jEcvdeBI2g9/xIbud9RBnKHrYNWsBp60NFhNdty1
	qtwzU4O4+tqmzNpWcgM8IVwcfprg0JqbiX/zJvMQ+KpIN9Q74IQGCdtzYOM/oX+Hovw6cwxmx7CTZ
	8tipKrsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42194 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tpt3J-0004h6-0M;
	Wed, 05 Mar 2025 18:01:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tpt2y-005UNH-QS; Wed, 05 Mar 2025 18:00:44 +0000
In-Reply-To: <Z8iRM8Q9Sb-y3fR_@shell.armlinux.org.uk>
References: <Z8iRM8Q9Sb-y3fR_@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: block PHY rx clock-stop over reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tpt2y-005UNH-QS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Mar 2025 18:00:44 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6924df893e42..037039a9a33b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3096,7 +3096,10 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
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


