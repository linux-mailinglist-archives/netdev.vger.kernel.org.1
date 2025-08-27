Return-Path: <netdev+bounces-217231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE4B37E25
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB731889B69
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2F2E3715;
	Wed, 27 Aug 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NSQxECPt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4F3376BD
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284903; cv=none; b=jzCVPhHFHh3wOctlOrmefHC3Nsj3J2x9fvL7r+jdxMyFulLyX/4kNZn2HTNR4SCRhaSCncspgRIdfTvu3fJxS6fhRryQzil9zIcKpepABltiVVezJTA96STtlDz7HdxOPx9oshgZYhyJJurfy0LhOmr+A5rh1bmd9QFAH3MQzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284903; c=relaxed/simple;
	bh=9nzP7jINn1KNb5gqhp9aY4ZxP3Tmt1l4gbcJrHgbM3g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=P6RiLf3C8+Wsxq8v4+A6A7hUYs8V51deN2r7AmzwEs4CRrrP0Ph7R0BHZzBwvriT0wVJm4hn0mCv1GlEcJK+ZGwSVxNPPPAeWaUStK02a1tUn5XPGZ/8b07tdhA3Xqy7WnEm3ErT91gFGZVxNVUbIuFbSdDm0AT4GUxiuuvmv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NSQxECPt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K7HaJk396OO093SxPHpUQb4seLkO7bxlhi3QdP8wBr4=; b=NSQxECPtX7C8dbMwGLyP+ulZGG
	nmPrcJ3zBoC0HPaOQA+Q8HyRz/Vvegz770b9uvYukTd7GO4uphNs/Qd8HOiNJCNOY5JdcrUD64XgQ
	G0PWImYty0TG6jzGQC+a8z7YUJhvZ2eBOaapcQ24ZrONV2gavsycOmR4rWaZNdRld0cHg10FUGkdI
	eUZpYaCVNsg8l6gvEulFCQ5oLvMGeyThNNn2TJZk/1rLrmNEWjVZv10gKCE72cU7QFjKA8/UGHVje
	TZt2zHacB08u68Ma3nx7FPW9m3WbamOSFIQqPY8WL4p/v2IwFeYW//mKB4o/k/t+UPE7wlNyNHxt+
	TfxY4yKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51196 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1urBvg-000000000G1-23Bx;
	Wed, 27 Aug 2025 09:54:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1urBvf-000000002ii-37Ce;
	Wed, 27 Aug 2025 09:54:51 +0100
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
Subject: [PATCH net-next] net: stmmac: minor cleanups to
 stmmac_bus_clks_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1urBvf-000000002ii-37Ce@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 27 Aug 2025 09:54:51 +0100

stmmac_bus_clks_config() doesn't need to repeatedly on dereference
priv->plat as this remains the same throughout this function. Not only
does this detract from the function's readability, but it could cause
the value to be reloaded each time. Use a local variable.

Also, the final return can simply return zero, and we can dispense
with the initialiser for 'ret'.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 429a871d7378..88f5d637f033 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -149,33 +149,34 @@ static void stmmac_exit_fs(struct net_device *dev);
 
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 {
-	int ret = 0;
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
+	int ret;
 
 	if (enabled) {
-		ret = clk_prepare_enable(priv->plat->stmmac_clk);
+		ret = clk_prepare_enable(plat_dat->stmmac_clk);
 		if (ret)
 			return ret;
-		ret = clk_prepare_enable(priv->plat->pclk);
+		ret = clk_prepare_enable(plat_dat->pclk);
 		if (ret) {
-			clk_disable_unprepare(priv->plat->stmmac_clk);
+			clk_disable_unprepare(plat_dat->stmmac_clk);
 			return ret;
 		}
-		if (priv->plat->clks_config) {
-			ret = priv->plat->clks_config(priv->plat->bsp_priv, enabled);
+		if (plat_dat->clks_config) {
+			ret = plat_dat->clks_config(plat_dat->bsp_priv, enabled);
 			if (ret) {
-				clk_disable_unprepare(priv->plat->stmmac_clk);
-				clk_disable_unprepare(priv->plat->pclk);
+				clk_disable_unprepare(plat_dat->stmmac_clk);
+				clk_disable_unprepare(plat_dat->pclk);
 				return ret;
 			}
 		}
 	} else {
-		clk_disable_unprepare(priv->plat->stmmac_clk);
-		clk_disable_unprepare(priv->plat->pclk);
-		if (priv->plat->clks_config)
-			priv->plat->clks_config(priv->plat->bsp_priv, enabled);
+		clk_disable_unprepare(plat_dat->stmmac_clk);
+		clk_disable_unprepare(plat_dat->pclk);
+		if (plat_dat->clks_config)
+			plat_dat->clks_config(plat_dat->bsp_priv, enabled);
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(stmmac_bus_clks_config);
 
-- 
2.47.2


