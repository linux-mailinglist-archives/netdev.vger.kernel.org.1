Return-Path: <netdev+bounces-155958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41628A04672
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DA43A7806
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0A1F75A9;
	Tue,  7 Jan 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="acBQQ+Ny"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA11F7575
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267382; cv=none; b=q9PlEmCzKtnGZV5BwNj89263ZuBNw4j9LBJxFr/TGORejXfmYfPW6RmqcuGhYaqSDG756UlVVC1o51oq+H0bBHShr8XdgvgaQ0g7uc7BPWgUjYSPqLhvUZYqv+XNMzNHVAhwkHSaNYy+5KxXp4kQze9JqiP52vJUbQvjGoZTYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267382; c=relaxed/simple;
	bh=MbbElpiISCmXlQ+d02zeQiaXWQGdSHJu5HKs9PxwHAA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Qa+rcbBZtyU1Htk9GXP3mPO9/SNbYCR15qH81RtquIfx4GqxsDBCjdoaCuJD6ILc9HqP9+w9qcjQkcm51tTtbJsDopJ0+zI0blE3ZoAkj9OFan2q7fcZZ+m7KlDrL2oPgXVH4uv9/M9Bis2cGUW2On2Xdxh1x70zimeHmPrqXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=acBQQ+Ny; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AtobVMnr8E5gzN8ZgvrreHjtEy+CmRHbLYgzCHnDnG4=; b=acBQQ+NyHAqjSuSoJzPyYnAk3v
	4n+lmW/UgxASD7sLSNkoXl5EANM5UHgfIZ/2530W9UaVyNDKtpYYbDCkxV2OVfGEeWVSe9r0l8mbn
	5ZVzo81Fpfevfrf0VG4JbcCmBWhk/YkVAURV0xkGoptuC+98Q109QMk8r45FwwjMqsmmxhGFvUuz8
	gbNErKg2ETG1MohLqC8fz768v1Z0iVblTlZTB9qdOiPsq1x+8IPPGVHOjM6/igTRZ8F28hdbLDWnb
	O/KsaNI9PGcG54RwEjKOpNZ7drgrjzvuY4Pe86QZiQLUk7yHj+Y8kKc5XL9D7e8M9d/x6zreSBCIF
	U3+faP8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59402 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSR-0007nz-1X;
	Tue, 07 Jan 2025 16:29:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCSO-007Y43-Fa; Tue, 07 Jan 2025 16:29:28 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 12/18] net: stmmac: move priv->eee_enabled into
 stmmac_eee_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCSO-007Y43-Fa@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:28 +0000

All call sites for stmmac_eee_init() assign the return code to
priv->eee_enabled. Rather than having this coded at each call site,
move the assignment inside stmmac_eee_init().

Since stmmac_init_eee() takes priv->lock before checking the state of
priv->eee_enabled, move the assignment within the locked region. Also,
stmmac_suspend() checks the state of this member under the lock. While
two concurrent calls to stmmac_init_eee() aren't possible, there is
a possibility that stmmac_suspend() may run concurrently with a change
of priv->eee_enabled unless we modify it under the lock.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 94bb6b07f96f..b7e0026c271b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -462,11 +462,13 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
  *  can also manage EEE, this function enable the LPI state and start related
  *  timer.
  */
-static bool stmmac_eee_init(struct stmmac_priv *priv)
+static void stmmac_eee_init(struct stmmac_priv *priv)
 {
 	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee)
-		return false;
+	if (!priv->dma_cap.eee) {
+		priv->eee_enabled = false;
+		return;
+	}
 
 	mutex_lock(&priv->lock);
 
@@ -483,8 +485,9 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 						priv->plat->mult_fact_100ns,
 						false);
 		}
+		priv->eee_enabled = false;
 		mutex_unlock(&priv->lock);
-		return false;
+		return;
 	}
 
 	if (priv->eee_active && !priv->eee_enabled) {
@@ -507,9 +510,10 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 			  STMMAC_LPI_T(priv->tx_lpi_timer));
 	}
 
+	priv->eee_enabled = true;
+
 	mutex_unlock(&priv->lock);
 	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
-	return true;
 }
 
 /* stmmac_get_tx_hwtstamp - get HW TX timestamps
@@ -967,7 +971,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	priv->eee_active = false;
-	priv->eee_enabled = stmmac_eee_init(priv);
+	stmmac_eee_init(priv);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
@@ -1080,7 +1084,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
 		priv->eee_active = phy->enable_tx_lpi;
-		priv->eee_enabled = stmmac_eee_init(priv);
+		stmmac_eee_init(priv);
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
 
-- 
2.30.2


