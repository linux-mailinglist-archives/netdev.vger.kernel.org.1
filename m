Return-Path: <netdev+bounces-164663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1CDA2EA26
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1281D188C0B9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E31DE3CA;
	Mon, 10 Feb 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NVZVOAu2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F041D515B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184847; cv=none; b=VWMcbb1LR43pbMU5AFXi8Zb5OUMLCzsP/HraV5MHQeyuL6kkkSsugc5VJhaap83G48bPS2t+2LVvVC08OOO0ZT5g0L08NMfVlblmW+hX9nyWdIsxstpFy0goz3NEMjJKzrkTyuVqksGprOafsSFdpyIuTdQj+CA2UVLDG2FUNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184847; c=relaxed/simple;
	bh=9zcrminkBJIkeIfYSeCwqEcLknqlz9U9BpYU/7WSVb0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=phFLw6I5qKnPUPGzZFR8rdPkQzXhkpLnMDFBDIJKndbl8aevWBvROWECOQRwXhd9V6gNoKPcdoPZDycx8bP2bxIhdM4vpxbXNpvg/t+YUKlCMwGNiIG4JOioIpifEh+CsZ2wbtHICvqDIvw//ez5nE2BuJuCNjZPoE8tDNKKtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NVZVOAu2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jXHt/5Eoh9udL8jpygkO/9L3xb0nJ0bR2NLfWApVjKY=; b=NVZVOAu2F9GcCHcf1iMmevJYjg
	WdIrjH+xP2XlUDw09zzNfDeDwrhDBRLqlF7S+W8Xmh45KGtGBfuh78xPEK4Y5c1Mu/yJPy+7Vs+2i
	Uy3fGcrQd7cw/EKG4MuFOc1qtll0mE+BrIdMgi4T9oCBeY9L/tFF3j2TY6eu+UxPnu7XDoBZPBvGA
	Ui/8fckvxZ6yqiFtCyR6sPWZv+Tj/jmmJc2f+xVMtCpzdlHA+Hu7WHpOBakqfcrBWcKX/ke9uLrNQ
	mepMtKSiQAFAOEdVXZKrEXPQ00+SupQahwrwoH2JnKuho+DCnsIUb9xHHf1P7gSW90vsOeJkslyz5
	ciOefFzg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52020 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRQN-0006VJ-1J;
	Mon, 10 Feb 2025 10:53:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thRQ3-003w6u-RH; Mon, 10 Feb 2025 10:53:39 +0000
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/8] net: phylink: add support for notifying PCS
 about EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thRQ3-003w6u-RH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:53:39 +0000

There are hooks in the stmmac driver into XPCS to control the EEE
settings when LPI is configured at the MAC. This bypasses the layering.
To allow this to be removed from the stmmac driver, add two new
methods for PCS to inform them when the LPI/EEE enablement state
changes at the MAC.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 25 ++++++++++++++++++++++---
 include/linux/phylink.h   | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 214b62fba991..840af19488d8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1073,6 +1073,18 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_disable_eee)
+		pcs->ops->pcs_disable_eee(pcs);
+}
+
+static void phylink_pcs_enable_eee(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_enable_eee)
+		pcs->ops->pcs_enable_eee(pcs);
+}
+
 /* Query inband for a specific interface mode, asking the MAC for the
  * PCS which will be used to handle the interface mode.
  */
@@ -1601,6 +1613,8 @@ static void phylink_deactivate_lpi(struct phylink *pl)
 		phylink_dbg(pl, "disabling LPI\n");
 
 		pl->mac_ops->mac_disable_tx_lpi(pl->config);
+
+		phylink_pcs_disable_eee(pl->pcs);
 	}
 }
 
@@ -1617,13 +1631,18 @@ static void phylink_activate_lpi(struct phylink *pl)
 	phylink_dbg(pl, "LPI timer %uus, tx clock stop %u\n",
 		    pl->mac_tx_lpi_timer, pl->mac_tx_clk_stop);
 
+	phylink_pcs_enable_eee(pl->pcs);
+
 	err = pl->mac_ops->mac_enable_tx_lpi(pl->config, pl->mac_tx_lpi_timer,
 					     pl->mac_tx_clk_stop);
-	if (!err)
-		pl->mac_enable_tx_lpi = true;
-	else
+	if (err) {
+		phylink_pcs_disable_eee(pl->pcs);
 		phylink_err(pl, "%ps() failed: %pe\n",
 			    pl->mac_ops->mac_enable_tx_lpi, ERR_PTR(err));
+		return;
+	}
+
+	pl->mac_enable_tx_lpi = true;
 }
 
 static void phylink_link_up(struct phylink *pl,
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 898b00451bbf..a692d638568f 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -477,6 +477,10 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
+ *		     at the MAC.
+ * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
+ *		    the MAC.
  * @pcs_pre_init: configure PCS components necessary for MAC hardware
  *                initialization e.g. RX clock for stmmac.
  */
@@ -500,6 +504,8 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
+	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
 };
 
@@ -625,6 +631,22 @@ void pcs_an_restart(struct phylink_pcs *pcs);
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
 
+/**
+ * pcs_disable_eee() - Disable EEE at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs
+ *
+ * Optional method informing the PCS that EEE has been disabled at the MAC.
+ */
+void pcs_disable_eee(struct phylink_pcs *pcs);
+
+/**
+ * pcs_enable_eee() - Enable EEE at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs
+ *
+ * Optional method informing the PCS that EEE is about to be enabled at the MAC.
+ */
+void pcs_enable_eee(struct phylink_pcs *pcs);
+
 /**
  * pcs_pre_init() - Configure PCS components necessary for MAC initialization
  * @pcs: a pointer to a &struct phylink_pcs.
-- 
2.30.2


