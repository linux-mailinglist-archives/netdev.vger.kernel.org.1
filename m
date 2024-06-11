Return-Path: <netdev+bounces-102696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39790454B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883D1286D9E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B8156652;
	Tue, 11 Jun 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTIo1M8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472A156257;
	Tue, 11 Jun 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135483; cv=none; b=M15Md2k/UyJP7xbUKcTtpp2BJDrF3zOl95GmamO/zgVoKzA0NsZ3qJmi886u3Ru1cqvy2gO6W5USkd7AMOjGP2zfxBKch2FtWttv4tTb5Wupt1cxRuA6VlbPnyxCZ9eEzsVmTDnpeOnFVcd5vFcBlakOqgax/Ib+GlaRkfd7/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135483; c=relaxed/simple;
	bh=CeZvKfJM6diifXGTJNLHv33j2pa/42CSAk2m9TDYrNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRVs4AahipF6fv9o/KpPU7GpnRPjtzhW/MqI3JrOYiXWlcQsdmo0fEoXu8FFwkMT1lHs99KN8yTD9E+r1h50d5yYwKvdZOl+q5VRGNPpnEG8AROL/0INXNG7cn/0fxK5hIFKH9qXGE5vr/AUlrZ06gd5Fg9apgloLn183CO8u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTIo1M8k; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso393094a12.1;
        Tue, 11 Jun 2024 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135480; x=1718740280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5n9oE0ukmeKOaxWYmzQjz4q7vlmRvhTLb2hwLacImM=;
        b=XTIo1M8kRmqY3DtgJg4ZYGLlRWHF+2E1dJ9d+WEsYxuqLIgCnlNPTwUXbfTIN7pHoj
         0KfzQyBDWOk00alpoGbkfhCIkmvUadkhHAH4JHwgHq76bqJcxdNdjoknfVLUopi5vq4s
         bmVgMTVZFo9Diu3klzHvvZbgHE5UQ35CCzTwPDuHWguz45TWKAllIlANqQs3ICl4VlWO
         DS2IQLUja5PsY7nyOrwmmqabc6GTkXNkKSAR7nNnlXaOu9caRFQUVOUJk24KqGGVkHvX
         th4L6k++jFHj9x9jdTidMkFaNCjujTQn9UjDJ+K5+STNG1pvbO2jowvUnXFSy4G7ah7H
         hViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135480; x=1718740280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5n9oE0ukmeKOaxWYmzQjz4q7vlmRvhTLb2hwLacImM=;
        b=bA0826Co22DDBvadO9hPAtLKEDtAJ5x8RzanIONb/LWjfBJDjshqEOrKLsymMAtuzT
         szWspz/CXPgjqecddyoYlgx+MZvNzrSWP4zo/4Gb8h6u6MBqOZAYRgVp7dN0bUtI6EI9
         EcFVNbnYeNvkw74HBty7SeLRidA12qzLazJlReCBgPAEgtqqOPDb+v044xQHDfbD44vX
         oqy6qLp2F81YnkiZuYjpbdECgXyUhNGLWuA+H446fsWpk521GIhCjbAaftNZa3Xpd0U0
         xdZiZqrUjKXHeF0Oa9kW71IN5uG7ttU7CNDeTZAT+uSIEYJlcPgjTkH0UzByRO8MdjiS
         WXoA==
X-Forwarded-Encrypted: i=1; AJvYcCVWM3QL1IBN5NY2BtJo9LMPDyMq9IavmMHfGdOak3DJDCNd4i9uYhzxRLKrllzIdC9cpIZrxeNk7x75pG57l1QkmofRn2iar3qiE84N
X-Gm-Message-State: AOJu0YyPQhRB83Z9AstOB6ewZN5H9O2BbyjAqGs697jzjWU3dJd4qxYD
	MYMGQVwu07qH9nSItTSnA8SOAjEN4cpHTpGoDFawUDNry8aRFWO4TBL7xGQZFBY=
X-Google-Smtp-Source: AGHT+IFLHXiU4CR5i9G2b51OSC48LHzX9vMrFNtsOUTyTBtcrbp7SZrY0stuUQKoMFeph0YX7TllTA==
X-Received: by 2002:a50:8713:0:b0:57c:614c:56e7 with SMTP id 4fb4d7f45d1cf-57c90e53d08mr2108281a12.18.1718135479497;
        Tue, 11 Jun 2024 12:51:19 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:19 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/12] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Tue, 11 Jun 2024 21:49:59 +0200
Message-Id: <20240611195007.486919-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
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
v1:
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
index 8e698bea99a3..e59360071c67 100644
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


