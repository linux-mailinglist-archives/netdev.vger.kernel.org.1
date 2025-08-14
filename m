Return-Path: <netdev+bounces-213597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88CB25C48
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B1A3B8D18
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87D25C816;
	Thu, 14 Aug 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSfKhYzo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4D25B2E3;
	Thu, 14 Aug 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154468; cv=none; b=bUuetZVn6LOKKc12QfgAoK8qGj24lCuZtehfJAviytmf8PvGCTCgs+nwDqid2cdfnjLd0OlABCKmkD85Ek3CoA2C1p9XtNKtqBUWyTu3LbpInRcpPoqb7SYVjbn13zv2So3/E5b8ZsL2IYnDy8Qwb65qIYH5UA1scYn+vlqi1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154468; c=relaxed/simple;
	bh=asjeJEmSFmPFeJWGhFBItWYtDo4mBTsBYEvqyGx58yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCga8c420UtVqjJuANEnmj+y5Bha6D+pJFBFVAS9/JQpos4PJ+FgAF3gdJ2/3nrb5z6ItBGDtMFjFC0aVcoFS02vfWo7/vt0W9N5Vi4j8nlbtYIm2YawJdU1bHt1S5a8+PEJDKMen9L3tal+2YABc5fiGtxotDhsaNOgAtUc+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSfKhYzo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e614b84so665567b3a.0;
        Wed, 13 Aug 2025 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154465; x=1755759265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV/FwDB61VKoH8QLTemjH8B6ozFRPeO6trFlTaP5glQ=;
        b=aSfKhYzow4W7cNMsrSy6KA7HgDqpr9sM3YgTJeFKpe9U//ngq03dpx3pxs22vN0oLG
         LbMv8bDYBnREAWpsA0T2+v5lg48xfoXCTztSb2o/eyY0y1UmC0J8wi8BZb4bZ3m9fIk4
         onxHiMqEMIwc6cDEk3hgAW6T78+eANGfEC+sORj25pfCNcmt02izNHtuDorzhaDk4+AO
         A9lfy1ZgTWQDb03Ck5J7ymP5HCm83K5Fc8qsFVszwMAaz1BfiM5qxaHr4JCjo37TVvzq
         /kE/o+KqeG1DkOcOO4LJt+a4Gusy3g4hRbtB+vMzLoBFVWAVpyX4qnE/5lh5YsKjJ5s3
         ancg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154465; x=1755759265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV/FwDB61VKoH8QLTemjH8B6ozFRPeO6trFlTaP5glQ=;
        b=RTWER3CnXJoCylhc4I/wxkgrmQt34DhIhdLsLKNmOo9cgPEki8SyWdPEsXTzAEBMyR
         DQrO9zfiOd9IW3eh9/RGzTKSJ9K1b090RwW1Utc+1RTY0o9ipGLnSYh5VYlspawbAWHX
         wldVMbjf7GsrlNQrG5Vzd0RHDAipQw72/4s3SqbZ4h5KB256kyDM/D2ikgA1Dkdd+Qie
         N+wGR6/LA3f1sk3Cs/hnEsxn0Xj3mbUgs2n9H9XelC8swlb391TyFhUol/MZHgawUvoO
         QMbcZKWM/g1IIi4B5jmAKA9v8HJKmy0kboNLaVGT3PxvfJykIZ29/4c7ipElOMo2EfjG
         UTew==
X-Forwarded-Encrypted: i=1; AJvYcCVFO3hGk+sSZqB+e9LLiC4KrKj/ooA8zg3dmqwkdIwbVWx9b+5VDUofaSPyI0eO/CRS70+hST7+ACq/@vger.kernel.org, AJvYcCW5JYBqE/NJIidRdLLEM6YpJo2cLQTyldohVFvuZnZQsdIa+3sx4CZ3GmtqBdp8HN/kqIoztHQ1QY+aoayJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Hd5qIkvdoFMIfdwSw5GqwuXD2geqsqGRXRnCCx10o1+UTXOO
	nMp52LOXvC9hR3hJBk5IZhL3g6WL4UihFas3sc3ddRRqzK59R9zLM/U7Yv4oRHEuWNA=
X-Gm-Gg: ASbGncvWVYE1ohQq7ZsORHsBIQ1nafsFiZXHxBnZqpWmtb4igTnVvQ8JnntXKwd8IPz
	GATffVS4nMizWmtZ4xNrkp0CugmHbQeXbi5T+n7a+UYv5DilBIFYaI9p39xTnFFyMLtjU5aPjPQ
	JFbq3N3hNpcvD2XWe+6YestXJbgPlzONDQ5yFJbwqj4tcrvUPyez0N3+TlOdqj/9AVdK8Fr2Wt3
	RpEmfpSzA8B0YFeo+PeVdN4yGBMFlBj5DVRg5hiT/lMYfT5YRFeeOO47Jzgpw11IMZzkQiuOY6z
	l6oCHU9+4MJuxwWV5ceECOyt7j0zIagg3KC+yVigU3AK4rMN0O6AwojGuPH47C4/zH3+OfUDWsk
	Cgm0z5ek9W8WYGCotDxsY7ytzG30I8WOAmBKI6qxM
X-Google-Smtp-Source: AGHT+IFqrfp+ZAsY3whoS8N/Bd5/VTwPLiqAltWMYsAeI0iF7k303jGJna0o88jG83GopZxYeNdgMA==
X-Received: by 2002:a05:6a20:9148:b0:23f:f431:9f64 with SMTP id adf61e73a8af0-240bd1f4804mr2995028637.25.1755154465458;
        Wed, 13 Aug 2025 23:54:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm28425078a12.20.2025.08.13.23.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:54:21 -0700 (PDT)
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
Subject: [RFC net-next 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Thu, 14 Aug 2025 14:50:21 +0800
Message-ID: <20250814065032.3766988-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814065032.3766988-1-mmyangfl@gmail.com>
References: <20250814065032.3766988-1-mmyangfl@gmail.com>
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


