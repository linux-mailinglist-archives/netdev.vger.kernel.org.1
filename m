Return-Path: <netdev+bounces-214689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CDB2AE16
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971821B28040
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06B342C92;
	Mon, 18 Aug 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnCKFd2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF86340D94;
	Mon, 18 Aug 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534306; cv=none; b=GF0Ev05u+RYdJbFY5y1P3QtSxdJ6OVDRoXPaC4AEW1bCZLokPL805o2WSKOqqqYRdAiJFZBXb2853sTGLyW+G8ZbB2LGw2wIRYXVZ8QwWMC8oaJqWTPe1clWI7baZZNJ+eYi7OJt1F+s2fZkkbG376LTV3T9Xeg4NFXOrKGC2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534306; c=relaxed/simple;
	bh=tgqSG9M3YWa8uLanWBWhdkq2N16iBGB3kPBVamKRdYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G25GvClzptS8hs41Pkhon7lD8BmQi5RSiSfhXP4eW+iuJmotvAeX4SFqdo11zVHS/fZ3TMo9dlkPjvgaA8nRJrWSlO5cunWRa/38znYNz2+Fr0uVw2AUAVyUSsvrQhEmVYqVE1lQQAzGJO1+hFpHNVlk4mPj2PdAh0pdf+7ziCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnCKFd2l; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso4035498a91.1;
        Mon, 18 Aug 2025 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534304; x=1756139104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rryp1sgIne2NxF+zlvfjZAK6wLSVPZu97DY2EEihmPA=;
        b=QnCKFd2lqsECB8gzoAmKAeYT2jDgcOkNRmY8F6lAKq2MQsOGAa+ugDPBFu1yJCSGvb
         KQwe4+IrDAoyCcJueN80fTO5q+Y60nkBMlU7KFCz4cfzrGzQNZilSYbvDTNRCuFHoFCy
         fuaQIglUNIlyBIlYhvM67MyyYDipyPrrq5Soc6hmdDxk+g/AgxqixQPjSsicvOq+3Oy5
         k/qcLytIgNZJ+6LFhcotgtVLjZ9Ql9QDmSdUKwShfXU/sN0GX9TlMV0w6wNz+n+8WvHK
         vix+OJWgUDxcyuXOyXncvzx7GZ71noYxmoSFEN6QSWl8+D98YQ0M2v7OvDOT/6EzVL/x
         byHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534304; x=1756139104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rryp1sgIne2NxF+zlvfjZAK6wLSVPZu97DY2EEihmPA=;
        b=pTvFk/YpfzZhOW0p1PP6VrzDRxufCiJ3RLSYAC1A8oo/S0YgkeIBQyQV0H6ajBvC7x
         cJLHkrOazI8W8tfpDoi6HPosn7nRv4RS/bMaGIgaP/1ALq+ZhlKcIHhhRqT1f3txmGWm
         NGqiY8Bv2dhpA2KcijGV+1KwIrDdWgZJ7G3wEO3Zx4fbfuvCScEs+OQ8ZgayugKuwSD2
         okd4Po4HA7291s3pOySfNB5KlfLAVxj4JmSUHE8pCN0XZifdq0wA4KarT7iCOiZZuONh
         tPqmRGTfZo+qqjOCBWEFGO/rP6Z0Av592cjQgs+PWit6NHH42j/nAS30ihkUDwM7C2w4
         Q7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWE0RLxVUmlopkVepYamzEuyU+yI7tBJhiqfVDi8BncAt1+rbe79DLwLsNjaV2HTP7i43ODljDqEk/k@vger.kernel.org, AJvYcCXhkmXcS2+qwUsE9OtmdQ5SVt6bjio0JZ4y/6Ckbt1fU1wMsDBWdBU3VIMhVSFKta1pdO6oKbdTqa0RLLUb@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPeXwbrRWY/NrVnteh9HRVTn4HZN6IW6FOT6bltC9pcxYyg8G
	A6UjzpyuXnd4xiEF8gGXyAiu4ijH6OfFQtmc412t93qbcj/czO2lHV8IS8AkINNW
X-Gm-Gg: ASbGnctqtEI382ybEFC5ElRdJfKf/iNf8Z6fJ4/K0/VNnk5tHguwPAy2mru/zbbqt9u
	oWWnY64AYK7dWwW5Iyo06ygi4ki2z9j581J3ThYPQ7fqX6cvlK1swV/TBH8VYjjb5xicKM+rGa2
	DKzY7lnjwLVrfpC0CT+z5GmE0CizbQrOqi4e10B78vHC+36ni8JtkUhRNrjcezgtUTRlzbHkhnL
	KRHHaKxXvVcPmkpkNCRQnHCWgT2eB3NWc+2g3DKdbCLHYIq9IhpVrgPAoYkWA5J0ebgBa+qh9je
	Ch65vGhKSMYzmrc62+c0UL/DaXTnhAFR02L2Lk7bUskLKzz3+Jo/B32IMTt13XyBBZtyPO6xLg5
	Pk6Y8yrJ6UOk/cW76LgYhh5938G/kGw==
X-Google-Smtp-Source: AGHT+IEEOkj6Xi+bDXfU0UeFj+DOdbKnDJRKOghqUv9n9FF7m+ZYNfxCOk0lxHukm3/Z9pltCe053A==
X-Received: by 2002:a17:90b:180d:b0:31f:2bd7:a4d2 with SMTP id 98e67ed59e1d1-32342122b93mr19736097a91.35.1755534304194;
        Mon, 18 Aug 2025 09:25:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e400e8dsm382656a91.22.2025.08.18.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:25:03 -0700 (PDT)
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
Subject: [net-next v4 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Tue, 19 Aug 2025 00:24:41 +0800
Message-ID: <20250818162445.1317670-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818162445.1317670-1-mmyangfl@gmail.com>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
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
 net/dsa/Kconfig      |   6 ++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_yt921x.c | 128 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
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
index 000000000000..d10b9a00c0b6
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,128 @@
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
+ * Tag Ethertype: CPU_TAG_TPID_TPID (default: 0x9988)
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
+	/* We might use yt921x_priv::tag_eth_p, but
+	 * 1. CPU_TAG_TPID could be configured anyway;
+	 * 2. Are you using the right chip?
+	 */
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
+		netdev_err(netdev, "Cannot locate rx port %u\n", port);
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
2.50.1


