Return-Path: <netdev+bounces-269493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCh1EucTvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:19:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C362CD918
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D908D3063B59
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8697E3CF026;
	Thu, 19 Mar 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="CcIZynlt"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B272622;
	Thu, 19 Mar 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933231; cv=none; b=P2jZOjVYw3uS8JpwMVsn0Hk7caLGb3p0nMRAqBacojDQYSyVkpQPGcx83yTQFvm2oU900I0zshhCnPTLmXNYnoqiOt8hJuFz5f8L+//tOzPWICPRaAoibvdVl9ryuHSWXqiN9WTnBTvbgLjAlRBA7qHB6blP3y7yYWlVJZYIvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933231; c=relaxed/simple;
	bh=YdGU6iQSB6J1VJnMwbYn+xQQAwK+qB4z+3mEGB8ehFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWRiuTgk7OFT5iA6dxlPa9q4VOqt7QBVlYbLlsuvFMWJ/d1gM3Gw7EjAKujJgRoRIi17AEPwOlgXCHBQ9zNtqtBEuBbsTPorMQGxH5xXXAFzocqZV0f0LbvqRW0kr+SIDUKKzt/V6+2zHkCAV0Qv+uHldk1+kliOdY53ACZKot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=CcIZynlt; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4fc8NT3JspzDvP8;
	Thu, 19 Mar 2026 16:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3X36v8Qu47aU8G+k1e+nD4qx4C1jckCtR5SYpVmAAM=;
	b=CcIZynlt99MXoP0o+PubWaZlzVOHM49Z4XxdmiYG/BI1AbRk28ZGfNZU+l0itBkqEJFGHN
	6Qld/EIR3gIlXe56Ad7BU7RrQxEyh93Yur1wtvFEhzaXKb5R9m3V9Y02Yk120ft2AAsgd9
	4CpYpoasUO9T2VUMLwFL1CfrUT3pwBGn/kHckAzvUXQ664Wf6z8mXDZECJzv7Vvhqd1Dxb
	/c8SUO98THmUzvLoZfUAIEasFswv0L1jC3OQKJzIIGYxvPzaWljCxJuAb5/cnBTeuJPNSc
	D8tcUjjxON5/TpFFut/v98UVcEuzdF+i0Kg3qA7yzx1wbDnPpKxUCdE2ygIovQ==
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
Subject: [RFC net-next 11/15] ipxlat: add ICMP informational translation paths
Date: Thu, 19 Mar 2026 16:12:20 +0100
Message-ID: <20260319151230.655687-12-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269493-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,darkboxed.org:email]
X-Rspamd-Queue-Id: E2C362CD918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ICMP informational message translation for both 4->6 and 6->4 paths
and wire the new ICMP translation units into the engine.

This introduces the protocol mapping and checksum update logic for echo
request/reply traffic, while ICMP error quoted-inner translation is
added in a follow-up commit.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/Makefile       |  2 +
 drivers/net/ipxlat/icmp.h         | 43 ++++++++++++++
 drivers/net/ipxlat/icmp_46.c      | 95 +++++++++++++++++++++++++++++++
 drivers/net/ipxlat/icmp_64.c      | 92 ++++++++++++++++++++++++++++++
 drivers/net/ipxlat/translate_64.c |  1 +
 drivers/net/ipxlat/transport.c    | 11 ----
 drivers/net/ipxlat/transport.h    |  5 --
 7 files changed, 233 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/ipxlat/icmp.h
 create mode 100644 drivers/net/ipxlat/icmp_46.c
 create mode 100644 drivers/net/ipxlat/icmp_64.c

diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
index d7b7097aee5f..2ded504902e3 100644
--- a/drivers/net/ipxlat/Makefile
+++ b/drivers/net/ipxlat/Makefile
@@ -11,3 +11,5 @@ ipxlat-objs += transport.o
 ipxlat-objs += dispatch.o
 ipxlat-objs += translate_46.o
 ipxlat-objs += translate_64.o
+ipxlat-objs += icmp_46.o
+ipxlat-objs += icmp_64.o
diff --git a/drivers/net/ipxlat/icmp.h b/drivers/net/ipxlat/icmp.h
new file mode 100644
index 000000000000..52d681787d6a
--- /dev/null
+++ b/drivers/net/ipxlat/icmp.h
@@ -0,0 +1,43 @@
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
+#ifndef _NET_IPXLAT_ICMP_H_
+#define _NET_IPXLAT_ICMP_H_
+
+#include <linux/ipv6.h>
+
+#include "ipxlpriv.h"
+
+/**
+ * ipxlat_46_icmp - translate ICMP informational payload
+ *		    after outer 4->6 rewrite
+ * @ipxl: translator private context
+ * @skb: packet carrying ICMPv4 transport payload
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_46_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb);
+
+/**
+ * ipxlat_64_icmp - translate ICMP informational payload
+ *		    after outer 6->4 rewrite
+ * @ipxlat: translator private context
+ * @skb: packet carrying ICMPv6 transport payload
+ * @in6: snapshot of original outer IPv6 header
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+		   const struct ipv6hdr *in6);
+
+#endif /* _NET_IPXLAT_ICMP_H_ */
diff --git a/drivers/net/ipxlat/icmp_46.c b/drivers/net/ipxlat/icmp_46.c
new file mode 100644
index 000000000000..ad907f60416c
--- /dev/null
+++ b/drivers/net/ipxlat/icmp_46.c
@@ -0,0 +1,95 @@
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
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+
+#include "icmp.h"
+#include "packet.h"
+#include "transport.h"
+
+static int ipxlat_46_map_icmp_info_type_code(const struct icmphdr *in,
+					     struct icmp6hdr *out)
+{
+	switch (in->type) {
+	case ICMP_ECHO:
+		out->icmp6_type = ICMPV6_ECHO_REQUEST;
+		out->icmp6_code = 0;
+		out->icmp6_identifier = in->un.echo.id;
+		out->icmp6_sequence = in->un.echo.sequence;
+		return 0;
+	case ICMP_ECHOREPLY:
+		out->icmp6_type = ICMPV6_ECHO_REPLY;
+		out->icmp6_code = 0;
+		out->icmp6_identifier = in->un.echo.id;
+		out->icmp6_sequence = in->un.echo.sequence;
+		return 0;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
+static void ipxlat_46_icmp_info_update_csum(const struct icmphdr *icmp4,
+					    struct icmp6hdr *icmp6,
+					    const struct ipv6hdr *ip6,
+					    const struct sk_buff *skb,
+					    unsigned int l4_off)
+{
+	struct icmp6hdr icmp6_zero;
+	struct icmphdr icmp4_zero;
+	__wsum csum;
+
+	icmp4_zero = *icmp4;
+	icmp4_zero.checksum = 0;
+	icmp6_zero = *icmp6;
+	icmp6_zero.icmp6_cksum = 0;
+	csum = ~csum_unfold(icmp4->checksum);
+	csum = csum_sub(csum, csum_partial(&icmp4_zero, sizeof(icmp4_zero), 0));
+	csum = csum_add(csum, csum_partial(&icmp6_zero, sizeof(icmp6_zero), 0));
+	icmp6->icmp6_cksum = csum_ipv6_magic(&ip6->saddr, &ip6->daddr,
+					     skb->len - l4_off,
+					     IPPROTO_ICMPV6, csum);
+}
+
+static int ipxlat_46_icmp_info_outer(struct sk_buff *skb)
+{
+	const unsigned int l4_off = skb_transport_offset(skb);
+	const struct icmphdr icmp4 = *icmp_hdr(skb);
+	const struct ipv6hdr *ip6 = ipv6_hdr(skb);
+	struct icmp6hdr *icmp6 = icmp6_hdr(skb);
+	int err;
+
+	err = ipxlat_46_map_icmp_info_type_code(&icmp4, icmp6);
+	if (unlikely(err))
+		return -EINVAL;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		icmp6->icmp6_cksum = ~csum_ipv6_magic(&ip6->saddr, &ip6->daddr,
+						      skb->len - l4_off,
+						      IPPROTO_ICMPV6, 0);
+		return ipxlat_set_partial_csum(skb, offsetof(struct icmp6hdr,
+							   icmp6_cksum));
+	}
+
+	ipxlat_46_icmp_info_update_csum(&icmp4, icmp6, ip6, skb, l4_off);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb)
+{
+	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
+		return -EPROTONOSUPPORT;
+
+	return ipxlat_46_icmp_info_outer(skb);
+}
diff --git a/drivers/net/ipxlat/icmp_64.c b/drivers/net/ipxlat/icmp_64.c
new file mode 100644
index 000000000000..6b11aa638068
--- /dev/null
+++ b/drivers/net/ipxlat/icmp_64.c
@@ -0,0 +1,92 @@
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
+
+#include "icmp.h"
+#include "packet.h"
+#include "transport.h"
+
+static int ipxlat_64_map_icmp_info_type_code(const struct icmp6hdr *in,
+					     struct icmphdr *out)
+{
+	switch (in->icmp6_type) {
+	case ICMPV6_ECHO_REQUEST:
+		out->type = ICMP_ECHO;
+		out->code = 0;
+		out->un.echo.id = in->icmp6_identifier;
+		out->un.echo.sequence = in->icmp6_sequence;
+		return 0;
+	case ICMPV6_ECHO_REPLY:
+		out->type = ICMP_ECHOREPLY;
+		out->code = 0;
+		out->un.echo.id = in->icmp6_identifier;
+		out->un.echo.sequence = in->icmp6_sequence;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static __sum16 ipxlat_64_compute_icmp_info_csum(const struct ipv6hdr *in6,
+						const struct icmp6hdr *in_icmp6,
+						const struct icmphdr *out_icmp4,
+						unsigned int l4_len)
+{
+	struct icmp6hdr icmp6_zero;
+	struct icmphdr icmp4_zero;
+	__wsum csum, tmp;
+
+	icmp6_zero = *in_icmp6;
+	icmp6_zero.icmp6_cksum = 0;
+	icmp4_zero = *out_icmp4;
+	icmp4_zero.checksum = 0;
+
+	csum = ~csum_unfold(in_icmp6->icmp6_cksum);
+	tmp = ~csum_unfold(csum_ipv6_magic(&in6->saddr, &in6->daddr, l4_len,
+					   NEXTHDR_ICMP, 0));
+	csum = csum_sub(csum, tmp);
+	csum = csum_sub(csum, csum_partial(&icmp6_zero, sizeof(icmp6_zero), 0));
+	csum = csum_add(csum, csum_partial(&icmp4_zero, sizeof(icmp4_zero), 0));
+	return csum_fold(csum);
+}
+
+static int ipxlat_64_icmp_info(struct sk_buff *skb, const struct ipv6hdr *in6)
+{
+	struct icmp6hdr ic6_copy, *ic6;
+	struct icmphdr *ic4;
+	int err;
+
+	ic6 = icmp6_hdr(skb);
+	ic6_copy = *ic6;
+
+	ic4 = (struct icmphdr *)(skb->data + skb_transport_offset(skb));
+	err = ipxlat_64_map_icmp_info_type_code(&ic6_copy, ic4);
+	if (unlikely(err))
+		return err;
+
+	ic4->checksum =
+		ipxlat_64_compute_icmp_info_csum(in6, &ic6_copy, ic4,
+						 ipxlat_skb_datagram_len(skb));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_64_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb,
+		   const struct ipv6hdr *in6)
+{
+	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
+		return -EPROTONOSUPPORT;
+
+	return ipxlat_64_icmp_info(skb, in6);
+}
diff --git a/drivers/net/ipxlat/translate_64.c b/drivers/net/ipxlat/translate_64.c
index 50a95fb75f9d..412d29214a43 100644
--- a/drivers/net/ipxlat/translate_64.c
+++ b/drivers/net/ipxlat/translate_64.c
@@ -16,6 +16,7 @@
 
 #include "translate_64.h"
 #include "address.h"
+#include "icmp.h"
 #include "packet.h"
 #include "transport.h"
 
diff --git a/drivers/net/ipxlat/transport.c b/drivers/net/ipxlat/transport.c
index 78548d0b8c22..3aa00c635916 100644
--- a/drivers/net/ipxlat/transport.c
+++ b/drivers/net/ipxlat/transport.c
@@ -338,14 +338,3 @@ int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
 		udp_new->check = CSUM_MANGLED_0;
 	return 0;
 }
-
-int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
-{
-	return -EPROTONOSUPPORT;
-}
-
-int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
-		   const struct ipv6hdr *outer6)
-{
-	return -EPROTONOSUPPORT;
-}
diff --git a/drivers/net/ipxlat/transport.h b/drivers/net/ipxlat/transport.h
index 0e69b98eafd0..9b6fe422b01f 100644
--- a/drivers/net/ipxlat/transport.h
+++ b/drivers/net/ipxlat/transport.h
@@ -100,9 +100,4 @@ int ipxlat_64_inner_tcp(struct sk_buff *skb, const struct ipv6hdr *in6,
 int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
 			const struct iphdr *out4, struct udphdr *udp_new);
 
-/* temporary ICMP stubs until ICMP translation support is introduced */
-int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
-int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
-		   const struct ipv6hdr *outer6);
-
 #endif /* _NET_IPXLAT_TRANSPORT_H_ */
-- 
2.53.0


