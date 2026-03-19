Return-Path: <netdev+bounces-269489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFn8OBkTvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:15:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463782CD89D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160B330AEA5A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194343D3481;
	Thu, 19 Mar 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="p/84I8wn"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103A2DBF78;
	Thu, 19 Mar 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933191; cv=none; b=qepQ1+D6xeY7euh89n1pX29RPLRff2VKVgWnjTvSuf8UV7m1VgmCiKm1vlnsZTXIRvyaNz2C+Cmz3hHUubPEeYziZBs9r7Xb4XKuALmQ7gNcHLkGgQsa48myTNvAb/iiv2yWVY6UGKDf7E8pHilHpeGz+egh9WlQ1NyIUzc2NZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933191; c=relaxed/simple;
	bh=2NYDwy/gV7dbV10YVs0Lb78B4af4Gw0dgptem2nEozY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I31K/OkKG4beUf0xzqHY7LHVxCU7Ri7jCTiKl79zTLBd7gXI2Br5e/RgpymwwuCZqYi5+l43qPoREPfUA5d7lOuP0hPY3sqsch1L0v5Zx4vxRqBDwl4k+/K34RFCwSiMIRqKrwIC/MDTvdiuNqRo8qEzhBKPu+c3fSaxSf8/4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=p/84I8wn; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4fc8Mg1NJmzDv9S;
	Thu, 19 Mar 2026 16:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SndRzQCr+0TV28vMI6neq7lH/2aOabTy4OqIGVFvHHA=;
	b=p/84I8wnabOFnqFtdXpkV2zqcfTMlzwFVjMKv8Nxy5UQEvdcoaNwSDOTNcCX9lfqKIVMoD
	WIjpckbaij8ZxffwcbSG/gL/fMQOMxIAtCfB8uy/ir0TP6jvJXSlVfC0RYW70Rwvhh8ded
	ecAMacrvoX3LXpd2bE91C8u7nVGdZmzt9G1H9UoHr6daPDrnOjXgqJiw6Vr/jsxiNYsrsJ
	XKw3a5fhHS0f/3ekIbVC4UjAQGS1GY3zlRLdpsC6GmODIMepbTFx4PmjeycKnbAtMRSnh+
	9evkI7lXYJmoxCqg3H7SOPGCP+g+9FeaqNivThMcyG6OT0LaGBAOygiVAKOlbw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
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
Subject: [RFC net-next 03/15] ipxlat: add packet metadata control block helpers
Date: Thu, 19 Mar 2026 16:12:12 +0100
Message-ID: <20260319151230.655687-4-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269489-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,darkboxed.org:email]
X-Rspamd-Queue-Id: 463782CD89D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the per-skb control-block layout and shared packet helper routines
used by translation stages introducing common metadata bookkeeping
(offset rebasing and invariant checks) plus protocol-fragment helper
utilities.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/Makefile |   1 +
 drivers/net/ipxlat/packet.c |  99 +++++++++++++++++++++
 drivers/net/ipxlat/packet.h | 166 ++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/net/ipxlat/packet.c
 create mode 100644 drivers/net/ipxlat/packet.h

diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
index b6367dedd78e..90dbc0489fa2 100644
--- a/drivers/net/ipxlat/Makefile
+++ b/drivers/net/ipxlat/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_IPXLAT) := ipxlat.o
 
 ipxlat-objs += main.o
 ipxlat-objs += address.o
+ipxlat-objs += packet.o
diff --git a/drivers/net/ipxlat/packet.c b/drivers/net/ipxlat/packet.c
new file mode 100644
index 000000000000..f82c375255f3
--- /dev/null
+++ b/drivers/net/ipxlat/packet.c
@@ -0,0 +1,99 @@
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
+#include "packet.h"
+
+/* Shift cached skb cb offsets by the L3 header delta after in-place rewrite.
+ *
+ * Translation may replace only the outer L3 header size (4->6 or 6->4), while
+ * cached offsets were computed before rewrite. Rebasing applies the same delta
+ * to all cached absolute offsets so they still point to the same logical
+ * fields in the modified skb.
+ *
+ * This helper only guards against underflow (< 0). Relative ordering checks
+ * are done by ipxlat_cb_offsets_valid.
+ */
+int ipxlat_cb_rebase_offsets(struct ipxlat_cb *cb, int delta)
+{
+	int off;
+
+	off = cb->l4_off + delta;
+	if (unlikely(off < 0))
+		return -EINVAL;
+	cb->l4_off = off;
+
+	off = cb->payload_off + delta;
+	if (unlikely(off < 0))
+		return -EINVAL;
+	cb->payload_off = off;
+
+	if (unlikely(cb->is_icmp_err)) {
+		off = cb->inner_l3_offset + delta;
+		if (unlikely(off < 0))
+			return -EINVAL;
+		cb->inner_l3_offset = off;
+
+		off = cb->inner_l4_offset + delta;
+		if (unlikely(off < 0))
+			return -EINVAL;
+		cb->inner_l4_offset = off;
+
+		if (cb->inner_fragh_off) {
+			off = cb->inner_fragh_off + delta;
+			if (unlikely(off < 0))
+				return -EINVAL;
+			cb->inner_fragh_off = off;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_NET
+/* Verify ordering/range relations between cached skb cb offsets.
+ *
+ * Unlike ipxlat_cb_rebase_offsets, this checks structural invariants:
+ * l4 <= payload, inner_l3 >= payload, inner_l3 <= inner_l4, and fragment
+ * header (when present) located inside inner L3 area before inner L4.
+ */
+bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb)
+{
+	if (unlikely(cb->payload_off < cb->l4_off))
+		return false;
+
+	if (unlikely(cb->is_icmp_err)) {
+		if (unlikely(cb->inner_l3_offset < cb->payload_off))
+			return false;
+		if (unlikely(cb->inner_l4_offset < cb->inner_l3_offset))
+			return false;
+		if (unlikely(cb->inner_fragh_off &&
+			     cb->inner_fragh_off < cb->inner_l3_offset))
+			return false;
+		if (unlikely(cb->inner_fragh_off &&
+			     cb->inner_fragh_off >= cb->inner_l4_offset))
+			return false;
+	}
+
+	return true;
+}
+#endif
+
+int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxl, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
+int ipxlat_v6_validate_skb(struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/net/ipxlat/packet.h b/drivers/net/ipxlat/packet.h
new file mode 100644
index 000000000000..f39c25987940
--- /dev/null
+++ b/drivers/net/ipxlat/packet.h
@@ -0,0 +1,166 @@
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
+#ifndef _NET_IPXLAT_PACKET_H_
+#define _NET_IPXLAT_PACKET_H_
+
+#include <net/ip.h>
+
+#include "ipxlpriv.h"
+
+/**
+ * struct ipxlat_cb - per-skb parser and control metadata stored in skb->cb
+ * @l4_off: outer L4 header offset
+ * @payload_off: outer payload offset
+ * @fragh_off: outer IPv6 Fragment Header offset, or 0 if absent
+ * @inner_l3_offset: quoted inner L3 offset for ICMP errors
+ * @inner_l4_offset: quoted inner L4 offset for ICMP errors
+ * @inner_fragh_off: quoted inner IPv6 Fragment Header offset, or 0
+ * @udp_zero_csum_len: outer UDP length used for 4->6 checksum synthesis
+ * @frag_max_size: pre-fragment payload cap for ip_do_fragment
+ * @l4_proto: outer L4 protocol (or nexthdr for IPv6)
+ * @inner_l4_proto: quoted inner L4 protocol
+ * @l3_hdr_len: outer L3 header length including extension headers
+ * @inner_l3_hdr_len: quoted inner L3 header length
+ * @is_icmp_err: packet is ICMP error and carries quoted inner packet
+ * @emit_icmp_err: datapath must emit translator-generated ICMP on drop
+ * @icmp_err: ICMP type/code/info cached for deferred emission
+ * @icmp_err.type: ICMP type to emit
+ * @icmp_err.code: ICMP code to emit
+ * @icmp_err.info: ICMP auxiliary info (e.g. pointer/MTU)
+ */
+struct ipxlat_cb {
+	u16 l4_off;
+	u16 payload_off;
+	u16 fragh_off;
+	u16 inner_l3_offset;
+	u16 inner_l4_offset;
+	u16 inner_fragh_off;
+	/* L4 span length (UDP header + payload) for outer IPv4 UDP packets
+	 * arriving with checksum 0.
+	 */
+	u16 udp_zero_csum_len;
+	u16 frag_max_size;
+	u8 l4_proto;
+	u8 inner_l4_proto;
+	u8 l3_hdr_len;
+	u8 inner_l3_hdr_len;
+	bool is_icmp_err;
+	bool emit_icmp_err;
+	struct {
+		u8 type;
+		u8 code;
+		u32 info;
+	} icmp_err;
+};
+
+/**
+ * ipxlat_skb_cb - return ipxlat private control block in skb->cb
+ * @skb: skb carrying ipxlat metadata
+ *
+ * Return: pointer to &struct ipxlat_cb stored in the control buffer of @skb.
+ */
+static inline struct ipxlat_cb *ipxlat_skb_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ipxlat_cb) > sizeof(skb->cb));
+	return (struct ipxlat_cb *)(skb->cb);
+}
+
+static inline unsigned int ipxlat_skb_datagram_len(const struct sk_buff *skb)
+{
+	return skb->len - skb_transport_offset(skb);
+}
+
+static inline u8 ipxlat_get_ipv6_tclass(const struct ipv6hdr *hdr)
+{
+	return (hdr->priority << 4) | (hdr->flow_lbl[0] >> 4);
+}
+
+static inline u16 ipxlat_get_frag6_offset(const struct frag_hdr *hdr)
+{
+	return be16_to_cpu(hdr->frag_off) & 0xFFF8U;
+}
+
+static inline u16 ipxlat_get_frag4_offset(const struct iphdr *hdr)
+{
+	return (be16_to_cpu(hdr->frag_off) & IP_OFFSET) << 3;
+}
+
+static inline bool ipxlat_is_first_frag6(const struct frag_hdr *hdr)
+{
+	return hdr ? (ipxlat_get_frag6_offset(hdr) == 0) : true;
+}
+
+static inline bool ipxlat_is_first_frag4(const struct iphdr *hdr)
+{
+	return !(hdr->frag_off & htons(IP_OFFSET));
+}
+
+static inline __be16 ipxlat_build_frag6_offset(u16 frag_offset, bool mf)
+{
+	return cpu_to_be16((frag_offset & 0xFFF8U) | mf);
+}
+
+static inline __be16
+ipxlat_build_frag4_offset(bool df, bool mf, u16 frag_offset)
+{
+	return cpu_to_be16((df ? (1U << 14) : 0) | (mf ? (1U << 13) : 0) |
+			   (frag_offset >> 3));
+}
+
+/**
+ * ipxlat_cb_rebase_offsets - shift cached cb offsets after skb relayout
+ * @cb: parsed packet metadata
+ * @delta: signed byte delta applied to cached offsets
+ *
+ * Return: 0 on success, negative errno if rebased offsets would underflow.
+ */
+int ipxlat_cb_rebase_offsets(struct ipxlat_cb *cb, int delta);
+#ifdef CONFIG_DEBUG_NET
+/**
+ * ipxlat_cb_offsets_valid - validate monotonicity and bounds of cb offsets
+ * @cb: parsed packet metadata
+ *
+ * Return: true if cached offsets are internally consistent.
+ */
+bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb);
+#else
+static inline bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb)
+{
+	return true;
+}
+#endif
+
+/**
+ * ipxlat_v4_validate_skb - validate and summarize IPv4 packet into skb->cb
+ * @ipxlat: translator private context
+ * @skb: packet to validate
+ *
+ * Populates &struct ipxlat_cb and may mark translator-generated ICMP action on
+ * failure paths.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
+int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
+
+/**
+ * ipxlat_v6_validate_skb - validate and summarize IPv6 packet into skb->cb
+ * @skb: packet to validate
+ *
+ * Populates &struct ipxlat_cb for subsequent 6->4 translation.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
+int ipxlat_v6_validate_skb(struct sk_buff *skb);
+
+#endif /* _NET_IPXLAT_PACKET_H_ */
-- 
2.53.0


