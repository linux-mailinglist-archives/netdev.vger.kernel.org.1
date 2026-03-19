Return-Path: <netdev+bounces-269501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKlfJKsVvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:26:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B92CDB42
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E30E32C91C3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8D3E5597;
	Thu, 19 Mar 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="yGRMOjHo"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577A3E1212;
	Thu, 19 Mar 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933632; cv=none; b=Sj2/qpzK9th8LQxFsJVh2QEyATUvdpFic0iKdMytvQ61tqj35VkwdfkL9BCfhXirKdTTeTsbY2rwg/MSoV5vlJFNad8eUc146bAsekk4BjFuRNvtAg+WoFSiAxXJNfYuPDKWcnm1kyyJvvGQhiUStnwNblREN4oi3ElyhONV3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933632; c=relaxed/simple;
	bh=FwOP6Y/r6cUNiycZePr8tA9psg2KP7NGp0NJhxq+fo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d89pwx8qpKr5gaQ+X/r4TuUt8LQ7uEaqlYaOSAx20Tp4kLTmBIfUxAVKuMW3jYb44uSaj2AgpRhXx8KxSaPdG7GMC/64gewOleK9mcvS4B9+U7CQdTI4qKDmQRnoWcpfCS+i5mof7+jEi94QkiUYyC9HCQjJ0JGY/DlibaRWhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=yGRMOjHo; arc=none smtp.client-ip=195.10.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4fc8N93hc4zDs24;
	Thu, 19 Mar 2026 16:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HCdS8enImfVbeBMGZCgmGJPoYxliDdYncuxGpUTcFA=;
	b=yGRMOjHopOG68LpT6zhbwRr44VdpaZNuPkv/Qvdmz5tri+fCh0aFRWT/rHffbp0OGzT+/a
	99C/Q9i2J+IQXgMCZ3lpXx+2oMceK9jxfQsiYk0YlnMkc1eOMdYaAz1gEqiPRGr+YJhkqg
	DILTkjvZe1lQyHd4jXmvfVD02S2emavzVojiP0g/3NATmIjBQ4bnnQkZf422+hn08TcXrk
	UoHnGqsk4hV2cfGpGKcAgyI1CCNXQXLcH25onPEJT367qabTvwGkWlQKOky16FQRiHY2k5
	PbMNY9oyjLVlNRSAj0mwDdQHKqFVgg/Cnskh7dAZK6OcWWImTX1WgaGbw/DBhg==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Thu, 19 Mar 2026 16:12:17 +0100
Message-ID: <20260319151230.655687-9-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269501-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,darkboxed.org:email,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid]
X-Rspamd-Queue-Id: F17B92CDB42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit introduces the core start_xmit processing flow: validate,
select action, translate, and forward. It centralizes action resolution
in the dispatch layer and keeps per-direction translation logic separate
from device glue. The result is a single data-path entry point with
explicit control over drop/forward/emit behavior.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/Makefile       |   4 +
 drivers/net/ipxlat/dispatch.c     | 104 +++++++++++++++
 drivers/net/ipxlat/dispatch.h     |  71 +++++++++++
 drivers/net/ipxlat/main.c         |   6 +-
 drivers/net/ipxlat/packet.c       |   1 +
 drivers/net/ipxlat/translate_46.c | 198 +++++++++++++++++++++++++++++
 drivers/net/ipxlat/translate_46.h |  73 +++++++++++
 drivers/net/ipxlat/translate_64.c | 205 ++++++++++++++++++++++++++++++
 drivers/net/ipxlat/translate_64.h |  56 ++++++++
 drivers/net/ipxlat/transport.c    |  11 ++
 drivers/net/ipxlat/transport.h    |   5 +
 11 files changed, 732 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ipxlat/dispatch.c
 create mode 100644 drivers/net/ipxlat/dispatch.h
 create mode 100644 drivers/net/ipxlat/translate_46.c
 create mode 100644 drivers/net/ipxlat/translate_46.h
 create mode 100644 drivers/net/ipxlat/translate_64.c
 create mode 100644 drivers/net/ipxlat/translate_64.h

diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
index 90dbc0489fa2..d7b7097aee5f 100644
--- a/drivers/net/ipxlat/Makefile
+++ b/drivers/net/ipxlat/Makefile
@@ -7,3 +7,7 @@ obj-$(CONFIG_IPXLAT) := ipxlat.o
 ipxlat-objs += main.o
 ipxlat-objs += address.o
 ipxlat-objs += packet.o
+ipxlat-objs += transport.o
+ipxlat-objs += dispatch.o
+ipxlat-objs += translate_46.o
+ipxlat-objs += translate_64.o
diff --git a/drivers/net/ipxlat/dispatch.c b/drivers/net/ipxlat/dispatch.c
new file mode 100644
index 000000000000..133d30859f49
--- /dev/null
+++ b/drivers/net/ipxlat/dispatch.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <net/ip.h>
+
+#include "dispatch.h"
+#include "packet.h"
+#include "translate_46.h"
+#include "translate_64.h"
+
+static enum ipxlat_action
+ipxlat_resolve_failed_action(const struct sk_buff *skb)
+{
+	return IPXLAT_ACT_DROP;
+}
+
+enum ipxlat_action ipxlat_translate(struct ipxlat_priv *ipxlat,
+				    struct sk_buff *skb)
+{
+	const u16 proto = ntohs(skb->protocol);
+
+	memset(skb->cb, 0, sizeof(struct ipxlat_cb));
+
+	if (proto == ETH_P_IPV6) {
+		if (unlikely(ipxlat_v6_validate_skb(skb)) ||
+		    unlikely(ipxlat_64_translate(ipxlat, skb)))
+			return ipxlat_resolve_failed_action(skb);
+
+		return IPXLAT_ACT_FWD;
+	} else if (likely(proto == ETH_P_IP)) {
+		if (unlikely(ipxlat_v4_validate_skb(ipxlat, skb)))
+			return ipxlat_resolve_failed_action(skb);
+
+		if (unlikely(ipxlat_46_translate(ipxlat, skb)))
+			return ipxlat_resolve_failed_action(skb);
+
+		return IPXLAT_ACT_FWD;
+	}
+
+	return IPXLAT_ACT_DROP;
+}
+
+/* mark current skb as drop-with-icmp and cache type/code/info for dispatch */
+void ipxlat_mark_icmp_drop(struct sk_buff *skb, u8 type, u8 code, u32 info)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+
+	cb->emit_icmp_err = true;
+	cb->icmp_err.type = type;
+	cb->icmp_err.code = code;
+	cb->icmp_err.info = info;
+}
+
+static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	const unsigned int len = skb->len;
+	int err;
+
+	/* reinject as a fresh packet with scrubbed metadata */
+	skb_set_queue_mapping(skb, 0);
+	skb_scrub_packet(skb, false);
+
+	err = gro_cells_receive(&ipxlat->gro_cells, skb);
+	if (likely(err == NET_RX_SUCCESS))
+		dev_dstats_rx_add(ipxlat->dev, len);
+	/* on failure gro_cells updates rx drop stats internally */
+}
+
+int ipxlat_process_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+		       bool allow_pre_frag)
+{
+	enum ipxlat_action action;
+	int err = -EINVAL;
+
+	(void)allow_pre_frag;
+
+	action = ipxlat_translate(ipxlat, skb);
+	switch (action) {
+	case IPXLAT_ACT_FWD:
+		dev_dstats_tx_add(ipxlat->dev, skb->len);
+		ipxlat_forward_pkt(ipxlat, skb);
+		return 0;
+	case IPXLAT_ACT_DROP:
+		goto drop_free;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		goto drop_free;
+	}
+
+drop_free:
+	dev_dstats_tx_dropped(ipxlat->dev);
+	kfree_skb(skb);
+	return err;
+}
diff --git a/drivers/net/ipxlat/dispatch.h b/drivers/net/ipxlat/dispatch.h
new file mode 100644
index 000000000000..fa6fafea656b
--- /dev/null
+++ b/drivers/net/ipxlat/dispatch.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_DISPATCH_H_
+#define _NET_IPXLAT_DISPATCH_H_
+
+#include "ipxlpriv.h"
+
+struct sk_buff;
+
+/**
+ * enum ipxlat_action - result of packet translation dispatch
+ * @IPXLAT_ACT_DROP: drop the packet
+ * @IPXLAT_ACT_FWD: packet translated and ready for forward reinjection
+ * @IPXLAT_ACT_PRE_FRAG: packet must be fragmented before 4->6 translation
+ * @IPXLAT_ACT_ICMP_ERR: drop packet and emit translator-generated ICMP error
+ */
+enum ipxlat_action {
+	IPXLAT_ACT_DROP,
+	IPXLAT_ACT_FWD,
+	IPXLAT_ACT_PRE_FRAG,
+	IPXLAT_ACT_ICMP_ERR,
+};
+
+/**
+ * ipxlat_mark_icmp_drop - cache translator-generated ICMP action in skb cb
+ * @skb: packet being rejected
+ * @type: ICMP type to emit
+ * @code: ICMP code to emit
+ * @info: ICMP auxiliary info (pointer/MTU), host-endian
+ *
+ * This does not emit immediately; dispatch consumes the mark later and sends
+ * the ICMP error through the appropriate address family path.
+ */
+void ipxlat_mark_icmp_drop(struct sk_buff *skb, u8 type, u8 code, u32 info);
+
+/**
+ * ipxlat_translate - validate/translate one packet and return next action
+ * @ipxlat: translator private context
+ * @skb: packet to process
+ *
+ * Return: one of &enum ipxlat_action.
+ */
+enum ipxlat_action ipxlat_translate(struct ipxlat_priv *ipxlat,
+				    struct sk_buff *skb);
+
+/**
+ * ipxlat_process_skb - top-level packet handler for ndo_start_xmit/reinjection
+ * @ipxlat: translator private context
+ * @skb: packet to process
+ * @allow_pre_frag: allow 4->6 pre-fragment action for this invocation
+ *
+ * The function always consumes @skb directly or through fragmentation
+ * callback/reinjection paths.
+ *
+ * Return: 0 on success, negative errno on processing failure.
+ */
+int ipxlat_process_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+		       bool allow_pre_frag);
+
+#endif /* _NET_IPXLAT_DISPATCH_H_ */
diff --git a/drivers/net/ipxlat/main.c b/drivers/net/ipxlat/main.c
index 26b7f5b6ff20..a1b4bcd39478 100644
--- a/drivers/net/ipxlat/main.c
+++ b/drivers/net/ipxlat/main.c
@@ -15,6 +15,7 @@
 
 #include <net/ip.h>
 
+#include "dispatch.h"
 #include "ipxlpriv.h"
 #include "main.h"
 
@@ -56,8 +57,9 @@ static void ipxlat_dev_uninit(struct net_device *dev)
 
 static int ipxlat_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	dev_dstats_tx_dropped(dev);
-	kfree_skb(skb);
+	struct ipxlat_priv *ipxlat = netdev_priv(dev);
+
+	ipxlat_process_skb(ipxlat, skb, true);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ipxlat/packet.c b/drivers/net/ipxlat/packet.c
index b9a9af1b3adb..b37a3e55aff8 100644
--- a/drivers/net/ipxlat/packet.c
+++ b/drivers/net/ipxlat/packet.c
@@ -13,6 +13,7 @@
 
 #include <linux/icmp.h>
 
+#include "dispatch.h"
 #include "packet.h"
 
 /* Shift cached skb cb offsets by the L3 header delta after in-place rewrite.
diff --git a/drivers/net/ipxlat/translate_46.c b/drivers/net/ipxlat/translate_46.c
new file mode 100644
index 000000000000..aec8500db2c2
--- /dev/null
+++ b/drivers/net/ipxlat/translate_46.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <net/ip6_route.h>
+
+#include "address.h"
+#include "packet.h"
+#include "transport.h"
+#include "translate_46.h"
+
+u8 ipxlat_46_map_proto_to_nexthdr(u8 protocol)
+{
+	return (protocol == IPPROTO_ICMP) ? NEXTHDR_ICMP : protocol;
+}
+
+void ipxlat_46_build_frag_hdr(struct frag_hdr *fh6, const struct iphdr *hdr4,
+			      u8 l4_proto)
+{
+	fh6->nexthdr = ipxlat_46_map_proto_to_nexthdr(l4_proto);
+	fh6->reserved = 0;
+	fh6->frag_off =
+		ipxlat_build_frag6_offset(ipxlat_get_frag4_offset(hdr4),
+					  !!(be16_to_cpu(hdr4->frag_off) &
+					     IP_MF));
+	fh6->identification = cpu_to_be32(be16_to_cpu(hdr4->id));
+}
+
+void ipxlat_46_build_l3(struct ipv6hdr *iph6, const struct iphdr *iph4,
+			unsigned int payload_len, u8 nexthdr, u8 hop_limit)
+{
+	iph6->version = 6;
+	iph6->priority = iph4->tos >> 4;
+	iph6->flow_lbl[0] = (iph4->tos & 0x0F) << 4;
+	iph6->flow_lbl[1] = 0;
+	iph6->flow_lbl[2] = 0;
+	iph6->payload_len = htons(payload_len);
+	iph6->nexthdr = nexthdr;
+	iph6->hop_limit = hop_limit;
+}
+
+/* Lookup post-translation IPv6 PMTU for 4->6 output decisions.
+ * Falls back to translator MTU on routing failures and clamps route MTU
+ * against translator egress MTU.
+ */
+unsigned int ipxlat_46_lookup_pmtu6(struct ipxlat_priv *ipxlat,
+				    const struct sk_buff *skb,
+				    const struct iphdr *in4)
+{
+	unsigned int mtu6, dev_mtu;
+	struct flowi6 fl6 = {};
+	struct dst_entry *dst;
+
+	dev_mtu = READ_ONCE(ipxlat->dev->mtu);
+
+	ipxlat_46_convert_addr(&ipxlat->xlat_prefix6, in4->saddr,
+			       &fl6.saddr);
+	ipxlat_46_convert_addr(&ipxlat->xlat_prefix6, in4->daddr,
+			       &fl6.daddr);
+	fl6.flowi6_mark = skb->mark;
+
+	dst = ip6_route_output(dev_net(ipxlat->dev), NULL, &fl6);
+	if (unlikely(dst->error)) {
+		mtu6 = dev_mtu;
+		goto out;
+	}
+
+	/* Route lookup can return a very large MTU (eg, local/loopback style
+	 * routes) that does not reflect the translator egress constraint.
+	 * Clamp with the translator device MTU so DF decisions are stable and
+	 * pre-fragment planning never targets packets larger than what this
+	 * interface can hand to the next stages.
+	 */
+	mtu6 = min_t(unsigned int, dst_mtu(dst), dev_mtu);
+
+out:
+	dst_release(dst);
+	return mtu6;
+}
+
+/**
+ * ipxlat_46_translate - translate one validated packet from IPv4 to IPv6
+ * @ipxlat: translator private context
+ * @skb: packet to translate
+ *
+ * Rewrites outer L3 in place, rebases cached offsets and translates L4 on
+ * first fragments only.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_46_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	unsigned int min_l4_len, old_l3_len, new_l3_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr outer4 = *ip_hdr(skb);
+	const u8 in_l4_proto = cb->l4_proto;
+	bool has_frag, first_frag;
+	struct frag_hdr *fh6;
+	struct ipv6hdr *iph6;
+	int l3_delta, err;
+	u8 out_l4_proto;
+
+	/* snapshot the original IPv4 header fields before skb layout changes */
+	has_frag = ip_is_fragment(&outer4);
+	first_frag = ipxlat_is_first_frag4(&outer4);
+	out_l4_proto = ipxlat_46_map_proto_to_nexthdr(in_l4_proto);
+
+	old_l3_len = cb->l3_hdr_len;
+	new_l3_len = sizeof(struct ipv6hdr) +
+		     (has_frag ? sizeof(struct frag_hdr) : 0);
+	l3_delta = (int)new_l3_len - (int)old_l3_len;
+
+	/* make room for the new hdrs */
+	if (unlikely(skb_cow_head(skb, max_t(int, 0, l3_delta))))
+		return -ENOMEM;
+
+	/* replace outer L3 area: drop IPv4 hdr, reserve IPv6(+Frag) hdr */
+	skb_pull(skb, old_l3_len);
+	skb_push(skb, new_l3_len);
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, new_l3_len);
+	skb->protocol = htons(ETH_P_IPV6);
+
+	/* build outer IPv6 base hdr from translated IPv4 fields */
+	iph6 = ipv6_hdr(skb);
+	ipxlat_46_build_l3(iph6, &outer4, skb->len - sizeof(*iph6),
+			   out_l4_proto, outer4.ttl - 1);
+
+	/* translate IPv4 endpoints into IPv6 addresses using xlat_prefix6 */
+	ipxlat_46_convert_addrs(&ipxlat->xlat_prefix6, &outer4, iph6);
+
+	/* add IPv6 fragment hdr when the IPv4 packet carried fragmentation */
+	if (unlikely(has_frag)) {
+		iph6->nexthdr = NEXTHDR_FRAGMENT;
+
+		fh6 = (struct frag_hdr *)(iph6 + 1);
+		ipxlat_46_build_frag_hdr(fh6, &outer4, in_l4_proto);
+		cb->fragh_off = sizeof(struct ipv6hdr);
+	}
+
+	/* Rebase cached offsets after L3 size delta.
+	 * For outer 4->6 translation this should not underflow: cached offsets
+	 * were built from l3_off + ip4_len(+...) and delta = ip6_len - ip4_len,
+	 * so ip4_len cancels out after rebasing. A failure here means internal
+	 * metadata inconsistency, not a packet validation outcome.
+	 */
+	err = ipxlat_cb_rebase_offsets(cb, l3_delta);
+	if (unlikely(err)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return err;
+	}
+
+	cb->l3_hdr_len = new_l3_len;
+	cb->l4_proto = out_l4_proto;
+	DEBUG_NET_WARN_ON_ONCE(!ipxlat_cb_offsets_valid(cb));
+
+	/* non-first fragments have no transport header to translate */
+	if (unlikely(!first_frag))
+		goto out;
+
+	/* ensure transport bytes are writable before L4 csum/proto rewrites */
+	min_l4_len = ipxlat_l4_min_len(in_l4_proto);
+	if (unlikely(skb_ensure_writable(skb, skb_transport_offset(skb) +
+						      min_l4_len)))
+		return -ENOMEM;
+
+	/* translate transport hdr and pseudohdr dependent checksums */
+	switch (in_l4_proto) {
+	case IPPROTO_TCP:
+		err = ipxlat_46_outer_tcp(skb, &outer4);
+		break;
+	case IPPROTO_UDP:
+		err = ipxlat_46_outer_udp(skb, &outer4);
+		break;
+	case IPPROTO_ICMP:
+		err = ipxlat_46_icmp(ipxlat, skb);
+		break;
+	default:
+		err = 0;
+		break;
+	}
+	if (unlikely(err))
+		return err;
+
+out:
+	/* normalize checksum/offload metadata for the translated frame */
+	return ipxlat_finalize_offload(skb, in_l4_proto, has_frag,
+				       SKB_GSO_TCPV4, SKB_GSO_TCPV6);
+}
diff --git a/drivers/net/ipxlat/translate_46.h b/drivers/net/ipxlat/translate_46.h
new file mode 100644
index 000000000000..75def10d0cad
--- /dev/null
+++ b/drivers/net/ipxlat/translate_46.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_TRANSLATE_46_H_
+#define _NET_IPXLAT_TRANSLATE_46_H_
+
+#include "ipxlpriv.h"
+
+struct iphdr;
+struct ipv6hdr;
+struct frag_hdr;
+struct sk_buff;
+
+/**
+ * ipxlat_46_map_proto_to_nexthdr - map IPv4 L4 protocol to IPv6 nexthdr
+ * @protocol: IPv4 L4 protocol
+ *
+ * Return: IPv6 next-header value corresponding to @protocol.
+ */
+u8 ipxlat_46_map_proto_to_nexthdr(u8 protocol);
+
+/**
+ * ipxlat_46_build_frag_hdr - build IPv6 Fragment Header from IPv4 fragment info
+ * @fh6: output IPv6 fragment header
+ * @hdr4: source IPv4 header
+ * @l4_proto: original IPv4 L4 protocol
+ */
+void ipxlat_46_build_frag_hdr(struct frag_hdr *fh6, const struct iphdr *hdr4,
+			      u8 l4_proto);
+
+/**
+ * ipxlat_46_build_l3 - build translated outer IPv6 header from IPv4 metadata
+ * @iph6: output IPv6 header
+ * @iph4: source IPv4 header
+ * @payload_len: IPv6 payload length
+ * @nexthdr: resulting IPv6 nexthdr
+ * @hop_limit: resulting IPv6 hop limit
+ */
+void ipxlat_46_build_l3(struct ipv6hdr *iph6, const struct iphdr *iph4,
+			unsigned int payload_len, u8 nexthdr, u8 hop_limit);
+
+/**
+ * ipxlat_46_lookup_pmtu6 - lookup post-translation IPv6 PMTU for a 4->6 packet
+ * @ipxlat: translator private context
+ * @skb: packet being translated
+ * @in4: source IPv4 header snapshot
+ *
+ * Return: effective PMTU clamped against translator device MTU.
+ */
+unsigned int ipxlat_46_lookup_pmtu6(struct ipxlat_priv *ipxlat,
+				    const struct sk_buff *skb,
+				    const struct iphdr *in4);
+
+/**
+ * ipxlat_46_translate - translate outer packet from IPv4 to IPv6 in place
+ * @ipxlat: translator private context
+ * @skb: packet to translate
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_46_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
+
+#endif /* _NET_IPXLAT_TRANSLATE_46_H_ */
diff --git a/drivers/net/ipxlat/translate_64.c b/drivers/net/ipxlat/translate_64.c
new file mode 100644
index 000000000000..50a95fb75f9d
--- /dev/null
+++ b/drivers/net/ipxlat/translate_64.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <linux/icmpv6.h>
+#include <net/ip.h>
+
+#include "translate_64.h"
+#include "address.h"
+#include "packet.h"
+#include "transport.h"
+
+u8 ipxlat_64_map_nexthdr_proto(u8 nexthdr)
+{
+	return (nexthdr == NEXTHDR_ICMP) ? IPPROTO_ICMP : nexthdr;
+}
+
+void ipxlat_64_build_l3(struct iphdr *iph4, const struct ipv6hdr *iph6,
+			unsigned int tot_len, __be16 frag_off, u8 protocol,
+			__be32 saddr, __be32 daddr, u8 ttl, __be16 id)
+{
+	iph4->version = 4;
+	iph4->ihl = 5;
+	iph4->tos = ipxlat_get_ipv6_tclass(iph6);
+	iph4->tot_len = cpu_to_be16(tot_len);
+	iph4->frag_off = frag_off;
+	iph4->ttl = ttl;
+	iph4->protocol = protocol;
+	iph4->saddr = saddr;
+	iph4->daddr = daddr;
+	iph4->id = id;
+	iph4->check = 0;
+	iph4->check = ip_fast_csum(iph4, iph4->ihl);
+}
+
+static __be16 ipxlat_64_build_frag_off(const struct sk_buff *skb,
+				       const struct frag_hdr *frag6,
+				       u8 l4_proto)
+{
+	bool df, mf, over_mtu;
+	u16 frag_offset;
+
+	/* preserve real IPv6 fragmentation state with a Fragment Header */
+	if (frag6) {
+		mf = !!(be16_to_cpu(frag6->frag_off) & IP6_MF);
+		frag_offset = ipxlat_get_frag6_offset(frag6);
+		return ipxlat_build_frag4_offset(false, mf, frag_offset);
+	}
+
+	/* frag_list implies segmented payload emitted as fragments */
+	if (skb_has_frag_list(skb))
+		return ipxlat_build_frag4_offset(false, false, 0);
+
+	if (skb_is_gso(skb)) {
+		/* GSO frames are one datagram here; set DF only for TCP
+		 * when later segmentation exceeds IPv6 minimum MTU
+		 */
+		df = (l4_proto == IPPROTO_TCP) &&
+		     (ipxlat_skb_cb(skb)->payload_off +
+			      skb_shinfo(skb)->gso_size >
+		      (IPV6_MIN_MTU - sizeof(struct iphdr)));
+		return ipxlat_build_frag4_offset(df, false, 0);
+	}
+
+	over_mtu = skb->len > (IPV6_MIN_MTU - sizeof(struct iphdr));
+	return ipxlat_build_frag4_offset(over_mtu, false, 0);
+}
+
+/**
+ * ipxlat_64_translate - translate one validated packet from IPv6 to IPv4
+ * @ipxlat: translator private context
+ * @skb: packet to translate
+ *
+ * Rewrites outer L3 in place, rebases cached offsets and translates L4 on
+ * first fragments only.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_64_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	unsigned int min_l4_len, old_l3_len, new_l3_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct ipv6hdr outer6 = *ipv6_hdr(skb);
+	bool is_icmp_err, has_frag, first_frag;
+	u8 in_l4_proto, out_l4_proto;
+	struct frag_hdr frag_copy;
+	struct frag_hdr *frag6;
+	__be32 saddr, daddr;
+	__be16 frag_off, id;
+	struct iphdr *iph4;
+	int l3_delta, err;
+
+	/* snapshot original outer IPv6 fields before L3 rewrite */
+	frag6 = cb->fragh_off ? (struct frag_hdr *)(skb->data + cb->fragh_off) :
+				NULL;
+	has_frag = !!frag6;
+	in_l4_proto = cb->l4_proto;
+	is_icmp_err = cb->is_icmp_err;
+	out_l4_proto = ipxlat_64_map_nexthdr_proto(in_l4_proto);
+
+	old_l3_len = cb->l3_hdr_len;
+	new_l3_len = sizeof(struct iphdr);
+	l3_delta = (int)new_l3_len - (int)old_l3_len;
+
+	if (unlikely(has_frag))
+		frag_copy = *frag6;
+	first_frag = ipxlat_is_first_frag6(has_frag ? &frag_copy : NULL);
+
+	if (unlikely(is_icmp_err)) {
+		if (unlikely(in_l4_proto != NEXTHDR_ICMP))
+			return -EINVAL;
+	}
+
+	/* derive translated IPv4 endpoints */
+	err = ipxlat_64_convert_addrs(&ipxlat->xlat_prefix6, &outer6,
+				      is_icmp_err, &saddr, &daddr);
+	if (unlikely(err))
+		return err;
+
+	/* replace outer IPv6 hdr with IPv4 hdr in-place */
+	skb_pull(skb, old_l3_len);
+	skb_push(skb, new_l3_len);
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, new_l3_len);
+	skb->protocol = htons(ETH_P_IP);
+
+	/* Rebase cached offsets after L3 size delta.
+	 * For outer 6->4 translation this should not underflow: cached offsets
+	 * were built from l3_off + ip6_len (+ ...), and
+	 * delta = sizeof(struct iphdr) - ip6_len, so ip6_len cancels out after
+	 * rebasing. A failure here means internal metadata inconsistency, not
+	 * a packet validation outcome.
+	 */
+	err = ipxlat_cb_rebase_offsets(cb, l3_delta);
+	if (unlikely(err)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return err;
+	}
+
+	cb->l3_hdr_len = sizeof(struct iphdr);
+	cb->fragh_off = 0;
+	cb->l4_proto = out_l4_proto;
+	DEBUG_NET_WARN_ON_ONCE(!ipxlat_cb_offsets_valid(cb));
+
+	/* build outer IPv4 base hdr from translated IPv6 fields */
+	iph4 = ip_hdr(skb);
+	frag_off = ipxlat_64_build_frag_off(skb, has_frag ? &frag_copy : NULL,
+					    out_l4_proto);
+	/* when source had Fragment Header we preserve its identification;
+	 * otherwise allocate a fresh IPv4 ID for the translated packet
+	 */
+	id = has_frag ? cpu_to_be16(be32_to_cpu(frag_copy.identification)) : 0;
+	ipxlat_64_build_l3(iph4, &outer6, skb->len, frag_off,
+			   out_l4_proto, saddr, daddr,
+			   outer6.hop_limit - 1, id);
+
+	if (likely(!has_frag)) {
+		iph4->id = 0;
+		__ip_select_ident(dev_net(ipxlat->dev), iph4, 1);
+		iph4->check = 0;
+		iph4->check = ip_fast_csum(iph4, iph4->ihl);
+	}
+
+	/* non-first fragments have no transport header to translate */
+	if (unlikely(!first_frag))
+		goto out;
+
+	/* ensure transport bytes are writable before L4 csum/proto rewrites */
+	min_l4_len = ipxlat_l4_min_len(out_l4_proto);
+	if (unlikely(skb_ensure_writable(skb, skb_transport_offset(skb) +
+						      min_l4_len)))
+		return -ENOMEM;
+
+	/* translate transport hdr and pseudohdr dependent checksums */
+	switch (out_l4_proto) {
+	case IPPROTO_TCP:
+		err = ipxlat_64_outer_tcp(skb, &outer6);
+		break;
+	case IPPROTO_UDP:
+		err = ipxlat_64_outer_udp(skb, &outer6);
+		break;
+	case IPPROTO_ICMP:
+		err = ipxlat_64_icmp(ipxlat, skb, &outer6);
+		break;
+	default:
+		err = 0;
+		break;
+	}
+	if (unlikely(err))
+		return err;
+
+out:
+	/* normalize checksum/offload metadata for the translated frame */
+	return ipxlat_finalize_offload(skb, out_l4_proto, ip_is_fragment(iph4),
+				       SKB_GSO_TCPV6, SKB_GSO_TCPV4);
+}
diff --git a/drivers/net/ipxlat/translate_64.h b/drivers/net/ipxlat/translate_64.h
new file mode 100644
index 000000000000..269d1955944f
--- /dev/null
+++ b/drivers/net/ipxlat/translate_64.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_TRANSLATE_64_H_
+#define _NET_IPXLAT_TRANSLATE_64_H_
+
+#include "ipxlpriv.h"
+
+struct sk_buff;
+struct iphdr;
+struct ipv6hdr;
+
+/**
+ * ipxlat_64_build_l3 - build translated outer IPv4 header from IPv6 metadata
+ * @iph4: output IPv4 header
+ * @iph6: source IPv6 header
+ * @tot_len: resulting IPv4 total length
+ * @frag_off: resulting IPv4 fragment offset/flags
+ * @protocol: resulting IPv4 L4 protocol
+ * @saddr: resulting IPv4 source address
+ * @daddr: resulting IPv4 destination address
+ * @ttl: resulting IPv4 TTL
+ * @id: resulting IPv4 identification field
+ */
+void ipxlat_64_build_l3(struct iphdr *iph4, const struct ipv6hdr *iph6,
+			unsigned int tot_len, __be16 frag_off, u8 protocol,
+			__be32 saddr, __be32 daddr, u8 ttl, __be16 id);
+
+/**
+ * ipxlat_64_translate - translate outer packet from IPv6 to IPv4 in place
+ * @ipxlat: translator private context
+ * @skb: packet to translate
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_64_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
+
+/**
+ * ipxlat_64_map_nexthdr_proto - map IPv6 nexthdr to IPv4 L4 protocol
+ * @nexthdr: IPv6 next-header value
+ *
+ * Return: IPv4 protocol value corresponding to @nexthdr.
+ */
+u8 ipxlat_64_map_nexthdr_proto(u8 nexthdr);
+
+#endif /* _NET_IPXLAT_TRANSLATE_64_H_ */
diff --git a/drivers/net/ipxlat/transport.c b/drivers/net/ipxlat/transport.c
index 3aa00c635916..78548d0b8c22 100644
--- a/drivers/net/ipxlat/transport.c
+++ b/drivers/net/ipxlat/transport.c
@@ -338,3 +338,14 @@ int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
 		udp_new->check = CSUM_MANGLED_0;
 	return 0;
 }
+
+int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	return -EPROTONOSUPPORT;
+}
+
+int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+		   const struct ipv6hdr *outer6)
+{
+	return -EPROTONOSUPPORT;
+}
diff --git a/drivers/net/ipxlat/transport.h b/drivers/net/ipxlat/transport.h
index 9b6fe422b01f..0e69b98eafd0 100644
--- a/drivers/net/ipxlat/transport.h
+++ b/drivers/net/ipxlat/transport.h
@@ -100,4 +100,9 @@ int ipxlat_64_inner_tcp(struct sk_buff *skb, const struct ipv6hdr *in6,
 int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
 			const struct iphdr *out4, struct udphdr *udp_new);
 
+/* temporary ICMP stubs until ICMP translation support is introduced */
+int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
+int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+		   const struct ipv6hdr *outer6);
+
 #endif /* _NET_IPXLAT_TRANSPORT_H_ */
-- 
2.53.0


