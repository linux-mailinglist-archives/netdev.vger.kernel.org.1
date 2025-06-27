Return-Path: <netdev+bounces-201914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21986AEB652
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C067B2C41
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B729DB6C;
	Fri, 27 Jun 2025 11:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BD2BD5B7
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023572; cv=none; b=MvlBpNk0nkhPVY3/lDmuKWLBqH3PnTRdrIbOplyrvfvtKbdwTuVjmF9+lowOVP7Q1YTl6wZVpdoPuFv+eD1lprqloCK9b1dyI1Dx/EFcRKgVu9bZIss1lIUPQazfNizktyfk/SUnojPzT/svJpA+M+cBWtRoCU0Aig6GxjTgij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023572; c=relaxed/simple;
	bh=/5sKzhy0U7mWcXv6ol6//8b1xu6weKJCNg0GsKTp2ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R7FciWtz059/2A/z/518siuB6ri3pp7OtSWt6cVKPXzyGiFV8SbPc+Fs3S61aorJFULJlKb9jH1D/2E2VU85gqf3nKswX8hi3KpwwiFyjL5bwukqbo4F6JOhTPFEKOwdR9cyHgZIjCLScGOL10Bk0tz+ag98lRX4ZCCIY3b3Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uV7DC-0007OW-HD; Fri, 27 Jun 2025 13:25:42 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uV7DA-005bYo-34;
	Fri, 27 Jun 2025 13:25:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uV7DA-003kun-2p;
	Fri, 27 Jun 2025 13:25:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/1] phy: micrel: add Signal Quality Indicator (SQI) support for KSZ9477 switch PHYs
Date: Fri, 27 Jun 2025 13:25:39 +0200
Message-Id: <20250627112539.895255-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add support for the Signal Quality Indicator (SQI) feature on KSZ9477
family switches, providing a relative measure of receive signal quality.

The hardware exposes separate SQI readings per channel. For 1000BASE-T,
all four channels are read. For 100BASE-TX, only one channel is reported,
but which receive pair is active depends on Auto MDI-X negotiation, which
is not exposed by the hardware. Therefore, it is not possible to reliably
map the measured channel to a specific wire pair.

This resolves an earlier discussion about how to handle multi-channel
SQI. Originally, the plan was to expose all channels individually.
However, since pair mapping is sometimes unavailable, this
implementation treats SQI as a per-link metric instead. This fallback
avoids ambiguity and ensures consistent behavior. The existing get_sqi()
UAPI was designed for single-pair Ethernet (SPE), where per-pair and
per-link are effectively equivalent. Restricting its use to per-link
metrics does not introduce regressions for existing users.

The raw 7-bit SQI value (0–127, lower is better) is converted to the
standard 0–7 (high is better) scale. Empirical testing showed that the
link becomes unstable around a raw value of 8.

The SQI raw value remains zero if no data is received, even if noise is
present. This confirms that the measurement reflects the "quality" during
active data reception rather than the passive line state. User space
must ensure that traffic is present on the link to obtain valid SQI
readings.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- Update commit message
- drop usleep
- bring back multi channel support
changes v2:
- Reword commit message
- Fix SQI value inversion
- Implement an empirically-derived, non-linear mapping to the standard
  0-7 SQI scale
---
 drivers/net/phy/micrel.c | 132 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index d0429dc8f561..74fd6ff32c6c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2173,6 +2173,136 @@ static void kszphy_get_phy_stats(struct phy_device *phydev,
 	stats->rx_errors = priv->phy_stats.rx_err_pkt_cnt;
 }
 
+/* Base register for Signal Quality Indicator (SQI) - Channel A
+ *
+ * MMD Address: MDIO_MMD_PMAPMD (0x01)
+ * Register:    0xAC (Channel A)
+ * Each channel (pair) has its own register:
+ *   Channel A: 0xAC
+ *   Channel B: 0xAD
+ *   Channel C: 0xAE
+ *   Channel D: 0xAF
+ */
+#define KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A	0xac
+
+/* SQI field mask for bits [14:8]
+ *
+ * SQI indicates relative quality of the signal.
+ * A lower value indicates better signal quality.
+ */
+#define KSZ9477_MMD_SQI_MASK			GENMASK(14, 8)
+
+#define KSZ9477_MAX_CHANNELS			4
+#define KSZ9477_SQI_MAX				7
+
+/* Number of SQI samples to average for a stable result.
+ *
+ * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
+ * For noisy environments, a minimum of 30–50 readings is recommended.
+ */
+#define KSZ9477_SQI_SAMPLE_COUNT		40
+
+/* The hardware SQI register provides a raw value from 0-127, where a lower
+ * value indicates better signal quality. However, empirical testing has
+ * shown that only the 0-7 range is relevant for a functional link. A raw
+ * value of 8 or higher was measured directly before link drop. This aligns
+ * with the OPEN Alliance recommendation that SQI=0 should represent the
+ * pre-failure state.
+ *
+ * This table provides a non-linear mapping from the useful raw hardware
+ * values (0-7) to the standard 0-7 SQI scale, where higher is better.
+ */
+static const u8 ksz_sqi_mapping[] = {
+	7, /* raw 0 -> SQI 7 */
+	7, /* raw 1 -> SQI 7 */
+	6, /* raw 2 -> SQI 6 */
+	5, /* raw 3 -> SQI 5 */
+	4, /* raw 4 -> SQI 4 */
+	3, /* raw 5 -> SQI 3 */
+	2, /* raw 6 -> SQI 2 */
+	1, /* raw 7 -> SQI 1 */
+};
+
+/**
+ * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
+ * @phydev: the PHY device
+ *
+ * This function reads and processes the raw Signal Quality Index from the
+ * PHY. Based on empirical testing, a raw value of 8 or higher indicates a
+ * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
+ * mapped to the standard 0-7 SQI scale via a lookup table.
+ *
+ * Return: SQI value (0–7), or a negative errno on failure.
+ */
+static int kszphy_get_sqi(struct phy_device *phydev)
+{
+	int sum[KSZ9477_MAX_CHANNELS] = { 0 };
+	int worst_sqi = KSZ9477_SQI_MAX;
+	int i, val, raw_sqi, ch;
+	u8 channels;
+
+	/* Determine applicable channels based on link speed */
+	if (phydev->speed == SPEED_1000)
+		channels = 4;
+	else if (phydev->speed == SPEED_100)
+		channels = 1;
+	else
+		return -EOPNOTSUPP;
+
+	/* Sample and accumulate SQI readings for each pair (currently only one).
+	 *
+	 * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
+	 * - The SQI register is updated every 2 µs.
+	 * - Values may fluctuate significantly, even in low-noise environments.
+	 * - For reliable estimation, average a minimum of 30–50 samples
+	 *   (recommended for noisy environments)
+	 * - In noisy environments, individual readings are highly unreliable.
+	 *
+	 * We use 40 samples per pair with a delay of 3 µs between each
+	 * read to ensure new values are captured (2 µs update interval).
+	 */
+	for (i = 0; i < KSZ9477_SQI_SAMPLE_COUNT; i++) {
+		for (ch = 0; ch < channels; ch++) {
+			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+					   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A + ch);
+			if (val < 0)
+				return val;
+
+			raw_sqi = FIELD_GET(KSZ9477_MMD_SQI_MASK, val);
+			sum[ch] += raw_sqi;
+
+			/* We communicate with the PHY via MDIO via SPI or
+			 * I2C, which is relatively slow. At least slower than
+			 * the update interval of the SQI register.
+			 * So, we can skip the delay between reads.
+			 */
+		}
+	}
+
+	/* Calculate average for each channel and find the worst SQI */
+	for (ch = 0; ch < channels; ch++) {
+		int avg_raw_sqi = sum[ch] / KSZ9477_SQI_SAMPLE_COUNT;
+		int mapped_sqi;
+
+		/* Handle the pre-fail/failed state first. */
+		if (avg_raw_sqi >= ARRAY_SIZE(ksz_sqi_mapping))
+			mapped_sqi = 0;
+		else
+			/* Use the lookup table for the good signal range. */
+			mapped_sqi = ksz_sqi_mapping[avg_raw_sqi];
+
+		if (mapped_sqi < worst_sqi)
+			worst_sqi = mapped_sqi;
+	}
+
+	return worst_sqi;
+}
+
+static int kszphy_get_sqi_max(struct phy_device *phydev)
+{
+	return KSZ9477_SQI_MAX;
+}
+
 static void kszphy_enable_clk(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -5801,6 +5931,8 @@ static struct phy_driver ksphy_driver[] = {
 	.update_stats	= kszphy_update_stats,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	.get_sqi	= kszphy_get_sqi,
+	.get_sqi_max	= kszphy_get_sqi_max,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.39.5


