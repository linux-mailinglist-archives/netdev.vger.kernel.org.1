Return-Path: <netdev+bounces-157720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF9A0B5FC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A059166CB4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EE1CAA80;
	Mon, 13 Jan 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uaDiXOvu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06261C3C05
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768792; cv=none; b=L3Pe7kaHSHlFFRHSj8vHoaSrN7WWqiHkMsnwrmRAhJ1eg+r7oYcVOA7gu8NMJ2hqRyBCnnGjcw2We46aPmZHXWuvF+pmhP8HbudT/dZDm6uFnFW+WRnoX/PCpACaRIA5uFZeLxBXpd6C+lidm5GeHJ0m/rNP/PAAMe2gn4+1E8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768792; c=relaxed/simple;
	bh=P6+5UUfzVWaWExUTuPMtYBy9iyJhiZ8Hii9iI5r/OZ0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=P4U0mBIRy8BToY3Kjl0sGVEnjNXJu09WYyeiBoNdjNgtrY8jAoWaGTPfKxUUmq0sj7M5G5ByGDp/iBnyR6aGMghYj8qH9VC76ejc38fCiBHzjAJRQkgH21d4I0uy5s2nIbk2JB5IfMIWU59SbDcxpxdLcGI4NgDimGK5SCS6XU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uaDiXOvu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g+VsXR88odtwMSlVe7f6Y99n5yB+/8EudxncAOgJLec=; b=uaDiXOvuAhAd7fvqgtJPK3Pzym
	JAW2BZnk22M1VKV7SwEZ6cxmi5u/3PMN2R2W0KjhbZ/ljPtCkf4HgyVg0xpM1l+P+yNl4EwrW4xky
	+ttjAuCONpJey143HFrHBiazoXZAEWkELODOTbYoszY298Bw3vm5fb45teYwa+p7IavOGYgIH4Wja
	U87ONwH7CH8l7hYIlTPG3zK7hCCYt7fLfBRJbPG2qq6eCBZDu5/U61bE76wBxkHk2PHupTRtVnKjO
	CLz+BWNNrJjf/pQs0XfdkBs2toSBItyL3bI8xTuF+hiMTT6Gf+MKKRZiwKDe2KtQWz1wV2wXTUoEo
	MIfy/HJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItk-0006WI-1l;
	Mon, 13 Jan 2025 11:46:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItR-000MBO-GF; Mon, 13 Jan 2025 11:46:05 +0000
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
Subject: [PATCH net-next 6/9] net: stmmac: provide stmmac_eee_tx_busy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItR-000MBO-GF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:46:05 +0000

Extract the code which checks whether there's still work to do on any
of the stmmac transmit queues. This will allow us to combine
stmmac_enable_eee_mode() with stmmac_try_to_start_sw_lpi() in the
next patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2bb61757e320..ddbcbe3886c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -400,13 +400,7 @@ static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
 	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
 }
 
-/**
- * stmmac_enable_eee_mode - check and enter in LPI mode
- * @priv: driver private structure
- * Description: this function is to verify and enter in LPI mode in case of
- * EEE.
- */
-static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
+static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
 {
 	u32 tx_cnt = priv->plat->tx_queues_to_use;
 	u32 queue;
@@ -416,9 +410,23 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 
 		if (tx_q->dirty_tx != tx_q->cur_tx)
-			return -EBUSY; /* still unfinished work */
+			return true; /* still unfinished work */
 	}
 
+	return false;
+}
+
+/**
+ * stmmac_enable_eee_mode - check and enter in LPI mode
+ * @priv: driver private structure
+ * Description: this function is to verify and enter in LPI mode in case of
+ * EEE.
+ */
+static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
+{
+	if (stmmac_eee_tx_busy(priv))
+		return -EBUSY; /* still unfinished work */
+
 	/* Check and enter in LPI mode */
 	if (!priv->tx_path_in_lpi_mode)
 		stmmac_set_eee_mode(priv, priv->hw,
-- 
2.30.2


