Return-Path: <netdev+bounces-216257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAAFB32CC9
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 02:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551157A5CCE
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE1B1A23AF;
	Sun, 24 Aug 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5lVCiLX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655F1A08AF;
	Sun, 24 Aug 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755996821; cv=none; b=r+OQKXx1nIHNLmsypmeZ4XnSzOHC9USNj7KCt8QvsJTsUp4nvDhqta671i3AigEQnQTJa1R5AEiPwZkWdCv+ZS9fscipNb/YIURVqqaoOcccZ21e1CSToluarFzFDTqWmHJ/o62n7qQRSv2Neyrbq/FsEUxcPWOIetK6Ex2ab88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755996821; c=relaxed/simple;
	bh=NV81H0XGpEuwCSxPhSX5NNTeNA4JR6Gm9zTl7f97DT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HETOnHyRGOoy/+NajwlVNDQmj1brrZLCcfhAVpQ297q1ctCeYdq/W7updjree5nWVDZ9UoAf5TMhDVr9cLCJzFqqQd+Egftarb6JvtwF1nAfz0g4NEzTNgWzDWTH5bynVZKflnDrhIFKLvH4ErDtn96CYMg3EWDK2BSnfXd17wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5lVCiLX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326e5f058so2276374a91.3;
        Sat, 23 Aug 2025 17:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755996819; x=1756601619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RC17vdQL69TDsUOQOqVvaH1hV2pA+P9t6R5y/TTHRE=;
        b=j5lVCiLXarwopq64itI9zfFsX37rZIPPd5lE+PF57qJ+mFA3iqJ42mU5eSM5gJ8cHa
         7LGautDNzuvdgyXSVoANyBBk91/yzU/j1yPZHQivLxao4cf/fxGg/Ez2ik71pDKUzU8u
         Ug3nIen8IyJscvL7MGww6OxmthQLSqchlLxvLt1eT4vARhvxY5VAiR31ecSsBWwA2adV
         uDpeHCk4AbcVApNW6TSPeYjoVVL0A811hnG1MaRgO2BB9SdG1ncMwmSYXetCgrVT8Tmn
         P5/Kh+peLXlMtO0IGuIopPow7QfW1papxWg0X6cZK+c6aZ8Li+CQW1fMz1GIHek2Ch73
         ZsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755996819; x=1756601619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RC17vdQL69TDsUOQOqVvaH1hV2pA+P9t6R5y/TTHRE=;
        b=fM7KgyNqw4saVfENfndY3dVLsRlG0rHCEuJIVHD56PMUaI6py1N6ERQ/e4ELu3nFXn
         a4kUu8N1pa4UnbLu695JCPxJ1G/NG/VobzzxzxPn98R+XamV4e0a8IdR40S5Dy2WVgfN
         BR4D5D6mdgOaLaO8kd13xjqVETF+4nSROLt/NpP6vWovCa/Gx7juFCIfRTav0G/IgnEj
         7Jhk/lZ7mLv+4/JQZH9V8ZW6FPtcnGtY5qF0xbWmpXM1obp/9lbqGIOCvQHHOUFAb/b7
         Z1s0Kf6FWbkPXwU+1/hChOCNF7LDAcyi+zFhw0d1VJ8U2t3gZAH3Na2undDkQ9ZeAkAx
         veQw==
X-Forwarded-Encrypted: i=1; AJvYcCVirp75xSsm9ewXuXk2qtdNgBlLDtj6/T4xfVpuqSZLOls+Bnv8l9t5drf/eenVX0QEJnXixqimdGal@vger.kernel.org, AJvYcCWarCMlq8pMEAboOcI/TT6ZCnRXbFtAUarLkJnfeOl4kAsrO40Yhd+0+NYOjko+2MMlSuxYET0452VtnZoV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44p+/BYOcHldGPu7qntj2oHXpw+fNSNY2SsREPWv5jQgZHpct
	2K4oiJgjaWTiTDGzEXQigDFa5dU2nqWuPpDrfSkAkhiCR8hsjiLsUAqhkGSny2Vr
X-Gm-Gg: ASbGncsw94bDVdGSz05iR9nO1gOP14Xwj7cn7UJxKmKNgboAyGANr/uLoFTmgCjJFml
	3L1SymthRP5/M3cWawWkzWPCVal67jYPKYwHtPn6XF2BMwj1ac9rwxi8IhDcTcBLOLK9hnD9ZA0
	RnCfwlzaDg66Mj4Sc/gpPuYHM/bte4/ce6Q4CcYSwP4OzmbQfMMl24pvG8S3l8o/6aoiiy1lq9/
	Ki2vPAoo/XBuHNM28UQXedXlcNMtexFT04EV3zvfDVw+o4DZFIHBOmdHiBaFHo7tcJ6eKimAKtR
	8+o5XWiFoMuaT8j7P0j3wggbz1upz8f1edglh3aR1QzrWmwZdUVe/Ebxspug1wwO3LMnrMHtwS9
	YAuZR0BvmEAETYjNF+0oFZ7d4gaLoUg==
X-Google-Smtp-Source: AGHT+IFhNkYizv52GOpjhD/eQDe9uZ9K/ax1AZpyUdH1FIKopLIiGyzNsT0Y/f3SHvDrgB57KijsMQ==
X-Received: by 2002:a17:90b:1b4c:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-32515d111e9mr9457862a91.0.1755996818922;
        Sat, 23 Aug 2025 17:53:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.247.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c38asm3172485a91.17.2025.08.23.17.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 17:53:38 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Sun, 24 Aug 2025 08:51:10 +0800
Message-ID: <20250824005116.2434998-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824005116.2434998-1-mmyangfl@gmail.com>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
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
index 000000000000..ab7f97367e76
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
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


