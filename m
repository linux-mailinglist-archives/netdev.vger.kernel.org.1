Return-Path: <netdev+bounces-221088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E0B4A36C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0911BC6ABA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BD3081DF;
	Tue,  9 Sep 2025 07:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91E302745
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402580; cv=none; b=fggar+wKVTwEhnFTXTQwbJawEin3v3CEzEF6ocfzQxaO241PQFfejxw4nJya+XZXYsIwMsqGrtYcEo0hvdge85J4KnHIEreY9nbMLe8Z3DskcGy0lPWu1M5th4OiY3i0XZkcD4Cbii7dQy7ZI+L038vy9aaD8FFRO1eegu++FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402580; c=relaxed/simple;
	bh=i8L2+82d/W9w3jgQ1ZkXNfIFYlw4fbP9uGGb9U3ZFzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTOpvxM1xoqA4ttpBpRRYAw1gYv7dAVdkAmZ5KfGmH3SJfUXNi8E/lyuMVPXliZNwIMGxdbpvMIERsUggNFZrCDIdgixYDjWPZrdhPqU+huaPX2Eg3BIt+HraA8yPee42ArYFgf6FXv11dLXJ3qRlTsoVaRktsjib67tjgo1WeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgF-0004gq-KO; Tue, 09 Sep 2025 09:22:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgA-000NlR-03;
	Tue, 09 Sep 2025 09:22:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-0000000FZFi-3p8Y;
	Tue, 09 Sep 2025 09:22:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 2/3] net: ynl: add generated kdoc to UAPI headers
Date: Tue,  9 Sep 2025 09:22:11 +0200
Message-ID: <20250909072212.3710365-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909072212.3710365-1-o.rempel@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
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

Run the ynl regeneration script to apply the kdoc generation
support added in the previous commit.

This updates the generated UAPI headers for dpll, ethtool, team,
net_shaper, netdev, and ovpn with documentation parsed from their
respective YAML specifications.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/dpll.h                     |  30 ++++
 .../uapi/linux/ethtool_netlink_generated.h    |  29 +++
 include/uapi/linux/if_team.h                  |  11 ++
 include/uapi/linux/net_shaper.h               |  50 ++++++
 include/uapi/linux/netdev.h                   | 165 ++++++++++++++++++
 include/uapi/linux/ovpn.h                     |  62 +++++++
 tools/include/uapi/linux/netdev.h             | 165 ++++++++++++++++++
 7 files changed, 512 insertions(+)

diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 37b438ce8efc..23a4e3598650 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -203,6 +203,18 @@ enum dpll_feature_state {
 	DPLL_FEATURE_STATE_ENABLE,
 };
 
+/**
+ * enum dpll_dpll
+ * @DPLL_A_CLOCK_QUALITY_LEVEL: Level of quality of a clock device. This mainly
+ *   applies when the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. This could
+ *   be put to message multiple times to indicate possible parallel quality
+ *   levels (e.g. one specified by ITU option 1 and another one specified by
+ *   option 2).
+ * @DPLL_A_PHASE_OFFSET_MONITOR: Receive or request state of phase offset
+ *   monitor feature. If enabled, dpll device shall monitor and notify all
+ *   currently available inputs for changes of their phase offset against the
+ *   dpll device.
+ */
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -221,6 +233,24 @@ enum dpll_a {
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
 };
 
+/**
+ * enum dpll_pin
+ * @DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET: The FFO (Fractional Frequency
+ *   Offset) between the RX and TX symbol rate on the media associated with the
+ *   pin: (rx_frequency-tx_frequency)/rx_frequency Value is in PPM (parts per
+ *   million). This may be implemented for example for pin of type
+ *   PIN_TYPE_SYNCE_ETH_PORT.
+ * @DPLL_A_PIN_ESYNC_FREQUENCY: Frequency of Embedded SYNC signal. If provided,
+ *   the pin is configured with a SYNC signal embedded into its base clock
+ *   frequency.
+ * @DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED: If provided a pin is capable of
+ *   embedding a SYNC signal (within given range) into its base frequency
+ *   signal.
+ * @DPLL_A_PIN_ESYNC_PULSE: A ratio of high to low state of a SYNC signal pulse
+ *   embedded into base clock frequency. Value is in percents.
+ * @DPLL_A_PIN_REFERENCE_SYNC: Capable pin provides list of pins that can be
+ *   bound to create a reference-sync pin pair.
+ */
 enum dpll_a_pin {
 	DPLL_A_PIN_ID = 1,
 	DPLL_A_PIN_PARENT_ID,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index e3b8813465d7..46de09954042 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -197,6 +197,15 @@ enum {
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
 };
 
+/**
+ * enum ethtool_mm_stat - MAC Merge (802.3)
+ * @ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS: aMACMergeFrameAssErrorCount
+ * @ETHTOOL_A_MM_STAT_SMD_ERRORS: aMACMergeFrameSmdErrorCount
+ * @ETHTOOL_A_MM_STAT_REASSEMBLY_OK: aMACMergeFrameAssOkCount
+ * @ETHTOOL_A_MM_STAT_RX_FRAG_COUNT: aMACMergeFragCountRx
+ * @ETHTOOL_A_MM_STAT_TX_FRAG_COUNT: aMACMergeFragCountTx
+ * @ETHTOOL_A_MM_STAT_HOLD_COUNT: aMACMergeHoldCount
+ */
 enum {
 	ETHTOOL_A_MM_STAT_UNSPEC,
 	ETHTOOL_A_MM_STAT_PAD,
@@ -448,6 +457,12 @@ enum {
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
 };
 
+/**
+ * enum ethtool_cable_result
+ * @ETHTOOL_A_CABLE_RESULT_PAIR: ETHTOOL_A_CABLE_PAIR
+ * @ETHTOOL_A_CABLE_RESULT_CODE: ETHTOOL_A_CABLE_RESULT_CODE
+ * @ETHTOOL_A_CABLE_RESULT_SRC: ETHTOOL_A_CABLE_INF_SRC
+ */
 enum {
 	ETHTOOL_A_CABLE_RESULT_UNSPEC,
 	ETHTOOL_A_CABLE_RESULT_PAIR,
@@ -485,6 +500,10 @@ enum {
 	ETHTOOL_A_CABLE_TEST_MAX = (__ETHTOOL_A_CABLE_TEST_CNT - 1)
 };
 
+/**
+ * enum ethtool_cable_test_ntf
+ * @ETHTOOL_A_CABLE_TEST_NTF_STATUS: _STARTED/_COMPLETE
+ */
 enum {
 	ETHTOOL_A_CABLE_TEST_NTF_UNSPEC,
 	ETHTOOL_A_CABLE_TEST_NTF_HEADER,
@@ -678,6 +697,12 @@ enum {
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
 };
 
+/*
+ * Flow types, corresponding to those defined in the old ethtool header for
+ * RXFH and RXNFC as ${PROTO}_FLOW. The values are not matching the old ones to
+ * avoid carrying into Netlink the IP_USER_FLOW vs IPV4_FLOW vs IPV4_USER_FLOW
+ * confusion.
+ */
 enum {
 	ETHTOOL_A_FLOW_ETHER = 1,
 	ETHTOOL_A_FLOW_IP4,
@@ -783,6 +808,10 @@ enum {
 	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
 };
 
+/**
+ * enum ethtool_pse_ntf
+ * @ETHTOOL_A_PSE_NTF_EVENTS: List of events reported by the PSE controller
+ */
 enum {
 	ETHTOOL_A_PSE_NTF_HEADER = 1,
 	ETHTOOL_A_PSE_NTF_EVENTS,
diff --git a/include/uapi/linux/if_team.h b/include/uapi/linux/if_team.h
index a5c06243a435..22d68c0dad60 100644
--- a/include/uapi/linux/if_team.h
+++ b/include/uapi/linux/if_team.h
@@ -12,6 +12,12 @@
 #define TEAM_STRING_MAX_LEN			32
 #define TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME	"change_event"
 
+/*
+ * The team nested layout of get/set msg looks like [TEAM_ATTR_LIST_OPTION]
+ * [TEAM_ATTR_ITEM_OPTION] [TEAM_ATTR_OPTION_*], ... [TEAM_ATTR_ITEM_OPTION]
+ * [TEAM_ATTR_OPTION_*], ... ... [TEAM_ATTR_LIST_PORT] [TEAM_ATTR_ITEM_PORT]
+ * [TEAM_ATTR_PORT_*], ... [TEAM_ATTR_ITEM_PORT] [TEAM_ATTR_PORT_*], ... ...
+ */
 enum {
 	TEAM_ATTR_UNSPEC,
 	TEAM_ATTR_TEAM_IFINDEX,
@@ -30,6 +36,11 @@ enum {
 	TEAM_ATTR_ITEM_OPTION_MAX = (__TEAM_ATTR_ITEM_OPTION_MAX - 1)
 };
 
+/**
+ * enum team_attr_option
+ * @TEAM_ATTR_OPTION_PORT_IFINDEX: for per-port options
+ * @TEAM_ATTR_OPTION_ARRAY_INDEX: for array options
+ */
 enum {
 	TEAM_ATTR_OPTION_UNSPEC,
 	TEAM_ATTR_OPTION_NAME,
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
index d8834b59f7d7..1aeeb1d68fff 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -41,6 +41,28 @@ enum net_shaper_metric {
 	NET_SHAPER_METRIC_PPS,
 };
 
+/**
+ * enum net_shaper_net_shaper
+ * @NET_SHAPER_A_HANDLE: Unique identifier for the given shaper inside the
+ *   owning device.
+ * @NET_SHAPER_A_METRIC: Metric used by the given shaper for bw-min, bw-max and
+ *   burst.
+ * @NET_SHAPER_A_BW_MIN: Guaranteed bandwidth for the given shaper.
+ * @NET_SHAPER_A_BW_MAX: Maximum bandwidth for the given shaper or 0 when
+ *   unlimited.
+ * @NET_SHAPER_A_BURST: Maximum burst-size for shaping. Should not be
+ *   interpreted as a quantum.
+ * @NET_SHAPER_A_PRIORITY: Scheduling priority for the given shaper. The
+ *   priority scheduling is applied to sibling shapers.
+ * @NET_SHAPER_A_WEIGHT: Relative weight for round robin scheduling of the
+ *   given shaper. The scheduling is applied to all sibling shapers with the
+ *   same priority.
+ * @NET_SHAPER_A_IFINDEX: Interface index owning the specified shaper.
+ * @NET_SHAPER_A_PARENT: Identifier for the parent of the affected shaper. Only
+ *   needed for @group operation.
+ * @NET_SHAPER_A_LEAVES: Describes a set of leaves shapers for a @group
+ *   operation.
+ */
 enum {
 	NET_SHAPER_A_HANDLE = 1,
 	NET_SHAPER_A_METRIC,
@@ -57,6 +79,13 @@ enum {
 	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
 };
 
+/**
+ * enum net_shaper_handle
+ * @NET_SHAPER_A_HANDLE_SCOPE: Defines the shaper @id interpretation.
+ * @NET_SHAPER_A_HANDLE_ID: Numeric identifier of a shaper. The id semantic
+ *   depends on the scope. For @queue scope it's the queue id and for @node
+ *   scope it's the node identifier.
+ */
 enum {
 	NET_SHAPER_A_HANDLE_SCOPE = 1,
 	NET_SHAPER_A_HANDLE_ID,
@@ -65,6 +94,27 @@ enum {
 	NET_SHAPER_A_HANDLE_MAX = (__NET_SHAPER_A_HANDLE_MAX - 1)
 };
 
+/**
+ * enum net_shaper_caps
+ * @NET_SHAPER_A_CAPS_IFINDEX: Interface index queried for shapers
+ *   capabilities.
+ * @NET_SHAPER_A_CAPS_SCOPE: The scope to which the queried capabilities apply.
+ * @NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS: The device accepts 'bps' metric for
+ *   bw-min, bw-max and burst.
+ * @NET_SHAPER_A_CAPS_SUPPORT_METRIC_PPS: The device accepts 'pps' metric for
+ *   bw-min, bw-max and burst.
+ * @NET_SHAPER_A_CAPS_SUPPORT_NESTING: The device supports nesting shaper
+ *   belonging to this scope below 'node' scoped shapers. Only 'queue' and
+ *   'node' scope can have flag 'support-nesting'.
+ * @NET_SHAPER_A_CAPS_SUPPORT_BW_MIN: The device supports a minimum guaranteed
+ *   B/W.
+ * @NET_SHAPER_A_CAPS_SUPPORT_BW_MAX: The device supports maximum B/W shaping.
+ * @NET_SHAPER_A_CAPS_SUPPORT_BURST: The device supports a maximum burst size.
+ * @NET_SHAPER_A_CAPS_SUPPORT_PRIORITY: The device supports priority
+ *   scheduling.
+ * @NET_SHAPER_A_CAPS_SUPPORT_WEIGHT: The device supports weighted round robin
+ *   scheduling.
+ */
 enum {
 	NET_SHAPER_A_CAPS_IFINDEX = 1,
 	NET_SHAPER_A_CAPS_SCOPE,
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..4d5169fc798d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -82,6 +82,16 @@ enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_ENABLED,
 };
 
+/**
+ * enum netdev_dev
+ * @NETDEV_A_DEV_IFINDEX: netdev ifindex
+ * @NETDEV_A_DEV_XDP_FEATURES: Bitmask of enabled xdp-features.
+ * @NETDEV_A_DEV_XDP_ZC_MAX_SEGS: max fragment count supported by ZC driver
+ * @NETDEV_A_DEV_XDP_RX_METADATA_FEATURES: Bitmask of supported XDP receive
+ *   metadata features. See Documentation/networking/xdp-rx-metadata.rst for
+ *   more details.
+ * @NETDEV_A_DEV_XSK_FEATURES: Bitmask of enabled AF_XDP features.
+ */
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
@@ -99,6 +109,29 @@ enum {
 	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
 };
 
+/**
+ * enum netdev_page_pool
+ * @NETDEV_A_PAGE_POOL_ID: Unique ID of a Page Pool instance.
+ * @NETDEV_A_PAGE_POOL_IFINDEX: ifindex of the netdev to which the pool
+ *   belongs. May be reported as 0 if the page pool was allocated for a netdev
+ *   which got destroyed already (page pools may outlast their netdevs because
+ *   they wait for all memory to be returned).
+ * @NETDEV_A_PAGE_POOL_NAPI_ID: Id of NAPI using this Page Pool instance.
+ * @NETDEV_A_PAGE_POOL_INFLIGHT: Number of outstanding references to this page
+ *   pool (allocated but yet to be freed pages). Allocated pages may be held in
+ *   socket receive queues, driver receive ring, page pool recycling ring, the
+ *   page pool cache, etc.
+ * @NETDEV_A_PAGE_POOL_INFLIGHT_MEM: Amount of memory held by inflight pages.
+ * @NETDEV_A_PAGE_POOL_DETACH_TIME: Seconds in CLOCK_BOOTTIME of when Page Pool
+ *   was detached by the driver. Once detached Page Pool can no longer be used
+ *   to allocate memory. Page Pools wait for all the memory allocated from them
+ *   to be freed before truly disappearing. "Detached" Page Pools cannot be
+ *   "re-attached", they are just waiting to disappear. Attribute is absent if
+ *   Page Pool has not been detached, and can still be used to allocate new
+ *   memory.
+ * @NETDEV_A_PAGE_POOL_DMABUF: ID of the dmabuf this page-pool is attached to.
+ * @NETDEV_A_PAGE_POOL_IO_URING: io-uring memory provider information.
+ */
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -113,6 +146,11 @@ enum {
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
 };
 
+/**
+ * enum netdev_page_pool_stats - Page pool statistics, see docs for struct
+ *   page_pool_stats for information about individual statistics.
+ * @NETDEV_A_PAGE_POOL_STATS_INFO: Page pool identifying information.
+ */
 enum {
 	NETDEV_A_PAGE_POOL_STATS_INFO = 1,
 	NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST = 8,
@@ -131,6 +169,28 @@ enum {
 	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
 };
 
+/**
+ * enum netdev_napi
+ * @NETDEV_A_NAPI_IFINDEX: ifindex of the netdevice to which NAPI instance
+ *   belongs.
+ * @NETDEV_A_NAPI_ID: ID of the NAPI instance.
+ * @NETDEV_A_NAPI_IRQ: The associated interrupt vector number for the napi
+ * @NETDEV_A_NAPI_PID: PID of the napi thread, if NAPI is configured to operate
+ *   in threaded mode. If NAPI is not in threaded mode (i.e. uses normal
+ *   softirq context), the attribute will be absent.
+ * @NETDEV_A_NAPI_DEFER_HARD_IRQS: The number of consecutive empty polls before
+ *   IRQ deferral ends and hardware IRQs are re-enabled.
+ * @NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT: The timeout, in nanoseconds, of when to
+ *   trigger the NAPI watchdog timer which schedules NAPI processing.
+ *   Additionally, a non-zero value will also prevent GRO from flushing recent
+ *   super-frames at the end of a NAPI cycle. This may add receive latency in
+ *   exchange for reducing the number of frames processed by the network stack.
+ * @NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT: The timeout, in nanoseconds, of how long
+ *   to suspend irq processing, if event polling finds events
+ * @NETDEV_A_NAPI_THREADED: Whether the NAPI is configured to operate in
+ *   threaded polling mode. If this is set to enabled then the NAPI context
+ *   operates in threaded polling mode.
+ */
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
@@ -150,6 +210,22 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+/**
+ * enum netdev_queue
+ * @NETDEV_A_QUEUE_ID: Queue index; most queue types are indexed like a C
+ *   array, with indexes starting at 0 and ending at queue count - 1. Queue
+ *   indexes are scoped to an interface and queue type.
+ * @NETDEV_A_QUEUE_IFINDEX: ifindex of the netdevice to which the queue
+ *   belongs.
+ * @NETDEV_A_QUEUE_TYPE: Queue type as rx, tx. Each queue type defines a
+ *   separate ID space. XDP TX queues allocated in the kernel are not linked to
+ *   NAPIs and thus not listed. AF_XDP queues will have more information set in
+ *   the xsk attribute.
+ * @NETDEV_A_QUEUE_NAPI_ID: ID of the NAPI instance which services this queue.
+ * @NETDEV_A_QUEUE_DMABUF: ID of the dmabuf attached to this queue, if any.
+ * @NETDEV_A_QUEUE_IO_URING: io_uring memory provider information.
+ * @NETDEV_A_QUEUE_XSK: XSK information for this queue, if any.
+ */
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -163,6 +239,88 @@ enum {
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
 };
 
+/**
+ * enum netdev_qstats - Get device statistics, scoped to a device or a queue.
+ *   These statistics extend (and partially duplicate) statistics available in
+ *   struct rtnl_link_stats64. Value of the `scope` attribute determines how
+ *   statistics are aggregated. When aggregated for the entire device the
+ *   statistics represent the total number of events since last explicit reset
+ *   of the device (i.e. not a reconfiguration like changing queue count). When
+ *   reported per-queue, however, the statistics may not add up to the total
+ *   number of events, will only be reported for currently active objects, and
+ *   will likely report the number of events since last reconfiguration.
+ * @NETDEV_A_QSTATS_IFINDEX: ifindex of the netdevice to which stats belong.
+ * @NETDEV_A_QSTATS_QUEUE_TYPE: Queue type as rx, tx, for queue-id.
+ * @NETDEV_A_QSTATS_QUEUE_ID: Queue ID, if stats are scoped to a single queue
+ *   instance.
+ * @NETDEV_A_QSTATS_SCOPE: What object type should be used to iterate over the
+ *   stats.
+ * @NETDEV_A_QSTATS_RX_PACKETS: Number of wire packets successfully received
+ *   and passed to the stack. For drivers supporting XDP, XDP is considered the
+ *   first layer of the stack, so packets consumed by XDP are still counted
+ *   here.
+ * @NETDEV_A_QSTATS_RX_BYTES: Successfully received bytes, see `rx-packets`.
+ * @NETDEV_A_QSTATS_TX_PACKETS: Number of wire packets successfully sent.
+ *   Packet is considered to be successfully sent once it is in device memory
+ *   (usually this means the device has issued a DMA completion for the
+ *   packet).
+ * @NETDEV_A_QSTATS_TX_BYTES: Successfully sent bytes, see `tx-packets`.
+ * @NETDEV_A_QSTATS_RX_ALLOC_FAIL: Number of times skb or buffer allocation
+ *   failed on the Rx datapath. Allocation failure may, or may not result in a
+ *   packet drop, depending on driver implementation and whether system
+ *   recovers quickly.
+ * @NETDEV_A_QSTATS_RX_HW_DROPS: Number of all packets which entered the
+ *   device, but never left it, including but not limited to: packets dropped
+ *   due to lack of buffer space, processing errors, explicit or implicit
+ *   policies and packet filters.
+ * @NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS: Number of packets dropped due to
+ *   transient lack of resources, such as buffer space, host descriptors etc.
+ * @NETDEV_A_QSTATS_RX_CSUM_COMPLETE: Number of packets that were marked as
+ *   CHECKSUM_COMPLETE.
+ * @NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY: Number of packets that were marked as
+ *   CHECKSUM_UNNECESSARY.
+ * @NETDEV_A_QSTATS_RX_CSUM_NONE: Number of packets that were not checksummed
+ *   by device.
+ * @NETDEV_A_QSTATS_RX_CSUM_BAD: Number of packets with bad checksum. The
+ *   packets are not discarded, but still delivered to the stack.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_PACKETS: Number of packets that were coalesced
+ *   from smaller packets by the device. Counts only packets coalesced with the
+ *   HW-GRO netdevice feature, LRO-coalesced packets are not counted.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_BYTES: See `rx-hw-gro-packets`.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS: Number of packets that were
+ *   coalesced to bigger packetss with the HW-GRO netdevice feature.
+ *   LRO-coalesced packets are not counted.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES: See `rx-hw-gro-wire-packets`.
+ * @NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS: Number of the packets dropped by the
+ *   device due to the received packets bitrate exceeding the device rate
+ *   limit.
+ * @NETDEV_A_QSTATS_TX_HW_DROPS: Number of packets that arrived at the device
+ *   but never left it, encompassing packets dropped for reasons such as
+ *   processing errors, as well as those affected by explicitly defined
+ *   policies and packet filtering criteria.
+ * @NETDEV_A_QSTATS_TX_HW_DROP_ERRORS: Number of packets dropped because they
+ *   were invalid or malformed.
+ * @NETDEV_A_QSTATS_TX_CSUM_NONE: Number of packets that did not require the
+ *   device to calculate the checksum.
+ * @NETDEV_A_QSTATS_TX_NEEDS_CSUM: Number of packets that required the device
+ *   to calculate the checksum. This counter includes the number of GSO wire
+ *   packets for which device calculated the L4 checksum.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_PACKETS: Number of packets that necessitated
+ *   segmentation into smaller packets by the device.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_BYTES: See `tx-hw-gso-packets`.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS: Number of wire-sized packets
+ *   generated by processing `tx-hw-gso-packets`
+ * @NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES: See `tx-hw-gso-wire-packets`.
+ * @NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS: Number of the packets dropped by the
+ *   device due to the transmit packets bitrate exceeding the device rate
+ *   limit.
+ * @NETDEV_A_QSTATS_TX_STOP: Number of times driver paused accepting new tx
+ *   packets from the stack to this queue, because the queue was full. Note
+ *   that if BQL is supported and enabled on the device the networking stack
+ *   will avoid queuing a lot of data at once.
+ * @NETDEV_A_QSTATS_TX_WAKE: Number of times driver re-started accepting send
+ *   requests to this queue from the stack.
+ */
 enum {
 	NETDEV_A_QSTATS_IFINDEX = 1,
 	NETDEV_A_QSTATS_QUEUE_TYPE,
@@ -200,6 +358,13 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+/**
+ * enum netdev_dmabuf
+ * @NETDEV_A_DMABUF_IFINDEX: netdev ifindex to bind the dmabuf to.
+ * @NETDEV_A_DMABUF_QUEUES: receive queues to bind the dmabuf to.
+ * @NETDEV_A_DMABUF_FD: dmabuf file descriptor to bind.
+ * @NETDEV_A_DMABUF_ID: id of the dmabuf binding
+ */
 enum {
 	NETDEV_A_DMABUF_IFINDEX = 1,
 	NETDEV_A_DMABUF_QUEUES,
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 680d1522dc87..cff05828d79b 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -30,6 +30,43 @@ enum ovpn_key_slot {
 	OVPN_KEY_SLOT_SECONDARY,
 };
 
+/**
+ * enum ovpn_peer
+ * @OVPN_A_PEER_ID: The unique ID of the peer in the device context. To be used
+ *   to identify peers during operations for a specific device
+ * @OVPN_A_PEER_REMOTE_IPV4: The remote IPv4 address of the peer
+ * @OVPN_A_PEER_REMOTE_IPV6: The remote IPv6 address of the peer
+ * @OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID: The scope id of the remote IPv6 address
+ *   of the peer (RFC2553)
+ * @OVPN_A_PEER_REMOTE_PORT: The remote port of the peer
+ * @OVPN_A_PEER_SOCKET: The socket to be used to communicate with the peer
+ * @OVPN_A_PEER_SOCKET_NETNSID: The ID of the netns the socket assigned to this
+ *   peer lives in
+ * @OVPN_A_PEER_VPN_IPV4: The IPv4 address assigned to the peer by the server
+ * @OVPN_A_PEER_VPN_IPV6: The IPv6 address assigned to the peer by the server
+ * @OVPN_A_PEER_LOCAL_IPV4: The local IPv4 to be used to send packets to the
+ *   peer (UDP only)
+ * @OVPN_A_PEER_LOCAL_IPV6: The local IPv6 to be used to send packets to the
+ *   peer (UDP only)
+ * @OVPN_A_PEER_LOCAL_PORT: The local port to be used to send packets to the
+ *   peer (UDP only)
+ * @OVPN_A_PEER_KEEPALIVE_INTERVAL: The number of seconds after which a keep
+ *   alive message is sent to the peer
+ * @OVPN_A_PEER_KEEPALIVE_TIMEOUT: The number of seconds from the last activity
+ *   after which the peer is assumed dead
+ * @OVPN_A_PEER_DEL_REASON: The reason why a peer was deleted
+ * @OVPN_A_PEER_VPN_RX_BYTES: Number of bytes received over the tunnel
+ * @OVPN_A_PEER_VPN_TX_BYTES: Number of bytes transmitted over the tunnel
+ * @OVPN_A_PEER_VPN_RX_PACKETS: Number of packets received over the tunnel
+ * @OVPN_A_PEER_VPN_TX_PACKETS: Number of packets transmitted over the tunnel
+ * @OVPN_A_PEER_LINK_RX_BYTES: Number of bytes received at the transport level
+ * @OVPN_A_PEER_LINK_TX_BYTES: Number of bytes transmitted at the transport
+ *   level
+ * @OVPN_A_PEER_LINK_RX_PACKETS: Number of packets received at the transport
+ *   level
+ * @OVPN_A_PEER_LINK_TX_PACKETS: Number of packets transmitted at the transport
+ *   level
+ */
 enum {
 	OVPN_A_PEER_ID = 1,
 	OVPN_A_PEER_REMOTE_IPV4,
@@ -59,6 +96,18 @@ enum {
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
 };
 
+/**
+ * enum ovpn_keyconf
+ * @OVPN_A_KEYCONF_PEER_ID: The unique ID of the peer in the device context. To
+ *   be used to identify peers during key operations
+ * @OVPN_A_KEYCONF_SLOT: The slot where the key should be stored
+ * @OVPN_A_KEYCONF_KEY_ID: The unique ID of the key in the peer context. Used
+ *   to fetch the correct key upon decryption
+ * @OVPN_A_KEYCONF_CIPHER_ALG: The cipher to be used when communicating with
+ *   the peer
+ * @OVPN_A_KEYCONF_ENCRYPT_DIR: Key material for encrypt direction
+ * @OVPN_A_KEYCONF_DECRYPT_DIR: Key material for decrypt direction
+ */
 enum {
 	OVPN_A_KEYCONF_PEER_ID = 1,
 	OVPN_A_KEYCONF_SLOT,
@@ -71,6 +120,12 @@ enum {
 	OVPN_A_KEYCONF_MAX = (__OVPN_A_KEYCONF_MAX - 1)
 };
 
+/**
+ * enum ovpn_keydir
+ * @OVPN_A_KEYDIR_CIPHER_KEY: The actual key to be used by the cipher
+ * @OVPN_A_KEYDIR_NONCE_TAIL: Random nonce to be concatenated to the packet ID,
+ *   in order to obtain the actual cipher IV
+ */
 enum {
 	OVPN_A_KEYDIR_CIPHER_KEY = 1,
 	OVPN_A_KEYDIR_NONCE_TAIL,
@@ -79,6 +134,13 @@ enum {
 	OVPN_A_KEYDIR_MAX = (__OVPN_A_KEYDIR_MAX - 1)
 };
 
+/**
+ * enum ovpn_ovpn
+ * @OVPN_A_IFINDEX: Index of the ovpn interface to operate on
+ * @OVPN_A_PEER: The peer object containing the attributed of interest for the
+ *   specific operation
+ * @OVPN_A_KEYCONF: Peer specific cipher configuration
+ */
 enum {
 	OVPN_A_IFINDEX = 1,
 	OVPN_A_PEER,
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..4d5169fc798d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -82,6 +82,16 @@ enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_ENABLED,
 };
 
+/**
+ * enum netdev_dev
+ * @NETDEV_A_DEV_IFINDEX: netdev ifindex
+ * @NETDEV_A_DEV_XDP_FEATURES: Bitmask of enabled xdp-features.
+ * @NETDEV_A_DEV_XDP_ZC_MAX_SEGS: max fragment count supported by ZC driver
+ * @NETDEV_A_DEV_XDP_RX_METADATA_FEATURES: Bitmask of supported XDP receive
+ *   metadata features. See Documentation/networking/xdp-rx-metadata.rst for
+ *   more details.
+ * @NETDEV_A_DEV_XSK_FEATURES: Bitmask of enabled AF_XDP features.
+ */
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
@@ -99,6 +109,29 @@ enum {
 	NETDEV_A_IO_URING_PROVIDER_INFO_MAX = (__NETDEV_A_IO_URING_PROVIDER_INFO_MAX - 1)
 };
 
+/**
+ * enum netdev_page_pool
+ * @NETDEV_A_PAGE_POOL_ID: Unique ID of a Page Pool instance.
+ * @NETDEV_A_PAGE_POOL_IFINDEX: ifindex of the netdev to which the pool
+ *   belongs. May be reported as 0 if the page pool was allocated for a netdev
+ *   which got destroyed already (page pools may outlast their netdevs because
+ *   they wait for all memory to be returned).
+ * @NETDEV_A_PAGE_POOL_NAPI_ID: Id of NAPI using this Page Pool instance.
+ * @NETDEV_A_PAGE_POOL_INFLIGHT: Number of outstanding references to this page
+ *   pool (allocated but yet to be freed pages). Allocated pages may be held in
+ *   socket receive queues, driver receive ring, page pool recycling ring, the
+ *   page pool cache, etc.
+ * @NETDEV_A_PAGE_POOL_INFLIGHT_MEM: Amount of memory held by inflight pages.
+ * @NETDEV_A_PAGE_POOL_DETACH_TIME: Seconds in CLOCK_BOOTTIME of when Page Pool
+ *   was detached by the driver. Once detached Page Pool can no longer be used
+ *   to allocate memory. Page Pools wait for all the memory allocated from them
+ *   to be freed before truly disappearing. "Detached" Page Pools cannot be
+ *   "re-attached", they are just waiting to disappear. Attribute is absent if
+ *   Page Pool has not been detached, and can still be used to allocate new
+ *   memory.
+ * @NETDEV_A_PAGE_POOL_DMABUF: ID of the dmabuf this page-pool is attached to.
+ * @NETDEV_A_PAGE_POOL_IO_URING: io-uring memory provider information.
+ */
 enum {
 	NETDEV_A_PAGE_POOL_ID = 1,
 	NETDEV_A_PAGE_POOL_IFINDEX,
@@ -113,6 +146,11 @@ enum {
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
 };
 
+/**
+ * enum netdev_page_pool_stats - Page pool statistics, see docs for struct
+ *   page_pool_stats for information about individual statistics.
+ * @NETDEV_A_PAGE_POOL_STATS_INFO: Page pool identifying information.
+ */
 enum {
 	NETDEV_A_PAGE_POOL_STATS_INFO = 1,
 	NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST = 8,
@@ -131,6 +169,28 @@ enum {
 	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
 };
 
+/**
+ * enum netdev_napi
+ * @NETDEV_A_NAPI_IFINDEX: ifindex of the netdevice to which NAPI instance
+ *   belongs.
+ * @NETDEV_A_NAPI_ID: ID of the NAPI instance.
+ * @NETDEV_A_NAPI_IRQ: The associated interrupt vector number for the napi
+ * @NETDEV_A_NAPI_PID: PID of the napi thread, if NAPI is configured to operate
+ *   in threaded mode. If NAPI is not in threaded mode (i.e. uses normal
+ *   softirq context), the attribute will be absent.
+ * @NETDEV_A_NAPI_DEFER_HARD_IRQS: The number of consecutive empty polls before
+ *   IRQ deferral ends and hardware IRQs are re-enabled.
+ * @NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT: The timeout, in nanoseconds, of when to
+ *   trigger the NAPI watchdog timer which schedules NAPI processing.
+ *   Additionally, a non-zero value will also prevent GRO from flushing recent
+ *   super-frames at the end of a NAPI cycle. This may add receive latency in
+ *   exchange for reducing the number of frames processed by the network stack.
+ * @NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT: The timeout, in nanoseconds, of how long
+ *   to suspend irq processing, if event polling finds events
+ * @NETDEV_A_NAPI_THREADED: Whether the NAPI is configured to operate in
+ *   threaded polling mode. If this is set to enabled then the NAPI context
+ *   operates in threaded polling mode.
+ */
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
@@ -150,6 +210,22 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+/**
+ * enum netdev_queue
+ * @NETDEV_A_QUEUE_ID: Queue index; most queue types are indexed like a C
+ *   array, with indexes starting at 0 and ending at queue count - 1. Queue
+ *   indexes are scoped to an interface and queue type.
+ * @NETDEV_A_QUEUE_IFINDEX: ifindex of the netdevice to which the queue
+ *   belongs.
+ * @NETDEV_A_QUEUE_TYPE: Queue type as rx, tx. Each queue type defines a
+ *   separate ID space. XDP TX queues allocated in the kernel are not linked to
+ *   NAPIs and thus not listed. AF_XDP queues will have more information set in
+ *   the xsk attribute.
+ * @NETDEV_A_QUEUE_NAPI_ID: ID of the NAPI instance which services this queue.
+ * @NETDEV_A_QUEUE_DMABUF: ID of the dmabuf attached to this queue, if any.
+ * @NETDEV_A_QUEUE_IO_URING: io_uring memory provider information.
+ * @NETDEV_A_QUEUE_XSK: XSK information for this queue, if any.
+ */
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -163,6 +239,88 @@ enum {
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
 };
 
+/**
+ * enum netdev_qstats - Get device statistics, scoped to a device or a queue.
+ *   These statistics extend (and partially duplicate) statistics available in
+ *   struct rtnl_link_stats64. Value of the `scope` attribute determines how
+ *   statistics are aggregated. When aggregated for the entire device the
+ *   statistics represent the total number of events since last explicit reset
+ *   of the device (i.e. not a reconfiguration like changing queue count). When
+ *   reported per-queue, however, the statistics may not add up to the total
+ *   number of events, will only be reported for currently active objects, and
+ *   will likely report the number of events since last reconfiguration.
+ * @NETDEV_A_QSTATS_IFINDEX: ifindex of the netdevice to which stats belong.
+ * @NETDEV_A_QSTATS_QUEUE_TYPE: Queue type as rx, tx, for queue-id.
+ * @NETDEV_A_QSTATS_QUEUE_ID: Queue ID, if stats are scoped to a single queue
+ *   instance.
+ * @NETDEV_A_QSTATS_SCOPE: What object type should be used to iterate over the
+ *   stats.
+ * @NETDEV_A_QSTATS_RX_PACKETS: Number of wire packets successfully received
+ *   and passed to the stack. For drivers supporting XDP, XDP is considered the
+ *   first layer of the stack, so packets consumed by XDP are still counted
+ *   here.
+ * @NETDEV_A_QSTATS_RX_BYTES: Successfully received bytes, see `rx-packets`.
+ * @NETDEV_A_QSTATS_TX_PACKETS: Number of wire packets successfully sent.
+ *   Packet is considered to be successfully sent once it is in device memory
+ *   (usually this means the device has issued a DMA completion for the
+ *   packet).
+ * @NETDEV_A_QSTATS_TX_BYTES: Successfully sent bytes, see `tx-packets`.
+ * @NETDEV_A_QSTATS_RX_ALLOC_FAIL: Number of times skb or buffer allocation
+ *   failed on the Rx datapath. Allocation failure may, or may not result in a
+ *   packet drop, depending on driver implementation and whether system
+ *   recovers quickly.
+ * @NETDEV_A_QSTATS_RX_HW_DROPS: Number of all packets which entered the
+ *   device, but never left it, including but not limited to: packets dropped
+ *   due to lack of buffer space, processing errors, explicit or implicit
+ *   policies and packet filters.
+ * @NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS: Number of packets dropped due to
+ *   transient lack of resources, such as buffer space, host descriptors etc.
+ * @NETDEV_A_QSTATS_RX_CSUM_COMPLETE: Number of packets that were marked as
+ *   CHECKSUM_COMPLETE.
+ * @NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY: Number of packets that were marked as
+ *   CHECKSUM_UNNECESSARY.
+ * @NETDEV_A_QSTATS_RX_CSUM_NONE: Number of packets that were not checksummed
+ *   by device.
+ * @NETDEV_A_QSTATS_RX_CSUM_BAD: Number of packets with bad checksum. The
+ *   packets are not discarded, but still delivered to the stack.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_PACKETS: Number of packets that were coalesced
+ *   from smaller packets by the device. Counts only packets coalesced with the
+ *   HW-GRO netdevice feature, LRO-coalesced packets are not counted.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_BYTES: See `rx-hw-gro-packets`.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS: Number of packets that were
+ *   coalesced to bigger packetss with the HW-GRO netdevice feature.
+ *   LRO-coalesced packets are not counted.
+ * @NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES: See `rx-hw-gro-wire-packets`.
+ * @NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS: Number of the packets dropped by the
+ *   device due to the received packets bitrate exceeding the device rate
+ *   limit.
+ * @NETDEV_A_QSTATS_TX_HW_DROPS: Number of packets that arrived at the device
+ *   but never left it, encompassing packets dropped for reasons such as
+ *   processing errors, as well as those affected by explicitly defined
+ *   policies and packet filtering criteria.
+ * @NETDEV_A_QSTATS_TX_HW_DROP_ERRORS: Number of packets dropped because they
+ *   were invalid or malformed.
+ * @NETDEV_A_QSTATS_TX_CSUM_NONE: Number of packets that did not require the
+ *   device to calculate the checksum.
+ * @NETDEV_A_QSTATS_TX_NEEDS_CSUM: Number of packets that required the device
+ *   to calculate the checksum. This counter includes the number of GSO wire
+ *   packets for which device calculated the L4 checksum.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_PACKETS: Number of packets that necessitated
+ *   segmentation into smaller packets by the device.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_BYTES: See `tx-hw-gso-packets`.
+ * @NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS: Number of wire-sized packets
+ *   generated by processing `tx-hw-gso-packets`
+ * @NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES: See `tx-hw-gso-wire-packets`.
+ * @NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS: Number of the packets dropped by the
+ *   device due to the transmit packets bitrate exceeding the device rate
+ *   limit.
+ * @NETDEV_A_QSTATS_TX_STOP: Number of times driver paused accepting new tx
+ *   packets from the stack to this queue, because the queue was full. Note
+ *   that if BQL is supported and enabled on the device the networking stack
+ *   will avoid queuing a lot of data at once.
+ * @NETDEV_A_QSTATS_TX_WAKE: Number of times driver re-started accepting send
+ *   requests to this queue from the stack.
+ */
 enum {
 	NETDEV_A_QSTATS_IFINDEX = 1,
 	NETDEV_A_QSTATS_QUEUE_TYPE,
@@ -200,6 +358,13 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+/**
+ * enum netdev_dmabuf
+ * @NETDEV_A_DMABUF_IFINDEX: netdev ifindex to bind the dmabuf to.
+ * @NETDEV_A_DMABUF_QUEUES: receive queues to bind the dmabuf to.
+ * @NETDEV_A_DMABUF_FD: dmabuf file descriptor to bind.
+ * @NETDEV_A_DMABUF_ID: id of the dmabuf binding
+ */
 enum {
 	NETDEV_A_DMABUF_IFINDEX = 1,
 	NETDEV_A_DMABUF_QUEUES,
-- 
2.47.3


