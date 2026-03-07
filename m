Return-Path: <netdev+bounces-265045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J86JRacq2kJewEAu9opvQ
	(envelope-from <netdev+bounces-265045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:31:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A5229EEA
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 208B5300681C
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97E2288D5;
	Sat,  7 Mar 2026 03:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004971DF74F;
	Sat,  7 Mar 2026 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854287; cv=none; b=h0j+CZs0NinEIqNCSVtqQ/0rz+l2nI0qBKJz9am8TThbnll2T07fZiaU2TIZxt/LpRTDWkJJRENHgkoYaY3G1DI5zHoKfRPBWAkC1OZhFk44InJX7wLvFSsRzj6F+5sSpVtHJz1UNhvb5pfqKX5wDvingUOSFBnyheCp0/4Emek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854287; c=relaxed/simple;
	bh=FfoaMcDwrluqHILQfnrrhyOuv6dIsch8xLpnh5UIxSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEKhLyqQ/RJdapBwxSTpUXha0U+8qgmco7fD/dQIBsodugNHzw7K2XrKdHC1N7L9tuUXFAjn08SkvTxZPzW8KsXUcVwU6aV0ZBUpxhociyDKI52iHYFOPGxHqi/CNy4qRzYgOMOOXCMllKXczOwYC46OmElq9kAYU48Ct5JY8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vyiNs-000000003xQ-2Ktd;
	Sat, 07 Mar 2026 03:31:20 +0000
Date: Sat, 7 Mar 2026 03:31:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 2/2] net: dsa: mxl862xx: implement bridge offloading
Message-ID: <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772853341.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 872A5229EEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265045-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.101];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bridge_vlan_unaware.sh:url]
X-Rspamd-Action: no action

Add support for bridge offloading on the mxl862xx DSA driver.

Implement joining and leaving bridges as well as add, delete and dump
operations on isolated FDBs and setting a port's STP state.

The switch supports a maximum of 63 bridges, however, up to 12 may
be used as "single-port bridges" to isolate standalone ports.
Allowing up to 48 bridges to be offloaded seems more than enough on
that hardware, hence that is set as max_num_bridges.

A total of 128 bridge ports are supported in the bridge portmap, and
virtual bridge ports have to be used eg. for link-aggregation, hence
potentially exceeding the number of hardware ports.

As there are now more users of the BRIDGEPORT_CONFIG_SET API and the
state of each port is cached locally, introduce a helper function
mxl862xx_set_bridge_port(struct dsa_switch *ds, int port) which is
then also be used to replace the direct calls to the API in
mxl862xx_setup_cpu_bridge() and mxl862xx_add_single_port_bridge(),
while removing the accidentally added VLAN-aware-learning settings.

Note that there is no convenient way to control flooding on per-port
level, so the driver is using a QoS meter setup as a stopper in lack
of any better option. This works, but allows a single 64-byte packet
to pass once after reset. While this limitation doesn't seem to be a
problem in practice, it has the effect that the bridge_vlan_unaware.sh
selftest only passes the FDB test the 2nd time the test is run after
boot (and any subsequent time after that, of course).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 171 +++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  19 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 576 ++++++++++++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h     |  21 +
 4 files changed, 755 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index a9f599dbca25b..8136f6b1c32e6 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -34,6 +34,117 @@ struct mxl862xx_register_mod {
 	__le16 mask;
 } __packed;
 
+/**
+ * enum mxl862xx_mac_table_filter - Source/Destination MAC address filtering
+ *
+ * @MXL862XX_MAC_FILTER_NONE: no filter
+ * @MXL862XX_MAC_FILTER_SRC: source address filter
+ * @MXL862XX_MAC_FILTER_DEST: destination address filter
+ * @MXL862XX_MAC_FILTER_BOTH: both source and destination filter
+ */
+enum mxl862xx_mac_table_filter {
+	MXL862XX_MAC_FILTER_NONE = 0,
+	MXL862XX_MAC_FILTER_SRC = BIT(0),
+	MXL862XX_MAC_FILTER_DEST = BIT(1),
+	MXL862XX_MAC_FILTER_BOTH = BIT(0) | BIT(1),
+};
+
+/**
+ * struct mxl862xx_mac_table_add - MAC Table Entry to be added
+ * @fid: Filtering Identifier (FID) (not supported by all switches)
+ * @port_id: Ethernet Port number
+ * @port_map: Bridge Port Map
+ * @sub_if_id: Sub-Interface Identifier Destination
+ * @age_timer: Aging Time in seconds
+ * @vlan_id: STAG VLAN Id
+ * @static_entry: Static Entry (value will be aged out if not set to static)
+ * @traffic_class: Egress queue traffic class
+ * @mac: MAC Address to add to the table
+ * @filter_flag: See &enum mxl862xx_mac_table_filter
+ * @igmp_controlled: Packet is marked as IGMP controlled if destination MAC
+ *                   address matche MAC in this entry
+ * @associated_mac: Associated Mac address
+ * @tci: TCI for B-Step
+ *	Bit [0:11] - VLAN ID
+ *	Bit [12] - VLAN CFI/DEI
+ *	Bit [13:15] - VLAN PRI
+ */
+struct mxl862xx_mac_table_add {
+	__le16 fid;
+	__le32 port_id;
+	__le16 port_map[8];
+	__le16 sub_if_id;
+	int age_timer;
+	__le16 vlan_id;
+	u8 static_entry;
+	u8 traffic_class;
+	u8 mac[ETH_ALEN];
+	u8 filter_flag;
+	u8 igmp_controlled;
+	u8 associated_mac[ETH_ALEN];
+	__le16 tci;
+} __packed;
+
+/**
+ * struct mxl862xx_mac_table_remove - MAC Table Entry to be removed
+ * @fid: Filtering Identifier (FID)
+ * @mac: MAC Address to be removed from the table.
+ * @filter_flag: See &enum mxl862xx_mac_table_filter
+ * @tci: TCI for B-Step
+ *	Bit [0:11] - VLAN ID
+ *	Bit [12] - VLAN CFI/DEI
+ *	Bit [13:15] - VLAN PRI
+ */
+struct mxl862xx_mac_table_remove {
+	__le16 fid;
+	u8 mac[ETH_ALEN];
+	u8 filter_flag;
+	__le16 tci;
+} __packed;
+
+/**
+ * struct mxl862xx_mac_table_read - MAC Table Entry to be read
+ * @initial: Restart the get operation from the beginning of the table
+ * @last: Indicates that the read operation returned last entry
+ * @fid: Get the MAC table entry belonging to the given Filtering Identifier
+ * @port_id: The Bridge Port ID
+ * @port_map: Bridge Port Map
+ * @age_timer: Aging Time
+ * @vlan_id: STAG VLAN Id
+ * @static_entry: Indicates if this is a Static Entry
+ * @sub_if_id: Sub-Interface Identifier Destination
+ * @mac: MAC Address. Filled out by the switch API implementation.
+ * @filter_flag: See &enum mxl862xx_mac_table_filter
+ * @igmp_controlled: Packet is marked as IGMP controlled if destination MAC
+ *                   address matches the MAC in this entry
+ * @entry_changed: Indicate if the Entry has Changed
+ * @associated_mac: Associated MAC address
+ * @hit_status: MAC Table Hit Status Update
+ * @tci: TCI for  B-Step
+ *	Bit [0:11] - VLAN ID
+ *	Bit [12] - VLAN CFI/DEI
+ *	Bit [13:15] - VLAN PRI
+ */
+struct mxl862xx_mac_table_read {
+	u8 initial;
+	u8 last;
+	__le16 fid;
+	__le32 port_id;
+	__le16 port_map[8];
+	int age_timer;
+	__le16 vlan_id;
+	u8 static_entry;
+	__le16 sub_if_id;
+	u8 mac[ETH_ALEN];
+	u8 filter_flag;
+	u8 igmp_controlled;
+	u8 entry_changed;
+	u8 associated_mac[ETH_ALEN];
+	u8 hit_status;
+	__le16 tci;
+	__le16 first_bridge_port_id;
+} __packed;
+
 /**
  * enum mxl862xx_mac_clear_type - MAC table clear type
  * @MXL862XX_MAC_CLEAR_PHY_PORT: clear dynamic entries based on port_id
@@ -138,6 +249,40 @@ enum mxl862xx_bridge_port_egress_meter {
 	MXL862XX_BRIDGE_PORT_EGRESS_METER_MAX,
 };
 
+/**
+ * struct mxl862xx_qos_meter_cfg - Rate meter configuration
+ * @enable: Enable/disable meter
+ * @meter_id: Meter ID (assigned by firmware on alloc)
+ * @meter_name: Meter name string
+ * @meter_type: Meter algorithm type (srTCM = 0, trTCM = 1)
+ * @cbs: Committed Burst Size (in bytes)
+ * @res1: Reserved
+ * @ebs: Excess Burst Size (in bytes)
+ * @res2: Reserved
+ * @rate: Committed Information Rate (in kbit/s)
+ * @pi_rate: Peak Information Rate (in kbit/s)
+ * @colour_blind_mode: Colour-blind mode enable
+ * @pkt_mode: Packet mode enable
+ * @local_overhd: Local overhead accounting enable
+ * @local_overhd_val: Local overhead accounting value
+ */
+struct mxl862xx_qos_meter_cfg {
+	u8 enable;
+	__le16 meter_id;
+	char meter_name[32];
+	__le32 meter_type;
+	__le32 cbs;
+	__le32 res1;
+	__le32 ebs;
+	__le32 res2;
+	__le32 rate;
+	__le32 pi_rate;
+	u8 colour_blind_mode;
+	u8 pkt_mode;
+	u8 local_overhd;
+	__le16 local_overhd_val;
+} __packed;
+
 /**
  * enum mxl862xx_bridge_forward_mode - Bridge forwarding type of packet
  * @MXL862XX_BRIDGE_FORWARD_FLOOD: Packet is flooded to port members of
@@ -658,6 +803,32 @@ struct mxl862xx_ctp_port_assignment {
 	__le16 bridge_port_id;
 } __packed;
 
+/**
+ * enum mxl862xx_stp_port_state
+ * @MXL862XX_STP_PORT_STATE_FORWARD: Forwarding state
+ * @MXL862XX_STP_PORT_STATE_DISABLE: Disabled/Discarding state
+ * @MXL862XX_STP_PORT_STATE_LEARNING: Learning state
+ * @MXL862XX_STP_PORT_STATE_BLOCKING: Blocking/Listening
+ */
+enum mxl862xx_stp_port_state {
+	MXL862XX_STP_PORT_STATE_FORWARD = 0,
+	MXL862XX_STP_PORT_STATE_DISABLE,
+	MXL862XX_STP_PORT_STATE_LEARNING,
+	MXL862XX_STP_PORT_STATE_BLOCKING,
+};
+
+/**
+ * struct mxl862xx_stp_port_cfg - Configures the Spanning Tree Protocol state of an Ethernet port
+ * @port_id: Port number
+ * @fid: Filtering Identifier (FID)
+ * @port_state: See &enum mxl862xx_stp_port_state
+ */
+struct mxl862xx_stp_port_cfg {
+	__le16 port_id;
+	__le16 fid;
+	__le32 port_state; /* enum mxl862xx_stp_port_state */
+} __packed;
+
 /**
  * struct mxl862xx_sys_fw_image_version - Firmware version information
  * @iv_major: firmware major version
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index f6852ade64e7c..43d04c019b50c 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -15,12 +15,15 @@
 #define MXL862XX_BRDG_MAGIC		0x300
 #define MXL862XX_BRDGPORT_MAGIC		0x400
 #define MXL862XX_CTP_MAGIC		0x500
+#define MXL862XX_QOS_MAGIC		0x600
 #define MXL862XX_SWMAC_MAGIC		0xa00
+#define MXL862XX_STP_MAGIC		0xf00
 #define MXL862XX_SS_MAGIC		0x1600
 #define GPY_GPY2XX_MAGIC		0x1800
 #define SYS_MISC_MAGIC			0x1900
 
 #define MXL862XX_COMMON_CFGGET		(MXL862XX_COMMON_MAGIC + 0x9)
+#define MXL862XX_COMMON_CFGSET		(MXL862XX_COMMON_MAGIC + 0xa)
 #define MXL862XX_COMMON_REGISTERMOD	(MXL862XX_COMMON_MAGIC + 0x11)
 
 #define MXL862XX_BRIDGE_ALLOC		(MXL862XX_BRDG_MAGIC + 0x1)
@@ -35,14 +38,22 @@
 
 #define MXL862XX_CTP_PORTASSIGNMENTSET	(MXL862XX_CTP_MAGIC + 0x3)
 
+#define MXL862XX_QOS_METERCFGSET	(MXL862XX_QOS_MAGIC + 0x2)
+#define MXL862XX_QOS_METERALLOC		(MXL862XX_QOS_MAGIC + 0x2a)
+
+#define MXL862XX_MAC_TABLEENTRYADD	(MXL862XX_SWMAC_MAGIC + 0x2)
+#define MXL862XX_MAC_TABLEENTRYREAD	(MXL862XX_SWMAC_MAGIC + 0x3)
+#define MXL862XX_MAC_TABLEENTRYREMOVE	(MXL862XX_SWMAC_MAGIC + 0x5)
 #define MXL862XX_MAC_TABLECLEARCOND	(MXL862XX_SWMAC_MAGIC + 0x8)
 
-#define MXL862XX_SS_SPTAG_SET		(MXL862XX_SS_MAGIC + 0x02)
+#define MXL862XX_SS_SPTAG_SET		(MXL862XX_SS_MAGIC + 0x2)
+
+#define MXL862XX_STP_PORTCFGSET		(MXL862XX_STP_MAGIC + 0x2)
 
-#define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x01)
-#define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x02)
+#define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x1)
+#define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x2)
 
-#define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x02)
+#define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
 
 #define MMD_API_MAXIMUM_ID		0x7fff
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b1e2094b58165..40f649b331365 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/if_bridge.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
@@ -36,6 +37,13 @@
 #define MXL862XX_READY_TIMEOUT_MS	10000
 #define MXL862XX_READY_POLL_MS		100
 
+static const int mxl862xx_flood_meters[] = {
+	MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_UC,
+	MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_IP,
+	MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_NON_IP,
+	MXL862XX_BRIDGE_PORT_EGRESS_METER_BROADCAST,
+};
+
 static enum dsa_tag_protocol mxl862xx_get_tag_protocol(struct dsa_switch *ds,
 						       int port,
 						       enum dsa_tag_protocol m)
@@ -169,6 +177,66 @@ static int mxl862xx_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static int mxl862xx_bridge_config_fwd(struct dsa_switch *ds, u16 bridge_id,
+				      bool ucast_flood, bool mcast_flood,
+				      bool bcast_flood)
+{
+	struct mxl862xx_bridge_config bridge_config = { };
+	struct mxl862xx_priv *priv = ds->priv;
+	int ret;
+
+	bridge_config.mask = cpu_to_le32(MXL862XX_BRIDGE_CONFIG_MASK_FORWARDING_MODE);
+	bridge_config.bridge_id = cpu_to_le16(bridge_id);
+
+	bridge_config.forward_unknown_unicast = ucast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD;
+
+	bridge_config.forward_unknown_multicast_ip = mcast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD;
+	bridge_config.forward_unknown_multicast_non_ip =
+		bridge_config.forward_unknown_multicast_ip;
+
+	bridge_config.forward_broadcast = bcast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD;
+
+	ret = MXL862XX_API_WRITE(priv, MXL862XX_BRIDGE_CONFIGSET, bridge_config);
+	if (ret)
+		dev_err(ds->dev, "failed to configure bridge %u forwarding: %d\n",
+			bridge_id, ret);
+
+	return ret;
+}
+
+/* Allocate a single zero-rate meter shared by all ports and flood types.
+ * All flood-blocking egress sub-meters point to this one meter so that
+ * the single CBS=64 token bucket fills as quickly as possible, minimising
+ * the one-packet leak inherent with the hardware minimum CBS.
+ */
+static int mxl862xx_setup_drop_meter(struct dsa_switch *ds)
+{
+	struct mxl862xx_qos_meter_cfg meter = {};
+	struct mxl862xx_priv *priv = ds->priv;
+	int ret;
+
+	/* meter_id=0 means auto-alloc */
+	ret = MXL862XX_API_READ(priv, MXL862XX_QOS_METERALLOC, meter);
+	if (ret)
+		return ret;
+
+	meter.enable = true;
+	meter.cbs = cpu_to_le32(64);
+	meter.ebs = cpu_to_le32(64);
+	snprintf(meter.meter_name, sizeof(meter.meter_name), "drop");
+
+	ret = MXL862XX_API_WRITE(priv, MXL862XX_QOS_METERCFGSET, meter);
+	if (ret)
+		return ret;
+
+	priv->drop_meter = le16_to_cpu(meter.meter_id);
+
+	return 0;
+}
+
 static int mxl862xx_setup(struct dsa_switch *ds)
 {
 	struct mxl862xx_priv *priv = ds->priv;
@@ -182,6 +250,15 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	ret = mxl862xx_bridge_config_fwd(ds, MXL862XX_DEFAULT_BRIDGE,
+					 false, false, true);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_setup_drop_meter(ds);
+	if (ret)
+		return ret;
+
 	return mxl862xx_setup_mdio(ds);
 }
 
@@ -259,64 +336,235 @@ static int mxl862xx_configure_sp_tag_proto(struct dsa_switch *ds, int port,
 	return MXL862XX_API_WRITE(ds->priv, MXL862XX_SS_SPTAG_SET, tag);
 }
 
-static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
+static int mxl862xx_set_bridge_port(struct dsa_switch *ds, int port)
 {
 	struct mxl862xx_bridge_port_config br_port_cfg = {};
 	struct mxl862xx_priv *priv = ds->priv;
-	u16 bridge_port_map = 0;
-	struct dsa_port *dp;
+	struct mxl862xx_port *p = &priv->ports[port];
+	u16 bridge_id = p->bridge ? p->bridge->bridge_id : p->fid;
+	bool enable;
+	int i, idx;
 
-	/* CPU port bridge setup */
-	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
+	br_port_cfg.bridge_port_id = cpu_to_le16(port);
+	br_port_cfg.bridge_id = cpu_to_le16(bridge_id);
+	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
+				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
 				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
-				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
+				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_EGRESS_SUB_METER);
+	br_port_cfg.src_mac_learning_disable = !p->learning;
 
-	br_port_cfg.bridge_port_id = cpu_to_le16(port);
-	br_port_cfg.src_mac_learning_disable = false;
-	br_port_cfg.vlan_src_mac_vid_enable = true;
-	br_port_cfg.vlan_dst_mac_vid_enable = true;
+	for (i = 0; i < ARRAY_SIZE(br_port_cfg.bridge_port_map); i++)
+		br_port_cfg.bridge_port_map[i] =
+			cpu_to_le16(bitmap_read(p->portmap, i * 16, 16));
+
+	for (i = 0; i < ARRAY_SIZE(mxl862xx_flood_meters); i++) {
+		idx = mxl862xx_flood_meters[i];
+		enable = !!(p->flood_block & BIT(idx));
+
+		br_port_cfg.egress_traffic_sub_meter_id[idx] =
+			enable ? cpu_to_le16(priv->drop_meter) : 0;
+		br_port_cfg.egress_sub_metering_enable[idx] = enable;
+	}
+
+	return MXL862XX_API_WRITE(priv, MXL862XX_BRIDGEPORT_CONFIGSET,
+				  br_port_cfg);
+}
+
+static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct dsa_port *dp;
+
+	priv->ports[port].fid = MXL862XX_DEFAULT_BRIDGE;
+	priv->ports[port].learning = true;
 
 	/* include all assigned user ports in the CPU portmap */
+	bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
 	dsa_switch_for_each_user_port(dp, ds) {
 		/* it's safe to rely on cpu_dp being valid for user ports */
 		if (dp->cpu_dp->index != port)
 			continue;
 
-		bridge_port_map |= BIT(dp->index);
+		__set_bit(dp->index, priv->ports[port].portmap);
 	}
-	br_port_cfg.bridge_port_map[0] |= cpu_to_le16(bridge_port_map);
 
-	return MXL862XX_API_WRITE(priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
+	return mxl862xx_set_bridge_port(ds, port);
 }
 
 static int mxl862xx_add_single_port_bridge(struct dsa_switch *ds, int port)
 {
-	struct mxl862xx_bridge_port_config br_port_cfg = {};
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mxl862xx_bridge_alloc br_alloc = {};
+	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
-	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
+	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
 	if (ret) {
 		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
 		return ret;
 	}
 
-	br_port_cfg.bridge_id = br_alloc.bridge_id;
-	br_port_cfg.bridge_port_id = cpu_to_le16(port);
-	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
-				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
-				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
-				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
-	br_port_cfg.src_mac_learning_disable = true;
-	br_port_cfg.vlan_src_mac_vid_enable = false;
-	br_port_cfg.vlan_dst_mac_vid_enable = false;
-	/* As this function is only called for user ports it is safe to rely on
-	 * cpu_dp being valid
+	priv->ports[port].fid = le16_to_cpu(br_alloc.bridge_id);
+	priv->ports[port].learning = false;
+	bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
+	__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
+
+	ret = mxl862xx_set_bridge_port(ds, port);
+	if (ret)
+		return ret;
+
+	/* Standalone ports should not flood unknown unicast or multicast
+	 * towards the CPU by default; only broadcast is needed initially.
 	 */
-	br_port_cfg.bridge_port_map[0] = cpu_to_le16(BIT(dp->cpu_dp->index));
+	return mxl862xx_bridge_config_fwd(ds, priv->ports[port].fid,
+					 false, false, true);
+}
+
+static struct mxl862xx_bridge *mxl862xx_allocate_bridge(struct dsa_switch *ds,
+							int num)
+{
+	struct mxl862xx_bridge_alloc br_alloc = {};
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_bridge *mxlbridge;
+	int ret;
+
+	mxlbridge = kzalloc_obj(*mxlbridge);
+	if (!mxlbridge)
+		return ERR_PTR(-ENOMEM);
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
+	if (ret) {
+		kfree(mxlbridge);
+		return ERR_PTR(ret);
+	}
+
+	mxlbridge->bridge_id = le16_to_cpu(br_alloc.bridge_id);
+	mxlbridge->dsa_bridge_num = num;
+
+	ret = mxl862xx_bridge_config_fwd(ds, mxlbridge->bridge_id,
+					 true, true, true);
+	if (ret) {
+		br_alloc.bridge_id = cpu_to_le16(mxlbridge->bridge_id);
+		MXL862XX_API_WRITE(priv, MXL862XX_BRIDGE_FREE, br_alloc);
+		kfree(mxlbridge);
+		return ERR_PTR(ret);
+	}
+
+	list_add(&mxlbridge->list, &priv->bridges);
+
+	return mxlbridge;
+}
+
+static void mxl862xx_free_bridge(struct dsa_switch *ds,
+				 struct mxl862xx_bridge *mxlbridge)
+{
+	struct mxl862xx_bridge_alloc br_alloc = {
+		.bridge_id = cpu_to_le16(mxlbridge->bridge_id),
+	};
+
+	MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGE_FREE, br_alloc);
+	list_del(&mxlbridge->list);
+	kfree(mxlbridge);
+}
+
+static struct mxl862xx_bridge *mxl862xx_find_bridge(struct dsa_switch *ds,
+						    struct dsa_bridge bridge)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_bridge *mxlbridge;
+
+	if (!bridge.num)
+		return NULL;
+
+	list_for_each_entry(mxlbridge, &priv->bridges, list) {
+		if (mxlbridge->dsa_bridge_num == bridge.num)
+			return mxlbridge;
+	}
+
+	return NULL;
+}
+
+static int mxl862xx_update_bridge(struct dsa_switch *ds,
+				  struct mxl862xx_bridge *mxlbridge,
+				  int port, bool join)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int member, ret;
+
+	if (join) {
+		__set_bit(port, mxlbridge->portmap);
+		priv->ports[port].bridge = mxlbridge;
+	} else {
+		__clear_bit(port, mxlbridge->portmap);
+		priv->ports[port].bridge = NULL;
+	}
+
+	/* Update all current bridge members' portmaps */
+	for_each_set_bit(member, mxlbridge->portmap,
+			 MXL862XX_MAX_BRIDGE_PORTS) {
+		dp = dsa_to_port(ds, member);
+
+		/* Build portmap: CPU port + all bridge members except self */
+		bitmap_copy(priv->ports[member].portmap, mxlbridge->portmap,
+			    MXL862XX_MAX_BRIDGE_PORTS);
+		__clear_bit(member, priv->ports[member].portmap);
+		__set_bit(dp->cpu_dp->index, priv->ports[member].portmap);
+
+		priv->ports[member].learning = true;
+		ret = mxl862xx_set_bridge_port(ds, member);
+		if (ret)
+			return ret;
+	}
+
+	/* Revert leaving port to its single-port bridge */
+	if (!join) {
+		dp = dsa_to_port(ds, port);
+
+		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
+		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
+		priv->ports[port].flood_block = 0;
+		priv->ports[port].learning = false;
+		ret = mxl862xx_set_bridge_port(ds, port);
+		if (ret)
+			return ret;
+
+		mxl862xx_port_fast_age(ds, port);
+	}
+
+	return 0;
+}
+
+static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge,
+				     bool *tx_fwd_offload,
+				     struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_bridge *mxlbridge;
 
-	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
+	mxlbridge = mxl862xx_find_bridge(ds, bridge);
+	if (!mxlbridge) {
+		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
+		if (IS_ERR(mxlbridge))
+			return PTR_ERR(mxlbridge);
+	}
+
+	return mxl862xx_update_bridge(ds, mxlbridge, port, true);
+}
+
+static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				       struct dsa_bridge bridge)
+{
+	struct mxl862xx_bridge *mxlbridge;
+
+	mxlbridge = mxl862xx_find_bridge(ds, bridge);
+	if (!mxlbridge)
+		return;
+
+	mxl862xx_update_bridge(ds, mxlbridge, port, false);
+
+	if (bitmap_empty(mxlbridge->portmap, MXL862XX_MAX_BRIDGE_PORTS))
+		mxl862xx_free_bridge(ds, mxlbridge);
 }
 
 static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
@@ -366,6 +614,262 @@ static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 		  config->supported_interfaces);
 }
 
+static int mxl862xx_port_fdb_add(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct mxl862xx_mac_table_add param = { };
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_bridge *mxlbridge;
+	u16 fid;
+	int ret;
+
+	switch (db.type) {
+	case DSA_DB_PORT:
+		fid = priv->ports[db.dp->index].fid;
+		break;
+
+	case DSA_DB_BRIDGE:
+		mxlbridge = mxl862xx_find_bridge(ds, db.bridge);
+		if (!mxlbridge)
+			return -ENOENT;
+		fid = mxlbridge->bridge_id;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	param.port_id = cpu_to_le32(port);
+	param.fid = cpu_to_le16(fid);
+	param.static_entry = true;
+	param.tci = cpu_to_le16(vid & 0xFFF);
+	memcpy(param.mac, addr, ETH_ALEN);
+
+	ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, param);
+	if (ret)
+		dev_err(ds->dev, "failed to add FDB entry on port %d\n", port);
+
+	return ret;
+}
+
+static int mxl862xx_port_fdb_del(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct mxl862xx_mac_table_remove param = { };
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_bridge *mxlbridge;
+	u16 fid;
+	int ret;
+
+	switch (db.type) {
+	case DSA_DB_PORT:
+		fid = priv->ports[db.dp->index].fid;
+		break;
+
+	case DSA_DB_BRIDGE:
+		/* Use multi-port bridge FID */
+		mxlbridge = mxl862xx_find_bridge(ds, db.bridge);
+		if (!mxlbridge)
+			return -ENOENT;
+		fid = mxlbridge->bridge_id;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	param.fid = cpu_to_le16(fid);
+	param.tci = cpu_to_le16(vid & 0xFFF);
+	memcpy(param.mac, addr, ETH_ALEN);
+
+	ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYREMOVE, param);
+	if (ret)
+		dev_err(ds->dev, "failed to remove FDB entry on port %d\n", port);
+
+	return ret;
+}
+
+static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
+				  dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct mxl862xx_mac_table_read param = { };
+	struct mxl862xx_priv *priv = ds->priv;
+	u32 entry_port_id;
+	int ret;
+
+	while (true) {
+		ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYREAD, param);
+		if (ret)
+			return ret;
+
+		if (param.last)
+			break;
+
+		entry_port_id = le32_to_cpu(param.port_id);
+
+		if (entry_port_id == port)
+			cb(param.mac, param.tci & 0x0FFF,
+			   param.static_entry, data);
+
+		memset(&param, 0, sizeof(param));
+	}
+
+	return 0;
+}
+
+static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_mdb *mdb,
+				 struct dsa_db db)
+{
+	return mxl862xx_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_mdb *mdb,
+				 struct dsa_db db)
+{
+	return mxl862xx_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int mxl862xx_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct mxl862xx_cfg param;
+	int ret;
+
+	ret = MXL862XX_API_READ(ds->priv, MXL862XX_COMMON_CFGGET, param);
+	if (ret) {
+		dev_err(ds->dev, "failed to read switch config\n");
+		return ret;
+	}
+
+	param.mac_table_age_timer = cpu_to_le32(MXL862XX_AGETIMER_CUSTOM);
+	param.age_timer = cpu_to_le32(msecs / 1000);
+	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_CFGSET, param);
+	if (ret)
+		dev_err(ds->dev, "failed to set ageing\n");
+
+	return ret;
+}
+
+static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
+					u8 state)
+{
+	struct mxl862xx_stp_port_cfg param = {
+		.port_id = cpu_to_le16(port),
+	};
+	struct mxl862xx_priv *priv = ds->priv;
+	int ret;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		param.port_state = MXL862XX_STP_PORT_STATE_DISABLE;
+		break;
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		param.port_state = MXL862XX_STP_PORT_STATE_BLOCKING;
+		break;
+	case BR_STATE_LEARNING:
+		param.port_state = MXL862XX_STP_PORT_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		param.port_state = MXL862XX_STP_PORT_STATE_FORWARD;
+		break;
+	default:
+		dev_err(ds->dev, "invalid STP state: %d\n", state);
+		return;
+	}
+
+	ret = MXL862XX_API_WRITE(priv, MXL862XX_STP_PORTCFGSET, param);
+	if (ret) {
+		dev_err(ds->dev, "failed to set STP state on port %d\n", port);
+		return;
+	}
+
+	/* The firmware may re-enable MAC learning as a side-effect of
+	 * entering LEARNING or FORWARDING state (per 802.1D defaults).
+	 * Re-apply the driver's intended learning and metering config
+	 * so that standalone ports keep learning disabled.
+	 */
+	ret = mxl862xx_set_bridge_port(ds, port);
+	if (ret)
+		dev_err(ds->dev, "failed to reapply brport flags on port %d\n", port);
+}
+
+static void mxl862xx_port_set_host_flood(struct dsa_switch *ds, int port,
+					 bool uc, bool mc)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->ports[port].bridge)
+		return;
+
+	/* Standalone ports must always keep broadcast flooding enabled
+	 * towards the CPU so that ARP and other broadcast protocols work.
+	 * Only unknown unicast and multicast should follow the host flood
+	 * knobs driven by IFF_PROMISC / IFF_ALLMULTI.
+	 */
+	mxl862xx_bridge_config_fwd(ds, priv->ports[port].fid, uc, mc, true);
+}
+
+static int mxl862xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					  struct switchdev_brport_flags flags,
+					  struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~(BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD |
+			   BR_LEARNING))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mxl862xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				      struct switchdev_brport_flags flags,
+				      struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	unsigned long old_block = priv->ports[port].flood_block;
+	unsigned long block = old_block;
+	bool need_update = false;
+	int ret;
+
+	if (flags.mask & BR_FLOOD) {
+		if (flags.val & BR_FLOOD)
+			block &= ~BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_UC);
+		else
+			block |= BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_UC);
+	}
+
+	if (flags.mask & BR_MCAST_FLOOD) {
+		if (flags.val & BR_MCAST_FLOOD) {
+			block &= ~BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_IP);
+			block &= ~BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_NON_IP);
+		} else {
+			block |= BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_IP);
+			block |= BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_UNKNOWN_MC_NON_IP);
+		}
+	}
+
+	if (flags.mask & BR_BCAST_FLOOD) {
+		if (flags.val & BR_BCAST_FLOOD)
+			block &= ~BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_BROADCAST);
+		else
+			block |= BIT(MXL862XX_BRIDGE_PORT_EGRESS_METER_BROADCAST);
+	}
+
+	if (flags.mask & BR_LEARNING)
+		priv->ports[port].learning = !!(flags.val & BR_LEARNING);
+
+	need_update = (block != old_block) || (flags.mask & BR_LEARNING);
+	if (need_update) {
+		priv->ports[port].flood_block = block;
+		ret = mxl862xx_set_bridge_port(ds, port);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_tag_protocol = mxl862xx_get_tag_protocol,
 	.setup = mxl862xx_setup,
@@ -374,6 +878,18 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.port_enable = mxl862xx_port_enable,
 	.port_disable = mxl862xx_port_disable,
 	.port_fast_age = mxl862xx_port_fast_age,
+	.set_ageing_time = mxl862xx_set_ageing_time,
+	.port_bridge_join = mxl862xx_port_bridge_join,
+	.port_bridge_leave = mxl862xx_port_bridge_leave,
+	.port_pre_bridge_flags = mxl862xx_port_pre_bridge_flags,
+	.port_bridge_flags = mxl862xx_port_bridge_flags,
+	.port_stp_state_set = mxl862xx_port_stp_state_set,
+	.port_set_host_flood = mxl862xx_port_set_host_flood,
+	.port_fdb_add = mxl862xx_port_fdb_add,
+	.port_fdb_del = mxl862xx_port_fdb_del,
+	.port_fdb_dump = mxl862xx_port_fdb_dump,
+	.port_mdb_add = mxl862xx_port_mdb_add,
+	.port_mdb_del = mxl862xx_port_mdb_del,
 };
 
 static void mxl862xx_phylink_mac_config(struct phylink_config *config,
@@ -415,6 +931,8 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 
 	priv->mdiodev = mdiodev;
 
+	INIT_LIST_HEAD(&priv->bridges);
+
 	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
 	if (!ds)
 		return -ENOMEM;
@@ -425,6 +943,8 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	ds->ops = &mxl862xx_switch_ops;
 	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
 	ds->num_ports = MXL862XX_MAX_PORTS;
+	ds->fdb_isolation = true;
+	ds->max_num_bridges = MXL862XX_MAX_BRIDGES;
 
 	dev_set_drvdata(dev, ds);
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index bfeb436942d5f..d5e1a4dee9ea7 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -7,10 +7,31 @@
 #include <net/dsa.h>
 
 #define MXL862XX_MAX_PORTS		17
+#define MXL862XX_DEFAULT_BRIDGE		0
+#define MXL862XX_MAX_BRIDGES		48
+#define MXL862XX_MAX_BRIDGE_PORTS	128
+
+struct mxl862xx_bridge {
+	unsigned int dsa_bridge_num;
+	u16 bridge_id;
+	DECLARE_BITMAP(portmap, MXL862XX_MAX_BRIDGE_PORTS);
+	struct list_head list;
+};
+
+struct mxl862xx_port {
+	u16 fid; /* single-port bridge ID (permanent) */
+	struct mxl862xx_bridge *bridge;
+	DECLARE_BITMAP(portmap, MXL862XX_MAX_BRIDGE_PORTS);
+	unsigned long flood_block; /* bitmask of meter indices with metering on */
+	bool learning;
+};
 
 struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
+	u16 drop_meter; /* single zero-rate meter shared by all ports */
+	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
+	struct list_head bridges;
 };
 
 #endif /* __MXL862XX_H */
-- 
2.53.0

