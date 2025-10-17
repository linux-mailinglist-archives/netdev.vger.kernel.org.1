Return-Path: <netdev+bounces-230441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DFBE831B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57D875817EA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E932321457;
	Fri, 17 Oct 2025 10:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589431BC82
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698088; cv=none; b=isFhSQzMlgrv7b2qrtXBExzT5ykiWdLVGyKi/6+xLv5NcjjhyZm6yK8VMgRA8RHGLaiTY4xfMoVyhbi4b+ZyrM6NBVdFWzrSbUpkrQRqlUbUhy4Mx0wOR89rUolsH+J2c1/KMG3x79xCYW8ejJ//M4/8BZcp4M6dKYHFM4r+Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698088; c=relaxed/simple;
	bh=svKB98Cmtc3um+1kxpR7ruKPhpllb44dk+M1FmOMqY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLRyl4/jRlXUWO9bxy1RDkPzNqPaQZs2OkXezh/AB5134XG8YqXYdizu5sXTnw/0GUYQRkoZ4/yfAWKKEZA9KVRCvkj381rlus3VdyLuMt/aCQMUmPFkSSCvKtV1xsZI1yxPxVV6sOjlmw6RG/NVjtHX4ciqDDAxkOOSy+hXMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzn-0000AI-1j; Fri, 17 Oct 2025 12:47:39 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0042n5-0g;
	Fri, 17 Oct 2025 12:47:37 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0000000F0AS-0ROM;
	Fri, 17 Oct 2025 12:47:37 +0200
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
Subject: [PATCH net-next v6 2/5] ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Date: Fri, 17 Oct 2025 12:47:29 +0200
Message-ID: <20251017104732.3575484-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017104732.3575484-1-o.rempel@pengutronix.de>
References: <20251017104732.3575484-1-o.rempel@pengutronix.de>
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

Introduce the userspace entry point for PHY MSE diagnostics via
ethtool netlink. This exposes the core API added previously and
returns both capability information and one or more snapshots.

Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
selector. The reply carries:
  - ETHTOOL_A_MSE_CAPABILITIES: scale limits, timing, and supported
    capability bitmask
  - ETHTOOL_A_MSE_CHANNEL_* nests: one or more snapshots (per-channel
    if available, otherwise WORST, otherwise LINK)

If no channel is requested, the kernel returns snapshots for all
supported selectors. Requests for unsupported selectors fail with
-EOPNOTSUPP; link down returns -ENETDOWN.

Changes:
  - YAML: add attribute sets (mse, mse-capabilities, mse-snapshot)
    and the mse-get operation
  - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
    ETHTOOL_MSG_MSE_GET/REPLY
  - ethtool core: add net/ethtool/mse.c implementing the request,
    register genl op, and hook into ethnl dispatch
  - docs: document MSE_GET in ethtool-netlink.rst

The include/uapi/linux/ethtool_netlink_generated.h is generated
from Documentation/netlink/specs/ethtool.yaml.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- YAML: rename mse-config -> mse-capabilities;
        rename top-level attr "config" -> "capabilities".
- YAML: drop all explicit UNSPEC entries; start enums at 1 with _CNT/_MAX tails.
- YAML: switch scalar fields to type: uint; remove pad attrs.
- YAML: per-channel reply layout:
        replace multi-attr "snapshot" with fixed nests
        ETHTOOL_A_MSE_CHANNEL_A/B/C/D/WORST_CHANNEL/LINK;
	drop inner "channel" field.
- UAPI: regenerate include/uapi/linux/ethtool_netlink_generated.h
- mse.c: implement capabilities container and per-channel snapshot nests;
        use nla_put_uint() for all YAML uint fields; size using sizeof(u64) in
	reply_size(); no pad usage.
- mse.c: encode supported-caps with ethnl_bitset32_size()/ethnl_put_bitset32();
- mse.c: return -ENETDOWN on link down (commit message updated accordingly).
- docs: ethtool-netlink.rst updated to new attribute names/layout and
        terminology (capabilities, per-channel nests).
changes v5:
- add struct phy_mse_snapshot and phy_mse_config in the documentation
changes v4:
- s/__ethtool-a-mse/--ethtool-a-mse
- remove duplicate kernel-doc line
- fix htmldocs compile warnings
---
 Documentation/netlink/specs/ethtool.yaml      |  94 ++++
 Documentation/networking/ethtool-netlink.rst  |  71 +++
 include/uapi/linux/ethtool.h                  |   2 +
 .../uapi/linux/ethtool_netlink_generated.h    |  37 ++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/common.c                          |  13 +
 net/ethtool/common.h                          |   2 +
 net/ethtool/mse.c                             | 411 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 +
 net/ethtool/netlink.h                         |   2 +
 net/ethtool/strset.c                          |   5 +
 11 files changed, 648 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/mse.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4c352f36d57d..a4531500dfb5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1914,6 +1914,80 @@ attribute-sets:
         type: uint
         enum: pse-event
         doc: List of events reported by the PSE controller
+  -
+    name: mse-capabilities
+    attr-cnt-name: --ethtool-a-mse-capabilities-cnt
+    attributes:
+      -
+        name: max-average-mse
+        type: uint
+      -
+        name: max-peak-mse
+        type: uint
+      -
+        name: refresh-rate-ps
+        type: uint
+      -
+        name: num-symbols
+        type: uint
+      -
+        name: supported-caps
+        type: nest
+        nested-attributes: bitset
+        enum: phy-mse-capability
+  -
+    name: mse-snapshot
+    attr-cnt-name: --ethtool-a-mse-snapshot-cnt
+    attributes:
+      -
+        name: average-mse
+        type: uint
+      -
+        name: peak-mse
+        type: uint
+      -
+        name: worst-peak-mse
+        type: uint
+  -
+    name: mse
+    attr-cnt-name: --ethtool-a-mse-cnt
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: channel
+        type: uint
+        enum: phy-mse-channel
+      -
+        name: capabilities
+        type: nest
+        nested-attributes: mse-capabilities
+      -
+        name: channel-a
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-b
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-c
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: channel-d
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: worst-channel
+        type: nest
+        nested-attributes: mse-snapshot
+      -
+        name: link
+        type: nest
+        nested-attributes: mse-snapshot
 
 operations:
   enum-model: directional
@@ -2847,6 +2921,26 @@ operations:
         attributes:
           - header
           - context
+    -
+      name: mse-get
+      doc: Get PHY MSE measurement data and capabilities.
+      attribute-set: mse
+      do: &mse-get-op
+        request:
+          attributes:
+            - header
+            - channel
+        reply:
+          attributes:
+            - header
+            - capabilities
+            - channel-a
+            - channel-b
+            - channel-c
+            - channel-d
+            - worst-channel
+            - link
+      dump: *mse-get-op
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b270886c5f5d..3206f791f56d 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -242,6 +242,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_SET``               set RSS settings
   ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
   ``ETHTOOL_MSG_RSS_DELETE_ACT``        delete an additional RSS context
+  ``ETHTOOL_MSG_MSE_GET``               get MSE diagnostic data
   ===================================== =================================
 
 Kernel to userspace:
@@ -299,6 +300,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_RSS_CREATE_ACT_REPLY``     create an additional RSS context
   ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
   ``ETHTOOL_MSG_RSS_DELETE_NTF``           additional RSS context deleted
+  ``ETHTOOL_MSG_MSE_GET_REPLY``            MSE diagnostic data
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2458,6 +2460,75 @@ Kernel response contents:
 
 For a description of each attribute, see ``TSCONFIG_GET``.
 
+MSE_GET
+=======
+
+Retrieves detailed Mean Square Error (MSE) diagnostic information from the PHY.
+
+Request Contents:
+
+  ====================================  ======  ============================
+  ``ETHTOOL_A_MSE_HEADER``              nested  request header
+  ``ETHTOOL_A_MSE_CHANNEL``             uint    optional channel enum value
+  ====================================  ======  ============================
+
+.. kernel-doc:: include/uapi/linux/ethtool_netlink_generated.h
+    :identifiers: ethtool_phy_mse_channel
+
+The optional ``ETHTOOL_A_MSE_CHANNEL`` attribute allows the caller to request
+data for a specific channel. If omitted, the kernel will return snapshots for
+all supported channels.
+
+Kernel Response Contents:
+
+  ====================================  ======  ================================
+  ``ETHTOOL_A_MSE_HEADER``              nested  reply header
+  ``ETHTOOL_A_MSE_CAPABILITIES``        nested  capability/scale info for MSE
+                                                measurements
+  ``ETHTOOL_A_MSE_CHANNEL_A``           nested  snapshot for Channel A
+  ``ETHTOOL_A_MSE_CHANNEL_B``           nested  snapshot for Channel B
+  ``ETHTOOL_A_MSE_CHANNEL_C``           nested  snapshot for Channel C
+  ``ETHTOOL_A_MSE_CHANNEL_D``           nested  snapshot for Channel D
+  ``ETHTOOL_A_MSE_WORST_CHANNEL``       nested  snapshot for worst channel
+  ``ETHTOOL_A_MSE_LINK``                nested  snapshot for link-wide aggregate
+  ====================================  ======  ================================
+
+MSE Capabilities
+----------------
+
+This nested attribute reports the capability / scaling properties used to
+interpret snapshot values.
+
+  ===========================================    ======  =========================
+  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE`` uint    max avg_mse scale
+  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE``    uint    max peak_mse scale
+  ``ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS`` uint    sample rate (picoseconds)
+  ``ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS``     uint    symbols per HW sample
+  ``ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS``  bitset  bitmask of
+                                                         phy_mse_capability
+  ===========================================    ======  =========================
+
+.. kernel-doc:: include/uapi/linux/ethtool_netlink_generated.h
+    :identifiers: ethtool_phy_mse_capability
+
+See ``struct phy_mse_capability`` kernel documentation in
+``include/linux/phy.h``.
+
+MSE Snapshot
+------------
+
+Each per-channel nest contains an atomic snapshot of MSE values for that
+selector (channel A/B/C/D, worst channel, or link).
+
+  ==========================================  ======  ===================
+  ``ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE``      uint    average MSE value
+  ``ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE``         uint    current peak MSE
+  ``ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE``   uint    worst-case peak MSE
+  ==========================================  ======  ===================
+
+See ``struct phy_mse_snapshot`` kernel documentation in
+``include/linux/phy.h``.
+
 Request translation
 ===================
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8bd5ea5469d9..df9bbfdb2a09 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -683,6 +683,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_RMON: names of RMON statistics
  * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
  * @ETH_SS_TS_FLAGS: hardware timestamping flags
+ * @ETH_SS_MSE_CAPS: Mean Square Error (MSE) capability bit names
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -710,6 +711,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_RMON,
 	ETH_SS_STATS_PHY,
 	ETH_SS_TS_FLAGS,
+	ETH_SS_MSE_CAPS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 03954c324ff8..481aadf8cdba 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -872,6 +872,41 @@ enum {
 	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+	ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+	ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+	ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS,
+
+	__ETHTOOL_A_MSE_CAPABILITIES_CNT,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX = (__ETHTOOL_A_MSE_CAPABILITIES_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+	ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+
+	__ETHTOOL_A_MSE_SNAPSHOT_CNT,
+	ETHTOOL_A_MSE_SNAPSHOT_MAX = (__ETHTOOL_A_MSE_SNAPSHOT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_HEADER = 1,
+	ETHTOOL_A_MSE_CHANNEL,
+	ETHTOOL_A_MSE_CAPABILITIES,
+	ETHTOOL_A_MSE_CHANNEL_A,
+	ETHTOOL_A_MSE_CHANNEL_B,
+	ETHTOOL_A_MSE_CHANNEL_C,
+	ETHTOOL_A_MSE_CHANNEL_D,
+	ETHTOOL_A_MSE_WORST_CHANNEL,
+	ETHTOOL_A_MSE_LINK,
+
+	__ETHTOOL_A_MSE_CNT,
+	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -924,6 +959,7 @@ enum {
 	ETHTOOL_MSG_RSS_SET,
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
+	ETHTOOL_MSG_MSE_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -984,6 +1020,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
+	ETHTOOL_MSG_MSE_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 1e493553b977..629c10916670 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o
+		   phy.o tsconfig.o mse.o
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..42c7f33f1c8c 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -521,6 +521,19 @@ const char udp_tunnel_type_names[][ETH_GSTRING_LEN] = {
 static_assert(ARRAY_SIZE(udp_tunnel_type_names) ==
 	      __ETHTOOL_UDP_TUNNEL_TYPE_CNT);
 
+const char mse_cap_names[][ETH_GSTRING_LEN] = {
+	[const_ilog2(PHY_MSE_CAP_CHANNEL_A)]		= "channel-a",
+	[const_ilog2(PHY_MSE_CAP_CHANNEL_B)]		= "channel-b",
+	[const_ilog2(PHY_MSE_CAP_CHANNEL_C)]		= "channel-c",
+	[const_ilog2(PHY_MSE_CAP_CHANNEL_D)]		= "channel-d",
+	[const_ilog2(PHY_MSE_CAP_WORST_CHANNEL)]	= "worst-channel",
+	[const_ilog2(PHY_MSE_CAP_LINK)]			= "link",
+	[const_ilog2(PHY_MSE_CAP_AVG)]			= "average-mse",
+	[const_ilog2(PHY_MSE_CAP_PEAK)]			= "peak-mse",
+	[const_ilog2(PHY_MSE_CAP_WORST_PEAK)]		= "worst-peak-mse",
+};
+static_assert(ARRAY_SIZE(mse_cap_names) == __MSE_CAP_CNT);
+
 /* return false if legacy contained non-0 deprecated fields
  * maxtxpkt/maxrxpkt. rest of ksettings always updated
  */
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 1609cf4e53eb..da4af3d69e3e 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -14,6 +14,7 @@
 
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 #define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
+#define __MSE_CAP_CNT (const_ilog2(PHY_MSE_CAP_MASK) + 1)
 
 struct genl_info;
 struct hwtstamp_provider_desc;
@@ -34,6 +35,7 @@ extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
 extern const char ts_flags_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
+extern const char mse_cap_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
 
diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
new file mode 100644
index 000000000000..89365bdb1109
--- /dev/null
+++ b/net/ethtool/mse.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+
+#include "netlink.h"
+#include "common.h"
+#include "bitset.h"
+
+#define PHY_MSE_CHANNEL_COUNT 4
+
+struct mse_req_info {
+	struct ethnl_req_info base;
+};
+
+struct mse_snapshot_entry {
+	struct phy_mse_snapshot snapshot;
+	int channel;
+};
+
+struct mse_reply_data {
+	struct ethnl_reply_data base;
+	struct phy_mse_capability capability;
+	struct mse_snapshot_entry *snapshots;
+	unsigned int num_snapshots;
+};
+
+static inline struct mse_reply_data *
+mse_repdata(const struct ethnl_reply_data *reply_base)
+{
+	return container_of(reply_base, struct mse_reply_data, base);
+}
+
+const struct nla_policy ethnl_mse_get_policy[] = {
+	[ETHTOOL_A_MSE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_phy),
+	[ETHTOOL_A_MSE_CHANNEL] = { .type = NLA_U32 },
+};
+
+static inline int mse_caps_size(u32 caps, bool compact)
+{
+	return ethnl_bitset32_size(&caps, NULL, __MSE_CAP_CNT,
+				   mse_cap_names, compact);
+}
+
+static inline int mse_caps_put(struct sk_buff *skb, int attrtype,
+			       u32 caps, bool compact)
+{
+	return ethnl_put_bitset32(skb, attrtype, &caps, NULL,
+				  __MSE_CAP_CNT, mse_cap_names, compact);
+}
+
+static int get_snapshot_if_supported(struct phy_device *phydev,
+				     struct mse_reply_data *data,
+				     unsigned int *idx, u32 cap_bit,
+				     int channel_id)
+{
+	int ret;
+
+	if (data->capability.supported_caps & cap_bit) {
+		ret = phydev->drv->get_mse_snapshot(phydev, channel_id,
+					&data->snapshots[*idx].snapshot);
+		if (ret)
+			return ret;
+		data->snapshots[*idx].channel = channel_id;
+		(*idx)++;
+	}
+
+	return 0;
+}
+
+static int mse_get_channels(struct phy_device *phydev,
+			    struct mse_reply_data *data)
+{
+	unsigned int i = 0;
+	int ret;
+
+	if (!data->capability.supported_caps)
+		return 0;
+
+	data->snapshots = kcalloc(PHY_MSE_CHANNEL_COUNT,
+				  sizeof(*data->snapshots), GFP_KERNEL);
+	if (!data->snapshots)
+		return -ENOMEM;
+
+	/* Priority 1: Individual channels */
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_A,
+					PHY_MSE_CHANNEL_A);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_B,
+					PHY_MSE_CHANNEL_B);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_C,
+					PHY_MSE_CHANNEL_C);
+	if (ret)
+		return ret;
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_CHANNEL_D,
+					PHY_MSE_CHANNEL_D);
+	if (ret)
+		return ret;
+
+	/* If any individual channels were found, we are done. */
+	if (i > 0) {
+		data->num_snapshots = i;
+		return 0;
+	}
+
+	/* Priority 2: Worst channel, if no individual channels supported. */
+	ret = get_snapshot_if_supported(phydev, data, &i,
+					PHY_MSE_CAP_WORST_CHANNEL,
+					PHY_MSE_CHANNEL_WORST);
+	if (ret)
+		return ret;
+
+	/* If worst channel was found, we are done. */
+	if (i > 0) {
+		data->num_snapshots = i;
+		return 0;
+	}
+
+	/* Priority 3: Link-wide, if nothing else is supported. */
+	ret = get_snapshot_if_supported(phydev, data, &i, PHY_MSE_CAP_LINK,
+					PHY_MSE_CHANNEL_LINK);
+	if (ret)
+		return ret;
+
+	data->num_snapshots = i;
+	return 0;
+}
+
+static int mse_get_one_channel(struct phy_device *phydev,
+			       struct mse_reply_data *data, int channel)
+{
+	u32 cap_bit = 0;
+	int ret;
+
+	switch (channel) {
+	case PHY_MSE_CHANNEL_A:
+		cap_bit = PHY_MSE_CAP_CHANNEL_A;
+		break;
+	case PHY_MSE_CHANNEL_B:
+		cap_bit = PHY_MSE_CAP_CHANNEL_B;
+		break;
+	case PHY_MSE_CHANNEL_C:
+		cap_bit = PHY_MSE_CAP_CHANNEL_C;
+		break;
+	case PHY_MSE_CHANNEL_D:
+		cap_bit = PHY_MSE_CAP_CHANNEL_D;
+		break;
+	case PHY_MSE_CHANNEL_WORST:
+		cap_bit = PHY_MSE_CAP_WORST_CHANNEL;
+		break;
+	case PHY_MSE_CHANNEL_LINK:
+		cap_bit = PHY_MSE_CAP_LINK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!(data->capability.supported_caps & cap_bit))
+		return -EOPNOTSUPP;
+
+	data->snapshots = kzalloc(sizeof(*data->snapshots), GFP_KERNEL);
+	if (!data->snapshots)
+		return -ENOMEM;
+
+	ret = phydev->drv->get_mse_snapshot(phydev, channel,
+					    &data->snapshots[0].snapshot);
+	if (ret)
+		return ret;
+
+	data->snapshots[0].channel = channel;
+	data->num_snapshots = 1;
+	return 0;
+}
+
+static int mse_prepare_data(const struct ethnl_req_info *req_base,
+			    struct ethnl_reply_data *reply_base,
+			    const struct genl_info *info)
+{
+	struct mse_reply_data *data = mse_repdata(reply_base);
+	struct net_device *dev = reply_base->dev;
+	struct phy_device *phydev;
+	int ret;
+
+	phydev = ethnl_req_get_phydev(req_base, info->attrs,
+				      ETHTOOL_A_MSE_HEADER, info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&phydev->lock);
+
+	if (!phydev->drv || !phydev->drv->get_mse_capability ||
+	    !phydev->drv->get_mse_snapshot) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+	if (!phydev->link) {
+		ret = -ENETDOWN;
+		goto out_unlock;
+	}
+
+	ret = phydev->drv->get_mse_capability(phydev, &data->capability);
+	if (ret)
+		goto out_unlock;
+
+	if (info->attrs[ETHTOOL_A_MSE_CHANNEL]) {
+		u32 channel = nla_get_u32(info->attrs[ETHTOOL_A_MSE_CHANNEL]);
+
+		ret = mse_get_one_channel(phydev, data, channel);
+	} else {
+		ret = mse_get_channels(phydev, data);
+	}
+
+out_unlock:
+	mutex_unlock(&phydev->lock);
+	ethnl_ops_complete(dev);
+	if (ret)
+		kfree(data->snapshots);
+	return ret;
+}
+
+static void mse_cleanup_data(struct ethnl_reply_data *reply_base)
+{
+	struct mse_reply_data *data = mse_repdata(reply_base);
+
+	kfree(data->snapshots);
+}
+
+static int mse_reply_size(const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct mse_reply_data *data = mse_repdata(reply_base);
+	size_t len = 0;
+	unsigned int i;
+	int ret;
+
+	/* ETHTOOL_A_MSE_CAPABILITIES */
+	len += nla_total_size(0);
+	if (data->capability.supported_caps & PHY_MSE_CAP_AVG)
+		/* ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE */
+		len += nla_total_size(sizeof(u64));
+	if (data->capability.supported_caps & (PHY_MSE_CAP_PEAK |
+					       PHY_MSE_CAP_WORST_PEAK))
+		/* ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE */
+		len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS */
+	len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS */
+	len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS */
+	ret = mse_caps_size(data->capability.supported_caps,
+			    req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS);
+	if (ret < 0)
+		return ret;
+	len += ret;
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		size_t snapshot_len = 0;
+
+		/* Per-channel nest (e.g., ETHTOOL_A_MSE_CHANNEL_A / _B / _C /
+		 * _D / _WORST_CHANNEL / _LINK)
+		 */
+		snapshot_len += nla_total_size(0);
+
+		if (data->capability.supported_caps & PHY_MSE_CAP_AVG)
+			snapshot_len += nla_total_size(sizeof(u64));
+		if (data->capability.supported_caps & PHY_MSE_CAP_PEAK)
+			snapshot_len += nla_total_size(sizeof(u64));
+		if (data->capability.supported_caps & PHY_MSE_CAP_WORST_PEAK)
+			snapshot_len += nla_total_size(sizeof(u64));
+
+		len += snapshot_len;
+	}
+
+	return len;
+}
+
+static int mse_fill_reply(struct sk_buff *skb,
+			  const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct mse_reply_data *data = mse_repdata(reply_base);
+	struct nlattr *cap_nest, *snap_nest;
+	unsigned int i;
+	int ret;
+
+	cap_nest = nla_nest_start(skb, ETHTOOL_A_MSE_CAPABILITIES);
+	if (!cap_nest)
+		return -EMSGSIZE;
+
+	if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
+		ret = nla_put_uint(skb,
+				   ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE,
+				   data->capability.max_average_mse);
+		if (ret < 0)
+			goto nla_put_cap_failure;
+	}
+
+	if (data->capability.supported_caps & (PHY_MSE_CAP_PEAK |
+					       PHY_MSE_CAP_WORST_PEAK)) {
+		ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+				   data->capability.max_peak_mse);
+		if (ret < 0)
+			goto nla_put_cap_failure;
+	}
+
+	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+			   data->capability.refresh_rate_ps);
+	if (ret < 0)
+		goto nla_put_cap_failure;
+
+	ret = nla_put_uint(skb, ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+			   data->capability.num_symbols);
+	if (ret < 0)
+		goto nla_put_cap_failure;
+
+	ret = mse_caps_put(skb, ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS,
+			   data->capability.supported_caps,
+			   req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS);
+	if (ret < 0)
+		goto nla_put_cap_failure;
+
+	nla_nest_end(skb, cap_nest);
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		const struct mse_snapshot_entry *s = &data->snapshots[i];
+		int chan_attr;
+
+		switch (s->channel) {
+		case PHY_MSE_CHANNEL_A:
+			chan_attr = ETHTOOL_A_MSE_CHANNEL_A;
+			break;
+		case PHY_MSE_CHANNEL_B:
+			chan_attr = ETHTOOL_A_MSE_CHANNEL_B;
+			break;
+		case PHY_MSE_CHANNEL_C:
+			chan_attr = ETHTOOL_A_MSE_CHANNEL_C;
+			break;
+		case PHY_MSE_CHANNEL_D:
+			chan_attr = ETHTOOL_A_MSE_CHANNEL_D;
+			break;
+		case PHY_MSE_CHANNEL_WORST:
+			chan_attr = ETHTOOL_A_MSE_WORST_CHANNEL;
+			break;
+		case PHY_MSE_CHANNEL_LINK:
+			chan_attr = ETHTOOL_A_MSE_LINK;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		snap_nest = nla_nest_start(skb, chan_attr);
+		if (!snap_nest)
+			return -EMSGSIZE;
+
+		if (data->capability.supported_caps & PHY_MSE_CAP_AVG) {
+			ret = nla_put_uint(skb,
+					   ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
+					   s->snapshot.average_mse);
+			if (ret)
+				goto nla_put_snap_failure;
+		}
+		if (data->capability.supported_caps & PHY_MSE_CAP_PEAK) {
+			ret = nla_put_uint(skb, ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+					   s->snapshot.peak_mse);
+			if (ret)
+				goto nla_put_snap_failure;
+		}
+		if (data->capability.supported_caps & PHY_MSE_CAP_WORST_PEAK) {
+			ret = nla_put_uint(skb,
+					   ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+					   s->snapshot.worst_peak_mse);
+			if (ret)
+				goto nla_put_snap_failure;
+		}
+
+		nla_nest_end(skb, snap_nest);
+	}
+
+	return 0;
+
+nla_put_cap_failure:
+	nla_nest_cancel(skb, cap_nest);
+	return ret;
+
+nla_put_snap_failure:
+	nla_nest_cancel(skb, snap_nest);
+	return -EMSGSIZE;
+}
+
+const struct ethnl_request_ops ethnl_mse_request_ops = {
+	.request_cmd = ETHTOOL_MSG_MSE_GET,
+	.reply_cmd = ETHTOOL_MSG_MSE_GET_REPLY,
+	.hdr_attr = ETHTOOL_A_MSE_HEADER,
+	.req_info_size = sizeof(struct mse_req_info),
+	.reply_data_size = sizeof(struct mse_reply_data),
+
+	.prepare_data = mse_prepare_data,
+	.cleanup_data = mse_cleanup_data,
+	.reply_size = mse_reply_size,
+	.fill_reply = mse_fill_reply,
+};
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 2f813f25f07e..6e5f0f4f815a 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -420,6 +420,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_GET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
+	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1534,6 +1535,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy	= ethnl_rss_delete_policy,
 		.maxattr = ARRAY_SIZE(ethnl_rss_delete_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_MSE_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
+		.policy = ethnl_mse_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 1d4f9ecb3d26..f9ebcfb327a6 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -442,6 +442,7 @@ extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
+extern const struct ethnl_request_ops ethnl_mse_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -497,6 +498,7 @@ extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE
 extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
+extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_CHANNEL + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index f6a67109beda..1c86549db88d 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -115,6 +115,11 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_PHY_CNT,
 		.strings	= stats_phy_names,
 	},
+	[ETH_SS_MSE_CAPS] = {
+		.per_dev	= false,
+		.count		= __MSE_CAP_CNT,
+		.strings	= mse_cap_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.47.3


