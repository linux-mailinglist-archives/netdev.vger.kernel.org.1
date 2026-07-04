Return-Path: <netdev+bounces-304723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kt4TAqthSWrd0wAAu9opvQ
	(envelope-from <netdev+bounces-304723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00844708469
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O+4TyFnz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304723-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304723-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E5953008448
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449F2F693B;
	Sat,  4 Jul 2026 19:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4312EB84E;
	Sat,  4 Jul 2026 19:39:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193996; cv=none; b=JHBVBGZ6RoG00EetyLTUdeZ9tbko3McJ9sxshIFcbsxClnfyyQ10+2yjTkDr7Hj4pOH/Oz1DPRYlrIa7XO977lf1W34aA/lX4DStkJlgeWZvDpSj1cpBTILhuY0n3IV2vTC03NHrR6NgbKHdnWS8MMFPl89SjNShDM/T/VGzkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193996; c=relaxed/simple;
	bh=NJhZXudFpfKWVsJsH4Ro78OnTKpSVOl2hXY2UyhrpzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmtTM78lbSuB93ZfqaYawEoJtsduGocAyc5jOVfXRynEWS5n0B3TEzoXY2ZQ9OOeELSwpQEvDsEGAPnT5Y75jMajk140/fLSpyNOE/lQYghvTUKr5a68weUYDt5uwUjaIO0fJYrh+Y4gss/lMGqWslrtVKaUS14pDtXoIXta+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+4TyFnz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FCC1F000E9;
	Sat,  4 Jul 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193995;
	bh=U4g7Ty6YnkXn6nXVJPUej+hex/GiQcqLZGsmKf+Llls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O+4TyFnzga59+yZco9Y6+LmJFdJFu8Rwk4H56k7TKEDt5vAmsU5LYFgXP+G39Sy+N
	 p8S/RhA5VsoXK/8YISD5EByCz9OsxIQrdDd6+lBl7Df8VOBPGSxla+F8wHePTJeJ7K
	 KMzht+OiSkt9KDSnUcrW3lA/ZPT3eW5xSXEPw3aaiYr9JQIp6PdDmbrKGynUxkq+Ty
	 z2NYOA2V6EpMflUya0Lh0DV9fVHJM1QwfhBAUlc3nybss/KCenplxk3ayjwcnQZ7/8
	 JDTGB5j61wiwzVVUv1WzTemE7ExboRk264EvaalqsjxQ2Ktvr50byYb5THH8u7G7PY
	 gHE+2B6+K/KfQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 04 Jul 2026 21:39:35 +0200
Subject: [PATCH net-next v7 3/5] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-ks8995-to-ksz8-v7-3-2af0eaa545a8@kernel.org>
References: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
In-Reply-To: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:linusw@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304723-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00844708469

The KS8995 100Mbit switch can do proper DSA per-port tagging
with the proper set-up. This adds the code to handle ingress
and egress KS8995 tags.

The tag is a modified 0x8100 ethertype tag where a bit in the
last nybble is set for each target port.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS          |   1 +
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f1a55eca99..6bd1baec7b44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17598,6 +17598,7 @@ F:	Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
 F:	drivers/net/dsa/microchip/*
 F:	include/linux/dsa/ksz_common.h
 F:	include/linux/platform_data/microchip-ksz.h
+F:	net/dsa/tag_ks8995.c
 F:	net/dsa/tag_ksz.c
 
 MICROCHIP LAN743X ETHERNET DRIVER
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc10..abd159527782 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
+#define DSA_TAG_PROTO_KS8995_VALUE		34
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -95,6 +96,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
+	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..bbdf324addac 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -119,6 +119,12 @@ config NET_DSA_TAG_MXL_GSW1XX
 	  Say Y or M if you want to enable support for tagging frames for
 	  MaxLinear GSW1xx switches.
 
+config NET_DSA_TAG_KS8995
+	tristate "Tag driver for Micrel KS8995 switch"
+	help
+	  Say Y if you want to enable support for tagging frames for the
+	  Micrel KS8995 switch.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index b8c2667cd14a..a9c2a0569e9e 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
 obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
 obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
+obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
new file mode 100644
index 000000000000..5e81ce1ea91a
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Linus Walleij <linusw@kernel.org>
+ */
+#include <linux/etherdevice.h>
+#include <linux/log2.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "tag.h"
+
+/* The Micrel KS8995XA / Microchip KSZ8995XA Special Tag Packet ID (STPID)
+ * pushes its tag in a modified VLAN (802.1Q) tag.
+ * -----------------------------------------------------------
+ * | MAC DA | MAC SA | 2 bytes tag | 2 bytes TCI | EtherType |
+ * -----------------------------------------------------------
+ * The tag is: 0x8100 |= BIT(port), ports 0,1,2,3
+ */
+
+#define KS8995_NAME "ks8995"
+
+#define KS8995M_STPID_STD	GENMASK(15, 4)
+#define KS8995M_STPID_PORTMASK	GENMASK(3, 0)
+#define KS8995M_STPID(portmask)	htons(ETH_P_8021Q | FIELD_PREP(KS8995M_STPID_PORTMASK, portmask))
+
+static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
+	bool have_hwaccel_tag = false;
+	u16 tci = 0, portmask;
+
+	/* Prepare the special KS8995 tags */
+	portmask = dsa_xmit_port_mask(skb, dev);
+
+	if (skb_vlan_tag_present(skb) && skb->vlan_proto == htons(ETH_P_8021Q)) {
+		tci = skb_vlan_tag_get(skb);
+		__vlan_hwaccel_clear_tag(skb);
+		have_hwaccel_tag = true;
+	}
+
+	if (have_hwaccel_tag || hdr->h_vlan_proto != htons(ETH_P_8021Q)) {
+		skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), tci);
+		/* vlan_insert_tag() drops the skb on failure */
+		if (!skb)
+			return NULL;
+		hdr = vlan_eth_hdr(skb);
+		netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
+			   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);
+	} else {
+		/* VLAN tag already exists in skb head, modify it in place */
+		hdr = vlan_eth_hdr(skb);
+		hdr->h_vlan_proto = KS8995M_STPID(portmask);
+		netdev_dbg(dev, "%s: modified VLAN TAG %04x\n",
+			   __func__, hdr->h_vlan_proto);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	int portmask;
+	u16 etype;
+
+	/* We are expecting all received packets to have a mangled VLAN
+	 * TPID, so drop anything else. Because of the non-standard TPID,
+	 * don't even bother looking for a tag in the hwaccel area.
+	 *
+	 * We have to inspect the ethertype directly because skb->protocol
+	 * will contain garbage.
+	 */
+	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
+	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
+		netdev_dbg(dev, "%s: dropped ethertype 0x%04x\n",
+			   __func__, etype);
+		kfree_skb(skb);
+		return NULL;
+	}
+	netdev_dbg(dev, "%s: received ethertype %04x\n",
+		   __func__, etype);
+
+	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
+	 * it from the skb head
+	 */
+	skb = skb_vlan_untag(skb);
+	if (!skb) {
+		/* skb_vlan_untag drops the skb on failure */
+		netdev_err(dev, "%s: unable to untag skb\n", __func__);
+		return NULL;
+	}
+
+	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
+	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
+		   __func__, etype, portmask, ilog2(portmask));
+	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
+	if (!skb->dev) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Preserve the VLAN tag if it contains a non-zero VID which is not
+	 * identical to 0x001, or PCP, and restore its TPID to the standard
+	 * value.
+	 *
+	 * If this is just an ordinary inbound package the datasheet claims
+	 * it will "replace null VID with ingress port VID", which means
+	 * VID set to 1: 0x8101 0001 for port 0 or 0x8102 0001 for port 1.
+	 * So in the DSA driver we will set the default port VID to 0 so
+	 * we can properly detect non-VLAN frames.
+	 */
+	if (!skb->vlan_tci) {
+		netdev_dbg(dev, "%s: clear VLAN tag from frame\n", __func__);
+		__vlan_hwaccel_clear_tag(skb);
+	} else {
+		skb->vlan_proto = htons(ETH_P_8021Q);
+		netdev_dbg(dev, "%s: vlan_tci = 0x%04x VLAN frame\n",
+			   __func__, skb->vlan_tci);
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops ks8995_netdev_ops = {
+	.name = KS8995_NAME,
+	.proto	= DSA_TAG_PROTO_KS8995,
+	.xmit = ks8995_xmit,
+	.rcv = ks8995_rcv,
+	.needed_headroom = VLAN_HLEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Micrel KS8995 family of switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KS8995, KS8995_NAME);
+
+module_dsa_tag_driver(ks8995_netdev_ops);

-- 
2.54.0


