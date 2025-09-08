Return-Path: <netdev+bounces-220821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBEB48DFB
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F5014E15BC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9DD3074B6;
	Mon,  8 Sep 2025 12:46:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30B3054CB
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335594; cv=none; b=rw+mLOndHTfcGpN0D4wzGBTlmnGrBi7fczCxIVhneHuuDckdRviW8J2rWYhpd77VFguke8HD885q+7S+ROKt3UWGTnggiBG8j+AakePLEcG8F/huqs1uK3gXTSC9Ejywme8GJNiAEzIXodDucDGPGCHpivPNl0hodMZd8rAoXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335594; c=relaxed/simple;
	bh=AHql4L2MMECt8qFo3mpT1lE/2CSHmR0Zx7dNrqyXO1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUugYyW4VB3HqSonf/L2LY837VtD5ikmEKkchHWpL0sRbQbyzQmo5pyEabLWS4ObfZqkHt/uJVg1EdWXkMJoscQHdmtss7GZAqvXeY5L65DwsxjsYdHkOt1/1GH4YKTUQtv4LQBohLZQAgi2WSZzbR6f6xD8XLjh1jsBJzMVyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG9-0003Ru-F8; Mon, 08 Sep 2025 14:46:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-000Fin-2L;
	Mon, 08 Sep 2025 14:46:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-0000000CKJK-2cyp;
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
Subject: [PATCH net-next v5 1/5] ethtool: introduce core UAPI and driver API for PHY MSE diagnostics
Date: Mon,  8 Sep 2025 14:46:06 +0200
Message-ID: <20250908124610.2937939-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908124610.2937939-1-o.rempel@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
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

Add the base infrastructure for Mean Square Error (MSE) diagnostics,
as proposed by the OPEN Alliance "Advanced diagnostic features for
100BASE-T1 automotive Ethernet PHYs" [1] specification.

The OPEN Alliance spec defines only average MSE and average peak MSE
over a fixed number of symbols. However, other PHYs, such as the
KSZ9131, additionally expose a worst-peak MSE value latched since the
last channel capture. This API accounts for such vendor extensions by
adding a distinct capability bit and snapshot field.

Channel-to-pair mapping is normally straightforward, but in some cases
(e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
If hardware does not expose MDI-X status, the exact pair cannot be
determined. To avoid returning misleading per-channel data in this case,
a LINK selector is defined for aggregate MSE measurements.

All investigated devices differ in MSE configuration parameters, such
as sample rate, number of analyzed symbols, and scaling factors.
For example, the KSZ9131 uses different scaling for MSE and pMSE.
To make this visible to userspace, scale limits and timing information
are returned via get_mse_config().

Some PHYs sample very few symbols at high frequency (e.g. 2 µs update
rate). To cover such cases and allow for future high-speed PHYs with
even shorter intervals, the refresh rate is reported as u64 in
picoseconds.

This patch defines new UAPI enums for MSE capability flags and channel
selectors in ethtool_netlink (generated from YAML), kernel-side
`struct phy_mse_config` and `struct phy_mse_snapshot`, and new
phy_driver ops:

  - get_mse_config(): report supported capabilities, scaling, and
    sampling parameters for the current link mode
  - get_mse_snapshot(): retrieve a correlated set of MSE values from
    the latest measurement window

These definitions form the core API; no driver implements them yet.

[1] <https://opensig.org/wp-content/uploads/2024/01/
     Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf>

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- remove -ENETDOWN as expected error value for get_mse_config() and
  get_mse_snapshot()
- fix htmldocs builds
---
 Documentation/netlink/specs/ethtool.yaml      |  78 ++++++++++++
 include/linux/phy.h                           | 115 ++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  54 ++++++++
 3 files changed, 247 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 13d8dcfa8dc5..969477f50d84 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -211,6 +211,84 @@ definitions:
         name: discard
         value: 31
 
+  -
+    name: phy-mse-capability
+    doc: |
+      Bitmask flags for MSE capabilities.
+
+      These flags are used in the 'supported_caps' field of struct
+      phy_mse_config to indicate which measurement capabilities are supported
+      by the PHY hardware.
+    type: flags
+    name-prefix: phy-mse-cap-
+    entries:
+      -
+        name: avg
+        doc: Average MSE value is supported.
+      -
+        name: peak
+        doc: Current peak MSE value is supported.
+      -
+        name: worst-peak
+        doc: Worst-case peak MSE (latched high-water mark) is supported.
+      -
+        name: channel-a
+        doc: Diagnostics for Channel A are supported.
+      -
+        name: channel-b
+        doc: Diagnostics for Channel B are supported.
+      -
+        name: channel-c
+        doc: Diagnostics for Channel C are supported.
+      -
+        name: channel-d
+        doc: Diagnostics for Channel D are supported.
+      -
+        name: worst-channel
+        doc: |
+          Hardware or drivers can identify the single worst-performing channel
+          without needing to query each one individually.
+      -
+        name: link
+        doc: |
+          Hardware provides only a link-wide aggregate MSE or cannot map
+          the measurement to a specific channel/pair. Typical for media where
+          the MDI/MDI-X resolution or pair mapping is unknown (e.g. 100BASE-TX).
+
+  -
+    name: phy-mse-channel
+    doc: |
+      Identifiers for the 'channel' parameter used to select which diagnostic
+      data to retrieve.
+    type: enum
+    name-prefix: phy-mse-channel-
+    entries:
+      -
+        name: a
+        value: 0
+        doc: Request data for channel A.
+      -
+        name: b
+        doc: Request data for channel B.
+      -
+        name: c
+        doc: Request data for channel C.
+      -
+        name: d
+        doc: Request data for channel D.
+      -
+        name: link
+        doc: |
+          Request data for the link as a whole. Use when the PHY exposes only
+          a link-wide aggregate MSE or cannot attribute results to any single
+          channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+      -
+        name: worst
+        doc: |
+          Request data for the single worst-performing channel. This is a
+          convenience for PHYs or drivers that can identify the worst channel
+          in hardware.
+
 attribute-sets:
   -
     name: header
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419adc3..4824ac9db08c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -898,6 +898,74 @@ struct phy_led {
 
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
+/**
+ * struct phy_mse_config - Configuration for Mean Square Error (MSE) measurement
+ *
+ * Describes the MSE measurement capabilities for the current link mode. These
+ * properties are dynamic and may change when link settings are modified.
+ * Callers should re-query this configuration after any link state change to
+ * ensure they have the most up-to-date information.
+ *
+ * Callers should only request measurements for channels and types that are
+ * indicated as supported by the @supported_caps bitmask. If @supported_caps
+ * is 0, the device provides no MSE diagnostics, and driver operations should
+ * typically return -EOPNOTSUPP.
+ *
+ * Snapshot values for average and peak MSE can be normalized to a 0..1 ratio
+ * by dividing the raw snapshot by the corresponding @max_average_mse or
+ * @max_peak_mse value.
+ *
+ * @max_average_mse: The maximum value for an average MSE snapshot. This
+ *   defines the scale for the measurement. If the PHY_MSE_CAP_AVG capability is
+ *   supported, this value MUST be greater than 0.
+ * @max_peak_mse: The maximum value for a peak MSE snapshot. If either
+ *   PHY_MSE_CAP_PEAK or PHY_MSE_CAP_WORST_PEAK is supported, this value MUST
+ *   be greater than 0.
+ * @refresh_rate_ps: The typical interval, in picoseconds, between hardware
+ *   updates of the MSE values. This is an estimate, and callers should not
+ *   assume synchronous sampling.
+ * @num_symbols: The number of symbols aggregated per hardware sample to
+ *   calculate the MSE.
+ * @supported_caps: A bitmask of PHY_MSE_CAP_* values indicating which
+ *   measurement types (e.g., average, peak) and channels
+ *   (e.g., per-pair or link-wide) are supported.
+ */
+struct phy_mse_config {
+	u32 max_average_mse;
+	u32 max_peak_mse;
+	u64 refresh_rate_ps;
+	u64 num_symbols;
+	u32 supported_caps;
+};
+
+/**
+ * struct phy_mse_snapshot - A snapshot of Mean Square Error (MSE) diagnostics
+ *
+ * Holds a set of MSE diagnostic values that were all captured from a single
+ * measurement window.
+ *
+ * The @channel field is an input parameter specified by the caller. Drivers
+ * must validate the requested channel against the capabilities returned by
+ * get_mse_config(). If an unsupported channel is requested, the driver must
+ * return -EOPNOTSUPP and must not coerce the request to a different channel
+ * (e.g., changing a per-channel request to a link-wide one).
+ *
+ * @channel: Input: The requested channel for the measurement, which must
+ *   be one of the PHY_MSE_CHANNEL_* constants.
+ * @average_mse: The average MSE value over the measurement window.
+ * @peak_mse: The peak MSE value observed within the measurement window.
+ * @worst_peak_mse: A latched high-water mark of the peak MSE. This value
+ *   represents the worst (highest) peak seen since this field
+ *   was last read. It MUST be cleared by the driver or hardware
+ *   upon reading (i.e., it has read-to-clear semantics).
+ */
+struct phy_mse_snapshot {
+	u32 channel;
+	u32 average_mse;
+	u32 peak_mse;
+	u32 worst_peak_mse;
+};
+
 /**
  * struct phy_driver - Driver structure for a particular PHY type
  *
@@ -1179,6 +1247,53 @@ struct phy_driver {
 	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
 
+	/**
+	 * @get_mse_config: Get configuration and scale of MSE measurement
+	 * @dev:    PHY device
+	 * @config: Output (filled on success)
+	 *
+	 * Fill @config with the PHY's MSE configuration for the current
+	 * link mode: scale limits (max_average_mse, max_peak_mse), update
+	 * interval (refresh_rate_ps), sample length (num_symbols) and the
+	 * capability bitmask (supported_caps).
+	 *
+	 * Implementations may defer configuration until hardware has
+	 * converged; in that case they should return -EAGAIN and allow the
+	 * caller to retry later.
+	 *
+	 * Return: 0 on success. On failure, returns a negative errno code, such
+	 * as -EOPNOTSUPP if MSE measurement is not supported by the PHY or in
+	 * the current link mode, or -EAGAIN if the configuration is not yet
+	 * available.
+	 */
+	int (*get_mse_config)(struct phy_device *dev,
+			      struct phy_mse_config *config);
+
+	/**
+	 * @get_mse_snapshot: Retrieve a snapshot of MSE diagnostic values
+	 * @dev:      PHY device
+	 * @channel:  Channel identifier (PHY_MSE_CHANNEL_*)
+	 * @snapshot: Output (filled on success)
+	 *
+	 * Fill @snapshot with a correlated set of MSE values from the most
+	 * recent measurement window.
+	 *
+	 * Callers must validate @channel against supported_caps returned by
+	 * get_mse_config(). Drivers must not coerce @channel; if the requested
+	 * selector is not implemented by the device or current link mode,
+	 * the operation must fail.
+	 *
+	 * On success, @snapshot->channel MUST equal the requested @channel.
+	 * worst_peak_mse is latched and must be treated as read-to-clear.
+	 *
+	 * Return: 0 on success. On failure, returns a negative errno code, such
+	 * as -EOPNOTSUPP if MSE measurement is not supported by the PHY or in
+	 * the current link mode, or -EAGAIN if the configuration is not yet
+	 * available.
+	 */
+	int (*get_mse_snapshot)(struct phy_device *dev, u32 channel,
+				struct phy_mse_snapshot *snapshot);
+
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
 	int (*get_plca_cfg)(struct phy_device *dev,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 0af7b90101c1..d36faf5f20f4 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -77,6 +77,60 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/**
+ * enum ethtool_phy_mse_capability - Bitmask flags for MSE capabilities. These
+ *   flags are used in the 'supported_caps' field of struct phy_mse_config to
+ *   indicate which measurement capabilities are supported by the PHY hardware.
+ * @PHY_MSE_CAP_AVG: Average MSE value is supported.
+ * @PHY_MSE_CAP_PEAK: Current peak MSE value is supported.
+ * @PHY_MSE_CAP_WORST_PEAK: Worst-case peak MSE (latched high-water mark) is
+ *   supported.
+ * @PHY_MSE_CAP_CHANNEL_A: Diagnostics for Channel A are supported.
+ * @PHY_MSE_CAP_CHANNEL_B: Diagnostics for Channel B are supported.
+ * @PHY_MSE_CAP_CHANNEL_C: Diagnostics for Channel C are supported.
+ * @PHY_MSE_CAP_CHANNEL_D: Diagnostics for Channel D are supported.
+ * @PHY_MSE_CAP_WORST_CHANNEL: Hardware or drivers can identify the single
+ *   worst-performing channel without needing to query each one individually.
+ * @PHY_MSE_CAP_LINK: Hardware provides only a link-wide aggregate MSE or
+ *   cannot map the measurement to a specific channel/pair. Typical for media
+ *   where the MDI/MDI-X resolution or pair mapping is unknown (e.g.
+ *   100BASE-TX).
+ */
+enum ethtool_phy_mse_capability {
+	PHY_MSE_CAP_AVG = 1,
+	PHY_MSE_CAP_PEAK = 2,
+	PHY_MSE_CAP_WORST_PEAK = 4,
+	PHY_MSE_CAP_CHANNEL_A = 8,
+	PHY_MSE_CAP_CHANNEL_B = 16,
+	PHY_MSE_CAP_CHANNEL_C = 32,
+	PHY_MSE_CAP_CHANNEL_D = 64,
+	PHY_MSE_CAP_WORST_CHANNEL = 128,
+	PHY_MSE_CAP_LINK = 256,
+};
+
+/**
+ * enum ethtool_phy_mse_channel - Identifiers for the 'channel' parameter used
+ *   to select which diagnostic data to retrieve.
+ * @PHY_MSE_CHANNEL_A: Request data for channel A.
+ * @PHY_MSE_CHANNEL_B: Request data for channel B.
+ * @PHY_MSE_CHANNEL_C: Request data for channel C.
+ * @PHY_MSE_CHANNEL_D: Request data for channel D.
+ * @PHY_MSE_CHANNEL_LINK: Request data for the link as a whole. Use when the
+ *   PHY exposes only a link-wide aggregate MSE or cannot attribute results to
+ *   any single channel/pair (e.g. 100BASE-TX with unknown MDI/MDI-X mapping).
+ * @PHY_MSE_CHANNEL_WORST: Request data for the single worst-performing
+ *   channel. This is a convenience for PHYs or drivers that can identify the
+ *   worst channel in hardware.
+ */
+enum ethtool_phy_mse_channel {
+	PHY_MSE_CHANNEL_A,
+	PHY_MSE_CHANNEL_B,
+	PHY_MSE_CHANNEL_C,
+	PHY_MSE_CHANNEL_D,
+	PHY_MSE_CHANNEL_LINK,
+	PHY_MSE_CHANNEL_WORST,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
-- 
2.47.3


