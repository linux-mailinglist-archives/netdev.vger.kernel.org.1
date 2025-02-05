Return-Path: <netdev+bounces-163010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E9A28C11
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AD47A44DF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDA13B5AE;
	Wed,  5 Feb 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GNZ2u28T"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485EC13C8E2
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762823; cv=none; b=E/JSZ638BbkneN+Pdsegl0acXGhOj/Xk3KuuXxJAaz88FewJulNBvb/DadxAl9toVA4JOQoCq4IAmIsOmBeySeYzhFNfi7T6Qdg9tZN2W+IxRTq18Ckx2Dw6wHPU9Vdy5Xv4f+ZeXmoJGAbzHoW8V0VAlQ5/9cFya8DsIqpUaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762823; c=relaxed/simple;
	bh=lk35UPdgqpSDQVNn5f+QUPq14tYMl1np9PO56joeGtQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HPWZsMyZAXpegzRrW9fj1MnXxHm69O0V6jXy1JiGRsol939rMdMx2gVvvhq7oIA/y/BEur0G8LYH8p+DQiB1GLeO0y5hH+EDH2/0oJiixbOQxA14qDiKdohqoHcpHvv7+E3jdqoQPhEJgyJU3vYAaeeL5L00p/YyTmzQtYbRFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GNZ2u28T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eCFhGClg9CjSX5KAb4d8jJf4KQjHkPGgZ/ES74pcY90=; b=GNZ2u28Thy6rnj0vAO8fROn9v6
	9Qba1U4DIdMUk+vrH96TgOA2vfxU1X2C7OCCJUHqqsS+3SoeyCHHoQrwZlqko/E+44BJfx16kqQnz
	JC/48n4YOXKLsXNbRWGgeEJ4AMeGyyc0MxkSa6QX3wm7QcpEHhUSMSv/x9aBeFnYBBj+5l7MM2OI7
	KFArwXPiQvsOOU7apWM0O2S+d+dKINphB5nS3wlvIZvco/IsgXTMv9VXxH/UyhiCEeTWnJbkUTi2U
	Xa4W8ZX5cfxrDJzDcu/nITejHvFJSNRwrQ8DQlRgXqKT62wDZo0nrrrGhinQOQ6sd87mx32gp3YxT
	m0OmaxbQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58636 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdX-0007AM-0o;
	Wed, 05 Feb 2025 13:40:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdD-003ZHh-Ew; Wed, 05 Feb 2025 13:39:55 +0000
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
Subject: [PATCH net-next 03/14] net: stmmac: dwmac4: ensure LPIATE is cleared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdD-003ZHh-Ew@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:39:55 +0000

LPIATE enables the hardware timer for entering LPI mode. To sure that
the correct mode is used, clear LPIATE when using manual/software-timed
mode to prevent the hardware using the timer.

stmmac_main.c avoids this being a problem at the moment by calling
stmmac_set_eee_lpi_timer(..., 0) before switching to software mode.

We no longer need to call stmmac_set_eee_lpi_timer(..., 0) when
disabling EEE as stmmac_reset_eee_mode() will now clear all LPI
settings.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 4 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 9ed8620580a8..17bf836eba7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -387,6 +387,7 @@ static void dwmac4_set_eee_mode(struct mac_device_info *hw,
 	 * state.
 	 */
 	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
+	value &= ~GMAC4_LPI_CTRL_STATUS_LPIATE;
 	value |= GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA;
 
 	if (en_tx_lpi_clockgating)
@@ -401,7 +402,8 @@ static void dwmac4_reset_eee_mode(struct mac_device_info *hw)
 	u32 value;
 
 	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~(GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA);
+	value &= ~(GMAC4_LPI_CTRL_STATUS_LPIATE | GMAC4_LPI_CTRL_STATUS_LPIEN |
+		   GMAC4_LPI_CTRL_STATUS_LPITXA);
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fecf9e8b29bf..c0472738bc76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -493,7 +493,6 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 			netdev_dbg(priv->dev, "disable EEE\n");
 			priv->eee_sw_timer_en = false;
 			del_timer_sync(&priv->eee_ctrl_timer);
-			stmmac_disable_hw_lpi_timer(priv);
 			stmmac_reset_eee_mode(priv, priv->hw);
 			stmmac_set_eee_timer(priv, priv->hw, 0,
 					     STMMAC_DEFAULT_TWT_LS);
-- 
2.30.2


