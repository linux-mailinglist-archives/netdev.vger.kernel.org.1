Return-Path: <netdev+bounces-224712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68060B88A3E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E2C1C87747
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321283093CD;
	Fri, 19 Sep 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbnv3+KX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A03093A7
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275103; cv=none; b=E+C/KWxsSP/gnShiz+R/P4KqvbeTPQPD1tpTT7bHCYr4jHEg+p9yEN3yD7UBidueEtu0UbxgAHHk/BqJ2ySi18F4OSYWdxorjMVf3MDzdjAvGu4EAdc+pHHl9ZeDdbcMkL+5okYCjXUIoMAI32VuMpgSCwgWRY+Bpyx0+dY+kkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275103; c=relaxed/simple;
	bh=SZ2v3HFrpzfTIKrJkGYFsVPTstS5wi/CPHBzBdXSC5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6jxeSc0V3sCqJJQTD4vhEsKhcyGHr6AnvzMVsN5/LMvz8OydYBVf550QqsIWvbdOkscbRE7eGIs8jQKbI2uwnR0t1HZHdeAQCvSxMw2+R8qIpsLw46lMazRV4HfP5MJiny3EUd8YRjRC5r9SiChthiqo34Cv+5WOwYAz4Kp7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbnv3+KX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330469eb750so2191404a91.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275100; x=1758879900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JgmLAllM6GJ7LAy07OgoFPN7Fl/16NMS6tmzU8OBXw=;
        b=Nbnv3+KX882dJTEdp0HGDdOzeqMlvhwLz63UOrHfsidWgU9rOLMoI/N5H/4hT54StB
         VSyfqrPsJqGYcCPV4wczge39mYWLWxsP9oVV2f1bW2iEsdjQqXJHKfO7C+o8pBhNWvR1
         Oo0xexHBgbKAt/o8Uwjn0NmV+xQw5SIlDETx/T5BDNTIq1eqNFH5pFWhbcvwTd531C9Y
         sOPe2fmOEGVEs6M/2Dne/3S9y4ARGqG/Kwibc2UdKO6MKZ3EL246GP5YOdO52Oo3uhtE
         m6Ns60sZqyCG+AZSphaewicfKiL/HEtV0T/lp+o/O90K1VqvsYav7I166ttw35TSAl4q
         5aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275100; x=1758879900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JgmLAllM6GJ7LAy07OgoFPN7Fl/16NMS6tmzU8OBXw=;
        b=xQIOnQgrWqmWZYlfKuqHnULGH8dx8v54t50sFlYkAonM4DczCVtyEzPV4NICy3PhXr
         4TGEWt4f+bLU6vGY/AOHIw8KqCyHJhuSOOY0EhYaklLQ/zicvy5+qGTCnFbhfbC8sRkr
         h8A9WGGDtJUVp+KdxKqFmOh0yRuX6wPkJVNXaij1iB//fWkEqzq6EpoB16MVVCOCW+Pn
         mSdTJGyUL3cNIctywJeJdn6A7DGUDP4ZjUPFsCto7MjX0n8OPhdb9dwxiV9ODwVS2Bqs
         YL4qK0r86GC4e93kmgig0J9H3Mu1awWpMuGLfi1rUbRu2GmtDPvZO7QKeZefR37nKxBa
         r6eQ==
X-Gm-Message-State: AOJu0YwO+mn9GCZ6GF7iTdOLR/U9FZWGbzbWH5tMWBTzjUonUG0t8tUi
	h0DSda08HFX/Ccow583ob4MLNKU5V+ot92nf0kZT9K/teGn08J/mL7YYL6vzAOLivXU=
X-Gm-Gg: ASbGncv3f6vCbHgTu0+bsJ6Miqgy2vUslV0C1SD4mjVHXMQuhRugFu5Nd1D6z5wiuaR
	e7PUKrgoy1XQP7cSDdirMpPDLCXA6SQ7PzWs85lvXUCi525XWVnFmV3w9j6wNVjOMt7VT8dqbEc
	xckpt0LMhR0NuXw347cTul9nYzFa6RD5XKYNXL//IeTQHi0KKA4ZTr1acl+CdlDfeahJ4037fL4
	LTAu0FOe/DpWQwRDDAU1aqWEYACKy4figWJmPdSPutGQojGjxRSWyaElVw5mNeQ1etmi7eywzZc
	70Z8BS1xA1Yc0Nj/M3RUxwZ7rcolTTgp61CmSZeIMlvuEZfhb+HCHExXHKRbXv8S2vzJhmCnTrX
	2jXAlfpPV0BRmZ6xwMSmPSt18rVYTLA==
X-Google-Smtp-Source: AGHT+IHJKELUVeXQGy9htu0ar0etqlx8AduQJ8B5Bog3n1moLwNAlsp8QCIrcDep0gT5KTcBKeDXXw==
X-Received: by 2002:a17:90b:1e53:b0:32e:32e4:9789 with SMTP id 98e67ed59e1d1-33097fdc3ffmr3507814a91.3.1758275100388;
        Fri, 19 Sep 2025 02:45:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3304a1d22cfsm6221873a91.7.2025.09.19.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:45:00 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 4/5] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Fri, 19 Sep 2025 17:42:29 +0800
Message-ID: <20250919094234.1491638-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919094234.1491638-1-mmyangfl@gmail.com>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Motorcomm YT921x tags, which includes a proper
configurable ethertype field (default to 0x9988).

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |   6 ++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_yt921x.c          | 141 ++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 net/dsa/tag_yt921x.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d73ea0880066..67762fdaf3c7 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -55,6 +55,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
+#define DSA_TAG_PROTO_YT921X_VALUE		30
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -87,6 +88,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
+	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 69e0457eb200..cfd200c87e5e 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -114,6 +114,7 @@
 #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_YT921X	0x9988		/* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_EDSA	0xDADA		/* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_8021Q	0xDADB		/* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 869cbe57162f..6b94028b1fcc 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -190,4 +190,10 @@ config NET_DSA_TAG_XRS700X
 	  Say Y or M if you want to enable support for tagging frames for
 	  Arrow SpeedChips XRS700x switches that use a single byte tag trailer.
 
+config NET_DSA_TAG_YT921X
+	tristate "Tag driver for Motorcomm YT921x switches"
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  Motorcomm YT921x switches.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 555c07cfeb71..4b011a1d5c87 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
+obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
new file mode 100644
index 000000000000..995da44f0a2a
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Motorcomm YT921x Switch Extended CPU Port Tagging
+ *
+ * Copyright (c) 2025 David Yang <mmyangfl@gmail.com>
+ *
+ * +----+----+-------+-----+----+---------
+ * | DA | SA | TagET | Tag | ET | Payload ...
+ * +----+----+-------+-----+----+---------
+ *   6    6      2      6    2       N
+ *
+ * Tag Ethertype: CPU_TAG_TPID_TPID (default: ETH_P_YT921X = 0x9988)
+ *   * Hardcoded for the moment, but still configurable. Discuss it if there
+ *     are conflicts somewhere and/or you want to change it for some reason.
+ * Tag:
+ *   2: VLAN Tag
+ *   2: Rx Port
+ *     15b: Rx Port Valid
+ *     14b-11b: Rx Port
+ *     10b-0b: Cmd?
+ *   2: Tx Port(s)
+ *     15b: Tx Port(s) Valid
+ *     10b-0b: Tx Port(s) Mask
+ */
+
+#include <linux/etherdevice.h>
+
+#include "tag.h"
+
+#define YT921X_TAG_NAME	"yt921x"
+
+#define YT921X_TAG_LEN	8
+
+#define YT921X_TAG_PORT_EN		BIT(15)
+#define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
+#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
+#define  YT921X_TAG_RX_CMD_FORWARDED		0x80
+#define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
+#define  YT921X_TAG_RX_CMD_UNK_MCAST		0xb4
+#define YT921X_TAG_TX_PORTS_M		GENMASK(10, 0)
+#define YT921X_TAG_TX_PORTn(port)	BIT(port)
+
+static struct sk_buff *
+yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	unsigned int port = dp->index;
+	__be16 *tag;
+	u16 tx;
+
+	skb_push(skb, YT921X_TAG_LEN);
+	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
+
+	tag = dsa_etype_header_pos_tx(skb);
+
+	tag[0] = htons(ETH_P_YT921X);
+	/* VLAN tag unrelated when TX */
+	tag[1] = 0;
+	tag[2] = 0;
+	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	tag[3] = htons(tx);
+
+	return skb;
+}
+
+static struct sk_buff *
+yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	unsigned int port;
+	__be16 *tag;
+	u16 cmd;
+	u16 rx;
+
+	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
+		return NULL;
+
+	tag = dsa_etype_header_pos_rx(skb);
+
+	if (unlikely(tag[0] != htons(ETH_P_YT921X))) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Unexpected EtherType 0x%04x\n",
+				     ntohs(tag[0]));
+		return NULL;
+	}
+
+	/* Locate which port this is coming from */
+	rx = ntohs(tag[2]);
+	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Unexpected rx tag 0x%04x\n", rx);
+		return NULL;
+	}
+
+	port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
+	skb->dev = dsa_conduit_find_user(netdev, 0, port);
+	if (unlikely(!skb->dev)) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Couldn't decode source port %u\n", port);
+		return NULL;
+	}
+
+	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
+	switch (cmd) {
+	case YT921X_TAG_RX_CMD_FORWARDED:
+		/* Already forwarded by hardware */
+		dsa_default_offload_fwd_mark(skb);
+		break;
+	case YT921X_TAG_RX_CMD_UNK_UCAST:
+	case YT921X_TAG_RX_CMD_UNK_MCAST:
+		/* NOTE: hardware doesn't distinguish between TRAP (copy to CPU
+		 * only) and COPY (forward and copy to CPU). In order to perform
+		 * a soft switch, NEVER use COPY action in the switch driver.
+		 */
+		break;
+	default:
+		dev_warn_ratelimited(&netdev->dev,
+				     "Unexpected rx cmd 0x%02x\n", cmd);
+		break;
+	}
+
+	/* Remove YT921x tag and update checksum */
+	skb_pull_rcsum(skb, YT921X_TAG_LEN);
+	dsa_strip_etype_header(skb, YT921X_TAG_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops yt921x_netdev_ops = {
+	.name	= YT921X_TAG_NAME,
+	.proto	= DSA_TAG_PROTO_YT921X,
+	.xmit	= yt921x_tag_xmit,
+	.rcv	= yt921x_tag_rcv,
+	.needed_headroom = YT921X_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT921x switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT921X, YT921X_TAG_NAME);
+
+module_dsa_tag_driver(yt921x_netdev_ops);
-- 
2.51.0


