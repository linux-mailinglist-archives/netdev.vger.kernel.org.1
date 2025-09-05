Return-Path: <netdev+bounces-220463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C02B4621E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969D67AEC92
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D984274B50;
	Fri,  5 Sep 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjS+iXso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49F2749ED;
	Fri,  5 Sep 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096278; cv=none; b=HJ+LlWvW+9Weabzo32ic9RPDHLOk3dZQgnefrn4LO9R7zsmvOtniecSj196LDOKiV0iNUw5xWnCMj7F9vnL9VANR3HzrU3n8MLL/tRZquSjHx75kVawKpLK5Ge5RiY3qspc7eSWE8Ru4tQfghqKq0fNVuhD55vE2+jzPfLowYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096278; c=relaxed/simple;
	bh=9j9yJwoFpexV+JCJnDmDogzRwblUAczhe0j91Bc7Z6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhwY6kfytb5OSm5o2YEgUr/f5ANzxzEM10IFHtDOS9l9leGWGYY21OwNdcx4WDa/x1NiSiw4akARiOkmHFLCvwwXWEFkrW9S+1wHVKyeyBPlYwFELPdSKGo61VArl+OC5WullsJRGj5YrH1aanJ09ndIGlUSzPCUm4JhriNZtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjS+iXso; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772481b2329so2585775b3a.2;
        Fri, 05 Sep 2025 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757096276; x=1757701076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6kBkkWx3iIWy2H7XUDfx4CMLFKyS8rbVKaognSdXic=;
        b=TjS+iXso/EfTV0TduDYFVtdEywi6C6CYTKeKTMVO3stz0tfMxB8ZQUf4X2xMH4htMu
         XbHYv0qB8kkmbq7xzO4veK0vlp11Q9XpNjA8DK/yKmujbWrVLKm8vc4qkLkinR0YEudJ
         EAYTaTeX+KqRNAP8ENjEXL8anp7AbAT77MHgbCbgvMlsmL93y0HXvQlG07NBr0s2ta0K
         ZMwwyjcNdvqf+mkUGse0LwI6zg2g0e8zKNuTCPBhDisDbOCORlBa8nVzF6G2bsamzrvs
         +EUx3Ikt7tP9x5iqwSvAnujbLiDjQcFlskFGiCZZyWc5YCvTyb84i8h4dfHceRubefx/
         R3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096276; x=1757701076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6kBkkWx3iIWy2H7XUDfx4CMLFKyS8rbVKaognSdXic=;
        b=hRS77CVk30n73mTuvzwbgCkLB1StAyGOKolwYWNoHGp3EUa7Z8sPamnAlZrR+Ke6rI
         iconMe3JWKcg24+igYlCXWdaNAtaKuNghHTZNAfNe21TAbNq+yYOl30fNMGZJY7EDahE
         cVUHULemWP5t+1W4HY2mb80lo0wWiZoAwjVqIg3o18QOqJXc8yF3B9pWQG9o777a1rEV
         X3ugAFP/+0edfRBKpANNa3EuScblBx5tj7wvBKDTEFiFDjVA+Ha1QA1ZujT+ZlXIwKVg
         hcPbC/Ji/Ag1+Oe8kPyvL5jxs1E9U8RpLkhVLkPuoLi6rVHGyP0YWRhEQbsnM6P7Nn5y
         fFNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWNlzXQ/rNM2zMikCN9mvyv1IVPgET1BSWlprkWhqZ/BoFABYURC12Z7r39JNtm9RL8ziuej8ur8d8gWmc@vger.kernel.org, AJvYcCX0xGS5sF8IzDBtSX0k0fVxWa1PHmfquVkY9KJwCoCJ/EZ+OHUVwFr6PAZ9j8sq7c1mmKtSm49fNKT2@vger.kernel.org
X-Gm-Message-State: AOJu0YyeK4aaSF2fTKv5/U7OnIxOWzZlzoleKz7m4VZOB1AJaEJ3zbNq
	Dx58JYDTHFYr3fyaX2rRqxaLcQ214RNypwt3Sli+aFiczSKebpiB1dPgaBH9/YPxack=
X-Gm-Gg: ASbGncsjBdPcFYocBbE+YxcVtGKKEWT1gBS/m85JnD7xPponXkaRJMDtrvVGJRnhrix
	alYf6vvn/kFHK5vVDdPQq1PtC1g7FRDAFirsaja+AKdiWIN05+gptJ/rp4DF9jpLrIihTElAbSa
	M/s8M8bWiz0KqJZt9T0erwepCEvKwf2MVVhWJebGsXmljqeFekTp8Me1lEMC2Dv4W5cNdKrL6sw
	xtz72UVRjvAWooJK87SahDoswL3QPoFDs7oxNdsEuMLDhxongJPvYNTad+Udrnpw5N8rhxIZIhQ
	zboirDHzAcjIcGR5tEogln4E8asSkxET/aW+Zf8Nfaj5CDOhC6p72n2A81CuvoHhdMzjiTEdsX/
	iE7caXbUB7x7zKqPfBC219UiWxfqDChU41YYys+ji
X-Google-Smtp-Source: AGHT+IFGu4pm/jXyXI+Jo5cmPPa6kw6v3TORnAHD6cDVx3bMSXqWQRWbLghKMVKTFQ3VtHWm4jT+KA==
X-Received: by 2002:a05:6a20:9190:b0:248:4d59:93ed with SMTP id adf61e73a8af0-2484d599595mr16209613637.53.1757096275573;
        Fri, 05 Sep 2025 11:17:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3282dd2sm19964031a12.44.2025.09.05.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:17:55 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Sat,  6 Sep 2025 02:17:22 +0800
Message-ID: <20250905181728.3169479-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905181728.3169479-1-mmyangfl@gmail.com>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
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
 net/dsa/tag_yt921x.c          | 138 ++++++++++++++++++++++++++++++++++
 5 files changed, 148 insertions(+)
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
index 000000000000..02947a3d1421
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,138 @@
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
+#define YT921X_NAME	"yt921x"
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
+		/* Should be forwarded by software */
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
+	.name	= YT921X_NAME,
+	.proto	= DSA_TAG_PROTO_YT921X,
+	.xmit	= yt921x_tag_xmit,
+	.rcv	= yt921x_tag_rcv,
+	.needed_headroom = YT921X_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT921x switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT921X, YT921X_NAME);
+
+module_dsa_tag_driver(yt921x_netdev_ops);
-- 
2.50.1


