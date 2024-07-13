Return-Path: <netdev+bounces-111275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FC930769
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05271F20EDC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A3174EF9;
	Sat, 13 Jul 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W//5dEqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE991741FE;
	Sat, 13 Jul 2024 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905417; cv=none; b=myJzbkvRV/by19AaWhjaQhvtajIuGYHslsn8d6ZC4TOfCz6fmvYbpKT2eBzdSuBbazm9lQ0gYB53jlP9MSs4zTFK61RZ2q9BApla3t9uACQHP4zpC5f/c/0Hks2S7McDeiPsPJlQrt/KCaL/pWUPXSwR1V5KxXgAmtxPFNOmoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905417; c=relaxed/simple;
	bh=Dn3cNums0JR+6hOK/GnNt77+XnzF5GCSAK/rLepIl60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tjvj8yJSg6bqWOiMPVZ8GkpH9hHUYK6YnCJVEW7rgclDsVZFU5pzES8BMMEWxo1Ekf0sw/O3V8sO+i4PhjGiP49v2MtDGBdPKJPEDHG1qdyFpMvL7kLopFNgEEDYWSkKKK6SfvX36HpiOIY0jkanbHdl7Ef7PDpWXHIheelqXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W//5dEqp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso40728381fa.1;
        Sat, 13 Jul 2024 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905413; x=1721510213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF5NxuV7ZeJIaOBHxz1QhnXVJ2x98c5f4LO1L0BqTVk=;
        b=W//5dEqpW9Sb9ZlMh15s20d77QIwzmrqmyAUsFoDDepubyzpMizzfu8UJc5AdA16hV
         2x82MqEX9z/YV1+X2foVt6VbZO6pkm0sbDBHvBtGfkKK9X+CFVlBZd0SRYK4U8HU9TJy
         M2ijkfh07t9xKa4XFMprQn3FIv1eC51DcYW38MjjZyrshRQMX9GCvNMahLv7agdht5h2
         l0dniJrcndKHOHplPr6QDecwb6bEBe9tEdaR+sr6EOYAFWmmpPBih0bZaOJP1IEMpnU1
         gheCa2K5G5RlTGOETuvnDRdlT6IqNueHMSgx1LIkZW/qTl0dFWkrWttQ/EolB0awNGk+
         LMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905413; x=1721510213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hF5NxuV7ZeJIaOBHxz1QhnXVJ2x98c5f4LO1L0BqTVk=;
        b=ZoMqii3ksgy2YjGrlqZJ53GtYwU0X1npp6bUuQz9K71e5tvlYw2ul1OhN42V00Eqsc
         VSxrGA73xzMXibyiSoKMZxvv9s1X43on2AKVIl3dzWwNmxt8uSN/U/zD2RvmvQSauiZX
         8mxDh4nCEYLTx7NcjONnMwsZJWobPsU/YDuIJNtbI6SwIbNfT7N8g6qVCswzUoCWuSPz
         f+fE5LpfJKHMDxTuztCZZFenMrAP5b+oKEekW+Sip7DrwEr4WPj6jOZtBjoojB08fw37
         Ue6jQ1zw4XJKAqVmInWJQd0QAFHfJ5MC6+prPOJrnT6U7KMU/+Pcu3h6lK57MgoF9La7
         qSdg==
X-Forwarded-Encrypted: i=1; AJvYcCWCIFKuFFezrOTj+Kmp9d40rWz96pezVwC2JLIg8pXNnqT8KajxF94Hy4tgTaKPE5AtdEYzDkqZOdTvB0W7XuMD266jN0t0Xczq3rlI
X-Gm-Message-State: AOJu0YxpqhHFU1zySn6h411zNfKoi6HnAxS+FxR0i183RXcD8jO9b5Ya
	pQFYML9GWlXfFShu99no0qKPJJ0Vsp9Ae8HLI9KpxXe9EV6ysiXB9uUp2/wK
X-Google-Smtp-Source: AGHT+IH94DmdTN9qJCbnnH1kvwvZWfU6MFUiqBqWl/RUSLl3jz2/pQpT5dnI3Tpe756GZxDHCzR4uA==
X-Received: by 2002:a2e:8784:0:b0:2ec:4aac:8fd4 with SMTP id 38308e7fff4ca-2eeb30b4cb1mr98532381fa.1.1720905413435;
        Sat, 13 Jul 2024 14:16:53 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:53 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 07/12] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Sat, 13 Jul 2024 23:16:13 +0200
Message-Id: <20240713211620.1125910-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces a new tagger based on 802.1q tagging.
It's designed for the vsc73xx driver. The VSC73xx family doesn't have
any tag support for the RGMII port, but it could be based on VLANs.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v4-v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - added 'Reviewed-by' only
v7:
  - replace netdev_warn by dev_warn_ratelimited
v6:
  - added missing MODULE_DESCRIPTION()
v5:
  - removed skb_vlan_tag_present(skb) checking
  - use 80 characters per line limit
v4:
  - rebase to net-next/main
v3:
  - Introduce a patch after the tagging patch split
---
 include/net/dsa.h           |  2 ++
 net/dsa/Kconfig             |  6 ++++
 net/dsa/Makefile            |  1 +
 net/dsa/tag_vsc73xx_8021q.c | 68 +++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index f9ae3ca66b6f..5a5a03a7b4c3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -53,6 +53,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
 #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
+#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -83,6 +84,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
+	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8d5bf869eb14..2dfe9063613f 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
 	  Say Y or M if you want to enable support for tagging frames at
 	  with a trailed. e.g. Marvell 88E6060.
 
+config NET_DSA_TAG_VSC73XX_8021Q
+	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
+	help
+	  Say Y or M if you want to enable support for tagging frames with a
+	  custom VLAN-based header.
+
 config NET_DSA_TAG_XRS700X
 	tristate "Tag driver for XRS700x switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 8a1894a42552..555c07cfeb71 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
+obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 
 # for tracing framework to find trace.h
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
new file mode 100644
index 000000000000..af121a9aff7f
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (C) 2024 Pawel Dembicki <paweldembicki@gmail.com>
+ */
+#include <linux/dsa/8021q.h>
+
+#include "tag.h"
+#include "tag_8021q.h"
+
+#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
+
+static struct sk_buff *
+vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+	u8 pcp;
+
+	if (skb->offload_fwd_mark) {
+		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+		struct net_device *br = dsa_port_bridge_dev_get(dp);
+
+		if (br_vlan_enabled(br))
+			return skb;
+
+		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+	}
+
+	pcp = netdev_txq_to_tc(netdev, queue_mapping);
+
+	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
+			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+}
+
+static struct sk_buff *
+vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
+
+	dsa_8021q_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+
+	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id,
+					   vid, vbid);
+	if (!skb->dev) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
+	.name			= VSC73XX_8021Q_NAME,
+	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
+	.xmit			= vsc73xx_xmit,
+	.rcv			= vsc73xx_rcv,
+	.needed_headroom	= VLAN_HLEN,
+	.promisc_on_conduit	= true,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DSA tag driver for VSC73XX family of switches, using VLAN");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1


