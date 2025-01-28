Return-Path: <netdev+bounces-161365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C5A20D70
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DA03A459B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C61D5ABF;
	Tue, 28 Jan 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QuUz8KNS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2F19DF61
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079248; cv=none; b=GKpoHQ2MiA9Qt1X19XKMHhRRq3dDxt2X0ThuV88Rx4Bk+1CrnTzxh8taLlRWzbsVSYpyvjOhUBu8hYieVI9EbU3w8sAnG2FhZE8vkRP0l7LK6eeFvfUupU/mSCV6VtbztHQ5HcUQE+eUHJ7RTjMtJZez8fKfKeK0Tzb+bsEPJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079248; c=relaxed/simple;
	bh=BjB+f1cBVPgnew39RbbFn2ojhTrvPU6iEsIiiKONVE0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XOweWMiDsyJrrk1m0evUN032aCCVsc05j71cSRRND3AT8CeuK7c8+sK5ys9GWw8yOJnWTo+ceesseIpL86SL4j7IfjGomO8Anb8QRy9/GIqrC3YD648MeKrSZjMaNB+34lGkkfPz4K7r4L2Y5VkaBVim0+5wRq1CeNAMg3Rv8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QuUz8KNS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=07l2JUwowhU6Kds29hM9ev3VTddwmEBKcHtBEEd7LSM=; b=QuUz8KNS2b6kxIsPGQp11LQfmn
	pQRbY8a2C6byP0dgrbIZWs317/4ADiqxGskxjCzS39sMG2xNWELMEdH5tiIv8dwvEYgKWok05QEQO
	Ya6CWQFJk//ANio8eNOinoMfWBIP2h6FmoKJycxpD94EkMjQNsyJP3ezgCViN0uAICmN5+uFamFM0
	BD+Yh9JXnxANzTf8e6qdCqMsOhnbLUeilkFbelf69Xi5UMdMlhLOIzLqvuoDwTYtZNUVm+pD7ykVY
	42Fq3M1oJgqP+UcZJwWYZ3Vwj8r2mLEbtePI10gkcL1AdlPnxb8wkRQT1eGQmhs/e3JEjJha/zvEY
	bssGk1/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcno7-0007TJ-2S;
	Tue, 28 Jan 2025 15:47:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnno-0037GK-7U; Tue, 28 Jan 2025 15:47:00 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 03/22] net: stmmac: dwmac4: ensure LPIATE is
 cleared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnno-0037GK-7U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:00 +0000

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
index 7480825389e9..e6a6aaa74185 100644
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


