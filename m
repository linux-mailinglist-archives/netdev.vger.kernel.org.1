Return-Path: <netdev+bounces-111215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04A9303DF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D49C1C2090C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32D130AF6;
	Sat, 13 Jul 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gua/YZr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740E12FB2A;
	Sat, 13 Jul 2024 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850118; cv=none; b=rs/rqFcz7aqjNnSJQ7lf5ISRaZ/YZf0UeXS1+cfq6V70xcPUtwaHSDZuBVAUTeu9bw0/dZYO7+7hXQZctWIfgdj/BjNPsSdgihPfr5BguNe4Mtn7y4gfAM0NtpLaxSNNwg/dyroWSEzIL4P3YipoRhG6gfrhszFlFKTacw4XM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850118; c=relaxed/simple;
	bh=tU1MDBxqtdAEFD/eSWaF3yY5Of+8VsCSB5Xj+ZcGBes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PekQU4Y1IMXDVngVbjAtv3FZrR2M7AqSurItLwulcYHyg2LPvBXqrQZH/Z6++Vc54+IiqLnCLLXJPBS+XrGria9AMC63xS38Hap8Y3oz5U5kVXuwYC/8yxusqmwTAUmfBn29nHjyRUZ2ujXJA3CKkinzdTlwgha83WFHSAeb+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gua/YZr9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77b60cafecso337985566b.1;
        Fri, 12 Jul 2024 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850115; x=1721454915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRK65MuRL/dqpPYwR3ct1ceNTNZOhW71q5D8BZ5w9KI=;
        b=gua/YZr9FUyMJ51at8qvKB2FXGVoKxQSkSFc3FyhdUdV77gfN4/YD8727x5JVfJQ/F
         xkUUWBoA/ECKI9NVUooMtgD3cQTcNOgNMEeLB3oh4N4Hwc974fVxjfl3RKG1gcRkY/S1
         rQE5PYFSh04y5hlhCa/4m8Z2ww280I6xIM7mUmiNUWS5WBCKaZQ+LWtUNpAwbXWKRUce
         GTQPSD1wyQ79YOQaOaR+683AAx74u/Rywh/GDqHzX+qYwQzErZwc7edKkZ6MwXodXUgY
         Wb3y388VGjGazFc8wL8kxYclVZCGi8gNMb5iyLMFJChg4IreMnH++MPwCYdum09I8Urj
         xxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850115; x=1721454915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRK65MuRL/dqpPYwR3ct1ceNTNZOhW71q5D8BZ5w9KI=;
        b=F05G7nmR72IiWYF6evw1Q3xuzx0eJ+SmSTNCo9DbH+OiBWlYuPd6NFRbxPWaz8yxDa
         p/EN6cC5ZqrovjV2Uyrm1JHXvew4TgGtvk66Kd2oZ8sBI0T7JwSkfIyRL6zm14cy3PZs
         cNKowiOo1yz5kcn11HKGJ2sNkeXJW7x6MGUEmyOWvIlooqwlpWkulqxEdmjlN3eD8ZPS
         SqHtAVT0d8XpOMaQ8Sn/0Kok7Q1f/ad1xFfbIOcgv//svEz6h8Jz05uYKl3TCV40Lee2
         HjCh4YXmpjRFGFhKyR4GIDU7cu9JD0RJexWl/cMqmrGTsqG00Jsz+f6bPYc9RGmj3tNJ
         tTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqh+e5Sn3yMXNjs1q++7JLvnSJYlO8sQBjsiKmJORaIpuoI6KGeaW3ls2F7y7SeedXcfHco+v3PRDpPh3c5nj7kemX69GlaNaWHpMi
X-Gm-Message-State: AOJu0Yx7hwcVRK5RqQfolINMUXtGv22P36552rdjoaq4oNftIK4P7tfH
	Ia6kLgCnW5TGzogp8MatDEiB6aEdzePFPI6bu4bfpQxDOYd+MpvUoqN5ewKA
X-Google-Smtp-Source: AGHT+IHS4G3bbpFhL6gADmSVDcC8WGI8bRKY8Si/1OK0kN6ZOzefz2MmNiMyoTa4/x6fqZEuemN/3A==
X-Received: by 2002:a17:906:48b:b0:a72:8fc7:ef7f with SMTP id a640c23a62f3a-a780b89a12fmr846818566b.65.1720850114790;
        Fri, 12 Jul 2024 22:55:14 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:14 -0700 (PDT)
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
Subject: [PATCH net-next v3 07/12] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Sat, 13 Jul 2024 07:54:35 +0200
Message-Id: <20240713055443.1112925-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
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
v3,v2,v1:
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


