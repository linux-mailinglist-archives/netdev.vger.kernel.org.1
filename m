Return-Path: <netdev+bounces-157715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69089A0B5F1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA58188690D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C546B5;
	Mon, 13 Jan 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RUHTTJZq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6622CF0E
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768768; cv=none; b=SnZ7KXhiIH+fEz+v2SjaH6VDGTAnTOBE8uhXKrqcFSGPWUHvH95v3zpWHCmo7UkZTy1DMQzDB5CFxtPMfVso6m+4qNQRp1OZOB/zwMtjuvCNn7uKz1N8zBGH3qp09K7fHhY5NYPuYW+kyOenW8GWLuWceSI3NTDYQeqqdONs6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768768; c=relaxed/simple;
	bh=PIZYriBD0QOfRK+pbNI3zMXjv0u/EoL2PjQ2Ve8tHUI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rSagO2kiIyAO0dXTWdu+XKHlfPKr0minIvwEKP1oMgCHM341uzvSd8p5mHq5MrTisAP3QCnWhDkx3e11M9C9MggR1jCbvo8cfKWD+br6dZdCYXzzRvJt6N1WZFBM1fsxh9iWVKR/UuTI5S9uFHf1gMJ1VwjGsDoaB7kjXD/p28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RUHTTJZq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j2KOzFqn83lW4a3mHaCjytJhPLElKdN8kLiBUf4B0I4=; b=RUHTTJZqJrk0CCmh22e+l3R+5s
	NB+oPZZlDpOwO2PqT6nUFUg1NP0YzZ2Vrjh8N6KUOHjsPSKdcOoGwpTP5uSunlZg6bEGCDJqtqGft
	KT0MgaOFNyUMAyhk2qOyYN+ZqDGpmWVBXNrxDKFUqZjhfJ0/EBTdMf6GNv/rN1HPLGZWUgUYyhwUv
	Ngel/p0VnzpRTFjNSPzaqFdBG13RXBoHjgwLD3m26mWFm8/tkC91FkeFbhAbOc1n7ecihxMEan0c4
	sADt6THDOuO9LJIecu3RpTRcqt8B5f5sA3e0Pn9HbWbq9oN9OQkusUdbmqmIQOmK6U0GiUJWUGw1f
	i7PjfzjA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49190 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItK-0006Uw-2a;
	Mon, 13 Jan 2025 11:45:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXIt1-000MAu-TE; Mon, 13 Jan 2025 11:45:39 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/9] net: stmmac: rename stmmac_disable_sw_eee_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXIt1-000MAu-TE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:45:39 +0000

stmmac_disable_sw_eee_mode() was not a good choice for this functions
purpose - which is to stop transmitting LPI because we want to send a
packet. Rename it to stmmac_stop_sw_lpi().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 58b013528dea..8130b0f614d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -427,12 +427,11 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 }
 
 /**
- * stmmac_disable_sw_eee_mode - disable and exit from LPI mode
+ * stmmac_stop_sw_lpi - stop transmitting LPI
  * @priv: driver private structure
- * Description: this function is to exit and disable EEE in case of
- * LPI state is true. This is called by the xmit.
+ * Description: When using software-controlled LPI, stop transmitting LPI state.
  */
-static void stmmac_disable_sw_eee_mode(struct stmmac_priv *priv)
+static void stmmac_stop_sw_lpi(struct stmmac_priv *priv)
 {
 	stmmac_reset_eee_mode(priv, priv->hw);
 	del_timer_sync(&priv->eee_ctrl_timer);
@@ -4497,7 +4496,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	first_tx = tx_q->cur_tx;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
-		stmmac_disable_sw_eee_mode(priv);
+		stmmac_stop_sw_lpi(priv);
 
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
-- 
2.30.2


