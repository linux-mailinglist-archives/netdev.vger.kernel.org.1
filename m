Return-Path: <netdev+bounces-215168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE81B2D542
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FD51BC80F8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490462D9493;
	Wed, 20 Aug 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmlmiw6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE692D9484;
	Wed, 20 Aug 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676521; cv=none; b=BBN2i5M18uZs/Xf1GC3D3ftmnvptXHN0OmAn9StgzqT71ycQ+jE6PJSnEtBnB49iLZskYywWn3sBy9CAL1Znaam3b2PoPn/YXrjavxH9ZF5tY15tLDTkY6cxrRAXe5ylM5KoIj5UAg7cewhSW61XLloJr2ebET46vCSe7SIIxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676521; c=relaxed/simple;
	bh=0TegYvCFcpLYoSS8R1/MTa+rWIj0fxtCU+JCQ5PJXv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5W4Js7DWpEa9S1yR1Znjp6KS9vJU3K4amfosBEGHPWUi4Fs6u5x3BSdtu+lGIAp2dMIbfWjXKJD2aWDqHALui3QvrMOw37PG0fRsaieKlRA5ZyxVfsfChLfwmY4vtXb94+fkP3Kra0PMnmTaoPARsAMX2mfSjz9Y7rEi2Mbsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmlmiw6Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so6195845b3a.1;
        Wed, 20 Aug 2025 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755676519; x=1756281319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlr08gO6VfmGTyNaQzieyWtwOv6R0hG+NjDB+oqJRRQ=;
        b=Lmlmiw6YM/Lavm50phpQupXiCA+OfxC2cjpcqbhNL0JolAIs1acNwyAGdY0QQ1Wgyi
         hI21pRGw7p0PWq3BbNX3WjRN7tYPI8PwPwvawy92C9w7nfEJfpUDYmg3u8cd6pxMk1b3
         oXLg/0S2saRiZySYL+EIHNZQlrpSCU/OjjxuFOCpFKO0klenLJZIV/FeVYlmYvQBwvMc
         aBnXP/wxv+nH77xuP+Vli6KOm6PydVxTpUs+qbf0zfT2ptgO+iYraOnPNpRbUJdJwUgh
         oEQpDrhC8PWLs8oWQKdM9pMo0YePvSMqyTve/kidTlQ0eGuuiaHUvp4z+bqrlp2xf6bj
         6TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755676519; x=1756281319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlr08gO6VfmGTyNaQzieyWtwOv6R0hG+NjDB+oqJRRQ=;
        b=r3CbKSLZUL/2pcE5uHbzMTC+HT/qah+Y+SAfiLO9uvkhtELhJEC0lc44CdSnUb0DjN
         xS5VJX2+XGMTg+SJWf24znMqYmKGyJOdmsYNbxZ8jyt0GrK6L9fsDcVgjMJltPBgxhCv
         JaO3DS+H0SMXaz1ocIAohG0jsuL/mKsNbTuLOrzBxPEyz/X6IeQwsAa9irV5QudCpKS7
         V7g9rTpmnscqOHODzFJfcr/7J3uo/Wuv5u84Zl0oHD8g1B534EH3Bt4ogt5LBsNzjT4u
         dqCZJ4Tr4tX1Hz/if/rxE3A1PSL1hKPSTX14K6BeSQezz4GHCuY5TCyqWY+1MQ30WcTw
         RBXg==
X-Forwarded-Encrypted: i=1; AJvYcCW46YEzG13GSHo5x9imV4g/BD/58xNSqutkar45kC08k1NM26G3JRPtveqir6Yqk0tw1u+tzLLAzUxfyYCf@vger.kernel.org, AJvYcCWgFjG/rn7TEZLvRllC3elZ8s6FRpEe+AhpJCuReFlUOIQV6ICIxo/rOuCpj3eiZMzayTOksLuKEFzs@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMeboeQCxQEYNtzZzjLGxeuyb/3mIBU8Gg6f1wOeq2PCL6h0K
	77w681P6J9inSKMdOTs9Mjhw5dhqRs5SUmrSuEi7nOwBRVAHtLjuLyHBUtc415eA
X-Gm-Gg: ASbGncssS/dTP7lN1BE97PgsKf+PypPuqE97rGS1OqcYtjeJn5kPrdRR0t4+Za5toeu
	qhnpXAw9ZIE6C0ousFiEe6dLVu2KAZksa2cmTkadXc/eUFg2niF3AAOpM09XebvKLRpnstu9edz
	buCTS7iHXHyEtWXrSDVUTw7g1lK8tqwDqx/KYLmn7hzsEf2AaamaT/ZBbLsp6SaL4DxKjaGyLdQ
	tw1pcdajZp9D9/KO6r0rQxTPixJKBbbqL5CcN1rat6JFA3Tm11QZyOqJ0QPYYSV/qOH3DeVTqWs
	s2hlWvyY6Oakk4hQK7H19TDMY5y2xfiTwC+jLC0cXi5viyLX90kapbZsahKvqSARMnuNJitPxIO
	JxhWc+yDhQtFDXcmZohAGBFrNDLTRzA==
X-Google-Smtp-Source: AGHT+IEysCfCpnx3VbP0bi/nqDEybqD1GQhTb5QcsAgkxwHJXS9jIMmYrPlM/TTyR7hWFeN0r5tdUQ==
X-Received: by 2002:a05:6a00:90a1:b0:76e:987b:2db with SMTP id d2e1a72fcca58-76e987b03afmr754163b3a.19.1755676518670;
        Wed, 20 Aug 2025 00:55:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d137344sm4605225b3a.42.2025.08.20.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 00:55:18 -0700 (PDT)
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
Subject: [net-next v5 2/3] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Wed, 20 Aug 2025 15:54:15 +0800
Message-ID: <20250820075420.1601068-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820075420.1601068-1-mmyangfl@gmail.com>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
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
index 000000000000..94a4c1cb61ff
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


