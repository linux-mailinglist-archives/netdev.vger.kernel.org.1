Return-Path: <netdev+bounces-155439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13EA0254D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1C2161AE1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED081A76C7;
	Mon,  6 Jan 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mnr1paHa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CC1DC9B2
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166334; cv=none; b=eNCZBIfGGRLTQ/Vu+5OcoSB+FAnuvXIqazK2OvEfYSjTJQDJHUls+igXTXEw+HU2Ig2aIF0EL9IEbP2zcr70cnb/3S/QuCGdn4SZ+sDa976u8ns83iL8g6s3VlPH6/sPuo7mTpZLyJNnGmWe543d3x7E02Ccu70PdVe8Y3/ga68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166334; c=relaxed/simple;
	bh=Q9sNgdBaBjOXTR/AhJ3GwVmjVqe2uHJOlsoPOFLY8qU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fJNSYEseHbrCjAWp52zgpM+URrZpEXXT+RNYTW6RjqxRUlHmd4oN8XNm2sDmO9fgt1at20WcJd7ulzPbCokC21x7QlTDUQDN6fx6zmxeG/FggVw9MZuLdazdzsD1t42AHaxhaoJEN0ieLK5yijOl3BrKBvZfv2enhrF/h9kTg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mnr1paHa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kFIrQtPP73QU4OizVuDkpWxR7v/mfucuSSfwYZ7Tf/I=; b=mnr1paHawwFHv+iS5yPQjuCSUt
	OCj+0iRtT4T6c2iSO6+Wc/TDbGvF4GBKau1/UOaxxbrIpPDE7msYNa3e3+oGLg8/c0szHtsEFqNuU
	wNtFyre6KMDjm683BpAg8yzRRD9Zfgn3QI/FthFotFtG6R4BqxcOfrDMJpcohNG1OZUW/JjROyfsA
	PdVfDlDPPgIgMF1GOzonFtgv1K5i9aZEzMDGaofTNYwheWRZ02YewJDpLVU5BYvMmxVZ+Tx6xco9v
	9DGFM0q52k2sJqKi1hRB+Kev/LrG3xlznUWfhdte0Df3/ptGZIWQOydBvMWd9HQY8CyjMrOSfqUON
	rGlZjzsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40256 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAc-0005rv-1B;
	Mon, 06 Jan 2025 12:25:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAZ-007VXJ-DT; Mon, 06 Jan 2025 12:25:19 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 07/17] net: stmmac: remove priv->tx_lpi_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAZ-007VXJ-DT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:19 +0000

Through using phylib's EEE state, priv->tx_lpi_enabled has become a
write-only variable. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 2eee3c5c4d1e..507b6ac14289 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -308,7 +308,6 @@ struct stmmac_priv {
 	int eee_enabled;
 	int eee_active;
 	u32 tx_lpi_timer;
-	int tx_lpi_enabled;
 	int eee_tw_timer;
 	bool eee_sw_timer_en;
 	unsigned int mode;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47c57a558e5b..ba6de7b7d572 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -970,7 +970,6 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	priv->eee_active = false;
-	priv->tx_lpi_enabled = false;
 	priv->eee_enabled = stmmac_eee_init(priv);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
@@ -1085,7 +1084,6 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
 		priv->eee_enabled = stmmac_eee_init(priv);
-		priv->tx_lpi_enabled = priv->eee_enabled;
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
 
-- 
2.30.2


