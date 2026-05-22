Return-Path: <netdev+bounces-290844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJF4OilfEGoxWwYAu9opvQ
	(envelope-from <netdev+bounces-290844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A55935B5820
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11FA0317D7AD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93213AFAEC;
	Fri, 22 May 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpICgPMW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E873ABDA2;
	Fri, 22 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456117; cv=none; b=XgoFM8Xcti86IeLhAkgFxag1Z04CBBgEQfZtG0oCRLTudEprKsprYNg/kF3dOsC34+LUnJzyvaTcUcA15x4H7CKFHRBx4hVBaCDQn595bR7H9I4clJJQupb24yhAI+F+bJH25z4uAEs1pav5U3O81+3MV0KzGFXWvsJ+vsRrAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456117; c=relaxed/simple;
	bh=vohzTUjTR0mMLvU55KtDbXo3HuCP2Q0hm2I0irxte5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ei9Kx6wM6UDuZQErEbUo7c61BvpJHctVmxlQY0gJE4D0Z3+wrbFZeGcFyna1YC4hHhsgNsR1CdzvxN5InVho8DbYNF29M8TCeIejkangsKIVdQ/w2X8b3l7bpyB4mwa1iqLoalJUZ8WzDWYbBbfq08qEYaPiP60mNhCX54etwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpICgPMW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86061F000E9;
	Fri, 22 May 2026 13:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456112;
	bh=57XGUpwtFtSZ3zAEnC1LVntPMy4p6Lcj+yFPnbzAohw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KpICgPMWgAc5eV08Qj3WEyJt3aQ5GswaeTR8bYXXAi/HIbvPzBCwmfPM1LpbA2GlL
	 dYXCM23tJ8GpzIV/IeRa9oOXyQTS8c0WF/1OUTJWsCqzrCH68U4GOr8e/6PgO/2VgJ
	 8jkhvrLzW1YiSjhA7ZItKXxqEhgnGQvFgIPsw/9wTeo0jErn00Jm7KkH34cSvfyI0u
	 UxhBNm3VQ/A8g8Zx7gilGKcXQs2gygFzX6PywobgPr7yQ2yKGGTUnk7uZFl/ljg9eo
	 im5RKNCwpYjgOsHWWjt0KJ8CV3lSIcyJ00hd6jiwFwa25AKJ6gSVatE000PEYF3zuf
	 2kSXBdJey10gQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 22 May 2026 15:21:25 +0200
Subject: [PATCH net-next v2 3/5] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-ks8995-to-ksz8-v2-3-5712c0dc9e75@kernel.org>
References: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
In-Reply-To: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290844-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A55935B5820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The KS8995 100Mbit switch can do proper DSA per-port tagging
with the proper set-up. This adds the code to handle ingress
and egress KS8995 tags.

The tag is a modified 0x8100 ethertype tag where a bit in the
last nybble is set for each target port.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2e..91e31e293ff3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_KS8995_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..11fd72891759 100644
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
index bf7247759a64..8ff313f1d329 100644
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
index 000000000000..b3ffbd5e6393
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
+		netdev_info(dev, "%s: dropped ethertype 0x%04x\n",
+			    __func__, etype);
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


