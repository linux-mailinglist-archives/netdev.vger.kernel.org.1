Return-Path: <netdev+bounces-289557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKbqCSShDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA558341D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EC3F300A503
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE95343884;
	Tue, 19 May 2026 17:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E134388D;
	Tue, 19 May 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212377; cv=none; b=M9egEe9/su24QZliTk4Yn5FwglKaPTFDq6kpR8yafGdHxuPGlmeTMpnVvlNT2BBP977I4Z8s4quHTgWizWCSG7+ak+7q2e2iS9AYdT+coPK6F1YQuZoE5WnlRE3FapOYySrUE6g/7tJZQV5ag148vHuqwc9vbYogyy3msZuCjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212377; c=relaxed/simple;
	bh=es4WBaWaKuPWr8PRkzEli5klze8Y1SRaMJT36sbcJF8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpN6LT0Hpi8UDH3vEDKAFT+zsHojEF5V3QNKVeYTj8vpnY5zW+SuaGMXE/skjdV7zBQZq1FR33UB88qE6Yj4dRF/oktgDAgyEFLBm+FIr2e8sk2URSBtb5Im8q5DRAysZ5C9Ds1JOCVH8CBbquDgzqAv0Cw7pIlkya+eqjdAduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOPk-000000001fa-25kO;
	Tue, 19 May 2026 17:39:32 +0000
Date: Tue, 19 May 2026 18:39:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 5/5] net: dsa: mxl862xx: add SerDes ethtool
 statistics
Message-ID: <5e8391488f4dbf23133d16ceaf1b168b39304c97.1779203863.git.daniel@makrotopia.org>
References: <cover.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779203863.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 95DA558341D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose SerDes equalization and signal detect parameters as ethtool
statistics on ports 9-16 (XPCS-backed ports). Uses the XPCS EQ_GET
and SIGNAL_DETECT firmware commands to read TX/RX equalization
coefficients, DFE taps, and link-level signal status.

The 19 additional stats (serdes_tx_*, serdes_rx_*, serdes_pma_link,
serdes_link_fault, serdes_in_reset) are appended after the standard
RMON counters and gated on firmware >= 1.0.84.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 90 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |  2 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 93 +++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |  3 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  6 +-
 5 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index 6e332c99b245..4cd5d3f0b266 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -1668,4 +1668,94 @@ struct mxl862xx_xpcs_reset_cfg {
 	__le16 result;
 } __packed;
 
+/**
+ * struct mxl862xx_xpcs_eq_item - single equalization parameter
+ * @value: current initial value
+ * @ovrd: override value
+ * @ovrd_en: override enable flag
+ */
+struct mxl862xx_xpcs_eq_item {
+	u8 value;
+	u8 ovrd;
+	u8 ovrd_en;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_tx_eq_info - TX equalization status
+ * @main: TX main cursor (0-63)
+ * @pre: TX pre-cursor (0-63)
+ * @post: TX post-cursor (0-63)
+ * @iboost_lvl: TX iboost level (0-15)
+ * @vboost_lvl: TX vboost level (0-7)
+ * @vboost_en: TX vboost enable (0-1)
+ */
+struct mxl862xx_xpcs_tx_eq_info {
+	struct mxl862xx_xpcs_eq_item main;
+	struct mxl862xx_xpcs_eq_item pre;
+	struct mxl862xx_xpcs_eq_item post;
+	struct mxl862xx_xpcs_eq_item iboost_lvl;
+	struct mxl862xx_xpcs_eq_item vboost_lvl;
+	struct mxl862xx_xpcs_eq_item vboost_en;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_rx_eq_info - RX equalization status
+ * @att_lvl: RX attenuation level (0-7)
+ * @vga1_gain: RX VGA1 gain (0-7)
+ * @vga2_gain: RX VGA2 gain (0-7)
+ * @ctle_boost: RX CTLE boost (0-31)
+ * @ctle_pole: RX CTLE pole (0-3)
+ * @dfe_tap1: RX DFE tap1 (0-255)
+ * @dfe_bypass: RX DFE bypass (0-1)
+ * @adapt_mode: RX adapt mode (0-3)
+ * @adapt_sel: RX adapt select (0-1)
+ */
+struct mxl862xx_xpcs_rx_eq_info {
+	struct mxl862xx_xpcs_eq_item att_lvl;
+	struct mxl862xx_xpcs_eq_item vga1_gain;
+	struct mxl862xx_xpcs_eq_item vga2_gain;
+	struct mxl862xx_xpcs_eq_item ctle_boost;
+	struct mxl862xx_xpcs_eq_item ctle_pole;
+	struct mxl862xx_xpcs_eq_item dfe_tap1;
+	struct mxl862xx_xpcs_eq_item dfe_bypass;
+	struct mxl862xx_xpcs_eq_item adapt_mode;
+	struct mxl862xx_xpcs_eq_item adapt_sel;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_eq_get - EQ get request/response
+ * @port_id: XPCS port index (0 or 1)
+ * @result: firmware result
+ * @tx: TX equalization info
+ * @rx: RX equalization info
+ */
+struct mxl862xx_xpcs_eq_get {
+	u8 port_id;
+	__le16 result;
+	struct mxl862xx_xpcs_tx_eq_info tx;
+	struct mxl862xx_xpcs_rx_eq_info rx;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_signal_detect - signal detect status
+ * @port_id: XPCS port index (0 or 1)
+ * @rx_signal: RX signal detected
+ * @pma_link: PMA link up
+ * @link_fault: PCS link fault
+ * @in_reset: XPCS in reset
+ * @__rsv: reserved
+ * @__pad: padding
+ * @result: firmware result
+ */
+struct mxl862xx_xpcs_signal_detect {
+	u8 port_id:2;
+	u8 rx_signal:1;
+	u8 pma_link:1;
+	u8 link_fault:1;
+	u8 in_reset:1;
+	u8 __rsv:2;
+	u8 __pad;
+	__le16 result;
+} __packed;
+
 #endif /* __MXL862XX_API_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index c87a955c13c4..f6fa32bac5d8 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -79,6 +79,8 @@
 #define MXL862XX_XPCS_PCS_LINK_UP	(MXL862XX_XPCS_MAGIC + 0x7)
 #define MXL862XX_XPCS_LOOPBACK		(MXL862XX_XPCS_MAGIC + 0x8)
 #define MXL862XX_XPCS_RESET		(MXL862XX_XPCS_MAGIC + 0x9)
+#define MXL862XX_XPCS_EQ_GET		(MXL862XX_XPCS_MAGIC + 0xc)
+#define MXL862XX_XPCS_SIGNAL_DETECT	(MXL862XX_XPCS_MAGIC + 0xd)
 
 #define MMD_API_MAXIMUM_ID		0x7fff
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
index f99c69984357..c5ee07a444e9 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -351,3 +351,96 @@ const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
 	.mac_link_up = mxl862xx_phylink_mac_link_up,
 	.mac_select_pcs = mxl862xx_phylink_mac_select_pcs,
 };
+
+/* --- SerDes ethtool statistics --- */
+
+static const char mxl862xx_serdes_stats[][ETH_GSTRING_LEN] = {
+	"serdes_tx_main",
+	"serdes_tx_pre",
+	"serdes_tx_post",
+	"serdes_tx_iboost",
+	"serdes_tx_vboost",
+	"serdes_tx_vboost_en",
+	"serdes_rx_att",
+	"serdes_rx_vga1",
+	"serdes_rx_vga2",
+	"serdes_rx_ctle_boost",
+	"serdes_rx_ctle_pole",
+	"serdes_rx_dfe_tap1",
+	"serdes_rx_dfe_bypass",
+	"serdes_rx_adapt_mode",
+	"serdes_rx_adapt_sel",
+	"serdes_rx_signal",
+	"serdes_pma_link",
+	"serdes_link_fault",
+	"serdes_in_reset",
+};
+
+static bool mxl862xx_port_has_serdes_stats(struct dsa_switch *ds, int port)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	return port >= 9 && port <= 16 &&
+	       MXL862XX_FW_VER_MIN(priv, 1, 0, 84);
+}
+
+int mxl862xx_serdes_stats_count(struct dsa_switch *ds, int port)
+{
+	if (mxl862xx_port_has_serdes_stats(ds, port))
+		return ARRAY_SIZE(mxl862xx_serdes_stats);
+
+	return 0;
+}
+
+void mxl862xx_serdes_get_strings(struct dsa_switch *ds, int port, u8 *data)
+{
+	int i;
+
+	if (!mxl862xx_port_has_serdes_stats(ds, port))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mxl862xx_serdes_stats); i++)
+		ethtool_puts(&data, mxl862xx_serdes_stats[i]);
+}
+
+void mxl862xx_serdes_get_stats(struct dsa_switch *ds, int port, u64 *data)
+{
+	struct mxl862xx_xpcs_eq_get eq = {
+		.port_id = MXL862XX_SERDES_PORT_ID(port),
+	};
+	struct mxl862xx_xpcs_signal_detect sig = {};
+
+	if (!mxl862xx_port_has_serdes_stats(ds, port))
+		return;
+
+	sig.port_id = MXL862XX_SERDES_PORT_ID(port);
+
+	if (!MXL862XX_API_READ(ds->priv, MXL862XX_XPCS_EQ_GET, eq)) {
+		*data++ = eq.tx.main.value;
+		*data++ = eq.tx.pre.value;
+		*data++ = eq.tx.post.value;
+		*data++ = eq.tx.iboost_lvl.value;
+		*data++ = eq.tx.vboost_lvl.value;
+		*data++ = eq.tx.vboost_en.value;
+		*data++ = eq.rx.att_lvl.value;
+		*data++ = eq.rx.vga1_gain.value;
+		*data++ = eq.rx.vga2_gain.value;
+		*data++ = eq.rx.ctle_boost.value;
+		*data++ = eq.rx.ctle_pole.value;
+		*data++ = eq.rx.dfe_tap1.value;
+		*data++ = eq.rx.dfe_bypass.value;
+		*data++ = eq.rx.adapt_mode.value;
+		*data++ = eq.rx.adapt_sel.value;
+	} else {
+		data += 15;
+	}
+
+	if (!MXL862XX_API_READ(ds->priv, MXL862XX_XPCS_SIGNAL_DETECT, sig)) {
+		*data++ = sig.rx_signal;
+		*data++ = sig.pma_link;
+		*data++ = sig.link_fault;
+		*data++ = sig.in_reset;
+	} else {
+		data += 4;
+	}
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
index 54a4c652ec5a..82cc3817adc1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
@@ -20,5 +20,8 @@ void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 			       struct phylink_config *config);
 void mxl862xx_setup_pcs(struct mxl862xx_priv *priv, struct mxl862xx_pcs *pcs,
 			int port);
+int mxl862xx_serdes_stats_count(struct dsa_switch *ds, int port);
+void mxl862xx_serdes_get_strings(struct dsa_switch *ds, int port, u8 *data);
+void mxl862xx_serdes_get_stats(struct dsa_switch *ds, int port, u64 *data);
 
 #endif /* __MXL862XX_PHYLINK_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 0af41efccbc6..a18e42b9cd6b 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -1776,6 +1776,8 @@ static void mxl862xx_get_strings(struct dsa_switch *ds, int port,
 
 	for (i = 0; i < ARRAY_SIZE(mxl862xx_mib); i++)
 		ethtool_puts(&data, mxl862xx_mib[i].name);
+
+	mxl862xx_serdes_get_strings(ds, port, data);
 }
 
 static int mxl862xx_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -1783,7 +1785,7 @@ static int mxl862xx_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	if (sset != ETH_SS_STATS)
 		return 0;
 
-	return ARRAY_SIZE(mxl862xx_mib);
+	return ARRAY_SIZE(mxl862xx_mib) + mxl862xx_serdes_stats_count(ds, port);
 }
 
 static int mxl862xx_read_rmon(struct dsa_switch *ds, int port,
@@ -1819,6 +1821,8 @@ static void mxl862xx_get_ethtool_stats(struct dsa_switch *ds, int port,
 		else
 			*data++ = le64_to_cpu(*(__le64 *)field);
 	}
+
+	mxl862xx_serdes_get_stats(ds, port, data);
 }
 
 static void mxl862xx_get_eth_mac_stats(struct dsa_switch *ds, int port,
-- 
2.54.0

