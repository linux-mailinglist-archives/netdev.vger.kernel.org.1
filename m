Return-Path: <netdev+bounces-212261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A9B1EDE8
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008941C27BBA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53341E7C05;
	Fri,  8 Aug 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BldNdrya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065B27F727;
	Fri,  8 Aug 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674897; cv=none; b=PTQrnH6E7OdoJsqSJyNS9LCAhvmNv9rx1j82LjgmoZGHlUaJhok4Sihu6DfMegUTmBmKZpEDiZIZSAAy41FpWwu9at5XwEW7QsfH8kws0yiQIYmlCaBIK82BtdfFiZZYX4Rehj+Mmf3x/4UIoMiq3o4lD+mVp5Z0abBsb9dKaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674897; c=relaxed/simple;
	bh=Keq+q4SHjEnprIHht1Gkm51TMEsbCSJKSbRviiHVooY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxPiQrr57+Pup2dv2J2FYpymAOUu14JjeWnqa9pRSrAATI6Q7YPVRFCa/ZjglhnvkSC9ExOmsEMLCH4Ydyzg/QeIs65jhe+nNVRmFX/Yf5Pkza7SwuiEYNkWaNR/GRKooN1XtQbXhJFrQNKMtE08I7JI98Ov+ncBsO50/wsQwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BldNdrya; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1936612a12.2;
        Fri, 08 Aug 2025 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754674895; x=1755279695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v04PbebFhHBNtpWqDhvlshr0WfLlj+fEY3t+CKSpRrk=;
        b=BldNdryaeCUP30uTi5MQ56cAjRC5H0zVWGSRkZhnfpCcMICLrLS9IdT4Cb4ZrCNCnv
         IYFqIWULqmYA89cz+1p6a42ZgU1Hee2k9T4SlRBSxdJAxQEesv/AMxu0QVxcuVY1Cg/o
         3q7/dAVT95MB/uVK3uRh0lFutj+3TCnyhdf5+N+r7TQow6leSx2Tc1Vj1EeTN2dv/Rig
         9Eoswq5TWuYZiIZA2pGlZWxDdI1wqdvJwUtddHZ/F/FF2UBRq1lVEUVh/75kQnCSHHiR
         Phy6gbktmDrM7f9hnb53rJE2q3t/cK5eLuAZrqOd7kHm3KaU/phIhy1prku3F3Qe7Y1C
         BmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754674895; x=1755279695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v04PbebFhHBNtpWqDhvlshr0WfLlj+fEY3t+CKSpRrk=;
        b=UpejoeZjjUJyoJ3659nzlyexnSe2RbfJmJvA/fRpmURsaoAMMBnuDoz4cEThWvTibY
         JFwJ+37DczmiAgdhPVLHZB0rsFyPTiZdFVYSyXbX4iXuVIo8dyhILv2XPpP1ZL0oMjQE
         iKIBk56qXro6VzQdzWeYjm4MU1hcw5VUhUie47yrmmdlty6leCW8q4JMw7LJ8XAQLDDN
         LW9MxjuXklDpuE1GSqntr9KzqmGRnk5E8qcOAvIB4i4Ie+Lq6zHOYKMOEj/Rvl+RPZlI
         k/dwDfJ1yx3EvpstfljfVGZZQksl8YKPJJm8nmQPY2Xt3DFS/mUbjxy4N7H0Utzkr36d
         OalA==
X-Forwarded-Encrypted: i=1; AJvYcCW3MXrHJoPJ/iW4g7N5UD7N2f6uNTYetKO2ZEOsD/ul0CSZ3MWJiTkB3rbfnm4n74X/lgqKmPR6WPxbnzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNy6hV50RwCzjuTyBBUvrQRt7xHY1bKctAzY1N6FbCCDyTQ6I
	w/opjIZVETOuNOfJh751i9e3DU0+1lNrtkUfcDjngRjSleZgngtMM9hgeU1HL1sND84=
X-Gm-Gg: ASbGncupf/Ce87QQDC6+FtL8JbjxufwCJJnEH/q1Bj+jTVfGMEnw3mK3Cl40lAP11nG
	R+4yG8h2fZyo4AeOr9DX4JmQb/Eep1cG+EAxQMBv2yVojKh1ytoN/ulQsdPUXRyTaq+SsbeaHQG
	pdQtiHMsiWQs5SJ8pF9iusHXhwZa6YQvL+xDuQ51PWdZsurTCVeocWi8xI8n6oR7aTH6jhu2JYZ
	K1TDWFL4P+qEI//TLMcbTp++2mxLsz8cZ1A78Fp4KU32qHd3YwAeyj/dqzP7ct6sEmte0/CMHsg
	wFVs6ZtAPM7Xi+gXgaWuRS3052qXVKHBizfFmpaQ13DhWexkVtO2c7saDOmgBT1O4P8SK6GL0Rh
	EXWr43Gy+Sg00gn69i/m0O/NA8dnwAY2P5nmirWib
X-Google-Smtp-Source: AGHT+IFdmHH+SWPYWVEVCNj9fwPDu+oalvm5Zr0wQ4+JuRnuvSri63Qm+BG8m1r2DMVavbgJ44mruw==
X-Received: by 2002:a17:902:ef4d:b0:242:cfc7:1fd6 with SMTP id d9443c01a7336-242cfc72077mr17907315ad.32.1754674894480;
        Fri, 08 Aug 2025 10:41:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975a66sm214174165ad.95.2025.08.08.10.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:41:34 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
Date: Sat,  9 Aug 2025 01:38:02 +0800
Message-ID: <20250808173808.273774-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808173808.273774-1-mmyangfl@gmail.com>
References: <20250808173808.273774-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Motorcomm YT921x tags, which includes a configurable
ethertype field (default to 0x9988).

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_yt921x.c | 116 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
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
index 000000000000..95354bdb0aff
--- /dev/null
+++ b/net/dsa/tag_yt921x.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Motorcomm YT921x Switch External CPU tagging
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
+ *     10b-0b: Unknown Value 0x80
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
+#define YT921X_TAG_PORT_ENf	BIT(15)
+#define YT921X_TAG_RX_PORTf	GENMASK(14, 11)
+#define YT921X_TAG_TX_PORTf	GENMASK(10, 0)
+#define  YT921X_TAG_TX_PORTnv(port)	BIT(port)
+
+static struct sk_buff *
+yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	__be16 *tag;
+
+	skb_push(skb, YT921X_TAG_LEN);
+	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
+
+	tag = (__be16 *)(skb->data + 2 * ETH_ALEN);
+
+	/* Might use yt921x_priv::tag_eth_p, but... */
+	tag[0] = htons(ETH_P_YT921X);
+	/* Service VLAN not used here, set to 1 anyway */
+	tag[1] = htons(1);
+	tag[2] = 0;
+	tag[3] = htons(YT921X_TAG_PORT_ENf | YT921X_TAG_TX_PORTnv(dp->index));
+
+	/* Now tell the conduit network device about the desired output queue
+	 * as well
+	 */
+	skb_set_queue_mapping(skb, dp->index);
+
+	return skb;
+}
+
+static struct sk_buff *
+yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	__be16 *tag;
+	u16 rx;
+	int rx_port;
+
+	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
+		return NULL;
+
+	tag = (__be16 *)skb->data;
+
+	/* Locate which port this is coming from */
+	rx = ntohs(tag[1]);
+	if (unlikely((rx & YT921X_TAG_PORT_ENf) == 0)) {
+		netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
+		return NULL;
+	}
+
+	rx_port = FIELD_GET(YT921X_TAG_RX_PORTf, rx);
+	skb->dev = dsa_conduit_find_user(netdev, 0, rx_port);
+	if (unlikely(!skb->dev)) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Couldn't decode source port\n");
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


