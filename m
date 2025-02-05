Return-Path: <netdev+bounces-163008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407FA28BFD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378D41885ADB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5D154C0B;
	Wed,  5 Feb 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BOk0lF2Y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245913AA27
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762812; cv=none; b=MQdipLfmP9G+i9uvLfAyTIhnB6aZzgBuqQMsjy4juw9GDaVVXDJ2P/lrQ9PN6X4fHlIv0++bG/a9rLKQWu41dQHYFZHv8xStNWcMvThVoBqGhzG3WCBFnQjjgK02QHliFjxlhfXMV4Tr81GEKgbaS/dmm6uRgyOkELDYj/F3gTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762812; c=relaxed/simple;
	bh=X7EuDdgGoktjGN+VmJd4J8Z1M6PzvgdaQU1bBTrtEhU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bQ4Y8iPFAZ7/C/bI/+aOcUABi5e2HdkmXDa/3PJ7Z9f3ng3rctOwOF8jiEKICFa4unixQncJpfG2n8BWKbK58TaMhwKCgMyuxeSFAgX5ICKZH+TJxqzNzMKBtXf4BikNq1I4bYXLU3/WtPmfrDhvide2iIjixWTL5kFX0CdMef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BOk0lF2Y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AhrWt9WVjAY60HpUOIFuu7OGOJj5bUlRo1gopxgG8/c=; b=BOk0lF2YVhlaqQFGfND5bJ1miN
	lMcrV0ucGIrdkLxzGhCm4Qeu8dXj9VHSaz1FCz5iUedR4fB/mCFsFxY+MFb4AnBxu2I7/Vzp1U3hP
	Sswzi7H1Y4Rmkw3SxyYLppbe9x/agDbEZfRz6StgTAy3vHTCERNJmJpcR6dnzYaSPEMbjF6Z4gaxt
	1VBtYk50pL5GBu4J9TvlYOC8d5aFPw/7JmHO8WGCFTLe7R5u6/IZIawTBk67AHPRZfMNWJB/pcQUg
	izyQkLzsJGm7yj9ctfV4De3YW3sKw0V+NvOIAbsfLG+hJ2UE0BS59vIiQItRHfFjdAHPM3zrxG8vd
	XlR6Kz2Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47364 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdM-00079s-2H;
	Wed, 05 Feb 2025 13:40:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffd3-003ZHV-6C; Wed, 05 Feb 2025 13:39:45 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 01/14] net: stmmac: delete software timer before
 disabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffd3-003ZHV-6C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:39:45 +0000

Delete the software timer to ensure that the timer doesn't fire while
we are modifying the LPI register state, potentially re-enabling LPI.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..9b44f4a8b7af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -447,8 +447,8 @@ static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
  */
 static void stmmac_stop_sw_lpi(struct stmmac_priv *priv)
 {
-	stmmac_reset_eee_mode(priv, priv->hw);
 	del_timer_sync(&priv->eee_ctrl_timer);
+	stmmac_reset_eee_mode(priv, priv->hw);
 	priv->tx_path_in_lpi_mode = false;
 }
 
@@ -492,8 +492,8 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 		if (priv->eee_enabled) {
 			netdev_dbg(priv->dev, "disable EEE\n");
 			priv->eee_sw_timer_en = false;
-			stmmac_disable_hw_lpi_timer(priv);
 			del_timer_sync(&priv->eee_ctrl_timer);
+			stmmac_disable_hw_lpi_timer(priv);
 			stmmac_set_eee_timer(priv, priv->hw, 0,
 					     STMMAC_DEFAULT_TWT_LS);
 			if (priv->hw->xpcs)
-- 
2.30.2


