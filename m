Return-Path: <netdev+bounces-267745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMJAACl6tWn80wAAu9opvQ
	(envelope-from <netdev+bounces-267745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5828D9E9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CE8B301327B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF237DE99;
	Sat, 14 Mar 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="rMt/A8tV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lqxGWe1G"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92937DE85
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500960; cv=none; b=FauScGOWHFC7Y1JLwpJf27y50iNywKuE8BIIgTCqsG12oddrF6S+ighDvMRKHtedliQzBXF3EocOpTeqm/BIGrmMFjXo2ieWsRUe5WFefKdNZB9im7MC1NnG3YxHdKO0st1A80iypF4Ek5ET1M6QkJZyegHm8SZvJDtp4B1cS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500960; c=relaxed/simple;
	bh=eCO5564ivnX99nTyNxdUlKItasg3mIPMRUwgeUdt78A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIEEHPdQV7F6GasdBjReEzEm0gUXck0RJemQBgDCwYtoeLB1Vp4VS4InkZsPMmv2KR5y2vuf5UsCEoyZQd74RfOWx+AQXmsR710nAiLBE1Qk53w7eBDpsbZBZwF44Q78UDGqq25SwBeDFZUabMG8c4GY7+HlBLoPqd5ZnexYkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=rMt/A8tV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lqxGWe1G; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rMt/A8tVAjKAuE8GMT9rvz7eItQJrtEuO0we6FmwxMcvL4DUwp84thUc7kwxheNko9ge2q6+YHbXcHe3jr2VP6jJCoLK6/4XrBUSptjUTfahEgr/gAHfQh2BBMkWGwRzYuuRNA6lS70H+Bbu66WF9wcvlOc3vx8SGv/MLzYXDtSsUtuZY793GB5LeHMEcpaeTc3MiRoqrsW5PZo24qCRdwVNTB7Rjemb+wCVXwhXmJVo1tY7n6oirSebrMWwjP4Pq3jqipgaAb0MW7hq+vQ2BVWQJ6Cdr+HTHca9I1UI3GCvUYbTgKhGXpmYjizlFhlQjr5znMeL4zg0fJ5S6ep/Dg==; s=purelymail2; d=tinyisr.com; v=1; bh=eCO5564ivnX99nTyNxdUlKItasg3mIPMRUwgeUdt78A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=lqxGWe1GVyInyMOwR/44I0baU+r5RjzCAH98+iYLDRELHhmwEv0rVT3dpZrIfLC5GSb1R1JGEihdtmdkoXgpPVMfqdTsWZnRkU75w8z/jqqUaGoOEjd5jawlRqZJ6J1Ms2y5Dmh4LfQk+fGW0tK7s/exl5FTJ+Eq2M1UwjBTzAeToeoevVC4ZwBs34c5ert1nOhlCpW3olih4Z8WYCudIY7l8yjKf379pMOCsax39SjO7NW6hQj1vu4/SRJulxoXsLSnaVTjqTKo+Cl/9Zp7X2Hy7ffOyn6gyNeVs4kyvPsXEK5jESwD6RKoqSwzxgUvRHjNq2sn4DF+SWS9u0Gtrg==; s=purelymail2; d=purelymail.com; v=1; bh=eCO5564ivnX99nTyNxdUlKItasg3mIPMRUwgeUdt78A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2038631184;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Mar 2026 15:09:17 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v2 2/3] net: dsa: initial MT7628 tagging driver
Date: Sat, 14 Mar 2026 17:08:44 +0200
Message-ID: <20260314150845.653866-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314150845.653866-1-joey@tinyisr.com>
References: <20260314150845.653866-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-267745-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: 97C5828D9E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 include/net/dsa.h    |  2 +
 net/dsa/Kconfig      |  6 +++
 net/dsa/Makefile     |  1 +
 net/dsa/tag_mt7628.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 net/dsa/tag_mt7628.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc..e93f9356b5c3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE=09=0930
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE=09=0931
 #define DSA_TAG_PROTO_MXL862_VALUE=09=0932
+#define DSA_TAG_PROTO_MT7628_VALUE=09=0933
=20
 enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_NONE=09=09=3D DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_YT921X=09=09=3D DSA_TAG_PROTO_YT921X_VALUE,
 =09DSA_TAG_PROTO_MXL_GSW1XX=09=3D DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 =09DSA_TAG_PROTO_MXL862=09=09=3D DSA_TAG_PROTO_MXL862_VALUE,
+=09DSA_TAG_PROTO_MT7628=09=09=3D DSA_TAG_PROTO_MT7628_VALUE,
 };
=20
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..4aa73bd1aa9b 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -211,4 +211,10 @@ config NET_DSA_TAG_YT921X
 =09  Say Y or M if you want to enable support for tagging frames for
 =09  Motorcomm YT921x switches.
=20
+config NET_DSA_TAG_MT7628
+=09tristate "Tag driver for the MT7628 embedded switch"
+=09help
+=09  Say Y or M if you want to enable support for tagging frames for the
+=09  switch embedded in the MT7628 SoC.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..d25ec0ab7d67 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) +=3D tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) +=3D tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) +=3D tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) +=3D tag_yt921x.o
+obj-$(CONFIG_NET_DSA_TAG_MT7628) +=3D tag_mt7628.o
=20
 # for tracing framework to find trace.h
 CFLAGS_trace.o :=3D -I$(src)
diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
new file mode 100644
index 000000000000..ca286d1c9e44
--- /dev/null
+++ b/net/dsa/tag_mt7628.c
@@ -0,0 +1,93 @@
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
+#define MT7628_TAG_TX_PORT_BIT_MASK GENMASK(5, 0)
+#define MT7628_TAG_RX_PORT_MASK GENMASK(2, 0)
+#define MT7628_TAG_LEN 4
+
+static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
+=09=09=09=09       struct net_device *dev)
+{
+=09struct dsa_port *dp;
+=09u16 xmit_vlan;
+=09u8 *tag;
+
+=09dp =3D dsa_user_to_port(dev);
+=09xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+
+=09skb_push(skb, MT7628_TAG_LEN);
+=09dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
+
+=09tag =3D dsa_etype_header_pos_tx(skb);
+
+=09tag[0] =3D ETH_P_8021Q >> 8;
+=09tag[1] =3D FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
+=09=09=09    dsa_xmit_port_mask(skb, dev));
+
+=09tag[2] =3D xmit_vlan >> 8;
+=09tag[3] =3D xmit_vlan & 0xff;
+=09return skb;
+}
+
+static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
+=09=09=09=09      struct net_device *dev)
+{
+=09int src_port;
+=09__be16 *phdr;
+=09u16 tpid;
+
+=09if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
+=09=09return NULL;
+
+=09phdr =3D dsa_etype_header_pos_rx(skb);
+=09tpid =3D ntohs(*phdr);
+=09skb_pull_rcsum(skb, MT7628_TAG_LEN);
+=09dsa_strip_etype_header(skb, MT7628_TAG_LEN);
+
+=09src_port =3D tpid & MT7628_TAG_RX_PORT_MASK;
+
+=09skb->dev =3D dsa_conduit_find_user(dev, 0, src_port);
+=09if (!skb->dev)
+=09=09return NULL;
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
2.53.0


