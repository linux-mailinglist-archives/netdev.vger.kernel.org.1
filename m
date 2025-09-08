Return-Path: <netdev+bounces-220816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C6B48DF4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558021B25D4C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A283054FB;
	Mon,  8 Sep 2025 12:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F644690
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335592; cv=none; b=T0OzCiWy0uilXTRHjzukXdjT2l3AxnM6DFvpko0dxns1T2gf9u9J356oinQDU3QB7g83Zond+qoZsziHy7PlMrqHmZch1gXbNrzLTpukenBCqEr2qLa0Ak945WwAVVL+EHWjXM0RcJla8o681eN0wl9ezUFWpAmnSS50q2a4+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335592; c=relaxed/simple;
	bh=KvPkdza+dT296uEARiCseHwuSIvLjN+tjNRKd1Gy8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miBiaonfQi2pSN2d37vtfKFk1XosnyM1VFQbdTPuDVnUZrpk5CH+200VcqcLnYzCxoGX7Td90gwmnLA7oWdaJ8wS7Zewk78v31GgSoLXS2CpSbklpf+8Z1cmVLTDXjgos/WmQciXByB5kFMtiGTSmWci75TFNi4R5aL8jalkDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG9-0003SA-F8; Mon, 08 Sep 2025 14:46:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-000Fiu-2r;
	Mon, 08 Sep 2025 14:46:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-0000000CKJz-3AvL;
	Mon, 08 Sep 2025 14:46:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v5 5/5] net: phy: dp83td510: add MSE interface support for 10BASE-T1L
Date: Mon,  8 Sep 2025 14:46:10 +0200
Message-ID: <20250908124610.2937939-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908124610.2937939-1-o.rempel@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Implement get_mse_config() and get_mse_snapshot() for the DP83TD510E
to expose its Mean Square Error (MSE) register via the new PHY MSE
UAPI.

The DP83TD510E does not document any peak MSE values; it only exposes
a single average MSE register used internally to derive SQI. This
implementation therefore advertises only PHY_MSE_CAP_AVG, along with
LINK and channel-A selectors. Scaling is fixed to 0xFFFF, and the
refresh interval/number of symbols are estimated from 10BASE-T1L
symbol rate (7.5 MBd) and typical diagnostic intervals (~1 ms).

For 10BASE-T1L deployments, SQI is a reliable indicator of link
modulation quality once the link is established, but it does not
indicate whether autonegotiation pulses will be correctly received
in marginal conditions. MSE provides a direct measurement of slicer
error rate that can be used to evaluate if autonegotiation is likely
to succeed under a given cable length and condition. In practice,
testing such scenarios often requires forcing a fixed-link setup to
isolate MSE behaviour from the autonegotiation process.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 23af1ac194fa..094c070f3f96 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -249,6 +249,47 @@ struct dp83td510_priv {
 #define DP83TD510E_ALCD_COMPLETE			BIT(15)
 #define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
 
+static int dp83td510_get_mse_config(struct phy_device *phydev,
+				    struct phy_mse_config *config)
+{
+	/* The DP83TD510E datasheet does not specify peak MSE values.
+	 * It only provides a single MSE value which is used to derive SQI.
+	 * Therefore, we only support the average MSE capability.
+	 */
+	config->supported_caps = PHY_MSE_CAP_AVG | PHY_MSE_CAP_LINK |
+		PHY_MSE_CAP_CHANNEL_A;
+	config->max_average_mse = 0xFFFF;
+
+	/* The datasheet does not specify the refresh rate or symbol count,
+	 * but based on similar PHYs and standards, we can assume a common
+	 * value. For 10BaseT1L, the symbol rate is 7.5 MBd. A common
+	 * diagnostic interval is around 1ms.
+	 * 7.5e6 symbols/sec * 0.001 sec = 7500 symbols.
+	 */
+	config->refresh_rate_ps = 1000000000; /* 1 ms */
+	config->num_symbols = 7500;
+
+	return 0;
+}
+
+static int dp83td510_get_mse_snapshot(struct phy_device *phydev, u32 channel,
+				      struct phy_mse_snapshot *snapshot)
+{
+	int ret;
+
+	if (channel != PHY_MSE_CHANNEL_LINK &&
+	    channel != PHY_MSE_CHANNEL_A)
+		return -EOPNOTSUPP;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_MSE_DETECT);
+	if (ret < 0)
+		return ret;
+
+	snapshot->average_mse = ret;
+
+	return 0;
+}
+
 static int dp83td510_led_brightness_set(struct phy_device *phydev, u8 index,
 					enum led_brightness brightness)
 {
@@ -893,6 +934,9 @@ static struct phy_driver dp83td510_driver[] = {
 	.get_phy_stats	= dp83td510_get_phy_stats,
 	.update_stats	= dp83td510_update_stats,
 
+	.get_mse_config	= dp83td510_get_mse_config,
+	.get_mse_snapshot = dp83td510_get_mse_snapshot,
+
 	.led_brightness_set = dp83td510_led_brightness_set,
 	.led_hw_is_supported = dp83td510_led_hw_is_supported,
 	.led_hw_control_set = dp83td510_led_hw_control_set,
-- 
2.47.3


