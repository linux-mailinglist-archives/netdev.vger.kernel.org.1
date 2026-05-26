Return-Path: <netdev+bounces-291784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBiYNBjFFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:06:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367F5D94E7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 236763058880
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E23A1686;
	Tue, 26 May 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmAr6hKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D839AD32;
	Tue, 26 May 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811199; cv=none; b=VouNm3dsK75Zb68YC4xHuenpFabE13uDFitHvDp0/U7uFCO8Lm0W6oU9LuebZhPqr4Dl2i+V4sZFrY7RkW9K911uVxbcC6ng+V2S654GfvjaqfwO2/aQhdI+LRXpKToyac63kuOfzXQDutGYZ/RNG30ZUsrb1TImBlEbFhDdvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811199; c=relaxed/simple;
	bh=fLsapKOT3aTUXNDco8WB/enxQ8OcbZpAv/0LF/rHZyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQR1Ml4bXZxjl8eMxtIIxoyPJJxBhNPyAnnBEscPP3n0SOPNKCgv7qRqSAdPhMF6TEOz+ETIPkWF7q3jwThEOQxLUIuoEkofVbD5tivb3sRlQt/dWbxHrXo//k+xV5ycFh9nTTO/fQ0sJMkGS6yFxa0XJneULZmdm4t3HUxkaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmAr6hKh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5461F00A3A;
	Tue, 26 May 2026 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811197;
	bh=+J/ldw/+ZWEAmB4OZdSFPZfdWklUzPNnd0GlsTjafnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MmAr6hKhdm/7NaxOC+WEMbRRzvD3JwkYh70f4sdkkl+qZEUyBcaUaN9IdMyv7qPwb
	 cZw1EOFw0Rq7qehg3ohic9Q6OIC4el+8hN2xx9Yk4CEDN5tbdyeOOz2jDNSNXh7Qkr
	 ZetoOjkKzEffzekC502NEyrvrsqUYgAXCZQ9Wsvo3pxtnGXmoQO++lYwccZBP+mKhR
	 Apjo/fDMkHRmQT2b8ybsztmBAqul1FmnaHcCw1N+OwTaRXaL5q8lXhM636I0hMtcHv
	 k1y22aqI5Q5DPFSMtp3GuvuUycyrVh1VUOCzy+nh95R99zYoI80Z2/u9Tn8utNRxfm
	 o+wgDk5/aSDEg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 26 May 2026 17:59:33 +0200
Subject: [PATCH net-next v3 3/5] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-ks8995-to-ksz8-v3-3-c530f651989f@kernel.org>
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
In-Reply-To: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291784-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8367F5D94E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 net/dsa/tag_ks8995.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6c7425b45f..eef6ac0e1200 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17409,6 +17409,7 @@ F:	Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
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
index 000000000000..5bdb18271582
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,132 @@
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
+		netdev_err(dev, "%s: unable to untag skb\n", __func__);
+		return NULL;
+	}
+
+	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
+	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
+		   __func__, etype, portmask, ilog2(portmask));
+	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
+	if (!skb->dev)
+		return NULL;
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


