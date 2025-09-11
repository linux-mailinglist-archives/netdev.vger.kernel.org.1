Return-Path: <netdev+bounces-222142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F784B53402
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41279B60886
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70A32F75F;
	Thu, 11 Sep 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJkgRnE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D532CF8D;
	Thu, 11 Sep 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598021; cv=none; b=ZI3sNNihzYNTIq1h6DqZ/HtSZIRSxyrNdOpVPE3aQ2OA9DcNJX+Vh2n9ImL+ZfNLiJ3b8LZuXAij1H2gV2K0VGpz2DwUaxgJvSLtChdKVIeEm0Vyl7e6WE/wnPFqV9GNhIhlbSRpqCH0oRVi9IX9bdEar7aBpzJZdzlh1waxjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598021; c=relaxed/simple;
	bh=34II6QSuSwoQzRT0L+HwJfzI+Z0J5m5wN2WhQB82UBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unM4Un7DvweM91NP1evlLpEitwyF2FROyPbp/yqK+eFqTNiQYwE3xcct/Vsr1CfG+ZK2wbwGbSgMJfczaKW9iUVuZaHrlYeRBn0v9/fX4hiLsDf7VjAAmTreHyK3BwZil20J4bZBo2/yhqUTfzUQLiitBjuuwg1aF0WZAACDOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJkgRnE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso7503825e9.1;
        Thu, 11 Sep 2025 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598018; x=1758202818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF+wFLzqJgcC4lMJZbTMW9CSMXwTLFbaGRq/VOX71hY=;
        b=VFJkgRnEugd1PVohFHVRWheO46+6hj4htznBmjA9z0a3oUFFprswCqtQMaFWVa/GBM
         7+Vr41xjnNR1ExT/94jupYqdkDhT/SFdfjfCuaxy5W2qpSb0eMAkS/EpxN/J2Ly1jlvq
         2flQR0tSA7cNVU2Ee1g5fwfLDHvUSeEghMV413me4P/MXgVL0PBIC/fucZ0W6jtbUCrS
         7X3Z9aKguNP4EZydMoybme49376qN5dNQ/ZbaEtWv4qILGms/BQ9EKvKuVsXizyh6tYX
         s8izh8VRkwkZK4K+cl/QNvx1gg5+DU133ZBMHOpU1yqZwBBFQKvZX+kbXg2xLSojsoIK
         fRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598018; x=1758202818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF+wFLzqJgcC4lMJZbTMW9CSMXwTLFbaGRq/VOX71hY=;
        b=fXJ74Ci2eOoXzt/TAtpzcg5cT5neMj8wSD0ga5iPiNszh3rJbW5UXdRCvWf3pVDqLn
         gHZsnQYldJyc7Serxu/a4cRr2cvCQYEACnfRz8rCcu2CVdZepbsmPAuo+53ILleCKBcA
         sF+YzJZo3QNEi1oOglMt2bLf4lNPSIp4yLdCIbeU6vIdDYUo6szLg6S7T5xM02ZeHZcY
         /QYut1YoCFCafKaalfpcMVRDTWyQHiLvGDGRSRM0Eaz+RHCZRDtU2xEI2ofOma+jz2lG
         xnvaxJqUn5KWQPex0w5qXevF4OEhd9HjzD4YhJNeSAJavalxUU8ZtQ6EiKBf4E/wNBV3
         UlUw==
X-Forwarded-Encrypted: i=1; AJvYcCU2MHAtMnSBAXMyKqGiNW3KyLCDl2Q1cbfWsLej8h8i62/TU0zdsX/vyiude0Y9/MwORYk8oc83@vger.kernel.org, AJvYcCVlzVcV39rmunf/3CHGkeq1xxOgv4jLXTzWRxoxWdwwIFNmuWxaR4BKrsbtvdawFs7mfwS6acjn1jhXhltQ@vger.kernel.org, AJvYcCXb2dJ3+fmqeTgyaJYEJzZdfDbwBJdFZNES+cwIOYHc1T21b8zNgyen26ARbp3FJySmOiofzOkfVXK/@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXWPGLN3ziRfpJxWXAlD+084M2HZD1EUvcgN8C+j9gwN4qxof
	QgI3M6fzeePUWD0cYMmTe16w81W+EAh97nC2UpJTu88ui/hKhDIAMknK
X-Gm-Gg: ASbGnct+OA16Nj3TnHvqTHg5A2KVG7TWSPj8p+TIt1eW9bTg5baxjFFmDq56bU8UVBl
	318lpJdTtKtliXcmSp2lObrF1zzlsbWsKizfLsvUMNk4EQ98ZKKEt+TDTFPZ3GoH/MUbUPkXilG
	YPnHNMM8y01O5gGaSxPyl6JZ5X+pmNekarrmpnE0euPNpXV4KU8aWyo2vKymK2wik+drL1VwHL5
	3cIix/aez58dg8UE07laeNiOu4EyKX2grMiAq4U9igXBMp/pJ1fhUMfIq754IWMVEE1kXCqPViu
	ghmjBkd2K50hJ2c4NBZ58g5T2TO8pbfWm8v87V9ctijDq4t40biKVfahw65FsY+Al3l+dgSf5cG
	83NtHuXAnDYHCPiSJpOcv9LppiYGlkMvLFSX/b0giczw7dCnNlwzT5vsA+dDWsfb/Drq9jRE=
X-Google-Smtp-Source: AGHT+IGuwzWcZDwxxcvVkWfDhLFC1rWc/wqy7pHhoHCwjrwLB5tlCcfVs6X3rr2PFxAFnnKGiEukzA==
X-Received: by 2002:a05:600c:1d16:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45dddec9927mr243734635e9.16.1757598015942;
        Thu, 11 Sep 2025 06:40:15 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:40:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v17 4/8] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Thu, 11 Sep 2025 15:39:19 +0200
Message-ID: <20250911133929.30874-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variant of the MTK TAG for Airoha Switch and comments about difference
between Airoha AN8855 and Mediatek tag bitmap.

Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
from tag. Although these bits are not used (and even not defined for
Leaky VLAN), it's worth to add comments for these difference to prevent
any kind of regression in the future if ever these bits will be used.

Rework the makefile, config and tag driver to better report to
external tool (like libpcap) the usage of this variant with a dedicated
"Airoha" name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/Kconfig   | 11 +++++++++++
 net/dsa/Makefile  |  2 +-
 net/dsa/tag_mtk.c | 36 +++++++++++++++++++++++++++++++++---
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d73ea0880066..bf03493e64ab 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -55,6 +55,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
+#define DSA_TAG_PROTO_AIROHA_VALUE		30
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -69,6 +70,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
 	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
 	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
+	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
 	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
 	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
 	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 869cbe57162f..7d63ecda25c8 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,12 +98,23 @@ config NET_DSA_TAG_EDSA
 	  Say Y or M if you want to enable support for tagging frames for the
 	  Marvell switches which use EtherType DSA headers.
 
+config NET_DSA_TAG_MTK_COMMON
+	tristate
+
 config NET_DSA_TAG_MTK
 	tristate "Tag driver for Mediatek switches"
+	select NET_DSA_TAG_MTK_COMMON
 	help
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
 
+config NET_DSA_TAG_AIROHA
+	tristate "Tag driver for Airoha switches"
+	select NET_DSA_TAG_MTK_COMMON
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  Airoha switches.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 555c07cfeb71..7aba189a715c 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
-obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
+obj-$(CONFIG_NET_DSA_TAG_MTK_COMMON) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index b670e3c53e91..32befcbdf4be 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 
 #define MTK_NAME		"mtk"
+#define AIROHA_NAME		"airoha"
 
 #define MTK_HDR_LEN		4
 #define MTK_HDR_XMIT_UNTAGGED		0
@@ -18,6 +19,9 @@
 #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
 #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
 #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
+/* AN8855 doesn't support SA_DIS and Leaky VLAN
+ * control in tag as these bits doesn't exist.
+ */
 #define MTK_HDR_XMIT_SA_DIS		BIT(6)
 
 static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
@@ -94,6 +98,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	return skb;
 }
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
 static const struct dsa_device_ops mtk_netdev_ops = {
 	.name		= MTK_NAME,
 	.proto		= DSA_TAG_PROTO_MTK,
@@ -102,8 +107,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
 	.needed_headroom = MTK_HDR_LEN,
 };
 
-MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
-MODULE_LICENSE("GPL");
+DSA_TAG_DRIVER(mtk_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
+#endif
 
-module_dsa_tag_driver(mtk_netdev_ops);
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+static const struct dsa_device_ops airoha_netdev_ops = {
+	.name		= AIROHA_NAME,
+	.proto		= DSA_TAG_PROTO_AIROHA,
+	.xmit		= mtk_tag_xmit,
+	.rcv		= mtk_tag_rcv,
+	.needed_headroom = MTK_HDR_LEN,
+};
+
+DSA_TAG_DRIVER(airoha_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
+#endif
+
+static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
+	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
+#endif
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
+#endif
+};
+
+module_dsa_tag_drivers(dsa_tag_driver_array);
+
+MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
+MODULE_LICENSE("GPL");
-- 
2.51.0


