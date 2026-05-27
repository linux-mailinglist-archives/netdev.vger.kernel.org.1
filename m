Return-Path: <netdev+bounces-292079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMbTOEVcFmpTlwcAu9opvQ
	(envelope-from <netdev+bounces-292079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99E5DEB99
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3291E300CC14
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD13033DF;
	Wed, 27 May 2026 02:48:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3B24A069;
	Wed, 27 May 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850132; cv=none; b=VkQNHvA76te7L/QhuQYVqeceaPPB6QKz72XPnsQoWAuKakWpp0U8+RtYj/0E+HiqteT9XtfhyEmNKGOClPK5+WTFSdIrL+U+nLvef7zNYqoqLblnBZNPDao6n+sKoCMzXkBPHJH9/cV6wPy2oyc/ygoKXLhETjzNWmrM/qQT7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850132; c=relaxed/simple;
	bh=1FVTGt+iHwwCACZllNuEtT03SMbmnbt1kvGDm7uscgU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inxNbUCIuCdY+qZ5wVZ/Q0CR7HoqzbIcWc7N1mNxrLVcUzsQS+65JZM8eXJ37IuHgTh5mzBJekM0M+pSA6ALozPQSYvUC7UuDQrDPCKOVsXGQ5q76wyanPhXRpbv/15btIwR1xsCjTChoWK6TO/PaBR8S89UgSAIrimsdAZGvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wS4K6-000000006zQ-3Jeu;
	Wed, 27 May 2026 02:48:46 +0000
Date: Wed, 27 May 2026 03:48:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: dsa: mxl862xx: add support for SerDes
 ports
Message-ID: <3d738c7bf198f9c3ea84e1edf551d6d9a1a647ce.1779849840.git.daniel@makrotopia.org>
References: <cover.1779849840.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779849840.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292079-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[phrozen.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.link:url,makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E99E5DEB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MxL862xx has two XPCS/SerDes interfaces (XPCS0 for ports 9-12,
XPCS1 for ports 13-16). Each can operate in various single-lane modes
(SGMII, 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, USXGMII) or as
QSGMII or 10G_QXGMII providing four sub-ports per interface.

Implement phylink PCS operations using the firmware's XPCS API:

  - pcs_config: configure negotiation mode and CL37/SGMII advertising.
  - pcs_get_state: read link state and the link-partner ability word
    from firmware and decode using phylink's standard CL37, SGMII, and
    USXGMII decoders.
  - pcs_an_restart: restart CL37 or CL73 auto-negotiation.
  - pcs_link_up: force speed/duplex for SGMII.
  - pcs_inband_caps: report per-mode in-band status capabilities.

Register a PCS instance for each SerDes interface and
QSGMII/10G_QXGMII sub-ports during setup. Advertise the supported
interface modes in phylink_get_caps based on port number.

Lacking support for expressing PHY-side role modes in Linux only the
MAC-side of SGMII, QSGMII, USXGMII and 10G_QXGMII are implemented for
now.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:

v2:
 * add __{LE,BE}_BITFIELD layouts to ABI structs
 * per-sub-port QSGMII AN restart via usx_subport / usx_lane_mode
 * shared-SerDes refcount in pcs_disable via per-XPCS slot bitmap
 * let every sub-port call pcs_config
 * cache phy_interface_t instead of firmware type
 * skip pcs_link_up when inband-AN enabled
 * gate phylink_get_caps SerDes modes on same FW version as select_pcs
 * interpret xpcs_pcs_cfg.result as signed (s16)
 * drop dead MXL862XX_PCS_PORT macro
 * drop misleading "downshift detection" line from commit message

 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 302 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |   9 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 358 +++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |   7 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         |   6 +-
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  31 ++
 6 files changed, 710 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index fb21ddc1bf1c..aef1a2f702b5 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -1366,4 +1366,306 @@ struct mxl862xx_rmon_port_cnt {
 	__le64 tx_good_bytes;
 } __packed;
 
+/**
+ * enum mxl862xx_xpcs_if_mode - XPCS interface mode
+ * @MXL862XX_XPCS_IF_SGMII: SGMII
+ * @MXL862XX_XPCS_IF_1000BASEX: 1000BASE-X
+ * @MXL862XX_XPCS_IF_2500BASEX: 2500BASE-X
+ * @MXL862XX_XPCS_IF_USXGMII: USXGMII (single or quad)
+ * @MXL862XX_XPCS_IF_10GBASER: 10GBASE-R
+ * @MXL862XX_XPCS_IF_10GKR: 10GBASE-KR
+ * @MXL862XX_XPCS_IF_5GBASER: 5GBASE-R
+ * @MXL862XX_XPCS_IF_QSGMII: QSGMII
+ */
+enum mxl862xx_xpcs_if_mode {
+	MXL862XX_XPCS_IF_SGMII = 0,
+	MXL862XX_XPCS_IF_1000BASEX = 1,
+	MXL862XX_XPCS_IF_2500BASEX = 2,
+	MXL862XX_XPCS_IF_USXGMII = 3,
+	MXL862XX_XPCS_IF_10GBASER = 4,
+	MXL862XX_XPCS_IF_10GKR = 5,
+	MXL862XX_XPCS_IF_5GBASER = 6,
+	MXL862XX_XPCS_IF_QSGMII = 7,
+};
+
+/**
+ * enum mxl862xx_xpcs_neg_mode - PCS negotiation mode
+ * @MXL862XX_XPCS_NEG_NONE: no inband negotiation
+ * @MXL862XX_XPCS_NEG_INBAND_AN_OFF: inband selected but AN disabled
+ * @MXL862XX_XPCS_NEG_INBAND_AN_ON: inband with AN enabled
+ */
+enum mxl862xx_xpcs_neg_mode {
+	MXL862XX_XPCS_NEG_NONE = 0,
+	MXL862XX_XPCS_NEG_INBAND_AN_OFF = 1,
+	MXL862XX_XPCS_NEG_INBAND_AN_ON = 2,
+};
+
+/**
+ * enum mxl862xx_xpcs_role - PCS protocol role
+ * @MXL862XX_XPCS_ROLE_MAC: local end is MAC side (TX_CONFIG = 0)
+ * @MXL862XX_XPCS_ROLE_PHY: local end is PHY side (TX_CONFIG = 1)
+ *
+ * Selects the role the XPCS plays in protocols that have an asymmetric
+ * AN code word (Cisco SGMII / QSGMII / USXGMII). Drives
+ * VR_MII_AN_CTRL.TX_CONFIG: 0 means the local end receives the partner's
+ * AN word, 1 means it sources one. Ignored for symmetric protocols
+ * (1000BASE-X, 2500BASE-X, 10GBASE-R/KR).
+ */
+enum mxl862xx_xpcs_role {
+	MXL862XX_XPCS_ROLE_MAC = 0,
+	MXL862XX_XPCS_ROLE_PHY = 1,
+};
+
+/**
+ * enum mxl862xx_xpcs_usx_lane_mode - USXGMII lane mode
+ * @MXL862XX_XPCS_USX_SINGLE: single USXGMII lane
+ * @MXL862XX_XPCS_USX_QUAD: quad USXGMII (4 ports per lane)
+ */
+enum mxl862xx_xpcs_usx_lane_mode {
+	MXL862XX_XPCS_USX_SINGLE = 0,
+	MXL862XX_XPCS_USX_QUAD = 1,
+};
+
+/**
+ * union mxl862xx_xpcs_an_word - XPCS AN code word, tagged by interface mode
+ * @cl37: 16-bit base-page word exchanged over the CL37 hardware AN path
+ *        (SR_MII_AN_ADV on write, SR_MII_LP_BABL on read). Carries the
+ *        802.3 CL37 base page for 1000BASE-X/2500BASE-X and the Cisco
+ *        SGMII config word for SGMII/QSGMII.
+ * @usx: USXGMII 16-bit AN code word, MDIO_USXGMII_* layout
+ * @cl73: CL73 48-bit base page (10GBASE-KR), three 16-bit registers per
+ *        802.3 Annex 28C
+ * @cl73.adv1: CL73 SR_AN_ADV1 / SR_AN_LP_ABL1
+ * @cl73.adv2: CL73 SR_AN_ADV2 / SR_AN_LP_ABL2
+ * @cl73.adv3: CL73 SR_AN_ADV3 / SR_AN_LP_ABL3
+ *
+ * The host picks the right member based on the interface field of the
+ * surrounding struct (and, for the asymmetric protocols, on the role).
+ */
+union mxl862xx_xpcs_an_word {
+	__le16 cl37;
+	__le16 usx;
+	struct {
+		__le16 adv1;
+		__le16 adv2;
+		__le16 adv3;
+	} cl73;
+} __packed;
+
+/**
+ * enum mxl862xx_xpcs_duplex - PCS duplex mode
+ * @MXL862XX_XPCS_DUPLEX_HALF: half duplex
+ * @MXL862XX_XPCS_DUPLEX_FULL: full duplex
+ */
+enum mxl862xx_xpcs_duplex {
+	MXL862XX_XPCS_DUPLEX_HALF = 0,
+	MXL862XX_XPCS_DUPLEX_FULL = 1,
+};
+
+/**
+ * enum mxl862xx_xpcs_loopback_mode - XPCS loopback mode
+ * @MXL862XX_XPCS_LB_DISABLE: disable all loopback
+ * @MXL862XX_XPCS_LB_PCS_SERIAL: PCS TX-to-RX serial loopback
+ * @MXL862XX_XPCS_LB_PCS_PARALLEL: PCS RX-to-TX parallel loopback
+ * @MXL862XX_XPCS_LB_PMA_SERIAL: PMA TX-to-RX serial loopback
+ * @MXL862XX_XPCS_LB_PMA_PARALLEL: PMA RX-to-TX parallel loopback
+ */
+enum mxl862xx_xpcs_loopback_mode {
+	MXL862XX_XPCS_LB_DISABLE = 0,
+	MXL862XX_XPCS_LB_PCS_SERIAL = 1,
+	MXL862XX_XPCS_LB_PCS_PARALLEL = 2,
+	MXL862XX_XPCS_LB_PMA_SERIAL = 3,
+	MXL862XX_XPCS_LB_PMA_PARALLEL = 4,
+};
+
+/**
+ * struct mxl862xx_xpcs_pcs_cfg - PCS configuration parameters
+ * @port_id: XPCS port index (0-3)
+ * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
+ * @neg_mode: PCS negotiation mode. See &enum mxl862xx_xpcs_neg_mode
+ * @permit_pause: Allow pause to MAC
+ * @usx_lane_mode: USXGMII lane mode.
+ *                 See &enum mxl862xx_xpcs_usx_lane_mode
+ * @role: PCS protocol role. See &enum mxl862xx_xpcs_role
+ * @usx_subport: Sub-port (0-3) within the XPCS. Used by the firmware
+ *               to set MAC pause per sub-port; ignored for the
+ *               XPCS-wide bringup, which is idempotent across slots.
+ * @advertising: AN code word the local end transmits. The active union
+ *               member is selected by @interface (and, for the asymmetric
+ *               protocols, by @role). Ignored when the local end does
+ *               not transmit an AN word (role=MAC for SGMII/QSGMII/
+ *               USXGMII, 10GBASE-R, 5GBASE-R) or when @neg_mode is not
+ *               INBAND_AN_ON. Pass all-zero to keep the firmware default
+ *               advertisement.
+ * @result: Firmware result. >0 means the host must follow with an AN
+ *          restart, 0 means no host follow-up is needed, <0 is an errno.
+ */
+struct mxl862xx_xpcs_pcs_cfg {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u8 port_id:2;
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
+	u8 permit_pause:1;
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 role:1; /* enum mxl862xx_xpcs_role */
+	u8 usx_subport:2;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 port_id:2;
+	u8 usx_subport:2;
+	u8 role:1; /* enum mxl862xx_xpcs_role */
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 permit_pause:1;
+	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
+#else
+#error "Unknown bitfield endianness"
+#endif
+	union mxl862xx_xpcs_an_word advertising;
+	__le16 result;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_pcs_state - PCS link state
+ * @port_id: XPCS port index (0-3) (input)
+ * @interface: PCS interface mode (input).
+ *             See &enum mxl862xx_xpcs_if_mode
+ * @usx_lane_mode: USX lane mode (input)
+ * @usx_subport: USX sub-port 0-3 (input)
+ * @link: Link up (1) / down (0) (output)
+ * @an_complete: Auto-negotiation complete (output)
+ * @duplex: Duplex mode (output). See &enum mxl862xx_xpcs_duplex
+ * @pcs_fault: PCS fault (output)
+ * @pause: Pause negotiation result, bit 0 symmetric, bit 1 asymmetric
+ *         (output)
+ * @lp_eee_cap: Link partner supports EEE (output)
+ * @lp_eee_cs_cap: Link partner supports EEE clock-stop (output)
+ * @__rsv: reserved
+ * @__pad: padding
+ * @speed: Resolved speed in Mbit/s (output)
+ * @lpa: Link partner ability word (output). Same union as
+ *       &union mxl862xx_xpcs_an_word; the host picks the member based on
+ *       @interface.
+ */
+struct mxl862xx_xpcs_pcs_state {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u8 port_id:2;
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 usx_subport:2;
+	u8 link:1;
+	u8 an_complete:1;
+	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
+	u8 pcs_fault:1;
+	u8 pause:2;
+	u8 lp_eee_cap:1;
+	u8 lp_eee_cs_cap:1;
+	u8 __rsv:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 port_id:2;
+	u8 pcs_fault:1;
+	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
+	u8 an_complete:1;
+	u8 link:1;
+	u8 usx_subport:2;
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 __rsv:4;
+	u8 lp_eee_cs_cap:1;
+	u8 lp_eee_cap:1;
+	u8 pause:2;
+#else
+#error "Unknown bitfield endianness"
+#endif
+	u8 __pad;
+	__le16 speed; /* Mbit/s */
+	union mxl862xx_xpcs_an_word lpa;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_pcs_disable - PCS disable parameters
+ * @port_id: XPCS port index
+ * @__pad: padding
+ * @result: Firmware result. 0 on success, <0 on error.
+ *
+ * Asserts IDDQ + PHY + XPCS resets to power down the SERDES when the
+ * port is admin-down or no module is plugged in. The next PCS config
+ * implicitly powers it back up and reprograms the desired interface.
+ */
+struct mxl862xx_xpcs_pcs_disable {
+	u8 port_id;
+	u8 __pad;
+	__le16 result;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_an_restart - AN restart parameters
+ * @port_id: XPCS port index (0-3)
+ * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
+ * @usx_lane_mode: USX lane mode
+ * @usx_subport: Sub-port (0-3) within the XPCS. Selects the lane
+ *               whose AN is restarted for QSGMII and QUSXGMII;
+ *               ignored by single-lane modes.
+ * @__rsv: reserved
+ * @result: Firmware result. 0 on success, <0 on error.
+ *
+ * Restarts auto-negotiation on a single sub-port of the XPCS. The
+ * SERDES must already be configured.
+ */
+struct mxl862xx_xpcs_an_restart {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u8 port_id:2;
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 usx_subport:2;
+	u8 __rsv:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 port_id:2;
+	u8 __rsv:4;
+	u8 usx_subport:2;
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+#else
+#error "Unknown bitfield endianness"
+#endif
+	__le16 result;
+} __packed;
+
+/**
+ * struct mxl862xx_xpcs_pcs_link_up - PCS link-up parameters
+ * @port_id: XPCS port index (0-3)
+ * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
+ * @duplex: Duplex mode. See &enum mxl862xx_xpcs_duplex
+ * @usx_lane_mode: USX lane mode (USXGMII only; ignored otherwise).
+ *                 See &enum mxl862xx_xpcs_usx_lane_mode
+ * @usx_subport: USX sub-port 0-3 (QUSXGMII only; ignored otherwise)
+ * @__rsv0: reserved
+ * @speed: Resolved speed in Mbit/s
+ * @result: Firmware result. 0 on success, <0 is errno.
+ *
+ * Called once per link-up event after the host has resolved the
+ * line-side speed/duplex (from the PHY's read_status, from a preceding
+ * PCS get-state, or from a fixed-link description).
+ */
+struct mxl862xx_xpcs_pcs_link_up {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u8 port_id:2;
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 usx_subport:2;
+	u8 __rsv0:3;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
+	u8 port_id:2;
+	u8 __rsv0:3;
+	u8 usx_subport:2;
+	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
+	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
+#else
+#error "Unknown bitfield endianness"
+#endif
+	__le16 speed; /* Mbit/s */
+	__le16 result;
+} __packed;
+
 #endif /* __MXL862XX_API_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index f1ea40aa7ea0..c87a955c13c4 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -24,6 +24,7 @@
 #define MXL862XX_SS_MAGIC		0x1600
 #define GPY_GPY2XX_MAGIC		0x1800
 #define SYS_MISC_MAGIC			0x1900
+#define MXL862XX_XPCS_MAGIC		0x1a00
 
 #define MXL862XX_COMMON_CFGGET		(MXL862XX_COMMON_MAGIC + 0x9)
 #define MXL862XX_COMMON_CFGSET		(MXL862XX_COMMON_MAGIC + 0xa)
@@ -71,6 +72,14 @@
 
 #define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
 
+#define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
+#define MXL862XX_XPCS_PCS_GET_STATE	(MXL862XX_XPCS_MAGIC + 0x2)
+#define MXL862XX_XPCS_PCS_DISABLE	(MXL862XX_XPCS_MAGIC + 0x4)
+#define MXL862XX_XPCS_AN_RESTART	(MXL862XX_XPCS_MAGIC + 0x5)
+#define MXL862XX_XPCS_PCS_LINK_UP	(MXL862XX_XPCS_MAGIC + 0x7)
+#define MXL862XX_XPCS_LOOPBACK		(MXL862XX_XPCS_MAGIC + 0x8)
+#define MXL862XX_XPCS_RESET		(MXL862XX_XPCS_MAGIC + 0x9)
+
 #define MMD_API_MAXIMUM_ID		0x7fff
 
 #endif /* __MXL862XX_CMD_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
index f17c429d1f1d..4656947b83e0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -7,20 +7,373 @@
  * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/phylink.h>
 #include <net/dsa.h>
 
 #include "mxl862xx.h"
+#include "mxl862xx-api.h"
+#include "mxl862xx-cmd.h"
+#include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
 void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 			       struct phylink_config *config)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
 				   MAC_100 | MAC_1000 | MAC_2500FD;
 
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  config->supported_interfaces);
+	switch (port) {
+	case 1 ... 8:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+	case 9:
+	case 13:
+		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
+			break;
+		__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GKR, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII, config->supported_interfaces);
+		fallthrough;
+	case 10 ... 12:
+	case 14 ... 16:
+		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
+			break;
+		__set_bit(PHY_INTERFACE_MODE_QSGMII, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, config->supported_interfaces);
+
+		break;
+	default:
+		break;
+	}
+
+	if (port == 9 || port == 13)
+		config->mac_capabilities |= MAC_10000FD | MAC_5000FD;
+}
+
+static struct mxl862xx_pcs *pcs_to_mxl862xx_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct mxl862xx_pcs, pcs);
+}
+
+static int mxl862xx_xpcs_if_mode(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		return MXL862XX_XPCS_IF_SGMII;
+	case PHY_INTERFACE_MODE_QSGMII:
+		return MXL862XX_XPCS_IF_QSGMII;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return MXL862XX_XPCS_IF_1000BASEX;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return MXL862XX_XPCS_IF_2500BASEX;
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return MXL862XX_XPCS_IF_USXGMII;
+	case PHY_INTERFACE_MODE_10GBASER:
+		return MXL862XX_XPCS_IF_10GBASER;
+	case PHY_INTERFACE_MODE_10GKR:
+		return MXL862XX_XPCS_IF_10GKR;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mxl862xx_xpcs_neg_mode(unsigned int neg_mode)
+{
+	if (!(neg_mode & PHYLINK_PCS_NEG_INBAND))
+		return MXL862XX_XPCS_NEG_NONE;
+	if (neg_mode & PHYLINK_PCS_NEG_ENABLED)
+		return MXL862XX_XPCS_NEG_INBAND_AN_ON;
+	return MXL862XX_XPCS_NEG_INBAND_AN_OFF;
+}
+
+static int mxl862xx_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+
+	/* Bringup is done idempotently by pcs_config; just account this
+	 * sub-port so pcs_disable powers the shared XPCS down only after
+	 * the last sub-port has been released.
+	 */
+	atomic_inc(&mpcs->priv->serdes_refcount[mpcs->serdes_id]);
+
+	return 0;
+}
+
+static void mxl862xx_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+	struct mxl862xx_xpcs_pcs_disable dis = {};
+	struct mxl862xx_priv *priv = mpcs->priv;
+
+	/* The SerDes is shared across QSGMII/QUSXGMII sub-ports; only
+	 * power it down once the last active sub-port goes away.
+	 */
+	if (!atomic_dec_and_test(&priv->serdes_refcount[mpcs->serdes_id]))
+		return;
+
+	dis.port_id = mpcs->serdes_id;
+
+	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_PCS_DISABLE, dis);
+}
+
+/* The XPCS firmware reports failures in the result field using its own
+ * libc errno values; ENOTSUP (134) in particular has no kernel errno.
+ * Translate the codes the firmware can actually return.
+ */
+static int mxl862xx_xpcs_errno(int result)
+{
+	switch (result) {
+	case -5:	/* firmware -EIO */
+		return -EIO;
+	case -134:	/* firmware -ENOTSUP */
+		return -EOPNOTSUPP;
+	default:	/* firmware -EINVAL and anything unexpected */
+		return -EINVAL;
+	}
+}
+
+static int mxl862xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			       phy_interface_t interface,
+			       const unsigned long *advertising,
+			       bool permit_pause_to_mac)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+	struct mxl862xx_priv *priv = mpcs->priv;
+	struct mxl862xx_xpcs_pcs_cfg cfg = {};
+	int if_mode, ret, adv;
+
+	if_mode = mxl862xx_xpcs_if_mode(interface);
+	if (if_mode < 0) {
+		dev_err(priv->ds->dev, "unsupported interface: %s\n",
+			phy_modes(interface));
+		return if_mode;
+	}
+
+	/* The XPCS bringup is per-instance and idempotent in the
+	 * firmware: every QSGMII/QUSXGMII sub-port may call pcs_config
+	 * and the firmware will skip the bringup if the requested mode
+	 * matches the cached one, then update MAC pause for the
+	 * sub-port indicated by @usx_subport.
+	 */
+	cfg.port_id = mpcs->serdes_id;
+	cfg.usx_subport = mpcs->slot;
+	cfg.usx_lane_mode = (interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
+			    MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
+	cfg.interface = if_mode;
+	cfg.neg_mode = mxl862xx_xpcs_neg_mode(neg_mode);
+	cfg.role = MXL862XX_XPCS_ROLE_MAC;
+	cfg.permit_pause = permit_pause_to_mac ? 1 : 0;
+
+	if (neg_mode & PHYLINK_PCS_NEG_INBAND) {
+		adv = phylink_mii_c22_pcs_encode_advertisement(interface,
+							       advertising);
+		if (adv >= 0)
+			cfg.advertising.cl37 = cpu_to_le16(adv);
+	}
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_CONFIG, cfg);
+	if (ret)
+		return ret;
+
+	ret = (s16)le16_to_cpu(cfg.result);
+	if (ret < 0)
+		return mxl862xx_xpcs_errno(ret);
+
+	mpcs->interface = interface;
+	return ret > 0 ? 1 : 0;
+}
+
+static void mxl862xx_pcs_get_state(struct phylink_pcs *pcs,
+				   unsigned int neg_mode,
+				   struct phylink_link_state *state)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+	struct mxl862xx_priv *priv = mpcs->priv;
+	struct mxl862xx_xpcs_pcs_state st = {};
+	int if_mode, ret;
+	u16 bmsr;
+
+	if_mode = mxl862xx_xpcs_if_mode(state->interface);
+	if (if_mode < 0)
+		return;
+
+	st.port_id = mpcs->serdes_id;
+	st.interface = if_mode;
+	st.usx_subport = mpcs->slot;
+	st.usx_lane_mode = (state->interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
+			   MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_GET_STATE, st);
+	if (ret)
+		return;
+
+	state->link = st.link && !st.pcs_fault;
+	state->an_complete = st.an_complete;
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		bmsr = (state->link ? BMSR_LSTATUS : 0) |
+		       (state->an_complete ? BMSR_ANEGCOMPLETE : 0);
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr,
+						 le16_to_cpu(st.lpa.cl37));
+		break;
+
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		if (state->link)
+			phylink_decode_usxgmii_word(state,
+						    le16_to_cpu(st.lpa.usx));
+		break;
+
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_10GKR:
+		if (state->link) {
+			state->speed = SPEED_10000;
+			state->duplex = DUPLEX_FULL;
+		}
+		break;
+
+	default:
+		state->link = false;
+		break;
+	}
+}
+
+static void mxl862xx_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+	struct mxl862xx_priv *priv = mpcs->priv;
+	struct mxl862xx_xpcs_an_restart an = {};
+	int if_mode;
+
+	if_mode = mxl862xx_xpcs_if_mode(mpcs->interface);
+	if (if_mode < 0)
+		return;
+
+	an.port_id = mpcs->serdes_id;
+	an.interface = if_mode;
+	an.usx_subport = mpcs->slot;
+	an.usx_lane_mode = (mpcs->interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
+			   MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
+
+	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_AN_RESTART, an);
+}
+
+static void mxl862xx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 phy_interface_t interface, int speed,
+				 int duplex)
+{
+	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
+	struct mxl862xx_xpcs_pcs_link_up lu = {};
+	struct mxl862xx_priv *priv = mpcs->priv;
+	int if_mode;
+
+	/* With inband-AN enabled (role=MAC), the XPCS auto-resolves
+	 * speed/duplex from the partner's AN word and the firmware
+	 * short-circuits link_up.  Skip the firmware round-trip, same
+	 * as pcs-mtk-lynxi.
+	 */
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		return;
+
+	if_mode = mxl862xx_xpcs_if_mode(interface);
+	if (if_mode < 0)
+		return;
+
+	lu.port_id = mpcs->serdes_id;
+	lu.interface = if_mode;
+	lu.usx_subport = mpcs->slot;
+	lu.usx_lane_mode = (interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
+			   MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
+	lu.duplex = (duplex == DUPLEX_FULL) ? MXL862XX_XPCS_DUPLEX_FULL :
+					      MXL862XX_XPCS_DUPLEX_HALF;
+	lu.speed = cpu_to_le16(speed);
+
+	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_PCS_LINK_UP, lu);
+}
+
+static unsigned int mxl862xx_pcs_inband_caps(struct phylink_pcs *pcs,
+					     phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+	case PHY_INTERFACE_MODE_10GKR:
+		return LINK_INBAND_ENABLE;
+	case PHY_INTERFACE_MODE_10GBASER:
+		return LINK_INBAND_DISABLE;
+	default:
+		return 0;
+	}
+}
+
+static const struct phylink_pcs_ops mxl862xx_pcs_ops = {
+	.pcs_enable = mxl862xx_pcs_enable,
+	.pcs_disable = mxl862xx_pcs_disable,
+	.pcs_config = mxl862xx_pcs_config,
+	.pcs_get_state = mxl862xx_pcs_get_state,
+	.pcs_an_restart = mxl862xx_pcs_an_restart,
+	.pcs_link_up = mxl862xx_pcs_link_up,
+	.pcs_inband_caps = mxl862xx_pcs_inband_caps,
+};
+
+void mxl862xx_setup_pcs(struct mxl862xx_priv *priv, struct mxl862xx_pcs *pcs,
+			int port)
+{
+	pcs->priv = priv;
+	pcs->serdes_id = MXL862XX_SERDES_PORT_ID(port);
+	pcs->slot = MXL862XX_SERDES_SLOT(port);
+	pcs->interface = PHY_INTERFACE_MODE_NA;
+
+	pcs->pcs.ops = &mxl862xx_pcs_ops;
+	pcs->pcs.poll = true;
+
+	__set_bit(PHY_INTERFACE_MODE_QSGMII, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, pcs->pcs.supported_interfaces);
+	if (pcs->slot != 0)
+		return;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_10GBASER, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_10GKR, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII, pcs->pcs.supported_interfaces);
+}
+
+static struct phylink_pcs *
+mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
+				phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mxl862xx_priv *priv = dp->ds->priv;
+	int port = dp->index;
+
+	if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
+		return NULL;
+
+	switch (port) {
+	case 9 ... 16:
+		return &priv->serdes_ports[port - 9].pcs;
+	default:
+		return NULL;
+	}
 }
 
 static void mxl862xx_phylink_mac_config(struct phylink_config *config,
@@ -48,4 +401,5 @@ const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
 	.mac_config = mxl862xx_phylink_mac_config,
 	.mac_link_down = mxl862xx_phylink_mac_link_down,
 	.mac_link_up = mxl862xx_phylink_mac_link_up,
+	.mac_select_pcs = mxl862xx_phylink_mac_select_pcs,
 };
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
index c3d5215bdf60..03bb9caad9aa 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
@@ -7,8 +7,15 @@
 
 #include "mxl862xx.h"
 
+#define MXL862XX_SERDES_SLOT(port) \
+	(((port) - MXL862XX_FIRST_SERDES_PORT) % MXL862XX_SERDES_SLOTS)
+#define MXL862XX_SERDES_PORT_ID(port) \
+	(((port) - MXL862XX_FIRST_SERDES_PORT) / MXL862XX_SERDES_SLOTS)
+
 extern const struct phylink_mac_ops mxl862xx_phylink_mac_ops;
 void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 			       struct phylink_config *config);
+void mxl862xx_setup_pcs(struct mxl862xx_priv *priv, struct mxl862xx_pcs *pcs,
+			int port);
 
 #endif /* __MXL862XX_PHYLINK_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 0b1a23364eb5..0af41efccbc6 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -622,7 +622,7 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	int n_user_ports = 0, max_vlans;
 	int ingress_finals, vid_rules;
 	struct dsa_port *dp;
-	int ret;
+	int ret, i;
 
 	ret = mxl862xx_reset(priv);
 	if (ret)
@@ -632,6 +632,10 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
+		mxl862xx_setup_pcs(priv, &priv->serdes_ports[i],
+				   i + MXL862XX_FIRST_SERDES_PORT);
+
 	/* Calculate Extended VLAN block sizes.
 	 * With VLAN Filter handling VID membership checks:
 	 *   Ingress: only final catchall rules (PVID insertion, 802.1Q
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index e3db3711b245..3cdb6866cd22 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -11,6 +11,9 @@
 struct mxl862xx_priv;
 
 #define MXL862XX_MAX_PORTS		17
+#define MXL862XX_FIRST_SERDES_PORT	9
+#define MXL862XX_SERDES_SLOTS		4
+
 #define MXL862XX_DEFAULT_BRIDGE		0
 #define MXL862XX_MAX_BRIDGES		48
 #define MXL862XX_MAX_BRIDGE_PORTS	128
@@ -242,6 +245,26 @@ struct mxl862xx_port {
 	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/**
+ * struct mxl862xx_pcs - link SerDes interfaces to bridge ports
+ * @pcs:       &struct phylink_pcs instance
+ * @priv:      pointer to &struct mxl862xx_priv
+ * @serdes_id: SerDes instance index (0 or 1)
+ * @slot:      slot within the SerDes (0-3 for QSGMII/QUSXGMII, 0 otherwise)
+ * @interface: cached PHY interface, last value passed to pcs_config().
+ *             %PHY_INTERFACE_MODE_NA before the first successful
+ *             pcs_config().  Used by pcs_an_restart() to populate the
+ *             firmware command and by pcs_disable() to skip the
+ *             firmware power-down for shared (QSGMII/QUSXGMII) modes.
+ */
+struct mxl862xx_pcs {
+	struct phylink_pcs pcs;
+	struct mxl862xx_priv *priv;
+	int serdes_id;
+	int slot;
+	phy_interface_t interface;
+};
+
 /**
  * struct mxl862xx_fw_version - firmware version for comparison and display
  * @major: firmware major version
@@ -280,6 +303,12 @@ struct mxl862xx_fw_version {
  *                      flooding)
  * @fw_version:         cached firmware version, populated at probe and
  *                      compared with MXL862XX_FW_VER_MIN()
+ * @serdes_ports:       SerDes interfaces incl. sub-interfaces in case of
+ *                      10G_QXGMII or QSGMII
+ * @serdes_refcount:    per-XPCS count of sub-ports enabled by phylink;
+ *                      pcs_disable powers an XPCS down when the count
+ *                      reaches zero. atomic_t so concurrent sub-port
+ *                      enable/disable need no extra lock.
  * @ports:              per-port state, indexed by switch port number
  * @bridges:            maps DSA bridge number to firmware bridge ID;
  *                      zero means no firmware bridge allocated for that
@@ -298,6 +327,8 @@ struct mxl862xx_priv {
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
+	struct mxl862xx_pcs serdes_ports[8];
+	atomic_t serdes_refcount[2];
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
-- 
2.54.0

