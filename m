Return-Path: <netdev+bounces-286126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULRFKTL5/mnu0gAAu9opvQ
	(envelope-from <netdev+bounces-286126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A0B4FEE64
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D136B30086A9
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BE39184B;
	Sat,  9 May 2026 09:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC92046BA;
	Sat,  9 May 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317610; cv=none; b=V3uUhgtsRhgML/rdEF/OWYssOlldEqr7aa86zHQI04wVPw7UdCBh1/rb6Am2t/EGGYnklNxG/pBfg3LQYuhbVy/yVHWJkcce0kv2rx+oHTswnDP9e2jWMaYbBk0YWt8gvywSmz3ZdHNVAdvxDRFybvv3b1IXUTO0/tP4xxw/MxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317610; c=relaxed/simple;
	bh=qSCsA/sYeQew9IeiwAKUuFOND5/wLU5A/6y583TGt3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V56f9oynLR37w/xVmYO5gL8sdlvWh+PE5is8ufeKqmKUBiBQKXLaCHIGK90JWKC+q25pwaMDyWr4JqkiD/SecckJk3+5izOiz8b9l94hgE7AXw1MWV/vFEFoRm8661o0W0hYkmUX5DtCEWsyajmFxY7z0TtrR4D/IiILXbvTZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FA77203A21;
	Sat,  9 May 2026 11:06:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F408320232C;
	Sat,  9 May 2026 11:06:45 +0200 (CEST)
Received: from lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com [10.52.8.159])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 19F2C18002DC;
	Sat,  9 May 2026 17:06:44 +0800 (+08)
From: Minghuan Lian <minghuan.lian@nxp.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: [PATCH net-next 2/4] net: dsa: tag_hms: Add HMS tag protocol
Date: Sat,  9 May 2026 18:06:30 +0900
Message-ID: <20260509090632.2959553-3-minghuan.lian@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509090632.2959553-1-minghuan.lian@nxp.com>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: E1A0B4FEE64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286126-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.215];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minghuan.lian@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Add a DSA tagger for NXP Heterogeneous Multi-SoC (HMS) switches.

HMS is used by systems where the Ethernet switch is managed by firmware
running on a companion SoC or MCU, while Linux runs on the host SoC and
exposes the switch ports through DSA. The host data path uses a regular
Ethernet controller as the DSA conduit port.

The HMS tag protocol has two frame formats. Regular data traffic is
identified using DSA tag_8021q VLAN IDs, which provide the source and
destination port information needed by DSA without requiring a custom
Ethernet header on every packet.

Link-local and control traffic uses an HMS meta frame format with
EtherType ETH_P_HMS_META. This is needed for frames where explicit
metadata must be exchanged with the switch firmware, such as slow
protocols, PTP-over-Ethernet traffic and in-band control notifications.
The tagger parses received meta frames, resolves the source switch and
port, and provides a callback hook for the switch driver to handle meta
commands.

The tagger therefore supports both:
  - tag_8021q based transmit and receive handling for regular data
    traffic
  - HMS meta frame transmit and receive handling for link-local and
    control traffic

Signed-off-by: Minghuan Lian <minghuan.lian@nxp.com>
---
 include/linux/dsa/tag_hms.h |  28 +++
 include/net/dsa.h           |   2 +
 net/dsa/Kconfig             |   9 +
 net/dsa/Makefile            |   1 +
 net/dsa/tag_hms.c           | 366 ++++++++++++++++++++++++++++++++++++
 5 files changed, 406 insertions(+)
 create mode 100644 include/linux/dsa/tag_hms.h
 create mode 100644 net/dsa/tag_hms.c

diff --git a/include/linux/dsa/tag_hms.h b/include/linux/dsa/tag_hms.h
new file mode 100644
index 0000000000000..180e969dc06f4
--- /dev/null
+++ b/include/linux/dsa/tag_hms.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _NET_DSA_TAG_HMS_H
+#define _NET_DSA_TAG_HMS_H
+
+#include <linux/dsa/8021q.h>
+#include <net/dsa.h>
+
+#define ETH_P_HMS_8021Q	ETH_P_8021Q /* 0x8100 */
+
+#define HMS_META_ETYPE	0xDADC /* HMS internal meta frame EtherType */
+
+/* IEEE 802.3 Annex 57A: Slow Protocols PDUs (01:80:C2:xx:xx:xx) */
+#define HMS_LINKLOCAL_FILTER_A		0x0180C2000000ull
+#define HMS_LINKLOCAL_FILTER_A_MASK	0xFFFFFF000000ull
+/* IEEE 1588 Annex F: Transport of PTP over Ethernet (01:1B:19:xx:xx:xx) */
+#define HMS_LINKLOCAL_FILTER_B		0x011B19000000ull
+#define HMS_LINKLOCAL_FILTER_B_MASK	0xFFFFFF000000ull
+
+struct hms_tagger_data {
+	void (*meta_cmd_handler)(struct dsa_switch *ds, int port,
+				 void *buf, size_t len);
+};
+
+#endif /* _NET_DSA_TAG_HMS_H */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2ec..625dee53488dc 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_HMS_VALUE			33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_HMS		= DSA_TAG_PROTO_HMS_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636dd..3f0295a364f18 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -211,4 +211,13 @@ config NET_DSA_TAG_YT921X
 	  Say Y or M if you want to enable support for tagging frames for
 	  Motorcomm YT921x switches.
 
+config NET_DSA_TAG_HMS
+	tristate "Tag driver for NXP Heterogeneous Multi-SoC switches"
+	select NET_DSA_TAG_8021Q
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  NXP Heterogeneous Multi-SoC switch family. This driver uses a
+	  custom 802.1Q VLAN header for injection and extraction of frames
+	  between the host and the NXP i.MX RT1180 NETC switch.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64a..5f9dbbe782381 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
+obj-$(CONFIG_NET_DSA_TAG_HMS) += tag_hms.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/net/dsa/tag_hms.c b/net/dsa/tag_hms.c
new file mode 100644
index 0000000000000..ea485b7088ce7
--- /dev/null
+++ b/net/dsa/tag_hms.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/if_vlan.h>
+#include <linux/dsa/tag_hms.h>
+#include <linux/packing.h>
+#include <linux/slab.h>
+#include "tag.h"
+#include "tag_8021q.h"
+
+#define HMS_TAG_NAME		"hms"
+
+/*
+ * HMS meta header inserted after the source MAC address.
+ *
+ * |     2B      |     2B      |   0 / 4B / 8B / 12B / 16B / 20B |
+ * +------------ +-------------+---------------------------------+
+ * |    0xDADC   |   HEADER    |               DATA              |
+ * +------------ +------------ +---------------------------------+
+ */
+
+#define HMS_HEADER_LEN			4
+
+#define HMS_HEADER_HOST_TO_SWITCH	BIT(15)
+
+/* Binary structure of the HMS Header ETH_P_HMS_META:
+ *
+ * |   15      |  14  |     13    |   12  |  11   | 10 - 9 |   7 - 4   |  3 - 0  |
+ * +-----------+------+-----------+-------+-------+--------+-----------+---------+
+ * | TO HOST 0 | META | HOST Only |       |       |        | Switch ID | Port ID |
+ * +-----------+------+-----------+-------+-------+--------+-----------+---------+
+ */
+#define HMS_RX_HEADER_IS_METADATA	BIT(14)
+#define HMS_RX_HEADER_HOST_ONLY		BIT(13)
+
+#define HMS_HEADER_PORT_MASK		0x0F
+#define HMS_HEADER_SWITCH_MASK		0xF0
+#define HMS_HEADER_SWITCH_OFFSET	4
+#define HMS_RX_HEADER_PORT_ID(x)	((x) & HMS_HEADER_PORT_MASK)
+#define HMS_RX_HEADER_SWITCH_ID(x)	(((x) & HMS_HEADER_SWITCH_MASK) >> HMS_HEADER_SWITCH_OFFSET)
+
+/* TX header */
+
+/*
+ * Binary structure of the HMS Header ETH_P_HMS_META:
+ *
+ * |   15      |  14  |   13   |   12  |  11     | 10 - 9 |  7 - 4    |  3 - 0  |
+ * +-----------+------+--------+-------+---------+--------+-----------+---------+
+ * |  To SW 1  | META |        |       |         |        | SWITCH ID | PORT ID |
+ * +-----------+------+--------+-------+------  -+--------+-----------+---------+
+ */
+
+#define HMS_TX_HEADER_SWITCHID(x)	(((x) << HMS_HEADER_SWITCH_OFFSET) & HMS_HEADER_SWITCH_MASK)
+#define HMS_TX_HEADER_DESTPORTID(x)	((x) & HMS_HEADER_PORT_MASK)
+
+/* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
+static inline bool hms_is_link_local(const struct sk_buff *skb)
+{
+	const struct ethhdr *hdr = eth_hdr(skb);
+	u64 dmac = ether_addr_to_u64(hdr->h_dest);
+
+	if (ntohs(hdr->h_proto) == HMS_META_ETYPE)
+		return true;
+
+	if ((dmac & HMS_LINKLOCAL_FILTER_A_MASK) ==
+	     HMS_LINKLOCAL_FILTER_A)
+		return true;
+
+	if ((dmac & HMS_LINKLOCAL_FILTER_B_MASK) ==
+	     HMS_LINKLOCAL_FILTER_B)
+		return true;
+
+	return false;
+}
+
+/* Send VLAN tags with a TPID that blends in with whatever VLAN protocol a
+ * bridge spanning ports of this switch might have.
+ */
+static u16 hms_xmit_tpid(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *other_dp;
+	u16 proto;
+
+	if (!dsa_port_is_vlan_filtering(dp))
+		return ETH_P_HMS_8021Q;
+
+	/* Port is VLAN-aware, so there is a bridge somewhere (a single one,
+	 * we're sure about that). It may not be on this port though, so we
+	 * need to find it.
+	 */
+	dsa_switch_for_each_port(other_dp, ds) {
+		struct net_device *br = dsa_port_bridge_dev_get(other_dp);
+
+		if (!br)
+			continue;
+
+		/* Error is returned only if CONFIG_BRIDGE_VLAN_FILTERING,
+		 * which seems pointless to handle, as our port cannot become
+		 * VLAN-aware in that case.
+		 */
+		br_vlan_get_proto(br, &proto);
+
+		return proto;
+	}
+
+	WARN_ONCE(1, "Port is VLAN-aware but cannot find associated bridge!\n");
+
+	return ETH_P_HMS_8021Q;
+}
+
+static struct sk_buff *hms_imprecise_xmit(struct sk_buff *skb,
+					  struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+	struct net_device *br = dsa_port_bridge_dev_get(dp);
+	u16 tx_vid;
+
+	/* If the port is under a VLAN-aware bridge, just slide the
+	 * VLAN-tagged packet into the FDB and hope for the best.
+	 * This works because we support a single VLAN-aware bridge
+	 * across the entire dst, and its VLANs cannot be shared with
+	 * any standalone port.
+	 */
+	if (br_vlan_enabled(br))
+		return skb;
+
+	/* If the port is under a VLAN-unaware bridge, use an imprecise
+	 * TX VLAN that targets the bridge's entire broadcast domain,
+	 * instead of just the specific port.
+	 */
+	tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+
+	if (unlikely(skb_vlan_tag_present(skb))) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb) {
+			WARN_ONCE(1, "Failed to push VLAN tag to payload!\n");
+			return NULL;
+		}
+	}
+
+	return dsa_8021q_xmit(skb, netdev, hms_xmit_tpid(dp), tx_vid);
+}
+
+static struct sk_buff *hms_meta_xmit(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	int len = HMS_HEADER_LEN;
+	__be16 *tx_header;
+
+	skb_push(skb, len);
+
+	dsa_alloc_etype_header(skb, len);
+
+	tx_header = dsa_etype_header_pos_tx(skb);
+
+	tx_header[0] = htons(HMS_META_ETYPE);
+	tx_header[1] = htons(HMS_HEADER_HOST_TO_SWITCH |
+			     HMS_TX_HEADER_SWITCHID(dp->ds->index) |
+			     HMS_TX_HEADER_DESTPORTID(dp->index));
+
+	return skb;
+}
+
+static struct sk_buff *hms_8021q_xmit(struct sk_buff *skb,
+				      struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
+	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+
+	return dsa_8021q_xmit(skb, netdev, hms_xmit_tpid(dp),
+			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+}
+
+static struct sk_buff *hms_xmit(struct sk_buff *skb,
+				struct net_device *netdev)
+{
+	if (skb->offload_fwd_mark)
+		return hms_imprecise_xmit(skb, netdev);
+
+	if (unlikely(hms_is_link_local(skb)))
+		return hms_meta_xmit(skb, netdev);
+
+	return hms_8021q_xmit(skb, netdev);
+}
+
+static bool hms_skb_has_tag_8021q(const struct sk_buff *skb)
+{
+	u16 tpid = ntohs(eth_hdr(skb)->h_proto);
+
+	return tpid == ETH_P_8021AD || tpid == ETH_P_8021Q ||
+	       skb_vlan_tag_present(skb);
+}
+
+static bool hms_skb_has_inband_control_extension(const struct sk_buff *skb)
+{
+	return ntohs(eth_hdr(skb)->h_proto) == HMS_META_ETYPE;
+}
+
+static struct sk_buff *hms_rcv_meta_cmd(struct sk_buff *skb, u16 rx_header)
+{
+	u8 *buf = dsa_etype_header_pos_rx(skb) + HMS_HEADER_LEN;
+	int switch_id = HMS_RX_HEADER_SWITCH_ID(rx_header);
+	int source_port = HMS_RX_HEADER_PORT_ID(rx_header);
+	struct hms_tagger_data *tagger_data;
+	struct net_device *master = skb->dev;
+	struct dsa_port *cpu_dp;
+	struct dsa_switch *ds;
+
+	cpu_dp = master->dsa_ptr;
+	ds = dsa_switch_find(cpu_dp->dst->index, switch_id);
+	if (!ds) {
+		net_err_ratelimited("%s: cannot find switch id %d\n",
+				    master->name, switch_id);
+		return NULL;
+	}
+
+	tagger_data = ds->tagger_data;
+	if (!tagger_data->meta_cmd_handler)
+		return NULL;
+
+	if (skb_is_nonlinear(skb))
+		if (skb_linearize(skb))
+			return NULL;
+
+	tagger_data->meta_cmd_handler(ds, source_port, buf,
+				skb->len - HMS_HEADER_LEN - 2 * ETH_ALEN);
+
+	/* Discard the meta frame */
+	return NULL;
+}
+
+static struct sk_buff *hms_rcv_inband_control_extension(struct sk_buff *skb,
+							int *source_port,
+							int *switch_id,
+							bool *host_only)
+{
+	u16 rx_header;
+	int len = 0;
+
+	if (unlikely(!pskb_may_pull(skb, HMS_HEADER_LEN)))
+		return NULL;
+
+	rx_header = ntohs(*(__be16 *)skb->data);
+	if (rx_header & HMS_RX_HEADER_HOST_ONLY)
+		*host_only = true;
+
+	if (rx_header & HMS_RX_HEADER_IS_METADATA)
+		return hms_rcv_meta_cmd(skb, rx_header);
+
+	*source_port = HMS_RX_HEADER_PORT_ID(rx_header);
+	*switch_id = HMS_RX_HEADER_SWITCH_ID(rx_header);
+
+	len += HMS_HEADER_LEN;
+
+	/* Advance skb->data past the DSA header */
+	skb_pull_rcsum(skb, len);
+
+	dsa_strip_etype_header(skb, len);
+
+	/* With skb->data in its final place, update the MAC header
+	 * so that eth_hdr() continues to works properly.
+	 */
+	skb_set_mac_header(skb, -ETH_HLEN);
+
+	return skb;
+}
+
+/* If the VLAN in the packet is a tag_8021q one, set @source_port and
+ * @switch_id and strip the header. Otherwise set @vid and keep it in the
+ * packet.
+ */
+static void hms_vlan_rcv(struct sk_buff *skb, int *source_port,
+			 int *switch_id, int *vbid, int *vid)
+{
+	dsa_8021q_rcv(skb, source_port, switch_id, vbid, vid);
+}
+
+static struct sk_buff *hms_rcv(struct sk_buff *skb,
+			       struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
+	bool host_only = false;
+
+	if (hms_skb_has_inband_control_extension(skb)) {
+		skb = hms_rcv_inband_control_extension(skb, &src_port,
+						       &switch_id,
+						       &host_only);
+		if (!skb)
+			return NULL;
+	}
+
+	/* Packets with in-band control extensions might still have RX VLANs */
+	if (likely(hms_skb_has_tag_8021q(skb)))
+		hms_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+
+	if (src_port == -1) /* Need to check it - bridge mode */
+		return NULL;
+
+	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id,
+					   vid, vbid);
+	if (!skb->dev) {
+		/* netdev_warn(netdev, "Couldn't decode source port\n"); */
+		return NULL;
+	}
+
+	if (!host_only)
+		dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static void hms_disconnect(struct dsa_switch *ds)
+{
+	struct hms_tagger_data *tagger_data = ds->tagger_data;
+
+	kfree(tagger_data);
+	ds->tagger_data = NULL;
+}
+
+static int hms_connect(struct dsa_switch *ds)
+{
+	struct hms_tagger_data *data;
+
+	data = kzalloc_obj(*data, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ds->tagger_data = data;
+
+	return 0;
+}
+
+static void hms_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+			     int *offset)
+{
+	/* No tag added for management frames, all ok */
+	if (unlikely(hms_is_link_local(skb)))
+		return;
+
+	dsa_tag_generic_flow_dissect(skb, proto, offset);
+}
+
+static const struct dsa_device_ops hms_netdev_ops = {
+	.name			= HMS_TAG_NAME,
+	.proto			= DSA_TAG_PROTO_HMS,
+	.xmit			= hms_xmit,
+	.rcv			= hms_rcv,
+	.connect		= hms_connect,
+	.disconnect		= hms_disconnect,
+	.needed_headroom	= VLAN_HLEN,
+	.flow_dissect		= hms_flow_dissect,
+	.promisc_on_conduit	= true,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Heterogeneous Multi-SoC switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_HMS, HMS_TAG_NAME);
+
+module_dsa_tag_driver(hms_netdev_ops);
-- 
2.43.0


