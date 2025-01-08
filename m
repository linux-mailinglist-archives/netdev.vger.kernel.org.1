Return-Path: <netdev+bounces-156356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB69A0628F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA351677CC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0AF1FF7A9;
	Wed,  8 Jan 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jYBWhcmy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943181FF601
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354913; cv=none; b=GRSeEs7fZauRLIKWKYWy/wuiGu09VpsMfZ58LzeLuyGSIgINNypnlZxYTSzUNXT4qAfwMY+yIwvhdKvsjb2iWKqsEIkqYQP4teJ4sW2XvDUSUgAxjCYM3PobnNCVp2RGFsiOdooa72vAEIuMdxJg8MTXHfrQnBfLL95ue4UkjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354913; c=relaxed/simple;
	bh=/ZjyUHK1HFpaTU33/HnlKX8xXJF6lP1lvGbxDWIMFBk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ASBgQdtAqC9XTNh1A1HVv/3/edPJnTMbvsdBkFnV9QHyY+3QrVD3wjBsQgfRe32U5Z9qpZWv1AGAOmT3WX2UZvNXf6sEXCYxij34+2Ik2V1KYGlyvojIgHtXThzEdMRFu6pA1NUrqIzlElBOJvHm+t/yVTK5g5Yak5nK1pjz/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jYBWhcmy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PQ14Izj44j5dYld782zHWwkwWoBPzRg9ao0ISPNBJRE=; b=jYBWhcmym+D8266EEI09hBd7xB
	q0sRIn3TK56zfyJGpjYASn29OHbTdZJBPmJXG9lCZf7J/AQgoEUX8kqRFzm5zS/vaY/keWE7oGJaO
	HwZpEqlPxMe8smFh+f3qy5xdwW7ouqXx7JwRE7icmEt852F694oSwl48tTBXKAJxmXA/vIn5AMqxh
	uGggnaTrYsGMTMduhaGyHc8pUZFz1RhSs1ZyUZR5QqtpbgMYQTa97G6zDbf5BvJQtB7AdcPGOXfLc
	h0Z9OeBw22JHOaWYhfG+RCrsgZ/CscmLXDeHhUtnjLejntvIMnj/t8/4y6EoKrJpLnVGlqgwSbZZr
	o8CcYoWw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60546 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZEF-0000vz-1A;
	Wed, 08 Jan 2025 16:48:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZDw-0002KL-Gg; Wed, 08 Jan 2025 16:48:04 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v4 07/18] net: stmmac: clean up
 stmmac_disable_eee_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZDw-0002KL-Gg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:04 +0000

stmmac_disable_eee_mode() is now only called from stmmac_xmit() when
both priv->tx_path_in_lpi_mode and priv->eee_sw_timer_en are true.
Therefore:

	if (!priv->eee_sw_timer_en)

in stmmac_disable_eee_mode() will never be true, so this is dead code.
Remove it, and rename the function to indicate that it now only deals
with software based EEE mode.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index de06aa1ff3f6..9a043d19ebac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -427,18 +427,13 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 }
 
 /**
- * stmmac_disable_eee_mode - disable and exit from LPI mode
+ * stmmac_disable_sw_eee_mode - disable and exit from LPI mode
  * @priv: driver private structure
  * Description: this function is to exit and disable EEE in case of
  * LPI state is true. This is called by the xmit.
  */
-static void stmmac_disable_eee_mode(struct stmmac_priv *priv)
+static void stmmac_disable_sw_eee_mode(struct stmmac_priv *priv)
 {
-	if (!priv->eee_sw_timer_en) {
-		stmmac_lpi_entry_timer_config(priv, 0);
-		return;
-	}
-
 	stmmac_reset_eee_mode(priv, priv->hw);
 	del_timer_sync(&priv->eee_ctrl_timer);
 	priv->tx_path_in_lpi_mode = false;
@@ -4495,7 +4490,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	first_tx = tx_q->cur_tx;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
-		stmmac_disable_eee_mode(priv);
+		stmmac_disable_sw_eee_mode(priv);
 
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
-- 
2.30.2


