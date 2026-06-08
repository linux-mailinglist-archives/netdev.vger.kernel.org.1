Return-Path: <netdev+bounces-296704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Gw2MWsYJ2pFrgIAu9opvQ
	(envelope-from <netdev+bounces-296704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8F65A119
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:30:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tinyisr.com header.s=purelymail2 header.b=MjyUyG4g;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b="IQY/ZeYp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296704-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=tinyisr.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3417A30221ED
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE93859C3;
	Mon,  8 Jun 2026 19:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E8249EB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 19:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947043; cv=none; b=KtdaYV4oXiE65Xu++wsqrF6/SfAj75GV2sZCjbU/BI8wyUK5yZ8kH9uBpsH/rHQ9TecwzCdQgtjn0FTAwP5YpT0uzqtN1FP/KzFj+1B8TJIkb599jU00tHerwROv4oZetxIf3P8D6G33P/GpX5jkQUtZJ7foRRcMMk8P1GGQ0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947043; c=relaxed/simple;
	bh=/Po4inVZQx7wRoL1GAwxCRAKv5JX9t6MokI5QBRKewo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avtEXJVFt83iLlMMucextjTyjUwUE9/padl0Lb4dITZmOlcbvkIBnKG9bMoSdXaRtmmFDQH8z7GFG84dx6VrABGcNSD3xiR4RV/GFMUausPsFTjkPlzOLh5TYYSKAh/kZeW03ky+nwaCsT3jm2SaVFD0LZPKwwcAtMNDpIlzcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=MjyUyG4g; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IQY/ZeYp; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=MjyUyG4geSHNB9OzpBjRsnC37IbujNRXMKtHarFnaIL5hxauiwcLxG4zeuxlf33cqVPFO+hfclIXDgYkKvDUWfDC+aX4IXbwFY6loGXQk5I7soi/DNTVXl0vXJlgREbMlrjPWWBFRpA4lKh4v1/fmoE1On/YeZpIobbGjY1rbjWPiD1jwV0GW4SobC45ZGczv64MDUVl0OMNk8xejeVxoViBH9QKkkJwdrfn39DTMF1qVbrEXYtVOGArtZGkSEIV3XPf9dauRiLrS+fhbsjvMyhu9UBHGvT6Y7YEssqq8iDAWSEnvpk5kRoTei8/SxA4cNdaMO8taXruHd8m1EIWMA==; s=purelymail2; d=tinyisr.com; v=1; bh=/Po4inVZQx7wRoL1GAwxCRAKv5JX9t6MokI5QBRKewo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=IQY/ZeYpmgGcvC8bFnqCvA5pOFUbdxLEAWUGs8gRTfq9Ueuk9W7xmAT194KW4ksAQ9SuheJ3IklPtLjvZhkOItPmQ9sQYfZNzc0gPKkUDF5CBpsjOpds5rFu3MBH8E+ZNxaOagfm7MnDBcWxZwhp6iDDCIqenO/0yRth4bV1z2bKVmhgsKkxxGTy4uO6u7FhJi6CtZI7JiIRqNuoLa4nI8RRXcW2UkY2qJIchtzZW712uCXVfzi2tT5hqwnybiYPmrAQhDJGVGuImXy6tyCl1YcckCvJ1d7m2iYJP+7ukj0cFI2WStW0HqP0pxfOqQG0XEqO210SjpIo3nTxNDk6Aw==; s=purelymail2; d=purelymail.com; v=1; bh=/Po4inVZQx7wRoL1GAwxCRAKv5JX9t6MokI5QBRKewo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 305744462;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 08 Jun 2026 19:30:40 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v4 3/4] net: dsa: initial MT7628 tagging driver
Date: Mon,  8 Jun 2026 22:29:47 +0300
Message-ID: <20260608192948.289745-4-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608192948.289745-1-joey@tinyisr.com>
References: <20260608192948.289745-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296704-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:daniel@makrotopia.org,m:joey@tinyisr.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,arinc9.com,mediatek.com,makrotopia.org,tinyisr.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,tinyisr.com:from_mime,vger.kernel.org:from_smtp,purelymail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CF8F65A119

Add support for the MT7628 embedded switch's tag.

The MT7628 tag is merged with the VLAN TPID field when a VLAN is
appended by the switch hardware. It is not installed if the VLAN tag is
already there on ingress. Due to this hardware quirk the tag cannot be
trusted for port 0 if we don't know that the VLAN was added by the
hardware. As a workaround for this the switch is configured to always
append the port PVID tag even if the incoming packet is already tagged.
The tagging driver can then trust that the tag is always accurate and
the whole VLAN tag can be removed on ingress as it's only metadata for
the tagger.

On egress the MT7628 tag allows precise TX, but the correct VLAN tag
from tag_8021q is still appended or the switch will not forward the
packet.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h    |  2 +
 net/dsa/Kconfig      |  6 +++
 net/dsa/Makefile     |  1 +
 net/dsa/tag_mt7628.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 net/dsa/tag_mt7628.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc10..913d1f71e3db 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE=09=0931
 #define DSA_TAG_PROTO_MXL862_VALUE=09=0932
 #define DSA_TAG_PROTO_NETC_VALUE=09=0933
+#define DSA_TAG_PROTO_MT7628_VALUE=09=0934
=20
 enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_NONE=09=09=3D DSA_TAG_PROTO_NONE_VALUE,
@@ -95,6 +96,7 @@ enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_MXL_GSW1XX=09=3D DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 =09DSA_TAG_PROTO_MXL862=09=09=3D DSA_TAG_PROTO_MXL862_VALUE,
 =09DSA_TAG_PROTO_NETC=09=09=3D DSA_TAG_PROTO_NETC_VALUE,
+=09DSA_TAG_PROTO_MT7628=09=09=3D DSA_TAG_PROTO_MT7628_VALUE,
 };
=20
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..23b4b74004ed 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
 =09  Say Y or M if you want to enable support for tagging frames for the
 =09  Marvell switches which use EtherType DSA headers.
=20
+config NET_DSA_TAG_MT7628
+=09tristate "Tag driver for the MT7628 embedded switch"
+=09help
+=09  Say Y or M if you want to enable support for tagging frames for the
+=09  switch embedded in the MT7628 SoC.
+
 config NET_DSA_TAG_MTK
 =09tristate "Tag driver for Mediatek switches"
 =09help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index b8c2667cd14a..d15bcf5c68f0 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) +=3D tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) +=3D tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) +=3D tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) +=3D tag_lan9303.o
+obj-$(CONFIG_NET_DSA_TAG_MT7628) +=3D tag_mt7628.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) +=3D tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) +=3D tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) +=3D tag_mxl-gsw1xx.o
diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
new file mode 100644
index 000000000000..f0e346595f30
--- /dev/null
+++ b/net/dsa/tag_mt7628.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Joris Vaisvila <joey@tinyisr.com>
+ * MT7628 switch tag support
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/dsa/8021q.h>
+#include <net/dsa.h>
+
+#include "tag.h"
+
+/*
+ * The MT7628 tag is encoded in the VLAN TPID field.
+ * On TX the lower 6 bits encode the destination port bitmask.
+ * On RX the lower 3 bits encode the source port number.
+ *
+ * The switch hardware will not modify the TPID of an incoming packet if i=
t is
+ * already VLAN tagged. To work around this the switch is configured to al=
ways
+ * append a tag_8021q standalone VLAN tag for each port. That means we can
+ * safely strip the outer VLAN tag after parsing it.
+ *
+ * A VLAN tag is constructed on egress to target the standalone VLAN and
+ * destination port.
+ */
+
+#define MT7628_TAG_NAME "mt7628"
+
+#define MT7628_TAG_TX_PORT GENMASK(5, 0)
+#define MT7628_TAG_RX_PORT GENMASK(2, 0)
+#define MT7628_TAG_LEN 4
+
+static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
+=09=09=09=09       struct net_device *dev)
+{
+=09struct dsa_port *dp;
+=09u16 xmit_vlan;
+=09__be16 *tag;
+
+=09dp =3D dsa_user_to_port(dev);
+=09xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+
+=09skb_push(skb, MT7628_TAG_LEN);
+=09dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
+
+=09tag =3D dsa_etype_header_pos_tx(skb);
+
+=09tag[0] =3D htons(ETH_P_8021Q |
+=09=09       FIELD_PREP(MT7628_TAG_TX_PORT,
+=09=09=09=09  dsa_xmit_port_mask(skb, dev)));
+=09tag[1] =3D htons(xmit_vlan);
+
+=09return skb;
+}
+
+static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
+=09=09=09=09      struct net_device *dev)
+{
+=09__be16 *phdr;
+
+=09if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
+=09=09return NULL;
+
+=09phdr =3D dsa_etype_header_pos_rx(skb);
+=09skb->dev =3D
+=09    dsa_conduit_find_user(dev, 0,
+=09=09=09=09  FIELD_GET(MT7628_TAG_RX_PORT, ntohs(*phdr)));
+=09if (!skb->dev)
+=09=09return NULL;
+
+=09skb_pull_rcsum(skb, MT7628_TAG_LEN);
+=09dsa_strip_etype_header(skb, MT7628_TAG_LEN);
+=09dsa_default_offload_fwd_mark(skb);
+=09return skb;
+}
+
+static const struct dsa_device_ops mt7628_tag_ops =3D {
+=09.name =3D MT7628_TAG_NAME,
+=09.proto =3D DSA_TAG_PROTO_MT7628,
+=09.xmit =3D mt7628_tag_xmit,
+=09.rcv =3D mt7628_tag_rcv,
+=09.needed_headroom =3D MT7628_TAG_LEN,
+};
+
+module_dsa_tag_driver(mt7628_tag_ops);
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MT7628, MT7628_TAG_NAME);
+MODULE_DESCRIPTION("DSA tag driver for MT7628 switch");
+MODULE_LICENSE("GPL");
--=20
2.54.0


