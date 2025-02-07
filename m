Return-Path: <netdev+bounces-163974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B4A2C34B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD83A4806
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA861E7C02;
	Fri,  7 Feb 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s0SIzxM7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120271E1A33
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933814; cv=none; b=KxIFwzM2zTg1lk1L+9xiHyqwOkq6XjFMCIp+jEcixlHZaVcg7b7c6QioNT2XWbp9M3nDOZu4coa4LFJoZ+iVIL+5zcIw79BiwwCO4t0a3EFMqSPhf3cLnas/Apsc/8otgBVUxj7YeI8hrnOngrDVO0MujFGcHp9Q4SW8TUfEgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933814; c=relaxed/simple;
	bh=uhnsYK8lhYw1vJvlUg+sUQjW9WgfpkLhxLKh5lEuTvo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CiPPFPTC7APX0pwtW0lzSkFW+ED0Vi2azwW3XI/wUKQn+nZplLtIc7DGhtGjr7QBM/nRf4s2MCx75S3C9qXzki06ufXTL312Ehfa1HRbFDauucmszFiuBRgJin4uIwFKniSGGHYhRvz8AcvR70VZfUcU5kI7b1SRAW6p0zP+KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s0SIzxM7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rPlsVId33txdBBranLBlQ1L7Lpylf6kTxcaJ3s9zHV8=; b=s0SIzxM70be6SAqLGuJXeih+Tp
	19KfL9tugVDmsXOCiNA9pyGA66ziK+piIdSmtneKyo2RBtQC+F+qvKOQKqkM6r71REHtaX7iJo6qB
	VYvDsWHfRX3mF8Pd0uUACPhm1SNimt7oYgOkx3Ynf8JI5ftSq69sdzOGia05DPm7K3CzJOq8b+4WE
	xs8ZK1pIABQX7Nh6XupXwsHZm1ZyiMxNdh6HC6tAOjX8BEbauC3WoMEmB92kCs122bnF1Mg7N6mdO
	YpsKqFNnR0MEk3t3vOJEeuFhbsE8EhyW+1bA1KbqBsBQns/2lA82fDnwByMlfheTik2lIn5Pf5erB
	qWnyJPLg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37010 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tgO7P-0005i4-2e;
	Fri, 07 Feb 2025 13:10:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tgO75-003ilL-5y; Fri, 07 Feb 2025 13:09:43 +0000
In-Reply-To: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 3/3] net: dsa: mt7530: convert to phylink managed
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
Message-Id: <E1tgO75-003ilL-5y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Feb 2025 13:09:43 +0000

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


