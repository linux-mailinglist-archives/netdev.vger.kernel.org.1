Return-Path: <netdev+bounces-220820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E4B48DF7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9852B3AEC99
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CD306B39;
	Mon,  8 Sep 2025 12:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1617304BB2
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335593; cv=none; b=G0XOEERbwXtljSWh962TBZFYyPFJwmUnmm6txwXCeJ4mJvLj9n8pKNB3z9VAS1kwcR6SNezVe418xnze60qszZDcFwLXMhKqS5bYh7tLZ3KCrRMMydMeeqlaunPGpsoWmuQIMBPi/w+jT1b0+49aGpvZMrlxZh4gVVQrdEc5FcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335593; c=relaxed/simple;
	bh=Tn4bVRJuF4JBmy1BVKoQ1YkKIXHXU/mV+zSkyQBecIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhl9VDZHzq15RTPR47EMRy96LgI8Qo8X7eolce9tzJmbQALGvJgSKisSzESlm1q007xGd4Mzb9dLbEK4UizTe1PzY/akA3irjUk3yYLxP3RnKRFCSX7A9Cehsq2pewRIykqz3XW5x/qUE+u2Yi1tN8pzcMxi7kzrEyizF3ln9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG9-0003S6-F8; Mon, 08 Sep 2025 14:46:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-000Fip-2U;
	Mon, 08 Sep 2025 14:46:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvbG7-0000000CKJU-2pj4;
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
Subject: [PATCH net-next v5 2/5] ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Date: Mon,  8 Sep 2025 14:46:07 +0200
Message-ID: <20250908124610.2937939-3-o.rempel@pengutronix.de>
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

Introduce the userspace entry point for PHY MSE diagnostics via
ethtool netlink. This exposes the core API added previously and
returns both configuration and one or more snapshots.

Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
selector. The reply carries:
  - ETHTOOL_A_MSE_CONFIG: scale limits, timing, and supported
    capability bitmask
  - ETHTOOL_A_MSE_SNAPSHOT+: one or more snapshots, each tagged
    with the selected channel

If no channel is requested, the kernel returns snapshots for all
supported selectors (per‑channel if available, otherwise WORST,
otherwise LINK). Requests for unsupported selectors fail with
-EOPNOTSUPP; link down returns -ENOLINK.

Changes:
  - YAML: add attribute sets (mse, mse-config, mse-snapshot) and
    the mse-get operation
  - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
    ETHTOOL_MSG_MSE_GET/REPLY
  - ethtool core: add net/ethtool/mse.c implementing the request,
    register genl op, and hook into ethnl dispatch
  - docs: document MSE_GET in ethtool-netlink.rst

The include/uapi/linux/ethtool_netlink_generated.h is generated
from Documentation/netlink/specs/ethtool.yaml.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- add struct phy_mse_snapshot and phy_mse_config to the documentation
changes v4:
- s/__ethtool-a-mse/--ethtool-a-mse
- remove duplicate kernel-doc line
- fix htmldocs compile warnings
---
 Documentation/netlink/specs/ethtool.yaml      |  88 +++++
 Documentation/networking/ethtool-netlink.rst  |  62 +++
 .../uapi/linux/ethtool_netlink_generated.h    |  37 ++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/mse.c                             | 362 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 +
 net/ethtool/netlink.h                         |   2 +
 7 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/mse.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 969477f50d84..d69dd3fb534b 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1899,6 +1899,79 @@ attribute-sets:
         type: uint
         enum: pse-event
         doc: List of events reported by the PSE controller
+  -
+    name: mse-config
+    attr-cnt-name: --ethtool-a-mse-config-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: max-average-mse
+        type: u32
+      -
+        name: max-peak-mse
+        type: u32
+      -
+        name: refresh-rate-ps
+        type: u64
+      -
+        name: num-symbols
+        type: u64
+      -
+        name: supported-caps
+        type: nest
+        nested-attributes: bitset
+      -
+        name: pad
+        type: pad
+  -
+    name: mse-snapshot
+    attr-cnt-name: --ethtool-a-mse-snapshot-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: channel
+        type: u32
+        enum: phy-mse-channel
+      -
+        name: average-mse
+        type: u32
+      -
+        name: peak-mse
+        type: u32
+      -
+        name: worst-peak-mse
+        type: u32
+  -
+    name: mse
+    attr-cnt-name: --ethtool-a-mse-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: channel
+        type: u32
+        enum: phy-mse-channel
+      -
+        name: config
+        type: nest
+        nested-attributes: mse-config
+      -
+        name: snapshot
+        type: nest
+        multi-attr: true
+        nested-attributes: mse-snapshot

 operations:
   enum-model: directional
@@ -2832,6 +2905,21 @@ operations:
         attributes:
           - header
           - context
+    -
+      name: mse-get
+      doc: Get PHY MSE measurement data and configuration.
+      attribute-set: mse
+      do: &mse-get-op
+        request:
+          attributes:
+            - header
+            - channel
+        reply:
+          attributes: &mse-reply
+            - header
+            - config
+            - snapshot
+      dump: *mse-get-op

 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ab20c644af24..aae53f39c2b0 100644
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
@@ -2453,6 +2455,66 @@ Kernel response contents:

 For a description of each attribute, see ``TSCONFIG_GET``.

+MSE_GET
+=======
+
+Retrieves detailed Mean Square Error (MSE) diagnostic information from the PHY.
+
+Request Contents:
+
+  ====================================  ======  ============================
+  ETHTOOL_A_MSE_HEADER                  nested  request header
+  ETHTOOL_A_MSE_CHANNEL                 u32     optional channel enum value
+  ====================================  ======  ============================
+
+.. kernel-doc:: include/uapi/linux/ethtool_netlink_generated.h
+    :identifiers: phy_mse_channel
+
+The optional ``ETHTOOL_A_MSE_CHANNEL`` attribute allows the caller to request
+data for a specific channel. If omitted, the kernel will return snapshots for
+all supported channels.
+
+Kernel Response Contents:
+
+  ====================================  ======  ============================
+  ETHTOOL_A_MSE_HEADER                  nested  reply header
+  ETHTOOL_A_MSE_CONFIG                  nested  MSE measurement configuration
+  ETHTOOL_A_MSE_SNAPSHOT+               nested  one or more MSE snapshots
+  ====================================  ======  ============================
+
+MSE Configuration
+-----------------
+
+This nested attribute contains the full configuration properties for the MSE
+measurements
+
+  ===============================================  ======  ====================
+  ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE             u32     max avg_mse scale
+  ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE                u32     max peak_mse scale
+  ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS             u64     sample rate (ps)
+  ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS                 u64     symbols per sample
+  ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS              bitset  capability bitmask
+  ===============================================  ======  ====================
+
+See ``struct phy_mse_config`` Kernel documentation defined in
+``include/linux/phy.h``
+
+MSE Snapshot
+------------
+
+This nested attribute contains an atomic snapshot of MSE values for a specific
+channel or for the link as a whole.
+
+  ===============================================  ======  ======================
+  ETHTOOL_A_MSE_SNAPSHOT_CHANNEL                   u32     channel enum value
+  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE               u32     average MSE value
+  ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE                  u32     current peak MSE
+  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE            u32     worst-case peak MSE
+  ===============================================  ======  ======================
+
+See ``struct phy_mse_snapshot`` Kernel documentation defined in
+``include/linux/phy.h``
+
 Request translation
 ===================

diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index d36faf5f20f4..8317e4b230a5 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -898,6 +898,41 @@ enum {
 	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
 };

+enum {
+	ETHTOOL_A_MSE_CONFIG_UNSPEC,
+	ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE,
+	ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE,
+	ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS,
+	ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS,
+	ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS,
+	ETHTOOL_A_MSE_CONFIG_PAD,
+
+	__ETHTOOL_A_MSE_CONFIG_CNT,
+	ETHTOOL_A_MSE_CONFIG_MAX = (__ETHTOOL_A_MSE_CONFIG_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_SNAPSHOT_UNSPEC,
+	ETHTOOL_A_MSE_SNAPSHOT_CHANNEL,
+	ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
+	ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+	ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+
+	__ETHTOOL_A_MSE_SNAPSHOT_CNT,
+	ETHTOOL_A_MSE_SNAPSHOT_MAX = (__ETHTOOL_A_MSE_SNAPSHOT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_UNSPEC,
+	ETHTOOL_A_MSE_HEADER,
+	ETHTOOL_A_MSE_CHANNEL,
+	ETHTOOL_A_MSE_CONFIG,
+	ETHTOOL_A_MSE_SNAPSHOT,
+
+	__ETHTOOL_A_MSE_CNT,
+	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -950,6 +985,7 @@ enum {
 	ETHTOOL_MSG_RSS_SET,
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
+	ETHTOOL_MSG_MSE_GET,

 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -1010,6 +1046,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
+	ETHTOOL_MSG_MSE_GET_REPLY,

 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index a1490c4afe6b..1be76e8d584f 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o \
-		   phy.o tsconfig.o
+		   phy.o tsconfig.o mse.o
diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
new file mode 100644
index 000000000000..78389491cc49
--- /dev/null
+++ b/net/ethtool/mse.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+
+#include "netlink.h"
+#include "common.h"
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
+	struct phy_mse_config config;
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
+static int get_snapshot_if_supported(struct phy_device *phydev,
+				     struct mse_reply_data *data,
+				     unsigned int *idx, u32 cap_bit,
+				     int channel_id)
+{
+	int ret;
+
+	if (data->config.supported_caps & cap_bit) {
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
+	if (!data->config.supported_caps)
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
+	if (!(data->config.supported_caps & cap_bit))
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
+	if (!phydev->drv || !phydev->drv->get_mse_config ||
+	    !phydev->drv->get_mse_snapshot) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+	if (!phydev->link) {
+		ret = -ENETDOWN;
+		goto out_unlock;
+	}
+
+	ret = phydev->drv->get_mse_config(phydev, &data->config);
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
+
+	/* ETHTOOL_A_MSE_CONFIG */
+	len += nla_total_size(0);
+	if (data->config.supported_caps & PHY_MSE_CAP_AVG)
+		/* ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE */
+		len += nla_total_size(sizeof(u32));
+	if (data->config.supported_caps & (PHY_MSE_CAP_PEAK |
+					   PHY_MSE_CAP_WORST_PEAK))
+		/* ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE */
+		len += nla_total_size(sizeof(u32));
+	/* ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS */
+	len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS */
+	len += nla_total_size(sizeof(u64));
+	/* ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS */
+	len += nla_total_size(sizeof(u32));
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		size_t snapshot_len = 0;
+
+		/* ETHTOOL_A_MSE_SNAPSHOT */
+		snapshot_len += nla_total_size(0);
+		/* ETHTOOL_A_MSE_SNAPSHOT_CHANNEL */
+		snapshot_len += nla_total_size(sizeof(u32));
+
+		if (data->config.supported_caps & PHY_MSE_CAP_AVG)
+			snapshot_len += nla_total_size(sizeof(u32));
+		if (data->config.supported_caps & PHY_MSE_CAP_PEAK)
+			snapshot_len += nla_total_size(sizeof(u32));
+		if (data->config.supported_caps & PHY_MSE_CAP_WORST_PEAK)
+			snapshot_len += nla_total_size(sizeof(u32));
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
+	struct nlattr *config_nest, *snapshot_nest;
+	unsigned int i;
+	int ret;
+
+	config_nest = nla_nest_start(skb, ETHTOOL_A_MSE_CONFIG);
+	if (!config_nest)
+		return -EMSGSIZE;
+
+	if (data->config.supported_caps & PHY_MSE_CAP_AVG)
+		if (nla_put_u32(skb, ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE,
+				data->config.max_average_mse))
+			goto nla_put_config_failure;
+
+	if (data->config.supported_caps & (PHY_MSE_CAP_PEAK |
+					   PHY_MSE_CAP_WORST_PEAK))
+		if (nla_put_u32(skb, ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE,
+				data->config.max_peak_mse))
+			goto nla_put_config_failure;
+
+	if (nla_put_u64_64bit(skb, ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS,
+			      data->config.refresh_rate_ps,
+			      ETHTOOL_A_MSE_CONFIG_PAD) ||
+	    nla_put_u64_64bit(skb, ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS,
+			      data->config.num_symbols,
+			      ETHTOOL_A_MSE_CONFIG_PAD) ||
+	    nla_put_u32(skb, ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS,
+			data->config.supported_caps))
+		goto nla_put_config_failure;
+
+	nla_nest_end(skb, config_nest);
+
+	for (i = 0; i < data->num_snapshots; i++) {
+		const struct mse_snapshot_entry *s = &data->snapshots[i];
+
+		snapshot_nest = nla_nest_start(skb, ETHTOOL_A_MSE_SNAPSHOT);
+		if (!snapshot_nest)
+			return -EMSGSIZE;
+
+		ret = nla_put_u32(skb, ETHTOOL_A_MSE_SNAPSHOT_CHANNEL,
+				  s->channel);
+		if (ret)
+			goto nla_put_failure;
+
+		if (data->config.supported_caps & PHY_MSE_CAP_AVG) {
+			ret = nla_put_u32(skb,
+					  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE,
+					  s->snapshot.average_mse);
+			if (ret)
+				goto nla_put_failure;
+		}
+		if (data->config.supported_caps & PHY_MSE_CAP_PEAK) {
+			ret = nla_put_u32(skb, ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+					  s->snapshot.peak_mse);
+			if (ret)
+				goto nla_put_failure;
+		}
+		if (data->config.supported_caps & PHY_MSE_CAP_WORST_PEAK) {
+			ret = nla_put_u32(skb,
+					  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+					  s->snapshot.worst_peak_mse);
+			if (ret)
+				goto nla_put_failure;
+		}
+
+		nla_nest_end(skb, snapshot_nest);
+	}
+
+	return 0;
+
+nla_put_config_failure:
+	nla_nest_cancel(skb, config_nest);
+	return -EMSGSIZE;
+
+nla_put_failure:
+	nla_nest_cancel(skb, snapshot_nest);
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
--
2.47.3


