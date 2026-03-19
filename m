Return-Path: <netdev+bounces-269503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKH1HXEWvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:29:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56E2CDBD8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149A131CE268
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57E3D7D63;
	Thu, 19 Mar 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Afz5ifqR"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F413D3481;
	Thu, 19 Mar 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933750; cv=none; b=BXLSkawsdvPHXOQrzo5qe+FzwNLi/7081ptoWxe4+k5JerefiURxa5xIy8w1hUuiNhAIrAD0OCrIEFDw//eZLZ90rgkBRmZutcNeOniTgbLYh33gxO9xpJJdE9w+/xjGZrNgB7c2RplBOiHwQVoJ5FkExuKV7viUL+IakV2Ujcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933750; c=relaxed/simple;
	bh=iTO4e6EY6LzuRBmdnlWNtywEwzjsLcLwOY1vsh6w6X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndRFJARN/7DgjyNpCFvW5ou4Pcy1vcpYxBmX/5BH04qtgTx3KUrkh+vLUXjJwfAgLZds7dtoo6RB6CS7Y8h+SnRVsOgFGMK80rkUnpDeMYDH3I08IIJE++wiH6kE2jp6/LIe5KAyVWbv/tdeANQditzuUUonfnEt+iDeNrsa5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Afz5ifqR; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4fc8MY5hxkzDqrQ;
	Thu, 19 Mar 2026 16:12:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0icos2ZBtUrsLwF58QCrTkTKUVqnIISU3RcxMFUjpAk=;
	b=Afz5ifqR/m3cvYhcAV+HV4VQFRBdnEgoxSlYhlEr/XS8DszzK3uqn6OeG3FT1rsJgWFDvJ
	PvlHyxjyrZmf5kate0iMR0mTVI8cZOZSFjY1K3+y7pOWW+bOEBSlJ/SeJfV2f/RNNvlpGj
	fHelUymu7cCSQ41qd2KR37p8hKj5BwTGkDRzLllSXuSTjaOcYVYPl+sQohM2dQWuROrK0f
	HpIUAAJ+MiXtii4JI9rH08xHqbKHgDwjLeP74tnP5COxxZj8gpMMG6fP1OpmQGuIwCXZ6M
	hh5uTD85JKWDOKOpZhgcDNA4niIreOLkdfnhH9U7YPD3i9fzTk3K978ucpxCrQ==
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
Subject: [RFC net-next 02/15] ipxlat: add RFC 6052 address conversion helpers
Date: Thu, 19 Mar 2026 16:12:11 +0100
Message-ID: <20260319151230.655687-3-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269503-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[darkboxed.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid]
X-Rspamd-Queue-Id: CF56E2CDBD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce IPv4/IPv6 stateless address mapping helpers used by the
translation pipeline. Add the core 4<->6 conversion routines, including
RFC 6052 prefix embedding/extraction and the RFC 6791 fallback source
selection logic used by ICMP translation paths.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/Makefile  |   1 +
 drivers/net/ipxlat/address.c | 132 +++++++++++++++++++++++++++++++++++
 drivers/net/ipxlat/address.h |  59 ++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/net/ipxlat/address.c
 create mode 100644 drivers/net/ipxlat/address.h

diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
index bd48c2700bf5..b6367dedd78e 100644
--- a/drivers/net/ipxlat/Makefile
+++ b/drivers/net/ipxlat/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_IPXLAT) := ipxlat.o
 
 ipxlat-objs += main.o
+ipxlat-objs += address.o
diff --git a/drivers/net/ipxlat/address.c b/drivers/net/ipxlat/address.c
new file mode 100644
index 000000000000..d1a2b7d1768f
--- /dev/null
+++ b/drivers/net/ipxlat/address.c
@@ -0,0 +1,132 @@
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
+#include "address.h"
+
+static bool ipxlat_prefix6_contains(const struct ipv6_prefix *prefix,
+				    const struct in6_addr *addr)
+{
+	return ipv6_prefix_equal(&prefix->addr, addr, prefix->len);
+}
+
+static __be32 ipxlat_64_extract_addr(const struct in6_addr *src,
+				     unsigned int q1, unsigned int q2,
+				     unsigned int q3, unsigned int q4)
+{
+	q1 = src->s6_addr[q1];
+	q2 = src->s6_addr[q2];
+	q3 = src->s6_addr[q3];
+	q4 = src->s6_addr[q4];
+	return htonl((q1 << 24) | (q2 << 16) | (q3 << 8) | q4);
+}
+
+static void ipxlat_46_embed_addr(__be32 __src, struct in6_addr *dst,
+				 unsigned int q1, unsigned int q2,
+				 unsigned int q3, unsigned int q4)
+{
+	u32 src = ntohl(__src);
+
+	dst->s6_addr[q1] = ((src >> 24) & 0xFF);
+	dst->s6_addr[q2] = ((src >> 16) & 0xFF);
+	dst->s6_addr[q3] = ((src >> 8) & 0xFF);
+	dst->s6_addr[q4] = ((src) & 0xFF);
+}
+
+void ipxlat_46_convert_addr(const struct ipv6_prefix *xlat_prefix6,
+			    __be32 addr4, struct in6_addr *addr6)
+{
+	*addr6 = xlat_prefix6->addr;
+
+	switch (xlat_prefix6->len) {
+	case 96:
+		addr6->s6_addr32[3] = addr4;
+		return;
+	case 64:
+		ipxlat_46_embed_addr(addr4, addr6, 9, 10, 11, 12);
+		return;
+	case 56:
+		ipxlat_46_embed_addr(addr4, addr6, 7, 9, 10, 11);
+		return;
+	case 48:
+		ipxlat_46_embed_addr(addr4, addr6, 6, 7, 9, 10);
+		return;
+	case 40:
+		ipxlat_46_embed_addr(addr4, addr6, 5, 6, 7, 9);
+		return;
+	case 32:
+		addr6->s6_addr32[1] = addr4;
+		return;
+	}
+
+	DEBUG_NET_WARN_ON_ONCE(1);
+}
+
+int ipxlat_64_convert_addrs(const struct ipv6_prefix *xlat_prefix6,
+			    const struct ipv6hdr *hdr6, bool icmp_err,
+			    __be32 *src, __be32 *dst)
+{
+	bool src_ok;
+
+	src_ok = ipxlat_prefix6_contains(xlat_prefix6, &hdr6->saddr);
+	if (unlikely(!src_ok && !icmp_err))
+		return -EINVAL;
+	if (unlikely(!ipxlat_prefix6_contains(xlat_prefix6, &hdr6->daddr)))
+		return -EINVAL;
+
+	switch (xlat_prefix6->len) {
+	case 96:
+		if (likely(src_ok))
+			*src = hdr6->saddr.s6_addr32[3];
+		*dst = hdr6->daddr.s6_addr32[3];
+		break;
+	case 64:
+		if (likely(src_ok))
+			*src = ipxlat_64_extract_addr(&hdr6->saddr, 9, 10, 11,
+						      12);
+		*dst = ipxlat_64_extract_addr(&hdr6->daddr, 9, 10, 11, 12);
+		break;
+	case 56:
+		if (likely(src_ok))
+			*src = ipxlat_64_extract_addr(&hdr6->saddr, 7,
+						      9, 10, 11);
+		*dst = ipxlat_64_extract_addr(&hdr6->daddr, 7, 9, 10, 11);
+		break;
+	case 48:
+		if (likely(src_ok))
+			*src = ipxlat_64_extract_addr(&hdr6->saddr, 6,
+						      7, 9, 10);
+		*dst = ipxlat_64_extract_addr(&hdr6->daddr, 6, 7, 9, 10);
+		break;
+	case 40:
+		if (likely(src_ok))
+			*src = ipxlat_64_extract_addr(&hdr6->saddr, 5, 6, 7, 9);
+		*dst = ipxlat_64_extract_addr(&hdr6->daddr, 5, 6, 7, 9);
+		break;
+	case 32:
+		if (likely(src_ok))
+			*src = hdr6->saddr.s6_addr32[1];
+		*dst = hdr6->daddr.s6_addr32[1];
+		break;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* keep 6->4 ICMP error translation functional even when the ICMPv6
+	 * source is not xlat_prefix6-mapped (for example, stack-generated PTB)
+	 */
+	if (unlikely(!src_ok))
+		*src = htonl(INADDR_DUMMY);
+
+	return 0;
+}
diff --git a/drivers/net/ipxlat/address.h b/drivers/net/ipxlat/address.h
new file mode 100644
index 000000000000..4283fdddac56
--- /dev/null
+++ b/drivers/net/ipxlat/address.h
@@ -0,0 +1,59 @@
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
+#ifndef _NET_IPXLAT_ADDRESS_H_
+#define _NET_IPXLAT_ADDRESS_H_
+
+#include <linux/ip.h>
+#include <net/ipv6.h>
+
+#include "ipxlpriv.h"
+
+/**
+ * ipxlat_46_convert_addr - translate one IPv4 address into RFC 6052 IPv6 form
+ * @xlat_prefix6: configured RFC 6052 prefix
+ * @addr4: IPv4 address to convert
+ * @addr6: output IPv6 address
+ */
+void ipxlat_46_convert_addr(const struct ipv6_prefix *xlat_prefix6,
+			    __be32 addr4, struct in6_addr *addr6);
+
+/**
+ * ipxlat_64_convert_addrs - translate outer IPv6 endpoints into IPv4 pair
+ * @xlat_prefix6: configured RFC 6052 prefix
+ * @hdr6: source IPv6 header
+ * @icmp_err: source packet is ICMPv6 error
+ * @src: output IPv4 source address
+ * @dst: output IPv4 destination address
+ *
+ * Return: 0 on success, negative errno on non-translatable addresses.
+ */
+int ipxlat_64_convert_addrs(const struct ipv6_prefix *xlat_prefix6,
+			    const struct ipv6hdr *hdr6, bool icmp_err,
+			    __be32 *src, __be32 *dst);
+
+/**
+ * ipxlat_46_convert_addrs - translate outer IPv4 endpoints into IPv6 pair
+ * @xlat_prefix6: configured RFC 6052 prefix
+ * @iph4: source IPv4 header
+ * @iph6: output IPv6 header (only saddr/daddr are updated)
+ */
+static inline void
+ipxlat_46_convert_addrs(const struct ipv6_prefix *xlat_prefix6,
+			const struct iphdr *iph4, struct ipv6hdr *iph6)
+{
+	ipxlat_46_convert_addr(xlat_prefix6, iph4->saddr, &iph6->saddr);
+	ipxlat_46_convert_addr(xlat_prefix6, iph4->daddr, &iph6->daddr);
+}
+
+#endif /* _NET_IPXLAT_ADDRESS_H_ */
-- 
2.53.0


