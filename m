Return-Path: <netdev+bounces-270282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBXmCnE2v2kBzAMAu9opvQ
	(envelope-from <netdev+bounces-270282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:23:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E32E7BDF
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06193017004
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E5212D7C;
	Sun, 22 Mar 2026 00:19:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA91FE451;
	Sun, 22 Mar 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138773; cv=none; b=fpAdoNJhiDOt9paRXnElQxxd0D4y7DYXo1bJqB42sdi7VN4hv0osb8SHm2+bHYP5m23RQqx9MRnk8UllBQ05owVetwHCRNxTcRE78TIPbeGjE6dnAfajyocFkDoI6eFQl4mU9RsX1Nip9znC42mDX44lHBkJlMZr8WcF810L7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138773; c=relaxed/simple;
	bh=iW50ZqxOgCd5l7erhKm18e+jHRv2l99LSowtvM0CHz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbjfREX+EJXENq5J7v7gxKNXkJZqgOrv5fU4lhQiJGUZb/h7IWK5DW92u3XPKVaXCYsZFO7mpIh2WSZlBgOHpTh60OYN9iXgBDEMFEGfiyI/plgWmG28UsXqcxsKqhAOyVBrGrPsg+ymWxFo3EqJZbPCaMR2mp18h1yM0uo29so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w46XL-000000001Oy-22AA;
	Sun, 22 Mar 2026 00:19:23 +0000
Date: Sun, 22 Mar 2026 00:19:20 +0000
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
Subject: [PATCH net-next v6 4/4] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <661d97e224faffca1b9a70fdac7c3761ef091790.1774136876.git.daniel@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-270282-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mxl862xx_mac_table_read.tci:url,makrotopia.org:email,makrotopia.org:mid,bridge_vlan_unaware.sh:url,param.tci:url]
X-Rspamd-Queue-Id: 550E32E7BDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement joining and leaving bridges as well as add, delete and dump
operations on isolated FDBs, port MDB membership management, and
setting a port's STP state.

The switch supports a maximum of 63 bridges, however, up to 12 may
be used as "single-port bridges" to isolate standalone ports.
Allowing up to 48 bridges to be offloaded seems more than enough on
that hardware, hence that is set as max_num_bridges.

A total of 128 bridge ports are supported in the bridge portmap, and
virtual bridge ports have to be used eg. for link-aggregation, hence
potentially exceeding the number of hardware ports.

The firmware-assigned bridge identifier (FID) for each offloaded bridge
is stored in dsa_bridge.priv, avoiding the need for a driver-private
bridge tracking structure. Bridge member portmaps are rebuilt on
join/leave using dsa_bridge_for_each_member().

As there are now more users of the BRIDGEPORT_CONFIG_SET API and the
state of each port is cached locally, introduce a helper function
mxl862xx_set_bridge_port(struct dsa_switch *ds, int port) which is
then used to replace the direct calls to the API in
mxl862xx_setup_cpu_bridge() and mxl862xx_add_single_port_bridge().

Note that there is no convenient way to control flooding on per-port
level, so the driver is using a 0-rate QoS meter setup as a stopper in
lack of any better option. This works, but allows a single 64-byte
packet to pass once after reset. While this limitation doesn't seem to
be a problem in practice, it has the effect that the
bridge_vlan_unaware.sh selftest only passes the FDB test the 2nd time
the test is run after boot (and any subsequent time after that, of
course).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6:
 * eliminate struct mxl862xx_bridge and driver-private bridge list,
   store firmware bridge FID in new dsa_bridge->priv instead
 * rework sync_bridge_members() to use dsa_bridge_for_each_member()
   instead of for_each_set_bit() on driver-private portmap
 * rework port_bridge_join/leave to use dsa_bridge.priv for first-
   member detection and dsa_bridge_ports() for empty-bridge check
 * derive active FID from dp->bridge->priv in set_bridge_port()
 * simplify allocate_bridge()/free_bridge() to take struct dsa_bridge
   pointer directly, drop kzalloc/kfree/list management
 * simplify get_fid() to read db.bridge.priv directly
 * remove mxl862xx_find_bridge()
 * remove unnecessary default bridge config call in setup()

v5:
 * introduce port_map helpers
 * properly implement port_mdb_{add,del} operations

v4:
 * add missing cpu_to_le32 in mxl862xx_bridge_config_fwd()
 * use little-endian 32-bit type for (unused) age_timer API field
 * better comment in port_set_host_flood() documenting architectural
   limitation
 * fix typo in comment "matche" should be "matches"
 * few whitespace fixes

v3:
 * refactor .port_bridge_join and .port_bridge_leave as requested
   by Vladimir Oltean
 * include linux/etherdevice.h which was missing and causing build
   to fail (it accidentally slipped into a follow-up patch)
 * remove left-over manual reset of learning state for port leaving
   bridge
 * remove unnecessary call to mxl862xx_port_fast_age() for port
   leaving bridge
 * add kernel-doc comments in mxl862xx.h instead of sporadic inline
   comments covering only some of the struct members
 * some other minor cosmetics (linebreaks, whitespace) here and there

v2:
 * fix kernel-doc comments in API header
 * use bitfield helpers for compound tci field in fdb API
 * add missing endian conversion for mxl862xx_stp_port_cfg.port_state
   as well as mxl862xx_mac_table_read.tci (spotted by AI review)
 * drop manually resetting port learning state on bridge<->standalone
   transitions, DSA framework takes care of that
 * don't abort updating bridge ports on error, return error at the end
 * report error in mxl862xx_port_bridge_leave()
 * create mxl862xx_get_fid() helper and use it in
   mxl862xx_port_fdb_add() and mxl862xx_port_fdb_del()
 * propagete error of callback function in mxl862xx_port_fdb_dump()
 * manually mxl862xx_port_fast_age() in mxl862xx_port_stp_state_set()
   to avoid FDB poisoning due to race condition
---
 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 225 ++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  20 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 617 ++++++++++++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h     | 103 ++++
 4 files changed, 931 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index a9f599dbca25b..8677763544d78 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -3,6 +3,7 @@
 #ifndef __MXL862XX_API_H
 #define __MXL862XX_API_H
 
+#include <linux/bits.h>
 #include <linux/if_ether.h>
 
 /**
@@ -34,6 +35,168 @@ struct mxl862xx_register_mod {
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
+#define MXL862XX_TCI_VLAN_ID		GENMASK(11, 0)
+#define MXL862XX_TCI_VLAN_CFI_DEI	BIT(12)
+#define MXL862XX_TCI_VLAN_PRI		GENMASK(15, 13)
+
+/* Set in port_id to use port_map[] as a portmap bitmap instead of a single
+ * port ID. When clear, port_id selects one port; when set, the firmware
+ * ignores the lower bits of port_id and writes port_map[] directly into
+ * the PCE bridge port map.
+ */
+#define MXL862XX_PORTMAP_FLAG		BIT(31)
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
+ *                   address matches MAC in this entry
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
+	__le32 age_timer;
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
+ * @tci: TCI for B-Step
+ *	Bit [0:11] - VLAN ID
+ *	Bit [12] - VLAN CFI/DEI
+ *	Bit [13:15] - VLAN PRI
+ * @first_bridge_port_id: The port this MAC address has first been learned.
+ *                        This is used for loop detection.
+ */
+struct mxl862xx_mac_table_read {
+	u8 initial;
+	u8 last;
+	__le16 fid;
+	__le32 port_id;
+	__le16 port_map[8];
+	__le32 age_timer;
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
+/**
+ * struct mxl862xx_mac_table_query - MAC Table Entry key-based lookup
+ * @mac: MAC Address to search for (input)
+ * @fid: Filtering Identifier (input)
+ * @found: Set by firmware: 1 if entry was found, 0 if not
+ * @port_id: Bridge Port ID (output; MSB set if portmap mode)
+ * @port_map: Bridge Port Map (output; valid for static entries)
+ * @sub_if_id: Sub-Interface Identifier Destination
+ * @age_timer: Aging Time
+ * @vlan_id: STAG VLAN Id
+ * @static_entry: Indicates if this is a Static Entry
+ * @filter_flag: See &enum mxl862xx_mac_table_filter (input+output)
+ * @igmp_controlled: IGMP controlled flag
+ * @entry_changed: Entry changed flag
+ * @associated_mac: Associated MAC address
+ * @hit_status: MAC Table Hit Status Update
+ * @tci: TCI (VLAN ID + CFI/DEI + PRI) (input)
+ * @first_bridge_port_id: First learned bridge port
+ */
+struct mxl862xx_mac_table_query {
+	u8 mac[ETH_ALEN];
+	__le16 fid;
+	u8 found;
+	__le32 port_id;
+	__le16 port_map[8];
+	__le16 sub_if_id;
+	__le32 age_timer;
+	__le16 vlan_id;
+	u8 static_entry;
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
@@ -138,6 +301,40 @@ enum mxl862xx_bridge_port_egress_meter {
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
@@ -456,7 +653,7 @@ struct mxl862xx_pmapper {
  */
 struct mxl862xx_bridge_port_config {
 	__le16 bridge_port_id;
-	__le32 mask; /* enum mxl862xx_bridge_port_config_mask  */
+	__le32 mask; /* enum mxl862xx_bridge_port_config_mask */
 	__le16 bridge_id;
 	u8 ingress_extended_vlan_enable;
 	__le16 ingress_extended_vlan_block_id;
@@ -658,6 +855,32 @@ struct mxl862xx_ctp_port_assignment {
 	__le16 bridge_port_id;
 } __packed;
 
+/**
+ * enum mxl862xx_stp_port_state - Spanning Tree Protocol port states
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
+ * struct mxl862xx_stp_port_cfg - Configures the Spanning Tree Protocol state
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
index f6852ade64e7c..9f6c5bf9fdf21 100644
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
@@ -35,14 +38,23 @@
 
 #define MXL862XX_CTP_PORTASSIGNMENTSET	(MXL862XX_CTP_MAGIC + 0x3)
 
+#define MXL862XX_QOS_METERCFGSET	(MXL862XX_QOS_MAGIC + 0x2)
+#define MXL862XX_QOS_METERALLOC		(MXL862XX_QOS_MAGIC + 0x2a)
+
+#define MXL862XX_MAC_TABLEENTRYADD	(MXL862XX_SWMAC_MAGIC + 0x2)
+#define MXL862XX_MAC_TABLEENTRYREAD	(MXL862XX_SWMAC_MAGIC + 0x3)
+#define MXL862XX_MAC_TABLEENTRYQUERY	(MXL862XX_SWMAC_MAGIC + 0x4)
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
index c825704c9e9ec..bef66e3327e2d 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -7,8 +7,11 @@
  * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
  */
 
-#include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
@@ -36,6 +39,13 @@
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
@@ -168,6 +178,66 @@ static int mxl862xx_setup_mdio(struct dsa_switch *ds)
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
+	bridge_config.forward_unknown_unicast = cpu_to_le32(ucast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD);
+
+	bridge_config.forward_unknown_multicast_ip = cpu_to_le32(mcast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD);
+	bridge_config.forward_unknown_multicast_non_ip =
+		bridge_config.forward_unknown_multicast_ip;
+
+	bridge_config.forward_broadcast = cpu_to_le32(bcast_flood ?
+		MXL862XX_BRIDGE_FORWARD_FLOOD : MXL862XX_BRIDGE_FORWARD_DISCARD);
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
@@ -181,6 +251,10 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	ret = mxl862xx_setup_drop_meter(ds);
+	if (ret)
+		return ret;
+
 	return mxl862xx_setup_mdio(ds);
 }
 
@@ -258,64 +332,207 @@ static int mxl862xx_configure_sp_tag_proto(struct dsa_switch *ds, int port,
 	return MXL862XX_API_WRITE(ds->priv, MXL862XX_SS_SPTAG_SET, tag);
 }
 
-static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
+static int mxl862xx_set_bridge_port(struct dsa_switch *ds, int port)
 {
 	struct mxl862xx_bridge_port_config br_port_cfg = {};
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mxl862xx_priv *priv = ds->priv;
-	u16 bridge_port_map = 0;
-	struct dsa_port *dp;
+	struct mxl862xx_port *p = &priv->ports[port];
+	u16 bridge_id = dp->bridge ?
+		(u16)(uintptr_t)dp->bridge->priv : p->fid;
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
+	mxl862xx_fw_portmap_from_bitmap(br_port_cfg.bridge_port_map, p->portmap);
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
+static int mxl862xx_allocate_bridge(struct dsa_switch *ds,
+				    struct dsa_bridge *bridge)
+{
+	struct mxl862xx_bridge_alloc br_alloc = {};
+	struct mxl862xx_priv *priv = ds->priv;
+	u16 fw_id;
+	int ret;
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
+	if (ret)
+		return ret;
+
+	fw_id = le16_to_cpu(br_alloc.bridge_id);
+
+	ret = mxl862xx_bridge_config_fwd(ds, fw_id, true, true, true);
+	if (ret) {
+		br_alloc.bridge_id = cpu_to_le16(fw_id);
+		MXL862XX_API_WRITE(priv, MXL862XX_BRIDGE_FREE, br_alloc);
+		return ret;
+	}
 
-	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
+	bridge->priv = (void *)(uintptr_t)fw_id;
+	return 0;
+}
+
+static void mxl862xx_free_bridge(struct dsa_switch *ds,
+				 struct dsa_bridge *bridge)
+{
+	u16 fw_id = (u16)(uintptr_t)bridge->priv;
+	struct mxl862xx_bridge_alloc br_alloc = {
+		.bridge_id = cpu_to_le16(fw_id),
+	};
+	int ret;
+
+	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGE_FREE, br_alloc);
+	if (ret) {
+		dev_err(ds->dev, "failed to free fw bridge %u: %pe\n",
+			fw_id, ERR_PTR(ret));
+		return;
+	}
+
+	bridge->priv = NULL;
+}
+
+static int mxl862xx_sync_bridge_members(struct dsa_switch *ds,
+					const struct dsa_bridge *bridge)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct dsa_port *dp, *member_dp;
+	int err, ret = 0;
+
+	dsa_bridge_for_each_member(dp, ds, bridge) {
+		int port = dp->index;
+
+		bitmap_zero(priv->ports[port].portmap,
+			    MXL862XX_MAX_BRIDGE_PORTS);
+
+		dsa_bridge_for_each_member(member_dp, ds, bridge) {
+			if (member_dp->index != port)
+				__set_bit(member_dp->index,
+					  priv->ports[port].portmap);
+		}
+		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
+
+		err = mxl862xx_set_bridge_port(ds, port);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge,
+				     bool *tx_fwd_offload,
+				     struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	int ret;
+
+	if (!dp->bridge->priv) {
+		ret = mxl862xx_allocate_bridge(ds, dp->bridge);
+		if (ret)
+			return ret;
+	}
+
+	return mxl862xx_sync_bridge_members(ds, &bridge);
+}
+
+static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				       struct dsa_bridge bridge)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_port *p = &priv->ports[port];
+	int err;
+
+	err = mxl862xx_sync_bridge_members(ds, &bridge);
+	if (err)
+		dev_err(ds->dev,
+			"failed to sync bridge members after port %d left: %pe\n",
+			port, ERR_PTR(err));
+
+	/* Revert leaving port, omitted by the sync above, to its
+	 * single-port bridge
+	 */
+	bitmap_zero(p->portmap, MXL862XX_MAX_BRIDGE_PORTS);
+	__set_bit(dp->cpu_dp->index, p->portmap);
+	p->flood_block = 0;
+	err = mxl862xx_set_bridge_port(ds, port);
+	if (err)
+		dev_err(ds->dev,
+			"failed to update bridge port %d state: %pe\n", port,
+			ERR_PTR(err));
+
+	if (!dsa_bridge_ports(ds, &bridge))
+		mxl862xx_free_bridge(ds, &bridge);
 }
 
 static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
@@ -365,6 +582,334 @@ static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 		  config->supported_interfaces);
 }
 
+static int mxl862xx_get_fid(struct dsa_switch *ds, struct dsa_db db)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	switch (db.type) {
+	case DSA_DB_PORT:
+		return priv->ports[db.dp->index].fid;
+
+	case DSA_DB_BRIDGE:
+		if (!db.bridge.priv)
+			return -ENOENT;
+		return (u16)(uintptr_t)db.bridge.priv;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mxl862xx_port_fdb_add(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct mxl862xx_mac_table_add param = { };
+	int fid = mxl862xx_get_fid(ds, db), ret;
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (fid < 0)
+		return fid;
+
+	param.port_id = cpu_to_le32(port);
+	param.static_entry = true;
+	param.fid = cpu_to_le16(fid);
+	param.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, vid));
+	ether_addr_copy(param.mac, addr);
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
+	int fid = mxl862xx_get_fid(ds, db), ret;
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (fid < 0)
+		return fid;
+
+	param.fid = cpu_to_le16(fid);
+	param.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, vid));
+	ether_addr_copy(param.mac, addr);
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
+		if (entry_port_id == port) {
+			ret = cb(param.mac, FIELD_GET(MXL862XX_TCI_VLAN_ID,
+						      le16_to_cpu(param.tci)),
+				 param.static_entry, data);
+			if (ret)
+				return ret;
+		}
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
+	struct mxl862xx_mac_table_query qparam = {};
+	struct mxl862xx_mac_table_add aparam = {};
+	struct mxl862xx_priv *priv = ds->priv;
+	int fid, ret;
+
+	fid = mxl862xx_get_fid(ds, db);
+	if (fid < 0)
+		return fid;
+
+	/* Look up existing entry by {MAC, FID, TCI} */
+	ether_addr_copy(qparam.mac, mdb->addr);
+	qparam.fid = cpu_to_le16(fid);
+	qparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	if (ret)
+		return ret;
+
+	/* Build the ADD command using portmap mode */
+	ether_addr_copy(aparam.mac, mdb->addr);
+	aparam.fid = cpu_to_le16(fid);
+	aparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
+	aparam.static_entry = true;
+	aparam.port_id = cpu_to_le32(MXL862XX_PORTMAP_FLAG);
+
+	/* Merge with existing portmap if entry already exists */
+	if (qparam.found)
+		memcpy(aparam.port_map, qparam.port_map,
+		       sizeof(aparam.port_map));
+
+	mxl862xx_fw_portmap_set_bit(aparam.port_map, port);
+
+	return MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, aparam);
+}
+
+static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_mdb *mdb,
+				 struct dsa_db db)
+{
+	struct mxl862xx_mac_table_remove rparam = {};
+	struct mxl862xx_mac_table_query qparam = {};
+	struct mxl862xx_mac_table_add aparam = {};
+	int fid = mxl862xx_get_fid(ds, db), ret;
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (fid < 0)
+		return fid;
+
+	/* Look up existing entry */
+	qparam.fid = cpu_to_le16(fid);
+	qparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
+	ether_addr_copy(qparam.mac, mdb->addr);
+
+	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	if (ret)
+		return ret;
+
+	if (!qparam.found)
+		return 0;
+
+	mxl862xx_fw_portmap_clear_bit(qparam.port_map, port);
+
+	if (mxl862xx_fw_portmap_is_empty(qparam.port_map)) {
+		/* No ports left — remove the entry entirely */
+		rparam.fid = cpu_to_le16(fid);
+		rparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
+		ether_addr_copy(rparam.mac, mdb->addr);
+		ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYREMOVE, rparam);
+	} else {
+		/* Write back with reduced portmap */
+		aparam.fid = cpu_to_le16(fid);
+		aparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
+		ether_addr_copy(aparam.mac, mdb->addr);
+		aparam.static_entry = true;
+		aparam.port_id = cpu_to_le32(MXL862XX_PORTMAP_FLAG);
+		memcpy(aparam.port_map, qparam.port_map, sizeof(aparam.port_map));
+		ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, aparam);
+	}
+
+	return ret;
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
+		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
+		break;
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_BLOCKING);
+		break;
+	case BR_STATE_LEARNING:
+		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_LEARNING);
+		break;
+	case BR_STATE_FORWARDING:
+		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_FORWARD);
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
+	/* The firmware may re-enable MAC learning as a side-effect of entering
+	 * LEARNING or FORWARDING state (per 802.1D defaults).
+	 * Re-apply the driver's intended learning and metering config so that
+	 * standalone ports keep learning disabled.
+	 * This is likely to get fixed in future firmware releases, however,
+	 * the additional API call even then doesn't hurt much.
+	 */
+	ret = mxl862xx_set_bridge_port(ds, port);
+	if (ret)
+		dev_err(ds->dev, "failed to reapply brport flags on port %d\n",
+			port);
+
+	mxl862xx_port_fast_age(ds, port);
+}
+
+static void mxl862xx_port_set_host_flood(struct dsa_switch *ds, int port,
+					 bool uc, bool mc)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	/* The hardware controls unknown-unicast/multicast forwarding per FID
+	 * (bridge), not per source port. For bridged ports all members share
+	 * one FID, so we cannot selectively suppress flooding to the CPU for
+	 * one source port while allowing it for another. Silently ignore the
+	 * request - the excess flooding towards the CPU is harmless.
+	 */
+	if (dsa_port_bridge_dev_get(dsa_to_port(ds, port)))
+		return;
+
+	/* Use the bridge-level forwarding configuration of the port's
+	 * single-port bridge to control host flooding for standalone ports.
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
@@ -373,6 +918,18 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
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
@@ -424,6 +981,8 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	ds->ops = &mxl862xx_switch_ops;
 	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
 	ds->num_ports = MXL862XX_MAX_PORTS;
+	ds->fdb_isolation = true;
+	ds->max_num_bridges = MXL862XX_MAX_BRIDGES;
 
 	dev_set_drvdata(dev, ds);
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index bfeb436942d5f..11c139f687aa9 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -7,10 +7,113 @@
 #include <net/dsa.h>
 
 #define MXL862XX_MAX_PORTS		17
+#define MXL862XX_DEFAULT_BRIDGE		0
+#define MXL862XX_MAX_BRIDGES		48
+#define MXL862XX_MAX_BRIDGE_PORTS	128
 
+/* Number of __le16 words in a firmware portmap (128-bit bitmap). */
+#define MXL862XX_FW_PORTMAP_WORDS	(MXL862XX_MAX_BRIDGE_PORTS / 16)
+
+/**
+ * mxl862xx_fw_portmap_from_bitmap - convert a kernel bitmap to a firmware
+ *                                   portmap (__le16[8])
+ * @dst: firmware portmap array (MXL862XX_FW_PORTMAP_WORDS entries)
+ * @src: kernel bitmap of at least MXL862XX_MAX_BRIDGE_PORTS bits
+ */
+static inline void
+mxl862xx_fw_portmap_from_bitmap(__le16 *dst, const unsigned long *src)
+{
+	int i;
+
+	for (i = 0; i < MXL862XX_FW_PORTMAP_WORDS; i++)
+		dst[i] = cpu_to_le16(bitmap_read(src, i * 16, 16));
+}
+
+/**
+ * mxl862xx_fw_portmap_to_bitmap - convert a firmware portmap (__le16[8]) to
+ *                                 a kernel bitmap
+ * @dst: kernel bitmap of at least MXL862XX_MAX_BRIDGE_PORTS bits
+ * @src: firmware portmap array (MXL862XX_FW_PORTMAP_WORDS entries)
+ */
+static inline void
+mxl862xx_fw_portmap_to_bitmap(unsigned long *dst, const __le16 *src)
+{
+	int i;
+
+	bitmap_zero(dst, MXL862XX_MAX_BRIDGE_PORTS);
+	for (i = 0; i < MXL862XX_FW_PORTMAP_WORDS; i++)
+		bitmap_write(dst, le16_to_cpu(src[i]), i * 16, 16);
+}
+
+/**
+ * mxl862xx_fw_portmap_set_bit - set a single port bit in a firmware portmap
+ * @map: firmware portmap array (MXL862XX_FW_PORTMAP_WORDS entries)
+ * @port: port index (0..MXL862XX_MAX_BRIDGE_PORTS-1)
+ */
+static inline void mxl862xx_fw_portmap_set_bit(__le16 *map, int port)
+{
+	map[port / 16] |= cpu_to_le16(BIT(port % 16));
+}
+
+/**
+ * mxl862xx_fw_portmap_clear_bit - clear a single port bit in a firmware portmap
+ * @map: firmware portmap array (MXL862XX_FW_PORTMAP_WORDS entries)
+ * @port: port index (0..MXL862XX_MAX_BRIDGE_PORTS-1)
+ */
+static inline void mxl862xx_fw_portmap_clear_bit(__le16 *map, int port)
+{
+	map[port / 16] &= ~cpu_to_le16(BIT(port % 16));
+}
+
+/**
+ * mxl862xx_fw_portmap_is_empty - check whether a firmware portmap has no
+ *                                bits set
+ * @map: firmware portmap array (MXL862XX_FW_PORTMAP_WORDS entries)
+ *
+ * Return: true if every word in @map is zero.
+ */
+static inline bool mxl862xx_fw_portmap_is_empty(const __le16 *map)
+{
+	int i;
+
+	for (i = 0; i < MXL862XX_FW_PORTMAP_WORDS; i++)
+		if (map[i])
+			return false;
+	return true;
+}
+
+/**
+ * struct mxl862xx_port - per-port state tracked by the driver
+ * @fid:         firmware FID for the permanent single-port bridge; kept alive
+ *               for the lifetime of the port so traffic is never forwarded
+ *               while the port is unbridged
+ * @portmap:     bitmap of switch port indices that share the current bridge
+ *               with this port
+ * @flood_block: bitmask of firmware meter indices that are currently
+ *               rate-limiting flood traffic on this port (zero-rate meters
+ *               used to block flooding)
+ * @learning:    true when address learning is enabled on this port
+ */
+struct mxl862xx_port {
+	u16 fid;
+	DECLARE_BITMAP(portmap, MXL862XX_MAX_BRIDGE_PORTS);
+	unsigned long flood_block;
+	bool learning;
+};
+
+/**
+ * struct mxl862xx_priv - driver private data for an MxL862xx switch
+ * @ds:            pointer to the DSA switch instance
+ * @mdiodev:       MDIO device used to communicate with the switch firmware
+ * @drop_meter:    index of the single shared zero-rate firmware meter used
+ *                 to unconditionally drop traffic (used to block flooding)
+ * @ports:         per-port state, indexed by switch port number
+ */
 struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
+	u16 drop_meter;
+	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 };
 
 #endif /* __MXL862XX_H */
-- 
2.53.0

