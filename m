Return-Path: <netdev+bounces-164652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79CA2E9A6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78CF3A9EC6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9F1C68A6;
	Mon, 10 Feb 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ukjnz8SY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACF1D14FF
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183844; cv=none; b=I/ziHnVskntTLdRp1o8jH/hEXK0ZLvll363OD0bjYxwjVGbFNltGWMG8laEoWkWSK3wXjBw6tX8i1QStm1TM01PbU1QX6OVqlR1kH8TQLtaDSSNBm7DDQrwiTd+F2FZabDwulZB1pATcZXNz5CNjRk2oCrjFdAhL+ZPdAz/Dsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183844; c=relaxed/simple;
	bh=uhnsYK8lhYw1vJvlUg+sUQjW9WgfpkLhxLKh5lEuTvo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QW7y1hut0ArZpsTzNi5VA/ek2mPo9yMxPZVS9Ym1kfpV+W0+36gi4lT1Lzpz373XwWCXKoZ+0lwLT6NZNRNozzue0vPjfs8TbzegbJ6bNtVmt2gr4NUESzf9yYl6XqNI+9DZzRtumkrkxwPfKiWQeMx+GtfQwpmjZGg2HhUABs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ukjnz8SY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rPlsVId33txdBBranLBlQ1L7Lpylf6kTxcaJ3s9zHV8=; b=ukjnz8SYZHHdBdIZziI8MlP9sP
	ic8omwR9g94e9tTntfnTQiwIODxtyR+6linoGhmPZy+bw9LCPvPF+q1wjGS438JXMm9ZsiB/1HvSx
	YsV0GSMKWMSPu05VhUo6X8mYw5G2ds82XDU1shsr9JrtRSYNTMEK14DLm2w3DeRAfS9bb8fhf10Ut
	UVOItsMFE3E9SdNymd4IEnib2xYOnzKrn1Mqs302s8B3h88sMsr3ybUowzoiAlDqVvJRvDfI8JuHf
	F5taXt8NdGnQC+CL/bbp62jbFf8Zt3sWGlHN43SNol4NeRbFmx6uY9J0GzSw/0W1HowZuU2jA4JWZ
	gCF/gGQA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36674 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRAA-0006RY-0A;
	Mon, 10 Feb 2025 10:37:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thR9q-003vXI-Cp; Mon, 10 Feb 2025 10:36:54 +0000
In-Reply-To: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v3 3/3] net: dsa: mt7530: convert to phylink managed
 EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thR9q-003vXI-Cp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:36:54 +0000

Convert mt7530 to use phylink managed EEE. When enabling EEE, we set
both PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 irrespective of the speed,
and clear them both when disabling.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mt7530.c | 68 +++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1c83af805209..9fd44e55d519 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2957,28 +2957,61 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 			mcr |= PMCR_FORCE_RX_FC_EN;
 	}
 
-	if (mode == MLO_AN_PHY && phydev && phy_init_eee(phydev, false) >= 0) {
-		switch (speed) {
-		case SPEED_1000:
-		case SPEED_2500:
-			mcr |= PMCR_FORCE_EEE1G;
-			break;
-		case SPEED_100:
-			mcr |= PMCR_FORCE_EEE100;
-			break;
-		}
-	}
-
 	mt7530_set(priv, MT753X_PMCR_P(dp->index), mcr);
 }
 
+static void mt753x_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mt7530_priv *priv = dp->ds->priv;
+
+	mt7530_clear(priv, MT753X_PMCR_P(dp->index),
+		     PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
+}
+
+static int mt753x_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					    u32 timer, bool tx_clock_stop)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mt7530_priv *priv = dp->ds->priv;
+	u32 val;
+
+	/* If the timer is zero, then set LPI_MODE_EN, which allows the
+	 * system to enter LPI mode immediately rather than waiting for
+	 * the LPI threshold.
+	 */
+	if (!timer)
+		val = LPI_MODE_EN;
+	else if (FIELD_FIT(LPI_THRESH_MASK, timer))
+		val = FIELD_PREP(LPI_THRESH_MASK, timer);
+	else
+		val = LPI_THRESH_MASK;
+
+	mt7530_rmw(priv, MT753X_PMEEECR_P(dp->index),
+		   LPI_THRESH_MASK | LPI_MODE_EN, val);
+
+	mt7530_set(priv, MT753X_PMCR_P(dp->index),
+		   PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
+
+	return 0;
+}
+
 static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
 	struct mt7530_priv *priv = ds->priv;
+	u32 eeecr;
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
+
+	eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
+	/* tx_lpi_timer should be in microseconds. The time units for
+	 * LPI threshold are unspecified.
+	 */
+	config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
+
 	priv->info->mac_port_get_caps(ds, port, config);
 }
 
@@ -3088,18 +3121,9 @@ mt753x_setup(struct dsa_switch *ds)
 static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 			      struct ethtool_keee *e)
 {
-	struct mt7530_priv *priv = ds->priv;
-	u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
-
 	if (e->tx_lpi_timer > 0xFFF)
 		return -EINVAL;
 
-	set = LPI_THRESH_SET(e->tx_lpi_timer);
-	if (!e->tx_lpi_enabled)
-		/* Force LPI Mode without a delay */
-		set |= LPI_MODE_EN;
-	mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
-
 	return 0;
 }
 
@@ -3238,6 +3262,8 @@ static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
 	.mac_config	= mt753x_phylink_mac_config,
 	.mac_link_down	= mt753x_phylink_mac_link_down,
 	.mac_link_up	= mt753x_phylink_mac_link_up,
+	.mac_disable_tx_lpi = mt753x_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = mt753x_phylink_mac_enable_tx_lpi,
 };
 
 const struct mt753x_info mt753x_table[] = {
-- 
2.30.2


