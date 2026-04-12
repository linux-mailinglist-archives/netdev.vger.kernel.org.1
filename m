Return-Path: <netdev+bounces-277725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNyoFS7h2mnA6wgAu9opvQ
	(envelope-from <netdev+bounces-277725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:02:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3513E203A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF3773037424
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02391C01;
	Sun, 12 Apr 2026 00:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99439FD4;
	Sun, 12 Apr 2026 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952126; cv=none; b=ZuXMyEmEhaM3X9Rg1XflJMqRt8+ZqYJHk83c9yJgbhxqGu0JmxKZgMKBR1H1+z1Es9+kPk51vLGrQgnEAY/kJkJE9BLidXgxhFiRrbVvRAqYptXco9PhazCRLugaCbxk0wFUSkTw4LIXm9jGRrgiBxRTj9NRIoSXcwuJi/fGfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952126; c=relaxed/simple;
	bh=SN/m7kI3Rr26f+axkooFet+ZnH8EoDZJkkP/K4O9v4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKNKH8mqDBbK1WeXPFMWBXOi8A0hu4mrtDjwpkILyB82HhiTjw45F/uJZuv6yviIXeVfEVZGp4MNuNc1JeI68E+pUMh4pWiDupXZdYzyPgJcfrCkjMe3wJBB2XT7xM30sFkacrHKGcZr0duHFvyaB3eWpm1lZwxBPHyQUvgjUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wBiH2-000000005aJ-2hIm;
	Sun, 12 Apr 2026 00:02:00 +0000
Date: Sun, 12 Apr 2026 01:01:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 1/2] net: dsa: mxl862xx: add ethtool statistics
 support
Message-ID: <480be14d5ed51f3db7b1681b298044dbf8e87494.1775951347.git.daniel@makrotopia.org>
References: <cover.1775951347.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775951347.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-277725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: BD3513E203A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MxL862xx firmware exposes per-port RMON counters through the
RMON_PORT_GET command, covering standard IEEE 802.3 MAC statistics
(unicast/multicast/broadcast packet and byte counts, collision
counters, pause frames) as well as hardware-specific counters such
as extended VLAN discard and MTU exceed events.

Add the RMON counter firmware API structures and command definitions.
Implement .get_strings, .get_sset_count, and .get_ethtool_stats for
legacy ethtool -S support. Implement .get_eth_mac_stats,
.get_eth_ctrl_stats, and .get_pause_stats for the standardized
IEEE 802.3 statistics interface.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 * trim mxl862xx_mib[] to counters not covered elsewhere only
 * remove histogram counters (moved to .get_rmon_stats)
 * remove RMON error counters (moved to .get_rmon_stats)
 * remove counters already in .get_eth_mac_stats
 * remove counters already in .get_stats64
 * add mxl862xx_rmon_ranges[] and mxl862xx_get_rmon_stats()

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 142 +++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 173 ++++++++++++++++++++++++
 3 files changed, 318 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index c902e90397e5f..fb21ddc1bf1c0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -1224,4 +1224,146 @@ struct mxl862xx_sys_fw_image_version {
 	__le32 iv_build_num;
 } __packed;
 
+/**
+ * enum mxl862xx_port_type - Port Type
+ * @MXL862XX_LOGICAL_PORT: Logical Port
+ * @MXL862XX_PHYSICAL_PORT: Physical Port
+ * @MXL862XX_CTP_PORT: Connectivity Termination Port (CTP)
+ * @MXL862XX_BRIDGE_PORT: Bridge Port
+ */
+enum mxl862xx_port_type {
+	MXL862XX_LOGICAL_PORT = 0,
+	MXL862XX_PHYSICAL_PORT,
+	MXL862XX_CTP_PORT,
+	MXL862XX_BRIDGE_PORT,
+};
+
+/**
+ * enum mxl862xx_rmon_port_type - RMON counter table type
+ * @MXL862XX_RMON_CTP_PORT_RX: CTP RX counters
+ * @MXL862XX_RMON_CTP_PORT_TX: CTP TX counters
+ * @MXL862XX_RMON_BRIDGE_PORT_RX: Bridge port RX counters
+ * @MXL862XX_RMON_BRIDGE_PORT_TX: Bridge port TX counters
+ * @MXL862XX_RMON_CTP_PORT_PCE_BYPASS: CTP PCE bypass counters
+ * @MXL862XX_RMON_TFLOW_RX: TFLOW RX counters
+ * @MXL862XX_RMON_TFLOW_TX: TFLOW TX counters
+ * @MXL862XX_RMON_QMAP: QMAP counters
+ * @MXL862XX_RMON_METER: Meter counters
+ * @MXL862XX_RMON_PMAC: PMAC counters
+ */
+enum mxl862xx_rmon_port_type {
+	MXL862XX_RMON_CTP_PORT_RX = 0,
+	MXL862XX_RMON_CTP_PORT_TX,
+	MXL862XX_RMON_BRIDGE_PORT_RX,
+	MXL862XX_RMON_BRIDGE_PORT_TX,
+	MXL862XX_RMON_CTP_PORT_PCE_BYPASS,
+	MXL862XX_RMON_TFLOW_RX,
+	MXL862XX_RMON_TFLOW_TX,
+	MXL862XX_RMON_QMAP = 0x0e,
+	MXL862XX_RMON_METER = 0x19,
+	MXL862XX_RMON_PMAC = 0x1c,
+};
+
+/**
+ * struct mxl862xx_rmon_port_cnt - RMON counters for a port
+ * @port_type: Port type for counter retrieval (see &enum mxl862xx_port_type)
+ * @port_id: Ethernet port number (zero-based)
+ * @sub_if_id_group: Sub-interface ID group
+ * @pce_bypass: Separate CTP Tx counters when PCE is bypassed
+ * @rx_extended_vlan_discard_pkts: Discarded at extended VLAN operation
+ * @mtu_exceed_discard_pkts: Discarded due to MTU exceeded
+ * @tx_under_size_good_pkts: Tx undersize (<64) packet count
+ * @tx_oversize_good_pkts: Tx oversize (>1518) packet count
+ * @rx_good_pkts: Received good packet count
+ * @rx_unicast_pkts: Received unicast packet count
+ * @rx_broadcast_pkts: Received broadcast packet count
+ * @rx_multicast_pkts: Received multicast packet count
+ * @rx_fcserror_pkts: Received FCS error packet count
+ * @rx_under_size_good_pkts: Received undersize good packet count
+ * @rx_oversize_good_pkts: Received oversize good packet count
+ * @rx_under_size_error_pkts: Received undersize error packet count
+ * @rx_good_pause_pkts: Received good pause packet count
+ * @rx_oversize_error_pkts: Received oversize error packet count
+ * @rx_align_error_pkts: Received alignment error packet count
+ * @rx_filtered_pkts: Filtered packet count
+ * @rx64byte_pkts: Received 64-byte packet count
+ * @rx127byte_pkts: Received 65-127 byte packet count
+ * @rx255byte_pkts: Received 128-255 byte packet count
+ * @rx511byte_pkts: Received 256-511 byte packet count
+ * @rx1023byte_pkts: Received 512-1023 byte packet count
+ * @rx_max_byte_pkts: Received 1024-max byte packet count
+ * @tx_good_pkts: Transmitted good packet count
+ * @tx_unicast_pkts: Transmitted unicast packet count
+ * @tx_broadcast_pkts: Transmitted broadcast packet count
+ * @tx_multicast_pkts: Transmitted multicast packet count
+ * @tx_single_coll_count: Transmit single collision count
+ * @tx_mult_coll_count: Transmit multiple collision count
+ * @tx_late_coll_count: Transmit late collision count
+ * @tx_excess_coll_count: Transmit excessive collision count
+ * @tx_coll_count: Transmit collision count
+ * @tx_pause_count: Transmit pause packet count
+ * @tx64byte_pkts: Transmitted 64-byte packet count
+ * @tx127byte_pkts: Transmitted 65-127 byte packet count
+ * @tx255byte_pkts: Transmitted 128-255 byte packet count
+ * @tx511byte_pkts: Transmitted 256-511 byte packet count
+ * @tx1023byte_pkts: Transmitted 512-1023 byte packet count
+ * @tx_max_byte_pkts: Transmitted 1024-max byte packet count
+ * @tx_dropped_pkts: Transmit dropped packet count
+ * @tx_acm_dropped_pkts: Transmit ACM dropped packet count
+ * @rx_dropped_pkts: Received dropped packet count
+ * @rx_good_bytes: Received good byte count (64-bit)
+ * @rx_bad_bytes: Received bad byte count (64-bit)
+ * @tx_good_bytes: Transmitted good byte count (64-bit)
+ */
+struct mxl862xx_rmon_port_cnt {
+	__le32 port_type; /* enum mxl862xx_port_type */
+	__le16 port_id;
+	__le16 sub_if_id_group;
+	u8 pce_bypass;
+	__le32 rx_extended_vlan_discard_pkts;
+	__le32 mtu_exceed_discard_pkts;
+	__le32 tx_under_size_good_pkts;
+	__le32 tx_oversize_good_pkts;
+	__le32 rx_good_pkts;
+	__le32 rx_unicast_pkts;
+	__le32 rx_broadcast_pkts;
+	__le32 rx_multicast_pkts;
+	__le32 rx_fcserror_pkts;
+	__le32 rx_under_size_good_pkts;
+	__le32 rx_oversize_good_pkts;
+	__le32 rx_under_size_error_pkts;
+	__le32 rx_good_pause_pkts;
+	__le32 rx_oversize_error_pkts;
+	__le32 rx_align_error_pkts;
+	__le32 rx_filtered_pkts;
+	__le32 rx64byte_pkts;
+	__le32 rx127byte_pkts;
+	__le32 rx255byte_pkts;
+	__le32 rx511byte_pkts;
+	__le32 rx1023byte_pkts;
+	__le32 rx_max_byte_pkts;
+	__le32 tx_good_pkts;
+	__le32 tx_unicast_pkts;
+	__le32 tx_broadcast_pkts;
+	__le32 tx_multicast_pkts;
+	__le32 tx_single_coll_count;
+	__le32 tx_mult_coll_count;
+	__le32 tx_late_coll_count;
+	__le32 tx_excess_coll_count;
+	__le32 tx_coll_count;
+	__le32 tx_pause_count;
+	__le32 tx64byte_pkts;
+	__le32 tx127byte_pkts;
+	__le32 tx255byte_pkts;
+	__le32 tx511byte_pkts;
+	__le32 tx1023byte_pkts;
+	__le32 tx_max_byte_pkts;
+	__le32 tx_dropped_pkts;
+	__le32 tx_acm_dropped_pkts;
+	__le32 rx_dropped_pkts;
+	__le64 rx_good_bytes;
+	__le64 rx_bad_bytes;
+	__le64 tx_good_bytes;
+} __packed;
+
 #endif /* __MXL862XX_API_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index 45df37cde40d1..f1ea40aa7ea08 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -16,6 +16,7 @@
 #define MXL862XX_BRDGPORT_MAGIC		0x400
 #define MXL862XX_CTP_MAGIC		0x500
 #define MXL862XX_QOS_MAGIC		0x600
+#define MXL862XX_RMON_MAGIC		0x700
 #define MXL862XX_SWMAC_MAGIC		0xa00
 #define MXL862XX_EXTVLAN_MAGIC		0xb00
 #define MXL862XX_VLANFILTER_MAGIC	0xc00
@@ -43,6 +44,8 @@
 #define MXL862XX_QOS_METERCFGSET	(MXL862XX_QOS_MAGIC + 0x2)
 #define MXL862XX_QOS_METERALLOC		(MXL862XX_QOS_MAGIC + 0x2a)
 
+#define MXL862XX_RMON_PORT_GET		(MXL862XX_RMON_MAGIC + 0x1)
+
 #define MXL862XX_MAC_TABLEENTRYADD	(MXL862XX_SWMAC_MAGIC + 0x2)
 #define MXL862XX_MAC_TABLEENTRYREAD	(MXL862XX_SWMAC_MAGIC + 0x3)
 #define MXL862XX_MAC_TABLEENTRYQUERY	(MXL862XX_SWMAC_MAGIC + 0x4)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index fca9a3e36bb69..58bf7210c6d40 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -30,6 +30,38 @@
 #define MXL862XX_API_READ_QUIET(dev, cmd, data) \
 	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
 
+struct mxl862xx_mib_desc {
+	unsigned int size;
+	unsigned int offset;
+	const char *name;
+};
+
+#define MIB_DESC(_size, _name, _element)					\
+{									\
+	.size = _size,							\
+	.name = _name,							\
+	.offset = offsetof(struct mxl862xx_rmon_port_cnt, _element)	\
+}
+
+/* Hardware-specific counters not covered by any standardized stats callback. */
+static const struct mxl862xx_mib_desc mxl862xx_mib[] = {
+	MIB_DESC(1, "TxAcmDroppedPkts", tx_acm_dropped_pkts),
+	MIB_DESC(1, "RxFilteredPkts", rx_filtered_pkts),
+	MIB_DESC(1, "RxExtendedVlanDiscardPkts", rx_extended_vlan_discard_pkts),
+	MIB_DESC(1, "MtuExceedDiscardPkts", mtu_exceed_discard_pkts),
+	MIB_DESC(2, "RxBadBytes", rx_bad_bytes),
+};
+
+static const struct ethtool_rmon_hist_range mxl862xx_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, 10240 },
+	{}
+};
+
 #define MXL862XX_SDMA_PCTRLP(p)		(0xbc0 + ((p) * 0x6))
 #define MXL862XX_SDMA_PCTRL_EN		BIT(0)
 
@@ -1734,6 +1766,140 @@ static int mxl862xx_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void mxl862xx_get_strings(struct dsa_switch *ds, int port,
+				 u32 stringset, u8 *data)
+{
+	int i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mxl862xx_mib); i++)
+		ethtool_puts(&data, mxl862xx_mib[i].name);
+}
+
+static int mxl862xx_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	return ARRAY_SIZE(mxl862xx_mib);
+}
+
+static int mxl862xx_read_rmon(struct dsa_switch *ds, int port,
+			      struct mxl862xx_rmon_port_cnt *cnt)
+{
+	memset(cnt, 0, sizeof(*cnt));
+	cnt->port_type = cpu_to_le32(MXL862XX_CTP_PORT);
+	cnt->port_id = cpu_to_le16(port);
+
+	return MXL862XX_API_READ(ds->priv, MXL862XX_RMON_PORT_GET, *cnt);
+}
+
+static void mxl862xx_get_ethtool_stats(struct dsa_switch *ds, int port,
+				       u64 *data)
+{
+	const struct mxl862xx_mib_desc *mib;
+	struct mxl862xx_rmon_port_cnt cnt;
+	int ret, i;
+	void *field;
+
+	ret = mxl862xx_read_rmon(ds, port, &cnt);
+	if (ret) {
+		dev_err(ds->dev, "failed to read RMON stats on port %d\n", port);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mxl862xx_mib); i++) {
+		mib = &mxl862xx_mib[i];
+		field = (u8 *)&cnt + mib->offset;
+
+		if (mib->size == 1)
+			*data++ = le32_to_cpu(*(__le32 *)field);
+		else
+			*data++ = le64_to_cpu(*(__le64 *)field);
+	}
+}
+
+static void mxl862xx_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				       struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct mxl862xx_rmon_port_cnt cnt;
+
+	if (mxl862xx_read_rmon(ds, port, &cnt))
+		return;
+
+	mac_stats->FramesTransmittedOK = le32_to_cpu(cnt.tx_good_pkts);
+	mac_stats->SingleCollisionFrames = le32_to_cpu(cnt.tx_single_coll_count);
+	mac_stats->MultipleCollisionFrames = le32_to_cpu(cnt.tx_mult_coll_count);
+	mac_stats->FramesReceivedOK = le32_to_cpu(cnt.rx_good_pkts);
+	mac_stats->FrameCheckSequenceErrors = le32_to_cpu(cnt.rx_fcserror_pkts);
+	mac_stats->AlignmentErrors = le32_to_cpu(cnt.rx_align_error_pkts);
+	mac_stats->OctetsTransmittedOK = le64_to_cpu(cnt.tx_good_bytes);
+	mac_stats->LateCollisions = le32_to_cpu(cnt.tx_late_coll_count);
+	mac_stats->FramesAbortedDueToXSColls = le32_to_cpu(cnt.tx_excess_coll_count);
+	mac_stats->OctetsReceivedOK = le64_to_cpu(cnt.rx_good_bytes);
+	mac_stats->MulticastFramesXmittedOK = le32_to_cpu(cnt.tx_multicast_pkts);
+	mac_stats->BroadcastFramesXmittedOK = le32_to_cpu(cnt.tx_broadcast_pkts);
+	mac_stats->MulticastFramesReceivedOK = le32_to_cpu(cnt.rx_multicast_pkts);
+	mac_stats->BroadcastFramesReceivedOK = le32_to_cpu(cnt.rx_broadcast_pkts);
+	mac_stats->FrameTooLongErrors = le32_to_cpu(cnt.rx_oversize_error_pkts);
+}
+
+static void mxl862xx_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+					struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct mxl862xx_rmon_port_cnt cnt;
+
+	if (mxl862xx_read_rmon(ds, port, &cnt))
+		return;
+
+	ctrl_stats->MACControlFramesTransmitted = le32_to_cpu(cnt.tx_pause_count);
+	ctrl_stats->MACControlFramesReceived = le32_to_cpu(cnt.rx_good_pause_pkts);
+}
+
+static void mxl862xx_get_pause_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_pause_stats *pause_stats)
+{
+	struct mxl862xx_rmon_port_cnt cnt;
+
+	if (mxl862xx_read_rmon(ds, port, &cnt))
+		return;
+
+	pause_stats->tx_pause_frames = le32_to_cpu(cnt.tx_pause_count);
+	pause_stats->rx_pause_frames = le32_to_cpu(cnt.rx_good_pause_pkts);
+}
+
+static void mxl862xx_get_rmon_stats(struct dsa_switch *ds, int port,
+				    struct ethtool_rmon_stats *rmon_stats,
+				    const struct ethtool_rmon_hist_range **ranges)
+{
+	struct mxl862xx_rmon_port_cnt cnt;
+
+	if (mxl862xx_read_rmon(ds, port, &cnt))
+		return;
+
+	rmon_stats->undersize_pkts = le32_to_cpu(cnt.rx_under_size_good_pkts);
+	rmon_stats->oversize_pkts = le32_to_cpu(cnt.rx_oversize_good_pkts);
+	rmon_stats->fragments = le32_to_cpu(cnt.rx_under_size_error_pkts);
+	rmon_stats->jabbers = le32_to_cpu(cnt.rx_oversize_error_pkts);
+
+	rmon_stats->hist[0] = le32_to_cpu(cnt.rx64byte_pkts);
+	rmon_stats->hist[1] = le32_to_cpu(cnt.rx127byte_pkts);
+	rmon_stats->hist[2] = le32_to_cpu(cnt.rx255byte_pkts);
+	rmon_stats->hist[3] = le32_to_cpu(cnt.rx511byte_pkts);
+	rmon_stats->hist[4] = le32_to_cpu(cnt.rx1023byte_pkts);
+	rmon_stats->hist[5] = le32_to_cpu(cnt.rx_max_byte_pkts);
+
+	rmon_stats->hist_tx[0] = le32_to_cpu(cnt.tx64byte_pkts);
+	rmon_stats->hist_tx[1] = le32_to_cpu(cnt.tx127byte_pkts);
+	rmon_stats->hist_tx[2] = le32_to_cpu(cnt.tx255byte_pkts);
+	rmon_stats->hist_tx[3] = le32_to_cpu(cnt.tx511byte_pkts);
+	rmon_stats->hist_tx[4] = le32_to_cpu(cnt.tx1023byte_pkts);
+	rmon_stats->hist_tx[5] = le32_to_cpu(cnt.tx_max_byte_pkts);
+
+	*ranges = mxl862xx_rmon_ranges;
+}
 static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_tag_protocol = mxl862xx_get_tag_protocol,
 	.setup = mxl862xx_setup,
@@ -1758,6 +1924,13 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.port_vlan_filtering = mxl862xx_port_vlan_filtering,
 	.port_vlan_add = mxl862xx_port_vlan_add,
 	.port_vlan_del = mxl862xx_port_vlan_del,
+	.get_strings = mxl862xx_get_strings,
+	.get_sset_count = mxl862xx_get_sset_count,
+	.get_ethtool_stats = mxl862xx_get_ethtool_stats,
+	.get_eth_mac_stats = mxl862xx_get_eth_mac_stats,
+	.get_eth_ctrl_stats = mxl862xx_get_eth_ctrl_stats,
+	.get_pause_stats = mxl862xx_get_pause_stats,
+	.get_rmon_stats = mxl862xx_get_rmon_stats,
 };
 
 static void mxl862xx_phylink_mac_config(struct phylink_config *config,
-- 
2.53.0

