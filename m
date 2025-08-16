Return-Path: <netdev+bounces-214261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428EEB28AAB
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079FE1C853EE
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D191E5B94;
	Sat, 16 Aug 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk3WXPXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6351B4247;
	Sat, 16 Aug 2025 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321999; cv=none; b=bkYJuslp4Y5Z4zlHQhSgGBoM/RsJ+V1k0zYF4VPbwVDzhzx6DhSlU54MjGNca0F2S/5lrqXAx3phnARd1tYmNua724OPMvtFSe7hPhPBPODZolbThgx5im47LmgEGN9SD/vnhf7/yL7ZhFOhXF54Ot0561ozy/cYTZv2iGxcacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321999; c=relaxed/simple;
	bh=asjeJEmSFmPFeJWGhFBItWYtDo4mBTsBYEvqyGx58yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqepMD2CHbWH6Sh7/piEZ45bQLPJ0C9ArxYFsWF4+N6Azc8FK3TqUDJJawgzSBSuBIzvjkzadleKKj4Q3eZ2mh4on3gnAYd84Mjvu88Sxs+Sk90+6PPtByAnb30ZVKMJItqgDkkvz4Q6tSb2jMpSf9yrT+E1WA5kjY1wOsfcT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk3WXPXA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47174edb2bso1879633a12.3;
        Fri, 15 Aug 2025 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755321995; x=1755926795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV/FwDB61VKoH8QLTemjH8B6ozFRPeO6trFlTaP5glQ=;
        b=lk3WXPXAoPfrBMogMU8928yIOxxET9jOlai6q2rrMbN3/WA0YlHfIIFIYne58RgTzH
         pwYKxJGq44FQOJDqZCHKt3J6k+4iV8zoL5yObyTr2HF4u5rn4TCKGXGvFXboXRRIDRwA
         sgSvqsaq2mY3LN4KTDtmz4okZJbQirrFSkT0voJYwYu0tNfQJlIYwwvzRz+GWQyq2stb
         j3KKX0RPt5OLU0rOQVKqn466GZN0s9wJmz0RJSyoJxr2Y/HoYlN9NmtSC9P6QuZfxqfM
         ns+SUos2RUqySAjZ5thmGh9YbMpipedeCHP5bWRMC401oGn+N135GKqZZbC60Rb4fAq4
         KY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755321995; x=1755926795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV/FwDB61VKoH8QLTemjH8B6ozFRPeO6trFlTaP5glQ=;
        b=DM7QIdSOI3JY5dzyRolbuz1oYey7SxfqPVhUgKcPh3ijdNqcK9dLfDRuAmOW2JfgSc
         cdxuxbpdcWqpEP6i9gTxg+q65fNDg7aaP/HiT74+eKuI7yLxq086d4bvtrXG2tVSgFz+
         n9b0W1uX+YJoYXzBcCSMYnfN6T9CVvpQVcVH4WSbaztBccZ3mojxIxo+l7H95liWFxmd
         mprsKwqRNdM/G7nVKMVq573Lc8NCKFN7Gtw59s1yELAd3xmX7xHlJprCqgQfw+Op8hXE
         Ey6WUlweNsU8giPmPWJm99AemzpBOFKnaDBITtGEO1q3SUzRTsd4bQ46T4zqOJUZ2WKa
         IAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrplXyFhvTRU/Q8fMQk7Z5ziXH4xfINu1jxNfOnUJS/9FU3PuQitDkyyoAZsNAoVn3ADlIuDl3K7fcze2y@vger.kernel.org, AJvYcCW0IUwxEZZkl9YkXsSHsD8DxrqcS5BDjoKWI1VpW0zB6dr6uosYjad+Wxp50JDA06Utbj3/DNf7QffO@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTcz/sePmrwCh7VCmROAfv64Iaz7iXcqraeo8aZoI7VGSmQcD
	3+fRrKVVHcbYpFXSr6S/oVe2Pc9me0OfI1haIdLgYyzPGVrbZw/huqCHzPJDsVJXPBW82w==
X-Gm-Gg: ASbGncvISMUdHmPcfia1eXswxZuJ2Nj4Nc9OXWXHb5I9Sdv0mM2wR6h2MoVUMuWAJ+c
	yh+w+kd4aTtq/UStA53104NkxujxfE3nXNfOQXJ9mxTlo903fkjmy8ujA8L2OtOVTFRkC6MYehR
	kTHDxDYt7NQZps75zKUchGo+/qlwJCr3AIEIbO00XgX4qnBZ8y2JDl+JB08A4LAZELM45bAhBFn
	wCVhJca9lj3NTJXXnUfLfCGcZ9RkLHZC9c9tI4n4C6kS4WjP8yNzfcqxlanJ2CNkdexkzB9RE8V
	q6LRT+oIGvY1Ye5lzgcOfE8s+y3lHA/r/7qVINg5RpD2BXXjLEXRffGyt1rTIoOVtdo4AMJIL0G
	NF9vP+xUDT4m2jhinDn3QS9jf0MLDZg==
X-Google-Smtp-Source: AGHT+IFfCJUel77VQrGH8QEkZMQyMxkneI/O2fIdH25jORJVjyoHuYaQ+s0j0gcoV2Erus6Ka4rpfQ==
X-Received: by 2002:a17:903:2d0:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2446d6e4c8fmr73645175ad.7.1755321995352;
        Fri, 15 Aug 2025 22:26:35 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d016sm27225805ad.35.2025.08.15.22.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 22:26:34 -0700 (PDT)
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
Subject: [net-next v3 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Sat, 16 Aug 2025 13:23:20 +0800
Message-ID: <20250816052323.360788-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816052323.360788-1-mmyangfl@gmail.com>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
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
---
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_yt921x.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)
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
index 000000000000..5b842948dfe3
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Motorcomm YT921x Switch Extend CPU Port
+ *
+ * Copyright (c) 2025 David Yang <mmyangfl@gmail.com>
+ *
+ * +----+----+-------+-----+----+---------
+ * | DA | SA | TagET | Tag | ET | Payload ...
+ * +----+----+-------+-----+----+---------
+ *   6    6      2      6    2       N
+ *
+ * Tag Ethertype: CPU_TAG_TPID_TPIDf (default: 0x9988)
+ * Tag:
+ *   2: Service VLAN Tag
+ *   2: Rx Port
+ *     15b: Rx Port Valid
+ *     14b-11b: Rx Port
+ *     10b-0b: Unknown value 0x80
+ *   2: Tx Port(s)
+ *     15b: Tx Port(s) Valid
+ *     10b-0b: Tx Port(s) Mask
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "tag.h"
+
+#define YT921X_NAME	"yt921x"
+
+#define YT921X_TAG_LEN	8
+
+#define ETH_P_YT921X	0x9988
+
+#define YT921X_TAG_PORT_EN		BIT(15)
+#define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
+#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
+#define   YT921X_TAG_RX_CMD_UNK_NORMAL			0x80
+#define YT921X_TAG_TX_PORTS_M		GENMASK(10, 0)
+#define  YT921X_TAG_TX_PORTn(port)		BIT(port)
+
+static struct sk_buff *
+yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	unsigned int port = dp->index;
+	struct dsa_port *partner;
+	__be16 *tag;
+	u16 tx;
+
+	skb_push(skb, YT921X_TAG_LEN);
+	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
+
+	tag = dsa_etype_header_pos_tx(skb);
+
+	/* Might use yt921x_priv::tag_eth_p, but... */
+	tag[0] = htons(ETH_P_YT921X);
+	/* Service VLAN tag not used */
+	tag[1] = 0;
+	tag[2] = 0;
+	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	if (dp->hsr_dev)
+		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
+			tx |= YT921X_TAG_TX_PORTn(partner->index);
+	tag[3] = htons(tx);
+
+	/* Now tell the conduit network device about the desired output queue
+	 * as well
+	 */
+	skb_set_queue_mapping(skb, port);
+
+	return skb;
+}
+
+static struct sk_buff *
+yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	unsigned int port;
+	__be16 *tag;
+	u16 rx;
+
+	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
+		return NULL;
+
+	tag = (__be16 *)skb->data;
+
+	/* Locate which port this is coming from */
+	rx = ntohs(tag[1]);
+	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
+		netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
+		return NULL;
+	}
+
+	port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
+	skb->dev = dsa_conduit_find_user(netdev, 0, port);
+	if (unlikely(!skb->dev)) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Cannot locate rx port %u\n", port);
+		return NULL;
+	}
+
+	/* Remove YT921x tag and update checksum */
+	skb_pull_rcsum(skb, YT921X_TAG_LEN);
+
+	dsa_default_offload_fwd_mark(skb);
+
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
2.47.2


